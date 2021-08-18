Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F3F0EB2
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 01:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhHRXmb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 19:42:31 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57505 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhHRXma (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 19:42:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E4CE580E03;
        Wed, 18 Aug 2021 19:41:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Aug 2021 19:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=hFvEoVWwSCuTh+jP7I60pj2evE
        WcEGXz9qnhOKOKqxA=; b=W1xshOxYDoRTbnyH9NBniCWY7B8A6XItrnkOCFACma
        DPEGYs8iDPiqiXCmMEQFmNz3IsYSQk90qnW7Mph/lQ3wUqraVYc/GLus65gsZhqV
        t9Kvs92F11oBWhrNB7OEEmCsGHacKEIr9+dCc6sK8bZQK4+5N+LTp5PN+SX4gLYn
        0ut164v925TzszwGO3MI9DAGB/jhnRBH8midGMDSLa6wzwWGcziXjCXxu+dTgvp5
        z5qZg4PHK/F+LjiARFtvBeKtpOUxgXTYuy76ifggKcFjJPy5+TeLBXRmAwP1zAZr
        993OZEBvckT+3Nd9VsLwuplSM97mwCcnZMYiiyIdU3Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hFvEoVWwSCuTh+jP7
        I60pj2evEWcEGXz9qnhOKOKqxA=; b=jJn9P1bERLvQZT2LKLfRgx9qd2+NW0pZ0
        MDahjBQ5iejDast4AzcnHBUsaECFdqMKnWJ7bj54UNZ0RjgLLHOOsCPzwVTnrCmp
        AxpZUX4FEOFzB5IitXqnnPEpacRdSQsVDAQ8+TQTUNoSfMrX3H6pMMRLzqte5GSC
        tVU8I5AUbBiG/EPsPvQcYIQGCnf9ExhWsro+b9MeWSmiDhxL+Zp5kkiYqOyedrIw
        +k5ff2wgnb/wtDcuwvlxkfk8QXteOXd8XWj/vmHlKVlvzSoOdtNe+doUOiQA4Ca3
        mDchsAFoqpgMfQttGUgbrhXdb6gsY2M64H7BrR6e1CX7hXNZ9Icuw==
X-ME-Sender: <xms:wZodYR-mqycKHd_EKdDh4upWtv5WRPTG5peBrq8K3Ckthqy8MroCwQ>
    <xme:wZodYVux32lO_cF5TFgVNypMZBwDMWOF2ov_aH3bgykluu8VrHZ4OkiqLMw811VAp
    1mIY1o2TOv_U5DQXA>
X-ME-Received: <xmr:wZodYfCd2m4JVpkKfzn5oc63V4SXX4YVUrud0xg56uAWl4unDWAtcfzIpy6SEY9wBiqJ2tg2i-V8Hhflnc8pcpTiCIIJ5pGYTmj3iA2pnnI5dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnegovehorghsthgrlh
    dqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeefgeehudeljeegueeguedvgeeuveelieetudffgfdvkeelheek
    vdejfffhfeefjeenucffohhmrghinheplhhkmhhlrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihu
    segugihuuhhurdighiii
X-ME-Proxy: <xmx:wZodYVdLHpsBwesXnwKl_sRHF1BPwy0GFKZSXPb7-AhQ71eCucjQIA>
    <xmx:wZodYWMCDmZAaVXwOhq2FrPnVyzQUbdBGqVKBOYcMg_6UW0AsnH-HQ>
    <xmx:wZodYXmSRpiTzs0qZ2Z3g7AH3EvXdLXvXzPPzHPhmw8dV5jFCL1Alw>
    <xmx:wpodYTqqrbxRjq1cIgDXXTpZGof2wGgZ2SWwKoe8VEzW2HTOxhGVWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 19:41:53 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] Add bpf_task_pt_regs() helper
Date:   Wed, 18 Aug 2021 16:41:40 -0700
Message-Id: <cover.1629329560.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The motivation behind this helper is to access userspace pt_regs in a
kprobe handler.

uprobe's ctx is the userspace pt_regs. kprobe's ctx is the kernelspace
pt_regs. bpf_task_pt_regs() allows accessing userspace pt_regs in a
kprobe handler. The final case (kernelspace pt_regs in uprobe) is
pretty rare (usermode helper) so I think that can be solved later if
necessary.

More concretely, this helper is useful in doing BPF-based DWARF stack
unwinding. Currently the kernel can only do framepointer based stack
unwinds for userspace code. This is because the DWARF state machines are
too fragile to be computed in kernelspace [0]. The idea behind
DWARF-based stack unwinds w/ BPF is to copy a chunk of the userspace
stack (while in prog context) and send it up to userspace for unwinding
(probably with libunwind) [1]. This would effectively enable profiling
applications with -fomit-frame-pointer using kprobes and uprobes.

[0]: https://lkml.org/lkml/2012/2/10/356
[1]: https://github.com/danobi/bpf-dwarf-walk

Daniel Xu (2):
  bpf: Add bpf_task_pt_regs() helper
  bpf: selftests: Add bpf_task_pt_regs() selftest

 include/uapi/linux/bpf.h                      |  7 +++
 kernel/trace/bpf_trace.c                      | 20 ++++++++
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../selftests/bpf/prog_tests/task_pt_regs.c   | 50 +++++++++++++++++++
 .../selftests/bpf/progs/test_task_pt_regs.c   | 29 +++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_pt_regs.c

-- 
2.32.0

