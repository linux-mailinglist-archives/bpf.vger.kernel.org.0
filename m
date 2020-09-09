Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44126263256
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgIIQZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbgIIQXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:23:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929AC061757
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:22:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g4so3630547wrs.5
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUTQ7wjwTJ+TAAblcFAmVW5okwBV1FuPt1Figo65gko=;
        b=SA8mxauCZHhys4AY9RnLusQACh/4c3QjGYXAfds8TZfUIwXDOWF7VVrg/hQyjIJk86
         ycXtmyUSiREfFLGxwtps9e/IJetitYFiMwzLaljUTSgev+0o2CGUFooRIrx77w3BOozD
         mSWKinjNGps4UDzHhA9Oe4E0R1mPM0h88H7AL18UJFESZtvy4Hinn78RVlpk+9G49Slj
         hqFk3jVcR6Rzzpl2S1O1fU2TT8BPCUAdDRIfQf6gLhyD7cKDI3rzNLVEIexB9X9+mmL9
         +T3VmQalbPouKLl2wLRJCoRGTb6YsPy0LCW+DA4KLkQ4cB8VJH8Vyj9XjxIjg24tGV/c
         Y16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUTQ7wjwTJ+TAAblcFAmVW5okwBV1FuPt1Figo65gko=;
        b=OKho5TuQTGS7OFbRdgplGSvsDm87GKFakShUvd/xGc6FW6Dt4ewz5L3e8PrKmU1CpR
         TO5yWoMrefdqvnIfGVGP+uDnbna5B+205nhxGdDxSx6pHz4LQ4SZipXIwUiqI5bKFveS
         bd7aKPnaJ+QamCE+RnVqfrHNEYOcIHLs/3InSks5cHjIPxFLfovABVz/GLOtI1F3Hv59
         uTzLS9kfw7ZUh1WI0F+SBdzVOF9hM7/rMiXZWftFZg4h836HOKC+aqmOACQKPDCqha1E
         wJGaBmGWE5qGgUwc0ctQA7PFDlLzVwnI/RctfjiwwOP/JBXPUavwkBx3dNkj3b19kvrM
         +qRA==
X-Gm-Message-State: AOAM530Joiz7TWsq/M0b9KTKGuG/61CYKS2TEUEHGwh50fJtduYkGFLy
        Md7oKwnfSwyeDC0whdVzZxiRRrPzcPvPJ/Yo6TM=
X-Google-Smtp-Source: ABdhPJxWjRBMchnrLLSUaxfRCoZrWEzjzCUuxR411iSq7GyrTXMlZOgbT8bUKL99RTCZwc1+IvugYw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr4583138wrt.267.1599668573655;
        Wed, 09 Sep 2020 09:22:53 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.149])
        by smtp.gmail.com with ESMTPSA id m1sm4747787wmc.28.2020.09.09.09.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:22:53 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/2] bpf: detect build errors for man pages for bpftool and eBPF helpers
Date:   Wed,  9 Sep 2020 17:22:49 +0100
Message-Id: <20200909162251.15498-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set aims at improving the checks for building bpftool's documentation
(including the man page for eBPF helper functions). The first patch lowers
the log-level from rst2man and fix the reported informational messages. The
second one extends the script used to build bpftool in the eBPF selftests,
so that we also check a documentation build.

This is after a suggestion from Andrii Nakryiko.

v2:
- Pass rst2man option through a dedicated variable, use it to ask for a
  non-zero exit value on errors.
- Also build doc right after bpftool when building (not only running) the
  selftests.

Quentin Monnet (2):
  tools: bpftool: log info-level messages when building bpftool man
    pages
  selftests, bpftool: add bpftool (and eBPF helpers) documentation build

 tools/bpf/bpftool/Documentation/Makefile      |  3 ++-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  3 +++
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++++
 .../bpf/bpftool/Documentation/bpftool-map.rst |  3 +++
 tools/testing/selftests/bpf/Makefile          |  5 +++++
 .../selftests/bpf/test_bpftool_build.sh       | 21 +++++++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.25.1

