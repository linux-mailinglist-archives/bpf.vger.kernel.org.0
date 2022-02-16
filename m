Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2C4B7B9D
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 01:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiBPAM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 19:12:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBPAM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 19:12:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DB70332
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:15 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21FMZu6Q020158
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=GTn7HYgxB5nsu+PHjAwC1BU5Rc/sgyA/sApspMF4UUk=;
 b=i/h4bHao2kLH6tAG7s/1zcgewcr+J7VDtX85kU55sQWvh6Ut0wuxMULX/lhjsowlCV1o
 IwYHaDfMThHNPdRtAErnDgVHDg/QxgsOjEXAhFamre0SLF63blshbO3N68TndCo+jD1y
 w9lnd6drforiyCq7fRu1UBbk2MnPXsxPiZc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e8n41gjve-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:12:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g49cQWOBdBLniO92Z2xg/HGTvh4fVyl/CA4bo33bl+Z3gyuI8shNHOTKTg4a4CXfFtbsqgU1EjJR+cstPsjyctWGfX0ieAlukP/59hbNV4KwwQy8OyibP8TX9zHBG5LJsJXh6dRGfnN10A/j+ENyn1PR7qO6fJuEPQmbiDErKzXEV/xTvB6DAPzmcC2zfSRopl3RwAciV74N+rzJfot06dfDE0OwfYKP80CfUmaKhtPNtqR9bvrjHWNNYHprJNYXlvm1AOjxrec+OhZyKAmf5ur6Npg1ZEsnpHIK06epOu1idhkjL8l3Qz2oPtVWohATIMjJGJyCZIm8up6mn+ny5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTn7HYgxB5nsu+PHjAwC1BU5Rc/sgyA/sApspMF4UUk=;
 b=e9h7vQ/c/tdTTpTWOQ9SXJY6K81hSyMuJ+sWMEi4s+cs3OyM4Gn2XUrbTYXimNdAmzelzN6BHIL9j31hWsDXOSkFmQ9aijZlRQDzpoziiM2JbIsdMVqEglf30++UiWlNSPtbXJEBqZB32g/Ct/Eyg1EmGlQKFw84AJq9aNLZ/2C061cg5mQPhcyHulZgp9b4HXZ7izwEQQf0VQTpuzRkk0Typ5LtE+hbftwqqhyVkM+Ff00f7cEd/FTGalLkHeCftq77yJBS0EJndZIzRf5BmA6c4UK/PIFFlDmL9VZ0u7aI+yT6nm0QV9Tx3+MUUCsvBR5pM92iOVbo1XaWjwfT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BL0PR1501MB2033.namprd15.prod.outlook.com (2603:10b6:207:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 16 Feb
 2022 00:12:11 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 00:12:11 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 0/1] Avoid size mismatches in skeletons
