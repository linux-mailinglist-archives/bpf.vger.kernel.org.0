Return-Path: <bpf+bounces-75350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B72CDC818DC
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15BAA346B0C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262F3161A4;
	Mon, 24 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gCsag0yx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6381314D3A
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001754; cv=none; b=JU8UsqLUgkk+y8SMf6UljAtyAzPWyDYWSEJ4zPZogCk0zvqtMU+IKTHy63JNJ/etYe7qJIT92XYBa2pOU60ybOMU6Q2N9LGZz17p7lThBvdnd1rbnCDd9WmtZmBKsX6etFzKDvHRrmulMBczIUIKmsKobyDAn3UHLx1Ve9DiCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001754; c=relaxed/simple;
	bh=ODvPSeLFM8ZsDBxMc9y4w7KsW8ANKhLH35flBrsgLZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/OQJGLnHJV23Nex/0D+q0I1Yb02B7ppEYnix237L6+0uijlQf0KzgYGkdBuzoVX1VE37vF7rO5FaCAEqgGx7o9ZanVPLej2bhZ2gBdkVeG3xMFy7/iUxRenOIZZltpX4FO8iGExY2owrNGE3AYivEqUl0lR5gOaL6IX3fasH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gCsag0yx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so21086a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001751; x=1764606551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N95V21IBNIbUG98EtbcsCf1tsPCMp3NjpmmsQKMdsbo=;
        b=gCsag0yxlY35APICcy8GWcCfRQUUKo5n/AgdL6H6J+T2OiIXma4MIB78t9QorrqXyN
         xtu7usJicH5s8BpFkn1VQ8Abdkt+ElDy4xHduj/fa4m3+8bBOtqpQfujBzYWmJ7XlLpm
         r27NdNQtUnB5FIpZA/xiEM413XPsn2iBk9KZG2GzDmkScHQoDCiyn8viLkbFab+wHP8i
         9LByi56iq+n6D5CFnyRB0rxMRW6TRGUCf2rK3cWzmxu+A/VNeBzuqf8uTdo4kFy/6sAz
         bVIB6b+9deoi9jc1FTq3s76GYsbzLUfcPYUHlCUCL7q7M68mptGXxjJIeqY85qyKeqGd
         b1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001751; x=1764606551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N95V21IBNIbUG98EtbcsCf1tsPCMp3NjpmmsQKMdsbo=;
        b=nLY3nR+ZJ7TlRuzeZ+iseHUH/Hm1bx55ps7RXnpgPByGQ2BjC7v+mDsCBgZ87IwGpT
         4sJMScFhHDvZIySCW0Ow93pMIIBTTHnN+lp75IcaNzv+CuyBI6o1LI72QDYPbYyKJK8c
         KUAf6bHToudyB+2v5RTHHkqCd8LU9Ab2poBEboifF69VNwlc/+eCAvO/MnepCAxyR1tU
         rvKoG8q4G0U6AQe9hEa1no+tuyTAYzzsBQfoqUMYTmHEkHqV4ryuZTkgr6MSGwub4NH5
         RhVSfeVbI6DYMVa524wpLpIMbolOcvlC5uaVAvpXCUW0OMbV/JuApFQjhC4cDbHyIg5j
         8OYg==
X-Gm-Message-State: AOJu0YxJdi9GCMGgP4boZO+eo2xyldo8a58b4BofY1KBUWW+hwDF3ZrE
	MhAnxQw9JwGMic8dLpvvt3ZuHt8HcQ7uPLkLM1jqEyEG+BB4GvffVq5yQ8SbNXZtEq6SRFyFf6I
	vNRCy
X-Gm-Gg: ASbGncuE3TOAgTA9/NC6kVggArvjhxoYrXKI4KOjB2sOxy/jY7nhi5KA2z4/WT0YQ4E
	WLN+MbmeB3q1Svx0lEkFHgnDf6xlzAFhqq1JMcmWcekfNuNaCFBo/ZwSgQUuYhSe+suQx8G1Rhy
	2xMCu2mNNU2Dh0InDtrccSg5rUe0Bz4i2evDnOr80cQVl2lEqI+Pu5ov0LT/1MUW/nYQCvADNUa
	Tr4PKwgWFbtECTeTH89yzin5vI4yYItxVTmhA3CyDp9irHzxwgUkmuwrBRryy3HVwoxWwv1Dm9n
	b8pRwXWeTkU2AGf+SvbWiakyWnAEQiCzpKaeimeaw7uHBlHWrkwXDjvZyWEolVs0IU5PqOAvQyv
	vTZhM2TpjUYej9QD6oEJEtK0/AWujkjyZl8+gAUQYDb/yNG8y5FaU4yycQlVZIvNySd1vbo/Nwb
	eLb8ZrrLpNVV59kmcVcPn9PxZRP4SV6VDCol7iPQZ8dfj8T3PCWA68wjZc
X-Google-Smtp-Source: AGHT+IGQhhyru0gVVmUUEDzO7cCLwI+nfgVhC781M5W/ItgC6K+XRDDi5fUxA9/voPjDkRBDTi5y9w==
X-Received: by 2002:a05:6402:1e95:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-64554677486mr9900740a12.23.1764001751062;
        Mon, 24 Nov 2025 08:29:11 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm12524557a12.9.2025.11.24.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:37 +0100
Subject: [PATCH RFC bpf-next 01/15] bnxt_en: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-1-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a625e7c311dd..93e05a0f1905 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


