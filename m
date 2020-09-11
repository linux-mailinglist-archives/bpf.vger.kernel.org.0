Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E672661E0
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgIKPMV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIKPKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:10:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1941C06135A
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:31:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q21so10198671edv.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mgZuX+I018CPLyKtPUh7k/9HodG7wIMhXXoeD6+JKU=;
        b=jkpy5S66o1feRhrtlzl6PzU1fYz4TE/zZjvhcBHu8qQD+l2uP0ug6wbXuJK9XU4+zS
         Ml+05QzSwfORDdn+2bQvu4VdPK2hc1MOc+CNLNakaj+5eG4vOqQ+6C4yyw6O78nMtoDL
         fYu9Skcyyh6a42fCJ70NDglzYCpuwLP8yZDm3HKrrSLSbHoGhva5SKerC7dFzpZNzzWf
         QXwz7BMUIkVhL2MFmhQEV8f0wCTcrqy83/EsGthbVOTMtERTPPy0pauQg8lD+Eyvz4U8
         e+xRRDyuXs0jNQBiTm6Ybs236Zx5Na+0jiuaPpAphBmFuJAz0xli0/wSs3jTZHX11Ryr
         XlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mgZuX+I018CPLyKtPUh7k/9HodG7wIMhXXoeD6+JKU=;
        b=frwIpidDJRrkeRTOz60SvdP0glZpN5c+S76wPxiFUgICvg87nqK6GHKBlClLFTZaEE
         M+LkzrWIgxUOEHJWLBm7o3wIKkAGwN99uMzAGTtODYJQnUIdLwGhC57gAE+HcHeM4kjn
         6Y8EzvjDDGQFgy9GL1+mPVdf5J8W2qKMdVwOSTvaxllxmLHNsAvZtwFL9ZC/03QzJxJY
         EGSf6DBlZmpW2HKmzRGBTx0WQdpiTkIw1luSKnodbHtVBQ2kYAlkfltuJZ1E1C1yAOMF
         k/eE8YUXsJYbue+t2j5/DikFD6/a6aGkcTl7oJLE1TfxD0LnBe0zyYrzw0UAHqFF6TyO
         v1ew==
X-Gm-Message-State: AOAM5329Zr8h2OMDIumqjKy9ojXISrhFIwY6fK32vquUyT3OzL2M1gbY
        2d8F2JIzDdSI/b5ihcYP9mXEaQ==
X-Google-Smtp-Source: ABdhPJwhmYbA1MMaXCK6kWdSVFv5YuQOmbMnYfXF79rYVkrYaDq+fAD+mllnm22XYjlgKXbocLQ7ng==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr2271422edq.106.1599834659332;
        Fri, 11 Sep 2020 07:30:59 -0700 (PDT)
Received: from localhost.localdomain ([87.66.33.240])
        by smtp.gmail.com with ESMTPSA id y21sm1716261eju.46.2020.09.11.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 07:30:58 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/5] bpf: expose is_mptcp flag to bpf_tcp_sock
Date:   Fri, 11 Sep 2020 16:30:16 +0200
Message-Id: <20200911143022.414783-1-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

is_mptcp is a field from struct tcp_sock used to indicate that the
current tcp_sock is part of the MPTCP protocol.

In this protocol, a first socket (mptcp_sock) is created with
sk_protocol set to IPPROTO_MPTCP (=262) for control purpose but it
isn't directly on the wire. This is the role of the subflow (kernel)
sockets which are classical tcp_sock with sk_protocol set to
IPPROTO_TCP. The only way to differentiate such sockets from plain TCP
sockets is the is_mptcp field from tcp_sock.

Such an exposure in BPF is thus required to be able to differentiate
plain TCP sockets from MPTCP subflow sockets in BPF_PROG_TYPE_SOCK_OPS
programs.

The choice has been made to silently pass the case when CONFIG_MPTCP is
unset by defaulting is_mptcp to 0 in order to make BPF independent of
the MPTCP configuration. Another solution is to make the verifier fail
in 'bpf_tcp_sock_is_valid_ctx_access' but this will add an additional
'#ifdef CONFIG_MPTCP' in the BPF code and a same injected BPF program
will not run if MPTCP is not set.

An example use-case is provided in
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 include/uapi/linux/bpf.h       | 1 +
 net/core/filter.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7dd314176df7..7d179eada1c3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4060,6 +4060,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 
 struct bpf_sock_tuple {
diff --git a/net/core/filter.c b/net/core/filter.c
index d266c6941967..dab48528dceb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5837,7 +5837,7 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 				  struct bpf_insn_access_aux *info)
 {
 	if (off < 0 || off >= offsetofend(struct bpf_tcp_sock,
-					  icsk_retransmits))
+					  is_mptcp))
 		return false;
 
 	if (off % size != 0)
@@ -5971,6 +5971,13 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct bpf_tcp_sock, icsk_retransmits):
 		BPF_INET_SOCK_GET_COMMON(icsk_retransmits);
 		break;
+	case offsetof(struct bpf_tcp_sock, is_mptcp):
+#ifdef CONFIG_MPTCP
+		BPF_TCP_SOCK_GET_COMMON(is_mptcp);
+#else
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
+#endif
+		break;
 	}
 
 	return insn - insn_buf;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7dd314176df7..7d179eada1c3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4060,6 +4060,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 
 struct bpf_sock_tuple {
-- 
2.28.0

