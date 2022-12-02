Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CB640502
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLBKqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 05:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiLBKqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 05:46:34 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2083.outbound.protection.outlook.com [40.107.12.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2913CFE77
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 02:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZrtl25udLYZDY7mKOzWOFWDLVvSubhtJW89EWuWVITUl2oNBS0mBn5tl7zORdG641a6SNclyiYs9rQy67X1FGZ3lFq49V2mRk3CTUM1UejQtznniJnWI0aJHgeNsDZxtHMwPARrliBOF9y/Vc5qrsZavnWJ20dIg2aTEhq3g7gnVbju5UYYROeQS4iDM9qON06Ib7Y0DQNh6mQ2b5YSvP6U2IhVpyAjkNnVeD9XbwsE1aOyK6PdTmLtPUWPiy9LXpgbURvsNqzPTj5mhJC5eejzdkrn5oq5nts63eT8bOwR0k/ncpUCNYG/jGXn1kTrhWbREMqLZXowJOHhZ1WTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DdF6nEgK/raM+CP8HRWbLVhXy+JclOi/m0IXs8f/jA=;
 b=NmvyYzStlXulT8RRcg9RRTTJxESrEeKzDucmfuuqgGOd+a64rW2MTCucOX81RVDywQc1Ir3Lamm9ToinXDAvEnkzY1p+RUPNJ2hYA3Z14aQEzkfUXv54nbXFbf/aCzhaPh4VaRnPUnMJfgTX2MNZL+ULOQ49qgeaPcqyEFub5lFNvYxhn86cP7uDs1qItz+HgRsFN2Pt5mU2BedNHrNmaDSWmMNCEoqb3Hb5OFnjiv+A7e/SzHmhrPAjbr44MMNj4orm5ufjq1aQuBb37HB82uJdjtMTJXdoBrLXJgwgolmvOblJBLhWAPy5jAwRe1Zzpp0MowzEWKMhmGsSIk5JuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DdF6nEgK/raM+CP8HRWbLVhXy+JclOi/m0IXs8f/jA=;
 b=1L8ZaKP5mPC6vbbbuVLwQv6q9MzqRuepxvfeZf4Xf+pIHu5o1hsln5mUrxH8xlPyzisY2ZJf6zAUwAvtvwdm6vd4ndRPgDQ2cECdw1iPQCc3TkczcpTsclkwAt81vxFKamlKSmAJQxaWF6v9SW6EA7ibdtNpm39vPdYgoDZjGrxjwaHEo4/yyFpww4XkUrc+lDuI+zSOhM8nB2WjgJ2gV0uMj2cF9H+ih7g/0CM4LHbyLKAwTEIPM86P7ffjcXSqSq4QAVPdaSiXz3R4ia4qLttVzHVrvzbl1X5UMol+z2YnpkSeroHw5PLNjmxbDHhlNoA9ailZs9No8kw252pSDA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3448.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 10:46:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 10:46:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Thomas Gleixner <tglx@linutronix.de>, Song Liu <song@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq4/PciAgBaVcoCAAHZiAIAAbN6AgAESV4CAARoiAIAAri6AgABmeACAAJkeAA==
Date:   Fri, 2 Dec 2022 10:46:30 +0000
Message-ID: <5fb21965-48c8-e795-632a-fa190470abe8@csgroup.eu>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
In-Reply-To: <87k03ar3e3.ffs@tglx>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3448:EE_
x-ms-office365-filtering-correlation-id: 38893866-f821-4ee3-b5b4-08dad45278a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciWWuj95dPPBufhS9/nFRdrt+E+KtheF+znpqoVvo/k0pP6dSVySlhRR1RhKTd9wWaiblbdlaL0iUZr/FP4WoqAZiK4VySH4bLO6R8k3/uZoDBKxVcvgvdRu3HdujpqJUUtTnQJQaCb9eUGfunEko/8wHUcMtEpCgsJ36qjbdLwGZPeU5Soyoa1mmvpJtZ161M1PI5qlKJWiWrwTwoCGBvd9I8y5g7KrrtmxaReuFVE31UO38H7kwviPsaK2w8KnZjd0rlu6q/kOwEhLX5xvtbl+l7V4wIMuPUDhun1ShyzO9mXJG1TrMYIg71phJWjZPQQ2Q2X1rzZ5TpnprTkmsww1puJzUJAM192hAWKRjp9ssD0+i5aCXvv+5lcLqU/udExc0TQPfC6pwY8n3yVK73ulr5P0UToj4r4Ro1F3kbWhlROYXPHCpuDRqtqrTPnJUQ8fs1Yh8iXQkiwbnxGOMdIQSgg2yfC2iByHoLoB/FVrX8Q3Zx2jfYRgSpzgU3t+WKw8ka36dgUBuKqKe+OmkDX6CpYVmLnn6j7zTDQ1SsaRTLdHk2O+BriZ7dybwGQQGQfsTCgKEXHeFCnJaxd9qspcPkzKi/WDSPj+tZZ9ORfs2oPcnKO0F9ZKd/w1MHGRKsyQ+fyrj4OjJC1hYqXM0Tbs9g6/KSQAN3MIQEXhqGmt4LUvqXBXCKgZuCuJzaXQAe0YVd8QgGPqcthof3+vs+wbIZlstlBPj2iBxGP0Mz7/dNHj8vqgp5kzocUfWbYFChlwP8jRmORBXjfOLJaatA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(6506007)(6486002)(6512007)(26005)(186003)(316002)(478600001)(54906003)(110136005)(91956017)(64756008)(66476007)(8676002)(66446008)(71200400001)(4326008)(31686004)(76116006)(66946007)(66556008)(2616005)(5660300002)(41300700001)(8936002)(7416002)(44832011)(2906002)(83380400001)(36756003)(86362001)(122000001)(38100700002)(31696002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y01MWGV6RThTa0RldnY1Ri9yalM0dXptbUdoMHpMS1pNU3JaV2c1UjdCSUlp?=
 =?utf-8?B?QWFxUmV0SExYRS9vMFQrTE4yOTV1RzVqcUdlYVQ0VURwb1hSR29mVE44T25T?=
 =?utf-8?B?OXlEUGdNTjBRMk9RNE42WU1ZYlJoRWRzcVE3bE5lRWw0dmdCNElFeEtzMTNs?=
 =?utf-8?B?ODlndHI3dmViQlFGbktHQUZqdHBjZWpFb2NxNndYSG9VT1NzQ3d0V09FcEJB?=
 =?utf-8?B?cVNFaDVySHdWbFZjWWNOb1BzdmVSWWdwMWk4RHh0WnhWNDlDLzNmRFJ2UjVX?=
 =?utf-8?B?UDlySGEyRnpSQWpZeStuZWVNYWJpVVRjS21obHBQNnBmRENHK1FDa21RbXRM?=
 =?utf-8?B?MzBhVlF3b1dPMVhFYXpjZElVSENtek1NVElkcHlIbmljWEpZY2o1dUUzR2s3?=
 =?utf-8?B?QTl4VkR3ellDemNCSGhYV05uNFFVelRlczBYb1E4OStZNEliTVFKODlENGhn?=
 =?utf-8?B?VHRCa2pDUXREZUg5aWRTR0hoRGlSMnlhZ3FEUlNFRzZMMHMrdzcwaUlsanFi?=
 =?utf-8?B?QUZkQlVkSlNweHhlMHkxNXhWOHJpeUdHbnBMWUlNYUFVMW55ZFdOb244OWlC?=
 =?utf-8?B?ZXhIS040ekgrQTdWK0g4RkFDVzVmK3hSVC9zKzZJSHRHeVMxcVBrLzhMUnVE?=
 =?utf-8?B?UFdOajZORXh2MEcvaWI1U0dlTEEwbTBkT2g4aXlnaGZibEk5RkZad2FKUFYr?=
 =?utf-8?B?UEljS2prTGZnR1RteDNyMTBiYmFaL0tRNkFyS1pzQktmZEJQdWVKT0NpTmtt?=
 =?utf-8?B?c3dSMm81VFREMWw2VDRzRm9vWDNjUXNReFZIcm5hbWx0UjR1NmdDMzd6UW9X?=
 =?utf-8?B?MWcwQ2p2UGVrMWpkRFNaVm5CS3h2Vnk2Y3VTVStNcnV2NitZeEozcURpeEZp?=
 =?utf-8?B?Q1liSnZDaEYxNDRZek95WFUvdXdyVmsyczJnOUJGbXdHZXo4bFVnRkUwb0Zu?=
 =?utf-8?B?aThITWlROWJjVW53amJoUWFNdWNBK21rWXZvUk1sbGtYRTNPcExLK1IwbEpZ?=
 =?utf-8?B?TkVWUzN3Q01Gc2FnMy93QTgvamJySkJLT1RMVHRucjFjanVlanlNazA2Nkdw?=
 =?utf-8?B?SWR1dVFFUHdlcmQwMHN5ckt1b0dvdDBaVW9LT2hqVkJiZzJOR3hrNWJTQitn?=
 =?utf-8?B?VDRCN2Y3WmdVa1B5dzF1NWVSNkJmY1NvWDNJVFU1QWdIeG1memJ5ZFl3OTVC?=
 =?utf-8?B?WUhYUW1sVDFERXJqdHpwS3BHclU2OUhjRXNOZlV1Yk9mWXdNdlJPelFQOHJ3?=
 =?utf-8?B?NEJ3SGlXamZuYk9Lbi80ZjV4QTJZMVo3ZDBwdSttY3hPb05tSGhQYVlpK0dG?=
 =?utf-8?B?b3JhdVdYRzVQSkJlR3ZPRHIvVFV3NjZuOUVWSFVNcUN0QnM3cjdLYklBNzF6?=
 =?utf-8?B?Mk92VjVvNGVUQ3FhdGZoL3JZMHk3TjhFaXBTMmNqTlNiMmwrZmt1aEZIbm1h?=
 =?utf-8?B?Z0FpdG1CZHBMMUJMNC9qVTFrbE1FOU85TUFUZkFHL1VqNHptejZVOTZGMUt6?=
 =?utf-8?B?ZTVwa2I0TDJBb1RzQnhTdFRlREpBRlBQY09hdXdIZWZtam9MWFlUdlVxbUp5?=
 =?utf-8?B?c3ZsTUZVOU9iSkdvajJEL1kyNWJackdtMjhaUExLcXkxelVwR2xNZ2lUbVR0?=
 =?utf-8?B?NmdVQTRwOGY1MGFMWUY1RzROVkhZUVFwWEhwOWowOWQ3M1FDZmVRcVlDWkRl?=
 =?utf-8?B?YlVwcjAybXNrS1gydDd0cTFMQ2k2WFBzdXFWLzJqSzh5UjRJeUFDUmJhbzYz?=
 =?utf-8?B?VVVBeWVmeW00czZKUHcxMXYxZitmTkV4T3dOeUdDRTAzejNYTDkwS2hweVcw?=
 =?utf-8?B?NnU1cnQxU2xhbWJhQTQ0b2xZaTcwK1ZLNTlLdDByd0lDZjVBTXVlaFFOaVU1?=
 =?utf-8?B?eUdCWUgyZUJ4ajVyU1VyUGI3WGVHRm4wY3owN3dRZmpFLy9yeHBlUnpSVkF0?=
 =?utf-8?B?TUdvYnJ3cGg0aEFUdEtITDRTSjRGTmo1L3ZpUlNqNnpnSVVSbzJ6d1VDczhj?=
 =?utf-8?B?S3hEcm9weHhBbnNJRHhJdENWc21ac3UzMFlZdVhBQnVCMlFRWDhtU2JZNjJv?=
 =?utf-8?B?OFd0c3F4RkdleC9Ub28xTkhNZmZIbTlQeXgxR0tDZ2xtMmJSbyt0Y2VNdnB6?=
 =?utf-8?B?cW9oR0dwUjdwbmlWbmtZZzVNSHpmT0wzMVV4L0J0SmZvanZkZDRhbUtic0Fx?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BE42C68EB9B354CAA1BF36E48FA4C52@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38893866-f821-4ee3-b5b4-08dad45278a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 10:46:30.2410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dw9714sJwlnvA+fHmdwx0uCB6beyaKi2e0p6UXMnnzDrQReIWiFvFKW7LlhOqJdWDriRSEU0zeL5+cp+IXpQnEyD/qY4mxiawvBS3e6qKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3448
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDAyLzEyLzIwMjIgw6AgMDI6MzgsIFRob21hcyBHbGVpeG5lciBhIMOpY3JpdMKgOg0K
PiANCj4+PiBBbHRlcm5hdGl2ZWx5LCBpbnN0ZWFkIG9mIHNwbGl0dGluZyB0aGUgbW9kdWxlIGFk
ZHJlc3Mgc3BhY2UsIHRoZQ0KPj4+IGFsbG9jYXRpb24gbWVjaGFuaXNtIGNhbiBrZWVwIHRyYWNr
IG9mIHRoZSB0eXBlcyAodGV4dCwgZGF0YSwgcm9kYXRhKQ0KPj4+IGFuZCBtYW5hZ2UgbGFyZ2Ug
bWFwcGluZyBibG9ja3MgcGVyIHR5cGUuIFRoZXJlIGFyZSBwcm9zIGFuZCBjb25zIGZvcg0KPj4+
IGJvdGggYXBwcm9hY2hlcywgc28gdGhhdCBuZWVkcyBzb21lIHRob3VnaHQuDQo+Pg0KPj4gQUZB
SUNULCB0aGUgbmV3IGFsbG9jYXRvciAobGV0J3MgY2FsbCBpdCBtb2R1bGVfYWxsb2NfbmV3IGhl
cmUpDQo+PiByZXF1aXJlcyBxdWl0ZSBzb21lIGRpZmZlcmVudCBsb2dpYyB0aGFuIHRoZSBleGlz
dGluZyB2bWFsbG9jIGxvZ2ljIChvcg0KPj4gbW9kdWxlX2FsbG9jIGxvZ2ljKToNCj4gDQo+IE9i
dmlvdXNseS4NCj4gDQo+PiAxLiB2bWFsbG9jIGlzIGF0IGxlYXN0IFBBR0VfU0laRSBncmFudWxh
cml0eTsgd2hpbGUgZnRyYWNlLCBicGYgZXRjIHdvdWxkDQo+PiAgICAgIGJlbmVmaXQgZnJvbSBh
IG11Y2ggc21hbGxlciBncmFudWxhcml0eS4NCj4gDQo+IEV2ZW4gbW9kdWxlcyBjYW4gYmVuZWZp
dCBmcm9tIHRoYXQuIFRoZSBmYWN0IHRoYXQgbW9kdWxlcyBoYXZlIGFsbA0KPiBzZWN0aW9ucyAo
dGV4dCwgZGF0YSwgcm9kYXRhKSBwYWdlIGFsaWduZWQgYW5kIHBhZ2UgZ3JhbnVsYXIgaXMgbm90
IGR1ZQ0KPiB0byBhbiByZXF1aXJlbWVudCBvZiBtb2R1bGVzLCBpdCdzIHNvIGJlY2F1c2UgdGhh
dCdzIGhvdyBtb2R1bGVfYWxsb2MoKQ0KPiB3b3JrcyBhbmQgdGhlIG1vZHVsZSBsYXlvdXQgaGFz
IGJlZW4gYWRvcHRlZCB0byBpdC4NCg0KDQpTZWN0aW9ucyBhcmUgcGFnZSBhbGlnbmVkIG9ubHkg
d2hlbiBTVFJJQ1RfTU9EVUxFX1JXWCBpcyBzZWxlY3RlZC4NCg0KU2VlIGNvbW1pdCAzYjViZTE2
YzdlOTAgKCJtb2R1bGVzOiBwYWdlLWFsaWduIG1vZHVsZSBzZWN0aW9uIGFsbG9jYXRpb25zIA0K
b25seSBmb3IgYXJjaGVzIHN1cHBvcnRpbmcgc3RyaWN0IG1vZHVsZSByd3giKQ0KDQpUb2RheSBp
dCBpcyBpbXBsZW1lbnRlZCBhcyBmb2xsb3dzOg0KDQoJc3RhdGljIGlubGluZSB1bnNpZ25lZCBp
bnQgc3RyaWN0X2FsaWduKHVuc2lnbmVkIGludCBzaXplKQ0KCXsNCgkJaWYgKElTX0VOQUJMRUQo
Q09ORklHX1NUUklDVF9NT0RVTEVfUldYKSkNCgkJCXJldHVybiBQQUdFX0FMSUdOKHNpemUpOw0K
CQllbHNlDQoJCQlyZXR1cm4gc2l6ZTsNCgl9DQoNCg0KQ2hyaXN0b3BoZQ0K
