Return-Path: <bpf+bounces-9836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B479DCB6
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB74228119F
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32341156E3;
	Tue, 12 Sep 2023 23:32:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E561429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:27 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C38210FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bf3f59905so770187166b.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561545; x=1695166345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4nEz1Iccr+xZqvDM5bnGug5s7P4+oRT7ierkjOsGaE=;
        b=Zd909t06qpmEmHXw+DWc1Y/XGH9qWbd0bcwyfuuNf4G6KZPyhl+UfQHHgrQrhp4+1n
         2JMP27mswQWqyy6MzmVEPvSMhHIYo9q9t/W6xJFSK8VmrX3iRt1pGIsj1BdGOlDv+NBM
         Zmscf3OoW22f66u9zdduZyS945AUAK+RGIvbbVJCJK3STdSMTWYc5HiXKgJ0ndiGgv9i
         o8swP/0uyE8B1UyHr6B7yUAov7hGe4n22F4C6SKYLvi0Kg8IFRF7BHe8iV+ipXpIOU8/
         5LWnvKewUIbCDxyhr28Kyol6J9BY6eth0zh1QUbxCF+YJTJhyW8D+q5ZpKRCI0zNIf47
         UXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561545; x=1695166345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4nEz1Iccr+xZqvDM5bnGug5s7P4+oRT7ierkjOsGaE=;
        b=TssYe5EaBAd5pp6vRD3COsYioqxqllosizXxsXsg82DYIBsbL+JXag9RbAbY7yhNvd
         ubeV9vbnl1VLVnMxFrDYJq8H7BrmlmGFWf+ExfyXiRenQXjwNP8WDaNic0y6DJ3EpA8U
         jaKt0KNgEDRtJRlm4GMdZGEEgfW3DDKc7/tzRBDoE8so4WVrPPJDh+nnTdEYV+o/EvXW
         0ZNr0YH8BdNtVPaJbOCTLpQ2gm36mLl5hPumxSwKuEsYfCv4kjkmXkgxxdunkCt9QpQX
         WEerVtRU807wW+udNPnbTF9qaqGFoHG5lnl6gZtRadgcZb2OvD99E6rFXYUmriT/MRi0
         q38Q==
X-Gm-Message-State: AOJu0Yzxldku7j0qABMGNEN3aR7YjuOvx37YGtjJMYstbUn8RhM2Tmzn
	VEv01lKFecwC5BYbnakSuz85D53n6c7Fgg==
X-Google-Smtp-Source: AGHT+IEr8d3pYighYqPSWw4xRQfn0fNAl7/N89SiBWDt1TFgsOm8aItNZpw6jtag4NbEDPU78mnqOg==
X-Received: by 2002:a17:907:2c6a:b0:9a1:edfd:73bb with SMTP id ib10-20020a1709072c6a00b009a1edfd73bbmr601569ejc.47.1694561545491;
        Tue, 12 Sep 2023 16:32:25 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id se22-20020a170906ce5600b009920e9a3a73sm7489440ejb.115.2023.09.12.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for exception callbacks
Date: Wed, 13 Sep 2023 01:32:09 +0200
Message-ID: <20230912233214.1518551-13-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; i=memxor@gmail.com; h=from:subject; bh=ZYZfPK9xehq0OlRbe34+tgm5ELBdf5+L7TGiYkXpUx8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPStPNtkQvOi1eXnTzCTxzh4HbyCSiqKhPicI 8AZlMhkLpGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R ytoBEACbKGtjeyjXZ9sBe7Z2Y3b8mnALTo14ca8u7Pt+C/NGBzgdYAZRyrm9vT+VM8OCpLNM0Of JjxbY5PvqY4a5hbs5yt95HZjAn6v33afWRCIZ4mUhew5wXCUjrK6mNq2ubrq5apiUhDo5LP6y+e H1c+8hcpUqimaC4GyoC0VCewDoJhaEv8Y70q9yE5r5r7MEuZyTzbFHymF+PPnxF2ic2YYOliDSM QteuvDOFnIYKg2JbylMYZ7l4BrkQGDygBckOvDQhad2wYullNweq06gUGk+2jQcDU4MjxgAmG8R CQ5u85N3iPTNctYT8KClmNddrlLQQVpoeuKo+rGMZlWHJD9ABdouAk+UI1+JcWJlFaA5o1JoLXa 83xkCVD1Nm/Js4LxHA6qI38HoVJ0q7xGH6sBu+qTkZZj9++AD2Keex7II63J/EWnpc4KP4eyA1g oYEaMjtJGorb5qTUB2sdAF91kFqeqyEUwcBjx2PplmUB0b2Opxn58/B9R21+bMHpeDhhRrkH6sq CLYOl/9X/3SdNf81j5aYrh4RPgvBkaKudhs1V4UQrx6Dxy96SqqlZsTkhR2NK+HXbOpuX87C3Tf N4RDPOgPSPBgFDtfjo645JW14XbkZILMcMYydMU+zt84NPaY6XBCR7Tv1NREMcwIgQO/7qoZn+A HFqWyCrWYlxu2wQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

During testing, it was discovered that extensions to exception callbacks
had no checks, upon running a testcase, the kernel ended up running off
the end of a program having final call as bpf_throw, and hitting int3
instructions.

The reason is that while the default exception callback would have reset
the stack frame to return back to the main program's caller, the
replacing extension program will simply return back to bpf_throw, which
will instead return back to the program and the program will continue
execution, now in an undefined state where anything could happen.

The way to support extensions to an exception callback would be to mark
the BPF_PROG_TYPE_EXT main subprog as an exception_cb, and prevent it
from calling bpf_throw. This would make the JIT produce a prologue that
restores saved registers and reset the stack frame. But let's not do
that until there is a concrete use case for this, and simply disallow
this for now.

Similar issues will exist for fentry and fexit cases, where trampoline
saves data on the stack when invoking exception callback, which however
will then end up resetting the stack frame, and on return, the fexit
program will never will invoked as the return address points to the main
program's caller in the kernel. Instead of additional complexity and
back and forth between the two stacks to enable such a use case, simply
forbid it.

One key point here to note is that currently X86_TAIL_CALL_OFFSET didn't
require any modifications, even though we emit instructions before the
corresponding endbr64 instruction. This is because we ensure that a main
subprog never serves as an exception callback, and therefore the
exception callback (which will be a global subprog) can never serve as
the tail call target, eliminating any discrepancies. However, once we
support a BPF_PROG_TYPE_EXT to also act as an exception callback, it
will end up requiring change to the tail call offset to account for the
extra instructions. For simplicitly, tail calls could be disabled for
such targets.

Noting the above, it appears better to wait for a concrete use case
before choosing to permit extension programs to replace exception
callbacks.

As a precaution, we disable fentry and fexit for exception callbacks as
well.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2c8e1ee97b71..7ff2a42f1996 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2490,6 +2490,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 */
 	kasan_unpoison_task_stack_below((void *)ctx.sp);
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
 __diag_pop();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ba32b626320..21e37e46d792 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19750,6 +19750,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
 		}
+		if (aux->func && aux->func[subprog]->aux->exception_cb) {
+			bpf_log(log,
+				"%s programs cannot attach to exception callback\n",
+				prog_extension ? "Extension" : "FENTRY/FEXIT");
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (conservative) {
@@ -19762,6 +19768,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			if (aux->func && aux->func[subprog]->aux->exception_cb) {
+				bpf_log(log,
+					"Extension programs cannot replace exception callback\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
-- 
2.41.0


