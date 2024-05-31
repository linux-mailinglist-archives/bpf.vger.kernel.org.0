Return-Path: <bpf+bounces-31012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32128D5FE1
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F7288B08
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4915746A;
	Fri, 31 May 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GD3j8AG2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21D15624D
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152309; cv=none; b=PptRsaDY0giaZrfSoniCJlsXqMRAGmep2wXH5mMDA8iJP7JKbTI6iH6Mq86tkqI5Yeck3pR96VpGvTJ5cucWdfC82jGj5n2MeTZw7M+rcvngEzsSBtTHYmuPJOoWAkJ7oLZ2eY7/A9tyNXJIqLx2IWtO87X3aPDphwNpvr8ovoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152309; c=relaxed/simple;
	bh=+O74bC7crkPEscgYhdIG1ohsmHNDl/oLsAtyvpy3nTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCMllyj9O7MKe7GBu3YBHDnyJUn8gb+2mPp+WyKDfgggHmKNOidumpAVgCEXm8Mvl/pUkC1ScTBhP7CmPf/sZ8rAaFKS0LKAOdB6f5lg+XahJr0loWllNdK3H5ym0q/Aw0Ecy7SCiRPBxBokRHRxd1Jmbq/jzDfnI003ypmvmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GD3j8AG2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so1511508a12.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717152305; x=1717757105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX448Ud4eVPnfmLCN+EQvZqufwLyNpau6GIoFy7+iCw=;
        b=GD3j8AG2atGiOFMV1dULbJ4n1OdhVh4dhdg+sW4Vwm1F+Ex+Nt2J18rIdjdTA8hC39
         9h70tZMIo55HxHS4eOfdvPnPLvyQkWWWSaDtvJN2hr96Umbx4PHijNtxoikyEyADt944
         3ZctO3yo6sJrwUkiaUhHgnei9arqxBJH3ORuhj6UvFxV+R7x5vR9b7tC2YBBRMpcjDpe
         MGuypXHP8HqS22agWkBQ4RDxoJG0p2MnAlfIdNOstdlC8S6BGWRerlthu0JEaTaoCDGx
         iw1/4xzti8V4pLZw1lOAZPERfFGwD+4OuRw+oeh6C0HWakkqAoZHrR7/Loq3aXIKoPOu
         GHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152305; x=1717757105;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BX448Ud4eVPnfmLCN+EQvZqufwLyNpau6GIoFy7+iCw=;
        b=W5vHkX6Ru395nPiZjVVJEktFnQBlTTiWteCXzPyiWHua7Oigqcaxz0evmz5UEmzg/u
         G/Il8N/N6m6ICtW4rWFcB4OzGFWxu6fIQVWVBXr+NuquqonZ41yjmflNJkEJSkrJ8Pqs
         pn4FW0Ztr+Qd7i2CeObFX9lcNVUMIkEe5f6LsYlvadJDeou85/DAADHOk/pbdSednBqE
         Qm/z+bbJ7JidxEmCXhK+GDwuInYszuh8sSvlgnZ3U1SrqqD2p/VhCFTfUSvIcwD4IoQT
         F3wwwoxWk/Mmq4aCQV3Ui0WF2B0Ddy7Nd8v1UHs/YAy2XNqpEXoIDkY34ql88S1CenfO
         MGCA==
X-Forwarded-Encrypted: i=1; AJvYcCWUfZeg2MZ3mBbPBiLRLi3RO9YN7bu6O28AHsWke1fSkIW/9fX2nFyAG+NYj3fLxzWqa38TrI659euMqzayVkkoZXO5
X-Gm-Message-State: AOJu0YwbhduAbZLS6uaYQHnBbuV0ZxS2+3fLNZonRsm78ysDV/KnFOAN
	ulrgQ+YZMjBCp7DPFkHjX8RF8F08eStPSzPRc/trOpnKotEwns9hG4UPtWNzSIU=
X-Google-Smtp-Source: AGHT+IHTYTM/ab6LWd92gVTgFqoZ8pkRyG3eRSwtgT+QrdwknrAixxaF8EiUoizMwaSlRInCm1Bzjw==
X-Received: by 2002:a50:d5dd:0:b0:578:5245:3296 with SMTP id 4fb4d7f45d1cf-57a364480e7mr986562a12.28.1717152305251;
        Fri, 31 May 2024 03:45:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d30esm874646a12.73.2024.05.31.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:45:04 -0700 (PDT)
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
In-Reply-To: <d66d58f1-219e-450a-91fc-bd08337db77d@bytedance.com> (Feng Zhou's
	message of "Fri, 17 May 2024 15:27:11 +0800")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
	<87seyjwgme.fsf@cloudflare.com>
	<1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
	<87wmnty8yd.fsf@cloudflare.com>
	<d66d58f1-219e-450a-91fc-bd08337db77d@bytedance.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 31 May 2024 12:45:03 +0200
