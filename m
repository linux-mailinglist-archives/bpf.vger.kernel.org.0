Return-Path: <bpf+bounces-41187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6B993E5E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 07:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73BD285CC1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7113C9DE;
	Tue,  8 Oct 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE8odPsr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CE13541B;
	Tue,  8 Oct 2024 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365639; cv=none; b=euWOHIDEc0mdAV8VmizpfFvY94pkaLdHN6UIjVG3UdsSBwPtesbrU626IK1B3RWUYSy/EP3wPVQt4j4Mgwkcx5h8iuo9gV3WvmWT+WVoYWXjZWooZvmO6d3x6uY4Pg+zfSOdvb9yAXLOYqju9mSinnS8IXRTAuexkIN5HGhS3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365639; c=relaxed/simple;
	bh=QsMfmRMqoZPqRd2VtuL3mHr0Y/DoHhsly56yN7f28oY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ec1AygBnQVj0VmzhK/0Q+KPNksbTk1BLVD76Py8NAbEmrgrxqO9utcgRqufEB0FjqY3dTNFpa9Dr0YdjvKY9BOSPzJRS4JcJSyYbAqa5ujCWrWYLDWiUtXoaPQf6ciXkZyH1R+beCmEnNZyEgkg+j3uees+h0HEirJoXEGhES5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE8odPsr; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7124395ca86so2245079a34.0;
        Mon, 07 Oct 2024 22:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728365636; x=1728970436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUco0xu1OeVOvTzkVenYrREklwP4JZ3n4Ju8hoPp0pg=;
        b=DE8odPsrtrlmoxqmwykq6/xmaRuEoNeljykEYgtO0huuZmcl4xmohu9qjArunfebEW
         d2eOSlzwn8hAPXkbCIM6pLlZTKSkHkZedTW6lzNpWLw6w9x/xt1Vk/JdU8Zx4w8JnUw2
         qhZ1oKowDT/WJEO5KTHUA55yRI4fvHdOUUSYIgoOoOANnJHJZvbp3UFIrsp/fMS45Pom
         lTFrRhpX5yna4vkjqW7GS9BQt0bbwuydXplE9wd3mWVX1Q7NGAl4rEDv3wQAwarbvXJt
         PAepXym6R7TqwjrytEFKrOimVbDODpmKWD6u9p4v0/PKWH6ZVaqtkTdqab3byZZlLNQ6
         FIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728365636; x=1728970436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUco0xu1OeVOvTzkVenYrREklwP4JZ3n4Ju8hoPp0pg=;
        b=agSml6SXWWCFb+DQbJBoNKA9+J1XnXtfn2CCKe60hByiS5/7EcpgZFrkGDsWMAiIHm
         56lP6NS+ElbEccO0IAYAXfFAXuHhdR/1jG0EA+afBTCfYsBpc/7ReJur+cKLCZEvACYf
         o81CaA5+n2N4b5YsccYFdaWLT4Eymg/OLoVT8Oi4R7oQpPta/FXiDnQomIjXsj215skm
         /fkV4vqClTCaeaUdZE4yCaLTYq3EeborAYV6jRk8wthoBoHrWPjAcRQRAsr1iDqMlJFp
         IcM++bB8tSljD23yXAhuhoKx/gt5EtgigqoOOy4QEiOrb5/VUTocRlOXRZZiQiGZdHeF
         XMyg==
X-Gm-Message-State: AOJu0YyXYABXZSBiRYaHK/IQLhdto8JxFtRLKqWBEvytEuROMvlIRmrv
	kCh/PvMAAGgMMyT+/fNA2JLACsRcw5y04Y05Huw46QflFv7nteN1r6i+3g==
X-Google-Smtp-Source: AGHT+IH8SgJA/hRyrkALNWned+Kl/UBmr6JGn6DdA1Q6YtVrM8Z71765x9TKomwf8AVKjzxvyFqm7A==
X-Received: by 2002:a05:6358:7201:b0:1b8:3d4c:bb30 with SMTP id e5c5f4694b2df-1c2b7f5681bmr519086655d.9.1728365636199;
        Mon, 07 Oct 2024 22:33:56 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:2970:c44c:308b:7d8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d65278sm5336922b3a.160.2024.10.07.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:33:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	Cong Wang <cong.wang@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [Patch bpf] bpf: check negative offsets in __bpf_skb_min_len()
Date: Mon,  7 Oct 2024 22:33:50 -0700
Message-Id: <20241008053350.123205-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

skb_transport_offset() and skb_transport_offset() can be negative when
they are called after we pull the transport header, for example, when
we use eBPF sockmap (aka at the point of ->sk_data_ready()).

__bpf_skb_min_len() uses an unsigned int to get these offsets, this
leads to a very large number which causes bpf_skb_change_tail() failed
unexpectedly.

Fix this by using a signed int to get these offsets and test them
against zero.

Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/core/filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4e3f42cc6611..10ef27639a5d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3737,13 +3737,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 {
-	u32 min_len = skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
+	u32 min_len = 0;
 
-	if (skb_transport_header_was_set(skb))
-		min_len = skb_transport_offset(skb);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		min_len = skb_checksum_start_offset(skb) +
-			  skb->csum_offset + sizeof(__sum16);
+	if (offset > 0)
+		min_len = offset;
+	if (skb_transport_header_was_set(skb)) {
+		offset = skb_transport_offset(skb);
+		if (offset > 0)
+			min_len = offset;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		offset = skb_checksum_start_offset(skb) +
+			 skb->csum_offset + sizeof(__sum16);
+		if (offset > 0)
+			min_len = offset;
+	}
 	return min_len;
 }
 
-- 
2.34.1


