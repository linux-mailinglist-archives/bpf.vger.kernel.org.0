Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC64FA918
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiDIOwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiDIOwV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 10:52:21 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C113D77
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 07:50:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 75so4264849qkk.8
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21OhV51xQSWATEM0YJwYM2dHg8DCPy4Z9WXs+/3SkHQ=;
        b=KRQBvWZuXq/m0ClH+SVgKv1a70+IcN/OnPZAeKk8/CeQQGqH0q4g7jmew59MdkOenz
         Pl+nJdoBQ126Jw0NoHxn3lAdjU5fnyZl5e/qb50scFk9xoNGfyd461dkOSmLJ8uzbOUM
         pg5EtS0EqBLYOfkGX6Do18BP/Byb7v3w3drPATuC5hXaa2CL25YThmS5Q2Zs2+r+Uc/X
         IC419PeC7lVkcJsTNqhW5pcS3VK2zAJKqOp1mPxjgKnd56WCrjOll3GJ1h5cK3db2yGO
         9/U1Aww1pg9CZ/FKa1BuxC93tcW52FMpMoIbe6ujnjq5QLdhn3jBDXZUsj2Dct2R0Hoh
         XhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21OhV51xQSWATEM0YJwYM2dHg8DCPy4Z9WXs+/3SkHQ=;
        b=SGYlRO6qztNBD2JULghvweg0TJIzAk29X4iewmh3022CW2NI3bAKe1JJFfERUcbZ0T
         yo0a5wbJWJ5RPLz3RJr+6qsFCjf+U6EPsDu9ZDqFNRbxKYXQ3VBn2twL/6qH9ujseiES
         aIEE87IDXmyQzeJgsppEYNByHAKuwByo6McTTsL1SdKzL/A89HnklTYVHQ+DlVbPWgxH
         E5gwHDI6LMABNHzWJjnP8UR76EXsRaAbWIDkyEsG1Zp8nC+XV4zyGpndbceSB5obvAuS
         bh9g/lFZ+KFYV3XJYVPqbgMW6izSYH4qEcto/rUOJHsUWFznYurne7F28A7H4Pc8LXVH
         2oyw==
X-Gm-Message-State: AOAM5313ZUwAYIrbJpoukXIXmYEP4BjP+yamcAZR4bF45ybSjvKjzjzT
        mS0wzSeAKVO42bXsTqwgS9AC4nPB2ulSl0u5
X-Google-Smtp-Source: ABdhPJxT254f5tKjREwlNubAAzyB0WnmXe3NsW0UPPVjfylZCbDacWjnVKwuLWwhvqXVdrW9jcww9A==
X-Received: by 2002:a05:620a:2544:b0:680:a53b:ec1a with SMTP id s4-20020a05620a254400b00680a53bec1amr16682401qko.544.1649515813522;
        Sat, 09 Apr 2022 07:50:13 -0700 (PDT)
Received: from localhost.localdomain ([115.220.136.126])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a16d700b0067e98304705sm14843516qkn.89.2022.04.09.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:50:13 -0700 (PDT)
From:   Runqing Yang <rainkin1993@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Runqing Yang <rainkin1993@gmail.com>
Subject: [bpf-next] libbpf: Fix a bug that checking bpf_probe_read_kernel API fails in old kernels
Date:   Sat,  9 Apr 2022 22:49:28 +0800
Message-Id: <20220409144928.27499-1-rainkin1993@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Background:
Libbpf automatically replaces calls to BPF bpf_probe_read_{kernel,user}
[_str]() helpers with bpf_probe_read[_str](), if libbpf detects that
kernel doesn't support new APIs. Specifically, libbpf invokes the
probe_kern_probe_read_kernel function to load a small eBPF program into
the kernel in which bpf_probe_read_kernel API is invoked and lets the
kernel checks whether the new API is valid. If the loading fails, libbpf
considers the new API invalid and replaces it with the old API.

static int probe_kern_probe_read_kernel(void)
{
	struct bpf_insn insns[] = {
		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 = r10 (fp) */
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 = 8 */
		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 = 0 */
		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
		BPF_EXIT_INSN(),
	};
	int fd, insn_cnt = ARRAY_SIZE(insns);

	fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL,
                           "GPL", insns, insn_cnt, NULL);
	return probe_fd(fd);
}

Bug:
On older kernel versions [0], the kernel checks whether the version
number provided in the bpf syscall, matches the LINUX_VERSION_CODE.
If not matched, the bpf syscall fails. eBPF However, the
probe_kern_probe_read_kernel code does not set the kernel version
number provided to the bpf syscall, which causes the loading process
alwasys fails for old versions. It means that libbpf will replace the
new API with the old one even the kernel supports the new one.

Solution:
After a discussion in [1], the solution is using BPF_PROG_TYPE_TRACEPOINT
program type instead of BPF_PROG_TYPE_KPROBE because kernel does not
enfoce version check for tracepoint programs. I test the patch in old
kernels (4.18 and 4.19) and it works well.

[0] https://elixir.bootlin.com/linux/v4.19/source/
            kernel/bpf/syscall.c#L1360
[1] https://github.com/libbpf/libbpf/issues/473

Signed-off-by: Runqing Yang <rainkin1993@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 465b7c0996f1..bf4f7ac54ebf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4594,7 +4594,7 @@ static int probe_kern_probe_read_kernel(void)
 	};
 	int fd, insn_cnt = ARRAY_SIZE(insns);
 
-	fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
+	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
 	return probe_fd(fd);
 }
 
-- 
2.35.1

