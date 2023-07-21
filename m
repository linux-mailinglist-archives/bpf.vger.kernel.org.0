Return-Path: <bpf+bounces-5597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD775C306
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879391C21658
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1B14F99;
	Fri, 21 Jul 2023 09:27:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772B14F8D
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:27:39 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA932D7F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89114266dso13207095ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689931657; x=1690536457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CnfO3rFMWxUzDFhqcplRljhCu5iMPxBpyDhU2kdczY=;
        b=i/+xMVjLNDjnoq5IN0OwlrMGv8eVyUyKl6gyhEFikgDU3JHDAz4HHWDLUHaRDZivlz
         z+GW5vMSvKkyZrnlTzG57/MRsY2Z1QQoK1Zb1W6g0cHG96glBYefy4jgXdgALUw4dNhS
         JBOrwIugiVjij9VdxS7sjIr+fIdOkqaTM1rLcT3P6U3O0jeZNO3MZcVI6V4vy7LdvbL1
         P1PTohXVkfGSnXFkz6G5IPAz/CG84jt+/WWNXpIG05DYs95CJSa7D5BQWfYSYjrSoys4
         9ANUoAl4o+PfDddJ+aolvG5EX0h3/tFlYvDThw22/8YADsJySEJNYvnTojZdV6/CHqtm
         +9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931657; x=1690536457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CnfO3rFMWxUzDFhqcplRljhCu5iMPxBpyDhU2kdczY=;
        b=K2guBtDZDWX7bTMiUoBO7O4Ani+0GYgM+N1lHa/SHYlo5xRZPyvXBPQegZPAQuwlEq
         yu7EvIIyCt1A2YsLSaZHeyqJrT4IdEAOzE7qbGv2BvGTpHhb6UgzkZZZloYP+ZOHxcKs
         Eyt09FY7oYmhLeeayaWNtuniCUX+zsaOmIe+9Kl1g8Kyd/X1hmkD398b+1GH51nQIAqn
         HySjWQ9B25C5bD/PSxzyD7NT7u0XH4grc74e6jD5BycTnd47E2Rg64ZBrW07kZIQUbux
         WG2kR/IRIqMCJtPpmD0V7xyRFx8BzHYxGaQAzUTkwOMqHzcC8t56IoQLVuzkIcyqjkDl
         cvKQ==
X-Gm-Message-State: ABy/qLY8crAqC4IiiaTHT7E/ipPG1lx/8+SBo5IidYOZcE7FsWUH1yC9
	2apqBKLx6WJ6AjwA1ph7O5BH5Lm7frnyWg63XlI=
X-Google-Smtp-Source: APBJJlFz3gdLV46BV+f6Ob53Oua+krO07yTL2qTXTu0Cp/jC3z45Hygk9NwNHiPi2bsgNbdGAlOxBg==
X-Received: by 2002:a17:902:ec83:b0:1b8:b41e:66b4 with SMTP id x3-20020a170902ec8300b001b8b41e66b4mr1623647plg.67.1689931657386;
        Fri, 21 Jul 2023 02:27:37 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1303:5400:4ff:fe83:cf8a])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm2911072pls.285.2023.07.21.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:27:36 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix fill_link_info and add selftest 
Date: Fri, 21 Jul 2023 09:27:23 +0000
Message-Id: <20230721092725.3795-1-laoar.shao@gmail.com>
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

Patch #1: Fix an error in fill_link_info reported by Dan
Patch #2: Add selftest for #1

Yafang Shao (2):
  bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
  selftests/bpf: Add selftest for fill_link_info

 kernel/bpf/syscall.c                               |  10 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      | 232 +++++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c      |  25 +++
 3 files changed, 262 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

-- 
1.8.3.1


