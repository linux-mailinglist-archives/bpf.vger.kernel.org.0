Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152F513A6F
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiD1Q5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiD1Q5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FBAAB6D
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7bkZ026710
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=U4NO8m8IDGi7so3m0I9LGYCHZWY79T35kWhM4cnGlpQ=;
 b=NPi79+D9OW/32bu6AksGmaK3LQW3FPnru6dBxXYiTDgPjRUCaiiLtqiH59Z5XONXmjvg
 nK516PjOIcsSMTWhh9QRzrUbXP0smqZlHSDFVB9SPyfTkEAWndvFfwgv8aqhdumn/ZJN
 unymSKvvCyEHbaqGwIgfZF+7998M7pU00Rs= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40r4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYRk2sXdrwy/Lmt+4q8qxLtaM+3WHY1gVMnVPuVHBMBLxhu7jmdQLSB1X1ZJNWSxMUopt5pSseL4RGKizBqrA+sNu9BEHUlsZwp7VJG8p9dDVe0ktV9tYsWqaybntR/u362iCD9uz8xfNktfvolvGfJhGUjLPBYb6wo83qYN+dAHvoXNlEFiO7WNkhzUvO78GiBXwJ++stElYpnEoSsk3ijhD7ChtB1gOMocBei0fh3z4T0msIxRqU9zDuFy+/ZNk3oLIX6UrBR3P3Jx2dSBxN4zbCcG3IZDE00knJEqj09EGytbsBLp6IVpqTd2SH3vzreew835Qx7TkrDgD2LVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4NO8m8IDGi7so3m0I9LGYCHZWY79T35kWhM4cnGlpQ=;
 b=NZ3HKE6v/wjE0WGiLzXiWuo3jn+odzyojHzL+e2Rxvj5AVG4i7Tj1PtyUfSB8iwg9JbrvJB15Wedd8zJFrNkoGhTW8kg0Sx8CYbMxdrE70sMeTq3dX1bbMVlRHTk9RV+b/6d5VENpAqFwZH7EN3vAK+2FtW0NwgSuq668271paU50jS1InlppSYMeQfbQZNL+avgN8v16dQuuCLTTvEtFkkMtqjk2p2dZGFnx1YGjnXRyhQy/J/jojSHysj+z6dD7d4EbrGkruwrvam3M/vHO2kFABnwBXScBYNuqyeQ0zMqgaEi3lno+mDekenTB1o8viSnG8HVrl6c68tf/NCI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:53:55 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:53:55 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 4/5] libbpf: add support for sleepable kprobe and
 uprobe programs
Thread-Topic: [PATCH bpf-next 4/5] libbpf: add support for sleepable kprobe
 and uprobe programs
