Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD81CB6DA
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHSQA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726807AbgEHSP7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 14:15:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A424C05BD09
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 11:15:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so1086400pls.8
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id;
        bh=SpXTpjywTMwNg9TSFFzsjIj59xv1CBVoV4EOvzTnkkE=;
        b=OUaIAWfx/D+534tHqEjPc5LhTV0i1FVt0Kt5hR3t1Yp7olGvCqp/H+sefJAIfUfMTo
         lsTfQ0r47jEml60qGikpE/Q4n5MWvrp5ySbMDcj83f4zkSJNh3q1ELFkn5xeYt41li+N
         Pg4VgAJ9/SlQaHUatqfDxchdOtITEwVOUOSPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SpXTpjywTMwNg9TSFFzsjIj59xv1CBVoV4EOvzTnkkE=;
        b=E5K4xzDiYzmLWg5cRW4pYXDRA3YzdTuHp+2JGKjEfAKnXrUpIq5PcyQ5f5hI/J7cvG
         lUFFhqgpdJqNgn6EVKHf5o0JEB8LOV3+QT01K1eL5h6pS4iZ6rd2fHiPNDtC7ndT4omg
         RREQwLtT8SuQEO84SpMIKuQx6NthDzRhVHb/YbhD6CQXF1DCslrPmm7HNldJ0kZM6bcc
         L6xnvig4AABoKGhYxnCmjnkaHVitnpoH7WFwqH0Wje0VSkVobM9yZCXh5NdaSdcpRiK+
         Y/aIbpa4xzYqT2V0cWu29zyBTwJDHMuToUtsiqEdQpcmGuRbzlknalvnx9IsgcLj8Zb4
         b99A==
X-Gm-Message-State: AGi0PuYbaJ0848iFWQemO0QAg8CjwO+PsrvC/0h5nOO9aqtCletybISC
        ZVLst3o+nycrHwXpZN5/uBiEsA7foDajOA==
X-Google-Smtp-Source: APiQypJi63IfRpNFJ9QMnCB3d7uQo9kOMqYx5rt13VDzmIabXyqW/KZU/7OgFnhyxpXQwSQA+CUfQg==
X-Received: by 2002:a17:902:9a43:: with SMTP id x3mr3623548plv.332.1588961758604;
        Fri, 08 May 2020 11:15:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id e11sm2349463pfl.85.2020.05.08.11.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:15:57 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH bpf-next v2 0/3] arm64 BPF JIT Optimizations
Date:   Fri,  8 May 2020 11:15:43 -0700
Message-Id: <20200508181547.24783-1-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series introduces several optimizations to the arm64 BPF JIT.
The optimizations make use of arm64 immediate instructions to avoid
loading BPF immediates to temporary registers, when possible.

In the process, we discovered two bugs in the logical immediate encoding
function in arch/arm64/kernel/insn.c using Serval. The series also fixes
the two bugs before introducing the optimizations.

Tested on aarch64 QEMU virt machine using test_bpf and test_verifier.

v2:
 - Cleaned up patch to insn.c.
   (Marc Zyngier, Will Deacon) 

Luke Nelson (3):
  arm64: insn: Fix two bugs in encoding 32-bit logical immediates
  bpf, arm64: Optimize AND,OR,XOR,JSET BPF_K using arm64 logical
    immediates
  bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates

 arch/arm64/kernel/insn.c      | 14 +++----
 arch/arm64/net/bpf_jit.h      | 22 +++++++++++
 arch/arm64/net/bpf_jit_comp.c | 73 ++++++++++++++++++++++++++++-------
 3 files changed, 88 insertions(+), 21 deletions(-)

Cc: Xi Wang <xi.wang@gmail.com>

-- 
2.17.1

