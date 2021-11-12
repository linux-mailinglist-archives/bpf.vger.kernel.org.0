Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3044E017
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 03:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhKLCFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 21:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLCFy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 21:05:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE12C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:03:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 136so2077149pgc.0
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o/ctiQ0jvWgZMbna/z83qQu926M0K6T0rgJ7jRDjq8=;
        b=pOohNHMesnALo9DCB1f2FmqkCDtuzOOhYdyBJj7/yXNV5zis50fFL7N0dhOsxJIQwi
         yooKBpMQ4+ipgwj4e5y4qIYodgCb4Ys0xoQvwMUm5o8NULUIvgUiR99HyQLV9zAzlRr6
         DOS5122SQlN+LGLB8jSu/saiXiDM4/+kGhV7QA78mOYsH2YBoWqTQBrZFmQDg8sirXjl
         tY7YucJCykABt5bkuYUTIcqykztwaR9UM1sb1LHeUQPVhpbWa/Z6YT55xZcjVo8F1nm0
         Iybdqfn9JCG4738mHu1XdWOI1LFS1zn22uQgswPqvVsZYS8vbgJdkjumPxF2ls0/DpUl
         TgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o/ctiQ0jvWgZMbna/z83qQu926M0K6T0rgJ7jRDjq8=;
        b=xi3gsbGP9dkSQzfXNVR7io2sJVhWX3S4kqpTIf84wIi4soqEeQzUCJNlu/Hbg0sKyJ
         Hi5c2Eb8MQ86GyQcVx+7Nmq6FgRECqU0aqm3Kl5f62eXZHlSflFt3JIpewylUrTvB8re
         xdyFUO57uSA49vithumDAqyWFfUxiPEBtcKZwkrOVPGp6gOwqEELop8vyhekqu9RlONM
         j6EhAibuwvccqCyVrLWKFPksHig/kwY0g1Pdw30gQ+ip9RuGDYGh/bTmYqVwBVidicPi
         lVWP/NowpA7hPglwHEoTgdLVKf3RzIhq7vhHjFpLIxnyelDR04Vfm8vpCqLbK566pbpI
         jh0A==
X-Gm-Message-State: AOAM5317yqlg5wtwcn58Ad6JIYqhSupEO6C82LQ35T/wed0o/CrurGak
        PtPI2FMRrc7SnKF/piMmvEiiUqpeSuRZ1g==
X-Google-Smtp-Source: ABdhPJyFoqNciIhyg5MdWWaTeSqSUlkO6/6+Fe8f4skiaIFZmZx69/45IkCKwORCZCuPTjizBcUc8w==
X-Received: by 2002:a63:90c4:: with SMTP id a187mr7583961pge.297.1636682584643;
        Thu, 11 Nov 2021 18:03:04 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id e8sm4497814pfn.45.2021.11.11.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 18:03:04 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf: Fix incorrect use of strlen in xdp_redirect_cpu
Date:   Fri, 12 Nov 2021 07:33:01 +0530
Message-Id: <20211112020301.528357-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit b599015f044d tried to fix a bug where sizeof was incorrectly
applied to a pointer instead of the array string was being copied to, to
find the destination buffer size, but ended up using strlen, which is
still incorrect. However, on closer look ifname_buf has no other use,
hence directly use optarg.

Fixes: b599015f044d ("samples/bpf: Fix application of sizeof to pointer")
Fixes: e531a220cc59 ("samples: bpf: Convert xdp_redirect_cpu to XDP samples helper")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/xdp_redirect_cpu_user.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index d84e6949007c..a81704d3317b 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -309,7 +309,6 @@ int main(int argc, char **argv)
 	const char *mprog_filename = NULL, *mprog_name = NULL;
 	struct xdp_redirect_cpu *skel;
 	struct bpf_map_info info = {};
-	char ifname_buf[IF_NAMESIZE];
 	struct bpf_cpumap_val value;
 	__u32 infosz = sizeof(info);
 	int ret = EXIT_FAIL_OPTION;
@@ -390,10 +389,10 @@ int main(int argc, char **argv)
 		case 'd':
 			if (strlen(optarg) >= IF_NAMESIZE) {
 				fprintf(stderr, "-d/--dev name too long\n");
+				usage(argv, long_options, __doc__, mask, true, skel->obj);
 				goto end_cpu;
 			}
-			safe_strncpy(ifname_buf, optarg, strlen(ifname_buf));
-			ifindex = if_nametoindex(ifname_buf);
+			ifindex = if_nametoindex(optarg);
 			if (!ifindex)
 				ifindex = strtoul(optarg, NULL, 0);
 			if (!ifindex) {
-- 
2.33.1

