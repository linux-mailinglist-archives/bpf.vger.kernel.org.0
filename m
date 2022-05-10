Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A6520AB0
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiEJBeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 21:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiEJBeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 21:34:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B7282032
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 18:30:05 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249MUlGu006150
        for <bpf@vger.kernel.org>; Mon, 9 May 2022 18:30:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kV8aEh/INNSVVzTOenyHsdb6TqzkAx0me6yRycOEg9I=;
 b=hbl9wNsL9uvZ2+IPC2gF8P3+WkiEWOhGUdeKG5lHjmjGhfu654WIaeNhRYBxEjqU7gzb
 g0TEXDnRY3LXnafIhAsfOMghorV3UXQcc8f4dcIiNb54ZnBbexUVbNE3oi4tXUBcM5OO
 2UJ/hUIpy1gwVBJDbIfkaBDCpdmoP5iF0rg= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwm3pd9sr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 18:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VosY0k8iifYSs2QCy9w8EfbMh8gDgKdyKiMYnWkPS23cGin0xBKUScmKbJ/BSyOWXLiudOY2LIDFcxgV5JyVaLAuZ7CDHjpU1xz2t8nLWVQ8U/uo1daOSUahqy4hQvvcHm2vvZzPw9dYLwhxHTEroQsqCj6weXb0EtuidZSrQYQ025JeZC7qrrAhAgcsB4hR1+2/V+LLAQ/yvjoostahkis50qJ6QgO3llgrfBcWKhQqg4EgRSOQQnefHajEPX9d5zVp4KyX79N8sP8g+74WsMHLqgRTb4GIj737iGxQh6Uqn9ojEGCd9oN7g1UcS3lomRMA1gS7oiG/CUejfINAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV8aEh/INNSVVzTOenyHsdb6TqzkAx0me6yRycOEg9I=;
 b=gJLYugCL11Kp8F0rkVd/BH0bMWKCiXnNPH6oT28f/wKlIXyA9LeH6kdeETZBJ5+zpDVJM/U65tnNbr6kgYry+LzxJmfaFYRWnlftYCC4YicOaeF0A0fEQiJMEJwBQkKpimOYKCPWDXjPGthwogI4J+XmH+XprnEarE35tE/YceDtVt9gGa095MeRSVDWBcsnBhS1tgL8Si3qXhpHH+WsVtB0D36/Fwritxu0goHtxnXwsBfYL3bcJHHrBzxA5fnTtTI6XMgD3lKWeLBuT6slmi8Y8+j8arpp4VlVIeuZ/PvpQ3olR6IMrFvYJM8jsmQIWHjraAPd/YwKKLKcZdC4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BN8PR15MB2547.namprd15.prod.outlook.com (2603:10b6:408:d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 01:29:59 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:29:59 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Thread-Index: AQHYYorCI9bE54qCe0CoDURzTgSB/60XC6SAgABKMQA=
Date:   Tue, 10 May 2022 01:29:59 +0000
Message-ID: <c3ade9c0ad19e9cef5864c0df948e0ae4cd54709.camel@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
         <20220508032117.2783209-3-kuifeng@fb.com>
         <20220509210425.igjjopd4virbtn3u@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220509210425.igjjopd4virbtn3u@MBP-98dd607d3435.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81a57fa1-faac-4ffa-77af-08da322498f7
x-ms-traffictypediagnostic: BN8PR15MB2547:EE_
x-microsoft-antispam-prvs: <BN8PR15MB25472960B8D36A0FAF9FF8EBCCC99@BN8PR15MB2547.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqzBIj/wameNdXefKlYlhDm2FOTTa7b+TBy+J9VY/EXiL8SKQmJ9NGQF/4YQOOWVjgJrK7zpOqxMgRK2tu/LTdjj8F+mgoSt2uUw61zXhNzYCwPgpo0B5BgRATn7kN5/dRZ/pxYUBx/o40E4qrNa6H0dPrByd8CHBuuveDSpCIJngzKe4pUXRzEXe8Ca0CIgG6BSts48563PxmO3XcEttsLHxTAHe8jsW3JyMEXXHZTqLWhfJ6gfvxbG+QA1Hxn4A+gcFQNZrSMf6aa+TbrlGNbOIWHAMGU5zUpJiooLAeS1mGJ6bvIWfDVQjaTP62pJhoDyPvdFofCazOeiSWlRh4h9wE99iU9rjT6xicKTxrFDhu+db8x5lH4F8lLp6GMPmQQUskamB9hV+8LWvq/XYwHLiROcc/DOYxIi/l0ifVV76saqFq8kL6KkeVIXTOwAGLz5nSskSXPUN7IsFqUbopd24XmxvgZl+Hh+H7L3WQkFlOTtRulsylG1uxvPIcE2w/PEJWoETafT1DnvBHZjuf2O4RugOAVe6pwQX3vfqxvkeXPZikoXBuMt2FDIy7sCYKIOAGlHHNN/39oQUP44KVRtvmjO8couRcQIDdhIdA/s40z/Na7tiF4S852IxIMEc4SpCNULpfr8oPi5HGZfYWR9RpIeJR+l+FQE4n9rsD7WfN1pBRJrdiJ9jFIRcfxp6ygTOkJqavCETZlwWXzdBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(86362001)(54906003)(6506007)(71200400001)(6916009)(122000001)(316002)(6486002)(2906002)(38070700005)(76116006)(36756003)(38100700002)(186003)(66946007)(6512007)(8676002)(2616005)(5660300002)(83380400001)(4326008)(66556008)(64756008)(66476007)(66446008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1phdTdwU1Z3QW9yM1FRWi9kbGFMVlJaZEVzYkhVRHprcVoxSXAxdjYvR0Ru?=
 =?utf-8?B?V2NXUGZ0UXV5Uk56QU5SUzJyVzZYS2RibVREZ284WEdocTdFRjQ3c3l5MjE0?=
 =?utf-8?B?SHI0RUtFQ3YwS05pYmhsVUw4aDloa3lmRndSUGFOdkRFSzhZTXlPOC80TzJN?=
 =?utf-8?B?OUJ3bys2WGVFc3VPUW1iK3l4MjIvaTQ0UmxKSG1UTFYyT1ZzNFNvNkRTOXBH?=
 =?utf-8?B?eFZ2UG03d0tmZXp1akRLRWVXb1kzU281aEdLK2ovNFZxYWNKWkZqS3ZHV3E1?=
 =?utf-8?B?VXpUOWpxWjYybjI5WG5HSFB6RnZWVTE5Q2J6SHNTN3c1eTJBa0ZHV1hGMm1w?=
 =?utf-8?B?bndYaTlkWnhiSWpFNGxkdlVNNjZPdkhuUS84eXFpejZ5dHhCMzZpcFNYczlQ?=
 =?utf-8?B?cG9XWXJxYWQrdkFrVUVQdjNoOGZlemlzVDYvSkVjUDZrem9DaXRYSU1waXo2?=
 =?utf-8?B?dStHcEJGUmZPSWVqNjhEdmFNRnJmSzRhYWc4Yk04cE5RRzRqRzBxY0dUR2Fo?=
 =?utf-8?B?VW8xdXBnTUxXOVFrQ3cxNHFlSkhlSk83aUZ1VDNVdVQxNTFsek5yTXBtVFQ3?=
 =?utf-8?B?NzBWNHprRm9rSm4yTDZrTVljUjdOdlhESUxPcjB3c0JCRm5RNU5zQ0ZLdnFu?=
 =?utf-8?B?TkZBNG1sWHdjYUY1d3JJSkpIQVF6dWVGRkpSMGdGbGJmVjRMbnBSM3RRRzE4?=
 =?utf-8?B?WTFwYkxTMVI2T3NORnZpWUVKOUZKbmJXLzJHcXdURk5OMStUNHp3WnNzL3Y3?=
 =?utf-8?B?a0t3b0VGQWhwdVFxWU9temFxdy9ZRXpSQ0RJbC9EK1Q2T0J2RGdUa3F1OGFa?=
 =?utf-8?B?cXlBczVkKzRaVVQwSDN0Z1ltR3FHbWpIclZEcW5SS2Z6elVzZTNZelRnQ1JB?=
 =?utf-8?B?c28xOFQ0QkpRYXNybHdGV2hRbWhhQVl2bG9jeXhGN2JEUThyMWI5WGxEVE9s?=
 =?utf-8?B?a1YrQ3lYSTJnb0R6VlYrREE2aGs1cXVQeXlhZkp2ZGhMeGUwcW1NQnh2QXA5?=
 =?utf-8?B?YnlIZFM5Rjg1UWtRVGVuNjBlck9ra2xpTXM5ZWx3QjdhcTNNTEg1dm8rbXVK?=
 =?utf-8?B?MmtXb3NlR1VFNTdFaWdpTmJ2SjFJQzgwQlRpWmZDL3VwbXF2YWo5MFM3bGdV?=
 =?utf-8?B?YWpkMisvTWswTW5jNlBnbUxpMVErREYwalZrbmJ1dHZvSVNWb3FEWFhKWk04?=
 =?utf-8?B?RERZTmI4OTFQdVZIdVVybE5hYWUvR0VvbHNYZGg5WWE2cGNwQkVqbDFYY3Nv?=
 =?utf-8?B?OXVZN01SOGVGV2tIa2lYaVpOQXdIaHVzWWtMamFsTEJ0M1V3VDZ1Nkc2VHhp?=
 =?utf-8?B?RzRkQkJBdm5ickVLMUtKN1drT0hEVCs0bC9JazF1bFNyNTZkSVpJNUl0czE4?=
 =?utf-8?B?YU5FZXVRREZCM0NBcDZUSlljK0F4SkRVd21NUWsybmd6WFVoQ29FNi9YRkQr?=
 =?utf-8?B?TTVIelNDMVAyN3dCYXRPRjMwemg1YjM3OU9lRTFrWkl5NEMrNzNQZkdqQmZL?=
 =?utf-8?B?TXg5ZlFja1lZOEJKYm9TWEtJTGZqZ0xWZUhDQ3pmZVg2OWNhUXNoQ01XaVo3?=
 =?utf-8?B?OU5oYkMrbzdZR09IazJhTnlKVXVuOWJjdnBvRG94YmhhV0VLOFJyYlJmZi9n?=
 =?utf-8?B?TkVNTkF3NjJTOGlWTjhkdjVtZnYrNFBnajE1VEJoUTFtZmVVQWJMQ1J3cDFJ?=
 =?utf-8?B?UVZmeFNtaW9PU2E3dGc1NXpkUUpmK0RER1pkY1d3dU1FUzdVSXVhOERSakd2?=
 =?utf-8?B?T1JvVU5ESHQ0UjNrUDFuZk1QdWhZOHpLNU9IVXppUUtTNkx0TmMweXhpTnBj?=
 =?utf-8?B?L0N6V3JYcDM0R1JKQ2hwbkZ0emVpR0R6V3VzRUw5VHhsUDNlOEc2d25mMTIy?=
 =?utf-8?B?Q3hTUjhDQkYzNGxqU2FMUk54TlVOdmhDL2V6VjY3YmwySG9PTE81clZIUWNk?=
 =?utf-8?B?WXFHd29sWlREcnVmem5GTG4vUHRHT2VEdHhwMWZrS3N0NkovNlVhRmYrTi9O?=
 =?utf-8?B?TjIrcW5NYTJkV2dQbS9nQVpBSDVDL2tUeE8wSmF5RmowMkc4K3BwY0poMUpa?=
 =?utf-8?B?Wm41alpLVWxBRDkzR1hYVUtsOFNHQlNneUM2VXlpdEdHWW1LSlZxbWRIR1E2?=
 =?utf-8?B?RlpVbWZnUjZ3U1h3R2hHTzhqTTVXcEZuaDA3WW50RjN6WW9RbWwrUjU2N3pV?=
 =?utf-8?B?MFFSZ2gxK0syMjRyQXg3RnczM3VTYzJITkppMXQyMk03NUQyaHJYc1FnZzZR?=
 =?utf-8?B?RElFK1l3Ri83M1VFK0pPYWV6QUxGSy8xZkxHd0FmcjNCYTcvbXV1WjJicXdM?=
 =?utf-8?B?Z3BYcUM2SmRDSzduOTBqNE0yT3R2b2o5TnBIRTExcW5WMms0VmJXUE1IWFBM?=
 =?utf-8?Q?4JN2c5BIYVcdV5Zc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85F032FC0544B34B9AE3F826D631D54C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a57fa1-faac-4ffa-77af-08da322498f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:29:59.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRBKr7xbNEM7Zwq5kDVBGqQ9nAGCRDmHE8UMrd09mLnBS+g6MsLnXqvnm53hZh0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2547
X-Proofpoint-GUID: JBkH3DXZCNokVyBQI547lbEBcdGGFGpM
X-Proofpoint-ORIG-GUID: JBkH3DXZCNokVyBQI547lbEBcdGGFGpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_06,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTA5IGF0IDE0OjA0IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gU2F0LCBNYXkgMDcsIDIwMjIgYXQgMDg6MjE6MTRQTSAtMDcwMCwgS3VpLUZlbmcg
TGVlIHdyb3RlOgo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFByZXBhcmUgc3RydWN0IGJw
Zl90cmFtcF9ydW5fY3R4Lgo+ID4gK8KgwqDCoMKgwqDCoMKgICogc3ViIHJzcCwgc2l6ZW9mKHN0
cnVjdCBicGZfdHJhbXBfcnVuX2N0eCkKPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDC
oMKgwqDCoMKgRU1JVDQoMHg0OCwgMHg4MywgMHhFQywgc2l6ZW9mKHN0cnVjdCBicGZfdHJhbXBf
cnVuX2N0eCkpOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChmZW50cnktPm5yX2xpbmtz
KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaW52b2tlX2JwZihtLCAm
cHJvZywgZmVudHJ5LCByZWdzX29mZiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFncyAmIEJQRl9UUkFNUF9GX1JFVF9G
RU5UUllfUkVUKSkKPiA+IEBAIC0yMDk4LDYgKzIxMjEsMTEgQEAgaW50IGFyY2hfcHJlcGFyZV9i
cGZfdHJhbXBvbGluZShzdHJ1Y3QKPiA+IGJwZl90cmFtcF9pbWFnZSAqaW0sIHZvaWQgKmltYWdl
LCB2b2lkICppCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKg
wqBpZiAoZmxhZ3MgJiBCUEZfVFJBTVBfRl9DQUxMX09SSUcpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAvKiBwb3Agc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYWRkIHJzcCwgc2l6ZW9mKHN0cnVjdCBicGZf
dHJhbXBfcnVuX2N0eCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBFTUlUNCgweDQ4LCAweDgzLCAweEM0LCBz
aXplb2Yoc3RydWN0Cj4gPiBicGZfdHJhbXBfcnVuX2N0eCkpOwo+ID4gKwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXN0b3JlX3JlZ3MobSwgJnByb2csIG5yX2FyZ3MsIHJl
Z3Nfb2ZmKTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIGNh
bGwgb3JpZ2luYWwgZnVuY3Rpb24gKi8KPiA+IEBAIC0yMTEwLDYgKzIxMzgsMTEgQEAgaW50IGFy
Y2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZShzdHJ1Y3QKPiA+IGJwZl90cmFtcF9pbWFnZSAqaW0s
IHZvaWQgKmltYWdlLCB2b2lkICppCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGltLT5pcF9hZnRlcl9jYWxsID0gcHJvZzsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbWVtY3B5KHByb2csIHg4Nl9ub3BzWzVdLCBYODZfUEFUQ0hfU0laRSk7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByb2cgKz0gWDg2X1BBVENIX1NJWkU7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogUHJlcGFyZSBzdHJ1Y3QgYnBm
X3RyYW1wX3J1bl9jdHguCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc3Vi
IHJzcCwgc2l6ZW9mKHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eCkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBF
TUlUNCgweDQ4LCAweDgzLCAweEVDLCBzaXplb2Yoc3RydWN0Cj4gPiBicGZfdHJhbXBfcnVuX2N0
eCkpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KGZtb2RfcmV0LT5ucl9saW5rcykgewo+ID4gQEAgLTIxMzMsNiArMjE2NiwxMSBAQCBpbnQgYXJj
aF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVjdAo+ID4gYnBmX3RyYW1wX2ltYWdlICppbSwg
dm9pZCAqaW1hZ2UsIHZvaWQgKmkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gY2xlYW51cDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoC8qIHBvcCBzdHJ1Y3QgYnBmX3Ry
YW1wX3J1bl9jdHgKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGFkZCByc3AsIHNpemVvZihzdHJ1Y3Qg
YnBmX3RyYW1wX3J1bl9jdHgpCj4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKg
wqDCoEVNSVQ0KDB4NDgsIDB4ODMsIDB4QzQsIHNpemVvZihzdHJ1Y3QgYnBmX3RyYW1wX3J1bl9j
dHgpKTsKPiA+ICsKPiAKPiBXaGF0IGlzIHRoZSBwb2ludCBvZiBhbGwgb2YgdGhlc2UgYWRkaXRp
b25hbCBzdWIvYWRkIHJzcCA/Cj4gSXQgc2VlbXMgdW5jb25kaXRpb25hbGx5IGluY3JlYXNpbmcg
c3RhY2tfc2l6ZSBieSBzaXplb2Yoc3RydWN0Cj4gYnBmX3RyYW1wX3J1bl9jdHgpCj4gd2lsbCBh
Y2hpZXZlIHRoZSBzYW1lIGFuZCBhYm92ZSA0IGV4dHJhIGluc25zIHdvbid0IGJlIG5lZWRlZC4K
CkkgdGhpbmsgeW91IGFyZSByaWdodC4KCg==
