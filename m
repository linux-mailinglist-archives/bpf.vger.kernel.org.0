Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994302B1398
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMA75 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 19:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKMA74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 19:59:56 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB50C0613D6
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:41 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so7178898wmg.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 16:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpc+8RaEdy9qZiZdDQDUeaaADVDGgLUTfDOc8IUPCu4=;
        b=PKma7TRMmdiNVC9nQ3CYstKP6BtQL0TbUe9TzMWmWdtw5oP2N7Cm/kdclFsCzvyUIu
         Sx9SiVaxSdhTo36oodx51MWjGdtNJiWqbJjpn33sDPs6N4eeVOyTNkE5dLbjBH2dnvCq
         2S58wCBjBQwR7O4klWGvRy2nsAPFu0+xlqiXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpc+8RaEdy9qZiZdDQDUeaaADVDGgLUTfDOc8IUPCu4=;
        b=DRrpJhbHFNp8edPTHC/j88Kb8CTsZ5vEd+0LJgpzioGGWZaGcmr13dt7l4zAyfxb5R
         v6EyeIA1GeE13Huv3bpJ4uTWyroIudUVZ02mlXMmbaSiuxXuKVBMG/+WwL1XXDezQd7N
         WDwNV0FEGOzm66imR5/773mbSuhUdoLO3/byQ4jM7NHaBKsWGHy3P8q9no1MAp9LGLVV
         pya98kpnq32vhoBJGmy2sRFyUT00t+T0Tx2fZ8zBz1/fIuQUiFidowHVexIO8JX1NINQ
         +hnmJ164vHs+VgbDCVAdJ0/psikB4l52TQeBSICPTxJZP+xN0rthl9DKHmTE1Euw/wnf
         vx+w==
X-Gm-Message-State: AOAM532aM7sqqZUUrhySHCR/lw6k++CjktOyWYNJYYrGzPL/qOcATfC8
        wsq+VavAyjofb+jOoE2MGcdh2s5pBg6MSkvr
X-Google-Smtp-Source: ABdhPJwqRBtztictHPFaO1CqHOEPx3JAsYtBLem4ynSphW9/ITT1tfLOGIoBNi4uPq61r2hT1i1nhQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr538648wmg.18.1605229179819;
        Thu, 12 Nov 2020 16:59:39 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm4508104wrv.6.2020.11.12.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:59:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 2/2] bpf: Expose bpf_d_path helper to sleepable LSM hooks
Date:   Fri, 13 Nov 2020 00:59:30 +0000
Message-Id: <20201113005930.541956-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201113005930.541956-1-kpsingh@chromium.org>
References: <20201113005930.541956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Sleepable hooks are never called from an NMI/interrupt context, so it is
safe to use the bpf_d_path helper in LSM programs attaching to these
hooks.

The helper is not restricted to sleepable programs and merely uses the
list of sleeable hooks as the initial subset of LSM hooks where it can
be used.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 kernel/trace/bpf_trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..eab1af02c90d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_lsm.h>
 
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
@@ -1178,7 +1179,11 @@ BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
-	return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+
+	return btf_id_set_contains(&btf_allowlist_d_path,
+				   prog->aux->attach_btf_id);
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
-- 
2.29.2.299.gdc1121823c-goog

