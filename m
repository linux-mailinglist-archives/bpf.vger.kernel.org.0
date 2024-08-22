Return-Path: <bpf+bounces-37817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63295AC4A
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D328178B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23937160;
	Thu, 22 Aug 2024 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dJRx3i9I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD02E644
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298919; cv=none; b=QU+lhmCtQOgUj7zhc+HLV3X1QeFtj9mRff91bW1QV70kivajHtd5pdYPPOlw4KJqupONlG7eEp3Wn7hklQZkQwAhlwYlHB+86/Sl2gNLywOPerKENjtEJakbjTthdbjOLzVYI8bum9c94aWygPyJzfigdSaBGlpUXCzapaUnPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298919; c=relaxed/simple;
	bh=7dmwSdMRLm8qv0V1Uxb8MdeHJQDP8JaPwVdiHbK6+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRxCaZRuoBgCTHqVpLeXZ6yc/yMVDAwaXROlHmfqbHMgyq+vZp3Ll8nd4qzUcaD07ErYfSzvaulgNlNIkB78lvC0YvEri8MNen7s5Edp2NGKIHAYqCWf88m2xMZt8yjHIYQChNdYYTb7hMqQxyt3G9wVH2Ctu6P54gEKBsNlXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dJRx3i9I; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3730749ee7aso137010f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 20:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724298915; x=1724903715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiYt7wweiAWkF/UO6SLMM3+WC81D3aj+Mv9pKTlcxGI=;
        b=dJRx3i9Ig3Z5yMpJmwrkQAkZg1jjSLRn7sEpDfuCh3UXqoFrtFDbg4FIUBABGsmT5y
         wDu78y/J4KTxCgIJVfpRO8aFSks9/FeIkDNTcrpfagloqFdu7hTR6cMwLu6TTTE2R4tl
         ZdR+1WXp+7q9/gktGvQWV00EwFffj1EOK36xtaUVrHIlEfygB3/P+pgAnWiSJaSCImwh
         8bROEuNORSSfd49azTiKotUHcCz94HxOkHEYTEhWF1ReBkJ/1c2ZoE0bJgPFJ8lNjWi8
         AGl2pL4G54UPSTOHdhSvMt6c1N9poXnUtIq54COuMLS6Jy4eorAbKAtXswJrRiaYhsqb
         N54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724298915; x=1724903715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiYt7wweiAWkF/UO6SLMM3+WC81D3aj+Mv9pKTlcxGI=;
        b=J/TBwnQrMuTcom4NEViC2KnSzkVEVkVEc4tvUyteaevsswYo8npb0QC8j2o/qjAw2f
         cIV7Vec0fIHRwI3q7eLrfSysZ1yH/qdkuKnzK8EewaMCmTHaGpnFYkf8EUMc3B4/rlqn
         DJjR8kHZZmVDvJnJgKOLTqYYynK2+3WT5OWY+owMEkaYQI28jOECG8eKFXizE5hIPvPy
         IKmfu1AofA+G5lzVNmxUwjbDj8YhVWtD4NLmd/UNLfAIVFA4jc2NlK5dNxLRA0DVl57N
         8u/1hnc8HgjD0PnlBumI69rbcuBfQ14SiJChlVMKwE0ynA2xL/gbacTmdcZP4AMFfk8o
         H3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGTQWyfbR2PeHC8XRGO84vMaKr3wUs9jyky45uooQ7dqBxEPkp+gCGrkQnsfGRFD8iVdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EBsZ1LkhUclzo/SQ5fpBJmURfHoLWFxuXMy62+7CXMBUuFze
	4cnSm8e5UcjWrj4Sk4KU9MOV5iA4Fjr7FhnnfB4wpgLM7fwzlkBdIrYbZ/J4A9k=
X-Google-Smtp-Source: AGHT+IH3il0dzh0Karjn7wXKw0/nFh5eMsCfDQk4ZeVPQydzWvcffelDn5Ofi4i92lXwme4MGZxdmQ==
X-Received: by 2002:adf:e44c:0:b0:367:bb20:b3e1 with SMTP id ffacd0b85a97d-372fd7316a3mr2514470f8f.51.1724298914516;
        Wed, 21 Aug 2024 20:55:14 -0700 (PDT)
