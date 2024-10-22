Return-Path: <bpf+bounces-42717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B39A9530
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74601F239B9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34A4964D;
	Tue, 22 Oct 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvUJIaTE"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469704A35
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558395; cv=none; b=UHs1IEGZd17l28+LutfSSntLjdQH9oqCXcYpS2dKoynr4fiM+q5rtcBrCWvjGU2w+Jb697BdIzI2oAzBhQBGjcJiCN6AxTa0fhIwQRKr+1V+7po1riea/jrzmdBgFeY6/mOuxPOP4A7uCC69fIpi1C6neCMLzn03LfxibL4YPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558395; c=relaxed/simple;
	bh=tjIFHv/EMReXjvsE+7mWchxnJppWe44uHjwYfEO5/RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixSURaLHI7IVJ4NN6VtA0ymfeyMl1I9xApSSdZHLnt+oBYbob+sW+dsBWwgi4l12pjY0BPAnS4nE2YhNhWwwIPijJ5K09CROn2Vrano6w9z/3kF4sAw9NTbif+hY9gLvE+zwoJ5Z7TgODg94F9HVKZdM8HzVJXqfIGFd1YxBf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wvUJIaTE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729558390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oHzFPLgOWgtkMsBteVC+zlpIqggyTXFkpQARkUQEnI=;
	b=wvUJIaTEdtjUt3riVlG0mdM8tfNXZ0lJGa0hM3ixQiMg10OUXrtrG7GakqkkHU4oRPJSbc
	tHBu92obJccgUFhbfG3Hd0ZIhKwSc7W4hLwK5Ka1ZLTsVxgl9adNOkyx3Xy3VZ4Nj98jyU
	Ce1cAkd+X0kSvCdyP9ZHdCxtZHSVuJQ=
