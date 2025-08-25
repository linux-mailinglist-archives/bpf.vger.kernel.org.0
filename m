Return-Path: <bpf+bounces-66397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1783B3429E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DCB5E1B02
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A82F9C3D;
	Mon, 25 Aug 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWvQag4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745562FB983;
	Mon, 25 Aug 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130095; cv=none; b=syacSTkpTNn6V7qh9JKEBjyrUS1c4IzQ3zdYc+MyFbbY9dCd5zLDKwaxI14BeCgJaCWvmy7myigUJ+fpBUguyUQUsxGw4ud1w4xy+AIV3e6H+ekL7XCrqlQpkF+6ZB1+VInMvt3lui0xSHoGGj9FCNlSHet/e76ymUgZFYPS7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130095; c=relaxed/simple;
	bh=Dv1j2CG9bRA4lfh4nuuN/NSDY6kFItZbPp1B320ULqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnqkwH+TiYWw4Hnp4GHUmVw9KiKr/x10M1McVaQ5eitfMZZEN4gWhIuPvjQT5Eg9NrNYl74DrpZPRnz0zBX5MXyBkk9s6rqv51nC/iyXU9Hk2bBgHXBthFuMjA6aOuHjuibwgPeh4s/yWM1DPTGeFFamfNk6ZOhKwxBj219gxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWvQag4n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e987b4e6so558799b3a.2;
        Mon, 25 Aug 2025 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130088; x=1756734888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI3fTsAavFAwGb4wYiSwgUlydq8e66SsiYMdQG/62Tg=;
        b=MWvQag4n0l3xiIyakXaCRLzY/68uiMKSL+ax7Uy+QIhRXEZ9kdnKljwgCUOhIPDcfx
         JC0WJBcbQrNuGoOU5IftYh6SoQQgU5TtgL8wx5QsT04fP+aJcGv26MBcsG/86Jsa7ebP
         4Q/Cg+l7Ktkn4BevMGiPN8izrT9iiI1mVsMtaDAgFUPyqzlrHQCp7MovDKMAc5Nu/3v0
         yoEtHcrpkvi0yUuRvWghcV/LtyEPsL+Z0vypUwXybObr9N64ddmvWksGtERfMSIrueMu
         wgrzZtqTg3IaESWyt5HvQpGnSeYqCLF1klbbYicl5BTnRxs7YYqnEx9hXRlNvhNx1PpM
         n2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130088; x=1756734888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI3fTsAavFAwGb4wYiSwgUlydq8e66SsiYMdQG/62Tg=;
        b=wKow+6XquFx094QD2bEqkzkUjPF2olaPNdCFNIYjHptJxhJQj4ro1ymWjkN0/rmdJs
         hCvC9eXUHGcMez3YsCPmT3Nv+JZ+mber0ULxYNKH0gkg7exfiinJea4Rd0M74h39IzZ5
         kVUoUXIPvLKl+eC3nuwWT6wigmuerEK4FBRbyf7qOviwva1OoptzPDSnNKP683xjewVs
         qs4k8tmjJ+6E7NN9EiqaC2OQeMi790VdHupyj2ZyARsIBcvIz+EoYJycS937+n/PgZTW
         9GcMs6jP6F6BgnEwu15R2Yeb1/eF82yNu0xytAuMmBP5DzAkVhukWcx/UK3/h3BLxOqR
         +q/w==
X-Forwarded-Encrypted: i=1; AJvYcCXtTHugdeQXqDQ4aBe/ZtrbGUSb1XSXkwLp7CuQjR1CVx1UimI8+R4p734QQF10ydZ47NNcT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOPtEKstBSvloOCilTo2WmZ55U+BDGFlf4/3ev1UF01YpDXg6
	C5sAh3u91DNRCi2OSVNUhQbf8jZztOiM8+RJKwq8l+GvQW277KUIY834
X-Gm-Gg: ASbGnctHQBMVZX41xyZ/VFZGJJrlbyPLcNRHLH5bF+e92rxIquRlN8ZNGDhDP6V8p1U
	IUzcDN2//V0r1WcClsTGnLk6dOfUvtVoWLlL2e2198m6+D2wiaPp/vr/eSHduImm0iPFEiNlPRx
	IwRs1YUIz0crAw4Imu3qwbMMORp1KH8McwK2Uz53eh/fCS7iRnXg58UVlIzIbXbWXOkJU5IfOJx
	VgbwdViU+9suyXpXKPztqp95oTYveRdt21qekQyONKTu+pxYUQ87AzQmDMzPOGz8lznwpiEhpRW
	Bomic3vZAFCbUD2fG017ShPDdA5YbKMWEauOq8pgoojuxYs3/TF3r293aNeLVzszj7QQPEEwh3Y
	grrWWb84EHWvv2mXRNxNi5rsDCuF7OXHAkTprNGquUpbYvAVXvAfPUXu79Sjhmr5rx+tdoA==
X-Google-Smtp-Source: AGHT+IFDs32xWezkA2bqLMF/Wsw16M9Wfq2aVCLZVfpckr+RUHepSc4H2MkQnJOb8r6w54U1CEmCwA==
X-Received: by 2002:a05:6a20:2a29:b0:243:78c9:1631 with SMTP id adf61e73a8af0-24378c94b3dmr2873817637.51.1756130088549;
        Mon, 25 Aug 2025 06:54:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 9/9] xsk: support dynamic xmit.more control for batch xmit
Date: Mon, 25 Aug 2025 21:53:42 +0800
Message-Id: <20250825135342.53110-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only set xmit.more false for the last skb.

In theory, only making xmit.more false for the last packets to be
sent in each round can bring much benefit like avoid triggering too
many irqs.

Compared to the numbers for batch mode, a huge improvement (26%) can
be seen on i40e driver while a slight decrease (10%) on virtio_net.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Considering different implmentation in VM and host, I'm not sure if
we need to create another setsockopt to control this...
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a5a6b9a199e9..9d28a3d0ce3b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4751,7 +4751,9 @@ int xsk_direct_xmit_batch(struct sk_buff **skbs, struct net_device *dev,
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
 	for (*cur = start; *cur >= end; (*cur)--) {
-		ret = netdev_start_xmit(skbs[*cur], dev, txq, false);
+		bool more = !!(*cur != end);
+
+		ret = netdev_start_xmit(skbs[*cur], dev, txq, more);
 		if (ret != NETDEV_TX_OK)
 			break;
 	}
-- 
2.41.3


