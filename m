Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D09559B45
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiFXOOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiFXOOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:18 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C6506D8
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 07:14:17 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 41B54C3CC5
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1656080057; bh=NPCwkSuUigDjyVo2RsAn7cP0BD9rwZP+oqwrf94uybg=;
        h=From:To:Subject:Date:From;
        b=R2IaNMrvpQBE3mefs25JojZQbt4lQGYkaVBlw9s6JFtlwT3VtOfOI+H/si/K2xJak
         OMcdIivnldw4vT58Ahv+mr6VMN8W7QkM1/nKoIpBajzQ6LJQ92oVm0dY4GH6aHnZSc
         EAylOr6uQwAiDHlSn9vzJ4SB6kaEIv/UC7jZysH9OT3TxknFBZUeHYx0Ckxnx8PnLR
         oVCShL7APxjuoQGyZIDdEzSU80sUw+Ixfsey3ts0FoIzztk/Jh/SzTfDmluZNR6JKU
         ozL6rxWksrH4vq8ZUeXT0SDf9Ngb9EcHrV90LfLqgrP4qMt6x77gDn3bpwkAZ8iTBc
         LijYkFqtTJZqA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CC53DA0086
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:14:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1598B80002
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:14:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="bJdHUi3v";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G47CgJmRA3S0GZuX7RP7Vxyzgx1pDkkjUG5JQ7sT+uj/IMioJzkAclM6M/eFPVh4oVwwQoo66h+ZWhD3S6sIXWMyf4EehKNo2kHmxkv59yHCZyJib2AXjd4sfzNJ7n+8eg45KwlELoeqlRKfszSuiRq7Q9ORKtYKmubVoP9Ro4x01/sMSZKkelsEmdcMZAIeCCed9gmNBdAXIep4do2ofHNPR6KTOsfDUHql/owHvW4aBQGhxM/yuOPrNralpIIYcdo36tLF1czRHPgq1V+SLrD4s7SSM1QYpLp+BwiME6Kdu2Iwty3kHgHYeyVMRqqtsQ1mzaCGSGAgyqUsABHr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPCwkSuUigDjyVo2RsAn7cP0BD9rwZP+oqwrf94uybg=;
 b=DU/cnUHOSGGqjOepFmQplMp+OOgEIbeBQ9MhCFP/bZ/q3ZpUWhSgknw/YMFHWdTR9qebYSPOiUDpm0VPDtzOEfrIlG6Plxm1LdbEyBMvVjL6pn0ypMhGjjm9LMwuRdzeFtDi6yTh+6SgLAz7AYyepVuEY/bFZ1Baj/qZuH5Um/4pGnTuDD02V26g2frpaGGVivqtB/r3asuTEK7MBoP7/v0FiBUxJZl5Btmgtx7PNz9RxkDGGHwr7uzWf+e+KKdF8EPrtOSvN6JqpKs0CZVR0D3oGp7EdSS08KBF0itFKmZeyx4tu6dLCjfr312854uKxXnMUOoxforY260sqj+mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPCwkSuUigDjyVo2RsAn7cP0BD9rwZP+oqwrf94uybg=;
 b=bJdHUi3vnlatd7nLvZ5bfVLB4BjCl077MPkKiS31EyoYKrl/n52AOOJ+GmxN6nvwANH0BOHxukCiIF7FWb5Wz0k6OsmlYp2tr+XomSfU/BE+xrTyY2I7OgmVOqYoPReusVUTvMTs3WXDq/rhRRNw/7OGPNpq1pgl4WuBUoHFHVE=
