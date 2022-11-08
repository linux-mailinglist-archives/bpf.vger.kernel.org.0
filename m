Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F3620F60
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 12:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiKHLo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 06:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKHLoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 06:44:54 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D51145C
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 03:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c26Gkq3tswdRNUwsTQ47VSBdLLmEU6pa8QC3rEToE29d1dbVnyeFcsbx/fNuF/mBTa2gvp8A3FEgkinIjVs1feGzSR9MiMQxfVdnBVssELt8cec3oiQtsDTxgTE2VEYWsf6wetfS9zXy/VZ5h6HpPBpQj7xeYRvzUhhHghaZzaf/svnBATn3ssmp7moUiS7MkSPwHk7/U6DAOqbc0nIRLVgH+qE8gvoi5xU/ULHaxaOyH7Bb7B6hVhzLNF3FMQH+KSpXLnANxus/zzDSLiMe1mlLAe5+M7dfQCwMIpB+gZAfBozI4GUKNx6MLWawL5/2+x77/seSs/r9eGfjUvWwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELfNRdQ092YfOoDHPQNt3VEfcR50EVNNiZhfdXSjmBA=;
 b=iTZYuw6TYe91j1zkAZmRQ5dq1q3fRtg+G9WyTRKSpy6GrxnxUc/knZUQcxt0dRJ93CEMNZW4qPO2u6JxjIuYI2ZziNJQvK0f22uqf7GpRRgexeQhAJ8TSv2Xr2Aj0CL8FzX5aRPOSWQBv/k3hYUA5NqPnvmcdKS0Pn+qUSwbqHOIhPbY4IVSay/WURirPcdKe7SuOaancm7aH0tKASYzFmB0Y0MGyuYjw/3t6CO0isdlKb/oT9dObDGxLnjAPng1ndNerpNg1CFlS7BYKnTxlzcgkO6DAO1EPG4hIszeOV9uflgzRe/760pyVFv1mxxlSQRMJ8vZ1VenXUeQBoT+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfNRdQ092YfOoDHPQNt3VEfcR50EVNNiZhfdXSjmBA=;
 b=Q7SewwRyCNhS3FG/c2aXDZv1OTksPHUmhOkylVfKOKYHQdX24H1Zv/dsrRqC//3I1dsqg18J5ipvtM6LhGLNiHT5sHaqUPpRxSMpGYPwSdeLAjM9xdLcSpx10SA9TRB1lnyd9iJ8MMX/kKDt9Z/11lWch4CaGm7oZthGA4P7aNIavXAz7duicRlzSNHVLhp5YN/nY8Rwzkn/8C+Hjx8bhlzuluLULLA4JzEYQNW53DSOxqr/St497iL4256tZ9Sj5mk0hrfwDqcopuTOkSRqMWpdDEZl6pYh3LxnycQvp7jGFZ/dTUdkVkyvOjCHiaKDb0ACwmJh1T6hxKXv9EQIig==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 11:44:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 11:44:48 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq406Q0A
