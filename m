Return-Path: <bpf+bounces-15669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A97F4A0D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96633B20F92
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AAF4E1C7;
	Wed, 22 Nov 2023 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fW8Opz08"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DF92;
	Wed, 22 Nov 2023 07:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/Bu2VQs5gpUOr1zltQq4kVF4KWyL88OyPQ1qvikMssI=; b=fW8Opz08B/kmeGk2CB0ZypA8f5
	dzvR+fPT61tokvJtftRJX5Mz/n5CmJuUSArGS5pvYdevn0AOxuvP7dC/AcamP7jtMA1envNyTLVMI
	vwhKl6BeigUswt/arMQjSWWV74/KDMgWNodiOwL3K02O3OpmQxonaYZKGx3x9olEQe7QBhSiyrUiP
	gkk8X0Js6aP/HYLApBl56CpOkqxwLSHd9nEfzryTXReA7z9kODuh35DBoJZlRQQ5vqYARBmUs3uT0
	ag/W86b7wErm0ttbPj8NCaiTJdqKsNTKeC8Op+aVSVi2jM8omVloG3chv0B0duESg+6RPf7qWRgdK
	cx6SGb5w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5oxq-000BUG-5x; Wed, 22 Nov 2023 16:16:30 +0100
Received: from [178.197.248.19] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5oxp-000Geg-Pq; Wed, 22 Nov 2023 16:16:29 +0100
Subject: Re: [PATCH bpf-next v2 0/3] skmsg: Add the data length in skmsg to
 SIOCINQ ioctl and rx_queue
To: Pengcheng Yang <yangpc@wangsu.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c856222-d103-8149-1cdb-b3e07105f5f8@iogearbox.net>
Date: Wed, 22 Nov 2023 16:16:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27101/Wed Nov 22 09:40:55 2023)

On 11/21/23 12:22 PM, Pengcheng Yang wrote:
> When using skmsg redirect, the msg is queued in psock->ingress_msg,
> and the application calling SIOCINQ ioctl will return a readable
> length of 0, and we cannot track the data length of ingress_msg with
> the ss tool.
> 
> In this patch set, we added the data length in ingress_msg to the
> SIOCINQ ioctl and the rx_queue of tcp_diag.
> 
> v2:
> - Add READ_ONCE()/WRITE_ONCE() on accesses to psock->msg_len
> - Mask out the increment msg_len where its not needed

Please double check BPF CI, this series might be breaking sockmap selftests :

https://github.com/kernel-patches/bpf/actions/runs/6922624338/job/18829650043

[...]
Notice: Success: 501/13458, Skipped: 57, Failed: 1
Error: #281 sockmap_basic
Error: #281/16 sockmap_basic/sockmap skb_verdict fionread
   Error: #281/16 sockmap_basic/sockmap skb_verdict fionread
   test_sockmap_skb_verdict_fionread:PASS:open_and_load 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:bpf_prog_attach 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:socket_loopback(s) 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:create_socket_pairs(s) 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:bpf_map_update_elem(c1) 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:xsend(p0) 0 nsec
   test_sockmap_skb_verdict_fionread:PASS:ioctl(FIONREAD) error 0 nsec
   test_sockmap_skb_verdict_fionread:FAIL:ioctl(FIONREAD) unexpected ioctl(FIONREAD): actual 512 != expected 256
   test_sockmap_skb_verdict_fionread:PASS:recv_timeout(c0) 0 nsec
Error: #281/18 sockmap_basic/sockmap skb_verdict msg_f_peek
   Error: #281/18 sockmap_basic/sockmap skb_verdict msg_f_peek
   test_sockmap_skb_verdict_peek:PASS:open_and_load 0 nsec
   test_sockmap_skb_verdict_peek:PASS:bpf_prog_attach 0 nsec
   test_sockmap_skb_verdict_peek:PASS:socket_loopback(s) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:create_pairs(s) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:bpf_map_update_elem(c1) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:xsend(p1) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:recv(c1) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:ioctl(FIONREAD) error 0 nsec
   test_sockmap_skb_verdict_peek:FAIL:after peek ioctl(FIONREAD) unexpected after peek ioctl(FIONREAD): actual 512 != expected 256
   test_sockmap_skb_verdict_peek:PASS:recv(p0) 0 nsec
   test_sockmap_skb_verdict_peek:PASS:ioctl(FIONREAD) error 0 nsec
   test_sockmap_skb_verdict_peek:PASS:after read ioctl(FIONREAD) 0 nsec
Test Results:
              bpftool: PASS
  test_progs-no_alu32: FAIL (returned 1)
             shutdown: CLEAN
Error: Process completed with exit code 1.

