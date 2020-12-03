Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2212CDAB8
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgLCQEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLCQEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:45 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B1C08E863
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:23 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r5so1690398wma.2
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=P/yq/QQWbpB7r4QFh7S+AKecPYKN/ajhsuXzhalk5DU=;
        b=nk3c1Pr1/+i7APpWeoY7LSgu1pCCyRq/vSUN8hqvQ9hfqnXht8rHs3eImodgT8++kR
         o3/W9PA0EcGW72ltEJH8mfk+Au8TLr3PhqrgHgpNAjn5L5yBRJ5VGOpqgd7Q93RxlA95
         vUaJ0Z2JKPqK+k1LB5oxvyK3AINNAIRnIj+Z57ZtDnL80qrJGghy/iVzEFXfWTWOdQLz
         BPX+Pc0M9TKUBYT27UFffn2lI8iKVlDyYXBmo2ILwgM73fL9WuiKgBbqK3rbon0xk9KY
         kdKy6fdni/99+aivkAfVis+LeCHg+/Tj+X1u+IqMNsmMc6SzpDpJ2VZQzE5HoSjlivvm
         qjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P/yq/QQWbpB7r4QFh7S+AKecPYKN/ajhsuXzhalk5DU=;
        b=kCRB+MH6RORSr7OxDRcCoFcojTGmiIidflx+BXC48zKvUHXNNtxdhgLBkb/O6V5dx3
         v4ytKc+ugLL5nj+SUAQ52uOByvFdP/QS4m4az94GFSP7YXPJnN3vgkBVM7AYgpgLZ5Yk
         6SRkeZJefMl6navIGQCRdcG+fpul9Uu82lzTsArt4B/Y05FkkYQ6yDcYWPDy+5sllxt7
         7B/c1P/VF00nFyqeh8TcurDqulOppr+NdQsjC80N5Apml9tUHK2+v8a5XVT4t0SdFTFx
         5nyh+DCCPBMWllDdHGucBVGE/1mUmY1v41xEMrRJi7Bvk3ZX3+6hZ7PBnrH1208WQpeG
         yz6Q==
X-Gm-Message-State: AOAM5303f4WhSJEnvsrUwligrEaDe1GtIZL2CNnVDcKL1vFzf0sQDc7A
        vKb9QqT++bTKluSRM4M9MQUoJsHKQCrgWj/Mf5h8H+ObaUpWoFd/6ZIC3tIrQ/40RFRxHWJOyyF
        rjRnJXCcRHnlgHf19qG6VA8qDa6Wpnp+teiucH1AW8ywNR7lRHgdB16R0EVUDxAY=
X-Google-Smtp-Source: ABdhPJwsAhXZL/lcGzdQfplLgykQGeAYQoEOYH2tTYj+nuKMiQXnnyj+PcrWYn1cSui6VWlMWaLR9HoHoq/9Og==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c5c6:: with SMTP id
 n6mr3982703wmk.131.1607011402494; Thu, 03 Dec 2020 08:03:22 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:37 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 06/14] bpf: Move BPF_STX reserved field check into
 BPF_STX verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Change-Id: I3410469270f4889a3af67612bd6c2e7979ab4da1
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1947da617b03..e8b41ccdfb90 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9501,6 +9501,12 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
+			if (((BPF_MODE(insn->code) != BPF_MEM &&
+			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9910,13 +9916,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (BPF_CLASS(insn->code) == BPF_STX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM &&
-		      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-- 
2.29.2.454.gaff20da3a2-goog

