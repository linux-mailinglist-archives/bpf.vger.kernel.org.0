Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09BB60CFE4
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJYPDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiJYPDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 11:03:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CCD1B866F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v1so21564655wrt.11
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbFKA7BbKkVTCiDA2jNGQBqtk+RU53oHgNWLeKHi3B8=;
        b=pn+1Yd8jAgWYNgBymUdEjCV9xRIxSsgnQtoAwk0n6MYHSAVQrJoHVOm0g65Qg+RQNh
         tWOoylsyCrMrIfVoDTbGNxHHCB8oZzrcUtlfeLCrJTBAoDn9tvF8w6lViAWjzqVFz1qE
         YeVvUVRMSyTpJbIWEEjMbZmxIqlXCTNF6X9+lKqJsKjG2xUaVE4We52SSzPvAd0Q+G2N
         Wm16Rq777twjeOyteuODFr6x8tiN8hKYyAnyxqrOZ2Vvwk7ndxF4irZlWhmLqd0hifhq
         yE6LQh7iikECynRGmx189SR5s0GvtSoYGkgmjFWF/BVQ7apbQBWM4YRrvCfd82Mq56K5
         mUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbFKA7BbKkVTCiDA2jNGQBqtk+RU53oHgNWLeKHi3B8=;
        b=gEUy7A2Cai+PISQhIS8ivWxvYoEhmPHbuK/d61fpUo22oF0rvQf9piqzqLQ4KtAn7W
         N4Aqs4OI//lscAVHezXVpIEuRYq5UBUInh8SYImq03BEtfFJTtl/G5dYSj3aZUZnJ6GB
         oxIK1YHz/dn+nytBjIoQPHxckxJKe2dtBWkV1+6IaeHb2DXYghwVm724qr6X6OGHcU3W
         ppN59etI8gIe9lm8O0MKY0nsIH5ao2YfPEPub98nZUqK5R3fJu9b9QrjvBhxNG5wHEHH
         ZiPSxBBdaNt3doG6+vGLHMl4pkE8xHj+x5w8jERm2cNh+ZIhSkHNwj2Ss2n4wJpi2Gis
         GI/A==
X-Gm-Message-State: ACrzQf0w0lYu/VNywhI0K58CoAP5Dg+ZHu2rykRKZIYyCCwa5BYhIi3d
        8b1mSNxXXlOavZJ2TyQWR+8KXA==
X-Google-Smtp-Source: AMsMyM4Az2sY8hpM0Qh8Ju8Gl3lFFjDmJBm2YWRnffWeCd4nudwcGt+QR7v4R/VE0wJtpxW1hselGQ==
X-Received: by 2002:adf:f84c:0:b0:236:6e52:504 with SMTP id d12-20020adff84c000000b002366e520504mr8374851wrq.564.1666710225692;
        Tue, 25 Oct 2022 08:03:45 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i7-20020adff307000000b0023659925b2asm2724182wro.51.2022.10.25.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:03:45 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v4 7/8] bpftool: Support setting alternative arch for JIT disasm with LLVM
Date:   Tue, 25 Oct 2022 16:03:28 +0100
Message-Id: <20221025150329.97371-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025150329.97371-1-quentin@isovalent.com>
References: <20221025150329.97371-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For offloaded BPF programs, instead of failing to create the
LLVM disassembler without even looking for a triple at all, do run the
function that attempts to retrieve a valid architecture name for the
device.

It will still fail for the LLVM disassembler, because currently we have
no valid triple to return (NFP disassembly is not supported by LLVM).
But failing in that function is more logical than to assume in
jit_disasm.c that passing an "arch" name is simply not supported.

Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/common.c     | 10 ++++++----
 tools/bpf/bpftool/jit_disasm.c | 15 +++++++--------
 tools/bpf/bpftool/main.h       |  3 +--
 tools/bpf/bpftool/prog.c       |  6 ++----
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 4c2e909a2d67..e4d33bc8bbbf 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -627,12 +627,11 @@ static int read_sysfs_netdev_hex_int(char *devname, const char *entry_name)
 }
 
 const char *
-ifindex_to_bfd_params(__u32 ifindex, __u64 ns_dev, __u64 ns_ino,
-		      const char **opt)
+ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt)
 {
+	__maybe_unused int device_id;
 	char devname[IF_NAMESIZE];
 	int vendor_id;
-	int device_id;
 
 	if (!ifindex_to_name_ns(ifindex, ns_dev, ns_ino, devname)) {
 		p_err("Can't get net device name for ifindex %d: %s", ifindex,
@@ -647,6 +646,7 @@ ifindex_to_bfd_params(__u32 ifindex, __u64 ns_dev, __u64 ns_ino,
 	}
 
 	switch (vendor_id) {
+#ifdef HAVE_LIBBFD_SUPPORT
 	case 0x19ee:
 		device_id = read_sysfs_netdev_hex_int(devname, "device");
 		if (device_id != 0x4000 &&
@@ -655,8 +655,10 @@ ifindex_to_bfd_params(__u32 ifindex, __u64 ns_dev, __u64 ns_ino,
 			p_info("Unknown NFP device ID, assuming it is NFP-6xxx arch");
 		*opt = "ctx4";
 		return "NFP-6xxx";
+#endif /* HAVE_LIBBFD_SUPPORT */
+	/* No NFP support in LLVM, we have no valid triple to return. */
 	default:
-		p_err("Can't get bfd arch name for device vendor id 0x%04x",
+		p_err("Can't get arch name for device vendor id 0x%04x",
 		      vendor_id);
 		return NULL;
 	}
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index c28b21f90cb9..58a5017034a2 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -84,12 +84,10 @@ init_context(disasm_ctx_t *ctx, const char *arch,
 {
 	char *triple;
 
-	if (arch) {
-		p_err("Architecture %s not supported", arch);
-		return -1;
-	}
-
-	triple = LLVMGetDefaultTargetTriple();
+	if (arch)
+		triple = LLVMNormalizeTargetTriple(arch);
+	else
+		triple = LLVMGetDefaultTargetTriple();
 	if (!triple) {
 		p_err("Failed to retrieve triple");
 		return -1;
@@ -128,8 +126,9 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
 
 int disasm_init(void)
 {
-	LLVMInitializeNativeTarget();
-	LLVMInitializeNativeDisassembler();
+	LLVMInitializeAllTargetInfos();
+	LLVMInitializeAllTargetMCs();
+	LLVMInitializeAllDisassemblers();
 	return 0;
 }
 #endif /* HAVE_LLVM_SUPPORT */
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9a149c67aa5d..467d8472df0c 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -203,8 +203,7 @@ void print_hex_data_json(uint8_t *data, size_t len);
 unsigned int get_page_size(void);
 unsigned int get_possible_cpus(void);
 const char *
-ifindex_to_bfd_params(__u32 ifindex, __u64 ns_dev, __u64 ns_ino,
-		      const char **opt);
+ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt);
 
 struct btf_dumper {
 	const struct btf *btf;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 93dfb89b85e3..a858b907da16 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -764,10 +764,8 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		const char *name = NULL;
 
 		if (info->ifindex) {
-			name = ifindex_to_bfd_params(info->ifindex,
-						     info->netns_dev,
-						     info->netns_ino,
-						     &disasm_opt);
+			name = ifindex_to_arch(info->ifindex, info->netns_dev,
+					       info->netns_ino, &disasm_opt);
 			if (!name)
 				goto exit_free;
 		}
-- 
2.34.1