Received: from u94a ([2401:e180:8831:ab89:50b7:7c42:dbeb:f22f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dded9sm3371905ad.161.2024.08.21.20.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 20:55:14 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:55:05 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>

(Add pahole maintainer and mailing list)

Hi Arnaldo,

We're running into kernel build failure on 32-bit (both full 32-bit and
32-bit userspace on 64-bit kernel) because pahole crashed due to virtual
memory exhaustion[1]. As a workaround we currently limit pahole's
parallel job count to 1 on such system[2]:

On Tue, 20 Aug 2024 10:59:50AM +0200, Jiri Slaby wrote:
[...]
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..f7de8e922bce 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,7 +12,9 @@ endif
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
>  
> +ifeq ($(CONFIG_PAHOLE_CLASS),ELF64)
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> +endif
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>  
> diff --git a/scripts/pahole-class.sh b/scripts/pahole-class.sh
> new file mode 100644
> index 000000000000..d15a92077f76
> --- /dev/null
> +++ b/scripts/pahole-class.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Usage: $ ./pahole-class.sh pahole
> +#
> +# Prints pahole's ELF class, such as ELF64
> +
> +if [ ! -x "$(command -v "$@")" ]; then
> +	echo 0
> +	exit 1
> +fi
> +
> +PAHOLE="$(which "$@")"
> +CLASS="$(readelf -h "$PAHOLE" 2>/dev/null | sed -n 's/.*Class: *// p')"
> +
> +# Scripts like scripts/dummy-tools/pahole
> +if [ -n "$CLASS" ]; then
> +	echo "$CLASS"
> +else
> +	echo ELF64
> +fi
> -- 

This helped lowered the memory usage enough so pahole no longer crash:

On Wed, Aug 21, 2024 at 09:29:57AM GMT, Jiri Slaby wrote:
> On 21. 08. 24, 8:40, Jiri Slaby wrote:
> >  From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c20:
> > Run on 64bit:
> > pahole -j32 -> 4.102 GB
> > pahole -j16 -> 3.895 GB
> > pahole -j1 -> 3.706 GB
> > 
> > On 32bit (the same vmlinux):
> > pahole -j32 -> 2.870 GB (crash)
> > pahole -j16 -> 2.810 GB
> > pahole -j1 -> 2.444 GB

Jiri (Slaby) in the meanwhile has also proposed structure packing to
further reduce memory usage. (Note: I think the numbers below are from a
64-bit machine)

> From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c21:
> (In reply to Jiri Slaby from comment #20)
> > | |   |   ->24.01% (954,816,480B) 0x489B4AB: UnknownInlinedFun
> (dwarf_loader.c:959)
> 
> So given this struct class_member is the largest consumer, running pahole on
> pahole. The below results in 4.102 GB -> 3.585 GB savings.
> 
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -487,14 +487,14 @@ int cu__for_all_tags(struct cu *cu,
>   */
>  struct tag {
>         struct list_head node;
> +       const char       *attribute;
> +       void             *priv;
>         type_id_t        type;
>         uint16_t         tag;
> +       uint16_t         recursivity_level;
>         bool             visited;
>         bool             top_level;
>         bool             has_btf_type_tag;
> -       uint16_t         recursivity_level;
> -       const char       *attribute;
> -       void             *priv;
>  };
> 
>  // To use with things like type->type_enum ==
> perf_event_type+perf_user_event_type
> @@ -1086,17 +1086,17 @@ static inline int function__inlined(const struct
> function *func)
>  struct class_member {
>         struct tag       tag;
>         const char       *name;
> +       uint64_t         const_value;
>         uint32_t         bit_offset;
>         uint32_t         bit_size;
>         uint32_t         byte_offset;
>         int              hole;
>         size_t           byte_size;
> +       uint32_t         alignment;
>         int8_t           bitfield_offset;
>         uint8_t          bitfield_size;
>         uint8_t          bit_hole;
>         uint8_t          bitfield_end:1;
> -       uint64_t         const_value;
> -       uint32_t         alignment;
>         uint8_t          visited:1;
>         uint8_t          is_static:1;
>         uint8_t          has_bit_offset:1;
>--

What do you think?

IIUC pahole's memory usage is largely tied to the number of entries in
vmlinux/kmodule DWARF, and there probably isn't much we could do about
that.

Shung-Hsi

1: https://bugzilla.suse.com/show_bug.cgi?id=1229450
2: https://lore.kernel.org/all/20240820085950.200358-1-jirislaby@kernel.org/

