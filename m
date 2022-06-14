Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A254BE2E
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiFNXK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17192527F2
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:50 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMcqs4006248
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6d3FTVA62oasVrN0pczUu55GUIMYv2ffORmmEYzsSeU=;
 b=kdMViffFAt9kuDlomeJHnZKszV6Ff/oxJ87zJfoODA+EEjpQOZvLgo8kpUswwfWmPTC8
 ZJkX9nXYVo9/u8VI0ax5sZZ1WN+ACPPzvGdLw2vIfEk1LlNG/ZsnxXwmOhr+fZcIY04k
 yhWnKiVBCjwHV4tfcv2J+m4vt7/eZ3W84go= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpht16dws-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiGjiiVbTXh7q6CJUi0XSkDTc8x+lgEhJHBixZ07+sMuZA35IAlMdx1HI+jxJVF2uNxRnSu0fHyoNoRKiQy+wldmYWuR9jgP+WUaj2McJHU/jFFlhV5eeJt8B98vWP9sW+rMbZpnyWD6KeIH/dSvIln5lVJrF2Oj+B+l5b+suiD+fy4UVbPK1CV5qNJ1OzLE8LqUqjg0jexgBRYS3t2CEyQZc7a+G5N7PrND5fnptmvCS9cDePLQsdEBojXiPHfUdDLyx/RzOEa8m353kZtYdznICB3swc30A/anZvaXacnYurGcHAh70fpoBWkOeWll9lcKwtF90737JpuyIMARqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d3FTVA62oasVrN0pczUu55GUIMYv2ffORmmEYzsSeU=;
 b=F56viOOUS6DIKRXAnpA+pTdQBRWbM6A5rV5GAMLtYKDF02g3/GuZlqqpmCnbhV9pmeNvRCJ4RBvbMn03wXXDqDYve4pIiM+c1wnTEKjpdOGk/4FaLjMEoQXTjX5XXc18/YpXEaz+8Zzj1aqeBRTnndGkvo3qvxs5Vv82DENe7BjDTzWYjfLUVn8L1xnqsd+FOb+D+WymhbOBxOUS2bV1vB49yHbwu3ceD/BuM+TwvpJByVxmpGER179drKC3i9fgyR5mx+dq95CwiE+L10Np0hd3GVA46nQLdyJrn6PBjmB/aW+bNj8CVDvxyUWF/iGt/tLXqWdtFFc38+eNplp+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2665.namprd15.prod.outlook.com (2603:10b6:5:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:47 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:47 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 4/5] libbpf: add support for sleepable uprobe
 programs
Thread-Topic: [PATCH bpf-next v4 4/5] libbpf: add support for sleepable uprobe
 programs
