Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7264E374
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLOVpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 16:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOVpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 16:45:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D435C76F
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 079F7CE1D57
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 21:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251DC433EF;
        Thu, 15 Dec 2022 21:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140699;
        bh=bmSpbFUzBfCJTJ+XALCMTiNU3j80LfNB9mVXE7hJfDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkItxWhN6k6ZCZ713wWX1OjxD0V28UFzMosKrgE4vJ/nloVdArBE/GphpiuIiaSiQ
         jLBBk819u9M5f/DSYkH7728wajfPtXm4xw6okGez8dDbJ4HGid5olsm/4NZg0stR79
         M2FL1czsmOSNQlYB0IeCZbSaNsl3Nz0cYU/X74P5pJETlkGATytXTeEWI+Ui0Q4mVa
         HYk4r7gQsWXqahwEqoOvnZ+NKTti192I70f6p47wE8j9qk0XX77U7jLaDh//vr2DvM
         rkT55TdHB8BSNzoO1SjI6vZ7ehlJgcDpfmPDoUwdg9vYqaXxiDd+b7CKE9yZaVQ71k
         k2Hb2TywKN1xw==
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
        Florent Revest <revest@chromium.org>
Subject: [PATCHv3 bpf-next 2/3] bpf: Do cleanup in bpf_bprintf_cleanup only when needed
Date:   Thu, 15 Dec 2022 22:44:29 +0100
Message-Id: <20221215214430.1336195-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215214430.1336195-1-jolsa@kernel.org>
References: <20221215214430.1336195-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we always cleanup/decrement bpf_bprintf_nest_level
variable in bpf_bprintf_cleanup if it's > 0.

There's possible scenario where this could cause a problem,
when bpf_bprintf_prepare does not get bin_args buffer (because
num_args is 0) and following bpf_bprintf_cleanup call decrements
bpf_bprintf_nest_level variable, like:

  in task context:
    bpf_bprintf_prepare(num_args != 0) increments 'bpf_bprintf_nest_level = 1'
    -> first irq :
       bpf_bprintf_prepare(num_args == 0)
       bpf_bprintf_cleanup decrements 'bpf_bprintf_nest_level = 0'
    -> second irq:
       bpf_bprintf_prepare(num_args != 0) bpf_bprintf_nest_level = 1
       gets same buffer as task context above

Adding check to bpf_bprintf_cleanup and doing the real cleanup
only if we got bin_args data in the first place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/helpers.c     | 16 +++++++++-------
 kernel/trace/bpf_trace.c |  6 +++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc390ba32e70..656879385fbf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2803,7 +2803,7 @@ struct bpf_bprintf_data {
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
-void bpf_bprintf_cleanup(void);
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 
 /* the implementation of the opaque uapi struct bpf_dynptr */
 struct bpf_dynptr_kern {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7dbf6bb72cad..9cca02e13f2e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -784,12 +784,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(void)
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 {
-	if (this_cpu_read(bpf_bprintf_nest_level)) {
-		this_cpu_dec(bpf_bprintf_nest_level);
-		preempt_enable();
-	}
+	if (!data->bin_args)
+		return;
+	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
+		return;
+	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 /*
@@ -1021,7 +1023,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	err = 0;
 out:
 	if (err)
-		bpf_bprintf_cleanup();
+		bpf_bprintf_cleanup(data);
 	return err;
 }
 
@@ -1047,7 +1049,7 @@ BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 
 	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return err + 1;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3e849c3a7cc8..2129f7c68bb5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -396,7 +396,7 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -454,7 +454,7 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -494,7 +494,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 
 	seq_bprintf(m, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
-- 
2.38.1

