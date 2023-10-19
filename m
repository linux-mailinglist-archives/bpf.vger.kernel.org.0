Return-Path: <bpf+bounces-12732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1237D028C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5677A1C20F1C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5339874;
	Thu, 19 Oct 2023 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pAymNkQc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952839853
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:32:15 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915CE8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:32:14 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7d9d357faso104449917b3.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697743933; x=1698348733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHL3LoeJEBuYgwhW8+XznlRVx7FaVqLWRec6REg7r0g=;
        b=pAymNkQcz4NwbsJjgMlMlwFBP9x/lUtAQq3b51gaKqDqlpqR58UgwBaM1C/yNTuGzq
         ym2RlNcdDQHNgyUI/ezho5AkYFG6rl7mE2uoDdh6i5KLKprFRTwVvJ6szPkhxthdQexZ
         faElsNAIF3FZK5FNXRQjF06H4ChAdRCXEOX3/lOA1ZoilpNTqRZfgul1+vucUeFa9cKo
         j/0CDAI6trdWtATvHyMKfXFHvIQ2Y0N2sW0NxWI/HwRsjo67JsHKQDdL7Lfr4GNrTzxd
         X6/dKpjfa0zNJB4gxUjI9SYHZu6gvFt7AqtC5AU9WD3ah2NQtMMW9gUpTPPise1khF66
         AE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743933; x=1698348733;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHL3LoeJEBuYgwhW8+XznlRVx7FaVqLWRec6REg7r0g=;
        b=Yst7qBF9Et4NmWhXygvYzJpEuJKNOcSuJ/GNKvGXof4w5/Ifgc7r4EKVC622dyksnT
         c9JA7zLckvGIsQZ5C1AeNIFOLH+czC2L4xJT6oKidh/L5hopY9Fo2+t1Lr4qCmkbs5w/
         AV1Y+myYnpSObX1O+z7Kl3HeN7vpKv+mw4rmU+upwz6OpX2z0I+QNpujYNGq/DydwyD9
         4TYJPVT+rbV+0+s5FxElZXtE5qhqMXOru1gq7Y0xet/BuRz28r0eyLyWvP52UmumLVj7
         4nWoXmkayWcBua4CMgfa5p/qM68hHSkTwV+QFSU3pZ3SZCKsm7MAQI/xPRpDDU/qa98X
         pfGQ==
X-Gm-Message-State: AOJu0Yyq7FmzclSJy3WtfJc7/IYeKcoWWf6thVRLBZaWy/BdI+g9wCGU
	0xNNnMW3amgf61C/9UNtwcMJjwSaod8WBZ2g1rzuxA==
X-Google-Smtp-Source: AGHT+IErGgo+Q3CcicjqdYsERUwfzLl3OIC8OoChVWQCNgW6geCUIHcGs0KxJtlu6gRexrYsqSWscSiKnA81QEBOZFk=
X-Received: by 2002:a0d:d704:0:b0:59a:b70e:5c13 with SMTP id
 z4-20020a0dd704000000b0059ab70e5c13mr3557348ywd.29.1697743933582; Thu, 19 Oct
 2023 12:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 19 Oct 2023 15:32:02 -0400
Message-ID: <CAM0EoM=UPTp2MKZbGk0U0rHb6srfVQ9djDOAPGtXj=Papw=TPA@mail.gmail.com>
Subject: challenges with DEBUG_INFO_BTF
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

Since patchworks does make allmodconfig it caught a small challenge
with our setup.
The makefile looks as follows:

 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
        p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
        p4tc_runtime_api.o
obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o

This compiles fine with the exception the bpf program that references
the kfuncs will fail to load. Bad for usability of course.

make allmodconfig does not enable CONFIG_DEBUG_INFO_BTF which means
CONFIG_DEBUG_INFO_BTF_MODULES is not turned on given dependency;
This leaves us with two options:

1) Issue a warning, as such

+ifndef CONFIG_DEBUG_INFO_BTF
+$(warning WARNING: DEBUG_INFO_BTF is off. No P4TC kfuncs will be compiled.)
+endif
At least the user will get a compile warning..

2) so another approach is we can force enable CONFIG_DEBUG_INFO_BTF.
Sadly this would require many other options in addition be to force
enabled such as CONFIG_DEBUG_INFO, etc (which is complex).

My current thinking is to leave it as #1 or the variant we have right
now (without the warning).
Thoughts?
+cc Florian (since netfilter may have had similar challenges)

cheers,
jamal

