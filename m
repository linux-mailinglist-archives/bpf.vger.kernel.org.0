Return-Path: <bpf+bounces-2929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4B737187
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92BE1C20CEB
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AC168BA;
	Tue, 20 Jun 2023 16:30:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA217AC5
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:19 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB210A;
	Tue, 20 Jun 2023 09:30:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39ce64700cbso3797241b6e.0;
        Tue, 20 Jun 2023 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278616; x=1689870616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uw8xFghZACHfpfTlPJ5+GUSznmqFHJLwRA11RjESET8=;
        b=ed1t9uhNIYuXH/mWAopT6d+KDokjY5Bjlrd4Rc/prnTdWGjRJnTH2+gQYRc1EP1MrM
         yp4ZRWAM1uQe96nqdfcGn9rUjh9xRTTexNQmzlIVfB3ZB6EJLNGhdePx3gAx3JVmQrAE
         ZZqx1Pnh3CFC39/gOSC1JX9wj1LSUhTFc9IjduRo5ylRY/RvFcx7UYlUgHWvr6uh4fkn
         hrrfhkZX/GhJYRDSbhrlHg9l3n4I1HC+sCS1C5WSssHpjztPpatAEYiIjcPsG6uiq1pA
         S4oixdVSOJySiz2aYVF5yS6lCdcC8eUf31u9f5aJ8rCGfM5JInGG5jTZZtvSpW3/uYH6
         hDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278616; x=1689870616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uw8xFghZACHfpfTlPJ5+GUSznmqFHJLwRA11RjESET8=;
        b=kCis13uGnAnn4A9YZA+PapczoBEtNVLDsb8lEOQ/F9Npy0UoYGc0nqTuNs1tPyiA2j
         jJ4PAFoiKCqdGOBsbWl1t/y3GvblO0umsDj43Oh2kVX7PaRz5tThjZ5QG+bZ9rUr0UNh
         /0VVtUEH6v0j0tFgVBL8Y3Vg/828dZR+OmExOyL2SdkcAxhhXwBw5zCiQPfd2Jhz1vvs
         wPgl72gInzUEcYOSj8OVN4jNhV82mfwj6V1pvTQL9Hx5VoQE1WYmBJz6eC8GQzD7Kr7F
         qXjLCbozwEyESDQkIfSlGSO8ToPTVyboTMqBbN1HjnEEnfxgCM+/ST4UhBY9b0qGhwXZ
         ct4w==
X-Gm-Message-State: AC+VfDyuTXiLMw5BdBaqro+ysQzoDC6Tb1cawMzrrUa5fj8iCEifkVGI
	XP+6VKC4j2aavm22Vis1re8=
X-Google-Smtp-Source: ACHHUZ4kGZiv869CKucv2ru87YD3BX6kCpnR4+qySIPpvmbHTVoKCnoaleokMTXSTEguyLf4JFvQ3Q==
X-Received: by 2002:a54:4383:0:b0:3a0:4282:1153 with SMTP id u3-20020a544383000000b003a042821153mr761417oiv.40.1687278616560;
        Tue, 20 Jun 2023 09:30:16 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:15 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 00/11] bpf: Support ->fill_link_info for kprobe_multi and perf_event links 
Date: Tue, 20 Jun 2023 16:29:57 +0000
Message-Id: <20230620163008.3718-1-laoar.shao@gmail.com>
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
  - Rename struct perf_link to struct perf_event, and change the names of the
    enum consequently
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

 include/uapi/linux/bpf.h          |  41 ++++
 kernel/bpf/syscall.c              | 183 +++++++++++++++--
 kernel/trace/bpf_trace.c          |  32 ++-
 kernel/trace/trace_kprobe.c       |   7 +-
 tools/bpf/bpftool/link.c          | 413 +++++++++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/xlated_dumper.c |   6 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  41 ++++
 8 files changed, 705 insertions(+), 20 deletions(-)

-- 
1.8.3.1


