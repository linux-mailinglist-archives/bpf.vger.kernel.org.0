Return-Path: <bpf+bounces-47861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19BA0116F
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 02:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DC9162A19
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63903A8D0;
	Sat,  4 Jan 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqJLpKw0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C92F36;
	Sat,  4 Jan 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735953077; cv=none; b=Cq7G80y9qepWVj7vrCOrahbAhZcobXsMIBm4Rfk1NXvjginIqbxg9h71vhl2EMbsHCLen7W63zUcU2J/4jv0gYhmwiaPhwcExiM0Ts5xVKtRos74tUdHvN1XfbL8TmbxLHhzV9PBe3LvYdfpquRg6mq4iD/WDVzh/s5cWB0106Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735953077; c=relaxed/simple;
	bh=wmWc/77/LQw1qXjfBth30rSS1ne9bLH3axy43XapDEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4Lua3Bx/dLiZADcvzEQRqHkeFq/8pD4VSlprrOJpk2BTYXJil6dhLo9w5XGgGSpp9Qjg5DKoLcPfjmEcktjUHSGOgI/Kn84Q7o253DrdSmW3UnrTQmKZ3TS82RnyRLlbeFEVcd3Vakbttaie7kYLTWV3CP8/1UCyeNivRWbEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqJLpKw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD42C4CEDE;
	Sat,  4 Jan 2025 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735953077;
	bh=wmWc/77/LQw1qXjfBth30rSS1ne9bLH3axy43XapDEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bqJLpKw07XoGSy1s/RnWX7CW13aqgAa363xnGnoBSlocZfIOAbPgPuqrJI+bWPjQW
	 r0zgnqpg7mr4upZIaDqhkA/jiifoDPu1WcjFVUqcRTppNXhGAuWDISahRigYuELu1Z
	 2gjTGCJLAsjIbff0lG3kIlEXFMj61KAcwZsu1Vj3qPYedJhN8bLyZzcWt9PcspSLvz
	 kpI/71dzbt+JfYR6Qk5WcjjMIjOlR36MUB8vDkQrPYBPthOcrXT4zrPtPPRxDcyQ01
	 ZTg1qGIeohV/aE8iuTiJrWzumtRCXpeoCA/L8fiE8xQXcIR1TJCaykRv5DSHe3qd8E
	 EfoXc5SM6k8Yg==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cddfa9a331so1078135ab.3;
        Fri, 03 Jan 2025 17:11:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURdo8w9CNDfQgr3abuC9DD41nXfazCcPb7CBAnpQR+tHdHQ4/VC+1nKsfk/OqI4CbF7xs=@vger.kernel.org, AJvYcCX6xk4SpTr7uz+Wc8sD423ClRQfILwI0NYI8oGqVBfFBtu/uoi12lE52TdtxGVNrAN3/THaBc7xVpPL2ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrMfU+LC4ijDnyErjt2xhJYGIJ+4o665FS5c1AZPDfMPnCyXC
	JDLebh4+wbusKgpzZd9OPoe4F6RF/Na7PLTEoIQwxIXZVY00jf7TTDsZZJZf2M5Q3Rq3abhkBW5
	6vm7D6iJKWM5CkIq+cBKxIQSxszw=
X-Google-Smtp-Source: AGHT+IGTA5mtmUi1e5ekRsHIG12mFpFa5wf8eXRP6b6qWFlz3OJQR4sTw+SV7jM2yAMOh4Ck6+8eVMdDAjf6weeDmGU=
X-Received: by 2002:a05:6e02:20ca:b0:3a7:86ab:bebe with SMTP id
 e9e14a558f8ab-3c2d514f966mr429152675ab.16.1735953076345; Fri, 03 Jan 2025
 17:11:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Jan 2025 17:11:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
X-Gm-Features: AbW1kvYvND5wrLCJdMk5CZBrLIhjlv6180Ove4rv7MC2kdmdU3zFjiIWHq56MBY
Message-ID: <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vishnu,

On Tue, Dec 31, 2024 at 10:35=E2=80=AFPM Vishnu ks <ksvishnu56@gmail.com> w=
rote:
>
> Dear Community,
>
> I would like to propose a discussion topic regarding the enhancement
> of block layer tracepoints, which could fundamentally transform how
> backup and recovery systems operate on Linux.
>
> Current Scenario:
>
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions

This makes little sense. It is not clear how this works.

> - The system aims to achieve reliable live data replication for block dev=
ices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations

What's the difference between this approach and existing data
replication solutions, such as md/raid?

>
> Potential Impact:
>
> - Transform Linux Backup Systems:
> - Enable true continuous data protection at block level
> - Eliminate backup windows by capturing changes in real-time
> - Reduce recovery point objectives (RPO) to near-zero
> - Allow point-in-time recovery at block granularity
>
> Current Technical Limitations:
>
> - Inconsistent visibility into write operation completion
> - Gaps between write operations and actual data flushes
> - Potential missing instrumentation points

If a tracepoint is missing or misplaced, we can fix it in a patch.

> - Challenges in ensuring data consistency across replicated volumes
>
> Proposed Improvements:
>
> - Additional tracepoints for better write operation visibility
> - Optimal placement of existing tracepoints
> - New instrumentation points for reliable block-level monitoring

Some details in these would help this topic proposal.

Thanks,
Song

