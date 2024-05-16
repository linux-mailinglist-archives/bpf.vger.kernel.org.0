Return-Path: <bpf+bounces-29865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1F8C7AF3
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4394B22173
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF70156C4D;
	Thu, 16 May 2024 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="StalDMSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE215666D
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879728; cv=none; b=Z7WM2rgEYeMNQ6GCqK/RmawcIjh3aBkzyXwigL/Rl84pMdry953q+PbOMrMPHttjCJHL/T7ubQSq81gR2Vhz1KWP6ir+OyztHNJ9lM3xNJxLcUrlXYraGkYpnJ00PN5s9L6CyxWphQcjDZGaWMBlSEztd9BspFg+OGM3DpRt9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879728; c=relaxed/simple;
	bh=I9yVvSeCiKbUPTf+PbtsXlnOw7lKjkdxZAf9RBe6FUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WcE1oWb+vKQeim3yuFM7nr7RPlOF1jFwu8+L3kSw46ArP/q53tSERl+9BLTKtQmehYTUE67N/L21KB2ZvfhQVYtshSAYEXGxQFU/NtOoL+wjoBXnLwCQ/UlyyCfs4kPZCx/eKojsBDYQEjYsZkbER7jmTC+NE79BYXs5zAiR0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=StalDMSV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59cf8140d0so317397466b.3
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715879725; x=1716484525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtWrAs0RAGr87XOIL9UmIa9QNKh1412dHu2bcji4wUg=;
        b=StalDMSV2L/jeecGfNs260NRBn9vJNTDAvqq1uAZsDUD/+DVMsygi3YQvhXT6OEGb6
         svRN7wY8cZ6+7IcBczkxqZLaQ0Pheh2nxpsnUxeIN5YeWI8ewDD8+TD1OU6wnYM+iCUx
         ydoP0t2GhHNI/S1R3hBQ7qE5vwbS5YduoDlNXPlqUAMCP/u3DU+H+IvZFpNe5wrVqTEu
         dde2EbqqaUegQjN3OHtu0iIMf1ONIQjHIXwv3mO7TOUPq8AQPWPtv0NCdKwE95mdcEhX
         KvWwgIBsYTz4ilZm7eJtpHLUSQ/t9exO+bGyQt/zBS6YoMUcUGbdLSzMuZqn76BLR6ZL
         SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879725; x=1716484525;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gtWrAs0RAGr87XOIL9UmIa9QNKh1412dHu2bcji4wUg=;
        b=D6/pTY33w1aqbkR3RTesII3v0zYXyQ/2d7+4gx9vnVrz1Ujc48QTL/ioUksbD7LGrP
         rHDxW8GmJaLM+IUqq6Sq9f87HY/qzfBbcs7HdRbcDoRJo9rImV0vQAcRkfcFkNsfqS9Y
         5LG5GaLKRBYENGjY8zdHLfQ4ZlZQstn5sw92YaXDHM1H/73KCYhsR9WNssHDz+cXk9Ad
         XjtmDAyJA5eR2l4STD5xW+i8QGq//B/ATZXu/Md6/ks2/yP9yBdOWuRMYqJ8s6+rZQc/
         IrQMcNK1HiKqp17O1BpgiqLDon3NXgVftUwKzSJLUTsXMgsYIHQaS/g2i6Jx2XSigmLE
         xewQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8+ALBgNKKPW9Em95yIPdEc1jRTtsqHq0mOCFILHRLiLryl7WqWsnTcGA2bhmnBxPpic8NeEkJdyzrLs8KNVuBo2kh
X-Gm-Message-State: AOJu0Yy40f3q0NWQKsgJiYlpbBiLtPKFQWVhwYAAqunuqS+pd6GQcbp7
	J32Uf41uhGQ/KRWRYo3oK+rTX8cBnXmqCwAhirNdQqUWmaY6XcyZSWSnLpG0Kj8=
X-Google-Smtp-Source: AGHT+IGIcb5rCvHQJvN9hgMI6gSGPg35+lrfzgyUnfBSSMYyKqtsfkjL/KonB0G/Xvz+BubyVJBH6g==
X-Received: by 2002:a17:907:3208:b0:a5a:1562:5187 with SMTP id a640c23a62f3a-a5a2d66a3a4mr1504912866b.55.1715879725114;
        Thu, 16 May 2024 10:15:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5c002103desm249121266b.161.2024.05.16.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:15:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@google.com,  haoluo@google.com,
  jolsa@kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  laoar.shao@gmail.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  yangzhenze@bytedance.com,
  wangdongdong.6@bytedance.com
Subject: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
In-Reply-To: <1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com> (Feng Zhou's
	message of "Thu, 16 May 2024 11:15:43 +0800")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
	<87seyjwgme.fsf@cloudflare.com>
	<1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 16 May 2024 19:15:22 +0200
