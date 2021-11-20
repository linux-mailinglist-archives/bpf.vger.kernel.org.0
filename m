Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668B5457C24
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhKTHeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 02:34:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30558 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236966AbhKTHeI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Nov 2021 02:34:08 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJLALcb030375
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 23:31:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ocbjf2pK+ac5Z8+/Cr2BPRoQIoJy9t+8Hdn4rM0dXss=;
 b=Lufm4U9TNCO5QrjkYaZTrNe9Mf3pek+YkABZoGPJ9XdkbI+B3Nw1Qqo8Kt+NU2V9N/NY
 bXnJlQkKYc9d9VqhYnjsI9UKWi1EEM3KZcxM6P+nP7BpjPIuzepkahZdbLnEf3HFTd+t
 MFDihMD0p9t1STFbuE7r51u/n8ZEtmqn4IE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cecasp51r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 23:31:03 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 19 Nov 2021 23:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4I3OjQ5XKZ0a+AYxL1RFGNuEegPU9ufT5/eHsrhIIX1xLVVh+xP6LtaXeMCuZtvgmI7IpuuB81oJesB+z8ExZDabTINTze65JVkUuDkWzgsL/dQAmtUgrSns6q1DRJ7+PBELrmf0jwdLaig9YH20+qFAKMyR4hpCMFxhjFVSd1DhniuCszquiDR5rXPxkbxqb1a9LAVad59REx1ZKUDZFqE8aQi1SrGa/ntbub5J73gCAx9eF0TGHFV0B2HJ8R4EUL1gGpwnCORgrdF/iJoZ+vsCh+q3Ljh3wuznyo0Ska9S/wM+o23f6akvBQIA+0KxlLuGnhhMJQHKS/GGjC6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocbjf2pK+ac5Z8+/Cr2BPRoQIoJy9t+8Hdn4rM0dXss=;
 b=Rd754ctKU+EQP+Pa7BCxwbzXcv8QVcrn0s3JPh0faVgJFybP9f56ThRj+tivDK/P1HqClJWbeaTjd51Me+hX9hwNRChpy4AXve3x970TXt/xaTvaHTeQ/3bu9wnLNLaklLC/Lc1JZI5KXAneErsR14F74GhaTn2KPW8KDj1BRsqkkHFh5fClfOManbhr/oi2EsszkwJoNkfYLKGC61OH+UFYppjR4Vw3+EL1zz4f4pSaFf+kXiWvZwhSelOti3KOre8tM/t6pszyB62b7ulkoXPE2aRLRsXIRdgnUjmo6IKaZBf4pXUMbzT4JkjUzLH7dDdHC12GSoMbC1CC+fUu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5111.namprd15.prod.outlook.com (2603:10b6:806:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 07:31:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 07:31:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: load global data maps lazily on
 legacy kernels
Thread-Topic: [PATCH bpf-next 1/2] libbpf: load global data maps lazily on
 legacy kernels
Thread-Index: AQHX3awmKyWUd57EyEmvo/h2AxXY8KwMBckA
Date:   Sat, 20 Nov 2021 07:31:01 +0000
Message-ID: <BE0DB14D-158D-429F-BCD0-F3006D8DF5AA@fb.com>
References: <20211120011455.3679237-1-andrii@kernel.org>
In-Reply-To: <20211120011455.3679237-1-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8720978c-2e49-408d-6acf-08d9abf7b434
x-ms-traffictypediagnostic: SA1PR15MB5111:
x-microsoft-antispam-prvs: <SA1PR15MB5111A034533CDBE5B17A62B1B39D9@SA1PR15MB5111.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOve8gIprkXQ9hq3x0LuINwF9t9xpSkgTNzuBPWllAXeYvppWfbAdFweQQbDLxZYp0tW7/c/FuwLRYDESiKwBPtim76r/DFifXDFpTc2KTfuSQe/08eQN32sEbcewCzCMWYOhUYObmz+ypXlf2zXIii1d6qpQWmdBsBhi/wh9AvJBbcuW40iJ2SjTi5lwDY0ig7+FporWGml45yjn+fMcYZt9/bktRm0KAFYySI9Squn0AAInKcf8iU7m0EUaVvSlHNNGWmkFeLyZK+ARLg7iwhKiDrpk99Ci5N9xyoGvL7r+IIL3KesZLoi28SMyCsxkkjD503ivgUWs1GA8nVdkAN6XHYtgbpI/H4eDyYOjHAl+0gE0jJXdtdhHiFcGyATi5+Twb65QiagJrORzPZPp5/TpC9H46lOa0AMDfZ0BZI1Bh8qby/pD8ac2aA22a9Mnoy+u1XvV4YIvWZCa5Ojw9bgmZsPwlhGSrJiYB4yHCv1MUbfyzLEC+zQFigwtYdXxMh8y2wrmY97K4GTMID7m9wMxPI30I5WNQsl6LO4PhXWN1n24gJtfsGsDKHM9ILFxYPpEqAg5O2SSiKlr4AthHbl/AaWpB32IBmY6wyPuANJ87qNSv/dm5WNeKt7wxPaWi3wyinUs8VJLAbpXf0FzFBKYDjvtfgPKzYPgWvqrPiATHs5mxdtRvSQVE1lr6CD4vhywBukdDzTbOomqZRcLDPUgSEmOvaG5BJmSBGsqFwRrFmv4x8WrupHjZvV2Eua2P8uc8It7eYK5e73u7/k3wV/qDsla/ak1if/2ue1V9gLNhyWrumreUkDhkVv54rVXXusBr/LXfa8m9x+mQHthQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(508600001)(36756003)(316002)(966005)(33656002)(38070700005)(83380400001)(2906002)(66946007)(4326008)(64756008)(71200400001)(8676002)(86362001)(54906003)(53546011)(6512007)(5660300002)(6916009)(186003)(6506007)(66446008)(38100700002)(8936002)(6486002)(122000001)(91956017)(76116006)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HmtqN+qyaoyLNe2FHRELVHAYdop6cHe8WbRDQTQbLFffI5c3G77o7f/oTGtU?=
 =?us-ascii?Q?gAG5oxOq/24blF02t7BslNvMYwEWr6Wed15I8+PFpxhrDLmdQtLsfK2d4JXg?=
 =?us-ascii?Q?NfiKjVu1EiwMnyK+KtzuZVCPXMnQIRdZHypXtGPADnTXk/mV8hU8MmBZe0yY?=
 =?us-ascii?Q?3XU5ENCrFckKU+NXAUUb2xcKR/wJxSsGSTrG2vNYGRDwnM4vOtPtUtjKBReh?=
 =?us-ascii?Q?z8T9JRm+W9Yb+aKr9STIx7Byk07JpqWW80goiQc+5TPB1X8jMxLso1swRoS/?=
 =?us-ascii?Q?hzBmWA5Volmh6yaWEmVZEq/qm5w1aidIi0PSfmXSGavAgfG0nkJyjAXWb0FA?=
 =?us-ascii?Q?4YH+0Qv3QG/bCzH3il49pXKGVtu+H/rLGGspfQt0hx5Dz79cS/d19ILkiPLK?=
 =?us-ascii?Q?Iva0+L07Qp5CKPCHRuHa/z59fDEfVLSyQ+L//dRlRyjaNhPaIAqcbtNuwUSz?=
 =?us-ascii?Q?djwtFV1vn1VxgxDwIweHlobSIiuEKgUAXdqJ8NKo9oC0Zu5Aj5i+2NmK9wWi?=
 =?us-ascii?Q?ry+wX5fnt6ARl5awWerKP6kmET+sBMjDDUC1oPy56avNfA6q4qngnhYa23/o?=
 =?us-ascii?Q?saqCFqC/au09zQYTcudwjKQelKU994IoLFoMKIVzjThnXNEdWuhPF446bFmI?=
 =?us-ascii?Q?oqftJ72WI9Mws4lfpZXL9bNpGux6StXOJskB0qx0ceYaRLXxaofXQ2zg9G/m?=
 =?us-ascii?Q?9NX0ZBGXTDoJozjMvFZBsY8ZZi2N45e7HG+IEwBUUrN0GKHmqGqcLEFgU0Ws?=
 =?us-ascii?Q?OY+Z1pse3Xy57BYZCpToqAER8S57oCNAxiv1tNATUBIZzRuj0nlvKc4Zw8MC?=
 =?us-ascii?Q?7Zqh9YDZWgS3ZT4iLWyy6jYtStXROh4mwABsN3y0BgaSBsogLU7qSrU5oMBF?=
 =?us-ascii?Q?aoK6h1qXRJxGQLHd1M+AlVF3xED5djrZ03qlIaQ9R+AI9IGIliqANA0yhdIh?=
 =?us-ascii?Q?ehtLZt6S6/t81aeCp3WADhCgbhT0JhBvy/Im09QxY+6odgtCtgTcRGJoc0eC?=
 =?us-ascii?Q?k2jhTDh4hPErG8bbh2bbOj03xhd4YPuh2MMXRNYDj7M+4MLESBlKZJvpLDrq?=
 =?us-ascii?Q?Bm4sX1nG+lOMMstQ6iit74lz26F4+ivgfJ/E9he2i6paL7kpDq19rWDi5UNc?=
 =?us-ascii?Q?vJsGQjs8WY1ElXC/Fbz1lPpz+V5dU179pyt6/IQ7hLR2zhvp8t6SHV12/wYK?=
 =?us-ascii?Q?eExG5efrEetXwPKhuewyUyAuaHikUWQgD0zfIFxdd1vMfE/wBEqqqZhDI10d?=
 =?us-ascii?Q?tdTYO9V3tRYdcQTZfXXWZBMBVEEKxq4JPAL8ztNlWL9U26I5OqldLEgyAgc/?=
 =?us-ascii?Q?TvFcz+cPfTfzVVmQiJdixVQcLojtniEUr9Mks8QyK2yXE1tYep7OLOlHdvc8?=
 =?us-ascii?Q?Vk+0KY5chBie8u9INF0CRIk3gA54k3/uYO2mHOSuXpmeSsRazfubrkf0aM1L?=
 =?us-ascii?Q?iCqj5tzevYJdUzg6/4tQzCB5Bjv+LULrkmiOBPeWsvZCGoRN1XqliMf4Bb6F?=
 =?us-ascii?Q?loymhmmINxHudIPC99cNKOLKB79xXJG9PVk169OlyAumfNAlP5Ng4UbTVDOF?=
 =?us-ascii?Q?V0I6jOyVSf+sE/Pft7maotBWryKVuIu1cRDtL+hRZVhChqnkGBK/1BVTvFPU?=
 =?us-ascii?Q?CDUNw2tATyNcskkXvx4faZzxLu2isBEC1KSStEm11zbH5hMZe8a8UPbA44NA?=
 =?us-ascii?Q?8GY3KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A936F29CD6DD174CAAAB8F16C871F38C@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8720978c-2e49-408d-6acf-08d9abf7b434
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2021 07:31:01.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3w09w6OzhW1syUIM447ICNg4b0hJTbxjIA/DASDIM7LKQbFC08d7TV1zltRUzdW3s6lQp2dCpi4eQ26PPJfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5111
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: C6XYAgq-h-lYJ5IQTxXJtgKGIbcXArww
X-Proofpoint-ORIG-GUID: C6XYAgq-h-lYJ5IQTxXJtgKGIbcXArww
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-20_02,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=933 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111200046
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 19, 2021, at 3:14 PM, Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Load global data maps lazily, if kernel is too old to support global
> data. Make sure that programs are still correct by detecting if any of
> the to-be-loaded programs have relocation against any of such maps.
> 
> This allows to solve the issue ([0]) with bpf_printk() and Clang
> generating unnecessary and unreferenced .rodata.strX.Y sections, but it
> also goes further along the CO-RE lines, allowing to have a BPF object
> in which some code can work on very old kernels and relies only on BPF
> maps explicitly, while other BPF programs might enjoy global variable
> support. If such programs are correctly set to not load at runtime on
> old kernels, bpf_object will load and function correctly now.'
> 
>  [0] https://lore.kernel.org/bpf/CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com/
> 
> Fixes: aed659170a31 ("libbpf: Support multiple .rodata.* and .data.* BPF maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>


