Return-Path: <bpf+bounces-7837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513AE77D1A4
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8069A1C20CD2
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0E18044;
	Tue, 15 Aug 2023 18:20:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECC18033
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 18:20:40 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC761BC3
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 11:20:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-565aba2e397so3898692a12.3
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692123638; x=1692728438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXIokqSHoHVJikQ0OTsHuVwuQJkAt9SyMe34Pt2DmXQ=;
        b=weigtb1BCv2vrtlWHVPt3BGxcYsZC+Ss2/Grvk6O1ywQf03LxDksSKbI9n2lLR497g
         hpgnE0k86YynWKfIn7JZ6j1p6VrHZCkIhZgfUOcDbxvjspIgeBANs4m1Whtph8LiInzm
         tjwZl/TRVoIidwfhbdk1CUfy4W2rc5So5Ee48Msbg0UWRVW0MSG875TjwU8e/MeDlhjs
         wtRbewY2dYQNng5vIRR45O27eU9nl8geDRmttEKaJ9vHCcrOhWT3t3bM064vbVXOIyER
         /XU7XReqh7g8e2zcT+xCuDCNx/reUAcqU78fsxrsrITmwTz0aHj0u8Zj6mPTnp2BjL0s
         ODfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692123638; x=1692728438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXIokqSHoHVJikQ0OTsHuVwuQJkAt9SyMe34Pt2DmXQ=;
        b=e+4byOWAxGYVHWmqMh9St/BlG0BbBSvdI32QpwWZCWA9z9Tjd5Pkp8EQ81oVhYjt0/
         r7vfJqp3UfcoQRw+fPmDCC+3HCWWnkR+Y+sbQHgOf4ECqTCZbsAIx6pJYcUS0EHewpJc
         GixDn2en2vrcP9IP5K7cql5jyg3DvOXRZHYkb/3TVKYhAa82VZNxWrNpGka79Z04PK55
         ohSd08+ayDVMJbq0NzMsuHUjrcjJXylqzOKENbKeAMxWiAJpQQ3Bm5+hXTrsGo2S6w+r
         xkPKN5g7PwAPCVi1+eDhRCwcsaFHTNYsaBni3A3ngX40mLgoNbTeOONBTWZFMHIAmPiy
         4VVw==
X-Gm-Message-State: AOJu0YxgBR9kHNpCeD4x3rT8a6wwzQ+n4MZ/c87odaXuccORE1nkXVNG
	Wc69ZHslJkBqcyQh2ex21IIzD2E=
X-Google-Smtp-Source: AGHT+IEGhJT/Ml15gtxj+nd3+ADfuioUCVJlt1CZAZinybKEDS2+OsvJ0QZujjYfuHeVu14AhCawksc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3646:0:b0:565:e991:d1ca with SMTP id
 d67-20020a633646000000b00565e991d1camr279543pga.11.1692123638420; Tue, 15 Aug
 2023 11:20:38 -0700 (PDT)
Date: Tue, 15 Aug 2023 11:20:36 -0700
In-Reply-To: <20230815150325.2010460-1-tirthendu.sarkar@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230815150325.2010460-1-tirthendu.sarkar@intel.com>
Message-ID: <ZNvB9AUzNIzwMW6+@google.com>
Subject: Re: [PATCH bpf-next v2] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
From: Stanislav Fomichev <sdf@google.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/15, Tirthendu Sarkar wrote:
> xsk_build_skb_zerocopy() may return an error other than -EAGAIN and this
> is received as skb and used later in xsk_set_destructor_arg() and
> xsk_drop_skb() which must operate on a valid skb.
> 
> Set -EOVERFLOW as error when MAX_SKB_FRAGS are exceeded and packet needs
> to be dropped and use this to distinguish against all other error cases
> where allocation needs to be retried.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202307210434.OjgqFcbB-lkp@intel.com/
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> 
> Changelog:
> 	v1 -> v2:
> 	- Removed err as a parameter to xsk_build_skb_zerocopy()
> 	[Stanislav Fomichev]
> 	- use explicit error to distinguish packet drop vs retry
> ---
>  net/xdp/xsk.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index fcfc8472f73d..55f8b9b0e06d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -602,7 +602,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  
>  	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
>  		if (unlikely(i >= MAX_SKB_FRAGS))
> -			return ERR_PTR(-EFAULT);
> +			return ERR_PTR(-EOVERFLOW);
>  
>  		page = pool->umem->pgs[addr >> PAGE_SHIFT];
>  		get_page(page);
> @@ -655,15 +655,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			skb_put(skb, len);
>  
>  			err = skb_store_bits(skb, 0, buffer, len);
> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
>  				goto free_err;
> +			}
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
>  			struct page *page;
>  			u8 *vaddr;
>  
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
> -				err = -EFAULT;
> +				err = -EOVERFLOW;
>  				goto free_err;
>  			}
>  
> @@ -690,12 +692,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (err == -EAGAIN) {
> -		xsk_cq_cancel_locked(xs, 1);
> -	} else {
> -		xsk_set_destructor_arg(skb);
> -		xsk_drop_skb(skb);
> +	if (err == -EOVERFLOW) {

Don't think this will work? We have some other error paths in xsk_build_skb
that are not -EOVERFLOW that still need kfree_skb, right?

I feel like we are trying to share some state between xsk_build_skb and
xsk_build_skb_zerocopy which we really shouldn't share. So how about
we try to have a separate cleanup path in xsk_build_skb_zerocopy?

Will something like the following (untested / uncompiled) work instead?

IOW, ideally, xsk_build_skb should look like:

	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
		return xsk_build_skb_zerocopy(xs, desc);
	} else {
		return xsk_build_skb_copy(xs, desc);
		/* ^^ current path that should really be a separate func */
	}

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 79a96019b7ef..747dd012afdb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -578,6 +578,19 @@ static void xsk_drop_skb(struct sk_buff *skb)
 	xsk_consume_skb(skb);
 }
 
+static struct sk_buff *xsk_cleanup_skb(int err, struct sk_buff *skb, struct xdp_sock *xs)
+{
+	if (err == -EAGAIN) {
+		xsk_cq_cancel_locked(xs, 1);
+	} else {
+		xsk_set_destructor_arg(skb);
+		xsk_drop_skb(skb);
+		xskq_cons_release(xs->tx);
+	}
+
+	return ERR_PTR(err);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -593,8 +606,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
 		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
-		if (unlikely(!skb))
-			return ERR_PTR(err);
+		if (unlikely(!skb)) {
+			err = ERR_PTR(err);
+			goto free_err;
+		}
 
 		skb_reserve(skb, hr);
 	}
@@ -608,8 +623,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
-			return ERR_PTR(-EFAULT);
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			err = ERR_PTR(-EFAULT);
+			goto free_err;
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
@@ -629,6 +646,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	refcount_add(ts, &xs->sk.sk_wmem_alloc);
 
 	return skb;
+
+free_err:
+	return xsk_cleanup_skb(err, skb, xs);
 }
 
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
@@ -641,11 +661,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			goto free_err;
-		}
+		return xsk_build_skb_zerocopy(xs, desc);
 	} else {
 		u32 hr, tr, len;
 		void *buffer;
@@ -729,15 +745,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (err == -EAGAIN) {
-		xsk_cq_cancel_locked(xs, 1);
-	} else {
-		xsk_set_destructor_arg(skb);
-		xsk_drop_skb(skb);
-		xskq_cons_release(xs->tx);
-	}
-
-	return ERR_PTR(err);
+	return xsk_cleanup_skb(err, skb, xs);
 }
 
 static int __xsk_generic_xmit(struct sock *sk)

