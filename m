Return-Path: <bpf+bounces-67839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ECB4A037
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 05:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF64E7C8B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12D27FB18;
	Tue,  9 Sep 2025 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6YhS8RM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C127A925
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389476; cv=none; b=dKBruRlsn1WKVoQYiiB90roGdQGWNQzJ8MmBJaMwhL079p3pjYdzRjP82IubPP9PXdNwfQVAT+7gCOXKzEqP12yyNITjplZV3qpk/LsrAe14f7wsCIiP5jJXuz6+TcFixEtiZ3E2m1mU07ArZME6/A9Wtiz8Rnb/idyggdpgcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389476; c=relaxed/simple;
	bh=11hSOlmTTnQdcbAx505jDRr7PEIFLFeIugSKgTmWXz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl5cnTnVSyRpJr8FzASmHqgOZy/QThcYImQcKtJY7rxmzFQRrHzCMcjRPNVN7F8shMgtR7kBIk+hlRdGR/48t3IA3n9O7DIVWjgcf1HAMzJuzNEbkIYu0gD073flq31ZZjAgM/4LcU4NNbLvPfEBbAsXbDgkbCWbtx46GDTvd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6YhS8RM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724cacc32bso3944499b3a.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757389475; x=1757994275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11hSOlmTTnQdcbAx505jDRr7PEIFLFeIugSKgTmWXz4=;
        b=P6YhS8RM2LTWyzMHbz7AnGCaGemEq5fmB2x8G6hzKCcqnahyssnN86Qv81dBr/hMId
         XWcSX0jP73411hbQhhe++o679m3mU+yLDxTevV/QnGNFF2su6b5/ioiULYz3AUPamjpd
         psb41kiHqzDpitd0urvTTzsueqpOEcB4S2jL8P0zMzOtUvF2pSTH9j+dV5A7LxKzTM4Z
         A0WJtXsYJ0e3q+F8l8MmeFRzQ5sJgJ21zoyd3s6lIekViKrIFpA9v+Oehry99B9+uMxr
         oCQQ7XgOv4ZNuC5DsSrUBNHz+zteISvJiRDpjRwuNhyG1oIKOAZV7oPo2n1mAxeXvf6m
         hpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389475; x=1757994275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11hSOlmTTnQdcbAx505jDRr7PEIFLFeIugSKgTmWXz4=;
        b=Kcv2rj6BRoUWTOuMwX9gLhobyBsevsHDPDt3GKedQ6DIr/e5xLH7jT97J+8NUpMmNV
         zH1Q3BTJG9s35BoJIyocS9Qw/BkZ10xFd3695m7zjgm9SCJU7qilHnSzFDlwYweH/S90
         sAq1x76ZKD0BKapRac+5ISvcTioeKbAX/A5zT7S96eNHqGVUjSCUfLPhHWasDaEuQ1Yc
         grXYW0GbavDMoZhRtsV6PbFzg5QGbTiSORrgQxSojd5vio4H8Pg92UFvhaEPksC7LsmL
         haiC9+KdX//qMgxRcvQ7fJtgndRPV5p+y/i8xnz2ef9AGO8SAyLym8cQrSY5Wx67eiwU
         LFmw==
X-Forwarded-Encrypted: i=1; AJvYcCXp9yZvS67jS9ypKj30ZZQm2SMVkfi8YWvYAdrmqFnQT1fRyGeJmi5ltGEeOiRMUtB8Li8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZjuGRHaQsdVroqHLMB2bF7pTOgaj1aYwDWVtFm/jcj9hmzUQ
	a0MRnpUkybVIHpE47Rzti7Tpn9PIxSgQ2M8xaAvsDBZDGI1fLjfppgKnXWtsXt6DOJF9y5ChD98
	rJ5ztBmX/+7mdTEVIuCxnP4oTWszj98E=
X-Gm-Gg: ASbGncskdF5LmiH4NFWq3DubDTJiAxw1VJDn65OQkFOB601+7B5ie7T8snc4Qaf8ZrZ
	wlJBwNTY6AR2GCTlEbIONcQ3joaSqxtVNQKO2RMDIAx63b7DmKTszgZitJ7ROMXj2CyvqDmt+8N
	XanccYFODifyCD9gmazE9yt3HMN+vgoV6kXFrnPAGrJ+rCF8gDpbGWSX7RBJt9SzhNFQN0DWUkH
	mlsdkeG
X-Google-Smtp-Source: AGHT+IE2iuJGF7AFhsPwY4VKqpW1vSCmUY63GupaZ60HkEmPwsuXnA7OkvXfPlOYU33jevpHSJrZH34TMdYNqUyLAJM=
X-Received: by 2002:a05:6a21:3384:b0:24d:598d:2171 with SMTP id
 adf61e73a8af0-2534547a674mr14452473637.51.1757389474694; Mon, 08 Sep 2025
 20:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com> <6bc24eca4d2abdec108f2013c2e414e24d48642f.camel@gmail.com>
 <e42913c0-811c-43bb-a570-9f903529ad91@gmail.com> <d6e5d817fb1c4d305ba6c43df3935dca578ad6dc.camel@gmail.com>
In-Reply-To: <d6e5d817fb1c4d305ba6c43df3935dca578ad6dc.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Sep 2025 23:44:21 -0400
X-Gm-Features: Ac12FXx3sa9iYjyqIufa0mg4XcxNls2XcUmcs8hyQFbEExbvkAEQSleadZc8Wdo
Message-ID: <CAEf4BzZTHgpajDx6JxLvbF5gZKWi-MpGq7BWuFMNdZpan4uuPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-09-08 at 14:21 +0100, Mykyta Yatsenko wrote:
> > On 9/8/25 08:43, Eduard Zingerman wrote:
> > > On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> > > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >
> > > > Introducing selftests that check BPF task work scheduling mechanism=
.
> > > > Validate that verifier does not accepts incorrect calls to
> > > > bpf_task_work_schedule kfunc.
> > > >
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > ---
> > > The test cases in this patch check functional correctness, but there
> > > is no attempt to do some stress testing of the state machine.
> > > E.g. how hard/feasible would it be to construct a test that attempts
> > > to exercise both branches of the (state =3D=3D BPF_TW_SCHEDULED) in t=
he
> > > bpf_task_work_cancel_and_free()?
>
> > Good point, I have stress test, but did not include it in the patches,
> > as it takes longer to run.
> > I had to add logs in the kernel code to make sure cancellation/freeing
> > branches are hit.
> > https://github.com/kernel-patches/bpf/commit/86408b074ab0a2d290977846c3=
e99a07443ac604
>
> Ack. I see no harm in having such test run for a couple of seconds on
> CI, but up to you.

Well, we generally push back against long running tests. We have tons
of them and maintainers still often run all of the tests locally (and
even with -j parallelization they run sloooowww), so I'd avoid adding
a test that will run for a few seconds hoping to trigger some unlikely
condition.

