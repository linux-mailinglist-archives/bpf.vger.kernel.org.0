Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46284A01B9
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 21:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiA1UMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 15:12:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28544 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351151AbiA1UMl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jan 2022 15:12:41 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SCm461001769
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 12:12:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HN7tK6m/rorHPCYsVg/wnMFUbXsm+TM0XjL5kRCts2g=;
 b=eguimpqIO66fm4ue8qz4SsL8NKkpP/ycIW7Sj8PzIo147aT9AdSNe9ZT/R4ABP6f6wYY
 cDMGN0BryEAcmmyd/xpRjugeHTlqkBazPsv9S9FxXnqJWPYlhOhk5xpQpK2eXugVJ+fu
 DO5gfA21rFHpq7PIirfC/IsJSRXBE7Kq72I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dvgtd2wt9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 12:12:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 12:12:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZS83HrWdulRwEosI7sD8t3tnrZgNf8OAt6ALfGv20FKOhCN4DvhXwsJrHdU7gIwNV89+vH/BDWo17cCOY6Eo6L0cvacwNI9wR9p26Sad/gMImOnomvlt62LIpCTUmyK2VagNth4/gBt8lGAWZ6x44qMlFaeNJuf0lhSo22UtrSgB41mYr8IGNUSJvwjDaNTM7zsedk4ezo7dBnD3B6xmGzwD/sGjyhSmaiFEzuRYm9bceF2twZoIrdwbc8gemOCmbmTeLbz604gGZIwWiHRcaQp18HUhUWmGeWICMGDBBiY2Saz9/EKv5e6XJXQ4Cws7cBL+eYtptPduLA/cz3XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN7tK6m/rorHPCYsVg/wnMFUbXsm+TM0XjL5kRCts2g=;
 b=mt9dgvzWnrTVSTOB39kicXs87ty6mVaM8IO6hYuljQV/fYexnntXSH3ZrzktBY6FCcpKSlsecFYxZwE2H8qAiZvJD+pWaDwxCZLpmeGMgZkFv29CHL9ad5qJSno1LuvGNXLFDZwaAFfzJ+5ChXPr0p3neTbwURY1Vl2pVMxMq69JpMuqZLxTP8gWoOu97Rmbh6da9siKLW6o5pi6wmeJjb2JVOdHLsLXTk3dC0ZfH0flIphG1Pcq52oIRI1I+LYm/2E194+oOZ97IlVp3OUjDFGj9YB2C+Gq2BUt2dhtOpqjHAgefdtLU4dPDCRpgrnoZdZ5JqMofM4JkS90cX8KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB3912.namprd15.prod.outlook.com (2603:10b6:5:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 20:12:38 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 20:12:38 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] migrate from bpf_prog_test_run{,_xattr}
Thread-Topic: [PATCH bpf-next v2 0/4] migrate from bpf_prog_test_run{,_xattr}
Thread-Index: AQHYE+W17MlYudFR2UWU7BWT2s1omqx4aEuAgAB2soA=
Date:   Fri, 28 Jan 2022 20:12:37 +0000
Message-ID: <6025eb29983a0b7a6d62b845510f9e61480b745d.camel@fb.com>
References: <20220128012319.2494472-1-delyank@fb.com>
         <310cca5f-ecca-5624-e4c2-e2ee79069e0b@iogearbox.net>
