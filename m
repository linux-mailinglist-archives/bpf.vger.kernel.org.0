Return-Path: <bpf+bounces-29916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F428C8163
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF53C2820C6
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA81757D;
	Fri, 17 May 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BKB5esPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A71171CD
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930844; cv=none; b=CQz0sLDi2EIrIlKb641D5WW7MRGOYgS+jD7kwzV5B+hm2liNsz5bR3B3ruamwnD8mz9qntmMBl2xrbOXG2Kkfx0dPXdx0f9354ufyukho70FELHv6cvcUS7GM2Nd1SarsfgxqrHulDzhWu+J2g6ZcPpsFCzT9ts+OJ+84tqZQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930844; c=relaxed/simple;
	bh=RoTjP1lAKKQthfI95ybYQcDv9MmIhNspMO0xKgYegwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlcVD6hCZ0R55VP57yP+9078QrT6GEG8mS21afHjxntDJ7MoKi7bIle7DPsB8eOYRUJ5h59Uz3wzr/L6VyRtKnxvbtP0geDhJeFfOy4sxVfKD9kPCZ90TQfQqPB3Rn/NgZtUqzm3A/JoTfxhXE4W6ZKbEqcpUSZDMjRS1N8n17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BKB5esPM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4302187c0so748965b3a.1
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715930841; x=1716535641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpkUquLcJq6T79Qn3SFHtFMU83iODzpP8Vyqkv9V9do=;
        b=BKB5esPMI6j+xQMKjoqbAJe6ceAxDEECwdh4Mejti3WU01MmIciFQe8KPJbhFOPuVF
         78PhDcVGxR6rh10Hp6Bj7tQTn0fuhHUUGGFl+npos+3pdgVUorv3mRZnxBfL76WeK4wV
         QGB45rQ7faJz6RGg9ilbuiYgGTBpNmg12RY4NrG2lCe6FGFjyiFaWyddAqIUKHEEqvOw
         dKjKhzRsFq8HgE8DXQWOkEZYP0C0AEEjgHjgAU/VRsfLQb9H1069RJ27oHuLLLBqOuHx
         pleMRQPDzSBzwCVnvfUjOC/cUrfwV1WHtQ1pcpFFT4EdCMG2c35hZNVBP+asLhhj5eEC
         CdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930841; x=1716535641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpkUquLcJq6T79Qn3SFHtFMU83iODzpP8Vyqkv9V9do=;
        b=OHbV0AJa9e4gwgquwynOzXrgZoEso6i+76Sh55oVB8x1SfCX23TkArtt9VA6OX+/8O
         BhdeZcEdzurdYCFtpzJKp/C5LRqjQyUYorIIxkkzAATo6jd7srmRzOyYIlzK53pJbotz
         J5nKvyAbLF+sICfuMZiRFx3aH0avJ0nufNp/Fcfke40biEUrN17eYssgQHuVp0Gt7s/L
         FmYjhhpqa5PJCXEatCc/5coB5Wja8Irr3litI+31Z7G+KKGVTPEzgBqI0vxn4CzSTogw
         tGKZOUtZ/MfWgW8g7kDTdwqfHwzl0tPmEIuCBiOU15MjDg4QcHb6dZTbH4+tk71n29Dh
         7Cfg==
X-Forwarded-Encrypted: i=1; AJvYcCWK6afXQ126pXpWR+8km4zm6ykVEKPWV2WJlVpsNQ37IeiwC1OLvf927bt/kIJr+03NbuxOrDTgfUu4vRGZTuk+pGQA
X-Gm-Message-State: AOJu0YxkLTt16E3FyFiuxMxz/sx85Wh74BkQS+TxhS9+mYGI0qIE/1Uh
	vY61oVWVr5abBPfMy8D9TYZewqh8QW8hz7ulcK0kTYP4X3vBF1BYHy729reg77Q=
X-Google-Smtp-Source: AGHT+IFYfkReq3qTdal5aWvWN6d8Yh92XZktlWipnwnGwiPQXzV2gBrKeGqo7Nary0FgR8seqEkX4A==
X-Received: by 2002:a05:6a20:a115:b0:1ac:3d3c:c1e7 with SMTP id adf61e73a8af0-1afd142f92bmr40384050637.12.1715930841398;
        Fri, 17 May 2024 00:27:21 -0700 (PDT)
