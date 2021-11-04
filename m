Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC14452E7
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhKDM0D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDM0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 08:26:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF7C06127A
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 05:23:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o14so8265346wra.12
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDAfluk/2X7+fmQG4qXn6RJudeE3seAt4NVyCikCy4s=;
        b=C5+NoGXw4ACviHJJ7p1MEBpfq8KXpKqqzLzMTM5nmbIHdcGUx20GaTVsHmt6ctfmNz
         FiA/OKmz/eVd0XHl0VLA5IuQbYzfLnzcdo7a5dOOAXiY4+xHityIMDUr75GTtF7kmzgB
         mJCnJaNxVHZvtPF1UtTSQefVxutNSb87mPYGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDAfluk/2X7+fmQG4qXn6RJudeE3seAt4NVyCikCy4s=;
        b=kfSUdcElN0TCFhMksiyAMIWPTlxh+CkEF0AOUL+buO/0yPLDBg5hK+dMRdz5PlMuI5
         T+L9uEdnQEh8NLgJ9qUO1rrYlZmDxMDuWisXa74hJO5fI3mmPeNED/2abdiJ9gBAlAZX
         cDUAvvrLdTXmPWtwjLixRpz4rK45bGlfafBAGS3A0E78npBcQxsmVZo9YSd1daIN6jow
         7Otjxpp08HpKbnxLiK4Kdzkt7V1ZG/efM6AwcL8X16I4gm/In1lIC2Ppf4uWDrYgveiY
         fdwZtECRi4Ax0PHxXrWNm3+AuWYfwiqSB+mq1QhMRngRsSboBajNEF8jQxTYvESTwX2X
         oY6A==
X-Gm-Message-State: AOAM531SPNRdUO31NXxnQ/iwhMuZrO09YXsOYmEVbmpzES8/IZwKoi4i
        mKizTNTBJOPQ/AluAb16TqEv6Q==
X-Google-Smtp-Source: ABdhPJw0sF2DN67/muAaWG6N5jp7kSqIfCN11j8MKhChoKZVI1dD8FdJexi4/Qqd+/KtnUa330ucCQ==
X-Received: by 2002:adf:9dc1:: with SMTP id q1mr65116565wre.13.1636028603491;
        Thu, 04 Nov 2021 05:23:23 -0700 (PDT)
Received: from kharboze.dr-pashinator-m-d.gmail.com.beta.tailscale.net (cust97-dsl60.idnet.net. [212.69.60.97])
        by smtp.gmail.com with ESMTPSA id a4sm4797535wmb.39.2021.11.04.05.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:23:23 -0700 (PDT)
From:   Mark Pashmfouroush <markpash@cloudflare.com>
To:     markpash@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] Get ifindex in BPF_SK_LOOKUP prog type
Date:   Thu,  4 Nov 2021 12:23:02 +0000
Message-Id: <20211104122304.962104-1-markpash@cloudflare.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_SK_LOOKUP users may want to have access to the ifindex of the skb
which triggered the socket lookup. This may be useful for selectively
applying programmable socket lookup logic to packets that arrive on a
specific interface, or excluding packets from an interface.

v2:
- Fix inaccurate comment (Alexei)
- Add more details to commit messages (John)

Mark Pashmfouroush (2):
  bpf: Add ifindex to bpf_sk_lookup
  selftests/bpf: Add tests for accessing ifindex in bpf_sk_lookup

 include/linux/filter.h                        |  7 ++--
 include/uapi/linux/bpf.h                      |  1 +
 net/core/filter.c                             |  7 ++++
 net/ipv4/inet_hashtables.c                    |  8 ++---
 net/ipv4/udp.c                                |  8 ++---
 net/ipv6/inet6_hashtables.c                   |  8 ++---
 net/ipv6/udp.c                                |  8 ++---
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 31 ++++++++++++++++++
 .../selftests/bpf/progs/test_sk_lookup.c      |  8 +++++
 .../selftests/bpf/verifier/ctx_sk_lookup.c    | 32 +++++++++++++++++++
 11 files changed, 101 insertions(+), 18 deletions(-)

-- 
2.31.1

