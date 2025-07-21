Return-Path: <bpf+bounces-63887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E213B0BF03
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D468718839F9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA61224249;
	Mon, 21 Jul 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyBCJwLZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673C1E50B;
	Mon, 21 Jul 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086844; cv=none; b=ciyYgHxVDZ0fTVSFZLYx9VbFzC52HkpyvIFYoTlN+VevDrKN5r2dUO39e/JigD8TAh/LiUom5topMUwAS15Vywvzo7UTuuf1QcL4gTogLEgz/wTo1UIYFqeppPp0ZI6IBr/21Kww6BZfeIk22XYSiuH6vvioZin/kL8Riyp6Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086844; c=relaxed/simple;
	bh=JxYLzVaua9fzlV6jAiU1SZijmkwOzRY+t6tBNC0XBCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cri1fW3t+QwFc8ZgMwkqk3HamMpg+v+/DGkN0Yy6UtpftSWGSi4clzuVeYA16e+Bgv5rlLc3zCmwXYxXpdIHVZNvS8Mvl0soF5AT5aMzyNHsqC3pvcMgzsUw5aSlY9vu/PeFgyLGBeB52JLN16GUKNHDChal0c/29kztP3aIS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyBCJwLZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4205843a12.2;
        Mon, 21 Jul 2025 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753086843; x=1753691643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbtNVv68Al+8cVNVFbCAZPRp/ZwmAyAvC1F+49a5gy8=;
        b=GyBCJwLZFcrMqagUqeZYSYzLRBzRilOw3FJqHbuNkpgWFJWB+9yCE4CbSzteJJ/NH9
         4lCdX5J7IOOoWI+xQqaBqR4BF1zY+BQEOgakYEqQwhEeY+dUh0uG50LAdlTsB/cu00qh
         KWol7sKO6MQ7RPBAwiMSGpFLxM8oMm9VVP40wTylNzLmtgCPK+5xKi7+O+mhbaJi+Ebd
         rDungq6mPP8JpSLQS1cZmH9qEpNG0S+klX3yrceiAxZvrbm0GxTl/Ouqn1ZiMdH1v9fX
         0WJ7W6Vf1H6xnccA1xVzqyLhK6mKIOtf3TKs7yJVJpWPfZoKFQKtFfKTCh5uFS+YTyKf
         ap2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086843; x=1753691643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbtNVv68Al+8cVNVFbCAZPRp/ZwmAyAvC1F+49a5gy8=;
        b=iOzdg4Ds5PWdg8b3dJMdHZSKBklF35X89y1fHXEuWaRjmSR01pjZaDlfxu7IiE317l
         Mogd0jBNthEZhYPw/ler/v2XNW6irx30iLgQhz7Zynr5zXLWSZbTRa6YJ9An9Jt/VwJE
         0Jfqdz5RlB8+9VM4SRcfpA86rEWcizOdc1JQ4FaTXQcLMqFQULGqFc0sSJhqwPhpmdjJ
         4VDDLNnQmSOjkUxDd8TAQ0xv1J3uj1QfH8OujJH5vdKxDJgXgGGeeqcNxbpnGlxCGa+6
         pXnGNIKDzpX9ZSg44BvtutBj6LjbCr9u5wGB5jD2ZPLW11qRTkLznOwR6nX+zv+EPEhc
         4cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy3eD1yyN2/cixAa/PDV9oEb/3B/w/ePL2K2zueEu261srK8M0raqpH39yAYD3dyoHg1s=@vger.kernel.org, AJvYcCVvf/xVT3DVyrN1Zfiy0OHEiOkPn6s17Z87WeCJHts9eKl/XJelEHRvS8S7mR04XAy2gcdS9xC5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYRj3sIcTfj2LjY24AgflPXE87+6q/TOYCGwVOLhhUCBSGJDA
	1BpWjku0+KU2uUYSCM1fJFooq6xFPijPaldR4wd2A0w+1ENmxXGsv8/pfYu05+uYGNk=
X-Gm-Gg: ASbGncse0GEiCbu3YnVhhwe97Z8jJUWo+RaGLKRAWpyf+n7Eoh88w6GKVBEnz1eiljc
	0BCgr4XYLYhJhVGfUmC3m1qq2jcIvIwq/IMi+WMKnJHnAZvyzaT1tzxwFsruPyRAyjAdv87SJZM
	tZfeauvUE5wMSzl1pWhMGpCxAWpaOOPZDjAPhhbXWa4vjB9I4acl1pT8g7XhK0KOcgxs6e8BiA/
	QOimSYgDTlTAzhjcs3Q17ZzrG9y2xN8VnKQu0wQyzNTDTSaxMivwnqTu56zRiBBeQ0/IA4vAv4n
	qlPVysmaCEpdQzSLYgi2AgODKzH439SshcI9wPRCtLP+8xDn3nN6myr+oxqOLozFNCFDpmHNwJ0
	4AoIulME6bjd0uQQo4oWmeezn0F70gj62nqHHR4Fzw2UCVDlsLSiWp/wKpbg=
X-Google-Smtp-Source: AGHT+IGyQK7XJLz3sOROYFmqcWgOIYrK0cMqYO+1HcoFFA3G5PlGwInuETMs6mPtONWOozx+/OJv8Q==
X-Received: by 2002:a17:90b:2684:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-31c9f47c7d7mr25319465a91.25.1753086842487;
        Mon, 21 Jul 2025 01:34:02 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb7742596sm7082116a91.27.2025.07.21.01.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:34:02 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
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
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] igb: xsk: solve underflow of nb_pkts in zerocopy mode
Date: Mon, 21 Jul 2025 16:33:43 +0800
Message-Id: <20250721083343.16482-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250721083343.16482-1-kerneljasonxing@gmail.com>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There is no break time in the while() loop, so every time at the end of
igb_xmit_zc(), underflow of nb_pkts will occur, which renders the return
value always false. But theoretically, the result should be set after
calling xsk_tx_peek_release_desc_batch(). We can take i40e_xmit_zc() as
a good example.

Returning false means we're not done with transmission and we need one
more poll, which is exactly what igb_xmit_zc() always did before this
patch. After this patch, the return value depends on the nb_pkts value.
Two cases might happen then:
1. if (nb_pkts < budget), it means we process all the possible data, so
   return true and no more necessary poll will be triggered because of
   this.
2. if (nb_pkts == budget), it means we might have more data, so return
   false to let another poll run again.

Fixes: f8e284a02afc ("igb: Add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 5cf67ba29269..243f4246fee8 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -482,7 +482,7 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
 	if (!nb_pkts)
 		return true;
 
-	while (nb_pkts-- > 0) {
+	while (i < nb_pkts) {
 		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
 		xsk_buff_raw_dma_sync_for_device(xsk_pool, dma, descs[i].len);
 
-- 
2.41.3


