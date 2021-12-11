Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7F470F2F
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbhLKAKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 19:10:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237526AbhLKAKa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 19:10:30 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAMKYeB028954
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:06:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sBrr2zCAH5wtjmUgLSdoEp04rUmXyC2cr+yZ3WiYLOE=;
 b=DaCKKXwqSBq1K0RAZpNprCiOIYh4W3wDScL0pe4/nNAuIgj/PPfDv0ZUCNLgPejz28l+
 +cks2b+OgJ78YaHL7VJ49iicrVQ9Ae0/JPlt3zrlaaxtH0RdGvaGEZstT9rIofbolE3N
 GQoqSd6U7rtQTXMS0Qj/zw+/JHuMMKM0nrk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvch29vg0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:06:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:06:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkd+E/cu5Bobi2CILsumSIRpiXvDm9DOC9qOLzJn5LxE3GXAVn9eV0f9FzsfRD1et6NVDcz9cXugN7wO2p3jqA6eQkLHZW95IFkOft7UUi8xYZRn3QxIfweJ0QMSwSAwEmr7dEf28FFBBzgkZ1lr54yvK2CzLgTf6esofxBnzq3OEm05n0p84s1bkg8t4hZFN7s/7M0wQeeM++hCszLWwGk+ScmBob8xnObbV1voEHyQMvtePec/FmBg421i9LLNqdjrcPCDjnGCkVvnrAmE36OBXCmg19rGSXTDuLpgWVJuJTfj/SEhCpre/aUKL1G8Lq/3xUK0qlfZpDcGRImjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBrr2zCAH5wtjmUgLSdoEp04rUmXyC2cr+yZ3WiYLOE=;
 b=ibyXGO53v0IqFfcLneK3XT6K71Enlu0fbtk0YcvSgIH7AJ8AZt5eiVvdpwCEBNxIk/86OnX1LCC5JXdZkJ9L70Lw7lbZWyOqqg4vU3E34oceyxz6Ok0Nrf5Lr+9ryzIE56Sh4s3smAItZFMEROsjPp+hRruzUZ5FaSBs5vp8yD+/HA8VFD4SZElGNaImYz4LEeaVftVDMDRQxAicHtd8KMq2UMUqoCsvnzMpTMoA3GM5WEsrJiIeOfJur+ijgfvpVblTmWQDutFAi/H1lrr3oR8F4g+6IALHPDaBTQPVAGyrcfJtLakiZY3b9iagUcndYaO0RJdX2vMSF3Ok3BGxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB3142.namprd15.prod.outlook.com (2603:10b6:a03:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Sat, 11 Dec
 2021 00:06:52 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2caa:16ce:c1bf:c59e]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2caa:16ce:c1bf:c59e%5]) with mapi id 15.20.4755.022; Sat, 11 Dec 2021
 00:06:52 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Stop using
 bpf_object__find_program_by_title API.
Thread-Topic: [PATCH bpf-next 1/4] selftests/bpf: Stop using
 bpf_object__find_program_by_title API.
Thread-Index: AQHX7fmDm8su7Bg8DE++catoNILKzawsS5mAgAAdfFs=
Date:   Sat, 11 Dec 2021 00:06:52 +0000
Message-ID: <BY5PR15MB36511181F166B2BB7AF0F6EFCC729@BY5PR15MB3651.namprd15.prod.outlook.com>
References: <20211210190855.1369060-1-kuifeng@fb.com>
 <20211210190855.1369060-2-kuifeng@fb.com>
 <CAEf4BzbrHE__GF1D117fXTCD0U-F_bq==2PxzxswU-P=umeA-A@mail.gmail.com>
