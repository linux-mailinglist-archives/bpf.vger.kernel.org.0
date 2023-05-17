Return-Path: <bpf+bounces-698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE54705E44
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634BE1C20C3F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC62116;
	Wed, 17 May 2023 03:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0817E0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:45:21 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750730E8;
	Tue, 16 May 2023 20:45:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53202149ae2so134187a12.3;
        Tue, 16 May 2023 20:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295120; x=1686887120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0fdPmeINo3M3GEcsjn+DqgIArQ+TF8t88l9Aksr7VQ=;
        b=Dy5EDllK8uVJFjPdvz1RUbi2yk4rgd1PjqZJX+ibJORvvteuhARUVlChiDWi2GdYyj
         ornOQnlZWAccsQTsX9fLi2XGvQ4x2OgrV6l+T2ZMZvd75JIePFW+SoFmsNoYqlf4tmj6
         mu8MFImYX/tmrIswvc9vSL7jdvTVtA3XMoOw2H5DMKVzaHKqWcXvCHVJhmLlIYe3M0zg
         DYvxBvbgYH6iW3+axk10pT1phM6PW493USZleI0YoHLDNsChz3x3uojs4ai7zGPrwo1S
         IyPBHmYqqM0fciz6V34Z9NRne8SpZebj4C4tOarrPY2uQ/ucSWcFEYkSxS9uD+fy6URe
         cVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295120; x=1686887120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0fdPmeINo3M3GEcsjn+DqgIArQ+TF8t88l9Aksr7VQ=;
        b=l0ksyFCRoVbMcBPmlWi6PK9EeCg7RZBTX08SVqJn2wRD7oqD0FqHMRv+13bREZ6NJO
         8KI7e2gbgWLm02wYBaMd389o/UcMDzSci6yEdk0M9BFnWNMEydtVdWWoR3EgFo92bZNC
         /gtZtydupaC0Vk/2oLLAd/yWgv0l19zC+4xWwR0DWQcDmknLPzNU/B3UMTAh1xgalzYa
         ri9b7rjawpMozv/CEIa/mewKQ2fC4CtwyroQ1bSMu0p2fbe+wTpsPLY3PAi0pAuGWCea
         BIHEQqdZ+LbabjQFDhsEm4dmkrCE6N5eA3MjEYp/dvPWNi4nPOPyVLTCcH/WV4XmAA70
         EEFg==
X-Gm-Message-State: AC+VfDxvMh/x76YgZmG+c7gIxnNWJP8uuR6L2adgGKyMMz7p99FkhQrw
	vLExXrQc46eykkQMW9Rg6z8=
X-Google-Smtp-Source: ACHHUZ4ZIj8959vfQi1i7G2NHQaO5ugC9tIBfRlSHL/tUdJglqovvvIgcNxw0ueQxt1v5RcuroWL7A==
X-Received: by 2002:a17:903:110f:b0:1a2:8c7e:f310 with SMTP id n15-20020a170903110f00b001a28c7ef310mr48043595plh.35.1684295119892;
        Tue, 16 May 2023 20:45:19 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id t2-20020a170902e84200b001a19196af48sm16336746plg.64.2023.05.16.20.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:45:19 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v3 0/3] Make fprobe + rethook immune to recursion
Date: Wed, 17 May 2023 11:45:05 +0800
Message-Id: <20230517034510.15639-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

This is the 3rd version of patch series that fix the ftrace rethook recursion problem.

Changes since v2:
- refine commit message of [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free

v1: https://lore.kernel.org/linux-trace-kernel/cover.1684120990.git.zegao@tencent.com/T/
v2: https://lore.kernel.org/linux-trace-kernel/ZGP4ypidaxQGdp7Y@krava/T/#mb9e74fe74d5800ee424234b26c6def9d5135237b

The original discussions of this bug can be checked out here:

https://lore.kernel.org/bpf/CAD8CoPCfPmqZH6BJCk3Y1-02BLVVsbQ6OeaNOhcfGWmdF0oX8A@mail.gmail.com/T/#t

Ze Gao (4):
  rethook: use preempt_{disable, enable}_notrace in
    rethook_trampoline_handler
  fprobe: make fprobe_kprobe_handler recursion free
  fprobe: add recursion detection in fprobe_exit_handler
  rethook, fprobe: do not trace rethook related functions

 arch/riscv/kernel/probes/Makefile |  2 +
 arch/s390/kernel/Makefile         |  1 +
 arch/x86/kernel/Makefile          |  1 +
 kernel/trace/fprobe.c             | 73 ++++++++++++++++++++++++-------
 kernel/trace/rethook.c            |  4 +-
 5 files changed, 64 insertions(+), 17 deletions(-)

-- 
2.40.1


