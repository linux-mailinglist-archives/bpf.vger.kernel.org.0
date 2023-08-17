Return-Path: <bpf+bounces-7982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7977F9D1
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9EB1C2142D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC614F73;
	Thu, 17 Aug 2023 14:56:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358B14290;
	Thu, 17 Aug 2023 14:56:24 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193D3592;
	Thu, 17 Aug 2023 07:56:08 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so1048319566b.2;
        Thu, 17 Aug 2023 07:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284167; x=1692888967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SQ2mdlJ/zc4OpHFZ3If0GuAfTpQpt1yP+BpEHXI8MY=;
        b=AQq0iF2VMg5/I+Ak/DZq/HpMby7RwpupgIzDtnSz2UmJi+wON31Wa5fgSUUuTRjeMQ
         JQY4qHUdHsqNJxzohrDDqsMV31y7esVT200mpYTZ/JN/QiMnKfDKlGyDHkmQBTFleGwD
         FG8ZlpEKhm/mxupcoEGhjQNRKdX2A8PPnsErGkAGyDld526cZk+Ns/tALVu6Mw4ReiMm
         q1rJQpCYhi5t8YSQ035lL3/FrOUWwUkByjkGk2y/E3nXgbFIcF09k/ChwIeT7JetuXv3
         Uq85XfcMNUlzhDAKNbZoDC/AcQSNoXr+oNBgSB6Mp2ZMQuoPDjI2Sx6AZMQiZSo1gPfT
         Ny/g==
X-Gm-Message-State: AOJu0Yy1wT4KiD9gbsrh0cJzMUsj4qlCJcg+up+Dfuv0p6tHUfSiR/Wj
	a0crVO9ikcnDqHes7IFInmI=
X-Google-Smtp-Source: AGHT+IHWC6ovjf9IAZiRk3LF0fppYKcG2xDzkIn/xXKUECNjYSgjfkL/ElFpHWg5oAIQoR3oQkdkBA==
X-Received: by 2002:a17:907:784b:b0:988:9b29:5653 with SMTP id lb11-20020a170907784b00b009889b295653mr3565597ejc.77.1692284167180;
        Thu, 17 Aug 2023 07:56:07 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906195500b0099df2ddfc37sm2433123eje.165.2023.08.17.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:56:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	krisman@suse.de
Subject: [PATCH v3 0/9] io_uring: Initial support for {s,g}etsockopt commands
Date: Thu, 17 Aug 2023 07:55:45 -0700
Message-Id: <20230817145554.892543-1-leitao@debian.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to SOL_SOCKET
level, which seems to be the most common level parameter for get/setsockopt(2).

In order to keep the implementation (and tests) simple, some refactors were done
prior to the changes, as follows:

Patches 1-2: Modify the BPF hooks to support sockptr_t, so, these functions
become flexible enough to accept user or kernel pointers for optval/optlen.

Patch 3: Extract the core setsockopt() core function from __sys_setsockopt, so,
the code code could be reused by other callers, such as io_uring.

Patch 4: Pass compat mode to the file/socket callbacks.

Patch 5: Move io_uring helpers from io_uring_zerocopy_tx to a generic io_uring
headers. This simplify the testcase (last patch)

PS1: For getsockopt command, the optlen field is not a userspace
pointers, but an absolute value, so this is slightly different from
getsockopt(2) behaviour. The new optlen value is returned in cqe->res.

PS2: The userspace pointers need to be alive until the operation is
completed.

These changes were tested with a new test[1] in liburing, as also with
bpf/progs/sockopt test case, which is now adapted to run using both system
calls and io_uring commands.

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
	  duplicated code. This removed the requirement to export
	  sock_use_custom_sol_socket() as done in v2.
	* Added io_uring test to selftests/bpf/sockopt.
	* Fixed "compat" argument, by passing it to the issue_flags.

Breno Leitao (9):
  bpf: Leverage sockptr_t in BPF getsockopt hook
  bpf: Leverage sockptr_t in BPF setsockopt hook
  net/socket: Break down __sys_setsockopt
  io_uring/cmd: Pass compat mode in issue_flags
  selftests/net: Extract uring helpers to be reusable
  io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
  io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
  io_uring/cmd: BPF hook for getsockopt cmd
  selftests/bpf/sockopt: Add io_uring support

