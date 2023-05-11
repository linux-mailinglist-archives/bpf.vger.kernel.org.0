Return-Path: <bpf+bounces-341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4656FF44A
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1B1C20F39
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11361D2B4;
	Thu, 11 May 2023 14:27:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52F19E77
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:27:15 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DA1991;
	Thu, 11 May 2023 07:26:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so15393704a12.1;
        Thu, 11 May 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815208; x=1686407208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Kdw60BIyCbfffo7kd/u9iWPAZQVDLmeaXBiKk2PEo=;
        b=kecnT8RiVzNqYEoxVyP2/tFcSy42y33tVeA++znGsLDE/6hRWthVe0N8OL3Z8AJzHD
         5ISXvH3iz8C9sNdGktvxgZ/XrejCEc1fImwOC+pLQtZkdEhJ8addc6P05ghIjJg9SuPw
         8JCbe8QBpvNOpBS+rh/vn2S3DaRK6we+ByoYny6gMudmYDYKUPqt7iWI3/Rh3PbHxEtn
         Nfset6m4eg0YGznFK4z5AmzFtE2YjQgzBi/YH6l4zPZTvY9cHycAA9PnL9hsVZl5xNTw
         5+nxJ6ICZUxX1KiPVD72cmjYKRp4CYVw+D5yW93GPMJ5XmJKKDzsKGLQEH+FN7Q1b2V/
         qAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815208; x=1686407208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Kdw60BIyCbfffo7kd/u9iWPAZQVDLmeaXBiKk2PEo=;
        b=E/XfycpjGsFL+eR6YMUXeYSdT3089sLLt5U9z6L+PeDdbGzeWC9/ghZmPotym1ePSI
         mz2yM+9tdv3ZotD+oa2MBBYYMW+YsSeobtKcmMXrkSGIr/wi4xjN3OzwdYs/EQ01Dy4B
         I+l83XntykUkhhHnfpE8y66ZgVhjd2ex9W7U/mH3qV8voLs4PEnT5f680KAtF9GS/Sxz
         SRYbchbUxBRG+tuZ3Buw8g5amu+myVhePzL5AEbKuApdrdimR/0gKMrcxzOtyHHMeJpS
         c6ydlyvQHMREAJTOw9fMHc155Rt3GbbcWZrrq1oahkEuSMASCVEI8YZ2iN6r88l2k+Rc
         RtoQ==
X-Gm-Message-State: AC+VfDx3bXQ3+DT2tWsOASyn+Yr4JYMyFu4JhlIa9NtzyfEsTZ9DWY9d
	J6HkTbFPEwTEsvodYqxBTGi+EZs8rTQtkg==
X-Google-Smtp-Source: ACHHUZ6CHMLGH40AinncmR0kLEE1N5eMJl9iZbtuHNWe5xkHVVXbDJJRstrnqymPzwHIBK+2OQeeqg==
X-Received: by 2002:a17:906:eec9:b0:94e:46ef:1361 with SMTP id wu9-20020a170906eec900b0094e46ef1361mr18738496ejb.34.1683815208249;
        Thu, 11 May 2023 07:26:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:47 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH v4 0/9] Introduce capable_any()
Date: Thu, 11 May 2023 16:25:33 +0200
Message-Id: <20230511142535.732324-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability request will create a denial
message.  Using this new wrapper with the least invasive capability as
left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
policy writers to only grant the least invasive one for the particular
subject instead of both.

v3 discussion:
https://patchwork.kernel.org/project/selinux/patch/20220615152623.311223-8-cgzones@googlemail.com/

v4:
  - add CAP_OPT_NODENYAUDIT capable flag


Christian Göttsche (9):
  capability: introduce new capable flag NODENYAUDIT
  capability: add any wrapper to test for multiple caps with exactly one
    audit message
  capability: use new capable_any functionality
  block: use new capable_any functionality
  drivers: use new capable_any functionality
  fs: use new capable_any functionality
  kernel: use new capable_any functionality
  bpf: use new capable_any functionality
  net: use new capable_any functionality

 block/ioprio.c                           |  9 +--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  3 +-
 drivers/net/caif/caif_serial.c           |  2 +-
 drivers/s390/block/dasd_eckd.c           |  2 +-
 fs/pipe.c                                |  2 +-
 include/linux/capability.h               | 17 ++++--
 include/linux/security.h                 |  2 +
 include/net/sock.h                       |  1 +
 kernel/bpf/syscall.c                     |  2 +-
 kernel/capability.c                      | 70 ++++++++++++++++++++++++
 kernel/fork.c                            |  2 +-
 net/caif/caif_socket.c                   |  2 +-
 net/core/sock.c                          | 18 +++---
 net/ieee802154/socket.c                  |  6 +-
 net/ipv4/ip_sockglue.c                   |  4 +-
 net/ipv6/ipv6_sockglue.c                 |  3 +-
 net/unix/scm.c                           |  2 +-
 security/apparmor/capability.c           |  8 ++-
 security/selinux/hooks.c                 | 14 +++--
 19 files changed, 123 insertions(+), 46 deletions(-)

-- 
2.40.1


