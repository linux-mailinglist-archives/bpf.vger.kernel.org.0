Return-Path: <bpf+bounces-79473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9ED3B499
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 428EC303A16B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656E31B13B;
	Mon, 19 Jan 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSe5tNR0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61491288C20
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842818; cv=none; b=I54GLpjs1rNOofE2M4qQFeC1VuRZRumq1qt5J7CrM3FLlZxTWasPnMCu7xr1fbyAV0cLmFwGZUyBJCqMuu/wQ85B2wmJ0ySGasXOD0J9B9T5G2jgIU5RpytGD2Ff5+J+2plwhyhxvXrVRSfydDGHr4E/NtzzI7rLl4wYXf4lNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842818; c=relaxed/simple;
	bh=JOV96A4HDBY3uzu8QEA2q1ZukB4A2CrDKxZKd9Y5U4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itft2MPwtc4QpTvjrByGB4YUSjWuWmTXPReD/6QtFgbjo80kFxKzZIVeF7uwHDYT0+Y1X+9kz2hgnhHIYIEOGeMBOvv1y90/aFaKP08pzHDnVbjLjxIuXXpDLdy5Nq8HwS/0D7Bhi/+a7rFPY5J8K5T0VIvToTrqm0dTUCRZefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSe5tNR0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2783452f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768842816; x=1769447616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOV96A4HDBY3uzu8QEA2q1ZukB4A2CrDKxZKd9Y5U4g=;
        b=BSe5tNR0+l+kbvlSjT0M0EpZArtMra925I5R7Ao3mp6OVSSXxBn4bYIv0MYQsdmKKW
         UxTGhPLn1/bVNsJCCkson94GHlnMobEIlO5iAkhBFITkM+4Mjmjg9cZ8JlWDSNcxECtr
         BTot3+TqtqftRhggeRSWueA5I+eh3sAC8+4aiNEyHYc3O3fLvBzG/RwF8gYmcAxEId2s
         otHLykij7RXHCer3tTxess7fYD5XEuZK57gaMvIVOFjgklcRZweu92ClUJk8fBK4Q33w
         isWkGyDIXfOCs+PW69DP9Gu3N/g7OL3lQeXf5/NSE9mBeiT9QpBfBBVfbJzS2vnCxfTq
         b8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842816; x=1769447616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOV96A4HDBY3uzu8QEA2q1ZukB4A2CrDKxZKd9Y5U4g=;
        b=F05Icm90FeRDre9G/8+f+NiII+QV2ldHxxkXr855+cJUxOrcOc/OOsIM1bDJVybm+R
         zLOWC8iXlMWZ74Q6TCljPekYR6u3Dk8cqmi2dbg6A07JaKeKEnVkHeZ3dWEaHQh9hhDY
         0i0ibn7yGT7DpGuyjlYK+4WoPhPhAHjiMI98FEBTHIXDK4HvnPVjnSLKV1Mlj66GK1wH
         d49w349myNPnaxX9sALcWUtKk35ES03l4DZ5rbN4FtfvzT2u3BeZFiVOR42FrZn/2EMZ
         DChRx/UpJsGEe2J5riTHw797CYL0PWGvFgF0/7HMlku2vhahh0/3BEY4aMrdO0EMpbhx
         6NYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36rjfLRIR8bdOBlUfhAGLSthvphyMVvM9d45k/nmW63Bmx/oPKwrwgKYkztIAYNr+3CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrgLWaDQTTfXUASLsBYMWsrnTQNsloQlIv9n0dltgf/X2iB5b
	OIO5eUyzd70eUHvUoBshOtqu8UQeEs0Wjl7rgwAjllWJut/Y3QmAcj0XKitF5cfXasDnnyiWrgo
	cZq1xB4PPwCDxOm0uy9QdFTKOfAQI14U=
X-Gm-Gg: AZuq6aIQTaAeMGQ2BfAwmQGZVV9nclzBDLhQYdAwBFopKX/fPpcCKS4yuV8+LVxhRcD
	cjiEvxeOPbkgl5uSdWmwa6JXYpjM69E3biYVG0ROivVr4fhOmQPdx7RYXoeVXsIkwrhEjcX23/t
	qQJcpDjYUF7Joax+dK3eSPBkxTeY1SC5o9Spz7iN9g7F9q2IBhFm3wXJEIJLkqsfPtfnMSmDdcm
	E6EEUmwIKpZd5Id1HTuwxmxZ5HJ/zH2Bb2ymnwZv6n+h5I06hsT1gRAWPwA94Y1RQx/pF8+bbFD
	Jc9RqihXlIGcd8OJMR5pMNkzdXI104Vx9YPzEAJxJXxddLXONcKBGUg=
X-Received: by 2002:a5d:64c4:0:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-4356a026502mr15638297f8f.10.1768842815540; Mon, 19 Jan 2026
 09:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163457.146267-1-alan.maguire@oracle.com>
 <DFPVFON6H9AQ.3BE95ZHQ3ATOL@bootlin.com> <87900b12-c836-4692-ad7d-b1997df806d8@oracle.com>
 <DFSL2DHCSLNU.1640Y190S8S1Q@bootlin.com>
In-Reply-To: <DFSL2DHCSLNU.1640Y190S8S1Q@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 09:13:24 -0800
X-Gm-Features: AZwV_QgBRgdZB7oerwAminwRLvRKlMWhmuOQ99qtTTwUdPfssJu3yWpEbAKhwkM
Message-ID: <CAADnVQKr57j30OqRDU+k6UkAbq47n+OoM_7PiveDfndPRgyfgA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:00=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Alan,
>
> On Fri Jan 16, 2026 at 10:32 AM CET, Alan Maguire wrote:
> > On 16/01/2026 08:30, Alexis Lothor=C3=A9 wrote:
> >> Hello,
> >>
> >> On Thu Jan 15, 2026 at 5:34 PM CET, Alan Maguire wrote:
> >>> If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
> >>> Add a ___local variant to support cases where vxlan is a module.
> >>
> >> Just a naive question: for ebpf selftests, aren't we assuming a
> >> dependency on a "fixed" kernel configuration (ie
> >> tools/testing/selftests/bpf/{config,config.vm,config.<arch}), which
> >> enables most of the features as built-in ?
> >>
> >
> > It's a good question - my take here is that we also need to remember
> > that most folks interactions with BPF happen via distro kernels. Most d=
istros
> > tend to modularize their configs more extensively, and they also want t=
o use
> > the BPF selftests to qualify the particular config combination they hav=
e
> > so that they can be sure that users have a good BPF experience.
> > Often issues arise from this, and distro folks either report or post
> > fixes. This is all good, so if the only cost is a bit more flexibility
> > in the test environment, I'd say it's well worth supporting that. In
> > particular blockers to selftests compilation cause problems for this
> > process.
> >
> > There are of course cases where having a very old toolchain or a highly
> > incompatible configuration that aren't supportable, but in general wher=
e there
> > is low-hanging fruit in making tests a bit more flexible, it's worth do=
ing I
> > think.
>
> With a bit of delay: ok, thanks for your input. To clarify, my point was
> not really about challenging your change but rather that I was not sure
> about the policy here; supporting only the CI selftests configuration,
> VS supporting other kernel configurations like distro configs (at the
> cost of duplicating a bit kernel data strutures definitions).

All development efforts are focusing on selftest/bpf/config only.
We don't pay attention to what distros and hyperscalers enable or disable.
Small patches like this are fine, but they will bit rot
and if they cause issues down the line they will get reverted.

