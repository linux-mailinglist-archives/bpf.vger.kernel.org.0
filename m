Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A852A8B1B
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgKFAGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:06:47 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33541 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgKFAGr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:06:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 77B735C0238;
        Thu,  5 Nov 2020 19:06:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 19:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=7xsynmTgqhqmmABRwsUDwqOu5v
        23z8b/ouobTL9ZhgM=; b=Uw6r1IQ4lIgKUdRqmClAU4HT8VztZYqdv9rteT1+uf
        wdca3/endcJpM7esZEELMw6jGa7VH/gjaSG2JMQWSHRz+FTRjQzUAztLgWktpGql
        67TlbvVSYYZPddkY1KTfPo5Hfmtm96jGdJa1FtL7fzJ0NimeV0aHn7Ae9zmtGX07
        kzJsrBYtlPGFnwWFGh6Q2BeZapB2CF7foAAoqNVH5xD8wQtVdJMNk3wIgEV4Rhw3
        hleHRJp8ossBLT5N9v8IJXEoZnBtu7Jx1jcAmm+j+ZZYn/xXGjeSb9x0M280oFUb
        Myl50zCBNjJKM9t8gWT7mNClkZuZeo/BKXbymJGui7Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7xsynmTgqhqmmABRw
        sUDwqOu5v23z8b/ouobTL9ZhgM=; b=fw1zaxLnBzxMxHxTJ9ODBsa3gdtZthpxa
        cwCS8IpZNcsYGY7AEFeBz89cidwa6qO22y9SAvytVZcVp27TdkKYEVzhwFTVyVtC
        L0APiHHKtNlLy6c0I/Bhbyc10nUbdoPUa6rtty+Qtjv685RRvhexh2jXlht0nURp
        IaYkEqobICmRj5T74OozqXKNpTgDeXg8feXU2F1rNIpqwVrMAkZgfYFbWk9eAZMr
        +VUVd4zczTpZV1Bsd9d3Lts+FoqFLkrYX5mNHARBQFaO1gW9m0Iysg4+RvCuq0lE
        IwWVdT/pvNA2ShBX2LbN1RQQ44tBj3cvkwzT8vZH9XGymZzPSpc+w==
X-ME-Sender: <xms:lpOkX3UJYuuvSJPJJB0KE38KepfBDjorOrU5Fyf0TRsUhTkXQrXU7Q>
    <xme:lpOkX_lAD8M5ENpyYELiWCyHVmtnK0YiYw8dUt5uUGwO4mt6Kj5ACZb1aDNlD3Hpc
    VAN1dB25f7JDbpRQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepieelrddukedurddutdeh
    rdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lpOkXza4yoxGinqOrjd4bo3w1iQaRAXQ8kKLxWSDgEv3vc5glGs-sQ>
    <xmx:lpOkXyVffP4xeQnv9Aw5PYZWBP8wMrJ49t77-2J8Dmf50gqQ5KoMWQ>
    <xmx:lpOkXxmFzyAX0Fkhj6sNR4SlT_4Mb0BVHQSjTbXPle3aIvF5EcZc9Q>
    <xmx:lpOkX0u3y6S6uxEC6fKjn9NF3vbVL6md27xlNn9VP39hdq_kH2t2YA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49ADA3280391;
        Thu,  5 Nov 2020 19:06:45 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v4 0/2] Fix bpf_probe_read_user_str() overcopying
Date:   Thu,  5 Nov 2020 16:06:33 -0800
Message-Id: <cover.1604620776.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
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

 lib/strncpy_from_user.c                       |  9 ++-
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 3 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

-- 
2.28.0

