Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28F3067DE
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 00:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhA0X1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 18:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235541AbhA0XYx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Jan 2021 18:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611789806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUU+ROeZFNZ36N8KcgUEXmIJUynEXm9qXEZ9l8dah6Y=;
        b=Myr7qUFJX6Hvx5V7mTb5VKYmxDDYdrBAYuryADObM6TPdlKxp5nFTrAHVqqenxAK8czQ7J
        7KVBqoBAqcQHXqslGakfoIAdZGLm9jx+tnZ0UwcFk4k0b5yStnB2DiLEctYocdihjwhSBZ
        LrWMFlZHEjIXq0o0SElkK3hxfkG0fhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-fnZ2riGoNCaO9mMS5b5A7w-1; Wed, 27 Jan 2021 18:23:24 -0500
X-MC-Unique: fnZ2riGoNCaO9mMS5b5A7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F8B8017DF;
        Wed, 27 Jan 2021 23:23:22 +0000 (UTC)
Received: from krava (ovpn-112-48.ams2.redhat.com [10.36.112.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 00E235C1BB;
        Wed, 27 Jan 2021 23:23:20 +0000 (UTC)
Date:   Thu, 28 Jan 2021 00:23:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org,
        ast@kernel.org, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 2/4] btf_encoder: Add .BTF section using libelf
Message-ID: <20210127232320.GA295637@krava>
References: <20210125130625.2030186-1-gprocida@google.com>
 <20210125130625.2030186-3-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125130625.2030186-3-gprocida@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 01:06:23PM +0000, Giuliano Procida wrote:
> pahole -J uses libelf directly when updating a .BTF section. However,
> it uses llvm-objcopy to add .BTF sections. This commit switches to
> using libelf for both cases.
> 
> This eliminates pahole's dependency on llvm-objcopy. One unfortunate
> side-effect is that vmlinux actually increases in size. It seems that
> llvm-objcopy modifies the .strtab section, discarding many strings. I
> speculate that is it discarding strings not referenced from .symtab
> and updating the references therein.
> 
> In this initial version layout is left completely up to libelf which
> may be OK for non-loadable object files, but is probably no good for
> things like vmlinux where all the offsets may change. This is
> addressed in a follow-up commit.
> 
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 145 ++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 100 insertions(+), 45 deletions(-)
> 
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..fb8e043 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  	uint32_t raw_btf_size;
>  	int fd, err = -1;
>  	size_t strndx;
> +	void *str_table = NULL;
>  
>  	fd = open(filename, O_RDWR);
>  	if (fd < 0) {
> @@ -741,74 +742,128 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  	}
>  
>  	/*
> -	 * First we look if there was already a .BTF section to overwrite.
> +	 * First we check if there is already a .BTF section present.
>  	 */
> -
>  	elf_getshdrstrndx(elf, &strndx);
> +	Elf_Scn *btf_scn = 0;

NULL


SNIP

> -		const char *llvm_objcopy;
> -		char tmp_fn[PATH_MAX];
> -		char cmd[PATH_MAX * 2];
> -
> -		llvm_objcopy = getenv("LLVM_OBJCOPY");
> -		if (!llvm_objcopy)
> -			llvm_objcopy = "llvm-objcopy";
> -
> -		/* Use objcopy to add a .BTF section */
> -		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> -		close(fd);
> -		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> -		if (fd == -1) {
> -			fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> -				tmp_fn);
> +		/* Add ".BTF" to the section name string table */
> +		Elf_Data *str_data = elf_getdata(str_scn, NULL);
> +		if (!str_data) {
> +			fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
> +				__func__, elf_errmsg(elf_errno()));
>  			goto out;
>  		}
> -
> -		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> -			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> -				__func__, raw_btf_size, tmp_fn, errno);
> -			goto unlink;
> +		dot_btf_offset = str_data->d_size;
> +		size_t new_str_size = dot_btf_offset + 5;
> +		str_table = malloc(new_str_size);
> +		if (!str_table) {
> +			fprintf(stderr, "%s: malloc(%zu) failed: %s\n", __func__,
> +				new_str_size, elf_errmsg(elf_errno()));
> +			goto out;
>  		}
> +		memcpy(str_table, str_data->d_buf, dot_btf_offset);
> +		memcpy(str_table + dot_btf_offset, ".BTF", 5);

hum, I wonder this will always copy the final zero byte

> +		str_data->d_buf = str_table;
> +		str_data->d_size = new_str_size;
> +		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
> +
> +		/* Create a new section */
> +		btf_scn = elf_newscn(elf);
> +		if (!btf_scn) {
> +			fprintf(stderr, "%s: elf_newscn failed: %s\n",
> +			__func__, elf_errmsg(elf_errno()));
> +			goto out;
> +		}
> +		btf_data = elf_newdata(btf_scn);
> +		if (!btf_data) {
> +			fprintf(stderr, "%s: elf_newdata failed: %s\n",
> +			__func__, elf_errmsg(elf_errno()));
> +			goto out;
> +		}
> +	}
>  
> -		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> -			 llvm_objcopy, tmp_fn, filename);
> -		if (system(cmd)) {
> -			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> -				__func__, filename, errno);
> -			goto unlink;
> +	/* (Re)populate the BTF section data */
> +	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> +	btf_data->d_buf = (void *)raw_btf_data;

doesn't this potentially leak btf_data->d_buf?

> +	btf_data->d_size = raw_btf_size;
> +	btf_data->d_type = ELF_T_BYTE;
> +	btf_data->d_version = EV_CURRENT;
> +	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> +
> +	/* Update .BTF section in the SHT */
> +	GElf_Shdr btf_shdr_mem;
> +	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> +	if (!btf_shdr) {
> +		fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
> +			__func__, elf_errmsg(elf_errno()));
> +		goto out;
> +	}
> +	btf_shdr->sh_entsize = 0;
> +	btf_shdr->sh_flags = 0;
> +	if (dot_btf_offset)
> +		btf_shdr->sh_name = dot_btf_offset;
> +	btf_shdr->sh_type = SHT_PROGBITS;
> +	if (!gelf_update_shdr(btf_scn, btf_shdr)) {
> +		fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
> +			__func__, elf_errmsg(elf_errno()));
> +		goto out;
> +	}
> +
> +	if (elf_update(elf, ELF_C_NULL) < 0) {
> +		fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
> +			__func__, elf_errmsg(elf_errno()));
> +		goto out;
> +	}
> +
> +	size_t phnum = 0;
> +	if (!elf_getphdrnum(elf, &phnum)) {
> +		for (size_t ix = 0; ix < phnum; ++ix) {
> +			GElf_Phdr phdr;
> +			GElf_Phdr *elf_phdr = gelf_getphdr(elf, ix, &phdr);
> +			size_t filesz = gelf_fsize(elf, ELF_T_PHDR, 1, EV_CURRENT);
> +			fprintf(stderr, "type: %d %d\n", elf_phdr->p_type, PT_PHDR);
> +			fprintf(stderr, "offset: %lu %lu\n", elf_phdr->p_offset, ehdr->e_phoff);
> +			fprintf(stderr, "filesize: %lu %lu\n", elf_phdr->p_filesz, filesz);

looks like s forgotten debug or you're missing
btf_elf__verbose check for fprintf calls above

jirka

