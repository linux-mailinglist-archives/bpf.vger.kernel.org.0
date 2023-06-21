Return-Path: <bpf+bounces-3010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670F738284
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E4A1C20E3F
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934F156CD;
	Wed, 21 Jun 2023 12:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A58101C5
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 12:00:59 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F09DE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e3b15370so3285720b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687348856; x=1689940856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBr3lFYZYCu1UlHDbgQr8An/2Skd/8Lffar44wLUa4k=;
        b=G7Ey1bi9TG8ZeG1xM7MkTCFISKMSg5wGRVJkmbLFcXntoJvy1Xxi+xVS08QktCL5el
         OC1UToxlFMdL6Wnj+hNQvA2QHUqf4tpVwvz2/hjQVGzqAspOM0ldCTtUcbBy6sDZY43z
         D5oY/UNrNrUyLVlypfrUzt8G2IbolY5JKqDLSBl+GEF4WdblpJ9blEFSUJb7Nlcy37zH
         N5IC7Xe/59MBw3QxHnHZVTw5BTasK9ymOWLHFIaheqtGJN/SyOxUxufszt3Fw3cZvVow
         vEWOTjEHJRpxpADCn5O+dKTjC0xS1u+JYOSLlzqqNI4G8EA18Dw8y/tbuwMmASTKZsIK
         73Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348856; x=1689940856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBr3lFYZYCu1UlHDbgQr8An/2Skd/8Lffar44wLUa4k=;
        b=UuOJfUiZHoLfNfutnux6o1ELhrEhdEgxeaxIggHhMmnAgtzXfZSUQO+pQ2n5RVc+kW
         66JekfCgoKWdHuKBvLfd3jTgM0QR7ZJgBjVzPr+k/vDV74Ssoe84P5B3owLLyMnW/nc4
         fECQC4Ikv5WJFaz9lvd5QW6JDxSPWQWIghWuHtluYIJwFwEeYftq7MUZByBPaQ3sBc12
         oZvylvz2y5Px40QsmG/ZV+bkkIUertKeVokoVEsKO4k9AAF1+CUVa+2ltM0CL9kymhix
         wYWCBVAz51XckDYAd1+BbjNDYpNYmu/3T9TBqeolmNa2YrIW64L+k96Su9G2/Ohgzt2z
         IO8A==
X-Gm-Message-State: AC+VfDwfMaVuW4ZbyMn1EjLA5waS6DP0uYGAPWRVCGfMfh++ux/yGIM2
	9dlJI717YGezwjjXCO0uCd8=
X-Google-Smtp-Source: ACHHUZ4Yl8mh8He7tAmKXjdK1P+/vCQWlCFeMqb9AfOD23i28aS52XzkegCawkft2wbhlF3ubrDIuQ==
X-Received: by 2002:a05:6a20:12c7:b0:10f:f8e2:183c with SMTP id v7-20020a056a2012c700b0010ff8e2183cmr15453862pzg.51.1687348856355;
        Wed, 21 Jun 2023 05:00:56 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:32e:5400:4ff:fe7b:7461])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0066887dc50easm2810620pfi.3.2023.06.21.05.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:00:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next] bpf: New bpf helpers to get perf type of [uk]probe 
Date: Wed, 21 Jun 2023 12:00:40 +0000
Message-Id: <20230621120042.3903-1-laoar.shao@gmail.com>
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

We are utilizing BPF LSM to monitor BPF operations within our container
environment. Our goal is to examine the program type and perform the
respective audits in our LSM program.

When it comes to the perf_event BPF program, there are no specific
definitions for the perf types of kprobe or uprobe. In other words, there
is no PERF_TYPE_[UK]PROBE. It appears that defining them as UAPI at this
stage would be impractical.

Therefore, if we wish to determine whether a new BPF program created via
perf_event_open() is a kprobe or an uprobe, we need to retrieve the type in
userspace by reading /sys/bus/event_source/devices/[uk]probe/type and
subsequently store it in global variables within the LSM program. This
approach proves to be inconvenient.

Here is a short example of LSM program.

  static int perf_type_kprobe = -1; // set it from userspace
  static int perf_type_uprobe = -1; // set it from userspace

  SEC("lsm/perf_event_open")
  int BPF_PROG(perf_event_audit, struct perf_event_attr *attr, int type)
  {
      if (attr->type == perf_type_kprobe)
          return perf_event_kprobe_audit(attr);
      if (attr->type == perf_type_uprobe)
          return perf_event_uprobe_audit(attr);
      return 0;
  }

Two new BPF helpers have been introduced to enhance the functionality.
These helpers allow us to directly obtain the perf type of a kprobe or
uprobe within a BPF program.

After that change, the LSM prog as follows,

  static int perf_type_kprobe;
  static int perf_type_uprobe;

  SEC("lsm/perf_event_open")
  int BPF_PROG(perf_event_audit, struct perf_event_attr *attr, int type)
  {
      if (!perf_type_kprobe)
          perf_type_kprobe = bpf_perf_type_kprobe();
      if (!perf_type_uprobe)
          perf_type_uprobe = bpf_perf_type_uprobe();

      if (attr->type == perf_type_kprobe)
          return perf_event_kprobe_audit(attr);
      if (attr->type == perf_type_uprobe)
          return perf_event_uprobe_audit(attr);
      return 0;
  }

Yafang Shao (2):
  perf: Add perf_type_[uk]probe()
  bpf: Add two new bpf helpers bpf_perf_type_[uk]probe()

 include/linux/bpf.h            |  2 ++
 include/linux/perf_event.h     |  3 +++
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 kernel/bpf/core.c              |  2 ++
 kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
 kernel/events/core.c           | 18 ++++++++++++++++++
 kernel/trace/bpf_trace.c       |  4 ++++
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 8 files changed, 88 insertions(+)

-- 
1.8.3.1


