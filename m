Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71C54BE32
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiFNXKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1993152E61
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:48 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMd1rX002772
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cB8sizYRRXgjN+ikxvaI+bHUBq5x93jbXv0psJ5INXE=;
 b=RCo3o68uz3rq/scmdAhGN/DeTC/f05HSSdCv9awJQUbkrUV8N402/A8hjM7Bkh1oGsmX
 dP+L8AhPFo9T+BVUQCQLM8h6cwdcKNXnIO+mzcupnbpKwQWpmJbdoD+8yQCtGFAjFZkD
 vekYgX5hfGwBhS0TUTHblKe4WkUA7oGouw8= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8aw1uet-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyi8aCMCYLb3OqO79lHmEcojK2PsJ9JCZsozLIAlMGnlkDJJEfwTB76T9rl2vrKfyVW3DwbBp57zFDBUJi1Zn/MrCP6nlya5GjjTcCk6aeHHRT2IoskP1rtxG/4UvdJASPpxNSRfDn+C6Ycx00mi/pEpNgadhEF8s/y+CIKQA+zOf3MfjXtGcMIGjZdYQ/bIZl97jgPu10PEQBVcU4xepEs/LfEYWrXzdjr6EbJ0Y1+sN0mk1rd+4MpayEBu2Wjeo69y7wl9GLYH5JkyrejS0kWXVzIjNULBsgHWMCf01oKHu3qJ4Jd/j+Zs5AZsAtaGfakKFdgkQ0Gde/CmvF6mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB8sizYRRXgjN+ikxvaI+bHUBq5x93jbXv0psJ5INXE=;
 b=UPEoU6d5VdSpRPqbVWqEbUAQiGtPfAichowqOsH50OuVcALgC6cwS0iKWUw7gCBy6MMk4KBDh2tsY72T1YiLN0kCQS2G7ECAGxyZj1znSAMnOJRTFHHeOt+PTOdu4hez7zjHHvRbcqbt6AO5KO/FHTKTlxrgHY+Im18ABWC3thM0zvs/nv4Y//CXLEldNC4lhmOfcDMnsqT8uQbj5F5QgCyshzq9P184zS2eBEKYrSs9IDGt3WBzIhrS46VtA0YVRLrJVcEb4VhxbZiiFWlr7qPG6vXLrG26S2L1yjfj79I8c9WAFGyMWdk4MRrSm43B+MxXr6SLkysZS2Xc9PtI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW5PR15MB5220.namprd15.prod.outlook.com (2603:10b6:303:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:45 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:44 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: add tests for sleepable
 (uk)probes
Thread-Topic: [PATCH bpf-next v4 5/5] selftests/bpf: add tests for sleepable
 (uk)probes
