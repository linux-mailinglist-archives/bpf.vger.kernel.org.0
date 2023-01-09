Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3A662443
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjAILfJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjAILex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:34:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2B18E2B;
        Mon,  9 Jan 2023 03:34:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C05EC33F51;
        Mon,  9 Jan 2023 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673264089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ed2kRG7zsuXiD58xhTaH2Hy8yTgKVPvLz0kMLwoU6tU=;
        b=yh5Z1cxpS/L3xb2leT5iXLp/RzCHUd6FxyVD+igHcfoos37Dv9O3oQ/oZN4TG2ia1k4LDU
        yGcaMAnmaOklWC5Px7j0PFDKQqzbeM6cAhm6SkeFMCvoRtplpg+F0dLFbb8AOKvhG42Xuj
        DR9vQsZ5B8MmjfmQVCVlPGXZ2PxZIgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673264089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ed2kRG7zsuXiD58xhTaH2Hy8yTgKVPvLz0kMLwoU6tU=;
        b=zGJCspUCSdD9pErdNIJxC71ZwrfYJGePDWXsnPLrZp4Kj2HNj5XibAX6ccFpE1IsLzIfvM
        MmhQdJ86x3402KCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 6AB6F2C141;
        Mon,  9 Jan 2023 11:34:49 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bpf_doc: Fix build error with older python versions
Date:   Mon,  9 Jan 2023 12:34:42 +0100
Message-Id: <20230109113442.20946-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <521abe2f-1aa3-563f-48ec-c016450602d9@iogearbox.net>
References: <521abe2f-1aa3-563f-48ec-c016450602d9@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ability to subscript match result as an array is only available
since python 3.6. Existing code in bpf_doc uses the older group()
interface but commit 8a76145a2ec2 adds code using the new interface.

Use the old interface consistently to avoid build error on older
distributions like the below:

+ make -j48 -s -C /dev/shm/kbuild/linux.33946/current ARCH=powerpc HOSTCC=gcc CROSS_COMPILE=powerpc64-suse-linux- clean
TypeError: '_sre.SRE_Match' object is not subscriptable

Fixes: 8a76145a2ec2 ("bpf: explicitly define BPF_FUNC_xxx integer values")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
v2: Add more details to commit message
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index e8d90829f23e..38d51e05c7a2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -271,7 +271,7 @@ class HeaderParser(object):
             if capture:
                 fn_defines_str += self.line
                 helper_name = capture.expand(r'bpf_\1')
-                self.helper_enum_vals[helper_name] = int(capture[2])
+                self.helper_enum_vals[helper_name] = int(capture.group(2))
                 self.helper_enum_pos[helper_name] = i
                 i += 1
             else:
-- 
2.35.3

