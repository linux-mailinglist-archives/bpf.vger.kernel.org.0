Return-Path: <bpf+bounces-5978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10D763BA4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA121C2135E
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88A62770A;
	Wed, 26 Jul 2023 15:51:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD05253BC;
	Wed, 26 Jul 2023 15:51:38 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E52738;
	Wed, 26 Jul 2023 08:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSfbmjz91fjid65wdq6MCab49N2VkteNQ5yR/XLZBixu/SBwR+AmkLOLTchi+IHp5Ii9IaUlswX01hWi4cYfEwFJXP//M6axCGfjzRXBa9D62Y0ORoQfV8Lja/KZZ9FZghJ3NRwl13CyjFhRUeqmmVBAkE1EMe4bLwUEmrdiPY6028SofFWommL9rqHNkjbSkbTsVu3S1zgIIRJEiy8GBOdi4LGdvINk/DIK9Yjll10SATeB3k6im13bWjhjBbf7VB3KX9+ooLB4M/wDG7Gwmyo1I/TsrJbp8uqpsx3ew7qqgwKt4c34AL75kQRSZzyeYA0XLFTMZpyUy8JQ1dGc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LrhnSaQDG9XB05b+Jv6Q3P5ig58JYg/dd2N40gM0Q0=;
 b=Is+XNVyB1lBHFo6lXKWzClsrYrgYYk0/d5DYsEQ9yCQcYNBN065On1p1cXKpI2z3ltmE2uNYwIPYtTD2lB34kd28DashUJPVvwTcqRlzgA9vULffkO/Te1Aij5c/d8KY53quGi36xRcd3hqDLFDHqYv3uJJd9tORlAP9ejbPwdBtFRz3PcaW3c9eHHO6QBD3taTJu0mEvNBTBtN+HMd6lGjfdp+QyGhV3JhVGa6OxyO/KXpRt9jujg5bu23GCR6x+N4Q5R0UfFDkRpQl37UIpdJDDLLz7i98adUWFhDxqohPF31oqiQ8mrxom9NM88x6gV9HVgUfaAK2YIE3hXxBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LrhnSaQDG9XB05b+Jv6Q3P5ig58JYg/dd2N40gM0Q0=;
 b=TdcO6Y0dFyJ9Mnv1kyfIbGI/aXkj5J5S02oCkdG+ErCKCbCfGTYMwEYmXun4NA6Bd5u38I+MUJPV9Uz+IrS1PmbGZQH1cu76uMRgPeireAlc7xQcr5evHuD7bZ3BA4+gBovpRvFMHY9zRlhk8ncMXc3i1AhqJSiCNT85OVqSmXg=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by BL0PR2101MB1346.namprd21.prod.outlook.com (2603:10b6:208:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Wed, 26 Jul
 2023 15:51:32 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::d2:cad1:318e:224b%7]) with mapi id 15.20.6652.002; Wed, 26 Jul 2023
 15:51:32 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, Dexuan Cui <decui@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
Subject: RE: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Topic: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Thread-Index:
 AQHZvAZSl8pOb40fXE2pDlV9gZuDN6/IzCkAgABE5NCAADEEcIABidWAgAANWGCAAPQoAIAAavKQ
Date: Wed, 26 Jul 2023 15:51:32 +0000
Message-ID:
 <PH7PR21MB3116C4C749C4E915CADEE273CA00A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
 <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <6396223c-6008-0e1b-e6ed-79c04c87a5e0@redhat.com>
