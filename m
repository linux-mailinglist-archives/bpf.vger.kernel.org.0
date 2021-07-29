Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5573DA8D4
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhG2QU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhG2QUu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:20:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D4C061796
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b128so4082359wmb.4
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z05HCoFLItaKC/XfP7RbKcIL37D0WS7BgQCbfiZH5KI=;
        b=jxDgMroLj69sJyQunbHN90KUHo7cdp6vMQUQxOWZ+jYCfzJT6ntkMIVyueJFx+ll/Z
         Fhcv0NlQ4qgMet/tBhdWBMIVKgLVUcrwEDbXH7jZ6X0yWP8a6wMvbEiZgavgDc4BI9jq
         Sp+ftR+Ji7hd3ItCE15XF/kt5jCl2I3s5hO4BrePsK+i4bQGVtzmpJLB2mQH90Q0aokL
         EPb001vVZDemV/bQgEIvphtnNKnna1cXChiw8hcz5I2aY1QvNxDQSzyrKKFWjQYZDD59
         lKwCA0FH/+3ubxF6Bi97qw9csBI24IOg1faUaiCxfhUZ9seUOMxZjrWP6VY+c+5FAX2v
         PqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z05HCoFLItaKC/XfP7RbKcIL37D0WS7BgQCbfiZH5KI=;
        b=bgq9c3FGHh0eGNeRiyNt1h0JboQYz02NqCzoO+eFE7X9A/ykhGz9sW8ozSePVm4O9w
         aSynq2vn9yEL8YGZlJnwuKAZkngatlL0E+E9K9XcsL0aIIYc3VAy5zYdq/1AWrI2HOir
         2m/hKSsXgoehNNDW4mPjlD6aWX36SqugG5M8Rq6n7mWvrhh5QattoZ0KWYWxCESRjdsD
         FAWcraoRgXEjJMtFzgF4hBO7PWZdZ3agOAY/IUEOUvE+CzxhOAgNVludAD1Xy8VambPM
         /+cDmnvLm4indU08Mq3skDdQ151/Vqpog85snGQmn2zzRCljp3D3CjUGNEshSENRoMQg
         PDww==
X-Gm-Message-State: AOAM5319ca6nsI2XTmaR+k/F8L/US5JXjs/eJUuqrUfJxGvFT9BoLt6o
        NdDtIbj9ClzFjgokv03wKjZN8Q==
X-Google-Smtp-Source: ABdhPJykEHbtQpATL57HjR8Hg3TNVxlkhYAggER0KgGdEua9vw102i45WLOE42KlioSBTXeekAAK9w==
X-Received: by 2002:a05:600c:4fcf:: with SMTP id o15mr15389124wmq.116.1627575645838;
        Thu, 29 Jul 2021 09:20:45 -0700 (PDT)
Received: from localhost.localdomain ([149.86.66.250])
        by smtp.gmail.com with ESMTPSA id c10sm3854853wmb.40.2021.07.29.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:20:45 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v3 8/8] tools: bpftool: support dumping split BTF by id
Date:   Thu, 29 Jul 2021 17:20:28 +0100
Message-Id: <20210729162028.29512-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729162028.29512-1-quentin@isovalent.com>
References: <20210729162028.29512-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split BTF objects are typically BTF objects for kernel modules, which
are incrementally built on top of kernel BTF instead of redefining all
kernel symbols they need. We can use bpftool with its -B command-line
option to dump split BTF objects. It works well when the handle provided
for the BTF object to dump is a "path" to the BTF object, typically
under /sys/kernel/btf, because bpftool internally calls
btf__parse_split() which can take a "base_btf" pointer and resolve the
BTF reconstruction (although in that case, the "-B" option is
unnecessary because bpftool performs autodetection).

However, it did not work so far when passing the BTF object through its
id, because bpftool would call btf__get_from_id() which did not provide
a way to pass a "base_btf" pointer.

In other words, the following works:

    # bpftool btf dump file /sys/kernel/btf/i2c_smbus -B /sys/kernel/btf/vmlinux

But this was not possible:

    # bpftool btf dump id 6 -B /sys/kernel/btf/vmlinux

The libbpf API has recently changed, and btf__get_from_id() has been
deprecated in favour of btf__load_from_kernel_by_id() and its version
with support for split BTF, btf__load_from_kernel_by_id_split(). Let's
update bpftool to make it able to dump the BTF object in the second case
as well.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 9162a18e84c0..0ce3643278d4 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -580,7 +580,7 @@ static int do_dump(int argc, char **argv)
 	}
 
 	if (!btf) {
-		btf = btf__load_from_kernel_by_id(btf_id);
+		btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
 		err = libbpf_get_error(btf);
 		if (err) {
 			p_err("get btf by id (%u): %s", btf_id, strerror(err));
-- 
2.30.2

