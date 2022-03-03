Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AD4CB35F
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiCCAHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCCAHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:07:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622C53B45
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:06:17 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMm8I005094
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 16:06:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qwPEKb4CJZa4YckOlAfQPKrkcEa2UfGeJw609IKQaBY=;
 b=mYsz4tKJqxoq+OMkkEtKzVWl2qZKwVcG/ZPNKM1ap6+ZWS8N8yuSB1dYWT6gL2HlNpgv
 nfn6YIGIwIY9wxwQIP49K4TizY4xTEYvUY8cPNPd7X/iVS0GPvHyrTAYcuYLvWP/jsBM
 FbGZ4G1wYMBTCf5zgzLzVpChF8wXCAh7uqs= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejdmmtd8g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:06:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwX9LnPSSfxXkk5pIwDrQF2TmAM/S4s66HEvpMqdXw1IE5XPDf/yHZx8NKGhkNu3RlRmQJpB+V02ZQF7jfZTGhOdpcqbD2SCWa9Z4gq2onua4zw/aNI9uimphWyLgMLS8lvLkHxcH4/HLtlpnPT/Bot/0UAM+GwfGN3CEjNyGW/490nugrmcRspskHaUiRnD3lmgYOSbt6JtJokjiE7bUbMgDS/Kc9+tE2ild17ykCIunEnaQSWYkoBExy11Kf052h9UA2E9Uo//Iz9jigHf2RFSHNS+o/8gti2jl3nrDmKjNs2ncs4+oiqvKq+t/TZNTnbfiOjXdFtPGYJM4IPYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwPEKb4CJZa4YckOlAfQPKrkcEa2UfGeJw609IKQaBY=;
 b=e4C6/DpNgFuutDNsRZBZNACKij6jjw6f+qe3Pp5AHKqIFn5jPCpIb4bnZK/AA9oEreqd6muMnp6uoTRPlZ+Vjqj3boZtWQVzgPH8eytfHFSZi88x/2Uje4uqtet+rD51EpJ0+fNW8f1MlxuB5vznnGqRF9mOLaEtn/QAa11bdoQV0jOQL0RCAvFAhbr/EjDtOpKDiL6G3w8//8HobN+rNyMZ1MdoUxF4iU6qRVOm5Gn7JEUlVe9EwsGbX9SSK/SK1cgnf+WZ0JJkqY4RyonamqvnXHJSlzfqzGXcIps/nla1jmuBLoFLGJXlJHoM1KfrlewhwftSsSGK0r2LM7XoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB4302.namprd15.prod.outlook.com (2603:10b6:208:181::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 00:06:14 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 00:06:14 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton
 functionality
Thread-Topic: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYLeAKMKJESw6+B0GttMPBMXX3YKysrmQAgAAZc4A=
Date:   Thu, 3 Mar 2022 00:06:14 +0000
Message-ID: <decc0e45afff1ed4bdb65e929aab24d7f66ed921.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
         <20220302223008.7deshk5qfw3pytxm@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220302223008.7deshk5qfw3pytxm@ast-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a209f32d-16a4-4fe1-b956-08d9fca9a1d6
