Return-Path: <bpf+bounces-77820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E4CF37BA
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B1A30E82C7
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03760335090;
	Mon,  5 Jan 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G28qRTlN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A63358B1
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615290; cv=none; b=WMvYNvl0dU6NHUOEZh+b2yEvqG4hBkCFBSMuLe+JhDQ0tv0Z8b2ZQ14kUkfXnlDgH9lEUqN5WM3/hjn7wwpgFcONG1I6pdTkNPqfN0ENMljN3hTK9FGsOnCd+FYf8epxCr2n+DlrPC3BqMtns5lUEPFSiBOCZU2B19rbLXEA94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615290; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikGG9043ZrdslEAQhMIvwV3kYvz/6z9d/4q2k/gL2Qlebpgy79AiVWu1ZAQufQ/yWeTP0+zxGWm7xLfXhcqzE0Jxnt5VD5Djx2s/olCqAt5wuabixCtKM7ixUSUpsqkHuiwgp2SpGkgcAsu0mFwIRROqnYQ6p//6vSs6XGesu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G28qRTlN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b728a43e410so2669264566b.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615287; x=1768220087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=G28qRTlNUUGwzJkWeUSlfEo26gDnr27jngwYsYaDrjlv5YgHKhrCuYfgEjXBj8f8Zg
         Alwi/qpfSGBn0Z0NEUVZfHcpCDmiTribNFFV1MAN6yzFoOzqj856v4a73VSbn/SbZ3kk
         CWbF3aGk2dxop6Snmfoshi0ufpnK7LDuUZF1KEAzDTuGHr2FU2oQtP3VUSvc2tcBmHVm
         pJAxfZuaM6l9v8SWiaeBJnSUuveGkFyRPBfPJv16Fn+E2qV4l22ApG4TrcKCDEGTduNm
         t79OthcHzCIqQpafqPrgMoHfhEeDJ2wr5CJyNYiN3mLxDRRN1sCuz2wYynFtnGjqRCOJ
         a9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615287; x=1768220087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=FaHou++YHDjzwomA5K5vLXara+hYNk9pqQ6yTtvCHhYzBLCdaVVIbirCH2y7TPvLD9
         X7jDgMekW7mWo4L5m+P1QfBIKUR/aKEMKHh5JltKUbDSjA/RUvf+2UKG04CvCEOOuHFD
         04ANUN0Dydugsm6NS1cJQE+lvKlTRGPe6Lte5GqGEC0TNFxQOuA4wZzLlwEto5luIF1c
         r9tY5ZirLrhGbOn9gSz/PH+WF7xodnGar1E1PlmnimolVsPo57XmvoNDqzEJ5omY88ID
         HZtiCilZA55649z+6TwtEGE2ynBBcbuTtKC6JEXRJoJaB4KG20UcwOj+toD30CyDzC9A
         fN1A==
X-Gm-Message-State: AOJu0YwpS0r91gGz7H+bRoJnmjOWP0SwE9zmqjpZ7ETuu1/LnVXN5ReM
	hXEjucS6uZkMl0/BGU8v960TKEp1jlhXjQw3iL1PGjb2BEXmlA5AiK6WFQiKOPkhNCHyJ87yl7P
	NT+t2n7M=
X-Gm-Gg: AY/fxX4KTcLUMYoF89QPIMzMH9Jy691FYxqfIGc7wZuzFs6fDaBMqy65CQI2UUBw9HX
	CoTtyP6xr3iV8qgDcjWEWs4r4D8ji1FW29ms3ZN3cIUsj5Yq63jGQOLUMhIonVgk7OhYM+rga0k
	B5KHYhlBjLdb8nTUdeIo6eSVeE0bAokxHUAbhsX+C9ZbwYr7YByMaNcxnrsFpgzQnWLNKhvGLvM
	tTeX7wk+YX1aGgoihXaeDjYu8tkVvEf7UgoKyTPFLHSxHTZiZxE4KmiC4qf9BmOl5U2zq1zj6Xw
	TjfYvmupAdS2Zrw8Zu0JyNqKj7NXDEpJo/GS8zmb5LcIrjDkcSpCWwWEEOzBRunq+cROwDIvzbm
	TGKMULe3HFS86wI3veoj9ZR7VK3ynPq9A9oJxuc9ocKZWxhphGxGWcA08kuLnrtZRObj4pxBiq4
	m5LvrVEVwzTr6Bon87o0a4iREYnteX2e/K6BLvHuuGcz+Mx9AbBt19kHcboeg=
X-Google-Smtp-Source: AGHT+IGmBFITIlNHpUQ9BWeKEfuFmXyuejhK0HAC20IEk3IcEAm4AJYk1tQYG5xWuKlOvuIu4hFrcw==
X-Received: by 2002:a17:907:7fa0:b0:b80:413:16d6 with SMTP id a640c23a62f3a-b803717e275mr5408693966b.44.1767615287057;
        Mon, 05 Jan 2026 04:14:47 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b830b5fe8cfsm4040726866b.59.2026.01.05.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:46 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:31 +0100
Subject: [PATCH bpf-next v2 06/16] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-6-a21e679b5afa@cloudflare.com>
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
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


