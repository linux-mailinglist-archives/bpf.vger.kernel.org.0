Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9936B19F8D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2019 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEJOvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 May 2019 10:51:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54067 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfEJOvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 May 2019 10:51:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so7909773wme.3
        for <bpf@vger.kernel.org>; Fri, 10 May 2019 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6LGGcB7ZoPAoJ3CF1IjStAUcu9/Mb+1LvT//iHSLJhs=;
        b=DLQQWjKiwiTwGj2DwxxjmShlz8xhm2ovlp8+dQkRhT7W6kcvhBO3OnAgikNrcTqt9w
         F7dDKuG8l3mE50AWnFvFsf7vBiLYUkNYq/r6dyqOuX4hhtT40DmusCW9szx4MXy9TWce
         7Vh1qh5RS6gd3Y5J1pEN1cYEO6ic303myPb9Rr8vt94QlbBhG75QIB97nDIcSQ0FQkTQ
         TAWJ8Y9akSRWqCzUujh5BxOX7D71x49Q98Wg9lqrPYj6umojEjH3D9NfPy/nTybGulmP
         6hkKP6PogUGlhJW5pG4DUR4vHCq+f8ENkis4I6+ImQ4VY5hgpvoyZ4kWW6kI2OmyQHQO
         v/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6LGGcB7ZoPAoJ3CF1IjStAUcu9/Mb+1LvT//iHSLJhs=;
        b=owDKIyo0qEqRZRE4a5jxtUR+OLw1oUGDMNNJCoanOnqkPsciQSHPInroM4izu/Oe4w
         J4E9xoyV4BmaKf8wEn2lZTVCSLweH/4BjgZtH3RZ+I36gPmxulWrUuf5YVWc5UK4cud7
         c1y16+Y0YcytNAspkoAbP4vF9qf7fLq6dpW1CEATscXI+jmT3MQz9gJbCcrlfWm2IEoU
         gGSWV60VUCpbwimtG532FST4STbUPMnEZiFIMvck/BCBB08886+KSKUrE3pGMsckcDfk
         Yd6sFSXIM5fxv/LP0NCeRc1fUAQD3ziia99+cM1HpSabNaDlXfI/wyEmmVh5h6aNIj8Z
         oOlQ==
X-Gm-Message-State: APjAAAU0chEbUes3fkYWy5NsWXG7oBN5YRKltUy4421HGHcKJyRN/62S
        goXnBSkgNmtTTF3VVnDa66BVdw==
X-Google-Smtp-Source: APXvYqyh6upZS93umpI5UrYbS8EhdgsUkxY5yhuViGPT+LDNS7iXSt9BqZfXOZvA1t9bYjdNYTsEDg==
X-Received: by 2002:a7b:cb85:: with SMTP id m5mr7598655wmi.75.1557499897880;
        Fri, 10 May 2019 07:51:37 -0700 (PDT)
Received: from reblochon.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p17sm7561027wrg.92.2019.05.10.07.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 07:51:37 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 0/4] bpf: fix documentation for BPF helper functions
Date:   Fri, 10 May 2019 15:51:21 +0100
Message-Id: <20190510145125.8416-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.14.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Another round of fixes for the doc in the BPF UAPI header, which can be
turned into a manual page. First patch is the most important, as it fixes
parsing for the bpf_strtoul() helper doc. Following patches are formatting
fixes (nitpicks, mostly). The last one updates the copy of the header,
located under tools/.

Quentin Monnet (4):
  bpf: fix script for generating man page on BPF helpers
  bpf: fix recurring typo in documentation for BPF helpers
  bpf: fix minor issues in documentation for BPF helpers.
  tools: bpf: synchronise BPF UAPI header with tools

 include/uapi/linux/bpf.h       | 145 +++++++++++++++++++++--------------------
 scripts/bpf_helpers_doc.py     |   8 +--
 tools/include/uapi/linux/bpf.h | 145 +++++++++++++++++++++--------------------
 3 files changed, 154 insertions(+), 144 deletions(-)

-- 
2.14.1

