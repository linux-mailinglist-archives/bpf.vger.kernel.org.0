Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4047E402
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 14:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbhLWNRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 08:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348613AbhLWNRm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Dec 2021 08:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640265462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TVC1GQHPjkWS2kQl8UspAoN8IBhjJpUMo49RPwnmofY=;
        b=CXY8XTUATqwJYn1F0KzLFskZAfVl5hBxI8zwiwEKBIjqKpkRgW0HmiV4f4gOA7kWGNj9ng
        Rk5NGZq3iTXtHUpk0UHQsyEmY2vdfbO4qaJ2tRzMUTtGCWVsXSWWLZkSL6q4ZZtLiJfj5W
        31AlsXk/rYa78yNEgjfM2X+8ZU66GTM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-ikIpYaOZMXSS6hcyqyYzXA-1; Thu, 23 Dec 2021 08:17:39 -0500
X-MC-Unique: ikIpYaOZMXSS6hcyqyYzXA-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b003f7ed57f96bso4462179edd.16
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 05:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVC1GQHPjkWS2kQl8UspAoN8IBhjJpUMo49RPwnmofY=;
        b=oXpWm/IV70q9ngINkp3DbBdOwS/44KBOuR9I4xkX0Y2ztKOk0+BsNglQnJN2TN+tcr
         uIWe2ULbbMb7BKJSDmHGx0C9DVrvbZGiIA+EYK5FdzXl7K7GG1eYsfvNe58HqzuwHmrG
         EPUTmh87D1n9wiwAMsOx8Q9s2rlaVg18EZu2Uuj4+zYeFKpr9CJAn0u165wbgedQwl0J
         LiySV7NbNI5KyPRm5KRNJx0hXutKYYR8uWOEYNpALgPv6TlOsyYOhDL/kDpTSpJF1V//
         97AyyHZxB6HGHM9EiVa56ZYhVWX+c9nJ6OE4YRlhbj3hfnvr9XiqnK+6eFz82oUdSG2J
         IbZw==
X-Gm-Message-State: AOAM533EU7vBgFmLqLP99tCb5A5jdz1eDsg5tQ1qoMm7J1E90Ww45JnT
        66lzBqS7oVIxln4BxMuEvQIrfsnfBNinVR5QeMX+4UXagoOGs1LIhMtfFvRymupJgvW/5VH5vzI
        avJHqs2oIUtT+
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr1912139edd.257.1640265458215;
        Thu, 23 Dec 2021 05:17:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCiKIFpTbJoKXgfcKHEZ54xECpeKpBquce8nFLhnQd0JEH5XvYPFm0WKzuaxXXPxp5R5twDA==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr1912126edd.257.1640265458015;
        Thu, 23 Dec 2021 05:17:38 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id h10sm1708489ejx.115.2021.12.23.05.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:17:37 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 1/2] libbpf: Do not use btf_dump__new macro for c++ objects
Date:   Thu, 23 Dec 2021 14:17:35 +0100
Message-Id: <20211223131736.483956-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported in here [0], C++ compilers don't support __builtin_types_compatible_p(),
so at least don't screw up compilation for them and let C++ users
pick btf_dump__new vs btf_dump__new_deprecated explicitly.

[0] https://github.com/libbpf/libbpf/issues/283#issuecomment-986100727
Fixes: 6084f5dc928f ("libbpf: Ensure btf_dump__new() and btf_dump_opts are future-proof")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 742a2bf71c5e..061839f04525 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -313,12 +313,18 @@ LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
  *
  * The rest works just like in case of ___libbpf_override() usage with symbol
  * versioning.
+ *
+ * C++ compilers don't support __builtin_types_compatible_p(), so at least
+ * don't screw up compilation for them and let C++ users pick btf_dump__new
+ * vs btf_dump__new_deprecated explicitly.
  */
+#ifndef __cplusplus
 #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(				\
 	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||		\
 	__builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),	\
 	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),	\
 	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
+#endif
 
 LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
-- 
2.33.1

