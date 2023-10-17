Return-Path: <bpf+bounces-12488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8987CCFF3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 00:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C61F234DA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C72F52F;
	Tue, 17 Oct 2023 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AL8ut0K6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B62F517
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 22:16:18 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D8DC6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:16:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHmsTW009754
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=iNz6kLFRUamnK4pFYJY7br/2SPdDBrjImNpRLi/3Vuk=;
 b=AL8ut0K6h4uEdKKkGj9wsytCSTIjS3XktUsfqXx7/8roE0cBAALDY2rCT6JyCnIqsOhf
 Ffd1NogWXg6PShfLSfKfgx8HihWy2sCxg1eBztOCTldl0YtWKYD0qWrATJHwTmmBrNz9
 r5s5rb/ORuC//Xh0MqPW17Upl1wTCU9KnmBKhS8rCbr8hIfDZgPjZ39RAZQ/eWrZytDa
 G86SR8cpB8uYe7F9YeSC6Hq2At+ErZJij+rv/Kl7ccuR1w8wik8xXtIdTHNAD4u5n7R9
 +652YXPd2I1n4abQWCX6+tSOshlaptGbEcL2I6KfMYQygPJeyBXM/SXdQPZYpbjUYyjG rA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tsqqt56ck-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD5l98T4N9a4174IxXtG9yEOY4jg5q4hvosdrrRac1IJNXEOAtxo+MX7fe07yHQDg6tUJl4IXHNiA/O+oZv5Jg+6e3Fqgz5PWlaUUAMd5Mhpg3eIjcJv76BGqxYjLsxUF7oy+KQUgW0NR1gPbz7QquIOdv2tmEL8nQjvFQxQXIUNFYHe+aMaAF/h2NHsfsEoATS20GbHoodCqNUhZWwR03Ar5RUo1IdH1GiGdWxpyMA5k0C4j5XAMNDkaD8/B93m4k3gN06sGZOIVBGjrYAR4IGD+LP29XLWoKRpJgOfvcp7uG3eKF0ho1Qel6QRrERCPTdQHuBs1DWwSaBW8tsANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNz6kLFRUamnK4pFYJY7br/2SPdDBrjImNpRLi/3Vuk=;
 b=ZkZ0FoI5Ff04tKZlUYeUmJQ71D0MdyqX4O2qQ2Jzdpz/mqvtFZ4PmgT6fsNOLtbjD6QmkcpG0a4vuEmy6HhPJj0SETdPmg8JtRnUgjJGlczCzWVk9Z5rPYMk02Cu6W+MMertyAD44x3OBY9ahd5TRlJCQLQQIib69MyzPgmlv4YyOsztL/ds4KQjygOzTKA9HkoZxXoUdd8zlfmqxKAiCTJ57ulyGQVdG4I0q6penNcDHQiXnDFGWlKAW/l0pQXKVU/ijYTEmyKAtXqul/n2jJ8FMjdyd3VPdD2bXWUNUk+7EczdBBaXDyC+jDKTv1QlY8dev+rMZySbpGvq84K0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB5674.namprd15.prod.outlook.com (2603:10b6:8:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 22:16:12 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 22:16:12 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Eric Biggers
	<ebiggers@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Topic: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Index: AQHZ/gM1jAkPDEgRp0q6fPvepF0WybBOW9CAgAAZ8ICAABaKgIAABrWA
Date: Tue, 17 Oct 2023 22:16:12 +0000
Message-ID: <5FBE8C27-0280-4434-BBF2-70344276F16D@fb.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-2-song@kernel.org>
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
 <0ABF7860-A331-4161-9599-C781E9650283@fb.com>
 <CAEf4BzaNA18CpG-E-OUynEZuhGoQsieyzTVTkVOF9qB=j4u+yA@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzaNA18CpG-E-OUynEZuhGoQsieyzTVTkVOF9qB=j4u+yA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB5674:EE_
x-ms-office365-filtering-correlation-id: aad9f2db-cd71-438a-6c12-08dbcf5eabea
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n/jdVAYxV/Wl/U91F8FfhxMAH5/F2DvuwyKYqlgwY/GSNjM8xfeXiiSwYXc/ht2Ak/AYRn9tFdDIPUn4Wl4jyB9pNTjC8I0hLdydkqLgXUgBCwrA2OGppOLLU4jvKLdWGOwWGWqZ44JxM3rQCI+4DHaFw+jLjGRz6oUE1GFzQIDNEQ+KeAkq1xR8dFyvxh1mBt5YZ4wZNUMzxWLWONw7qEdR0jqBPUCJyVjkSru6RRwYLwjaRR3Dh2CJ1+OKbUD2w5lCKxSNyiZ0N/eF4B0paLMNtBZquHx1q9sz9VzmsrHbJk0ZNTmYp1byyKbf1nyTqHln7ROoKktFQdAcDKMUZyvjhay2kpnEOrsAgcRFx3qTEeIkhVjmQWHEVhPvB50yBI6sNdYipkdWRHcIj2TB00GT17Fz8UmjULRs9wFPmVGGQPtlQrPm4ufnj7n/7XRP3o0KSIjwE7/UyiVFc1g3lcNOd3wHGJQYOSVlM8Y2Y7H7HpgXeiXW8wo46XqS8xMp5ryZSwa8NMvODE/Gq+Ke9WkU8ritHCVIJ4aTVCY4KCrmT+Xm/xNXkCfHvywSjnOXi9/i0KUIFnpUM9ajUfzkkB2IwiIJ9ugXwyVpK1/Z4yCI5aQ5ESrMFkeHbFbCfJS0jF1quXwUc1XxOm2Bg3b93A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(2906002)(6512007)(9686003)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(54906003)(64756008)(6916009)(66446008)(66556008)(91956017)(76116006)(66476007)(66946007)(6486002)(478600001)(38100700002)(6506007)(53546011)(83380400001)(33656002)(86362001)(36756003)(38070700005)(122000001)(71200400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YjdEMHJUWnFkMmRDT1JYdUs2bW01dnp4UlJQRFZHY09sNUdqakw4NzJnTnJx?=
 =?utf-8?B?SkxYeTdMYmxndWUxaEFsQzVGbVdPWUZIckNSMWx6cmQ0VjE3MjFjQzhkTmw5?=
 =?utf-8?B?aHhLdEN2R1NSVkNCZmloeVI2VnBHbEltWWtvR29PODdIaGx5UTZqekxrYU8y?=
 =?utf-8?B?d1RsVWxYM2RlbkgrOVhKWXVXRVpmSEdwRWlaUGk1RmFaQVJqWnQ5Z0cxTUVB?=
 =?utf-8?B?TnR5Nmt4RlUySWg5Sk55dEFmZDNFNGdTVXVua0JHMTZiMUxmKzdPTnpzVmkr?=
 =?utf-8?B?SjhRMnBMd2g3bEZ1ZzFSSllOcy9MRG5zSEFqQURodlhCV3B3VHNSUG9HNWZI?=
 =?utf-8?B?aGlHZFNGdE1nSzVmUmZLdmhjSGlLUlgrOXFST25HNGtrTHBCTGJUQ01kUk1z?=
 =?utf-8?B?UEtUaDNaTUNxUHpCb0xPVGE0Q2hSeUxIeUZtV1phT09iczVBeE5JZkZDVisy?=
 =?utf-8?B?TVNHTWl1TXBwaEdIenFxQ3RhVHI3d2VhVURzdGF6a2JsQlMyazBTek1MU2xv?=
 =?utf-8?B?bjBYZHE2UDEySmU4a2puRW16aFd1dEVaUFppVW84dFlIaHdEbUx3YVZDTUk3?=
 =?utf-8?B?UXdaWnN3QjhLYytqSVN4cytXNUF6SHo3R0gvamJsT01jdnZ6YXZCSEtJT3Uz?=
 =?utf-8?B?NVErUm83a0FRQlY4aFFFQUo2UW9qZDRYZ1RDMHlOR3pnTlprMFFRR1FRQ0p1?=
 =?utf-8?B?SlhFakQvL2dhdnB2RmdnNUY0OC9VbHBjNmF5RjArdzVsSTF4MDBhS0YvcVJi?=
 =?utf-8?B?eTl3MGMrTGdZczdDd3VlVXRhQ1pHTlU0RmR0cVlHRUcyd1dURkdPSk5kb1pD?=
 =?utf-8?B?S3h1OWNibmFIMWFQdTYzQkVOblhzbHUwa00xNnRKR0VyaitsUEk1bXNBcjFG?=
 =?utf-8?B?N3d2VXA2ZVVrd3k5dkY3MEI1bEM1T1FaUWl0cU4rcVpaN21hamJ3WExvSXJv?=
 =?utf-8?B?ZVRwS0hTUzVkWkFKOE9wclZOMCtQcU1WVGIzWUFPdEtjWm5xaHVKb0tGT1pS?=
 =?utf-8?B?ZzIzbmVIVVhaNnc1ekJWTmhsSG5SSXBrdnlzbFFRdDNUWXE2YUJCbk5kRjdm?=
 =?utf-8?B?TTJGL0xveXI5TU9FRzJ4NVljNmJUamxTVHhRYU5rOUZManJDZm1paDZKQTk2?=
 =?utf-8?B?a1pWMXBzdURTT1VIR285RC9iM01FaVlMZkVrY2dBcWExV2w1eDQwemFIb2Ns?=
 =?utf-8?B?NGhPY01zUmZjNkhlU2hzbVE5OEw2UlZIbzdEalpaYmdxTmhuZnQwOGJqdkZu?=
 =?utf-8?B?WFdzNE9vd1hTRXVkM2VxQTZGVDRobWV4R2hYVi9xL3BIbHlRV0phZ1FBVmJq?=
 =?utf-8?B?SEtwZDhIb09DQzF3eEJGYjd1QjJ5UTBDQml4eWJvNWM5a2VOT0JaUklaNG42?=
 =?utf-8?B?VHcwdW5xQjBUSUx5cWZVc2E5SjlqUldPUUZJdEk2LzlDY0hpaVl6cmI2cE1x?=
 =?utf-8?B?NU4yYnY4dWJjR2wyM0xJWVlxQ1pkKzdUTjJVa1RSNmJRVTRhSTFabzY4Q3dp?=
 =?utf-8?B?WGhnU1ladlBINmJZWkhDL1VOUktFaWYvTVJxZyt6dHdxSmpDeFVtdlBHckVV?=
 =?utf-8?B?UWQvbzBtd0N4Y001MFV5WERCcmNwZ1FvM1JyaGZKU0dCZDJpaGx4amFmaTJu?=
 =?utf-8?B?enhYUm9UVWFyS0wwdkpPWFp3MHBQR0phcmhESzlOSHlmNVlLSXpCb0NOUllY?=
 =?utf-8?B?LzVXSXFkNEFySGtqbmplU3ZHWndmZ2dNNVNrRzFQakM2QjRxYjIzYksxMXEz?=
 =?utf-8?B?ZWdqU3VWZDVwMGFkVmt0aC9ERWJqUENJRXVRNVhZOHFpWW4veTNPWHY1dGtM?=
 =?utf-8?B?N1dFakRlZzAyU3IyUTVjVHNRd3BGVkZkSmVSZElyalUzMGFDK3hseXppbUM0?=
 =?utf-8?B?MkdiUnNWNmRqbzFjdkpqL0d1OHUzUzNYU2V4V3JZcncxYmFoSStuVCt4TnlO?=
 =?utf-8?B?SUV0WkpETkhOdy9ydzBaRUNVQ2tlNW5QeXZCUUNXbmRvUTV4ZDNoQUQwN05F?=
 =?utf-8?B?N3dRL3JXZlJWd0JTNVZYR05LeSt1SUVmRlpTVG5YOFBBQUpZZzhqNDIvWU1S?=
 =?utf-8?B?TVcxMWpPVHNZWnRXV1V0OHN6R3hYZ0liWmdXS2tIaUd4V1dOMjVEYXlkbEZq?=
 =?utf-8?B?cGJ2S3BYYUVQSUQxNElxZU9PZ0x0Q01ZRUdDcTd0VnRqTWM3Nk5tWEs4ODJu?=
 =?utf-8?Q?yKFECjkeAAHtzx6WZR0lxXg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5EF71B42F404D41A11229E0B1A580C2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad9f2db-cd71-438a-6c12-08dbcf5eabea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 22:16:12.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daxt/CXGkHae3Pc09NgVdJ3pmc7NESIdjmywV7aTxJbNdDHfU5oNvjbVOMnfqJQu8Rxnl6fM2YkkVpmrxIBaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5674
X-Proofpoint-GUID: n715h5LOf541ukS2Jjtrg0YEsUkyypP_
X-Proofpoint-ORIG-GUID: n715h5LOf541ukS2Jjtrg0YEsUkyypP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAyOjUy4oCvUE0sIEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAxNywgMjAy
MyBhdCAxOjMx4oCvUE0gU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMTcsIDIwMjMsIGF0IDExOjU44oCvQU0sIEFuZHJp
aSBOYWtyeWlrbyA8YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMTE6MjnigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFRoaXMga2Z1bmMgY2FuIGJlIHVzZWQgdG8gcmVhZCB4
YXR0ciBvZiBhIGZpbGUuDQo+Pj4+IA0KPj4+PiBTaW5jZSB2ZnNfZ2V0eGF0dHIoKSByZXF1aXJl
cyBudWxsLXRlcm1pbmF0ZWQgc3RyaW5nIGFzIGlucHV0ICJuYW1lIiwgYSBuZXcNCj4+Pj4gaGVs
cGVyIGJwZl9keW5wdHJfaXNfc3RyaW5nKCkgaXMgYWRkZWQgdG8gY2hlY2sgdGhlIGlucHV0IGJl
Zm9yZSBjYWxsaW5nDQo+Pj4+IHZmc19nZXR4YXR0cigpLg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+IGluY2x1ZGUv
bGludXgvYnBmLmggICAgICB8IDEyICsrKysrKysrKysrDQo+Pj4+IGtlcm5lbC90cmFjZS9icGZf
dHJhY2UuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
Pj4gMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+Pj4+IA0KPj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4gaW5k
ZXggNjFiZGU0NTIwZjVjLi5mMTRmYWU0NWUxM2QgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvYnBmLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPj4+PiBAQCAtMjQ3
Miw2ICsyNDcyLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBoYXNfY3VycmVudF9icGZfY3R4KHZv
aWQpDQo+Pj4+ICAgICAgIHJldHVybiAhIWN1cnJlbnQtPmJwZl9jdHg7DQo+Pj4+IH0NCj4+Pj4g
DQo+Pj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgYnBmX2R5bnB0cl9pc19zdHJpbmcoc3RydWN0IGJw
Zl9keW5wdHJfa2VybiAqcHRyKQ0KPj4+IA0KPj4+IGlzX3plcm9fdGVybWluYXRlZCB3b3VsZCBi
ZSBtb3JlIGFjY3VyYXRlPyB0aG91Z2ggdGhlcmUgaXMgbm90aGluZw0KPj4+IHJlYWxseSBkeW5w
dHItc3BlY2lmaWMgaGVyZS4uLg0KPj4gDQo+PiBpc196ZXJvX3Rlcm1pbmF0ZWQgc291bmRzIGJl
dHRlci4NCj4+IA0KPj4+IA0KPj4+PiArew0KPj4+PiArICAgICAgIGNoYXIgKnN0ciA9IHB0ci0+
ZGF0YTsNCj4+Pj4gKw0KPj4+PiArICAgICAgIHJldHVybiBzdHJbX19icGZfZHlucHRyX3NpemUo
cHRyKSAtIDFdID09ICdcMCc7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gdm9pZCBub3RyYWNlIGJw
Zl9wcm9nX2luY19taXNzZXNfY291bnRlcihzdHJ1Y3QgYnBmX3Byb2cgKnByb2cpOw0KPj4+PiAN
Cj4+Pj4gdm9pZCBicGZfZHlucHRyX2luaXQoc3RydWN0IGJwZl9keW5wdHJfa2VybiAqcHRyLCB2
b2lkICpkYXRhLA0KPj4+PiBAQCAtMjcwOCw2ICsyNzE1LDExIEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBoYXNfY3VycmVudF9icGZfY3R4KHZvaWQpDQo+Pj4+ICAgICAgIHJldHVybiBmYWxzZTsNCj4+
Pj4gfQ0KPj4+PiANCj4+Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBicGZfZHlucHRyX2lzX3N0cmlu
ZyhzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICpwdHIpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgICAgcmV0
dXJuIGZhbHNlOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+IHN0YXRpYyBpbmxpbmUgdm9pZCBicGZf
cHJvZ19pbmNfbWlzc2VzX2NvdW50ZXIoc3RydWN0IGJwZl9wcm9nICpwcm9nKQ0KPj4+PiB7DQo+
Pj4+IH0NCj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYyBiL2tlcm5l
bC90cmFjZS9icGZfdHJhY2UuYw0KPj4+PiBpbmRleCBkZjY5N2M3NGQ1MTkuLjk0NjI2ODU3NGUw
NSAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jDQo+Pj4+ICsrKyBi
L2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPj4+PiBAQCAtMjQsNiArMjQsNyBAQA0KPj4+PiAj
aW5jbHVkZSA8bGludXgva2V5Lmg+DQo+Pj4+ICNpbmNsdWRlIDxsaW51eC92ZXJpZmljYXRpb24u
aD4NCj4+Pj4gI2luY2x1ZGUgPGxpbnV4L25hbWVpLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgv
ZmlsZWF0dHIuaD4NCj4+Pj4gDQo+Pj4+ICNpbmNsdWRlIDxuZXQvYnBmX3NrX3N0b3JhZ2UuaD4N
Cj4+Pj4gDQo+Pj4+IEBAIC0xNDI5LDYgKzE0MzAsNDkgQEAgc3RhdGljIGludCBfX2luaXQgYnBm
X2tleV9zaWdfa2Z1bmNzX2luaXQodm9pZCkNCj4+Pj4gbGF0ZV9pbml0Y2FsbChicGZfa2V5X3Np
Z19rZnVuY3NfaW5pdCk7DQo+Pj4+ICNlbmRpZiAvKiBDT05GSUdfS0VZUyAqLw0KPj4+PiANCj4+
Pj4gKy8qIGZpbGVzeXN0ZW0ga2Z1bmNzICovDQo+Pj4+ICtfX2RpYWdfcHVzaCgpOw0KPj4+PiAr
X19kaWFnX2lnbm9yZV9hbGwoIi1XbWlzc2luZy1wcm90b3R5cGVzIiwNCj4+Pj4gKyAgICAgICAg
ICAgICAgICAgImtmdW5jcyB3aGljaCB3aWxsIGJlIHVzZWQgaW4gQlBGIHByb2dyYW1zIik7DQo+
Pj4+ICsNCj4+Pj4gKy8qKg0KPj4+PiArICogYnBmX2dldF9maWxlX3hhdHRyIC0gZ2V0IHhhdHRy
IG9mIGEgZmlsZQ0KPj4+PiArICogQG5hbWVfcHRyOiBuYW1lIG9mIHRoZSB4YXR0cg0KPj4+PiAr
ICogQHZhbHVlX3B0cjogb3V0cHV0IGJ1ZmZlciBvZiB0aGUgeGF0dHIgdmFsdWUNCj4+Pj4gKyAq
DQo+Pj4+ICsgKiBHZXQgeGF0dHIgKm5hbWVfcHRyKiBvZiAqZmlsZSogYW5kIHN0b3JlIHRoZSBv
dXRwdXQgaW4gKnZhbHVlX3B0ciouDQo+Pj4+ICsgKg0KPj4+PiArICogUmV0dXJuOiAwIG9uIHN1
Y2Nlc3MsIGEgbmVnYXRpdmUgdmFsdWUgb24gZXJyb3IuDQo+Pj4+ICsgKi8NCj4+Pj4gK19fYnBm
X2tmdW5jIGludCBicGZfZ2V0X2ZpbGVfeGF0dHIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBi
cGZfZHlucHRyX2tlcm4gKm5hbWVfcHRyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnZhbHVlX3B0cikNCj4+Pj4gK3sNCj4+
Pj4gKyAgICAgICBpZiAoIWJwZl9keW5wdHJfaXNfc3RyaW5nKG5hbWVfcHRyKSkNCj4+Pj4gKyAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+IA0KPj4+IHNvIGR5bnB0ciBjYW4gYmUg
aW52YWxpZCBhbmQgbmFtZV9wdHItPmRhdGEgd2lsbCBiZSBOVUxMLCB5b3Ugc2hvdWxkDQo+Pj4g
YWNjb3VudCBmb3IgdGhhdA0KPj4gDQo+PiBXZSBjYW4gYWRkIGEgTlVMTCBjaGVjayAob3Igc2l6
ZSBjaGVjaykgaGVyZS4NCj4gDQo+IHRoZXJlIG11c3QgYmUgc29tZSBoZWxwZXIgdG8gY2hlY2sg
aWYgZHlucHRyIGlzIHZhbGlkLCBsZXQncyB1c2UgdGhhdA0KPiBpbnN0ZWFkIG9mIE5VTEwgY2hl
Y2tzDQoNClllYWgsIHdlIGNhbiB1c2UgYnBmX2R5bnB0cl9pc19udWxsKCkuIA0KDQo+IA0KPj4g
DQo+Pj4gDQo+Pj4gYW5kIHRoZXJlIGNvdWxkIGFsc28gYmUgc3BlY2lhbCBkeW5wdHJzIHRoYXQg
ZG9uJ3QgaGF2ZSBjb250aWd1b3VzDQo+Pj4gbWVtb3J5IHJlZ2lvbiwgc28gc29tZWhvdyB5b3Un
ZCBuZWVkIHRvIHRha2UgY2FyZSBvZiB0aGF0IGFzIHdlbGwNCj4+IA0KPj4gV2UgY2FuIHJlcXVp
cmUgdGhlIGR5bnB0ciB0byBiZSBCUEZfRFlOUFRSX1RZUEVfTE9DQUwuIEkgZG9uJ3QgdGhpbmsN
Cj4+IHdlIG5lZWQgdGhpcyBmb3IgZHlucHRyIG9mIHNrYiBvciB4ZHAuIFdvdWxkIHRoaXMgYmUg
c3VmZmljaWVudD8NCj4gDQo+IHdlbGwsIHRvIGtlZXAgdGhpbmcgc2ltcGxlIHdlIGNhbiBoYXZl
IGEgc2ltcGxlIGludGVybmFsIGhlbHBlciBBUEkNCj4gdGhhdCB3aWxsIHRlbGwgaWYgaXQncyBz
YWZlIHRvIGFzc3VtZSB0aGF0IGR5bnB0ciBtZW1vcnkgaXMgY29udGlndW91cw0KPiBhbmQgaXQn
cyBvayB0byB1c2UgZHlucHRyIG1lbW9yeS4gQnV0IHN0aWxsLCB5b3Ugc2hvdWxkbid0IGFjY2Vz
cyBkYXRhDQo+IHBvaW50ZXIgZGlyZWN0bHksIHRoZXJlIG11c3QgYmUgc29tZSBoZWxwZXIgZm9y
IHRoYXQuIFBsZWFzZSBjaGVjay4gSXQNCj4gaGFzIHRvIHRha2UgaW50byBhY2NvdW50IG9mZnNl
dCBhbmQgc3R1ZmYgbGlrZSB0aGF0Lg0KDQpZZWFoLCB3ZSBjYW4gdXNlIGJwZl9keW5wdHJfd3Jp
dGUoKSwgd2hpY2ggaXMgYSBoZWxwZXIgKG5vdCBrZnVuYykuIA0KDQo+IA0KPiBBbHNvLCBhbmQg
c2VwYXJhdGVseSBmcm9tIHRoYXQsIHdlIHNob3VsZCB0aGluayBhYm91dCBwcm92aWRpbmcgYQ0K
PiBicGZfZHlucHRyX3NsaWNlKCktbGlrZSBoZWxwZXIgdGhhdCB3aWxsIGFjY2VwdCBhIGZpeGVk
LXNpemVkDQo+IHRlbXBvcmFyeSBidWZmZXIgYW5kIHJldHVybiBwb2ludGVyIHRvIGVpdGhlciBh
Y3R1YWwgbWVtb3J5IG9yIGNvcHkNCj4gbm9uLWNvbnRpZ3VvdXMgbWVtb3J5IGludG8gdGhhdCBi
dWZmZXIuIFRoYXQgd2lsbCBtYWtlIHN1cmUgeW91IGNhbg0KPiB1c2UgYW55IGR5bnB0ciBhcyBh
IHNvdXJjZSBvZiBkYXRhLCBhbmQgb25seSBwYXkgdGhlIHByaWNlIG9mIG1lbW9yeQ0KPiBjb3B5
IGluIHJhcmUgY2FzZXMgd2hlcmUgaXQncyBuZWNlc3NhcnkNCg0KSSBkb24ndCBxdWl0ZSBmb2xs
b3cgaGVyZS4gQ3VycmVudGx5LCB3ZSBoYXZlIA0KDQpicGZfZHlucHRyX2RhdGEoKQ0KYnBmX2R5
bnB0cl9zbGljZSgpDQpicGZfZHlucHRyX3NsaWNlX3Jkd3IoKQ0KYnBmX2R5bnB0cl93cml0ZSgp
DQoNCkFGQUlDVCwgdGhleSBhcmUgc3VmZmljaWVudCB0byBjb3ZlciBleGlzdGluZyB1c2UgY2Fz
ZXMgKGFuZCB0aGUgbmV3IA0KdXNlIGNhc2Ugd2UgYXJlIGFkZGluZyBpbiB0aGlzIHNldCkuIFdo
YXQncyB0aGUgbmV3IGtmdW5jIGFyZSB5b3UNCnRoaW5raW5nIGFib3V0Pw0KDQpUaGFua3MsDQpT
b25nDQoNCg0K

