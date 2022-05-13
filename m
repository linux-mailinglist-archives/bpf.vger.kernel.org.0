Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B73525959
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiEMBWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbiEMBWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A855468A
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D0ZN90009739
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Cv5Cj2GGOTH6YHFhMyXgNukmieyHPUty3NmmOaaRfg4=;
 b=dB3vNEC8hS7yrzUgMRzxCU3jBzGLg/8Jp7U11CXCoRzoSRHfmV/63vcB+7dvgAmZ3gRV
 MoGOrnwU+ZW1xcUKN89aVw0MbDnnmeAvLgdPNoQ5McjslGXaiK6DmMhSeTUDeQZM2GyK
 T1kkN6Nautm3vN36vfsMR2uWXUTfmCVfqLA= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1cwx85wn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqDOz2oPJyIng0AThR5sQIP+QP9omjZFVPXXYqM3OuRVUGVoeGhRp1jYsMJPpFglksqiBaW/yZKHA2DSXHARMNhbkWHfVvRcfVu9Um4spW5icECsQPSR3RYZgwbSm9zgplg3pu1UuS9npzIJcBrILsctP7+uJfkpUUXT8MYXcbrNx5ADGKeD+YoMRMo5VImU7lOLb/xtTl1nhkAhhlG0VAGj1R3CatMnxK2qCGbdK911gZxbsU9U6h4lujR9V41990fsM1VeLYL2DNsgFcY76RrITEQKoDPEz01j6YuX1XSm8PRePyNQgd57sQlu2AudtdDAgVFJQKr3WQP5MSN9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv5Cj2GGOTH6YHFhMyXgNukmieyHPUty3NmmOaaRfg4=;
 b=IKiItGIoA4dKIllX28yrWVwklGZzWsE5YUbeCnOuEI66DslmAteoseFZCfWXds7X9Ur0fiUvXOIoFctLvsKToJZUKreuOT+QMvpCcYsOnxiRFXU5afOx9UNZZpPUN+S972th5tVahQhJV0vgXb9ewAoiFo/zERfN5lmH8MgvrjMbH5ip98crxCxonmemRJr7Wa/4iqY46XFrDbREy8cjeDUt1GtHmpBrowvRaKNb5fV0l32tM0xXq1m6tH6C1Hi+WpGugTmTg4vkZhLMdmvdqlzifEp3LKO/bc/0MmnXKXQnkd2AyLDHbmtb14SHFWg42c0Z0j5bJV28ke6/c7u49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1208.namprd15.prod.outlook.com (2603:10b6:903:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:40 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:40 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: add tests for sleepable
 (uk)probes
Thread-Topic: [PATCH bpf-next v3 5/5] selftests/bpf: add tests for sleepable
 (uk)probes
Thread-Index: AQHYZmfwI3KO3DjPKUqkzc2Qe37WDQ==
Date:   Fri, 13 May 2022 01:22:40 +0000
Message-ID: <0a7d4944b0952e92a8bb75a312a59ff975c6bac1.1652404870.git.delyank@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
In-Reply-To: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1415796e-4519-499d-1b13-08da347f12e2
x-ms-traffictypediagnostic: CY4PR15MB1208:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1208C81214754C8FDB525923C1CA9@CY4PR15MB1208.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqI496NxIoSULUbheQ1sNjx2GVcxpJU7GVGHR3Ic9U90Zydkkavj/2BQoX/NKz2XNcHKk64/QzWj7uc58fHPa+nkgk6qeP4JtaERqJezebuRzXYwfEjhSl4DUoIixxUyremD0lft+8W0OFu1QdZw+QdL72+acnCVsSSx5XTV4EJQCAw0shkDM4AQ8KM/8rYUSJoYBXIz6Tf8UBliHbabl7JEKMH03TfHhIV/woclyDiLeFFH1ZNqQGBtBfCw0OuRcZcT/EUbTsIktB/nR/0h8mBbTX6MjYtsz8pLqw5+CoV6UJNQXHV0YSEzYaNqp4MuVkzNvYB9EDtwpeXfwKrkDz7kPJMbBroQmEXPab7fsDOfoKQP55fw5IBf7OyQET1mk3pe+n/gKHX1tx26rJG2KW+b3mmF1SX1ZFG5g0HNixhm7c3CUA2K8Jv04rZM+UAeoRiO3ilEjbRU5FkL5bt7yx5zU3Hx3atyCdZk7R9KhE0mRT8ot+MXfe4EcI0U60ZZUyOWi+LYVFlxGwT8wfDEt1PFv9RvZr7lplPhOqvTGWcoVLVtei15tRHZ7EazilfB9zhTMV0QE97qu7J6EbfNY9NJWj7J3AwGy6OcIg/wrpOGAf2/UgJX8zecAft1jQS1Rk8bg78wwwU3t1DjgLkjE5BhE6upZHvYYaHZjb3alSWANKXMdsevpqm6lQP9fo3aAlFxRWa/rzoKuQQvyr2kxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(122000001)(38070700005)(38100700002)(36756003)(316002)(8676002)(71200400001)(76116006)(186003)(64756008)(66476007)(91956017)(66556008)(5660300002)(66446008)(66946007)(6506007)(83380400001)(8936002)(2616005)(86362001)(6486002)(508600001)(2906002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gooHFL32b2BbIS4MCU6TCvQnUXsI6sIQkrafT8oXWtZNvZ/Od25SP4QP7d?=
 =?iso-8859-1?Q?dh7CSxjUWAv9mdQx4oBfahk1isz98VzNWB+xJcnN8qHgCl4n+M46YSw/lL?=
 =?iso-8859-1?Q?LWGte1BBICV87n6uccNdq8hMmY5tip4PWvLJeR7ETOTF95i5F2fzMlpdzM?=
 =?iso-8859-1?Q?sT8NWmwLP7/wpHhel3r8fLhz9wJqqEOH0+b4HYbtDKz/sNv1P5wWDMy27Y?=
 =?iso-8859-1?Q?Vlx0ZVyxw2wAWzbjjWZd9hIuy+5fPSbqwHjPN4/frLE9BPiEDREmrjvR8M?=
 =?iso-8859-1?Q?S/5V58Z40yqnHi3vs6v0g0ACSbnra4Ku1WUaP6Fjv1PHz40kvinzJDJNFT?=
 =?iso-8859-1?Q?bPjt+kAkgmVx9DEmFhjg2sy6b457SE1C7Lz8EZGdP3Ju+cdQm/qv2M/Wth?=
 =?iso-8859-1?Q?q1PhpVQdpbw2RVxz7IzbpX6bpq1S5IRGR7ycpbQr3yzwDLvcx5MyIdDzZ1?=
 =?iso-8859-1?Q?95bK2wFFPt+G13TkUYB2bMPKyift1XvTYSXrB97C2FPdAISYMxT1XknkJL?=
 =?iso-8859-1?Q?jhODNGE7RSS3nyu9qJZdwL/xnbapTsMLWNP6eyTlC+QRJjbfS2HQ2GPgjj?=
 =?iso-8859-1?Q?h/+q+FEgCS/ccduIBi0V8PiqP90C7FCjgShYrDK3XAWy+UC4G8EQokA5O3?=
 =?iso-8859-1?Q?LPhGqE+jMGoyVx2zxcisKH3uIu2OuItpc+MHGWOVTp7dGU5wKDVHYnu0zE?=
 =?iso-8859-1?Q?rHfKph9klMuj5C5dp/EKIBUGGRhAHZ+r2W3Pvdd68jhMtndlHxKnIbL/VO?=
 =?iso-8859-1?Q?LkFOAzfqrO4EAauYNGtau/f4QKdO4Fx/+Zw2MevkJo6tSoijf/KL0+Ffmn?=
 =?iso-8859-1?Q?1TZPPesaeaGmMrGsaQjnZ9AhaMD+OABiZW9Vyv9OaRDV8f57y3hiYv+pFa?=
 =?iso-8859-1?Q?ULzO+m+ggl2CxE0JGqzO4mRU8x2IosjylkGV/QyELMZYonv+gtmWexbWae?=
 =?iso-8859-1?Q?deG1mpVeuRNE/SUP1Mqv2U72kdd+jVTxAGqgjKoVFsb/CefhIgNhcTNzDL?=
 =?iso-8859-1?Q?y+8TcC5EVtJWqnJSWi0dAE2nX0KYA0xCIj/VIuKEu4ijXSRzpxUiRPOntg?=
 =?iso-8859-1?Q?hue14vU4NUdobJhvlE4Zk7w5oc3+86ZvLgXcu57d27Zuu4TzN2lWgOrtpX?=
 =?iso-8859-1?Q?dbhabrIRjTC9aV174SKGz34wXlw7i8S15vlhwX0EUdBntf4Oq3R9XhrVa5?=
 =?iso-8859-1?Q?1VpKG23kLp5OkK0A5OD7fBMFC+NkZ9kFdngn1gRo4vC7ChLo2VtlucfSUr?=
 =?iso-8859-1?Q?P7pVB5+q5VU/SYiq0PwUCV7dOv1Zho4MI82ZD1QtSDbWWqod7NNDHaNSLf?=
 =?iso-8859-1?Q?ul3+LJdYQF2vTjbTDHD2jir34CNWTjm3FikpPOrcLknr+2sofBckOGmDr0?=
 =?iso-8859-1?Q?Ag27bJvA+ToZsDmpP4RZ3G16Ar9+F+PCweogJRsfJRSPL2p6Z7XoAYauv1?=
 =?iso-8859-1?Q?0cjvNcnVnWdrbA58GxAJ6IKXmdgjxy1pBeAbN9WNVusswFcUApR1ea/x4V?=
 =?iso-8859-1?Q?C4/O/7gJWJInqlZ1B9smqGj/u/BaggeoMP1fs86w5B5qxApyUondtVZxZ6?=
 =?iso-8859-1?Q?6fCRAcau28wPOhEkAQgv85+oGb1V1wa5OEU+JPM+KE0DAsSBDIx6O6rUCL?=
 =?iso-8859-1?Q?98OrT0Zrmb0j420fEYykDFNZLN481K5Rgs7Tkyf0eZFbejiPAeUl2HsmVq?=
 =?iso-8859-1?Q?B+aSbRpa9SxQmrcLjUzMx7dfsXnogDF4jQS+UdVyE6UOnHhBzRLvle6Yrh?=
 =?iso-8859-1?Q?L6ytOiIQ6re/RpLToUNvl7x+VyIj31Dy7kS/nCv8qrkhdwQh8lMd9AXvpW?=
 =?iso-8859-1?Q?54L+NpYRN1+8V7xUk3cJ8demPHNzttMR37uVB/i3fNe/4vf47S6/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1415796e-4519-499d-1b13-08da347f12e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:40.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fou3Oxm0Vr8cyMOjxxt+KtVT/1sjj6G5fGox3tAp7qcpKkJ9B3QG0Sr2+PTLdkfy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1208
X-Proofpoint-GUID: ku2xmQkiNV0dwRspBtMx5WyXxZ4XLuKI
X-Proofpoint-ORIG-GUID: ku2xmQkiNV0dwRspBtMx5WyXxZ4XLuKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index ce9acf4db8d2..75d2b0492122 100644
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
+static inline bool verify_sleepable_user_copy(void)
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
2.35.3
