Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C158E1C7FA7
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 03:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEGBFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgEGBFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 21:05:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7AC061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 18:05:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so1875556pjb.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id;
        bh=fDAxUkCWnLLNYKyqcom5jHpqbxcvX3Nwbyo0Ip8LuRk=;
        b=h3+IYrojdj8XrOT2yXppvSlG8FlwZRoZQROyHHbykmQH5tWOadvP0qK0EZc5qCfLI6
         IqjGPMkJRzQr+j+pWak8kvYgpGx4wUuuXT4NMxnU17wy8R779cxPMzCxmLH2fnU1Y8il
         x/zIrMjy3HjgIAu+PpqzTq5b3BIs9elVKsoUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fDAxUkCWnLLNYKyqcom5jHpqbxcvX3Nwbyo0Ip8LuRk=;
        b=Z6L0MYF7tI1mPJNPM7DCrp6EycaRzx8fPRhKjxp4ncx6vmGhm6eH48Nz8bkLSwwrJL
         ykLCdebA+I4UUeqYfAr+P/49SFUwcIEASLzGFhK9P8y/x8Z+VqOk9CXJ/zlxfMXI5vVN
         bz/K+fovwQ4ibTEpiBP3IeoGgcUUeQvxZV/rLFRzCAbPP6zoQ6kA5sGuPgmHYgF0Du1P
         95V7OomKb+rsg/k88vvD+Qqb2eoqXOalRtPXnZ9UlW1bDlU3hzLayhUwzq09ptBg01Ak
         8rHsZRGU3wR8a3F2Yg1nEFTlp1fhUHItciVgur54AwuyxBnRVPLEYZaIM4rlB4l68u2J
         1AYw==
X-Gm-Message-State: AGi0PubA6wJ+lI1ECP80irKopoZ2xfvgyrb2mw3B9c0SzQWDCtPtMd2c
        xCX4IxS3ENIpSEuaS+858Bh60uShU7KZeA==
X-Google-Smtp-Source: APiQypILpdn/n4nXzF+P/+vZkv7wDuleI/+evcTuS8G2sV3tj+B+qfsjlo61Cp/3MJ9nD2qqAg7YWA==
X-Received: by 2002:a17:90a:d153:: with SMTP id t19mr13166154pjw.42.1588813510513;
        Wed, 06 May 2020 18:05:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id ev5sm6165250pjb.1.2020.05.06.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 18:05:09 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [RFC PATCH bpf-next 0/3] arm64 BPF JIT Optimizations
Date:   Wed,  6 May 2020 18:05:00 -0700
Message-Id: <20200507010504.26352-1-luke.r.nels@gmail.com>
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

Luke Nelson (3):
  arm64: insn: Fix two bugs in encoding 32-bit logical immediates
  bpf, arm64: Optimize AND,OR,XOR,JSET BPF_K using arm64 logical
    immediates
  bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates

 arch/arm64/kernel/insn.c      |  6 ++-
 arch/arm64/net/bpf_jit.h      | 22 +++++++++++
 arch/arm64/net/bpf_jit_comp.c | 73 ++++++++++++++++++++++++++++-------
 3 files changed, 85 insertions(+), 16 deletions(-)

Cc: Xi Wang <xi.wang@gmail.com>

-- 
2.17.1