Date: Mon, 21 Oct 2024 17:53:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/20/24 2:51 PM, Willem de Bruijn wrote:
> Jason Xing wrote:
>> From: Jason Xing <kernelxing@tencent.com>
>>
>> Willem suggested that we use a static key to control. The advantage
>> is that we will not affect the existing applications at all if we
>> don't load BPF program.
>>
>> In this patch, except the static key, I also add one logic that is
>> used to test if the socket has enabled its tsflags in order to
>> support bpf logic to allow both cases to happen at the same time.
>> Or else, the skb carring related timestamp flag doesn't know which
>> way of printing is desirable.
>>
>> One thing important is this patch allows print from both applications
>> and bpf program at the same time. Now we have three kinds of print:
>> 1) only BPF program prints
>> 2) only application program prints
>> 3) both can print without side effect
>>
>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Getting back to this thread. It is long, instead of responding to
> multiple messages, let me combine them in a single response.
> 
> 
> * On future extensions:
> 
> +1 that the UDP case, and datagrams more broadly, must have a clear
> development path, before we can merge TCP.
> 
> Similarly, hardware timestamps need not be supported from the start,
> but must clearly be supportable.
> 
> 
> * On queueing packets to userspace:
> 
>>> the current behavior is to just queue to the sk_error_queue as long
>>> as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
>>> is regardless of the sk_tsflags. "
> 
>> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
>> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
>> read the skb from the errqueue but are not able to parse the
>> timestamps
> 
> Before queuing a packet to userspace on the error queue, the relevant
> reporting flag is always tested. sock_recv_timestamp has:
> 
>          /*
>           * generate control messages if
>           * - receive time stamping in software requested
>           * - software time stamp available and wanted
>           * - hardware time stamps available and wanted
>           */
>          if (sock_flag(sk, SOCK_RCVTSTAMP) ||
>              (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
>              (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
>              (hwtstamps->hwtstamp &&
>               (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
>                  __sock_recv_timestamp(msg, sk, skb);
> 
> Otherwise applications could get error messages queued, and
> epoll/poll/select would unexpectedly behave differently.

I just tried the following diff to remove setsockopt from txtimestamp.c and run 
"./txtimestamp -6 -c 1 -C -N -L ::1". It is getting the skb from the error queue 
with only cmsg flag. I did a printk in __skb_tstamp_tx to ensure the
sk->sk_tsflags is empty also.

diff --git i/tools/testing/selftests/net/txtimestamp.c 
w/tools/testing/selftests/net/txtimestamp.c
index dae91eb97d69..5d9d2773b076 100644
--- i/tools/testing/selftests/net/txtimestamp.c
+++ w/tools/testing/selftests/net/txtimestamp.c
@@ -319,6 +319,8 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int 
payload_len)
  	for (cm = CMSG_FIRSTHDR(msg);
  	     cm && cm->cmsg_len;
  	     cm = CMSG_NXTHDR(msg, cm)) {
+		printf("cm->cmsg_level %d cm->cmsg_type %d\n",
+		       cm->cmsg_level, cm->cmsg_type);
  		if (cm->cmsg_level == SOL_SOCKET &&
  		    cm->cmsg_type == SCM_TIMESTAMPING) {
  			tss = (void *) CMSG_DATA(cm);
@@ -362,7 +364,7 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int 
payload_len)
  	if (batch > 1) {
  		fprintf(stderr, "batched %d timestamps\n", batch);
  	} else if (!batch) {
-		fprintf(stderr, "Failed to report timestamps\n");
+		fprintf(stderr, "Failed to report timestamps. payload_len %d\n", payload_len);
  		test_failed = true;
  	}
  }
@@ -578,9 +580,12 @@ static void do_test(int family, unsigned int report_opt)
  	if (cfg_loop_nodata)
  		sock_opt |= SOF_TIMESTAMPING_OPT_TSONLY;

+	(void)sock_opt;
+/*
  	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
  		       (char *) &sock_opt, sizeof(sock_opt)))
  		error(1, 0, "setsockopt timestamping");
+*/

  	for (i = 0; i < cfg_num_pkts; i++) {
  		memset(&msg, 0, sizeof(msg));
> 
>> SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
>> features including cmsg mode. But it will not be used in bpf mode.
> 
> For simplicity, the two uses of the API are best kept identical. If
> there is a technical reason why BPF has to diverge from established
> behavior, this needs to be explicitly called out in the commit
> message.

SOF_TIMESTAMPING_OPT_TSONLY will not be supported. The orig_skb can always be 
passed directly to the bpf if needed without extra cost. The same probably goes 
for SOF_TIMESTAMPING_OPT_PKTINFO. SOF_TIMESTAMPING_SOFTWARE does not seem to be 
useful either. I think only a subset of SOF_* will be supported, probably only 
the TX_* and RX_* ones.

> 
> Also, if you want to extend the API for BPF in the future, good to
> call this out now and ideally extensions will apply to both, to
> maintain a uniform API.
> 
> 
> * On extra measurement points, at sendmsg or tcp_write_xmit:
> 
> The first is interesting. For application timestamping, this was
> never needed, as the application can just call clock_gettime before
> sendmsg.
> 
> In general, additional measurement points are not only useful if the
> interval between is not constant. So far, we have seen no need for
> any additional points.
> 
> 
> * On skb state:
> 
>>> For now, is there thing we can explore to share in the skb_shared_info?
> 
> skb_shinfo space is at a premium. I don't think we can justify two
> extra fields just for this use case.
> 
>> My initial thought is just to reuse these fields in skb. It can work
>> without interfering one another.
> 
> I'm skeptical that two methods can work at the same time. If they are
> started at different times, their sk_tskey will be different, for one.

For the skb's tx_flags, Jason seems to be able to figure out by only using the 
new sk_tsflags_bpf. In the worst case, it seems there is still one bit left in 
tx_flags.

I am also not very positive on the skb's tskey for now.

Willem, I recalled I had tried to reuse the tx_flags and hwtstamp when keeping 
the delivery time in skb->tstamp for a skb redirecting from egress to ingress. I 
think that approach was stalled because the tx_flags could be changed by the 
netdevice like "skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS". How about the 
skb_shinfo(skb)->hwtstamps? At least for the TX path, it should not be changed 
until the netdevice calling skb_tstamp_tx() to report the hwtstamp? or the clone 
in the tcp stack will still break things if the hwtstamps is reused for other 
purpose?

> 
> There may be workarounds. Maybe BPF can store its state in some BPF
> specific field, indeed. Or perhaps it can store per-sk shadow state
> that resolves the conflict. For instance, the offset between sk_tskey
> and bpf_tskey.

I have also been proposing to explore other way for the key since bpf has direct 
access to the skb (also the sk, bpf prog can store data in the sk).

The bpf prog can learn what is the seq_no of the egress-ing skb. When the ack 
comes back, it can also learn the ack seq no. Does it help? It will be harder to 
use because it probably needs to store this info in the bpf map (or in the bpf 
sk storage). However, if it needs to learn the timestamp at the 
tcp_sendmsg/tcp_transmit_skb/tcp_write_xmit, this timestamp has to be stored 
somewhere also. Either in a bpf map or in a bpf sk storage.

SEC("cgroup/setsockopt") prog can also enforce the user space setsockopt. e.g. 
it can add SOF_TIMESTAMPING_OPT_ID_TCP when user space only use 
SOF_TIMESTAMPING_OPT_ID.

