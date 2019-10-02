Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C230C89B6
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJBNad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 09:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfJBNac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 09:30:32 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C1CA2BF73
        for <bpf@vger.kernel.org>; Wed,  2 Oct 2019 13:30:32 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id y12so4857113ljc.8
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 06:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pbUUD2XJ6prV3zK1ZpK/kSetnSl9zt8sMAFPDgDE7Ng=;
        b=VQXm4aj6z7vMOB5ewiZF/4kYpDI198MbvEt0IsRkJXCJE0l8j617W9G0ii6i0jF6+P
         ydtWB3+xC0udB/X1q+D177EBtre6kfwhDaTf3AxtFahRvg5xJy4JEQiPPH6Pg1FB3/VK
         IVtpy1DEk73gV1IVGWTpZgvKBe2QCvzdix8o3YbS2+PSNEW+WVMqgkZEztG3LBqQMHWO
         bGuK3Jgqftq41nqAAzpyn9TU9BixSEZ4AQasJ5GRIK0+idAiSp35zcO13sKBupNdlG25
         s1olSXYsPwAkxdMP+7uMKnOPNjTfECvSGYHxUUXFrGH0om7cjzoiNVLUN9vAq5eRmEb0
         s+ow==
X-Gm-Message-State: APjAAAX935qNFlmtgiqOuxBum4ajvCwmYUWmD9DuiA9CPHL5968YsujJ
        Ru/aeztYCd0Ilf1gE9aOOd76xfomXSql2WYK1jDFT87D2tdPAPofrLC79dYYb4OOuM7JhVpSe+O
        ZGdvfqF1IDakm
X-Received: by 2002:ac2:495e:: with SMTP id o30mr2359186lfi.82.1570023030787;
        Wed, 02 Oct 2019 06:30:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5cGmzdcKy5vmgUCN95vLcyGVAl1vnuile/NaWBL7pE5VNqrxdtSsdzExzBWCoeDUIG2wwQQ==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr2359165lfi.82.1570023030555;
        Wed, 02 Oct 2019 06:30:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id n5sm6096592ljh.54.2019.10.02.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:30:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 06C06180641; Wed,  2 Oct 2019 15:30:29 +0200 (CEST)
Subject: [PATCH bpf-next 4/9] xdp: Implement chain call logic to support
 multiple programs on one interface
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 02 Oct 2019 15:30:28 +0200
Message-ID: <157002302894.1302756.12004905609124608227.stgit@alrua-x1>
In-Reply-To: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds for executing multiple XDP programs on a single interface using
the chain call map type introduced in the previous commits. The logic is
added as an extension of bpf_prog_run_xdp() which will loop through the
call sequence specified by the chain call map installed on the current
interface. The overhead when no chain map is installed is only a single
pointer dereference.

The total call sequence length is limited to 32 programs, and the call
sequence will be aborted and XDP_ABORTED returned if it is exceeded.
Likewise, if a program in the sequence returns XDP_ABORTED, the whole
sequence will be aborted immediately, on the assumption that this is a
fault somewhere in the system.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/filter.h |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2ce57645f3cd..8a79ddd4f7b5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -693,6 +693,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	return res;
 }
 
+#define BPF_XDP_MAX_CHAIN_CALLS 32
 static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 					    struct xdp_buff *xdp)
 {
@@ -702,7 +703,30 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * already takes rcu_read_lock() when fetching the program, so
 	 * it's not necessary here anymore.
 	 */
-	return BPF_PROG_RUN(prog, xdp);
+
+	int i = BPF_XDP_MAX_CHAIN_CALLS;
+	struct bpf_map *chain_map;
+	u32 ret;
+
+	chain_map = rcu_dereference(xdp->rxq->dev->xdp_chain_map);
+	if (!chain_map)
+		return BPF_PROG_RUN(prog, xdp);
+
+	do {
+		if (!--i) {
+			ret = XDP_ABORTED;
+			goto out;
+		}
+
+		ret = BPF_PROG_RUN(prog, xdp);
+		if (ret == XDP_ABORTED)
+			goto out;
+
+		prog = bpf_xdp_chain_map_get_prog(chain_map, prog->aux->id, ret);
+	} while(prog);
+
+out:
+	return ret;
 }
 
 static inline u32 bpf_prog_insn_size(const struct bpf_prog *prog)

