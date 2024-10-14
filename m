Return-Path: <bpf+bounces-41865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270F99CACB
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BBB209CE
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFA1A76B9;
	Mon, 14 Oct 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLXI+8u+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E015F40B
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910576; cv=none; b=pmFHCriE1NruVFkaFiqMoguWfMwPAGdcQHSUDc0Tx8CgKJJdusAsY0k6Aui0DZZkkrHTeP1sJXoncpPOQKDsjlu5OpBpzxq5w2gx19T72nEIaQA4MGlNb87K/HAvaoeEQqcIYP7jTG2x7tNK/HkjrHaoqPtY9L2PG+8syRTSW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910576; c=relaxed/simple;
	bh=ErCWha5F9Zu142Z2PWKpSbdYqh9qP10QVqfEzL0yazE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxSA9yrsZRYwf/YkytOYEUycuxyFrLhYqCZKQNYf5xZWDn0y9Z4I6mc/lI1OelejrlM33W/o7GA1gAZiCNciqpT7WyH9cSwDm4gqleBENmmhDp2uedFtgJipRyoXWZupLMfbyTpWNkNoLWNPjzhIsv6Sna3UmiuYpNSwQzK/7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLXI+8u+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728910573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEnNnGfP9frBHzr453KLcV25QRVhLzNr1WskBaFRKrs=;
	b=NLXI+8u+kliyNQ7hyiwM16bLSIjlHdxjU6jvkpQtR9pEB7HCwl2rKprVFSkm7I5twpfACB
	dAKpzZW9H951N7ml895ljbG2zD+C12pQAYySXtdtZ5sk/xvKCVedij0rEhk1haGu3KsO3C
	tiYpJWD//4+tMZ1cfz3xs2/cmFjze+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-7uvifH9YPVe4nuT3jzPfYQ-1; Mon, 14 Oct 2024 08:56:12 -0400
X-MC-Unique: 7uvifH9YPVe4nuT3jzPfYQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4311f7b9f04so17661165e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 05:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910571; x=1729515371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEnNnGfP9frBHzr453KLcV25QRVhLzNr1WskBaFRKrs=;
        b=LsRD/XaphAWtTdnn09rxS8TT43XiYzug5gXHOGqaFfIzzyFlXPwUD2/DY0sQmqM3jt
         8r+K6MJ1+boMnnn0JnctSSG5HIu+0QpHO8qIcMXa9qwCWT/hvrD3PehYX0tLGb+ufcHv
         4CsD0TbikZLMlIUT4E+RBLzTsq3jMCVqFkvHQ21sbm0cW4vhzoeKJvQIDVFvAs0svk8Y
         VmlhqV3RMsSVpKTvWLv6zX/IjTacjCzzMhFp+cR2eimbPTyD30XwD3VhMNfpJrmnrh03
         ZNy8+tBNwujP2ufNWwx0KU7ykf2sRpyF0wkWWSiruNclWhzndeNYk29/EbKRJoBx/y9h
         CziA==
X-Forwarded-Encrypted: i=1; AJvYcCVxA6/X3azLUpJX8KM7bTgWxp2Irz43oqYSNyMqqJrksqdEaguB47/zb03Xog/f6L1uTbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi80HY8jG4a5u5FKyLJhL8p/ihXU+ZMYgIbKXJ3gi4qldeaOeV
	dene1guepr2QI3B9v9APQDy0gVJmsbq09ysj6NYgFvOiM55W92RRfVwpHqZCDCRzgDOuwcI301p
	ZszHB5UDdSUCqjk7HGEpQPWWfQRSB8pN3EEopSr0MGisYz1S+
X-Received: by 2002:a05:600c:1c04:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-4311df56126mr93827265e9.30.1728910571127;
        Mon, 14 Oct 2024 05:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKPexQ4gqGD2eGTWOjtR3b3QJbZra8hF6ubvShxY0ViXl2Yc28UtFxhc4PU5d6AEZSMDYzRA==
X-Received: by 2002:a05:600c:1c04:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-4311df56126mr93826915e9.30.1728910570532;
        Mon, 14 Oct 2024 05:56:10 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d78dcsm121090945e9.5.2024.10.14.05.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 05:56:10 -0700 (PDT)
Message-ID: <5c9a296b-217e-4c34-ac98-abe23f408f8a@redhat.com>
Date: Mon, 14 Oct 2024 14:56:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/3] tools/resolve_btfids: Simplify handling
 cross-endian compilation
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
 <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 09:49, Tony Ambardar wrote:
