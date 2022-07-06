Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBC569454
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiGFV3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 17:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiGFV3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 17:29:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D501EADA
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 14:28:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AB454240029
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 23:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657142937; bh=SeBg86NAwSY3FrGJNKC0samC58A1WFwR4OjhiPQWBFs=;
        h=From:To:Subject:Date:From;
        b=JZrBWZ2JA8cKZZAc0+Z/koygz9RRZfCVKJ2EiZIKBa3N/zJY1Aypvj/crlZdhGAbf
         F6L/f8qX5PqqzAAJ7qkshz/h2iRmjyoeoIvrZUAoJCbzCUUKWqruvvJuuO0xoP4TT6
         3G3OIyeDYuCCD5o3HcXIG6DV/SumA1Nxu6aijNU3aITHN6crI/aK8I+zAZgL0K/gQG
         g3MSWkSoHD4mCg0eKbGdbO8vpem4rDFVGNWnSXVqrO2/s90lJ5y/8TmBxebgL50rj6
         jAZf+G8nNkVbmblPozk1DTWjfDrsEOu0w4ftz9B5kM5LzAkGCaZNb9dbi7UHk7EYDb
         fmteOIcyjrQgg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LdXjN6922z6tmQ;
        Wed,  6 Jul 2022 23:28:56 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, quentin@isovalent.com, kernel-team@fb.com
Subject: [PATCH bpf-next 0/2] Add KIND_RESTRICT support to bpftool
Date:   Wed,  6 Jul 2022 21:28:53 +0000
Message-Id: <20220706212855.1700615-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As pointed out in an earlier discussion [0] not all paths in bpftool's
minimization logic handle the restrict type qualifier properly. Specifically,
the gen min_core_btf command fails when encountering the corresponding BTF kind
for a TYPE_EXISTS relocation (TYPE_MATCHES support was added earlier):
  > Error: unsupported kind: restrict (26)

This patch set fixes this short coming.

[0]: https://lore.kernel.org/bpf/20220623212205.2805002-1-deso@posteo.net/T/#m4c75205145701762a4b398e0cdb911d5b5305ffc

Daniel Müller (2):
  bpftool: Add support for KIND_RESTRICT to gen min_core_btf command
  selftests/bpf: Add test involving restrict type qualifier

 tools/bpf/bpftool/gen.c                                   | 1 +
 tools/testing/selftests/bpf/prog_tests/core_reloc.c       | 2 ++
 tools/testing/selftests/bpf/progs/core_reloc_types.h      | 8 ++++++--
 .../selftests/bpf/progs/test_core_reloc_type_based.c      | 5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.30.2

