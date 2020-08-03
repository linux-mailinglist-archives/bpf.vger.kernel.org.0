Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA423B0B6
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgHCXKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 19:10:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62078 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbgHCXKf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Aug 2020 19:10:35 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073Mt8Me001094
        for <bpf@vger.kernel.org>; Mon, 3 Aug 2020 16:10:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ENnFZ5a2qYkZgQfuQqJO3qL+d0MIG6J7ZgK++HEmV+k=;
 b=E944LyqxK3KixA3ARacVnay3OjkOuakbsOi7qhQqXlvWp0I5OPB1B2CLSFcu7isUxF7C
 5etTMI8N5OXhFXPRuyhAiELpUJngeoaFzE0pJJv9n9zOdqsjgYViHRBvLjLsOlb6LPfv
 zUxZ9kByilOw8oPuTe6ltvQQS8TOs6oIV9c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n80t9gdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 16:10:34 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 16:10:33 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id E13D02943872; Mon,  3 Aug 2020 16:10:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH v4 bpf-next 02/12] tcp: bpf: Add TCP_BPF_DELACK_MAX setsockopt
Date:   Mon, 3 Aug 2020 16:10:26 -0700
Message-ID: <20200803231026.2682120-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200803231013.2681560-1-kafai@fb.com>
References: <20200803231013.2681560-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=13 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change is mostly from an internal patch and adapts it from sysctl
config to the bpf_setsockopt setup.

The bpf_prog can set the max delay ack by using
bpf_setsockopt(TCP_BPF_DELACK_MAX).  This max delay ack can be communicat=
ed
to its peer through bpf header option.  The receiving peer can then use
this max delay ack and set a potentially lower rto by using
bpf_setsockopt(TCP_BPF_RTO_MIN) which will be introduced
in the next patch.

Another later selftest patch will also use it like the above to show
how to write and parse bpf tcp header option.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/inet_connection_sock.h | 1 +
 include/uapi/linux/bpf.h           | 1 +
 net/core/filter.c                  | 8 ++++++++
 net/ipv4/tcp.c                     | 2 ++
 net/ipv4/tcp_output.c              | 2 ++
 tools/include/uapi/linux/bpf.h     | 1 +
 6 files changed, 15 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
index 1e209ce7d1bd..8b6d89ac91cc 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -86,6 +86,7 @@ struct inet_connection_sock {
  	struct timer_list	  icsk_retransmit_timer;
  	struct timer_list	  icsk_delack_timer;
 	__u32			  icsk_rto;
+	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eb5e0c38eb2c..993060d9ecf2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4244,6 +4244,7 @@ enum {
 enum {
 	TCP_BPF_IW		=3D 1001,	/* Set TCP initial congestion window */
 	TCP_BPF_SNDCWND_CLAMP	=3D 1002,	/* Set sndcwnd_clamp */
+	TCP_BPF_DELACK_MAX	=3D 1003, /* Max delay ack in usecs */
 };
=20
 struct bpf_perf_event_value {
diff --git a/net/core/filter.c b/net/core/filter.c
index 250b5552a148..969c6b6b98d0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4459,6 +4459,7 @@ static int _bpf_setsockopt(struct sock *sk, int lev=
el, int optname,
 		} else {
 			struct inet_connection_sock *icsk =3D inet_csk(sk);
 			struct tcp_sock *tp =3D tcp_sk(sk);
+			unsigned long timeout;
=20
 			if (optlen !=3D sizeof(int))
 				return -EINVAL;
@@ -4480,6 +4481,13 @@ static int _bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 					tp->snd_ssthresh =3D val;
 				}
 				break;
+			case TCP_BPF_DELACK_MAX:
+				timeout =3D usecs_to_jiffies(val);
+				if (timeout > TCP_DELACK_MAX ||
+				    timeout < TCP_TIMEOUT_MIN)
+					return -EINVAL;
+				inet_csk(sk)->icsk_delack_max =3D timeout;
+				break;
 			case TCP_SAVE_SYN:
 				if (val < 0 || val > 1)
 					ret =3D -EINVAL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a774b5094e9..10db079cb9e3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -418,6 +418,7 @@ void tcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
=20
 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
+	icsk->icsk_delack_max =3D TCP_DELACK_MAX;
 	tp->mdev_us =3D jiffies_to_usecs(TCP_TIMEOUT_INIT);
 	minmax_reset(&tp->rtt_min, tcp_jiffies32, ~0U);
=20
@@ -2685,6 +2686,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_backoff =3D 0;
 	icsk->icsk_probes_out =3D 0;
 	icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
+	icsk->icsk_delack_max =3D TCP_DELACK_MAX;
 	tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd =3D TCP_INIT_CWND;
 	tp->snd_cwnd_cnt =3D 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d8f16f6a9b02..984114087263 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3741,6 +3741,8 @@ void tcp_send_delayed_ack(struct sock *sk)
 		ato =3D min(ato, max_ato);
 	}
=20
+	ato =3D min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
+
 	/* Stay within the limit we were given */
 	timeout =3D jiffies + ato;
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index eb5e0c38eb2c..993060d9ecf2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4244,6 +4244,7 @@ enum {
 enum {
 	TCP_BPF_IW		=3D 1001,	/* Set TCP initial congestion window */
 	TCP_BPF_SNDCWND_CLAMP	=3D 1002,	/* Set sndcwnd_clamp */
+	TCP_BPF_DELACK_MAX	=3D 1003, /* Max delay ack in usecs */
 };
=20
 struct bpf_perf_event_value {
--=20
2.24.1

