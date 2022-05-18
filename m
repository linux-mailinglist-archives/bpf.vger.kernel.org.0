Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F452B286
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 08:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiERGeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiERGef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 02:34:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F2E7306;
        Tue, 17 May 2022 23:34:33 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKFEot018431;
        Tue, 17 May 2022 23:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EPjGgY0A9QH/f8Wdus9EPIEcLOfWdmEWqO/QnAk6nDg=;
 b=ar7en1ajVfzC8Teqy1aKEUiAcMZKboojD8vTwXy/zyjtSnjbIXVjsfEai0osNUCCAYc1
 GHqazDt60E9NxvwWzEyFK1xnp/6uGNevSbpYiwVLn6Or0IsQUcS1r3Md2J1uaA5gNKjc
 7J7rlBxhqqqD9pXT5tbI8F62qOdRVDdqKOA= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d81wkjg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 23:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5/7MyBAnfFNDFSZQO/4PFuCzItyNDS+iMx+7FQyDfikZ+4xg0HGCjJ3xZ7tK5uLmE2rhdZ/iSCf1G7inftOSDPxmf68g85O8mPn6GIQbtmsVltDpfuAQgBOnvsUpWuccJQbC0UTdLy7Ew1ru/oWT4I1R5pzi4+ouCZxJJvZbwCFYOj5zLkloJ0sBPZ1+Hvz3mjbjSA2q05kpxynAy6eD9DNbUl2TPCGig506/e7I94Y0y+dpeZcdpUKiQvhtcIKo2mPHB5EZ0E7YUCZO/ObXzJVgLGpucab9XcRyya7qDWii9qM0E3nyu5Ls6IRkONPTb5Ug48j6HXUN/c84uyqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPjGgY0A9QH/f8Wdus9EPIEcLOfWdmEWqO/QnAk6nDg=;
 b=cVf0QPktRnSHdiW5u3LXIWmxqdUKCOfGFOLb/WXASV09Sx5iuEfI0qJESbTF8DOvAgYjnuXP51y2YErpZAYSVcmUVckfQ6cv63lFqTZNKnHFyEd9pvRI6UJtOENwVyRc03L+xHrxgDsDqUKj0ATW49xw60Tu97YUDKS4I32PJP5VeDMWwjMe9SwHb6ApvBDfD3GoR5kxBQ9pcyHbjb1G/Nhv2XUNAGzyJxoR9L0IWII7mNrn57k+ZlIPFB+1mAEfFnfYBnko0r/OOEulard18rHfcxpwyPo8U3jNIRBCfCBzSP+SkQEyqtKf/S4WDmVZ238BemNwvOIQFQdS+Wp/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3292.namprd15.prod.outlook.com (2603:10b6:5:167::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:34:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:34:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYCAAC+jgIAAbBSA
Date:   Wed, 18 May 2022 06:34:29 +0000
Message-ID: <42042EE3-EDDF-4DBF-AFD5-89A5CCC59AA3@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-6-song@kernel.org>
 <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
 <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
 <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
In-Reply-To: <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a27dc656-c3a0-412a-7f56-08da38987642
x-ms-traffictypediagnostic: DM6PR15MB3292:EE_
x-microsoft-antispam-prvs: <DM6PR15MB3292C577A81100480CC36DF0B3D19@DM6PR15MB3292.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgpQxMSWEvE0MMcuatcyKqzg7KJYczUIE98vPbOvMtS/eagIp0LxlXvZhS3oNgr+BNEddwNP4ek2IWQhcpw6Pp03XpvQ5Kfj3F4QubOowgb5fhVnPLCHcBgsydZQ3cUZEjF6eMa5VwfDBh6gwZUWWD9tDdQmBS9dNCP3T6DSapSCTQvAov6RDghJgPR57aY5SFDIaiblNYDI22IVOtUeANCwKALldn2AFAK2MISD9AR/rKCi4pgh0ZQ+gCzLhMum1wE/OjFYGFhSte4HELBl2B6DoJcF2FjAW8AUYspBfb2GRDVj0jULA2PoXETsciLD+cb/KDayVHBPuJohJbaIk6/YlaOWSQjBmJ63Hmk3Evefr/kjvbyhu0DVvXER+oadlos6kbRV5pQygBbht1DbXBIqNa0SvjOsvevljTHeygzpf/FfWO2DHvwLYcEA4ZI8OGk2bsJ+lmdNc+dRAQEIlfiXum0LlEcpofBBK3TFGYBW+ZoR8Ao71r4DIO4WvRVkTdep5zGlO0V5voejIrLL2Ku3NlaC5PHGFgOo+c3IbDk2XeW/9XdooX87BbpdwHSvlQJZ3Bqz2c83rfEQ55BGofXHAu7D9c+pfBY4cLJh2DX8Cl4hgaSrJ+VTCBNbTMMRu2CQBHColArEQDirVmZBHuOP1CJKSKmPtCxlBgSqpihg8XDnX7Cr9JShVTEVh0d6NveLYIQ8tlIVplaq7D1UuOY6OmSrUy7OLaVUUCyKUBDQwOfq5Re4KUseXdqIe1CQ3FbtX/ouxWGv3Fif8Y8JQz/u1xwZFrolNciCa0j4H1nAqkDiv4rTPHFsLsXLRof9R67r3F/KQLB6zeLZ6IgYs8ZODawuZv9BVOSmg0SOB3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(6506007)(64756008)(91956017)(8676002)(6916009)(54906003)(86362001)(71200400001)(36756003)(66556008)(6486002)(316002)(508600001)(83380400001)(38100700002)(966005)(2616005)(122000001)(38070700005)(186003)(8936002)(2906002)(66476007)(6512007)(66446008)(53546011)(33656002)(4326008)(5660300002)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q25qRkdiaXpiaDlMajZ1UkpleWJlMW9oWnZQaHh6cnFhWUpaMWVRVm9NNVVi?=
 =?utf-8?B?NEIzM08zRWNqbXNveGVYZXBNVzQyNWJVSWJLa2s1SHNKTUJ1ZzhEeXY1NkFG?=
 =?utf-8?B?L0lNbllQWEgybHF6NlBiRW5NL3VZQnFUZ2NoL2NRZjBKWHpOT1RiSlVqYzBF?=
 =?utf-8?B?TzVHRVVuazJ1bzlNMHdBRDZvNEFTVGl0dHFsU2MzenJJak5oN01td1IzUXIy?=
 =?utf-8?B?MVdSSDdMWEQxS2RtY3F1WGQ4T0ZONFpsNU5sRzlKWWIvZDAzbmxvcmpmMzln?=
 =?utf-8?B?RzArUTl0aWR4UDgwbDRVbVRaYnFpZjlueXk2WlJPSmJmdEhwREMySlNSclFL?=
 =?utf-8?B?dzlHSWdPaFpGb2FjU0hQYk9WZXAwajlSc2dtSEpySVpiWVdmVE5EbEpnWmVh?=
 =?utf-8?B?SFhGQW9oUnVPZ3VOWGZaK1Z4V0gzVVUwZVJndFFWWGkyZVFSMHlMdStDY3VT?=
 =?utf-8?B?S0JieXUrdnIxSlFZazVld0ZYL2RPN0xtNFkxNytJUS94UVhSVGZJRDBiWkVt?=
 =?utf-8?B?NkFna09md205QzdzU1U5UXc4aVdIdGhpa3lXNXZQN2F2aC9mWFhFUVpuUGc1?=
 =?utf-8?B?R09BSW0yeThPYVBtdGs0ekVjaVNBV0RueTRGUFN5bGdPUEFTVDBJTHJWVUg2?=
 =?utf-8?B?c1N6RFg3bFNoRGs5N05pbnJtTDZTWS92U0hGd2xOK0Yvb3grMzhaTWJxWmNx?=
 =?utf-8?B?d21lM3JQV1dYQTk1T3ladHlJako1VjFqbjZ5ZjUyM3lycnJXa3F6Q1JzUEx4?=
 =?utf-8?B?Qy9uK05IVHFFYk96WWsrQTZMWTFsMkVPQ1Z0c25rb2ZhRHM5YkFxWThtWkNH?=
 =?utf-8?B?bUZZbXQ4NnZUOGxwbTJYOFNKdWtiOVQvb0pRbytqcEdCdEpxN0Fsa2dCUXZN?=
 =?utf-8?B?dU80TWV5YkFtS0RKUlFOd0Uwc2FDTVVGcEZmb0tndG1XeHNZTUs0Z2IyMzFX?=
 =?utf-8?B?bUtPV01acktKNE8zZTQ0RGo5RWZPVVhoaHFkNDV1S29pajM4M0wvM1lhN2N4?=
 =?utf-8?B?SHNUWGtVMk5rek1jbUE0UnBBRWdINkhTdS81R2JRVHRBTjdNZGVYTkdGc1NW?=
 =?utf-8?B?R0MwSEgvQ2xGZVV4d0IyQzFjNDdaUlhhVi9VODBtUGY2ajdZZ0VDL1VYbFh0?=
 =?utf-8?B?T2U1MnlyM2tzaVh0QUFTTXh5YTVtQjc3cDlvaWN5cE1vZERTYW8rVUFwS0tI?=
 =?utf-8?B?bmVXa1VxeXFHTjBXekpWWjdLMlB5YWJQdUdqMlNiT29yUkt6NGczM3FtN0ZN?=
 =?utf-8?B?U3VkMkY2WUxUNkMxazVZbWFVWlhJeFJMT2hLc2JyWDRvYVROL1hTNmlqcW51?=
 =?utf-8?B?Ly9WV0ZOczlFeERZRHNjVjlZbHl4blA5dGhPQis2QjI3R2lCVDdvRzhpZ0Iv?=
 =?utf-8?B?cEZkcFJKTkxwRVp2NEhqTWJHWnFpMlhFU0EzTVRXNzU4MGZpbURyR21McGFU?=
 =?utf-8?B?bEtwbTBleUJTdXF5MmlmMkM4UFFmNiszdGdUZldEV0t1MmVWQktTQ1JhaEZC?=
 =?utf-8?B?czlING41T1E4aTRpT3F3NXNZdjhtOC8zT3RPZjBaT3NEekRHdlZ6QVlVSzVp?=
 =?utf-8?B?MGVnUktuSGJWUVVyMUVxdjZuUE1iYmkrNHVxZFFmMXh2MHJxb2ozdXNJNE1K?=
 =?utf-8?B?RDhRWExjZExNaFlIK2hUTkFsUm9VNzRxT29HMzFwSGxZdHpNdUFLYTUwSzNN?=
 =?utf-8?B?c3JDaFBFL3hiMnoyNi9zV3paZFA4SkpKWTFqRFlqVEJyaHFYa3oyZkxSWTRC?=
 =?utf-8?B?bVFXQnB5UWY0WERJdVdyaC9HZkppT1ZTVDJuRmpiaGZwSlVHc2J5NE5kV05M?=
 =?utf-8?B?akRNa3R6UDlqbVVJa2k4TTRVZlh0NC9BV0JKL01ZVnRxVTVzVWYwQ1Z6aHRa?=
 =?utf-8?B?eVdzMytNaDBSem5uYTVpaDRHQ0ZJdktTSmJINzQ5cWFMR254akdLYnJ2cThR?=
 =?utf-8?B?dHhoMzYySFlOWHJsU2VTNktKRkwwSUdyTzlkeWRkbUpPN0NDaFVkWEN4bzAz?=
 =?utf-8?B?dnhsbEVUQmVqSldWRUNlVU1xMHNqSTh0Um12cHlYVmhKVU9mS2tCKzRhVUF6?=
 =?utf-8?B?bHpPM1I0ZHprUElVYURmS0MvMDh6L09FdG1kZ1Q3Vks1aDM1N040RzJpTFd2?=
 =?utf-8?B?V1pNTkpheWhxODRBZjVPVDI0R1pTZ1F3N0piUDhVckZnWVcrdDNnMUY3VHo2?=
 =?utf-8?B?b0czV1djUklVYVg4MVIrYkNGcGZ5VU9hR2ozbUFzVjBRcFJINVYrT054c3Ez?=
 =?utf-8?B?dWg5YVZPeDlqc3lPNENxNHB6WkhnSGVlN1Z2U0tlOVFHZUJhVlI4Uyt1ZjBi?=
 =?utf-8?B?cWJFM3l2TzhhUC9DdVdkeEdQbEtEQ3VzaG5UMXNzSEFYM3BROVI0SU1qb3RL?=
 =?utf-8?Q?X+Yha3WtA1pWuWTaxkeHmR9ZphMG9IyX2MI6k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0946AAAB24BB914D9E25008FD536CDE1@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27dc656-c3a0-412a-7f56-08da38987642
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 06:34:29.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCOhg8jlInJn61YFIh3nxA7/NyA8QJX6kVdDsB47KGCBjTUciAOv11uGuX7J4kG3jOdUPVpJxzG0FI6NBUMdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3292
X-Proofpoint-GUID: 1SMt8c1MRODLvYXWP3fDdaU3jBig3PGS
X-Proofpoint-ORIG-GUID: 1SMt8c1MRODLvYXWP3fDdaU3jBig3PGS
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE3LCAyMDIyLCBhdCA0OjU4IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIyLTA1LTE3
IGF0IDIxOjA4ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4+PiBPbiBNYXkgMTcsIDIwMjIsIGF0
IDEyOjE1IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8DQo+Pj4gcmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFN1biwgMjAyMi0wNS0xNSBhdCAyMjo0MCAtMDcw
MCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4+IFVzZSBtb2R1bGVfYWxsb2NfaHVnZSBmb3IgYnBmX3By
b2dfcGFjayBzbyB0aGF0IEJQRiBwcm9ncmFtcyBzaXQNCj4+Pj4gb24NCj4+Pj4gUE1EX1NJWkUg
cGFnZXMuIFRoaXMgYmVuZWZpdHMgc3lzdGVtIHBlcmZvcm1hbmNlIGJ5IHJlZHVjaW5nIGlUTEIN
Cj4+Pj4gbWlzcw0KPj4+PiByYXRlLiBCZW5jaG1hcmsgb2YgYSByZWFsIHdlYiBzZXJ2aWNlIHdv
cmtsb2FkIHNob3dzIHRoaXMgY2hhbmdlDQo+Pj4+IGdpdmVzDQo+Pj4+IGFub3RoZXIgfjAuMiUg
cGVyZm9ybWFuY2UgYm9vc3Qgb24gdG9wIG9mIFBBR0VfU0laRSBicGZfcHJvZ19wYWNrDQo+Pj4+
ICh3aGljaCBpbXByb3ZlIHN5c3RlbSB0aHJvdWdocHV0IGJ5IH4wLjUlKS4NCj4+PiANCj4+PiAw
LjclIHNvdW5kcyBnb29kIGFzIGEgd2hvbGUuIEhvdyBzdXJlIGFyZSB5b3Ugb2YgdGhhdCArMC4y
JT8gV2FzDQo+Pj4gdGhpcyBhDQo+Pj4gYmlnIGF2ZXJhZ2VkIHRlc3Q/DQo+PiANCj4+IFllcywg
dGhpcyB3YXMgYSB0ZXN0IGJldHdlZW4gdHdvIHRpZXJzIHdpdGggMTArIHNlcnZlcnMgb24gZWFj
aA0KPj4gdGllci4gIA0KPj4gV2UgdG9vayB0aGUgYXZlcmFnZSBwZXJmb3JtYW5jZSBvdmVyIGEg
ZmV3IGhvdXJzIG9mIHNoYWRvdyB3b3JrbG9hZC4gDQo+IA0KPiBBd2Vzb21lLiBTb3VuZHMgZ3Jl
YXQuDQo+IA0KPj4gDQo+Pj4gDQo+Pj4+IA0KPj4+PiBBbHNvLCByZW1vdmUgc2V0X3ZtX2ZsdXNo
X3Jlc2V0X3Blcm1zKCkgZnJvbSBhbGxvY19uZXdfcGFjaygpIGFuZA0KPj4+PiB1c2UNCj4+Pj4g
c2V0X21lbW9yeV9bbnh8cnddIGluIGJwZl9wcm9nX3BhY2tfZnJlZSgpLiBUaGlzIGlzIGJlY2F1
c2UNCj4+Pj4gVk1fRkxVU0hfUkVTRVRfUEVSTVMgZG9lcyBub3Qgd29yayB3aXRoIGh1Z2UgcGFn
ZXMgeWV0LiBbMV0NCj4+Pj4gDQo+Pj4+IFsxXSANCj4+Pj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2JwZi9hZWVlYWYwYjdlYzYzZmRiYTU1ZDQ4MzRkMmY1MjRkOGJmMDViNzFiLmNhbWVs
QGludGVsLmNvbS8NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20+DQo+Pj4gDQo+Pj4gQXMgSSBzYWlkIGJlZm9yZSwgSSB0aGluayB0
aGlzIHdpbGwgd29yayBmdW5jdGlvbmFsbHkuIEJ1dCBJIG1lYW50DQo+Pj4gaXQNCj4+PiBhcyBh
IHF1aWNrIGZpeCB3aGVuIHdlIHdlcmUgdGFsa2luZyBhYm91dCBwYXRjaGluZyB0aGlzIHVwIHRv
IGtlZXANCj4+PiBpdA0KPj4+IGVuYWJsZWQgdXBzdHJlYW0uDQo+Pj4gDQo+Pj4gU28gbm93LCBz
aG91bGQgd2UgbWFrZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyB3b3JrIHByb3Blcmx5IHdpdGggaHVn
ZQ0KPj4+IHBhZ2VzPyBUaGUgbWFpbiBiZW5lZml0IHdvdWxkIGJlIHRvIGtlZXAgdGhlIHRlYXIg
ZG93biBvZiB0aGVzZQ0KPj4+IHR5cGVzDQo+Pj4gb2YgYWxsb2NhdGlvbnMgY29uc2lzdGVudCBm
b3IgY29ycmVjdG5lc3MgcmVhc29ucy4gVGhlIFRMQiBmbHVzaA0KPj4+IG1pbmltaXppbmcgZGlm
ZmVyZW5jZXMgYXJlIHByb2JhYmx5IGxlc3MgaW1wYWN0ZnVsIGdpdmVuIHRoZQ0KPj4+IGNhY2hp
bmcNCj4+PiBpbnRyb2R1Y2VkIGhlcmUuIEF0IHRoZSB2ZXJ5IGxlYXN0IHRob3VnaCwgd2Ugc2hv
dWxkIGhhdmUgKG9yIGhhdmUNCj4+PiBhbHJlYWR5IGhhZCkgc29tZSBXQVJOIGlmIHBlb3BsZSB0
cnkgdG8gdXNlIGl0IHdpdGggaHVnZSBwYWdlcy4NCj4+IA0KPj4gSSBhbSBub3QgcXVpdGUgc3Vy
ZSB0aGUgZXhhY3Qgd29yayBuZWVkZWQgaGVyZS4gUmljaywgd291bGQgeW91IGhhdmUNCj4+IHRp
bWUgdG8gZW5hYmxlIFZNX0ZMVVNIX1JFU0VUX1BFUk1TIGZvciBodWdlIHBhZ2VzPyBHaXZlbiB0
aGUgbWVyZ2UgDQo+PiB3aW5kb3cgaXMgY29taW5nIHNvb24sIEkgZ3Vlc3Mgd2UgbmVlZCBjdXJy
ZW50IHdvcmsgYXJvdW5kIGluIDUuMTkuIA0KPiANCj4gSSB3b3VsZCBoYXZlIGhhcmQgdGltZSBz
cXVlZXppbmcgdGhhdCBpbiBub3cuIFRoZSB2bWFsbG9jIHBhcnQgaXMgZWFzeSwNCj4gSSB0aGlu
ayBJIGFscmVhZHkgcG9zdGVkIGEgZGlmZi4gQnV0IGZpcnN0IGhpYmVybmF0ZSBuZWVkcyB0byBi
ZQ0KPiBjaGFuZ2VkIHRvIG5vdCBjYXJlIGFib3V0IGRpcmVjdCBtYXAgcGFnZSBzaXplcy4NCg0K
SSBndWVzcyBJIG1pc3NlZCB0aGUgZGlmZiwgY291bGQgeW91IHBsZWFzZSBzZW5kIGEgbGluayB0
byBpdD8NCg0KPiANCj4+IA0KPj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29u
Z0BrZXJuZWwub3JnPg0KPj4+PiAtLS0NCj4+Pj4ga2VybmVsL2JwZi9jb3JlLmMgfCAxMiArKysr
KysrLS0tLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBiL2tlcm5l
bC9icGYvY29yZS5jDQo+Pj4+IGluZGV4IGNhY2Q4Njg0YzNjNC4uYjY0ZDkxZmNiMGJhIDEwMDY0
NA0KPj4+PiAtLS0gYS9rZXJuZWwvYnBmL2NvcmUuYw0KPj4+PiArKysgYi9rZXJuZWwvYnBmL2Nv
cmUuYw0KPj4+PiBAQCAtODU3LDcgKzg1Nyw3IEBAIHN0YXRpYyBzaXplX3Qgc2VsZWN0X2JwZl9w
cm9nX3BhY2tfc2l6ZSh2b2lkKQ0KPj4+PiAgICAgIHZvaWQgKnB0cjsNCj4+Pj4gDQo+Pj4+ICAg
ICAgc2l6ZSA9IEJQRl9IUEFHRV9TSVpFICogbnVtX29ubGluZV9ub2RlcygpOw0KPj4+PiAtICAg
IHB0ciA9IG1vZHVsZV9hbGxvYyhzaXplKTsNCj4+Pj4gKyAgICBwdHIgPSBtb2R1bGVfYWxsb2Nf
aHVnZShzaXplKTsNCj4+PiANCj4+PiBUaGlzIHNlbGVjdF9icGZfcHJvZ19wYWNrX3NpemUoKSBm
dW5jdGlvbiBhbHdheXMgc2VlbWVkIHdlaXJkIC0NCj4+PiBkb2luZyBhDQo+Pj4gYmlnIGFsbG9j
YXRpb24gYW5kIHRoZW4gaW1tZWRpYXRlbHkgZnJlZWluZy4gQ2FuJ3QgaXQgY2hlY2sgYQ0KPj4+
IGNvbmZpZw0KPj4+IGZvciB2bWFsbG9jIGh1Z2UgcGFnZSBzdXBwb3J0Pw0KPj4gDQo+PiBZZXMs
IGl0IGlzIHdlaXJkLiBDaGVja2luZyBhIGNvbmZpZyBpcyBub3QgZW5vdWdoIGhlcmUuIFdlIGFs
c28gbmVlZA0KPj4gdG8gDQo+PiBjaGVjayB2bWFwX2FsbG93X2h1Z2UsIHdoaWNoIGlzIGNvbnRy
b2xsZWQgYnkgYm9vdCBwYXJhbWV0ZXINCj4+IG5vaHVnZWlvbWFwLiANCj4+IEkgaGF2ZW7igJl0
IGdvdCBhIGJldHRlciBzb2x1dGlvbiBmb3IgdGhpcy4gDQo+IA0KPiBJdCdzIHRvbyB3ZWlyZC4g
V2Ugc2hvdWxkIGV4cG9zZSB3aGF0cyBuZWVkZWQgaW4gdm1hbGxvYy4NCj4gaHVnZV92bWFsbG9j
X3N1cHBvcnRlZCgpIG9yIHNvbWV0aGluZy4NCg0KWWVhaCwgdGhpcyBzaG91bGQgd29yay4gSSB3
aWxsIGdldCBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBuZXh0IA0KdmVyc2lvbi4NCg0KPiAN
Cj4gSSdtIGFsc28gbm90IGNsZWFyIHdoeSB3ZSB3b3VsZG4ndCB3YW50IHRvIHVzZSB0aGUgcHJv
ZyBwYWNrIGFsbG9jYXRvcg0KPiBldmVuIGlmIHZtYWxsb2MgaHVnZSBwYWdlcyB3YXMgZGlzYWJs
ZWQuIERvZXNuJ3QgaXQgaW1wcm92ZSBwZXJmb3JtYW5jZQ0KPiBldmVuIHdpdGggc21hbGwgcGFn
ZSBzaXplcywgcGVyIHlvdXIgYmVuY2htYXJrcz8gV2hhdCBpcyB0aGUgZG93bnNpZGUNCj4gdG8g
anVzdCBhbHdheXMgdXNpbmcgaXQ/DQoNCldpdGggY3VycmVudCB2ZXJzaW9uLCB3aGVuIGh1Z2Ug
cGFnZSBpcyBkaXNhYmxlZCwgdGhlIHByb2cgcGFjayBhbGxvY2F0b3INCndpbGwgdXNlIDRrQiBw
YWdlcyBmb3IgZWFjaCBwYWNrLiBXZSBzdGlsbCBnZXQgYWJvdXQgMC41JSBwZXJmb3JtYW5jZQ0K
aW1wcm92ZW1lbnQgd2l0aCA0a0IgcHJvZyBwYWNrcy4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=
