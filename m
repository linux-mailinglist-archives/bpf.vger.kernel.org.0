Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38935F1752
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiJAAYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiJAAYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 20:24:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042D550AE
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 17:22:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UNApn8007787
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 17:22:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+y/a7BrcKME7lXpcG8GuLyKPT6pNQse2W1tkV1+N/eU=;
 b=nEgy8DIVXrMSK2pboIkWwPrX0lzmvCQGpaPjjcCe6PoA8k/KzPwaP9oSD8MJ6BTWdm08
 piMFKUzTl9pRQJrJWo0HNDoiBzhREyeGMVUwtcU5G4Udvm/DWuEV/zFy1tT0LL8gLo8J
 UtUFv4hUca0PGkjtjLj55V9SK/E+KIoI5C80BPJ0qek0pp5a0jEWHizdQ8lB6GRJvQTz
 vDjHum2ZS1q4/WEPldGVT+2qAJSl7x/bLHbiavHL42fnU4M6QgGooNIrx4jp9gAqP54W
 D/kJYWbwte8cTAufMp89DdSiqBQ+X+hsrpn4W0ReQ/fv5iiHU8/MCkTERsxVHKwtV/e2 rw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jx0t8vsyn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 17:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGN4cw+ko5LYMNWPb2MGwF3mQhNzkNC4jwtdAkmcHU0G6LhG0RExcA3RCmRZREg7PzRu0xsjah2tqxDajzk360SXXxiWuBJFJ49jxzr8TX3fkSCmskCSFQ+23ZE046/1WU6rYXAXI3mKo+yqIWnTZExRLQ59dMbrxhi4scKSJWPjwGtOHrhTLCzL7014t2Z3ouS/2wtbPhoh0/ispUKA11Kr0vWELiMxMpJXchn9D2YY248Mwh5aac6oxGHRtW3eHML6I4UFgyR+A+Nfan6ReL8zvA28GhKoeTGjegJ2Y/9+iEVQFs4Mg/xEo9qxjgR7JR7lyc6GcNtMck4UxcQv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y/a7BrcKME7lXpcG8GuLyKPT6pNQse2W1tkV1+N/eU=;
 b=Vw3SScQFNYtG0XxTij0ggybSAMhDTm9+f35OaIxtdm6xVJ4HQx8QYsJhy6a/sa0HD8zT++gh/ZOyYZI5yhDNXwMncsQrkBV/wdA1yyhjf4HKGb9EwlyLT8GTtCe3nIdwgAKB11y3/IbReFtRZw+fgJ4twPaHt84SuM3RAvYF/JT6RqjTO94hhthTj+g7zA2jdY+PTwuA36iYLedbjxu68L9GG/hkMJvMevtevmH0G6JSPwI0i3DLfTPtVHVs4+vg8Qpiav2n07Xwk4xytsxjwo4rAmFwMxYuKaV/sG+HnZSmvJDdmy/fGU7I3joerVM4yqMTEixqXFfQLH6guVfSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by PH7PR15MB5367.namprd15.prod.outlook.com (2603:10b6:510:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sat, 1 Oct
 2022 00:22:12 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::b17b:1311:51db:f45a]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::b17b:1311:51db:f45a%6]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 00:22:06 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     bpf <bpf@vger.kernel.org>
