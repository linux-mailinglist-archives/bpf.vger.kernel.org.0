Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A958444C
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiG1QkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1QkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 12:40:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A825F94
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 09:40:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SAE15x015591
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 09:40:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CUCUFUqLXBmmDffZpr6oz6ndT5eltON/XOLuFQRp3Mw=;
 b=PJxvrMzGo9lDytAwHkf1tjh0TbZUY05muZe+L7Yh/wczaJ5lYGSiWpCgy2ZxGB2vAew4
 Lxre7Ql+3rJHwNUp+mWHV1m9O4oS0TDcTvGBtz9WgrRDHj/CTI1eRASzObeH8fIoEpg3
 eG8TF9qzWamRbMFii/UfmKpEa6yyWmZC194= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hk3702p2e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 09:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WohXTjuWY5A1C/olYNAhX+NEu6INQR13+zesoJVo7qEDjsksww7fR/1MfCeFRfxcY1iYgor0lKAGxI7+M6E9YmktTarjVGtgQM0FtLtc/ZHxnKpZ9juu3HeHMAQFstake0tK9QqtJcQd/Q4VsC6OvrCfXp0kHoicxIUupBil5Q+DNieHA4JDkqQMJ5RsnwHSM7Sx38rOLFxkWBwcPjXk5qrdbRNmFMaWkyzry3j2XgecshopS4EzzGS2DxIWb80+DXvv4dnapWLTHEcBes59e3DzcNilI0L2VMwcqi656FxHpMHCxSN9PIkJLXYrvtI9Wmf3oOlIr80fWr/Cci0MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUCUFUqLXBmmDffZpr6oz6ndT5eltON/XOLuFQRp3Mw=;
 b=kCOQaI9tu0rIdZ5T1bV83pDtUvDyrwOr4hrvauuH38Ce1rIPMNSqvkogp/jus+kt7ywceRXGPpW3jLLzxGVfb4KoeYDsGZRp6MBQIVZ+f//fKSW0yR9lVi+hGkxgcJUprCbVq4dryBoUTYQtiCc6cgUfalINrNSyFZkb/MY6NeZvJOj4rs1/P/CoR1QAgjVjTfZuCfl1SJMtkKTgbn1/qUjazbbme8AFHaBUxmKSLjh5yu3GqjjF1yCiEk1W70lBtcfJphluCvk+f0LbS76Q4dMnrZKxFMzuBD+YWrd6ikc7tG8FTc4wzg/8ZxPN49aqA0uvhdYt6VxOxSqQr8zx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MWHPR15MB1151.namprd15.prod.outlook.com (2603:10b6:320:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Thu, 28 Jul
 2022 16:40:11 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 16:40:11 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "memxor@gmail.com" <memxor@gmail.com>
CC:     Yonghong Song <yhs@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAE54wCAABc7AIABYbAAgAA4cgCAAGyEgIAAEqgAgAAEzYA=
Date:   Thu, 28 Jul 2022 16:40:11 +0000
Message-ID: <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
         <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
         <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
         <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
         <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
         <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
         <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
