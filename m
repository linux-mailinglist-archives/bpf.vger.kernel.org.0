Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D982555CF2
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFZAi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 20:38:57 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52772 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZAi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 20:38:57 -0400
Received: by mail-pg1-f201.google.com with SMTP id a13so410579pgw.19
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cALMpl1zhJhWyFsIJDuEGXPsZBtZwwHf9RNESh/DFIw=;
        b=q6HF3nqqskhjv+PSJGKOWHW3tR81pXc8EAsARsWrFtWfpmOTBajscuH3kgWx7gTq88
         UscPLsQhLExTfPPb8s8o9eux2AyHu5J31jpIYk81/O8PBTuJbE1/CuA1Quq37WkVBNVL
         Mu+rAsKAh64Fh4K1xmweEiFKJ7qkiDN4VPhJR9ERhv1h0yhwy38SHbCIQbowZ76CEnyI
         Y1+OIb7ZLCdVNWy50zvvroF+R+QJQszp9jsRnW6Nsr+meEuzcJaH9FMiZj0I6pZKbwtI
         4+1gekk3WxjZGND8TJx+/OMxg0HCBgreCjddGO+lzbO+NQRXoimoOWfXso0vFX4cUlnM
         wzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cALMpl1zhJhWyFsIJDuEGXPsZBtZwwHf9RNESh/DFIw=;
        b=gBmIjhsoBNh8Pyftg87d67jPw1K0ZAylKOKYJgOmdIsK+wmygnhdziSfBkx3CoRqWi
         4GVzhxmIwQvomfiTO5xxdNj+pShdQL+nk7trbFn7qI9p1ubpDwZVi2RApvEdRxhWiTEJ
         lM4Hws0SZ9v9Brn4j5X8zap7DT9YKvvpMeZCup0968AD/kb4PZ0ZNQffDvrguW8cO9nf
         FI/xHEPi90wzIN75TIaSk9n35gnF6lW8pXEyp6q/UqjPWznyPODD89CXKTYxf6lhZBFT
         GM2Lst56XleCl8HMLn0g9Jesilx1QiDaSEysk2BRDxqvDNqXtvRcQtjlYzP/XpaSTKiD
         gYHg==
X-Gm-Message-State: APjAAAXF0Zld3HBQC4y3NNyTPgjLz6+LhCHSLFLyj2tTJjmar3Frw23K
        E8IEnwg2/ysGf4pDb2z7Z9VnGSGrxyw6H/Qo
X-Google-Smtp-Source: APXvYqzsBFKGyDA2PqihhPpY6qxeUko0GVwQrfcpv5JxGJZAQguRpfdHPmcPJcuQET+xrL6DT6lvDvFz9BDkRC7U
X-Received: by 2002:a65:6102:: with SMTP id z2mr40322232pgu.194.1561509536303;
 Tue, 25 Jun 2019 17:38:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 17:38:50 -0700
Message-Id: <20190626003852.163986-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 0/2] bpf: Allow bpf_skb_event_output for more prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

More prog types are enabled to access bpf_skb_event_output in this
patch.

v2 changes:
Reformating log message.

v3 changes:
Reformating log message.

v4 changes:
Reformating log message.

v5 changes:
Fix typos, reformat comments in event_output.c, move revision history to
cover letter.

v6 changes:
fix Signed-off-by, fix fixup map creation.

allanzhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 12 ++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

