Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A74B0B23
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiBJKmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 05:42:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiBJKmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 05:42:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF40FE2
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 02:42:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ch26so10037882edb.12
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACldz1J+BwQOGN3OqxJcKqTnx4MchwjbpOvWSpw44ZU=;
        b=hr/n0eE9UUYnrsWyKMvdEzK7QfXmlJVQ1bG7mo1veo2e+2BfJu9ZOcEs57vJC0NNv3
         GVHgnzUMMEo1YLR615lgWupbkGBS6eaktZ3HikG4Rx9BuGnIQK3Lq4sdJhNHeJ2W5jh8
         vynivuh8OPhY9RHOhQTDqKxDu1tgmJdH4IphgyfezPs48nKvbKXkM+IDlWNqoQxfSjR6
         EOmjI/Mrylh1RBdo0p8y3c0jlhyf0OGtkx5nDjVBcof+mQBVOtH2sCPTXUD7P2HmC6PG
         DZaMP+q+pkw2Fa2UwuY4x5vxn2X8HZqW2BeNLS4i/CQ2VEDrZfN6PR6UCg2JfOMtORa5
         qMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACldz1J+BwQOGN3OqxJcKqTnx4MchwjbpOvWSpw44ZU=;
        b=DLATfqupr2nmq6Py4qiIWI4Z40Tu+JKBfuk5IuJ1m4QmQdNaVRJvvdO8uRHdDh4/u8
         ahQyngRb6dHt8J1pYG06buPNYH15mvur/eqYQqGRIro4WHGqdt0ubuDekqdWtYA1ktCH
         JKfm0CQoOdiFQR7fp3yJBj5L/xluvVEb1X+/Nz6Di80rdIZsjPWlbgKu+XTb3tZrpITy
         UmBnQl9wYHArjLYajU/ACqvM1BshFgbqy60d/eJ/MzrWVpNfqc8n9Chz2pubFV+ZTE5y
         XBS8zwGv5oB0D5uPHz3DQxZuakmRTvy7ullyNaT70uPXiNZNCMHWiG9wpoNto1zLluxE
         iruA==
X-Gm-Message-State: AOAM530jbGzAaJQG1RtD1Es0n2Ey3fwmQkD6WHIlXgTd9kwn6OC207Nm
        W4UB6PsMoESMNb2jnHdiMm5a6Q==
X-Google-Smtp-Source: ABdhPJySZfs/ZF5+r/kibOa7gGsHZoFVxqg1yj86z7nnik2YTlnxlp802kqyWCEeT513TlyljCokeg==
X-Received: by 2002:a05:6402:f17:: with SMTP id i23mr7626633eda.196.1644489764672;
        Thu, 10 Feb 2022 02:42:44 -0800 (PST)
Received: from localhost.localdomain ([149.86.70.238])
        by smtp.gmail.com with ESMTPSA id w8sm6111839ejo.18.2022.02.10.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:42:43 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 0/2] bpftool: Switch to new versioning scheme (align on libbpf's)
Date:   Thu, 10 Feb 2022 10:42:35 +0000
Message-Id: <20220210104237.11649-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, this set aims at updating the way bpftool versions are numbered.
Instead of copying the version from the kernel (given that the sources for
the kernel and bpftool are shipped together), align it on libbpf's version
number, with a fixed offset (6) to avoid going backwards. Please refer to
the description of the second commit for details on the motivations.

The patchset also adds the number of the version of libbpf that was used to
compile to the output of "bpftool version". Bpftool makes such a heavy
usage of libbpf that it makes sense to indicate what version was used to
build it.

v3:
- Compute bpftool's version at compile time, but from the macros exposed by
  libbpf instead of calling a shell to compute $(BPFTOOL_VERSION) in the
  Makefile.
- Drop the commit which would add a "libbpfversion" target to libbpf's
  Makefile. This is no longer necessary.
- Use libbpf's major, minor versions with jsonw_printf() to avoid
  offsetting the version string to skip the "v" prefix.
- Reword documentation change.

v2:
- Align on libbpf's version number instead of creating an independent
  versioning scheme.
- Use libbpf_version_string() to retrieve and display libbpf's version.
- Re-order patches (1 <-> 2).

Quentin Monnet (2):
  bpftool: Add libbpf's version number to "bpftool version" output
  bpftool: Update versioning scheme, align on libbpf's version number

 .../bpftool/Documentation/common_options.rst  | 13 +++++-----
 tools/bpf/bpftool/Makefile                    |  6 ++---
 tools/bpf/bpftool/main.c                      | 25 +++++++++++++++++++
 3 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.32.0

