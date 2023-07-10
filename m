Return-Path: <bpf+bounces-4647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0974E085
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD4E2812E9
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687816433;
	Mon, 10 Jul 2023 21:58:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05116413
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:58:31 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038DDA
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 993F8C17EB5C
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689026310; bh=W560dmZLFP5OB4gALRIT9TuwMIe7jXZexp6GMcK+Tqs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gorTynzC2ZkIpHfUf9dlY5nIF2Bzg0llJC3r7ThN8E3Cg9bF7JO2DifZ36+6tUb5O
	 n3XZKkGuxoFA55sx8Q2XEfMDC8MN5meUJ7N+g0ollz64eKmpOQOaQyE90Gk0aSi4wN
	 qn/JB12c/V3a+XndmrWNpcf3yJOSnfD+5r7rbCIY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 14:58:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8271EC17CEA0;
	Mon, 10 Jul 2023 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689026310; bh=W560dmZLFP5OB4gALRIT9TuwMIe7jXZexp6GMcK+Tqs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gorTynzC2ZkIpHfUf9dlY5nIF2Bzg0llJC3r7ThN8E3Cg9bF7JO2DifZ36+6tUb5O
	 n3XZKkGuxoFA55sx8Q2XEfMDC8MN5meUJ7N+g0ollz64eKmpOQOaQyE90Gk0aSi4wN
	 qn/JB12c/V3a+XndmrWNpcf3yJOSnfD+5r7rbCIY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2E058C1782A2
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 14:58:29 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.897
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zUisI9_pEGTl for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 14:58:28 -0700 (PDT)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8EA7FC17CEA0
 for <bpf@ietf.org>; Mon, 10 Jul 2023 14:58:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7672303c831so452585185a.2
 for <bpf@ietf.org>; Mon, 10 Jul 2023 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689026306; x=1691618306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT1CR6YvJGgrUO871gftYTVzjQKLxvoNwgtL3+hTSrc=;
 b=RfxX0jwayukzTlc0sLTpFE7vdwdGop7FAkZYLdB/8oRUo2ySN9HqinMXnqa8v4wc0v
 wfZoVpwh8DsozjNPoiBUYDhY2GKD4xiJmoqG9wBqV5rPpf6wOaGYj2Pbcb11WGNOxDD6
 MJF3wY6gyAzLQvo+CNHB3nEpHv7mXbwdhbayzNFodtlEtx/uA89B8E9Y8gsoqm7cRyot
 oSoOCDaxp2zKtnIH9sbtWyoJL2C2x4tw2aCqdjHCgL3XTy1h/9qA3zbXpb3cGemIXxj4
 yQSAa3cCJsr4Z/x8cGF+KZ9Cib6yFdc6f/DiZzxm5CT9Dap8e/ulYaJKQhlMDFkofiWe
 BbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689026306; x=1691618306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PT1CR6YvJGgrUO871gftYTVzjQKLxvoNwgtL3+hTSrc=;
 b=MFB1SQxPKwyTmE7YWiRwWk10HVTv4cegezvFPn6zEEj2aX6W0147R6PYVyrB+EOlCG
 02KdjfEy/AVPXV1SzfIU0KrW/7lJd4ujNXS7vPO+t9Mn7mjPa7llPOPdMUWe3i3jZ4nn
 sPQS11+4hDfoWS4P3VApap2vcQQ4nfMC+fm9d2W/6lRpYN0q2I0qk+QhpJAgx17OJi4B
 9o/KIhztb1/zG8nnIQPvyQGQZ//4n8Ute9wB7zuNIaFezQdZtshAc5ANbojo8+4ZoGJO
 0oxBulwCYX2QOb4bvzxhbBNPa4Q81a5Ux8knSBujU+TvXTTS+YgcTmgX7iPYj7iZpkQ7
 kWVw==
X-Gm-Message-State: ABy/qLbmVZF7tIGfCR0fepiXuMJGq30+rYkyOd2+PsDQDg9CsMcVpsvd
 ixihBQb30ZotjPKidIRhmxFLsIV9/osOSoaELfA=
X-Google-Smtp-Source: APBJJlH160Xpd8yJzdSKI3whlG3BpwoMiO2HswiOyWQnFJWGQSBUwKBPhdohjNlomcX+mi0E+NlNVQ==
X-Received: by 2002:a05:620a:284b:b0:766:fa7b:7694 with SMTP id
 h11-20020a05620a284b00b00766fa7b7694mr15249829qkp.70.1689026306340; 
 Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 pa36-20020a05620a832400b007676658e369sm295380qkn.26.2023.07.10.14.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 17:58:19 -0400
Message-Id: <20230710215819.723550-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710215819.723550-1-hawkinsw@obs.cr>
References: <20230710215819.723550-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/nlN-cnE7siFY-EcdnAFeJZypboA>
Subject: [Bpf] [PATCH 1/1] bpf,
 docs: Specify twos complement as format for signed integers
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the documentation of the eBPF ISA it is unspecified how integers are
represented. Specify that twos complement is used.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 751e657973f0..63dfcba5eb9a 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -173,6 +173,11 @@ BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
+eBPF supports 32- and 64-bit signed and unsigned integers. It does
+not support floating-point data types. All signed integers are represented in
+twos-complement format where the sign bit is stored in the most-significant
+bit.
+
 Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If eBPF program execution would
 result in division by zero, the destination register is instead set to zero.
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

