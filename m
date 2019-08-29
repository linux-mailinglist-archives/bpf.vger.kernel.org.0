Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729C7A19AF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH2MOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 08:14:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37689 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH2MOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 08:14:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so3614890wme.2
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os50tJaD6JiIScbeHUb8bjC8gU2Z5LBOEuQJiCs0Ppg=;
        b=R27KJbqPozFLviKeyFVZG/il1c+C0c2fe3FyYbVx+S4AcjOPbgmAvWTdgEQIfAHxFQ
         Rds0wKmxh+YsFmmNIxc8eyC+J99oaxKQ/Di/sQaDDhjPhVPae3lptuCqvFKtg/xJnnd0
         5d2Q/cczOeZzaRbdOzNHNKV+3Mp5dqusENmJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os50tJaD6JiIScbeHUb8bjC8gU2Z5LBOEuQJiCs0Ppg=;
        b=kZBflQoHbXfOAcPDfs+7ErOJtthHUSwOztSHWMC8bQ+LAAUsMjaYxpfmOfo7bYcdXq
         eQzhbsTaZUvMJDDTt6miTfZBxnbqxYWdcgjDcShcj2wQWQrTcieQJs9zm9CtLFTF8c2M
         Do3siAmaqaZ/5o8eBGsuzzutCvKhaeRfTz3yXUcSlXhxvEteJXjo0krckQoaEIO2bKdz
         duAKMHToStk2nvoXf1eXbV6Fo+IHjSHlY/cFtku8ANQaYdp8LKE5PFgmll3CbldikgZb
         p0ODyxMaHj83T5MJ0uxIB2Eanad4Cs80lTYnzUu3p3J4hX6FBS1D6tBMg9wA8CsCh3mT
         kSAQ==
X-Gm-Message-State: APjAAAW/5rjgNkhFWlJVyeLUfBTGgDQEzCzKPHFCvdN3UjmFhChHR4EJ
        2iKeix23pKRHHWRHxf3mEPlBRg==
X-Google-Smtp-Source: APXvYqw7WlWFLquG2dwRQVUU37lKtIC7Eey6K70D8th18SD4p3Fb1mUUmx2piO45/Ek8FV+XBqJDQg==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr11171221wmu.76.1567080846118;
        Thu, 29 Aug 2019 05:14:06 -0700 (PDT)
Received: from localhost.localdomain (bzq-82-81-225-244.cablep.bezeqint.net. [82.81.225.244])
        by smtp.gmail.com with ESMTPSA id b3sm3696183wrm.72.2019.08.29.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 05:14:05 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] test_bpf: Add an skb_segment test for a linear head_frag=0 skb whose gso_size was mangled
Date:   Thu, 29 Aug 2019 15:13:42 +0300
Message-Id: <20190829121344.20675-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following reports of skb_segment() hitting a BUG_ON when working on
GROed skbs which have their gso_size mangled (e.g. after a
bpf_skb_change_proto call), add a reproducer test that mimics the
input skbs that lead to the mentioned BUG_ON as in [1].

Currently, this new test *INDEED* hits the BUG_ON, therefore the final
patch is to be applied only after skb_segment is fixed.

When changing the gso_size of the test skb to its original value (+20
bytes) then the test passes successfully.

[1] https://lists.openwall.net/netdev/2019/08/26/110

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Yonghong Song <yhs@fb.com> 

Shmulik Ladkani (2):
  test_bpf: Refactor test_skb_segment() to allow testing skb_segment()
    on numerous different skbs
  test_bpf: Introduce 'gso_linear_no_head_frag' skb_segment test

 lib/test_bpf.c | 112 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

-- 
2.19.1