Thread-Topic: [PATCH bpf-next v3 0/1] Avoid size mismatches in skeletons
Thread-Index: AQHYIsnXAL3J62PLiE28j3/+3KML1Q==
Date:   Wed, 16 Feb 2022 00:12:11 +0000
Message-ID: <cover.1644970147.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1d761f6-92aa-4bc8-c762-08d9f0e0fa5a
x-ms-traffictypediagnostic: BL0PR1501MB2033:EE_
x-microsoft-antispam-prvs: <BL0PR1501MB2033DF99357782891C029DA2C1359@BL0PR1501MB2033.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pogvCDIf/7KoBftkXMc4CAquK1l/0MkGubDl0WxBtClqm29AAZrsZ/Mn76h2xB/ZewmKzsFCg7w0QyatcvNu8Mu6L/cf74Ln9egKZMpDAQ1r/o2quwYr58+0JU9Wmbf/cctGPV/gNZr2RVdUBkIR/5cLY+ZKN0kCbmoYlo1UxI6Fg/e5VZkI4dem1l3MwN1EoeYYUw28Gui6w/Z7Jdyo4A8lWnjZMlEjJ5mTD8BGgthxTqUoQ2OH2gNtXE2l6K6O+3v9wuQC7BKUM03dcE1ogfSsYeI4xTtN09LBii/TlaahBq3iL5PCVV+2ROsNXt0xeaDFt1UkOlle8S+Y89d22TsvOF7SleIeSaMTDMX6uxU2QjFpfLOvNSYuRHCAx7uyreZr8t86Q0eOKRVTRXITDhkkf2OYezoKTetiB3U0yRMZnaswf0fi1uyXol5oHnYPAi2SGTSVvUAlFWV9NccAx0oSwVVr78oABKgO8YIPjYBrjuf+4qzrcEw9jzhkssJ9PALr3M+9m55KdZUIaO0dkuruGaXjCOCl7RA6Iqp69RonJroK8fcnweBGaJBrewFhtcSQu80sfDZWB21ISl2I2IRJdtItnB0AgEJ8UxouNiETXf3Cx66y0zBdvq0JHb6wM0W1Uh/nHVLushp1YvQApnObxkvn2tJdux6+gI5DHAMzCruA14bAJe3JqPFCQtES85MSL4t5TkRH2wXn/bCeZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(2906002)(38070700005)(6486002)(8676002)(91956017)(76116006)(5660300002)(36756003)(86362001)(110136005)(66946007)(64756008)(38100700002)(66556008)(66476007)(186003)(71200400001)(83380400001)(122000001)(2616005)(66446008)(6506007)(6512007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uCT79nce+DuTrdygVZl1AWCqpCtj5Iuyo2TiqkYnhnttW1NtRwpR60ysHl?=
 =?iso-8859-1?Q?b0f1oSRQdmf0Qi232hqsGN0vs2sXdO9AGM5kZ2bRbzamlqQmzzyZBny7RU?=
 =?iso-8859-1?Q?gNxD4H2/+MrhdXas+qf6diP8Z1kws/fonM9vQKyyvZVs4ehe7wl4pWEYVJ?=
 =?iso-8859-1?Q?t4swFKRftEiQ0soCOuqSm7+UGHZ6SBc2GJLOE+huiBUx1msLf4wNUYBuKx?=
 =?iso-8859-1?Q?2WzNfzr4wy+KDi/sqkRno6c302pIKHWqHZcwkn1t/bYdhEi5bgj0+8G6tV?=
 =?iso-8859-1?Q?SxqOxn8ylhezTtP1SnQzuPax4CJCm7/j8V/uwl6vsds/oTtf6Na+DXQ0Gj?=
 =?iso-8859-1?Q?+IBIT3nkEHT2lRVjOVE0P5hqo662XtDfgzRC/8icQyXaRsjYEuOv/FPnsB?=
 =?iso-8859-1?Q?0wlXQn7236aFGED2Cyo5oNBuD1w6XCj7Y7xhCLYT7chHUUndg3+IuIr9Gc?=
 =?iso-8859-1?Q?xDxjz+A/gOdn5uqtmSTkfG44e4vU9NlOq51S6G7WUOzm7Da9Cj0JMjFSqr?=
 =?iso-8859-1?Q?xiBGZyidFM/u3y1WLFICu4zB9RqFnjg86l53j4Go/aLq87u0rkmDmsIp+y?=
 =?iso-8859-1?Q?vYSz1Q/cSmm9UBghRrTjlDZM44NPOsUhCRPSa81HZYjCFV3eLyo9z4fip+?=
 =?iso-8859-1?Q?hI+3aSzylVWO2L5Np5x8E+Tcb4RI6SAljo/tBQS4tncPOigfi1hTy9EGm2?=
 =?iso-8859-1?Q?JFFMwustsnT0NFiFKMIvnSUDHF/wg7AWSTMWpA2MVjRJ2f82uQpgQg2AdU?=
 =?iso-8859-1?Q?HGIkC+IcgamySdw2u46a3XrNUDGhmyGJ5A/mTcA7hp9JyssPYs/JWC74Ug?=
 =?iso-8859-1?Q?KwmIGVmEsoGohe+sk89pizJGPeyQLNmRDCAocehj0mCpzz5lJh+8J1P4gj?=
 =?iso-8859-1?Q?iRjBE3DY4WYnHN5A/cD566ImsbZR5/XMzrD6E59/Ys3xJm1CLbMVlcPQpL?=
 =?iso-8859-1?Q?vk2gW8Gff9rCtQ7CZ5KK2MtjGCBCuUnBYh+jGLoMMG1UR94TBQtf9tJdb3?=
 =?iso-8859-1?Q?IX6L5nDqNyQu63tNOuvmUjnAFONtxWDBlHLKZKyJic1Qy6amYlQoc+P6qL?=
 =?iso-8859-1?Q?IlmCIKsyXzJ3j9ddszQ0Y5Pf6xaVoMj2XpK/CCzwoG2xtN2lTo+yQ3XlWP?=
 =?iso-8859-1?Q?nt7XhkFmfusWwvp4KcVB/cnaok/TUgy69SHVcOfKqT3tHlWC1lzbOloLVJ?=
 =?iso-8859-1?Q?N69sKet1z7RO2PG1B0DlE6nk9o4m23N9DasUpAo/j1m2LI3oFFtY9C/Xt2?=
 =?iso-8859-1?Q?STMg+eQaMlv0R7eYa0oz1g7MTWeflFrr/AVpK+nbORylGSYp4f/wD4oO9V?=
 =?iso-8859-1?Q?+7T6UbfYk4hsfJFpFsD4lf5KJnGax6alO+03aCX13FR5Qo+nyZu/BfmP+O?=
 =?iso-8859-1?Q?94a04A10b+xSiTe4SEq/k2V39fwfu2x4hmC+sNyqtyMdbFXDwAJmgNr3pW?=
 =?iso-8859-1?Q?NCbsXypYldm2gY6DDY9Yer9CeOoVYI3KDMjaOkNkrZPM2kvOH2cu3Jp0RL?=
 =?iso-8859-1?Q?Q2X1z08asKZ+1ihreZa3s/TcLwT+pL4SlDsJP90mEBrVPxGw1HaDo29Swo?=
 =?iso-8859-1?Q?r7pg1AHQSjmI4L3ETNvlxFyvZmmSqSXHAGOy0iHv3N36chHkw3rRsE+YPu?=
 =?iso-8859-1?Q?sCslBNs1mFad05w4oCmdwTdVya/LaESHIn7dr6tQaKwhPeXnycXMh7Lg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d761f6-92aa-4bc8-c762-08d9f0e0fa5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 00:12:11.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EhiGvxt/1m3pAJ7TMcv3BHYnVJAbum7lEDS8ttwzim6k0zj+bGjkjX73OnSB7VW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2033
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GUoOWcDy5KhKh6X_jkhKYl9dsJWcXxcA
X-Proofpoint-ORIG-GUID: GUoOWcDy5KhKh6X_jkhKYl9dsJWcXxcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_07,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150139
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported in [0], kernel and userspace can sometimes disagree
on the size of a type. This leads to trouble when userspace maps the memory=
 of
a bpf program and reads/writes to it assuming a different memory layout.

With this change, the skeletons now contain size asserts to ensure the
types in userspace are compatible in size with the types in the bpf program=
.
In particular, we emit asserts for all top-level fields in the data/rodata/=
bss/etc
structs, but not recursively for the individual members inside - this strik=
es a
compromise between diagnostics precision and still catching all possible si=
ze
mismatches.

The generated asserts are contained within a skeleton__type_asserts functio=
n
at the end of the (l)skel.h like so:

  #ifdef __cplusplus
  #define _Static_assert static_assert
  #endif

  __attribute__((unused)) static void
  atomics_lskel__type_asserts(struct atomics_lskel *s)
  {
    _Static_assert(sizeof(s->data->skip_tests) =3D=3D 1, "unexpected size o=
f 'skip_tests'");
    _Static_assert(sizeof(s->data->add64_value) =3D=3D 8, "unexpected size =
of 'add64_value'");
    ...
  }

  #ifdef __cplusplus
  #undef _Static_assert
  #endif


v2 -> v3:
 - group all static asserts in one function at the end of the file
 - only use macros in C++ mode

v1 -> v2:
 - drop the stdint approach in favor of static asserts right after the stru=
cts

Delyan Kratunov (1):
  bpftool: bpf skeletons assert type sizes

 tools/bpf/bpftool/gen.c | 134 +++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 22 deletions(-)

--
2.34.1=
