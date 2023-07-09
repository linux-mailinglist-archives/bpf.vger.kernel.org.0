Return-Path: <bpf+bounces-4511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659DF74C078
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498BA1C20906
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0B617C6;
	Sun,  9 Jul 2023 02:56:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C4ECA
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:46 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC15E45;
	Sat,  8 Jul 2023 19:56:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687446eaccso2779800b3a.3;
        Sat, 08 Jul 2023 19:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871404; x=1691463404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iAnkpzLogI2LXanWo888CbURkFu1KKEAFkxyuV92gg=;
        b=PXggkjQRdINPjjOrt4/ZVg1Gd1dvR2yQjiaicbjWv+rOu5FN5Fw+Np8BDuFjXBu2zD
         F/7PWpG8PDcXVpz94aEcYlZb/jE1EhCFgEAqnSig2C41bcbmdKUylkY8ul6MUVQuPZ2x
         9u32YdAv+E793zeudJWNZcv8J0MH0zwKKXPQJdB0Fs7JR+wbM49UUB8zROZfFedtvNJV
         SqVwulULf3iRSQdhJ1jq6yyXrFhI4BvMhtrcxi0kr3Do2ta6zJA10szzMzhkzp2PUJIN
         4UeOubt35Jy3Lva6iu8qGbaxLy8Bwur5bs1hqYOM6GtHBzRxBP+PsOOol1mOrO295gaP
         HivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871404; x=1691463404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iAnkpzLogI2LXanWo888CbURkFu1KKEAFkxyuV92gg=;
        b=bGZ+Tjut/thDVkyXZFV1rSth685udzPgEMRnrDyxg7a5QGa816h5ut4WrQQx0R+B/X
         oLlobJ33HCcOSwHqBKYBR+GRZpQuOxKpIk4clZub2LJMCOUzHgpfT73Iy347s6V8BR4E
         s/WD0iP4iFVJFwRs7H0kWdWpmY/dFnQFcn1hWP+GNLORJpTmXd/AADWGNl8Bzk1My9vl
         Gj/EB52mj5No15izeXKd4v0PJO75fL8Futc9AS9N1ijfGK8F4FtwOaU4hTrKXNAnFk2c
         a1wx9vC2J+zmjGLx/cPzQA7aOY4ZH2X8IEkWSCK8lVRIfMRUVUyYwfqyN/XUjQ0Ab/Vo
         tZZg==
X-Gm-Message-State: ABy/qLZLcYVWqUIp1mzNtPOAXkgfMDZsXQBC+SwTr6TQWxAr9S4qX3/P
	mRsiNb9QvWflqSUvAc45ZM4=
X-Google-Smtp-Source: APBJJlGBZVM8YBaVkA8uaK6Sk8WIcsfCchjh4msqTXjqwtAHrUPENvbH6aehIksEM07KlgOAxJtihg==
X-Received: by 2002:a05:6a00:2d20:b0:67a:a906:9edb with SMTP id fa32-20020a056a002d2000b0067aa9069edbmr12418558pfb.30.1688871404132;
        Sat, 08 Jul 2023 19:56:44 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:43 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 00/11] bpf: Support ->fill_link_info for kprobe_multi and perf_event links 
Date: Sun,  9 Jul 2023 02:56:20 +0000
Message-Id: <20230709025630.3735-1-laoar.shao@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

v6->v7:
- From Daniel
  - No need to explicitly cast in many places
  - Use ptr_to_u64() instead of the cast
  - return -ENOMEM when calloc fails 
  - Simplify the code in bpf_get_kprobe_info() further
  - Squash #9 with #8
  - And other coding style improvement
- From Andrii
  - Comment improvement
  - Use ENOSPC instead of E2BIG
  - Use strlen only when buf in not NULL
- Clear probe_addr in bpf_get_uprobe_info()

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

Yafang Shao (10):
  bpf: Support ->fill_link_info for kprobe_multi
  bpftool: Dump the kernel symbol's module name
  bpftool: Show kprobe_multi link info
  bpf: Protect probed address based on kptr_restrict setting
  bpf: Clear the probe_addr for uprobe
  bpf: Expose symbol's respective address
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Support ->fill_link_info for perf_event
  bpftool: Add perf event names
  bpftool: Show perf link info

 include/linux/trace_events.h      |   3 +-
 include/uapi/linux/bpf.h          |  40 +++
 kernel/bpf/syscall.c              | 180 ++++++++++++-
 kernel/trace/bpf_trace.c          |  49 +++-
 kernel/trace/trace_kprobe.c       |  13 +-
 kernel/trace/trace_uprobe.c       |   3 +-
 tools/bpf/bpftool/link.c          | 432 +++++++++++++++++++++++++++++-
 tools/bpf/bpftool/xlated_dumper.c |   6 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  40 +++
 10 files changed, 734 insertions(+), 34 deletions(-)

-- 
2.30.1 (Apple Git-130)


