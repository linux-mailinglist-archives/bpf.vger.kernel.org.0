Return-Path: <bpf+bounces-45620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931EB9D9B7E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA32168A8A
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828471D8DE4;
	Tue, 26 Nov 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="FNq1DI5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404701D5CF2
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638823; cv=none; b=i7v9HU2nU44NVMRkZxrA5GlTjsC7fFftcSmQcmSarSvHPaR0K3Bhs0i22KXPVa3LpbAwOkUzANUVPtg1NCLhu36+P8zWX0xjE8Xhbss3uEvobi6XDyTMjYMhSSglgqOuVMZ9hl3ceRRInjduilQRja4DhBV1F0pNkpLwtrCA8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638823; c=relaxed/simple;
	bh=huKLtzAgcf0W4NNakAR7dEpy8buSsn6BMMKoHGRv6QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjFZPopcNTw49tJNhxxlrdlfQD0DWdwL7g2/AIX2hPO8mFFbwM5lSLbCnB/GZqnsvAUyVxLNsajm7CLFD/67llmuuXpxBSrNVsBsSx3FZYl1SD093qqkCMB5Ur9oemMah1n5zzG2HFpCG25Fw0ZYo2D+hIMOPorzivooT5U/wiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=FNq1DI5U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa8092e34so53969321fa.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732638819; x=1733243619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=watqJiNoqlNmoPI76PupjfXhCNy9l3HeaIBiI62dpGY=;
        b=FNq1DI5U+xpBay34j2Hfeo989vs5gJ6jC49ZaqOARilkk9QdOFvYY/Yn6wt0Ccc3Lp
         w+fpoI3FdD0l1plpmjH2pc7qvzvNByPwnVcwodswMpPwt1KGHfMZnDYHJ/PWI4rOA0mx
         EgoGuG6f7AEhEmsTX7q+yrdz8J5CjH80wAg7Tgvp+R6tbl4wvx0nA5X1teKQHUzFREcG
         PA4npdyphjndzai1nNENZTW12gcRhe49icjCDSpU6yLaEOOXIXm2cr70AK0gHwBDgFKj
         MNWmmpMvaxfGmrY7Zov4w5ES35gJTTlf+0E2qTZBwqJU0e767pLeqeRGFrJb+dgj09m+
         6y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638819; x=1733243619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=watqJiNoqlNmoPI76PupjfXhCNy9l3HeaIBiI62dpGY=;
        b=Hpv6IWD0+ZXaysWPN0LMoDjHjOSC/sas+UathCm4Hzvql32DL2mZnXrhE8i++BeSEZ
         kDCUUpc7wTUUf40hHhyX55BA9FkVjtueWoHboRwtjn5O+NmszW27pwnAzuVPDD4QlyKa
         thChs5gwT5H1jiNupCzneosAUPKgYHP5jN8XUwZuV8gpz1WDXk1QozV3R/b/DjTs32ME
         tVnghlB5u+6uzSaFajmqm7Ss57fBY3I2MhhhUzTCa4ZL+4+mHJVbB9slSOnm66Nl9oO+
         KMYYmypGCgzDg1Y4ck9Cz9abW7Xm1YXtJzKfo4RIQEClUPyOlQ+cClvWzObPhdwv1E3x
         JM5w==
X-Gm-Message-State: AOJu0YyID1dD9IDNY2Ti22V5LGMQKy2iSrp1oQGz1iUlW+LP9U0ebykV
	heroYX6TevFw0TdLesAanGANnI+uRNFnUamdnv9JfO1mkcQuwxxbqGfdNCNi9hzxsZ7qWrOR3Dd
	l
X-Gm-Gg: ASbGnctfDHd5TECgjwasjdcKnT4A0hjESH4dkZWk8JaOWOFOLwusKdtdOGpqaDeikTb
	jyg2MfvzhE/SAv4ToBOnFTUvb3BbLGj2+SNEZygqK2i0CHBIh9LoPshI+cX+TbkwSf5Maj/aw8y
	YrtWEQW76mXshyis1cTK0tLdG84/16RDF9RvkaVepQWmA6VWWGn5n0rOayyJ/FpZhEH21OqpZT/
	UT5HgIlZZSgoPYwihcPukr+2LVq4xZcwYPRNT0=
X-Google-Smtp-Source: AGHT+IG8Ye04DtwYrA4Xmr/Gu1QYapkichYakYXadUq5ZV4wUKKkDPmrfQbB1NYC536selaQSncMIg==
X-Received: by 2002:a05:651c:555:b0:2fb:6181:8ca1 with SMTP id 38308e7fff4ca-2ffa70f6cd3mr82345791fa.6.1732638819336;
        Tue, 26 Nov 2024 08:33:39 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fcf86sm5261423a12.63.2024.11.26.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:33:38 -0800 (PST)
Date: Tue, 26 Nov 2024 16:36:13 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 bpf-next 5/6] bpf: fix potential error return
Message-ID: <Z0X4/SIJ7ZkL86o3@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-6-aspsk@isovalent.com>
 <CAADnVQ+=R-ai4wpBuGkDa9GeARYGeG3oXBjoQSXP06BN6TPdpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+=R-ai4wpBuGkDa9GeARYGeG3oXBjoQSXP06BN6TPdpg@mail.gmail.com>

On 24/11/25 05:43PM, Alexei Starovoitov wrote:
> On Tue, Nov 19, 2024 at 2:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> > error is a result of bpf_adj_branches(), and thus should be always 0
> > However, if for any reason it is not 0, then it will be converted to
> > boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> > error value. Fix this by returning the original err after the WARN check.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 14d9288441f2..a15059918768 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
> >
> >  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >  {
> > +       int err;
> > +
> >         /* Branch offsets can't overflow when program is shrinking, no need
> >          * to call bpf_adj_branches(..., true) here
> >          */
> > @@ -546,7 +548,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >                 sizeof(struct bpf_insn) * (prog->len - off - cnt));
> >         prog->len -= cnt;
> >
> > -       return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
> > +       err = bpf_adj_branches(prog, off, off + cnt, off, false);
> > +       WARN_ON_ONCE(err);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> 
> That looks very odd. Just return err ?

Ah, yes, thanks. This was supposed to be followed up by a patch which
adds code in between, but as this patch is out of scope of this set,
I will just return err here.

