Return-Path: <bpf+bounces-2101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F243727CE3
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CF12816C0
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5D6FC0;
	Thu,  8 Jun 2023 10:35:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5045A3D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:40 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF42D41
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9cf20da51so2782101cf.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220535; x=1688812535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWZUpxEHtPBIDxpvzCjfge4n/BdRO2xikJERIG4l47Y=;
        b=mNJkiF1iQhIw6+zc0RFq9W+cr6pchFIZlR8zGHW6g6SBPcvusF/ZoAxAqA/cPjVs1C
         yY+Aj7iZKzmaMf8ya30FE+/fG2Njn1wB1PuR3KMnXKVM3c024VVe7sWK5wjJDaLj1lgD
         CNkYbVEX31xcdEQDx3jO167pJmHNpAWZLmbePU8xOfTVL41sFYGpuw4tvQ4r/wG4T2QX
         yom+m4f4jhuGeZRfoKKQemlTeNHeLdlOsu0z75PgFLpDy/1VjxVSW179pOmpKBANVWui
         cg4/JTGWITlBCnebBIUuzkiQA9HxtZB8BE0elDUQuu/XS4WsHAEbboJW4afMqkGxY0Y0
         lx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220535; x=1688812535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWZUpxEHtPBIDxpvzCjfge4n/BdRO2xikJERIG4l47Y=;
        b=YLNevNl3ISPlQMFoiWvgn1NDzRVDcph0wXKrbG8//lCY8FFvHvoUKmk9o7wUyt5LmN
         kmkPFU/X/MbxTDyaueIsc5xnhZn2kZwOKZ0G+0zJncBs9VoURhJaNb3DYyUnY2YNFKJV
         19y+45kWQxjz56+pANoMT5dvCwcjPTsAgFnZAz9VvVfcnDYFkUEGi2kxeRjvusF/EyVu
         VflHh6aHmotYyGieeCLX7gacN+C+2cFs8ycpAcE4bUdwUen5nSF6GRtKD88A0CSJggcU
         RltXNGJn6849wMxxTe0+SEMvqZRt6CUnlCorYr4gy5mmxLxcUPGzyLxlTduDPa7+Q6q5
         H6kg==
X-Gm-Message-State: AC+VfDxgLfeSF4tiZ1k8LxI6koEFlWgkpxkmIPYMygIhf72hqK2p9cKX
	X9FM4nGqr3XvYJcm9ZBwCJs=
X-Google-Smtp-Source: ACHHUZ6QIrLQwMkkkyzmiqIQ/gHF/+KduREcXgAIAMVTR13u093JaS+lVJAfpO7mSdKdyTq08MzyXQ==
X-Received: by 2002:ac8:5f90:0:b0:3e3:8ed5:a47e with SMTP id j16-20020ac85f90000000b003e38ed5a47emr7998716qta.10.1686220535529;
        Thu, 08 Jun 2023 03:35:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 00/11] bpf: Support ->fill_link_info for kprobe_multi and perf_event links 
Date: Thu,  8 Jun 2023 10:35:12 +0000
Message-Id: <20230608103523.102267-1-laoar.shao@gmail.com>
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
  bpftool: Add address filtering in kernel_syms_load()
  bpftool: Show probed function in kprobe_multi link info
  bpf: Protect probed address based on kptr_restrict setting
  bpf: Clear the probe_addr for uprobe
  bpf: Expose symbol addresses for precise identification
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Support ->fill_link_info for perf_event
  libbpf: Add perf event names
  bpftool: Move get_prog_info() into do_show_link()
  bpftool: Show probed function in perf_event link info

 include/uapi/linux/bpf.h          |  27 ++++
 kernel/bpf/syscall.c              | 132 +++++++++++++++--
 kernel/trace/bpf_trace.c          |  34 ++++-
 kernel/trace/trace_kprobe.c       |   6 +-
 tools/bpf/bpftool/link.c          | 299 +++++++++++++++++++++++++++++++++++---
 tools/bpf/bpftool/prog.c          |   6 +-
 tools/bpf/bpftool/xlated_dumper.c |  72 +++++++--
 tools/bpf/bpftool/xlated_dumper.h |   3 +-
 tools/include/uapi/linux/bpf.h    |  27 ++++
 tools/lib/bpf/libbpf.c            | 107 ++++++++++++++
 tools/lib/bpf/libbpf.h            |  56 +++++++
 tools/lib/bpf/libbpf.map          |   6 +
 12 files changed, 719 insertions(+), 56 deletions(-)

-- 
1.8.3.1