Received: from [10.84.154.38] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b862572sm12750732a12.37.2024.05.17.00.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 00:27:21 -0700 (PDT)
Message-ID: <d66d58f1-219e-450a-91fc-bd08337db77d@bytedance.com>
Date: Fri, 17 May 2024 15:27:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt
 performance
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 laoar.shao@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
 <87seyjwgme.fsf@cloudflare.com>
 <1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
 <87wmnty8yd.fsf@cloudflare.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <87wmnty8yd.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/5/17 01:15, Jakub Sitnicki 写道:
> On Thu, May 16, 2024 at 11:15 AM +08, Feng Zhou wrote:
>> 在 2024/5/15 17:48, Jakub Sitnicki 写道:
>>> On Wed, May 15, 2024 at 04:19 PM +08, Feng zhou wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Set the full package write tcp option, the test found that the loss
>>>> will be 20%. If a package wants to write tcp option, it will trigger
>>>> bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
>>>> call "tcp_established_options" to reserve tcp opt len, call
>>>> "bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
>>>> TSO. Through bpftrace tracking, it was found that during the pressure
>>>> test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
>>>> len does not change often, consider caching opt len for optimization.
>>> You could also make your BPF sock_ops program cache the value and return
>>> the cached value when called for BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>>> If that is in your opinion prohibitevely expensive then it would be good
>>> to see a sample program and CPU cycle measurements (bpftool prog profile).
>>>
>>
>> I'm not referring to the overhead introduced by the time-consuming
>> operation of bpf prog. I have tested that bpf prog does nothing and
>> returns directly, and the loss is still 20%. During the pressure test
>> process, "tcp_send_mss" and "__tcp_transmit_skb" the call frequency per
>> second
>>
>> @[
>>      bpf_skops_hdr_opt_len.isra.46+1
>>      tcp_established_options+730
>>      tcp_current_mss+81
>>      tcp_send_mss+23
>>      tcp_sendmsg_locked+285
>>      tcp_sendmsg+58
>>      sock_sendmsg+48
>>      sock_write_iter+151
>>      new_sync_write+296
>>      vfs_write+165
>>      ksys_write+89
>>      do_syscall_64+89
>>      entry_SYSCALL_64_after_hwframe+68
>> ]: 3671671
>>
>> @[
>>      bpf_skops_write_hdr_opt.isra.47+1
>>      __tcp_transmit_skb+761
>>      tcp_write_xmit+822
>>      __tcp_push_pending_frames+52
>>      tcp_close+813
>>      inet_release+60
>>      __sock_release+55
>>      sock_close+17
>>      __fput+179
>>      task_work_run+112
>>      exit_to_usermode_loop+245
>>      do_syscall_64+456
>>      entry_SYSCALL_64_after_hwframe+68
>> ]: 36125
>>

Sorry, The call stack here is copied incorrectly, it is this one.

     bpf_skops_write_hdr_opt.isra.47+1
     __tcp_transmit_skb+761
     tcp_write_xmit+822
     __tcp_push_pending_frames+52
     tcp_sendmsg_locked+3324
     tcp_sendmsg+58
     sock_sendmsg+48
     sock_write_iter+151
     new_sync_write+296
     vfs_write+165
     ksys_write+89
     do_syscall_64+89
     entry_SYSCALL_64_after_hwframe+68

>> "tcp_send_mss" before TSO, without packet aggregation, and
>> "__tcp_transmit_skb" after TSO, the gap between the two is
>> 100 times.
> 
> All right, we are getting somewhere.
> 
> So in your workload bpf_skops_hdr_opt_len more times that you like.
> And you have determined that by memoizing the BPF
> skops/BPF_SOCK_OPS_HDR_OPT_LEN_CB result and skipping over part of
> tcp_established_options you get a performance boost.
> 
> Did you first check with perf record to which ops in
> tcp_established_options are taking up so many cycles?
> 

bpftrace -e 'k:__cgroup_bpf_run_filter_sock_ops { @[((struct 
bpf_sock_ops_kern *)arg1)->op, ((struct bpf_sock_ops_kern 
*)arg1)->args[0]]=count(); } i:s:1 { print(@); clear(@); }' --include 
'linux/filter.h'

@[12, 0]: 2003
@[15, 0]: 40952
@[14, 0]: 40953
@[14, 1]: 1512647

@[12, 0]: 5580
@[15, 0]: 45686
@[14, 0]: 45687
@[14, 1]: 1481577

