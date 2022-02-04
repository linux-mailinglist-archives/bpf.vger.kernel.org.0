Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E04AA3C9
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 23:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbiBDW6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 17:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377743AbiBDW6e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 17:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644015513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LOflVIKz+gCbrlxQKB68Ohtlehw+OxBW97y22Jm7KQ=;
        b=ZZRvmnVcQdR2UadNVp5B651Ik4svt9c8iWUqXEO9ELWyXXjPry4AFmHKzKgduMx4s8kzyk
        nHoX6kIdHTaZgwGzlFR7aRKJY1HWd2YMCDZfNe/FTnEH7V9pd6w0CIoFdjEA8KcIFWHfnY
        pHpJr2nWmY8eSTYNd/juRsf09fbmekY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648--rabi5v1NkeMpMmbB8Q3ow-1; Fri, 04 Feb 2022 17:58:32 -0500
X-MC-Unique: -rabi5v1NkeMpMmbB8Q3ow-1
Received: by mail-ed1-f72.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso3995284edi.11
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 14:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LOflVIKz+gCbrlxQKB68Ohtlehw+OxBW97y22Jm7KQ=;
        b=LVZAi3rXh0LKDZEH0upEQ6k13YCD2K2XVzAxULzjSzmqyziUTY7+rt3IGsSPK2wSLi
         P92Rt/FfMtSYB6jE7h3oyw7DtqKo5Zm2vre9Ej/KRvAQxp2O2X1ko1mxTDnyaR/BqoKP
         /S+8JnQpTRl/PurH52Gh6QTbS2OljMy5Gs8TO1lsvyAY3zmh2Z8nZCbin73HBaU7cKkb
         e0PfGcqYpSQLNNzN+h5e439ghn2V9y8J5YjvoK3ItD52SwfqyPlmCQABhY2gZacwkIy0
         XDz0YScbpynCzTRom+CVJvi2fuRJz+vlGjYXrNl8udxJhOyIf+FgFC0jx2VDIWA+6rh8
         NbkQ==
X-Gm-Message-State: AOAM533zfhx079uiXBMB1BQ7po2dwmhzr03FKIu7SBAfcsGiZfnWOXiM
        z3EYGiXG4QEhcvKbRLlQvrqySTZKgGA0F2EyXCKeLh5ydCrkBpuGFl+0d+U42lxcXxQauSvh2up
        LjT14dp5KQFlw
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr937014ejt.751.1644015511280;
        Fri, 04 Feb 2022 14:58:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6IL8n9tVhuRgQ3jvRArA9AOU5deGUjVMA0DGzi3+xQc/p0kKsKg+8zmN8UUUUXnmf8QAvww==
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr936998ejt.751.1644015511146;
        Fri, 04 Feb 2022 14:58:31 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id gh14sm1060169ejb.126.2022.02.04.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:58:30 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf/test_offload.py: Add more base maps names
Date:   Fri,  4 Feb 2022 23:58:22 +0100
Message-Id: <20220204225823.339548-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204225823.339548-1-jolsa@kernel.org>
References: <20220204225823.339548-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding more base maps that can show in bpftool map output,
so we can properly filter them out.

This fixes for me following test_offload.py failure:

  Test bpftool bound info reporting (own ns)...
  FAIL: 3 BPF maps loaded, expected 2
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1177, in <module>
      check_dev_info(False, "")
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 645, in check_dev_info
      maps = bpftool_map_list(expected=2, ns=ns)
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 190, in bpftool_map_list
      fail(True, "%d BPF maps loaded, expected %d" %
    File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 86, in fail
      tb = "".join(traceback.extract_stack().format())

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_offload.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index edaffd43da83..0cf93d246804 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -769,7 +769,11 @@ skip(ret != 0, "bpftool not installed")
 base_progs = progs
 _, base_maps = bpftool("map")
 base_map_names = [
-    'pid_iter.rodata' # created on each bpftool invocation
+    # created on each bpftool invocation
+    'pid_iter.rodata',
+    'bind_map_detect',
+    'global_data',
+    'array_mmap',
 ]
 
 # Check netdevsim
-- 
2.34.1