> Initially, the .BTF_ids section was created zero-filled and then patched
> with BTF IDs by resolve_btfids on the build host. Patching was done in
> native endianness and thus failed to work for cross-endian compile targets.
> This was fixed in [1] by using libelf-based translation to output patched
> data in target byte order.
> 
> The addition of 8-byte BTF sets in [2] lead to .BTF_ids creation with both
> target-endian values and zero-filled data to be later patched. This again
> broke cross-endian compilation as the already-correct target-endian values
> were translated on output by libelf [1]. The problem was worked around [3]
> by manually converting BTF SET8 values to native endianness, so that final
> libelf output translation yields data in target byte order.
> 
> Simplify and make the code more robust against future changes like [2] by
> employing libelf-based endian translation on both input and output, which
> is typical of libelf usage.
> 
> [1]: 61e8aeda9398 ("bpf: Fix libelf endian handling in resolv_btfids")
> [2]: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> [3]: 903fad439466 ("tools/resolve_btfids: Fix cross-compilation to non-host endianness")
> 
> CC: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---

Acked-by: Viktor Malik <vmalik@redhat.com>

>  tools/bpf/resolve_btfids/main.c | 60 ++++++++++++---------------------
>  1 file changed, 22 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d54aaa0619df..9f1ab23ed014 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -90,14 +90,6 @@
>  
>  #define ADDR_CNT	100
>  
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> -# define ELFDATANATIVE	ELFDATA2LSB
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> -# define ELFDATANATIVE	ELFDATA2MSB
> -#else
> -# error "Unknown machine endianness!"
> -#endif
> -
>  struct btf_id {
>  	struct rb_node	 rb_node;
>  	char		*name;
> @@ -125,7 +117,6 @@ struct object {
>  		int		 idlist_shndx;
>  		size_t		 strtabidx;
>  		unsigned long	 idlist_addr;
> -		int		 encoding;
>  	} efile;
>  
>  	struct rb_root	sets;
> @@ -325,11 +316,30 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>  	return 0;
>  }
>  
> +static int btfids_endian_fix(struct object *obj)
> +{
> +	Elf_Data *btfids = obj->efile.idlist;
> +	Elf *elf = obj->efile.elf;
> +	int file_byteorder;
> +
> +	/* This should always succeed due to prior ELF checks */
> +	file_byteorder = elf_getident(elf, NULL)[EI_DATA];
> +
> +	/* Set type to ensure endian translation occurs, and manually invoke
> +	 * translation on input since .BTF_ids section as created disables it.
> +	 */
> +	btfids->d_type = ELF_T_WORD;
> +	if (gelf_xlatetom(elf, btfids, btfids, file_byteorder) == NULL) {
> +		pr_err("FAILED xlatetom .BTF_ids data: %s\n", elf_errmsg(-1));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int elf_collect(struct object *obj)
>  {
>  	Elf_Scn *scn = NULL;
>  	size_t shdrstrndx;
> -	GElf_Ehdr ehdr;
>  	int idx = 0;
>  	Elf *elf;
>  	int fd;
> @@ -361,13 +371,6 @@ static int elf_collect(struct object *obj)
>  		return -1;
>  	}
>  
> -	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> -		pr_err("FAILED cannot get ELF header: %s\n",
> -			elf_errmsg(-1));
> -		return -1;
> -	}
> -	obj->efile.encoding = ehdr.e_ident[EI_DATA];
> -
>  	/*
>  	 * Scan all the elf sections and look for save data
>  	 * from .BTF_ids section and symbols.
> @@ -409,6 +412,8 @@ static int elf_collect(struct object *obj)
>  			obj->efile.idlist       = data;
>  			obj->efile.idlist_shndx = idx;
>  			obj->efile.idlist_addr  = sh.sh_addr;
> +			if (btfids_endian_fix(obj))
> +				return -1;
>  		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
>  			/* If a .BTF.base section is found, do not resolve
>  			 * BTF ids relative to vmlinux; resolve relative
> @@ -706,24 +711,6 @@ static int sets_patch(struct object *obj)
>  			 */
>  			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
>  			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> -
> -			/*
> -			 * When ELF endianness does not match endianness of the
> -			 * host, libelf will do the translation when updating
> -			 * the ELF. This, however, corrupts SET8 flags which are
> -			 * already in the target endianness. So, let's bswap
> -			 * them to the host endianness and libelf will then
> -			 * correctly translate everything.
> -			 */
> -			if (obj->efile.encoding != ELFDATANATIVE) {
> -				int i;
> -
> -				set8->flags = bswap_32(set8->flags);
> -				for (i = 0; i < set8->cnt; i++) {
> -					set8->pairs[i].flags =
> -						bswap_32(set8->pairs[i].flags);
> -				}
> -			}
>  		}
>  
>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
> @@ -748,9 +735,6 @@ static int symbols_patch(struct object *obj)
>  	if (sets_patch(obj))
>  		return -1;
>  
> -	/* Set type to ensure endian translation occurs. */
> -	obj->efile.idlist->d_type = ELF_T_WORD;
> -
>  	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
>  
>  	err = elf_update(obj->efile.elf, ELF_C_WRITE);


