Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF53E426B
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhHIJTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhHIJTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C20C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 02:18:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so23559742edu.1
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0HvqzfnPGjGFI0y3WK6yitDk3oSPXbq2+fXq7sm5WU=;
        b=wzWBYTq9ogFGJwiRJjc+9dBW4fnNJmcwkYrE9Wt4LKeN18thU1f7GdoKaptkundpB/
         bjgDndcY354evG6X2VLgaqaQmx6ERlujI2T2+KFsrLh+x9s+c/uBgcA4EQUF9tplQzG0
         sl/IjV58Ok8fY2RiECVz7NafD+pzWL6G+vtJBo3zDq/KrH0ynUbmYXReL35otgjYvJnr
         ig0mftpd0Cq3jgyMlqaOaPRVM81hquve/jRtDwVHgGjOI1mMmR8ZE14ErkM4Tqo7XmuI
         UtHjlC7egWFun2AdnoZ+7t0KjmgUNmC5mGtXWeJraXx/wt2Pvk+imQAjKdapf2mvC2HH
         A4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0HvqzfnPGjGFI0y3WK6yitDk3oSPXbq2+fXq7sm5WU=;
        b=LaVfXFCATsAtlomVAK+8ZCuGyzO/vpjdH37pTkUDF1BzuZIOzNM/ETsSaqVHwVUUWr
         NN9dEks2r1/Ax/F/wxjEZ3zdQMbclH9CnQjT/JKPe7eZp/Vk2Wu3+Hgz4B+Nui7xl6Kv
         D43+JsSlTlpW+q5YDhYe+W3kqEEjV6YqC/GB+fkfwx9WD2fOnHgIXw9MmIr1IcraH5Xe
         4iB7Vec1fAbCtu51eSCy61avIBS6pryldVHWtXA0aoOwy453YECWA9qdJeQFDNySjsXD
         Jpd5f73Q/zdQKL1QK9GWmACg7GVIj6tis0hFNuQAXF75Ocv39DWPWL48fDEjYoZEoOMg
         y1zg==
X-Gm-Message-State: AOAM531YiAk0P641YBfgU6pbz0FoZGxrrcyuF/9iGTR8AN3B6dGGbogd
        itdzcxo0p4yoXBHz8+WHfAeo4w==
X-Google-Smtp-Source: ABdhPJxyABk3rwmkLsnMrDLpX4dJXRE2SrDrGNcYhZQX0AlxZbBzm1wgE2jF4YigENWKO4hyv24PPg==
X-Received: by 2002:a05:6402:386:: with SMTP id o6mr28679324edv.294.1628500733070;
        Mon, 09 Aug 2021 02:18:53 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id dg24sm1234250edb.6.2021.08.09.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:18:52 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 11/14] bpf/tests: Add test for 32-bit context pointer argument passing
Date:   Mon,  9 Aug 2021 11:18:26 +0200
Message-Id: <20210809091829.810076-12-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
References: <20210809091829.810076-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On a 32-bit architecture, the context pointer will occupy the low
half of R1, and the other half will be zero.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 896d37f4f4b3..fcfaf45ae58a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -2092,6 +2092,22 @@ static struct bpf_test tests[] = {
 #undef NUMER
 #undef DENOM
 	},
+#ifdef CONFIG_32BIT
+	{
+		"INT: 32-bit context pointer word order and zero-extension",
+		.u.insns_int = {
+			BPF_ALU32_IMM(BPF_MOV, R0, 0),
+			BPF_JMP32_IMM(BPF_JEQ, R1, 0, 3),
+			BPF_ALU64_IMM(BPF_RSH, R1, 32),
+			BPF_JMP32_IMM(BPF_JNE, R1, 0, 1),
+			BPF_ALU32_IMM(BPF_MOV, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 1 } }
+	},
+#endif
 	{
 		"check: missing ret",
 		.u.insns = {
-- 
2.25.1

