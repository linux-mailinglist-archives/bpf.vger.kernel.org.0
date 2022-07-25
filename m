Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3A57FF26
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiGYMmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiGYMmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 08:42:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E17D51035;
        Mon, 25 Jul 2022 05:42:11 -0700 (PDT)
Received: from pwmachine.numericable.fr (82.65.121.78.rev.sfr.net [78.121.65.82])
        by linux.microsoft.com (Postfix) with ESMTPSA id A9D4720C356E;
        Mon, 25 Jul 2022 05:42:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9D4720C356E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658752931;
        bh=UFCSt3k5DxLVighG073IK/AEsI1NTLXv9nmpTeeRKuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EM0pJiyhAFIZzLOcCLTT6gmiYDQgA9TulmvnqrY5Tq2uF21dKdQtCYaPl+dxhmmoC
         JDBaCjGEAUF9oGYpux1+xrs9om2RUcZm02y7FZwmedptXX4Y24ZCx6PkXFQQozMSkB
         xUtn/Dknl+sF7VJ4elFKhqQMl/izO4hHftcB2CcM=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:BPF [MISC])
Subject: [RFC PATCH v4 0/2] Add capabilities file to securityfs
Date:   Mon, 25 Jul 2022 14:41:21 +0200
Message-Id: <20220725124123.12975-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.


First, I hope you are fine and the same for your relatives.

Capabilities are used to check if a thread can perform a given action [1].
For example, a thread with CAP_BPF set can use the bpf() syscall.

Capabilities are used in the container world.
In terms of code, several projects related to container maintain code where the
capabilities are written alike include/uapi/linux/capability.h [2][3][4][5].
For these projects, their codebase should be updated when a new capability is
added to the kernel.
Some other projects rely on <sys/capability.h> [6].
In this case, this header file should reflect the capabilities offered by the
kernel.

The delay between adding a new capability to the kernel and this
capability being used by "container stack" software users can be long.
Indeed, CAP_BPF was added in a17b53c4a4b5 which was part of v5.8 released in
August 2020.
Almost 2 years later, none of the "container stack" software authorize using
this capability in their last stable release.
The only way to use CAP_BPF with moby is to use v22.06.0-beta.0 release which
contains a commit enabling CAP_BPF, CAP_PERFMON and CAP_CHECKPOINT_RESTORE [7].
This situation can be easily explained by the following:
1. moby depends on containerd which in turns depends on runc.
2. runc depends on github.com/syndtr/gocapability which is golang package to
deal with capabilities.
This high number of dependencies explain the delay and the big amount of human
work to add support in the "container stack" software for a new capability.

A solution to this problem could be to add a way for the userspace to ask the
kernel about the capabilities it offers.
So, in this series, I added a new file to securityfs:
/sys/kernel/security/capabilities.
The goal of this file is to be used by "container world" software to know kernel
capabilities at run time instead of compile time.

The "file" is read-only and its content is the capability number associated with
the capability name:
root@vm-amd64:~# cat /sys/kernel/security/capabilities
0       CAP_CHOWN
1       CAP_DAC_OVERRIDE
...
40      CAP_CHECKPOINT_RESTORE
root@vm-amd64:~# wc -c /sys/kernel/security/capabilities
698 /sys/kernel/security/capabilities
So, the "container stack" software just have to read this file to know if they
can use the capabilities the user asked for.
For example, if user asks for CAP_BPF on kernel 5.8, then this capability will
be present in the file and so it can be used.
Nonetheless, if the underlying kernel is 5.4, this capability will not be
present and so it cannot be used.

The kernel already exposes the last capability number under:
/proc/sys/kernel/cap_last_cap
So, I think there should not be any issue exposing all the capabilities it
offers.
If there is any, please share it as I do not want to introduce issue with this
series.
Also, the data exchanged with userspace are less than 700 bytes long which
represent 17% of PAGE_SIZE.

Note that I am open to any better way for the userspace to ask the kernel for
known capabilities.
And if you see any way to improve this series please share it as it would
increase this contribution quality.

Change since:
 v3:
  * Use securityfs_create_file() to create securityfs file.
 v2:
  * Use a char * for cap_string instead of an array, each line of this char *
  contains the capability number and its name.
  * Move the file under /sys/kernel/security instead of /sys/kernel.

Francis Laniel (2):
  capability: Add cap_string.
  security/inode.c: Add capabilities file.

 include/uapi/linux/capability.h |  1 +
 kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
 security/inode.c                | 16 ++++++++++++
 3 files changed, 62 insertions(+)


Best regards and thank you in advance for your reviews.
---
[1] man capabilities
[2] https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L135
[3] https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a902aabc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9c1
moby relies on containerd code.
[4] https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e0b7f94e3a0ffb/capability/enum.go#L47
[5] https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231880ba0e6380519a/libcontainer/capabilities/capabilities.go#L12
runc relies on syndtr package.
[6] https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b880c089f1/src/libcrun/linux.c#L35
[7] https://github.com/moby/moby/commit/c1c973e81b0ff36c697fbeabeb5ea7d09566ddc0
--
2.25.1
