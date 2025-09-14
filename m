Return-Path: <bpf+bounces-68358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EB8B56CF9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 01:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DF23B563C
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732552E613B;
	Sun, 14 Sep 2025 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Nu4zsvdB"
X-Original-To: bpf@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EE2DAFA9
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757893045; cv=none; b=RSJWvJCpIMwTEJF5IocKyvFz0750OvTiimbjeVjN8vs9OiOvV8hL9jzhl/txegrxGt/N+7To2XNV2D/z1VNHGEjVT7SUVWQkjlgQz0GC7szvzCUzrpTv2Z4miqQcIguuqyDGkMv97YV0q4C24mgISnQedhcZp/tKxMMtXfg3DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757893045; c=relaxed/simple;
	bh=odlrz20IXfc9MUnEwi5nRwEYXd3V+Xkv2SYseouBhLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lkyaIv7jadG0k6k/tdp6w866HZSHTYnzejb8AczFDCkGM4AxxB64yGu0IVriOJhByc5+R3hQQ2sDQg10mwuW5vsFzg52d/SdHh0otWLpne6owDtbfuCU2mU7Oncz1masv67/m20pJNGZtQP6cP11ebV6jRfxCFhKKKa38a+36w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Nu4zsvdB; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4173D240101
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 01:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757893036; bh=5xTBfcIgxXN2CX1CLHSz7aQ83atl75CzIOg3qYAIU7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=Nu4zsvdBfdYU3OBXmUfXiAlMIAXTIpKNSYQ+pcZxA2iEjRrS6cjgXj8XS55CFKlrk
	 KO1jdKhOrSSDbNIgJsUgNuLtE3HyYVB360Ht0GMHaZ9zU+BkmZn3UIe55pXVRQ5R89
	 ki8eJ9VS9Y8Yfcvgkw1OhtmJS9B4TUZytXgs0OQYH2IsJps0rBrhc+TX9lJpUYo3kR
	 OKZ8qAAMEXoJOQar+7YQiGID8ye8+8VDM9iPEaCDbww4br+EGRIwm4efNbTjg4znpH
	 3XMjgGW0nNFR2C7HdBnZujtFGAynvJAHX34Q4+L5EKQ5vlJVBWZBzpme/zw5cJGsYI
	 tpCoj+guDKJSA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQ4MB58Twz6tn4;
	Mon, 15 Sep 2025 01:37:10 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com>
Cc: alexei.starovoitov@gmail.com,  andrii@kernel.org,  ast@kernel.org,
  bpf@vger.kernel.org,  daniel@iogearbox.net,  davem@davemloft.net,
  eddyz87@gmail.com,  edumazet@google.com,  haoluo@google.com,
  horms@kernel.org,  jiayuan.chen@linux.dev,  john.fastabend@gmail.com,
  jolsa@kernel.org,  kpsingh@kernel.org,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  martin.lau@linux.dev,  mykolal@fb.com,  netdev@vger.kernel.org,
  pabeni@redhat.com,  sdf@fomichev.me,  shuah@kernel.org,  song@kernel.org,
  syzkaller-bugs@googlegroups.com,  tj@kernel.org,  yangfeng@kylinos.cn,
  yonghong.song@linux.dev
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in corrupted (3)
In-Reply-To: <68bf3893.050a0220.192772.0885.GAE@google.com> (syzbot's message
	of "Mon, 08 Sep 2025 13:12:03 -0700")
References: <68bf3893.050a0220.192772.0885.GAE@google.com>
Date: Sun, 14 Sep 2025 23:37:15 +0000
Message-ID: <87h5x4obbt.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+9767c7ed68b95cfa69e6@syzkaller.appspotmail.com> writes:

> syzbot suspects this issue was fixed by commit:
>
> commit 7f12c33850482521c961c5c15a50ebe9b9a88d1e
> Author: Charalampos Mitrodimas <charmitro@posteo.net>
> Date:   Wed Jun 11 17:20:43 2025 +0000
>
>     net, bpf: Fix RCU usage in task_cls_state() for BPF programs
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13745562580000
> start commit:   079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
> dashboard link: https://syzkaller.appspot.com/bug?extid=9767c7ed68b95cfa69e6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114915f4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15566170580000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

Correct, also did test-run to make sure.

#syz fix: net, bpf: Fix RCU usage in task_cls_state() for BPF programs

C. Mitrodimas

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

