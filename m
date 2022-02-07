Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989054AC215
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiBGO5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442511AbiBGOwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:52:19 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73791C0401C1
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:52:19 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id c36so23147218uae.13
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZtABFI5cNBm/eHiIyfTOBmMdnmCDUrTmiFxVvQRvIk=;
        b=AU/XUeRCfjrq2h50MvAAbLtXQMvXPnF1OQYbz+uYV66kfQpjJ5JZKWn040JZyprG5Y
         i2RHs+OuQWoF8n1LCs1tWi/sZHAEhStvkBlMPRSShBQgLFRvEEhYE8SnDIY8Vmm92lo8
         2cJ0/3dMDYTT5CMx3XH8KYzoySRkvALWLfBUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZtABFI5cNBm/eHiIyfTOBmMdnmCDUrTmiFxVvQRvIk=;
        b=Ie6eMTYwt0mKBK2RVY+zktUEhaOBxc4oVzoa7jyiRMW+ndP9n1+3NmSYvQ78k6qUmo
         bA3x2QJrk6aFSVHeH2uu3xDd3SQ6BaWFfF+frvbk9j+4RCuCY3cQ87zteivUGoJjwkmj
         IEwY3geOZ0nPQuyFYMRn2BxY8QkegJ19MrFA3wM+wXAGRUyROeN9WBRT5S9BGljoibuV
         dFMI03rLK31f4Fo8Ay2bn10Si6EUM1B6WT6UTC+gdtcr+7b2Nwf9RevMexTJ5VBc4OQR
         j0XRX7D7YhE9zD30JlW5sOkmBRyWOVFW5i5Xjr0O32RtmsR3VPvh2FhSKvzL6gDXUDOk
         IMvA==
X-Gm-Message-State: AOAM53003ulleAvLb9QtXVL9QKzMqx8LQ/G/TKrqZeI3NgDmBwfMjEHF
        KX2sa6f+cmnsRXEEkGjafP5JOg==
X-Google-Smtp-Source: ABdhPJxd7czwyrCJSKh5ynMPFWDnHcE4mDToDt0JOdBdGOMR5xzShdyJkrVpGkFsxOVJCGNHrzODAw==
X-Received: by 2002:a67:e146:: with SMTP id o6mr52916vsl.12.1644245537456;
        Mon, 07 Feb 2022 06:52:17 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id r14sm581347vke.20.2022.02.07.06.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:52:17 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/3] libbpf: Remove mode check in libbpf_set_strict_mode()
Date:   Mon,  7 Feb 2022 09:50:50 -0500
Message-Id: <20220207145052.124421-2-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207145052.124421-1-mauricio@kinvolk.io>
References: <20220207145052.124421-1-mauricio@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf_set_strict_mode() checks that the passed mode doesn't contain
extra bits for LIBBPF_STRICT_* flags that don't exist yet.

It makes it difficult for applications to disable some strict flags as
something like "LIBBPF_STRICT_ALL & ~LIBBPF_STRICT_MAP_DEFINITIONS"
is rejected by this check and they have to use a rather complicated
formula to calculate it.[0]

One possibility is to change LIBBPF_STRICT_ALL to only contain the bits
of all existing LIBBPF_STRICT_* flags instead of 0xffffffff. However
it's not possible because the idea is that applications compiled against
older libbpf_legacy.h would still be opting into latest
LIBBPF_STRICT_ALL features.[1]

The other possibility is to remove that check so something like
"LIBBPF_STRICT_ALL & ~LIBBPF_STRICT_MAP_DEFINITIONS" is allowed. It's
what this commit does.

[0]: https://lore.kernel.org/bpf/20220204220435.301896-1-mauricio@kinvolk.io/
[1]: https://lore.kernel.org/bpf/CAEf4BzaTWa9fELJLh+bxnOb0P1EMQmaRbJVG0L+nXZdy0b8G3Q@mail.gmail.com/

Fixes: 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
---
 tools/lib/bpf/libbpf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 81605de8654e..d5bac4ed7023 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -156,14 +156,6 @@ enum libbpf_strict_mode libbpf_mode = LIBBPF_STRICT_NONE;
 
 int libbpf_set_strict_mode(enum libbpf_strict_mode mode)
 {
-	/* __LIBBPF_STRICT_LAST is the last power-of-2 value used + 1, so to
-	 * get all possible values we compensate last +1, and then (2*x - 1)
-	 * to get the bit mask
-	 */
-	if (mode != LIBBPF_STRICT_ALL
-	    && (mode & ~((__LIBBPF_STRICT_LAST - 1) * 2 - 1)))
-		return errno = EINVAL, -EINVAL;
-
 	libbpf_mode = mode;
 	return 0;
 }
-- 
2.25.1

