Return-Path: <bpf+bounces-40964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6E990942
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DC21F214B4
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D31CACCC;
	Fri,  4 Oct 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="MXJ0pgME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA71E379F
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059580; cv=none; b=LJ0LBm848kcyfl08GDowUrHKQc7NtgNzNe2HHiBApRzZZ0DHwlb90BX2DP3/3PxzNTydyUITjGGu7R/rOKgp2W8tEwtvBcs62ytQeUvDFhVw3zkDwi42msXYqETZn3G96Igr3xLIGkrV0I802WrH+2mqddSt10o13G+uUum72lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059580; c=relaxed/simple;
	bh=oQeEOs/Um002STA7msr4mgYH9YTj5H8C6DwAf2eaxE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otVOCXPklf6RU/KrRyFe/YlbpUfUcsesJdWP7XBcTm92A02w4z3XenjfUpC7i27CuOtbt1r2jodyUwHUvwttTi0+YBJimqBziA4lR4waZm0WUqC4bI2qiYxbSwxYAxbQqAqzNKrX5TSTdIomyIS6K6zveMudwqfqLSIhb0krVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=MXJ0pgME; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53995380bb3so2919996e87.1
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1728059577; x=1728664377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQeEOs/Um002STA7msr4mgYH9YTj5H8C6DwAf2eaxE4=;
        b=MXJ0pgMEh0oiif4gJNPNGARqTGZF83ZJavUAUZhPxFXDBiEamSLR56Z1lkCXzMoIHU
         FHzFZXp2imuZRh+tFc0hG3HLcLQCPVavZV/0NmTjlXfdRHxi++GJ+1E5vRtFn8YryBSC
         RpQhZpC5Wsb39OMZd1nr+bck52qKkwQtyLL4SM5bJEPJYeiovRNpwMieA43IkuokFS6v
         HbkRgKxPyy3lvjv6jOOAA4FkFO7jMDSRL2CpWkmR/cCbkrtcALJzdfeG5/EKbWIDrQnV
         NDTsurATxhpoCbp5hGOLGJqD0x8cORmyS8qYPBGg7Q+aGSediR5BHCjeYOiH1JES0xSD
         rBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059577; x=1728664377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQeEOs/Um002STA7msr4mgYH9YTj5H8C6DwAf2eaxE4=;
        b=NXFDqCD5dePNwP4+VeYDR5gFQ+dSU+siWC83RsBpY5wIIX2MqFivT5mgVXuZdp1Tgk
         aNcPqHScHacuhc4EyY73CpgFzGg5nrwuOFYxVpc5w17Xow/BqxgUpVFx9IfJ2Q4l17Zt
         1A2TOxB4Yh2QlssDhKN4CpR+NdLdi9PDq+sSnDVUIpx9BPyJGcdVvYxHCT5b56zthUwk
         wsq9ho4dhJD+s1C9HgDniE/xYXH3I+unXbwrImvOtqsr1QsbWxCyq7y5jD0dYq0u7F1I
         b9a+qyrhuc6ybODydu0G6y2FAk36d4J8+QGAA0HvLEVdyqKRlfDhm43/9V1mHnX1ge6G
         AdsA==
X-Forwarded-Encrypted: i=1; AJvYcCW6wFOQoSiCA8nDvd4SeJyHjVCEclctJsnadtVkpw+VKCDw811O0WuYEaHi7sTW/w41cJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/Up/i142JYUa7XMyhc3IVeYSQs109ppF1+i1mJKCayg0pZM/
	0xmvitkYY4MM38GPRGYIU3Er1dWz9KaKOi4eT9gOhw1mHuVMP+m8qe9uaCX5vRGjD675jObtCiH
	R95lY6TaFZnA7whm1/PjYm+EQmgMG/c7j33PnC8v5P7cPVfcITzs=
X-Google-Smtp-Source: AGHT+IEtPShWB9JDInqHMAub5X4JaWbWy1YJjZ7Eu0VjIngZtqUXhKzfEa8eBj0Bplt5YdecbVKW+M24/gLnGwySoTA=
X-Received: by 2002:a05:6512:281a:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-539ab862484mr2258609e87.7.1728059576874; Fri, 04 Oct 2024
 09:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com>
 <CAADnVQKda-ta8PnqcAcXy92-V0unGbs+5qbquT6-V9F4kpJk5g@mail.gmail.com>
In-Reply-To: <CAADnVQKda-ta8PnqcAcXy92-V0unGbs+5qbquT6-V9F4kpJk5g@mail.gmail.com>
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 4 Oct 2024 09:32:45 -0700
Message-ID: <CAPPBnEaTo0hMi5wPOC8wdg00pE79GYkMfkRnABMaqycf0bJ8CA@mail.gmail.com>
Subject: Re: Possible deadlock in bpf_common_lru_pop_free
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Alexei,

Thanks for the feedback. I have two questions:

1) My understanding is that if the "noinstr" attribute is to be
applied to a given function, any functions that are called within it
must be explicitly marked as "noinstr" or "__always_inline". This
means that marking "bpf_common_lru_pop_free" and
"bpf_common_lru_push_free" as "no instr" would involve marking many
other additional functions (we can count about 30 of them). Would this
be acceptable?

2) Spinner has been finding several more deadlock bugs in ebpf helper
functions. And it is likely to find more as we keep analyzing the ebpf
subsystem. We are wondering how you suggest we report the bugs?
Oftentimes, we are not sure how to best patch the bugs and hence we
prefer to just report the bugs alongside PoCs and lockdep splats. If
it helps, we can batch the bugs that look similar in one report.
Please advise.

Thanks,
Priya

On Sat, Sep 28, 2024 at 3:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Sep 28, 2024 at 4:02=E2=80=AFAM Priya Bala Govindasamy <pgovind2@=
uci.edu> wrote:
> >
> >
> > SEC("kprobe/bpf_lru_pop_free+0x352")
> > int test_prog2(void *ctx){
>
> Instead of resending old issue and/or claiming new bug
> please send a patch that makes these functions "noinstr".

