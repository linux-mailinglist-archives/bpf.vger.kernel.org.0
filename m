Return-Path: <bpf+bounces-51640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B3A36BD0
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966251722B7
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A051624D7;
	Sat, 15 Feb 2025 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1OEVuqP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66E155342;
	Sat, 15 Feb 2025 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591520; cv=none; b=NuShYfUfKhNkwq09pCPIwiaVTrkrMziCFcPQFAdLkeIUT91SlgpWHCddXa4UHFCOMeCzSF1F0iceqtpmR4V39rQz5hJ12QX44WnSSfMh+KioPERuBB/D9TZ+j1tSG5Qv4zWT8yGa/V8I4SS8UFCfPHb0d/Amjb/02BlOAaiKmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591520; c=relaxed/simple;
	bh=mlcNOIs+dZN9DRElT8sGeL53z0iBU1oTT26uV690M9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiPWmcDWUd9REdWHb2w3d/VRwJ1WaUHOMCuC68je+8y/bwDqVctpCMC9QgPmV67Av8uBYlBrSk4FyYocozMATvRNhIDtm3D70ZORGcb6YZbdIBzMK5Z50P+nmpp5J5Qsgt6X0D0TXBEBJWj64Ayt/uqtR3JioZPX9LtU+JCFRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1OEVuqP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2f391864so659922f8f.3;
        Fri, 14 Feb 2025 19:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739591517; x=1740196317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwvbnj43hXMCzZoeyYyLHDFKL4f34XBdxrleoRPOceE=;
        b=c1OEVuqPo8miaqjj53tklHt5J5wFrDfKklTLF4KdKlfIY3yv3xMAKjozEKCZlL+jPO
         pgE/nhQWrXov2uiWz73jUocwOXEdDtSxiS15vaX6P+/BrEtVrj4r5Yf+u3u5Y7AHdJNK
         HNkQno0oAshMknMwBsftgP60CBQnLuBGfX1h/RNDmQ603wyYYuIfZp7TdZzu1RQDtd82
         9fjALmUsN2E10ApJTC3uB2Xnu1dm60NV0H/HbJxDZ+MqKNkpzjULhf4pu0AsdI+3j5ha
         Y1mwLT/nMpumcOM+xnbanwhBeOZU2zL8pM6yMjQZTw27qHDQJbEGZyE3QRug/BRSDdqr
         z1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739591517; x=1740196317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bwvbnj43hXMCzZoeyYyLHDFKL4f34XBdxrleoRPOceE=;
        b=kJTdsf8sHl7L9O0urRrCGG+nJfEr52eXQ6x/PkShUw6cciWlpCMoi5Q1sZI/AURmWR
         4a1Y1fXsVxFyd87a3nBLy0Mpwn2cHbNy1EXO/TTQcL8OOqgyjLtCO459ldPa7YFz4Ff3
         D8vuoTvwbbCrXc5L8UDzwbMBvGHTDWJLyaWoTttlHiCL5BjrY/ZwmklUse9KGIe8vZ6R
         i3LmJ/vbaFKMcJCyGUyPqenc9/+aEN5Yf0P4T+tCze4Rkb7ZaqJdHi06tIhqX0Os1vOa
         58/6zTYy8xxD15DEFgyt67OW5HOfO69P42WX2oHhaf7GqWdvJcoXAnZE7ezDTxsGUcvW
         I/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUHtLF4NPIKua6u68nezuYrF9+xvqxF3p9hKIOLmrgKueeJ1CQcwAAqeQqQSOpXU2yM2YUAkXmUGUyEsmUb@vger.kernel.org, AJvYcCWB+ZUECWFeNNWOM8kDy7ngyhtC6BFESSWu7e4LOsQDtzR4YNri2IuWgOnTOlQLgrM2GjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyiiYShLgrKyVt31HMcQo20btrwvZB3zJbF62w3BOfptxKfR3
	nZWHHVr7fNXVLEDcuGli+SThhjVSw90sCmu+X1ihnRB43VNbV5GzAjT8hK9r2VotOcDDAZ/L0rZ
	gzrK6sAfrafkQ/wini1X+nvAxFSM=
