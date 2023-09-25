Return-Path: <bpf+bounces-10785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA037AE0FF
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9ECEF1C2098C
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC472420A;
	Mon, 25 Sep 2023 21:52:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5324213
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:30 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94D11C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEC9Wi023153;
	Mon, 25 Sep 2023 21:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=MC0uvYMO2FCgf65F6KKYGwogxSRr8eNxjVlVQ6tS7/M=; b=DH8emgZnpSc7
	f3EbBaGUm0utnddjD+ikUHTLQLC9pKlG3Fy//SoIC0bTFz5rSwnsQw/Y61GZx1AC
	/B9Ar1WM0PFeFkl7xO/KfKEtVF4qGEnzBk6BxzUSmFg+f3PVkz0+1zDJ5qzPO8V/
	Xs88u1kwLEhXfI/FaQKTRRDhkowQ3uTaIab/g7amMgK9Zi9YsDay1Isj0FiMqyVA
	mEZSqFXOs5gZ1yG3+Vv8mWHv+X+sRHEX3ulsQyIGU89+n6G9r/Q/QKmqFgylhqTH
	boy1rVToCFMqMZnIs7db2efE7/5X6Up2hy5ZyXh0nx4V38DuEspxMNXX0k14Tpsr
	WFPohzYZ9A==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taatvvybr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:13 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:11 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 07/14] libbpf: add ring__avail_data_size
Date: Mon, 25 Sep 2023 14:50:38 -0700
Message-ID: <20230925215045.2375758-8-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
References: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: 8EMmCCmMKtBspnmYE-CwWG5B9roTInju
X-Proofpoint-ORIG-GUID: 8EMmCCmMKtBspnmYE-CwWG5B9roTInju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=965
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ring__avail_data_size for querying the currently available data in
the ringbuffer, similar to the BPF_RB_AVAIL_DATA flag in
bpf_ringbuf_query. This is racy during ongoing operations but is still
useful for overall information on how a ringbuffer is behaving.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  |  9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index ab470179b7fe..d60254c5edc6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1282,6 +1282,17 @@ LIBBPF_API unsigned long ring__consumer_pos(const struct ring *r);
  */
 LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
 
+/**
+ * @brief **ring__avail_data_size()** returns the number of bytes in the
+ * ringbuffer not yet consumed. This has no locking associated with it, so it
+ * can be inaccurate if operations are ongoing while this is called. However, it
+ * should still show the correct trend over the long-term.
+ *
+ * @param r A ringbuffer object.
+ * @return The number of bytes not yet consumed.
+ */
+LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 3bec002449d5..5184c94c0502 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,6 +400,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		ring__avail_data_size;
 		ring__consumer_pos;
 		ring__producer_pos;
 		ring_buffer__ring;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index d14a607f6b66..07fbc6adcdd9 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -352,6 +352,15 @@ unsigned long ring__producer_pos(const struct ring *r)
 	return smp_load_acquire(r->producer_pos);
 }
 
+size_t ring__avail_data_size(const struct ring *r)
+{
+	unsigned long cons_pos, prod_pos;
+
+	cons_pos = ring__consumer_pos(r);
+	prod_pos = ring__producer_pos(r);
+	return prod_pos - cons_pos;
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1


