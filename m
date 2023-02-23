Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6DA6A1251
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjBWVxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWVxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:53:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D22A14E
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:18 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u10so14502490pjc.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dJsCeCY3PkrRcC825wKvi02CIl1blnn0UO2S+qZF7U=;
        b=hdFfSLw1jWuwo6PhsVv9op48To405/ckDuDQC6CYHYeVO4IK0dVcDtIzwiiuzbTWoJ
         Q1cuKyL3+STc+wU9cVyE/ZjWcDSlG8zqLwuTWJ/x+3PMY63kVuitaru+qnhpRRcLqNFT
         xWPj+0rHz72dsNbcRuFuZMpJXzEXw67fAbSlxv1wdaE2PGc343sOJPUi2P1za02zGkw4
         kJZYApXoXG+n7KZPAcdrleyyF5jwvEBgFf3tPlHlk1j8BPLWbURG6coMma/MX3Ob3Svz
         ncsZjrxyimHcjElEo73lHdHsR3ATNRr0+IApwrYSkorTg6JF2ZVT3leB27Kj7bs5kd2Q
         3OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dJsCeCY3PkrRcC825wKvi02CIl1blnn0UO2S+qZF7U=;
        b=AgT3j8Kt3P4vwHYiexqoIrvaTtbJ6OqmZtHAHY2jgfQXSCjL4NEd6kDTbHeQMSaY4W
         5hLjTMF/hJwzPGvPPqPFZ2OPBxCbw91iN0WOfyS3w+2xb3cKyL64ojtqibxcQEP4AtSh
         STgRW1iFpAFOLr9TCSZHZv5xAyX8V2pZK5BZYa+rWomW6ApzTXWmr1xIGhb2KJB0SEob
         VcrNzbaFEqmIuvwxwruc1O3WcM5a3hKB+oiq4etlj93ocXV71SM+nqN8vzCZWM/ia8p2
         SBMHnUw0vk1xtro0KdevW5eC2QkxQwIRIGCCJWEs+I1mmKSMO10OssvSMTatkiZvBqPH
         5kAQ==
X-Gm-Message-State: AO0yUKWVHbPhJu7DC0d5e83vArfZX1pSepKse9+mScNxem0knM1c9I84
        KIHbiF2CMwJNIcZeYH2IrBwE/20WffiS/2mh/a0=
X-Google-Smtp-Source: AK7set9I8zKOG3GWLYM2z+DZZR4KRDTs3HJrf0N3bIYrYmVcED7yE1JVInBG0Xo9qYT5Yh5h6pGTFg==
X-Received: by 2002:a17:902:e54e:b0:19a:af54:d814 with SMTP id n14-20020a170902e54e00b0019aaf54d814mr15989915plf.67.1677189197849;
        Thu, 23 Feb 2023 13:53:17 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0019c33ee4730sm8292686pld.146.2023.02.23.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:53:17 -0800 (PST)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v2 bpf-next 0/3]: Add socket destroy capability
Date:   Thu, 23 Feb 2023 21:53:08 +0000
Message-Id: <20230223215311.926899-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the capability to destroy sockets in BPF.  We plan to use
the capability in Cilium to force client sockets to reconnect when their
remote load-balancing backends are deleted. The other use case is
on-the-fly policy enforcement where existing socket connections prevented
by policies need to be terminated. 

The use cases, and more details around
the selected approach was presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v1 patch series - 
https://lore.kernel.org/bpf/cover.1671242108.git.aditi.ghag@isovalent.com/

v2 highlights:
- Implemented batching support for UDP iterator.
- Converted bpf_sock_destroy helper to kfunc.
- Synchronous execution of destroy handlers to
  replace the previous workqueue implementation.
- Updated selftests to use the kfunc.

Notes to the reviewers (further details in commits description):

- I hit a snag while writing the kfunc where verifier complained about the
`sock_common` type passed from TCP iterator. With kfuncs, there don't
seem to be any options available to pass BTF type hints to the verifier
(equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
helper).  As a result, I changed the argument type of the sock_destory
kfunc to `sock_common`. Discussed it from the point of view of the verifier
with my colleague (Dylan Reimerink): the verifier has a `sock_common` BTF
ID for a subset of socket types. However, it may not always be safe to cast
from `sock_common *` to 'sock *', so I added a check for full sock
availability in the kfunc.

- The `vmlinux.h` import in the selftest prog unexpectedly led to libbpf
failing to load the program. As it turns out, the libbpf kfunc related
code doesn't seem to handle BTF `FWD` type for structs. I've attached debug
information about the issue in case the loader logic can accommodate such
gotchas. Although the error in this case was specific to the test imports.

- We previously discussed the possibility of using sockmap to store sockets
to be destroyed as an optimization, so that users may not need to iterate
over all the host-wide sockets. This approach needs more discussion on the
TCP side, as we may need to extend the logic that checks for certain TCP
states while inserting sockets in a sockmap. So I've skipped those self
test cases involving sockmap from the patch. (same as v1 patch)


Aditi Ghag (3):
  bpf: Implement batching in UDP iterator
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add tests for bpf_sock_destroy

 net/core/filter.c                             |  55 +++++
 net/ipv4/tcp.c                                |  17 +-
 net/ipv4/udp.c                                | 231 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sock_destroy.c   | 125 ++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 110 +++++++++
 5 files changed, 522 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

-- 
2.34.1

