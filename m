Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDD4CC5AC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiCCTKC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiCCTJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:09:59 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39631151375
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 11:09:13 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223DZG1C007405
        for <bpf@vger.kernel.org>; Thu, 3 Mar 2022 11:09:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+fQtKP+D5bVchBQkWRIXNZabOkMKgYNif+sJG5qgvB0=;
 b=QO3X6JTRqIRX+R40cpziKVDLl4ZpyPoo/iPQNTx/HkUZy/vxHIUbKoZ8zO/fJPQPTFiB
 XScNDSiBwPC0aT2jJKfNBoKHKndNhuOFsSWk2yYFaDWzD6DKZ3T/42L6VHJcNsb3oMj9
 bwbVWcmj6sbM52Nd7yq9SiAYDdosenxt2ew= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejxnmagsp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 11:09:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeVMBjGjgmyx0bIm6dm1KRyGkmzv1mI8sP5WbBExiD4wK9AxjxNDA8vvy54oEHzIi57v0v8PJxv/O66YcE/oHXXGn3VgkoKFTjzprqsa0L14CBsJ4/pNCBnH/5zgZBwWoXRqjy02QIoMDG213xCgtOZuCYf/YaSGlX31EctUcNG1EnavxkXJRE9T0gJh84M3T6CkoW+KeIcLhxTSbBtkLx+RNvXZzYQljnaTFrbi28CFTylFWtEjq2BwPQK1CUTJKESeWj+ZJM/b2RbTbpmQeAGkfWMEtS1WC6xN2Pxuv4jWw9a8SGMSUoVQ4WqPtBMoFx3TE3PDRiMjmm5Eodw7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fQtKP+D5bVchBQkWRIXNZabOkMKgYNif+sJG5qgvB0=;
 b=LlIowAE/3X6YkG+PnRZt1NmQ3EzUL7SRud+4J0GBYomwCmUSBh6SpHs0bc4Mg9tUPHuQMaJIu2k/G1apLk8ikWv+lXs6Zuk4vYXlri4TZmqXsR0gvMs7E/AGB1bwAiM7P8WwTr/NZvtdpMas9sdrbHV2u4gVl7B3S8yOywZw8/OamPlBM1cWkBvGFnNBHYaZcBMASgMUQu3WVzJg72Oc+p01pxnj2/5zsvjV74MGTl9hDDaLPfOjOpORrzpaIupQ27AmRNCCvw3txMsDUtwcNqS13QIvzJmGx9Qj+AlX60PtveyFeaV/ZXFqyQZF7hETSr74dtEp8Rtd5S5ghSWLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4488.namprd15.prod.outlook.com (2603:10b6:a03:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 19:09:10 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 19:09:10 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Index: AQHYLeAK9g0hdIS9FkG6uKp/LdoqtaytE9UAgAAARwCAAPMQgA==
Date:   Thu, 3 Mar 2022 19:09:10 +0000
Message-ID: <af229a64d7f64996c75e6406b146ff00df3e9f5a.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
         <CAEf4Bza55GsV1oZa=d9UuscNerMsvFPtXSTQ9qr8mrxPQVu7QA@mail.gmail.com>
         <CAEf4BzbHM_5Ytw=bMbw8Lif+EMyyCmvTRt36DnkGB00+ovX26w@mail.gmail.com>
In-Reply-To: <CAEf4BzbHM_5Ytw=bMbw8Lif+EMyyCmvTRt36DnkGB00+ovX26w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 642ea2f9-ab6a-4385-5706-08d9fd494c50
x-ms-traffictypediagnostic: SJ0PR15MB4488:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB44887AEC74211F6447A18B0DC1049@SJ0PR15MB4488.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSMSBXOs9t+luTOeHZGmiIICsR9GnWRL4ept4r/8By5+Y9iL9y+Yaw4IhvdcjV1p1UBThZFpHlytAuB0qS0CWM/k+KKdOlV6abSA2rNCTcZojTw1nw8gQKsqJZRSST/9+8cWK0p+bDrP5+ZUjbI6GHhVXmftYtH66IKmlDXcSwTcs7VqQa0FLrixucLe4ZzhJa6q7Mt1+t2WJbqaRpuFyf3+sqIg2WWO7tsH7+Z60EQWw1LbiOisz3cWIexoDjlYBOfVpJmH4X38M73HuiZk3UclJ6AaYTSb1iwmyU2RTfOZ7G6vm6pU7HGz4JjM8+HxSwASR7C5NBGWCv7YLb16/yAIhCjgr6/fh/P5VplJTDM2Ji9Yfm5r5jFCpP9uyB6Aqa0kM/IvPhhdRkSJTLLJsYi2iJ14sXK+WRoQdWAIE0Aq1yuXp8GKZX/jMNkT5Ojr7plh7zzlpcvPuijMTgz1FSEtnk9pp1OhjkeKm7fHBSRmYox7h2Enakvf5ZQZVYiNUoSX+NOLDrrhSUk8JM7QSGUqMUqJM73jZzx+dtdiwSxkOo3YmsDVtgX39C4tnm/BKBKiaJ9LrVij2AgnW24XLj9eBIyyc/kbPE5SyidJLMdVs0sb7e7nuMzBNlBGMR6oKbZEW47SyW8PBOvZjH8HVUhbFwYn7RIJxCOvgibZZvW+6VtBrjiRMtBNjmCq830vT+Yhws/rl3O/a+VtaLDseA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66446008)(64756008)(66556008)(66476007)(26005)(66946007)(186003)(76116006)(38070700005)(6916009)(316002)(54906003)(4326008)(6512007)(38100700002)(2616005)(122000001)(71200400001)(6486002)(36756003)(508600001)(8936002)(86362001)(5660300002)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cy8wMDZvSlM3TFgrQkFwSTVvWXFIM2VBWm0zVWIyMVB4QXdiZGEvMmM1cVZy?=
 =?utf-8?B?ejFOeXBCdGtub3pKK3BHRjFXa1V5OFFKN0x3YVNXZGVvb3dHWFdMdkVZRlRK?=
 =?utf-8?B?VmJiYWpNZHBWRTQrRjdTbm1XMnRxOGw2Tnh0cmUrNFdtRVdpUFVKYWo5WGtB?=
 =?utf-8?B?bmtmNlVYRVFmSWVjejFtTnU2aXR0WlRHQnQ4dUE0dmROZTlMRnBQaDNQN0VX?=
 =?utf-8?B?NUZBSVljNXVWSW9reDZwaWpTbWNGL1lHcVhqWmpoV3R2RkpheXFhSkNWQ3Rj?=
 =?utf-8?B?cDVGbTJoZDdwNjFEUHV0UmxVOHJXYWYvRDN5cG5yd3ZmNE1DMklnQ3lmY2FD?=
 =?utf-8?B?ZDdKS2ZxOFBzZ3lWYjYwUkVEU3pic2NpNGR6djkrUXdUZUZ2N2NkWkYvUTVw?=
 =?utf-8?B?WFRoSkxzVlhRY3VOSm5vUlduQ0tzUDhJT0xiUnlNQ1piUGJRb1hqS3d0dmRi?=
 =?utf-8?B?VDQ3QlRLdHN0OWQ1RmJSM3RqMkY1NlBKN2tsaFdFOCtReERFdXQreFNkWmdB?=
 =?utf-8?B?UVNVOXd3WFZTL0w0ODVyT3ZxTjBIMGxQSytUNFd1d2ZJVGo5d0Y2OCszZjhn?=
 =?utf-8?B?NXhHQUhmcmtlTkpKSnpUYzJCQi9UMENKMWpPd3lNVVkzTTZOUjVYeGRkaUZP?=
 =?utf-8?B?K1JObkVlcDY3ZHptNkwzSmx1WlNISEw1YXpXcGpJdi9sNVh6TGd0Zm5JVlkv?=
 =?utf-8?B?MTFDZnRtaUZLaXdCK01mSDQ4Y2ppRlJuUDhUbVFnWmVQczJ4NjNsWEZnQ0M1?=
 =?utf-8?B?WDNtR0RUOHA1a2JsNnBRS3dvc1N3Y3orS3pONzRvUm9rcjlkaUJzMk5qeVJz?=
 =?utf-8?B?ZkZBWS9lRkVLejFRQ25PQWF0ZkludE9HcUpFamNZYTBWcjZUMXBlUXY0WjFi?=
 =?utf-8?B?eHRKUmMyOTNxb3J3QkVFem9CZFBJbHMrVXh6OUJBMmx6Myt1K3JlTTIvUzZO?=
 =?utf-8?B?QUk2VlFyZFJPVmozWmZUZ3cyWXlNdWtaMDd6RStBRitVUmZXUXZrYTF2N0Jp?=
 =?utf-8?B?dE5MR0NZUERaTlhsQW5sd28rNGMyaFNVZVd5YTFFL0tuMzRBU0xLYkk2c1dl?=
 =?utf-8?B?YWMwcm1RcjZDLzVVT1BDYkE0clk5MWlydllhL2hla05zR1RWMEZ6T1ByN0Qr?=
 =?utf-8?B?WnduVTNWQStnQUYwWXhhcExlRDRIUTFZWkxCKzZTNThYcjFuRlZ1c2FzTU9t?=
 =?utf-8?B?Wkd6ZitlOGc4OTVqMXNZV1Y1QzR3RVpmSG9PZXhNMTMvdWwzWjRWRExZOFVZ?=
 =?utf-8?B?akJSQWJqUkJFNjFNOTJqek9JVGEwUDJYdE05VVU0VU5WWHNDUjQrQk1FRTdh?=
 =?utf-8?B?L3hFMzFadXBqM09GazRJejIxR00yOU1nWFR6QXl0MG9obFhjTzVkZXZQTU5L?=
 =?utf-8?B?RmhGRm1HZFlQbzNsR0Y0NUNoY0VJYmxRVlB4aUhtTFpxakI3SCtZR1czRUNB?=
 =?utf-8?B?SnVjQXFxM3ByYlpKQkt3MVNUSVNkUkdqRzRqUktSUU5GSE1ZZEZCS2lUNVR4?=
 =?utf-8?B?V2R1clE1c3ZCSU9LdmVtYy9VeDcyY0RtZTRldWVSMjJsaEQvSG5vNlREVURF?=
 =?utf-8?B?eXRlMkJJMStRWkJDajhMeFFxQ05ONXNicGFGWXFJRlpqVEVXS1hUOTVWSk94?=
 =?utf-8?B?ZG54UGxnMTQvMU9hT0VNSnk4MHk0MjRSZms1bzZzWEpNZW9JcE5kZzl6WGtn?=
 =?utf-8?B?bkszYzkzcHJNL1U4SUIzait6RTdqNzFYbWsveTc1YTdOSFFHODg4U3Y2UWNt?=
 =?utf-8?B?VVFRcTRuNGk4VCt4YW9mNTUrZjhsZ1JYdUkzTnVISGhIeXRLY2dFQ01iK1lx?=
 =?utf-8?B?RUwrNU9jcTRFM3FVSjNDNVlVYXF3QWg2RVZSTlM0Qisrc0xzYStheEhKZW5X?=
 =?utf-8?B?Z09SeHorZ3NqaitlVGhST1RJU3ZXL3FuZ1kvdFVLcTNJNDBMV3YvckRIbkIr?=
 =?utf-8?B?ZE9mUnNCdXJYVlp4bC93VjlwaFNITmYyK0ZzYlhZZ0ZIM3VnV2x3TnpWZ0Y1?=
 =?utf-8?B?eDJiOU9DVmxhVVp3YWpySkFzLzBQWTBwVmtuVU9BblRMMks3S0hDQVkxK3lr?=
 =?utf-8?B?UFVXdHRCaFFjcGNLTU8vbmpPYnV2djNmcFBVMWQzYmZINUVzNzdYd2tlWHJp?=
 =?utf-8?Q?RBH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C14F36458304C546A457C4FE5CA8AC2F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642ea2f9-ab6a-4385-5706-08d9fd494c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 19:09:10.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZIrTsZZBhtEyQ7mIaAkESCoXfXCr68+pMRgKy/eDXSwZgoruC6MYrxtFxpaP/hb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4488
