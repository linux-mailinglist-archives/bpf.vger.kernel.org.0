Return-Path: <bpf+bounces-34172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B392ACDF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8F1C21789
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B3A21;
	Tue,  9 Jul 2024 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AoS4ft1p"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9532BAE1
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483455; cv=none; b=mvVG0N7sHFs6ap0mWjuktFaUjFm7IqkeWS5ri9Z8s6KlvUcMFDhjRlGC6NVfUMq/h6HAlnm7chPSx2CmeS98ly7EWKEJJ5zrsgFtJoFGz4lYF0pEDxVREx5X950hg9xPryUrQdAGaAjeZD/0pN+0bHybeucjrT94OY0THqjv018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483455; c=relaxed/simple;
	bh=D1T3vzfM90DlsQPTel3t1UsNl07+U2CyLWc2quFay6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYyobT4KeqX4Dq3BG9j1MSPyYKQIdi/ZBzOzl8RbVcacppr1vS/giUHBVrhNEs1P0G991elZZvGxuM2bzzGhXBEDqvhJ70sC+2t6OCe3AGd56PbJneMkmTdMU7WNUhy+pnur/mMuxTKIefeCv6CHRWMJHA7UXxQ5rFaOKi0A+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AoS4ft1p; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720483449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vJ/5Uao0pdtVebeKV6kCXGjNtbGqBZuoy052SVeswE=;
	b=AoS4ft1pm0N+3AVfcq1YPYQdqb8WJESmIUQt/ITtKa71LugBFglvFcAg72ArssQwqm3izw
	b3CAqUG8MUy71BjltEyaB70vKCSU90XNoRs8s4gm4VONUscyfx4/xdpeL7D+t9GQc0+hQS
	hPSQHTIqXE+aZ9VyzyCTpJMDoXjoswE=
X-Envelope-To: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: davem@davemloft.net
X-Envelope-To: dsahern@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: sdf@google.com
X-Envelope-To: song@kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: tglx@linutronix.de
Message-ID: <82c77e30-6e9d-44c3-bdcd-7da17654fa81@linux.dev>
Date: Mon, 8 Jul 2024 17:03:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] seg6: Ensure that seg6_bpf_srh_states can only
 be accessed from input_action_end_bpf()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, Thomas Gleixner <tglx@linutronix.de>
References: <000000000000571681061bb9b5ad@google.com>
 <20240705104133.NU9AwKDS@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240705104133.NU9AwKDS@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/5/24 3:41 AM, Sebastian Andrzej Siewior wrote:
> Initially I assumed that the per-CPU variable is `seg6_bpf_srh_states'
> is first initialized in input_action_end_bpf() and then accessed during
> the bpf_prog_run_save_cb() invocation by the eBPF via the BPF callbacks.
> syzbot demonstrated that is possible to invoke the BPF callbacks (and
> access `seg6_bpf_srh_states') without entering input_action_end_bpf()
> first.
> 
> The valid path via input_action_end_bpf() is invoked within NAPI
> context which means it has bpf_net_context set. This can be used to
> identify the "valid" calling path.
> 
> Set in input_action_end_bpf() the BPF_RI_F_SEG6_STATE bit to signal the
> valid calling path and clear it at the end. Check for the context and
> the bit in bpf_lwt_seg6.*() and abort if missing.
> 
> Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
> Fixes: d1542d4ae4dfd ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/filter.h | 24 ++++++++++++++++++++++++
>   net/core/filter.c      |  6 ++++++
>   net/ipv6/seg6_local.c  |  3 +++
>   3 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 0bbd2585e6def..cadddb25ff4db 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -739,6 +739,7 @@ struct bpf_nh_params {
>   #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
>   #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
>   #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
> +#define BPF_RI_F_SEG6_STATE	BIT(5)
>   
>   struct bpf_redirect_info {
>   	u64 tgt_index;
> @@ -856,6 +857,29 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
>   		*lh_xsk = lh;
>   }
>   
> +static inline bool bpf_net_ctx_seg6_state_avail(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +
> +	if (!bpf_net_ctx)
> +		return false;
> +	return bpf_net_ctx->ri.kern_flags & BPF_RI_F_SEG6_STATE;
> +}
> +
> +static inline void bpf_net_ctx_seg6_state_set(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +
> +	bpf_net_ctx->ri.kern_flags |= BPF_RI_F_SEG6_STATE;
> +}
> +
> +static inline void bpf_net_ctx_seg6_state_clr(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +
> +	bpf_net_ctx->ri.kern_flags &= ~BPF_RI_F_SEG6_STATE;
> +}
> +
>   /* Compute the linear packet data range [data, data_end) which
>    * will be accessed by various program types (cls_bpf, act_bpf,
>    * lwt, ...). Subsystems allowing direct data access must (!)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 403d23faf22e1..ea5bc4a4a6a23 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6459,6 +6459,8 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
>   	void *srh_tlvs, *srh_end, *ptr;
>   	int srhoff = 0;
>   
> +	if (!bpf_net_ctx_seg6_state_avail())
> +		return -EINVAL;

The syzbot stack shows that the seg6local bpf_prog can be run by test_run like: 
bpf_prog_test_run_skb() => bpf_test_run(). "return -EINVAL;" will reject and 
break the existing bpf prog doing test with test_run.

bpf_test_run() has already done the local_bh_disable() and bpf_net_ctx_set(). 
How about doing the local_[un]lock_nested_bh(&seg6_bpf_srh_states.bh_lock) in 
bpf_test_run() when the prog->type == BPF_PROG_TYPE_LWT_SEG6LOCAL?

pw-bot: cr