BPF_SOCK_OPS_HDR_OPT_LEN_CB   14
BPF_SOCK_OPS_WRITE_HDR_OPT_CB 15

BPF_WRITE_HDR_TCP_CURRENT_MSS = 1

It can be found that the frequency of bpf prog "BPF_SOCK_OPS_HDR_OPT_LEN_CB"
triggered by "BPF_WRITE_HDR_TCP_CURRENT_MSS"
is very high during the pressure test, because
"tcp_send_mss" call is before TSO, and the package
has not been pooled.


> If it's not the BPF prog, which you have ruled out, then where are we
> burining cycles? Maybe that is something that can be improved.
> 
> Also, in terms on quantifying the improvement - it is 20% in terms of
> what? Throughput, pps, cycles? And was that a single data point? For
> multiple measurements there must be some variance (+/- X pp).
> 
> Would be great to see some data to back it up.
> 
> [...]
> 

Pressure measurement method:

server: sockperf sr --tcp -i x.x.x.x -p 7654 --daemonize
client: taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30

Default mode, no bpf prog:

taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
sockperf: == version #3.10-23.gited92afb185e6 ==
sockperf[CLIENT] send on:
[ 0] IP = x.x.x.x    PORT =  7654 # TCP
sockperf: Warmup stage (sending a few dummy messages)...
sockperf: Starting test...
sockperf: Test end (interrupted by timer)
sockperf: Test ended
sockperf: Total of 71520808 messages sent in 30.000 sec

sockperf: NOTE: test was performed, using msg-size=1200. For getting 
maximum throughput consider using --msg-size=1472
sockperf: Summary: Message Rate is 2384000 [msg/sec]
sockperf: Summary: BandWidth is 2728.271 MBps (21826.172 Mbps)

perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
perf report

80.88%--sock_sendmsg
  79.53%--tcp_sendmsg
   42.48%--tcp_sendmsg_locked
    16.23%--_copy_from_iter
    4.24%--tcp_send_mss
     3.25%--tcp_current_mss


perf top -C 8

19.13%  [kernel]            [k] _raw_spin_lock_bh
11.75%  [kernel]            [k] copy_user_enhanced_fast_string
  9.86%  [kernel]            [k] tcp_sendmsg_locked
  4.44%  sockperf            [.] 
_Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
  4.16%  libpthread-2.28.so  [.] __libc_sendto
  3.85%  [kernel]            [k] syscall_return_via_sysret
  2.70%  [kernel]            [k] _copy_from_iter
  2.48%  [kernel]            [k] entry_SYSCALL_64
  2.33%  [kernel]            [k] native_queued_spin_lock_slowpath
  1.89%  [kernel]            [k] __virt_addr_valid
  1.77%  [kernel]            [k] __check_object_size
  1.75%  [kernel]            [k] __sys_sendto
  1.74%  [kernel]            [k] entry_SYSCALL_64_after_hwframe
  1.42%  [kernel]            [k] __fget_light
  1.28%  [kernel]            [k] tcp_push
  1.01%  [kernel]            [k] tcp_established_options
  0.97%  [kernel]            [k] tcp_send_mss
  0.94%  [kernel]            [k] syscall_exit_to_user_mode_prepare
  0.94%  [kernel]            [k] tcp_sendmsg
  0.86%  [kernel]            [k] tcp_current_mss

Having bpf prog to write tcp opt in all pkts:

taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
sockperf: == version #3.10-23.gited92afb185e6 ==
sockperf[CLIENT] send on:
[ 0] IP = x.x.x.x    PORT =  7654 # TCP
sockperf: Warmup stage (sending a few dummy messages)...
sockperf: Starting test...
sockperf: Test end (interrupted by timer)
sockperf: Test ended
sockperf: Total of 60636218 messages sent in 30.000 sec

sockperf: NOTE: test was performed, using msg-size=1200. For getting 
maximum throughput consider using --msg-size=1472
sockperf: Summary: Message Rate is 2021185 [msg/sec]
sockperf: Summary: BandWidth is 2313.063 MBps (18504.501 Mbps)

perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
perf report

80.30%--sock_sendmsg
  79.02%--tcp_sendmsg
   54.14%--tcp_sendmsg_locked
    12.82%--_copy_from_iter
    12.51%--tcp_send_mss
     11.77%--tcp_current_mss
      10.10%--tcp_established_options
       8.75%--bpf_skops_hdr_opt_len.isra.54
        5.71%--__cgroup_bpf_run_filter_sock_ops
         3.32%--bpf_prog_e7ccbf819f5be0d0_tcpopt
   6.61%--__tcp_push_pending_frames
    6.60%--tcp_write_xmit
     5.89%--__tcp_transmit_skb

