Return-Path: <bpf+bounces-1218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CE710A72
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 13:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3A1C20E8C
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82297FBEB;
	Thu, 25 May 2023 11:01:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED62DF55;
	Thu, 25 May 2023 11:01:20 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A013139;
	Thu, 25 May 2023 04:01:18 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1q28iZ-0004iR-Gf; Thu, 25 May 2023 13:01:15 +0200
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	<netdev@vger.kernel.org>,
	dxu@dxuuu.xyz,
	qde@naccy.de,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next 0/2] libbpf: add netfilter link attach helper
Date: Thu, 25 May 2023 13:00:58 +0200
Message-Id: <20230525110100.8212-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When initial netfilter bpf program type support got added one
suggestion was to extend libbpf with a helper to ease attachment
of nf programs to the hook locations.

Add such a helper and a demo test case that attaches a dummy
program to various combinations.

I tested that the selftest fails when changing the expected
outcome (i.e., set 'success' when it should fail and v.v.).

Florian Westphal (2):
  tools: libbpf: add netfilter link attach helper
  selftests/bpf: Add bpf_program__attach_netfilter_opts helper test

 tools/lib/bpf/libbpf.c                        | 51 +++++++++++
 tools/lib/bpf/libbpf.h                        | 15 ++++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../bpf/prog_tests/netfilter_basic.c          | 87 +++++++++++++++++++
 .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
 5 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

-- 
2.39.3