In-Reply-To: <310cca5f-ecca-5624-e4c2-e2ee79069e0b@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aad87b6-5e6b-4fb5-b83d-08d9e29a87d4
x-ms-traffictypediagnostic: DM6PR15MB3912:EE_
x-microsoft-antispam-prvs: <DM6PR15MB39128BB887C8E85641BC53C0C1229@DM6PR15MB3912.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8DtOoj0Kcm9QIGQpX7B1tyCGU/n5DW1Rr+qJdt/SYaFmljafv7nFfbj0slUfMZnO+RoFJ/WQlpB+Li23RZx7XT6G5uD334MB1C+JxAYbCG5LDE7LaAMeuXY8HOxWCd53EYrvV3cPjbJaN2G6sSbwyBIsj1vHMQsbyfPgn64RdDj0kPRL//TISXRhoz6BFL9Ui+9aJnCm+SGO9I6oB3jKM0hGaJyXL8Zd/GlvUOWek0Mlc/4eMC80pRmXZZn2YD82WlVwKBfS+j4bTYtjN4vWnqH4YpYUJwj7PYNhs+vQbRuNwCaEbMzuCN+8YxPYG0XifXDTqIjsnXSXmPTMXZuJXFmN5bRyZ3CHRw5Y+xRbbdoNniByAu4KoT04XngbHwYkMBRR198S7jaCg2yejesbpXjOj3BueNhtdsxFkwrIIP2PclP484zSXaNXFvLYNgV9qeiCFPlQUNRs0kfEyhJ9CHyizkxQN2UP7cAZR2xuA7yy4xIjAsoQWnkDTg7/gixE0Ew4T1EOjNGNdiKKhJbQ+TdNjCpQNS3Fqcb4i1DcWMepXI0M8hAJOig0rTuy3zFQocj5NuX9Bd8b88lroGsRfUlP8WEXYxbzYYHD76LqBYgFy6LmqFVMt9FAN/9wXPs62vL1+he0+pmyUEvUJVkLrpp+PzLQRhi7C/j/O6fbmZTQ2S93mTKqKCAqMKXCFN0pK3Y70Yw/Xe5WfaQd8qxrbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(8676002)(76116006)(66946007)(64756008)(38070700005)(4326008)(86362001)(8936002)(53546011)(2906002)(6486002)(38100700002)(66476007)(66556008)(6512007)(66446008)(6506007)(2616005)(83380400001)(91956017)(71200400001)(54906003)(6916009)(316002)(508600001)(5660300002)(36756003)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1dLRDRNZ1lOR25nWW8wbkxLY1MrYlV3TW8yR2h4emM4TEFFK0kzZ1JEcjZj?=
 =?utf-8?B?UkJxb3gwYmtJOFBnNUhGQjdVNGZqbjF6di9uZSsyaU00NzFqc2NwWmVHMlpM?=
 =?utf-8?B?WG5IVWg0NVMxWm1sdWFVeUprZ1VTeWMyK2h6K1Q1MmVVeEVEUzVrQ1pXdXk0?=
 =?utf-8?B?dU90a21lbnRuUUZGbEs3QXRhSnBkSkd6OS9QOEV1VlJLQ1lnTjYvcVM3QjJj?=
 =?utf-8?B?bHA4L21vYU5HdC9oWEllRFBoLzIzaW5mZlYwM05uaXdiWCtzTlhZeW9UMUZn?=
 =?utf-8?B?NmQ4RjhyNXk1TWNxV1FnWmxzQ2thN1N5aW1XSDIzd3BpT3NLWHJCbmFlQ1B5?=
 =?utf-8?B?emZXNDVOVUREUzdDQ2NDZjVQOENqaUUwK3ZwS2JNV0thSFhuSmg5WXFUVStZ?=
 =?utf-8?B?bzVtWWphOUhQbndEcmw2M3FTc0dlVThpckQ1dWxldExGRUJzeUF3ZlNrZjgv?=
 =?utf-8?B?ZW9zNzY0SFp1dmdyMm44cm51L1RKb0VUSjZMOGk0R3J5bkQ1MmZtdGZlQjZs?=
 =?utf-8?B?MmloT0x1U01CYzF1a0RXSklLMnNIb3VnbG5jWjI1MS9NOGlGOURoTmNMYVF1?=
 =?utf-8?B?UWpQVFRkdmJoQkhHNEJub3ljeGVobzRqUFdValU3bmw4bGY4UFRxbFBubFVa?=
 =?utf-8?B?RVk1VzBJQlA3QmZTdVB1c1MrQkd6NzFtNGFMVSs2NTM4SkZkY2NWdmxQWnJD?=
 =?utf-8?B?OVZacVlsVUVjVTZvanNmYUJ1N21Zb25kUUkxbnlYUnkxNGlsSkYwc25NOXlL?=
 =?utf-8?B?bVNXNU1qVWZuSVQ0RmVxcG1XYWdwbnBkVkF1bXZ0czBtbDRrR1NMOFZRSzdw?=
 =?utf-8?B?QXlTV2NmdWMzN1d1OVFIZjc5UHJITDVXaVNhblNYSUx3bkRWeWxpVk9lRGVD?=
 =?utf-8?B?R3REdnpwS0dpYW1GTTMrS1lqK0tlNFV4K2trSnNwTnFYNlltRkYwVHd1OGxU?=
 =?utf-8?B?cWpIYlAzU0NPdzFGQjBEOExQODR1V09aWnR5VU1aS2wxYldXZWRmZDREQW1N?=
 =?utf-8?B?eEZHY3J0SWlCRW5zRmVFajB3dE9uWml2bGF3V0g1QmdNbCtGQ3pJSmx6STNK?=
 =?utf-8?B?YWtmcG14U3diSWgvbnMvSWUxQkVaWnJwd1RCaFhhMU1KVVUzSkZDR3dVRHRz?=
 =?utf-8?B?eEZRVlBYWnkrcTU3RFhLZ0p0cnhpYWZBUEQ4NGdldVIvKzJvcjBxTEdvZ2t1?=
 =?utf-8?B?M1loZEJlQ0l6M3d1ZDh0YTNmcTZxYi9LTmt6NWx1a2JRbC9xcUJvbm9qdmpN?=
 =?utf-8?B?VUJMd3A5R3Y1cHFrbTR1RjQxZXNnWGFLVU52NStSQS9VQjZMSUwzZ21QYW1n?=
 =?utf-8?B?a1RpUjlZVktHdzJxbzgrblVKVDVBYXU3aG5EUHdrQU9qVTdJLy9UWXRlcGRj?=
 =?utf-8?B?aW9MRW9NNTN6MkpBR1lyMTRxZ1pNNVp0WUJpQ0lnOEZJa3ZWT2M1K0pKemg3?=
 =?utf-8?B?SVRqRk5lanhaU29tZFFuWERxSzFHOGdMNkVMS0oxR1d0WjhCaVpFZVVodnFX?=
 =?utf-8?B?TG53SFF6VUJPam1BYVBKamdBRFJYbk9COEV6dFRTdmRpWmRtVDNKdEcyUEFM?=
 =?utf-8?B?Y1VYMDV6ZUo3cmY1UXVJWGU2bE1MVlVCWjZjR2R6YWIycWZlWjZNZVJlYktN?=
 =?utf-8?B?QVQrUkZkeDBoNERKcnBBS2JncitHVzZsanR3M3g3TlpQMmw1Nm1lVjU1V0Jr?=
 =?utf-8?B?dkptVjV3eHQ1eTkvNUdFZHF3dCs0d1JTcko1U0xmeUNIOXpjRjVZbThqc2tj?=
 =?utf-8?B?bG9ONTE3WTU3OG82dDdBUzIyQ1BmbzFkOVVvcjhaZHN6dUJpQW85eklVRE0x?=
 =?utf-8?B?YjRKQ2M5c1hxRG1Hd1FGOHAxMnVMRitraDVoL2k0ekJDRUtxNk5BVU84Wk5w?=
 =?utf-8?B?d2lUSC9pSG1pcXRoZ3dFUXplaDR4WWllY3RkOEgrcC95cTV4d1dOY2FnT0t4?=
 =?utf-8?B?M1V6QVVqY00rcXZ6MXRlTlptTWVMUWZ4bjlQa1Jzb3VtWVd6c2dxYVdGVk9p?=
 =?utf-8?B?c0k3eEVqcGhaVm54cEo0UHdzU1JOZ3NKa0FpUEZ4ZkZrMGxKdFhvTkxudk4r?=
 =?utf-8?B?azZPSzROc2RrVForbjNheFRLaUdNS05nTjRRZTZCejUrUXc2SFo2VmwzMjRl?=
 =?utf-8?B?UG1qWUxPQXFTWUczUVRmVE1WdkV4U25JRllKbXpPM0VzSjlSeDhjUVduM3RK?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B12FB68B3FD0DA43B9A254BBAB250F2D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aad87b6-5e6b-4fb5-b83d-08d9e29a87d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 20:12:38.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Senffx9Z4slimPhxlc0EPV1qeyAW3TFYsAWuwKHLCOanZdc2C3nVO44F3OzyQaT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3912
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bZJBigaT-v5EhNyIvQY-nPCUTsF-jryq
X-Proofpoint-ORIG-GUID: bZJBigaT-v5EhNyIvQY-nPCUTsF-jryq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_07,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 mlxlogscore=692 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLCBEYW5pZWwhDQoNCk9uIEZyaSwgMjAyMi0wMS0yOCBh
dCAxNDowNyArMDEwMCwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPiBPbiAxLzI4LzIyIDI6MjMg
QU0sIERlbHlhbiBLcmF0dW5vdiB3cm90ZToNCj4gPiBBZGRpbmcgdGhpcyBiZWhhdmlvciB0byBw
cm9nX3Rlc3RfcnVuX29wdHMgaXMgb25lIG9wdGlvbiwga2VlcGluZyB0aGUgdGVzdCBhcy1pcw0K
PiA+IGFuZCBjbG9uaW5nIGl0IHRvIHVzZSBicGZfcHJvZ190ZXN0X3J1bl9vcHRzIGlzIGFub3Ro
ZXIgcG9zc2liaWxpdHkuDQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QgdG8gZG8gdGhlIGZvcm1lciBy
YXRoZXIgdGhhbiBkdXBsaWNhdGluZywgaWYgdGhlcmUncyBub3RoaW5nDQo+IHBhcnRpY3VsYXJs
eSBibG9ja2luZyB1cyBmcm9tIGFkZGluZyB0aGlzIHRvIHByb2dfdGVzdF9ydW5fb3B0cy4NCg0K
SSBsb29rZWQgaW50byB0aGlzIGEgYml0IG1vcmUuIFVuZm9ydHVuYXRlbHksIGJwZl90ZXN0X2Zp
bmlzaCB1bmNvbmRpdGlvbmFsbHkNCmNvcGllcyBkYXRhX3NpemVfb3V0IGJhY2sgaW50byB0aGUg
dWF0dHIsIGV2ZW4gaWYgZGF0YV9vdXQgaXMgTlVMTC4NCihuZXQvYnBmL3Rlc3RfcnVuLmM6MTgw
KQ0KDQpUaGlzIG1ha2VzIHRoZSBlcmdvbm9taWNzIG9mIHJldXNpbmcgdGhlIHNhbWUgdG9wdHMg
c3RydWN0IGZvciBtdWx0aXBsZQ0KYnBmX3Byb2dfdGVzdF9ydW4gY2FsbHMgcHJldHR5IGhvcnJl
bmRvdXMgLSB5b3UnZCBuZWVkIHRvIGNsZWFyIGRhdGFfc2l6ZV9vdXQNCmJlZm9yZSBldmVyeSBj
YWxsLCBldmVuIGlmIHlvdSBkb24ndCBjYXJlIGFib3V0IGl0IG90aGVyd2lzZSAoYW5kIHlvdSBk
b24ndCwgeW91DQpkaWRuJ3Qgc2V0IGRhdGFfb3V0ISkuDQoNCkluIHByYWN0aWNhbGl0eSwgYWRk
aW5nIHRoZSBsb2dpYyBmcm9tIF94YXR0ciB0byBfb3B0cyByZXN1bHRzIGluIGEgc2lnbmlmaWNh
bnQNCm51bWJlciBvZiB0ZXN0IGZhaWx1cmVzLiBJJ20gYSBiaXQgd29ycmllZCBpdCBtaWdodCBi
cmVhayBsaWJicGYgdXNlcnMgaWYgdGhleQ0KdXNlIHNpbWlsYXIgb3B0cyByZXVzZSBwYXR0ZXJu
cy4NCg0KPiBBcyB5b3UgaGF2ZSBpdCBsb29rcyBnb29kIHRvIG1lLiBPbmUgc21hbGwgbml0LCBw
bGVhc2UgYWxzbyBhZGQgYSBub24tZW1wdHkNCj4gY29tbWl0IG1lc3NhZ2Ugd2l0aCByYXRpb25h
bGUgdG8gZWFjaCBvZiB0aGUgcGF0Y2hlcyByYXRoZXIgdGhhbiBqdXN0IFNvQiBhbG9uZS4NCg0K
V2lsbCBkbyENCg0K