Thread-Index: AQHYWyCLmUWuy8bCeUK1TVSeHWTI+g==
Date:   Thu, 28 Apr 2022 16:53:54 +0000
Message-ID: <aac0c6adae881f57c247d7bf35e3047f7bf6cfe0.1651103126.git.delyank@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
In-Reply-To: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c8a0781-aad4-42ff-a8ae-08da2937ae59
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB461544A925534E3AD69D7A49C1FD9@SJ0PR15MB4615.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWwHhUYIwnoPfy9V57Vd2RDdaoFlYy8l9q3nU/NmfPgVa/MqwQYwUZq7kzQkUCbKYiflwnFyyh96LLMVacNCvzMX+dxT7F3x1oYrDhmM4DcUqyiVs18vdcb5wZc9Kj1Lt7bZJJy2erZNb2vl9HPLQa/fWgDHzMlxHx7eliZM5/GwvJq+KMs4r1OFJKE3mO/oMWO60Qf8ExfNd5dWL6Ormx9wZxXD1BstPHeXyLE3wJ5zXYG3BYlj/cUeay4iliLROmZ516w39mUzcdjnWxgK/kBced5BJLiLKzNxPnrqGAaTDGke1HQkw1BAnAtQKSahAmJab19Ro1tw5cKoHjTZ1kl5tdCRBFCiJk6cdh+fH/ISynRIh67MiaL6FT1R0kyQjZdKCrrgwgBZ8ltDP5S/T0DVjg6s9Ibzc6js+6su7i84p33TNxNrIcQ+OZHrEAsjeYCz7cxhyd4S4Z+rXtTtNcmjgVwyS951HCZbG63MfT0396Y9Dgo4STyQXRLMxleJGvHRvyVshFPrHHgn6pumm6XjGDJLr7G3FKnUsQE2DCqJU+De/f6yAZISghAZEM/6IEWcJ1wlPEShU1vxMNx9vzlAFe2+zj5ZryYG3aJD62Er9SPe8yLGO+O/TawNTWbRRlFJMhu6TnNchou1C58mlwK0SVJpzMyJNiD4kR0oXO+nuXGa7T6uGuUHMaMsVi6JL/6Y3TLmDCTPUcELpBOLSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(36756003)(38070700005)(86362001)(316002)(122000001)(5660300002)(66946007)(8936002)(6506007)(66556008)(76116006)(8676002)(64756008)(66446008)(83380400001)(66476007)(6486002)(71200400001)(186003)(26005)(6512007)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/XHmBy8ghjlJEqnPAzMh++48afUnWDmey6gMy/u59XjofwwiQkOdtO4q04?=
 =?iso-8859-1?Q?mSayM0tiE+6vy+pir/bIrroBvQKMnHPyY/EFTlPm1abj/b3n7mUkpPEdEf?=
 =?iso-8859-1?Q?lAJ5iGYj+PXw5AS5gnUZp8UfRAKFM4xmil8GzRUZQ0YRbSk5rz+ZMsYzQe?=
 =?iso-8859-1?Q?DrxybwV5qahfaRtvbVCGEfc63rdh/LYpSJKSszu7q0msOUI+DnoOzceYaH?=
 =?iso-8859-1?Q?KTIypkuDhh5mDM81I1tPufKQDojXcVoQ9vHNyGWVg0fGUWZc2IW+QfXwM3?=
 =?iso-8859-1?Q?ahxYADyrk8tDMZvLu3xLf7yBa1W4xCRo8m0w6NJ7Gtwabtdy/vavVDUnEu?=
 =?iso-8859-1?Q?b3FegealzXjHEkblgn/szyDtZxRMtwQrGcY4Uq2ysT1ex9RBpsU6bO3xgb?=
 =?iso-8859-1?Q?kpxFFGquNucXn6NTvCpuE2BsYIGF6TL4IYELD5xY947wyYAVGfjvz8vLFH?=
 =?iso-8859-1?Q?6eCwW6j7gdiRixXqdFDGU1K3em3OgvYMEKWe0iZJBrAQNeG0tP+FV671oh?=
 =?iso-8859-1?Q?3EU8ADHF/RXOaAtXKnAPGRxSvjlYi5sMTR9WTEnVWCJrw/SwYBThdvJwfG?=
 =?iso-8859-1?Q?jO6hXg0TO3mMHzNXhOOGwVCX0gTWN256PkP0tFgo3BlKGL0VFbWB2KYLud?=
 =?iso-8859-1?Q?YVRUT7o7czF8kf21ChhxvrxqA2Mm6XgtTQjudJvC6NR9PZxIqjNrVUTrID?=
 =?iso-8859-1?Q?kKEv4NieuiuJZqNJMMY8/CI0/+2DckQ/Jc0G6TRaqBogg3XrsC3xwSZDE5?=
 =?iso-8859-1?Q?RSh26nHLnpaKPvNkKiWN3BrCXi3bP7qqABO3WDUl0AzIpGCxuD6FalFbsu?=
 =?iso-8859-1?Q?q5vOjH7sp+hUW7Jw/DtsbzGishh7HOopJZIeeGlSD4VOaI7J88QNSZjvpi?=
 =?iso-8859-1?Q?uigRRiT4Qz/AvqD4pFASyLc+Z57XWLMAcIVf4RK5KzzbGFkyEMQaXZ1nUl?=
 =?iso-8859-1?Q?Mjhw02Ss6/TqvsbyDcutuq7w1vtPL1oY0aDLh3onLw8UeTY1tDpZKUlIMC?=
 =?iso-8859-1?Q?fZkcRet1yWmbK1vr/aW451qNTbq7kkNFk3oSN7g+6TL1zEg5P+dGpq1cRB?=
 =?iso-8859-1?Q?F7yo4NdtQa+BL8sro/FwfgVCpo/7NADSGPKyjBjX4fRAsLTyXFTfVYOy5k?=
 =?iso-8859-1?Q?p28ijlqeDrjKl/5FzGrO4Pk2YTvLoe1b9jjdXzPST2UXyubyBhD1PpSrA6?=
 =?iso-8859-1?Q?3jkpPlvapE1BxBxgPTvVod00lpFf8Us73TUOIH2GJU7pSmcYGqdPpkGUfU?=
 =?iso-8859-1?Q?QPcVsR/C4f1h5jl3TdVsvWFcw92CxFBl6eEyJ78DsUgCRKfp0+L8pxf77Y?=
 =?iso-8859-1?Q?zWgfTEVSKBWJBuiEjXlA+CFSMD9+ltD4NQ5ixoBCyyDg6LTNKxVcc3UL1P?=
 =?iso-8859-1?Q?PTV5FjkHDOVY9t5lE6VBqjbV9Sjf4HbBhqGrIa/AOTrIFG00qyoGR9+6cr?=
 =?iso-8859-1?Q?XcW1i5fKlaRe1tLAzzvIOykjequbZ8a+WWnbtde9Gwrgfz4UAb+Z1zmhu+?=
 =?iso-8859-1?Q?r/1tZj6uc7gisIBV/9jReXuSskB8W2MehwGEkAdLekmud6/Eysk5xKsl+K?=
 =?iso-8859-1?Q?EYODY1dqlgU62YestfVtCnkdfWPyFmwXlRqRnyfv+tgvO1YiPkZS6INgf3?=
 =?iso-8859-1?Q?y3WPEEOIQr5lkx14hkL/9G6efSDoe1inaqakHUMnk5iXQgKw1aEju4LuDZ?=
 =?iso-8859-1?Q?p0DatNq48IrzYJnr3GrmYTBWwT6FsTdjZ+BSfq05iYU1VNmceRBtUL3FWF?=
 =?iso-8859-1?Q?oE8c4C2qJLNFr2PIZExA/dvYPAc/mCyNhvS9/ALKN8PI2rmpYUgQM2a0nR?=
 =?iso-8859-1?Q?fNljeKPalw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8a0781-aad4-42ff-a8ae-08da2937ae59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:53:55.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sr7UQMZRdq7D2ynlD96UjSWcjyGhQPH5ZyQJxXigl0/deJpfryQ3txQmcxPeif9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4615