x-ms-traffictypediagnostic: MN2PR15MB4302:EE_
x-microsoft-antispam-prvs: <MN2PR15MB4302AD0F7FC225F1E829DC50C1049@MN2PR15MB4302.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BF1Vo6X3jX+FuQjlQUzkgzYFLDOchoJFCmjjUDc5q52uWNm1Y1mcY8qm05zHtFmcEziv625C8rDfenrNgHgFPSwnuVP7aPAzyJBxxIWd8PZoyqDRRUG3yMTt6RccYxC/GjQPf1ymiU6C5Bbxs6wCzyHC1csGm4SpQuFEalbpW1Y9joSq7sWW/4TWUROfdisu5Qk4JKM7lDAxPJIdc6B3jU1WYLkGeJpfoD8cq+WvqK+gyfXLHxbXyl/2c/KLOmH/rOsisTmrWtHNFxy9iefHsrv7/A/MCeMFkdMBC3PzbGjDexvYc8F7MVwk4oxeF1cMxmlzDa9a/qy0lOHayLjbKwvBx23Tj5CnANs1XFJO3/EDayBDOXGCduqucRX3dsvfZ4oL9Etxpwty5v8vY5CVCg0roJY33rqoOE98ukQqOuE9tIRUsA/oUrOqoyKUW3rjuOYBz8nD3lH+8dy419GhWruSbSmheiY7OuAqJYrQVRg0moRrWMyjcx2Zgl9kd8X1mFuB1CeKf/W1b8QnziTjDCIi9imsGwujaSDKsgayTrHODY/1f7loESRHTJt04mFPPVndYghNYNX4F8lvDLZCl7g6IUsrOZZ0Qwn4beMwdg++8U2WPQ3p6bUuOkXCDpQAk/nOlhMci9wyFcLqRH6/mhs9VomuLL42dMbnfGTXA77EN2HeQNrBOox7co8Zp/rULeSZdGcyxTHCbQbulv9ZMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(186003)(2616005)(122000001)(38100700002)(86362001)(38070700005)(6512007)(316002)(5660300002)(8936002)(6506007)(508600001)(6916009)(6486002)(66446008)(71200400001)(54906003)(91956017)(76116006)(4326008)(8676002)(66476007)(66556008)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdEcXMySWZ0Nk4vYlI4dTl0YkVMVjVINGIyNHNUbkQwd0ZzYkdDOTlhK0Ew?=
 =?utf-8?B?ZUtObGZxWmhoS2hqZ0JUZFluNEVWM2RRRlFIRitPdnUzV2Z1QTR5SVBQMEZY?=
 =?utf-8?B?ZXVKL3NBc0dwYjlxWFkyTzFjSEUwVWtBczJndXQxQmg5NVRKVVVmUVNEalBY?=
 =?utf-8?B?MHQrWTJURFg2R3RtWk5jRUlVcmtjd3EwRU5oL1pEekw2cXM3YTNVVnh1VE9h?=
 =?utf-8?B?N2FkeDZqZk9sWFlnMUFVZytoVTdUdjN3VFZLUmIwNmFTT3Z5SjlWLzZCVzIw?=
 =?utf-8?B?V3laMytLMWs5VXIrNzNheUdmUmgvNVNuU1JtTGhoeGFURUVSR3BUMEpuS2lR?=
 =?utf-8?B?bkFHbVI5bnIxeXdPcW9yZ0RCNDB5QnExQTlVUEZaRkJSZ3hTWFdmdTRsb3Jo?=
 =?utf-8?B?Zy85ajVlRUk1dmIrSDdIdS8yTjdSVU9YbXRKaGlkemFkS081YTh5QWdmdHdl?=
 =?utf-8?B?T2ZQUmppcHZEeUlCWkRlOWwwT3gvZ0Q5alR3ak5sekdQWHI3UEtuRlFBTW9B?=
 =?utf-8?B?YmhIWStyWFBrL2phUWFLMDIySFpSaE9CalFuVVpBS0VwRU5WcWxEOEJ0M25V?=
 =?utf-8?B?KzZKcEg5dFhYSk5TdGEyaFMvRWwrcmVtL0ZxeEFKS0FodnE1SkRtTDM1alo2?=
 =?utf-8?B?b1M5bjNRZ1g3UHZraFh2SjdRZFhPOHZ5ZlZhbXFsUVFQWkRzVDdSdjZtTkNl?=
 =?utf-8?B?VmM5cEwvSytxQzFqeEJEZnRLcEg3QzFmWUFxYXUxb0N3cWkrQ2RJRktJbDll?=
 =?utf-8?B?MGlDZVVxZ1Y0c0tQbmJmWm0rYzgvdWpNNVYvN2YzRUNFOUw3clpueStUY0tM?=
 =?utf-8?B?cTQ1TGtmdGZLRlpyeFZSd1ZPZ3lsSVQ4M2NWTW9RZ1RCeGlMTXNCamxNelNu?=
 =?utf-8?B?SVZzWnN5YW1icXQ4aWxyUG9XVGkvVkhsT21kYThkMWtCQVZUZ1JIYno0S3lL?=
 =?utf-8?B?dS93WG81MUU5VFVJcWI2R1RMME0vU1BxSytubmpLMXdURlBxTVVJcTNCYWRL?=
 =?utf-8?B?dGwzbUdSelZpS1lIUHZzUmFpN091anhEZlIwS2FzS1ZOL2R1TzZQVytFMmIv?=
 =?utf-8?B?T2NRNDJaQUdqdUZXekdHaloxWHY1UlNvUGZXMWFVSDhDTDBKVHIydjkyR3lJ?=
 =?utf-8?B?N1pWL1VsbHRjMmxnKy9IWHJabjVmWFFmNTNmQlpXcnVRWEIxRnNlUmxXN2Fm?=
 =?utf-8?B?b2lqSGEvMFFPL2FWeFdOU2VpMEZPVkZSWkhWSGZRaTF5UjlLMmhqZ0gwbFA1?=
 =?utf-8?B?dkFURkNKRTdBMkFEYkxlVFVqdWNZWUZ1MzkxQkh4UkFVRDZVdVZSSDU2aC81?=
 =?utf-8?B?OGVaMnp3K2lpQ2JDZkRJRGUvak1vLy90L1dpS3poUkVsOVBqWkxxeVdTSW9r?=
 =?utf-8?B?dmhsSDJ4MENkZUdWUm9pVEJxcEdCUllScE0zL05pbmtHTWJRZGx6LzVlNUhI?=
 =?utf-8?B?Tmp2cytSYXlxblcwbnJPL0MyRnRoZ0dKczRUOGp4dWhvUzFBMXcvSHljOUNx?=
 =?utf-8?B?ZEd5THdiRzA0Q3JReUhwNytyVENvYi9XYlVmVzFLT2RPVzdXRER2Z1JUR0dU?=
 =?utf-8?B?UWZGNnlnZUJNZ3ExcXNUUTk0SDlGTXk1ZHlZUXR5ZW9IRXdIUFpMcG04YnBo?=
 =?utf-8?B?T3dXUmh6OWJTNGZMNURaMS9ES2lKN2liSFQzMHdKcFhvR01Ba2J2ZFloY2p3?=
 =?utf-8?B?bVFjM1p3SHd0UWJTVmRtUXRnc3BlZ2EwU1BVTUYrNzFmeDhnUUEvd043eVZT?=
 =?utf-8?B?NWNYZnYyTGNmUko0czBvK1NkakpsaXBhNU1YUjNaSi9HWDFDV2lJTGRJc1ZV?=
 =?utf-8?B?blF2cElQdzNuTlBIYS9vLzhJRkhrTFNCQThMeG9Ga2pXT2MwUXFoakhXMnRt?=
 =?utf-8?B?UlpnL0hsekNlOXR0MHdTRFhENFpVTUNtQXlsQWhuUjJZNjJPd2VQOGt3QjNx?=
 =?utf-8?B?Z1RWRC95eGU4eGFzNitPUzVNMU1BVHdPUzlqa1pDNHNUM1Z1bnRZSUlQQlRn?=
 =?utf-8?B?cTRJUmtqUTZoZFU1QlVKWmF6NTJBakgvcFZ4MDJTU2VqNDlnSFg2ZExjc1lO?=
 =?utf-8?B?QnpteTBQN2FiejlIaC9VN3BWOExzRndEMVhYT3ZXZHJSM1NYVDZwQ2NSSWVC?=
 =?utf-8?B?a2JOZWNIaWNMNThXblpvYjIyQURUYXoyQ2N2UzBuc3NkYmZMWmNZWDlnMUlR?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00D630B1FC4FB342B456679FF25425C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a209f32d-16a4-4fe1-b956-08d9fca9a1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 00:06:14.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpIL1q0FKTPehxWu18fINITaKbWLBX3UdAmiYjwVS/5jUcbFK+6C9zlSwkOe/vEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4302
