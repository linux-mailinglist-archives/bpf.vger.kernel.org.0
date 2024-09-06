Return-Path: <bpf+bounces-39148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078A96F81E
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E252867F7
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528C1D27B6;
	Fri,  6 Sep 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI1l6Nv0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B01D2F48
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636305; cv=none; b=eDmb0hEA2vkUqlmYFjir3HMFw5kTe+53YG/lNwf4PpSTRxIW1QoGfAT5JAz5dIFBZsO1PeRAIJ3EcBMa0exfeVONB8tbnvYlrAU6fwbtvINOPIG2yr929GWgl4ddzj5IjCO61Y0MQ1z/Cg9wwxxvJoq/V75DJI9PHDkXj6IBVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636305; c=relaxed/simple;
	bh=lTbovPwHOrVdacpd5MiODgQSuHsS3g2Tn3IKqB3xpvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSE12wz6CIGZVF5pZ+npMfWwJEKQ5PGduCVgq8r+IXAUSsBv8945ylJ52OrjLEdjq+FQVcTNzEbLWw1K+lHtvSBYq0UdnoH2vl7ozX6ZTnnxzGV8R1XWHsQmh9ogMA4bzbiYQCsxtwAh1gJhaOR42lcsGbXjmLsOJOVTg6s3dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI1l6Nv0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbf138477so18714335e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636302; x=1726241102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTbovPwHOrVdacpd5MiODgQSuHsS3g2Tn3IKqB3xpvY=;
        b=fI1l6Nv03i7zi3v+DGO70/fO9mbjgojLUn3yX+Y0Q47A8QCFnPFZryovJtcBu5Er/p
         GraFFw/QSt55vApPmQSju19lugjpE1YBkCRWFZNnKM2n8tW9uhSP21NDKqhY6DxlL3k5
         KbFPzTkvyUuijmV/y5Q2g7sRaeo+psEGFnVYOOqTHOBtO8cMSgeRLVCjbHAnwSnIcF9F
         u6cVujCAZM/tLSQUV2f4g0NGLLMsJxQD5dgkZXiXN/3GmBt/AAJKgsHuw/sNFryGrYcA
         zifn9eq/P5y9oU7UzD0ViAwU1f1+Is/wGF/c3KaNFFlr0pE3PjLFrEvZF4Z4NrecK9/t
         b9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636302; x=1726241102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTbovPwHOrVdacpd5MiODgQSuHsS3g2Tn3IKqB3xpvY=;
        b=spgh7I/TV2qGaxNoDBgQkjuZMCBlcnmTvsFMEkX+hEGot1J1QcZA4S2cpbquBXzdHk
         Pd+nbENTpyFaxHWl5Eab7jmCE81JkphrysES/pLbz47QKYFmqhigY5otVV5vT3GuxCNa
         M+MD1gbO7I14Ib02jhAK+HfvwkFIU+r1L68ESTCzu+L6q9XoOckT7E2l3wfaRXASzyEn
         f0MaXsRr7ZDr8aok/5yH2M08sDAIGeEOQMLEO6/QfXZQupbYjLKKHzjHjB3uLd0RMkdy
         yaY+awhc5DTFfPDh2CM66Et0VgYZ3ysKHp3ZrFbOMMyPDVvpe5yf8LtAcAnQUqH/qEnB
         kJsA==
X-Forwarded-Encrypted: i=1; AJvYcCV0aHuLhK6ufAfjwLFwjokbwHfRUnSXGTP4lomX7Ce3ZjFaKzhp8DtYXfoU10xvQPba+T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIAC40qymGb86gTuh6+qMXTMcX1iFwMzdzfdqbDBIL+knYQxX
	tInHCukab9ZPoYly77ViRhaH/Y+Umj/VIHYPvkLs+QlOkxqHPRuWvYfwl8AhgIccBV2eQIb9+rj
	4jzSeKhiRye3HhbjjbrXZqbmApks=
X-Google-Smtp-Source: AGHT+IGjJFPzbcdkTf2DI//LIb7vojZdlmxcH6BRDURzg+Qu9TGZTpHgepUhvbk8uJAQp0Y2g/Uo+NWbq7STwOyeK7w=
X-Received: by 2002:a05:600c:45d1:b0:428:f79:1836 with SMTP id
 5b1f17b1804b1-42c9f9d7338mr24292845e9.26.1725636301884; Fri, 06 Sep 2024
 08:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825130943.7738-1-leon.hwang@linux.dev> <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com> <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com> <mb61ped5ysbso.fsf@kernel.org>
 <007b71a8-ccaa-43f4-a24e-903d3ee9cbec@linux.dev>
In-Reply-To: <007b71a8-ccaa-43f4-a24e-903d3ee9cbec@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 08:24:50 -0700
Message-ID: <CAADnVQJcxX=X=MRqg9ToharLAfvMWLVptTU2x9YW6cNt5BsWdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:32=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 2024/9/5 17:13, Puranjay Mohan wrote:
> > Xu Kuohai <xukuohai@huaweicloud.com> writes:
> >
> >> On 8/27/2024 10:23 AM, Leon Hwang wrote:
> >>>
> >>>
> >>> On 26/8/24 22:32, Xu Kuohai wrote:
> >>>> On 8/25/2024 9:09 PM, Leon Hwang wrote:
> >>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the=
 same
> >>>>> issue happens on arm64, too.
> >>>>>
> >>>
> >>> [...]
> >>>
> >>>>
> >>>> This patch makes arm64 jited prologue even more complex. I've posted=
 a
> >>>> series [1]
> >>>> to simplify the arm64 jited prologue/epilogue. I think we can fix th=
is
> >>>> issue based
> >>>> on [1]. I'll give it a try.
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweic=
loud.com/
> >>>>
> >>>
> >>> Your patch series seems great. We can fix it based on it.
> >>>
> >>> Please notify me if you have a successful try.
> >>>
> >>
> >> I think the complexity arises from having to decide whether
> >> to initialize or keep the tail counter value in the prologue.
> >>
> >> To get rid of this complexity, a straightforward idea is to
> >> move the tail call counter initialization to the entry of
> >> bpf world, and in the bpf world, we only increase and check
> >> the tail call counter, never save/restore or set it. The
> >> "entry of the bpf world" here refers to mechanisms like
> >> bpf_prog_run, bpf dispatcher, or bpf trampoline that
> >> allows bpf prog to be invoked from C function.
> >>
> >> Below is a rough POC diff for arm64 that could pass all
> >> of your tests. The tail call counter is held in callee-saved
> >> register x26, and is set to 0 by arch_run_bpf.
> >
> > I like this approach as it removes all the complexity of handling tcc i=
n
>
> I like this approach, too.
>
> > different cases. Can we go ahead with this for arm64 and make
> > arch_run_bpf a weak function and let other architectures override this
> > if they want to use a similar approach to this and if other archs want =
to
> > do something else they can skip implementing arch_run_bpf.
> >
>
> Hi Alexei,
>
> What do you think about this idea?

This was discussed before and no, we're not going to add an extra tcc init
to bpf_prog_run and penalize everybody for this niche case.

