Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED1517A78
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiEBXNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiEBXNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1FB2FE56
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:40 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 242LsRMb014107
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HMfablRoep+/y1w7Tny77t3kBHOCjdFo/7gm23hCUK8=;
 b=ZcdMdoHGRXzHNQdMRZ48boupvzfW7F+vSrcNyO69+Xz5ovTKdD45c7byVY68x4ser1ea
 fvn4HPhOW9MUzHWVLqA5s+iv9d79sa3nxPRM8Y72etuRLCNaIJDy9+f5COz/uqP0hfzN
 GyHFMbkdT2eIoPN5pPbr4uu8GGjODmZBmqQ= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fs0sucuq2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl5hONbLKAVQ37pEGpfGfLNPfR0sWgKdVfhzBi2PahgLHP4oeFC02Ai62ZbCr1vU07jdYV8A38GZmqbG3rDpIFmMbqLU39zyRrPCBKEOkFrjOt5enBs3KKwvNiWYh5tAvyMVx7q2ToY2nKeUTstfSjjSG0WtLu1cgUQLSZaYlks8dkzJi+O6H9IUUFxRgcFqDH3+y1EbNCtBLDcofVhDJgwRDD4m1eJDnyij6f69TxJ1V5G+fKwGip92l3PKPcwfoRnBt48vehoE52TOp66bKswKW3WRk4uAovblPSbDC3KFD44OWaUhoXcMDDOGOw+jpmuyYuEzRsaNTmh53LHrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMfablRoep+/y1w7Tny77t3kBHOCjdFo/7gm23hCUK8=;
 b=irOVyl3SWKb95zN1w3fbw7841H8E5rzHrWZs8//2yXDoihtea/p5136QL1qZ6kdK/ZU/Yc82b4ra7J3U4/kbV8TYLUVYxJ9k9jX7wS8cFBOzR8PFZq768cbyMUOjDUu6S2kyUPtdRbEdb6Lvs6rz836SbeXYU0FCLrs0nVm14HI0AAF1231k7I2KZbRJL6WDMh0R4QhSSutALwWON9KXojRdguB1nvNRLFjKMR3QidbggpScKWQtMpP6i0dqfkG8lcPbudLu2czCYlDZPPn28wkNoA8yH63KxvHYqsP2mid836L7wKC3YqfeBwzoklbPZuONxRd4BvCEGoeYPashQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1903.namprd15.prod.outlook.com (2603:10b6:301:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:09:36 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:36 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for sleepable
 kprobes and uprobes
Thread-Topic: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for sleepable
 kprobes and uprobes
