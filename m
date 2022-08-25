Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FC5A057F
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiHYBH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYBH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 21:07:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40166170A
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:07:55 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P0j5nR021510
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:07:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=E38Ou318hUJ+JzdvRETcrvoY7+fYr8e9OZrV/EYSCgY=;
 b=Y+Eun88lWTL3G8KCCd8TzTZL0hJd2BCHsb5DLMJc5IBicXhIVaLRgPn2P8lMNBhKacWd
 jsLaq7Z0DlqQraT6N9vVCigFeG2q6+7LGpA5HGVBTiG12GmQ3vOKRYIUPQMF0CeIZCnL
 DvsTn5x1xYP5mC+1qmSYqzMfTz3ysbno/+o= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bejyc54-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnua5geddBFPGkjJfbLbiSsnxGUbFuQvTyepfl+8J5UVaw4tibkzL1J+ttH96ji+fVjQHoBH7wHIsQ33HJnn4bzZLUEf5W+9/FJWM3C6SofMxKS70PLf/UL7TaArrm2Y9ERpc2AvJn8p5VBkooCX6QyteDQXcDBs2wAK3xgIppPGO/XvOqlBcF6WyhkIm49lfRc2a/u6QcIXrN1/bHQrowgopuBY8kbFc3V1QXMUW2cmmpQr4zb8RGk2mFI8YDcyC5kvHPS3XHxjuJD4mQawlllMb5zZPxFEYTSgoHtW7vs5XfOXa9JcMXOaWDB5MSzNQl5v3kIWUJvimwzBB/OYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E38Ou318hUJ+JzdvRETcrvoY7+fYr8e9OZrV/EYSCgY=;
 b=ZePJ021KAN/9kjhNqijqkiK561x12PwCG8smCAWUsZbxalkq4/E1p2p1D7Qo4ZOVbMdOzovVB2U43zagVGWk1xJXiQPK5xeMB+lBhVSAU4GYNOxe7auPjvgF4tKp31g1yUPXHC7SF8fNfCRBEVU31SxW6X0EfXJqjoeJkhkdFDxRLG4cAI3afbqCcl++n5T/6BoSr7WlXZRnpCvyY/TdhxdKdIJYtontQO0FdOxpdQN12dL7eoxyNOXMQIil0joueAS28IOXZef7uhRV3L1Qf7sX5AqtcnK3m4tXe1VdL51cCV6CbmA0v1QeG31hu1PjurlexzN7oc0vZ99WyUWhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BN6PR15MB1876.namprd15.prod.outlook.com (2603:10b6:405:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Thu, 25 Aug
 2022 01:07:50 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 01:07:50 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Test parameterized task
 BPF iterators.
Thread-Topic: [PATCH bpf-next v6 4/4] selftests/bpf: Test parameterized task
 BPF iterators.
Thread-Index: AQHYtBhmeWddHZqMxUOlFg4G1YvjbK2+qhQAgAAr6oA=
Date:   Thu, 25 Aug 2022 01:07:50 +0000
Message-ID: <3820d849c31c95563310f4d1130c6bc1c2b7f756.camel@fb.com>
References: <20220819220927.3409575-1-kuifeng@fb.com>
         <20220819220927.3409575-5-kuifeng@fb.com>
         <CAEf4BzYpnp3sYxWe4XWeJZPqi3+NgH4NMqa7X9kbE9y4trs5KQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYpnp3sYxWe4XWeJZPqi3+NgH4NMqa7X9kbE9y4trs5KQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d63c6b3-08e5-4797-f5a0-08da86363b40
x-ms-traffictypediagnostic: BN6PR15MB1876:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spjxk9OwCmYybeLnR7VkXp5XyLb16l0vCJQM6MP2f6XXkbKUkf+22+j+ZG7+mSmxP0lFp38VpzNa/S8J1Cr+3c+pu7s1xHrbpdQ0BlnP0neYbMZvfcd4oLprz6Heu+IOt0sbw0Vdbt3nbrgXE5rQlM2FaMfHbqKcEJRMnh+pGXPN+QTE43uLf3KqlyLmGi+RAsQaNiYu0w66vg38Oo0ut//Ft7dQZ8KDLWTzxwqnygdkeE5TsQuLs/BEQeMj4rLEvVt3CucPtaAPANjUk6BgiKsJeB6hDjt3wFEaN5l/uFusJK5riNAEU83eqjGIZdiqp4qCzntd4HNMQ8JrjMAp8E+AfMTnZXiMzEzk9i5IjItHI6JqsQERG7HjehY4PXnG3dTppZxon3iM7LECqcYDk+HFkXga6r5914U+el/SBpq5QH9pQZJ8ll4ifJ9vCUFIbMOnP0SLCgb3GgALTiNBamuy7e++gtdOxJOviairOmiWUPuiZd02HxknGhVOieylppiRDMZhBoswv6rLuMxUGtMTxodI5r/H+kfuQgsrmK4cBYaTCgdiral3DGR+eK+jXQwdZe5WVxv3kfwfBYMPtNbMyAXNzlbSclLSLVlLz4zFcILaZ2TzrtmE5liRv9h2/NPnM/FYChjZSY0Y73AJZ3GYG04MQZWUGEliR8kjtGBI21ozaMcv3sRrVAJtZM4ZuqgvgqUA7C/rmn81uoBDQ63WjCcd7tQz4rPsD4O0k+x3Ma9ohh20jiLESWWhp25rsFuXaaM/YiyGvup1/5h+sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(38070700005)(2906002)(8936002)(122000001)(6506007)(26005)(6512007)(53546011)(86362001)(316002)(5660300002)(36756003)(6916009)(66946007)(478600001)(76116006)(4326008)(186003)(38100700002)(2616005)(71200400001)(41300700001)(64756008)(54906003)(66556008)(6486002)(66476007)(8676002)(66446008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5MR0REaC9QNHJwcFQ0blF2T01YS0o4eTVLQWFJclFvMEVsWXRXdzd0UGNS?=
 =?utf-8?B?T2FpSVgyakV3NzhmaGcyQW1GS3JNM3BDYmt4NmFwa1dlZFRIdnVpcWxaMDI3?=
 =?utf-8?B?bkMvOGVQYzdiZGpJeHQwcW9jbldTejJCUlV1TStRaVRkMHpLTGIvRmIvNWpM?=
 =?utf-8?B?alp3RGE1RmtkQnNmb1BkVHl5emxDdHNzR09waDJIK0pmL3JGY0xnS3NnOUpG?=
 =?utf-8?B?U0lQQVhxYkkvNDVCa090aERpYUJrUHlSR3hFSTEzeXEwTENhY1ZLK3BtUkty?=
 =?utf-8?B?Y2dVWEFNUXJaZVdwanpDTFVpakRJMGluTFlKSGtmZjBzOXBpOEtaZEZCR09L?=
 =?utf-8?B?bkJrd2xod1E2YTVBelgyTlVoUzlBV1lFZTJLNFNlZ0JmN3J0b2VTZmJoeWpo?=
 =?utf-8?B?T3haZkE0OWJianZBMThYUTJldkNyOGcrSmZGUWRZYVR2OU1ic282Unp4RHRN?=
 =?utf-8?B?bnFLTERBanRDQXMvZzg2TjZOUWw0UTZpR1R2QXJnMmRGSENLSlRpR1dJQ3Jt?=
 =?utf-8?B?TUEwTUIzWENHUmRacmxlMEN2anhheUJGYUVXeHFyV0VNQ2Jjd0RMYWdTZGtI?=
 =?utf-8?B?WVl6MkJxbVIycEhBTzB5Q0R3bTd1bkQvYmU2K1lzYlV0THdTaldJYkdPSkZv?=
 =?utf-8?B?MFR1dVF2eEdFbkpnWHA3eXBBNmlsUGw3RWxWNDE5MW9qNCtBVG8zQWZNQW5T?=
 =?utf-8?B?ZlBpMXBVK0x6K2Rhai9YbEtqVUlOZ0dlbzJNRHN3NzEyTDV3SmthcTRGV2tD?=
 =?utf-8?B?L21zVFU2NGNoTFNKQzZwSlFhNjNJc1FHNGl6dmlyZXBHcVMwTEcxcC9tN3hT?=
 =?utf-8?B?d3BiWjhoQU1qSURBdFFFdSttVmpZRnZweFZrUzRnTDlXVHhoRkxYdWFzNWcw?=
 =?utf-8?B?V1llempxRXBDWVhvdENBK0FUQjVSWTQ5SkUvWHAyOFhnaFNJWi9aTUYvNXlU?=
 =?utf-8?B?a3l3cVlJdXhDYmR0SEVkYVBoVWZPSmlIYXFjV2V2WVBwNWFuaXFJTGlRTEd0?=
 =?utf-8?B?VUg3c01qQjY1dXZvZXpHVzVVT3BsdnRET1lDWlpQb3V4RFJ4ZUF0MEtYNUFw?=
 =?utf-8?B?LzBWZHRrOXAwMDhzNDZNNDV5QnVGeHh5UHQ3SzV3aUhEdmlvMVRjZFM2QWJL?=
 =?utf-8?B?ejJ5OWRUQWc0WDk4VWpGWGdWYy9Pa1l4dU9jZHV6YjJmZnQrNVdGRURRQzRT?=
 =?utf-8?B?SGdCWkhxN3JxR1JyT0phZ1B6QXBXUllCNXFUSmZCRmVoclB5Q2laYkt2LzRE?=
 =?utf-8?B?UkhnMjZyUVVuaUczNW03WHJLSmRyWmlLbVlJdEVJcWx5eEdqTWZ0U2RSM2Q4?=
 =?utf-8?B?U3JMSCtqa1V5d1ZSOVI2VmdWV1QwNUx5RElaaDl2bWoxNkwyK1ZnWEpOUkx2?=
 =?utf-8?B?U0JDbUw4QzN1KytkSnpzWVdrYWRGZDhoNGlSMTNNWGJ6WFZYT3VYTmptU3Bq?=
 =?utf-8?B?eUVLam1XeDVZeWJRY1h0N3hWVmViUUU2WEdvb2ticC91TXVMSzV1bmlHSkJF?=
 =?utf-8?B?K3dUekNtZ2NhSWx5SjB5R0JCU296TmVpY1pON3BrMXZxcjBMOTZSTjArKzAz?=
 =?utf-8?B?SUVLVFh2ajZDWHRqU1ZEdWVzMUx0NGlmQlYwRER1VGZKRXZqY0pHQTMzZlMx?=
 =?utf-8?B?UjhBRHNiV21lUHNSSzJKODJSMXJWRmR6NHlhUDZ4WjEvTWNVclNnVVF1ZEt4?=
 =?utf-8?B?Qk5yTnk5TDF6R240dyswSVpZcm56bS9odXFxaldkWFhxSjNaS1lCeDFkWDlz?=
 =?utf-8?B?VVdqUnVaK3Yvd1pJbDFHdlpuYTJlclRmZ1E2WVIwWFVnamxMWEJaeFMreFhz?=
 =?utf-8?B?MUVRK29pdkZyZi8yVkhMSkttUitnMVRRTmUvOWgvWWF4eEJpcFFKK0VIV0pa?=
 =?utf-8?B?UzhDVmRKQzhiZWlMbUVvU1BtMWVMcDZudmVmcWRZMWFjSGg2SWhCSUNzZ3lk?=
 =?utf-8?B?K0doS3hMek1kODhTWWIraFcwYm42NHMyV0NsRjRjZzE1MTE2WGxvZFhDWjRa?=
 =?utf-8?B?c1Y0eGNOaXFEazh6Y3NVcml2TGNndi9sTGVpdW11RjUxNW9jSVBCU210djBL?=
 =?utf-8?B?UVdweU5vMDBwcjBGVUJzS2s1ZDJ0cWdCSjh6eGtFS20wTGZneENieXQ2QXY1?=
 =?utf-8?Q?6qsyYfoqOKzh2U8Z8q7mqlahj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <705908C7A8B64D43B77746A2D73FA023@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d63c6b3-08e5-4797-f5a0-08da86363b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 01:07:50.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paRIHZirMc2M4n3pZBqNBxB1GVNg2Dwoof65yyFTqolkzKVSPNUDXEMPGr2di+U4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1876
X-Proofpoint-ORIG-GUID: FszQy65XMSHXEIZjfZNt-glHVp7y4LoJ
X-Proofpoint-GUID: FszQy65XMSHXEIZjfZNt-glHVp7y4LoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE1OjMwIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDE5LCAyMDIyIGF0IDM6MDkgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVGVzdCBpdGVyYXRvcnMgb2Ygdm1hLCBmaWxlcywg
YW5kIHRhc2tzIG9mIHRhc2tzLg0KPiA+IA0KPiA+IEVuc3VyZSB0aGUgQVBJIHdvcmtzIGFwcHJv
cHJpYXRlbHkgdG8gdmlzaXQgYWxsIHRhc2tzLA0KPiA+IHRhc2tzIGluIGEgcHJvY2Vzcywgb3Ig
YSBwYXJ0aWN1bGFyIHRhc2suDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVl
IDxrdWlmZW5nQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2df
dGVzdHMvYnBmX2l0ZXIuY8KgwqDCoMKgwqDCoCB8IDI4NA0KPiA+ICsrKysrKysrKysrKysrKysr
LQ0KPiA+IMKgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9idGZfZHVtcC5jwqDCoMKgwqDC
oMKgIHzCoMKgIDIgKy0NCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Rh
c2suY8KgwqDCoMKgwqDCoCB8wqDCoCA5ICsNCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dz
L2JwZl9pdGVyX3Rhc2tfZmlsZS5jwqAgfMKgwqAgOSArLQ0KPiA+IMKgLi4uL3NlbGZ0ZXN0cy9i
cGYvcHJvZ3MvYnBmX2l0ZXJfdGFza192bWEuY8KgwqAgfMKgwqAgNiArLQ0KPiA+IMKgLi4uL2Jw
Zi9wcm9ncy9icGZfaXRlcl91cHJvYmVfb2Zmc2V0LmPCoMKgwqDCoMKgwqDCoCB8wqAgMzUgKysr
DQo+ID4gwqA2IGZpbGVzIGNoYW5nZWQsIDMyNiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9ncy9icGZfaXRlcl91cHJvYmVfb2Zmc2V0LmMNCj4gDQpbLi4uXQ0KPiA+ICsNCj4g
PiDCoHZvaWQgdGVzdF9icGZfaXRlcih2b2lkKQ0KPiA+IMKgew0KPiA+ICvCoMKgwqDCoMKgwqAg
aWYgKCFBU1NFUlRfT0socHRocmVhZF9tdXRleF9pbml0KCZkb19ub3RoaW5nX211dGV4LCBOVUxM
KSwNCj4gPiAicHRocmVhZF9tdXRleF9pbml0IikpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOw0KPiA+ICsNCj4gDQo+IGRpdHRvLCB0b28gcGFyYW5vaWQsIElNTw0K
DQpSaWdodCwgZm9yIHRlc3QgY2FzZXMsIHdlIGNhbiBlYXNlIGNoZWNrcy4NCkkgd291bGQgbGlr
ZSB0byBoYXZlIHNvbWV0aGluZyBsaWtlDQoNCiAgICBJTkZBTExJQkxFKHB0aHJlYWRfbXV0ZXhf
aW5pdCguLi4uLi4pLi4uKTsNCg0KSXQgd2lsbCBjcmFzaCBhdCB0aGUgZmlyc3QgcG9pbnQuDQoN
Cj4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHRlc3RfX3N0YXJ0X3N1YnRlc3QoImJ0Zl9pZF9v
cl9udWxsIikpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3RfYnRmX2lk
X29yX251bGwoKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAodGVzdF9fc3RhcnRfc3VidGVzdCgi
aXB2Nl9yb3V0ZSIpKQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Vwcm9iZV9vZmZzZXQuYw0K
PiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Vwcm9iZV9v
ZmZzZXQuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li44MjVjYTg2Njc4YmQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3Vwcm9iZV9vZmZzZXQuYw0KPiA+IEBAIC0w
LDAgKzEsMzUgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
PiArLyogQ29weXJpZ2h0IChjKSAyMDIyIE1ldGEgUGxhdGZvcm1zLCBJbmMuIGFuZCBhZmZpbGlh
dGVzLiAqLw0KPiA+ICsjaW5jbHVkZSAiYnBmX2l0ZXIuaCINCj4gPiArI2luY2x1ZGUgPGJwZi9i
cGZfaGVscGVycy5oPg0KPiA+ICsNCj4gPiArY2hhciBfbGljZW5zZVtdIFNFQygibGljZW5zZSIp
ID0gIkdQTCI7DQo+ID4gKw0KPiA+ICtfX3UzMiB1bmlxdWVfdGdpZF9jbnQgPSAwOw0KPiA+ICt1
aW50cHRyX3QgYWRkcmVzcyA9IDA7DQo+ID4gK3VpbnRwdHJfdCBvZmZzZXQgPSAwOw0KPiA+ICtf
X3UzMiBsYXN0X3RnaWQgPSAwOw0KPiA+ICtfX3UzMiBwaWQgPSAwOw0KPiA+ICsNCj4gPiArU0VD
KCJpdGVyL3Rhc2tfdm1hIikgaW50IGdldF91cHJvYmVfb2Zmc2V0KHN0cnVjdA0KPiA+IGJwZl9p
dGVyX190YXNrX3ZtYSAqY3R4KQ0KPiANCj4gcGxlYXNlIGtlZXAgU0VDKCkgb24gc2VwYXJhdGUg
bGluZQ0KPiANCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEgPSBjdHgtPnZtYTsNCj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzZXFfZmlsZSAqc2Vx
ID0gY3R4LT5tZXRhLT5zZXE7DQo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRhc2sgPSBjdHgtPnRhc2s7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHRhc2sgPT0g
TlVMTCB8fCB2bWEgPT0gTlVMTCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAobGFzdF90Z2lkICE9IHRhc2st
PnRnaWQpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5pcXVlX3RnaWRfY250
Kys7DQo+ID4gK8KgwqDCoMKgwqDCoCBsYXN0X3RnaWQgPSB0YXNrLT50Z2lkOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgIGlmICh0YXNrLT50Z2lkICE9IHBpZCkNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAo
dm1hLT52bV9zdGFydCA8PSBhZGRyZXNzICYmIHZtYS0+dm1fZW5kID4gYWRkcmVzcykgew0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldCA9IGFkZHJlc3MgLSB2bWEtPnZt
X3N0YXJ0ICsgKHZtYS0+dm1fcGdvZmYNCj4gPiA8PCAxMik7DQo+IA0KPiBpdCdzIGJlc3Qgbm90
IHRvIGFzc3VtZSBwYWdlX3NpemUgaXMgNEssIHlvdSBjYW4gcGFzcyBhY3R1YWwgdmFsdWUNCj4g
dGhyb3VnaCBnbG9iYWwgdmFyaWFibGUgZnJvbSB1c2VyLXNwYWNlICh3ZSd2ZSBwcmV2aW91c2x5
IGZpeGVkIGENCj4gYnVuY2ggb2YgdGVzdHMgd2l0aCBmaXhlZCBwYWdlX3NpemUgYXNzdW1wdGlv
biBhcyB0aGV5IGJyZWFrIHNvbWUNCj4gcGxhdGZvcm1zLCBsZXQncyBub3QgcmVncmVzcyB0aGF0
KQ0KDQpBIGdldHBhZ2VzaXplKCkgaGVscGVyIHdvdWxkIGhlbHAgOikNCg0KPiANCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCUEZfU0VRX1BSSU5URihzZXEsICJPS1xuIik7DQo+
ID4gK8KgwqDCoMKgwqDCoCB9DQo+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArfQ0K
PiA+IC0tDQo+ID4gMi4zMC4yDQo+ID4gDQoNCg==
