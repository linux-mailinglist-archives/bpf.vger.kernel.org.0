Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346BD513A6E
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiD1Q5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiD1Q5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45E9D04F
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7bkY026710
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qYYfM4jpQsgZ1I4zj/9WHIp6BYyP77ofjCQWx+xmyUY=;
 b=ezndlwqYX3Ac5Ew5Lz4Kg3Msu4nXH3FCZ1iYugaIupijMUtmZkE79H2dxKKtserz1Y06
 BrpGe1eiyCx0aKXd6AW7vO7gvfqLspd0X7puTM1ZXqmtQDjlWFf8VCvtaivVWE56AIuD
 jvCP8yyFJix/9HgfcrYQFganJHaGtl9CKqY= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40r4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvDr2Z3exsFPQDHGLx5/UrhMWjxmChbfBUyadc6zoQXP6YN7ZYeZUupK3qS1fbCF00WEOypFm5t1PihesqjR+iWTUT5KPDKgGgZ1rtVb//nSxWtnxlbiNgNdAt4lePpIw063WQRb2qwQrQXkhjdndNTgBqGhmibcDaOOkSyM22fpREv3VYPh4kXu2Qmzi7O+zbIqu9xsLuIJGG7NH+Dth9suf93mdukC5yHcS6b4s84qaKeGoFiptvb6q2ME61q5Tpx02sdV0K6oPTCPpZcWIDkHVghwh25rOn1GpBYndzkgOId2I1OYZGUfyeTcCmXPNtF5dp/0qgvYOdIEVBgaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYYfM4jpQsgZ1I4zj/9WHIp6BYyP77ofjCQWx+xmyUY=;
 b=LfR+Lu9GQKAgKMtlLi7TtP4FvbHzZMx+63MvkC7u2VAe2LoyOAnphMHrA7y3EBw0ZYvaq9qkPB2hT3Kej4uDv05tDh25MaCHE3+2enDTuLcMO/eLyjlhOf9k+iqNSlb9OuJ+0KoxvKdq/YKyDU8hXxXNrpI7xcmQtq42oNCHE25p5GbucFJ97RIAgSF7LExH8e9OymEG824frx1C37PThV7vouzlKA285b1S91yUkeROS1+QkmjpJ1DBASkfQ6dCdZuM89dchdNnJgKdEhQQaN41RKerMa7v4sofGNIgLWpaRMb+qv+8ilf4RIqLL45zXMqRvLg2lSc28pWsYtFbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:53:56 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:53:56 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: add tests for sleepable kprobes
 and uprobes
Thread-Topic: [PATCH bpf-next 5/5] selftests/bpf: add tests for sleepable
 kprobes and uprobes
