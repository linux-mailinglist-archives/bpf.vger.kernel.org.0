Return-Path: <bpf+bounces-15744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1307F5DAD
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 12:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9642281ADF
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1D22F19;
	Thu, 23 Nov 2023 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 418CD1BD;
	Thu, 23 Nov 2023 03:21:14 -0800 (PST)
Received: from XMCDN1207038 (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAAnoxKZNV9lmDJsAA--.28580S2;
	Thu, 23 Nov 2023 19:20:59 +0800 (CST)
From: "Pengcheng Yang" <yangpc@wangsu.com>
To: "'Daniel Borkmann'" <daniel@iogearbox.net>,
	"'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Sitnicki'" <jakub@cloudflare.com>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com> <6c856222-d103-8149-1cdb-b3e07105f5f8@iogearbox.net>
In-Reply-To: <6c856222-d103-8149-1cdb-b3e07105f5f8@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 0/3] skmsg: Add the data length in skmsg to SIOCINQ ioctl and rx_queue
Date: Thu, 23 Nov 2023 19:20:57 +0800
Message-ID: <000001da1dff$223ed4e0$66bc7ea0$@wangsu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpjviH4qTFjCB89Pc8Rjk1Q8y5HALF/A0Ur9KtXqA=
Content-Language: zh-cn
X-CM-TRANSID:SyJltAAnoxKZNV9lmDJsAA--.28580S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4rCw4xCw4rKw43Xr48Xrb_yoW5AFWDpa
	4DA34UGFWkZa42grsxWr4Igw4Fgr9Iyw45Kr1UWry3CF13uw1F9r4xWayaqr4xGr4rua4j
	gw4UWFW8J3y5JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48
	McIj6xkF7I0En7xvr7AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxG
	rwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5no2U
	UUUUU==
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/

Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 11/21/23 12:22 PM, Pengcheng Yang wrote:
> > When using skmsg redirect, the msg is queued in psock->ingress_msg,
> > and the application calling SIOCINQ ioctl will return a readable
> > length of 0, and we cannot track the data length of ingress_msg with
> > the ss tool.
> >
> > In this patch set, we added the data length in ingress_msg to the
> > SIOCINQ ioctl and the rx_queue of tcp_diag.
> >
> > v2:
> > - Add READ_ONCE()/WRITE_ONCE() on accesses to psock->msg_len
> > - Mask out the increment msg_len where its not needed
> 
> Please double check BPF CI, this series might be breaking sockmap selftests :
> 
> https://github.com/kernel-patches/bpf/actions/runs/6922624338/job/18829650043
> 

Is this a misunderstanding?
The selftests failure above were run on patch set v1 4 days ago, and this patch v2
is the fix for this case.

> [...]
> Notice: Success: 501/13458, Skipped: 57, Failed: 1
> Error: #281 sockmap_basic
> Error: #281/16 sockmap_basic/sockmap skb_verdict fionread
>    Error: #281/16 sockmap_basic/sockmap skb_verdict fionread
>    test_sockmap_skb_verdict_fionread:PASS:open_and_load 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:bpf_prog_attach 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:socket_loopback(s) 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:create_socket_pairs(s) 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:bpf_map_update_elem(c1) 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:xsend(p0) 0 nsec
>    test_sockmap_skb_verdict_fionread:PASS:ioctl(FIONREAD) error 0 nsec
>    test_sockmap_skb_verdict_fionread:FAIL:ioctl(FIONREAD) unexpected ioctl(FIONREAD): actual 512 != expected 256
>    test_sockmap_skb_verdict_fionread:PASS:recv_timeout(c0) 0 nsec
> Error: #281/18 sockmap_basic/sockmap skb_verdict msg_f_peek
>    Error: #281/18 sockmap_basic/sockmap skb_verdict msg_f_peek
>    test_sockmap_skb_verdict_peek:PASS:open_and_load 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:bpf_prog_attach 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:socket_loopback(s) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:create_pairs(s) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:bpf_map_update_elem(c1) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:xsend(p1) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:recv(c1) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:ioctl(FIONREAD) error 0 nsec
>    test_sockmap_skb_verdict_peek:FAIL:after peek ioctl(FIONREAD) unexpected after peek ioctl(FIONREAD): actual 512 != expected 256
>    test_sockmap_skb_verdict_peek:PASS:recv(p0) 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:ioctl(FIONREAD) error 0 nsec
>    test_sockmap_skb_verdict_peek:PASS:after read ioctl(FIONREAD) 0 nsec
> Test Results:
>               bpftool: PASS
>   test_progs-no_alu32: FAIL (returned 1)
>              shutdown: CLEAN
> Error: Process completed with exit code 1.