Message-ID: <87wmnty8yd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:15 AM +08, Feng Zhou wrote:
> =E5=9C=A8 2024/5/15 17:48, Jakub Sitnicki =E5=86=99=E9=81=93:
>> On Wed, May 15, 2024 at 04:19 PM +08, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Set the full package write tcp option, the test found that the loss
>>> will be 20%. If a package wants to write tcp option, it will trigger
>>> bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
>>> call "tcp_established_options" to reserve tcp opt len, call
>>> "bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
>>> TSO. Through bpftrace tracking, it was found that during the pressure
>>> test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
>>> len does not change often, consider caching opt len for optimization.
>> You could also make your BPF sock_ops program cache the value and return
>> the cached value when called for BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>> If that is in your opinion prohibitevely expensive then it would be good
>> to see a sample program and CPU cycle measurements (bpftool prog profile=
).
>>=20
>
> I'm not referring to the overhead introduced by the time-consuming
> operation of bpf prog. I have tested that bpf prog does nothing and
> returns directly, and the loss is still 20%. During the pressure test
> process, "tcp_send_mss" and "__tcp_transmit_skb" the call frequency per
> second
>
> @[
>     bpf_skops_hdr_opt_len.isra.46+1
>     tcp_established_options+730
>     tcp_current_mss+81
>     tcp_send_mss+23
>     tcp_sendmsg_locked+285
>     tcp_sendmsg+58
>     sock_sendmsg+48
>     sock_write_iter+151
>     new_sync_write+296
>     vfs_write+165
>     ksys_write+89
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 3671671
>
> @[
>     bpf_skops_write_hdr_opt.isra.47+1
>     __tcp_transmit_skb+761
>     tcp_write_xmit+822
>     __tcp_push_pending_frames+52
>     tcp_close+813
>     inet_release+60
>     __sock_release+55
>     sock_close+17
>     __fput+179
>     task_work_run+112
>     exit_to_usermode_loop+245
>     do_syscall_64+456
>     entry_SYSCALL_64_after_hwframe+68
> ]: 36125
>
> "tcp_send_mss" before TSO, without packet aggregation, and
> "__tcp_transmit_skb" after TSO, the gap between the two is
> 100 times.

All right, we are getting somewhere.

So in your workload bpf_skops_hdr_opt_len more times that you like.
And you have determined that by memoizing the BPF
skops/BPF_SOCK_OPS_HDR_OPT_LEN_CB result and skipping over part of
tcp_established_options you get a performance boost.

Did you first check with perf record to which ops in
tcp_established_options are taking up so many cycles?

If it's not the BPF prog, which you have ruled out, then where are we
burining cycles? Maybe that is something that can be improved.

Also, in terms on quantifying the improvement - it is 20% in terms of
what? Throughput, pps, cycles? And was that a single data point? For
multiple measurements there must be some variance (+/- X pp).

Would be great to see some data to back it up.

[...]

>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
>>> index 90706a47f6ff..f2092de1f432 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -6892,8 +6892,14 @@ enum {
>>>   	 * options first before the BPF program does.
>>>   	 */
>>>   	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
>>> +	/* Fast path to reserve space in a skb under
>>> +	 * sock_ops->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>>> +	 * opt length doesn't change often, so it can save in the tcp_sock. A=
nd
>>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>>> +	 */
>>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG =3D (1<<7),
>> Have you considered a bpf_reserve_hdr_opt() flag instead?
>> An example or test coverage would to show this API extension in action
>> would help.
>>=20
>
> bpf_reserve_hdr_opt () flag can't finish this. I want to optimize
> that bpf prog will not be triggered frequently before TSO. Provide
> a way for users to not trigger bpf prog when opt len is unchanged.
> Then when writing opt, if len changes, clear the flag, and then
> change opt len in the next package.

I haven't seen a sample using the API extenstion that you're proposing,
so I can only guess. But you probably have something like:

SEC("sockops")
int sockops_prog(struct bpf_sock_ops *ctx)
{
	if (ctx->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
	    ctx->args[0] =3D=3D BPF_WRITE_HDR_TCP_CURRENT_MSS) {
		bpf_reserve_hdr_opt(ctx, N, 0);
		bpf_sock_ops_cb_flags_set(ctx,
					  ctx->bpf_sock_ops_cb_flags |
					  MY_NEW_FLAG);
		return 1;
	}
}

I don't understand why you're saying it can't be transformed into:

int sockops_prog(struct bpf_sock_ops *ctx)
{
	if (ctx->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
	    ctx->args[0] =3D=3D BPF_WRITE_HDR_TCP_CURRENT_MSS) {
		bpf_reserve_hdr_opt(ctx, N, MY_NEW_FLAG);
		return 1;
	}
}

[...]