Date:   Tue, 8 Nov 2022 11:44:48 +0000
Message-ID: <83277694-6cb3-3fc7-b300-d39f82ac5b04@csgroup.eu>
References: <20221107223921.3451913-1-song@kernel.org>
In-Reply-To: <20221107223921.3451913-1-song@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1707:EE_
x-ms-office365-filtering-correlation-id: 5c76f9e7-45a3-4961-c8f6-08dac17ea3fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaJ/l0XfxQ9xnCmcJ7fV0hsZ2lxytAqTO6T9Aq5TjvOaJlNvE4FbgKU/iU/U65UaUZX70+9CipCPQUpMPMhLhoz27wUXcz9NSJmkchg/Hy0MeE0RczjVNJa88qK3dhKRcSmJ+7Pf67xdVGvM9+bRjEp2/dGb9wA/UY/PWKiAHXYwo+XwncaqUxC09or5+X0i0XfxFAsWJHo7IaQL75tBnm6rKtkF7g/ymKUA3MlUJGU5nqmP0DZ0vq3dBJ/W5KHaaPcj/6g5KQuLZnVxb0/AAQBuxdUG4A4JKzxp+ALysAQJ/GfafyXOdP+Ab4Kbitxc0lR1x16lWyUJeK/YnOdCfdnWzNvkoNTKrXz4j1QW6GMkaAZ4FniN+5HER1MDQu0FppbMQUStlUhJjCUhMbTlHtwPVavNAVkVkY3ukqQFL6wiKlizq8IEuFoW1nUx41vxeXVH4YHwKXsA9IXJu9qQUGv8sUqkrl8vGkDuiZKuDK56wfSzy2iAFCeUkly9t+LS+O5CujPzzZixZaw9r80cy5KcupC7HV7G3T0EytouY4x2YmCd4CJ9VIIpoYa3miK1aGOZadg8fCQeTZhMN621Ufi3KUsG2gnQtCCX1H+faNOYA1z2nq4hkBAhflw7zE5aBj7DNSoVD4/j911s57YplpZkUGoYKiD230PeTI9PyZF3tSHqJKWB9JfPVNsGvC0Uqs0pz3w0o0fwIlJhdEioNbNZ2dMkQAJUEWgKUfcphUHofnGFFgMhGr5thL+GKzRWSHPCeKtODJF0wIV6Wj5xkcB9MTsv4V7DY44TIu+X1BuTUUcGV/WW9psJ0LTV+WjteFIT/4HS8z0PUO4FjDXWkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(451199015)(6486002)(31686004)(4326008)(6512007)(5660300002)(478600001)(122000001)(71200400001)(36756003)(54906003)(110136005)(31696002)(86362001)(66476007)(91956017)(64756008)(66556008)(66446008)(8676002)(6506007)(38070700005)(66574015)(26005)(38100700002)(316002)(76116006)(66946007)(83380400001)(41300700001)(2906002)(2616005)(7416002)(44832011)(8936002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djA1SzdaeGJxNzFVZVVQNWNBR0c0cytZQ05ZQ2pDVlNta010TnYrZk1TOVJu?=
 =?utf-8?B?S0VVNEFqUDBpbGpxaEZIQjg1TXdIMHZ2UjFSbVRmUk1SRWxBb21vZ0ljdXhT?=
 =?utf-8?B?TFRmZGJ4d3RLV0ppZnBRN3BySkxhb0ZEdXQzeDcxRW5MeHBzaWg1bW80ZGFV?=
 =?utf-8?B?dWJGWnZMaFZIZGwrRVNhNWJBbFQyd0tmSjNtMUpVNnBjUFp1bkJja0N2TnN4?=
 =?utf-8?B?cDJzQXdOQmZvaCtsUEt0Y0VkaWNGSld4SGpUT3kzb3NXcWI1cUk0ZytYK2Fj?=
 =?utf-8?B?clhleHF1WlZiMVRKdnhad3BXUit6U053QTNXVnVINkxpeDVvQXg4Nm85K0Vs?=
 =?utf-8?B?bWxDclpXTTREaStUWURsRFZSQldCL0VpWTd1YXBaMDZ1Y1FjazBCZW5CNjli?=
 =?utf-8?B?NUdMTG5YYVlpUnBVODFncVlnOTZ5M2tjSm1IMktSOEwwb2xBWll6SUM5MUh2?=
 =?utf-8?B?UVF5RDBtUG5nZ2szdHU0K01Xd2hFSDF3akZ2Z0Z5OTR5b09JR0hENGJ6dUxH?=
 =?utf-8?B?QmEvajlRbW5wdXEvMUdJdUwxMW5TNWI0VkdHbklTL040SVNMR1dsNDJxcWxT?=
 =?utf-8?B?ODhrckxkVVo5NkJwNXIrSjlzWDRRaWJPeHo5QzVjNWUrNCs2UG5WQzZvYjBu?=
 =?utf-8?B?N24wVEQ3U0lIRW5FYXpCK0N4dE5TRTdpVjB5azN0UzBlNEV6WGNqY2Z3L09C?=
 =?utf-8?B?NnBSWU9HWUhLRmprZFk1bW40QWVsRmJtYWZyRmtUbXJBQ0hPVmEzcEdUYmlE?=
 =?utf-8?B?SHZGV0ZmalBZeE1GYTdHdXJMRzEzeHhjcFI0MG1MY1hGMVF5Wlppc3hSVHZj?=
 =?utf-8?B?c29jQnF4d2FhWG9zeEk3U3RydzkrZy90akE4dkw3VDNHREh5b0h6QWhBSW82?=
 =?utf-8?B?VVZPQUxRcGVDbi8vdStmQ0hIZ1F0bjg4RkVCS0pLQWNWNkxndldRdGkycXhB?=
 =?utf-8?B?Y2h3UXBOZE5aNDFxd1UyRHVFdk8waGdGWmxSdU9pRVozTVdyZGI0VXB6WDJL?=
 =?utf-8?B?MGZaRmV5QmR4cndrQjdDcFZKTTZRU09SbTQzYnZuRStWOGF1eDB0V0ZESjEz?=
 =?utf-8?B?ZEJvbURkN2dvSnZYUGdZR1RSbGVWTVczeThXUDN0UWtRSElyRFdEK0w4MzdB?=
 =?utf-8?B?b0E2dGNXZzU0cVhKcG5sWE1ibzdBSmJRY2dXL0ZWblZ3dnJyajZSMnNBd2g5?=
 =?utf-8?B?ZjJUSXhldCtvWnZqdTQ2RFplSExOZzFlbm1hbnVSQThLYy9qZWpzYnpna3h1?=
 =?utf-8?B?WjI5Rk16NDdTSC9JMk5mczhMZkxFK0thcVArb200Y0ljUHMrK0ttZVkwck9W?=
 =?utf-8?B?NUo4anNtTURJOTlZRTVnTWpOaWp2ZXB3MjFKL1BXRmVRNk9JSjA4ZmVvN0pu?=
 =?utf-8?B?UjdzUmJib3ErN1FHUFdNektIMjRXYThQNFBpcXQyc05XMUdLck42SlF5OEx5?=
 =?utf-8?B?Um9WeDUvTURjMnlZeG1IVEI5SSttbW4zQ1B5QU81cmRTQlZvNFZtb2dqYnhB?=
 =?utf-8?B?YTJYdVhYR05kemljdkNoOTVXeVJYckp5Vi9JMHpnVkdFc29TTzVkL1d2UTdZ?=
 =?utf-8?B?aE5JR0w3dlhMcnlBUlNlRXNXUkVidUhybUJVQ0FxTG05c0R4Zk9SUGxDUkQ4?=
 =?utf-8?B?MzArWDVyY0JmTUVpRng0MEhjRG4vaExWcDdOY1FUU1Y0bzNXNU84L0F2VkdZ?=
 =?utf-8?B?WldWdFFiVmk0dEZoaElackkzWDlpSklJeXI0TEFicHJPUXpPS2JrL0J3d1c4?=
 =?utf-8?B?VkdhalJlYkV3ZWh4SkNaUXA2Yy9qdXpteUlHY05ybEpvUUZ1cVQ1R3JXOWtW?=
 =?utf-8?B?WG5TeFFrWkJrMEdRQ2g5ZTFGcHJTWmZlVXBhWDJHRTc5ZFppODkxR3hrWVBM?=
 =?utf-8?B?NUFmWmVNWnJzVXJTWlZydno5UlFoUW5UbjhMU3BRTktpZDlWNVNoMUttM3BO?=
 =?utf-8?B?ZFNvVnVWOHBuelp6TkJPeFRRclNRUU5wa1RPWGVLQk4vSjVESGVsMHJHNGx5?=
 =?utf-8?B?VGcxNXNCWHZZNFFGVWhVSW9KTitOQUJqdlZ1Z2U4RVlxektDN2swb1NMMXIr?=
 =?utf-8?B?VnJ6N2xITXVWOGZVTGtKL1hHeW52OFBxeVdDUWZhUWFlczFTTlBwNkM5UXpj?=
 =?utf-8?B?VVRzOG52dE4rcXpFMEZ5MmgwaVRTc0g1TjZsY09hM0J0c3lOUGJtN1ZSUHpm?=
 =?utf-8?Q?p4JfheT8OYLjqHpK+xCxyV0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52B239E6BD36FE4994449C10C7B85C85@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c76f9e7-45a3-4961-c8f6-08dac17ea3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 11:44:48.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJ/MMo+Aa5wKp3+e+RFr7EIqREx1K7jum6+UkGfA7BApKjlCL1NbeboeHvzwHA92bg7+7Xn+D0q/yeMT/EIzNY4wv03GPC9GG+8Q+4s8gN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA3LzExLzIwMjIgw6AgMjM6MzksIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IFRoaXMg
cGF0Y2hzZXQgdHJpZXMgdG8gYWRkcmVzcyB0aGUgZm9sbG93aW5nIGlzc3VlczoNCj4gDQo+IDEu
IERpcmVjdCBtYXAgZnJhZ21lbnRhdGlvbg0KPiANCj4gT24geDg2LCBTVFJJQ1RfKl9SV1ggcmVx
dWlyZXMgdGhlIGRpcmVjdCBtYXAgb2YgYW55IFJPK1ggbWVtb3J5IHRvIGJlIGFsc28NCj4gUk8r
WC4gVGhlc2Ugc2V0X21lbW9yeV8qIGNhbGxzIGNhdXNlIDFHQiBwYWdlIHRhYmxlIGVudHJpZXMg
dG8gYmUgc3BsaXQNCj4gaW50byAyTUIgYW5kIDRrQiBvbmVzLiBUaGlzIGZyYWdtZW50YXRpb24g
aW4gZGlyZWN0IG1hcCByZXN1bHRzIGluIGJpZ2dlcg0KPiBhbmQgc2xvd2VyIHBhZ2UgdGFibGUs
IGFuZCBwcmVzc3VyZSBmb3IgYm90aCBpbnN0cnVjdGlvbiBhbmQgZGF0YSBUTEIuDQo+IA0KPiBP
dXIgcHJldmlvdXMgd29yayBpbiBicGZfcHJvZ19wYWNrIHRyaWVzIHRvIGFkZHJlc3MgdGhpcyBp
c3N1ZSBmcm9tIEJQRg0KPiBwcm9ncmFtIHNpZGUuIEJhc2VkIG9uIHRoZSBleHBlcmltZW50cyBi
eSBBYXJvbiBMdSBbNF0sIGJwZl9wcm9nX3BhY2sgaGFzDQo+IGdyZWF0bHkgcmVkdWNlZCBkaXJl
Y3QgbWFwIGZyYWdtZW50YXRpb24gZnJvbSBCUEYgcHJvZ3JhbXMuDQo+IA0KPiAyLiBpVExCIHBy
ZXNzdXJlIGZyb20gQlBGIHByb2dyYW0NCj4gDQo+IER5bmFtaWMga2VybmVsIHRleHQgc3VjaCBh
cyBtb2R1bGVzIGFuZCBCUEYgcHJvZ3JhbXMgKGV2ZW4gd2l0aCBjdXJyZW50DQo+IGJwZl9wcm9n
X3BhY2spIHVzZSA0a0IgcGFnZXMgb24geDg2LCB3aGVuIHRoZSB0b3RhbCBzaXplIG9mIG1vZHVs
ZXMgYW5kDQo+IEJQRiBwcm9ncmFtIGlzIGJpZywgd2UgY2FuIHNlZSB2aXNpYmxlIHBlcmZvcm1h
bmNlIGRyb3AgY2F1c2VkIGJ5IGhpZ2gNCj4gaVRMQiBtaXNzIHJhdGUuDQo+IA0KPiAzLiBUTEIg
c2hvb3Rkb3duIGZvciBzaG9ydC1saXZpbmcgQlBGIHByb2dyYW1zDQo+IA0KPiBCZWZvcmUgYnBm
X3Byb2dfcGFjayBsb2FkaW5nIGFuZCB1bmxvYWRpbmcgQlBGIHByb2dyYW1zIHJlcXVpcmVzIGds
b2JhbA0KPiBUTEIgc2hvb3Rkb3duLiBUaGlzIHBhdGNoc2V0IChhbmQgYnBmX3Byb2dfcGFjaykg
cmVwbGFjZXMgaXQgd2l0aCBhIGxvY2FsDQo+IFRMQiBmbHVzaC4NCj4gDQo+IDQuIFJlZHVjZSBt
ZW1vcnkgdXNhZ2UgYnkgQlBGIHByb2dyYW1zIChpbiBzb21lIGNhc2VzKQ0KPiANCj4gTW9zdCBC
UEYgcHJvZ3JhbXMgYW5kIHZhcmlvdXMgdHJhbXBvbGluZXMgYXJlIHNtYWxsLCBhbmQgdGhleSBv
ZnRlbg0KPiBvY2N1cGllcyBhIHdob2xlIHBhZ2UuIEZyb20gYSByYW5kb20gc2VydmVyIGluIG91
ciBmbGVldCwgNTAlIG9mIHRoZQ0KPiBsb2FkZWQgQlBGIHByb2dyYW1zIGFyZSBsZXNzIHRoYW4g
NTAwIGJ5dGUgaW4gc2l6ZSwgYW5kIDc1JSBvZiB0aGVtIGFyZQ0KPiBsZXNzIHRoYW4gMmtCIGlu
IHNpemUuIEFsbG93aW5nIHRoZXNlIEJQRiBwcm9ncmFtcyB0byBzaGFyZSAyTUIgcGFnZXMNCj4g
d291bGQgeWllbGQgc29tZSBtZW1vcnkgc2F2aW5nIGZvciBzeXN0ZW1zIHdpdGggbWFueSBCUEYg
cHJvZ3JhbXMuIEZvcg0KPiBzeXN0ZW1zIHdpdGggb25seSBzbWFsbCBudW1iZXIgb2YgQlBGIHBy
b2dyYW1zLCB0aGlzIHBhdGNoIG1heSB3YXN0ZSBhDQo+IGxpdHRsZSBtZW1vcnkgYnkgYWxsb2Nh
dGluZyBvbmUgMk1CIHBhZ2UsIGJ1dCB1c2luZyBvbmx5IHBhcnQgb2YgaXQuDQo+IA0KPiANCj4g
QmFzZWQgb24gb3VyIGV4cGVyaW1lbnRzIFs1XSwgd2UgbWVhc3VyZWQgMC41JSBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudA0KPiBmcm9tIGJwZl9wcm9nX3BhY2suIFRoaXMgcGF0Y2hzZXQgZnVydGhl
ciBib29zdHMgdGhlIGltcHJvdmVtZW50IHRvIDAuNyUuDQo+IFRoZSBkaWZmZXJlbmNlIGlzIGJl
Y2F1c2UgYnBmX3Byb2dfcGFjayB1c2VzIDUxMnggNGtCIHBhZ2VzIGluc3RlYWQgb2YNCj4gMXgg
Mk1CIHBhZ2UsIGJwZl9wcm9nX3BhY2sgYXMtaXMgZG9lc24ndCByZXNvbHZlICMyIGFib3ZlLg0K
PiANCj4gVGhpcyBwYXRjaHNldCByZXBsYWNlcyBicGZfcHJvZ19wYWNrIHdpdGggYSBiZXR0ZXIg
QVBJIGFuZCBtYWtlcyBpdA0KPiBhdmFpbGFibGUgZm9yIG90aGVyIGR5bmFtaWMga2VybmVsIHRl
eHQsIHN1Y2ggYXMgbW9kdWxlcywgZnRyYWNlLCBrcHJvYmUuDQo+IA0KPiANCj4gVGhpcyBzZXQg
ZW5hYmxlcyBicGYgcHJvZ3JhbXMgYW5kIGJwZiBkaXNwYXRjaGVycyB0byBzaGFyZSBodWdlIHBh
Z2VzIHdpdGgNCj4gbmV3IEFQSToNCj4gICAgZXhlY21lbV9hbGxvYygpDQo+ICAgIGV4ZWNtZW1f
YWxsb2MoKQ0KPiAgICBleGVjbWVtX2ZpbGwoKQ0KPiANCj4gVGhlIGlkZWEgaXMgc2ltaWxhciB0
byBQZXRlcidzIHN1Z2dlc3Rpb24gaW4gWzFdLg0KPiANCj4gZXhlY21lbV9hbGxvYygpIG1hbmFn
ZXMgYSBzZXQgb2YgUE1EX1NJWkUgUk8rWCBtZW1vcnksIGFuZCBhbGxvY2F0ZXMgdGhlc2UNCj4g
bWVtb3J5IHRvIGl0cyB1c2Vycy4gZXhlY21lbV9hbGxvYygpIGlzIHVzZWQgdG8gZnJlZSBtZW1v
cnkgYWxsb2NhdGVkIGJ5DQo+IGV4ZWNtZW1fYWxsb2MoKS4gZXhlY21lbV9maWxsKCkgaXMgdXNl
ZCB0byB1cGRhdGUgbWVtb3J5IGFsbG9jYXRlZCBieQ0KPiBleGVjbWVtX2FsbG9jKCkuDQo+IA0K
PiBNZW1vcnkgYWxsb2NhdGVkIGJ5IGV4ZWNtZW1fYWxsb2MoKSBpcyBSTytYLCBzbyB0aGlzIGRv
ZXNub3QgdmlvbGF0ZSBXXlguDQo+IFRoZSBjYWxsZXIgaGFzIHRvIHVwZGF0ZSB0aGUgY29udGVu
dCB3aXRoIHRleHRfcG9rZSBsaWtlIG1lY2hhbmlzbS4NCj4gU3BlY2lmaWNhbGx5LCBleGVjbWVt
X2ZpbGwoKSBpcyBwcm92aWRlZCB0byB1cGRhdGUgbWVtb3J5IGFsbG9jYXRlZCBieQ0KPiBleGVj
bWVtX2FsbG9jKCkuIGV4ZWNtZW1fZmlsbCgpIGFsc28gbWFrZXMgc3VyZSB0aGUgdXBkYXRlIHN0
YXlzIGluIHRoZQ0KPiBib3VuZGFyeSBvZiBvbmUgY2h1bmsgYWxsb2NhdGVkIGJ5IGV4ZWNtZW1f
YWxsb2MoKS4gUGxlYXNlIHJlZmVyIHRvIHBhdGNoDQo+IDEvNSBmb3IgbW9yZSBkZXRhaWxzIG9m
DQo+IA0KPiBQYXRjaCAzLzUgdXNlcyB0aGVzZSBuZXcgQVBJcyBpbiBicGYgcHJvZ3JhbSBhbmQg
YnBmIGRpc3BhdGNoZXIuDQo+IA0KPiBQYXRjaCA0LzUgYW5kIDUvNSBhbGxvd3Mgc3RhdGljIGtl
cm5lbCB0ZXh0IChfc3RleHQgdG8gX2V0ZXh0KSB0byBzaGFyZQ0KPiBQTURfU0laRSBwYWdlcyB3
aXRoIGR5bmFtaWMga2VybmVsIHRleHQgb24geDg2XzY0LiBUaGlzIGlzIGFjaGlldmVkIGJ5DQo+
IGFsbG9jYXRpbmcgUE1EX1NJWkUgcGFnZXMgdG8gcm91bmR1cChfZXRleHQsIFBNRF9TSVpFKSwg
YW5kIHRoZW4gdXNlDQo+IF9ldGV4dCB0byByb3VuZHVwKF9ldGV4dCwgUE1EX1NJWkUpIGZvciBk
eW5hbWljIGtlcm5lbCB0ZXh0Lg0KDQpXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBoYXZlIHNvbWV0
aGluZyBtb3JlIGdlbmVyaWMgdGhhbiBiZWluZyBzdHVjayB0byANClBNRF9TSVpFID8NCg0KT24g
cG93ZXJwYyA4eHgsIFBNRF9TSVpFIGlzIDRNQiBhbmQgaHVnZXBhZ2VzIGFyZSA1MTJrQiBhbmQg
OE1CLg0KDQpDaHJpc3RvcGhl
