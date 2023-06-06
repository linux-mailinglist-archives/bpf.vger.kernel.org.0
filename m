Return-Path: <bpf+bounces-1915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BD723641
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC79C1C20D6F
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896662117;
	Tue,  6 Jun 2023 04:28:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A1A41
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:51 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBFA11D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:28:48 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230606042846epoutp01bfaf7dd86f15f8cd881c0ff798e3610c~l93cQuQjt3036330363epoutp01c
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230606042846epoutp01bfaf7dd86f15f8cd881c0ff798e3610c~l93cQuQjt3036330363epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1686025726;
	bh=qRx2MiVjTdrQM2Tl4Oif4fJU4zipVUeupStPUSK9Ej8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjQmYYwbO+uR5l5br3SlPAU0uWRT1AgrotaR+DY6j2D+kOO37Q8i8croB1hKWKFdD
	 YmTKe20pG3oWtzc6VpbeF1mcI07+3gdJBi3KYM6MHyyWZonuNaSANfLl84hmB0yE4T
	 dzh6Spk8ZvG9dfSmDiBKcr/DQLpX174gS+tF6UNo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230606042845epcas5p3de5c474826c91795dd5736390a65c0c3~l93bYCZbi0807908079epcas5p3Q;
	Tue,  6 Jun 2023 04:28:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.18.44881.DF5BE746; Tue,  6 Jun 2023 13:28:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a~l93DOuE-p0584205842epcas5p48;
	Tue,  6 Jun 2023 04:28:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230606042819epsmtrp23a9feb9b8c8d4a4ffdc6654280c22913~l93DNhXea2695426954epsmtrp2C;
	Tue,  6 Jun 2023 04:28:19 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-87-647eb5fdc43c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.13.28392.3E5BE746; Tue,  6 Jun 2023 13:28:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230606042813epsmtip1e7ff603b02a4b4a77f85c0d217c1b66e~l92_F5ULT1767917679epsmtip1A;
	Tue,  6 Jun 2023 04:28:13 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com,
	glider@google.com, peterz@infradead.org, keescook@chromium.org,
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v4 2/3] bpf: make bpf_dump_raw_ok() based on CONFIG_KALLSYMS
Date: Tue,  6 Jun 2023 09:58:01 +0530
Message-Id: <20230606042802.508954-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606042802.508954-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHPffe3pbO6uURPYXhTCdDSIrMaXZM0G2EbFdnRoeLRFnmGrgB
	x6NNK8MXWAW7gLx0EmmLSEXX0rEVa9GuWF1LWYHINjs2kWnEDAMRdZaCINJstHdm/vf5/X7f
	7+9xcnh4hImM5u0u2sMoiqQFIpJPXOpOSBAHOstykq11S9CQ6zCBZp7rcDT17E8uarcexpDf
	7SHRRPckQK36pzj6yufAkctzjYuabq1FR2xGDLlPanF0/VghGrtag6Hf7E0k6j6jJlB7ZRsH
	DdXfByhwYoiD2s4YADJWP+EgT82PGPrnr2kOOm98xEHe2QkCeQwBEgXcTgyNzk2SqHYgA42f
	awTvrqB1qhsEfbz8MZf+QXuHS7dYiukK9yMOfdGYSFcNeXHaYqokab2qAad994cJutZqArTZ
	+jtB+y0rJIKd/JQcpmD3l4xizabP+XmGOh+QH12813ysD6hALb8KhPEgtQ62DlSRQY6gugCc
	noqsAvwFngSwxlZHsIEfQLe3ZSHghRwjl8PZvB1AzZ12jA2mAKz9pQMPtiKpJGiyXwm5oygb
	AX+9MBJS4ZQaQF2zM9QqktoK7/WlBQ0EFQernplDZgG1Eeq1Dg6732tQ453hBuVh1CZorFnN
	SsJhn2aUCDK+ICnv1OHB9pDqD4NmWy/OetPgT1dvA5Yj4QOPlctyNPQ/dpDsNSWws/4Q660A
	8FrTSZLVvANHb+g5QQ1OJUCzfQ2bjoUN/d9j7NwlsOb5KMbmBdDW/ILjYMWtjv/Wj4F+n49g
	mYaBsStc9rGOAzji7MfrwUrtS/doX7pH+//oFoCbgJCRKwtzGeV6+doipiRJKS1UFhflJmXL
	Ci0g9J0Tt9jAvZEnSS6A8YALQB4uihLYtxzIiRDkSPftZxSyXYriAkbpAjE8QrRcEL+xLzuC
	ypXuYfIZRs4oXlQxXli0CssbSGvbSnvTV2eNJQ6nCMTfOnY+zIn9Oz99foMw3E0Lt0WHxx7Z
	H38g/I2JTvmuy92qz7bZ4kQ/G0pfH0ujtjvf0p+aU8ve/iiFqB5snImf9qhkJXFN52La1n2S
	2fFAMvfe+3GG8Yy7XYOS1loLJiuuzk9PVmfr0of5m8s3LJVInbOlFwM7yKWLhJplRW2NqZ8u
	62ltearmNN+8Lvl64iy6dCg1s+DDwvWnZxserozcPDm/6OA3qaf3TWctX3Vz0HJ7cY/JMecR
	Z70SdV6R+4dj+96mfnGv2kx8l3oX7xWWlU3Nn/q4brIr84uMSteJufrS8fILGa8erY7fIT7Y
	84EmmTGSIkKZJ30zEVcopf8CTj+g9z0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSnO7jrXUpBrfm8VvcONTIYvH992xm
	iy8/b7NbrNnSyGTx+chxNovXhz8xWixe+I3Zov3jXmaLQ8f3s1vMuWlk0bRjBZPFkSmzmC3O
	dOdaPN/Xy2RxedccNovD89tYLNZ0rmS1uDHhKaPF30k3WC1Wzl/OaLGi5wOrxfHeA0wW/x9/
	ZbVYuuItq8WlH69ZLI4v/8tm8ffIQSaLJ78+sVn0nQ2yeLFkBqODnMfshossHhOb37F77Jx1
	l91jwaZSj5Yjb1k9Nq/Q8ui6cYnZY9OqTjaPhQ1TmT0+Pr3F4tG3ZRWjx/otV1k8Pm+SC+CN
	4rJJSc3JLEst0rdL4MpY3v+RsaCVp2J990nGBsY+ri5GDg4JAROJB9sFuxi5OIQEdjBK7N72
	ja2LkRMoLi3x8997FghbWGLlv+fsEEWfGCU61q5kBUmwCehJrNq1hwUkISJwh0Vi38uNYFXM
	Al2MEg+frWEHWSEs4CPx8KQLSAOLgKpE18/1zCA2r4CtxMJZe1khNshLzLz0HaycU8BOYkWv
	BogpBFTybTITRLWgxMmZT8DuYQaqbt46m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW
	6xUn5haX5qXrJefnbmIEx7+W1g7GPas+6B1iZOJgPMQowcGsJMK7y6s6RYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmyy3vdghczXJOmj9RMvTss1eT
	p+bc+GocdTSk1i6BXWz70wipTR/EFvCJniw9cvil0WRD2W3hCjY7WsTUDzGzdet7X1kiFW7m
	7KGrfObkraWXN/8WVbgW58e2NJt1xkrLwonz5nCe3zHHqe9Sy3yufcIaEcb7gmvMPLaKq63K
	XFlg39l3e92ex4oP123cejyj1Dfq7MXGQsE/1Zkcv95Yl90WFZzL1PX8+vP5Ruzsjt//ld1f
	cDBgxRcboRyR5X6vUxy2J5b7a8s2vVGpX/7w9r9EfsGbmv899wmnHQve8vzbjlOn9N713jtV
	ZDvzyynzPA6x1hjzFYLakwJv/mstr9TrP8tTm/HYv9AjS7lHiaU4I9FQi7moOBEA0svbTG4D
	AAA=
X-CMS-MailID: 20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a
References: <20230606042802.508954-1-maninder1.s@samsung.com>
	<CGME20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
have a false definition for the !CONFIG_KALLSYMS case. But we'll
soon expand on kallsyms_show_value() and so to make the code
easier to follow just provide a direct !CONFIG_KALLSYMS definition
for bpf_dump_raw_ok() as well.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/filter.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..1f237a3bb11a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -923,13 +923,21 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
+/*
+ * Reconstruction of call-sites is dependent on kallsyms,
+ * thus make dump the same restriction.
+ */
+#ifdef CONFIG_KALLSYMS
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
-	/* Reconstruction of call-sites is dependent on kallsyms,
-	 * thus make dump the same restriction.
-	 */
 	return kallsyms_show_value(cred);
 }
+#else
+static inline bool bpf_dump_raw_ok(const struct cred *cred)
+{
+	return false;
+}
+#endif
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
-- 
2.17.1


