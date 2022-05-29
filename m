Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04DB5372C0
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiE2WG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiE2WG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:06:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9C79811;
        Sun, 29 May 2022 15:06:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FC095C00D6;
        Sun, 29 May 2022 18:06:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 29 May 2022 18:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1653861985; x=1653948385; bh=UC
        lJxbC3dYsTnlB9EQCDEeVJjlgkJVQ4fF8v6lEjbLQ=; b=osrKy06y7Y33av7im0
        vHoSIXyW69mOFQcoxrw8r8uwkYyhWoJy0HmOAkGlbxvxS4PK4aJ5nBhmQCv/wT/o
        wVkODVeDiNcuOLJh8rwdsW5MxSztCqC4yC+8v8Y9Vqg95POb2oQI2SfzuByDoULa
        vNN+o8xuVg//AwKhIumg+hVETlhRvCjj1sbgcM880ptB7iM+5+ZAUJkr4b3h3bfC
        5mPHak6hT+XXFGJ2fn/dZymwSOfUUr6JLrFh//OGJmzryuMZLbukavmAS1rBspzY
        I0AWPS8gG2hgk9Wj2O3LDagm0MuF6wxRHNUqM0k3P/Jx3TsF7bxurYBsmr75l7tA
        Svrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653861985; x=1653948385; bh=UClJxbC3dYsTn
        lB9EQCDEeVJjlgkJVQ4fF8v6lEjbLQ=; b=mohLzHOMvBAsdEZAAGCqcamBtQos0
        uzxUbCe1+/xVUUlRk9VD6XnC/yoIl/d+LEHN9PWktSe6B9OB0V34aeYzoXoNcBo6
        1qsqbO6RshVJAuTN8f23WA8P3QOL41rtpw8Iy0/Kuu0Bz/HXK1n6LZ80dtYqKaHr
        LdYRgsZgUyc85rOSxHukaTD+TxrhnWYzhomyFN8QKsWy9SRu8zben+iRGjtStz/Y
        JStlbmYweSPz0+tb6acg4zEUgU/L0bfCRze6PtEc5ntuhMiJJoQuS1C9AC0iNjbF
        slR/dXJvVARiS9xj44QCmOdpO1pEc2hOFSafCaMzyWX8cNJS6J0QWjYMw==
X-ME-Sender: <xms:YO6TYkjza6Dv0NSVziGzdZOUvZkt4IKvc7Etkm9RIc11CV8vGKw3VA>
    <xme:YO6TYtBh30iZRCRlT370vSejHOS2lCC2mO7GeYuLv56IbsO_k7CawQIjoG2GFmN7P
    Zr13TbB2CeibeEgnQ>
X-ME-Received: <xmr:YO6TYsHdHTxYWqp_dBXZV21TAQF8NelmoB3YMj2XyeEPUKeO9L1xhPRIEd6-Qetx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:YO6TYlQ9wn4C8fkJDHx9wYkMv8FKqYAnFzV4ky9SACU1ZVL1FyAscQ>
    <xmx:YO6TYhxZgRkOPCO8qgjYZskY6hz3GeRyNfwahxxgH_iYDh4M2ju_Pw>
    <xmx:YO6TYj612ADWrICqkwmO1Srm1-DjLuQs9qGLkNzR1on8duG-VtlC5Q>
    <xmx:Ye6TYjuxHlhY9W_unU8t6xHUVje5DZWP6s_KbFm-_s3uzgIuIhL2fg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 May 2022 18:06:24 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to kprobe
Date:   Sun, 29 May 2022 17:06:05 -0500
Message-Id: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653861287.git.dxu@dxuuu.xyz>
References: <cover.1653861287.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs. On
top of being generally useful for unit testing kprobe progs, this commit
more specifically helps solve a relability problem with bpftrace BEGIN
and END probes.

BEGIN and END probes are run exactly once at the beginning and end of a
bpftrace tracing session, respectively. bpftrace currently implements
the probes by creating two dummy functions and attaching the BEGIN and
END progs, if defined, to those functions and calling the dummy
functions as appropriate. This works pretty well most of the time except
for when distros strip symbols from bpftrace. Every now and then this
happens and users get confused. Having PROG_TEST_RUN support will help
solve this issue by allowing us to directly trigger uprobes from
userspace.

Admittedly, this is a pretty specific problem and could probably be
solved other ways. However, PROG_TEST_RUN also makes unit testing more
convenient, especially as users start building more complex tracing
applications. So I see this as killing two birds with one stone.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h      | 10 ++++++++++
 kernel/trace/bpf_trace.c |  1 +
 net/bpf/test_run.c       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b914a56a2c5..dec3082ee158 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1751,6 +1751,9 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
 				const union bpf_attr *kattr,
 				union bpf_attr __user *uattr);
+int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
+			     const union bpf_attr *kattr,
+			     union bpf_attr __user *uattr);
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info);
@@ -1998,6 +2001,13 @@ static inline int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
 	return -ENOTSUPP;
 }
 
+static inline int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
+					   const union bpf_attr *kattr,
+					   union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
 static inline void bpf_map_put(struct bpf_map *map)
 {
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 10b157a6d73e..b452e84b9ba4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1363,6 +1363,7 @@ const struct bpf_verifier_ops kprobe_verifier_ops = {
 };
 
 const struct bpf_prog_ops kprobe_prog_ops = {
+	.test_run = bpf_prog_test_run_kprobe,
 };
 
 BPF_CALL_5(bpf_perf_event_output_tp, void *, tp_buff, struct bpf_map *, map,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56f059b3c242..0b6fc17ce901 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1622,6 +1622,42 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 	return err;
 }
 
+int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
+			     const union bpf_attr *kattr,
+			     union bpf_attr __user *uattr)
+{
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	u32 repeat = kattr->test.repeat;
+	struct pt_regs *ctx = NULL;
+	u32 retval, duration;
+	int err = 0;
+
+	if (kattr->test.data_in || kattr->test.data_out ||
+	    kattr->test.ctx_out || kattr->test.flags ||
+	    kattr->test.cpu || kattr->test.batch_size)
+		return -EINVAL;
+
+	if (ctx_size_in != sizeof(struct pt_regs))
+		return -EINVAL;
+
+	ctx = memdup_user(ctx_in, ctx_size_in);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	err = bpf_test_run(prog, ctx, repeat, &retval, &duration, false);
+	if (err)
+		goto out;
+
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)) ||
+	    copy_to_user(&uattr->test.duration, &duration, sizeof(duration))) {
+		err = -EFAULT;
+	}
+out:
+	kfree(ctx);
+	return err;
+}
+
 static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
 	.owner        = THIS_MODULE,
 	.check_set        = &test_sk_check_kfunc_ids,
-- 
2.36.1

