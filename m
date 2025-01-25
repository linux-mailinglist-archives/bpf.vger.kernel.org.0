Return-Path: <bpf+bounces-49764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C45A1C108
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 06:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134113A988C
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 05:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185BE207A0C;
	Sat, 25 Jan 2025 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnzrRrOQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268172582;
	Sat, 25 Jan 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737782712; cv=none; b=EOV7n+hz5fEtVask7POf8B/NMyzfYd8CfCHCeE8q6zNtcmtsN5MxhTJCgArHhXQRUvSoOIrCJi87rx03N/gkHoUaIlLZQkjPANegRWVuzJRYzQoYz+aPaSaHL+kp4EIjfCbCxZVKe2Kohj4sv7VKLSF2Gx7XjovWGE+kSwhUVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737782712; c=relaxed/simple;
	bh=7GaXwBaMTNz7QsHoI0hOmYJ3MRj/002l/EBAzzP+oYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpngt8l2UnY4N3orTXMeKK4UAmnp+oGfvnW7SbfcyRrq10YI/3VLlmb6l86x5YzK6N/6ucG6/3jCxJAQNHi0hNOqHnwD5RcJjJUpPx5L02tZXtqyIyslNQd4jZJyIfFw/NSBagnU4UnbsQPeXFBnCKZELUkEG+xycBkdKvEu0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnzrRrOQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so5211915a91.0;
        Fri, 24 Jan 2025 21:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737782710; x=1738387510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSSTIOL0i8k8ok3WPoUFyCTMS5T9Rt15wlkg9Dm8NG4=;
        b=WnzrRrOQsLaqvIOwtwjPqYTZHgIkt6XKtWBujo+Igocp+FXnsEVWNO9AI5jn7G55yM
         Xi3xxBKutL+Ygrc/aw72S+Nh/VtMObaM7xFejm1526EASAV5yOYUqMPpKe8xeKtye6GS
         7kDkbEax/R6uo66WkPg03BcziuBniEVzQa72jY4eHGh2B91k39TYQUPrPQhhodXaaJgU
         nColPYmJCeJ/c6aI7FqzP1GuTxQwNItkJEbzxB38iLxucOk4O21QiQ+hETBUAPcqewfn
         twQEYfSYhPCx6lfRFmP90/wZigpI/7AHPqB96ONQrtD+EIT0Sw1TxX06YoMtb4kiNZ35
         lHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737782710; x=1738387510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSSTIOL0i8k8ok3WPoUFyCTMS5T9Rt15wlkg9Dm8NG4=;
        b=xTQ3kOmjuay7sk6KQ2Fjl7O6ZXrIkH7p+Jg2o2gEE0ITdTY+jyevBkPGxYuxScg9PB
         WYu+UyTiAQLreITieMcLpRpkqlexnG0PtQL9P2muiq39nTQvfHNCAqM3OFk+jdn9oNlT
         Ea2F9YiT7OyFwvdOUlQ2s+fa1BN7+q9ifhLMTQkfKpO9V7qAWqj6qSilNc+80oZEcZZ2
         vkRH6qsomMmgAcGDBsN85S5DrzpjtN2lF90lRShpyPgfFZ04zhhhj670aVBGh8E/RR4U
         U1OssqwWJCzGUSDvTDqr/jvdqzD8eo0GlVughq3h0e/3vVl9zcrFrzCot/6d2JQBgjmy
         1PLw==
X-Forwarded-Encrypted: i=1; AJvYcCWranDp627rUDgo/qWkgKF9fosaRj3DwvzCTtc789GkwQ3U5OmC8a4wqS3JQhGPQcbmcqNtxYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkLdbbdPQF367WP2bXLF0ubSrtivxdsohNlqVZCLF/hUThbEs
	WJjKOMB15j64N/mZdzvkzIu9HLGqBzpoOMuFnyaL6BGia9TYUXRR
X-Gm-Gg: ASbGncuS/gCtuz6XNLBSvASXcnYpDXn8mR2wHrRqG8WTltYlqQlPxyFm99agdjMOLTG
	ojjudp5tM22BBA0qy9pq4Mz5VpEAHv5bVfbLTDmFZUSoQfaH+ke82t9EXFrABb7whDMqZPwDvJK
	P3b5U0Gh5Gdxbff6oa1Q4T358KDFgbfSb8ChUeQFrGPKbcJEihTvL7nWK6Rw06FdkBWS+0RQ7IO
	BG6Jev2PvNUkP13pzRMAdlB2+CgnElrqTF39UjzEm/AO+F3WKH4OspMukIyo4Yn+omNHwd3u8Tq
	VOmkeA==
