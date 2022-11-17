Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6162E19C
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiKQQ0a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiKQQ0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:13 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C17FF08
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 6so2405188pgm.6
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqeaOeRTs6LYqbmOafgXqL26gEz9+X01GqyiEvSlDTU=;
        b=iD9ZGRiAgKfsFcp9dr09j3VXoi1rWRvhrq+owhSD5KJJ1Gcbz19dbC2RxrHljWYcUD
         /2dsN/nkky5a6EJmJM0p9yekotX8PjCDrES9PZ9BQKWI8PiooSqO4zjBWK2gcb0T/xLm
         NkToZVKU55e1fdBKuU7dDja/TOEjSl28DAzt3sTUC7z18czfwJ1swsgizCbU4a/GfHGo
         A8eiuReiSxs9+c0Pvos0rIQSOpdud00i45i/uLLBFBXIyt9AUTNrmiZS7qnUXL+klHnw
         916/Pf6G2GeO0c929GtcEy54tLymQzhISkNbhmM0NRKMnH6WPLhqBrW4wfqLwyFALRCQ
         qa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqeaOeRTs6LYqbmOafgXqL26gEz9+X01GqyiEvSlDTU=;
        b=gDNazTs8Qnmvr6btJIILgMfGT++tqhsqLbD0Q14eeVz2dbAcuTXayPu1j0NcTNr4GL
         cFkrYAh8ybQnQQgaj3i9JSda82sLCBI4xIzz/dC0R5MUmtVzgNYq+BRbWOVsmJGESr1j
         z3bmB5q6ztYJxlTwi8dDNNDeLyVO22WxORnU7msHAzK8K+TzFFF1RFSgC06fJGf2fQ2R
         9Qo2KDXtwb+2l3LGw1FHyk7WB4FjjimPabq9Xv8OkofXBLWr+/rGPLBQsSBgCvYG4XPb
         QUPTcf704UJsVT6jVmVqPIr/0C46hIF7xcVOb/oSgHI1X6MldRJF7RBqhwkVFsqMHUUh
         jHxQ==
X-Gm-Message-State: ANoB5pkL+u95l02ZkhOEHcFKbbKtCi5lmpjIS3gpwVEGiBjXxt7ZyDRQ
        PLIQw/hysQWPLIO/sEi3m393Os49agg=
X-Google-Smtp-Source: AA0mqf7FeAzCvtLkoUGviUxsPwNLwwZ1YK/w6+bthEPbgGfNIp3CU0NbcWAvwWx12k3gUxJPYndRkg==
X-Received: by 2002:a65:6118:0:b0:476:d2e9:778e with SMTP id z24-20020a656118000000b00476d2e9778emr2659802pgu.309.1668702283813;
        Thu, 17 Nov 2022 08:24:43 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id z14-20020a65610e000000b004768b74f208sm1213369pgu.4.2022.11.17.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:24:43 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 01/22] bpf: Fix early return in map_check_btf
Date:   Thu, 17 Nov 2022 21:54:09 +0530
Message-Id: <20221117162430.1213770-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=memxor@gmail.com; h=from:subject; bh=+YGeckQjf07xB5OZFUuf6ChpHLXy6Nl5e0wS9/6X9zQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+HgJ2yFrZ01yOfR++EezXaEVyPbSbbIhMxZHF W22XKqaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8Ryo1DD/ 41iQECPMFK2k19HdaIXzbhvxuNYJmGMzmRwYUvr4XrCRUiaQJSi9q7gZ2BMVdhEWvovZHOOC34byJk AxP3Q7BR6sAExrraFxs6U14GV/irSdSQjS6nzgV7Ba93owF+zf1pLGXCK+UL4kSoowp5XUWwtZ10OV 9Hkl/FMetvUYGQdK5Vx/+hF4lM8KwdY4huLZQMFe1qXk/HzvRTUNOFgYQg1Nib64MHvolmdVW9eYC3 ffXblwgAApoCimKN9QnCcznFdRj68pZKjkZKjnXnEksdR596Opjd764NhAGwrd3udgsLFwQCE53Udj NZWcRdCX35J69k42HV2+QiNvNJYl2k+wgb6md18Xp2TnhzrcjpRozoNqsdIprvO0CV+BFRK73WTTXx Ejmla0Ckl4Zs5wFfMkGHb2jzsWdyN14fWDJWa9FZMr5Wt0OkmTVQoTHZ6xcrSLVv5WgE0fNq+tUPeH kSHGunBEDUerd9Y/jZqJBdouc2nO0SMsV+syAVMGTDAHBCxPnyRq27wxjJ8+fdknR14guEBE6BrZcH e0on5Rk47xGbB01wYsKDzgFW5eKywBm7Wm7QtF+p30lQdWZlAoUbQ0Zz1aD/fU6Hi429+i8b+/SgdO 9R1Pz52Nb290TseSPGzEQs2hWrgLV9YC0mV/JA+Zvq1CEiSs/7cT+yqFe5aA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of returning directly with -EOPNOTSUPP for the timer case, we
need to free the btf_record before returning to userspace.

Fixes: db559117828d ("bpf: Consolidate spin_lock, timer management into btf_record")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fdbae52f463f..0b48e2b13021 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1010,7 +1010,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
-					return -EOPNOTSUPP;
+					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
 				break;
-- 
2.38.1