X-Proofpoint-GUID: L4cXZK5rmAoaocwxY_tgn1XKEnmhgiQi
X-Proofpoint-ORIG-GUID: L4cXZK5rmAoaocwxY_tgn1XKEnmhgiQi
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

Add section mappings for uprobe.s and kprobe.s programs. The latter
cannot currently attach but they're still useful to open and load in
order to validate that prohibition.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9a213aaaac8a..9e89a478d40e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8692,9 +8692,12 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_=
MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTAC=
HABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
+	SEC_DEF("kprobe.s/",		KPROBE,	0, SEC_SLEEPABLE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach=
_kprobe_multi),
 	SEC_DEF("kretprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, att=
ach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -10432,13 +10435,18 @@ static int attach_kprobe(const struct bpf_program=
 *prog, long cookie, struct bpf
 	const char *func_name;
 	char *func;
 	int n;
+	bool sleepable =3D false;
=20
 	opts.retprobe =3D str_has_pfx(prog->sec_name, "kretprobe/");
+	sleepable =3D str_has_pfx(prog->sec_name, "kprobe.s/");
 	if (opts.retprobe)
 		func_name =3D prog->sec_name + sizeof("kretprobe/") - 1;
+	else if (sleepable)
+		func_name =3D prog->sec_name + sizeof("kprobe.s/") - 1;
 	else
 		func_name =3D prog->sec_name + sizeof("kprobe/") - 1;
=20
+
 	n =3D sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
 		pr_warn("kprobe name is invalid: %s\n", func_name);
@@ -10957,7 +10965,7 @@ static int attach_uprobe(const struct bpf_program *=
prog, long cookie, struct bpf
 		break;
 	case 3:
 	case 4:
-		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0;
+		opts.retprobe =3D str_has_pfx(probe_type, "uretprobe");
 		if (opts.retprobe && offset !=3D 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
--=20
2.35.1