X-Gm-Gg: ASbGncuOfQgTDJgadfvS2Cv0JSBBa+n4tW/LG+j7G2PsPwKDikz1Z/rNrfSs/6R5vTc
	aeXpNh5Gz6FJ4Sckq6fjf3/asRa2JRC7V63pTyYSkbATpJs+36w7D9eVDiyJseibivqpOx0Vn
X-Google-Smtp-Source: AGHT+IFc2bszlu0C/P+m+eGxhO4AALE8J+M24qkzYMsGmJ+6Pz7hBP+bX0ClOmPyAID/pQid9mX19WQnm8ZDqviKLA8=
X-Received: by 2002:a05:6000:1a8e:b0:38f:260f:b319 with SMTP id
 ffacd0b85a97d-38f33f533edmr1881871f8f.44.1739591516927; Fri, 14 Feb 2025
 19:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084851.150169-1-changwoo@igalia.com> <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
 <4fd39e4b-f2dc-4b7d-a3be-ec3eae8d592a@igalia.com>
In-Reply-To: <4fd39e4b-f2dc-4b7d-a3be-ec3eae8d592a@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 19:51:46 -0800
X-Gm-Features: AWEUYZnOP4SfeEve9Zm1_p2oKymjPO8z3rpWArCkMSzGXnMfvPWsvt2N8jKlv-o
Message-ID: <CAADnVQL5dt7_S-zFSh-ps7uPfL2ofYs0vo1fFuFBwiz0=DV2Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:24=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Hello Alexei,
>
> Thank you for the comments! I reordered your comments for ease of
> explanation.
>
> On 25. 2. 14. 02:45, Alexei Starovoitov wrote:
> > On Wed, Feb 12, 2025 at 12:49=E2=80=AFAM Changwoo Min <changwoo@igalia.=
com> wrote:
>
> > The commit log is too terse to understand what exactly is going on.
> > Pls share the call stack. What is the allocation size?
> > How many do you do in a sequence?
>
> The symptom is that an scx scheduler (scx_lavd) fails to load on
> an ARM64 platform on its first try. The second try succeeds. In
> the failure case, the kernel spits the following messages:
>
> [   27.431380] sched_ext: BPF scheduler "lavd" disabled (runtime error)
> [   27.431396] sched_ext: lavd: ops.init() failed (-12)
> [   27.431401]    scx_ops_enable.isra.0+0x838/0xe48
> [   27.431413]    bpf_scx_reg+0x18/0x30
> [   27.431418]    bpf_struct_ops_link_create+0x144/0x1a0
> [   27.431427]    __sys_bpf+0x1560/0x1f98
> [   27.431433]    __arm64_sys_bpf+0x2c/0x80
> [   27.431439]    do_el0_svc+0x74/0x120
> [   27.431446]    el0_svc+0x80/0xb0
> [   27.431454]    el0t_64_sync_handler+0x120/0x138
> [   27.431460]    el0t_64_sync+0x174/0x178
>
> The ops.init() failed because the 5th bpf_cpumask_create() calls
> failed during the initialization of the BPF scheduler. The exact
> point where bpf_cpumask_create() failed is here [1]. That scx
> scheduler allocates 5 CPU masks to aid its scheduling decision.

...

> In this particular scenario, the IRQ is not disabled. I just

since irq-s are not disabled the unit_alloc() should have done:
        if (cnt < c->low_watermark)
                irq_work_raise(c);

and alloc_bulk() should have started executing after the first
calloc_cpumask(&active_cpumask);
to refill it from 3 to 64.

What is sizeof(struct bpf_cpumask) in your system?

Something doesn't add up. irq_work_queue() should be
instant when irq-s are not disabled.
This is not IRQ_WORK_LAZY.
Are you running PREEMPT_RT ?
That would be the only explanation.

