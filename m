Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9B3CCFD1
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhGSIU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 04:20:56 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:45821 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhGSIUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 04:20:53 -0400
Received: by mail-wm1-f44.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso9990315wmj.4
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gicoTuhx62Lz0IXi9HyKg/EPZjby5OAg9N4Cc+WYi3s=;
        b=UeIE377QK2WGUeE/NyuK7L1kbnQYpERmhrdXLxMaiJl4nTX/JzP4PiWtiw4aw0pntU
         33aLmGIBDoAeyMlQzLIRi7MMyGRHr9sxmEXc/cp3+Xg75zsrv02bEXt0O/V82MZISBQy
         n5j+qMd/honSQ2CDlFw6cOOazEKcl3jlf5wxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gicoTuhx62Lz0IXi9HyKg/EPZjby5OAg9N4Cc+WYi3s=;
        b=TaUuAD3kV8dD+MH8nYTzoQ9FpSfUz3t96QA97EyyKfuG0umdc3xKiNFkCHcAg9ktin
         fyR0TubT3DLEXg8cYwARWzQFaGTpCfZNduU6KcNgmhTwgg5cGkDCIi/Dt3qTG+GHVgwz
         S+XbZeFQIDWgVLjUFWv5R05SSP/tPna15t5jwE0bprBse5gVuOo6lXxkPl6qnJdTNHGz
         pmdJODKIS6zqF+S9fbReYGtrYqey30C9sVqLfYsYbEeUhdalZNtP3zyXSQxJJMb8O1fK
         zFT19QaXpk1CEGVnyaBGMom4Hl/d1K9icRm2/RqgOG1naHK6JuwbErkvYnfjiEAXtDtZ
         GgEg==
X-Gm-Message-State: AOAM533t6l5o1YpIXjwaSufN2UfQA+qcy5gcsc3b1gFXNqgt+FYtlc+m
        cOh1Bj076aX5RF5fr5xQqdbP2ZkJHdNCZw==
X-Google-Smtp-Source: ABdhPJx00yXKDB0CcKZ1Zx5X9m0kVYKDhWQ2GUaHqEN1fHPkW3nFFGSN6N53fqYurbSRHBVD7FQkig==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr31330824wmi.187.1626684712228;
        Mon, 19 Jul 2021 01:51:52 -0700 (PDT)
Received: from antares.. (8.5.4.3.6.6.4.c.b.0.4.b.8.b.e.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4eb8:b40b:c466:3458])
        by smtp.gmail.com with ESMTPSA id 12sm20079763wme.28.2021.07.19.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 01:51:51 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf v2 0/1] bpf: fix OOB read when printing XDP link fdinfo
Date:   Mon, 19 Jul 2021 09:51:33 +0100
Message-Id: <20210719085134.43325-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

See the first patch message for details. Same fix as before, except that the
macro invocation is guarded by CONFIG_NET now.

Lorenz Bauer (1):
  bpf: fix OOB read when printing XDP link fdinfo

 include/linux/bpf_types.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.30.2

