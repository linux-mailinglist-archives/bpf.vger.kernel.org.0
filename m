Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E953D3115DF
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhBEWoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhBENnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 08:43:35 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1AC061223
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 05:42:48 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so5798913qkh.10
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tAOVQ3G2eN9dGCWyxwwne5gBaM7loqyQjU9wOYpr/6I=;
        b=OH+gSvlZu8rebHPUVoqKDmTFHlv+/7sQvcchXxOZT1Jn21iONeHO5qh0iOgXDZWX7q
         jeC17g6FkVEOtLw2JujRlsXjCBYN14uQ/OGcRwPWafs4nX0OA8kWZjC42AjACQRY3E+O
         6K/exEZWEsXQ7RObfSoLk6W2LbPGLqRruEHRwzRRiJvTCBgd82+1G8ivxl2sOdOftuJg
         m2WBkw65oW3/j1LRV1+a1nZkqeU/kLZ7Q1IpGzztRAi0qeh1hjeMjoO8ZWfgx29MYJIa
         TUwZpYnUIxODrp3LiKHFcqxHFa/CINvN3it27Eev4QLEzWMsmWlQfsjBnm/+Twr7/tdz
         Qe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tAOVQ3G2eN9dGCWyxwwne5gBaM7loqyQjU9wOYpr/6I=;
        b=XVFd1WA4SQhlKNzp7ur6qoVmQKUCLBgiC1b3uEUmk8LKKy1TSZT7RMI1jMXhxxz6c4
         mYH2nUf3nwiHoyJw1t/8YatzKFysjzMewe1p3ctQXMnKFiRANOknvRGBB0cDCNZC7JRU
         MWbklzTH5QtJj+sylyHnDPmVwyGa1hueqIALFT2yravF3hC+lZBt6P5Hj6Na9VGlgx2T
         t1SbW7r94p3PMRnwZbo92MCb2XXb/k6yUwhvrZSX4gBseIEvtPn2a8LXBcR3dT3wrydX
         GeNZA1dIpMU9YNXFfonCaAPBwQTwhWIGk1PWqjCB9e/8Ck/hPV3rhbcdjcwAfZv3qJ2c
         s5xA==
X-Gm-Message-State: AOAM533IRUaG2Xvi5vitdENyv6/5Llv38ya0BLAbLsT+PdewEYgNSQb3
        jUIxCdX6zpIO5urQguj4vtQ8kWWGRu/crg==
X-Google-Smtp-Source: ABdhPJz5wihZxlw8hgR5CE0fmzuZmzIXYPXLcOoH3i+RKhajR348e6cGEOGc6mhYA8VGyVScObuVOOKwC0tm4w==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:6214:a54:: with SMTP id
 ee20mr4390536qvb.16.1612532567845; Fri, 05 Feb 2021 05:42:47 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:21 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-6-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 5/5] btf_encoder: Align .BTF section to 8 bytes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is to avoid misaligned access to BTF type structs when
memory-mapping ELF objects.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 9f4abb3..6754a17 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -744,6 +744,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	/*
+	 * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
+	 * nice if we could fetch this value from somewhere. The BTF
+	 * specification does not discuss alignment and its trailing string
+	 * table is not currently padded to any particular alignment.
+	 */
+	const size_t btf_alignment = 8;
+
 	/*
 	 * First we check if there is already a .BTF section present.
 	 */
@@ -821,6 +829,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		elf_error("elf_getshdr(btf_scn) failed");
 		goto out;
 	}
+	btf_shdr.sh_addralign = btf_alignment;
 	btf_shdr.sh_entsize = 0;
 	btf_shdr.sh_flags = 0;
 	if (dot_btf_offset)
-- 
2.30.0.478.g8a0d178c01-goog