perf top -C 8

10.98%  [kernel]                           [k] _raw_spin_lock_bh
  9.04%  [kernel]                           [k] 
copy_user_enhanced_fast_string
  7.78%  [kernel]                           [k] tcp_sendmsg_locked
  3.91%  sockperf                           [.] 
_Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
  3.46%  libpthread-2.28.so                 [.] __libc_sendto
  3.35%  [kernel]                           [k] syscall_return_via_sysret
  2.86%  [kernel]                           [k] 
bpf_skops_hdr_opt_len.isra.54
  2.16%  [kernel]                           [k] __htab_map_lookup_elem
  2.11%  [kernel]                           [k] _copy_from_iter
  2.09%  [kernel]                           [k] entry_SYSCALL_64
  1.97%  [kernel]                           [k] __virt_addr_valid
  1.95%  [kernel]                           [k] 
__cgroup_bpf_run_filter_sock_ops
  1.95%  [kernel]                           [k] lookup_nulls_elem_raw
  1.89%  [kernel]                           [k] __fget_light
  1.42%  [kernel]                           [k] __sys_sendto
  1.41%  [kernel]                           [k] 
entry_SYSCALL_64_after_hwframe
  1.31%  [kernel]                           [k] 
native_queued_spin_lock_slowpath
  1.22%  [kernel]                           [k] __check_object_size
  1.18%  [kernel]                           [k] tcp_established_options
  1.04%  bpf_prog_e7ccbf819f5be0d0_tcpopt   [k] 
bpf_prog_e7ccbf819f5be0d0_tcpopt

Compare the above test results, fill up a CPU, you can find that
the upper limit of qps or BandWidth has a loss of nearly 18-20%.
Then CPU occupancy, you can find that "tcp_send_mss" has increased 
significantly.

>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>>> index 90706a47f6ff..f2092de1f432 100644
>>>> --- a/tools/include/uapi/linux/bpf.h
>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>> @@ -6892,8 +6892,14 @@ enum {
>>>>    	 * options first before the BPF program does.
>>>>    	 */
>>>>    	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
>>>> +	/* Fast path to reserve space in a skb under
>>>> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>>>> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
>>>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>>>> +	 */
>>>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
>>> Have you considered a bpf_reserve_hdr_opt() flag instead?
>>> An example or test coverage would to show this API extension in action
>>> would help.
>>>
>>
>> bpf_reserve_hdr_opt () flag can't finish this. I want to optimize
>> that bpf prog will not be triggered frequently before TSO. Provide
>> a way for users to not trigger bpf prog when opt len is unchanged.
>> Then when writing opt, if len changes, clear the flag, and then
>> change opt len in the next package.
> 
> I haven't seen a sample using the API extenstion that you're proposing,
> so I can only guess. But you probably have something like:
> 
> SEC("sockops")
> int sockops_prog(struct bpf_sock_ops *ctx)
> {
> 	if (ctx->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
> 	    ctx->args[0] == BPF_WRITE_HDR_TCP_CURRENT_MSS) {
> 		bpf_reserve_hdr_opt(ctx, N, 0);
> 		bpf_sock_ops_cb_flags_set(ctx,
> 					  ctx->bpf_sock_ops_cb_flags |
> 					  MY_NEW_FLAG);
> 		return 1;
> 	}
> }

Yes, that's what I expected.

> 
> I don't understand why you're saying it can't be transformed into:
> 
> int sockops_prog(struct bpf_sock_ops *ctx)
> {
> 	if (ctx->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
> 	    ctx->args[0] == BPF_WRITE_HDR_TCP_CURRENT_MSS) {
> 		bpf_reserve_hdr_opt(ctx, N, MY_NEW_FLAG);
> 		return 1;
> 	}
> }

"bpf_reserve_hdr_opt (ctx, N, MY_NEW_FLAG);"

I don't know what I can do to pass the flag parameter, let
"bpf_reserve_hdr_opt" return quickly? But this is not useful,
because the loss caused by the triggering of bpf prog is very
expensive, and it is still on the hotspot function of sending
packets, and the TSO has not been completed yet.

> 
> [...]


