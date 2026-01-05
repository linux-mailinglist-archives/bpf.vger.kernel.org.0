Return-Path: <bpf+bounces-77819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B7CF37B7
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A4D530E115C
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DA3358D8;
	Mon,  5 Jan 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aeHukKJu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BE335575
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615290; cv=none; b=QPo7XUPE/NCbsYHJJjY7SH7o8oxOxX7SFm07W7Mmknq6AcO+UM8VooDkW0FcQOehN6Ek0OpsN4NBKNqHqXPCs8AMLnMjnh0Po2s/2zew0Jn3r6eGrR1jQ6Gta3y6HEO0Y7ciVvBy8/wqldDoxGVFrrGjNTdio7BZUyb0Pjz/SPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615290; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS4MCEvqzaHBx1LCxKbsHI71dRM/i7gAMzHpJ4H9ztL5ctWC2sSrXWdpjgMZMJlUPSrjlrwU1lhv2KgUJlsLEYmJO7ArwZoS1YWHyOrJ5vl4WqIGkakXwT4LVFQNbEYfJkathzL/GL2urrH8bjsZ8n3Co3d3wdhV+NzAgiI6GUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aeHukKJu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so577739a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615286; x=1768220086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=aeHukKJuFGarx2R7Afl0tb2nwo+rBLcPJHOTlCaumuMRoP8L1D79hI7rx4qZNaDdyv
         CoCT849D6mIdn4xoVFZaC05h1ds5WFEUI1QvU4yrxDNagexsOGu+L5vSHbjrIPBkOVCp
         5cRceVFnvuLEbZNivwbLu3TQT5urCASziPArvvjrtqcQsKM13n5y4KutflcgVWBmyfEr
         cQ26vai+fiaNs4JFsxfv3C2iFEalvJ9rKMJEO9VPO4YSLE536AuFmSrwd+2ZUY/uSu4o
         Ho2FPTCrDzvsc/QIXr7XRAytZ4Z/GcDzIPPywm9kvJ4vzxtQw5Tl9WUWqWMW8slc6FBS
         1/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615286; x=1768220086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=kQFz+nEKWjSpcUPrf6chrwrq+6fWNLscOtQjJW+wqCrpuWI56DWnoRXv01jimMWCBO
         enAkSr5w4OodUtse0x5SIiCmYcOCw5qAZ/qN9/PSSWNGdK7oupMzMYKD9yp6zOFGoKh0
         XyZV9Gs1n5WmrB3BQZjgIHgdJUjwBiJB8RE1OyXcYp/g129tYPb5g3/1QEBVKeRjYPnp
         VpMNcyJT374RyuiwJD4NnqmpH4nhSHc2IPHdG5BN21Z21vXLr8D8SDIgbT0fxXv8oMEh
         PTqbQsxBYGaHn5abROyioOrwdQdbYhvVj2I/NBDEtitKyuEH033zV6S2Vo8lYZpJc6wc
         rqFA==
X-Gm-Message-State: AOJu0YzJdGuL01PXj4uplSlkBWk2af2xafpsUa3aqc2Kc2ypv+gmuAzL
	PK6QEYfPWCczgtDpg0sCaG1hWCkyrgh/zzyc5622FttzBSLpi9JEnbGp9KPjL1eseSE=
X-Gm-Gg: AY/fxX6q2gWbYodCTcFa0kEjNtS1XrgAnZnei3KAshAesRyPYB1uVlvfw+S3ckm3gGk
	WhxG1Jrq6aze1xyyYADwlTt7o1FQWMJZbWsycTCzOO3WM3JrE6uW0qy6NRlNtcRvTFp3tAmKwJM
	cKqh2T/IsyXwRuvVUi3WuhBUM64ICJNIbxDscivP4XY0Uq4nJ3XtBtTc/JsZucxvg1jCbCFECdp
	YamCcbzzHJr62lPJPmMCpNd9Ok3G27n0LoP/q4TlTAfm/VqfeDLFhPFwiRBT9RKohpY15Uwb+4N
	OcbiFfp1+Y4RC6xNlMoDj6AZVS6BrAJrpVfWToFbHwtvd9W1mamdG5dblSEdWLagdc4awuVPd6u
	ypSaJX/QUbNzZPLwMqNpGaCUb2cFG4KGxPZqIIhEii03a8zTh9b/1ap0EFoH7opE8JppdVVVLyX
	yP+IcYUxl0PIb0cGbCcwe5dHagPGvNEQ1wvVOeqPgZOKSrPCmxzAqnIKfZ6yo=
X-Google-Smtp-Source: AGHT+IFr0ZMjG7qKX7KGn3B7ISvZYjFHyjR3rkhdmPDVNI0djGeUfwpEd1bvPeKdUAQZ9v0e2vBV3w==
X-Received: by 2002:a17:907:e8d:b0:b83:975:f8a6 with SMTP id a640c23a62f3a-b8309765132mr3383530066b.43.1767615285872;
        Mon, 05 Jan 2026 04:14:45 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0deesm5550292266b.37.2026.01.05.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:45 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:30 +0100
Subject: [PATCH bpf-next v2 05/16] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-5-a21e679b5afa@cloudflare.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


