Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6583D12A2
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhGUO5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbhGUO5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 10:57:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE4C06179C
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:38:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t5so2652223wrw.12
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0jhVjo6WTcaDV4uEQGKhqx9NDnOHVKLazidVPgUD5U=;
        b=lSuS1WXcz2AdA2zaTZWlRHJ5HnWusy+jwTK+/QkRMuwv9GjQXfYbSoO9epZ3LR9fr0
         CbILGec66D7YzGZmtWcmj3/rRdVoGUQbs0Z4FVWmtg3vdXdk0j14wisV+3C/v3W7heXk
         N/n0V7DhESPO9jFxky0Ci7VOBJSPzkyhyE36jZdJCPk3HgInfrruyWmtkT9jrIs3vygd
         EatJLcYHAbhRn/vMtKuyeEuwtmJAjsYNuNRn/Gu62YXzYZvEGMTIfpqSk92ovfA+wDk+
         4LLoYxsGAtcWyx40iClsper2RD34eLzwd8pxt+VhvzMXnu5MmS17CKpLMUND2TauRaVe
         JLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0jhVjo6WTcaDV4uEQGKhqx9NDnOHVKLazidVPgUD5U=;
        b=GMMYOWwu9rt5G4PDG2GACcl5LGt8+HYiA1z2Q4jHBQ8Ohv8kGHiVEs/0VDSqqp7SB7
         CvF3OMXDHpuUhCYV6POj6u2WcNH4iq4FsE9vvkND9v4+dxM9Uc1bE7aKCSCvHwjC3cha
         w+L05OCfCSFBrLy6r/ZuezMZxdzCIyqA0WuCFVRDVOWGy1YrFAJk/uBOR4MIeHLl17TO
         fxD53XG0+1Cp8WNUNNblEJe4Y1hljuf9iePnSD8kjSCqiNSgI4n8N8e2sd4R2Omubgq1
         kV2zwC3aM7oNdNEcA0CBOgoK1cxha2uOPI80/AB8s/W7aRcgpFsULDDddwgYDv8eJy8G
         PugA==
X-Gm-Message-State: AOAM533iJkJllWl/5bhBCR557kb3GB5fyLVhVjMoNcrV9+fIBZpGMP3V
        CbyWgYgSsPbgzZmOd7rQbH7DSg==
X-Google-Smtp-Source: ABdhPJwIS51VUZdciAOQH8LyHNFdK73sq/xqLzzQGxUQBINXPmfMTJd/PiBPi8+dtDsWQzPjUf/weQ==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr42541805wrx.267.1626881897058;
        Wed, 21 Jul 2021 08:38:17 -0700 (PDT)
Received: from localhost.localdomain ([149.86.71.195])
        by smtp.gmail.com with ESMTPSA id n18sm26209714wrt.89.2021.07.21.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:38:16 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2 5/5] tools: bpftool: support dumping split BTF by id
Date:   Wed, 21 Jul 2021 16:38:08 +0100
Message-Id: <20210721153808.6902-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721153808.6902-1-quentin@isovalent.com>
References: <20210721153808.6902-1-quentin@isovalent.com>
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
replaced with btf__load_from_kernel_by_id() and its version with support
for split BTF, btf__load_from_kernel_by_id_split(). Let's update bpftool
to make it able to dump the BTF object in the second case as well.

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

