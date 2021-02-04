Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA330F792
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 17:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhBDQU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 11:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhBDPMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 10:12:16 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F4C06178A
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 07:11:36 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h13so2408528qvo.18
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ly81Omvy3A0pY+iH50Cqw5e7AkcF0E/HZgnhxFBqPoA=;
        b=mWOaZ1hroWDB1Q4FefKt2XqOKeoN4kNYpLJ9Dm+S+UV7N4yTCT+YEe+Dzr7BUBjYnk
         cZ7czy/byAR0EeVSiuLa0/eZqdRueC3CcgT9yQVwn7u/csLipvD1j7xuFSp9U9jItKSx
         7Jy6/NWJePOa3f4p88TlCDIpGdPJCdw5gU3ufSobxyhJtBeqPL7br0/Q2lLYNbCgQl28
         bBnBO2kZrM/5xHtri3jE3frauwv6MecQhtTOcUvJm36adR5C+kJqog79rdVTitUf6UYC
         ZhuFCPxsd3w02EpWuisgXmQGOLYZX5FV/CSjdSpa4DLLEcF7VHf5Psk19t8ym+5yQUXD
         lrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ly81Omvy3A0pY+iH50Cqw5e7AkcF0E/HZgnhxFBqPoA=;
        b=P7S7ee/IJtDIqvlL6jq1VjJnozCrekLXIM6wCxD2NKbGBg0VWSPJoYRqUCnK09F1au
         gctiP3OAZoYoBW8FbrXwzRULfSS/7OgwZYYxedunDeHUezNPcbVi9yLw3j5YI07PLo8s
         ub2JoKLlzzdFkqCostoZ2WGrkBJKB8nUgHGKmMmP0/7iXRcD2Aj/LxtVHH67nK4jKx+X
         hB7CeRHJJux9IpdnBQAqj3WFBxzbolaQNfRvYENh2BM+DFi4/V5pqHCt4Z59D3utjMTa
         lglxeJ9UsEJDO7Pp19QsnzaxAN9XuC137USIKnJjEoVCQwQRqUQJBkOXjR+8sc2bollv
         FJdw==
X-Gm-Message-State: AOAM532y7i977UuwxCJ3A2gqCzSSAWgtQXscdpU8mPKC12pz+STG0Omc
        ElQi5nrJVIjxSQ5jHPKpI3TwN0gj+2KaDA==
X-Google-Smtp-Source: ABdhPJyDLSvbj7w4vwEf+hLajWTbVkTAd1Jfm3gJ3HYDkQOcz7R99gIO4tkvt6bXUtSC1bZtgQ8ZnZ4Bwyq8yg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a0c:f582:: with SMTP id
 k2mr7779072qvm.55.1612451495028; Thu, 04 Feb 2021 07:11:35 -0800 (PST)
Date:   Thu,  4 Feb 2021 15:11:27 +0000
In-Reply-To: <CAGvU0HmLckYQv43OgvpU1aDkwVTBHc3MV0rZ_jfi4Az_tZXjjA@mail.gmail.com>
Message-Id: <20210204151127.2676041-1-gprocida@google.com>
Mime-Version: 1.0
References: <CAGvU0HmLckYQv43OgvpU1aDkwVTBHc3MV0rZ_jfi4Az_tZXjjA@mail.gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] btf_encoder: Align .BTF section to 8 bytes
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
memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 5b91d3a..9974747 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -740,6 +740,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
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
@@ -823,6 +831,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			__func__, elf_errmsg(elf_errno()));
 		goto out;
 	}
+	btf_shdr->sh_addralign = btf_alignment;
 	btf_shdr->sh_entsize = 0;
 	btf_shdr->sh_flags = SHF_ALLOC;
 	if (dot_btf_offset)
-- 
2.30.0.365.g02bc693789-goog