Thread-Index: AQHYgEP7nAv/h4b5pkmwqzqFkW2DZg==
Date:   Tue, 14 Jun 2022 23:10:47 +0000
Message-ID: <aedbc3b74f3523f00010a7b0df8f3388cca59f16.1655248076.git.delyank@fb.com>
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a315fc8b-7124-43e8-c156-08da4e5b1dfb
x-ms-traffictypediagnostic: DM6PR15MB2665:EE_
x-microsoft-antispam-prvs: <DM6PR15MB26652172F8DF67E16876F106C1AA9@DM6PR15MB2665.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 381OoFRyeOosKmF4lpBmgrywCZAIhmkgcBhpuFDiSWkRHm6hJ/8F40P7zV2Zp5RJOcytU18fYSTa6Ocoh6I+MU4Oi11L0WRaO5Bht3aGjCzuTfc59XVO5S5V0SdJrGxEPQ3QOfwtfucJLbdw+Pudgp3FHZ/zKGjA6kH+gwXKzUth1T9qezPyD4iztIPuoDY5GIbadyb0RAVuk/9oN+CO71qWstmZn6KrI/TMMiVjpB8NqS8alFUPk3bahxaN/ZShtx8Sr0zkRoi22O4H0zMveTRgRFFVykd6BaRa7HthZICnq6amWPxbNemWSlm1oV/0ZdfNMZ6WskxySg5wzHczMiPPhRgM5fBph98dY/+wi3VYh+6NhnzVxm8QMd91odUkMJbrGFIgf9SAbTKKEYLely0HeIfG+69uYXcpVSK46AaKmysjSqNW5+D1z67Ako78iyx8DcJ3svVgYZt+3Fe3c2m22DdhheD8RzcxrYPBtbLX1dQeWkeaWIWCnG7PvLEp8o0eTkhOQq7/FaHclGMwqrqfxUfaHJAflBRjtDOQCFZ2NRw2ZXvZ/5Tew/6Yj8Ls26Bm1f0XtkH2Jy+SUob4XfS57TqrNOpsJPpLRGp9CySab6ydE7nze/cPQpNGnN2UOBXt8tQB+rXCLGC+DnJOCIA1vWM0atrOfyMJjeqIa5Xgye4qkkQ5FkE2fQwPQEyCPDRYWcbo49Y1Obqs/layqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(5660300002)(508600001)(71200400001)(6486002)(36756003)(38100700002)(6506007)(110136005)(76116006)(86362001)(66946007)(38070700005)(64756008)(66476007)(66556008)(91956017)(122000001)(2906002)(8676002)(316002)(2616005)(6512007)(66446008)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dKqKMCVujxYnwN3wk8GV65/LtenwcYZWSz/mfIsIJco/XAfoO4W0TjUk3J?=
 =?iso-8859-1?Q?lnsy6Vc4vWiMGxE4Nv6YcPF4FobkiK7MFCM96cJbJ0EULmo97bpcahJ4jW?=
 =?iso-8859-1?Q?8rSuaoCmYmLZad5WTYbPtFpDGt+aEeqP/LdLleLNqXJlDXMjO8DX7KGz26?=
 =?iso-8859-1?Q?d0e04yuiWz2aMbg5/6FgRl8o7TUjz47b9JxC/p53PRI1a/VqsN6kHHZrTp?=
 =?iso-8859-1?Q?m+DEzIfYUA26SilRiJmHyDYlsqXPfQ7X9gbfBb9Z7ZzGAieSVtQaIni73g?=
 =?iso-8859-1?Q?sHwhSBtFKc08KZsPOI+4XewYBaTBduUh48fBSdInfMMn54cKlasQ6t4Yhk?=
 =?iso-8859-1?Q?YWyWZ4RCxH0p2xMVOAs2xOlYMinSb+P4rmg95IKWgvj1JZldBF7BxHuTp4?=
 =?iso-8859-1?Q?Ne27dbz5dNYZp24lc3T7v2AWg35fJetslvJ3zIrQNnpNG86y/nAk0G8bGK?=
 =?iso-8859-1?Q?FwtuUk+ROaBLNCEh508FRaUtFkSfPN9GoDWU3CbaHzJDoAsmCWuP9XKuzh?=
 =?iso-8859-1?Q?nN7HA07iC/06Y1XDpJLN98q+1p+sbg1bk8Z3GPbzd10W9eg2K+fkXHRSEP?=
 =?iso-8859-1?Q?s9L5rB3BdORBpyiVDfj5CJdVOETV3Oxn4pL+PYHcseWuCtvDlNrOvU1boS?=
 =?iso-8859-1?Q?cnJbd4leW6IieoIKBKjiOk6Q6SdhgquW7trzmqxF8EzhMyIRYDKP1hCbPb?=
 =?iso-8859-1?Q?H4oV+sWdk83u7Jt9crYPU68p/WJGfvqhUpna6sY0gI7ft9goyUdge7KIyi?=
 =?iso-8859-1?Q?SlEvWGnTl54WiXB6niTzIjKQkjz/NHoCvHC7ct4jiTKAu6mJxg0Bt65RZd?=
 =?iso-8859-1?Q?ysk3u5r9qe9hUq3s7dzpc4d3iEd+gQ690nGfj+WOHmQj2bIGunb0aBP9Ts?=
 =?iso-8859-1?Q?mO1wg1vvtvQRcMMbMjoGHnRTCt0lJkdLVtVtwKifBadv+mVsDmvyGkb7l2?=
 =?iso-8859-1?Q?pDoE7HlRievjIBdJyh6UmTczu2N4XRZ2ZYHYhVP6X1TiyeAhWYt3MXqYyY?=
 =?iso-8859-1?Q?2EMaQXI1L1oqKz95Lj/d5REBM89oIcBnuNvZcm28nvwU8ztCaB391d8+TD?=
 =?iso-8859-1?Q?pRW3Ob0+BaDIzRrRf5UE379tGCUEMlSs2Mw77rwWxuNO/k3vmDdxaEtYpR?=
 =?iso-8859-1?Q?Tt6wbq8QQH9lZvj0pRDEzyniTr97+JxqRDTkHZ2APBf25qpCKnUZ/ExtnT?=
 =?iso-8859-1?Q?Ie02GrhPNKtglEixGbKXH0w/b3nYIWDk4pByRCJ8cLpJZLgUO/3QvigSor?=
 =?iso-8859-1?Q?npdk/A0dWe6CL+bUjpjYy7bBJ/eHsYIIX4HrVyOmaxPjqubfT+QvlIwU8R?=
 =?iso-8859-1?Q?G/7uORQcgsLFK15j8FLQaFpwKEkq7fgfQQEMlmJl4Ybz//Zry7adNewNkk?=
 =?iso-8859-1?Q?j/9si4awNmEFiErk8i00mZ8+rU3Cv4PPVp2jCNJEoxKd5qKmI59Jo0Oais?=
 =?iso-8859-1?Q?RZazbGWI8BfIDk5qhDvkCbcMYmkJupW0AejTZqCMxdnT861+SDDBOqql06?=
 =?iso-8859-1?Q?g5MzdeekyHFABU9AXiR8FeH16R3/an5pVnPkZQNBhAswWagtbJkfFNbAGK?=
 =?iso-8859-1?Q?V1Pgbuk9POzpKQIQKqq19MtbDG1XmLmNcLM6xKaFYWasi9L8KF2eytSOzF?=
 =?iso-8859-1?Q?9bI9b/5oKCCP69F4tBvWwaiGktFd4YGSe0riJYl+GTM0PMSR4czrBx46NB?=
 =?iso-8859-1?Q?/PsDpRLw2d3mOcB/0gbiaJO3TPRB0rJu9pIF8AaQT/OtF4GKKtd9HP0ScK?=
 =?iso-8859-1?Q?eDcKIae+tJLbmEf8/r5PbEfpUzT2cC7Jis/0W8fZT2BlsBAptE4fdxCq7e?=
 =?iso-8859-1?Q?yTkM/6td4yjVj9M1r8MYLxW/sveAHw1thAf0kRVec+nR3eWm3nqz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a315fc8b-7124-43e8-c156-08da4e5b1dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:47.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usT8JuoBTIY5SQHancEXEmIBGtegREz/sZhsho4SClShUGArYI+3ddiIhjWA8Kee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2665
X-Proofpoint-GUID: 1pQ-OdMRlijNBBj2Nm5tBXSRqK6wuYKz
X-Proofpoint-ORIG-GUID: 1pQ-OdMRlijNBBj2Nm5tBXSRqK6wuYKz
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

Add section mappings for u(ret)probe.s programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d989b0a17a89..49e359cd34df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9177,8 +9177,10 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTAC=
HABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach=
_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, att=
ach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
@@ -11571,7 +11573,8 @@ static int attach_uprobe(const struct bpf_program *=
prog, long cookie, struct bpf
 		break;
 	case 3:
 	case 4:
-		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0;
+		opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0 ||
+				strcmp(probe_type, "uretprobe.s") =3D=3D 0;
 		if (opts.retprobe && offset !=3D 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
--=20
2.36.1
