Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244864F6DB
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 02:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLQB6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 20:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLQB5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 20:57:52 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF9BCBC
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:45 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id m4so3994156pls.4
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6LpcEhE9qoiqPb/Ri553SmKdR0xAcJ33drSmPD3l7k=;
        b=l6HyRdStGauuo5XCW7U5dIjjWRiqklmCQk6J2iMuVgp7TmWyB5SSXDI5Skkf3/9o1Y
         1BzCZkeTHOFEwtwBasoS9/eK3pjmm3RaADe9PtygInPa2NNR01XDmE6B8Gm68us3gylu
         2xf7uq9jLLlpJ464eNuBG+sjSbusbS3lYmT1NOGKiwQtUT7Zfw0J3+OgXgksxrOzXxd+
         U2Od1WxzIKZfexnqEI0TkwILPMd0PJ+q+6HHFERav7tGoCatvrIEI1hA1LU4FYwKrGXb
         sSq2Zb0st+89u6V5CGoGhVg5ttZAcZi38M+Zb3Mhk53byTBemaj8QT+jpLWqv/JHUvOg
         o2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6LpcEhE9qoiqPb/Ri553SmKdR0xAcJ33drSmPD3l7k=;
        b=0KUDoGfHs5egZcedzSUmu1PI/DH2QGmf17SB1MzxZmDU+pEBf80poU2dWSAeLEFG5E
         4uW7L6iGafY9frNhALrQ9Rd6sn8eIkB/HbQfIMijoLv0e10I28WeMu8VhYuw+SfZAMYi
         NQKbKnEt3Hx726M0kPgtdMMvCNYZwJDfbalz9sAIIJXVeSXyAkOFB2H35cKxNiKewf+/
         mFvl86l+I5sR56NpHVSxBfq9U6h/2L9FzxCVSbjwXpKVjiUe6+1kmjNTQozki0wcjiG/
         f7TwldiGGkV+h7RjsZlrA/i1tuMmk9hKiUeFQ1PaYb1GQPY9/AnCwaOREKfFTN3s+o2I
         447A==
X-Gm-Message-State: ANoB5plni45bAmPMyu2duM+JJBuhdJo/ijMAGDRLlWA2sm0fKSUWKzgg
        oAzdxZpY+BO/VZq87jtLfNiunVaVmjsprw/3te5x/q7CSJk=
X-Google-Smtp-Source: AA0mqf4P26q/KvQPHf4HpZAflmtNQmO/abwfV5vWX2qAv/uBSylU8uxZseRT+OT9dVgkEYPHxOkZ3Q==
X-Received: by 2002:a17:90a:bb10:b0:21c:f927:f573 with SMTP id u16-20020a17090abb1000b0021cf927f573mr33106583pjr.41.1671242264928;
        Fri, 16 Dec 2022 17:57:44 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a1f4a00b001ef8ab65052sm1924994pjy.11.2022.12.16.17.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 17:57:44 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [PATCH 0/2] bpf-next: Add socket destroy capability
Date:   Sat, 17 Dec 2022 01:57:16 +0000
Message-Id: <cover.1671242108.git.aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the capability to destroy sockets in BPF.
We plan to use the capability in Cilium to force
client sockets to reconnect when their remote
load-balancing backends are deleted. The other use case
is on-the-fly policy enforcement where existing socket
connections prevented by policies need to
be terminated.
The use cases, and more details around the selected
approach was presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.

Notes to the reviewers:
- We evaluated different approaches to allow the
  `diag_destroy` handlers to acquire/skip locks from
  the BPF iterator programs. The commit description
  has all the details. The selected work queue approach
  was discussed with Daniel Borkmann. 
- We previously discussed the possibility of using
  sockmap to store sockets to be destroyed as an
  optimization, so that users may not need to iterate
  over all the host-wide sockets. This approach needs
  more discussion on the TCP side, as we may need to
  extend the logic that checks for certain TCP states
  while inserting sockets in a sockmap. So I've skipped
  those self test cases involving sockmap from the patch.

Aditi Ghag (2):
  bpf: Add socket destroy capability
  selftests/bpf: Add tests for bpf_sock_destroy

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  17 +++
 kernel/bpf/core.c                             |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  70 ++++++++++
 tools/include/uapi/linux/bpf.h                |  17 +++
 .../selftests/bpf/prog_tests/sock_destroy.c   | 131 ++++++++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   |  96 +++++++++++++
 8 files changed, 335 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c


base-commit: 0e43662e61f2569500ab83b8188c065603530785
-- 
2.34.1

