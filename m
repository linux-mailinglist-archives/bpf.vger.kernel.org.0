Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26B2484750
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiADR7d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiADR7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:59:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39804C061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:59:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v7so77674425wrv.12
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iohrnjdYSUSXtR57MMhODAaUER+JKP7h9997XjjNmGY=;
        b=64VlPR+jtpRIFKGCAOzDE9++M0YFE5EXjiu19jAGJu/w1NF4IFDgsThf8552nkK1jQ
         QA8DysS2oGPslKjNg2bfTKvxHBWdOC1C/T54c4UQRwjPHRKmBK/9aWaLHoLNKKVExAOi
         9ynVcqhIlunwWSeVxxq1OOufAJ0dlDIPCfvc1RtLHmMPyDkXfBhmowXm/+TH79x6CFZL
         FcAlnGhS+lrCqd0sFZIKnPvQ4ywZnGr6e2TuKSi55NogZ7VzaIhq7ky21QQR1sz8vFb+
         uPu80GbN2Ri7dENBxYqfzMor1cCK827rMBAFqPfVC1Jhu40XqwR9AQfZugYCFDZNzK8W
         IdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iohrnjdYSUSXtR57MMhODAaUER+JKP7h9997XjjNmGY=;
        b=TO7qyojUYyPsaZkWpjZlTpm+4pBeq2+C/Ogf2HuSlp+12ITtTHQ4mPIqbH7VRjdoQ4
         ZDHPbfhFhk6LiXCMxGgUo0o7XSYb2tNZxHitQt2f925T0ntMZswujBTM9+xBjrqhWEvW
         RcK9/ximdiSrvsYMj3w7zcevRp0mw2V4Ec09g4pa21HP2K7vq+YXuNql5U8zB1R+qVqJ
         Y2yNhSEUyLyeSIxPJS+kqF3+DTZ1TPCxY5i6YveANNTd8d7K0Ig6BWG38MK28e7qjUM3
         6oGYdzuBjODPj/NpHth+6czYfHGvan5QTOc+K+eLqlXRgVHGiw2962zK0x07Cw94Hjko
         Zvjg==
X-Gm-Message-State: AOAM533HCM/+dj3vXBcFHoSVs/CMJYi4EcY2OLs10XKvCsw0uqFZsusX
        eEKzweJLiO/atMOr1UE9+9Ev
X-Google-Smtp-Source: ABdhPJwKW/iM+4dVy3YY5vu7hQrKDBkJ/HScnSFAsJuVldHLnpB2T+8qKlk+9lkSpx/3Z/H0vFb+cQ==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr43971659wrc.637.1641319170893;
        Tue, 04 Jan 2022 09:59:30 -0800 (PST)
Received: from Mem (2a01cb088160fc006dcbec8694cd1f89.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6dcb:ec86:94cd:1f89])
        by smtp.gmail.com with ESMTPSA id o5sm53738wmc.39.2022.01.04.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:59:30 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:59:29 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/3] bpftool: Refactor misc. feature probe
Message-ID: <956c9329a932c75941194f91790d01f31dfbe01b.1641314075.git.paul@isovalent.com>
References: <cover.1641314075.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641314075.git.paul@isovalent.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is currently a single miscellaneous feature probe,
HAVE_LARGE_INSN_LIMIT, to check for the 1M instructions limit in the
verifier. Subsequent patches will add additional miscellaneous probes,
which follow the same pattern at the existing probe. This patch
therefore refactors the probe to avoid code duplication in subsequent
patches.

The BPF program type and the checked error numbers in the
HAVE_LARGE_INSN_LIMIT probe are changed to better generalize to other
probes. The feature probe retains its current behavior despite those
changes.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 45 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 6719b9282eca..3da97a02f455 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -642,6 +642,30 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 		printf("\n");
 }
 
+static void
+probe_misc_feature(struct bpf_insn *insns, size_t len,
+		   const char *define_prefix, __u32 ifindex,
+		   const char *feat_name, const char *plain_name,
+		   const char *define_name)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.prog_ifindex = ifindex,
+	);
+	bool res;
+	int fd;
+
+	errno = 0;
+	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+			   insns, len, &opts);
+	res = fd >= 0 || !errno;
+
+	if (fd >= 0)
+		close(fd);
+
+	print_bool_feature(feat_name, plain_name, define_name, res,
+			   define_prefix);
+}
+
 /*
  * Probe for availability of kernel commit (5.3):
  *
@@ -649,29 +673,18 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
  */
 static void probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
 {
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.prog_ifindex = ifindex,
-	);
 	struct bpf_insn insns[BPF_MAXINSNS + 1];
-	bool res;
-	int i, fd;
+	int i;
 
 	for (i = 0; i < BPF_MAXINSNS; i++)
 		insns[i] = BPF_MOV64_IMM(BPF_REG_0, 1);
 	insns[BPF_MAXINSNS] = BPF_EXIT_INSN();
 
-	errno = 0;
-	fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL",
-			   insns, ARRAY_SIZE(insns), &opts);
-	res = fd >= 0 || (errno != E2BIG && errno != EINVAL);
-
-	if (fd >= 0)
-		close(fd);
-
-	print_bool_feature("have_large_insn_limit",
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_large_insn_limit",
 			   "Large program size limit",
-			   "LARGE_INSN_LIMIT",
-			   res, define_prefix);
+			   "LARGE_INSN_LIMIT");
 }
 
 static void
-- 
2.25.1

