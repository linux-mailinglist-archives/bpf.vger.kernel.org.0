Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E424D5496
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 23:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiCJW3S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 17:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiCJW3R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 17:29:17 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EE3466E
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 14:28:15 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so7484183oif.5
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=L50gyqenwrlhooMlFljcH3M9Bm8aHoxCPPqfCu4Q2BI=;
        b=lURtiOIQm1Fzr/7eATPUeCmC6bh/GUI2W8hKvwkH9I5Hgz6q2OQzhef9p6ImjTcXHe
         h9faC3slkGhKUbotxd9MX4b/AQgERTCnrg8AAYxcGdc17lw9MrZ0WXSHvTmMSg0bp/3f
         FBjQvky5iTLBZTvxN8ZfaDt5N4ytq6+LxzfDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=L50gyqenwrlhooMlFljcH3M9Bm8aHoxCPPqfCu4Q2BI=;
        b=7JRua5vcWYEvzfpQUY9FDhW9TJz+xofqcbPVkGWYxohQHjWr0SSTNr13fvwRrrWeu3
         h+vVzfLccApHPbs8F2JjotZGrNLtKtP+0wmpIbZMrF2osPksx3hLTFdGOxS/TZI+2Gnh
         c0VN7daR8ArRJKIZfQ5iFHoBGeBP3Ehn1nLbYPCiNUXXGUGkwydWZ591jIwEG1jMko+a
         /vzU1UGRejttaDa2bPjCzVwrIZqt8RllqvhRXQoU56QcAw4yO/97gLN4eSAFeZoZyMrw
         bJNeeYfn8j863gjkKSnR7kUJgIO5c1U0dmoTremcTPnbkgYCkiAeSNWj28l9YfrvpeGD
         Wa8w==
X-Gm-Message-State: AOAM533eh1p5f34U6YPjlTUki0X8H1z8qKavhMYmqI7DJYVNNI98Mhmc
        9NuXX1/Q1c7EtJlJtdRZi7OmbowTh3i8Fg==
X-Google-Smtp-Source: ABdhPJz5k0vitjPY00OS9QKIXyOGTge4rA2yWMVhe8B/IrOBfOa8Lh5TCXso/P4dVRUtlc4pa6N4VA==
X-Received: by 2002:a05:6808:179c:b0:2d9:c4bd:cbe with SMTP id bg28-20020a056808179c00b002d9c4bd0cbemr10850938oib.163.1646951294923;
        Thu, 10 Mar 2022 14:28:14 -0800 (PST)
Received: from [192.168.1.230] (cpe-68-203-7-69.austin.res.rr.com. [68.203.7.69])
        by smtp.gmail.com with ESMTPSA id d2-20020a05683025c200b005b248ae4d4asm3152258otu.59.2022.03.10.14.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:28:14 -0800 (PST)
Message-ID: <b6601087-0b11-33cc-904a-1133d1500a10@cloudflare.com>
Date:   Thu, 10 Mar 2022 16:28:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quentin@isovalent.com, ast@kernel.org, andrii@kernel.org
From:   Chris Arges <carges@cloudflare.com>
Subject: [PATCH] bpftool: ensure bytes_memlock json output is correct
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From 40107402b805c4eaca5ce7a0db66d10e9219f2bf Mon Sep 17 00:00:00 2001
From: Chris J Arges <carges@cloudflare.com>
Date: Wed, 9 Mar 2022 15:41:58 -0600
Subject: [PATCH] bpftool: ensure bytes_memlock json output is correct

If a bpf map is created over 2^32 the memlock value as displayed in JSON
format will be incorrect. Use atoll instead of atoi so that the correct
number is displayed.

```
$ bpftool map create /sys/fs/bpf/test_bpfmap type hash key 4 \
  value 1024 entries 4194304 name test_bpfmap
$ bpftool map list
1: hash  name test_bpfmap  flags 0x0
        key 4B  value 1024B  max_entries 4194304  memlock 4328521728B
$ sudo bpftool map list -j | jq .[].bytes_memlock
33554432
```

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 tools/bpf/bpftool/map.c  | 2 +-
 tools/bpf/bpftool/prog.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index cc530a229812..7002f815b7ed 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -504,7 +504,7 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 	jsonw_uint_field(json_wtr, "max_entries", info->max_entries);
 
 	if (memlock)
-		jsonw_int_field(json_wtr, "bytes_memlock", atoi(memlock));
+		jsonw_int_field(json_wtr, "bytes_memlock", atoll(memlock));
 	free(memlock);
 
 	if (info->type == BPF_MAP_TYPE_PROG_ARRAY) {
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2a21d50516bc..edd8a9619341 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -480,7 +480,7 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 
 	memlock = get_fdinfo(fd, "memlock");
 	if (memlock)
-		jsonw_int_field(json_wtr, "bytes_memlock", atoi(memlock));
+		jsonw_int_field(json_wtr, "bytes_memlock", atoll(memlock));
 	free(memlock);
 
 	if (info->nr_map_ids)
-- 
2.25.1

