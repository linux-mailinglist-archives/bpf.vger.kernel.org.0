Return-Path: <bpf+bounces-43444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813809B5684
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471652846CD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2520B213;
	Tue, 29 Oct 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afVOPXaK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98620ADFC
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243262; cv=none; b=H/K8kKvh59Xbz13MgcWBV6F2DOpcchDPI8Hn/9j9Hrpth/2UvHvHlTNdRKMoQd7J5JM10pGtC/RIV/dj7955fpfWtObyUDL+NUUMqcKgGPjkJ8uyltikxDr1vuKJoC1KSGc94vwKwyKA7ibvAyaJhqW1xi0UMN1oWBU5B/i+aYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243262; c=relaxed/simple;
	bh=8DRQbAATaD43CYbFD+EyUGDtTq0lh56u/bukIF9DEns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncrztqR4E23dyTyYLQI57dZ3ZHg8BiUgtck2Iy8CzMTSWeO0Fzo4QsIWtfcW6fsSRr1VeRFbJ/p4nKPMSiSRzehHqZTk0ov3JWkx0694aZ2NuTehVckD8zj4UxR1Qlbq2Aj3a/Sksjhsdq2Pyj3e53tn2QGAgLMAGVKDpVnMWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afVOPXaK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so3905202a12.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730243260; x=1730848060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsWj21e8mfAM9++CGcS8J209f7a65bCkQEFsIZppUDE=;
        b=afVOPXaKhB2GEyRiuXXr9RuFIVFU3RD9Wv+4slfd1Ydo94azfP9iUikbnT6xien5tN
         bvd8fN39uJwFVKCZqeTDw7zxruBZM7+PgrdSmq3vCsgh9QiZ+r02yDdsR3Q7M3A1XEyL
         VrZvKK6suxvYMIPT5d5az0ekDh+4JGMjm3Cd9BOLzA+8e/+YgwsCBJTIbRzMnOgz9Aee
         IDes48pEWjQqxlD16Zgj7QMWSvIkmk1NdXbwfLHNMM1Q9Wz1k74U3U59VYSdLWlFlfmm
         bPS1ciw5hZtE9xUphdcTTqYSNxuQqJE/sTfqI0Kd3pMogpwCC+HrJOc1E3zg1juHerWc
         JvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730243260; x=1730848060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsWj21e8mfAM9++CGcS8J209f7a65bCkQEFsIZppUDE=;
        b=I7UPmiGID5QzeI4mh5WidWX9/Zs3nR9KbWSZyoIDQ/ZO6vxI4dqZTFOMdhrcSkSbfa
         h7+PZFR2yD2sZ0z1X4/ml4r19HSxNsgHXj8/p5roShjt9I7Dr9S3qI7UOXD0VN9MQIGS
         00AU1XHS0By8w6nMuJdwpt4qDsgKwdb75lez3aG2JN45jFf3PN0zNGFVQfkeOjtJk1ei
         wZcB4YxUdNqB+udfVbvcv+/Ve6cjiD8UW3Dy08U0vsu0HAc+dRwW9wOhW7T8L29naBmY
         U1nWiVhLoP0xuvnoIoohT1cdrjV7OQqAqIlCzIzcVa6xejGt0KEG6NSTZS+bhCvot5TN
         bKZQ==
X-Gm-Message-State: AOJu0YyY5c3/buNBKKsRkxqHLVq9VzMCUOVMp9Ds37grFBx0K9K4L3xv
	sPlSmMdlkwXHMqDSXYArkV5aFx1bpMg+3rIVeXrvq44mfIqUAd4=
X-Google-Smtp-Source: AGHT+IGSj/KfvrqnnfzNwJ9dNAPGGyeVzCW2uovWwM4K8WFqNbB7T9GvgGwWFdiDLtM6me5lQ5uz5A==
X-Received: by 2002:a05:6a20:43a4:b0:1d9:83cc:ef90 with SMTP id adf61e73a8af0-1d9a83a3dd4mr17392861637.8.1730243259903;
        Tue, 29 Oct 2024 16:07:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a72e92sm6819867a12.92.2024.10.29.16.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:07:39 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:07:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, cong.wang@bytedance.com
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
Message-ID: <ZyFquswggZxKCYGH@mini-arch>
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029202830.3121552-1-zijianzhang@bytedance.com>

On 10/29, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> As the introduction of the support for vsock and unix sockets in sockmap,
> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be inet.
> Otherwise, tls_get_ctx may return an invalid pointer and result in page
> fault in function tls_sw_ctx_rx.
> 
> BUG: unable to handle page fault for address: 0000000000040030
> Workqueue: vsock-loopback vsock_loopback_work
> RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
> Call Trace:
>  ? __die+0x81/0xc3
>  ? no_context+0x194/0x350
>  ? do_page_fault+0x30/0x110
>  ? async_page_fault+0x3e/0x50
>  ? sk_psock_strp_data_ready+0x23/0x60
>  virtio_transport_recv_pkt+0x750/0x800
>  ? update_load_avg+0x7e/0x620
>  vsock_loopback_work+0xd0/0x100
>  process_one_work+0x1a7/0x360
>  worker_thread+0x30/0x390
>  ? create_worker+0x1a0/0x1a0
>  kthread+0x112/0x130
>  ? __kthread_cancel_work+0x40/0x40
>  ret_from_fork+0x1f/0x40
> 
> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
> Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  include/net/tls.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 3a33924db2bc..a65939c7ad61 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
>  
>  static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>  {
> -	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_context *ctx;
> +
> +	if (!sk_is_inet(sk))
> +		return false;
>  
> +	ctx = tls_get_ctx(sk);
>  	if (!ctx)
>  		return false;
>  	return !!tls_sw_ctx_tx(ctx);
> @@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>  
>  static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
>  {
> -	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_context *ctx;
> +
> +	if (!sk_is_inet(sk))
> +		return false;
>  
> +	ctx = tls_get_ctx(sk);
>  	if (!ctx)
>  		return false;
>  	return !!tls_sw_ctx_rx(ctx);

This seems like a strange place to fix it. Why does tls_get_ctx return
invalid pointer for non-tls/ulp sockets? Shouldn't it be NULL?
Is sockmap even supposed to work with vsock?

