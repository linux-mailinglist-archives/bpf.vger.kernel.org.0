Return-Path: <bpf+bounces-1658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D971FCB4
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5F92815CF
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1254101F0;
	Fri,  2 Jun 2023 08:52:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1B1C20
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:51 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C3E51
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-568928af8f5so28680307b3.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695968; x=1688287968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcRlSpopP8JkhDRCus1KYwfx2bgsm9nzmVhhj0rrhI8=;
        b=UR2QrhOMFD/0SCJV243UjMjrBK53H5IbFUT4BuBdhA2X/71Lnill0N0bOAv0FeXqqH
         i6zR5yV6KvsYvXgcqJ+SsNknlWjUGvvDYOjpFmCmwT9gyuQiKnZJ0noXRL91hT45ghlD
         tGvkzFevWz3Ne5rXnN1bcajbYjvw1gE54GUHV1cVks9dIWB/h03oDGsMWNk0zOvFUyS0
         dYdd/8jn0r7Vc1Jp6R+3OXkSiDUYt1wYDdM7pI4P0fl51gqxVURXJTHgdTS3ZzIJjRXN
         iJ6RP4F7vVcE2ViAHJFFI2z50WxdQQLwteVFhbe/T7qmopIo3iIzlS612ogs4yrsG7dA
         /1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695968; x=1688287968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcRlSpopP8JkhDRCus1KYwfx2bgsm9nzmVhhj0rrhI8=;
        b=fnUkZQR7yx3B0I/8mZ7njXlQLjMh5jqNLa3FKLfsbE165YmcNuvNlTtRWTQ0r8eDys
         U5zjkSn0kBmKKOZLivDBWmtr3vDGuo+/jrno2Yad3INGKvjQCqshWuF2Thzm6UObl+JB
         AmNTQFQwFfRufipUuhOSkffBfXZ36ELht+hhM7VWZYRJhe+g/GQ+FzIm+80OBqZRUH+G
         xBQuO2Tklj5peiygESyduQTe/ymmfEa+7HJ+0OkTDvnsv+Omwds318nGf0s53Ugw/bG2
         a2ut1qpkffhAlR2FIA1MI1cVsIAFCWYAyjkjC9GdUbl61WC0Ay0GF9ncWq6wui6HmR9d
         8lhQ==
X-Gm-Message-State: AC+VfDxNWLWC/IpJogv6Xzt2fpbKPvufB27lt7uPtHbVzKGf7DcFFqQZ
	Ik5UZQjlvs2r8vcsveBLG/k=
X-Google-Smtp-Source: ACHHUZ5kfx/mbW03IOQaTDD1Hr2HbLgQW9wIR+I192lhJVrBHGrCd7XPU467qM203ZHxdHlFt3jcAQ==
X-Received: by 2002:a81:8382:0:b0:568:cd43:b4ef with SMTP id t124-20020a818382000000b00568cd43b4efmr5334725ywf.1.1685695968173;
        Fri, 02 Jun 2023 01:52:48 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:47 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/6] bpf: Support ->fill_link_info for kprobe prog 
Date: Fri,  2 Jun 2023 08:52:33 +0000
Message-Id: <20230602085239.91138-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Currently, it is not easy to determine which functions are probed by a
kprobe_multi program. This patchset supports ->fill_link_info for it, 
allowing the user to easily obtain the probed functions.

Although the user can retrieve the functions probed by a perf_event
program using `bpftool perf show`, it would be beneficial to also support
->fill_link_info. This way, the user can obtain it in the same manner as
other bpf links.

It would be preferable to expose the address directly rather than the symbol
name, as multiple functions may share the same name. These addresses
will be parsed by bpftool.

RFC->v1:
- Use a single copy_to_user() instead (Jiri)
- Show also the symbol name in bpftool (Quentin, Alexei)
- Use calloc() instead of malloc() in bpftool (Quentin)
- Avoid having conditional entries in the JSON output (Quentin)
- Drop ->show_fdinfo (Alexei)
- Use __u64 instead of __aligned_u64 for the field addr (Alexei)
- Avoid the contradiction in perf_event name length (Alexei) 
- Address a build warning reported by kernel test robot <lkp@intel.com>

Yafang Shao (6):
  bpf: Support ->fill_link_info for kprobe_multi
  bpftool: Show probed function in kprobe_multi link info
  bpf: Always expose the probed address
  bpf: Add a common helper bpf_copy_to_user()
  bpf: Support ->fill_link_info for perf_event
  bpftool: Show probed function in perf_event link info

 include/uapi/linux/bpf.h       |  10 ++++
 kernel/bpf/syscall.c           |  79 +++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c       |  26 ++++++++++
 kernel/trace/trace_kprobe.c    |   2 +-
 tools/bpf/bpftool/link.c       | 115 ++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  10 ++++
 6 files changed, 226 insertions(+), 16 deletions(-)

-- 
1.8.3.1


