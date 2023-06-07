Return-Path: <bpf+bounces-2007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8AC726635
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87F81C20E5A
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4B1ACAE;
	Wed,  7 Jun 2023 16:42:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894A168B9
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:42:37 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D871FD7;
	Wed,  7 Jun 2023 09:42:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-528cdc9576cso3858536a12.0;
        Wed, 07 Jun 2023 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686156154; x=1688748154;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNtQsqwcFl/cHA8FXUAC3pwd32NzZkO9EqSyIbOcyco=;
        b=lqBbMWYtgQwb2e9GiOTqPvz4mdI1YVqPmHtmWQCmULRjFGUp84mM12ddNWfwBc//37
         jt5oQnwu3g/vfBjBhX6IiXwYKLsuOw2ryTvyeEkXSgpZTJryxVHarPq0rOAd85HkIPF+
         2q5Fcv81XB5jIzLz+sdydNl1i4/b/uayaqZsZ059DoGa8+VbvY3WebXon92xlrkOJdvN
         Uq8ECg4lBA3QdwoIIISprFaq6QydgjKll46UHhbL2wKyi3rz/Ywqp1K852xtCQ2fy04x
         OaxTe16+p19NFT9T/RB6YZ4/pesvMvWwRJ6UQn/Gig4Px2c2v2trO5SkaBrjjQwlEEFe
         RhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156154; x=1688748154;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNtQsqwcFl/cHA8FXUAC3pwd32NzZkO9EqSyIbOcyco=;
        b=SgEf1TZiZ3jUrZcHxzq2d85yaRfGczzQiYI674RCQ7KkCGiKJOszSRHtdJboCEhNo/
         YD0baKPMH3iA8o/NdnD8cJVWf6mR+1eCZyUthq3khowmPuk5cJ52obw8P1U8DqP7YsBA
         1MBtjc+JC/v6XSYKO67hWqoxnEqU4JDOXR3RJZoSRL7BLwt/H+Q2Kx/OJteOkGjW/+IL
         uZ5Pjnlh/HYwOhEvIp4nLgQjvJaaAuLgvEFcPk+BZBSiH77wLSZBHjKaAIY+H9cru3UD
         XrYaR6UxT0cfI+szyKR9Z6yWATo/0bApTtUepuAi6jRyKzGUokP6RLXrBFNep99QF24y
         HJsg==
X-Gm-Message-State: AC+VfDx46sg/Xp7gVpWbuiOOoH+AjWbVzE//fC4LsK+vyG31z1CQsed6
	N5MvVRTuqnq3zZxgOPq3luA=
X-Google-Smtp-Source: ACHHUZ5x797qgEOmmP2yN4igJvBd6Ap5yVl4IpECKeDgF/IM4SX0es4JjtuBNb4zxg647LMBjGShkQ==
X-Received: by 2002:a17:902:d487:b0:1b0:46af:7f15 with SMTP id c7-20020a170902d48700b001b046af7f15mr3229541plg.64.1686156153623;
        Wed, 07 Jun 2023 09:42:33 -0700 (PDT)
Received: from krava (c-67-160-222-115.hsd1.ca.comcast.net. [67.160.222.115])
        by smtp.gmail.com with ESMTPSA id g16-20020a170902869000b001b02162c86bsm10703357plo.80.2023.06.07.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:42:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Jun 2023 09:42:30 -0700
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org
Subject: [RFC] fprobe call of rethook_try_get faults
Message-ID: <ZICzdpvp46Xk1rIv@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hi,
I occasionally get following fault:

  general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
  CPU: 3 PID: 28438 Comm: test_progs Tainted: G           OE      6.4.0-rc3+ #448 dad92bc91c459c664b308990ada0799837010e31
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
  RIP: 0010:rethook_try_get+0x34/0xf0
  Code: 48 8b 47 08 85 d2 74 0b 65 8b 15 af 26 eb 7e 85 d2 74 57 48 85 c0 74 73 e8 39 8e f0 ff 84 c0 74 6a 48 8b 53 10 48 85 d2 74 >
  RSP: 0018:ffffc90003ccfcf0 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffff88810920db40 RCX: 0000000000000003
  RDX: 6b6b6b6b6b6b6b6b RSI: ffffffff82c0a371 RDI: ffffffff82bcbddb
  RBP: ffffffff81f5a5f0 R08: 0000000000000001 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000014000 R12: ffffffffa02ec3f2
  R13: fffffffffffffff7 R14: ffffc90003ccfd38 R15: 0000000000000000
  FS:  00007f2f8195eb80(0000) GS:ffff88846da00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f2f819c0140 CR3: 0000000189cb8006 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   fprobe_handler+0xc1/0x270
   ? __pfx_bpf_testmod_init+0x10/0x10 [bpf_testmod b0bc3019aa6d6bdb2afc30cf6381f510d7e5abbe]
   ? __pfx_bpf_testmod_init+0x10/0x10 [bpf_testmod b0bc3019aa6d6bdb2afc30cf6381f510d7e5abbe]
   ? bpf_fentry_test1+0x5/0x10
   ? bpf_fentry_test1+0x5/0x10
   ? bpf_testmod_init+0x22/0x80 [bpf_testmod b0bc3019aa6d6bdb2afc30cf6381f510d7e5abbe]
   ? do_one_initcall+0x63/0x2e0
   ? rcu_is_watching+0xd/0x40
   ? kmalloc_trace+0xaf/0xc0
   ? do_init_module+0x60/0x250
   ? __do_sys_finit_module+0xac/0x120
   ? do_syscall_64+0x37/0x90
   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
   </TASK>
  Modules linked in: bpf_testmod(OE+) loop bpf_preload intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel >


I can't really reliable reproduce this, but while checking the code, I wonder
we should call rethook_free only after we call unregister_ftrace_function like
in the patch below

jirka


---
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 18d36842faf5..0121e8c0d54e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
 		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
-	/*
-	 * rethook_free() starts disabling the rethook, but the rethook handlers
-	 * may be running on other processors at this point. To make sure that all
-	 * current running handlers are finished, call unregister_ftrace_function()
-	 * after this.
-	 */
-	if (fp->rethook)
-		rethook_free(fp->rethook);
-
 	ret = unregister_ftrace_function(&fp->ops);
 	if (ret < 0)
 		return ret;
 
+	if (fp->rethook)
+		rethook_free(fp->rethook);
+
 	ftrace_free_filter(&fp->ops);
 
 	return ret;

