Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A044D565D
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiCKAM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiCKAMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:12:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE91A06E3
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:53 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AJFwk3005490
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kTk9nENb9hAH9nik26fqOePPPvFRZeNfjevwh9PJBeE=;
 b=GwzRG8We0gk5n3Nj/RTb9u//+lGm2kTlaKAxWo1Da3OWlWa/7NbafoW/7dJ2PQgPRigj
 nRYlozg4U6RsFaYjCZQkHI7ouVZNKr/ktV43AIKXvTXPAzAqgzDP1JRqy+MNjDKoDC+J
 UZV8yX5XK7n4aTm59ieJ8xv3p5BeUj94fvE= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqqb5sykk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:11:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrFE/rr6IOUuZWMdYAoA9+KVebMu6KLY/oc/HU67/teshUYh5YC5IvtcbDjRspHI8iqK4JFy8N27kRLzImLPLGIe4YwrMrO3Fb8QBNrsCzohj+jNDxXe8Ilc5HHrFXAXN1DAbrs/yDtYGeSUkorUPZ7ykDH0NlawA5cnScBYiNcVcJyam/cxaRBCmjL/vhcnRje1+bNEdBWRKx1C5Yh7sJjN4Yce9yNmjiBsTF7L8N03U9LqyidoHWmX+z6t4MHa8Pld/ifjx0R5OEN3+mMBFH47NT1xFZQa1FSpY+Xj/B9l9UnYOjKsnUZzXqZDo96F8vBvx2zMi0gPnJ0SODHucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTk9nENb9hAH9nik26fqOePPPvFRZeNfjevwh9PJBeE=;
 b=c1k8Y8hs1Ybrk9g52c58Mznf9wwPAGyq+/vsv+wYAL6NTAQUJpW/4ks5XMLioG5kpKAa5wtS+6r7UdNl6hOFJa5uey9PzrqT/O14vXVP/fzo/xriOgDftXAqpNqs1wXI1ZGWOO7fthBQ0PYn9rwSILa94aFScrVapczj8YwePHH5EvUXU3/1KqhK/T1uUUvgwuGcTaqM5qIxrTzxT3kOCZmYp/cCsyKz95kGQA96hLDE1nRhk+hUYyC/iJfAPNa+Cno2WZ6XEhUeD+JMJST42SgVn0FSYH4y2mmnyY6CcTG5VuGVI5scEWwoTxNmeJyXZs1j1/GA+EeVebpm6cvxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1170.namprd15.prod.outlook.com (2603:10b6:404:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 00:11:50 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:11:50 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 1/5] libbpf: add new strict flag for .text
 subprograms
Thread-Topic: [PATCH bpf-next v2 1/5] libbpf: add new strict flag for .text
 subprograms
