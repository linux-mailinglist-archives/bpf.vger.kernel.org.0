Return-Path: <bpf+bounces-2405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BF72C992
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B14281039
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F11D2A1;
	Mon, 12 Jun 2023 15:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D51C744
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:18 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C781E5F;
	Mon, 12 Jun 2023 08:16:17 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-465db156268so1210545e0c.3;
        Mon, 12 Jun 2023 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582976; x=1689174976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1zV05vX5FrXpt+4ScqDlwqn2wRbh7AS+yzbx0x5IFE=;
        b=rmR/cDpWkmFR7Rj8kGucBQmlZ+26ZkX8wN4O6Iy2hCRBgJL9FOo4yzIQcutakdxfvJ
         tWdOb3b+JWEBmMKM6kIOqu4xLTyZhC8cjyo+DBH5/4n1CY0OWPT1g9y7iI3QXbJxh4+K
         q5m0ZbkYk5p0KrkbyEsf9O7NZEGiF+v0YR+qeGw/ZpGmVyWZFZLAtawlpYw4peFaE/l6
         clJ3GWi041l5C0HXRotHMYJBMTXRdSdLxdRmk/FGUOHt4Nf7WUXXegMrFb22oXUjbcH5
         4nrM5Tdpj+5Conty06BlMVyNZUbR06xzJux1+rjvJPZmels6UyxE2rmfr7vbItIOuv2E
         lUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582976; x=1689174976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1zV05vX5FrXpt+4ScqDlwqn2wRbh7AS+yzbx0x5IFE=;
        b=IBOJFj0qdzEGhlwAUQbYx/cAnf6KkvGoD4OOZhHVsEL84xwiwPqz3Ur8wrSFyp2bhD
         MGkn2YlO64dIw91udQPO7HruiRUUM4G+5sUloQWW9tJ5GZJlLYB1TXEZUX+a4Xu7I0Hp
         FYj15Uj2Kt7TlpK8rSiVZ5HXx9X3QxNPpZSZja4imI4mFWKRhHHdTrwGR+dKW3rrdPzK
         4EbIVRdhVKqYMe4BJYVUdnOofYUWDQZX8YpJIVfNrEUUgE6k/Wb+wnshslmlafWyQDY/
         dwXKNNsEtoicUJz+0dZPB0FMo0ucQrrpbh2P6aMVT47Z0j/M6wu1YR/+Nq0R1DWj0dVF
         szJg==
X-Gm-Message-State: AC+VfDzd1zyEYCrBTC734ZRfe1gW8DdhAYuI9RiASdGwZ+NejtNFtspt
	Odzcz5QFlgTyOdG/AsRHkr8=
X-Google-Smtp-Source: ACHHUZ7/f6cuG9bVLe2BRduLqopKNspoei8KhdWswr84bS8R/1QO3Pu4i/XnjlydATWbxWEcpkHNEg==
X-Received: by 2002:a1f:4c81:0:b0:45d:edef:788c with SMTP id z123-20020a1f4c81000000b0045dedef788cmr3844385vka.1.1686582976257;
        Mon, 12 Jun 2023 08:16:16 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:15 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 00/10] bpf: Support ->fill_link_info for kprobe_multi and perf_event links
Date: Mon, 12 Jun 2023 15:15:58 +0000
Message-Id: <20230612151608.99661-1-laoar.shao@gmail.com>
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

This patchset enhances the usability of kprobe_multi programs by introducing
support for ->fill_link_info. This allows users to easily determine the
probed functions associated with a kprobe_multi program. While
`bpftool perf show` already provides information about functions probed by
perf_event programs, supporting ->fill_link_info ensures consistent access to
this information across all bpf links.

In addition, this patch extends support to generic perf events, which are
currently not covered by `bpftool perf show`. While userspace is exposed to
only the perf type and config, other attributes such as sample_period and
sample_freq are disregarded.

To ensure accurate identification of probed functions, it is preferable to
expose the address directly rather than relying solely on the symbol name.
However, this implementation respects the kptr_restrict setting and avoids
exposing the address if it is not permitted.

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
  bpftool: Show probed function in kprobe_multi link info
  bpf: Protect probed address based on kptr_restrict setting
  bpf: Clear the probe_addr for uprobe
  bpf: Expose symbol's respective address
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Support ->fill_link_info for perf_event
  bpftool: Add perf event names
  bpftool: Show probed function in perf_event link info

 include/uapi/linux/bpf.h          |  37 +++++
 kernel/bpf/syscall.c              | 158 +++++++++++++++++--
 kernel/trace/bpf_trace.c          |  32 +++-
 kernel/trace/trace_kprobe.c       |   7 +-
 tools/bpf/bpftool/link.c          | 322 +++++++++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/perf.c          | 107 +++++++++++++
 tools/bpf/bpftool/perf.h          |  11 ++
 tools/bpf/bpftool/xlated_dumper.c |   6 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  37 +++++
 10 files changed, 700 insertions(+), 19 deletions(-)
 create mode 100644 tools/bpf/bpftool/perf.h

-- 
1.8.3.1


