Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A999D2D9B8
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfE2J5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 05:57:20 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37346 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2J5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 05:57:20 -0400
Received: by mail-wm1-f41.google.com with SMTP id 7so1131794wmo.2
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WtceIj/KY1G89Cy1WuUs0iyj8MQlkaannIjT1i86qC8=;
        b=tquf3Yp2XDRv0gKp6e6dcHjco4/sfwdojT4JMaNRe1HkvECbwFFWIQgxkD0AzMGl0/
         lDMin4ZuGvBd/BJrlXigo3yjL7ZUlRc7lbbHEAP8PpU+RUr37cHg+jndbPlwL21CKFMf
         eqlwil9dbNIeNnIjcdG+4Fqgz+6KfXvrRzqU/9yfJLaoczwh6fIAGIsNso1Um478qXc6
         7VcAD/tT5wMF4pOoXJtP/IafHro9e0qnGK8UTbwq/8f4tcrYz0l6wQ3U/VUbhEQUpXey
         Dlx8Qv3v5X2ygNc1aIZ92vRPX1UQ5MB5IzQkCko8/hsAvevxrRgQQ2HdRMU5X6fpXc1j
         kc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WtceIj/KY1G89Cy1WuUs0iyj8MQlkaannIjT1i86qC8=;
        b=UrXfakV8KD5fGS57cEhhWv2437wvJULz5vHXy2sk7jWQ2BilIrvkM40T9GnkM6xtEw
         nz5o987kqTkDg1UznlbsURzmNqKoLCtVvA7ayWCwBRFEfOdUH9ouyb3f3npHCBqnvFaU
         PluI1ukaZ+ndjWgDRrk0z63nxW6kpVyfJNvenJEEhzTx1fRAFlzPim1Mli++/hBRNnCb
         c5auzaXaYNHtoL9ze5Q0KtpRMsXUFUIDQr9PmDyspXI4fmmSMJaBSOG7D684b14PKgDK
         +LHTT11/wSL8mH8QPP0NFthcvemJ1XGe8cVr5ACjC7CsqulxiBdqNv+ugXWIFz3oe8LL
         qHIw==
X-Gm-Message-State: APjAAAWGquOLU4p5NKywpcxq1QPYyvz23/MMAWo1xWqFGC5t/EwdYoEU
        DVyddpioSCSNLYGfeBydn/wSjQ==
X-Google-Smtp-Source: APXvYqxUaZf66I3CHwHxyakct1m9Y9764nP797GZiAuiK1708akn0V7lDzhf1lqhQFzXizmcfRlbcQ==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr6500572wml.45.1559123838302;
        Wed, 29 May 2019 02:57:18 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 205sm6322206wmd.43.2019.05.29.02.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 02:57:17 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bjorn.topel@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH bpf 0/2] selftests: bpf: more sub-register zero extension unit tests
Date:   Wed, 29 May 2019 10:57:07 +0100
Message-Id: <1559123829-9318-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

JIT back-ends need to guarantee high 32-bit cleared whenever one eBPF insn
write low 32-bit sub-register only. It is possible that some JIT back-ends
have failed doing this and are silently generating wrong image.

This set completes the unit tests, so bug on this could be exposed.

Jiong Wang (2):
  selftests: bpf: move sub-register zero extension checks into subreg.c
  selftests: bpf: complete sub-register zero extension checks

 tools/testing/selftests/bpf/verifier/basic_instr.c |  39 --
 tools/testing/selftests/bpf/verifier/subreg.c      | 533 +++++++++++++++++++++
 2 files changed, 533 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/subreg.c

-- 
2.7.4

