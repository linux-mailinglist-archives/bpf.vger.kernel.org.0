Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA18371365
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhECKJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 06:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233285AbhECKJI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 May 2021 06:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620036495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QM7LX30zixFvAJA+LWpBmSBCqZL3DHOeqR3gSdt7mUE=;
        b=KjBICge1Q4PKPYabVs8DDowO2Tb27/chjBhcl+I9dEBD+ZRpTRupAIGRP0grkwmJ4aUPO4
        aDQ0gqzvEzoC4GzS6x4qudOhjUtbVdPyv8S3wgnP6yl5a0Eonvi2mYGYrINcRaObP14EjT
        gtg4m5TvFzJbbZJmm1mZOG/5qQYYYXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-MOHmxVoAPHOVkocEE9n3hg-1; Mon, 03 May 2021 06:08:13 -0400
X-MC-Unique: MOHmxVoAPHOVkocEE9n3hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66FCD107ACC7;
        Mon,  3 May 2021 10:08:11 +0000 (UTC)
Received: from krava (unknown [10.40.195.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48D291001B2C;
        Mon,  3 May 2021 10:08:03 +0000 (UTC)
Date:   Mon, 3 May 2021 12:08:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: linux-next failing build due to missing cubictcp_state symbol
Message-ID: <YI/LgjLxo9VCN/d+@krava>
References: <20210426121401.GO15381@kitsune.suse.cz>
 <49f84147-bf32-dc59-48e0-f89241cf6264@fb.com>
 <YIbkR6z6mxdNSzGO@krava>
 <YIcRlHQWWKbOlcXr@krava>
 <20210427121237.GK6564@kitsune.suse.cz>
 <20210430174723.GP15381@kitsune.suse.cz>
 <3d148516-0472-8f0a-085b-94d68c5cc0d5@suse.com>
 <6c14f3c8-7474-9f3f-b4a6-2966cb19e1ed@kernel.org>
 <4e051459-8532-7b61-c815-f3435767f8a0@kernel.org>
 <cbaf50c3-c85d-9239-0b37-c88e8cbed8c8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbaf50c3-c85d-9239-0b37-c88e8cbed8c8@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 03, 2021 at 10:59:44AM +0200, Jiri Slaby wrote:
> CCing pahole people.
> 
> On 03. 05. 21, 9:59, Jiri Slaby wrote:
> > On 03. 05. 21, 8:11, Jiri Slaby wrote:
> > > > > > > > looks like vfs_truncate did not get into BTF data,
> > > > > > > > I'll try to reproduce
> > > > 
> > > > _None_ of the functions are generated by pahole -J from
> > > > debuginfo on ppc64. debuginfo appears to be correct. Neither
> > > > pahole -J fs/open.o works correctly. collect_functions in
> > > > dwarves seems to be defunct on ppc64... "functions" array is
> > > > bogus (so find_function -- the bsearch -- fails).
> > > 
> > > It's not that bogus. I forgot an asterisk:
> > > > #0  find_function (btfe=0x100269f80, name=0x10024631c
> > > > "stream_open") at
> > > > /usr/src/debug/dwarves-1.21-1.1.ppc64/btf_encoder.c:350
> > > > (gdb) p (*functions)@84
> > > > $5 = {{name = 0x7ffff68e0922 ".__se_compat_sys_ftruncate", addr
> > > > = 75232, size = 72, sh_addr = 65536, generated = false}, {
> > > >     name = 0x7ffff68e019e ".__se_compat_sys_open", addr = 80592,
> > > > size = 216, sh_addr = 65536, generated = false}, {
> > > >     name = 0x7ffff68e0076 ".__se_compat_sys_openat", addr =
> > > > 80816, size = 232, sh_addr = 65536, generated = false}, {
> > > >     name = 0x7ffff68e0908 ".__se_compat_sys_truncate", addr =
> > > > 74304, size = 100, sh_addr = 65536, generated = false}, {
> > > ...
> > > >     name = 0x7ffff68e0808 ".stream_open", addr = 65824, size =
> > > > 72, sh_addr = 65536, generated = false}, {
> > > ...
> > > >     name = 0x7ffff68e0751 ".vfs_truncate", addr = 73392, size =
> > > > 544, sh_addr = 65536, generated = false}}
> > > 
> > > The dot makes the difference, of course. The question is why is it
> > > there? I keep looking into it. Only if someone has an immediate
> > > idea...
> > 
> > Well, .vfs_truncate is in .text (and contains an ._mcount call). And
> > vfs_truncate is in .opd (w/o an ._mcount call). Since setup_functions
> > excludes all functions without the ._mcount call, is_ftrace_func later
> > returns false for such functions and they are filtered before the BTF
> > processing.
> > 
> > Technically, get_vmlinux_addrs looks at a list of functions between
> > __start_mcount_loc and __stop_mcount_loc and considers only the listed.
> > 
> > I don't know what the correct fix is (exclude .opd functions from the
> > filter?). Neither why cross compiler doesn't fail, nor why ebi v2 avoids
> > this too.
> 
> Attaching a patch for pahole which fixes the issue, but I have no idea
> whether it is the right fix at all.

hi,
we're considering to disable ftrace filter completely,
I guess that would solve this issue for ppc as well

  https://lore.kernel.org/bpf/20210501001653.x3b4rk4vk4iqv3n7@kafai-mbp.dhcp.thefacebook.com/

jirka

> 
> > regards,--
> js
> suse labs

> From: Jiri Slaby <jslaby@suse.cz>
> Subject: ppc64: .opd section fix
> Patch-mainline: submitted 2021/05/03
> 
> Functions in the .opd section should be considered valid too. Otherwise,
> pahole cannot produce a .BTF section from vmlinux and kernel build
> fails on ppc64.
> ---
>  btf_encoder.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -31,6 +31,8 @@ struct funcs_layout {
>  	unsigned long mcount_start;
>  	unsigned long mcount_stop;
>  	unsigned long mcount_sec_idx;
> +	unsigned long opd_start;
> +	unsigned long opd_stop;
>  };
>  
>  struct elf_function {
> @@ -271,11 +273,24 @@ static int is_ftrace_func(struct elf_fun
>  	return start <= addrs[r] && addrs[r] < end;
>  }
>  
> +static int is_opd_func(struct elf_function *func, struct funcs_layout *fl)
> +{
> +	return fl->opd_start <= func->addr && func->addr < fl->opd_stop;
> +}
> +
>  static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
>  {
>  	__u64 *addrs, count, i;
>  	int functions_valid = 0;
>  	bool kmod = false;
> +	GElf_Shdr shdr;
> +	Elf_Scn *sec;
> +
> +	sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr, ".opd", NULL);
> +	if (sec) {
> +		fl->opd_start = shdr.sh_addr;
> +		fl->opd_stop = shdr.sh_addr + shdr.sh_size;
> +	}
>  
>  	/*
>  	 * Check if we are processing vmlinux image and
> @@ -322,7 +337,8 @@ static int setup_functions(struct btf_el
>  			func->addr += func->sh_addr;
>  
>  		/* Make sure function is within ftrace addresses. */
> -		if (is_ftrace_func(func, addrs, count)) {
> +		if (is_opd_func(func, fl) ||
> +				is_ftrace_func(func, addrs, count)) {
>  			/*
>  			 * We iterate over sorted array, so we can easily skip
>  			 * not valid item and move following valid field into

