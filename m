Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4E6ED205
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjDXQGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjDXQGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18516A69
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE3261BD1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1791EC433D2;
        Mon, 24 Apr 2023 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352402;
        bh=V2v5G7vW0QNg1w/Ta3CnwwlfLUBck1eIJQKeJAWZ254=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr6nyjTKelj/UgnIeBPNugZ8HSbWT8+mFsLoI7l+VRxOvA2TI0cfkD3uBgk5q1Lis
         HzmqQlsZJ0b/1PWmIzMZoUnTF92+5Nza4md/4O9iBDE92lsmr+X5182QGX839LZRKb
         1XaM/Q17PIi5rxwcBOo9QgGcQ+/8O7Xe0BjRs+ZBoN9jnIevhyphmW6T2sO4ISBMZE
         bZ14SmktfBHakgl5+3oHNLnaouxULMfQuYj3a+ecNGElzSRqdsWE93770y9SDqZlBw
         6BVwmX+1cA+Siyyp3dKbvVqoUngzsiM/LCxOc3aI2EJ5PTHjTPyNjmevZ8Vd/0uvqj
         RWBtpC72wUSgA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 11/20] libbpf: Add support for uprobe.multi/uprobe.multi program sections
Date:   Mon, 24 Apr 2023 18:04:38 +0200
Message-Id: <20230424160447.2005755-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support for uprobe.multi/uprobe.multi program sections
to allow auto attach of multi_uprobe programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c786bc142791..70353aaac86e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8628,6 +8628,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
@@ -8643,6 +8644,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("uprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
+	SEC_DEF("uretprobe.multi+",	KPROBE,	BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
 	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -10611,6 +10614,41 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	return libbpf_get_error(*link);
 }
 
+static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
+	int n, ret = -EINVAL;
+
+	*link = NULL;
+
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.*?]+",
+		   &probe_type, &binary_path, &func_name);
+	switch (n) {
+	case 1:
+		/* handle SEC("u[ret]probe") - format is valid, but auto-attach is impossible. */
+		ret = 0;
+		break;
+	case 2:
+		pr_warn("prog '%s': section '%s' missing ':function[+offset]' specification\n",
+			prog->name, prog->sec_name);
+		break;
+	case 3:
+		opts.retprobe = strcmp(probe_type, "uretprobe.multi");
+		*link = bpf_program__attach_uprobe_multi_opts(prog, binary_path, func_name, &opts);
+		ret = libbpf_get_error(*link);
+		break;
+	default:
+		pr_warn("prog '%s': invalid format of section definition '%s'\n", prog->name,
+			prog->sec_name);
+		break;
+	}
+	free(probe_type);
+	free(binary_path);
+	free(func_name);
+	return ret;
+}
+
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *binary_path, uint64_t offset)
 {
-- 
2.40.0