In-Reply-To: <CAEf4BzbrHE__GF1D117fXTCD0U-F_bq==2PxzxswU-P=umeA-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b42c9583-342e-a10e-f9c4-fed026172d84
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d581ab-e96f-48c7-6c08-08d9bc3a2273
x-ms-traffictypediagnostic: BYAPR15MB3142:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3142C03573D074A2932B69C7CC729@BYAPR15MB3142.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/zIgedoKrYNJJCRISbbsN/5uCEVlPwU7HGg0nRyGyF1iDD1NSsF2Xe1FwCpxmmjUCsiYG2sdc8TtuJXw3BuC9fzRAbSrihOcugBKlhclMQmDgepgEQuu2bUtyP6HYrnETFtYZI9NoW9xJxFvwM67r/cYxgLTnDkUHLN7sdmtr2pcarEeXTdiPm1DUq0LfA6xU/AeTZWD/wUyuR0ppylzUbz14I9gEssGqK6ftdlfIPMcw72dk/U2VOe99DM1oPuw0fxX/LvDRyKCueleKkWVL0TL83kjR2BBMpVqULwzH9QmS2J1taw+RDESubR824myCYK/BhOw2WI98DnaiPR9VSu4Zbofj8aiA1QvpmtOF7oQn7V2v1CQNlvR9mNV8RaniuSjTCqiPuextK5a0g45FGMGGf65Dme3XaeRDIynmk+tx1BXWbZMYjedMiTct62/1OfX7K4gDlBU25rA8+KRsn9oa9qeXcQVEv13Rb0u3HUcTlkWZpWtPQl4QdIe5XtQh5ItoHDaYbI0mxPTbUpafWuaKHJ6c3BweITG/WVQizD6TdkG65fZcvk9260rmPFj+zp4+rmzvcXrOaczh71U17vQRfXvHrvnHjgtgVGxJnTRvG6DKz1ejgTKzuif106AwpncG/vM/QXrdtJCAhOkv0du1gqZUX2WtupS2mC/wKeeEgqofBP/2p1VBnsx/+yc6/0P01weWPnxapPYyOxnFn0CnpUCpbLlhgyKfgtEpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(186003)(316002)(66556008)(66476007)(38100700002)(38070700005)(64756008)(6916009)(8936002)(71200400001)(8676002)(53546011)(6506007)(33656002)(7696005)(54906003)(52536014)(4326008)(5660300002)(86362001)(508600001)(2906002)(76116006)(91956017)(9686003)(122000001)(66946007)(558084003)(66446008)(101420200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D7ODMzlpDzfy90wCtC8HuJ2NkW3yMzGTKL7RZm8dPXXYbjp+HWCRSvh5BM?=
 =?iso-8859-1?Q?p2mHRxYiTKeWHfsjIvaR4Eze0unOb/r1x2NR3pNl0W/1WQoq7+q3WFSXUo?=
 =?iso-8859-1?Q?2iXHHmm3dxgfGkrpO0G5QEOpyg+oRll7UMbrW/9v8BRll6MZAugv96xI1C?=
 =?iso-8859-1?Q?u27JbJjOvnYDfQ+OPZv4gcAmQfdbd47VySEVGQ3EY53GFK4i/d95ISAqUX?=
 =?iso-8859-1?Q?wMfc9RG9ik2KvIIvxNIAuOyO++nT/ntMGvaJ39sGRvkTEkbfOoAkZaomch?=
 =?iso-8859-1?Q?rlCbp2acHamusMzyNlmCYOH8RxE+moEgQ7MStDMu78+WRz6TwR3vvRyaKq?=
 =?iso-8859-1?Q?hM5+dcBzvRSQTd1o4Gk5TT365VTqmMvYTOmRX4y0ofri00XaV0fFwHgqQ+?=
 =?iso-8859-1?Q?WJtRgDjnsGoOd88RF3oe9Y5GQXg8stIsENhbVFTytQQ/rSfP+aHbGykDRU?=
 =?iso-8859-1?Q?qE2j9MB/VcnKcbaPMHcFW0xDlIcAlQsxH0Cf/M1lWvc5aY7eITkyBKm2P4?=
 =?iso-8859-1?Q?IDa2j4VqcKAX9u/ZTKD4ho5LfLUXljiLxNaYpK9zSg410Y2JkrGe6+mEkk?=
 =?iso-8859-1?Q?VVURv0x98qb0gPp2Eh2n/65zCimzCqx/qv2Esiyxgr24n8WRy2n+Rnb8ea?=
 =?iso-8859-1?Q?qUl+DOg/xFSruFH3hq/kN7K78XavvNfVpWGW8nhoUcmr7EVEnbzi9lgb0p?=
 =?iso-8859-1?Q?JtjwPiVEtrB0PejW0AHPHhZlXg0Yyj8EN5yWJ0OuH9VcKQUrmUjRr8/ZEz?=
 =?iso-8859-1?Q?9wn3j5sGCoGBgV4G95bAy3sZvuxU7+vLB6UJpN2u28B9+qN5UpOGPidrYG?=
 =?iso-8859-1?Q?LDkBh3qx+6yyThsVqqNo71/S7H/F2Spe1HWpToHcMH95+VqtytmAATz/3A?=
 =?iso-8859-1?Q?X9Gw6JT+EGmoTtvL42dv4oRLvhMu/nDEdMrshXOXCXlEcSTk2wQNzYjcXT?=
 =?iso-8859-1?Q?4RSQ4aAQxg1X8+brryf1r90r55CReKMIwMSslS+LCciPVDNIELnxY3punr?=
 =?iso-8859-1?Q?so94LDNSmjh/IPTsO/I0/9BrBCBQ5J6tla/lW5QwluQ29YhvwvgF6VDob2?=
 =?iso-8859-1?Q?4jfms6BSey5eOAboan57muVMkaP7oDO1jR4bryE0orxTaOAjxxvh/QTZuG?=
 =?iso-8859-1?Q?apU/ulDQWKTeUov6NzKsSVbrMzpfyS6c6g7iwiq8hmca5+dATqLJVy4IvG?=
 =?iso-8859-1?Q?hVbcbq37FIqnVfLc1Xs55AjZG3KMoVYFH5gDjkYr6oQ76owhTkJ4coN4M8?=
 =?iso-8859-1?Q?vbzr39HWMT1BvEkKDyS/V7Lto4mIT75e46QAHjZMTbZAOdlYcmqpCj3YRx?=
 =?iso-8859-1?Q?p2NW2A68ZqH+NFRlyBJy+n2Llx8EllNHif57E60WDdcqGQiVoSw2gso/1F?=
 =?iso-8859-1?Q?n20NfufGCFotC3DH/ZtkY/GmpYGgPe/qsj/dNf3uLbrtvFo1A42Zmf91La?=
 =?iso-8859-1?Q?tvHa+HDLkJaRFFF4MggxljyHNWfOjhjtZE1bW3717VuRKfXpAQkP7K4yn0?=
 =?iso-8859-1?Q?DGnWpFSCZHit7fWxxEinj9WAsrw6XGVde0UCq3RFic67fxN/YFtRyDOmQ/?=
 =?iso-8859-1?Q?ZFnld+zLF54yhCNI7dFnQGnjdZ1iFbeclIjGLdWGTJQBZ6x00hIPA1jm/J?=
 =?iso-8859-1?Q?DFVBJEn1nUtZ1h/3CRgl0TWCeqDDYZ4btC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d581ab-e96f-48c7-6c08-08d9bc3a2273
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 00:06:52.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkMQhWg6ZRQROXuCSCtvJETt3mPB1AIX3W0oIYOBapKjfsB2QVPsAOpSS3uceBPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3142
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ucyMX-NGeuJJZlFko4OA_LQSK6dsC3MU
X-Proofpoint-ORIG-GUID: ucyMX-NGeuJJZlFko4OA_LQSK6dsC3MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_09,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=720
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>=0A=
> Sent: Friday, December 10, 2021 2:17 PM=0A=
> On Fri, Dec 10, 2021 at 11:10 AM Kui-Feng Lee <kuifeng@fb.com> wrote:=0A=
> =0A=
> Did you compile selftests locally? Seems like our CI has problems=0A=
> compiling it, see [0].=0A=
=0A=
My fault! I did it wrong during last-minute rebasing.=0A=
