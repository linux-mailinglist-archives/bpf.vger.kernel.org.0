Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCC6C90FB
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCYVcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYVcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 17:32:05 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAFCC19;
        Sat, 25 Mar 2023 14:32:04 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id g9so4334827qvt.8;
        Sat, 25 Mar 2023 14:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679779923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvytPOgIy3Mzp1dIziBHWQjN9qpIziod7hYaS4cen+M=;
        b=Y34KnqYZlK5vXV2421T4gbHnREimFrxzx4Ih2ombUGEVfWA+K7YvaFN0K2TvFxJheU
         L3Tz4T2Gcd+lBK7GZbR99eyrFHcyU60IQUeAov7c4s0EuO4XIYugttsQa/TLKrdCanKs
         gnLC1lH9W/haShPG+puuTA7z+xXT+Hw5AKZjaFi3uEXdzL77qy1Ot/BqP5CcXSIVn9VL
         yU2M/OGa1n1F9o53M5m13twf3Nqlxnv2GUfQSwfI0ULfE8eJYPpepT8rxT/LaD20nq/H
         ebSLaHl7BRnyVZV0AE5y0z8z0zMgpidKJBImTyus2yLF6O9Auk7qMZzV10M0feTGzjke
         JqUQ==
X-Gm-Message-State: AAQBX9dKCw5tX26CwU9l0wMSEQwqYoQVz94tnXLplxhgk6gGQR2+dxgT
        vyTGHLdlU9Kdy//0ygFFEdF+uIHtdjSUAQD4kzU=
X-Google-Smtp-Source: AKy350bUjO0srAaw17BBSGXnuViTo0DVMu7OEflLlNXPoayy/mmKo9CFHMhrqtFX4H0mGWYB1yatDg==
X-Received: by 2002:a05:6214:ac6:b0:5ac:208c:4e64 with SMTP id g6-20020a0562140ac600b005ac208c4e64mr13523457qvi.37.1679779923301;
        Sat, 25 Mar 2023 14:32:03 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id z8-20020a0cd788000000b005dd8b934587sm1713947qvi.31.2023.03.25.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 14:32:03 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: Only invoke kptr dtor following non-NULL xchg
Date:   Sat, 25 Mar 2023 16:31:42 -0500
Message-Id: <20230325213144.486885-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230325213144.486885-1-void@manifault.com>
References: <20230325213144.486885-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a map value is being freed, we loop over all of the fields of the
corresponding BPF object and issue the appropriate cleanup calls
corresponding to the field's type. If the field is a referenced kptr, we
atomically xchg the value out of the map, and invoke the kptr's
destructor on whatever was there before (or bpf_obj_drop() it if it was
a local kptr).

Currently, we always invoke the destructor (either bpf_obj_drop() or the
kptr's registered destructor) on any KPTR_REF-type field in a map, even
if there wasn't a value in the map. This means that any function serving
as the kptr's KF_RELEASE destructor must always treat the argument as
possibly NULL, as the following can and regularly does happen:

void *xchgd_field;

/* No value was in the map, so xchgd_field is NULL */
xchgd_field = (void *)xchg(unsigned long *field_ptr, 0);
field->kptr.dtor(xchgd_field);

These are odd semantics to impose on KF_RELEASE kfuncs -- BPF programs
are prohibited by the verifier from passing NULL pointers to KF_RELEASE
kfuncs, so it doesn't make sense to require this of BPF programs, but
not the main kernel destructor path. It's also unnecessary to invoke any
cleanup logic for local kptrs. If there is no object there, there's
nothing to drop.

So as to allow KF_RELEASE kfuncs to fully assume that an argument is
non-NULL, this patch updates a KPTR_REF's destructor to only be invoked
when a non-NULL value is xchg'd out of the kptr map field.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a09597c95029..e18ac7fdc210 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -677,6 +677,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			break;
 		case BPF_KPTR_REF:
 			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
+			if (!xchgd_field)
+				break;
+
 			if (!btf_is_kernel(field->kptr.btf)) {
 				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
-- 
2.39.0