Message-ID: <875xuuxntc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 03:27 PM +08, Feng Zhou wrote:
> =E5=9C=A8 2024/5/17 01:15, Jakub Sitnicki =E5=86=99=E9=81=93:
>> On Thu, May 16, 2024 at 11:15 AM +08, Feng Zhou wrote:
>>> =E5=9C=A8 2024/5/15 17:48, Jakub Sitnicki =E5=86=99=E9=81=93:

[...]

>> If it's not the BPF prog, which you have ruled out, then where are we
>> burining cycles? Maybe that is something that can be improved.
>> Also, in terms on quantifying the improvement - it is 20% in terms of
>> what? Throughput, pps, cycles? And was that a single data point? For
>> multiple measurements there must be some variance (+/- X pp).
>> Would be great to see some data to back it up.
>> [...]
>>=20
>
> Pressure measurement method:
>
> server: sockperf sr --tcp -i x.x.x.x -p 7654 --daemonize
> client: taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
>
> Default mode, no bpf prog:
>
> taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
> sockperf: =3D=3D version #3.10-23.gited92afb185e6 =3D=3D
> sockperf[CLIENT] send on:
> [ 0] IP =3D x.x.x.x    PORT =3D  7654 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: Total of 71520808 messages sent in 30.000 sec
>
> sockperf: NOTE: test was performed, using msg-size=3D1200. For getting ma=
ximum
> throughput consider using --msg-size=3D1472
> sockperf: Summary: Message Rate is 2384000 [msg/sec]
> sockperf: Summary: BandWidth is 2728.271 MBps (21826.172 Mbps)
>
> perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
> perf report
>
> 80.88%--sock_sendmsg
>  79.53%--tcp_sendmsg
>   42.48%--tcp_sendmsg_locked
>    16.23%--_copy_from_iter
>    4.24%--tcp_send_mss
>     3.25%--tcp_current_mss
>
>
> perf top -C 8
>
> 19.13%  [kernel]            [k] _raw_spin_lock_bh
> 11.75%  [kernel]            [k] copy_user_enhanced_fast_string
>  9.86%  [kernel]            [k] tcp_sendmsg_locked
>  4.44%  sockperf            [.]
>  _Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
>  4.16%  libpthread-2.28.so  [.] __libc_sendto
>  3.85%  [kernel]            [k] syscall_return_via_sysret
>  2.70%  [kernel]            [k] _copy_from_iter
>  2.48%  [kernel]            [k] entry_SYSCALL_64
>  2.33%  [kernel]            [k] native_queued_spin_lock_slowpath
>  1.89%  [kernel]            [k] __virt_addr_valid
>  1.77%  [kernel]            [k] __check_object_size
>  1.75%  [kernel]            [k] __sys_sendto
>  1.74%  [kernel]            [k] entry_SYSCALL_64_after_hwframe
>  1.42%  [kernel]            [k] __fget_light
>  1.28%  [kernel]            [k] tcp_push
>  1.01%  [kernel]            [k] tcp_established_options
>  0.97%  [kernel]            [k] tcp_send_mss
>  0.94%  [kernel]            [k] syscall_exit_to_user_mode_prepare
>  0.94%  [kernel]            [k] tcp_sendmsg
>  0.86%  [kernel]            [k] tcp_current_mss
>
> Having bpf prog to write tcp opt in all pkts:
>
> taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
> sockperf: =3D=3D version #3.10-23.gited92afb185e6 =3D=3D
> sockperf[CLIENT] send on:
> [ 0] IP =3D x.x.x.x    PORT =3D  7654 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: Total of 60636218 messages sent in 30.000 sec
>
> sockperf: NOTE: test was performed, using msg-size=3D1200. For getting ma=
ximum
> throughput consider using --msg-size=3D1472
> sockperf: Summary: Message Rate is 2021185 [msg/sec]
> sockperf: Summary: BandWidth is 2313.063 MBps (18504.501 Mbps)
>
> perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
> perf report
>
> 80.30%--sock_sendmsg
>  79.02%--tcp_sendmsg
>   54.14%--tcp_sendmsg_locked
>    12.82%--_copy_from_iter
>    12.51%--tcp_send_mss
>     11.77%--tcp_current_mss
>      10.10%--tcp_established_options
>       8.75%--bpf_skops_hdr_opt_len.isra.54
>        5.71%--__cgroup_bpf_run_filter_sock_ops
>         3.32%--bpf_prog_e7ccbf819f5be0d0_tcpopt
>   6.61%--__tcp_push_pending_frames
>    6.60%--tcp_write_xmit
>     5.89%--__tcp_transmit_skb
>
> perf top -C 8
>
> 10.98%  [kernel]                           [k] _raw_spin_lock_bh
>  9.04%  [kernel]                           [k] copy_user_enhanced_fast_st=
ring
>  7.78%  [kernel]                           [k] tcp_sendmsg_locked
>  3.91%  sockperf                           [.]
>  _Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
>  3.46%  libpthread-2.28.so                 [.] __libc_sendto
>  3.35%  [kernel]                           [k] syscall_return_via_sysret
>  2.86%  [kernel]                           [k] bpf_skops_hdr_opt_len.isra=
.54
>  2.16%  [kernel]                           [k] __htab_map_lookup_elem
>  2.11%  [kernel]                           [k] _copy_from_iter
>  2.09%  [kernel]                           [k] entry_SYSCALL_64
>  1.97%  [kernel]                           [k] __virt_addr_valid
>  1.95%  [kernel]                           [k] __cgroup_bpf_run_filter_so=
ck_ops
>  1.95%  [kernel]                           [k] lookup_nulls_elem_raw
>  1.89%  [kernel]                           [k] __fget_light
>  1.42%  [kernel]                           [k] __sys_sendto
>  1.41%  [kernel]                           [k] entry_SYSCALL_64_after_hwf=
rame
>  1.31%  [kernel]                           [k] native_queued_spin_lock_sl=
owpath
>  1.22%  [kernel]                           [k] __check_object_size
>  1.18%  [kernel]                           [k] tcp_established_options
>  1.04%  bpf_prog_e7ccbf819f5be0d0_tcpopt   [k] bpf_prog_e7ccbf819f5be0d0_=
tcpopt
>
> Compare the above test results, fill up a CPU, you can find that
> the upper limit of qps or BandWidth has a loss of nearly 18-20%.
> Then CPU occupancy, you can find that "tcp_send_mss" has increased
> significantly.

