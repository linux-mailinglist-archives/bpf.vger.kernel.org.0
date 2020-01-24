Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AADE1482AD
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbgAXL3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 06:29:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42194 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404108AbgAXL3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 06:29:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so1538267wro.9
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNXqjFOyvU9j2Jqn1MWNzHVe1R1QvmONATv+pJ3Zxyc=;
        b=DUR7ANm7sruhqxj6zZqkEzpuc+jgRQuKtezD7dfdKZWi6Sh13LCdyNMr/Y2RTmolRH
         g3N3gflUql/zwGRZCsnZNk8sky1CZ6ovocUxwg6UKAklkMlBT2vNuCsHp5P3zGxSVbko
         ++DvBxyZRoF3MRzE9wIyq0EcLgZ7voMmMMmdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNXqjFOyvU9j2Jqn1MWNzHVe1R1QvmONATv+pJ3Zxyc=;
        b=A80v+przvZP/DjaRRtJhLrTyXRuBeTE/yfET3PM4vYEx+ltGG14KxyF2gCZSGWhVBH
         rcpZ7eyZeW60oVx1QmQY/h19k2xFLWBAs9qToxnKKat5QLkrTrAi/FnSKVL957+dR9Dd
         RVO8E71lo0xLm2kj8Gd0BuFy6G0JffWG6z7khita5KKvZBTE3jCQYNt0kg/4uGo1oNrr
         CkQrLzDSYDeeDbEzWUIJr9726A+2Mt/Dj60J6r2/l9i4onp4ObwplSkV6j8bH+GJ06wS
         LInzZ5PJ12unjMXdrO/FCLLe/0JX3bGwiURn9OGyUhR/zo4ZyquQ6hjLT6iGN8X3+at4
         idAQ==
X-Gm-Message-State: APjAAAWbMgmdNR2XG1gZ1PdWOOTuLcHoKANqPJIbquZVRKyRZEwocMLp
        Yvf5kDt28FvgY/FMPwuxU/3oDA==
X-Google-Smtp-Source: APXvYqwRCZBeSAM05fpFjX7SIG+fal+e0deBo23ZtxBrk6v29OLg5dLEDaDPMpj+bf4fEm5iALCnWQ==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr3879847wrn.239.1579865390154;
        Fri, 24 Jan 2020 03:29:50 -0800 (PST)
Received: from antares.lan (3.a.c.b.c.e.9.a.8.e.c.d.e.4.1.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:614e:dce8:a9ec:bca3])
        by smtp.gmail.com with ESMTPSA id n189sm6808688wme.33.2020.01.24.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:29:49 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Various fixes for sockmap and reuseport tests
Date:   Fri, 24 Jan 2020 11:27:50 +0000
Message-Id: <20200124112754.19664-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've fixed the commit messages, added Fixes tags and am submitting to bpf-next instead
of the bpf tree.

There is still the question whether patch #1 needs to preserve O_RDONLY, which John
can hopefully answer.

Lorenz Bauer (4):
  selftests: bpf: use a temporary file in test_sockmap
  selftests: bpf: ignore FIN packets for reuseport tests
  selftests: bpf: make reuseport test output more legible
  selftests: bpf: reset global state between reuseport test runs

 .../bpf/prog_tests/select_reuseport.c         | 44 ++++++++++++++++---
 .../bpf/progs/test_select_reuseport_kern.c    |  6 +++
 tools/testing/selftests/bpf/test_sockmap.c    | 15 +++----
 3 files changed, 49 insertions(+), 16 deletions(-)

-- 
2.20.1

