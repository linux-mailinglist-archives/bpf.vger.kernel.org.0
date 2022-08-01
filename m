Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD08587278
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiHAUus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiHAUuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 16:50:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C19FD3
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 13:50:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f4e870a17so99933337b3.9
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E1/rW2r70zyzqbkFgkmqJNWOc56RBiTRd890RD2T0+o=;
        b=XRNlLnXNNNo/3J7ur9PazcMWQXWXdy0i4aGQbhsUznk0w+tMIO9sDu0/7g4O8KG4rj
         1ZrxlurF863pz5Ebm+T4N2HcJD52RhpJaFJPFR9aKR7WBPWlwrfGimgPIESCe9w4X19g
         /DJzSPvoMe13rkKB5nYSXS3rQqPrju6VAZ8rY5Bz4GkUHFeGAacz6MSAJISiWmY+CAYZ
         X708Q4v77OzFy5rU4nh05vdJy0wsp/2b49O+5Nwzt1fALXz3+IY16QIf8Y48uNcz6Mgy
         VGsUQxlIf9Mb7z5Xngd0eivSJTu55Ob0xqWvwq1e//6nRxA32t1PzpuWiPPf4FhxenMo
         119w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E1/rW2r70zyzqbkFgkmqJNWOc56RBiTRd890RD2T0+o=;
        b=hWWl1Ng6dpM+b6ZtTnoODANeOT9qI2fFy6buP9NIIRTvTDTremCXUJFB2svIlpmAPL
         pRYrk/MZ0y0JkD8Zun4QJXVpzzliWEVd2ZJIcAnYj/55Vz2+sGeHW2iEaPXOrmbgP0+I
         TLGkxsqOx9TTXGz39ac0/NWe8+ls1a/OIvTqlSskuOM9cfAyEcBdwFT9XQV7ME2V7vzg
         FRULAyNXF1xKZjbp+141SKDDyayJVYJbLXEKCiYnqfmVicPKAoCzBQSqrn+xZybp4Rzq
         keLv8nS97lNvfYcfELm7ENS6y0xjHXYl5xHS2qjYEc3P0RLAuIGA3Ogo1rgTVHQQuFJv
         6vYg==
X-Gm-Message-State: ACgBeo3cTZ/VxyWLCrgjsJVWzY0Hi4OsNK4tsGEZ6eayH47g46PenRAg
        /Hkk+oruOPyKaMH77xae8CRBqbV2qZ0=
X-Google-Smtp-Source: AA6agR4ATB4rd/E+Yib6g1x/Un/QX10KVOPSLBYrSV7E3jAYeDJgdVlnl3sf2MKEZUQJL1J/GFxE3Eb/Crc=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7c9:7b32:e73f:6716])
 (user=haoluo job=sendgmr) by 2002:a25:640d:0:b0:670:9077:2203 with SMTP id
 y13-20020a25640d000000b0067090772203mr12776495ybb.460.1659387045104; Mon, 01
 Aug 2022 13:50:45 -0700 (PDT)
Date:   Mon,  1 Aug 2022 13:50:39 -0700
Message-Id: <20220801205039.2755281-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v1] bpf, iter: clean up bpf_seq_read().
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor bpf_seq_read() by extracting some common logic into helper
functions. I hope this makes bpf_seq_read() more readable. This is
a refactoring patch, so no behavior change is expected.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/bpf_iter.c | 156 +++++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..39b5b647fdb7 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -77,6 +77,83 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
 	return iter_priv->tinfo->reg_info->feature & BPF_ITER_RESCHED;
 }
 
+/* do_copy_to_user, copies seq->buf at offset seq->from to userspace and
+ * updates corresponding fields in seq. It returns -EFAULT if any error
+ * happens. The actual number of bytes copied is returned via the argument
+ * 'copied'.
+ */
+static int do_copy_to_user(struct seq_file *seq, char __user *buf, size_t size,
+			   size_t *copied)
+{
+	size_t n;
+
+	n = min(seq->count, size);
+	if (copy_to_user(buf, seq->buf + seq->from, n))
+		return -EFAULT;
+
+	seq->count -= n;
+	seq->from += n;
+	*copied = n;
+	return 0;
+}
+
+/* do_seq_show, shows the given object 'p'. If 'p' is skipped or
+ * error happens, resets seq->count to 'offs'.
+ *
+ * Returns err > 0, indicating show() skips this object.
+ * Returns err = 0, indicating show() succeeds.
+ * Returns err < 0, indicating show() fails or overflow happened.
+ */
+static int do_seq_show(struct seq_file *seq, void *p, size_t offs)
+{
+	int err;
+
+	WARN_ON(IS_ERR_OR_NULL(p));
+
+	err = seq->op->show(seq, p);
+	if (err > 0) {
+		/* object is skipped, decrease seq_num, so next
+		 * valid object can reuse the same seq_num.
+		 */
+		bpf_iter_dec_seq_num(seq);
+		seq->count = offs;
+		return err;
+	}
+
+	if (err < 0 || seq_has_overflowed(seq)) {
+		seq->count = offs;
+		return err ? err : -E2BIG;
+	}
+
+	/* err == 0 and no overflow */
+	return 0;
+}
+
+/* do_seq_stop, stops at the given object 'p'. 'p' could be an ERR or NULL. If
+ * 'p' is an ERR or there was an overflow, reset seq->count to 'offs' and
+ * returns error. Returns 0 otherwise.
+ */
+static int do_seq_stop(struct seq_file *seq, void *p, size_t offs)
+{
+	if (IS_ERR(p)) {
+		seq->op->stop(seq, NULL);
+		seq->count = offs;
+		return PTR_ERR(p);
+	}
+
+	seq->op->stop(seq, p);
+	if (!p) {
+		if (!seq_has_overflowed(seq)) {
+			bpf_iter_done_stop(seq);
+		} else {
+			seq->count = offs;
+			if (offs == 0)
+				return -E2BIG;
+		}
+	}
+	return 0;
+}
+
 /* maximum visited objects before bailing out */
 #define MAX_ITER_OBJECTS	1000000
 