This helps prove the point, but what I actually had in mind is to check
"perf annotate bpf_skops_hdr_opt_len" and see if there any low hanging
fruit there which we can optimize.

For instance, when I benchmark it in a VM, I see we're spending cycles
mostly memset()/rep stos. I have no idea where the cycles are spent in
your case.

>
>>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linu=
x/bpf.h
>>>>> index 90706a47f6ff..f2092de1f432 100644
>>>>> --- a/tools/include/uapi/linux/bpf.h
>>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>>> @@ -6892,8 +6892,14 @@ enum {
>>>>>    	 * options first before the BPF program does.
>>>>>    	 */
>>>>>    	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
>>>>> +	/* Fast path to reserve space in a skb under
>>>>> +	 * sock_ops->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>>>>> +	 * opt length doesn't change often, so it can save in the tcp_sock.=
 And
>>>>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>>>>> +	 */
>>>>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG =3D (1<<7),
>>>> Have you considered a bpf_reserve_hdr_opt() flag instead?
>>>> An example or test coverage would to show this API extension in action
>>>> would help.
>>>>
>>>
>>> bpf_reserve_hdr_opt () flag can't finish this. I want to optimize
>>> that bpf prog will not be triggered frequently before TSO. Provide
>>> a way for users to not trigger bpf prog when opt len is unchanged.
>>> Then when writing opt, if len changes, clear the flag, and then
>>> change opt len in the next package.
>> I haven't seen a sample using the API extenstion that you're proposing,
>> so I can only guess. But you probably have something like:
>> SEC("sockops")
>> int sockops_prog(struct bpf_sock_ops *ctx)
>> {
>> 	if (ctx->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
>> 	    ctx->args[0] =3D=3D BPF_WRITE_HDR_TCP_CURRENT_MSS) {
>> 		bpf_reserve_hdr_opt(ctx, N, 0);
>> 		bpf_sock_ops_cb_flags_set(ctx,
>> 					  ctx->bpf_sock_ops_cb_flags |
>> 					  MY_NEW_FLAG);
>> 		return 1;
>> 	}
>> }
>
> Yes, that's what I expected.
>
>> I don't understand why you're saying it can't be transformed into:
>> int sockops_prog(struct bpf_sock_ops *ctx)
>> {
>> 	if (ctx->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
>> 	    ctx->args[0] =3D=3D BPF_WRITE_HDR_TCP_CURRENT_MSS) {
>> 		bpf_reserve_hdr_opt(ctx, N, MY_NEW_FLAG);
>> 		return 1;
>> 	}
>> }
>
> "bpf_reserve_hdr_opt (ctx, N, MY_NEW_FLAG);"
>
> I don't know what I can do to pass the flag parameter, let
> "bpf_reserve_hdr_opt" return quickly? But this is not useful,
> because the loss caused by the triggering of bpf prog is very
> expensive, and it is still on the hotspot function of sending
> packets, and the TSO has not been completed yet.
>
>> [...]

This is not what I'm suggesting.

bpf_reserve_hdr_opt() has access to bpf_sock_ops_kern and even the
sock. You could either signal through bpf_sock_ops_kern to
bpf_skops_hdr_opt_len() that it should not be called again

Or even configure the tcp_sock directly from bpf_reserve_hdr_opt()
because it has access to it via bpf_sock_ops_kern{}.sk.

