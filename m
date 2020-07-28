Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661AF230DF8
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgG1Pfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgG1Pfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 11:35:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99C6C061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 08:35:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o10so5466429edh.6
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db/TRpT5kV/W8mcFEsxSUdSWdjO0G1cFFZkEW6SG77U=;
        b=YWZIxtj1nPUiZ1MC1oJx0lMh/mIsKru+t0v/IzNkA6DutuUZpgrzNTEVphX+lyVyIp
         U8cs+bYxU4mRBTlPUji7TUQToVheFDsIijvV6SwTjvl7LLEpsw5BjBJEuOkOYVGM/2nL
         KENJThcY76ozCAet7kx7yLOyjYL7RrD6An/GmrI7vvlNxhBKgYA11gBbOjvldXqr893s
         SIk3XUZMf+l/PfSNwAH5MFn/7FcmLE1fkWDbyi8XYu/WAEvoJ6bdkWAPQDlrdjpkA0It
         X3qBRVfaNsH6TFdh+gERF2hRHfH6XpvZNvSEY9BPoqseQyp8Hb5WUIQOh9Hqy8VMoBEh
         NswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db/TRpT5kV/W8mcFEsxSUdSWdjO0G1cFFZkEW6SG77U=;
        b=B3G/145olXNtvEG7+1RyiHMfX/sPdZHvqHeG+vlNvpKy4xq1gOuxERCV22QSCLxjIo
         ZWQ1K33jUGRFePKtV/GT+v3ha/VIKpN2Y9zE3vDOSP+AxIXRw5n4tr3cDCmyYdHBrT1K
         yGpbkjQSbsAYi1MTogS9xkWZf+93BWcNnWLYOeqYP5bxABsqk4KmH0XeGwATSI5DsAiT
         qa+gIWpMQeyK0em8tLq+9TSmlCkJKKo+Lfuv7wqeEw8SaNGBauAw8AQJEVlAneZWoyRh
         Da0iQrciVGTF4wMv/vMzrX4PuFkOW8JQSCt4PulpCIGTaIVa0ElizBlcvoVSg7OQJ/x0
         JTLQ==
X-Gm-Message-State: AOAM532gsoHX4BX5LxwTLtchAdIc3oxngwHceOymHlWz0so69WkRFteO
        OKsXVBgnO0uJ13mjWsg2wt98tQ==
X-Google-Smtp-Source: ABdhPJw2DUvpmrLaI1mp6J4Wh3Uj9MM6l2x/Qwj6OjuK47yvJlkWRX+9ONB5atmFIyKYc3K+RX2gcQ==
X-Received: by 2002:a50:e1c5:: with SMTP id m5mr26085799edl.138.1595950537354;
        Tue, 28 Jul 2020 08:35:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id ce12sm10217235edb.4.2020.07.28.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:35:36 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, zlim.lnx@gmail.com, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 0/1] arm64: Add BPF exception tables
Date:   Tue, 28 Jul 2020 17:21:24 +0200
Message-Id: <20200728152122.1292756-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following patch adds support for BPF_PROBE_MEM on arm64. The
implementation is simple but I wanted to give a bit of background first.
If you're familiar with recent BPF development you can skip to the patch
(or fact-check the following blurb).

BPF programs used for tracing can inspect any of the traced function's
arguments and follow pointers in struct members. Traditionally the BPF
program would get a struct pt_regs as argument and cast the register
values to the appropriate struct pointer. The BPF verifier would mandate
that any memory access uses the bpf_probe_read() helper, to suppress
page faults (see samples/bpf/tracex1_kern.c).

With BPF Type Format embedded into the kernel (CONFIG_DEBUG_INFO_BTF),
the verifier can now check the type of any access performed by a BPF
program. It rejects for example programs that cast to a different
structure and perform out-of-bounds accesses, or programs that attempt
to dereference something that isn't a pointer, or that hasn't gone
through a NULL check.

As this makes tracing programs safer, the verifier now allows loading
programs that access struct members without bpf_probe_read(). It is
however still possible to trigger page faults. For example in the
following example with which I've tested this patch, the verifier does
not mandate a NULL check for the second-level pointer:

/*
 * From tools/testing/selftests/bpf/progs/bpf_iter_task.c
 * dump_task() is called for each task.
 */
SEC("iter/task")
int dump_task(struct bpf_iter__task *ctx)
{
	struct seq_file *seq = ctx->meta->seq;
	struct task_struct *task = ctx->task;

	/* Program would be rejected without this check */
	if (task == NULL)
		return 0;

	/*
	 * However the verifier does not currently mandate
	 * checking task->mm, and the following faults for kernel
	 * threads.
	 */
	BPF_SEQ_PRINTF(seq, "pid=%d vm=%d", task->pid, task->mm->total_vm);
	return 0;
}

Even if it checked this case, the verifier couldn't guarantee that all
accesses are safe since kernel structures could in theory contain
garbage or error pointers. So to allow fast access without
bpf_probe_read(), a JIT implementation must support BPF exception
tables. For each access to a BTF pointer, the JIT generates an entry
into an exception table appended to the BPF program. If the access
faults at runtime, the handler skips the faulting instruction. The
example above will display vm=0 for kernel threads.

See also
* The original implementation on x86
  https://lore.kernel.org/bpf/20191016032505.2089704-1-ast@kernel.org/
* The s390 implementation
  https://lore.kernel.org/bpf/20200715233301.933201-1-iii@linux.ibm.com/

Jean-Philippe Brucker (1):
  arm64: bpf: Add BPF exception tables

 arch/arm64/include/asm/extable.h |  3 ++
 arch/arm64/mm/extable.c          | 11 ++--
 arch/arm64/net/bpf_jit_comp.c    | 93 +++++++++++++++++++++++++++++---
 3 files changed, 98 insertions(+), 9 deletions(-)

-- 
2.27.0

