Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474DA2B0B25
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKLRTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgKLRTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 12:19:14 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4F5C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 09:19:14 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so6202169wme.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XvDI+wpjgB/udB/U6ZUMsnDIItG6AuNAvWmNdWpIRQ=;
        b=Ew9Ci5IVEs+gXfeUj+EvmQeFjAbr4dHKtv3Q3ejJ8NSL+09gHjalNqMwvH7jSXUnR9
         a4Lr0WZFY2l2AdDrYTOYylgMH2JKENkBtXVuo9NUP0YS3kVKM04aiing3JNEWP0pMxLK
         mnqWCDWbV6bLa8p/t5rs39VQCW0X13zMHlSX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XvDI+wpjgB/udB/U6ZUMsnDIItG6AuNAvWmNdWpIRQ=;
        b=kgSP7+eBa5p89vJycOrsuZMhYvR27mcjZD2OdT/drp85330RVNaSydhozN5cp5Xr7O
         8I/YznFixYb70kEx7Ndmciwgp4QEeiWR4JKxhvfolEk2hbEmnltFwuaOfXYQ2ITg6NeB
         NzA93+Obi2O7Q1K7BLwUzyXhYMbmeB45b/Hvuj9AEz+OZK1DqXxuuW8W8tLHuXnk0GOD
         Dg9jyUM0NGk5AxQLU0NcT8tsxHoOed9CqVXt4aYovuaeAkiw0TUhYwTl1dX2WOiEhGIS
         J1stNLiW6fQGncfE8iyQw5L+dptWUUak+4ep4NPVqkW1WOMfNVelGnyHuPt+f15eHUZU
         lKZg==
X-Gm-Message-State: AOAM532grBGajAMZqvhBJJBk+M8VfAKzp+4cf7s6LJ0L9idZt/a+IxZr
        6pACdimYwItIbByqzU52nd4fQTOVw/EcbHku
X-Google-Smtp-Source: ABdhPJxtb3xAXucUIwDy00Nbo+QUk5aaTGZn8BH76+rY8KOzU2DRSA6mlwusdQmBAS1+shXhBFTgjw==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr681965wmj.14.1605201552803;
        Thu, 12 Nov 2020 09:19:12 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m18sm5574938wru.37.2020.11.12.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:19:12 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 2/2] bpf: Expose bpf_d_path helper to sleepable LSM hooks
Date:   Thu, 12 Nov 2020 17:19:07 +0000
Message-Id: <20201112171907.373433-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112171907.373433-1-kpsingh@chromium.org>
References: <20201112171907.373433-1-kpsingh@chromium.org>
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
2.29.2.222.g5d2a92d10f8-goog