CC:     Mykola Lysenko <mykolal@meta.com>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: BPF office hours summary, September 2022
Thread-Topic: BPF office hours summary, September 2022
Thread-Index: AQHY1SvW2luZm6yFhkWpEUmiabq9oQ==
Date:   Sat, 1 Oct 2022 00:22:06 +0000
Message-ID: <F981E994-D336-45FD-9D1E-28A5785D3660@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|PH7PR15MB5367:EE_
x-ms-office365-filtering-correlation-id: 883fd4a7-115c-4386-2967-08daa342f8c4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t0lRrbNWLK3OKFQLRYUYSAu+W+3W6Vx8q4CGbPFaa9pFWZBZPbahAa6WH1t0sBdie90ql2A8JKUL3L7wZ1Umfc2xEZpFm1N9sVONDUr1H7oaDXhQMgKJBBXpb8x44/ZhymZLg/edjzIJ94t86ue/vHQ1kLEYw3R/at+rnVYnEDcVkb5pA973OK3Gv58jYWeBrfI/NMXCUJsYDNg1yTFofASo2Ikiu63Bh/Yk0czkP00kgqnFcK/yQKu3Iq4xvsTGFyvInSEM4vugSssWe2XDlin/9qRmtH9mdDi68/VhKYqBdmJzoztRl1N81mkP5ooj/5gfDjyNhBycGaj4HnM4wzAK/I8w4c40JQkA0eyHkDweWbU3PkxWb9l3l1cLylQ5KGMmemHZ5cF5z0J05VnIaZJ+kBiqkbliUuO6cx6+11SDa3a45AavnD0rNVeReT25gC2pmHM2oUWPUia7SckAjXwccNpZg3h3UhKlYtAfSQZlMEwZV+oASiEuHF73udTgG7i66VUUM1KuHKsTDW+g3sdZeRtlvh8gf0Uc7Lozg4YnPR76pV5dVeBi1Mi/xxGMpYlF9kJ6eEW7TEEBldAIySxWXf3d+kxQQm/VHy0kwBaxnlv50N+es4qqolTg2Mm3GNEl7iBZSX3EpG0RGQKbhfEnfv++MXnS3VkivUj+wme7wZ4wZ3kmXLRu58hThEhWVvFK2f1ENT6xjOxukuO3E3b7WX1nn4rzCdwBaT2Ph37IoruSkiQXWc65IO25LQkbxHZmh/WYt4phpDT32T4VyIFDiWC4iITqBj8yEls2XbqxOSg9OQeaV2NMtsUtZzTW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(38070700005)(8936002)(54906003)(5660300002)(6486002)(478600001)(66446008)(71200400001)(9686003)(6916009)(966005)(122000001)(6512007)(8676002)(6506007)(36756003)(66556008)(4744005)(316002)(186003)(4326008)(33656002)(76116006)(41300700001)(91956017)(83380400001)(64756008)(66476007)(86362001)(66946007)(5930299009)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXo3NVdoWFlQb0MyaGpWajhneUFubmxGUGZ6TDl6MG5oT1p0dWl6eEpDTFEy?=
 =?utf-8?B?T1dqV253ODVrYmg0aDZYemhXak5kVVZBVGR2TlJEeUVIdVZVOHZGR3RGcFZI?=
 =?utf-8?B?SERBNDZvMzNxSlBwdnN6cEd1dmpSM25EdU8zeDBhMkxkb2U2cWlUZHdwZjlZ?=
 =?utf-8?B?b0ppQVNrSFFYZEJXSXZ0ZWpTVEVpbHRDZHByR09IYm5Oc1I5d0p6TUZOMXRF?=
 =?utf-8?B?M3lwZ29Vc0ZLb1ZCTTR4bVNEcnd4VXZKU0lrWGNBb016UWlSNmlTTEhqM2N4?=
 =?utf-8?B?OEQyTk9nZjYrU0gzbXdlRkZpNVNyS1B2ZWRDUnM3aGhBS3BjcDJOdTgrd3NU?=
 =?utf-8?B?eUpTQ2ZmZ0podDZKMW9JVHN1UWRMeS9pZGxSUndKM09nanlOUWxpU1FJTncr?=
 =?utf-8?B?V21GRVRhbzk3ZHpOQjlzbGdYVmNDU0haYktxMHpzdWRNZTF0UWFabHBaalBY?=
 =?utf-8?B?Sm9haU5EUFl6S3NCK0JhcnpvUEZyMXo1V1dQQUdvUWxoT1RONDRnOEc3Zisw?=
 =?utf-8?B?UWRMaHdmblNYeTAxMzdsLzVhSnpEazVkaG45V1phTkcwQzlWVlJFWFVpamd0?=
 =?utf-8?B?WlhnaUdGMFQxdDBjZEFiYjBvdkowbmFPTGJIRXowc2J0UmhwcGk3bkZwZkRn?=
 =?utf-8?B?YzBpZmNGOFl1QmhLZTdKNjZNRVFkNTFTMkR4UzJ5eVdyaktSSWxxbk9oUG5x?=
 =?utf-8?B?aUdBcG5qMHNCZlZlSkw1cWYrcEJlbkdFc0YxSjh3U3V4WGpIaFdBVzQzY2V1?=
 =?utf-8?B?UTh2dFJOQkhPNnJFWnpsdS83aXpiRGxJNlRlVnRCV1gyY3dvYnBXYlgwajcw?=
 =?utf-8?B?S1ZEdk1CT1lhcEJBQ1E3ek9kdWFGdUpKNnp6VFV6YlZnamFMWEZaYUVlbWlO?=
 =?utf-8?B?eFVDaXVmQk1IOGtoSVhteWVMZ0R6ZStrc1hIcmRUdU94emR0d3RDcFYwVnpN?=
 =?utf-8?B?MDRDQ1hTRzMzUzh1alhQamdOTGFBQ1ZJNThJZVNnM0JNTTNMMW0vMVZCMnFw?=
 =?utf-8?B?eStOcU53N3p4dHJ3ZlZCOHJkL2g5LzRFdjVQWm54QU1rMzRYb2FpMTkySFQ5?=
 =?utf-8?B?dkdXTk1QZXVVeXY0bCtSSWxVc0xnNXB6a2NOMU1SZ0pRbVBDb3lCY2RrcGp3?=
 =?utf-8?B?clZOTUx2WXE5eUpEcFA1RGp1bnh0VjgwTnYyWHEzZWdDWGg0L2M4alhFU1dj?=
 =?utf-8?B?WVlEbkxQd3ZuSTRYRGREQTJOdVNZelFuck51L2IxYzd5VW5EY25PN1l4dDIz?=
 =?utf-8?B?MlFHY0pWWnJ0VU1WYjN6NWVhSEUyOHVLYU9IaEFiazlsYzlFczdjRVpBU1ZX?=
 =?utf-8?B?MGlyanAvdkZzZnlnLytjSDhCdmYybWpVOWhId0Q5NG5OaU8zK0IyYUJpRzg0?=
 =?utf-8?B?Y1JNMHFFZCtpVTd6VU9wM2JpdldCSUNzNStBUHRHQjNEOWpqMXArVU5PSDI2?=
 =?utf-8?B?VW1ua0w4d1VQVUZkU2RlQzBSYVZCb3lGdFc0QzMzWm9zc2xwR05WQ3pvK094?=
 =?utf-8?B?K0hxZkFIQ3VVNDhaNDJaTjNlZlA4VUVjQlhoWGdMeG8yeXlOcUtwVVF2Z1Nr?=
 =?utf-8?B?MG9SMk9sYm0wM1VKb0l0dGZ4L2VlcG0wSklqdC9lenBHZzlXeFZrKzRMVXB3?=
 =?utf-8?B?aDE2MUhSUENDOEJMOVlPWW1LVnZpZTlkRlFTYVllR3NpNHl3NGdWd1M5ZDlq?=
 =?utf-8?B?cHhBUWhSVE1MUWY5WnFpSVQ1TTRiMGhuc3VXRDRKQXc1T3BpMzhaVWNRR1VK?=
 =?utf-8?B?cUxKTHJWT1VNcG8xNHdSc0VTVmZSTmZJc3lWalFyczhPbXpjamJoMXBxSDZD?=
 =?utf-8?B?aFBvNzYySXlKeVVWSmYzRHN4UElidlN2a1VhNXgzemdkNHN1bG44SU1OL1hQ?=
 =?utf-8?B?U3c0alVaNjJDYUZwZkVWOXFLVTdKc0p6S0ZzbzZQNmladUE2ek1MZUlOT3Rm?=
 =?utf-8?B?TEhQQmJLNUpwdGR2dnRGeUJZZ0ZRWVpYTmNVRkpWVHF1eDZNZmEySWhhSFBv?=
 =?utf-8?B?eFdSZE9uK21iSXA0ZXJYT2pmcERFdjFidnlnKzl2MVhPcVBJSGxmMDlrVmtN?=
 =?utf-8?B?aGs2QnN6bnRET2YxeU5nd3UvWWtXUFc5cHJ1L2dyN0VVTUJjTkpOOWRwampu?=
 =?utf-8?B?L1VFQnBvdkdjT3FEUEJaZkZuWXNMVWhlNDFZWmFxMUs1bStVV25FYmE3MjFP?=
 =?utf-8?Q?Hij3Zqa9yU0YmrMFP7RRMOFPMhXkN405Dpq5OgBPXPX1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB9F4648EDEA534DAD1CADE535D29390@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883fd4a7-115c-4386-2967-08daa342f8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 00:22:06.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7IvqDyskJ0pdg31ziUKq/mJhT5Ap0YDUKFvJWrFD7KRhmxTZ/1ZIj4RciW5WLr8Eb/KXubvbH6yFua0GMXrbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5367