Thread-Index: AQHYNNyaxglbi9iXjEWczoM5ePpXcw==
Date:   Fri, 11 Mar 2022 00:11:49 +0000
Message-ID: <b107f56787c89464ab52828b885e1a208312d20b.1646957399.git.delyank@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
In-Reply-To: <cover.1646957399.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e34ccb98-a20e-4c57-a3f9-08da02f3bd30
x-ms-traffictypediagnostic: BN6PR15MB1170:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1170E31C03F97F77ADAB89FEC10C9@BN6PR15MB1170.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wstfnfj5nqGguMNdTxXue626kwqBv0Ud9B87aKdN9OPKGY06TiFIt7/x7iCMQ5RQBg+SZewxhLIU3Njx1NJiQ/n1EyCAuYPQYJ2yN2qikeOlpKU2+Fc494LnJ51S0Xhr1J8cFJssRRORlPBiSfV6IgFDKMob9TPyTvFnnrNu92o3EuY/aSu8H1Y9+P2909whBNtpC3PO3TuNvlVVTEfkpL8atoAAJZTq04gc+fFTYxoKYtG8yOEuATyImwK5OsBWl70vHHMGygSgEpUCs/e468GtPDcZBHccKQy1E59/fd9l1GLfMBlPP+iQEkv2Ors3Ji9xskjagEydGorUShuD9LPsbzDyDV5gjr+Ah+nB7M3+bCwOk0XjV+PtLcvhlQBLnh2CgF89MRBWRVHlm+QdaRXObkfz58vDMTAx/gFjPYxxdkFSTTRrQrESt/KKWX+H3rXEi9IE8CIX41xQ01CZKZqg8fLshOK42wRRWT7p99Ufep3pTFBAEaAtQV0jmyaARUsnTo8xvvntPMbjkpooauLNyEsKJbKhqgpp3mILbqm+uc2h1QZjQlrHmM8holtLSILTxANYtr0PR3d4OQFteGaBMsUcj8SpN8H6or+5SIxnSrrvYpqpAZkvDvshRgpjRydRh0eEnUI+W5NyDw24JPvc8Gam+UrNzDbVzsI/ElHQoreDssfOaIqVm2SiKz9QrsDet0DGq/8wRLMeO0LRvnx6/SduujmtAR2Fg4iMdWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66476007)(8676002)(91956017)(38070700005)(66946007)(64756008)(76116006)(6506007)(186003)(8936002)(316002)(36756003)(122000001)(38100700002)(71200400001)(508600001)(5660300002)(6486002)(2906002)(6512007)(110136005)(2616005)(86362001)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0aZVRlGXJCO1nnUflc2pJz07Vy4H5NM40V0GstEyafL2PjwpcOBiz7iKFS?=
 =?iso-8859-1?Q?hwKlezD9LdNzfzYQ81XTuiYdKA8sXKbFeF7hChcjOdr1NRvWPJ6+SROSj3?=
 =?iso-8859-1?Q?t8s67Pijnz4wZBizqwydnNkjxbO1fbCh2so83kOOwCvwD1voNguVekpnX+?=
 =?iso-8859-1?Q?Ju+7Y1BF0uluFWdBcbpg9YopOwBbD3jXbO22e/gdDl/br2/d2AHZWYGWmP?=
 =?iso-8859-1?Q?CjjDvV3dxUWB6QXJpWxTWvOtg1UMZnw9jGuSPDjEPXvsvSYUy/BnceVeT/?=
 =?iso-8859-1?Q?lgkp/qhH6atafj+dBxFtIAkZ5+WyFskOK+XGQlolqZlOl40Hj5OSd/JKpM?=
 =?iso-8859-1?Q?Dvu0wY9wpYB88HNxMFHRN9SobdpLGTNrjmzNg5Q0zJr8ELw9mJdxrzt2W0?=
 =?iso-8859-1?Q?cVKsUMywnOiVoJ1eZAwJ1/bAouVn/Gmjq8y7/yuOTY6eYi4owogxvp2+Tg?=
 =?iso-8859-1?Q?FPbpbr3cSoY+z6f5uNpzjLn+07VV0/wKpT00aQmA6H37/QrNP9pr3eH/b5?=
 =?iso-8859-1?Q?h4m9mR8EUqIGH9fNtdHhNvYB0inTRihWjkKsxbgcgr+KFdLBheYlFlRhoX?=
 =?iso-8859-1?Q?6rZkssgSFTsIJHon4J2Ff5WXQhb1ERN060ushanZWVyDdXy4N8oiMLOToF?=
 =?iso-8859-1?Q?7DoH0afy4d4omcE/LaZZVc4Nj3hOGAS+UR+UxxPb8nuXEco84Mt3V4i1bU?=
 =?iso-8859-1?Q?OvH5IYB3sax1iuVz9tERUSk5j3VjPHsARGK5M0DoQT4DdUJM9NPI5kTzsK?=
 =?iso-8859-1?Q?MmxBqhh/jEXdy1QpmHzPYJqGDWkvA7GQguNsMOlca/buEg6sjtpMUYLSz8?=
 =?iso-8859-1?Q?t/dpI/EEnhJVpBTYRRH+7GO3zBCgJuobfLdCeYPlZgaOILVLEyW3Kxx4mX?=
 =?iso-8859-1?Q?QCBidd7yILJgIurfZ92iD10pAMBOdCP6tkUg8FuOJqeV1ZrH+ZpQ8xctFc?=
 =?iso-8859-1?Q?X9mpA/b/WlG58FY5fEZ7gfutG/EdO4ceoztrZTBgUJezelofhrelUiWIca?=
 =?iso-8859-1?Q?P1I9WNbJL0UZeEkmGquz6PnLzhcQcFV7MVh0Cc4gViE0WJ5j8eTWe7Q5Aq?=
 =?iso-8859-1?Q?QIPbTRDGpYjkx7Q/t73z9Ngyoi0W23Sp+lwLaWuFgC1da299TmbbZujPpT?=
 =?iso-8859-1?Q?wCWlu0RUUGYiyikxR5S9iq0N1jLyGX6yCdSvZFLDzhniW/uI7BrFZm8InG?=
 =?iso-8859-1?Q?b3WdOt1zdnt+HdsH/P8nSHOJ8nrBa4uj1NEbFQIbgZzV8FJJKwArJ6K9k1?=
 =?iso-8859-1?Q?QoYWBKkUamy12ZZge0zp503NtDkQ7ll+RCk682nYlvPNfVo7w9B0cOB9BI?=
 =?iso-8859-1?Q?pgzbSaLqOrYQm2LOYDcu1XZxCvc3/tcnq6+BUBEBXtw9H2icSIAD75cc5Z?=
 =?iso-8859-1?Q?bIgHXT0WrkElzi20A9bNDHBkun4QhhoBdLl8UoXNn4n8lLGG9QF5ZwjI07?=
 =?iso-8859-1?Q?d/rBncwlbPD70WNAB7L4J4sr/PYVYWKzCltvivJnBcuZwXahv1TQniDecs?=
 =?iso-8859-1?Q?+l4CbtY4iwaFIdUeFQ0Fb2bdWBDTsllezfxAOI3IxXO5MmA/VI5JG/3fd5?=
 =?iso-8859-1?Q?qTceVrc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ccb98-a20e-4c57-a3f9-08da02f3bd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:11:49.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2k3yaY4IZz+yrv7vQiisR7p0H+JcmFzaovE3dYYBRgn0ZTcOq5sHkwbnuQg8v8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1170
