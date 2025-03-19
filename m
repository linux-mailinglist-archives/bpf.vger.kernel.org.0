Return-Path: <bpf+bounces-54425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BEA69CCE
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 00:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD97A222B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0A224246;
	Wed, 19 Mar 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI4VIG28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85C1991CB;
	Wed, 19 Mar 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427752; cv=none; b=SJD3djSRLl814vmS2LoaVhTGnXiIfZs0Vy+NBelZrqTMORsMZ7a1YQF2kpBWPqxJNH98270CgRxHSWmrhNWpWPMofOA7QXn8TOPU09uioYXRo7GIKxKPHK6Bh0qVRekCd4hrWBIGKEuAV6+zarPEaaXou9o8TXHGESKyZljNaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427752; c=relaxed/simple;
	bh=bt2ba/1aateD273zMpuBKHwx+vhYxn5LVtt6VAQmzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOH9jid9NHqo1D+t0wiHGmti95WThzE8EiWuMVNz30XtCESURtFTlnY9V6NJSNksxHDIuJyS2teI+XBCaVQnVnfY7rYI1jPOgbWfyz5WnkjuyhcC2LSZ19uK5omIhv55rPC5WCWAaKmfdOO18x2UiZJpa5wL3/N6qcKjDbWfjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI4VIG28; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225d66a4839so21223945ad.1;
        Wed, 19 Mar 2025 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742427750; x=1743032550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4BUXiAbtxDoW0HPX6dtOJ7c0QK5dcGl/NHAwfEJTQg=;
        b=FI4VIG28NlWxmr5B9Y73i6MrI92zVpSD4FHSKgGXXcYMpWAiOI1E3eHLHOMZoVO1qK
         97uf7XVNR3UZQgVjmaTMi1csJVlLTin3WcNpU/PxxrMW6rWIJQk0zrkcO7sDfHRO+kud
         OpBtNOl/o4826zkn/y6sPohqaEzrz0W8drGizdGP5undjAJoCHMUzGQFJuVV/hhYA/8V
         riTyirizMMm54soOnnvMTt7gZvlfnSm/g2v1hYGW9/CoEJzjVg7enLS2yP1l2s2+0D0g
         fNY/6E0Gnis4t16c5sTpu6gqZzW1pWwVM0pI6WD62uZu1eR3X5dO8VB03tkVYdb041g+
         zyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427750; x=1743032550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4BUXiAbtxDoW0HPX6dtOJ7c0QK5dcGl/NHAwfEJTQg=;
        b=jjn+ZwOOxBi8op1qBZKEb2m3AMw/zpGNAdcF152BQGwa5ruK962SzG3VPX7pNTIp+3
         4LZJvtLinIZvpVUK/i2dATtLjE5jvarFvOolBE8+AV3R/QqkL78YoIIG8Ar03fKODLPE
         YDe78AQCKbEUaSMLDpJT/ZmG+HUk+V/qyq2dYK79v5XNUYB2VWTxNY0OZI5/5rKQzr90
         VCHHXSzhKJ6uGZh9cSl3jrbwDCStOWYc7PoClqZtgLq0jkoPNgvmCarm7vEKYkkW3BLj
         /AftfiOqt8BJd9yL8PhU7S/dbUFBNVlBGeC/sjBJ6ilOwlO2N973LPDlT4Wh1I1Cw8UG
         Q/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWH68VjR5YrBqnv+TEBwvYUd93NgecupP6TLulK37cskNPb9uuiVkJT54PCsESj/TgnJDIYugpy@vger.kernel.org, AJvYcCWOtcCrrG735kpg/2Yb8BK6SK9xLmPxJXVeuPZsPFvZ7+aUyXvPk4yPIzEDgqCpNwqh52I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfBgfz3zdWoUrKHvk6hiNoTDTeRLL2F1d1Qd8pNXJ+fJzBblf
	Id9O2MmRDEqnnw+KF+04nCkoZjztRM4X58RQ3ALxXVxV9pnCqFED
