Return-Path: <bpf+bounces-9626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042EE79A741
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B06281294
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E9C2E9;
	Mon, 11 Sep 2023 10:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19966523B;
	Mon, 11 Sep 2023 10:34:27 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEEE5F;
	Mon, 11 Sep 2023 03:34:25 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso543476766b.1;
        Mon, 11 Sep 2023 03:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428464; x=1695033264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuxWzi0SpMhBfa5qiwgBKVDj1sBIBDVRjmMU4662HK8=;
        b=SQbuzEmyic9K5mXSE3/2mx4IMzJF/HmbjQ/3zXMKqoMtscI8hQhEX7xDDA8Gf1twUv
         jNTsUEvJg/DRp9t71tWrRzg2JMTNcYwmXnXFU3omTjtwdmvwwsM4BTy72rcw4LHJ8t7F
         ZIYkq/yIDJ2q2Cw4bD4dwJnhzioeXgxw/mja6uu6d8Z2g52krVVdVMxzR4LI6mD13y1m
         yrk5IoSoBfZnQq4YXCRLdYbAga5S41BqlLkO4m+UqyT5koKpKJh9BVZ3pCW7XZbDZH1u
         ZOT9Qc3wbUvXKXVsO9cdDi/ZwxeqY2Q70Ph/KoUFbOto3d9s61V7mn0e8ki32Ywn3O7d
         MekA==
X-Gm-Message-State: AOJu0YymrcdeaOUHwzFMzyj6hPdFY8+qzA9Vbgdv7g9lpXdYfpTTYKJy
	DCZFSWG+kRIODj2RHGcQId4=
X-Google-Smtp-Source: AGHT+IFHynsKgWq4NgUjq4OKLyUzMvXPVvvjbbjYd6PD4qMpJEvDfhgLeYH8m3839btK71/4rp846Q==
X-Received: by 2002:a17:906:8b:b0:9a2:1ce5:1243 with SMTP id 11-20020a170906008b00b009a21ce51243mr8687836ejc.60.1694428463664;
        Mon, 11 Sep 2023 03:34:23 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id hb5-20020a170906b88500b009828e26e519sm5079289ejb.122.2023.09.11.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:34:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	krisman@suse.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v5 0/8] io_uring: Initial support for {s,g}etsockopt commands
Date: Mon, 11 Sep 2023 03:33:59 -0700
Message-Id: <20230911103407.1393149-1-leitao@debian.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
SOCKET_URING_OP_SETSOCKOPT and SOCKET_URING_OP_GETSOCKOPT implement generic
case, covering all levels and optnames (a change from the previous
version, where getsockopt was limited to level=SOL_SOCKET).

In order to keep the implementation (and tests) simple, some refactors
were done prior to the changes, as follows:

Patch 1-2:  Remove the core {s,g}etsockopt() core function from
__sys_{g,s}etsockopt, so, the code could be reused by other callers,
such as io_uring.

Patch 3: Pass compat mode to the file/socket callbacks

Patch 4: Move io_uring helpers from io_uring_zerocopy_tx to a generic
io_uring headers. This simplify the test case (last patch)

Patch 5: Protect io_uring_cmd_sock() to not be called if CONFIG_NET is
disabled.

Important to say that userspace pointers need to be alive until the
operation is completed, as in the systemcall.

These changes were tested with a new test[1] in liburing, LTP sockopt*
tests, as also with bpf/progs/sockopt test case, which is now adapted to
run using both system calls and io_uring commands.

[1] Link: https://github.com/leitao/liburing/blob/getsock/test/socket-getsetsock-cmd.c

RFC -> V1:
	* Copy user memory at io_uring subsystem, and call proto_ops
	  callbacks using kernel memory
	* Implement all the cases for SOCKET_URING_OP_SETSOCKOPT

V1 -> V2
	* Implemented the BPF part
	* Using user pointers from optval to avoid kmalloc in io_uring part.

V2 -> V3:
	* Break down __sys_setsockopt and reuse the core code, avoiding
	  duplicated code. This removed the requirement to expose
	  sock_use_custom_sol_socket().
	* Added io_uring test to selftests/bpf/sockopt.
	* Fixed compat argument, by passing it to the issue_flags.

V3 -> V4:
	* Rebase on top of commit 1ded5e5a5931b ("net: annotate data-races around sock->ops")
	* Also broke down __sys_setsockopt() to reuse the core function
	  from io_uring.
	* Create a new patch to return -EOPNOTSUPP if CONFIG_NET is
	  disabled
	* Added two SOL_SOCKET tests in bpf/prog_tests/sockopt.

V4 -> V5:
	* Do not use sockptr anymore, by changing the optlen getsock argument
	  to be a user pointer (instead of a kernel pointer). This change also drop
	  the limitation on getsockopt from previous versions, and now all
	  levels are supported.
	* Simplified the BPF sockopt test, since there is no more limitation on
	  the io_uring commands.
	* No more changes in the BPF subsystem.
	* Moved the optlen field in the SQE struct. It is now a pointer instead
	  of u32.

Breno Leitao (8):
  net/socket: Break down __sys_setsockopt
  net/socket: Break down __sys_getsockopt
  io_uring/cmd: Pass compat mode in issue_flags
  selftests/net: Extract uring helpers to be reusable
  io_uring/cmd: return -EOPNOTSUPP if net is disabled
  io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
  io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
  selftests/bpf/sockopt: Add io_uring support

 include/linux/io_uring.h                      |   1 +
 include/net/sock.h                            |   5 +
 include/uapi/linux/io_uring.h                 |  10 +
 io_uring/uring_cmd.c                          |  41 +++
 net/socket.c                                  |  89 ++++--
 tools/include/io_uring/mini_liburing.h        | 292 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockopt.c        |  95 +++++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/io_uring_zerocopy_tx.c      | 268 +---------------
 9 files changed, 497 insertions(+), 305 deletions(-)
 create mode 100644 tools/include/io_uring/mini_liburing.h

-- 
2.34.1


