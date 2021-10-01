Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55141EB87
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353026AbhJALPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353772AbhJALLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Oct 2021 07:11:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF89C0613E2
        for <bpf@vger.kernel.org>; Fri,  1 Oct 2021 04:09:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m22so9418922wrb.0
        for <bpf@vger.kernel.org>; Fri, 01 Oct 2021 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZNCtgJESuuBglLRSxSP+yMWbcKos3toNZIRMOdvxc4=;
        b=Mfv5vvP15OR8E1Y8a9L+d3tTQ7LbH5kKmRVd3+3TXPrgFXxjC70dt9CE9eG0WXAOtz
         P8MygFZcq2QmRR2+PbMGPhpVUE+Obo5pZJ4ETTUruXlitxOO/1T2AZ8P1hyx/9ax9xHx
         yEGGwo+a4DhoxDQmGHQ9hjXxAbIf6meqE3WyyugZaDNfX0i118Hbsv3C0iexWuvgpJMg
         2l6VT5PATlmTM++iNCVDIGOfPaWGn6mOQjWudTXP3TXOUFN7MuOkaypGGrlfnRrGTCUS
         +6MuDQsM7PYQplBRuR0aPnn/l/yuW1E32EOEZ8xQrdAHxa39n12TmTBjKUFWmcpFZAMQ
         JGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZNCtgJESuuBglLRSxSP+yMWbcKos3toNZIRMOdvxc4=;
        b=Y0Mhf1gLB38f8v1SJftW75qdtpJfoEq4HT6JL+qFt4sOQDN8FGTASyBkTcM1JZcJSw
         5+qleU2en6PZCYalqaRhsFiSioKQkh/LzHFP1FAoG8mqBOqfSUq+IZSPdOsdqu4auYbu
         gSrJ+DxJttaTIjh9PV5PYDZer2f0PilEv1lDSlBo+3/oS356595kyNfWX1YUT2kj3LM6
         p1MRL7IU8I048HsQVDGsE3NU5Qxk/mJiPGCkU+3eo/3bJ4fKS7nKiKMfMAgiFa+1rUzT
         3ZZgTVy96kU+masOFQDZZrVoGgTVafl+8gb1DswBT3GRppxNMr6JbHPjqV8yIKhuPHYP
         tyCA==
X-Gm-Message-State: AOAM530EgGPqrQxP2UM3b92T1ErZ1eWcqRwILP8LFA57vhhABm6PFhKW
        FQdcIm1QtINeRkTQ+g84Chaq3Q==
X-Google-Smtp-Source: ABdhPJzyzCovRIsfB/xwUiwIEYlTY9UvAnCfUA8lOoffqUTKuzclXcz4btF9mnf3TPb1nonpQ63cTA==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr11363714wrw.376.1633086569059;
        Fri, 01 Oct 2021 04:09:29 -0700 (PDT)
Received: from localhost.localdomain ([149.86.91.69])
        by smtp.gmail.com with ESMTPSA id v17sm5903271wro.34.2021.10.01.04.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:09:28 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 8/9] samples/bpf: update .gitignore
Date:   Fri,  1 Oct 2021 12:08:55 +0100
Message-Id: <20211001110856.14730-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001110856.14730-1-quentin@isovalent.com>
References: <20211001110856.14730-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update samples/bpf/.gitignore to ignore files generated when building
the samples. Add:

  - vmlinux.h
  - the generated skeleton files (*.skel.h)
  - the samples/bpf/libbpf/ directory, recently introduced as an output
    directory for building libbpf and installing its headers.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 samples/bpf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index fcba217f0ae2..01f94ce79df8 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -57,3 +57,6 @@ testfile.img
 hbm_out.log
 iperf.*
 *.out
+*.skel.h
+vmlinux.h
+libbpf/
-- 
2.30.2

