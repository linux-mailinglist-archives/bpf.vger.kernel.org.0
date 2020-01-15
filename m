Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7D13CAB0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAORNY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:13:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so5231973wmd.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMrzaXbHOJoXJR4BqSM8/Q4xofgHVyPxrukOYhnuR8w=;
        b=CDuGgPNGWYz4c7wtILqThkFOu+2SErXXx0agyzMiefku/qGD/up2rxB74jjJxZUpBd
         CGMun26K8cwuHV8+eF1JDPocckf2uAIRYQlk2HncWsO3bcdjtDSbfcIWLkcZ8KVUc2zI
         K5bVO4gJX9/CZv2WMSjT0r0RtWS0O7XLR3pkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMrzaXbHOJoXJR4BqSM8/Q4xofgHVyPxrukOYhnuR8w=;
        b=UrPTlivIKb76SKiNCKiVD5TQ63KeP88yu383HyDwsgEtAsY+5nuytRThUON88dyc1M
         9mbIwqEutTNKBZOP3SA0/CwoENfni2Mn6so7Cqd1rzywCJoBhz9H0/ppqrZ+TbLi9mTk
         QXxOdqZ2t6qh2U9SgHuvCpjW7+fJoAB4n1mkJ5gB5QVncyEfVB/Y+qzDKtwMdYgtwxTo
         wgdnwiXFuxromj1rsgWgpkjSLe8BCMZmSu1HYUxGCCuSmoa/13YnKGPmQbPuiIw/cX2G
         ynzPs1fxj8ZRm8PrEjbT38ma0ZtZ3gwnqnfrf1b2pDdtQJh9ETUZjWLrWRq4XTO8YWkR
         elfw==
X-Gm-Message-State: APjAAAXRcUubS8JGd5lpNyBf8zK8ie8cgRqWwjH1t6HUVQKoXjAwvkop
        RQqYnI3nnWGiY3eTntymBjhQ+g==
X-Google-Smtp-Source: APXvYqw+83aJOogdP51uHjakQPrbRphvcxTyKNh4lFcbQf8mJWthRqQx/L4xsXdKWcUBUCE2YaLkWA==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr978688wmb.32.1579108401751;
        Wed, 15 Jan 2020 09:13:21 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:21 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v2 01/10] bpf: btf: Make some of the API visible outside BTF
Date:   Wed, 15 Jan 2020 18:13:24 +0100
Message-Id: <20200115171333.28811-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- Add an extern for btf_vmlinux in btf.h
- Add btf_type_by_name_kind, the LSM code does the combination of
  btf_find_by_name_kind and btf_type_by_id quite often.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/btf.h |  8 ++++++++
 kernel/bpf/btf.c    | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 881e9b76ef49..dc650d294bc4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -15,6 +15,7 @@ struct btf_type;
 union bpf_attr;
 
 extern const struct file_operations btf_fops;
+extern struct btf *btf_vmlinux;
 
 void btf_put(struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr);
@@ -66,6 +67,8 @@ const struct btf_type *
 btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		 u32 *type_size, const struct btf_type **elem_type,
 		 u32 *total_nelems);
+const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
@@ -142,6 +145,11 @@ static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 {
 	return NULL;
 }
+static inline const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline const char *btf_name_by_offset(const struct btf *btf,
 					     u32 offset)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 832b5d7fd892..b8968cec8718 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -436,6 +436,23 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 	return NULL;
 }
 
+const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind)
+{
+	const struct btf_type *t;
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, name, kind);
+	if (type_id < 0)
+		return ERR_PTR(-EINVAL);
+
+	t = btf_type_by_id(btf, type_id);
+	if (!t)
+		return ERR_PTR(-EINVAL);
+
+	return t;
+}
+
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
  */
-- 
2.20.1