X-Proofpoint-GUID: 9ZoeDjXEh8glzWDbFKpROS8CV_OLg9_4
X-Proofpoint-ORIG-GUID: 9ZoeDjXEh8glzWDbFKpROS8CV_OLg9_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030087
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

T24gV2VkLCAyMDIyLTAzLTAyIGF0IDIwOjM0IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+ID4gDQo+IA0KPiBmb3Jnb3QgdG8gbWVudGlvbiwgdGhpcyBwYXRjaCBsb2dpY2FsbHkgcHJv
YmFibHkgc2hvdWxkIGdvIGJlZm9yZQ0KPiBicGZ0b29sIGNoYW5nZXM6IDEpIGRlZmluZSB0eXBl
cyBhbmQgQVBJcyBpbiBsaWJicGYsIGFuZCBvbmx5IHRoZW4gMikNCj4gInVzZSIgdGhvc2UgaW4g
YnBmdG9vbA0KDQpTdXJlLg0KDQo+ID4gPiANCj4gPiA+ICtzdHJ1Y3QgYnBmX3N5bV9za2VsZXRv
biB7DQo+ID4gDQo+ID4gSSB0cmllZCB0byBnZXQgdXNlZCB0byB0aGlzICJzeW0iIHRlcm1pbm9s
b2d5IGZvciBhIGJpdCwgYnV0IGl0IHN0aWxsDQo+ID4gZmVlbHMgb2ZmLiBGcm9tIHVzZXIncyBw
ZXJzcGVjdGl2ZSBhbGwgdGhpcyBhcmUgdmFyaWFibGVzLiBBbnkNCj4gPiBvYmplY3Rpb25zIHRv
IHVzZSAidmFyIiB0ZXJtaW5vbG9neT8NCg0KInZhciIgaGFzIGEgc3BlY2lmaWMgbWVhbmluZyBp
biBidGYgYW5kIEkgZGlkbid0IHdhbnQgdG8gbWFrZSBicGZfdmFyX3NrZWxldG9uDQpsb29rIHJl
bGF0ZWQgdG8gYnRmX3ZhciBmb3IgZXhhbXBsZS4gR2l2ZW4gdGhlIGV4dGVybiB1c2FnZSB0aGF0
IGxpYnMgcmVxdWlyZSwgSQ0KZmlndXJlZCAic3ltIiB3b3VsZCBtYWtlIHNlbnNlIHRvIHRoZSB1
c2VyLiANCg0KSWYgeW91IGRvbid0IHRoaW5rIHRoZSBjb25mdXNpb24gd2l0aCBidGZfdmFyIGlz
IHNpZ25pZmljYW50LCBJIGNhbiByZW5hbWUgaXQgLQ0KdGhpcyBpcyBhbGwgdXNlZCBieSBnZW5l
cmF0ZWQgY29kZSBhbnl3YXkuDQoNCj4gPiANCj4gPiA+ICsgICAgICAgY29uc3QgY2hhciAqbmFt
ZTsNCj4gPiA+ICsgICAgICAgY29uc3QgY2hhciAqc2VjdGlvbjsNCj4gPiANCj4gPiB3aGF0IGlm
IHdlIHN0b3JlIGEgcG9pbnRlciB0byBzdHJ1Y3QgYnBmX21hcCAqIGluc3RlYWQsIHRoYXQgd2F5
IHdlDQo+ID4gd29uJ3QgbmVlZCB0byBzZWFyY2gsIHdlJ2xsIGp1c3QgaGF2ZSBhIHBvaW50ZXIg
cmVhZHkNCg0KV2UnZCBoYXZlIHRvIHNlYXJjaCAqc29tZXdoZXJlKi4gSSdkIHJhdGhlciBoYXZl
IHRoZSBzZWFyY2ggaW5zaWRlIGxpYmJwZiB0aGFuDQppbnNpZGUgdGhlIGdlbmVyYXRlZCBjb2Rl
LiBCZXNpZGVzLCBmaW5kaW5nIHRoZSByaWdodCBicGZfbWFwIGZyb20gd2l0aGluIHRoZQ0Kc3Vi
c2tlbGV0b24gaXMgcHJldHR5IGFubm95aW5nIC0geW91J2xsIGhhdmUgdG8gZG8gc3VmZml4IHNl
YXJjaGVzIG9uIHRoZQ0KYnBmX21hcCBuYW1lcyBpbiB0aGUgcGFzc2VkLWluIGJwZl9vYmplY3Qg
YW5kIGNvZGVnZW5pbmcgYWxsIHRoYXQgaXMgdW5uZWNlc3NhcnkNCndoZW4gbGliYnBmIGNhbiBs
b29rIGF0IHJlYWxfbmFtZS4NCg0KPiANCg0KVGhhbmtzLA0KRGVseWFuDQo=
