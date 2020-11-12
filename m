Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04502B0EBB
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKLUDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKLUDu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:03:50 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB808C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:03:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so7342524wrx.5
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDF5l0n3msRGgGGH1jpdrBrGSoTCWyYhlZaMIFoRHNY=;
        b=PxCDajPYS+KMhHly7PQAn7plJ/zYAleZ+YiSv2SUa754kwXS/aJGSZwC+TDW/rdQCv
         q05aiakbtJAtUYBPNycY+A3kwd12STIpUnbMkxkd610OR0mCJ1l6idQrSXY6s2PhrXN5
         fsux1Ln24Wq+x9r5mJm65U+rSJc8QKcVLJNGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDF5l0n3msRGgGGH1jpdrBrGSoTCWyYhlZaMIFoRHNY=;
        b=I2eCX76gSXExjQzdxmof4/WQQFzCn4KEjDU8pbtOjxr0w/u6E3zFR8CTy4uKGAmXvV
         /RJtzQMgLYXUIn/X3JaxT0Ze2EAIFFVkxeekfm/mPtsMgjqY6ReLeMn2xrkn1zVb14OY
         SDOYxpcJ+qLSLpBASz3wxmeaIWkNepmbwosSag1jDA3b6u5izyfIYwVatj7/OTsO2fI5
         Xx3aYcxC74HR9gB5yt/jYPDLBWCrTHR+v/xhEcMcptagpEPEVMULOn//+9RbqF9f6bn3
         MHtGyxRFAMKX3NxhEWmt8opGCe525jZDn/9WZ9pm4OetIQfLRE4Hw9HMhWD4+ZldUkr4
         RCOQ==
X-Gm-Message-State: AOAM532j6wU5WtlSPfgfarE46BtToAazLj47p8+z5GTvmpROxpqivWqi
        8m8loD7K3He9Ho1v0+s4fZT3Tw==
X-Google-Smtp-Source: ABdhPJwVb+LsMJ0DjHqzXuECZpfn2+MFgdWWTcckzcS+fCFdEmaOUz+OteWD+70e25ksjgaZahkqBw==
X-Received: by 2002:adf:de85:: with SMTP id w5mr1476604wrl.90.1605211428534;
        Thu, 12 Nov 2020 12:03:48 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f5sm8488472wrg.32.2020.11.12.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:03:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 0/2] Sleepable LSM Hooks
Date:   Thu, 12 Nov 2020 20:03:44 +0000
Message-Id: <20201112200346.404864-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

# v1 -> v2

  * Fixed typos and formatting errors.
  * Added Andrii's ack.

KP Singh (2):
  bpf: Augment the set of sleepable LSM hooks
  bpf: Expose bpf_d_path helper to sleepable LSM hooks

 include/linux/bpf_lsm.h  |   7 +++
 kernel/bpf/bpf_lsm.c     | 121 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c    |  16 +-----
 kernel/trace/bpf_trace.c |   7 ++-
 4 files changed, 135 insertions(+), 16 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

