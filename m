Return-Path: <bpf+bounces-604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD6704623
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A762811B9
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D881D2C8;
	Tue, 16 May 2023 07:18:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DA23D6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 07:18:49 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F419A;
	Tue, 16 May 2023 00:18:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f6461af24so9604156a12.2;
        Tue, 16 May 2023 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221528; x=1686813528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnAI2sXUbiQvd6mgY7NnxOBWPf3gGQ8XWTI5xmKxwWU=;
        b=np4y4iLNUIexTfiyIkMxgYRriRCWr8e/v0OflxMm2NmIfb1jr2jheNFm1Ks54g+2f0
         yCdYdJ105s74b2lGBaMJLO0sY+u2TSGBBk/upTjlyWrV3Rs6gbgs5BY1+Kq8xDzyI+qs
         or9CRP5q7DogGW9pPPIMj3dhNLzm4sJV0HhgI2UuKgXUPRqEE9qfYM773droKbYS9THF
         3LheMjghgJSOiC7tR5xsEGfU1ycFZGm9Ifcvu0Sj41VX3pRDwF7ieFsEAz/F0fB8KzhU
         xZbMj9nEIukEPVK/IjlfIdLQjS86Sr7zMUAEtRTHXSlv6XbORqIwDInXPJvWyHYibCgD
         yAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221528; x=1686813528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnAI2sXUbiQvd6mgY7NnxOBWPf3gGQ8XWTI5xmKxwWU=;
        b=Ll16AUr5XYXwy2QrzQusSZ/TJshAbctUagrMJL54lEjqcMbEl8AY4ItnOgPZBEaJ0n
         hNli2kmkZYIVePYCMG+TXCsKwUr8B3hdizAv3NWgE3npwvRb5cnuO4MUsqpU8fcrO+Gt
         UsrPCKK+nwA4plhHURnStwufJDdpy7vRl0xFwuAUmQ/ZjH0Ayhm5JZ0PhDVgbg8Gtj/6
         2MOYoYNEaT+3gJhSzcnxT6YlIX8SBr4H05fGiGHlHYhM/yuoTYUU2SKexV3kh8Mc7JfV
         dPH9XsKaTAi8hqnX2zVd8KjqeXufovSMU5tfVns7psM2UkPVBHBvzcDL0Yq4vhnhQUWt
         RCkw==
X-Gm-Message-State: AC+VfDzRKkp/W5THEopU52RNPyBD2NsANIJQ06crO7t/LUYD563CYT19
	wSJtBmKxyUpOruFPE9Jy28E=
X-Google-Smtp-Source: ACHHUZ6KLgde39yA7rEwU9DsLAFJhMvVZ4vKy7KxmS68J67q5sb74zy1V8UcYpfyCJsfvq+z8inB3Q==
X-Received: by 2002:a05:6a20:3d82:b0:104:2200:8949 with SMTP id s2-20020a056a203d8200b0010422008949mr21473230pzi.56.1684221527736;
        Tue, 16 May 2023 00:18:47 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm12849830pfp.48.2023.05.16.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:18:47 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 0/4] Make fprobe + rethook immune to recursion
Date: Tue, 16 May 2023 15:18:26 +0800
Message-Id: <20230516071830.8190-1-zegao@tencent.com>
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

This is the 2nd version of patch series to fix the ftrace rethook recursion problem.

v1: https://lore.kernel.org/linux-trace-kernel/cover.1684120990.git.zegao@tencent.com/T/                                 +++#md4c0bae6a6cae28dadf2a2c6105ff140b35fddea

As Steven suggested, this version removes unnecessary notrace annotations from fprobe
and rethook functions from v1 [PATCH 2,3,4/4] and replaces with makefile changes to filter
out compiler flags which ftrace depends upon for rethook related objects.

Ze Gao (4):
  rethook: use preempt_{disable, enable}_notrace in
    rethook_trampoline_handler
  fprobe: make fprobe_kprobe_handler recursion free
  fprobe: add recursion detection in fprobe_exit_handler
  rehook, fprobe: do not trace rethook related functions

 arch/riscv/kernel/probes/Makefile |  2 +
 arch/s390/kernel/Makefile         |  1 +
 arch/x86/kernel/Makefile          |  1 +
 kernel/trace/fprobe.c             | 72 ++++++++++++++++++++++++-------
 kernel/trace/rethook.c            |  4 +-
 5 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.40.1


