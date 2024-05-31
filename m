Return-Path: <bpf+bounces-31015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BE8D6010
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCCE285C83
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB0156899;
	Fri, 31 May 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJdklNI9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5718756A;
	Fri, 31 May 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152828; cv=none; b=q3gvwPuUZoCTzPeiAYdWpMQIQN8VuXIBm06sr9c87iXZ8Nt5Kh6w/HaJjFp4wmovD7F08hlmxs5H+535W19VbAbxXrcn6RFa3IYSzYZ+YSBTExDMnCHUlcuEm1g/KxBVocIN5bVqNj2ZlBn7jwjQf8/psMPfS43lPpoYIJ7vyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152828; c=relaxed/simple;
	bh=/83MRsrVM2oXbn4uDqS5AZEsC8HOFGZW98TOiO7QvWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P23DD+79AwLtJwFIPDvL+di31k0gJ7VWCoOR/EQhK5t+AHraqL/Qk5ALVX9yqyUSUUXTKq1OpfZj34UfVspGCfZ+AwMigTnscchtDdKMy/WZ3EKvEeO/cfEaWh2ObRg0PNH/OgNYNC9Z6AyRoD7CktOf35gnx9z2iBTB2k/FP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJdklNI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE82C116B1;
	Fri, 31 May 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717152827;
	bh=/83MRsrVM2oXbn4uDqS5AZEsC8HOFGZW98TOiO7QvWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJdklNI9mY98pW4dslMeCf4x1bFelOC+wFysWrqtrEwEcn/ZFDCI1M5X9KuXTH9vp
	 CbwoLjv3WDYJ7XF4AbVe7H0Etg9Cbdvm5wLrobjZ0g7wqAXnsCuhFOyXJv91JJbs1h
	 KE3Ia1HpuW3oaXkDEQceYJRdcc+UrIC2Qt5YUXSu7xye5GEBcIh6Ej8TbDEgEnxvM5
	 w0itoiDNGFzjfRUisZXF6hdSmNmfxVIp60Z3c2QCibOIbtdIPn5n5fv6ZMMD0bSzV8
	 A0+ConCSk2qfZ41tjTcTFbbXbGEPEr2+wJQRQo9mTTLz0T+WjhPk7xvAufRHwTKkHd
	 /tYKTsjglulIg==
Date: Fri, 31 May 2024 11:53:39 +0100
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Mat Martineau <martineau@kernel.org>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v5 11/13] net: replace page_frag with
 page_frag_cache
Message-ID: <20240531105339.GA491852@kernel.org>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
 <20240528125604.63048-12-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528125604.63048-12-linyunsheng@huawei.com>

On Tue, May 28, 2024 at 08:56:01PM +0800, Yunsheng Lin wrote:
> Use the newly introduced prepare/probe/commit API to
> replace page_frag with page_frag_cache for sk_page_frag().
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Mat Martineau <martineau@kernel.org>

Hi Yunsheng Lin,

Unfortunately this seems to break W=1 allmodconfig builds (on x8_64).
I'm suspecting this relates to some missing includes, but I am unsure.

With clang-18 I see:

In file included from net/ipv4/ip_output.c:46:
In file included from ./include/linux/uaccess.h:8:
In file included from ./include/linux/sched.h:48:
./include/linux/page_frag_cache.h:176:2: error: call to undeclared function 'VM_BUG_ON'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  176 |         VM_BUG_ON(fragsz > nc->remaining || !nc->pagecnt_bias);

...

In file included from net/ipv4/ip_output.c:47:
In file included from ./include/linux/module.h:19:
In file included from ./include/linux/elf.h:6:
In file included from ./arch/x86/include/asm/elf.h:10:
In file included from ./arch/x86/include/asm/ia32.h:7:
In file included from ./include/linux/compat.h:17:
In file included from ./include/linux/fs.h:33:
In file included from ./include/linux/percpu-rwsem.h:7:
In file included from ./include/linux/rcuwait.h:6:
In file included from ./include/linux/sched/signal.h:6:
./include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
   98 |                 return (set->sig[3] | set->sig[2] |
      |                         ^        ~
./arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
   24 |         unsigned long sig[_NSIG_WORDS];
      |         ^

...

