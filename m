Return-Path: <bpf+bounces-67771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93DB49831
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4364116924C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2231B13B;
	Mon,  8 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdiYY4mx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D831AF20
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355794; cv=none; b=RhCwzi+rBaLU/siWcMmdOQdH21NsyDuQtAIEwPmCNAQRyWHaqbuBPa28uX1YRJSOVGbQA+/IyCW3OFRb7huXjDMr1xMMG+IHopcqwAzgyUQwO6D6qFc6FM2IriyW0BuHY9XBn6kwmffFaxGFSdHiZWU148D2a4BzKLBD+0f5MG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355794; c=relaxed/simple;
	bh=WZOmG8+a2vJ2JMJAGjMXfdDz/j6ZikrP5L0V9LK4+RM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brXWOZjj406qDuCs/j5wx2Ccu0aD596hvovkZ/lbGIXLSrNg3GBt7ClEa7FQDkHMtygNfA3dvOSIbQ7XOoQNSMh6JvBXhdbtN/2gIo0w7Vd+Ahr+sUXs7cnfJoqQJazQlTCNtpk01Gwm6n4/7Jl8ABrlIPai/fhfjxrnvUwtLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdiYY4mx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cd340377dso28370245ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757355791; x=1757960591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZOmG8+a2vJ2JMJAGjMXfdDz/j6ZikrP5L0V9LK4+RM=;
        b=UdiYY4mxsmCt4MyquIdHmwUGjyg2r086YnAaSxXNCufkSg8KEs9My1jIULcHGGuFvg
         p8kK3xDyfDK3GCpLr6jpwxBVdQJQ89uN+5P1oTSNtefdnm0n/0TpKHlcjzl17TVbFHdT
         cdWL63+LAprSdu1I1vPO/c/dQ0yLHDXdjLFHcti4nC838Bib5zTkky4XbI8d+dWD1nzW
         O8AfLsWL9o2DuH4/Ly9QILAqgZpm/hB92cU6SvbR+zEY0IxgE9aHEWgXzY9vdyCoBIW1
         g1xTm1BRHzHf9yGD4nflKeSfXWMlrPZqzwifAexhFIzbIxBSPJBfPTo65vwd9nKOTGuQ
         LoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355791; x=1757960591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZOmG8+a2vJ2JMJAGjMXfdDz/j6ZikrP5L0V9LK4+RM=;
        b=kQPsZdEN/nEr9Oq/q2UVwY+6ouj9hbCuHKs4HAqQ47VlBHSQDTzCSXFxR026ei3vsL
         lBya/qf0Sac+oixbRtEDwkSRGHF4WMDf6EHQeUH6WrLzjZgAB2xj/0W/L2TeziFEqDyY
         awVgR9cuG7Hi/cPivlGRWfy/GXVO0pxN0m1mO8q+EO/tV62BDdNTOqsMkabXIXoGYCn5
         EYJCFeZt34Go3fBqdEDot7k2CNynqga1VIX6LLkIeVl5eHgcDL4tZAS8lDspjTjMcd5N
         AC/hy6j+1ghTolh1vQAC+ATv2swfVUdg42tsSBJhxfio3y6tQAOLKfehWj+Va8JZE1Zh
         d0fg==
X-Forwarded-Encrypted: i=1; AJvYcCViSI/BdapnKi5N3QypYAax9Wo4OqN8NYwgguHEwJHU2F7I4hP7MftDoSHAgKaPJhtBQ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClYrFkz+w4TVxcu2APN0XRfw11LYSHAM2URKiU0FKcPL5M5sT
	oYG/h5r9rC1LyAyucu61zaQsNRF+xBSRKXVRTsfwB3HMMqKTZIGbU1j+2rdCI8tI
X-Gm-Gg: ASbGncvOEE7hEhjXxX3I2WZRq/QXPrUpEBItcd/gTQ1dP6CdrOmqYRfhmjRppcnHSqZ
	x4ASg0HsCp/FT9g5OMDO5ubHRCr1seMu3xedSC8Bt1WEYIHiYu4x4vW4QgOvbhdtUCmfCkptoST
	nGNFVCRsCHwr9X58IKONU9HH9z6hDJ4ANKWSslbSAGxMG5NmlAlku+a/UrJp5mG8UdjQYivQar1
	+vTgnAr2UjOcRaOVA/2X7g3IhS/RmqXTJwWYVLbOHoTfyaGBIAKxwH+VIHkEMradYe6NmZrMzEH
	UvkYNHiq2PZqTNInbRVr90Dq/wdHXytPg7PyEyeUGtcz+cKf+DbNRxMJyDdwsD2VEd5Jw+dXZDr
	AOptTHFOlpgqnfaCQo+wQ5+wSOxpT5hyHMS5odB25t0DyG9cPlnsAK4F8kw==
X-Google-Smtp-Source: AGHT+IFGOgLIrk0xY5bqQoOX63w8JmUzfboQv1JGpmVOIeX2hG0l7jZeX/9Ujm2Jr24HKyMZ1vbLLg==
X-Received: by 2002:a17:903:2c07:b0:257:3283:b856 with SMTP id d9443c01a7336-2573283bbaemr45840865ad.6.1757355790950;
        Mon, 08 Sep 2025 11:23:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caffd7beesm135177855ad.121.2025.09.08.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:23:10 -0700 (PDT)
Message-ID: <d6e5d817fb1c4d305ba6c43df3935dca578ad6dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 11:23:08 -0700
In-Reply-To: <e42913c0-811c-43bb-a570-9f903529ad91@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
	 <6bc24eca4d2abdec108f2013c2e414e24d48642f.camel@gmail.com>
	 <e42913c0-811c-43bb-a570-9f903529ad91@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 14:21 +0100, Mykyta Yatsenko wrote:
> On 9/8/25 08:43, Eduard Zingerman wrote:
> > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >=20
> > > Introducing selftests that check BPF task work scheduling mechanism.
> > > Validate that verifier does not accepts incorrect calls to
> > > bpf_task_work_schedule kfunc.
> > >=20
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> > The test cases in this patch check functional correctness, but there
> > is no attempt to do some stress testing of the state machine.
> > E.g. how hard/feasible would it be to construct a test that attempts
> > to exercise both branches of the (state =3D=3D BPF_TW_SCHEDULED) in the
> > bpf_task_work_cancel_and_free()?

> Good point, I have stress test, but did not include it in the patches,=
=20
> as it takes longer to run.
> I had to add logs in the kernel code to make sure cancellation/freeing=
=20
> branches are hit.
> https://github.com/kernel-patches/bpf/commit/86408b074ab0a2d290977846c3e9=
9a07443ac604

Ack. I see no harm in having such test run for a couple of seconds on
CI, but up to you.