Thread-Index: AQHYgEP54lQ4LSHYi0Wwb6FAljTYOg==
Date:   Tue, 14 Jun 2022 23:10:44 +0000
Message-ID: <c744e5bb7a5c0703f05444dc41f2522ba3579a48.1655248076.git.delyank@fb.com>
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7667d21-7c15-4338-0d2e-08da4e5b1c39
x-ms-traffictypediagnostic: MW5PR15MB5220:EE_
x-microsoft-antispam-prvs: <MW5PR15MB5220BAA6B7806D1DBB4D4A04C1AA9@MW5PR15MB5220.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wosHdTjTXtIgRySljgUAbSxHbC9xF4jkNR2Ooj2Bi8zJTNX5ACpKYzGpjnKExhOEyvN2aimWkGng797mEwBOWpH2wII1W0i3ieMbk3dzsJXAbtTCnkdIEFFEuT3NrwiGvRdz521gVHw2BYlEcfJMLAqbj1b/PtaUtHYBpe5nlwvTIRKkvUo8VmeRPeTLUvgk+0BoqIgSjgg3FSA2AJTsrwegezn0wb3lInUUqYzMnEqjRan8Fs37c+XvpdTUlo1Ignq6gJ31kLPQGO1GUIl9sFn10tjDytq7WtIycV2zkY+5cOgSpD3hQMIhJYyz7Tw7HrlKU/rncioLt+YZC4O7qk/vpmWodev2V7L8V+qpYAO4GxwWym74UPaEzXv+1AKhX00vct/eMq6d8YjkH6QZHPjbrwtv/qyj98fz8ulfSjVTYnBoAcPmutdojqOOLYXfJBV8+W1GWMVeHg7ADZeK+79nyMT79z7mV3xXo3BegAK8zoFyAYeNcXAXgaNmukkVrW8HmnduoxXL5HoXilPNScBsVtt0a/UI1+vLn8Db67GwWUKBVs26QEwuraapQCl6p+DWIW3E6F0Qar9oQxTsCGBie/6dpcFt8NYeGQVWl9OSwgHix0lpbgBwbyeAs96NnxNlJ2slCXAMJSTZsJ/SoqYKeXRQOXE3UPSQHvqOvXSsqBJHwlZ1OIv8pmZMZBUyhCBc9E32lLQrVrJc9OndTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(6506007)(6486002)(36756003)(508600001)(38070700005)(6512007)(71200400001)(66946007)(316002)(66476007)(2616005)(2906002)(64756008)(66446008)(76116006)(8676002)(91956017)(66556008)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6SMu0u3ovHWibWU8prOJM2YLKYunbXK+Qlp+2dtL/C+WMjWZfV02KIZZm6?=
 =?iso-8859-1?Q?6/+5+/6aLEVwpenJLzt0W8VtOfy3XuH/nj+w9GKjyE/9piipL6Ew7Q0Y7U?=
 =?iso-8859-1?Q?9FrW8CMl+cHKBC3mxXy7d+OZ7TJUSyYloIM4AmCKYouMU9APlrmQhZbTtm?=
 =?iso-8859-1?Q?0uK8Oln705NlhbmNYx36AIfr6GZ2fzmZHZzGe0aTESt8xqmb+XscUfNjMM?=
 =?iso-8859-1?Q?XIbpyIYVJBl4yUK5BnE8l3hZEmiK+nquNU83yJv7igddXabmy+Sv+eQLi6?=
 =?iso-8859-1?Q?qt19U6nQnI240Ipg2uTEq2pMXprw/cEpbQmWyxqikVnNN3eH6mVKvJOjxz?=
 =?iso-8859-1?Q?XteY79FM6IiZ+ez8KLyd5g0qUwmON3Nv/NyIiwEuxsnrCKlRzvzY5RFsjZ?=
 =?iso-8859-1?Q?r4rZvadauKf/tzU8Ks+zxnk4bKYw8OJoclDDFaMDGTAS2YeTsdKDoe4QKE?=
 =?iso-8859-1?Q?Ox62KR+XtsbZAFoFiuNNYHT9TmAjC9CJjAJHb8aOozl7xGYkRp3+sjdXg0?=
 =?iso-8859-1?Q?wPL3KpF40yGmgzgEVrnNRRqdimG/800LZnVE4UV1pJZ13pu/gGa+LfImbM?=
 =?iso-8859-1?Q?uPaVEp8k/UjtfPGLSe76ObHsemIzixcxI0sYSJ6dB8waS9SG6n8ZqeGIT6?=
 =?iso-8859-1?Q?tdPpy5rn+96EFkCkRiZMRU0tUzoNBRcEm4jceHDLiDTJkxRCdR1vEd/OtX?=
 =?iso-8859-1?Q?mNw8KmViUJlesRZWxTGAPyRw9kePsNW4C8CIA/u0UMQsUCojbWZ1qnxG+Z?=
 =?iso-8859-1?Q?SksLtRik8HffHrjYUi8/EKhlsmKVBJ3gjYu+SPgy9CXt7lvH7cxh2KpQqx?=
 =?iso-8859-1?Q?nllH4ihSN5Oyozc/e4p+wBYQ6IGJUdaUeQSo00GRESS1QWNBNMspx/9qW7?=
 =?iso-8859-1?Q?UUa9mWMBQeZZOmT0x97jlaeYDNl7N0BFsuO2vWbsABJJXOwkBFl6SB3kTN?=
 =?iso-8859-1?Q?9PP8iKLQyqZ2vXo+AkwM5QR9ov6GU59iesiJoezixDlUOowbQc1tPqaPho?=
 =?iso-8859-1?Q?kq0zZMyMDlU4Xw6PuZFt5txMRb8hLDNv/68adDBttaXH0XKpElU+E3dO0n?=
 =?iso-8859-1?Q?yeBSTM34uJv730Q/wbavkMMTfe+BzmLFISZGKKMBPAjK05inCjtot7lRHw?=
 =?iso-8859-1?Q?WRpkPB82SL7g/4RK7jzpZvLpkq5iBS7g8NPc9IUCWL6P+M1bfOo/O3BzVr?=
 =?iso-8859-1?Q?QZnqAt+ZSnBrlxm/gy2FTYU9XY/244768Zh/RddR9Ylh4nnO/NEroyIQNY?=
 =?iso-8859-1?Q?signG2WhkajOf7SqK62+2DMNp6SJTUiK488vXXqrS2jERUSw7tcB5HR55I?=
 =?iso-8859-1?Q?verLvtjPLHLH63TWhUZ0C0zRniFYxmrkMBoHm+5pVo54JsDeInRQ/2CqOZ?=
 =?iso-8859-1?Q?nK34vOoxTD50XcCS5Cdx1oetYTCR524A30s3AVdaq8GkOprn8i0UtzXr0D?=
 =?iso-8859-1?Q?aKex+B3FyM3WMEq1jrhozXZ6ilBEmffjJfRpS/+WhdT94PlR/nJkwtf5u+?=
 =?iso-8859-1?Q?Za0KroxREJaPkoxdDCoPz4PcPxc7sqW9yrNDs4CoMm8YCuwwIiFO+kQpZY?=
 =?iso-8859-1?Q?VwLpsY2f+xavS70DuLZc57a/rTBet6jN0BP3j7shiZScZIXfSbMBKInixd?=
 =?iso-8859-1?Q?YTPPUGk3lBJ7ftivc1rcDWdnQZs5wP2t2pk0/iKanYJg5kfGUTo68hL9tR?=
 =?iso-8859-1?Q?GNop3Qwwv1CgLi9HoK28kBCXpnAuBh5WIxcD7kmehO7vo3xSIGy7kad0d4?=
 =?iso-8859-1?Q?Dil3Or7UWznkYM3u7cSAvkdRG4D9ulJEsch8sSrjzlegeKeviH/g3vGzNS?=
 =?iso-8859-1?Q?HAd4Bire51RTxLcoSjqT6YDYcAjXlMw+jmt3UVxa64zHl07P9VD8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7667d21-7c15-4338-0d2e-08da4e5b1c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:44.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBjgE3z0fty1337U+N8R5vvwcUbwMeIZ7KCp5MOO9MBhVIx+jN1TVzIm1apj4IDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5220
