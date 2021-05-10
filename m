Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414F379559
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhEJRYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhEJRYE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:24:04 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012DC06138A;
        Mon, 10 May 2021 10:22:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t7so12526255qtn.3;
        Mon, 10 May 2021 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rahaQaLyFPP9GGvK15BOl5iZ4PSYmD/vlR06dUAD7e0=;
        b=RJePQanVHTvnYJXjtq/LxIaIBOPhJjnoxA29/o8xMmHwkNv7CtioYcn32Jnr3SwqWQ
         almESooTi22DGCQjJhrwJtY+mrcCKsxmpiB0l4BKhdIscp06rl+ZJvphWiOYy07hRQBp
         +ET28ugKg6/csqDQ9YcfzO8JQYI3Z3AuIn8yxn8L5/HezfUh7pf/QDa/t6dC0uob7xAG
         EXIg+EXqE/ijLiYxCt4djfIa9vOAKQy0xK4dzteIwuNKEU1vmnxy9Gyzit3IxvXfeWJy
         cIQ+yt1Cp3SLgLxTpZdrKQNlDvAz6m3Y0UEkkeDGQ7pOZTX6Yi5qt48S2kirpaNRU30m
         gRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rahaQaLyFPP9GGvK15BOl5iZ4PSYmD/vlR06dUAD7e0=;
        b=So3wzkKlQXBB1FVecaHqSwPys2AZ2cQ/CZh5IQgk3HnKfMxG80ji/qN6NbrXfToMoY
         331Hi34gmQztattKBB0wdyITXvEvlbvXE5xRspeRzu+j0Oboa0g/pSd/J/zfot7Xp2nv
         rplvsH7t+bgZpTA6LmnBq3+JxmT7+EEATFVoGpfP3uuLC5twX32ttGBNxm19p6SsJil+
         jDHuOVzInF5W6OC0YXqLOlIjq7P94UByEZIeXSuMZu1Y0Rk5fBZAKA2qRGBL67XBl/o6
         EFKtIh8R1xD2HT5g6xSivBJbYciygjXlHU0Cs1zxYyyakmjxZoweWPQeLg4Sz84ebPHC
         ciGA==
X-Gm-Message-State: AOAM532GyygZPgWqOU2Q6oOnouvXbIHMdZV301ktmnlHOUvzC8qFIcg8
        My2WkE7eD5eJdQS5YTknXQWgaLusdWhQyF3f
X-Google-Smtp-Source: ABdhPJz7dTCeaErW7vArw1fyKmZO4UJ0S1Q0/i4pR56D4pC8rE886IfEcheNNTd/YWEMMzCCas1NRg==
X-Received: by 2002:ac8:7f83:: with SMTP id z3mr14353597qtj.239.1620667378335;
        Mon, 10 May 2021 10:22:58 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q7sm11924367qki.17.2021.05.10.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:22:58 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next seccomp 04/12] libbpf: recognize section "seccomp"
Date:   Mon, 10 May 2021 12:22:41 -0500
Message-Id: <78401c1929394e999f154bcecd5aa00d2178d1c5.1620499942.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620499942.git.yifeifz2@illinois.edu>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

The section is set to program type BPF_PROG_TYPE_SECCOMP with no
attach type.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a3cf437814..42ce79b47378 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8958,6 +8958,7 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
 	BPF_EAPROG_SEC("sk_lookup/",		BPF_PROG_TYPE_SK_LOOKUP,
 						BPF_SK_LOOKUP),
+	BPF_PROG_SEC("seccomp",			BPF_PROG_TYPE_SECCOMP),
 };
 
 #undef BPF_PROG_SEC_IMPL
-- 
2.31.1

