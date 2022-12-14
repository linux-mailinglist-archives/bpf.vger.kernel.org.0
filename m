Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9A64C196
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 02:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiLNBBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 20:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiLNBBp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 20:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492026494
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670979660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YoVO1S/lRb6mfezKacXvsssJ94nzJ1wrr5seAJE0P+U=;
        b=P6/smwef8IEoKhpmKRYYUhmHKr+97O8KoQO9qnDFPZvkP/E6aetDxY2+RxsQeI8V521108
        oN5NSfNuXu7b64kqGCf/H7XqeuEajNtouZ2LuOb8EuUj+F+2oktuU1SGQq8Qc44YouEiO/
        BnKtTf7stJ5lWQgqnKychoA3OQciPX4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-TwCUIBbmPQ67DE6GdRJqaQ-1; Tue, 13 Dec 2022 20:00:59 -0500
X-MC-Unique: TwCUIBbmPQ67DE6GdRJqaQ-1
Received: by mail-ej1-f70.google.com with SMTP id sd23-20020a1709076e1700b007c16f834c4aso5138705ejc.22
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoVO1S/lRb6mfezKacXvsssJ94nzJ1wrr5seAJE0P+U=;
        b=E4Zby+WeJF7M2d8HtwpTh4WmPznnhoG6t3Yp3yTRdDgQWp37IL4HZvAdxt/oHO57Sc
         SUBkLQZsFD5Y+6n9PH1j+yZovE+f13OoNpnRnPipdnFBaAX3FmF7z0cOudzgjpv1Clmy
         JcjiwG+4jAM9W5xibw1RyffrDUEaWyVEnWabobnz2n4Nml0iVXGgGHxB9/knJRD1KDKN
         1DFio8M1QhmA1+iELtVIhmZm8sfPn2RLS1/Em8Bk6gHxkfZB7Kas8NOFB/YpNY7I6ZIC
         7FfjILkqP3fX21u0ZviDgksw01IDcM1dQLaY/jvfCLCBahqx/62J8YH0Kjw4Dn+7SZvZ
         E3lg==
X-Gm-Message-State: ANoB5pnd3LF+6tz1bW0dt2Vr+7j5OR51GnvWH+YETlYZaJptczd/B0Zu
        SZzAoA/hXfG7KiKMunuyrhQloQIc58QWgTV85Zco3jzxHPEZvwCWCadIa1wTkXFS8VrRk70nUx2
        58Z5thwxwPG0R
X-Received: by 2002:a17:907:397:b0:7c1:58cb:86b9 with SMTP id ss23-20020a170907039700b007c158cb86b9mr12604185ejb.28.1670979657183;
        Tue, 13 Dec 2022 17:00:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6elrpFzMbKUHsLnh4mzXZM7JMCmNRUUpMFj7YN3MHbPNOQZB019yZyPZ0lzz/kJlGQmW1S/g==
X-Received: by 2002:a17:907:397:b0:7c1:58cb:86b9 with SMTP id ss23-20020a170907039700b007c158cb86b9mr12604126ejb.28.1670979656077;
        Tue, 13 Dec 2022 17:00:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906251500b007b29eb8a4dbsm5232109ejb.13.2022.12.13.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:00:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1809B82F420; Wed, 14 Dec 2022 02:00:53 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
Subject: [PATCH bpf] libbpf: Fix signedness confusion when using libbpf_is_mem_zeroed()
Date:   Wed, 14 Dec 2022 02:00:46 +0100
Message-Id: <20221214010046.668024-1-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The commit in the Fixes tag refactored the check for zeroed memory in
libbpf_validate_opts() into a separate libbpf_is_mem_zeroed() function.
This function has a 'len' argument of the signed 'ssize_t' type, which in
both callers is computed by subtracting two unsigned size_t values from
each other. In both subtractions, one of the values being subtracted is
converted to 'ssize_t', while the other stays 'size_t'.

The problem with this is that, because both sizes are the same
rank ('ssize_t' is defined as 'long' and 'size_t' is 'unsigned long'), the
type of the mixed-sign arithmetic operation ends up being converted back to
unsigned. This means it can underflow if the user-specified size in
opts->sz is smaller than the size of the type as defined by libbpf. If that
happens, it will cause out-of-bounds reads in libbpf_is_mem_zeroed().

To fix this, change libbpf_is_mem_zeroed() to take unsigned start and end
offsets instead of a signed length. This avoids all casts between signed
and unsigned types and should hopefully prevent a similar error from
reappearing in the future.

Fixes: 3ec84f4b1638 ("libbpf: Add bpf_cookie support to bpf_link_create() API")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf_internal.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..92375a86b15c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -267,13 +267,14 @@ void *libbpf_add_mem(void **data, size_t *cap_cnt, size_t elem_sz,
 		     size_t cur_cnt, size_t max_cnt, size_t add_cnt);
 int libbpf_ensure_mem(void **data, size_t *cap_cnt, size_t elem_sz, size_t need_cnt);
 
-static inline bool libbpf_is_mem_zeroed(const char *p, ssize_t len)
+static inline bool libbpf_is_mem_zeroed(const char *obj,
+					size_t off_start, size_t off_end)
 {
-	while (len > 0) {
+	const char *p;
+
+	for (p = obj + off_start; p < obj + off_end; p++) {
 		if (*p)
 			return false;
-		p++;
-		len--;
 	}
 	return true;
 }
@@ -286,7 +287,7 @@ static inline bool libbpf_validate_opts(const char *opts,
 		pr_warn("%s size (%zu) is too small\n", type_name, user_sz);
 		return false;
 	}
-	if (!libbpf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
+	if (!libbpf_is_mem_zeroed(opts, opts_sz, user_sz)) {
 		pr_warn("%s has non-zero extra bytes\n", type_name);
 		return false;
 	}
@@ -309,11 +310,10 @@ static inline bool libbpf_validate_opts(const char *opts,
 	} while (0)
 
 #define OPTS_ZEROED(opts, last_nonzero_field)				      \
-({									      \
-	ssize_t __off = offsetofend(typeof(*(opts)), last_nonzero_field);     \
-	!(opts) || libbpf_is_mem_zeroed((const void *)opts + __off,	      \
-					(opts)->sz - __off);		      \
-})
+	(!(opts) || libbpf_is_mem_zeroed((const void *)opts,		      \
+					 offsetofend(typeof(*(opts)),	      \
+						     last_nonzero_field),     \
+					 (opts)->sz))
 
 enum kern_feature_id {
 	/* v4.14: kernel support for program & map names. */
-- 
2.38.1

