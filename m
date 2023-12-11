Return-Path: <bpf+bounces-17361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0780BF7D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 03:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BA3280C83
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827E156E2;
	Mon, 11 Dec 2023 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS9eiXzp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21CCE
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 18:56:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33349b3f99aso3725585f8f.0
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702263384; x=1702868184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCasKs1gtBF9db0gzJ3JIU1JoaQ/4U4s8i2ZkTyzVNc=;
        b=lS9eiXzp4hzNgqol33+XkyJ8oAizBQxa8+mevwp3A4hKs9oumsifP082MWx1VM5dPx
         tjnUaBZYt3IDQBnqjHYpYiB/xzOJnb+G7/Y3axWx++Dg/pP54XFVVQfCEiT6vLU1OxOm
         7C9Mfu0C+me9L7aSnophgW+XwCzL7jWv4XWGg6I45KdP7V95Y4xL/ysiAO08EaSuj7UA
         DrElCsXUIB0qzvergBzj5FoZZuoLfqtqcf0rvkvZb/Vzzxcs5NWhOxcPfP14WTHRApcs
         2maytOVU6bSyd5VDo8M8binHw8VUcMhDpU2MBEYWpFqqPNSL/EUageUXiSW1rM2wnJmI
         pm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702263384; x=1702868184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCasKs1gtBF9db0gzJ3JIU1JoaQ/4U4s8i2ZkTyzVNc=;
        b=b6MiKJ5gSLCuLRFVzDVzdm7J4nPoRcGtc8Am35D51p669RdpEsrzUtacI4ygQ1fdRP
         ICQWOzPuIkVpotwGY9a9Gzl13KdxooZByrJzYvrF4yZoSXU+GI7//9A8G7bdc1+HDbuR
         6V0mFz429LoWuRWi4KaKFbWaif5p5+rhYM1i1YgxNc3SfSapJvDXJ3pWqGfTTttHyAG6
         SiXu3LB43lSZQuwmK5RDnfJSYh7ry5pb5HyDx4lbQwfKOGDqcj5I15V/5cTpM/HGlXRU
         w4BYm8tre7ikE2p/IC8+87YGqCdqaJSg0EAXvdWWHMneXO7X0syDR4cQvWQ1wVxCblMb
         6L3A==
X-Gm-Message-State: AOJu0YynApj3bljOkNksIK8HH+Vy0kIZ3SNyrrvArDTmXL/LAuavmG8Z
	MnB5CDygEfu5eC9HBLeXYx9qYoou75JydgW2r0w=
X-Google-Smtp-Source: AGHT+IEzPl8KNfv4Jr8bQWMExi1dwrn+YsI7oU0GPIL6kLDxyMBwBR9+REAEpsbO+DsPEIcpDCdMslnILfV5STQ04iI=
X-Received: by 2002:adf:fe85:0:b0:333:50e2:557a with SMTP id
 l5-20020adffe85000000b0033350e2557amr1782217wrr.89.1702263383511; Sun, 10 Dec
 2023 18:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-8-houtao@huaweicloud.com> <CAADnVQKZfvDQUuzJ98n5Q6a1xU5XBxFGi0PeEnmRxj_TFKoW1A@mail.gmail.com>
 <bcaeae84-766c-5e3c-d444-70015ada7765@huaweicloud.com>
In-Reply-To: <bcaeae84-766c-5e3c-d444-70015ada7765@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 10 Dec 2023 18:56:12 -0800
Message-ID: <CAADnVQKev7805QuyZA1yq_N3Ljg+X5vZqscRpCSHS2NV3AdMgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 6:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Alexei,
>
> On 12/10/2023 10:11 AM, Alexei Starovoitov wrote:
> > On Fri, Dec 8, 2023 at 2:22=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> +       /* Wait for any running non-sleepable and sleepable BPF progra=
ms to
> >> +        * complete, so that userspace, when we return to it, knows th=
at all
> >> +        * programs that could be running use the new map value.
> > which could be forever... and the user space task doing simple map upda=
te
> > will never know why it got stuck in syscall waiting... forever...
> > synchronous waiting for tasks_trace is never an option.
>
> Could you please elaborate the reason why there is dead-lock problem ?
> In my naive understanding, synchronize_rcu_tasks_trace() only waits for
> the end of rcu_read_lock_trace()/rcu_read_unlock_trace(), if there is no
> rcu_read_lock_trace being held, there will be no dead-lock.

I didn't say it's dead-lock. rcu_read_lock_trace() section can last
for a very long time. The user space shouldn't be exposed to such delays.