Received: from SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 14:14:11 +0000
Received: from SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4]) by SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 14:14:11 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH] bpf, docs: fix the code formatting in instruction-set
Thread-Topic: [PATCH] bpf, docs: fix the code formatting in instruction-set
Thread-Index: AQHYh9St2DC4m8CGLUq9q/xAVn3Pvw==
Date:   Fri, 24 Jun 2022 14:14:11 +0000
Message-ID: <b6120b31-3d1d-bf2d-2f2a-aa768d91257b@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90c6647e-513a-46cc-ba85-08da55ebcfa8
x-ms-traffictypediagnostic: MW4PR12MB5604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i19Iam4+/0ctNbSTtRQI+gGzeFXJCXDVyoICtvqmQXe7UcLltM4b46jS4vqwZLw/uxpVyKi8B28DdIJOYdNtSL8QaC1T3Tr5fsorvwHf2mgUTlzoT1WbSJ96wYYhhTVzPNsCjfRqRyTnACV0WeCLLPJuLHjj0xufn1028VfFx4x984og70zVSAFj719Lwi+VBi7Zp+ZoW8MyHQKIn3EJAxO58FsKSK4D2eA3hTcjvPcI9z0w38i8nBdmalwjG3ev7t0/bKQCfNf0Enwyko37q6fp+iA0lpeqCvKQXISa3Ajzrbx4oRYe4e7L8DuzCrR3+1shtlvokFtOClIU+QqOcaAjfU65mTUuz4Ah44uCQk82xVmZGbCTrmKGANwkdAMoOr94atJbNuR/H35pHAMGquslr8X/qUCd06edGJgcMvHtKtM5pLdSq6CwHJ1Dk9nA610Q8hzaLkl2WJ9KzoXYpX6tcgAhh/Iyyj7oo6Od6HvV4LSafm+P47ENfjnKECmBO2jRft8vraavbnqMKOnwiWYKfwFlDArdsGeM4OyJIyfXdJAij62ES/jMcnoxu5q2c6UxGN2pwm9ySr7qUI/K/pa4NH29XTSBHMLPWpbOfOktNthlaKmw1Ny7uRHP9PaZHwpjLx4Kd221+Sy2ZvLODJ2MLUohX8AbpXndwBg919HVWnGLPppogFf0gL1Zk2HOdMcu7rtO/FkN/eAO5uRFdLlUpDKXqwlH1PisrHcAx18Fj0on0/ACPiean4KbGNG4nNNRBBpaQVE78RP8wHh9XqriZvNOHOx42VwvfMWgexOJhnfWIneW/jc6gGf1owtu9D7qtUJHNaDrI8no+/E0EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(39860400002)(376002)(38070700005)(6916009)(83380400001)(38100700002)(66476007)(36756003)(122000001)(31696002)(76116006)(86362001)(478600001)(41300700001)(71200400001)(2616005)(6486002)(186003)(26005)(6506007)(2906002)(6512007)(5660300002)(8936002)(316002)(91956017)(66556008)(66946007)(8676002)(31686004)(4744005)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2h0Uk81Rm9DdW5wRlU0a3lVSG5ZKytyQ3ozRndSRkRoc1hiY3JlMTNYNFdj?=
 =?utf-8?B?S0p4MXQ5U0xyL0piczlaSDZ2MC9Sbm1oM3h0NGtad1hzTGhoK3A1WUowUFZQ?=
 =?utf-8?B?ODFSNUZ4VHpYMStsUGRQV3lLVzJLVGp5cFNiWTh5ai9RY3FnMHNoenpOQ0Nx?=
 =?utf-8?B?YmNrNStDRUtHRTRjdEEraFNMTFpKMnM2ZEdVT3lBK3R0V3Y2bEphVmI0Smtn?=
 =?utf-8?B?bE8zQ24vcEEwcGZRY0pGcXlKNU1uTnBub3BpVzRzUk5VNlhNVGtUUVhnT2sr?=
 =?utf-8?B?R0NyU1JockRVOUcwN0JOdGhsbEkrdGJzdlMvS21ZUjluQVZ6V1Ficmdldkh3?=
 =?utf-8?B?QnhrYUszQWtycVpYZDROd3R5aWZjQjhsSU5ZOGo5K2pLWWV1M09DMElnS2Ir?=
 =?utf-8?B?L3luMDd2SmZDc1lPTHdkNW1RVERGZENYSlNSMmkxNGdtRFkzTlhFQzZPSSsy?=
 =?utf-8?B?emZZWTZEcDBteU1hUkErSmJzNlFVV25lSGFha2kvMGVadUFtbHp2K3A1MkM3?=
 =?utf-8?B?aHNTUy9hRUg0Vzc3UlM3RWcvYlV1RjQ4U2tUWnNJZkNxcktPODVhLy9TYXVD?=
 =?utf-8?B?S2hwZTduS21yMUxRNUgrUG9IeGRQNm9UWklYRHJFMHU1WEhSQXh6eC9IYUVp?=
 =?utf-8?B?TzhiTVFmb2EwMTluU1RZTHpwTXBpeHQ2OGw5ZkFqMk14WGdIQ0srdHlucFlI?=
 =?utf-8?B?L1YvOXErQzVIZnAwRnNwcC9HcUFMcUVVUEcvVGNiTDFEWnZ5OWl0cEpiRHNS?=
 =?utf-8?B?MjN0N1dwSXlPT2JRRTg1RmFnYytVclRCU1FMMndZUlFxek5jSHBHTWgxZHBT?=
 =?utf-8?B?WTVPdGh2Y2Uya3lUVVdEYWgrUk9VRkcwV1FuZzVVN3RLcHJtcHVnbUdaaHB0?=
 =?utf-8?B?cUdNM0pEc2NiY0xsOFFUL3RRbTBtUzgwZTZES2plWXJsOVBuZnJtTEdDdzJw?=
 =?utf-8?B?eXBOSTMxaXo2bkM2Zk5nVzM0TVBMc2w0RU9EcmM0UTA0ZHBlODZtcWw2eVRX?=
 =?utf-8?B?aE8zNGREc3FoV2NubldqbkpFVGRDOHhQWERsSkMrZW13bXk1N3pTRnlJaTdr?=
 =?utf-8?B?bUJQRU4yQ1R5Z3ZHTEFTeW13R2VGTjFkUkQvc2lUVVFTOE9lK1hsUzcyb2tH?=
 =?utf-8?B?L3p3RDZsNHZFQk4zd2pQd2JWc2JSM3lDVTFzTVMvcTBXbUpTN21zZ2h6alVi?=
 =?utf-8?B?bklLRzRQY253b2FmelJBMzdGN1hqZFFBclA5K0tHVURIcmFDdkVvdGR3bEhD?=
 =?utf-8?B?SVY3ZDBxWG5GWk5rUVlCQzFVOERYOWQ1MEhvU3p0MFNrb0lzenVtQTkwVWkr?=
 =?utf-8?B?MkdCdEF2UzlhNGptTStuREhWbmxwQmtrOHZ3T1ZoeUVJM2JkQnJwQkNCMW1I?=
 =?utf-8?B?NmFtc2U5YXg3cGMrSHovNWo0Z0djZUxwU29aa1lKK3RCZlRoM1phVXpPQU9D?=
 =?utf-8?B?RDdhOTZsZ3JCdHJNd05LaG0xR2ViNFJueWRwL1ZuZjFyRHFoM2E4ckJmc292?=
 =?utf-8?B?SlNLVEtjOStEYjUwYVI0a1FZU3J3TnpCTE5vZDY2Vmd5bGtXS1VIRm4yWDFG?=
 =?utf-8?B?RVl1QzErN0Q2OG9kKzRHRVZ3bE5vU3dmdzFhd09EYU91bUJRMmp2Y2h3Sk9y?=
 =?utf-8?B?SStKc1N3NWkxTTYvVTAwOC81SnVSYlpZU1hwSlkxQkVZd1NXMmVnMVQrdTVT?=
 =?utf-8?B?eW05ZGw4VGVlRGJ3SXE2QXFHTlFHM0JXVEUzcE5PSldLZzFaYW56WmpKd2VH?=
 =?utf-8?B?ckNQaC92WFZDOHNrQXl5VE1SNUs4SThrQVFQREIySkd3SHdoY2pET2dWaDJR?=
 =?utf-8?B?Q2lQSE81NERqNFZQYXhyMEVNdk1xTGJrRjU1NkI0anVmUTE5S3k0ZlVCSTdC?=
 =?utf-8?B?b2FXZWlvL3FwdlhHMXZUNDNnWGs2Z29oSnZ0b2hQeUZIZHBrMXl5WXhWTHpV?=
 =?utf-8?B?WTRyQ0REWnVFdCtvV2xhdkpuckJ4ZXVVUS9saXZuZzdLeU05eGo0aTRBK0cv?=
 =?utf-8?B?NkV3eDEzdGpucmQzRG5CeldRTnBOd2picnI3MUlZUVRtaTNiUFkrUjFIR3dP?=
 =?utf-8?B?OS84Zyt2QXY1alROSW1DRlZEa2ZWdlhJK0xBNDBzWnRpRzEveU0yNWg2bm0y?=
 =?utf-8?Q?Rf+ilPkifmaGupRtMEc7QI85R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3844699F397424DB5E7112831B811DB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c6647e-513a-46cc-ba85-08da55ebcfa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 14:14:11.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIdVUR10ezDvkbEvUZnP4jBzubvLCZEHFQrn48xjo5ESpF1jmL1rxw0ciq/8w4WLw0WZVlJp3VT0v8WcP/0Cuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QSBtaW5vciB0eXBvIGZpeCB0byBpbmNsdWRlICJ8IEJQRl9MRCIgaW50byBpdHMgcHJldmlvdXMN
