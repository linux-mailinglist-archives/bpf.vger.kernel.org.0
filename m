Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2552948A4B2
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 02:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiAKBF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 20:05:28 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:48640 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243225AbiAKBF2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 20:05:28 -0500
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AMufh8020964;
        Tue, 11 Jan 2022 01:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=f4JICRsySH0yiG3v7HaIFoJ4yrl5kXHjxy7hRI07Pxo=;
 b=XrbjndWAWPecIIfcV0D/jYXbT+cieDwNRP801JjBlfjiL9EI81+q/XJD/5/FNuJeHDuJ
 k/Ye31fo4/PNJ9A6+FJF4wyyHGDCHMxz98wGuuOncvNsy29wNUSmNOZ1qyLN+toGHalX
 rlyor9oUH18+w6DvushgcaluqCyTCJto6BhJZo9lM+7JOfyEIYEwS0RPrTh5BHJpoN4x
 E2Q9t2kLOWWDl5VbcE52iAyHCO7euO5Zhw2n/QcregCXJaz5VR+AZmW7xs/VZE9Jr9yU
 vBdSBb9oJRhtwASjn/KKngG3d/6x420tyJUYb+BxVW5ykNQ9kdE7ajK5mbInlkAGNUuS wg== 
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2106.outbound.protection.outlook.com [104.47.23.106])
        by mx08-001d1705.pphosted.com with ESMTP id 3df30r1xs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 01:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx2JRh1zVRwPw/6iBca+VHk59q1nMegJGJLR3dD3zniEz0dIBNYYZ4I6F117EqEuL/7jwG1rWEpBS6adWWMB8vSPJieXd9Z/CDiXLCl9A7TKmjqh0UOMbS+djW+uUjLKF+iiGpEbn1jgc+6Hnthiq7nxxkYeaj/wzMFBP/zAPT/yVYiLj6gZs+82cb3odZbriTBpT5cHiMmpKPkxVvmsojkWAv9AVv6p7EBlVR2dmY6SOGpyuagYY4J6uZAScYq3hZWaJqH+i7/nceINfrv22i6Re2qEBnsQQxzXAmJwK3aPH2V6Yhl9fz83rKzoIJ7iG3v1d7NLNt1FCvV3T4GG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4JICRsySH0yiG3v7HaIFoJ4yrl5kXHjxy7hRI07Pxo=;
 b=n7zmU4lIyI/bHNei1R2zQjopuEp5Jk7QK1vnvotSRdUHNdEIp5+XJsHNkRBVb6IGev6Ial+o9jLvG7tdwrrGPW8JIHTyaCWljB1LEw6MHACcUlN9iZuynnCFRVlWiHmSvBUiJGv5/UvLZIp4c48DDU74VTyHW6nPL4tjIISv5J6JLiLWBHKpvofmwDudSzYnC01YcLjcd9m6Lr4ig3ThbhEiZa3h4HAXMTICPaebBqCJhWt4qSVCC1JJPQAP7pe1Fgzkttt6DTjJ2TnimycsJX8qdEXT+1zpm572pOoB9Q/UyXAitY4vrRMhqQ1Q3Vgy0YgLH4mpLwGas32Fv0M8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TY2PR01MB3148.jpnprd01.prod.outlook.com (2603:1096:404:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 01:04:50 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::f814:f7e:f65c:3147%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:04:50 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: RE: [PATCH v2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Topic: [PATCH v2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
Thread-Index: AdgDbmTY/BRuEK6oR7OS3JTt6yRDPQAl5y6AAJ/QBkA=
Date:   Tue, 11 Jan 2022 01:04:49 +0000
Message-ID: <TYCPR01MB593693A7D00833CE4FCF6053F5519@TYCPR01MB5936.jpnprd01.prod.outlook.com>
References: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <CAEf4BzYWueWzBzVfW62augyDmLTN0ZW=mtE0xPFX7UrtG2BMPw@mail.gmail.com>
In-Reply-To: <CAEf4BzYWueWzBzVfW62augyDmLTN0ZW=mtE0xPFX7UrtG2BMPw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50d0e0a-8665-42c9-73c9-08d9d49e5e43
x-ms-traffictypediagnostic: TY2PR01MB3148:EE_
x-microsoft-antispam-prvs: <TY2PR01MB31489C0B5FC654D0F636DA11F5519@TY2PR01MB3148.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwhTzTta90F+YxX6KBmy6IIWHHGDq2g5druopZuvchRxLvVwTgW0HOQrCRBaXXjgfbs5f59nCOBlHRInsWh+OAOaK7H4T/a/1a6TUQ7fP0OmOf6VZkvRsXvR++YDHfYVTiobv6X2prMUu3YLTOGsxeVDC/9FtITuTVLmKkz42CTg6539Oz4Yv9FL8FkWAM64ZLxIvKw98hWGqsIkWtWtRp8VdglCWVIYYtfUd35Jt9QpD+CBP0N279SpLpAij9vBj7r4Se7xG5T+YeLkGzAp2mEIERQiGkZboGbscvJ7w0zx7aSCMEMedbdY3KZY8Rw6WWwnMkONKfAsk6y5GArRQOwtw2zYnRJCaxGiHjx1ersfnOCDFBza7Zdu1XqG+kCqb3W2xHPGa8gX5VUXY/SYJ4rPW8ryKsPI38t6CH9CeDPfa3BD/0f/JtOjyUsGiXvHMYkjbZrEh4P23z9eoXl2Qw/bYDbLWaBuvF0A+BW6zNAv8r1D6U7ATDW1lFCsra1r01zC57vmoc5OOOB9/Xul3gyTpIHzDB9J4lyisr7+afZ1t+uRvPVzCeIR4I/vf0SS/T3VxmFp7wQVdZy1sFrEfocHGNHMK25X7Do31ytLbLNMd2f0mk1pa8mgVW+i6WjDTLhVyfPsSqWKA6Hr8ZrsRaM7Hbn5bpmIFDrw3C9aUX6ulLM+HVSlSqnxTT8uxFMjDPTQ/239IhGFxChTEQJqoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(6916009)(508600001)(4326008)(8676002)(33656002)(9686003)(186003)(71200400001)(38100700002)(54906003)(8936002)(6506007)(7416002)(7696005)(122000001)(82960400001)(558084003)(86362001)(66476007)(66556008)(76116006)(64756008)(66446008)(38070700005)(5660300002)(66946007)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWlNYlFXUWsvT0xEQnF4Sml2WlJYYy9QS0VSSnBCTzVPcUkxVUl4NytLbHdD?=
 =?utf-8?B?d0JuS1VVc24vR3MvOGgzOC9OTU9vRU9UZ2V1emRCaEJOblFBaUJUSXF2eDNw?=
 =?utf-8?B?TUx5R3VxbTBWaU9vL0taMjFmZU1weUFjL2VYNTA4TytkeklvbXc5aEVqUmxo?=
 =?utf-8?B?bTVCdGFMRUxPUUgzVnhkRGN2MldhZUJFQk1QNGxJZkhZTlBXdzBZcFlXeEdU?=
 =?utf-8?B?a1MzT1JVK0NZdmowUHU2dFJ1U1FNcURYZG5PNDdPQUZEcHhDMlpjU2NzZTIz?=
 =?utf-8?B?NGpCZEJpdUdkZHRjYUVDdzdpZkxYdnhDT2xjSXpjWkNUU0hISE9NaE4wbmY3?=
 =?utf-8?B?aXhZQ3hWL01zK2c2NmJTZG4yODRIRXlPaFJYNVB1SUJvWWVldjJoWXhmbnZk?=
 =?utf-8?B?MGttVURiQmJ5RWlPQWttdUJFTnJXME1ZbDlSbzFSdGVVUWE4SHlhSTl1R2ZV?=
 =?utf-8?B?MVlibmtjdlZqaktPWHd5T01ub3IrWjhDODZMVWxiZFhac0ZrSkZwTkpwSUk5?=
 =?utf-8?B?ZUk2YnNFRFdlUVAzUVpyTVFVZGF4TFRnSlQzR2pBVFU2MnhkdXZrSk5DOTJv?=
 =?utf-8?B?YjliUXRKZXRmeHNhTmtvL2d2c2lBOHBvRkVtYThVaTFKSGs4WXQyOUdpZFVV?=
 =?utf-8?B?eU9jeVBPMWZzdnZvc001UVYyUnlZcFB6cExBU296WjFJMkVabCtpOHg1b01z?=
 =?utf-8?B?WUNET2cxdmVZNHVBNTdIZ0Fna3F6L3NiVUp0THFXK0Z0Yi9RSSt1ajU5TWU5?=
 =?utf-8?B?MWo4ODFUd3BIc3NzTlNKU3VzNmZWVVhLamZjRHdrMGV2aUQyTC9UVWRGNEI4?=
 =?utf-8?B?ZnRxN2k0QnN1OFVlOXlpeGlPV2VmTXhlNDRxWkhBV3IvcUVtdWlnMlVBTmIy?=
 =?utf-8?B?Y2xkVzh6TEEyaUVzalhVSG51U2JMRjlNT1Z2dFc0RWY3WnNJcWtCQ2QwOHpV?=
 =?utf-8?B?K1BjWjZPTWYzTlZFNmxiZUVZV0hJUW1pTUNtQ0JxUWgyNkpYUSswVkI5aGho?=
 =?utf-8?B?Y01HaGNrZzRqYzNiend5K2ViR2oydEhtMUJ1R0xpYUZVMFJ0ZXpUWWJwZjhN?=
 =?utf-8?B?MmV5QWljWEtHMGt4aVdtN0luVEdudkVzUUNrV1VTelBTdCs0cW9rRDJVTmJF?=
 =?utf-8?B?RUs2d1JFZ1lEZGNNQkxBNDlQTys4WDZUajN6anBMZlYxbks3V2E0dldBalgw?=
 =?utf-8?B?SUc0YXhybU8rdWxBUXVuVHZzc1VNK0dKVlY4aGVYYzJXWXFGTHdNc08wYk1J?=
 =?utf-8?B?MFJIMFNqUWJiaVlXeHdUNHNtVFRKR3JBTlY2N0hHSW1IbkxNQnluU3lhR1o4?=
 =?utf-8?B?c3I4OWRXTTJUeXJQR2FSdkZBMHlacWtSSUpIdzBRUHNBeVdMVXFxUE84Q081?=
 =?utf-8?B?ZVU1QzQ1M0JkWkRMZ1B1dmszTzBGQXBxL2pKaHMxa1VxeTFSSDB4dnRuTCtL?=
 =?utf-8?B?RXlBeVM4c2MyZi91SXl2WlJjYnJ1QWF0ZmZwQUFGb2VZUzIyOWFCSnh3aU1E?=
 =?utf-8?B?RmlCNlUzZ05mVXMyQ2pBWGZRSGlXWlJROVNNNVNVRXRvTzhYK1d1TjhVVWtE?=
 =?utf-8?B?MkYzMkdZMnVtU3FyRXU0RmQzMnZCbGIraGpOOHpXR1ltQXZDYXhYZTQ0clVN?=
 =?utf-8?B?cWtRbzVxNFVhWFk2Rjc2WUUrY09RVWUzYnJvSVo5VFVBclR6UnprSDFaMWVV?=
 =?utf-8?B?bitWQ2ZIaHJJREg3VXUyMDlhbmNtUGg4djJYRUpWeGhCMzlxNnZLY2NHOHUy?=
 =?utf-8?B?cjBNZ2drYUd2SDhqR3FBN3pkdVp4VlQvb0RVNG1hTVZKc2xpeGRwSEUxWlZ3?=
 =?utf-8?B?dGlaUkVsS1ZZTWlBd1BrNlBTcDhDeTVDdmtLS1RwT1RSRG9hZ2xYanBOckJ0?=
 =?utf-8?B?TkZ4T2FDVENZaytvRHlsaWQ2eStDSTJheGpEc2Q5NmVsKy9FczEyaUNLQUtZ?=
 =?utf-8?B?NmlLZ0Y3L0ZTSVJ1SFkrOHZpQy90WmpHcUlWYWVSVWRvOFNmREp6Z1F1dklr?=
 =?utf-8?B?Zk9MVkh4NkdqK28zSytXbVNJNktoSlFzUDVVU1NjV09MRjNwaU4xSUpRbmpV?=
 =?utf-8?B?L2ZYK3lndE9CSFkwL2lvelE5b2J0TGVvTTRnQ1VrekpqV1ZtQWhUUnI5bWpv?=
 =?utf-8?B?d2ZpRzcwblFrTHVPYzhydFFzeDcvTkNTNUFnWTZycVdGeVRCSmpiczU3Z1cv?=
 =?utf-8?B?TGJ2NkordVVqdDF4dkhWVXZReXZ4SHBOamwxY0Y1THRnZmI0dXJrNGhKZjVQ?=
 =?utf-8?B?K2szaHN0a0E0NjFGYmQyZXVpZW5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d0e0a-8665-42c9-73c9-08d9d49e5e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 01:04:49.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCLdZsOwiQYrJ9JdrovZBkVu+2m6t1Zv2rDmEZF94iIaSQJyefZ+WjTuX/Am/+cQGV8Wu6ZCEpoSNaxq3zrYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3148
X-Proofpoint-GUID: whTNsejAAI0-nuudvOPd8gc7tnw6T2PE
X-Proofpoint-ORIG-GUID: whTNsejAAI0-nuudvOPd8gc7tnw6T2PE
X-Sony-Outbound-GUID: whTNsejAAI0-nuudvOPd8gc7tnw6T2PE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=930 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110001
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSdsbCByZWNvbnNpZGVyIHdoZXRoZXIgd2UgbmVlZCBDT1JFIHZhcmlhbnRzIHdoZW4gSSBjcmVh
dGUgc2VsZnRlc3RzIGFuZCBmaXggdGhlIHByb2JsZW0geW91IHBvaW50ZWQgb3V0Lg0KSSdtIHNv
cnJ5IGJ1dCBteSByZXNwb25zZSBtaWdodCBiZSBhIGxpdHRsZSBsYXRlIGR1ZSB0byBteSBwZXJz
b25hbCByZWFzb24uDQo=