Thread-Index: AQHYWyCMsgxlJnSFd0GLBqB/JA91PQ==
Date:   Thu, 28 Apr 2022 16:53:56 +0000
Message-ID: <d460d5b8a184a9d431efa3a016f56389415a1fc6.1651103126.git.delyank@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
In-Reply-To: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c8b085e-f00f-4fa3-f3b2-08da2937aefb
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4615AA3C966E8C44E932A98AC1FD9@SJ0PR15MB4615.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpLh6jtWv37rydXAnaI64qJKSJZY4hBrNoC/eaT2gbiXCEbK6W4uH0P4wvRVRfZNISImNOf+pXDdxSu769Sj0nmMwg5cLcPhjRjk9JR1kRhsACnbS2pKzGbxqt2TOtlI4/oQFGXvZFY76vPV2+jAwiiAEst3hewcSHqLgL5osOI6a34C1KFMi4kQNaN7uGRImEKlEdAF5/fcnuKaD1rpEV9I/RUJubOJVZtzA791N10cF85Oa7lfNXpJB3OKzAWLJHE7ZH0cdI6cBKuW1XPrY4d+Q5yh7fN51t+P0it3+qzmVQ5wXNdnEYcC65mOjtXbeq/cdqaF8NEyRCTh/wndeN0cjk+t82ZMrEbCxeLzomVVmxGoMUVfOu5fEYK26AZmN9yGKsPZwBR/dDk3fC3vY8tDeyYwgGaJIePG/PQzMztTyXKZBuRiG/7nQ0k1E7tYJfxxrmnEbuKrad2v4Cq9Uw3+g1LyNyJ+Hcl/nPpDX+jPRSFbFumj2mtDr6a27JwFbsN9Bs02a+NVCcX/dak9Nsf+NN8vP2cFzIy7gUQ3EA7XpFfUd0E4JZulM0TtOj2bc22OQtAu309D1We700N9Q7byxoBWHuu67Af0vWK7jqRFeXZIyPsyqxtwYNfzcmf3faSsxvyImUIaNEYdlC+3M2Mka2KlsCoiqwkjL7NRBzcGJwDz1xLKyzHqWvZfO68bAHcEUC5GDAmLEkpGoMIifw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(36756003)(38070700005)(86362001)(316002)(122000001)(5660300002)(66946007)(8936002)(6506007)(66556008)(76116006)(8676002)(64756008)(66446008)(83380400001)(66476007)(6486002)(71200400001)(186003)(26005)(6512007)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9Z5UK9LIeRRmAUM2eaeXRUoj95FifswRgHoFYJsPA7sM5V1rUkS75L9p9Y?=
 =?iso-8859-1?Q?epMPVXQ9SsR7ZklsbzFo5I8fLgTNrx2AtboM8yZ76EUkeDi9ivYTXcib/3?=
 =?iso-8859-1?Q?/I4q7qe8YptN8DeetehChSuEIjU6rS+Xr0ikBHTVmmDMIbIh0T1fRz8a/y?=
 =?iso-8859-1?Q?k7Zkjaqf8ZqYeG3Cefs5BQcQsa8Vw3AXlXX3AfhcwqyT9ewSOBqA86cQ22?=
 =?iso-8859-1?Q?Tm84a7AA3kOgMOBbWYEHjIV9I7aEc0UubehX2V8rF5KmVG/ePixy+AMFe+?=
 =?iso-8859-1?Q?c9QrjGMQPnPZ+xxHXWO38zEmayTnqR+coKoKNpnsuS3zjD1PcexxlmTYtx?=
 =?iso-8859-1?Q?qPGuk+rSfr3yO99ig16fncoe07R2HA42tf3flfNtrqBZMUsQvIYR4SCEcc?=
 =?iso-8859-1?Q?MALFw6yyUa0+StjYVxDVze5o7aynNrNDDZOsIXI4so8Wy/izmbYvJy1UM0?=
 =?iso-8859-1?Q?u+NpilSBJijO+UFPfQNrHEytOVYM17eXMCePN/S5udqqxCnDqowfLjwi0n?=
 =?iso-8859-1?Q?F51ZFgauZFldE8wtBmbH+xcPK9jkmO2cHE9tiPT85S5F03LoXwDHZWEJZz?=
 =?iso-8859-1?Q?cB2Txeh5A1pakMhMiLWeumtwHa5CYx9pZKjoacZFTU1aXEDoXba7mKR0xq?=
 =?iso-8859-1?Q?CtP4mkA5Rb/+2a2SKZI9/kXGDBG0+ch0o5+/jN2DDzcfDqUkW0spsUt5VY?=
 =?iso-8859-1?Q?t6WLTbNb8EwRNvzKD3NnUwHa2MTh1n6JmeH47B/rGhvIeQ13o1xtY+UfOD?=
 =?iso-8859-1?Q?VXNs5l8T0wCIFpThGcX+XJkk6EKBbPbMztBTy3PiJmZj3tT/QCr5HUqw7C?=
 =?iso-8859-1?Q?hpFZ/6etyZQdM67fu9mW35aVY5FOjEQ9A5SueZRLGmXy4EYbEhfk7ZXVBS?=
 =?iso-8859-1?Q?x1F7j8ZWpyD9643sgjk2ksFWu1s19TUYj0ckkhjqkZdL31unGASQqEONv6?=
 =?iso-8859-1?Q?lBzqruW6/sU7Fe1nyavDriE6B7T/xHIPK4BQgV22/JaBBE6GbQVss6q0Cl?=
 =?iso-8859-1?Q?oPve1zB+fPDQGhMRF0IE6JpOC94YH2ZjKJXs3uHQatgscMIKLSb+G6A+n6?=
 =?iso-8859-1?Q?ggYV9rIzsE18IGu+QfJHiMzf6g2M25wrRJwnAzznwsH3MA/X7w211gIlDX?=
 =?iso-8859-1?Q?bdpRwvzMW1PJkxZqTwQhlR7p3P9pJzG3pVRSzJFT1G70ufIQcOhNB1I76Y?=
 =?iso-8859-1?Q?mXSr0SUH1nVLLOmEX1a/9kMctU19/AbHX0S/oEKWPLU+j2iW1JdImidCKs?=
 =?iso-8859-1?Q?J4eUxC3N5JMk126Dt6UCB9Yull2hVoBMqobGZE02UAW6fnOIsh0lIikPmJ?=
 =?iso-8859-1?Q?ZQhEQtFuf5Gbe8fAKjhvYO5l1dC1RL6tlp0EE5IIs1HhPuCC70c6BMdcce?=
 =?iso-8859-1?Q?PoSC62u1r3rb/Ltdqp2p8R6EJCwPQIXZ2HwyeCdkTxTHvQlSnFKXbbt0Aq?=
 =?iso-8859-1?Q?BLnwHpOTQ2UFpLgO6grtPBDGea8m2+YJymaNkahxOJymmzgpHu8wrLRr7a?=
 =?iso-8859-1?Q?+ZaRA5SO49zD2OdPSLHvT8YRqsWqsIX6C/pGoCdEDGPzp6ueWcmHr1butv?=
 =?iso-8859-1?Q?lT9UlQ9rDhD248KP1tntWd/KbQl5/tSrGqV92hBiyCP1x971avC/f9IS03?=
 =?iso-8859-1?Q?rynA4utYZgnK6wsyy7Ev3SOkb/H9lGGUG5xG4lWLOmsR5/g7RbUlnvkUWg?=
 =?iso-8859-1?Q?IQ+GB3gnr2pq2D4ulEfQeUF2Kw/RpHf7LoXZUGanTunN+4WXqLeTp1mdWB?=
 =?iso-8859-1?Q?t40JZv3XZviSOxhhgYz+UIMyFRAvV3358Ho06L6LfcrfbafDkzF9MVpVTi?=
 =?iso-8859-1?Q?gdB7j/v0AA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8b085e-f00f-4fa3-f3b2-08da2937aefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:53:56.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93ZxCm+eizIec9Yi9pkyJQT2ikUhszDjj3wxnyX/ysYQyRAAC8DwnKPtPNFiTmsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4615
