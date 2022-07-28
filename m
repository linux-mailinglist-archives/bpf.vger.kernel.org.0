Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F88584374
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiG1Pqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1Pqv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 11:46:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584C683F7
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:46:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SA2mVb019554
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:46:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FoQ5YVA8gl5gIN4K5SelkYywXomoBhF4967FI+1Yu68=;
 b=G7UFnZAmTdSi4gcvUjnKoi/sExxB4kTwPnL1ahDf+iWe1kltjN05L7KqKJ1VVaqHF4Fk
 fEbYieCCl9J7Ct+uNOMcGs3Q2lnZTAfuTbubh0QB/GzLWPiQCa8IDrmToSc6qoNl1rhV
 Q4kqaQ87C0SW6i7tvlYcHKWQgisDl+MT+iM= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hk4su1tju-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 08:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIWkEiGYwpZbSOiD1EJxKN198HdD0XgM4q+TROZGxnR5+S3Pglh3PdS3IShnAGzxI9gWcrCCLPiyPnjLH2TGHgeBnQJm0fisgA+UAk5XA80+I4MKuq/prd0QS8ReVJ4cTaixnE3T2PqHl0ipS277Q6KOBMKKp5Jh+J8QWbHp9ece7HF1wmO0G6IuG89lwKGg/C+4g82JdFg+MDjufzLqme9OVpTKqmMErCu4CpT2am+YgQgpSownSA2slhSLK6VD+Jfks/iu6aL/nok6U9cC0zHpDMKQm09/w+txHM4ZvDqkTnlXB5/Ji+Z/THTXxyBBb5GeyeXYTXfZvoy56toDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoQ5YVA8gl5gIN4K5SelkYywXomoBhF4967FI+1Yu68=;
 b=JmxAP5O+FIxY36gojP/lCLynJoYSKcEAlIJBgNvctbjhFaVjuc34esnoREIJDIJoKN91P9AxiteE64Dj+JiAp5pA6hchxwAEaSYCIXjjunDPg27azGo8qvpm9Y3cg2koX3DBBCuEGRRK0N3IZ0ZZysjhL69Ex9EE6BeCnCZZ2cpXjzaI/k5xu7hDUk7MNn1pe7OadL+8wlXEgSWlF6Nilwjgt7zOp21tSxUGeGXRe6hibmpcQaEXIPXEn5YX6Z1kBb0EIkGogQVCkGn0D4gGS/fehfWV2IOOqRRXV4pbLB30fempOF+Vs2zG/Lft/w4A7ftNWrMnGwJwL1PfKcykzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SJ0PR15MB5130.namprd15.prod.outlook.com (2603:10b6:a03:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 15:46:44 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 15:46:44 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Topic: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Index: AQHYoRLIz41WXjJWD0i8rSCksLxN2q2T8E8A
Date:   Thu, 28 Jul 2022 15:46:44 +0000
Message-ID: <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690949f2-5834-4387-770d-08da70b05f3b
x-ms-traffictypediagnostic: SJ0PR15MB5130:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYjuD/4ud8bphLeIhIGZ7tf72ra/zup8ymHxejA5JAPlkvrsbBEcV/l+2sGi1Q1EBp3s53OKYZpbrH5ZaaE8/ZqFvU0zC/Zz7C8Q0V9JbRUuTwKpYhP51fBf0hbfiZwaT7JDiGEEjePJqZbmwKNLzFV+IcqNUqRtCtHHGz5/WowgGDdIqB5VZ1uBJdOIUSvT+RnGCuto7OfxJJk2SuNFlTJCyg87THnRM+QELuZfaQYKt6ZdSug3oRq5yLrNEkx8HdFINTmVMh+yWCuo6MrdeorCCjSiC1v9Ma4ziQNDFWEczs1f21aBsB/gM5GDg+Qo089UPgFe0K6snDgeB9G3kWjxv4Grni9TMDEYffJrHvHMZHhZqP+dt/g3Bx/FdxlDpu1rSz1v8YlPGGuX2DIimaV0EqQk/HobfMPEIPTWJFw98vPAw1F6tB7+rUelnjPb5niNRh8WtkUC9cWG55jhFYWhAFT0EdfkYNu+UAhrOJ8wRJDeI4zyHHDOWntVP0EJlZMr6qxkhwM5helpazs9j/VXDuqiomJY+5qoIBtDR28JyVDXFrj/o7czZhfXNOG6WfOmszUSf3aPJaGrOO+dTxm/TFlwQoKMsNnCCO1WmDQY2hKACqWhVGDnwJZWWx7fwPdT64wIpWAWil0ooqTIV+zTniIzp6QWfrqYlLQlVYOC5jeEwKu4eTmdk3rvzAZ+Wv+MZLXakmM8onovYISNCQgXwK9PP6wec/f+rT1qVEte+8xw3KVGQLOwW2dW+fErIXO+/RNastUE4Oa+stxRo2n14/EM1P9PHhY8T2nrDJFKfQQodTvXWiN8SZ2/10AG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(478600001)(6486002)(71200400001)(36756003)(41300700001)(66556008)(186003)(38070700005)(86362001)(6512007)(122000001)(2616005)(4326008)(76116006)(5660300002)(8936002)(66446008)(91956017)(6506007)(2906002)(110136005)(66476007)(38100700002)(64756008)(316002)(83380400001)(54906003)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1WZU9ac2wxZWx1aXR4dE1yU01DNy9OTzdvS25FbkNmSWJqWjZMbElURUJm?=
 =?utf-8?B?Tmd6cS9kRG04ZktBN1dkTEF0UmY1SW9VaGJEL0tEaHNTY2FrUEpvVk16clBm?=
 =?utf-8?B?RXArOHBWbnNnUm9aRTVIRUpDK2JZbGRGQU9vYlF4MlMwblhtQzk3bWMrMVI3?=
 =?utf-8?B?QlZna0RQZ1B2MFNQdFpDRDFVK3lGcitoWjFmOU8rNzBWTWcrV1N5ZU1Zd0Vk?=
 =?utf-8?B?T1pwQUhvcGVuVXVRVDhKK1BnY3VpNzEvRkJFSzJCUnNLMkRBTVE3WjFIL1ZZ?=
 =?utf-8?B?MmtQWlZpYkUwRkRaUUFpZWttSEJCY0t5aXpnRS9jeUJnN0Vpb2NUTWtFTGNa?=
 =?utf-8?B?S1VKTjMwRTZRekNUQmdiMGxDTHpDckxPMy9NbTNyRERYNlh5NTI5bncrL0Ju?=
 =?utf-8?B?YkFTZGJGbmYyalExOE1FQk5LdlY0S29VZ1h3WjVLNHFJekpDeGRLWDhhbFVn?=
 =?utf-8?B?Q1ZyNDJxRldnNVIvS3F5czJEZkwxQjJwY0NkNFNwd1M0YytyNlJEa1U3UU5q?=
 =?utf-8?B?Q3pJamtEb2RlUDAwYTBraFVKUUpTWXNOQ2tielFPYjN3RlpjbkF6by8vRkVn?=
 =?utf-8?B?VWVhSW9tMEFCZDFQNHVkc0tqY0RMTU9oZFkzNlBudXUySmFpd0V0dElhb0RI?=
 =?utf-8?B?cEZCRmdFcU5ZU0pXeHFOZmNiSEZmNVFnS1pLdUFBR2xaZzViOUJqY2J1NEpX?=
 =?utf-8?B?T0hxSytVTmxSL3M2d1dGdXlrYjdPQk43N2lnaFAwZ3F4RnR3M2pmUW55eldI?=
 =?utf-8?B?RWtodmM0elZRWU5vOW81NjY0OE1ldWhaejhVcm9tNHVTRkp3N1pRZ3BPWXhO?=
 =?utf-8?B?VkN4TUFkN08rUTlLYjdyaFVEQjZmWDYrTEVnazkraTdsMmhOemlQNUJ1NW14?=
 =?utf-8?B?SnI0VW9xbjlqZGxYeEkxeWNGMFpWem5PcnVyejZrRy9JM0tHb3l0U05ndVZK?=
 =?utf-8?B?NjJJSUpFVTNMZmprZElpVG96S3c5Nk45ZjZXeE9XMWNHY3BhTStUeVlmMEd6?=
 =?utf-8?B?RndRYnp3ZUpyeW90K2FBUzRjZEdESzJtR0ZacEgrRndkd2ZkeThqVzNRUTJR?=
 =?utf-8?B?UDlBNlIyY0pLd2RJTTNVOVVKZmU2WVJBUUU2M2p1TGVmNzFPbGNjMGVUU0N6?=
 =?utf-8?B?cFJaRkswbDQra1hqanVjdCtza1N6UnRKbXFTZy9DVzYzc1NuckJGSjIvQzFk?=
 =?utf-8?B?aktuTnR3dnpOaENNbFNmdGJUcnVENS8vNmhyZEpta0JhNkRUK1FUWTFqZ3hk?=
 =?utf-8?B?ZzQ4YjBNM2N2T09QYnNJNk5DSDJzM1VKS2dEMFZ4YWFzZ1hqT0IyUVpLZm1z?=
 =?utf-8?B?TzdkMk9Bam1XbU03bUVOZmZ1VlhoL2RKTTNhSWhnRzFnZ2pIZXNoUlhNNk5i?=
 =?utf-8?B?ejBkWnFzbnZmTlI5N042a2VTcVBFZWxnemd0Ym1tT2dJVWtQU3pjNlVWcXZ1?=
 =?utf-8?B?aWpPei9JTE1jWVl1QmRHZFNRa1FvdnAyZzUweUpJb3E4RnY4dmR6VjRDdEVN?=
 =?utf-8?B?Z3dKTGkvdmtRNlJRaUIrMVhBK3E0cWxBZGpScjI4cXFxTDhBYytmclV3Smhr?=
 =?utf-8?B?dnFFMjdIV2tiVjF2Uk1hY1RLaUU3NXdjaGZERDBXRmxRSVR4WUFNSE1iN21C?=
 =?utf-8?B?QXBadER3N0p5OVQzK0F5RXBEWHI3UFZ1M0xLLzlQVC9ZNjJyVFMxaHNoYUpQ?=
 =?utf-8?B?bHB3S2pyVFZjR21pRmxRN3UzdXdoNEovYXlHbW9nVU1oVHk4ZTczVEtEb2JR?=
 =?utf-8?B?SHRJNENYeXpVZXVVdVovVmNqQm9zREdSUDcvdnR4eFkxS2s4ZmtleXZLbHJi?=
 =?utf-8?B?bU9EV3dISVprZmVrOCtZUGFqNklBMlcvRkt5WmRJM0RETXB1ZDE5b2cvN0Ju?=
 =?utf-8?B?YmExOE4xYkZYY2Z2UFh3TDNlNmxGakUrZTh2OGFreFJnV29WMGFDcndCL2U2?=
 =?utf-8?B?SHpkUklDQWJGVkR0ZEFjejBpbXd5a3pSYkpMY3MxSStldGZpZ05GNHE5amRl?=
 =?utf-8?B?blBJTTlKcklCRmUySzlxaERvS2ZUakV3Qk9BSXZJdDluYUVieTRueEZYWWRB?=
 =?utf-8?B?em9ReitWeEpkam9NYmhpdVdTVXUraWg0S1FTOGhhalBaN1lEdnRrd1Z2UXFK?=
 =?utf-8?B?cEFXdmd1czZ6OCs2aE1GWXpJc3ZrUEdSdHJlVXMvTVBsM0ZBMHJwQko3d3Fl?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ABE7D555B36D6428FDAA70217E6381E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690949f2-5834-4387-770d-08da70b05f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 15:46:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bJG70RHRyb0NWJqWx1GCdED8nhfxWKBq0EXfSMbtFIfzQHdsup67JDL13jZpFDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5130
X-Proofpoint-ORIG-GUID: IRinCxkCz6J-VSuTfAxUj0t-Y4VOvnWL
X-Proofpoint-GUID: IRinCxkCz6J-VSuTfAxUj0t-Y4VOvnWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA3LTI2IGF0IDEwOjExIC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiBDdXJyZW50bHkgc3RydWN0IGFyZ3VtZW50cyBhcmUgbm90IHN1cHBvcnRlZCBmb3IgdHJhbXBv
bGluZSBiYXNlZA0KPiBwcm9ncy4NCj4gT25lIG9mIG1ham9yIHJlYXNvbiBpcyB0aGF0IHN0cnVj
dCBhcmd1bWVudCBtYXkgcGFzcyBieSB2YWx1ZSB3aGljaA0KPiBtYXkNCj4gdXNlIG1vcmUgdGhh
biBvbmUgcmVnaXN0ZXJzLiBUaGlzIGJyZWFrcyB0cmFtcG9saW5lIHByb2dzIHdoZXJlDQo+IGVh
Y2ggYXJndW1lbnQgaXMgYXNzdW1lZCB0byB0YWtlIG9uZSByZWdpc3Rlci4gYmNjIGNvbW11bml0
eSByZXBvcnRlZA0KPiB0aGUNCj4gaXNzdWUgKFsxXSkgd2hlcmUgc3RydWN0IGFyZ3VtZW50IGlz
IG5vdCBzdXBwb3J0ZWQgZm9yIGZlbnRyeQ0KPiBwcm9ncmFtLg0KPiDCoCB0eXBlZGVmIHN0cnVj
dCB7DQo+IMKgwqDCoMKgwqDCoMKgIHVpZF90IHZhbDsNCj4gwqAgfSBrdWlkX3Q7DQo+IMKgIHR5
cGVkZWYgc3RydWN0IHsNCj4gwqDCoMKgwqDCoMKgwqAgZ2lkX3QgdmFsOw0KPiDCoCB9IGtnaWRf
dDsNCj4gwqAgaW50IHNlY3VyaXR5X3BhdGhfY2hvd24oc3RydWN0IHBhdGggKnBhdGgsIGt1aWRf
dCB1aWQsIGtnaWRfdCBnaWQpOw0KPiBJbnNpZGUgTWV0YSwgd2UgYWxzbyBoYXZlIGEgdXNlIGNh
c2UgdG8gYXR0YWNoIHRvIHRjcF9zZXRzb2Nrb3B0KCkNCj4gwqAgdHlwZWRlZiBzdHJ1Y3Qgew0K
PiDCoMKgwqDCoMKgwqDCoCB1bmlvbiB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2b2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqa2VybmVsOw0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdm9pZCBfX3VzZXLCoMKgwqDCoCAqdXNlcjsNCj4gwqDCoMKgwqDCoMKg
wqAgfTsNCj4gwqDCoMKgwqDCoMKgwqAgYm9vbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXNfa2Vy
bmVsIDogMTsNCj4gwqAgfSBzb2NrcHRyX3Q7DQo+IMKgIGludCB0Y3Bfc2V0c29ja29wdChzdHJ1
Y3Qgc29jayAqc2ssIGludCBsZXZlbCwgaW50IG9wdG5hbWUsDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc29ja3B0cl90IG9wdHZhbCwgdW5zaWduZWQgaW50IG9w
dGxlbik7DQo+IA0KPiBUaGlzIHBhdGNoIGFkZGVkIHN0cnVjdCB2YWx1ZSBzdXBwb3J0IGZvciBi
cGYgdHJhY2luZyBwcm9ncmFtcyB3aGljaA0KPiB1c2VzIHRyYW1wb2xpbmUuIHN0cnVjdCBhcmd1
bWVudCBzaXplIG5lZWRzIHRvIGJlIDE2IG9yIGxlc3Mgc28NCj4gaXQgY2FuIGZpdCBpbiBvbmUg
b3IgdHdvIHJlZ2lzdGVycy4gQmFzZWQgb24gYW5hbHlzaXMgb24gbGx2bSBhbmQNCj4gZXhwZXJp
bWVudHMsIGF0cnVjdCBhcmd1bWVudCBzaXplIGdyZWF0ZXIgdGhhbiAxNiB3aWxsIGJlIHBhc3Nl
ZA0KPiBhcyBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QuDQoNCklzIGl0IHBvc3NpYmxlIHRvIGZvcmNl
IGxsdm0gdG8gYWx3YXlzIHBhc3MgYSBwb2ludGVyIHRvIGEgc3RydWN0IG92ZXINCjggYnl0ZXMg
KHRoZSBzaXplIG9mIHNpbmdsZSByZWdpc3RlcikgZm9yIHRoZSBCUEYgdHJhZ2V0Pw0KDQo=