X-Gm-Gg: ASbGncuzj5bK16A84IweeFsQ3+1Xu57aN+QOsFYKbIbjmZzIZBiRI7U6ooFJbOdP6rh
	fwJaBpK+P8swN9sRjxr1R1iqzesyI+1RrPy8Prd38Xawnx8oo1Foz1610vFIFzJ9A6P8FfbfoCW
	BJuHTdFTWVoCvDCgOnsFI799fO/JnI41w4/59fNpl7jltRatSOwa/SpEhQPT5hnZ7ONTpeVrwEH
	0LAjRsaPU7yJaHEsa+eERTlU5aD12fihXdcpYriSDJH2p+VNgmMuUOuzWBS7lTHjcP1UmLSX6+x
	tsqaVOWYUf9cC2FFINM1RlXopMcH2XKzu8WIUb9JCfOtveNm
X-Google-Smtp-Source: AGHT+IEw/4vULxTa1ySDtMivMJt2yRxJKSRbEdiqkxcYBqX3FVNtAkwNisew4VKeeY2ibmcOqngY8A==
X-Received: by 2002:a05:6a21:2d87:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1fd09c2c36bmr1867343637.15.1742427750144;
        Wed, 19 Mar 2025 16:42:30 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ddf4fsm11526155a12.21.2025.03.19.16.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:42:29 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:42:28 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
	willemb@google.com, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
	stfomichev@gmail.com, mrpre@163.com, zhangchangzhong@huawei.com,
	weiyongjun1@huawei.com
Subject: Re: [PATCH net 1/2] bpf, sockmap: Avoid sk_prot reset on sockmap
 unlink with ULP set
Message-ID: <Z9tWZPaidMB4uvQu@pop-os.localdomain>
References: <20250314082004.2369712-1-dongchenchen2@huawei.com>
 <20250314082004.2369712-2-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314082004.2369712-2-dongchenchen2@huawei.com>

On Fri, Mar 14, 2025 at 04:20:03PM +0800, Dong Chenchen wrote:
> WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
> Modules linked in:
> CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
> RIP: 0010:sock_map_close+0x3c4/0x480
> Call Trace:
>  <TASK>
>  inet_release+0x144/0x280
>  __sock_release+0xb8/0x270
>  sock_close+0x1e/0x30
>  __fput+0x3c6/0xb30
>  __fput_sync+0x7b/0x90
>  __x64_sys_close+0x90/0x120
>  do_syscall_64+0x5d/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is:
> bpf_prog_attach(BPF_SK_SKB_STREAM_VERDICT)
> tcp_set_ulp //set ulp after sockmap add
> 	icsk->icsk_ulp_ops = ulp_ops;
> sock_hash_update_common
>   sock_map_unref
>     sock_map_del_link
>       psock->psock_update_sk_prot(sk, psock, false);
> 	sk->sk_prot->close = sock_map_close
> sk_psock_drop
>   sk_psock_restore_proto
>     tcp_bpf_update_proto
>        tls_update //not redo sk_prot to tcp prot
> inet_release
>   sk->sk_prot->close
>     sock_map_close
>       WARN(sk->sk_prot->close == sock_map_close)

This makes sense now. Please see my comment below.

> 
> commit e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
> has moved ulp check from tcp_bpf_update_proto() to psock init.
> If sk sets ulp after being added to sockmap, it will reset sk_prot to
> BPF_BASE when removed from sockmap. After the psock is dropped, it will
> not reset sk_prot back to the tcp prot, only tls context update is
> performed. This can trigger a warning in sock_map_close() due to
> recursion of sk->sk_prot->close.
> 
> To fix this issue, skip the sk_prot operations redo when deleting link
> from sockmap if ULP is set.
> 
> Fixes: e34a07c0ae39 ("sock: redo the psock vs ULP protection check")
> Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  net/core/sock_map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 82a14f131d00..a3ed1f2cf8a2 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -170,7 +170,7 @@ static void sock_map_del_link(struct sock *sk,
>  		if (verdict_stop)
>  			sk_psock_stop_verdict(sk, psock);
>  
> -		if (psock->psock_update_sk_prot)
> +		if (!(sk_is_inet(sk) && inet_csk_has_ulp(sk)) && psock->psock_update_sk_prot)
>  			psock->psock_update_sk_prot(sk, psock, false);

Can we put this TCP-specific logic into tcp_bpf_update_proto() instead?

Something like this...

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4..0bb363447fc7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -708,6 +708,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
                return 0;
        }

+       if (inet_csk_has_ulp(sk))
+               return 0;
        if (sk->sk_family == AF_INET6) {
                if (tcp_bpf_assert_proto_ops(psock->sk_proto))
                        return -EINVAL;


