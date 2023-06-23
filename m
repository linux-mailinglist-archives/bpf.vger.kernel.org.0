Return-Path: <bpf+bounces-3265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D173B9AE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCE91C21206
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF912945F;
	Fri, 23 Jun 2023 14:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D68F68
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:19 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B002135;
	Fri, 23 Jun 2023 07:16:17 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a98cf01151so529523fac.2;
        Fri, 23 Jun 2023 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529776; x=1690121776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3opNLfaofO4XDCJOexejaNUpNBSFcotehkIKcHQoks8=;
        b=WIYgG7ZqUDc+/2yhaP8uOLlHKmIPhUoFJRghb9WbmAZ9LdG+4CvnE7PHSpPhN4A7AN
         z2RSatXw656h+zQAfv+RdO5d4DqTR6PqN8g5U9FIQzXN8sSh9PZa9L/y3GP5vfLnNF0H
         YPhPylwz28YUFxxnQwi9hGQhUxtfd7SbkD4wZC7uhlHOxfuKqHi65yz1dnDkDbN2UGHt
         e/Cn5fA7mN0j6h2++eS6uFsnN1Zmi63f1oSj/Fsv4E/DaQc98Q+IA+Wl+4RMitkU65T6
         dlrO/M/jU4JA9UxCpSSvXr94CDQwKx08fhsJNNGOGWRyHsfhTMCuZC2987cWPgWQdsgd
         KFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529776; x=1690121776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3opNLfaofO4XDCJOexejaNUpNBSFcotehkIKcHQoks8=;
        b=fsmpQvu1WjuaDCqBjrALgLJAk2UgpAFlxN1aipdyWS723EWWTC2b9aisHA/sZhSztM
         qlTt7Jr2VNTHO58jKr6sO26sKIhAyjbLK70GwlaLpbRIALXcJfTdCXY4rIcy20VcoCoM
         L8nZYWJL++th6JHKMC/UUr3RRy5VfMsrdv4/m1gghtc3JmlZ1o/yufyLowfuqZbpZ1pl
         YZ0i37/6GG7aO9ilBDDj56kdzpXu/QbKhv6g4mXrc4zGbQdWKMitxsRZmRDbAwhxqDUW
         X2K3XPaIfHVvUnRMVFyY+JIZmE4mrmEgd+QERFryi+/fUCTkYAhn9wzOYK1q8wpcIilO
         qdbQ==
X-Gm-Message-State: AC+VfDyac5Y9KyTNxB6eSM1g2b911iutgTAVQ/qBRYjMPbF9sPbTXdOT
	xfBet9YML98oFJiG1lgxjC8=
X-Google-Smtp-Source: ACHHUZ6vb2KZVS65PMxFWWabJvydHNvxI3HDf7lW6YN6SMdKNb4LsKrm12mfiIFGS8qPKRnUv1hbfg==
X-Received: by 2002:a05:6871:8506:b0:1a9:a12d:f7b8 with SMTP id sx6-20020a056871850600b001a9a12df7b8mr23055121oab.41.1687529775680;
        Fri, 23 Jun 2023 07:16:15 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 00/11] bpf: Support ->fill_link_info for kprobe_multi and perf_event links 
Date: Fri, 23 Jun 2023 14:15:35 +0000
Message-Id: <20230623141546.3751-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset enhances the usability of kprobe_multi program by introducing
support for ->fill_link_info. This allows users to easily determine the
probed functions associated with a kprobe_multi program. While
`bpftool perf show` already provides information about functions probed by
perf_event programs, supporting ->fill_link_info ensures consistent access
to this information across all bpf links.

In addition, this patch extends support to generic perf events, which are
currently not covered by `bpftool perf show`. While userspace is exposed to
only the perf type and config, other attributes such as sample_period and
sample_freq are disregarded.

To ensure accurate identification of probed functions, it is preferable to
expose the address directly rather than relying solely on the symbol name.
However, this implementation respects the kptr_restrict setting and avoids
exposing the address if it is not permitted.

v4->v5:
- Print "func [module]" in the kprobe_multi header (Andrii)
- Remove MAX_BPF_PERF_EVENT_TYPE (Alexei)
- Add padding field for future reuse (Yonghong)

v3->v4:
- From Quentin
  - Rename MODULE_NAME_LEN to MODULE_MAX_NAME
  - Convert retprobe to boolean for json output
  - Trim the square brackets around module names for json output
  - Move perf names into link.c
  - Use a generic helper to get perf names
  - Show address before func name, for consistency
  - Use switch-case instead of if-else
  - Increase the buff len to PATH_MAX
  - Move macros to the top of the file
- From Andrii
  - kprobe_multi flags should always be returned
  - Keep it single line if it fits in under 100 characters
  - Change the output format when showing kprobe_multi
  - Imporve the format of perf_event names
  - Rename struct perf_link to struct perf_event, and change the names of
    the enum consequently
- From Yonghong
  - Avoid disallowing extensions for all structs in the big union
- From Jiri
  - Add flags to bpf_kprobe_multi_link
  - Report kprobe_multi selftests errors
  - Rename bpf_perf_link_fill_name and make it a separate patch
  - Avoid breaking compilation when CONFIG_KPROBE_EVENTS or
    CONFIG_UPROBE_EVENTS options are not defined

v2->v3:
- Expose flags instead of retporbe (Andrii)
- Simplify the check on kmulti_link->cnt (Andrii)
- Use kallsyms_show_value() instead (Andrii)
- Show also the module name for kprobe_multi (Andrii)
- Add new enum bpf_perf_link_type (Andrii)
- Move perf event names into bpftool (Andrii, Quentin, Jiri)
- Keep perf event names in sync with perf tools (Jiri) 

v1->v2:
- Fix sparse warning (Stanislav, lkp@intel.com)
- Fix BPF CI build error
- Reuse kernel_syms_load() (Alexei)
- Print 'name' instead of 'func' (Alexei)
- Show whether the probe is retprobe or not (Andrii)
- Add comment for the meaning of perf_event name (Andrii)
- Add support for generic perf event
- Adhere to the kptr_restrict setting

Yafang Shao (11):
  bpf: Support ->fill_link_info for kprobe_multi
  bpftool: Dump the kernel symbol's module name
  bpftool: Show kprobe_multi link info
  bpf: Protect probed address based on kptr_restrict setting
  bpf: Clear the probe_addr for uprobe
  bpf: Expose symbol's respective address
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Add bpf_perf_link_fill_common()
  bpf: Support ->fill_link_info for perf_event
  bpftool: Add perf event names
  bpftool: Show perf link info

 include/uapi/linux/bpf.h          |  40 ++++
 kernel/bpf/syscall.c              | 183 +++++++++++++++--
 kernel/trace/bpf_trace.c          |  32 ++-
 kernel/trace/trace_kprobe.c       |   7 +-
 tools/bpf/bpftool/link.c          | 413 +++++++++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/xlated_dumper.c |   6 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  40 ++++
 8 files changed, 703 insertions(+), 20 deletions(-)

-- 
1.8.3.1


