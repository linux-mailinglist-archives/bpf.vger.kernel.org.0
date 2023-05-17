Return-Path: <bpf+bounces-803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183270700C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCAE1C20EC5
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02F31EEE;
	Wed, 17 May 2023 17:54:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D710966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:54:13 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA7BE
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:54:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643ac91c51fso837968b3a.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684346051; x=1686938051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t4NjfY4eRu8ZnM3Sb2TFxKjNoWj0dPMVvfKJIDWs30=;
        b=SPMHgNAHqvx9luoQv6iCawcq+snwc8k0loRrHkDQXsdHuIg2AwqBfpX01yD8u3d0/n
         uRAwnLngfE081AMjcvjVX6xaywB5DCjx0Vl+JXl6hJBhBHAAefpyWAvXmVR+qn3CC287
         jauIa6GQqbFFndvJTbCajZisB6CdUYHpCr6uaktlvtvrRle/xd9e6E6ZBBSPbo0Y2s6V
         upZYAzyXmWukAvnqXA16C6EcBahsaDjctc+ThIras+pwfd+k/JJG5AKPDUkR8cgMYR4H
         b64LEl0Y3chk07X66eDyvRDz+m3aM0HKEp27frUJ/ZJh+wQ1gvodd0jKDzdTaEpRVykf
         LvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346051; x=1686938051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t4NjfY4eRu8ZnM3Sb2TFxKjNoWj0dPMVvfKJIDWs30=;
        b=mB8Fr7DrQM0LyDliQZXeB749d5WsnGz50pQ4Z6rYlOc+fD9Gutg6qHD4nDVl5EVqZV
         vgppRFP9McwMOoFYupcrQF3G6vE/z96drRHlLIlizAAnyN50E9lsWO8hKXUY3bTkuvKK
         REZvDzpdFw+c2qMq9MOofentKX4VLLOmQ22A0fTy+GiVz2qRVpySwQex30iZ1Ti9deAG
         hEY4W5ERTF1Rhlw+oVNJVkznM2LNwaA1qXDzTlYUP33dry3Q6Uy6BjkoX9IUdYtVY483
         CxnUM/Hd7zmGtEqsxKN+ceshYq8Fa1qm2GE0haM4lzQth3Gbgg8AHKB5vREv6geCUi8M
         vBEw==
X-Gm-Message-State: AC+VfDy1Ko/eTO+3LPNYLY/0nZd9AAVt7NKAeSIZA246T1gdDRbPsbVv
	plCAyVylXU6zZO9ACXDErSPmOBSDQnTNxGPrF9w=
X-Google-Smtp-Source: ACHHUZ51QVgZyZllohT2SlmBAq6/pQ8u80hXRg4EcGNNrSUNhVAwChp8Fy616bEzqhM2VPGkOTvBcQ==
X-Received: by 2002:a05:6a20:6a0c:b0:106:70af:a5ca with SMTP id p12-20020a056a206a0c00b0010670afa5camr12799718pzk.38.1684346050690;
        Wed, 17 May 2023 10:54:10 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id a9-20020a63e409000000b0050376cedb3asm15717830pgi.24.2023.05.17.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:54:10 -0700 (PDT)
From: Aditi Ghag <aditi.ghag@isovalent.com>
To: bpf@vger.kernel.org
Cc: kafai@fb.com,
	sdf@google.com,
	aditi.ghag@isovalent.com
Subject: [PATCH v8 bpf-next 00/10] bpf: Add socket destroy capability
Date: Wed, 17 May 2023 17:53:59 +0000
Message-Id: <20230517175359.527917-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set adds the capability to destroy sockets in BPF. We plan to
use the capability in Cilium to force client sockets to reconnect when
their remote load-balancing backends are deleted. The other use case is
on-the-fly policy enforcement where existing socket connections
prevented by policies need to be terminated.

The use cases, and more details around
the selected approach were presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v7 patch series -
https://lore.kernel.org/bpf/20230503225351.3700208-1-aditi.ghag@isovalent.com/

v8 highlights:
- Add missing ifdef to preparatory commit removing bpf_seq_afinfo as
  Reported-by: kernel test robot <lkp@intel.com>
Address review comments:
Martin:
- Applied trusted arg changes to the bpf_sock_destroy kfunc patch.
- Rename kfunc filter set to a more generic name
- Minor selftest changes 

(Below notes are same as v7 patch series that are still relevant. Refer to
earlier patch series versions for other notes.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.

Aditi Ghag (10):
  bpf: tcp: Avoid taking fast sock lock in iterator
  udp: seq_file: Helper function to match socket attributes
  bpf: udp: Encapsulate logic to get udp table
  udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
  bpf: udp: Implement batching for sockets iterator
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add helper to get port using getsockname
  selftests/bpf: Test bpf_sock_destroy
  bpf: Add kfunc filter function to 'struct btf_kfunc_id_set'
  selftests/bpf: Extend bpf_sock_destroy tests

 include/linux/btf.h                           |  18 +-
 include/net/udp.h                             |   1 -
 kernel/bpf/btf.c                              |  59 +++-
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  63 ++++
 net/ipv4/tcp.c                                |   9 +-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/udp.c                                | 291 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.c |  23 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 221 +++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 145 +++++++++
 .../bpf/progs/sock_destroy_prog_fail.c        |  22 ++
 13 files changed, 789 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

-- 
2.34.1


