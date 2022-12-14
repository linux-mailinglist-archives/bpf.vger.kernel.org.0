Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5D64D3AC
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLNXso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLNXsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:48:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E974730A
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:48:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i15so24882033edf.2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMVfBatjQJ8Apd1FbUQ/t7YW99jbbgQQnVdjObsHWFU=;
        b=IiPdEl3CywqTncD3qfXHfROJcQJxyegXve36buaTXLt6YIIMiD6C4pyKQWpBFLe/oQ
         +tbei6CyGo7LY15/IbwA5JwGVBUFdVC3pKzPsTLvA2tv3opf6nWpy6g4grd7bXgLjpjq
         nrNsa7FhgJ2lY27zbiBDHtIVFp8Secs2My7uVVfYCAVxzFc37zhTevK9Erj+YXskHvCZ
         36WFkuVDLBonRzLAjyUG1IzS/e982Cx311L0Q/15EYdtjhDtPTuUGtCrl9iEwikINamN
         UQq973GfErEDFAkxjdAWWCsdxBXNlGa9BozFBtT965KeYzsjPpkBG6jZhwkDVO0N4nuh
         ibBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMVfBatjQJ8Apd1FbUQ/t7YW99jbbgQQnVdjObsHWFU=;
        b=hy9tr9jdvWqqYVpojVaDhnmNxBH83mGxh5RWp6lvXDAvjd9UAyWe/kU690t2ivIJbw
         PT//MkVUqnwIsdLtcMfAuVUmaxL8XK7mnWJtozXRKwWZRsX5OB7Cn0mnVI6jb7pHxs/u
         uRqGea2/NoQ2J2eGEeHxhzHBQIOnx0m65k4Dz/O/fUNgVpWzjQ9zL/Mn5iiimoXBkIwv
         pYOeiW3QANyyNU+bI1vUgSrHcAn4MJLFrFFtfSzwevHxOqWaSCZ7VhFzopJIkzObh8QQ
         c7Am46sa0wXePEB/g71ilKfT/NIoCdzAA7YAxGMPwvqWLu0a44enB/9Rl4DgSRx82jJn
         FBcQ==
X-Gm-Message-State: ANoB5pnreM7bXjsYwYLgKmOk5AIBxZP66+97nDKCSBZeV5/HoJ8szsdG
        nKidhQc4EOMikUuOlrGbZkc=
X-Google-Smtp-Source: AA0mqf4PJxkYGxHMrxoMSTvRLknrW5XjNGGPZZ8KavbC6EuWZlS5nNB8Zwc/dZXaYPv5LQvWsrjGuA==
X-Received: by 2002:a05:6402:1f08:b0:467:f0e7:15f7 with SMTP id b8-20020a0564021f0800b00467f0e715f7mr21942627edb.31.1671061704308;
        Wed, 14 Dec 2022 15:48:24 -0800 (PST)
Received: from krava ([83.240.63.35])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906560400b0078de26f66b9sm6390893ejq.114.2022.12.14.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:48:23 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 15 Dec 2022 00:48:21 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next] bpf: Remove trace_printk_lock
Message-ID: <Y5pgxd9+G2wHROlp@krava>
References: <20221214100424.1209771-1-jolsa@kernel.org>
 <CAEf4BzYmt+7k-eovdj2MWMKOj5FCwhExHa7jSFUX+9Q2NfHHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYmt+7k-eovdj2MWMKOj5FCwhExHa7jSFUX+9Q2NfHHLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 11:48:06AM -0800, Andrii Nakryiko wrote:

SNIP

> >
> > -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > -       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> > +       ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
> >
> >         trace_bpf_trace_printk(buf);
> > -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> >
> >         bpf_bprintf_cleanup();
> 
> I checked what this is doing. And it seems like we have a very similar
> thing there already, with preempt_disable(), 3-level buffers, etc.
> Would it make sense to roll this new change into bpf_bprintf_prepare()
> and make it return the buffer for bpf_trace_printk(), even if it is
> not used for bpf_snprintf() ?

I thought adding another arg to bpf_bprintf_prepare would be too much,
but it actually does not look that bad

I'll do some more testing and send another version

jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3de24cfb7a3d..da5733f15994 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2795,9 +2795,10 @@ struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
+#define MAX_PRINTF_BUF			1024
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_buf, u32 num_args);
+			u32 **bin_buf, char **buf, u32 num_args);
 void bpf_bprintf_cleanup(void);
 
 /* the implementation of the opaque uapi struct bpf_dynptr */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af30c6cbd65d..e2c1e573401b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -756,19 +756,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 /* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
  * arguments representation.
  */
-#define MAX_BPRINTF_BUF_LEN	512
+#define MAX_PRINTF_BIN_ARGS	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
 struct bpf_bprintf_buffers {
-	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
+	char bin_args[MAX_PRINTF_BIN_ARGS];
+	char buf[MAX_PRINTF_BUF];
 };
-static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
+
+static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_fmt_tmp_buf(char **tmp_buf)
+static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
-	struct bpf_bprintf_buffers *bufs;
 	int nest_level;
 
 	preempt_disable();
@@ -778,9 +779,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 		preempt_enable();
 		return -EBUSY;
 	}
-	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
-	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
-
+	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level]);
 	return 0;
 }
 
@@ -807,27 +806,33 @@ void bpf_bprintf_cleanup(void)
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_args, u32 num_args)
+			u32 **bin_args, char **buf, u32 num_args)
 {
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	struct bpf_bprintf_buffers *buffers = NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
 	char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
+	bool get_buffers = bin_args || buf;
 
 	fmt_end = strnchr(fmt, fmt_size, 0);
 	if (!fmt_end)
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (bin_args) {
-		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
-			return -EBUSY;
+	if (get_buffers && try_get_buffers(&buffers))
+		return -EBUSY;
 
-		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
+	if (bin_args) {
+		tmp_buf = buffers->bin_args;
+		tmp_buf_end = tmp_buf + MAX_PRINTF_BIN_ARGS;
 		*bin_args = (u32 *)tmp_buf;
 	}
 
+	if (buf)
+		*buf = buffers->buf;
+
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
 			err = -EINVAL;
@@ -1020,7 +1025,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 
 	err = 0;
 out:
-	if (err)
+	if (err && get_buffers)
 		bpf_bprintf_cleanup();
 	return err;
 }
@@ -1039,7 +1044,7 @@ BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
 	 * can safely give an unbounded size.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, NULL, num_args);
 	if (err < 0)
 		return err;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..798f65c532b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7636,7 +7636,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
 	 * can focus on validating the format specifiers.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, NULL, num_args);
 	if (err < 0)
 		verbose(env, "Invalid format string\n");
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..7a6a07b2180e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -369,8 +369,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -379,20 +377,17 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
 	u32 *bin_args;
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
+	char *buf;
 	int ret;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args, &buf,
 				  MAX_TRACE_PRINTK_VARARGS);
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, MAX_PRINTF_BUF, fmt, bin_args);
 
 	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
 	bpf_bprintf_cleanup();
 
@@ -430,25 +425,22 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
 	   u32, data_len)
 {
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret, num_args;
 	u32 *bin_args;
+	char *buf;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
 	    (data_len && !data))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, &buf, num_args);
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, MAX_PRINTF_BUF, fmt, bin_args);
 
 	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
 	bpf_bprintf_cleanup();
 
@@ -482,7 +474,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, NULL, num_args);
 	if (err < 0)
 		return err;
 