CmNvZGUgcGhyYXNlOg0KDQpgYEJQRl9JTkRgYCB8IEJQRl9MRCAtLT4gYGBCUEZfSU5EIHwgQlBG
X0xEYGANCg0KU2lnbmVkLW9mZi1ieTogU2hhaGFiIFZhaGVkaSA8c2hhaGFiQHN5bm9wc3lzLmNv
bT4NCi0tLQ0KIERvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QgfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IGIvRG9jdW1lbnRhdGlv
bi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KaW5kZXggOWUyN2ZiZGIyMjA2Li4xYjBlNjcxMWRl
YzkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0DQpAQCAtMzUxLDcgKzM1
MSw3IEBAIFRoZXNlIGluc3RydWN0aW9ucyBoYXZlIHNldmVuIGltcGxpY2l0IG9wZXJhbmRzOg0K
ICAqIFJlZ2lzdGVyIFIwIGlzIGFuIGltcGxpY2l0IG91dHB1dCB3aGljaCBjb250YWlucyB0aGUg
ZGF0YSBmZXRjaGVkIGZyb20NCiAgICB0aGUgcGFja2V0Lg0KICAqIFJlZ2lzdGVycyBSMS1SNSBh
cmUgc2NyYXRjaCByZWdpc3RlcnMgdGhhdCBhcmUgY2xvYmJlcmVkIGFmdGVyIGEgY2FsbCB0bw0K
LSAgIGBgQlBGX0FCUyB8IEJQRl9MRGBgIG9yIGBgQlBGX0lORGBgIHwgQlBGX0xEIGluc3RydWN0
aW9ucy4NCisgICBgYEJQRl9BQlMgfCBCUEZfTERgYCBvciBgYEJQRl9JTkQgfCBCUEZfTERgYCBp
bnN0cnVjdGlvbnMuDQogDQogVGhlc2UgaW5zdHJ1Y3Rpb25zIGhhdmUgYW4gaW1wbGljaXQgcHJv
Z3JhbSBleGl0IGNvbmRpdGlvbiBhcyB3ZWxsLiBXaGVuIGFuDQogZUJQRiBwcm9ncmFtIGlzIHRy
eWluZyB0byBhY2Nlc3MgdGhlIGRhdGEgYmV5b25kIHRoZSBwYWNrZXQgYm91bmRhcnksIHRoZQ0K
LS0gDQoyLjMwLjINCg0KDQo=
