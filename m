Return-Path: <bpf+bounces-77821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E459CF37C6
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0179C3108F84
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D532548A;
	Mon,  5 Jan 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gTkhxGbU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D3358C6
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615291; cv=none; b=k9grjOqx3I4nQFh4BKwpDZQMvdkqwHyy4cPCYSkopSj0OvvgZHmUM9lrU7YqimPfXkMTK9Z18iB3+pd8o1l8jmJpdzHCwE2hVJrD8wcwensWWcWjptr9sZRHIFvb3ovHpxeltc3bi25hCSzKU5RUvuroj4nWQPysozQpo2VllKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615291; c=relaxed/simple;
	bh=NaajF5tLSJC0MVk186WINR7q37KABHcy2kYvLo9rMVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPgHL1cyI5ezdF5ogJR4PIyzQOD2K8vCpvMOfnueiDeG0NyzPOVGtr9AxhOZuDUM1bzmydNHbRzBtQuq+B04T2hbDzJN4zPNy9ILBST77hw5HztRkSY2NFJQXX+HFn/Qa1i3IhaRa9cg1Q95sTr5qugZvvvFoNyUDs7SqhcQux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gTkhxGbU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8018eba13cso2200524666b.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615288; x=1768220088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=gTkhxGbUb8Ptgo4Gjcj5sx+cdMRkUVjG2/PLEzlb7Jv/bZF5RxZBb0lOlIs9NsHK1I
         jrqDCKZMks4Qz+0how+P4pwwpYuY42aVSsihltesKRG2V/rgNppjVDLhrTaDaCJyvUpO
         8A8pmLqUqbpGpvbjN16+U46XJRr+Cc3lsT8/2SPVGsPCGm6PgFl7Qu3XhfbVJgnNAXjC
         5SHTlVcrzeCMjfucRTEPnNmVnmGlUeH6IFsbN30o8CDxXfHGIh+CxE/ySV3ttmp0nsV5
         ZixBanFCqrS+sNtq9zhUQu/FrQm0w5mhMCjbBn6fLfNOd/Sty2jcEJIstyooFofHh1Sr
         SGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615288; x=1768220088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=bwgW8C+2pIExFoSClRrmNma5PKQElNzm1u/mRfKjG6pmSvkQeK/+YY0E7ewOzfAdBM
         ucvrNR3wcuqkW0jldjfdyjqgTWo9otsgxdGgYwEp3mvLZu6XahPLehmPzgnfJDFeA3GG
         8grbey1w0PoPqmSTnR4Mtupdjg0S3CtBxUaSWA4SURYhzvM4QtjkVXs1vVhTQwpTv7qi
         Uuu4vn8LsAPMi9AZ2srJ+FBDKmJxXCd6pHKjy2wOt3UymzPLq4SGJVSF3WbKNhvSY6AU
         Q00ZGIGvC1kbwu7+aOgaAC13Zs9kkr9T6cp0e4MQ+qmw7h+k8rh3oECZzYlULa9YKnof
         XLmQ==
X-Gm-Message-State: AOJu0YxiI4+JFxur8hWAPnVUlO5ZVavpc9PIdk0re5psjJQqAu50fOc3
	dvmdrCD/kQUZNEWLYtQgZeHjMNe8xddt3R4qjLU0eJFXtw7rjwvrljQU6VFWy0xkEKk=
X-Gm-Gg: AY/fxX5A/ohSRE9SImANT3EP2LEuR84MY+vWzmoACOuqCTwz3yURzrZNaXQvMxcd+8r
	sG0khqQcQxzGzX6hdEPW97knT+T9ClvBLWjfO9gw0hghpqY/hZRqGCVY4mcrj5y5C2syOvjrDrx
	98rOQEfZXFCpJcM723Tcg+dxacKO6QEgw1tEkub6WBGjz1YIgRZX7IObRvqwL0jFINqIEcKyVMR
	8p2AMYvvYg6NSR1+0VoH1rMskIoywJdCiuMkcVWPdNtsJhskKQvUo5C7PNXecOPbHnMr2BB3EQZ
	yRIad9BVEVmtUAwZbdONIlOQDJBzfGXEOWPjLYGex4sJ0q4VVGqAernC0lU+HfwY1PRq5mu4QsE
	03rcG93HzHgVUiNEJxUgySJ1U9feN5fMq9wX/RyG3n2708SZHCLUdie1TpyJXy/IzSEI5NPqmre
	4UGtoZIeirfxAW+HBvIWCHt6Xg06WwuH35srS5ydJbNb/I3wRv2AUGYkG4l/E=
X-Google-Smtp-Source: AGHT+IHF2y789vZ9L5QZP11T2yCBl7sSqeVv1BFKUDGeKuzVN6znOu+Fdjpsor2okWeZSF/297bDuw==
X-Received: by 2002:a17:906:fe0a:b0:b73:8887:f42d with SMTP id a640c23a62f3a-b8036f0a3ffmr4987450566b.5.1767615288231;
        Mon, 05 Jan 2026 04:14:48 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm53485163a12.28.2026.01.05.04.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:47 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:32 +0100
Subject: [PATCH bpf-next v2 07/16] veth: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-7-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points right past the metadata area.

Unlike other drivers, veth calls skb_metadata_set() after eth_type_trans(),
which pulls the Ethernet header and moves skb->data. This violates the
future calling convention.

Adjust the driver to pull the MAC header after calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..1d1dbfa2e5ef 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -874,11 +874,11 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	skb->protocol = eth_type_trans(skb, rq->dev);
 out:
 	return skb;
 drop:

-- 
2.43.0


