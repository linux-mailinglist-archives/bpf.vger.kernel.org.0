Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84532B33A
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352496AbhCCDuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349781AbhCBRga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E2C061A27
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:33 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o38so14246407pgm.9
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSepNuTpShhqXcTO9o/+6YyXUqnmTGJsJycIq3qFJpo=;
        b=iCWZupQqVkBwoPxoHcF5zAleItLX18zgYEvsPvPz1QBKeW4ggt81c3gfm62l9KBLYv
         0ZQ5/4+e7WEVeILAU1QoVQSgSF9NuPuCV/IuzL04ylKWdGrGw+isusB09Py22T/03PCg
         c3zTrTe6IClZMKWveUal+fOHVZ39cGEYQo7Jf+UYTg4D5IV7/L2JRK+sgAx11Di3SnG8
         kPsPQAClb108dIOkpMeBlAW++rr+4zNrMD2UKsZmFOR9CLQKh4iJBQn/jKUjCYwpBMAp
         8GN4iFygZb1OmR3+YI+ogrlz5On/VsVJ5aNi6wDpqJPfp6sBIUyB9bx1gPBDPCciVm/M
         6mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSepNuTpShhqXcTO9o/+6YyXUqnmTGJsJycIq3qFJpo=;
        b=A25glCXqSh+l6CCNr8ZBXV5tQqmZUupidrlw6yfGseQwjqtv/BdbAnpQuos9WUnqda
         Tai7doAhBcm2pI4/34v1W/ICp49wsYrGjlkf2rzEM57H850WqWu+Xnm9BJq3XxZQIdGa
         dyAvCgvidcoXUWBTlj8yIaB8lgeR4nV3AKPDAsIZ5OPtOSkkex1HM7DsxEqcmbO3iQ3t
         6u2eDSShCNzGgvwOtiib7V2d6HTEs1YDbDASLpKlBwofwC0/tCxk1JONb1Ualgnmx7lv
         SUsQtPe3C6W4J6TZh6kyyV6LTRA+mLaoGVRhyhQKKkjJRzAszvijFxns3W1m85RAN49n
         Y6rg==
X-Gm-Message-State: AOAM5308A38IEPbqhshPNA3katUrO1QdCV6A9HrlfNWjSeymEslE0wFC
        B4xh7s7oBLJRuQQ+Vrb0vhvJ0YdCzdXFzz9Q
X-Google-Smtp-Source: ABdhPJwuIMK+ewRiaw33ZRBdLAvPTiWCttJuE4Y7QHyuLgDmoaprwrhcPx4OJfWs7oWlUXT/bYylqQ==
X-Received: by 2002:aa7:9a86:0:b029:1ee:70dd:c44e with SMTP id w6-20020aa79a860000b02901ee70ddc44emr4136871pfi.56.1614705632486;
        Tue, 02 Mar 2021 09:20:32 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:32 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     linux-man@vger.kernel.org, linux-doc@vger.kernel.org,
        mtk.manpages@gmail.com, ast@kernel.org, brianvv@google.com,
        daniel@iogearbox.net, daniel@zonque.org, john.fastabend@gmail.com,
        ppenkov@google.com, quentin@isovalent.com, sean@mess.org,
        yhs@fb.com
Subject: [PATCHv2 bpf-next 00/15] Improve BPF syscall command documentation
Date:   Tue,  2 Mar 2021 09:19:32 -0800
Message-Id: <20210302171947.2268128-1-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The state of bpf(2) manual pages today is not exactly ideal. For the
most part, it was written several years ago and has not kept up with the
pace of development in the kernel tree. For instance, out of a total of
~35 commands to the BPF syscall available today, when I pull the
kernel-man-pages tree today I find just 6 documented commands: The very
basics of map interaction and program load.

In contrast, looking at bpf-helpers(7), I am able today to run one
command[0] to fetch API documentation of the very latest eBPF helpers
that have been added to the kernel. This documentation is up to date
because kernel maintainers enforce documenting the APIs as part of
the feature submission process. As far as I can tell, we rely on manual
synchronization from the kernel tree to the kernel-man-pages tree to
distribute these more widely, so all locations may not be completely up
to date. That said, the documentation does in fact exist in the first
place which is a major initial hurdle to overcome.

Given the relative success of the process around bpf-helpers(7) to
encourage developers to document their user-facing changes, in this
patch series I explore applying this technique to bpf(2) as well.
Unfortunately, even with bpf(2) being so out-of-date, there is still a
lot of content to convert over. In particular, the following aspects of
the bpf syscall could also be individually be generated from separate
documentation in the header:
* BPF syscall commands
* BPF map types
* BPF program types
* BPF program subtypes (aka expected_attach_type)
* BPF attachment points

