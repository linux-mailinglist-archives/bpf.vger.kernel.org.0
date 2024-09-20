Return-Path: <bpf+bounces-40128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE497D4B2
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917B41F24BE1
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395E152196;
	Fri, 20 Sep 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBPd6Q+F"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0514EC7D
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831143; cv=none; b=ppH0Th+PE1sipWearMiS2Q008Qyx5Xwy5a0GBX0Wth3v42D1FRZrobsTwWdACrJnLSHunLIfolCAlt4NZVrZdS9QfmIz5siOEYBxKtGXorrGfOR7l+PDddzojxPL8X5b0obGjKT6jvu9XigP6GnhnXLolrek4JkVkNoVOwOqlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831143; c=relaxed/simple;
	bh=YmmdShIqKaT2yeZj5698K3XwhwhdWq1wQAnhjNAgSoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d//fSyPXot6ci1jtVo5vApl+IXYGStWZUGLE38V2FexpxWQMW2eJasFoSffnx4yB7sC90pw8+GhFIquxyTH4xHyfzRC9N7EviQucbIULjW+83DNpj+ctvg5bmxgNbvu8H6jfm7r2ZHGZDMJJJTC+ZCmlU8/PkklLLxZ8cgl4d4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBPd6Q+F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726831139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxgxgQuUGZxly+q+gkXNqzmcxuR4gi3wEXVTHNlpL88=;
	b=aBPd6Q+Fa2lUg5KThfL/Gj6/g1Dmn+s2pTHbGxN37fPjP94P3jFqAsy3oTsyWWIAYYw24W
	Wtr/xrSkZe3MPKYMBR280r6HEmRHbMnkuOI0eLO47eqWDdBhX4AVvrN5+5PcqxpQ5oyHnY
	TICnbL1JI0eBNumJx0bhv4Tayddc3ts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-yylsMWxuOSm7HtaT6HG96w-1; Fri, 20 Sep 2024 07:18:58 -0400
X-MC-Unique: yylsMWxuOSm7HtaT6HG96w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cbadcbb6eso14701845e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726831137; x=1727435937;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxgxgQuUGZxly+q+gkXNqzmcxuR4gi3wEXVTHNlpL88=;
        b=Pl4kLTW5hgmfK+ivIIBjReMufUrYBTg6eg40snVbT30d9Tlj7/Xw6VznJCstjTWHDv
         Cxn8+wVGeMEIO3gcgLHHk1ZcDCn7vDe4AovTGsi3ccGRoEh1mH+9SeMYaJaZ4UkOGtRF
         hRiZRxRZkxv/XUVjAdso35EONlhmmX0l5qEK7mQOluGvuh6fShD7qSZaXSpaelaPnL/T
         Kq+NlkLslq/bKadWH1WP27W77aZG6YYGAyO5I1cSu0VE2VjRWCbsH3sXmG4hFfzaOKhr
         /Wwq5bZIqtT4+aUhk2FZa55C8eVtlP1HJi1YW0Kq7Km2RKGnzGxULjirHwdzsx8hdAJz
         jnKw==
X-Forwarded-Encrypted: i=1; AJvYcCUlO+inecmz9BsYx+9Uwf9FYilurVON88cJQnGbkwRGd5nfdhMvCECTbSBXb1ODXVhMev8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWm9040HBqD5yWZfCSJZIImTEnXEUlUM2NdBHQXnMkTonRbmG
	SGTZzUvtWRbrHck0fSYi2T+1e9SSIV6BdqnPOdKRIq8FNXeQAjp/So51hg57no5pA6UE5FeZgw1
	4saRhq+dJpMlNDPvy/c3HY87BGyEEAjBoXVhXVfB0kVkzVYDhKw==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr21768725e9.17.1726831136860;
        Fri, 20 Sep 2024 04:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXwA+/Lq7Qwx1kLgvjWo7woGE50UmLK6Xj0kazKJTf8V2gCF2e1kojmPEmHDGLe0sv5hiCQ==
X-Received: by 2002:a05:600c:458d:b0:42c:a8cb:6a75 with SMTP id 5b1f17b1804b1-42e7ac35e0fmr21768345e9.17.1726831136470;
        Fri, 20 Sep 2024 04:18:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754516e7sm46430025e9.27.2024.09.20.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 04:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C14DA157F76D; Fri, 20 Sep 2024 13:18:53 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, syzbot
 <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 michal.switala@infogain.com, netdev@vger.kernel.org, revest@google.com,
 sdf@fomichev.me, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
In-Reply-To: <20240902080232.wnhtxiWK@linutronix.de>
References: <00000000000099cf25061964d113@google.com>
 <000000000000ebe92a062100eb94@google.com>
 <20240902080232.wnhtxiWK@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 20 Sep 2024 13:18:53 +0200
Message-ID: <874j6aindu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-08-31 13:55:02 [-0700], syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e
>> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Date:   Thu Jun 20 13:22:04 2024 +0000
>> 
>>     net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12597c63980000
>> start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
>> git tree:       bpf
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
>> dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13390aea980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10948741980000
>
> This looks like ri->tgt_value is a NULL pointer (dst in
> dev_map_enqueue()). The commit referenced by syz should not have fixed
> that.
> It is possible that there were leftovers in bpf_redirect_info (from a
> previous invocation) which were memset(,0,) during the switch from
> per-CPU to stack usage and now it does not trigger anymore.

Yes, I believe you are right. AFAICT, the original issue stems from the
SKB path and XDP path using the same numeric flag values in the
ri->flags field (specifically, BPF_F_BROADCAST == BPF_F_NEXTHOP). So if
bpf_redirect_neigh() was used and subsequently, an XDP redirect was
performed using the same bpf_redirect_info struct, the XDP path would
get confused and end up crashing. Now, with the stack-allocated
bpf_redirect_info, this sharing can no longer happen, so the crash
doesn't happen anymore.

However, different code paths using identically-numbered flag values
in the same struct field still seems like a bit of a mess, so I'll send
a patch to fix this just to be safe in case we ever move back to sharing
this data structure.

-Toke


