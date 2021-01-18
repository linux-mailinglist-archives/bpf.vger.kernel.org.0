Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9D2FA581
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405918AbhARQCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406298AbhARQCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 11:02:36 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071BC0613ED
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:56 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id a9so8085976edy.8
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TqkGDF1ta5PCdnxEEvsF8Ma1Lt/vVVNhRWpTG6LTrD8=;
        b=skeG0dILnijwcANaFRzfFG8rns/gfweOPnEBdnioVj37CH0jabLoyCs8pkSk9UokwC
         Cq+ktrPAYJ9ABubh9LzgMr/5AZdBTGTaR1Ph8E6xbry2rqtZdl0jYnCPoEBEI6jwtW77
         DqNVltbUjUHsljLeFb1o7erBKBnYqAARQfPyQK2cXwmmJEg0W23x9HfmxDYW/QJnDuX6
         fX3FpqMOKfNLQnV9RcX9JqGCfVayXjjyawj6DAn4Sfn/E9DB7/ZFpfcVATHAncOxE8C2
         gjWmeOyp1sSGA41DwWg4HU10TqQinbYXP5hCupAr6THMXjp7knQlllZVpz7rGh2/6x1H
         rIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TqkGDF1ta5PCdnxEEvsF8Ma1Lt/vVVNhRWpTG6LTrD8=;
        b=RMidPznPuu2TWsKqVVocxUQuZ5jj49T3rI/LcYTGcJYg+CS2ond834dtBRl0x4ff38
         lgQZgQFTiRJ2bAdZzlMJDY6iJDfTVUlsSaNtUVV/CQzrRlgzmvWWvBXZV7TvxaQgtsUg
         vUYsvSDGhiZTlohDfqXuKZcXyqrs2RGwIZH4+T8jyLf38AFQY4RyAHfO00MCeuMmJLNf
         exUVGjIMa3WZfMV5qtij/XtfbMvkG/f6ua3k4swGE2RQBE9blt/tH2uO/jM8sBrGtjur
         f2/TNdmVlha5HD5Y3FLxwc4JOUoKjTszAxi09BHu/r40R32u/HQXLN711/VF71YYriBh
         P41w==
X-Gm-Message-State: AOAM531rqCXatVMedubhnX8K1pUEYI9eP2VUTDrEzjP7Qt1MyTuWylt9
        W8tatLYVnVs8Ve4xyFD40/tXJ4RqgiQJHQ==
X-Google-Smtp-Source: ABdhPJyUWrBT4UlLd93wmvwwr+Ba6wo0Z3mXx1DRRmGWRLYjv9cnrAdfGCj0xvRwKN6BhYXAA17iu5VlIxUdWA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6402:158:: with SMTP id
 s24mr119650edu.19.1610985714831; Mon, 18 Jan 2021 08:01:54 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:39 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210118160139.1971039-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is to avoid misaligned access when memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 7552d8e..2f12d53 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			goto unlink;
 		}
 
+		snprintf(cmd, sizeof(cmd), "%s --set-section-alignment .BTF=16 %s",
+			 llvm_objcopy, filename);
+		if (system(cmd)) {
+			/* non-fatal, this is a nice-to-have and it's only supported from LLVM 10 */
+			fprintf(stderr, "%s: warning: failed to align .BTF section in '%s': %d!\n",
+				__func__, filename, errno);
+		}
+
 		err = 0;
 	unlink:
 		unlink(tmp_fn);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

