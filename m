Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C076631D7F8
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhBQLKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhBQLJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:09:55 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F256C0617A7
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:26 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h10so9704211qvf.19
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ICJenGYVVB2UMBJ+iIKGIow1eUvegxgyz46lhETpOEo=;
        b=PEhEAThsEfNyW5iaB/O495UGeIjmkOQhOja4zRTQcigkQrN0VXhnDEqu5yCsVz8hJt
         C3RSWAwyrkRcLgJ250YHpCYOhR/d7SbD87sVPf+kQaADqe18hrMxJwgHC3vC3e1r/5hM
         i6N0SqLKpqT8Yx55U6WIOJhX3XeVVnpUHv4bAJyrcc7RgXMWl7TFjX7EWybymD1i0rE9
         fjBEAdbQQpasahkwXL5h00bGF9Z8Z4C9h7a3YEYQMxNDoH1G2jx7Jc6+u1aQqbMwWw85
         jHjpHOC+RgJSJPx5UhjMsOnAiVNqt8qFkWUBGOllF96E7qFkPTIe5Pr/lpNKxSCUoeon
         LYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ICJenGYVVB2UMBJ+iIKGIow1eUvegxgyz46lhETpOEo=;
        b=GdrkUBuBbr+qKZiOQ+qNDqqTeG/9l/kCMtlji3e8FY2yE12VpwxT8g7j5xxm6Mrxdi
         D7f3y1ZSspSMGpg+57cLr8y58xDNI+/EkeJL1rqSGEZbUnIG7xlAkUlztg6YM92cbsiS
         C7pCvfwzqJIbbpka7x1cas4Khiysj3Jt6ImtZCFfjjwfUx5FYCUuJBdRdb/smo1UBwhd
         vj2Pasu4rC9FceTX9EdIEFXcWm5pgERCB/jy/TOg96VRME9xhfV7LqnJjuQE83HiWY4B
         0YZL3EW4ynqN3RLj1ThxvV9yn1bDO3Dlc8T+/wytAnZGikv/usErbBE8fI6G25cg73nW
         aZzg==
X-Gm-Message-State: AOAM531CksTcjFzzMSjPGYrozUimK0HIKAS9gKqqo2kpkQNg46tf2PCk
        8VBkdEdeI2YGMjCnZ5kuRwpPvgcJHeDtig==
X-Google-Smtp-Source: ABdhPJziMOSsIQGNdtJaRQPRS9whDjRhhEU+hGOvIG0l8uCjwtm9jd+lI0E/ouyizbEYfP8GW+SMxFAcBfbP4Q==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a05:6214:16cf:: with SMTP id
 d15mr23910944qvz.32.1613560105235; Wed, 17 Feb 2021 03:08:25 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:04 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-6-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 5/5] btf_encoder: Align .BTF section to 8 bytes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is to avoid misaligned access to BTF type structs when
memory-mapping ELF objects.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 9ff03ca..ee677fa 100644
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

