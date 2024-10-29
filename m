Return-Path: <bpf+bounces-43350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F319B3F6A
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B8EB219C3
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648C817C64;
	Tue, 29 Oct 2024 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LalyhaDj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3050D26D;
	Tue, 29 Oct 2024 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163740; cv=none; b=XskNw5V2XEeMaT8cnIU8BC65v8ZfOV9T4NLODKADnSsvo/x6rLTofgsTr0JpXDqwoZ9KOCasztgQIPC3RLD+KximnW1/G79369O0cxVhWTrj76CsIeoyI90Fw+8RaQMMsEf30yB2t1zfJy5ijL24vx0BcNYX3rBGGjivj+5hzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163740; c=relaxed/simple;
	bh=nr7TGO917e+igHWYQ0ucjpaLpgNYioZO/emBf0kEH58=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CqZsp058ZAOZT9rb0EkJoHEQNaHb61SoTtJmtJibjPSmzgExRSS8MBXtZ4P5wFzLnvcPUcu5+txfFjC/h9RgIDfjE+y+2k3GWYKzSxh4kLwXa9tq5GbFc2UDuWTHCgWDYjMKe+sDoY7aiibgNdNg1xqpIi6dOZLe3s4Jv/hoQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LalyhaDj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14077ec5aso537077285a.1;
        Mon, 28 Oct 2024 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163738; x=1730768538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSVVpGVTfwiCmtcdTlu+ojF1yEQjCvLSKKKhd8kuSuk=;
        b=LalyhaDj/S5ATJ+WU6FTzkR8N5S68/xUEmxoFqHMCfh1MH5/42xuEoyamOkkwKi4fa
         yOlW06RPjXSOYPxGo3bAGz2DtWAagl65Ta2kGoWxu0338X5mKNE3zQx2eUSQkd490vdG
         Dq01DNIQibxzqtFFj+wy1e80qRkkO1MJlrjSVf4qw5wQduILCKtPrIlLDsMHJ2OTJYUJ
         XBOoXDLJEqV1/MTLBCeAvmFxgrmp2E6TcZvPr+mmcmhAHC8vvpeRE9pViRiC2MHoQhD3
         6NDA4a4sFK31V3OZe58riVyrEd67X+QX5M9QAenLR2YCxxmvFMwhUhha+HCh2a5WakjG
         5E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163738; x=1730768538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSVVpGVTfwiCmtcdTlu+ojF1yEQjCvLSKKKhd8kuSuk=;
        b=RRvOt6tqiCh75rnGBM2Pcx0KRQnmcZfNkB7xU/uhHJ7+RWZm/dJyA1ZHKewLJe237Z
         IC0D8nSocf5ZQOvznTrdL/x3bMeKh099HmWiOBfRIKgvfRV3CEiwX97LJKYLaofvTwT2
         dr66PsRPkTxIWtydW/OyeH3Y9FkhgqesVjlWmnCNlYXLFXKy6GhmJaXLRKEqVGDdVkOz
         Oxdp1NHcOJJUmrKHtuzNvL2fOEItGTZzLHHLWdSCg0uYOcgtu82/FniaYivSdKJlUT+2
         /V9GH9rfg8UQGP15+PBVZhQU0bh+RSEH+NWADUoD4nbMXxkI1keDGs3O1bX66jMAuppH
         WLhg==
X-Forwarded-Encrypted: i=1; AJvYcCXDUUjr3tFiSvzud3qp+CBcklClF34GqW0DSi9ZwZ/5hqNciUePQZenNgA04cpjVBQyoQzRz24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhNYh7Rfwi+u+AIzNoJKpE0nW5TcWEJ1NfnLWf9qB44EnkL3zh
	atoOLd0Gb7m5kJiUGOQVBgZHBEdHeuAECGfu4t2b/+GOOZ9Doe/P
X-Google-Smtp-Source: AGHT+IE9fkaMRCIbiolhohLDUsIQHFAOIHuPJ1FHLcA04T3YkXH8vPnyC/hvzaxJdJW98+MAueuI7Q==
X-Received: by 2002:ac8:5fc3:0:b0:460:3f14:89e2 with SMTP id d75a77b69052e-46168431b76mr7569721cf.15.1730163737722;
        Mon, 28 Oct 2024 18:02:17 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211a9dasm39918291cf.2.2024.10.28.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:02:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:02:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67203418aa886_24dce62949@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-5-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 04/14] net-timestamp: introduce
 TS_SCHED_OPT_CB to generate dev xmit timestamp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Introduce BPF_SOCK_OPS_TS_SCHED_OPT_CB flag so that we can decide to
> print timestamps when the skb just passes the dev layer.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/uapi/linux/bpf.h       |  5 +++++
>  net/core/skbuff.c              | 31 ++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e8241b320c6d..324e9e40969c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7013,6 +7013,11 @@ enum {
>  					 * by the kernel or the
>  					 * earlier bpf-progs.
>  					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 39309f75e105..e6a5c883bdc6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -64,6 +64,7 @@
>  #include <linux/mpls.h>
>  #include <linux/kcov.h>
>  #include <linux/iov_iter.h>
> +#include <linux/bpf-cgroup.h>
>  
>  #include <net/protocol.h>
>  #include <net/dst.h>
> @@ -5621,13 +5622,41 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>  	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
>  }
>  
> +static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +	if (sk_fullsock(sk)) {
> +		sock_ops.is_fullsock = 1;
> +		sock_owned_by_me(sk);

Why this check?

This will usually be false, as timestamps are taken outside the
protocol layers.

> +	}
> +
> +	sock_ops.sk = sk;
> +	sock_ops.op = op;
> +	if (nargs > 0)
> +		memcpy(sock_ops.args, args, nargs * sizeof(*args));
> +
> +	BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
> +}
> +

