Return-Path: <bpf+bounces-4646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737574E083
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576001C20B48
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6EC1642D;
	Mon, 10 Jul 2023 21:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3816423
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:58:28 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A30DB
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:27 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76731802203so452582085a.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:27 -0700 (PDT)
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
        b=NaSGjnOBgiHtshabGMJQIxjPPQFjeGHw4r5bDJu6qdr2iVxKs2qqSZw7dZ+AfmTGAB
         CQwBHd7ZFX3rHBwGZhpiWywR4e1/UVjnaRcMeJqBS8hyzfFoI2fvQ2zI7DHm65Cp+/X8
         6vBd3twkb78r036ixwDeXQ/p9Za30pa35WgFbRVqAmbmu3BbzfO4noKfO0p7CD8uJ2lU
         wEeurp/WfLF1/jJ6j1AN/2kcro0tcGtMTacGt5bXFCVsCA+JxybLvAv3rwUht7KNH0b/
         DsELhTtkMjl8v4X/qcrnJtzu5qpX7vDSaduIrXzA0qvqc1DwW4Ize6J/UCnceYCan2L5
         sMdg==
X-Gm-Message-State: ABy/qLZMiglhDX2Nh86FtxDBKXqrI+6ulopp3E9yjTTlFoOwKe3f8CBs
	XJjE8Q00B2LP56KDqTcai4SzTfMMipDSowY++mk=
X-Google-Smtp-Source: APBJJlH160Xpd8yJzdSKI3whlG3BpwoMiO2HswiOyWQnFJWGQSBUwKBPhdohjNlomcX+mi0E+NlNVQ==
X-Received: by 2002:a05:620a:284b:b0:766:fa7b:7694 with SMTP id h11-20020a05620a284b00b00766fa7b7694mr15249829qkp.70.1689026306340;
        Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id pa36-20020a05620a832400b007676658e369sm295380qkn.26.2023.07.10.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] bpf, docs: Specify twos complement as format for signed integers
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