X-Proofpoint-GUID: xnMm1HGf5A-_vXekjXuHBJ_s_zYbMePi
X-Proofpoint-ORIG-GUID: xnMm1HGf5A-_vXekjXuHBJ_s_zYbMePi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=560 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203020102
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTAyIGF0IDE0OjMwIC0wODAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFdlZCwgTWFyIDAyLCAyMDIyIGF0IDAyOjQ4OjQ4QU0gKzAwMDAsIERlbHlhbiBL
cmF0dW5vdiB3cm90ZToNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc3Vic2tlbGV0b24uYw0KPiA+IEBAIC0wLDAgKzEs
MzggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyog
Q29weXJpZ2h0IChjKSAyMDE5IEZhY2Vib29rICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8dGVz
dF9wcm9ncy5oPg0KPiA+ICsjaW5jbHVkZSAidGVzdF9zdWJza2VsZXRvbi5za2VsLmgiDQo+ID4g
Kw0KPiA+ICtleHRlcm4gdm9pZCBzdWJza2VsZXRvbl9saWJfc2V0dXAoc3RydWN0IGJwZl9vYmpl
Y3QgKm9iaik7DQo+ID4gK2V4dGVybiBpbnQgc3Vic2tlbGV0b25fbGliX3N1YnJlc3VsdChzdHJ1
Y3QgYnBmX29iamVjdCAqb2JqKTsNCj4gPiArDQo+ID4gK3ZvaWQgdGVzdF9zdWJza2VsZXRvbih2
b2lkKQ0KPiA+ICt7DQo+ID4gKwlpbnQgZHVyYXRpb24gPSAwLCBlcnIsIHJlc3VsdDsNCj4gPiAr
CXN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uICpza2VsOw0KPiA+ICsNCj4gPiArCXNrZWwgPSB0ZXN0
X3N1YnNrZWxldG9uX19vcGVuKCk7DQo+ID4gKwlpZiAoQ0hFQ0soIXNrZWwsICJza2VsX29wZW4i
LCAiZmFpbGVkIHRvIG9wZW4gc2tlbGV0b25cbiIpKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+
ID4gKwlza2VsLT5yb2RhdGEtPnJvdmFyMSA9IDEwOw0KPiANCj4gVGhlIHJvZGF0YSB2YXJzIGlu
IHN1YnNrZWxldG9uIHdpbGwgbmVlZCBleHRyYSAnKicsIHJpZ2h0Pw0KDQpQb3NzaWJseSwgZGVw
ZW5kaW5nIG9uIHRoZSBleGFjdCBzdHJ1Y3R1cmUgKHNlZSB0aGUgdmFyMyBhc3NpZ25tZW50cyBp
biB0aGUNCnN1YnNrZWwpLsKgDQpPdmVyYWxsLCB0aGUgbmFtaW5nIGhlcmUgaXMgY29uZnVzaW5n
LiBUaGlzIGlzIHRoZSBzdWJza2VsZXRvbi5jIHRlc3QsIHRoZSANCnN1YnNrZWxldG9uLm8gZmlu
YWwgYnBmIG9iamVjdCwgYnV0IHRoaXMgaXMgdGhlICpmdWxsKiBza2VsZXRvbiBmb3IgdGhhdCBv
YmplY3QuDQoNCk5hbWluZyBzdWdnZXN0aW9ucyB3ZWxjb21lIQ0KDQo+IFRoZSBhYm92ZSBpcyBj
b25mdXNpbmcgdG8gcmVhZCBjb21wYXJpbmcgdG8gYmVsb3c6DQo+IA0KPiA+ICt2b2lkIHN1YnNr
ZWxldG9uX2xpYl9zZXR1cChzdHJ1Y3QgYnBmX29iamVjdCAqb2JqKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgdGVzdF9zdWJza2VsZXRvbl9saWIgKmxpYiA9IHRlc3Rfc3Vic2tlbGV0b25fbGliX19v
cGVuKG9iaik7DQo+ID4gKw0KPiA+ICsJQVNTRVJUX09LX1BUUihsaWIsICJvcGVuIHN1YnNrZWxl
dG9uIik7DQo+ID4gKw0KPiA+ICsJKmxpYi0+ZGF0YS52YXIxID0gMTsNCj4gPiArCSpsaWItPmJz
cy52YXIyID0gMjsNCj4gPiArCWxpYi0+YnNzLnZhcjMtPnZhcjNfMSA9IDM7DQo+ID4gKwlsaWIt
PmJzcy52YXIzLT52YXIzXzIgPSA0Ow0KPiA+ICt9DQo+IA0KPiBDb3VsZCB5b3UgYWRkIHJvZGF0
YSB0byBzdWJza2VsIGFzIHdlbGw/DQo+IEp1c3QgdG8gbWFrZSBpdCBvYnZpb3VzIHRoYXQgcm9k
YXRhIGlzIG5vdCBzcGVjaWFsLg0KDQpTdXJlLCBubyBvYmplY3Rpb25zIGZyb20gbWUuDQoNCj4g
QW4gZXhhbXBsZSBvZiBnZW5lcmF0ZWQgc2tlbCBpbiBjb21taXQgbG9nIHdvdWxkIGJlIGdyZWF0
Lg0KDQpXaWxsIGFkZCBpbiByZXJvbGwuIFRoaXMgaXMgaXQgaW4gaXRzIGVudGlyZXR5Og0KDQov
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKExHUEwtMi4xIE9SIEJTRC0yLUNsYXVzZSkgKi8N
Cg0KLyogVEhJUyBGSUxFIElTIEFVVE9HRU5FUkFURUQhICovDQojaWZuZGVmIF9fVEVTVF9TVUJT
S0VMRVRPTl9MSUJfU0tFTF9IX18NCiNkZWZpbmUgX19URVNUX1NVQlNLRUxFVE9OX0xJQl9TS0VM
X0hfXw0KDQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRl
IDxicGYvbGliYnBmLmg+DQoNCnN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uX2xpYiB7DQoJc3RydWN0
IGJwZl9vYmplY3QgKm9iajsNCglzdHJ1Y3QgYnBmX29iamVjdF9zdWJza2VsZXRvbiAqc3Vic2tl
bDsNCglzdHJ1Y3QgdGVzdF9zdWJza2VsZXRvbl9saWJfX2RhdGEgew0KCQlpbnQgKnZhcjE7DQoJ
fSBkYXRhOw0KCXN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uX2xpYl9fYnNzIHsNCgkJaW50ICp2YXIy
Ow0KCQlzdHJ1Y3Qgew0KCQkJaW50IHZhcjNfMTsNCgkJCV9fczY0IHZhcjNfMjsNCgkJfSAqdmFy
MzsNCgkJaW50ICpsaWJvdXQxOw0KCX0gYnNzOw0KDQojaWZkZWYgX19jcGx1c3BsdXMNCglzdGF0
aWMgaW5saW5lIHN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uX2xpYiAqb3Blbihjb25zdCBzdHJ1Y3QN
CmJwZl9vYmplY3Rfb3Blbl9vcHRzICpvcHRzID0gbnVsbHB0cik7DQoJc3RhdGljIGlubGluZSB2
b2lkIHRlc3Rfc3Vic2tlbGV0b25fbGliOjpkZXN0cm95KHN0cnVjdA0KdGVzdF9zdWJza2VsZXRv
bl9saWIgKnNrZWwpOw0KI2VuZGlmIC8qIF9fY3BsdXNwbHVzICovDQp9Ow0KDQpzdGF0aWMgaW5s
aW5lIHZvaWQNCnRlc3Rfc3Vic2tlbGV0b25fbGliX19kZXN0cm95KHN0cnVjdCB0ZXN0X3N1YnNr
ZWxldG9uX2xpYiAqc2tlbCkNCnsNCglpZiAoIXNrZWwpDQoJCXJldHVybjsNCglpZiAoc2tlbC0+
c3Vic2tlbCkNCgkJYnBmX29iamVjdF9fZGVzdHJveV9zdWJza2VsZXRvbihza2VsLT5zdWJza2Vs
KTsNCglmcmVlKHNrZWwpOw0KfQ0KDQpzdGF0aWMgaW5saW5lIHN0cnVjdCB0ZXN0X3N1YnNrZWxl
dG9uX2xpYiAqDQp0ZXN0X3N1YnNrZWxldG9uX2xpYl9fb3Blbihjb25zdCBzdHJ1Y3QgYnBmX29i
amVjdCAqc3JjKQ0Kew0KCXN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uX2xpYiAqb2JqOw0KCXN0cnVj
dCBicGZfb2JqZWN0X3N1YnNrZWxldG9uICpzdWJza2VsOw0KCXN0cnVjdCBicGZfc3ltX3NrZWxl
dG9uICpzeW1zOw0KCWludCBlcnI7DQoNCglvYmogPSAoc3RydWN0IHRlc3Rfc3Vic2tlbGV0b25f
bGliICopY2FsbG9jKDEsIHNpemVvZigqb2JqKSk7DQoJaWYgKCFvYmopIHsNCgkJZXJybm8gPSBF
Tk9NRU07DQoJCXJldHVybiBOVUxMOw0KCX0NCglzdWJza2VsID0gKHN0cnVjdCBicGZfb2JqZWN0
X3N1YnNrZWxldG9uICopY2FsbG9jKDEsIHNpemVvZigqc3Vic2tlbCkpOw0KCWlmICghc3Vic2tl
bCkgew0KCQllcnJubyA9IEVOT01FTTsNCgkJcmV0dXJuIE5VTEw7DQoJfQ0KCXN1YnNrZWwtPnN6
ID0gc2l6ZW9mKCpzdWJza2VsKTsNCglzdWJza2VsLT5vYmogPSBzcmM7DQoJc3Vic2tlbC0+c3lt
X3NrZWxfc3ogPSBzaXplb2Yoc3RydWN0IGJwZl9zeW1fc2tlbGV0b24pOw0KCXN1YnNrZWwtPnN5
bV9jbnQgPSA0Ow0KCW9iai0+c3Vic2tlbCA9IHN1YnNrZWw7DQoNCglzeW1zID0gKHN0cnVjdCBi
cGZfc3ltX3NrZWxldG9uICopY2FsbG9jKDQsIHNpemVvZigqc3ltcykpOw0KCWlmICghc3ltcykg
ew0KCQlmcmVlKHN1YnNrZWwpOw0KCQllcnJubyA9IEVOT01FTTsNCgkJcmV0dXJuIE5VTEw7DQoJ
fQ0KCXN1YnNrZWwtPnN5bXMgPSBzeW1zOw0KDQoJc3ltc1swXS5uYW1lID0gInZhcjEiOw0KCXN5
bXNbMF0uc2VjdGlvbiA9ICIuZGF0YSI7DQoJc3ltc1swXS5hZGRyID0gKHZvaWQqKikgJm9iai0+
ZGF0YS52YXIxOw0KCXN5bXNbMV0ubmFtZSA9ICJ2YXIyIjsNCglzeW1zWzFdLnNlY3Rpb24gPSAi
LmJzcyI7DQoJc3ltc1sxXS5hZGRyID0gKHZvaWQqKikgJm9iai0+YnNzLnZhcjI7DQoJc3ltc1sy
XS5uYW1lID0gInZhcjMiOw0KCXN5bXNbMl0uc2VjdGlvbiA9ICIuYnNzIjsNCglzeW1zWzJdLmFk
ZHIgPSAodm9pZCoqKSAmb2JqLT5ic3MudmFyMzsNCglzeW1zWzNdLm5hbWUgPSAibGlib3V0MSI7
DQoJc3ltc1szXS5zZWN0aW9uID0gIi5ic3MiOw0KCXN5bXNbM10uYWRkciA9ICh2b2lkKiopICZv
YmotPmJzcy5saWJvdXQxOw0KDQoJZXJyID0gYnBmX29iamVjdF9fb3Blbl9zdWJza2VsZXRvbihz
dWJza2VsKTsNCglpZiAoZXJyKSB7DQoJCXRlc3Rfc3Vic2tlbGV0b25fbGliX19kZXN0cm95KG9i
aik7DQoJCWVycm5vID0gZXJyOw0KCQlyZXR1cm4gTlVMTDsNCgl9DQoNCglyZXR1cm4gb2JqOw0K
fQ0KDQojaWZkZWYgX19jcGx1c3BsdXMNCnN0cnVjdCB0ZXN0X3N1YnNrZWxldG9uX2xpYiAqdGVz
dF9zdWJza2VsZXRvbl9saWI6Om9wZW4oY29uc3Qgc3RydWN0IGJwZl9vYmplY3QNCipzcmMpIHsg
cmV0dXJuIHRlc3Rfc3Vic2tlbGV0b25fbGliX19vcGVuKHNyYyk7IH0NCnZvaWQgdGVzdF9zdWJz
a2VsZXRvbl9saWI6OmRlc3Ryb3koc3RydWN0IHRlc3Rfc3Vic2tlbGV0b25fbGliICpza2VsKSB7
DQp0ZXN0X3N1YnNrZWxldG9uX2xpYl9fZGVzdHJveShza2VsKTsgfQ0KI2VuZGlmIC8qIF9fY3Bs
dXNwbHVzICovDQoNCiNlbmRpZiAvKiBfX1RFU1RfU1VCU0tFTEVUT05fTElCX1NLRUxfSF9fICov
DQoNCg0K
