Return-Path: <bpf+bounces-67373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C1B42F3C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 03:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E87A1BC876C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146111C8621;
	Thu,  4 Sep 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0h855yF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300531A9FB6
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950712; cv=none; b=TO9R9f1ShUctgXQijKQW0ROQMOz1+7ggFtj8Y8eccJ9gRwMC8GjBOl4LjpyKvqB/10tidIN3bi6Jh4QlkA5kXE08XxBUK5jbYLPA/A4G+5kNi1Jqo7TFGrZ9Guz+P4mIP9PZkTnHWLLqbmW3xwa0cciJhiYG224t9rGkyUXQoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950712; c=relaxed/simple;
	bh=1yQVy6KL8Wy7C67HxFNGJCAgN80a5g1uHMd0SJizcPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utasGaLVnEBWZbDZtscCQo+dVxaWPBu89LOc6FNJZ3AipoqwWJfItt518O6Tp8uKgk1A3wg7L1dj8vI8B1cTQwCPpWkEQPa2KXe4jQ2SDBas+LIL1dcSVcopgQSIdacGHD/OFk9ouXnrNK1iH7Ub41Qn26SCjck3JMUIdXD8heA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0h855yF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61e27fee909so198299eaf.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756950710; x=1757555510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+ehcv4WqzfqIcfmWR6zW5Stl2bmeATexQZd5bH+eUM=;
        b=X0h855yF3rctLJSroY0zJ0MH61DdlB7fIdeZUH4qkG+ET8m2yBR3igak+T+vtDx75Y
         5FVNT2JuNl0MpQ/9tyY2GRPypQAqR7i4IiMCpEF5iU09m+E7m+22dAg8Sj9L615jK4Ia
         757/UMW1eCc4GpINoT0JuBN8XPnFPbYWB/FjEA1KWMJKzP+v5XqmBPiVPNsyUeOUudLT
         xkQUk6WLbNwNvUFwXrHbAMpSXeBDfPCr1/s2R1Ed/W1BAul937RGpiiTN6fKPaDx6hoM
         yiDUvmHeG0vMcLjoIvD6SbFyIj5ku24pakUfWMeza/Fnb5qYkmyXJH6oo7ZLh6SPtOW+
         o3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756950710; x=1757555510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+ehcv4WqzfqIcfmWR6zW5Stl2bmeATexQZd5bH+eUM=;
        b=cpss9geMSnSj7lWrgBDU8u2IlpjebG74lecsnaZf8EY5ghZ9NTs6lG3limAYM5K1NL
         SsJOeBwUP1qVGng6HIe7jDGTyttRs0VHmNfrMak88g8uKUztfI1IwEYbhhdZHAUooacz
         GaYVL16DR1bduEYTLW5M/X45NZQjZVBaeKDg1hQqC9t83bv9wCIV2/s21Kx6bZP1ImW5
         sC8EhXFeJHq8dBFbta3ofzsKkn4xlxVUzRUtPem76VCBMNc+moMv8AGFH7+dHA0SqOJV
         oPz5RSV++eU9JhVoeTMoQbtIY6DO5pqNLwOKUj23aWspfBD7w0qkr5GY8Uad8VTT43VE
         XKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8eeP5WXD7x3qAKJbwSPreI01Q7oZhRTgIzkmIB29fJCp9iLPxoCl4KNnrC3JxcgeIBho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1W1ZN+2D5a2EM4W5z1C74kxwczxaYIE6AHScMRr31xWskL+To
	/a5nwbp4GeJGuzhK+Q/cBtfFOijp7mFX+CCXRil0UM06EcSeMhHuTZF8C6l+o8q2NzqjtgX/F0j
	wirPW469LhN9giPym7ZjHf7dAQQAL6Vw3pDHmlNE=
X-Gm-Gg: ASbGncvGoWFdozl40ygnzCr4Rk/xkw0TWQaMYTSl8hoJpVaGuzQ56HxZJmnf7aXwu4g
	nlyShma7+GlO3u9F82HFKdDTW/Ix+pGhsEVEVpWPNaWtL8e+tNbGLA1BLXFNdyTLyxWFafdR8k7
	1o97fLaJXyRnKwJA8B/IWp1XAG8vcO1wPN1NvIudem76rGCMMoxhY3TvCfnhicl+dqbiwT7Azq2
	hO7/yNAiWzdtiz/CQ==
X-Google-Smtp-Source: AGHT+IFtoiAM7ruilXBBd9h3o6f+PVRNXCZLkBzgaUWE+nKkKvOoOromMi7KR2TS6MV5gBVECj/3IwRpUdMhuyraWFs=
X-Received: by 2002:a05:6871:781a:b0:30c:92a1:64e6 with SMTP id
 586e51a60fabf-319633df0abmr7575347fac.42.1756950710085; Wed, 03 Sep 2025
 18:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-3-hengqi.chen@gmail.com>
 <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com>
In-Reply-To: <CAAhV-H5UUVYnM3TkKujvS2u99NTEK7VCQsVHZkAKzhL5o8jCXA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 4 Sep 2025 09:51:38 +0800
X-Gm-Features: Ac12FXznlh4p1q7GydLiq64gmujxhra8YEXFolkZImPgLjkCqe_kOXTaTo4PMQ4
Message-ID: <CAEyhmHSU4R1XRLy5O=OicvdAAzeSQxo-Hnd5Pm_FazApeydH2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] LoongArch: BPF: Remove duplicated bpf_flush_icache()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Wed, Sep 3, 2025 at 8:05=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > The bpf_flush_icache() is called by bpf_arch_text_copy()
> > already. So remove it.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 77033947f1b2..9155f9e725a1 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1721,7 +1721,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *ro_image,
> >                 goto out;
> >         }
> >
> > -       bpf_flush_icache(ro_image, ro_image_end);
> Both ARM64 and RISC-V do this, so I prefer to keep it.
>

Then they probably should remove it too, I guess.

> Huacai
>
> >  out:
> >         kvfree(image);
> >         return ret < 0 ? ret : size;
> > --
> > 2.43.5
> >

