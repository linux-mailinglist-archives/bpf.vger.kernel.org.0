Return-Path: <bpf+bounces-34850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC6931CEC
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 00:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376C5B21C60
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F613D8A0;
	Mon, 15 Jul 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qfWuR7pw"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758A13D250
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080810; cv=none; b=lOT9D3GQsIAM6uJBlxScRv3RG9tdVUYTSDhj4tpHXesXjL5aD4PjCzabT8T7Lc09oyqPFj1c1yDuLjvqUdCDlr4wkU6M3jggNp7cB5/DwYA6UZd59y602RgBCOoZtiXxk6WteiZeUbeOzItr7WqC/Pqm6FfyTibXkZKpB0JHhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080810; c=relaxed/simple;
	bh=VvXq92KpHPIRozJfcq+L1F50oUtNg9ko7V7379mo2fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haKEF1PG140qHbMVclIBL4uOpOLoPyhif+3r/8x+REPQ2Q7j2bCYlLJ0b57gODUXgGWpgcHqES7C5lNEyGf7uIdKm5IUqHWzZunOjnUvdk0WcfJLPvM1Z4oYYouxG9/5LpvbzVbtE3hGx1g1s/tM+hcBB/IXZU7XJVYLIsdXn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qfWuR7pw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: michal.switala@infogain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721080802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EdCflnB/pwsCFcJPi8tMScj5szL6F6CawhXwJyWqco=;
	b=qfWuR7pwbd3YJgFqA+KIycFuHhUVAZnPdcdAkCrc2IGwQvq7fDWqOSyjYEZvHJOBmm4KPH
	jCOD/6rufJCBtgwMWL0ycHsfFw1ExuAxixjI/rSmcOwIPYf8nAmHb90QMXGKdYGmIPukqO
	3155GDcShhkVZSxPcIMo0YRs3Vcjoig=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: revest@google.com
X-Envelope-To: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
X-Envelope-To: alexei.starovoitov@gmail.com
X-Envelope-To: toke@redhat.com
Message-ID: <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev>
Date: Mon, 15 Jul 2024 14:59:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context
 initialization
To: Michal Switala <michal.switala@infogain.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, revest@google.com,
 syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
 <20240715181339.2489649-1-michal.switala@infogain.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240715181339.2489649-1-michal.switala@infogain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/24 11:13 AM, Michal Switala wrote:

 >> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
 >> Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
 >> Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com/
 >
 > Something doesn't add up.
 > This syzbot report is about:
 >
 > dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
 > __xdp_do_redirect_frame net/core/filter.c:4397 [inline]
 > bpf_prog_test_run_xdp
 >
 > why you're fixing bpf_prog_test_run_skb ?


[ Please keep the relevant email context in the reply ]


> The reproducer calls the methods bpf_prog_test_run_xdp and
> bpf_prog_test_run_skb. Both lead to the invocation of dev_map_enqueue, in the

The syzbot report is triggering from the bpf_prog_test_run_xdp. I agree with 
Alexei that fixing the bpf_prog_test_run_skb does not make sense. At least I 
don't see how dev_map_enqueue can be used from bpf_prog_test_run_skb.

It looks very similar to 
https://lore.kernel.org/bpf/000000000000f6531b061494e696@google.com/. It has 
been fixed in commit 5bcf0dcbf906 ("xdp: use flags field to disambiguate 
broadcast redirect")

I tried the C repro. I can reproduce in the bpf tree also which should have the 
fix. I cannot reproduce in the bpf-next though.

Cc Toke who knows more details here.

> case of the former, the backtrace is recorded in its entirety, whereas for the
> latter it is not. I think the bug might be incorrectly reported on syzkaller, as
> during GDB debugging, the problem occurred in functions called from
> bpf_prog_test_run_skb. I also ran testing of my patch on syzkaller and the tests
> passed.