In-Reply-To: <6396223c-6008-0e1b-e6ed-79c04c87a5e0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=779a0386-fc46-47d6-8bab-1fba97ac898a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T15:45:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|BL0PR2101MB1346:EE_
x-ms-office365-filtering-correlation-id: c3f956af-1f82-41fa-8136-08db8df02f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8HPRak+jDLiKgYyhvH9a8C5bYbB1XHX+lv/iLZXhZjUEFr4KmbPrbjNhzdixrQKSS7y45fK4wVBGNm3A31VEsZaf+x09X3bvrgoxkNDaPWVFlMmkCAt5KUTI4So/u2t3QMKYLz+ZsQ+xr+mus88RwLt16lyzlLSAQocCzDDhU/NXViG8PuBFsv3vhybADjPSdDkq+SkxG5TiKb106HHly78pHkXz0yzLi4yzRjwyL7rG8YZgFZxr2Q3Oz/ksUf6ZYdDlaRieRWFr8eMMxu2W/twqeD+GKcb+SADGaVLH3AoKn/H5q6AUIVg0amKhMHGWA9FrPlmPp2RPkalHX5jluIQuo2+TWRSfkzI4/h2D+80v/O7kWxXb4tDD9MEt95tL10rddlUgMITAhQg4+VAuTUrQRBL4M0yu8Yciq0XWdj/bDKmoa/x3MtauedbohAWX546VjcJwp4xepDja0gRDLZMu2xsFbBIRZHzR2SsHPfk0M7v8mH88/ua+KFOjc40Epd3E/pkJRxuETrfGLaNpJfXuev70EO3MnCPNqd/5LO1rEbnV7OlncVGZSptVi1XR97ZPzavFgiJbmg+VaaQ4xTdq3sXzpFjxn46sECD+UploawSvuQtddLbkwfRMP1lsMfouLpN47KVmwDhfGTMJ/zZ1yYRsOaIukb+N4hwci+Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(55016003)(110136005)(122000001)(38100700002)(9686003)(54906003)(7696005)(66946007)(71200400001)(478600001)(82960400001)(52536014)(66556008)(41300700001)(10290500003)(82950400001)(5660300002)(316002)(66476007)(8676002)(4326008)(76116006)(8936002)(64756008)(66446008)(83380400001)(186003)(26005)(6506007)(86362001)(8990500004)(33656002)(38070700005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzJlWHRLKzl5SDhmbml1anBxck5XYXpQM2xGZ25KWHZpOUt3TFI1bmMvTGVG?=
 =?utf-8?B?bTVuWGFzeWI4SXJ0aVBvSHVxV3ZSUFJaUTZURUFTUFh0L0lSMGN0YTJIWUJ5?=
 =?utf-8?B?U2o2YnR4aklKVk5FMHVRamNRZDFMbnE0TUFnN0k5V29tUksrUGVONlZNQjc0?=
 =?utf-8?B?Zll5YUJwZEdWeGRKbTEwSVM0ZEdvYys2V00yUTZDZUdTWDZUYktITmtyekgz?=
 =?utf-8?B?QWJtRmQ0MU5oNUZFZTVZa2FEZGJmRTNTTnBZRVRGTEw5TUxaZkRKZlFPNFhD?=
 =?utf-8?B?KzZ3RWJjako4SkN2WnhUSTQwZFoyaUxseGE5bWxVcDRCMVdxVzV2N203d1Vo?=
 =?utf-8?B?ejhtb0E4amQ5TmZ1eVBINmFtdWF4QTg3Y01tOTh2T0RhYnQySnNoMS82U0VU?=
 =?utf-8?B?cGpkaHdOK3lnR25lSlFxYmFQTUwwSkl3bGRzNGF2SjhYanZDTER5QjFVRTlQ?=
 =?utf-8?B?SGNFakJpemhzODJ2STJrWlV1SS9tWUtmRHFHMFdaTE5kUlZWZjByWWx6Wjdm?=
 =?utf-8?B?QTcvMnE5VmlJOVhLNkhhd0dnQkZtcUtlN0Eya3dMcnAySU1lVzJueVdwVVE2?=
 =?utf-8?B?cjlkZjd2RmhxWWtTVEtxd2N0TzJsTklOVVBhN3B6OXZ3OHFWRm8zT2E3THp0?=
 =?utf-8?B?WXFSMHZ6WmR0Uy9laHZicUQzMEwzak9zOGcwbWcvYlRFQTM4L1pSa01uemlK?=
 =?utf-8?B?R3lONlRaRG8wMlNzMDhueXpKN2ZwSlo2TXg0Rm1CUTIyWUZtblFjRkZoU3Zk?=
 =?utf-8?B?dms1UTRscjdkNFIzbjVOaEJ3QVJCODFjYnN2TTV6Q2ljOVN2aHFwbnpjTmRW?=
 =?utf-8?B?c09NTFZ5dVpVTmhEcFFqMmRZTW4ySHIweDJvUGluS1N2MkF1WkVEeGJMam5N?=
 =?utf-8?B?WENVMXpheHhrMTA0UksveUg3eVhzVXFkeEU2OGx0TW1QSmoxRDk5QzdSNnFz?=
 =?utf-8?B?MTlGOUprRHlFZjNNVThtMEUzS1YzOHMyWmI5VWw1RzZONWtTeFVrOVNpWHN4?=
 =?utf-8?B?SDRKVFFodnJrWUs1VWw4Zm8yU0s0YW16bC95SDdNRjRXa2w3MklWTFY5RTVk?=
 =?utf-8?B?Qlh0N0FjMHU2cHZLNFlnL3lEMjY5MUZpV29DVDVoYmlMdW5oY3poelB6NzlT?=
 =?utf-8?B?VkFtc3dSdGxOVUo4T2FaWkNlNmlBRDVaR0tOaEdaa0Q3MWR6a0xpdVNtUTl2?=
 =?utf-8?B?QitCSDU5aGlzUlpXTUNaaDNsTFpsanphbGZhVXk1dDNDRHJoOTV2WS9weDJo?=
 =?utf-8?B?TWpjRUIxbmdzb0FVQUZOVG5jM0FIcnRraWpuVnB6VWVlazNHR2d3YUszdC9K?=
 =?utf-8?B?WUpKUy9UQVJQNTNJSDNLd1Q5aXhDb3dRTmFBMlRwY2lwM3ZMbVFQcW9VQlZ5?=
 =?utf-8?B?L3had3czdnlIKys2NVRmQlJKbFZ5L1ZRTmJXdVNIMXdrVTBnRkdReUREQmZr?=
 =?utf-8?B?L1htN3pGbHFSSGQyS1NVTEdKTjhidWlPMXMrVVBYd3FNUitaSWpjRWtIdmx3?=
 =?utf-8?B?US9jT2U2akczbGdqWHhoa0Zybm1XWUxwcFlUMGNYUU8vMDlHNWI5b0xLaE1S?=
 =?utf-8?B?RTRsdFJzUGczVFRXWFZKUkRRbEJMakxibzJOTWJpakNrREM0NlFVZ0plTlFu?=
 =?utf-8?B?MWNJSFhOeDkvNXAxaW9GRHZJSnhZdWgwL1VrazhFZkNHa1ltL1hIZnpUNm14?=
 =?utf-8?B?eldmUi9XK1ZIRGF1c3RYalVnckZsZjB1azRKVlF6Um90VWZidFEremxJNG0x?=
 =?utf-8?B?ak50ZnF5SmIreHlEL09oSkVFQndyV0VQNEdIcUVtRW5DdWZzeGFPOXZ0RVJt?=
 =?utf-8?B?b0lLM25vUFlLQnpEQkJZbGxsc0pyUy9YRjFxZ0lqdCtiMThpU0xxVnEwaytS?=
 =?utf-8?B?ajlQUW9NVm83THBKQXozaVdPU25XU3lBZ25zZnZRMWFQTVFVWUxKU3BnTkwr?=
 =?utf-8?B?RFFkZkUzZEVFdy9UUm5UNy90ejhybWR1OGVzbkFZbFExMDR3aHFjZkVUR3JN?=
 =?utf-8?B?Ly8vZ1Zpelp4cW1SZGQwSFZGMktFbEEyL3RoRTJIWlREMDJSdGQxOXVJQ0po?=
 =?utf-8?B?bVU5elZENjlJWkphbkFEQ2MvdWZQcnY2Wk04YmNPcldUbml4dDRQeTB6Y2RZ?=
 =?utf-8?Q?HsS5X0qkQOg1TaQClgRpqHssC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f956af-1f82-41fa-8136-08db8df02f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 15:51:32.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VaQReD+QLV2uw/6IhFtdkZD1w88JcIH3ZsZyCCZwyIx5Cbta1rAi+WnKCHdCMdAu4a9Vqz6LqF2R1nz7Dr6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVzcGVyIERhbmdhYXJk
IEJyb3VlciA8amJyb3VlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjYs
IDIwMjMgNToyMyBBTQ0KPiA+DQo+ID4gSW4gbWFuYV9nZF9zZXR1cF9pcnFzKCksIHdlIHNldCB0
aGUgZGVmYXVsdCBJUlEvQ1BVIGFmZmluaXR5IHRvIGdjLQ0KPiA+bnVtYV9ub2RlDQo+ID4gdG9v
LCBzbyBpdCB3b24ndCByZXZlcnQgdGhlIG5pZCBpbml0aWFsIHNldHRpbmcuDQo+ID4NCj4gPiBD
dXJyZW50bHksIHRoZSBBenVyZSBoeXBlcnZpc29yIGFsd2F5cyBpbmRpY2F0ZXMgbnVtYSAwIGFz
IGRlZmF1bHQuIChJbg0KPiA+IHRoZSBmdXR1cmUsIGl0IHdpbGwgc3RhcnQgdG8gcHJvdmlkZSB0
aGUgYWNjdXJhdGUgZGVmYXVsdCBkZXYgbm9kZS4pIFdoZW4gYQ0KPiA+IHVzZXIgbWFudWFsbHkg
Y2hhbmdlcyB0aGUgSVJRL0NQVSBhZmZpbml0eSBmb3IgcGVyZiB0dW5pbmcsIHdlIHdhbnQgdG8N
Cj4gPiBhbGxvdyBwYWdlX3Bvb2xfbmlkX2NoYW5nZWQoKSB0byB1cGRhdGUgdGhlIHBvb2wuIElz
IHRoaXMgT0s/DQo+ID4NCj4gDQo+IElmIEkgd2VyZSB5b3UsIEkgd291bGQgd2FpdCB3aXRoIHRo
ZSBwYWdlX3Bvb2xfbmlkX2NoYW5nZWQoKQ0KPiAib3B0aW1pemF0aW9uIiBhbmQgZG8gYSBiZW5j
aG1hcmsgbWFyayB0byBzZWUgaWYgdGhpcyBhY3R1YWxseSBoYXZlIGENCj4gYmVuZWZpdC4gIChZ
b3UgY2FuIGRvIHRoaXMgaW4gYW5vdGhlciBwYXRjaCkuICAoSW4gYSBBenVyZSBoeXBlcnZpc29y
DQo+IGVudmlyb25tZW50IGlzIG1pZ2h0IG5vdCBiZSB0aGUgcmlnaHQgY2hvaWNlKS4NCk9rLCBJ
IHdpbGwgc3VibWl0IGEgcGF0Y2ggd2l0aG91dCB0aGUgcGFnZV9wb29sX25pZF9jaGFuZ2VkKCkg
b3B0aW1pemF0aW9uIA0KZm9yIG5vdywgYW5kIHdpbGwgZG8gbW9yZSB0ZXN0aW5nIG9uIHRoaXMu
DQoNCj4gVGhpcyByZW1pbmRzIG1lLCBkbyB5b3UgaGF2ZSBhbnkgYmVuY2htYXJrIGRhdGEgb24g
dGhlIGltcHJvdmVtZW50IHRoaXMNCj4gcGF0Y2ggKHVzaW5nIHBhZ2VfcG9vbCkgZ2F2ZT8NCldp
dGggaXBlcmYgYW5kIDEyOCB0aHJlYWRzIHRlc3QsIHRoaXMgcGF0Y2ggaW1wcm92ZWQgdGhlIHRo
cm91Z2hwdXQgYnkgMTItMTUlLCANCmFuZCBkZWNyZWFzZWQgdGhlIElSUSBhc3NvY2lhdGVkIENQ
VSdzIHVzYWdlIGZyb20gOTktMTAwJSB0byAxMC01MCUuDQoNClRoYW5rcywNCi0gSGFpeWFuZw0K
DQo=

