Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA0597E94
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiHRGYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiHRGYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 02:24:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933A65541
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so617295edd.13
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jfD7yUJlEL3HzXF3mBCExbxnGVX+Pkut5lkuA4Cn4pI=;
        b=RmNS//7e1zQOObkQOib4V6y0cz8ZVbk0ca/rrA8nEtxmdVNSpyUHbWaVXq+dBuNnA/
         jnRporF2NCyv2WKNRQ6ehz10/1p5zEFxfI/w816rsY0YbpudXAfRYWLt0ZJwb6TbxrF+
         bURLhzedJiGofjeHVQ7uXyHfqs3j0HdXhDN2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jfD7yUJlEL3HzXF3mBCExbxnGVX+Pkut5lkuA4Cn4pI=;
        b=cA9YSbWstWjivZroM3uPZPTk1Pnqfblaa2NhJXInTSJGnSVv+qnJ+mSor5st7GG1v8
         4oPx70Fhh7/4AFxlNf3uGWjRpVpem5RS2ClpH6fZ5EjSZ7YAO5kCK4EL/1smMjJhO5Xx
         1X4LI/khcTCHdTkgCEN+G0GhW6e3hDGbRelF4vA2mQUKJTiPUqQl3+Se5HEMd3Y0a8n3
         KgcfGgZbW49NiY2tbyrg0fG1pLx/f0t6bp0tzhBce3Bame3wp5moqv6KfyZcZ0+zHqRc
         TIvufJi9cEyZap21zWEQRmzWg9BqBZ6xxvthl3K+MRpn5a+0xJjgH//ve7zjyEsnQ0lb
         7SRA==
X-Gm-Message-State: ACgBeo3OXN76sWtOGEdtdk+rnGD2woZ9yTJWfUhpjwRxjs+HgASv1Osm
        P3boxjHqgwjyoik304PJAISsYmg0/lhDT2j6hcmqSY6KEiOrF1d3rA5n5AA/Kq0L18N4ggEYOd8
        9i3MuAuq7P9NwDuPOVVc0ivq3Hykdg54mLAqFw1Si5bBdot46redZmj9M6mp4KUzbyM1fF+/K
X-Google-Smtp-Source: AA6agR49jOfwRfqQkgsSZs4X4oRNDaohCBlOZcVwTdm8n7mXo2CXEf6PDSuMDQklLml0OHHhCo3KQg==
X-Received: by 2002:aa7:c790:0:b0:443:a086:6877 with SMTP id n16-20020aa7c790000000b00443a0866877mr1096967eds.84.1660803862096;
        Wed, 17 Aug 2022 23:24:22 -0700 (PDT)
Received: from localhost.localdomain ([141.226.169.165])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7cf0b000000b0043bc19efc15sm535263edy.28.2022.08.17.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:24:21 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 0/2] flow_dissector: Allow bpf flow-dissector progs to request fallback to normal dissection
Date:   Thu, 18 Aug 2022 09:24:03 +0300
Message-Id: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
replaces the flow-dissector logic with custom dissection logic.
This forces implementors to write programs that handle dissection for
any flows expected in the namespace.

It makes sense for flow-dissector bpf programs to just augment the
dissector with custom logic (e.g. dissecting certain flows or custom
protocols), while enjoying the broad capabilities of the standard
dissector for any other traffic.

Shmulik Ladkani (2):
  flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
  bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for
    flow-dissector bpf progs

 include/linux/skbuff.h    |  4 ++--
 include/uapi/linux/bpf.h  |  5 +++++
 net/bpf/test_run.c        |  2 +-
 net/core/flow_dissector.c | 16 ++++++++++------
 4 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.37.1