Thread-Index: AQHYXnmxf32KBia6pUayDYxFbYIsLw==
Date:   Mon, 2 May 2022 23:09:36 +0000
Message-ID: <50290e7abc06f4aa7ea355a7aeb64f059a998c7f.1651532419.git.delyank@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
In-Reply-To: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb5c8021-7a72-4524-24ec-08da2c90d3d3
x-ms-traffictypediagnostic: MWHPR15MB1903:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1903E5BBB739A94C94742E33C1C19@MWHPR15MB1903.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eqNKzjugUBybJpFqhvhJydgdav9GupiTF6zHfI5dlX/r4Z0nBEipbe9gzHXzCxdY1thsXoaklJCb+tovtd3OoVdO5f8s0wqT+2ng/drd7bxHzfLnd0AoVIA6ZnwnSEsN4Oo+B/HwCU5L+rZlG1HKbuc13cUU1b4njma7sAcO9e6xDSFsCD9ammOaSctGtZPZKyOO0t1CXHGK6EbsSTJ272q7c+HUU0aXTVQfzK6LpXf5bQnZnHtrKX16VtAJDGOE5I2Em/IvDzXf8OySxklxiBMdZ9X19sgyh8Db996UoaqvjwI7/HMVgsAMK0vKx5SQaGzh14Dx66/mFsozkM3GAl9zB/u7AKqJl+AdwrFTwnyT7l/QfxZelCIT5eTwJKB6LGyxewFjT03F6ndCErVQ6MYXX28I5zfiX2Bw0w+oFodhr5k2opjaIHuCSa/cSoqBsDLrsKFCUrT1WflF5UyB6tCh9EBbGzWaOVHlKYMjLcJX1+qk/6DmPGsVNWiT+JpedPwHqMJTHVckvD2rlgQGhYYMMjbLYDqpAY7d3ZzQQnmgunapdxLKtQCeeasdX0Mzh+fEFqfUmnGkBg/8E+2gRuHNkh4BQhcrwoQreq5U9bcVx4LLBHx/iDgjxlY+VZy9g7W3RSY72toWypTYjl+TGw9dXktbn9P/ix6JTAjM5YMU2YAJzT1aW1gvCIQRUrCbUbiNgJRE4PvDnxU5Hus1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(6512007)(83380400001)(186003)(2906002)(66446008)(8676002)(76116006)(86362001)(5660300002)(71200400001)(66946007)(6506007)(8936002)(316002)(66476007)(66556008)(64756008)(38070700005)(6486002)(122000001)(508600001)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ui4LuqjBo/GNudpzLpkcTlgiCS/E8sBA348akuT3uB9jsTvHogkOsxoB9?=
 =?iso-8859-1?Q?B47hekhnaFeGf9vSpdI1yqO7m1hyuqjjbCQPifAseyOD4Y+RKPLEOnkfdg?=
 =?iso-8859-1?Q?JY7BpscAqVswLyXJ5K/+6xALSPkdCxAkN0dZ4bFRTmY6SfwmlnugNmdtW8?=
 =?iso-8859-1?Q?StlgNhnahc2LKNy+y+lWIlIWUQlcZHzfSOX2uQmn85mzb3TqYp7qvY9zMy?=
 =?iso-8859-1?Q?3/HNJed+Y+Nde1esVjBPiyiG3gsJ8sZPzTBLr2oaDn31lCZ/3QDpkDCpI5?=
 =?iso-8859-1?Q?p56MxT2xhyA0SHbcyfHy6U1wnUnk28xT/5HxhW/HnA99RM4TUuPKTrFif8?=
 =?iso-8859-1?Q?U+wX1BKzlgyQ3ktG/gGG3yeWqkyQHgCh6X20zKzJnWe7CI+pQT9Uc8Tta2?=
 =?iso-8859-1?Q?YKbEsAeUoC1keyJi+0G21zorKj97HFO8MZzihuiuQUb3ffHg7Tg6QW5hUo?=
 =?iso-8859-1?Q?Xh0f//iIXQwV+eUnsHXAXB9293DDdf2r3ij1ZseH4aOReU5zUrEb9wo7rC?=
 =?iso-8859-1?Q?yyVzrVXW+i7XUvDaSYij/vHKrTUm1zhKGSKI4kuAtR2Jyxp7BsPGKXCNYy?=
 =?iso-8859-1?Q?8dOZfGu2mm1ZuUyQ74X0zeOz/OOnhe6Vo9KoLOC3zlK6edrPP/4UG3sMI8?=
 =?iso-8859-1?Q?L6y4qskbjSdncPw2vXgWhe8ug1SOakcG/pTd4iJOiXYNcmfsMOAJS3mXi0?=
 =?iso-8859-1?Q?7gm7G+63jObrKocVqaz4WZ5kfvztXyY8tPgg5Dg/oi5UuA/Xksj/wzRKms?=
 =?iso-8859-1?Q?4LYFNaWfz8lweyCPOJlz2k98qP1M0iurP694lJRFYmvCMFV42HUBru+OSP?=
 =?iso-8859-1?Q?CuC7GtlWCrsFOpIPHQJ2UvROoEj4nRen1GIQBzgMb/uL9XSH2bn97i575E?=
 =?iso-8859-1?Q?3KEiEI+ziTZ0pN4zt94dC0cmQWmqbMZXC4xXV4MaAmuq9jjO95Cw0BR+Ni?=
 =?iso-8859-1?Q?7PSlmVs7y7Gz3YfhJalRg/Cs68g4ig8QWRUOfFqqd7FPTCG6rgdm9DbAzU?=
 =?iso-8859-1?Q?0eZ+IdY4nSBQsAAWnlAZCG27oQTR/0XhGHkNp8i8AaatRz4B854UPZMSae?=
 =?iso-8859-1?Q?VFjQuHci68wogv26Cmk/0IECLSP0/xChaPP9lbgy6S49TP5KQvTfJ7UE3d?=
 =?iso-8859-1?Q?GtulHq1Lf2uqoOXJMFiokZPhf0ZoWpAfkL2FmTkZzbPMHV2bquYulJgxGN?=
 =?iso-8859-1?Q?cLMyFBVzOE4tluFHtdu7sI8K0nb6bNZVZKvhEn0jPGmOjCoR4JIEfSbG0X?=
 =?iso-8859-1?Q?9jHhb15POYJ16g7YJOgNgsLu/xTUw9/dWN1VSOL/hPV+XYM7JTN+VkybtU?=
 =?iso-8859-1?Q?Ug+PTz5eubb/TKN9w2ybMVckmeYfbYFvsxMXrM6/Ogc1zTjpFzhwM7zmuO?=
 =?iso-8859-1?Q?fvBpEVIuhAuRGgldr7ZjhZYMFpbSaHIaWpe21rFofs2EUatLbUtuzxhFUy?=
 =?iso-8859-1?Q?BTX4ZytsIUSSohSuzjvcQpjF8i0JelgDcqIN05AGkFSwGwIndmP6t2RkM5?=
 =?iso-8859-1?Q?njrGBSepayKaudkAGu7vCTKA+an7N09dJy3o6Vbdh9hWlPOT1qi9lintaB?=
 =?iso-8859-1?Q?lhRlTsXkdJGxs5qGEoaFH4oNh1Ga2CN64R2z68kWp9WVgGm6yUZIGjPce5?=
 =?iso-8859-1?Q?/BU9V2FxvB3nfeMvpaY+rcnvl3IJbEgTRZGAZZowtgLox9fX46T23QmI0q?=
 =?iso-8859-1?Q?sqoUBT2wWhLqX3Zt2R9MbbQ8RVfrQ5BLMcltMdPMQj9LomF+OgLwOotbgo?=
 =?iso-8859-1?Q?yRNJz95C6zbl7iaEMMMdSYMDVXlSiYYfLoy5MkfxvVYaavfYCUs0N/oHtB?=
 =?iso-8859-1?Q?kd7LlyBGmHYkwgF1RW+6YbsE8LNZfrjiGfuepRvMau/oZnygjre7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c8021-7a72-4524-24ec-08da2c90d3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:36.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek4aITUiOmJ8CqalmCgaOHUCVQ74SPPzZi8dqBk2dzUP+7kKhlqKA55U41nzhZCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-Proofpoint-GUID: DJ_FnMlJhV3PaR0dfiYzwsh4QEH7_J-T
