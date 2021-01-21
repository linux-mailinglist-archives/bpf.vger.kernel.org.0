Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19E42FE8EE
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbhAULgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbhAULgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 06:36:07 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AEC0613D6
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:27 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g17so808615wrr.11
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ufMNqtr2froN5NhNrq+9XfQmylek3tVcYtCEPpmC7MI=;
        b=g1UWbIeSDKI7xy3Z4cq92acJrZ3dq84cLApjLQgGJsPDSnnqlShsCjUY+Rl+MTNq8s
         M3SUEZCfhh2uXH7+VLccza+7t5dU1e7aDL0zjP07QXigWxcnJ7tAN4Akqb9COU3R65n5
         eaAjf5q57bpvBcICBLlX0iyDgVhxrAqVraR9wV+4Xm7eo8U9mRmFku2QtZjeDZzGqL32
         +rImKzUP1v07HTtYxTRWXLSdLf6sWkLTZZ7bG3u1zGrlP8mBDLlJyac0T2kDrObCMfE4
         MbFBZnc2upUQbigbPgD7WNEcng0SFJsxhNeCLDyY7OczCGJJTv2lCYn0u6Jny5oweRGl
         GXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ufMNqtr2froN5NhNrq+9XfQmylek3tVcYtCEPpmC7MI=;
        b=dgUrhVtCqEC47guJSMC9pS6aZs8XJETTxw0rk13sWNfQZNjZriGUsRsXww+xwZT1pT
         Bm7tB7P93WO8LYJ/U+jZfAe4kNo+aj6epK+TXY54p7vI0dGMB1noAuLnAxZdlz7IN5di
         ib+J5R+4gNhrzet1gAgV2HFtAuyn7KyEI2WrRNgiPbww7EIECppmbZo+vpqYlmFJDGBM
         NOLVHXzAUU8iYnigfG0rQ9AGYfltwlPKYXU2Yl3vZugdsh852qJgDjWC28IvYhFpIqVo
         TwuyR40XyJYs/zEX6eTvDGhTplF2rxOXtcNA+lSVI8t2RZdDLB8Mzy6vGkrWFn1EmyNJ
         rNTQ==
X-Gm-Message-State: AOAM533URrT1lqV3NWrUkw+N/UhPYYVyjR12Wo1/ZYMjjC4vBN+AZGXp
        xislj5yXuWQ6/3FsuJXl19wHh4h0yfnwkA==
X-Google-Smtp-Source: ABdhPJwpbFDiV630Klw6CHkClUjz++LTTH7yVmGh3ybWxS0IMB2IVq9fm22eoGk2Yjb5ZkKEhrljkMTZ94pMSA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a5d:690d:: with SMTP id
 t13mr13728061wru.410.1611228925660; Thu, 21 Jan 2021 03:35:25 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:18 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 1/3] btf_encoder: Fix handling of restrict qualifier
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This corrects a typo that resulted in 'restrict' being treated as 'const'.

Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libbtf.c b/libbtf.c
index 16e1d45..3709087 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
 		id = btf__add_const(btf, type);
 		break;
 	case BTF_KIND_RESTRICT:
-		id = btf__add_const(btf, type);
+		id = btf__add_restrict(btf, type);
 		break;
 	case BTF_KIND_TYPEDEF:
 		id = btf__add_typedef(btf, name, type);
-- 
2.30.0.296.g2bfb1c46d8-goog

