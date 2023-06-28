Return-Path: <bpf+bounces-3651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8C741071
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E2E1C20826
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02204BE5E;
	Wed, 28 Jun 2023 11:53:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40FBA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:37 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6930C7;
	Wed, 28 Jun 2023 04:53:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26304be177fso1631325a91.1;
        Wed, 28 Jun 2023 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953215; x=1690545215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RRJziyPSRmU0Ub+b/uVepfp0PlF0x7PFn8a8+Bm724=;
        b=oLjr6ubJehe1E2LpykG2gY4UxsrFZVln6AR6LXYULLck2J9ptW1uTkYUDdIm699Is0
         XepPkopWZkI7YkBBxWBA3EtiT1sgGCyf6G7Pg4m2vqjtD5dBxFU33ZONthQYwnFfTObV
         7zFZTmKeYVCpJORc/XP/bZGaJO1cL1nOFwYb6bS3uaj42pUkh9GqTxiN3l/Ybj4fxL0q
         reeW+dcsvLUc6BAoTDGlhzCcZb6vHXfW6KVIGPHXIaPF4qXyojAqur8Ohxb7U+9K3/LJ
         k90OxJksKkscrb+rf/DIfPQ7AXPuHb/BoEvyJVrFcK5Msg8jx8/wMV1jxFkR8ytn1dmr
         tR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953215; x=1690545215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RRJziyPSRmU0Ub+b/uVepfp0PlF0x7PFn8a8+Bm724=;
        b=gnQ88Q/UN7Jc4uh8yLuKnmmIiJogInSnOuxyft1q5z6spB0VagjK9jEj+wVuo3vixM
         OOCGz3fbA/YU8JxsgkWMFQX+5NG8pjhrGPTzpWPYpIb+6St5edFRlykuixuht/Hwmn6x
         hEYa9FIgFHk4p5UyWMQRWg8Ivf4rBugLP3Rq+sRpTgfjaO2VvQeDgWWHwjWR7Pjf4QAR
         eq7br+rvVaCkM5rFqfKdwK12XRTSUmoqe7ex/kbX4DmMQc6+JBjZovg5Pl20nmLQoL8V
         OCdDjgxn6Wtsr216DK1+46lLidGUFOeXHncAF3vZcNqZ9bASywJGQ3y7erGHYJAJ5HQu
         Ff5w==
X-Gm-Message-State: AC+VfDw5Pm8TUyB57OhcFKJl+At8TFuRaQtPfBYgjE3RdfJDsZDeVQo5
	Df+80K3fwmgcgnLd08gk8wXrQLI+wTk0NbUm
X-Google-Smtp-Source: ACHHUZ4nvVhBsvOGtiTL+cPwRPmHfcxkoXJPljX75i4NNfLcq9HtD6p94PbZL7aWED7JIfTW08a64Q==
X-Received: by 2002:a17:90a:a892:b0:262:ef90:246d with SMTP id h18-20020a17090aa89200b00262ef90246dmr7030087pjq.23.1687953215377;
        Wed, 28 Jun 2023 04:53:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:34 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 00/11] bpf: Support ->fill_link_info for kprobe_multi and perf_event links 
Date: Wed, 28 Jun 2023 11:53:18 +0000
Message-Id: <20230628115329.248450-1-laoar.shao@gmail.com>
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

v5->v6:
- From Andrii
  - if ucount is too less, copy ucount items and return -E2BIG 
  - zero out kmulti_link->cnt elements if it is not permitted by kptr
  - avoid leaking information when ucount is greater than kmulti_link->cnt
  - drop the flags, and add BPF_PERF_EVENT_[UK]RETPROBE 
- From Quentin
  - use jsonw_null instead when we have no module name
  - add explanation on perf_type_name in the commit log
  - avoid the unnecessary out lable 

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

RFC->v1:
- Use a single copy_to_user() instead (Jiri)
- Show also the symbol name in bpftool (Quentin, Alexei)
- Use calloc() instead of malloc() in bpftool (Quentin)
- Avoid having conditional entries in the JSON output (Quentin)
- Drop ->show_fdinfo (Alexei)
- Use __u64 instead of __aligned_u64 for the field addr (Alexei)
- Avoid the contradiction in perf_event name length (Alexei) 
- Address a build warning reported by kernel test robot <lkp@intel.com>

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

 include/uapi/linux/bpf.h          |  40 +++
 kernel/bpf/syscall.c              | 185 ++++++++++++-
 kernel/trace/bpf_trace.c          |  41 ++-
 kernel/trace/trace_kprobe.c       |   7 +-
 tools/bpf/bpftool/link.c          | 428 +++++++++++++++++++++++++++++-
 tools/bpf/bpftool/xlated_dumper.c |   6 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  40 +++
 8 files changed, 729 insertions(+), 20 deletions(-)

-- 
2.39.3


