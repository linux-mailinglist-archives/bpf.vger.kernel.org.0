Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08E379560
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEJRYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhEJRYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:08 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB443C061760;
        Mon, 10 May 2021 10:23:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id n22so12481762qtk.9;
        Mon, 10 May 2021 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os+aNkIj11roEHDUU05sC6TNDVf0op+4DKUiI/YhlCI=;
        b=M5fRVYqrGRIo+zDt0ww9BZnPnThLcGUFnq1uBtyv9zZCFzq7kYM+ebANCjyQPR7JyW
         mojidBSveomAk3SZkuZyQQbm33GnzbuwSmiT7pRt5dreyQRnAiAGSLLIjdAkL3bXtXJW
         Kt/uQ0ZGpjx10L02Nyw2XJqcP6SjauIIlC6rOnlauWf0OQXsXChwyC2s3wUuAHjR+OBl
         449/wDIHI8AY8vsyKGmxD4MQMG/lfaEFI0m2zRzxEkducKu0VsktQiFeN03xmZIiqgWq
         lzx6AAApP7SWNBNaW8VN5W5QrdTaJQYfZzWHM1ZZ8LY0g4pEyrOREnKw6c7bk3FvV3y6
         4acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os+aNkIj11roEHDUU05sC6TNDVf0op+4DKUiI/YhlCI=;
        b=JPsUvG9zmpXYkpPF5pcSRPOAtJb15d4OAJZeF8RwmafOjcpqolSQXMCh6Ek/Pa7pe9
         ZvlRJTYVMbPBv5jqagBiJVvc0DrB3GU00gZKH8EG/4vMBfICZwltfa8/vHqN5euGOrNI
         Wt0snOyRxZS7wYBn7SZhUZZilH/RoWUK88S6eQrsP13R/9U9XeLcDVnw/vMxoDceK/43
         0i0EGPPzCz6JyCJCvU5NtospH+XuQqKC8liohpLuqoWn/BJEwU7DkPeGrqy08OewZtQg
         8M0wcKCj5nbHoaG/1a91Y8Nli47/d4bdYYbswPoMFNNthty7P9iNtpqkgzBurwwg5OPh
         tKZw==
X-Gm-Message-State: AOAM532fdVZfOL0ehB3GVCd+d0VNnw+wYUTa5wymccTcnxCekB9OnalG
        uSeC11XEv0pOOLNqjD1aplCFuYVmdDk2IeZ8
X-Google-Smtp-Source: ABdhPJzGzOZt96I0Zs7TdCghlnOJueKKaLB7JVqgkm1SC2dIxERLF1FLObKXXk8uUTGdiuh0MqkEEw==
X-Received: by 2002:ac8:646:: with SMTP id e6mr22635080qth.285.1620667382103;
        Mon, 10 May 2021 10:23:02 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:23:01 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux.dev, bpf@vger.kernel.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: [RFC PATCH bpf-next seccomp 07/12] bpf/verifier: allow restricting direct map access
Date:   Mon, 10 May 2021 12:22:44 -0500
Message-Id: <08b306f207cc6c516500a58ee0bc506f09859d26.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

Add a verifier hook that is able to reject direct map access that
does not make use of eBPF helpers. These accesses mostly correspond
to eBPF data section accesses. This allows a program type to disable
maps altogether by resturing direct map accesses and not whitelisting
helpers that perform map accesses.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 02b02cb29ce2..86f3e8784e43 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -484,6 +484,7 @@ struct bpf_verifier_ops {
 				 enum bpf_access_type atype,
 				 u32 *next_btf_id);
 	bool (*check_kfunc_call)(u32 kfunc_btf_id);
+	bool (*map_access)(enum bpf_access_type type);
 };
 
 struct bpf_prog_offload_ops {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8fd552c16763..8eec1796caaa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3100,6 +3100,9 @@ static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_map *map = regs[regno].map_ptr;
 	u32 cap = bpf_map_flags_to_cap(map);
 
+	if (env->ops->map_access && !env->ops->map_access(type))
+		cap = 0;
+
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
 		verbose(env, "write into map forbidden, value_size=%d off=%d size=%d\n",
 			map->value_size, off, size);
-- 
2.31.1