X-Proofpoint-GUID: n4I0jkmRS-WEA263CQj94NSPzogmjxe0
X-Proofpoint-ORIG-GUID: n4I0jkmRS-WEA263CQj94NSPzogmjxe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that ensure sleepable uprobe programs work correctly.
Add tests that ensure sleepable kprobe programs cannot attach.

Also add tests that attach both sleepable and non-sleepable
uprobe programs to the same location (i.e. same bpf_prog_array).

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 ++++++++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 60 +++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/=
testing/selftests/bpf/prog_tests/attach_probe.c
index 08c0601b3e84..0b899d2d8ea7 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -17,6 +17,14 @@ static void trigger_func2(void)
 	asm volatile ("");
 }
=20
+/* attach point for byname sleepable uprobe */
+static void trigger_func3(void)
+{
+	asm volatile ("");
+}
+
+static char test_data[] =3D "test_data";
+
 void test_attach_probe(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
@@ -49,9 +57,17 @@ void test_attach_probe(void)
 	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
 		return;
=20
-	skel =3D test_attach_probe__open_and_load();
+	skel =3D test_attach_probe__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
+
+	/* sleepable kprobe test case needs flags set before loading */
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable=
,
+		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
+		goto cleanup;
 	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
 		goto cleanup;
=20
@@ -151,6 +167,30 @@ void test_attach_probe(void)
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprob=
e_byname2"))
 		goto cleanup;
=20
+	/* sleepable kprobes should not attach successfully */
+	skel->links.handle_kprobe_sleepable =3D bpf_program__attach(skel->progs.h=
andle_kprobe_sleepable);
+	if (!ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_s=
leepable"))
+		goto cleanup;
+
+	/* test sleepable uprobe and uretprobe variants */
+	skel->links.handle_uprobe_byname3_sleepable =3D bpf_program__attach(skel-=
>progs.handle_uprobe_byname3_sleepable);
+	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3_sleepable, "attach_u=
probe_byname3_sleepable"))
+		goto cleanup;
+
+	skel->links.handle_uprobe_byname3 =3D bpf_program__attach(skel->progs.han=
dle_uprobe_byname3);
+	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3, "attach_uprobe_byna=
me3"))
+		goto cleanup;
+
+	skel->links.handle_uretprobe_byname3_sleepable =3D bpf_program__attach(sk=
el->progs.handle_uretprobe_byname3_sleepable);
+	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3_sleepable, "attac=
h_uretprobe_byname3_sleepable"))
+		goto cleanup;
+
+	skel->links.handle_uretprobe_byname3 =3D bpf_program__attach(skel->progs.=
handle_uretprobe_byname3);
+	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3, "attach_uretprob=
e_byname3"))
+		goto cleanup;
+
+	skel->bss->user_ptr =3D test_data;
+
 	/* trigger & validate kprobe && kretprobe */
 	usleep(1);
=20
@@ -164,6 +204,9 @@ void test_attach_probe(void)
 	/* trigger & validate uprobe attached by name */
 	trigger_func2();
=20
+	/* trigger & validate sleepable uprobe attached by name */
+	trigger_func3();
+
 	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
 	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
 	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
@@ -174,6 +217,10 @@ void test_attach_probe(void)
 	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res=
");
 	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_r=
es");
+	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_bynam=
e3_sleepable_res");
+	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretprob=
e_byname3_sleepable_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3_=
res");
=20
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/=
testing/selftests/bpf/progs/test_attach_probe.c
index ce9acf4db8d2..f1c88ad368ef 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <stdbool.h>
 #include "bpf_misc.h"
=20
 int kprobe_res =3D 0;
@@ -17,6 +18,11 @@ int uprobe_byname_res =3D 0;
 int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
+int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_res =3D 0;
+int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_res =3D 0;
+void *user_ptr =3D 0;
=20
 SEC("kprobe")
 int handle_kprobe(struct pt_regs *ctx)
@@ -32,6 +38,17 @@ int BPF_KPROBE(handle_kprobe_auto)
 	return 0;
 }
=20
+/**
+ * This program will be manually made sleepable on the userspace side
+ * and should thus be unattachable.
+ */
+SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
+int handle_kprobe_sleepable(struct pt_regs *ctx)
+{
+	kprobe_res =3D 2;
+	return 0;
+}
+
 SEC("kretprobe")
 int handle_kretprobe(struct pt_regs *ctx)
 {
@@ -93,4 +110,47 @@ int handle_uretprobe_byname2(struct pt_regs *ctx)
 	return 0;
 }
=20
+static __always_inline bool verify_sleepable_user_copy(void)
+{
+	char data[9];
+
+	bpf_copy_from_user(data, sizeof(data), user_ptr);
+	return bpf_strncmp(data, sizeof(data), "test_data") =3D=3D 0;
+}
+
+SEC("uprobe.s//proc/self/exe:trigger_func3")
+int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
+{
+	if (verify_sleepable_user_copy())
+		uprobe_byname3_sleepable_res =3D 9;
+	return 0;
+}
+
+/**
+ * same target as the uprobe.s above to force sleepable and non-sleepable
+ * programs in the same bpf_prog_array
+ */
+SEC("uprobe//proc/self/exe:trigger_func3")
+int handle_uprobe_byname3(struct pt_regs *ctx)
+{
+	uprobe_byname3_res =3D 10;
+	return 0;
+}
+
+SEC("uretprobe.s//proc/self/exe:trigger_func3")
+int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
+{
+	if (verify_sleepable_user_copy())
+		uretprobe_byname3_sleepable_res =3D 11;
+	return 0;
+}
+
+SEC("uretprobe//proc/self/exe:trigger_func3")
+int handle_uretprobe_byname3(struct pt_regs *ctx)
+{
+	uretprobe_byname3_res =3D 12;
+	return 0;
+}
+
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.36.1