X-Google-Smtp-Source: AGHT+IFq/aJZjajPErKiYz+/prB7gSGb5LGY157NzZABtyZKeFWx7pwWYjUCU4p2pqdMjjNIQGmg3g==
X-Received: by 2002:a17:90a:e18f:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-2f782c674c1mr43610792a91.3.1737782710082;
        Fri, 24 Jan 2025 21:25:10 -0800 (PST)
Received: from gmail.com ([98.97.36.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa82ce5sm2684408a91.42.2025.01.24.21.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 21:25:09 -0800 (PST)
Date: Fri, 24 Jan 2025 21:24:48 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: fix ktls panic
Message-ID: <gkx7axo3mau4jb7ojsdl4lwrtkuxsbnozplupscl3vvl3zfqg5@qnc5qfwzcwlj>
References: <20250123171552.57345-1-mrpre@163.com>
 <20250123171552.57345-2-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123171552.57345-2-mrpre@163.com>

On 2025-01-24 01:15:51, Jiayuan Chen wrote:
> [ 2172.936997] ------------[ cut here ]------------
> [ 2172.936999] kernel BUG at lib/iov_iter.c:629!
> ......
> [ 2172.944996] PKRU: 55555554
> [ 2172.945155] Call Trace:
> [ 2172.945299]  <TASK>
> [ 2172.945428]  ? die+0x36/0x90
> [ 2172.945601]  ? do_trap+0xdd/0x100
> [ 2172.945795]  ? iov_iter_revert+0x178/0x180
> [ 2172.946031]  ? iov_iter_revert+0x178/0x180
> [ 2172.946267]  ? do_error_trap+0x7d/0x110
> [ 2172.946499]  ? iov_iter_revert+0x178/0x180
> [ 2172.946736]  ? exc_invalid_op+0x50/0x70
> [ 2172.946961]  ? iov_iter_revert+0x178/0x180
> [ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
> [ 2172.947446]  ? iov_iter_revert+0x178/0x180
> [ 2172.947683]  ? iov_iter_revert+0x5c/0x180
> [ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
> [ 2172.948206]  tls_sw_sendmsg+0x52/0x80
> [ 2172.948420]  ? inet_sendmsg+0x1f/0x70
> [ 2172.948634]  __sys_sendto+0x1cd/0x200
> [ 2172.948848]  ? find_held_lock+0x2b/0x80
> [ 2172.949072]  ? syscall_trace_enter+0x140/0x270
> [ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
> [ 2172.949595]  ? find_held_lock+0x2b/0x80
> [ 2172.949817]  ? syscall_trace_enter+0x140/0x270
> [ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
> [ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
> [ 2172.951036]  __x64_sys_sendto+0x24/0x30
> [ 2172.951382]  do_syscall_64+0x90/0x170
> ......
> 
> After calling bpf_exec_tx_verdict(), the size of msg_pl->sg may increase,
> e.g., when the BPF program executes bpf_msg_push_data().
> 
> If the BPF program sets cork_bytes and sg.size is smaller than cork_bytes,
> it will return -ENOSPC and attempt to roll back to the non-zero copy
> logic. However, during rollback, msg->msg_iter is reset, but since
> msg_pl->sg.size has been increased, subsequent executions will exceed the
> actual size of msg_iter.
> '''
> iov_iter_revert(&msg->msg_iter, msg_pl->sg.size - orig_size);
> '''
> 
> The changes in this commit are based on the following considerations:
> 
> 1. When cork_bytes is set, rolling back to non-zero copy logic is
> pointless and can directly go to zero-copy logic.
> 
> 2. Suppose sg.size is initially 5, and we push it to 100, setting
> apply_bytes to 7. Then, 98 bytes of data are sent out, leaving 2 bytes to
> be processed. The rollback logic cannot determine which data has been
> processed and which hasn't.

This is the error path we are talking about correct?

        if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
            !enospc && !full_record) {
                err = -ENOSPC;
                goto out_err;
        }

> 
> This current change is based on the principle of minimal modification,
> which won't make things worse. If we still encounter similar panic
> further, we can consider a more comprehensive solution.
> 
> Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  net/tls/tls_sw.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 7bcc9b4408a2..b3cae4dd4f49 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  					num_async++;
>  				else if (ret == -ENOMEM)
>  					goto wait_for_memory;
> -				else if (ctx->open_rec && ret == -ENOSPC)
> +				else if (ctx->open_rec && ret == -ENOSPC) {
> +					if (msg_pl->cork_bytes) {
> +						ret = 0;
> +						goto send_end;
> +					}

The app will lose bytes here I suspect if we return copied == try_to_copy then
no error makes it to the user?

Could we return delta from bpf_exec_tx_verdict and then we can calculate
the correct number of bytes to revert? I'll need to check but its not
clear to me if BPF program pushes data that the right thing is done with
delta there now.

Thanks for looking into this.

