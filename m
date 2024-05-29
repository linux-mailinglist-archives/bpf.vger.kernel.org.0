Return-Path: <bpf+bounces-30863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F018D3E5B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC2D1F24115
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A41C0DD0;
	Wed, 29 May 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Usol3I7a"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7415B990;
	Wed, 29 May 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007526; cv=none; b=uuSs+Bug2iK1WZb9o5h59ou6532j0+EjftMSskry2BEIiyJs3K++UZQ/Icwh9ZkvZdRH72ixNLtjIEDzWMRAQWqbx13d3pRDYXq6R9TpAk+wbEzrUSdFLn72LyqE207wZ7pUmyDXG5LGsO8dno8OYLSv3kqFTDpDVUB+eOl6ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007526; c=relaxed/simple;
	bh=b5KUfmV+0BQDlwndzSzEsRg0XBiTwxcg8iE04GTa7Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AFU5vpIKdZdyWW5IhwOi/Q7vvttrDIZHBSo/o3v/8mDu9FfB0nUFpe0YFQBrMCRN2GQ/7VkBQ5ExeLZ8vCpAs1Ac04B43NFoy8D32gzRNDVFv7ivXWnJ2oUwL/UnEP5yUVLvwiItdX+Q9R+tT6zTz0rYOGl7lhznWT0yP7R4gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Usol3I7a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44THlM7D015796;
	Wed, 29 May 2024 18:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Il5puEjjGoo/eUo4Gn88zcACE3zHPOHAVn7
	nercTcfc=; b=Usol3I7aN2TTS5wvxwxtkFg3Nc+zhPf7Hc4r7g8rExm+ahFjE6u
	Uuncj2HyH/FTbznYj0JC2m8OU4b8W+3Yvt42HBUaFoHkIhrMVAlJqifs1VHbOUEh
	+mxASwbQliptGUxzdwHh9IzjDSAjUZiWhUYg7nCN6PhtthyGqZoNATuJvBomnc+1
	LJQjZ7ho0p8j1c/Ebu7AWbSRMAdzPVRlY3GAKjqdpH5kWZ7Yez7bl0ypmZO5QEJf
	nFpvNNRDVPoElxvmvTSFXXHxUYYVwKVOObF1BKGx96/d/BLsKzfbQXPi8D73rNeo
	IqvrEK0dIpEaHqNZSfQYn6aJp7xO1se5SsQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws1nsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:31:35 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44TISEq3010782;
	Wed, 29 May 2024 18:31:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3ydwwpdr08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:31:34 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TIQZVJ007931;
	Wed, 29 May 2024 18:31:33 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 44TIVXKo016136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:31:33 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 51E84220D3; Wed, 29 May 2024 11:31:30 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com, syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com,
        syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Subject: [PATCH net-next v2] net: validate SO_TXTIME clockid coming from  userspace
Date: Wed, 29 May 2024 11:31:30 -0700
Message-Id: <20240529183130.1717083-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nMSxEiVRugjInCAbig439WwEWISOeAKg
X-Proofpoint-GUID: nMSxEiVRugjInCAbig439WwEWISOeAKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290129

Currently there are no strict checks while setting SO_TXTIME
from userspace. With the recent development in skb->tstamp_type
clockid with unsupported clocks results in warn_on_once, which causes
unnecessary aborts in some systems which enables panic on warns.

Add validation in setsockopt to support only CLOCK_REALTIME,
CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Link: https://lore.kernel.org/lkml/6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com/
Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
Changes since v1 
- Moved from net to net-next since 
  Fixes tag is available only on net-next
  as mentioned by Martin 
- Added direct link to design discussion as 
  mentioned by Willem.
- Parameter in the sockopt_validate_clockid
  is of type __kernel_clockid_t so changed it from 
  int to __kernel_clockid_t as mentioned by 
  Willem.
- Added Acked-by tag. 

 net/core/sock.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8629f9aecf91..d497285f283a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
 }
 EXPORT_SYMBOL(sockopt_capable);
 
+static int sockopt_validate_clockid(__kernel_clockid_t value)
+{
+	switch (value) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_TAI:
+		return 0;
+	}
+	return -EINVAL;
+}
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -1497,6 +1508,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EPERM;
 			break;
 		}
+
+		ret = sockopt_validate_clockid(sk_txtime.clockid);
+		if (ret)
+			break;
+
 		sock_valbool_flag(sk, SOCK_TXTIME, true);
 		sk->sk_clockid = sk_txtime.clockid;
 		sk->sk_txtime_deadline_mode =
-- 
2.25.1


