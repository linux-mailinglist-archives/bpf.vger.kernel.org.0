Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF825E9F5
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCRCN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 13:02:13 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44567 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfGCRCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 13:02:10 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so1954049pgh.11
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FObiLyW+7s29VatAFwxKLbXFDiZhgbEOFEz5IaW9X1w=;
        b=V8AEOwvALDT/8NX2//x05tIUvrGs+LLBWkkMt4Tq6pHW5f/PnuvfcIZjTjc2BO2qFL
         JzOszIwOXb2TEHCqDOZHt3yk7Sww+2v0Qg51V6t89xo8bESuZULcPxU+qWppWnpTXqmW
         t/VkkDo2pHH9td/cwUYFPhRGyO1M87HJwUi73lzhh5J5nmfwkk3BqUmFwBT+hSL913EE
         Z2vioVchf92XkkxlQeVoRdmTUlub1rbCM4uwTGWNDOa9/PDwhR+d1E/Cye6T0Vn9ROsd
         INc57Xeyj4ktrB6g6cVBCjCH84VKHEY5EPa2WP11gFKSLRL+KGGH2j3/rk4ddsgHyaD9
         zDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FObiLyW+7s29VatAFwxKLbXFDiZhgbEOFEz5IaW9X1w=;
        b=Ki4wh2aZ1VIjGNBYTzZ8XOL1LYvYff6V/8rY94asyiAS3YAtWB29aOtQFSji1aznYi
         7yjf8pRnGuoP/bub+VOx2aRqNsfu+uMGcsSu4fVDdcEtbyx4GDVITaCfbnVjxvcZOVX6
         e+h0UIxEUd3EjpSQnaKlLxFNrBhbdgOD1mknzfa8JXSCWXAtfaqU+faqNm8XnjvSRpFr
         HRoMkUuPG7QDubdRtPrSAi6RpeIDVxTca9umPutMbLhrq8E3Kx9M+wi1mCTzcLnZOUOi
         VqEAGwEI5T29eQHU7qWsJLJbVEH+EPdYjK3QWiE8rCXTLpt5HIXvOOalRKBlVAd/mZe8
         xcLQ==
X-Gm-Message-State: APjAAAXJ5xhWg1wxPZZC2SSdhtYse2OmBHfJDGcG+g5o0xL8fBEcEqqW
        Kp17Zsr1yGooBCF0xXKIo7Fln2j0jk+B
X-Google-Smtp-Source: APXvYqw7ANZEITdOhSvuXoIc8hQyumIQuEGkkEcpfrRV4llGdWK6mj1RIg3BGwZD1WSZTH+vcmEoW+Ex0+Er
X-Received: by 2002:a65:420c:: with SMTP id c12mr18547310pgq.125.1562173328926;
 Wed, 03 Jul 2019 10:02:08 -0700 (PDT)
Date:   Wed,  3 Jul 2019 10:01:15 -0700
In-Reply-To: <20190703170118.196552-1-brianvv@google.com>
Message-Id: <20190703170118.196552-4-brianvv@google.com>
Mime-Version: 1.0
References: <20190703170118.196552-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next RFC v3 3/6] bpf: keep bpf.h in sync with tools/
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds bpf_attr.dump structure to libbpf.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/include/uapi/linux/bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a396b516a2b2..db6785a03538 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -388,6 +389,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__u32		map_fd;
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.22.0.410.gd8fdbe21b5-goog

