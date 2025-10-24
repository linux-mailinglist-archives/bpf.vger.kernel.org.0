Return-Path: <bpf+bounces-72124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE81C073AE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C2B1C26BC3
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E0271468;
	Fri, 24 Oct 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYF0a2j3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FF22541B
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322518; cv=none; b=TkQ3ewOR4kdUKJwwOLmJkqsC76AI6AYHjW/vvp+1fVD6RjJT9ZCWKcTAGyiVwx0yY1p4yCUyX/1+GMhYyH/SU9Tl8HsdBNsc0GNB3CVF0mm0Igcrk4DVjqs0LFTAABcvKcTUKOyR+XuifNSkRL7hSCVhuA2JRwYgi1DI2FgU4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322518; c=relaxed/simple;
	bh=t2xB5w2D/C9kbb7Bzl1tMo0JOvGXNQKckLTMhZRtTuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz+hhGXgJSgWdgMmRGAyoMzL8YyvFaw2yfzmxdH5YEifTxHL4qOpDrk+TkfM6KnQmZDbysPg5DqUP2IQef+VOnFX/HH9wcGS8QPttO+LwdKvkVM5uCupFeHzdfSPCWBU4PRNETwOaI3CMs4GK+a/mNDoZ/RI+B+SZa7RqT+x4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYF0a2j3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1140352f8f.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322515; x=1761927315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX2wgXyhOFI2HLBtCIVzdgo/PaSKpitLRDyKKLcKuCo=;
        b=cYF0a2j3+66lD8a9BZLpc03nLS8aOpIBqYGLHawJBswQzU875AvKVqifFqJo52QnBB
         bj+aJMyjWhwIwGZ1HjsdecgUePoRwpp+H8SMqv8tgQBewNcTKZqFkX+67XLN0qv/elvB
         fETsS9EJEHpfJEuLATxaT082lpkTS3bVZZsxqBa6jXboajU9xkSbSobgIDs17DwWAr0P
         lORGwN9T0kp3LhQ+50prP7eRnC1IEtQwJzSz32tTpa6ezlDuqIwqvOZrDCheFsSsF24B
         9G6t+VdLCAgDMFf+EnkWoic0TWJovp77Md8ke50V72nmtAOywCz4Is2Zphu0E9FDrxt5
         acCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322515; x=1761927315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX2wgXyhOFI2HLBtCIVzdgo/PaSKpitLRDyKKLcKuCo=;
        b=l+If0NNoEDcNLhaAHNEIZEmg+QJI61YfeJJCdfN/7k7bZh7XURu7fvEUaVsoreEAc1
         aG2TU7/YDokaliLCg8zFxDdAR+UkBEtJDe0xDJkmw5ICYzdvjqEHcZNPgeJP4w45DWqX
         bUc7V7qmdkEHTHF8eT5C0jR/0u6CMrSpNob/l//fg+81UtSKGqgLf+lajGHEPJFsC+DR
         pXvCSmxsnfKHWJQZPPFzJuYr3k//8HXkDfq7u9q6FYFGP6+CN8ecdP5nqLE0Y4vlcM2k
         dn7X9JpZF/5KrBdSu273SnswGEmMeqZA1l/xcMtgE1ufeDHSlsp1ERz62HH0F/VFcv37
         IxaA==
X-Forwarded-Encrypted: i=1; AJvYcCWMeoPyU0JYF0QynYm32EGW4n4TdPOAg0KaQQq4nodwNvKFiY7cZjk5Rvl9klKCdJS3yLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/s5wQlis+M0GelYHEKgCAI7rlzhLOJIHBWa8kGN+E2dZpvEPT
	K1lxo4GLj+1KOfsiCYl3Ps70YcMyvCRKEswFieKcxjB1Mlax0LbBLt9xkWe9duYPMyNv55w6QVE
	ewTLMuytwC6diSaQJzDMg4loLenujkKc=
X-Gm-Gg: ASbGncuZPBmYtaoan30piY/ZhYufqsAORjBH2C0o2DfB3386wRmIeR2cD5Gl7G7C065
	WO0q9Wb25pDnP4cHHRpnx+1PCpUD4+GUjn99AmesHH8Z/prY88htghxgjA9AoE/oa9OvXgvultH
	vIpO+v3u6i95W8Pa8IuIBhcaMGy7cVrOSR8RrpM1uy1zOV9TP3GsnU0eliTG0FDOTj8adyiXaME
	Js+IDlt2aAJA7fovmgA/eXvoL81fG/SdW7jE/4xq3WeXOmRT0MIW+sm2jfe6GgurZd/EGphxyue
	BCLOEOxenGYf5JYX2w==
X-Google-Smtp-Source: AGHT+IHYhQieymijbR97ThEWtTUuWIeWwcW7dASpktkOfhyJVrh56p292orZ26GtXJFfL041HGk3fWOBdTQaTUxeamY=
X-Received: by 2002:a05:6000:2008:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-42704d9895amr20799373f8f.29.1761322514888; Fri, 24 Oct 2025
 09:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
 <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com> <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
 <CAADnVQJ6zKbThz8B5bqBpwz=gyqeindZb1kwCmM90PsR4-7iQQ@mail.gmail.com> <DDQCVG55KXN7.3P6MCQTNID8K9@bootlin.com>
In-Reply-To: <DDQCVG55KXN7.3P6MCQTNID8K9@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:15:02 -0700
X-Gm-Features: AWmQ_bmLtVyHMC53pSRSYOJH_a_wCczVDxu-UPW_QXlFnFx1oBh0bRcOV9rTc7Q
Message-ID: <CAADnVQKQRCC8KJZewRsakDYsFmGZBYuEVYV6xEL2X1Kg06+AYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:58=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Alexei,
>
> On Wed Oct 22, 2025 at 6:44 PM CEST, Alexei Starovoitov wrote:
> > On Wed, Oct 22, 2025 at 12:52=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
> >> A note about test duration:
> >> the overall test duration, in my setup (x86 qemu-based setup, running =
on
> >> x86), is around 13s. Reviews on similar series ([1]) shows that such a
> >> duration is not really desirable for CI integration. I checked how to
> >> reduce it, and it appears that most of it is due to the fact that for =
each
> >> subtest, we verify that if we insert bpf encapsulation (egress) progra=
m,
> >> and nothing on server side, we properly fail to connect client to serv=
er.
> >> This test then relies on timeout connection,  and I already reduced it=
 as
> >> much as possible, but I guess going below the current value (500ms) wi=
ll
> >> just start to make the whole test flaky.
> >>
> >> I took this "check connection failure" from the original script, and k=
ind
> >> of like it for its capacity to detect false negatives, but should I
> >> eventually get rid of it ?
> >
> > I vote to get rid of it.
> > I'd rather have test_progs that are quick enough to execute for CI and
> > for all developers then more in depth coverage for the corner case.
>
> ACK. I' ll get rid of it. For the record, I drop down to ~3s in my testin=
g
> setup instead of ~13s when removing this "ensure connection failure test"=
.

Good. 3s is fine.

> > Note that for the verifier range test we randomize the test coverage,
> > since the whole permutation takes hours to run. Instead we randomly
> > pick a couple tests and run only those. Since CI runs for every patch
> > the overall coverage is good enough.
> > Would something like that possible here ? and in the other xsk test?
>
> I see that test_verifier takes some "to" and "from" indexes, selecting th=
e
> range of tests that we are able to run. Is this the mechanism you are
> referring to ? (and if so, I guess the rand part is handled by the CI
> runner ?)

I'm talking about SLOW_TESTS=3D1 in reg_bounds.c

