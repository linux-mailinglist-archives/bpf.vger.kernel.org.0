Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E687251F59
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfFXX50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 19:57:26 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53981 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfFXX5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 19:57:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id w22so1359579pgc.20
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=txqvv/NrWF2r2ZYnikxukD/ZTGTxdxrEpeeOGHmXwj72GqxK2ht2VzPh7WQDvUOEvx
         fveeS03789E660Df7NgYySiBMq0CKfnt0FGrf+j0Ccn2Q8q1SUPKjPckd0zwOvi2S8Lm
         fTMZHhPZ2Rt4so+75FNenrstI74oZ231YwcoLAzFNzkScr9l99sN5uLzDadIRInd/sy2
         zSq3KdMgHT8SZI65hzgk0sGSFKdjTir5r+KZ4MDS5SoytMFRCAKJvHNZ7XT6h/cp2iDF
         HHPsjszn23XpCFmfrSA9dnk+MoClS1XLMfyLf3IfmKNR0qOJoAYvyKcGSTMGcqqvcYiJ
         pHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=ggJKwZI1u4Csq3EqE6DIpghU3faR+s3XLp0UmZWcPKkxHprhlVpk7dOvRGxLNwfZxq
         fcN1RObj+yk81WXtEq74ehZviAWR02JdA5u6AWyq2U0O9l5ORAyLisGmEt+FT9K6MOaf
         CeW9dI1350LQ5b7LZsBfiSxmn9+qDyI8kUtPAev1zgtDV8CEw+EjfRolNxdUwmvrk5ZH
         DSWKDPXqZVm/CK8U7hUihYU3d4SqajCQox36VaUvNktDMtQqPlfRvMoAHpdyx4kkjWJH
         lcr2pDP3tEOtFymJLWkE60DKKlvz78dddbUxzyL+T6xlbiJGxp64kxA5UXb6Zev02bwW
         HIzw==
X-Gm-Message-State: APjAAAWoffyfHyoQhuCCyihUXz9mP6cfDrgqW0XmGN/3UfGGe/eF0nfW
        TvY9Ovavp8gstzt0T0Q8tY29MR6kUPOCmBsk
X-Google-Smtp-Source: APXvYqyVAz/J7JuE9xSQrMGwuqiw5jvMqJF2PJiivFk2FjhFS9d/dVj1l146q2/pkut1R0tC6xATSgINoHjQjykI
X-Received: by 2002:a65:560f:: with SMTP id l15mr12290186pgs.94.1561420645035;
 Mon, 24 Jun 2019 16:57:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:57:18 -0700
Message-Id: <20190624235720.167067-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/2] bpf: Allow bpf_skb_event_output for more prog types
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

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

*** BLURB HERE ***

allanzhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 33 ++++++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

