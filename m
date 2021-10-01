Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5E41EE24
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354109AbhJANGv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 09:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354173AbhJANGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 09:06:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B8C0613E5
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 06:03:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bd28so34453488edb.9
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw9IUMaLywJloQik8I5Go3bAQFQF2YDMapxftvHW9ss=;
        b=kL2uqYRQ2DVtojeTq45f2PBUCs/JXBOYH0ZwK8Hfc2IXN7XA4Hqq5tcw+M/hSqfiXN
         Y3/VRbCBvw+Pjo+kfDnIKtI3KmDbh+ucB5dej+lwpi97aoX8mvdHKvoQgbisctbT5CEt
         BVmfsMrbV55wU0vIvK3l1yt4YhuVzXjk6uIPOqvroOzAibAIsUYHNQy9cBn7wSVwPg7f
         gFzFhwTQfz+rJHM0ikSrFhloNT333EeEWi284vZfKSGIQK1EVAoacjypl9YPwpbw4Mi8
         9ZFnos4j8jcKN5c3nQZDZA42diEPI0bQN+inwWP+tpNI4Xlnt/PRPLUuIpS3KxqjM/sY
         7tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw9IUMaLywJloQik8I5Go3bAQFQF2YDMapxftvHW9ss=;
        b=oq7qFNA02ghcFbRFjY+ldhWnri8LYPMIogAj0yR7uMTr2LALHJWDTzKDkmqaeSAO9b
         FnKCYFUeggFHvsxlpoXsUZxQAQqDZkZxVQqPWYuzSfTjVK6lxUcTs/1o7s3xCOCcbOvl
         bneAaOsBbkLQ9rqVfN0X7U6WAT0wlsp9ka7bTSL9Ve/3Sln3XNUT90UpPVrBk8vdZvYe
         ShqdW3dSO0VZXwgn5FqpC+TH4zp4QTO4UrjmrP+RXxGBsEzw0UQH04oHgkkAs4biQQks
         qLG/BxLPivAVDuR1eKr742Bexz67FtPWUqhLLH/ltaSzSZ2N7ROCuN390HeD2I+99c/W
         3rvA==
X-Gm-Message-State: AOAM531stZcAGzBYYXjz8GhZilJNhtzJj9ZcO3R1E8tHYiSw9spE8i7B
        ny2CDI7+SD6a2JG2zt6JjgoIng==
X-Google-Smtp-Source: ABdhPJwuOTrl9CV5KOgJa7gOtxUuQMDtwaAPUEqH9sxYW38UFTjXcrHMs0X9p1BIGX0ZvtcWv66ZGA==
X-Received: by 2002:a17:906:8aa7:: with SMTP id mu39mr6081129ejc.298.1633093437608;
        Fri, 01 Oct 2021 06:03:57 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id p22sm2920279ejl.90.2021.10.01.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:03:57 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 00/10] bpf/tests: Extend eBPF JIT test suite
Date:   Fri,  1 Oct 2021 15:03:38 +0200
Message-Id: <20211001130348.3670534-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a number of new tests to the test_bpf.ko test suite.
The new tests focus on the behaviour of operations with different
combinations of register operands, and in particular, when two or more
register operands are in fact the same register. It also verifies things
like a src register not being zero-extended in-place in ALU32 operations,
and that operations implemented with function calls do not clobber any
other eBPF registers.

Johan Almbladh (10):
  bpf/tests: Add tests of BPF_LDX and BPF_STX with small sizes
  bpf/tests: Add zero-extension checks in BPF_ATOMIC tests
  bpf/tests: Add exhaustive tests of BPF_ATOMIC magnitudes
  bpf/tests: Add tests to check source register zero-extension
  bpf/tests: Add more tests for ALU and ATOMIC register clobbering
  bpf/tests: Minor restructuring of ALU tests
  bpf/tests: Add exhaustive tests of ALU register combinations
  bpf/tests: Add exhaustive tests of BPF_ATOMIC register combinations
  bpf/tests: Add test of ALU shifts with operand register aliasing
  bpf/tests: Add test of LDX_MEM with operand aliasing

 lib/test_bpf.c | 2803 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 2571 insertions(+), 232 deletions(-)

-- 
2.30.2

