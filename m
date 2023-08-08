Return-Path: <bpf+bounces-7253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05B773F0C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A452802E6
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72D29DE3;
	Tue,  8 Aug 2023 16:39:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CC15486;
	Tue,  8 Aug 2023 16:39:26 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB227F8397;
	Tue,  8 Aug 2023 09:39:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso91904961fa.0;
        Tue, 08 Aug 2023 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512449; x=1692117249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJKYbjr1Hb9WHuWOPFqDpGQyS7eVaxQ0WI1Ze6xYIuI=;
        b=IdbhSqHeOKswzkca5dluhYktrPp8i3K2kABdafIB0YCr22D+8AOEVhSPSP3fGPGALT
         FQb1E33gANLCwK5rk1smFLTU/c2kau6oLb1SLgvtqVKWshiEPRYJ8btoFhDTjImDCtKa
         o/XDpULcAZzTmvYhVZRsPUhhUih70si+6sxmYmyvjWBikCuweB+BLG318AjShkPdnqNG
         iJHh8lSrgOcDvmw2aY7uiHmYU4ATDfdnqoFEUzetQ4aZve4ojynHiygUW5iY2KPhyajj
         dFiD1DDWRLSBS7wl/JUZQrQtWVRoJNo7PyNVhYrHFieDp96nf5z9KLP9WvhvefAEPYZP
         HzxQ==
X-Gm-Message-State: AOJu0YxhFGLUp4AM3WVUQ7K0Oc9o5z6zt4oErMQmJPEzvSIMjaV/yDUJ
	Al39XtyUR7CuuYkidfQZ3uSZBTBtq5Q=
X-Google-Smtp-Source: AGHT+IHG80o/f8oaKNOhKd6kp2JtfXZl2uTVt4PvEONnauM2jHioMJyp37dG+uFfwEgRQxRkt9dZ1A==
X-Received: by 2002:a17:906:535d:b0:99c:db8d:f9a with SMTP id j29-20020a170906535d00b0099cdb8d0f9amr3999486ejo.58.1691502062242;
        Tue, 08 Aug 2023 06:41:02 -0700 (PDT)
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906520400b0099bd7b26639sm6774937ejm.6.2023.08.08.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:41:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH v2 0/8] io_uring: Initial support for {s,g}etsockopt commands
Date: Tue,  8 Aug 2023 06:40:40 -0700
Message-Id: <20230808134049.1407498-1-leitao@debian.org>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
nad optnames. On the other hand, SOCKET_URING_OP_GETSOCKOPT just
implements level SOL_SOCKET case, which seems to be the
most common level parameter for get/setsockopt(2).

struct proto_ops->setsockopt() uses sockptr instead of userspace
pointers, which makes it easy to bind to io_uring. Unfortunately
proto_ops->getsockopt() callback uses userspace pointers, except for
SOL_SOCKET, which is handled by sk_getsockopt(). Thus, this patchset
leverages sk_getsockopt() to imlpement the SOCKET_URING_OP_GETSOCKOPT
case.

In order to support BPF hooks, I modified the hooks to use  sockptr, so,
it is flexible enough to accept user or kernel pointers for
optval/optlen.

PS1: For getsockopt command, the optlen field is not a userspace
pointers, but an absolute value, so this is slightly different from
getsockopt(2) behaviour. The new optlen value is returned in cqe->res.

PS2: The userspace pointers need to be alive until the operation is
completed.

These changes were tested with a new test[1] in liburing. On the BPF
side, I tested that no regression was introduced by running "test_progs"
self test using "sockopt" test case.

[1] Link: https://github.com/leitao/liburing/blob/getsock/test/socket-getsetsock-cmd.c

RFC -> V1:
	* Copy user memory at io_uring subsystem, and call proto_ops
	  callbacks using kernel memory
	* Implement all the cases for SOCKET_URING_OP_SETSOCKOPT
V1 -> V2
	* Implemented the BPF part
	* Using user pointers from optval to avoid kmalloc in io_uring part.

Breno Leitao (8):
  net: expose sock_use_custom_sol_socket
  io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
  io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
  io_uring/cmd: Extend support beyond SOL_SOCKET
  bpf: Leverage sockptr_t in BPF getsockopt hook
  bpf: Leverage sockptr_t in BPF setsockopt hook
  io_uring/cmd: BPF hook for getsockopt cmd
  io_uring/cmd: BPF hook for setsockopt cmd

 include/linux/bpf-cgroup.h    |  7 +--
 include/linux/net.h           |  5 +++
 include/uapi/linux/io_uring.h |  8 ++++
 io_uring/uring_cmd.c          | 82 +++++++++++++++++++++++++++++++++++
 kernel/bpf/cgroup.c           | 25 ++++++-----
 net/socket.c                  | 12 ++---
 6 files changed, 117 insertions(+), 22 deletions(-)

-- 
2.34.1


