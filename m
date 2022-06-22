Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EECA55527B
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiFVRfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFVRfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:35:16 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581031DC3
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:35:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 36E94240107
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655919314; bh=mYyAa7FCIS55o8JzNfscv400IF6tVUjmn8DRy0+c6H8=;
        h=From:To:Subject:Date:From;
        b=LhEMkNFoPlfR68pkvT89FUcXPIsu298ntZRGj37taTDcM70jtEy/C3lgp9OprnEaw
         ZRtQEu3+aRobLNTRTKFXPQZupD6Ppzekcib61yk71B2ssMxnCqnybua+GHfpicHGgZ
         gCXrI+4xleCIfc7j2cu8hkK5xxayQlZfmjwNRiRRKxEJdw0jASQqTrT3qXag/wrCrJ
         8Y7iSZkEyx5uDhKCdBtPTK3ko022z/rsav89jKEGoo6kEPFH3lpboDBDbP3UE9c5rQ
         RiO1IWx0wa9sYM/fBvKb4LIJebbMNEIwJOYdN3EcHCJxgO82ArrMqjc/4TjhzE7AHn
         4SeZOCkVRN6aQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSrB93Jkcz6tmW;
        Wed, 22 Jun 2022 19:35:13 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 0/2] Deduplicate type compat check
Date:   Wed, 22 Jun 2022 17:35:04 +0000
Message-Id: <20220622173506.860578-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF type compatibility checks (bpf_core_types_are_compat()) are currently
duplicated between kernel and user space. That's a historical artifact more than
intentional doing and can lead to subtle bugs where one implementation is
adjusted but another is forgotten.

That happened with the enum64 work, for example, where the libbpf side was
changed (commit 23b2a3a8f63a ("libbpf: Add enum64 relocation support")) to use
the btf_kind_core_compat() helper function but the kernel side was not (commit
6089fb325cf7 ("bpf: Add btf enum64 support")).

This patch set addresses both the duplication issue and fixes the alluded to
kind check.

For discussion of the topic, please refer to:
https://lore.kernel.org/bpf/CAADnVQKbWR7oarBdewgOBZUPzryhRYvEbkhyPJQHHuxq=0K1gw@mail.gmail.com/T/#mcc99f4a33ad9a322afaf1b9276fb1f0b7add9665

Daniel Müller (2):
  libbpf: Move core "types_are_compat" logic into relo_core.c
  bpf: Use bpf_core_types_are_compat functionality from relo_core.c

 kernel/bpf/btf.c          | 86 +--------------------------------------
 tools/lib/bpf/libbpf.c    | 72 +-------------------------------
 tools/lib/bpf/relo_core.c | 78 +++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.h |  2 +
 4 files changed, 83 insertions(+), 155 deletions(-)

-- 
2.30.2