X-Proofpoint-ORIG-GUID: DJ_FnMlJhV3PaR0dfiYzwsh4QEH7_J-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_08,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that ensure sleepable kprobe programs cannot attach.

Also attach both sleepable and non-sleepable uprobe programs to the same
location (i.e. same bpf_prog_array).

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 51 +++++++++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 58 +++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/=
testing/selftests/bpf/prog_tests/attach_probe.c
index 08c0601b3e84..cddb17ab0588 100644
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
@@ -27,6 +35,7 @@ void test_attach_probe(void)
 	struct bpf_link *uprobe_err_link;
 	bool legacy;
 	char *mem;
+	int kprobe_s_flags;
=20
 	/* Check if new-style kprobe/uprobe API is supported.
 	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
@@ -49,9 +58,18 @@ void test_attach_probe(void)
 	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
 		return;
=20
-	skel =3D test_attach_probe__open_and_load();
+	skel =3D test_attach_probe__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
+
+	/* sleepable kprobe test case needs flags set before loading */
+	kprobe_s_flags =3D bpf_program__flags(skel->progs.handle_kprobe_sleepable=
);
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable=
,
+		kprobe_s_flags | BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
+		goto cleanup;
 	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
 		goto cleanup;
=20
@@ -151,6 +169,30 @@ void test_attach_probe(void)
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
@@ -164,6 +206,9 @@ void test_attach_probe(void)
 	/* trigger & validate uprobe attached by name */
 	trigger_func2();
=20
+	/* trigger & validate sleepable uprobe attached by name */
+	trigger_func3();
+
 	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
 	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
 	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
@@ -174,6 +219,10 @@ void test_attach_probe(void)
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
index ce9acf4db8d2..5bcaab2c0c54 100644
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
@@ -93,4 +110,45 @@ int handle_uretprobe_byname2(struct pt_regs *ctx)
 	return 0;
 }
=20
+static inline bool verify_sleepable_user_copy() {
+	char data[9];
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
2.35.1
