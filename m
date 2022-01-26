Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3303049D3EE
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiAZU5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 15:57:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52028 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbiAZU5g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 15:57:36 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QEIr8f022420;
        Wed, 26 Jan 2022 12:57:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XQQf3BS5nV5T0hoqsYf9NWHqVTARiNoym42LmquOYBE=;
 b=Ock2+/jwsQv/M3NHMVmB5QkkbXdCmbva8h1qqBGWubQPNiBX2l5r73hFQ4d8jE+5y4B5
 JNva1E59GaccpH5absJMuO1CH7u6FEyMSj6pPRpR+bfn9Yybre6vW5crm4w743C3Zv9Q
 Q9IWd7/Cc8cKy/7O96yvMmAN1rj4S/udzAY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtfjgk04j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Jan 2022 12:57:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 12:57:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR2paper5xy2lILsj8G3kUxoXGkFiVWmboBTe3IalRnr5XQSkuiOQDYVeJw31e+RegTqXw2JgkHMI/yyRw7QbQh+s49/Rrtg9d+HXMEsEf2DD99xl70Lt/lpCPMQuZ6xg+9EweJSBW1fMkCrL8lOjDaMIo/PYIpu7yzlHEXVlnQHaj1if34V1d1d+wY8AINHvXzF3HEdufI+jlo+FlVCypqlNYCSB0D4SVYQNgXx2O/SJ/wfUxL6D+luRQwbOsEmLjvxxzPykngTcuAaigmYMHVd5/Yiw1f77BzHqV4ZnwvPl9nJxYCva+frt0eVioALYUT3Uui+a71Ma4ylFc4VrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQQf3BS5nV5T0hoqsYf9NWHqVTARiNoym42LmquOYBE=;
 b=HrVyFfiMp0GD7MfLc8cWvGgeTjWwDmgxOKhQ78awU0h/Ok7aZSFKUoi+t4OQHVA/fUYfmN0H6uopqyowIHTpjwfA9ZEc7BKcDRNejerIYGd6ebvN/vDm8Gf5fT9TFDIkOLY0/azxFpPnC+P2YInw+1WINc5sjfeUsNlPiD7LmyhL0DM8WYPLYX37JlNeRRRPKXjbOA7dgLN/GEHoyM+buCX31tF+5iwuyfjAltiPSPZDImLK2mxc79fFCGu2yXENeRgApijjDx2AeEo+dIcVuwbMDIb2L4nDE+f28tcSboAPNhuHsK+UgOYQCrVrTEW1xVXh44ned/bOpiqsYB7rWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SA1PR15MB4904.namprd15.prod.outlook.com (2603:10b6:806:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 20:57:33 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 20:57:33 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Topic: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Index: AQHYEunbzdmpTCH2G0W5LF0fnFB0wqx1uFaAgAAQggA=
Date:   Wed, 26 Jan 2022 20:57:33 +0000
Message-ID: <313f0f08405a5312af7d73e914348c19ce2f8565.camel@fb.com>
References: <20220126192039.2840752-1-kuifeng@fb.com>
         <20220126192039.2840752-4-kuifeng@fb.com>
         <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6fd6a35-4f76-43e6-fa76-08d9e10e7968
x-ms-traffictypediagnostic: SA1PR15MB4904:EE_
x-microsoft-antispam-prvs: <SA1PR15MB4904A6FA27940F279DA669C4CC209@SA1PR15MB4904.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VR6AGyaOv2Y7oupiOjT5xMSpispIE8OCUAHPkjkMZowF1rpUHTsmOPbBVhyD2xhPjKzArMOAyPCzTQWhlgi9TS4xxpXHfW1Hf2bjR1F7u9xurXErlt4gVO6hsMmjxzbFGCB4ROXRw8VjBW7sXCqVpeKAD/0LtOnv6C0yAkj3j189t1gC29BCc22cCw6qv+yWNmD74938v329pXeEjec+KM6VENl5sj8RI9D5LPx3WDwcBVKpdLwGg0vq9Pwb5FNAMj8sJvwPy45jt20CZsqwmEReVXlmGOgDMXR53PVVHGXEyTlJhXMCzLYX2vvzgEQQDBY3vdMBdbkN2WadNexGcgwlI8RURPRi3ujGZxt9acH8anlDB9IKFqyVskxUjPI1fW+B76IWRP0dsYiyin7N6Od1rCHmOJXeZl94lSlzo9lEfCLGmFKH/XwpD/FSJM9gpmcJZCmDM0Yo0OloCmF4wIJKVnn7pmygox+NvoG3uQEViJECzaZObSXbdIDCgsYwb1cZzARC+Ivuaje91rPUOGyTsp0wMp3pM/Mgnq8YH9m7W2Ddw4MaQyGzPcs5NgR89Zxm7zqQKX7Dp45U7Gr6mL+NdhkkofwbsH14VyoAw2EpBkwZ7PUEjaQy9oUHakS2zkS3sQow2myPJ35Xv2cVeVe5IZVT2FF4djNkeSXVFapoLc2/U2NZfq4RBNzf33zlLMdim4k+oSVM2z/Kdro7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(71200400001)(36756003)(64756008)(66446008)(6916009)(66476007)(86362001)(66556008)(53546011)(2616005)(122000001)(4744005)(38070700005)(76116006)(316002)(6506007)(2906002)(38100700002)(66946007)(8936002)(508600001)(8676002)(186003)(6486002)(4326008)(54906003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE92aWgzTW9kUGVmdVk3OTZUaGZFWEcvalcrVUZuQUE4MGg4WWVka1dPTlJM?=
 =?utf-8?B?UDMwMkZDTk1IUUJOZ1BxQmY1eGhjYy9xV1pSelJFcTlGOEc0TERJQ3pISVBp?=
 =?utf-8?B?MUltYnl5VEVlalNYZTNzV1dOM3lmWnBCWXhreXBoR0pCVEZuR0lLVWF4blh2?=
 =?utf-8?B?cW9MbmkrT2wwVTZrcGxRWWZEcXdCb3puTnJ3by93YWxmOHBhKzZOdlZ6K1RS?=
 =?utf-8?B?bVJpODVZd1FYVjR2MGoxWjhxcjdITVZwWWorcnUvVnJPdUNDUjhzWFVPK2ll?=
 =?utf-8?B?bWRBWDlLZ0ptckwwRGNsQzNrY204YXBaaUNnSjkwWlpha2RmbXVlcDdKbmlJ?=
 =?utf-8?B?RDRzUUg4UWlIb3VuejZKMHZMRm9abVZnL3NpcTZWYzJzKzVselFuaTA3a0Fr?=
 =?utf-8?B?V2pwbzVBQnV0QjUxZUxyeGJUTm9QWXRBWCt1RXVFd1duZmxDWnliUEdPYkYz?=
 =?utf-8?B?a0l2OHRpZlZFbDFKM3FsSDBlWjl3dXBmY0pJY09YVFVUNDRWd3k5VnNXWFFl?=
 =?utf-8?B?OEhHU0FiQklUaitTMWFzaHRZWDJjR0RnV2I5K3p3WmFXSWFCWHp6QUxnbHZX?=
 =?utf-8?B?Z0I2MXQzWnZ6ZUt1dEk1WlUwNHY4eHlWUTBqc2V5d0Q2WElxT0VCTlRsNEc5?=
 =?utf-8?B?aTQ5d21NWlo1ckNkU3MrajNwQmNCWlcrUFdKKzFIRzdFUkphQ3BuUHJBcUxD?=
 =?utf-8?B?dEJzamw0N3ZraURWaTIzTVlSRkNJRzVNc1Z1djhtRThtOGF0ZFpZSGhzaHJB?=
 =?utf-8?B?b0FNbXN0ZTRWQ2xzcmg0emI2MlFDZERhT1dUQU1pUFpiMHJ3U2hHdkF1OWRj?=
 =?utf-8?B?alQzd3BBQUd4S3Z1dGFtN3hablpoNlhKVW5uTGpNS0NMRDI1MWFNZHYyYkpL?=
 =?utf-8?B?a3hQZWVrbVc2OCtncklleStVdFRIanQwbkdZZ2VPdGxYanZ0cFJSUVB6anZ1?=
 =?utf-8?B?N3d2SWpIWnh5ZnhhM09yeEcvTW8wTENoV3RJRHhXeFgrTUlqK2NPL2VhYWE5?=
 =?utf-8?B?L1F6T2JZdEJ0RTE2dHBGampBVGtkU2d3VFU1UnFoekhQVE9aOE0vdndkL0RE?=
 =?utf-8?B?OWd5NjVxdG5pamNlMnpWY2Y5RE9ES1VtMUFnNml4WDhtalYyRUdtSTdqV2Jy?=
 =?utf-8?B?MWxRWFY2clBUMExsZ1NML3BzUzh5ZE5qODdKNGJHZ0Q1cG5wM01BWFpyQTIv?=
 =?utf-8?B?R3JCUTk3M1lmdUpVbEpnQW5XeGYzVnpqemZ6OUVUR3drYjQxTk5MVmNKb0hT?=
 =?utf-8?B?Nnk0Zk1WeDkwdTk2d0tSdmxXY21yNFJuTHp6UVJkRXVRZnByYnBuZzQ2VTYv?=
 =?utf-8?B?ek9IcEY5b3FPSlNYelNSWXVMWXNmRDB3Zjl6Ky9naXVYbEhkNXRMMzA2c21N?=
 =?utf-8?B?VDN6VVN0dFBKL2d1SzEwd29laDR5Q3ZiN2hDeEhmTFh6NktpdFl4OHRlTzB3?=
 =?utf-8?B?RCtqQUNGcVUwYmE3QXRmWmpJSVpyalJTV2lhbVZHK2N6bVpTNGk0TUgvUjV3?=
 =?utf-8?B?OXp2SFhkU2M5RnZIWG5ScE1YazhINVVFWXA3YmRsQ095RkVpZUw2RHU5cm0r?=
 =?utf-8?B?ZmNYRmdqNE9UU0hvRWZiS2hmQVhDeUVLbDVoditPNUE1YmhzNzFHS1N2ZFNT?=
 =?utf-8?B?N1pTR0gxbzVDWEZtUGpuYXdla29FRElodVpVVXdWRjhxV0JaZWN0U2VjSVNo?=
 =?utf-8?B?dVAyMVRVSFFVWndUZWlEaTlrTWhzRnRKQjFRWWttTDRsZWRwTGRlRkt5S3lR?=
 =?utf-8?B?MTBQZWMyNzBNSVJxaG1TdTVDY0t6VXBmeGNPVi9BL2psekZVM1hSSWxwVnhT?=
 =?utf-8?B?N2RWYWs0WFRITCsremEvR3RQUEQxRGhsaVdDbzZRUzFpdFEweW9waXpGZmZa?=
 =?utf-8?B?Q25yckhYUEIxY29uOHY5RXVJRkFuRTljOU5lN29JaDdNWDJEeDlNdkdZakxH?=
 =?utf-8?B?UlllWVNqZzBFQVlBZHdIejBKWit2WTZNMU9yMXRsUy9BZVByV3ZNQkFlMzFm?=
 =?utf-8?B?ODZ1ZEFhMm41QTBJWStoRERWREtxakl3K3pjZHo0T2s5alI2Y0ZsZ2NZVU1m?=
 =?utf-8?B?NmMydkpFRXpWS0tGNTRIYzZxK1JUejBVK2JzbXNoWHIwdG8xcW8weEg2MW82?=
 =?utf-8?B?RDIxNWhNa2FibnVleGhoVTdoRHRIS3NpNmZNaEw4eVg4T29ZSWhLa2dUTEwx?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A05E913DCAB54DABAB9310CA545CE7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd6a35-4f76-43e6-fa76-08d9e10e7968
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 20:57:33.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUgMa1mgVp5+s5Z4jPpc/3j/7becNy+w0jrXtBgpD1aeHKANa5eJCDrdbuiktDt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4904
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OS6yXb5hbtZkYIdr-lu-plsJslg5d2eO
X-Proofpoint-ORIG-GUID: OS6yXb5hbtZkYIdr-lu-plsJslg5d2eO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTI2IGF0IDExOjU4IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDI2LCAyMDIyIGF0IDExOjIxIEFNIEt1aS1GZW5nIExlZSA8a3VpZmVu
Z0BmYi5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IENyZWF0ZSBhbiBpbnN0YW5jZSBvZiBidGYgZm9y
IGVhY2ggd29ya2VyIHRocmVhZCwgYW5kIGFkZCB0eXBlIGluZm8NCj4gPiB0bw0KPiA+IHRoZSBs
b2NhbCBidGYgaW5zdGFuY2UgaW4gdGhlIHN0ZWFsLWZ1bmN0aW9uIG9mIHBhaG9sZSB3aXRob3V0
DQo+ID4gbXV0ZXgNCj4gPiBhY3F1aXJpbmcuwqAgT25jZSBmaW5pc2hlZCB3aXRoIGFsbCB3b3Jr
ZXIgdGhyZWFkcywgbWVyZ2UgYWxsDQo+ID4gcGVyLXRocmVhZCBidGYgaW5zdGFuY2VzIHRvIHRo
ZSBwcmltYXJ5IGJ0ZiBpbnN0YW5jZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVu
ZyBMZWUgPGt1aWZlbmdAZmIuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhlcmUgYXJlIHN0aWxsIHVu
bmVjZXNzYXJ5IGNhc3RzIGFuZCBtaXNzaW5nIHt9IGluIHRoZSBlbHNlIGJyYW5jaCwNCj4gYnV0
IEknbGwgbGV0IEFybmFsZG8gZGVjaWRlIG9yIGZpeCBpdCB1cC4NCj4gDQo+IE9uY2UgdGhpcyBs
YW5kcywgY2FuIHlvdSBwbGVhc2Ugc2VuZCBrZXJuZWwgcGF0Y2ggdG8gdXNlIC1qIGlmIHBhaG9s
ZQ0KPiBzdXBwb3J0IGl0IGR1cmluZyB0aGUga2VybmVsIGJ1aWxkPyBTZWUgc2NyaXB0cy9wYWhv
bGUtdmVyc2lvbi5zaCBhbmQNCj4gc2NyaXB0cy9saW5rLXZtbGludXguc2ggZm9yIGhvdyBwYWhv
bGUgaXMgc2V0IHVwIGFuZCB1c2VkIGluIHRoZQ0KPiBrZXJuZWwuIFRoYW5rcyENCg0KU3VyZSEN
Cg0K
