Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA198C0605
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfI0NIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Sep 2019 09:08:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44858 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfI0NIv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 09:08:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id r16so2237664edq.11
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2019 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t798kdQUcfAYE/1V829ZixveOdeFQG/DTCItAoKM464=;
        b=hEQoZA6oVCySqYsY84lMoejfdPlNCU6Tyqp7nB7qv+lkAPFbm+kumHNEMsMrvHueRA
         NZa1WZXKEJfxfif3wtPhRljiZiRinlKfEOflojVnW6/fj9CrN+nTgcVZNsQswpiJ5eh0
         s0gLBo0j3th/2gQl+HUuKFNUeKRSy/NGxA+kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t798kdQUcfAYE/1V829ZixveOdeFQG/DTCItAoKM464=;
        b=V9ntikDm/EhzB3D2iHSLIfLVzceAhKLClS2GHXdmFsSg15KIFJTz+5zAEaVp8RFLuw
         fupJS9+GZkOIK9zJmPADpgAu1dRBpZWkkn82jJZ2Ubokl2XsKwSxXLu0DGYVmQhlljJT
         3XWHEKMsGbcYM0kEvUSxnVrtF0yQLXcQZgTsrLrQ4uCUfxRm/RUGxTekdktEUqtRdpfV
         sOD9Q37CEfNf7KNIvsB4urueyCBGxoJLBS7N1oshNv4QxJItBKIwxTunLxQhNI+kh8EF
         dWYOvWU3Mg4WTn6oJBe0rBkz9gNLHd1N1w3uxOP4PvVFu7eg1tl5X7uOenKaRcoQlQup
         84QQ==
X-Gm-Message-State: APjAAAWIQ9yA0KIxWsOo2+xowU0CouW14aqQ7cVhPD9DTE2uxT56JN6l
        eGzcv235wAmAXaq1nDUW3jBG9Q==
X-Google-Smtp-Source: APXvYqx1o2fwr7rmR9/LEX6BQ4fNBvguKPIdJVPGN4IfoNucEfqZIrUtHHJOD7+hbZQOXBTflpFs+Q==
X-Received: by 2002:a17:906:d797:: with SMTP id pj23mr7805635ejb.70.1569589728925;
        Fri, 27 Sep 2019 06:08:48 -0700 (PDT)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:440a:66a5:a253:2909])
        by smtp.gmail.com with ESMTPSA id g19sm567727eje.0.2019.09.27.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:08:48 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH] tools: libbpf: Add bpf_object__open_buffer_xattr
Date:   Fri, 27 Sep 2019 15:08:34 +0200
Message-Id: <20190927130834.18829-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Introduce struct bpf_object_open_buffer_attr and an API function,
bpf_object__open_xattr, as the existing API, bpf_object__open_buffer,
doesn't provide a way to specify neither the "needs_kver" nor
the "flags" parameter to the internal call to the
__bpf_object__open which makes it inconvenient for loading BPF
objects that do not require a kernel version from a buffer.

The flags attribute in the bpf_object_open_buffer_attr is set
to MAPS_RELAX_COMPAT when used in bpf_object__open_buffer to
maintain backward compatibility as this was added to load objects
with non-compat map definitions in:

commit c034a177d3c8 ("bpf: bpftool, add flag to allow non-compat map
		      definitions")

and bpf_object__open_buffer was called with this flag enabled (as a
boolean true value).

The existing "bpf_object__open_xattr" cannot be modified to
maintain API compatibility.

Reported-by: Anton Protopopov <a.s.protopopov@gmail.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c   | 39 ++++++++++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.h   | 10 ++++++++++
 tools/lib/bpf/libbpf.map |  5 +++++
 3 files changed, 43 insertions(+), 11 deletions(-)

This patch is assimilates the feedback from:

  https://lore.kernel.org/bpf/20190815000330.12044-1-a.s.protopopov@gmail.com/

I have added a "Reported-by:" tag, but please feel free to update to
"Co-developed-by" if it's more appropriate from an attribution perspective.

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2b57d7ea7836..1f1f2e92832b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2752,25 +2752,42 @@ struct bpf_object *bpf_object__open(const char *path)
 	return bpf_object__open_xattr(&attr);
 }
 
-struct bpf_object *bpf_object__open_buffer(void *obj_buf,
-					   size_t obj_buf_sz,
-					   const char *name)
+struct bpf_object *
+bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *attr)
 {
 	char tmp_name[64];
 
 	/* param validation */
-	if (!obj_buf || obj_buf_sz <= 0)
-		return NULL;
+	if (!attr || !attr->obj_buf || !(attr->obj_buf_sz <= 0))
+		return ERR_PTR(-EINVAL);
 
-	if (!name) {
+	if (!attr->obj_name) {
 		snprintf(tmp_name, sizeof(tmp_name), "%lx-%lx",
-			 (unsigned long)obj_buf,
-			 (unsigned long)obj_buf_sz);
-		name = tmp_name;
+			 (unsigned long)attr->obj_buf,
+			 (unsigned long)attr->obj_buf_sz);
+		attr->obj_name = tmp_name;
 	}
-	pr_debug("loading object '%s' from buffer\n", name);
+	pr_debug("loading object '%s' from buffer\n", attr->obj_name);
+
+	return __bpf_object__open(attr->obj_name, attr->obj_buf,
+				  attr->obj_buf_sz,
+				  bpf_prog_type__needs_kver(attr->prog_type),
+				  attr->flags);
+}
+
+struct bpf_object *bpf_object__open_buffer(void *obj_buf,
+					   size_t obj_buf_sz,
+					   const char *name)
+{
+	struct bpf_object_open_buffer_attr attr = {
+		.obj_name	= name,
+		.obj_buf	= obj_buf,
+		.obj_buf_sz	= obj_buf_sz,
+		.prog_type	= BPF_PROG_TYPE_UNSPEC,
+		.flags		=  MAPS_RELAX_COMPAT,
+	};
 
-	return __bpf_object__open(name, obj_buf, obj_buf_sz, true, true);
+	return bpf_object__open_buffer_xattr(&attr);
 }
 
 int bpf_object__unload(struct bpf_object *obj)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5cbf459ece0b..ad0f5a263594 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -67,6 +67,14 @@ struct bpf_object_open_attr {
 	enum bpf_prog_type prog_type;
 };
 
+struct bpf_object_open_buffer_attr {
+	const char *obj_name;
+	void *obj_buf;
+	size_t obj_buf_sz;
+	enum bpf_prog_type prog_type;
+	int flags;
+};
+
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
 bpf_object__open_xattr(struct bpf_object_open_attr *attr);
@@ -75,6 +83,8 @@ struct bpf_object *__bpf_object__open_xattr(struct bpf_object_open_attr *attr,
 LIBBPF_API struct bpf_object *bpf_object__open_buffer(void *obj_buf,
 						      size_t obj_buf_sz,
 						      const char *name);
+LIBBPF_API struct bpf_object *
+bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *attr);
 int bpf_object__section_size(const struct bpf_object *obj, const char *name,
 			     __u32 *size);
 int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..4d5dcc58c73d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
 		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
+
+LIBBPF_0.0.5 {
+	global:
+		bpf_object__open_buffer_xattr;
+} LIBBPF_0.0.4;
-- 
2.20.1

