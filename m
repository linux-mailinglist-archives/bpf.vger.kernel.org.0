Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA262161C8
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGFXBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGFXBe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 19:01:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED4C061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 16:01:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i203so14954081yba.9
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KeQTrd37BEFhJhhFg8eLib2y6OHrwfUDJnin6VhVDDE=;
        b=OI5BBKCHe9yMHhm+QwNaQGayQifvpsnSAOlIPrU/WOn4p8C3G+ue3VpzJrcBgquQ6H
         z21Vy6oBM1OPbuLOHqJa3EABRW/fb8dCSayZaq9yr79z4HpwbNX30tgVU+0UXOCwDhtA
         SY8o0njtzdHCI2S9JDo00pSk/oGLqVldDHI3z1icx+avTwoIR6v+mi3j8fUXzzjz4OAp
         zGtcrTa20WdxJ9N4ywv8UDLmeQLAhWU8UE3qCJ7Xgw81gy4epedR358A3igb8cTpTIVs
         7HhhvLve4jLXvtu6BYUWoPKW/EWQp7BkIgJ2809JClMgYaCtpeqPzNEbfoh4D7gsX8QY
         fHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KeQTrd37BEFhJhhFg8eLib2y6OHrwfUDJnin6VhVDDE=;
        b=Tf1kauLeSIsHuQDpLbdHUv7bzNbPQ8/CRLFtLcEpVAoNG4k/0np4u1WIuq/OOzUhC3
         Sl1YGmOZR/SM4CxTusBH23Z5UG5vpGR5o4ZI6pTukWBIxlsYfmB2QZSyoSom42OyxGdp
         DUIIJ4wrxIfMFMCZmz853kgFvdq1N4v0L6zJJlZtxI/f1UWClJwpgKLBtnxHWe/kDhwR
         RhzVqihn8d8B4eb1XQYWPdsDiW8GsMRGb50+rnxoOF13GPEwv4zEmFQ/KjzhAY/lnRMP
         0jUvKYK/ZATRSSnhfB9PHgzgq8shU8eDKvD6C62CI5yaErSP5uUvGME/Ujoeo7eiqT19
         zeDg==
X-Gm-Message-State: AOAM531Zcm1pT/LZDgv6z8SKu9CzZSDMRoSCiCMBk56ZU3O3gBgli2SR
        ZbVNjpA4MIDYNS61H+c36xwsNPQ=
X-Google-Smtp-Source: ABdhPJxS/FVlLfQoHDKrYZ5hQ33tvftY8xxsUUaGDRo3PeqNb1/bKLYYJK/E5BT9en5R0qX/DjiB83c=
X-Received: by 2002:a25:5d2:: with SMTP id 201mr60561397ybf.280.1594076493984;
 Mon, 06 Jul 2020 16:01:33 -0700 (PDT)
Date:   Mon,  6 Jul 2020 16:01:26 -0700
In-Reply-To: <20200706230128.4073544-1-sdf@google.com>
Message-Id: <20200706230128.4073544-3-sdf@google.com>
Mime-Version: 1.0
References: <20200706230128.4073544-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v4 2/4] libbpf: add support for BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add auto-detection for the cgroup/sock_release programs.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/libbpf.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index da9bf35a26f8..548a749aebb3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -226,6 +226,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_INET4_GETSOCKNAME,
 	BPF_CGROUP_INET6_GETSOCKNAME,
 	BPF_XDP_DEVMAP,
+	BPF_CGROUP_INET_SOCK_RELEASE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ea7f4f1a691..88a483627a2b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6917,6 +6917,10 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_EGRESS),
 	BPF_APROG_COMPAT("cgroup/skb",		BPF_PROG_TYPE_CGROUP_SKB),
+	BPF_EAPROG_SEC("cgroup/sock_create",	BPF_PROG_TYPE_CGROUP_SOCK,
+						BPF_CGROUP_INET_SOCK_CREATE),
+	BPF_EAPROG_SEC("cgroup/sock_release",	BPF_PROG_TYPE_CGROUP_SOCK,
+						BPF_CGROUP_INET_SOCK_RELEASE),
 	BPF_APROG_SEC("cgroup/sock",		BPF_PROG_TYPE_CGROUP_SOCK,
 						BPF_CGROUP_INET_SOCK_CREATE),
 	BPF_EAPROG_SEC("cgroup/post_bind4",	BPF_PROG_TYPE_CGROUP_SOCK,
-- 
2.27.0.212.ge8ba1cc988-goog

