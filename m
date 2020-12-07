Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0194B2D159E
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgLGQJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLGQJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:22 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB69C0611CE
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:24 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id r124so12888990qkd.8
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JZuzlSoAjz7FNG/xXGP3ldQQuwguOauM6X/0+9EKmts=;
        b=kuioVJ08vE6S92h1R7I+//XBgajY7a4JuolHp1x7PP/9tTSoDEAegDUB0lnCtg+9IU
         83o+z7wxxstyNeMJ7k/YSey5qJwIYiPu3zTHU7IgZWkPEEoLk9wGTVu1OqV564qw1M0K
         u/hOtMqnBsjxUqmHYG/iH6E/gJnSyCaMq5DAlV2HPRku0AyWU4HDXzSRk1TsjkEYvHrf
         coy+QV/Ukb2hzYnrRqThYLE4IpcWL/G2g5smexbzzK9176PFP9uon4J4qJE/jzRPt8Pl
         Qd0rXkSHrjYCTE2wwYgu0rFpI5p7+sPJw4X+GmUbbSpfydGiQel9ghKwDYjSVXCuTXbo
         Ri6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JZuzlSoAjz7FNG/xXGP3ldQQuwguOauM6X/0+9EKmts=;
        b=dF7f8a3gnlA9y0Evoq+ixcJNrGdT8OS/IYGf77gTxrj+7ta9nKqNUhqaVA6+2QiSo2
         jtsb2GxHP+5IIEe2QHktJ8NXfRdPoyBqi8taftWx2PbmuqE1mR0wy+xsrY92z8MQ9hPo
         59zSgAcalFCwrhmpd6GVBNO0Tduf5KeZ3RW/OkZ6GTkWjqHQuuXJYzE1RrH5Gx6vlnCR
         4VUyXrrl0SssxQ3db9hRgUG+YxrtTgvmW+3GpZlpHFagM6b127M61enlsF1wjIb/umpg
         Lc8f/pwB0AwnobsYbkqBlHJoXPcoXeMVsP5ymJ7pkhsRtHb+IvxOY6SIV7pqOq5kDUB5
         NoNQ==
X-Gm-Message-State: AOAM532CnkldEsKFymkFwi7wz8aphSGZfv6Nk7so0PyRvmA5Imxmk7OR
        LBn8bq9XBgMmcTCCJVp8e3nBpJ7kyHWsfeXB87NhfniAl+qseL0iS7wcsd7JPYIc28I2cLgAEX/
        eEroc3FFCeq9fS6hcg9SWEN4GMnUranOdA8UThPjFwDTJ55uw42GodsgAeH4fZfU=
X-Google-Smtp-Source: ABdhPJwPjwXSfCutJZf0Ngl1kTSd7EwXf/y80t3GSKAhRzTF6Baa1IB97Pv357yN/89fLu5wmsBnZUH5B6C0SA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:5bcd:: with SMTP id
 t13mr21906474qvt.7.1607357303539; Mon, 07 Dec 2020 08:08:23 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:28 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-6-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 05/11] bpf: Move BPF_STX reserved field check into
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

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 615be10abd71..745c53df0485 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9527,6 +9527,12 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -9939,13 +9945,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
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
2.29.2.576.ga3fc446d84-goog

