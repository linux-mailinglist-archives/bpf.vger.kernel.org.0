Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7004AA3D2
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 23:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358179AbiBDW7P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 17:59:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357887AbiBDW6k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 17:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644015519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuPkY8aF8foCy1xMQ7K88ilNkVFxYvJg6UfhArqX/OE=;
        b=ZSFqv3HuT3CEXPpk/G9XpF09bp6r/V0a5gMGQSRGxJUPZm3jG8nG5jFkkanxgaEi3MaNHF
        qAEyXtCJe+mEH6YhikgIywylmnAIDqOh0iktXTBxnuWuGRd8Nwa3LYNjv8LokFct5chw0h
        8CLKML641hGs08QigzmaeKH/WsBW8I8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-jMyBYFfdOzadgEec5HS7Bg-1; Fri, 04 Feb 2022 17:58:38 -0500
X-MC-Unique: jMyBYFfdOzadgEec5HS7Bg-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso3978913edt.20
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 14:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuPkY8aF8foCy1xMQ7K88ilNkVFxYvJg6UfhArqX/OE=;
        b=5PJCfuyOBTJLtiVG5PursXQelen2awnsY8mDc4VrXLlcZWWRXtfgdzGuXjciIi1cPw
         3rRNZNdRBWs51Q9ggDmjIo3dUGjYqr5KMpmuYE5mJU+HGM/d0lw7pnpn8zAy02WXvCYA
         qFnsW9SP8Ex/BSL2S7busk9PzGkE2ZTjYntnwAiqOQkH3xgId+pmHwzXrZGW98+jEbbK
         nU/RW6g5TfibBrUZ0u2Ysp5ZFu+J5c3INnluLWUM0+0W/4KZJI7rklDb6WMNjOtRzx89
         Q0X4WjhK/3/YNNhVMAvWH0me0+JYuMITR1iQsE28t+TwU4EDaeDyk+oadbLcmJM/ldzl
         ZNCA==
X-Gm-Message-State: AOAM531gK3UITPDsFXE3KPsvCY+SiuWdlEWpbzG+od8jZaISkf6dq0fv
        yeEgT1qjivZpHlbYsmu2qAIKYIJRRhMuFpwqIzd3J9DIzq5JI+jBroUs+BFtrV6HRsahKC1gbqQ
        +2jovYJIrV42B
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr989587ejc.334.1644015517719;
        Fri, 04 Feb 2022 14:58:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfMC0jfCBGSPIZgj8KIZhO3L2DqSwEXEGUdXnhN74v25kVKO9x+CidEyZ1jI72iCp5fKT4dw==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr989567ejc.334.1644015517562;
        Fri, 04 Feb 2022 14:58:37 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id d5sm1388884edz.78.2022.02.04.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:58:37 -0800 (PST)
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
Subject: [PATCH bpf-next 3/3] bpftool: Fix pretty print dump for maps without BTF loaded
Date:   Fri,  4 Feb 2022 23:58:23 +0100
Message-Id: <20220204225823.339548-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204225823.339548-1-jolsa@kernel.org>
References: <20220204225823.339548-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The commit e5043894b21f ("bpftool: Use libbpf_get_error() to check
error") forced map dump with pretty print enabled to has BTF loaded,
which is not necessarily needed.

Keeping the libbpf_get_error call, but setting errno to 0 because
get_map_kv_btf does nothing for this case.

This fixes test_offload.py for me, which failed because of the
pretty print fails with:

   Test map dump...
   Traceback (most recent call last):
     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1251, in <module>
       _, entries = bpftool("map dump id %d" % (m["id"]))
     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 169, in bpftool
       return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 155, in tool
       ret, stdout = cmd(ns + name + " " + params + args,
     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 109, in cmd
       return cmd_result(proc, include_stderr=include_stderr, fail=fail)
     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 131, in cmd_result
       raise Exception("Command failed: %s\n%s" % (proc.args, stderr))
   Exception: Command failed: bpftool -p map dump id 4325

Fixes: e5043894b21f ("bpftool: Use libbpf_get_error() to check error")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c66a3c979b7a..2ccf85042e75 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -862,6 +862,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	prev_key = NULL;
 
 	if (wtr) {
+		errno = 0;
 		btf = get_map_kv_btf(info);
 		err = libbpf_get_error(btf);
 		if (err) {
-- 
2.34.1

