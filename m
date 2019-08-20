Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65B95B01
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfHTJcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 05:32:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfHTJcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so11624990wra.6
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aPzL39jtcr+g0fOPZqd4wmFCwlWg7wcJ3OhmuYqiGXk=;
        b=UZ1cIz0VQd6Rx3csqpw4Jvtuv9HJ87ySLjJkBHx7TV2EVQI+yMybNXNeoa54V18qFT
         09P+XZqAvky/WrQdEJWEBs5bTu4NepvNz1+mmp3Za9QAzpz8mHuHCEPOSzQDBkMW6xEM
         ED9NpalwtGUoQfmwPiPUq78lYn6M7UDMLKBYJXAPb2n8xDZplkzFpKiDMq37K8cvRJ2P
         dt4KXS21snwG7L0XmAY2UyZLLX6Y8bT1KBdfQOD5YPtZMyQOjJ/6SPRw/DX/9IzWC8l6
         cfplLVrdJQPtLhUN/sJI/WmQaaidMGJF0Go3tcGk20Mgf/CC+kqptojRySjYnmgo1BlW
         reTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aPzL39jtcr+g0fOPZqd4wmFCwlWg7wcJ3OhmuYqiGXk=;
        b=fZNAICO0OG4JHi6nvUNlE10yyVDC1dLTdNoiA3gYrBmyytI9kL84gyGQiCFzvWEK+k
         76fS3Ub78G9jnU4Ik4oXFjtJn9AVLIp8GlYYs+3KUnktP4N+EAbwgpGJrI8JVY16MyDG
         0N9dq0RG+je/DorKourc0u+y5D0c9iWDFL3Dgx36syNoXAK6jTzV3BfAmdWOi3+/338/
         mH0LazC853E+dKlhKJcTrePM/Xrpg+1hzL5nh6t5XuFLdczJ1U0g9tde8Mz33nDd4gND
         /pGqAedWjxU3UK+Cq0G2dondN+x10Zkl9ie15iCrPm7lePsqFcMlKQ1wGE2A3LbTCff+
         bNWQ==
X-Gm-Message-State: APjAAAWhennABT1Ub3EDLoGElmgFLUHBakFFdrE/q/QolN0QdoizIso/
        jGqYrxhU2RSne4I8UScN49ri/Q==
X-Google-Smtp-Source: APXvYqxwcTwHUck+KkxbRtNv9d7XPCV3JxsPWY2dHXhygMTV/FUy8HE+Mt1UinnhPR8Y3NoX+LeT0g==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr33339876wrw.15.1566293526280;
        Tue, 20 Aug 2019 02:32:06 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:05 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 0/5] bpf: list BTF objects loaded on system
Date:   Tue, 20 Aug 2019 10:31:49 +0100
Message-Id: <20190820093154.14042-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This set adds a new command BPF_BTF_GET_NEXT_ID to the bpf() system call,
adds the relevant API function in libbpf, and uses it in bpftool to list
all BTF objects loaded on the system (and to dump the ids of maps and
programs associated with them, if any).

The main motivation of listing BTF objects is introspection and debugging
purposes. By getting BPF program and map information, it should already be
possible to list all BTF objects associated to at least one map or one
program. But there may be unattached BTF objects, held by a file descriptor
from a user space process only, and we may want to list them too.

As a side note, it also turned useful for examining the BTF objects
attached to offloaded programs, which would not show in program information
because the BTF id is not copied when retrieving such info. A fix is in
progress on that side.

v2:
- Rebase patch with new libbpf function on top of Andrii's changes
  regarding libbpf versioning.

Quentin Monnet (5):
  bpf: add new BPF_BTF_GET_NEXT_ID syscall command
  tools: bpf: synchronise BPF UAPI header with tools
  libbpf: refactor bpf_*_get_next_id() functions
  libbpf: add bpf_btf_get_next_id() to cycle through BTF objects
  tools: bpftool: implement "bpftool btf show|list"

 include/linux/bpf.h                           |   3 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   4 +-
 kernel/bpf/syscall.c                          |   4 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  20 +-
 tools/bpf/bpftool/btf.c                       | 342 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |  24 +-
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.map                      |   2 +
 11 files changed, 389 insertions(+), 20 deletions(-)

-- 
2.17.1