In-Reply-To: <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc6a9af2-b40c-4ec2-96f3-08da70b7d6dc
x-ms-traffictypediagnostic: MWHPR15MB1151:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zERQ3Azc1MO43I0l8kGIMxJObHDW2L/fXT1N1EI97YCX7T6cJzmDGwztDj9L/W6GYxuODE3S3ZKoo4gm4T0Qhves8FFGZGUsS05oeaEtgTZEJy3LzgcLabJKnmkGCemWKs8u9HrYEn8VY8RM5JjrYNw8Rphq9IUuX+jPlsj04+tvA3JQdwMgMjjqkw7NWOlfEF4ySvSXw6IUa7qXTwKMovcFdztTRJ71/2BEFmLTZkqP3cM9URwhEdExq4bZvfssfImLZGBkVakjAwhpGl37rFRMz8fGXNOy/U/BqERbuEfP7uzrFmL2SF4I7M1C4hlWagc63xrOYi385KJH7ITJYi+96aA2K/AWK9XIXew2hSYSv/7rP+U1YiZdAZSAlVvCU+7VF240khm1SzzLuiCxrow3KOMrLpD5v97MXvxqIARbLi0R99ft3NfZmB/dSqgygEfrv5WbSeLJSajR5z5qOAaUwhCtGiIwbxIRYal/pN4UqFdCPGp1sqSJ4IiooyM7B9J5PK9GmE8LHZzkOTwrjDE62XiZ8bF7DzCr80wGLt7u7LK82wsqv8RW0pISnpxbTGOkeUJ7gQnSbfckvKhYhwkh0FxE964pvRj3xDDO3GcQpMKzH6LlJinqGYG9AQ1VxDcKmaRCg17/0YZw/kZToixlURFpfa1YQZ1xHR7/4hbIPHLEeMyCAJS4kvvfS2cSZQX+iQT/r0WcoYdAd0kgx/gztpMNDjUljP/GJSQRkMCyDEpmYbZANYhHGXw5GQbLJu5iLIjD8P/66OX2kM5Nru+G47qIzlldllmR65UT+PaYWp/t+SAQ/fFY4/3dHDb6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(38100700002)(66556008)(2616005)(6506007)(6512007)(5660300002)(122000001)(64756008)(8936002)(41300700001)(6916009)(2906002)(36756003)(478600001)(76116006)(54906003)(86362001)(71200400001)(316002)(38070700005)(6486002)(66476007)(4326008)(83380400001)(66446008)(66946007)(91956017)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmJWVmlSRnoxckZsclBEUXRKdHBVL29UUHdmaElIenlhaVhWTzNod1dRNDNN?=
 =?utf-8?B?Qm1seEsrRUhNZStoM3dlbTE0d204K0c0Q1d6enBTZUNtNVVXKy9XWHQ0VWd0?=
 =?utf-8?B?RzZBRW0xTHZkb01Od29BeGFsbTJXWkdoTXVrVUZHcG51NW94QWJEUVNzNm5R?=
 =?utf-8?B?Qjh5ZmNuNnF5TnRkcnBrZ2g5alFtMHlnQjZDaTg4Zy9CNGUweXovRTJWSVQ1?=
 =?utf-8?B?dElXODlvNHQrdU9vL2xjVGRINVZxR0dxTVU1ZVJscHpjUURSb3A1azBzOXBK?=
 =?utf-8?B?UVFtWU5wL1NFYmpsaXNlRkN3MTkrSlFOU2ZIYlZqR0R3YUV4Y2laeEpoc0F6?=
 =?utf-8?B?dWJMc0wvemhnV0JleGV5d0FadVVwUEFKOFp1VG9tR1Rvbmw3VTIyaU94Ym10?=
 =?utf-8?B?UGhXU2FIWlV6WnpsVmJ6SnU4QXIyOHZyYTRSZnhFNWNsU3VJNHdKcys1d29R?=
 =?utf-8?B?WUtnVi9RNU4rN1JhcmQ3U09MWlZvYi83SXFzV2pzTXYvelp6ajNlL2RyMVdy?=
 =?utf-8?B?eXZNNkdPVGpjQStpRG12cEVZOElNaUJiMSt2UFFacm5tRGxacDVZT3RINEs1?=
 =?utf-8?B?MFFLUUhzLzBFSUNIWExEWUgwMzA2WHBPaURKdlp1OWdlRXRmRzgvb1lwR0ds?=
 =?utf-8?B?bExjVW1BWXBMOW9hZmgzdjYxZ0ZIUk9aZUJ0QXA0bkU1UkR5OXZwQUNhajI1?=
 =?utf-8?B?TGZpN3B5YjNVZkVzOTRiWGVkMHAzTDk1aUQwZHZScGVEWXJ1Ympwa3hZdkxV?=
 =?utf-8?B?czA2elg3ZXJaWGVlSnkyMkxTbG1KUzkvS0N6SjJpazBUWUJSWE52TlBwRE1y?=
 =?utf-8?B?S1VKcWJtQXpuQ0I4dzNJVUtJVjh4V2tPWEVRQzR1SjlveUNxMmJoNHJJa3JU?=
 =?utf-8?B?eHIyRGJjb2tNc1JjZjhMakJaS29xTFBIa2gvWkI0bGRGYk9JM0Q4WE9tbDkr?=
 =?utf-8?B?UGphS3hQUDlEMVU4d0s2QUtLV0l2REdQWlIxYThpK2pNQmVCd2Y3bkZDNmtK?=
 =?utf-8?B?WVdWczlqbDdQaGNZYWJseWJWKzdndEFsK1BvMW1GcVhyWWxjQWRjZVNwbzUx?=
 =?utf-8?B?TW9JY0xXekhBM0s4bmZIYThreVlDYjlDZzlUM3FqMEY5ejkyR29rQWlnV1Ji?=
 =?utf-8?B?Ukg4QzdPUmVXc1BPaURDNkFqYndQTU9LbjZkd0EvamVMci94RWMrb1NaK2V1?=
 =?utf-8?B?WExFejVCTlFzdm5JS2FWTUR2N2dpeTRqbzV6RFhuM3V3TytOZzdZTTBtVExk?=
 =?utf-8?B?aDlVZ2FhdzlrWXc3WTVDSG50a1FNcFMyTEt5aWphUkVwdk5pbUQ1QlJPWDls?=
 =?utf-8?B?UnZsbWs4WDE4ejgreFA3Y2d6b29pWDJCUkh0SWljcDRBMDFvZWEzU052UzdF?=
 =?utf-8?B?UzRFdmkySDB5MG11TUE0SkhxYWFSZEdleUgwbjR4dTZaS3RzNGFKMUxEVjZ2?=
 =?utf-8?B?TG5xR0E1R3RTdS9EamxRTTByOWUrWjVTT2RLeGRBaFROTFlmRlNpbWo2TTdp?=
 =?utf-8?B?eDV4VDJaVFYzUGw3TFd2L0U5TGE2NkVnRGlPcGM2bVArMldIWmZrUms0bEd0?=
 =?utf-8?B?c3JaNjhOYktWMEY0Q0hmckhJZ2RxWDJ4b3lZZURFUXF3a3lyTFNRYld5VHdn?=
 =?utf-8?B?RW40QXIwWHk5eXJ2djZ6UHJBbGZyc3llbklTMzBSZVovZmFKa1JNakpMODZY?=
 =?utf-8?B?Ry9zNXBNTStlNUZRZzg4S2xjWUtOajZtR2J3dnk5d1U1L2NmOXhROTBrelBP?=
 =?utf-8?B?TFU0Nlo3VFJENjdRY0pJWDdkWUEzVi9LMTM4YlZhQ3VCWjNmeHp5aHA3RUI0?=
 =?utf-8?B?dmxYNTdwT3Y1b1dDOG92dWlISjR2MklnT0dxTGVVMko2M0JEUEtJWmN2Yndv?=
 =?utf-8?B?enBiSUJzUHo5bENVcktiazF2Wm02ajVsVHZYSi9udWxVOGdnTXU5YVNweXJO?=
 =?utf-8?B?Ti9pczdhVkhJM3l1TmRuSUlhVm1peUhWV3BXYWcrU3dqaVhzTXQ2RkpOeEsx?=
 =?utf-8?B?WmIzaC94Q21lL3FUSHJONE9zSi83eDc3dWk5Sm1oVzFXR1RHYnlJYVhPZThQ?=
 =?utf-8?B?eUM5YzhVZHlNaVJyN1h3SUxhYVJYaWtQdUhzSExZSzVVRnZLdVAvV29vNTkx?=
 =?utf-8?B?U25uczVDK3RFcUk0N3ZmNllBcEhmSzdLeTlMaUNIenowTy9XeGVWRWZXazRN?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4068B22802714F816A05AFB6C7AE91@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a9af2-b40c-4ec2-96f3-08da70b7d6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 16:40:11.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXtjvLGWvIlZ+Y35IL0GVHZ/0jhXtUbN1HbUX4W/U9/kTlDwxDip2Wi/qOffknKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1151