Rather than tackle everything at once, I have focused in this series on
the syscall commands, "enum bpf_cmd". This series is structured to first
import what useful descriptions there are from the kernel-man-pages
tree, then piece-by-piece document a few of the syscalls in more detail
in cases where I could find useful documentation from the git tree or
from a casual read of the code. Not all documentation is comprehensive
at this point, but a basis is provided with examples that can be further
enhanced with subsequent follow-up patches. Note, the series in its
current state only includes documentation around the syscall commands
themselves, so in the short term it doesn't allow us to automate bpf(2)
generation; Only one section of the man page could be replaced. Though
if there is appetite for this approach, this should be trivial to
improve on, even if just by importing the remaining static text from the
kernel-man-pages tree.

Following that, the series enhances the python scripting around parsing
the descriptions from the header files and generating dedicated
ReStructured Text and troff output. Finally, to expose the new text and
reduce the likelihood of having it get out of date or break the docs
parser, it is added to the selftests and exposed through the kernel
documentation web pages.

The eventual goal of this effort would be to extend the kernel UAPI
headers such that each of the categories I had listed above (commands,
maps, progs, hooks) have dedicated documentation in the kernel tree, and
that developers must update the comments in the headers to document the
APIs prior to patch acceptance, and that we could auto-generate the
latest version of the bpf(2) manual pages based on a few static
description sections combined with the dynamically-generated output from
the header.

This patch series can also be found at the following location on GitHub:
https://github.com/joestringer/linux/tree/submit/bpf-command-docs_v2

Thanks also to Quentin Monnet for initial review.

[0]: make -C tools/testing/selftests/bpf docs

---

v2:
* Remove build infrastructure in favor of kernel-doc directives
* Shift userspace-api docs under Documentation/userspace-api/ebpf
* Fix scripts/bpf_doc.py syscall --header (throw unsupported error)
* Improve .gitignore handling of newly autogenerated files

---

Joe Stringer (15):
  bpf: Import syscall arg documentation
  bpf: Add minimal bpf() command documentation
  bpf: Document BPF_F_LOCK in syscall commands
  bpf: Document BPF_PROG_PIN syscall command
  bpf: Document BPF_PROG_ATTACH syscall command
  bpf: Document BPF_PROG_TEST_RUN syscall command
  bpf: Document BPF_PROG_QUERY syscall command
  bpf: Document BPF_MAP_*_BATCH syscall commands
  scripts/bpf: Abstract eBPF API target parameter
  scripts/bpf: Add syscall commands printer
  tools/bpf: Remove bpf-helpers from bpftool docs
  selftests/bpf: Templatize man page generation
  selftests/bpf: Test syscall command parsing
  docs/bpf: Add bpf() syscall command reference
  tools: Sync uapi bpf.h header with latest changes

 Documentation/bpf/index.rst                   |   9 +-
 Documentation/userspace-api/ebpf/index.rst    |  17 +
 Documentation/userspace-api/ebpf/syscall.rst  |  24 +
 Documentation/userspace-api/index.rst         |   1 +
 MAINTAINERS                                   |   2 +
 include/uapi/linux/bpf.h                      | 714 +++++++++++++++++-
 scripts/{bpf_helpers_doc.py => bpf_doc.py}    | 191 ++++-
 tools/bpf/Makefile.helpers                    |  60 --
 tools/bpf/bpftool/.gitignore                  |   1 -
 tools/bpf/bpftool/Documentation/Makefile      |  11 +-
 tools/include/uapi/linux/bpf.h                | 714 +++++++++++++++++-
 tools/lib/bpf/Makefile                        |   2 +-
 tools/perf/MANIFEST                           |   2 +-
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  20 +-
 tools/testing/selftests/bpf/Makefile.docs     |  82 ++
 .../selftests/bpf/test_bpftool_build.sh       |  21 -
 tools/testing/selftests/bpf/test_doc_build.sh |  13 +
 18 files changed, 1746 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/userspace-api/ebpf/index.rst
 create mode 100644 Documentation/userspace-api/ebpf/syscall.rst
 rename scripts/{bpf_helpers_doc.py => bpf_doc.py} (82%)
 delete mode 100644 tools/bpf/Makefile.helpers
 create mode 100644 tools/testing/selftests/bpf/Makefile.docs
 create mode 100755 tools/testing/selftests/bpf/test_doc_build.sh

-- 
2.27.0

