Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C712136EB87
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbhD2Nr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2Nr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 09:47:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226BEC06138C
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 06:47:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h4so57977174wrt.12
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSCwrssqX2KhgRx3xuyar2hPuZ63b3AtaEHTCRmhIXc=;
        b=wTAiuDH5UMv5Ya0FWEUlLhcPW7viwH7fV6AkJ/q0E0Vssm/QYy0wcB7GRydob+SeGG
         44xTACzVxOAMMC/rCFbilBJR77daBE//5ihtDXR7y5paPZVXEtsa/n2q5lk4gK8zLV0h
         khnbe532lM54gi1MSLi5RZAsX4fz8OG//lDTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSCwrssqX2KhgRx3xuyar2hPuZ63b3AtaEHTCRmhIXc=;
        b=Mfk+1v+sZtoSvNSp59spFvQZHS6e3YjuYrsH7g7+Ss8ZtFDiUkXk2xcPsBLqcKoKXP
         m/nfZU+4XIEPW5NX2VE9qqaNR5Yvdsc7BmcYZQ3BitTFraxgPItwTJE6uHiL4XcqtBDv
         OINIDP7udbucxtVKdTFx4a7L7XcHpVF3KRvwU9GP6rJJXuNe/T4DM1onZ+QePjXsCUDn
         VmhZDd+SwHMxXfCGsZhGlvJ85NEjju2DxdOHRTnHMFCHORWxo18Rw3UzlrQRsKFnDqLa
         E06O9Gk5EuULcPQRVMnGe9UyNO4iPDAomNpF2851aLMV/VbVVI1QqRolUy694mG6DcuE
         WEjA==
X-Gm-Message-State: AOAM531yOJ3HB6f55fG6rnN8Urt4Ltuo92P8hXQlXkujyZ8jHL+P8CmZ
        lDZG2GBusOVYRyXq4359N1N9Lw==
X-Google-Smtp-Source: ABdhPJzSKYwVvCe0MrvvKkpRTpexIHtK/H0uEAX8M1P0xEYdxMhAXAYEXFRC2ukkiQfu4xszWaYxRA==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr43756298wrc.236.1619704028842;
        Thu, 29 Apr 2021 06:47:08 -0700 (PDT)
Received: from localhost.localdomain (8.7.1.e.3.2.9.3.e.a.2.1.c.2.e.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4e2c:12ae:3923:e178])
        by smtp.gmail.com with ESMTPSA id x8sm5105592wru.70.2021.04.29.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 06:47:08 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/3] Reduce kmalloc / kfree churn in the verifier
Date:   Thu, 29 Apr 2021 14:46:53 +0100
Message-Id: <20210429134656.122225-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

github.com/cilium/ebpf runs integration tests with libbpf in a vm on CI.
I recently did some work to increase the code coverage from that, and
started experiencing OOM-kills in the VM. That led me down a rabbit
hole looking at verifier memory allocation patterns. I didn't figure out
what triggered the OOM-kills but refactored some often called memory
allocation code.

The key insight is that often times we don't need to do a full kfree /
kmalloc, but can instead just reallocate. The first patch adds two helpers
which do just that for the use cases in the verifier, which are sufficiently
different that they can't use stock krealloc_array and friends.

The series makes bpf_verif_scale about 10% faster in my VM set up, which
is especially noticeable when running with KASAN enabled.

Lorenz Bauer (3):
  bpf: verifier: improve function state reallocation
  bpf: verifier: use copy_array for jmp_history
  bpf: verifier: allocate idmap scratch in verifier env

 include/linux/bpf_verifier.h |   8 ++
 kernel/bpf/verifier.c        | 254 +++++++++++++++++------------------
 2 files changed, 128 insertions(+), 134 deletions(-)

-- 
2.27.0

