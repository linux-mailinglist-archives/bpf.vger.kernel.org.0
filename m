Return-Path: <bpf+bounces-21923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE8854070
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3348D28DCA5
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6E63404;
	Tue, 13 Feb 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxlZD6g7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E56313C
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868599; cv=none; b=sRIHFRE1QKPE9kqnkATpBywhkxmQiX/6fX5FPSvrkpNONuUXckYLI7qfJBe1DSCAJao7NvreDgme7Mktt4bKwi6fc94zFKmd2UXDtJvx37GhKXvfS1Htty3Ro5CJPBWyqeVLalTDQ5HHfk5yDwJQ9MW3b0AaFSy0kViOG9+OzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868599; c=relaxed/simple;
	bh=eG1Z7qXp1jDGBo50wsnYjDQwhUF5D2ifiNDV1RQ+kpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx/VZO1vqGNLwswVjDBBhbcVYpLSw0f2QZerORjHACvQ+fu+VrlURBrxcTX5cTHZaDST+yEr1H7PYDdZSqSG9452T/NLjXM7FpE/KdCeJgq9yTGwAo2KsckK7BVdMDwTM3NuT9Q2lAElj0cHtYrrYecYPIHEW/gZYAO1nd2XnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxlZD6g7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3641ec7803fso3216535ab.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707868596; x=1708473396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5i0+7qUkGUR+StQ2aGirnK2+rjtRkZXXH7K9o3+5lE=;
        b=WxlZD6g7OdQLjuRfBGPOhxKRIg8AqBXP4EHhI5tcB2vs2JGR9Q9UX7v7HF/VpJfW6I
         sqgDWwRo9ccvV/iREbDb69y5Hu9nuYHikBdvxM3hfuhiyMOzdGAvSiKEKTecv3So6Vdj
         3YEoBy36bNfQYLe2omuzplTiE3I30r8zuhfIr/0glJkUM9vLpZZTvji5OkBmtWm+zwDm
         R7/zvmzb3ZuB+wSckTdkPUgs+zABNzWPRze1vhPkdw80qjx67JVSqf5ZYQECt9ggWisW
         OMkibnCWnQFa2pSCWQi35FTv9tLt+SkCYThCEDsCW/Vj+n1SAYpl0wYdd/v+FBUhNhgY
         7Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868596; x=1708473396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5i0+7qUkGUR+StQ2aGirnK2+rjtRkZXXH7K9o3+5lE=;
        b=CtY7ATqrhBeIW+ZW+bBNFLc/4NI7AX2cv2QFC3pPMg5oufH8i4OklLrf5/T4Y1d/2c
         jBpP72aMtpbHWiIsb+SUyp5nLowo/hTagVr1boKGypOP4Fa7HH5G1oUZQEZrOm6LhtaN
         y/9Pk+JrbdWr2WoLGjI+kTcq7FP56lQLPrT/qsuuceSTGpfCDUgEGrmwY87YwNIl2WQ3
         tht3wEMPGWcdwydrogA2vMpy4HzR+HNz4sNKAimrR+e3k5rxqZSiuKzXarE3bwqOI/BD
         wtucURi/qbj+7A46tWgCtj07qs9cLVrt8+ghKKQ/CKJqLHQ5CgsVB97qN0Q/sqNABkYe
         Nrsg==
X-Forwarded-Encrypted: i=1; AJvYcCXN//YfoI+fW2zD1Z93sNSWtcKFCDGZldVpNV9I3tvL+CFmz0cNOmDcN8iareH9PMHZcht74IzbHTJfF3SyFJKd6LbU
X-Gm-Message-State: AOJu0Ywfta7qxI6OghgxZpPxlaq6L+wdHoVIuvGMu1TtB1xxrUKPxQ0b
	9Sj+otq0IM0yYxXz/nsPOaQe+Thh++cUCD0Ak6HzcZ0l35q4aGbd/R6wuoxwlA==
X-Google-Smtp-Source: AGHT+IG62RuLwq2OLE5Yz0FmcAHGNtv9/YBtgvIUbfni/ZF6on/cLe36ocrjEhGbaxm7Edp0+sjhbg==
X-Received: by 2002:a05:6e02:1bc7:b0:363:cbb8:53c7 with SMTP id x7-20020a056e021bc700b00363cbb853c7mr1787567ilv.23.1707868596087;
        Tue, 13 Feb 2024 15:56:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYvP9l0sxOZNWxefz67TKAm7Fu6CaEpFHauX0AQItVIogkJSLzPJZFx0UakEwLZxl00t5oU+31mhKid7inxkeFp2reqoNF7I1kQxXuMe0ZLLjU+VNcyvi5h0kzhX+TyeJ1VP43aVOT4m3qsJuZ2WTnAEwLcwMnWktU04ycyXRDgCmsBODEflPdYmaHZucstimY66Km2/Z5gIAEwJ1hCoRUXhk25LYKDboLX3KT8nLXdpopsd/2CwWbSm4unOobRINWMcfmsvORIfDXc7r/Zsi25RKx+qHoRGHeVwQ1Bb6ybiJKW3ABwCmcS53hIVlmX6p+Il8fLHtHn7VLINZCCIx57OjUssEr+x0lmRVkHqzYzjQ=
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id n11-20020a02cc0b000000b004739f0fc27fsm2028449jap.164.2024.02.13.15.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:56:35 -0800 (PST)
Date: Tue, 13 Feb 2024 23:56:30 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com,
	morbo@google.com, keescook@chromium.org, maskray@google.com,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: Fix changing ELF file type for output of
 gen_btf for big endian
Message-ID: <20240213235630.423raijsgijkgrnj@google.com>
References: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>

Hi,

On Mon, Feb 12, 2024 at 07:05:10PM -0700, Nathan Chancellor wrote:
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o to ET_REL via dd, which works
> fine for little endian platforms:
>
>    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
>   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
>
> However, for big endian platforms, it changes the wrong byte, resulting
> in an invalid ELF file type, which ld.lld rejects:
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>
>   Type:                              <unknown>: 103
>
>   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
>
> Fix this by updating the entire 16-bit e_type field rather than just a
> single byte, so that everything works correctly for all platforms and
> linkers.
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>
>   Type:                              REL (Relocatable file)
>
> While in the area, update the comment to mention that binutils 2.35+
> matches LLD's behavior of rejecting an ET_EXEC input, which occurred
> after the comment was added.
>
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I prefer this version to v1 as well. This seems better than setting the
seek value.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> Changes in v2:
> - Rather than change the seek value for dd, update the entire e_type
>   field (Masahiro). Due to this change, I did not carry forward the
>   tags of v1.
> - Slightly update commit message to remove mention of ET_EXEC, which
>   does not match the dump (Masahiro).
> - Update comment to mention binutils 2.35+ has the same behavior as LLD
>   (Fangrui).
> - Link to v1: https://lore.kernel.org/r/20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org
> ---
>  scripts/link-vmlinux.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..7862a8101747 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -135,8 +135,13 @@ gen_btf()
>  	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
>  		--strip-all ${1} ${2} 2>/dev/null
>  	# Change e_type to ET_REL so that it can be used to link final vmlinux.
> -	# Unlike GNU ld, lld does not allow an ET_EXEC input.
> -	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
> +	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> +	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +		et_rel='\0\1'
> +	else
> +		et_rel='\1\0'
> +	fi
> +	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
>  }
>
>  # Create ${2} .S file with all symbols from the ${1} object file
>
> ---
> base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e1296
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
Thanks
Justin

