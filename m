Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4AD119C05
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfLJWM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 17:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfLJWD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78725214D8;
        Tue, 10 Dec 2019 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015408;
        bh=/5fAVxxUjSZJE4xH7IhLJ3O8MJfUsscc+boLpoxHZKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yC/0tsArmwax6tMLh0MiNGvn2zcihBFd+kRecOUH7RDW1KxQWAzZYOg+sQ5gB34Hn
         dHNfsahBQYo2iygtn55eHzeVeYKkj25F+YRmRyEmc/z24mmINW2rlBktjI0ZIQveUT
         htUH4N9AfEdgAqLDvShVBVImsbZ2CTu77TVt7eJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 022/130] selftests/bpf: Correct path to include msg + path
Date:   Tue, 10 Dec 2019 17:01:13 -0500
Message-Id: <20191210220301.13262-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit c588146378962786ddeec817f7736a53298a7b01 ]

The "path" buf is supposed to contain path + printf msg up to 24 bytes.
It will be cut anyway, but compiler generates truncation warns like:

"
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c: In
function ‘setup_cgroup_environment’:
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:52:34:
warning: ‘/cgroup.controllers’ directive output may be truncated
writing 19 bytes into a region of size between 1 and 4097
[-Wformat-truncation=]
snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
				  ^~~~~~~~~~~~~~~~~~~
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:52:2:
note: ‘snprintf’ output between 20 and 4116 bytes into a destination
of size 4097
snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:72:34:
warning: ‘/cgroup.subtree_control’ directive output may be truncated
writing 23 bytes into a region of size between 1 and 4097
[-Wformat-truncation=]
snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
				  ^~~~~~~~~~~~~~~~~~~~~~~
cgroup_path);
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:72:2:
note: ‘snprintf’ output between 24 and 4120 bytes into a destination
of size 4097
snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
cgroup_path);
"

In order to avoid warns, lets decrease buf size for cgroup workdir on
24 bytes with assumption to include also "/cgroup.subtree_control" to
the address. The cut will never happen anyway.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20191002120404.26962-3-ivan.khoronzhuk@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/cgroup_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/cgroup_helpers.c b/samples/bpf/cgroup_helpers.c
index 09afaddfc9ba9..b5c09cd6c7bd7 100644
--- a/samples/bpf/cgroup_helpers.c
+++ b/samples/bpf/cgroup_helpers.c
@@ -43,7 +43,7 @@
  */
 int setup_cgroup_environment(void)
 {
-	char cgroup_workdir[PATH_MAX + 1];
+	char cgroup_workdir[PATH_MAX - 24];
 
 	format_cgroup_path(cgroup_workdir, "");
 
-- 
2.20.1