@@ -91,7 +168,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 			    loff_t *ppos)
 {
 	struct seq_file *seq = file->private_data;
-	size_t n, offs, copied = 0;
+	size_t offs, copied = 0;
 	int err = 0, num_objs = 0;
 	bool can_resched;
 	void *p;
@@ -108,40 +185,18 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 
 	if (seq->count) {
-		n = min(seq->count, size);
-		err = copy_to_user(buf, seq->buf + seq->from, n);
-		if (err) {
-			err = -EFAULT;
-			goto done;
-		}
-		seq->count -= n;
-		seq->from += n;
-		copied = n;
+		err = do_copy_to_user(seq, buf, size, &copied);
 		goto done;
 	}
 
 	seq->from = 0;
 	p = seq->op->start(seq, &seq->index);
-	if (!p)
+	if (IS_ERR_OR_NULL(p))
 		goto stop;
-	if (IS_ERR(p)) {
-		err = PTR_ERR(p);
-		seq->op->stop(seq, p);
-		seq->count = 0;
-		goto done;
-	}
 
-	err = seq->op->show(seq, p);
-	if (err > 0) {
-		/* object is skipped, decrease seq_num, so next
-		 * valid object can reuse the same seq_num.
-		 */
-		bpf_iter_dec_seq_num(seq);
-		seq->count = 0;
-	} else if (err < 0 || seq_has_overflowed(seq)) {
-		if (!err)
-			err = -E2BIG;
-		seq->op->stop(seq, p);
+	err = do_seq_show(seq, p, 0);
+	if (err < 0) {
+		do_seq_stop(seq, p, 0);
 		seq->count = 0;
 		goto done;
 	}
@@ -153,7 +208,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 		num_objs++;
 		offs = seq->count;
 		p = seq->op->next(seq, p, &seq->index);
-		if (pos == seq->index) {
+		if (unlikely(pos == seq->index)) {
 			pr_info_ratelimited("buggy seq_file .next function %ps "
 				"did not updated position index\n",
 				seq->op->next);
@@ -161,7 +216,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 		}
 
 		if (IS_ERR_OR_NULL(p))
-			break;
+			goto stop;
 
 		/* got a valid next object, increase seq_num */
 		bpf_iter_inc_seq_num(seq);
@@ -172,22 +227,16 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 		if (num_objs >= MAX_ITER_OBJECTS) {
 			if (offs == 0) {
 				err = -EAGAIN;
-				seq->op->stop(seq, p);
+				do_seq_stop(seq, p, seq->count);
 				goto done;
 			}
 			break;
 		}
 
-		err = seq->op->show(seq, p);
-		if (err > 0) {
-			bpf_iter_dec_seq_num(seq);
-			seq->count = offs;
-		} else if (err < 0 || seq_has_overflowed(seq)) {
-			seq->count = offs;
+		err = do_seq_show(seq, p, offs);
+		if (err < 0) {
 			if (offs == 0) {
-				if (!err)
-					err = -E2BIG;
-				seq->op->stop(seq, p);
+				do_seq_stop(seq, p, seq->count);
 				goto done;
 			}
 			break;
@@ -197,30 +246,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 			cond_resched();
 	}
 stop:
-	offs = seq->count;
-	/* bpf program called if !p */
-	seq->op->stop(seq, p);
-	if (!p) {
-		if (!seq_has_overflowed(seq)) {
-			bpf_iter_done_stop(seq);
-		} else {
-			seq->count = offs;
-			if (offs == 0) {
-				err = -E2BIG;
-				goto done;
-			}
-		}
-	}
-
-	n = min(seq->count, size);
-	err = copy_to_user(buf, seq->buf, n);
-	if (err) {
-		err = -EFAULT;
+	err = do_seq_stop(seq, p, seq->count);
+	if (err)
 		goto done;
-	}
-	copied = n;
-	seq->count -= n;
-	seq->from = n;
+
+	err = do_copy_to_user(seq, buf, size, &copied);
 done:
 	if (!copied)
 		copied = err;
-- 
2.37.1.455.g008518b4e5-goog

