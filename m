Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5E42D87
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 19:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409543AbfFLRaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 13:30:46 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47184 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406395AbfFLRaq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 13:30:46 -0400
Received: by mail-qk1-f201.google.com with SMTP id l185so14279793qkd.14
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uD0S0Fr977XbAf3v96x/HVlLPiyEpqZkm6CH6Dt+DGw=;
        b=G34nbtNBuyjHlA8kXx04tv5bCmuFC1FutZl6xaMcCQkcRMrwTJz4hWQdD9zLwvxR4c
         tvp7rqzLJj85Pkcrw7Fth45UK2p0iznaMYtoEePBVD/Eg3tz5kmc257vB3+p/U7tj1nI
         f6Db9Q5a+gMBkPifracEuq72k+7uWGbm3unciwFBao61B/8+/4wLJsrlM0iM5om4GW87
         1HQFC1+GseGtlpAb4PtmSJYrkjMBVnuAtu2Ln47rDUKMbv12lXZIJuCDvgT7WZbx+DrA
         FK93rnnakjAbR5ro1ZW6DTvvduf/f12AYHV+l1yMSmmyIE5GU1DIkbOSQJG2R74Rc2s3
         FhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uD0S0Fr977XbAf3v96x/HVlLPiyEpqZkm6CH6Dt+DGw=;
        b=Z2Pzn3MNo1ZvQQaplJ1Sv4zqckOL+SG52fgO/XrgBrlTjKeGJIQsrVg6+raBfN3L6d
         qk3476l3q+oL0Ee5Xn2vDNAAs89KffpX97ER0dNpEfIE2AvxIl4EmsMDY8KCw42s3CsY
         rl0YBeMiv3EUkPP/Lwe/h1JTvd6NlI+a9c18yjBRRciLaQBMHbRn+9aI2XEY4Cu5lQyX
         CujshnXRi8uPp113Dt+Nwtifj15YvmdEN1Ku9KwaDsgU4DEMGFlyvqt/JqW5KcMLiEyi
         Yl1qTojq3D3xNylYSDgGCi69KbWxqr/ZMJqNTNoEW4tQAcjObyyINF5e2Jv78rpxRi5m
         0A7w==
X-Gm-Message-State: APjAAAVBVhg3LPbGS1IxIDwDraxZuQ30YUTHUQ1HOt8vdRPj9Pk20EOu
        egBbMu9xVBVoW73HKXRgLcpJumQ=
X-Google-Smtp-Source: APXvYqxYen89Upp42c9iF0On/2yRREqj0vSMPc3cG7rMveKNbtUIg4iaBr/NMMrrM7zerR2q7GNZqa8=
X-Received: by 2002:ac8:28bc:: with SMTP id i57mr40203937qti.288.1560360645423;
 Wed, 12 Jun 2019 10:30:45 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:30:38 -0700
In-Reply-To: <20190612173040.61944-1-sdf@google.com>
Message-Id: <20190612173040.61944-2-sdf@google.com>
Mime-Version: 1.0
References: <20190612173040.61944-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next 2/4] bpf: export bpf_sock for BPF_PROG_TYPE_SOCK_OPS
 prog type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

And let it use bpf_sk_storage_{get,delete} helpers to access socket
storage. Kernel context (struct bpf_sock_ops_kern) already has sk
member, so I just expose it to the BPF hooks. I use
PTR_TO_SOCKET_OR_NULL and return NULL in !is_fullsock case.

I also export bpf_tcp_sock to make it possible to access tcp socket stats.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h |  1 +
 net/core/filter.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8815fc418cde..d0a23476f887 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3299,6 +3299,7 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__bpf_md_ptr(struct bpf_sock *, sk);
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
diff --git a/net/core/filter.c b/net/core/filter.c
index 37c4a2fd559b..8c18f2781afa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6147,6 +6147,14 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_sockopt_event_output_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
+#ifdef CONFIG_INET
+	case BPF_FUNC_tcp_sock:
+		return &bpf_tcp_sock_proto;
+#endif /* CONFIG_INET */
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6882,6 +6890,11 @@ static bool sock_ops_is_valid_access(int off, int size,
 			if (size != sizeof(__u64))
 				return false;
 			break;
+		case offsetof(struct bpf_sock_ops, sk):
+			if (size != sizeof(__u64))
+				return false;
+			info->reg_type = PTR_TO_SOCKET_OR_NULL;
+			break;
 		default:
 			if (size != size_default)
 				return false;
@@ -8053,6 +8066,19 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
 					  struct sock, type);
 		break;
+	case offsetof(struct bpf_sock_ops, sk):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct bpf_sock_ops_kern,
+						is_fullsock),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sock_ops_kern,
+					       is_fullsock));
+		*insn++ = BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0, 1);
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct bpf_sock_ops_kern, sk),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sock_ops_kern, sk));
+		break;
 	}
 	return insn - insn_buf;
 }
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

