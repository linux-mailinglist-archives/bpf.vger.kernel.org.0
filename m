Return-Path: <bpf+bounces-31480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286EF8FDD98
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 05:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4981C28794B
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 03:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D571EB35;
	Thu,  6 Jun 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/0bKOk/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385010A11
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645549; cv=none; b=c4bgUjbXHdiHqFBOWnlHkiLFMaZG5Cl/UoAB6AbSabAlERlbC/EyMC73McxfwmynYmDwHbEZxXU/t1lW6ADCs4DOaDmXpyeedEDTXb+VL6d48LcdPw9zzTsKY3WqXVpCsd8s9U44j2x+LID/5wSwPsykfCl3p1GT6QJH2ULDtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645549; c=relaxed/simple;
	bh=Tlfzz/YOnKJBcUfNXNUU010823ruNHVILhDbWb/Z6OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9F3Ft6d7Ydsx6Zi2fUaZHIDv7yXyM8LBIyOjX6z/olESRSYWS1kJ+YYlRdUch+LGc+CTSDjEhd4xr+jd+NgVb7Cr2ZsUO5AP04n5v7wzSyrWxEeIFtuEGmZGY33hmqxOqOvbAftHP0rhaBnosqV+Dz59b87naR9W1ucdNpb884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/0bKOk/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42148c0cb1aso6570095e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717645546; x=1718250346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlfzz/YOnKJBcUfNXNUU010823ruNHVILhDbWb/Z6OI=;
        b=J/0bKOk/aDweb7K/WWDZmpWYQPqL4Ss5Fwsdtfqt+dWjTJq8z2PPxY+yBS+KuGCq06
         eQmm61yrr8DB/w9FtINARr5f0y1pewnfr5Yh5YsE5BV2Vz4Uo3kYCQZJpiml0cBdNOy3
         lUyNfugw5nllXySTHXDQjhMgH4uw3sIWaonm1f6ZLvbUmOtx56YgHS+CN8olHUoeREpC
         1DWvNecJ8RfsLFE3hj1gX2s9dwgo+KCyS8MlHfMJ0xmlKILP9CqvsMpCwPwQMOse3TsA
         UVeOvNH3SCU8xWyMFBakiB6lyJxF1RoA82BHjgkX+uqqVQryM0rfDxZMsp9wF4K/vlx4
         muCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717645546; x=1718250346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlfzz/YOnKJBcUfNXNUU010823ruNHVILhDbWb/Z6OI=;
        b=IqRwSRFPvx4z+TPF33vgTTq6/ywdo2ez/KPn2j3ZrDx3SlmOS/rarOjMPiXYN+kZAs
         S0rb3spfPvR2GKucT9okbdxSGTWmLnJgCvgVvd7oOAuw2+lNPfOxvtNoUtmkvyOw0guI
         yvAsQL3y3YIalIUM5r5k1xJieTzyO5t+7sYTudX0GPDrfbSyp8ARR/i6TWoR7xyWmEYz
         sHykXeDADv9X0XWMtafWJrfHXEKg+APM+631DOeNyGCzr8JeQ6bA8gPRdZpppx5BBCuQ
         quhFkp9Gh9CYBcOdHUUJLDuE0+5WOuEs2vGgRl0sad+eL/qud6abIiyJHU7lRBs7rLRK
         NR5w==
X-Gm-Message-State: AOJu0YyYejdnKEt1qIld9jqrTmFz4AtxtPl/8mdjBZx7zBvXZcC0sTw+
	36iRf5i/tHnHr8D8Ctmgd6MrfHCKtfSVOYoRHHuNwwhSoI0uhaGerMxrRk6hbObK3JZrS3dP5cA
	h4U18RXhJFiD/EUx+jp8x/9y9V+Y=
X-Google-Smtp-Source: AGHT+IHsOb8Ln3ziHUPRbLmHqFdXkKIV1EFCPD2+YJGngfuS5gGj0KTo1aU4C9liuL98bvr7a0Dti666r8Lig2BRq5A=
X-Received: by 2002:a5d:59a6:0:b0:354:f550:8363 with SMTP id
 ffacd0b85a97d-35e8833a4e0mr3895011f8f.34.1717645545959; Wed, 05 Jun 2024
 20:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
 <20220917153125.2001645-7-houtao@huaweicloud.com> <CAADnVQ+0eTwL_iJo8Y79GHB-8zAgNCV7Ka9Mza1b+8ENOShBvw@mail.gmail.com>
 <3a21310f-e5ec-c9fb-86a8-6eeecb0b6975@huaweicloud.com>
In-Reply-To: <3a21310f-e5ec-c9fb-86a8-6eeecb0b6975@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jun 2024 20:45:34 -0700
Message-ID: <CAADnVQK0U8pdW0NAno5fS7RYpZcPDWxNHXYaunw4foP9JFLZnQ@mail.gmail.com>
Subject: Re: qp-trie? Re: [PATCH bpf-next 06/10] bpf: Add support for qp-trie map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, 
	KP Singh <kpsingh@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer <oss@lmb.io>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi Alexei,
>
> On 6/5/2024 9:48 PM, Alexei Starovoitov wrote:
> > Hi Hou,
> >
> > Are you still working on qp-trie ?
> > All prerequisites (like bpf_mem_alloc support) have landed.
> > Anything keeping you from respinning this set?
>
> Sorry, it is paused due to my limited time for bpf subsystem recently.
> During the limited time for bpf subsystem, I am still trying to resolve
> the huge memory usage for global bpf_mem_alloc. The problem can be
> demonstrated by using the bpf_ma benchmark [1] and it happens as follows:

that was the issue with per-cpu only, no?

> (1) there are intensive allocation/free calls for global bpf_mem_alloc
> in one period on a specific CPU
> (2) there is not any call afterwards on this CPU
> (3) these two RCU callbacks in bpf memory allocator end, and it will not
> be called anymore, because there is not unit_free()/unit_free_rcu() call
> on the CPU
> (4) but there will be many objects in free_by_rcu and free_by_rcu_ttrace
> which are not freed.

I don't quite see how that can happen.

> I am working on a patch-set which tries to resolve the problem by the
> following two methods:
> (1) track the active refcount of global bpf memory allocator hold by bpf
> programs and bpf maps and invoke a new bpf_mem_alloc_flush() API to
> flush freeable objects in these lists when the active refcount goes down
> as zero.
> (2) try to call call_rcu_tasks_trace() nested if there are freeable
> objects in the free_by_rcu_ttrace, because bpf_mem_alloc_flush may leave
> these freeable objects due to concurrency with __free_by_rcu().

I feel you're seeing something else related to long delays
in rcu_tasks_trace GP or weirdness with per-cpu alloc.

> I hope the RFC patch-set for global bpf memory allocator will be posted
> before next week. After that, I will try to continue my work on qp-trie.

Anyway, at the last LPC there was a discussion to generalize
all of bpf_ma logic and make it part of slab.
So I suggest we hold on to any further changes to bpf_ma.

Please prioritize qp-trie. It's more urgent.
At LPC multiple folks requested a good data structure to store
variable length objects.

