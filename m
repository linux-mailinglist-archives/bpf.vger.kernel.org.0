Return-Path: <bpf+bounces-5663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960575DA32
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 07:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAD28248A
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D48C14;
	Sat, 22 Jul 2023 05:22:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C10E4
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 05:22:54 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA1171B
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:53 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-579ed2829a8so31252707b3.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003372; x=1690608172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0LQjKXkyl+tTOefE45UgjnoPn0F+A6Y0BzI1tJoIKQ=;
        b=f/gx9eAY0Ew6Jvq1MQjEGWCnL8E+PS/0ObSDu7Gp/XNnI2Zl2J4Op8F8hu6IxgG8Gi
         L6fAMb87JGrypVkWgIpPj2LSkeTweeU6tXKtBDJsMcr6QcbVm7e5zAL89P/IlSPQKIJV
         koWstPzYOfUdzWTuBPdgUp3d1+J3C21pOaUGdW0kzi/ei7aWlD/35acPKMdUC8VDER5t
         td4lBKoGUIo8+nShdIonVQ3SBJn76IUk6k/91YqS6qugWAb1ht9NhJGZRnHHlsYFhK3N
         2o4GOHONiPZeYPq/hjr23g+M4njVzhAlIzMH+QcG2cB8zX3Pk64WldyFIlu2Ca6Xh/6t
         z0gQ==
X-Gm-Message-State: ABy/qLZhj+eJukmqHPKemiS6Srj7kT9zGdN+0MIibqcybjEQP069KNZ4
	DPfwyUcBklPIQRzmvXzBVPHgJEfUlZUA1Q==
X-Google-Smtp-Source: APBJJlF6gp/7k3zWMCA66dafI3oalRDrdRrlSjvHBBZJkyLD5qnKW1AogXne2TQeWtwlCqdPbPmYuQ==
X-Received: by 2002:a81:a04e:0:b0:575:4b1c:e5f1 with SMTP id x75-20020a81a04e000000b005754b1ce5f1mr1777341ywg.39.1690003372055;
        Fri, 21 Jul 2023 22:22:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c289:3eeb:eb78:fe3b])
        by smtp.gmail.com with ESMTPSA id y191-20020a0dd6c8000000b00577335ea38csm1397829ywd.121.2023.07.21.22.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 22:22:51 -0700 (PDT)
From: kuifeng@meta.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [RFC bpf-next 0/5] Sleepable BPF programs on cgroup {get,set}sockopt
Date: Fri, 21 Jul 2023 22:22:43 -0700
Message-Id: <20230722052248.1062582-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Make BPF programs attached on cgroup/{get,set}sockopt hooks sleepable
and able to call bpf_copy_from_user() and bpf_copy_to_user(), a new
kfunc.

The Issue with CGroup {get,set}sockopt Hooks
============================================

Calling {get,set}sockopt from user space, optval is a pointer to a
buffer. The format of the buffer depends on the level and optname, and
its size is specified by optlen. The buffer is used by user space
programs to pass values to setsockopt and retrieve values from
getsockopt.

The problem is that BPF programs protected by RCU read lock cannot
access the buffers located in user space. This is because these
programs are non-sleepable and using copy_from_user() or
copy_to_user() to access user space memory can result in paging.

The kernel makes a copy of the buffer specified by optval and optlen
in kernel space before passing it to the cgroup {get,set}sockopt
hooks. After the hooks are executed, the content of the buffer in
kernel space is copied to user space if necessary.

Programs may send a significant amount of data, stored in buffer
indicated by optval, to the kernel. One example is iptables, which can
send several megabytes to the kernel. However, BPF programs on the
hooks can only see up to the first PAGE_SIZE bytes of the buffer. The
optlen value that BPF programs observe may appear to be PAGE_SIZE, but
in reality, it is larger than that. On the other hand, the value of
optlen represents the amount of data retrieved by
getsockopt(). Additionally, both the buffer content and optlen can be
modified by BPF programs.

Kernel may wrongly modify the value of optlen returned to user space
to PAGE_SIZE. This can happen because the kernel cannot distinguish if
the value was set by BPF programs or by the kernel itself.

To fix it, we perform various hacks; for example, the commit d8fe449a9c51
("bpf: Don't return EINVAL from {get,set}sockopt when optlen > PAGE_SIZE")
and the commit 29ebbba7d461 ("bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen").

Make CGroup {get,set}sockopt Hooks Sleepable
============================================

The long term solution is to make these hooks sleepable to enable BPF
programs call copy_from_user() and copy_to_user(),
a.k.a. bpf_copy_from_user() and bpf_copy_to_user(). It prevents
manipulation of optval and optlen values, and allows BPF programs to
access the complete contents of the buffer referenced by optval.

Kui-Feng Lee (5):
  bpf: enable sleepable BPF programs attached to
    cgroup/{get,set}sockopt.
  bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
  bpf: Add a new dynptr type for CGRUP_SOCKOPT.
  bpf: Prevent BPF programs from access the buffer pointed by
    user_optval.
  bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT
    type.

 include/linux/bpf.h                           |   7 +-
 include/linux/filter.h                        |   3 +
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           | 196 +++++++++---
 kernel/bpf/helpers.c                          | 104 ++++++
 kernel/bpf/verifier.c                         | 116 ++++---
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../testing/selftests/bpf/bpf_experimental.h  |  27 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  30 ++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  34 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 299 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 14 files changed, 763 insertions(+), 82 deletions(-)

-- 
2.34.1