X-Proofpoint-GUID: W_rs2MFWjGnhyq63fY0mHSI5ZqiBSycP
X-Proofpoint-ORIG-GUID: W_rs2MFWjGnhyq63fY0mHSI5ZqiBSycP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++
 .../selftests/bpf/progs/test_attach_probe.c   | 44 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/=
testing/selftests/bpf/prog_tests/attach_probe.c
index c0c6d410751d..c5c601537eea 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -17,6 +17,12 @@ static void trigger_func2(void)
 	asm volatile ("");
 }
=20
+/* attach point for byname sleepable uprobe */
+static void trigger_func3(void)
+{
+	asm volatile ("");
+}
+
 void test_attach_probe(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
@@ -143,6 +149,28 @@ void test_attach_probe(void)
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprob=
e_byname2"))
 		goto cleanup;
=20
+	/* sleepable kprobes should not attach successfully */
+	skel->links.handle_kprobe_sleepable =3D bpf_program__attach(skel->progs.h=
andle_kprobe_sleepable);
+	if (!ASSERT_NULL(skel->links.handle_kprobe_sleepable, "attach_kprobe_slee=
pable"))
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
 	/* trigger & validate kprobe && kretprobe */
 	usleep(1);
=20
@@ -156,6 +184,9 @@ void test_attach_probe(void)
 	/* trigger & validate uprobe attached by name */
 	trigger_func2();
=20
+	/* trigger & validate sleepable uprobe attached by name */
+	trigger_func3();
+
 	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
 	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
 	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
@@ -164,6 +195,10 @@ void test_attach_probe(void)
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
index af994d16bb10..265a23af74d4 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -14,6 +14,10 @@ int uprobe_byname_res =3D 0;
 int uretprobe_byname_res =3D 0;
 int uprobe_byname2_res =3D 0;
 int uretprobe_byname2_res =3D 0;
+int uprobe_byname3_sleepable_res =3D 0;
+int uprobe_byname3_res =3D 0;
+int uretprobe_byname3_sleepable_res =3D 0;
+int uretprobe_byname3_res =3D 0;
=20
 SEC("kprobe/sys_nanosleep")
 int handle_kprobe(struct pt_regs *ctx)
@@ -22,6 +26,13 @@ int handle_kprobe(struct pt_regs *ctx)
 	return 0;
 }
=20
+SEC("kprobe.s/sys_nanosleep")
+int handle_kprobe_sleepable(struct pt_regs *ctx)
+{
+	kprobe_res =3D 2;
+	return 0;
+}
+
 SEC("kretprobe/sys_nanosleep")
 int BPF_KRETPROBE(handle_kretprobe)
 {
@@ -76,4 +87,37 @@ int handle_uretprobe_byname2(struct pt_regs *ctx)
 	return 0;
 }
=20
+SEC("uprobe.s//proc/self/exe:trigger_func3")
+int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
+{
+	uprobe_byname3_sleepable_res =3D 9;
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
+	uretprobe_byname3_sleepable_res =3D 11;
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
