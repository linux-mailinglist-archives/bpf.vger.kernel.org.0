Return-Path: <bpf+bounces-56708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2EA9CEF1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A24A6FB3
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FC1C84C5;
	Fri, 25 Apr 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKdOKpO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD2194A44;
	Fri, 25 Apr 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599970; cv=none; b=N0GPDZK5S0B69WRJdK6KwglzhW9XUDK5pMpKovhCDutB18koaJyCV13BWlr/FAbGY+xi0+DksZdktne88eXU5WquBnmmkz8h7RSx/OlURcIAoIoUzs6KwrnblCJuZxdDWLdRolhWYvRXTbMPTDviGMcQLw6lO2htR7ieUXYjUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599970; c=relaxed/simple;
	bh=E/6K11Nu1doilIwKesstDitPx1319vRFjJrnwsJWGlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAw6O8FNNNtrkb6kRgxPtPLqqGRPCT0KJI8Gh8RYEYle61wbNsuDHOG1fWfdDLy4fsTTzlsOgBAYutEsZn+6kNgy31k1iUB3pwWk2tndiiLv01Iou1HvZEUWQyl3qGsZvAmnPDS2hzhPktU036m0ocSSQCmFNIbNAfbxzncyQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKdOKpO5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376dd56eccso2683192b3a.0;
        Fri, 25 Apr 2025 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745599967; x=1746204767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPE0jw/cbWW6nhWNEm39me5DCK6XBagvczncyZzTTCk=;
        b=iKdOKpO5opOJBurICCYdUqe3owB2hmEQs7C5u+Z8vmwngCWhmhbfcAGi/8S13FDzxK
         vkTVWoC7MB4PAZrqV/SXxVQ9BpJ5zOH1JddgmZcsHsMA7EqLcnwuOmRVVyN2go/0wjCa
         PMj4RFlunZj0I21M30UJr4QfD/BQxrCt8zdklgZB5TZlMy5qqvaR3bBEv8ZROn6q8oQH
         QfAY+5S2YzukBaJ6cP6F2oXhEiBKh5eN0Tr41Re9KW4PCXmsKVItLsWlet9FilsD3W4K
         poJRXXIMjZHCTldh+OHRc8Q9KyoQqf0Nlsz10hQ7x3NgURcAAGnPCgpJjjY/8U/DAjuI
         hE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599967; x=1746204767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPE0jw/cbWW6nhWNEm39me5DCK6XBagvczncyZzTTCk=;
        b=nh4yAx3cTViVnmZL3IkujHRHzfFYs3tJs7647pj0uR3IPJfJl/5V1FIZ+ELcc6ZpIK
         +SxP0daFGMjczkkHqgwffNYagZwLY1P6lu52ADYL6eCDYt1OIQ0GjCvI7qqa2LBR7EKI
         VN6I7SaGkzTaCUVR3R4LH4HIaEkJdPgNJ6cg/GCMOS+S2yP8s3BCXCzvLcaRvg0QHWRd
         uR3fgb/hs9J61B2wNk8PZHXg2zcQalDlYQWAHQ9CBBZHW1x4IHedqQ9bUCekNKP5oUfi
         dGnQGmn4GYevRyRVyFTjmB7gokznh0UTz6uUjl28RkOwVADcton94Z5xNPvIr/kwdvPi
         hsug==
X-Forwarded-Encrypted: i=1; AJvYcCXCxkSsTIlRyTgQSo622+QUTMteh5sSmMJ55GZzry7J/ctSmYd/nWZvsxej+L0s4vDuYo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dJJX1bLuwEzuxph/vFLsUJLmxjXcjafKuwyvS/urHAifPiZH
	aa7r++6a6s2B4aEGJQ37ZFCEaDgFta7bzMfObm8svmg+Y+XXNSBXq57XPTy9JPSe5Bg824vbsYl
	CJT2md12xnZSr7lhgdaqxUjR3ebM=
X-Gm-Gg: ASbGncvhx0wtVGAMI/FqKYbi330W1q6RMeruKQanISbCXXMfaKqSdA56z2u2FjDuLmB
	PLyYDkJ+u6gcfZlo2uwtv6HO9kgm+n6Jf1A5qq7TjD5VcYOG8WVoGlbnQ1Pb4HMO0Ir6cBUS03G
	qdNAxHq0sy/jbq8tVHQlDk22uFj4oEO4/yNDWH8gl+89vJLiBD
X-Google-Smtp-Source: AGHT+IHsE4tpFV00HDt6z5NOiZdy4xqMC2tQ7aGg3Q1NBqpL8kEB1l+fIJtawgH16A553JEcLhActfPM/+fohqK2riQ=
X-Received: by 2002:a05:6a21:4002:b0:1f5:931d:ca6d with SMTP id
 adf61e73a8af0-2045b6ae067mr4051413637.1.1745599967202; Fri, 25 Apr 2025
 09:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425095042.838824-1-jianghaoran@kylinos.cn>
In-Reply-To: <20250425095042.838824-1-jianghaoran@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 09:52:34 -0700
X-Gm-Features: ATxdqUEVCDIzlgDehq91RGcWZVxbp-q_nLVPhO7lnNt562E0ZXlBsA1KFWVfwvI
Message-ID: <CAEf4Bzabjf68a-bP1RuHUEAdiz0MuWuyS5w+nZagEOHesDQgpQ@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Fix compilation failure for samples/bpf on
 LoongArch Fedora
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, trix@redhat.com, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, chenhuacai@kernel.org, yangtiezhu@loongson.cn, 
	zhangxi <zhangxi@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:51=E2=80=AFAM Haoran Jiang <jianghaoran@kylinos.c=
n> wrote:
>
> When building the latest samples/bpf on LoongArch Fedora
>
>      make M=3Dsamples/bpf
>
> There are compilation errors as follows:
>
> In file included from ./linux/samples/bpf/sockex2_kern.c:2:
> In file included from ./include/uapi/linux/in.h:25:
> In file included from ./include/linux/socket.h:8:
> In file included from ./include/linux/uio.h:9:
> In file included from ./include/linux/thread_info.h:60:
> In file included from ./arch/loongarch/include/asm/thread_info.h:15:
> In file included from ./arch/loongarch/include/asm/processor.h:13:
> In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
> ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin=
.h' file not found
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>
> larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
> and the header file location is specified at compile time.
>
> Test on LoongArch Fedora:
> https://github.com/fedora-remix-loongarch/releases-info
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Signed-off-by: zhangxi <zhangxi@kylinos.cn>
> Change-Id: I5fca6f0cee21e429982c5a3865efc5afeb3fa757
> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

applied to bpf tree, thanks

> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 3fa16412db15..927d72659173 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -392,7 +392,7 @@ $(obj)/%.o: $(src)/%.c
>         @echo "  CLANG-bpf " $@
>         $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS=
) \
>                 -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
> -               -I$(LIBBPF_INCLUDE) \
> +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>                 -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-poi=
nter-sign \
>                 -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-=
types \
>                 -Wno-gnu-variable-sized-type-not-at-end \
> --
> 2.25.1
>

