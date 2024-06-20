Return-Path: <bpf+bounces-32651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AE911592
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57711F23217
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83AE15444F;
	Thu, 20 Jun 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HtLvSN0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09810153569
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921970; cv=none; b=XxcIDu1hR9O4oNGZjyImGRQx5BURzz4286fVT+XsQIi8lpqXxiEmpZwRmmfBXNrMQN6ffJ6EutoX/EmJLITQ9DQ9SX3u3uGKyTRdp6HhgBiiW38iVxBbe1BN72+bpbUCRaHfxVLDxrvL62iP8/hneM6YW/GyrBqBDb/kEEKt6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921970; c=relaxed/simple;
	bh=AzuBu/nYd4noTnvcgiEnKbx32LQxb17oyJeVJ8ndhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F38rDuhU7nZcgddfRyoTXNGLp48CKNrNrtArgIFf5ajZSh04e80kDFB1QDbjVTQZbvmlNMByR6YyTYMEeeF0GOGOPsfFCNKJiA7KyVE53zTOMMts+dfveC6BhHItTiiBuFpuQCFRlFDdJ+wOj6FJ8jndGBh7Qo/nLrc5W3sDNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HtLvSN0k; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ae093e8007so3593196d6.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921968; x=1719526768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=HtLvSN0kZiZXE+JFmxRY6iFK9eTRGriwaSfVKvUbqKH/77dcW3jOYqrOGVl1Se/S4/
         ykpF23sXHvepgwQlxeWEdrOtBn7kBt3W+weZG5JptvKINIo8U0AzJMTZeXoVXfplDqUG
         y2kwz7dDkXCwSlzh8jidcVYK5pQaRvB+Z/GQtW/Xc3/iBNkVcGJURTizb5GypurA1+g7
         MrsamVqDuDS2E05B6xUN8hCcB6HtZxEJ1duQ+YqQ7ryLiskkaB1m4alP63zASyj9rLMk
         oUox0b2qJi8bg27fBV0/KNahtmlXWZ5JDtGiOhlJuDfLspp9rD4gSNeZj/Bj5rkyyze1
         ZYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921968; x=1719526768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=fo+LqFVcXuow20nxati+pajmdHmYZ6V+Ayb6/TaLJlxqx88ryPsCwGnRmIwVpMV/rL
         wVDgxJgMdraQ5ONC+Di7k6MrJvpULwvoNsdcbxLrVw5mVLyOKCz6HPQ+d7Fwh5MCovZC
         NkbQ6O8t4kTxaSEdKe/PN/pAZAsTW/u4coxcJU5H+foPD2Xpkdax4QwMyq/qYZbUZcYG
         77McoK+hPZRbiaC0T6JcHH+MCONXPQyAuCBVOlpfaAuYlL2g4vWx9GlXm6LUZ/TvkGGE
         NzUO37ad+9ctr6ZrjoSsEo7OvIrX4yISZByJKziTwog4KQuwD3aQ4SD93PxJAKeJKoY0
         2ByQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtSwwLC8t6wJKF/v4bDb3jFwaFF1zivJ2POR2rRGG5jS34ycs22uAofTtj4NCetzo6TdwB0rnlfMnorBQNhvytnqTc
X-Gm-Message-State: AOJu0Yzh0WosvblKRoCn9K9M5RVsnzT4cL5ENPHvpktah1koReZXwTEE
	95ZbHlJYbGk0nDlrKSf0lfWqcc/TKmOdD7xkRcd8MgLfN+aKOkL5kkp2LaM7QWs=
X-Google-Smtp-Source: AGHT+IHgBBxlD+qDZaVaOqDtQcbNvXT8j2u4+YOx1AyLUR2YCxxWQ0XJoivZxNhP3Jz56mudjlNUSQ==
X-Received: by 2002:ad4:57aa:0:b0:6b0:738f:faf1 with SMTP id 6a1803df08f44-6b501e3f1b4mr65791656d6.38.1718921968099;
        Thu, 20 Jun 2024 15:19:28 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe6d9sm907396d6.11.2024.06.20.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:27 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:25 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 6/9] veth: apply XDP offloading fixup when building skb
Message-ID: <b7c75daecca9c4e36ef79af683d288653a9b5b82.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 drivers/net/veth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..c799362a839c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -703,6 +703,8 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 			stats->rx_drops++;
 			continue;
 		}
+
+		xdp_frame_fixup_skb_offloading(frames[i], skb);
 		napi_gro_receive(&rq->xdp_napi, skb);
 	}
 }
@@ -855,6 +857,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	xdp_buff_fixup_skb_offloading(xdp, skb);
 out:
 	return skb;
 drop:
-- 
2.30.2



