Return-Path: <bpf+bounces-39718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EE976A57
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C127C284F6B
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B41ACDE3;
	Thu, 12 Sep 2024 13:18:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383D1A76C9;
	Thu, 12 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147084; cv=none; b=XfsxrxMAHed1Na/aXInxe9Plx/slVHN0QX/Jxt79o3jkOw9jDV2M3xOFUKhgSb2T5RIGNAgLMcS+8kxWrA0v9RZeFb/wY6Wk0yjkoudHIVs4CWQXvvRbKOJHbJKqhSeBCRqYTcvLwr/3moR27i+qzxVlLgn+Hz5zmDEMgjfCQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147084; c=relaxed/simple;
	bh=8vtiuWy8DEEYZuh8z5JLVaTZZ+OrEOoXgyyr+iakjlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMlNcxqtuk+tSasHd0KDYFL9g/sOBkubUXx0L9B5tKD0BaL5z+LCydkDS/4UswJpQERhhyAtlolvhUI+N7/rDhuP0tRc4r3YxrYnHwcjcaW5Rd8Wc8ucic8U4HGpfRE2tmvEWteV9vgX82YaQugZ9hG3fQlEDMgJVFAgiO1/KjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c3400367so925323f8f.2;
        Thu, 12 Sep 2024 06:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147080; x=1726751880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+jkhZtCbEDKlDFBZYWklnHtzrWSfKD6Ka+gxj0l1wk=;
        b=QKnqf0UmiI5+5P1WOMCPcr6N/Xc/Ajdwmu4MUplDGRVjTKxhNRdXgB7E/fEz5xUtIf
         PoZlMKA2kFKoq53KTAYYp8ayzboznMfhNwkXaVXVyx2XrG0o3KhwszgbecoeN5sE4rdM
         DpI5mYDhiSNT66Fb/qmApfcZjJ8OgeFudX/1S4kQXcjn+buJu6UKkCoE5LjjAwAmwPq3
         ZcNQK61lFW9OX1HwMn8wAUTRlbQ5DeTm6W8Vbg6qM03jOPcmTyyztrgIeEoUFDrbMN2Q
         ESI7ut5XtJuDfh8QsvXXjI7dGTDhjouVOaAGZdtVbixu2qE5SJ8cpABHMWTLfzJXpqn5
         bFaw==
X-Forwarded-Encrypted: i=1; AJvYcCVWOtNLfWTC1jzgpFmCj4KrbHnnQfIRzvPVjRYt5w6aPL1Vzrb0oV/YXI4mKr8COzkaSKFN7+Iq8DFwnCBi@vger.kernel.org, AJvYcCVqgCINT3MxkOyuqdNrI2O1glzt/yAcGpv0aZljjmuQwgBJGYYrp/O1AtOaNofjts15ZDbGN0Q5@vger.kernel.org, AJvYcCWRomv1pUrfRZrs3okzIfmyriqTkmkw86YG/lrWfS7LPDyH9wC8HpXsiThIFLlHLp1rwPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzhu3bM8PLU+13AJ9AIfg9l1umb/qbeng1Be6/hFyDVoHR7wwB
	XMz/ryEycFtYcTwpJySsjg56NTfrOFNv7iyVgkMPKUXskZnirx1L
X-Google-Smtp-Source: AGHT+IH2FK1sZsXCQcQITQimeUOtmON1FCsxoZGOoivBPz1eG/mktX+Dh3Repf8UyTiOlZqLX7uTeQ==
X-Received: by 2002:a5d:6751:0:b0:374:c512:87ce with SMTP id ffacd0b85a97d-378c2d0359fmr2390588f8f.30.1726147080369;
        Thu, 12 Sep 2024 06:18:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d40b2esm748160266b.194.2024.09.12.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:17:59 -0700 (PDT)
Date: Thu, 12 Sep 2024 06:17:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912122847.x70_LgN_@linutronix.de>

Hello Sabastian,

Thanks for the quick reply!

On Thu, Sep 12, 2024 at 02:28:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-09-12 05:06:36 [-0700], Breno Leitao wrote:
> > Hello Sebastian, Jakub,
> Hi,
> 
> > I've seen some crashes in 6.11-rc7 that seems related to 401cb7dae8130
> > ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.").
> > 
> > Basically bpf_net_context is NULL, and it is being dereferenced by
> > bpf_net_ctx->ri.kern_flags (offset 0x38) in the following code.
> > 
> > 	static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> > 	{
> > 		struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> > 		if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
> > 
> > That said, it means that bpf_net_ctx_get() is returning NULL.
> > 
> > This stack is coming from the bpf function bpf_redirect()
> > 	BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
> > 	{
> > 	      struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
> > 
> > 
> > Since I don't think there is XDP involved, I wondering if we need some
> > preotection before calling bpf_redirect()
> 
> This origins in netkit_xmit(). If my memory serves me, then Daniel told
> me that netkit is not doing any redirect and therefore does not need
> "this". This must have been during one of the first "designs"/ versions. 

Right, I've seen several crashes related to this, and in all of them it
is through netkit_xmit() -> netkit_run() ->  bpf_prog_run()

> If you are saying, that this is possible then something must be done.
> Either assign a context or reject the bpf program.

If we want to assign a context, do you meant something like the
following?

Author: Breno Leitao <leitao@debian.org>
Date:   Thu Sep 12 06:11:28 2024 -0700

    netkit: Assign missing bpf_net_context.
    
    During the introduction of struct bpf_net_context handling for
    XDP-redirect, the netkit driver has been missed.
    
    Set the bpf_net_context before invoking netkit_xmit() program within the
    netkit driver.
    
    Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 79232f5cc088..f8af57b7a1e8 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -65,6 +65,7 @@ static struct netkit *netkit_priv(const struct net_device *dev)
 
 static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct netkit *nk = netkit_priv(dev);
 	enum netkit_action ret = READ_ONCE(nk->policy);
 	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
@@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *peer;
 	int len = skb->len;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	rcu_read_lock();
 	peer = rcu_dereference(nk->peer);
 	if (unlikely(!peer || !(peer->flags & IFF_UP) ||
@@ -110,6 +112,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	}
 	rcu_read_unlock();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	return ret_dev;
 }

