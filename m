Return-Path: <bpf+bounces-70571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4EBC347B
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 06:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C56F14E94CE
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DF2BE646;
	Wed,  8 Oct 2025 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfuGdehp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE72BE7B8
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759896640; cv=none; b=r6UJyQ0s6P3Zou6dmLlZr1icSD63WsMU51KI56Y8Rj4Bfo5Ya5gMnHtM+KzHbRbUkxl/xbyj/RyA29BDjnf8tTlyF9hc5a6O0nQsW2uz4PjEA59PXZ7HarTJimaEkUbZ6emdNiXe9oFdZnkpWU7OQ7OtF8+ToJhw3oFYd5t4CHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759896640; c=relaxed/simple;
	bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnqHXKCjKYceVYMgUG6endi+KJVoDxAw+mo4VTZDRp9fl1EgdUB+b5bNinuYbLdZrA+d0ckxEgx6i+Ysn7LF1Uqvmbxfh5aUYdHErkMe38DQN+SdsR3Ansafc/0tOgpi3BuLSuyrsz2NrcbxAvATeEL3kzOBuv75HNVYTWpMgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfuGdehp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1505644f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759896637; x=1760501437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
        b=AfuGdehpws8psHDrxjZiAT5/r9OcqLXrTk4VEW5ru2d0xrcL45TSgJoiWjkR+6MJ5g
         haxSIicFpoCjIqdLfDaTA4kduBhaltToSSUFgw4AgBQC/C+bjahqW1DrFpWmPFSJqu67
         qxoXepTbQAbnaQS+7vxJeGBaIqieixnJrHbWLiodTFypiJSXz6UhbbQTJZhOkTTG5b6T
         I8uLUVICXLqsr6GLNB9bRt6EIhZNHnxBEDss5QFfHTi3mNKFyqh7FMBuhxkmfZSbwQS3
         Bd8KruVFfgqGT28dD6DFBFy6ZPvqCT0iUuP96KHuzblKZfzL4MGwAuu6/orGSr0voCdL
         TopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759896637; x=1760501437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4kMP+g5RiEZcnhoRkeve+Z9tYSilH0RKGWoeHvR8Vo=;
        b=SdJFUMjQKsv+YaMpTSwFdUeTIs2PmSCQIPl5dqJ4T0Pu8ebc7vBLRURo1M2AaQtheZ
         3+8h5SCX9sFWzbH0L9mmBP0XooZ7B00jC0szW1SpaK8dfM9ea5skkdyIi8Z9exUq+n9A
         hvH/+0tO2Wible0U14Up0ijzHmszix1sp41cLeqZ6IoWku06D4D449VXEDf5KtcJEMsz
         7/Yw2cq4ovDBsqgFpDICfWNfZeQV3giTy9uiym9OVhN2QjYKSKSKDcfCVXArMMO12XP7
         FNex0li3kKx48m0tP5qycusYe7YyLqhMFyzLmrXT4M5RZf8qvuLw6pyGT6rl61+0w1PR
         pGDg==
X-Forwarded-Encrypted: i=1; AJvYcCUCiX4fF7FuLBozvLZErQLN2ihpbvxydBTjguBJDXHbXKoBg5Z2Wk4Gd1AN52RmtFxUjno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SAYHX136m+8DeLAIkxDbvNv1wcRN7lKULbE3wPkM/laogo/L
	0nhT/Njyf5cPD9k8yKRDyWEY2xhM6qphtJ8sRDi4mdwSM1FYKobReCWcbM363jo6bFVZ+zSgpTe
	ephJF+uG5RQZVRcpVFT6fNQ78e+CIojQ=
X-Gm-Gg: ASbGncvbFkTBDfZNoYoJ74rMtMgwPmYRNiJYVmMaKS2n24r8uFHzlprbxlzjALwU8px
	zUB7Y4HnIJhqzWJa2qWSblsFWYd7rMw3/lKEBOecOHqs9mSK0Ud6bvubQzGHxIoZ6GCvT0QQgob
	IUYL2E4ujlFmk/iVZ4IiX+euEia4uBbGNry9mEHuS72G+P5zGQJ6je3CvRo1Oel+gwuDGJ1wnxL
	96fGrSw7coFqyh4CfR2eg8IV103NZ6ipCCQdHeNEoJoeM7Gu1opff0HKXOobBT7zaENwGwH1nE=
X-Google-Smtp-Source: AGHT+IEbTF1Padja2a5VYTPxu9e01sfQgU7xUDhedDQcSi45ZcqbFc2By50SOlGmeATDd+z0rHt0ZHSn8owfVsEk02s=
X-Received: by 2002:a5d:588b:0:b0:425:7f10:ada7 with SMTP id
 ffacd0b85a97d-42667458124mr907732f8f.20.1759896636654; Tue, 07 Oct 2025
 21:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
 <CAADnVQ+S590wKn0rdaDAHk=txQenXn6KyfhSZ3ks6vJA3nKrNg@mail.gmail.com> <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
In-Reply-To: <CALOAHbBcU1m=2siwZn10MWYyNt15Y=3HwSGi7+t-YPWf0n=VRg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Oct 2025 21:10:25 -0700
X-Gm-Features: AS18NWAHpHX-o2MgG3uRPCIrdO8_WsGJ2z7_dnabrBdSIRdjp2sl6QIslommR8o
Message-ID: <CAADnVQKzW0wuN3NfgCSqQKVqAVRdKVEYMyJg+SpH0ENKH6fnMA@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Oct 8, 2025 at 11:25=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 7, 2025 at 1:47=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > > has shown that multiple attachments often introduce conflicts. This i=
s
> > > precisely why system administrators prefer to manage BPF programs wit=
h
> > > a single manager=E2=80=94to avoid undefined behaviors from competing =
programs.
> >
> > I don't believe this a single bit.
>
> You should spend some time seeing how users are actually applying BPF
> in practice. Some information for you :
>
> https://github.com/bpfman/bpfman
> https://github.com/DataDog/ebpf-manager
> https://github.com/ccfos/huatuo

By seeing the above you learned the wrong lesson.
These orchestrators and many others were created because
we made mistakes in the kernel by not scoping the progs enough.
XDP is a prime example. It allows one program per netdev.
This was a massive mistake which we're still trying to fix.

> > hid-bpf initially went with fmod_ret approach, deleted the whole thing
> > and redesigned it with _scoped_ struct-ops.
>
> I see little value in embedding a bpf_thp_struct_ops into the
> task_struct. The benefits don't appear to justify the added
> complexity.

huh? where did I say that struct-ops should be embedded in task_struct ?

