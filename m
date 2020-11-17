Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847152B6F8F
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKQUF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 15:05:58 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51411 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgKQUF6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 15:05:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 993EAB70;
        Tue, 17 Nov 2020 15:05:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 Nov 2020 15:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=OwSaGpFUzheZzGzXnS0ZkDLa3p
        7OJ/mlwl9RnwCagmU=; b=KXD1+/XsQfB2V70wGjMFd8Y6UwBBTV1QvvR7vz1yST
        JPV2l7uSCwxYfCgWvVtqKQDwYGYkfVrm0c1MSHH2qtlxLHEsJu2/hInoExU2aUlg
        fuamtSCbdb0BBKdYJMaKVAQqfj5jXfVUJQo78BFK6VZM3E2338ZpYkYYU4GNlB6U
        7lBfpwDaCt7f/ZvDQCp0HSHhRLJHCs2JcuqxWvHDqhsUwRDp40pkO8brArK99V5s
        XS+KZcb+zgXALSfFc+c4BGZvcbkFqM8rRr4ae8kUiV8F04FOs41q672f7uzuF1fd
        EjurtNHowDK4L6qY6RwC2HlaJ980yHMi8rXCnXCQ0hRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OwSaGpFUzheZzGzXn
        S0ZkDLa3p7OJ/mlwl9RnwCagmU=; b=NgVN8p8t8PgPYds6WOtsAC3GuP78cWBb1
        8U4vkV5MU4jDnypt0QbTFmjE0Zlxsb+zFoVt7ycMtwzaLESkJ2Re8TATiyF6PzdA
        FUrE+3YfwbPwpR53wOZ6sYFuraAQTmHmAG7pWuma6UKETSYlgC42rob8IbaAnu7r
        /LYDXXHC1H1ur90wUVDTdIRSq1RKmWwV2ZEa/IOfrrH7FpG1Glcfr7NrkLgstmb0
        JXuLX1F/dBP7mOtJjehpci5ZvkOmYITLVLLxt7RvEoKeONy2OSK+oA3uQQKAteK8
        M9kpN4AgLMXe99RqJolYBacKV7PQ33XCjVOxayEU9ns/zYbYbaiKQ==
X-ME-Sender: <xms:Iy20X2hAAafFDCyvwLaSkk9BLI6Zb4xwMNQf-HkwsLZYa2NT5NVLIg>
    <xme:Iy20X3D4OxMnGelYBGv1CDOnws3-hSQIvzKuaNggYcfJHbeeD_1NSLCV3CN0hr-ER
    eVwTRRKRNkcFc0rdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeffedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvd
    etfeefiedvfeehieevveejudeiiefgteeiveeiffffnecukfhppeeiledrudekuddruddt
    hedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Iy20X-G_XTD7JHBNS41zLkadRX7lMp8bwL19ckIEp6i-X1JfxEym-A>
    <xmx:Iy20X_REnhjnjuRJotmwOIQRk1GyJ1j7apI6XCYgd0Zk8NLqvu6wgw>
    <xmx:Iy20XzxYihIeK3kkKTPUs2RVGY4Xy3iS7h_Uo3kMCpQiOWcCWLvsxw>
    <xmx:JC20X6mPX0RbiOTgtuvQf7P9E9wYb9hRcqXt1cxfcKfJDmpMI6ZD6A>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 274DD3064AAA;
        Tue, 17 Nov 2020 15:05:54 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v7 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Tue, 17 Nov 2020 12:05:44 -0800
Message-Id: <cover.1605642949.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
kernel}_str helpers") introduced a subtle bug where
bpf_probe_read_user_str() would potentially copy a few extra bytes after
the NUL terminator.

This issue is particularly nefarious when strings are used as map keys,
as seemingly identical strings can occupy multiple entries in a map.

This patchset fixes the issue and introduces a selftest to prevent
future regressions.

v6 -> v7:
* Add comments

v5 -> v6:
* zero-pad up to sizeof(unsigned long) after NUL

v4 -> v5:
* don't read potentially uninitialized memory

v3 -> v4:
* directly pass userspace pointer to prog
* test more strings of different length

v2 -> v3:
* set pid filter before attaching prog in selftest
* use long instead of int as bpf_probe_read_user_str() retval
* style changes

v1 -> v2:
* add Fixes: tag
* add selftest

Daniel Xu (2):
  lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
  selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes
    after NUL

 kernel/trace/bpf_trace.c                      | 10 +++
 lib/strncpy_from_user.c                       | 19 ++++-
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.29.2