X-Proofpoint-ORIG-GUID: 0hIvTn6aJRomTB4IOtBgxDrDqyqFyafK
X-Proofpoint-GUID: 0hIvTn6aJRomTB4IOtBgxDrDqyqFyafK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, libbpf considers a single routine in .text as a program. This
is particularly confusing when it comes to library objects - a single routi=
ne
meant to be used as an extern will instead be considered a bpf_program.

This patch hides this compatibility behavior behind a libbpf_mode strict
mode flag.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c        | 7 +++++++
 tools/lib/bpf/libbpf_legacy.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 43161fdd44bb..b6f11ce0d6bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3832,7 +3832,14 @@ static bool prog_is_subprog(const struct bpf_object =
*obj,
 	 * .text programs are subprograms (even if they are not called from
 	 * other programs), because libbpf never explicitly supported mixing
 	 * SEC()-designated BPF programs and .text entry-point BPF programs.
+	 *
+	 * In libbpf 1.0 strict mode, we always consider .text
+	 * programs to be subprograms.
 	 */
+
+	if (libbpf_mode & LIBBPF_STRICT_TEXT_ONLY_SUBPROGRAMS)
+		return prog->sec_idx =3D=3D obj->efile.text_shndx;
+
 	return prog->sec_idx =3D=3D obj->efile.text_shndx && obj->nr_programs > 1=
;
 }
=20
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index a283cf031665..388384ea97a7 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -78,6 +78,12 @@ enum libbpf_strict_mode {
 	 * in favor of BTF-defined map definitions in SEC(".maps").
 	 */
 	LIBBPF_STRICT_MAP_DEFINITIONS =3D 0x20,
+	/*
+	 * When enabled, always consider routines in the .text section to
+	 * be sub-programs. Previously, single routines in the .text section
+	 * would be considered a program on their own.
+	 */
+	LIBBPF_STRICT_TEXT_ONLY_SUBPROGRAMS =3D 0x40,
=20
 	__LIBBPF_STRICT_LAST,
 };
--=20
2.34.1