X-Proofpoint-GUID: 3S3pH9jg0SiXvX0bgEoufoo1E8OWJnuL
X-Proofpoint-ORIG-GUID: 3S3pH9jg0SiXvX0bgEoufoo1E8OWJnuL
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_05,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGVsbG8sDQoNCldlIGRpZCBub3QgaGF2ZSBvZmZpY2UgaG91cnMgdGhpcyBtb250aC4gTm90aGlu
ZyB0byBzdW1tYXJpemUgOi0pDQoNCldpbGwgdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRvIHJlbWlu
ZCBldmVyeW9uZSB0aGF0IHdlIGhhdmUgQlBGIG9mZmljZSBob3VycyBldmVyeSBUaHVyc2RheSBh
dCA5YW0gUFNULiBZb3UgY2FuIHNpZ24tdXAgaW4gWzFdLg0KDQpEb27igJl0IGJlIHNoeSEgSWYg
eW91IHRoaW5rIHRoYXQgaW4tcGVyc29uIGNvbnZlcnNhdGlvbiB3aXRoIEJQRiBtYWludGFpbmVy
cyBhbmQgY29tbXVuaXR5IGNhbiBoZWxwIHlvdXIgdXBzdHJlYW1pbmcgZWZmb3J0LCBkbyBzaWdu
LXVwLg0KDQpUaGFuayB5b3UhDQpNeWtvbGENCg0KWzFdIGh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L3NwcmVhZHNoZWV0cy9kLzFMZnJEWFo5LWZkaHZQRXBfTEhreEFNWXl4eHB3QlhqeXdXYTBBZWpF
dmVVL2VkaXQ=