X-Proofpoint-GUID: LsY79MXT-hu2vWDDPABuCykFl5MdH8gH
X-Proofpoint-ORIG-GUID: LsY79MXT-hu2vWDDPABuCykFl5MdH8gH
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

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDE4OjIyICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVk
aSB3cm90ZToNCj4gT24gVGh1LCAyOCBKdWwgMjAyMiBhdCAxNzoxNiwgS3VpLUZlbmcgTGVlIDxr
dWlmZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIyLTA3LTI4IGF0IDEw
OjQ3ICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSB3cm90ZToNCj4gPiA+IE9uIFRodSwg
MjggSnVsIDIwMjIgYXQgMDc6MjUsIEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgMjAyMi0wNy0yNyBhdCAxMDoxOSAr
MDIwMCwgS3VtYXIgS2FydGlrZXlhIER3aXZlZGkNCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
T24gV2VkLCAyNyBKdWwgMjAyMiBhdCAwOTowMSwgS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNv
bT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gVHVlLCAy
MDIyLTA3LTI2IGF0IDE0OjEzICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgSnVsIDI1LCAyMDIyIGF0IDEwOjE3OjExUE0gLTA3MDAsIEt1aS1GZW5nIExlZQ0K
PiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBBbGxvdyBjcmVhdGluZyBhbiBp
dGVyYXRvciB0aGF0IGxvb3BzIHRocm91Z2ggcmVzb3VyY2VzDQo+ID4gPiA+ID4gPiA+ID4gb2YN
Cj4gPiA+ID4gPiA+ID4gPiBvbmUNCj4gPiA+ID4gPiA+ID4gPiB0YXNrL3RocmVhZC4NCj4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBQZW9wbGUgY291bGQgb25seSBjcmVhdGUgaXRl
cmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwNCj4gPiA+ID4gPiA+ID4gPiByZXNvdXJjZXMgb2YN
Cj4gPiA+ID4gPiA+ID4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZl
biB0aG91Z2ggdGhleQ0KPiA+ID4gPiA+ID4gPiA+IHdlcmUNCj4gPiA+ID4gPiA+ID4gPiBpbnRl
cmVzdGVkDQo+ID4gPiA+ID4gPiA+ID4gaW4gb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgc3BlY2lm
aWMgdGFzayBvciBwcm9jZXNzLg0KPiA+ID4gPiA+ID4gPiA+IFBhc3NpbmcNCj4gPiA+ID4gPiA+
ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBhZGRpdGlvbmFsIHBhcmFtZXRlcnMsIHBlb3BsZSBj
YW4gbm93IGNyZWF0ZSBhbg0KPiA+ID4gPiA+ID4gPiA+IGl0ZXJhdG9yIHRvDQo+ID4gPiA+ID4g
PiA+ID4gZ28NCj4gPiA+ID4gPiA+ID4gPiB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb3Igb25seSB0
aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPg0KPiA+ID4gPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+IMKgaW5jbHVkZS9saW51eC9icGYuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDQgKysNCj4gPiA+ID4gPiA+ID4gPiDCoGluY2x1ZGUvdWFwaS9s
aW51eC9icGYuaMKgwqDCoMKgwqDCoCB8IDIzICsrKysrKysrKysNCj4gPiA+ID4gPiA+ID4gPiDC
oGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKgIHwgODENCj4gPiA+ID4gPiA+
ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ID4gPiA+IC0tLS0NCj4g
PiA+ID4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+ID4gPiA+ID4gwqB0b29scy9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmggfCAyMyArKysrKysrKysrDQo+ID4gPiA+ID4gPiA+ID4gwqA0IGZpbGVzIGNo
YW5nZWQsIDEwOSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBiL2lu
Y2x1ZGUvbGludXgvYnBmLmgNCj4gPiA+ID4gPiA+ID4gPiBpbmRleCAxMTk1MDAyOTI4NGYuLmM4
ZDE2NDQwNGUyMCAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jw
Zi5oDQo+ID4gPiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiA+
ID4gPiA+IEBAIC0xNzE4LDYgKzE3MTgsMTAgQEAgaW50IGJwZl9vYmpfZ2V0X3VzZXIoY29uc3Qg
Y2hhcg0KPiA+ID4gPiA+ID4gPiA+IF9fdXNlcg0KPiA+ID4gPiA+ID4gPiA+ICpwYXRobmFtZSwg
aW50IGZsYWdzKTsNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiDCoHN0cnVjdCBi
cGZfaXRlcl9hdXhfaW5mbyB7DQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGJwZl9tYXAgKm1hcDsNCj4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCB7DQo+
ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191MzLCoMKgIHRp
ZDsNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IHNob3VsZCBiZSBqdXN0IHUzMiA/DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9yLCBzaG91bGQgY2hhbmdlIHRoZSBmb2xsb3dpbmcg
J3R5cGUnIHRvIF9fdTg/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV291bGQgaXQgYmUgYmV0dGVy
IHRvIHVzZSBhIHBpZGZkIGluc3RlYWQgb2YgYSB0aWQgaGVyZT8NCj4gPiA+ID4gPiBVbnNldA0K
PiA+ID4gPiA+IHBpZGZkDQo+ID4gPiA+ID4gd291bGQgbWVhbiBnb2luZyBvdmVyIGFsbCB0YXNr
cywgYW5kIGFueSBmZCA+IDAgaW1wbGllcw0KPiA+ID4gPiA+IGF0dGFjaGluZw0KPiA+ID4gPiA+
IHRvDQo+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+IHNwZWNpZmljIHRhc2sgKGFzIGlzIHRoZSBjb252
ZW50aW9uIGluIEJQRiBsYW5kKS4gTW9zdCBvZiB0aGUNCj4gPiA+ID4gPiBuZXcNCj4gPiA+ID4g
PiBVQVBJcyB3b3JraW5nIG9uIHByb2Nlc3NlcyBhcmUgdXNpbmcgcGlkZmRzICh0byB3b3JrIHdp
dGggYQ0KPiA+ID4gPiA+IHN0YWJsZQ0KPiA+ID4gPiA+IGhhbmRsZSBpbnN0ZWFkIG9mIGEgcmV1
c2FibGUgSUQpLg0KPiA+ID4gPiA+IFRoZSBpdGVyYXRvciB0YWtpbmcgYW4gZmQgYWxzbyBnaXZl
cyBhbiBvcHBvcnR1bml0eSB0byBCUEYNCj4gPiA+ID4gPiBMU01zDQo+ID4gPiA+ID4gdG8NCj4g
PiA+ID4gPiBhdHRhY2ggcGVybWlzc2lvbnMvcG9saWNpZXMgdG8gaXQgKG9uY2Ugd2UgaGF2ZSBh
IGZpbGUgbG9jYWwNCj4gPiA+ID4gPiBzdG9yYWdlDQo+ID4gPiA+ID4gbWFwKSBlLmcuIHdoZXRo
ZXIgY3JlYXRpbmcgYSB0YXNrIGl0ZXJhdG9yIGZvciB0aGF0IHNwZWNpZmljDQo+ID4gPiA+ID4g
cGlkZmQNCj4gPiA+ID4gPiBpbnN0YW5jZSAoYmFja2VkIGJ5IHRoZSBzdHJ1Y3QgZmlsZSkgd291
bGQgYmUgYWxsb3dlZCBvciBub3QuDQo+ID4gPiA+ID4gWW91IGFyZSB1c2luZyBnZXRwaWQgaW4g
dGhlIHNlbGZ0ZXN0IGFuZCBrZWVwaW5nIHRyYWNrIG9mDQo+ID4gPiA+ID4gbGFzdF90Z2lkDQo+
ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiB0aGUgaXRlcmF0b3IsIHNvIEkgZ3Vlc3MgeW91IGRvbid0
IGV2ZW4gbmVlZCB0byBleHRlbmQNCj4gPiA+ID4gPiBwaWRmZF9vcGVuDQo+ID4gPiA+ID4gdG8N
Cj4gPiA+ID4gPiB3b3JrIG9uIHRocmVhZCBJRHMgcmlnaHQgbm93IGZvciB5b3VyIHVzZSBjYXNl
IChhbmQgZmR0YWJsZQ0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IG1tDQo+ID4gPiA+ID4gYXJl
DQo+ID4gPiA+ID4gc2hhcmVkIGZvciBQT1NJWCB0aHJlYWRzIGFueXdheSwgc28gZm9yIHRob3Nl
IHR3byBpdCB3b24ndA0KPiA+ID4gPiA+IG1ha2UgYQ0KPiA+ID4gPiA+IGRpZmZlcmVuY2UpLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoYXQgaXMgeW91ciBvcGluaW9uPw0KPiA+ID4gPiANCj4g
PiA+ID4gRG8geW91IG1lYW4gcmVtb3ZlZCBib3RoIHRpZCBhbmQgdHlwZSwgYW5kIHJlcGxhY2Ug
dGhlbSB3aXRoIGENCj4gPiA+ID4gcGlkZmQ/DQo+ID4gPiA+IFdlIGNhbiBkbyB0aGF0IGluIHVh
cGksIHN0cnVjdCBicGZfbGlua19pbmZvLsKgIEJ1dCwgdGhlIGludGVyYWwNCj4gPiA+ID4gdHlw
ZXMsDQo+ID4gPiA+IGV4LiBicGZfaXRlcl9hdXhfaW5mbywgc3RpbGwgbmVlZCB0byB1c2UgdGlk
IG9yIHN0cnVjdCBmaWxlIHRvDQo+ID4gPiA+IGF2b2lkDQo+ID4gPiA+IGdldHRpbmcgZmlsZSBm
cm9tIHRoZSBwZXItcHJvY2VzcyBmZHRhYmxlLsKgIElzIHRoYXQgd2hhdCB5b3UNCj4gPiA+ID4g
bWVhbj8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFllcywganVzdCBmb3IgdGhlIFVBUEksIGl0
IGlzIHNpbWlsYXIgdG8gdGFraW5nIG1hcF9mZCBmb3IgbWFwDQo+ID4gPiBpdGVyLg0KPiA+ID4g
SW4gYnBmX2xpbmtfaW5mbyB3ZSBzaG91bGQgcmVwb3J0IGp1c3QgdGhlIHRpZCwganVzdCBsaWtl
IG1hcA0KPiA+ID4gaXRlcg0KPiA+ID4gcmVwb3J0cyBtYXBfaWQuDQo+ID4gDQo+ID4gSXQgc291
bmRzIGdvb2QgdG8gbWUuDQo+ID4gDQo+ID4gT25lIHRoaW5nIEkgbmVlZCBhIGNsYXJpZmljYXRp
b24uIFlvdSBtZW50aW9uZWQgdGhhdCBhIGZkID4gMA0KPiA+IGltcGxpZXMNCj4gPiBhdHRhY2hp
bmcgdG8gYSBzcGVjaWZpYyB0YXNrLCBob3dldmVyIGZkIGNhbiBiZSAwLiBTbywgaXQgc2hvdWxk
IGJlDQo+ID4gZmQNCj4gPiA+ID0gMC4gU28sIGl0IGZvcmNlcyB0aGUgdXNlciB0byBpbml0aWFs
aXplIHRoZSB2YWx1ZSBvZiBwaWRmZCB0byAtDQo+ID4gPiAxLg0KPiA+IFNvLCBmb3IgY29udmVu
aWVuY2UsIHdlIHN0aWxsIG5lZWQgYSBmaWVsZCBsaWtlICd0eXBlJyB0byBtYWtlIGl0DQo+ID4g
ZWFzeQ0KPiA+IHRvIGNyZWF0ZSBpdGVyYXRvcnMgd2l0aG91dCBhIGZpbHRlci4NCj4gPiANCj4g
DQo+IFJpZ2h0LCBidXQgaW4gbG90cyBvZiBCUEYgVUFQSSBmaWVsZHMsIGZkIDAgbWVhbnMgZmQg
aXMgdW5zZXQsIHNvIGl0DQo+IGlzIGZpbmUgdG8gcmVseSBvbiB0aGF0IGFzc3VtcHRpb24uIEZv
ciBlLmcuIGV2ZW4gZm9yIG1hcF9mZCwNCj4gYnBmX21hcF9lbGVtIGl0ZXJhdG9yIGNvbnNpZGVy
cyBmZCAwIHRvIGJlIHVuc2V0LiBUaGVuIHlvdSBkb24ndCBuZWVkDQo+IHRoZSB0eXBlIGZpZWxk
Lg0KDQpJIGp1c3QgcmVhbGl6ZSB0aGF0IHBpZGZkIG1heSBiZSBtZWFuaW5nbGVzcyBmb3IgdGhl
IGJwZl9saW5rX2luZm8NCnJldHVybmVkIGJ5IGJwZl9vYmpfZ2V0X2luZm9fYnlfZmQoKSBzaW5j
ZSB0aGUgb3JpZ2luIGZkIG1pZ2h0IGJlDQpjbG9zZWQgYWxyZWFkeS4gIFNvLCBJIHdpbGwgYWx3
YXlzIHNldCBpdCBhIHZhbHVlIG9mIDAuDQoNCg==
