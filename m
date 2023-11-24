Return-Path: <bpf+bounces-15801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29847F705D
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 10:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307FD1C20ECA
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551C1772F;
	Fri, 24 Nov 2023 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UZS+8JRd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193241A5;
	Fri, 24 Nov 2023 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y6oOg+XyggL3panEJ9dZ3qh6P7m6iqtMQeQ+/73vKtk=; b=UZS+8JRd5hGjDZklNyqijiVqoG
	QzvTPxvRWOHTUmyR3vZ9VJvGM1f9YgAdkl6lxVrVStTEVbXtFXjzzxiZtEBbJPAXrb1p5GHqxxfBV
	83lUoWBjWoXQ9ZMfymHJ7XspO64xP8Ug4qFe/TIXv+0VwbP5Bl3wTVoZ2pDKDhDDWnMXfxrrbhdYm
	XAi9JZKirPuGbBAUs1BJqEyObdZWBGLD/SaUgzRlSqyPF/7zfa2tFsF0fd6vI3/ZjvuqtKDnB/S6n
	vmopK1nO1JsxToTTLgVhm/He0d9GhLEHGs06OD3B9JS/nAaPoPSxYMxkaX1kS1NNJufgEjTyBjEdl
	mf4kAvyA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r6Snv-0008hD-HU; Fri, 24 Nov 2023 10:48:55 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r6Snu-000Gj6-9l; Fri, 24 Nov 2023 10:48:54 +0100
Subject: Re: [PATCH bpf-next] bpf: add sock_ops callbacks for data
 send/recv/acked events
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org
References: <20231123030732.111576-1-lulie@linux.alibaba.com>
 <438f45f9-4e18-4d7d-bfa5-4a239c4a2304@linux.alibaba.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <72166ea4-cae7-97e2-88fd-e9bde56523fb@iogearbox.net>
Date: Fri, 24 Nov 2023 10:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <438f45f9-4e18-4d7d-bfa5-4a239c4a2304@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27103/Fri Nov 24 09:40:22 2023)

On 11/23/23 1:37 PM, Philo Lu wrote:
> Sorry, I forgot to cc the maintainers.
> 
> On 2023/11/23 11:07, Philo Lu wrote:
>> Add 3 sock_ops operators, namely BPF_SOCK_OPS_DATA_SEND_CB,
>> BPF_SOCK_OPS_DATA_RECV_CB, and BPF_SOCK_OPS_DATA_ACKED_CB. A flag
>> BPF_SOCK_OPS_DATA_EVENT_CB_FLAG is provided to minimize the performance
>> impact. The flag must be explicitly set to enable these callbacks.
>>
>> If the flag is enabled, bpf sock_ops program will be called every time a
>> tcp data packet is sent, received, and acked.
>> BPF_SOCK_OPS_DATA_SEND_CB: call bpf after a data packet is sent.
>> BPF_SOCK_OPS_DATA_RECV_CB: call bpf after a data packet is receviced.
>> BPF_SOCK_OPS_DATA_ACKED_CB: call bpf after a valid ack packet is
>> processed (some sent data are ackknowledged).
>>
>> We use these callbacks for fine-grained tcp monitoring, which collects
>> and analyses every tcp request/response event information. The whole
>> system has been described in SIGMOD'18 (see
>> https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
>> achieve this with bpf, we require hooks for data events that call
>> sock_ops bpf (1) when any data packet is sent/received/acked, and (2)
>> after critical tcp state variables have been updated (e.g., snd_una,
>> snd_nxt, rcv_nxt). However, existing sock_ops operators cannot meet our
>> requirements.
>>
>> Besides, these hooks also help to debug tcp when data send/recv/acked.
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   include/net/tcp.h        |  9 +++++++++
>>   include/uapi/linux/bpf.h | 14 +++++++++++++-
>>   net/ipv4/tcp_input.c     |  4 ++++
>>   net/ipv4/tcp_output.c    |  2 ++
>>   4 files changed, 28 insertions(+), 1 deletion(-)

Please also add selftests for the new hooks, and speaking of the latter
looks like this fails current BPF selftests :

https://github.com/kernel-patches/bpf/actions/runs/6974541866/job/18980491457

Notice: Success: 502/3526, Skipped: 56, Failed: 1
Error: #348 tcpbpf_user
   Error: #348 tcpbpf_user
   test_tcpbpf_user:PASS:open and load skel 0 nsec
   test_tcpbpf_user:PASS:test__join_cgroup(/tcpbpf-user-test) 0 nsec
   test_tcpbpf_user:PASS:attach_cgroup(bpf_testcb) 0 nsec
   run_test:PASS:start_server 0 nsec
   run_test:PASS:connect_to_fd(listen_fd) 0 nsec
   run_test:PASS:accept(listen_fd) 0 nsec
   run_test:PASS:send(cli_fd) 0 nsec
   run_test:PASS:recv(accept_fd) 0 nsec
   run_test:PASS:send(accept_fd) 0 nsec
   run_test:PASS:recv(cli_fd) 0 nsec
   run_test:PASS:recv(cli_fd) for fin 0 nsec
   run_test:PASS:recv(accept_fd) for fin 0 nsec
   verify_result:PASS:event_map 0 nsec
   verify_result:PASS:bytes_received 0 nsec
   verify_result:PASS:bytes_acked 0 nsec
   verify_result:PASS:data_segs_in 0 nsec
   verify_result:PASS:data_segs_out 0 nsec
   verify_result:FAIL:bad_cb_test_rv unexpected bad_cb_test_rv: actual 0 != expected 128
   verify_result:PASS:good_cb_test_rv 0 nsec
   verify_result:PASS:num_listen 0 nsec
   verify_result:PASS:num_close_events 0 nsec
   verify_result:PASS:tcp_save_syn 0 nsec
   verify_result:PASS:tcp_saved_syn 0 nsec
   verify_result:PASS:window_clamp_client 0 nsec
   verify_result:PASS:window_clamp_server 0 nsec
Test Results:
              bpftool: PASS
           test_progs: FAIL (returned 1)
             shutdown: CLEAN
Error: Process completed with exit code 1.

