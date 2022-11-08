Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F655621D22
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiKHTnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 14:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKHTnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 14:43:12 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120057.outbound.protection.outlook.com [40.107.12.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6993B71F3E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:43:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiYHgBX3YNdp2S0uOnIOcaDToNr2TpXKwLIPi2hEQMrzNn1WD4VYatgtSu5Q5FXaxa1hmnOaen8OaDDAyyaAhXdHQycFTuPEjLr0Gnjdz7/ZvEjzKJjjQtNh3oR6d0qtzKDnUhvps/vWzdsQARDLs3dWlh/z9F51P3cTgr1NU/Mmsh4rsVm3jS2AA2OctF99ruwxYZrDkmLPXL603oV2el7uYGr4E2pJz1PK+xeUeK3k52GCP/qqlAg1fYS9f8/NBrWSEq3zKurU6cSe8dzTL2os+b55t9Ph4y7+m48Dp2k9IRh7LQCfaTemyMHGcJjexmEWHVqUea0h3GmVZ+awUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+fLr3DJokFnu7rHs/028mWDYVjlOk9PD6k4SN0EElE=;
 b=XQ091PSlbc6L1ZLFocD95FX/g1N/o3Yi92PauP8jPI1YqkimVrdPR9DTfmDttrZ+sfQb402xXAuOxlQqiAiSvjvxRWhlZj6xfW+JWEqGBb7giSJUjppF7ZQOQK7u1suwecFe4C8qADblIrxNuvfOO4SCPEyi3eFWaAyt53ItMTy5rBjfEXqnXxJNLSpXbgePp6ZgxyFK/mXNT9ZTvLeuH184PRIxCnVv8AqRo6aC4HV46Qh2A9MV7CkuP73uT7S1GfolxeRgK0yL5IEvWShcjKTdFey7vhQymf7sh3fQGq8WZticw5sD5FrEpky4pVhpPBQaaeBoyo06xDFNjPVefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+fLr3DJokFnu7rHs/028mWDYVjlOk9PD6k4SN0EElE=;
 b=Re4aXxokjOsjlEW1HVqjHw7gKol/3BsQqUaVwTG1q2+7PAJVX8bJ0A2/o+iC+E5pVWC8A5daeEWJZa/FLbT18p2rSDFyGUcMtD7gLChT7c5PLdzI1pd+fvdaEjtLOHELb5U88oIkXsyZsvXVuApxV/aCAXoUdDlY5L9fdaV+UDO4xULzZj4Wzo20A+gqrUuHqktaxUo8+JGUX6Nukb82jw6uLihr/uWO1vSQCIMvR9gngbbKlY/QgtIk/f91M8MR+2ssr20REjgVZNQmvqgc0daMJ+7/w+uq7fYSRj4yX9kdOrnt5WAHhSNSkY5/b5L9y3Z0BSoDJzFuoSf/FgiVkw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1743.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 19:43:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:43:07 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Song Liu <song@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq405DmAgAB5XYCAABEaAA==
Date:   Tue, 8 Nov 2022 19:43:07 +0000
Message-ID: <d0c60ab6-e618-425a-4279-454901a60235@csgroup.eu>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7xtUKb7ovjLFDPap-_t1TzPZ0Td+kHparOniZf7cBCSQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1743:EE_
x-ms-office365-filtering-correlation-id: 0eeaedd9-8084-4a9e-df74-08dac1c175f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwqO/5tMPmdNvP1mNa74C14LweuApnOShOLu2jvgs9S1h0UNl09E7ZuFmnWcrWLMKid9J/0XB3DEbvaa9gGtPkQz9iFHP3s62lvbGhJhZG7JUTui5MQMKWhbWAUr+5y8G6usP+ct/ky1wMVFONGg8DF5BJRq51hvLm5qcnAVr+4jm0TVA4oPXDwrNVM4csWI4S/d1HXwcNpclqv+swE59GIpWJp2ppXl2ANJ3bNyinMXNbcqsjXXbNiXf36N3efl79UF+96+6lXmLIB6rHHvg4dQxf0m10QrsaRPsQAM5lCDyzlqjRpKj7d5jn6XVrHEXtDr47ggF0DD3lAS4fg7gAajPlDVK3u+Lr7O2WaoNWy5AYHmOi47MQxLORlK7s/LHyudQtjKF9+zFaMbLPaAaiWri3taudcthWFEeUvO2cHM7l/5QXhq+nRzd9AoyCpy9f84oFneg7tb/FzZFSVY700tMaZuTpnCUNIgjBx0f2DlXkDQoKj+GGxVT+a0G8nS0oYgfU03WeC9cNH+kRmdKmeOU2Ih8hqGTicq2IVA+YpKtbiY5FFWCByJ+EthKwTspShIOsjlvUpL15uwTV0dDgTmemYa4RcimkY+gN7e9ajVjiTulWF/93zdEcyls7VuBe7+twaIvjFv1/qjWKDr/4+1M6TPRbBvDomdrantM6ONTPjXINj7YbNdS01nIoCoO8YH9A8tdSVeXXUkBe8jkjhCLK38IlUgoXBgujKWgqbhG+bcbTOAzZb+k41p1J6R3jBUPOkIc73zB/scNrZ/gARqaXwYp8ZkKR7eZEXnLeK6FkeoCwRW12utENiHxPgXsmXgFq4uCLdatDD/zEQu2O4q9/JkqLBmP30ihsVDNDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(31686004)(38100700002)(966005)(71200400001)(2906002)(478600001)(6486002)(44832011)(53546011)(38070700005)(86362001)(31696002)(54906003)(122000001)(186003)(26005)(6512007)(76116006)(2616005)(66476007)(36756003)(83380400001)(64756008)(316002)(66446008)(66556008)(8676002)(4326008)(66946007)(91956017)(110136005)(41300700001)(7416002)(8936002)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXYxZXBOeTdlVmhsRFAxQit6Tlk1WW9qSTJRbkxFTTF2MWw3bmRuSWVXODBH?=
 =?utf-8?B?aW9hSWVoY3RIQ0JGaDRVNlU1WGs2WWZ4dzR6V3lnMVFOWXNrU081Q01TOEVF?=
 =?utf-8?B?OVZOL0kyVlJvcGx6SGtnQkFJMkRlcHdWeTFwa25Jd3VCOGF6TjRrRHBZdGRu?=
 =?utf-8?B?YmdBeHdNRk9WeEtoazljU1MvODBqcVp1Z29GQWtibXJZa0swUFhQK2hCZHVj?=
 =?utf-8?B?ZGsvS1Juay92YTV2blpHRnYyK2daWE1PZEJRc1FVY296ZEdXSTlIZjZCay9Q?=
 =?utf-8?B?ZEpmNXFKVzNxc2xsdkZKSkVUUGhCaXRmYnJYSjhpYnRFaDB5Z1pCa1hlQ0dY?=
 =?utf-8?B?NVV6ZnRzdWNDeEFJMjV0L2JRblJxZElIY0JkWU5CRjQzSkdaSnpsQmdJczBU?=
 =?utf-8?B?d3VUKzNKbzNzS0tRaUZyNytMR1pnOVVWdGlqVWhJZUZ5amlrK1dYQStiaVk0?=
 =?utf-8?B?QllTMU1zVXZmdHJQY1c5ckZPUDZNR1V3cy9FUk9Mb25nZzBCRlR6azFHQU9C?=
 =?utf-8?B?dXlZbzZjWWRoTi9MZCtqRGxhVUh1bzRKUVgxWkNaRWZpaUNDdE0reTFlQlhv?=
 =?utf-8?B?REp3SE5YWDRzM05yV2J4VnBUSUFxUDIrbnF4SlNvMCthaWszRCtsU0dvYXlo?=
 =?utf-8?B?U2liNGlTdlkvL0UzODhVQXdnT3NiOFh2ZUJQOHlLcHdHU2c0OXFkQ3IybkNr?=
 =?utf-8?B?VEp2bmdoSGZMdTRQUkoyNEJkYlVQRXJjbWgrY0daK0JiYXJzSVlQSmgvRFhD?=
 =?utf-8?B?d1lCUmNxUTlsS3c1cUxhQWFsYUtDT3FjWmdBSTJVVFhqWS92Z0ZSMjFidisw?=
 =?utf-8?B?UUxxcmZqRkFXU0V1bG5HeVN1ZVNBbU91NGtMS0VkM0JVSEE0UGdGYkRyNEpS?=
 =?utf-8?B?UWlOMFpJVU1XbXV5blhFZTkvNHloR2ErbFdyNU9zRmJBRE5YdVB4bTZ3Z0lG?=
 =?utf-8?B?NmN2MGh6T3M3dkhQL2huTk5XZDQ2M2k2YitEb2ZTQkJwZzhSRXgxVldHR3U5?=
 =?utf-8?B?TTFGend6TDIwZS8rWmszaDl4UmhIR0t5YnpnSGlwSnZMRHZVT0l6eGtnS1p0?=
 =?utf-8?B?cU90SUYxKzduZWphVXFKay9xVW9zbnlnR0NHVDIydG5iUFZpemN2ajdsNGcw?=
 =?utf-8?B?K2xrTTN4TGl0YWROSHN6RGxVbDRNSDZ4dGZtZzVJaFBSRjNFNUY5cWdkc0dU?=
 =?utf-8?B?SEZ1VElFZ2F4Vk93ZGUxRzdqS0s1ZldWZU9pT1B1eHJJOUJvTDdzSGtFeXJ0?=
 =?utf-8?B?VmVIdHgzSW45Y1pTclROWUltNzE3VzRETDFZTlJaSGlTVGJrQ0Y4cFkrZHRM?=
 =?utf-8?B?cW9zaWUzUXBxdEhNL01TVXdhTTVPZi9iOTdmdXpZQU9IOGpMNDFGQkNPY2Jh?=
 =?utf-8?B?VTdXU0F2RlFMYjFXSDRuNUNTU0hHeUZxb0FXL3d2YS85TG93M1FTSnlvSGRM?=
 =?utf-8?B?clgvZUdMeHJXYWREN0NmNHJ1ZjdaN3NNRFVqbVlPclQvdzNqYk5BRUR0eVhW?=
 =?utf-8?B?NkJsUi9kc09SOWhEVEhCMmdPNDJtVVNvN3ZOdGJMbGpWajJkY0RJLzNRQnBp?=
 =?utf-8?B?RW90TmJLMFgyQmY2OHROOFNiMVVabmFlRTlDV0lXdUFPT2tIRElFWG9KeDVG?=
 =?utf-8?B?M3F4T0RFSnBTamRWbzRTemt2ZmN6N1Y3UHI2LzlBaFhseTVsOVdVUGRLSXN2?=
 =?utf-8?B?RnZPc1BMVXZmNXB4YjRsQy9NcFVMeXdQeVlnVVVwUmpFUjBOWXpDUUdLNVRW?=
 =?utf-8?B?dWlBY0VUU204NlB6eTZXTEM5K3RncFkzQ3ZnKy9qZTRYaUsrdDR0WG1ZR01i?=
 =?utf-8?B?YnlHd3pmQ2JITWJQeEdHaytBcy9GUFpPY00xaXdDWU43eHVBM0xEMGxWY3pG?=
 =?utf-8?B?WFVIZExCakFsdmdvTnZqT3dEV2xNL2xYdkhUL2RIQnc5Tk4wR29GOFZTcTBJ?=
 =?utf-8?B?RDQxNGJKT08veWJKNmJCQndnOGVWaEw2ancxQlZYbC9HaEp2Z051TEdZd0Js?=
 =?utf-8?B?YitGRWl1ZGZodU16UytPYU5pcWRPTjl4UStIODRqM0ZjM3ZDRGh1ZUxhRWJL?=
 =?utf-8?B?OFhkbGlYWGlXaVJSeHlnSlhEYmJwL0ZML2lTbVlHZGVmak0xUXFpYVJCdVIy?=
 =?utf-8?B?YzNFbnpBUHhXTWh0dzFaR1dyL2RlM094R2oxU1VBdHRkeUxkbUo1S0tUQnhK?=
 =?utf-8?Q?PX2fHDdl+9YySTtfh2iMcq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F60D6C7DFE43741BAA4DF7AD228E15A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeaedd9-8084-4a9e-df74-08dac1c175f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:43:07.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCQ8zm7D9nHKLlL+OW1SqZBxXA4ZKecxgkO7GnKQs96u4xeDFst8OvfnpBLZYLwrieYc47+gPQYdn5Hq58iqOr09dO1/s2t6/hgmGZ6CZT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA4LzExLzIwMjIgw6AgMTk6NDEsIFNvbmcgTGl1IGEgw6ljcml0wqA6DQo+IE9uIFR1
ZSwgTm92IDgsIDIwMjIgYXQgMzoyNyBBTSBNaWtlIFJhcG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+
IHdyb3RlOg0KPj4NCj4+IEhpIFNvbmcsDQo+Pg0KPj4gT24gTW9uLCBOb3YgMDcsIDIwMjIgYXQg
MDI6Mzk6MTZQTSAtMDgwMCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaHNldCB0cmll
cyB0byBhZGRyZXNzIHRoZSBmb2xsb3dpbmcgaXNzdWVzOg0KPj4+DQo+Pj4gMS4gRGlyZWN0IG1h
cCBmcmFnbWVudGF0aW9uDQo+Pj4NCj4+PiBPbiB4ODYsIFNUUklDVF8qX1JXWCByZXF1aXJlcyB0
aGUgZGlyZWN0IG1hcCBvZiBhbnkgUk8rWCBtZW1vcnkgdG8gYmUgYWxzbw0KPj4+IFJPK1guIFRo
ZXNlIHNldF9tZW1vcnlfKiBjYWxscyBjYXVzZSAxR0IgcGFnZSB0YWJsZSBlbnRyaWVzIHRvIGJl
IHNwbGl0DQo+Pj4gaW50byAyTUIgYW5kIDRrQiBvbmVzLiBUaGlzIGZyYWdtZW50YXRpb24gaW4g
ZGlyZWN0IG1hcCByZXN1bHRzIGluIGJpZ2dlcg0KPj4+IGFuZCBzbG93ZXIgcGFnZSB0YWJsZSwg
YW5kIHByZXNzdXJlIGZvciBib3RoIGluc3RydWN0aW9uIGFuZCBkYXRhIFRMQi4NCj4+Pg0KPj4+
IE91ciBwcmV2aW91cyB3b3JrIGluIGJwZl9wcm9nX3BhY2sgdHJpZXMgdG8gYWRkcmVzcyB0aGlz
IGlzc3VlIGZyb20gQlBGDQo+Pj4gcHJvZ3JhbSBzaWRlLiBCYXNlZCBvbiB0aGUgZXhwZXJpbWVu
dHMgYnkgQWFyb24gTHUgWzRdLCBicGZfcHJvZ19wYWNrIGhhcw0KPj4+IGdyZWF0bHkgcmVkdWNl
ZCBkaXJlY3QgbWFwIGZyYWdtZW50YXRpb24gZnJvbSBCUEYgcHJvZ3JhbXMuDQo+Pg0KPj4gVXNh
Z2Ugb2Ygc2V0X21lbW9yeV8qIEFQSXMgd2l0aCBtZW1vcnkgYWxsb2NhdGVkIGZyb20gdm1hbGxv
Yy9tb2R1bGVzDQo+PiB2aXJ0dWFsIHJhbmdlIGRvZXMgbm90IGNoYW5nZSB0aGUgZGlyZWN0IG1h
cCwgYnV0IG9ubHkgdXBkYXRlcyB0aGUNCj4+IHBlcm1pc3Npb25zIGluIHZtYWxsb2MgcmFuZ2Uu
IFRoZSBkaXJlY3QgbWFwIHNwbGl0cyBvY2N1ciBpbg0KPj4gdm1fcmVtb3ZlX21hcHBpbmdzKCkg
d2hlbiB0aGUgbWVtb3J5IGlzICpmcmVlZCouDQo+Pg0KPj4gVGhhdCBzYWlkLCBib3RoIGJwZl9w
cm9nX3BhY2sgYW5kIHRoZXNlIHBhdGNoZXMgZG8gcmVkdWNlIHRoZQ0KPj4gZnJhZ21lbnRhdGlv
biwgYnV0IHRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBtZW1vcnkgaXMgZnJlZWQgdG8gdGhlIHN5
c3RlbQ0KPj4gaW4gMk0gY2h1bmtzIGFuZCB0aGVyZSBhcmUgbm8gc3BsaXRzIG9mIDJNIHBhZ2Vz
LiBCZXNpZGVzLCBzaW5jZSB0aGUgc2FtZQ0KPj4gMk0gcGFnZSB1c2VkIGZvciBtYW55IEJQRiBw
cm9ncmFtcyB0aGVyZSBzaG91bGQgYmUgd2F5IGxlc3MgdmZyZWUoKSBjYWxscy4NCj4+DQo+Pj4g
Mi4gaVRMQiBwcmVzc3VyZSBmcm9tIEJQRiBwcm9ncmFtDQo+Pj4NCj4+PiBEeW5hbWljIGtlcm5l
bCB0ZXh0IHN1Y2ggYXMgbW9kdWxlcyBhbmQgQlBGIHByb2dyYW1zIChldmVuIHdpdGggY3VycmVu
dA0KPj4+IGJwZl9wcm9nX3BhY2spIHVzZSA0a0IgcGFnZXMgb24geDg2LCB3aGVuIHRoZSB0b3Rh
bCBzaXplIG9mIG1vZHVsZXMgYW5kDQo+Pj4gQlBGIHByb2dyYW0gaXMgYmlnLCB3ZSBjYW4gc2Vl
IHZpc2libGUgcGVyZm9ybWFuY2UgZHJvcCBjYXVzZWQgYnkgaGlnaA0KPj4+IGlUTEIgbWlzcyBy
YXRlLg0KPj4NCj4+IExpa2UgTHVpcyBtZW50aW9uZWQgc2V2ZXJhbCB0aW1lcyBhbHJlYWR5LCBp
dCB3b3VsZCBiZSBuaWNlIHRvIHNlZSBudW1iZXJzLg0KPj4NCj4+PiAzLiBUTEIgc2hvb3Rkb3du
IGZvciBzaG9ydC1saXZpbmcgQlBGIHByb2dyYW1zDQo+Pj4NCj4+PiBCZWZvcmUgYnBmX3Byb2df
cGFjayBsb2FkaW5nIGFuZCB1bmxvYWRpbmcgQlBGIHByb2dyYW1zIHJlcXVpcmVzIGdsb2JhbA0K
Pj4+IFRMQiBzaG9vdGRvd24uIFRoaXMgcGF0Y2hzZXQgKGFuZCBicGZfcHJvZ19wYWNrKSByZXBs
YWNlcyBpdCB3aXRoIGEgbG9jYWwNCj4+PiBUTEIgZmx1c2guDQo+Pj4NCj4+PiA0LiBSZWR1Y2Ug
bWVtb3J5IHVzYWdlIGJ5IEJQRiBwcm9ncmFtcyAoaW4gc29tZSBjYXNlcykNCj4+Pg0KPj4+IE1v
c3QgQlBGIHByb2dyYW1zIGFuZCB2YXJpb3VzIHRyYW1wb2xpbmVzIGFyZSBzbWFsbCwgYW5kIHRo
ZXkgb2Z0ZW4NCj4+PiBvY2N1cGllcyBhIHdob2xlIHBhZ2UuIEZyb20gYSByYW5kb20gc2VydmVy
IGluIG91ciBmbGVldCwgNTAlIG9mIHRoZQ0KPj4+IGxvYWRlZCBCUEYgcHJvZ3JhbXMgYXJlIGxl
c3MgdGhhbiA1MDAgYnl0ZSBpbiBzaXplLCBhbmQgNzUlIG9mIHRoZW0gYXJlDQo+Pj4gbGVzcyB0
aGFuIDJrQiBpbiBzaXplLiBBbGxvd2luZyB0aGVzZSBCUEYgcHJvZ3JhbXMgdG8gc2hhcmUgMk1C
IHBhZ2VzDQo+Pj4gd291bGQgeWllbGQgc29tZSBtZW1vcnkgc2F2aW5nIGZvciBzeXN0ZW1zIHdp
dGggbWFueSBCUEYgcHJvZ3JhbXMuIEZvcg0KPj4+IHN5c3RlbXMgd2l0aCBvbmx5IHNtYWxsIG51
bWJlciBvZiBCUEYgcHJvZ3JhbXMsIHRoaXMgcGF0Y2ggbWF5IHdhc3RlIGENCj4+PiBsaXR0bGUg
bWVtb3J5IGJ5IGFsbG9jYXRpbmcgb25lIDJNQiBwYWdlLCBidXQgdXNpbmcgb25seSBwYXJ0IG9m
IGl0Lg0KPj4NCj4+IEknbSBub3QgY29udmluY2VkIHRoZXJlIGFyZSBtZW1vcnkgc2F2aW5ncyBo
ZXJlLiBVbmxlc3MgeW91IGhhdmUgaHVuZHJlZHMNCj4+IG9mIEJQRiBwcm9ncmFtcywgbW9zdCBv
ZiAyTSBwYWdlIHdpbGwgYmUgd2FzdGVkLCB3b24ndCBpdD8NCj4+IFNvIGZvciBzeXN0ZW1zIHRo
YXQgaGF2ZSBtb2RlcmF0ZSB1c2Ugb2YgQlBGIG1vc3Qgb2YgdGhlIDJNIHBhZ2Ugd2lsbCBiZQ0K
Pj4gdW51c2VkLCByaWdodD8NCj4gDQo+IFRoZXJlIHdpbGwgYmUgc29tZSBtZW1vcnkgd2FzdGUg
aW4gc3VjaCBjYXNlcy4gQnV0IGl0IHdpbGwgZ2V0IGJldHRlciB3aXRoOg0KPiAxKSBXaXRoIDQv
NSBhbmQgNS81LCBCUEYgcHJvZ3JhbXMgd2lsbCBzaGFyZSB0aGlzIDJNQiBwYWdlIHdpdGgga2Vy
bmVsIC50ZXh0DQo+IHNlY3Rpb24gKF9zdGV4dCB0byBfZXRleHQpOw0KPiAyKSBtb2R1bGVzLCBm
dHJhY2UsIGtwcm9iZSB3aWxsIGFsc28gc2hhcmUgdGhpcyAyTUIgcGFnZTsNCj4gMykgVGhlcmUg
YXJlIGJpZ2dlciBCUEYgcHJvZ3JhbXMgaW4gbWFueSB1c2UgY2FzZXMuDQoNCkFuZCB3aGF0IEkg
bG92ZSB3aXRoIHRoaXMgc2VyaWVzIChmb3IgcG93ZXJwYy8zMikgaXMgdGhhdCB3ZSB3aWxsIGxp
a2VseSANCm5vdyBiZSBhYmxlIHRvIGhhdmUgYnBmLCBmdHJhY2UsIGtwcm9iZSB3aXRob3V0IHRo
ZSBwZXJmb3JtYW5jZSBjb3N0IG9mIA0KQ09ORklHX01PRFVMRVMuDQoNClRvZGF5LCBDT05GSUdf
TU9EVUxFUyBtZWFucyBwYWdlIG1hcHBpbmcsIHdoaWNoIG1lYW5zIGhhbmRsaW5nIG9mIGtlcm5l
bCANCnBhZ2UgaW4gSVRMQiBtaXNzIGhhbmRsZXJzLg0KDQpCeSB1c2luZyBzb21lIG9mIHRoZSBz
cGFjZSBiZXR3ZWVuIGVuZCBvZiByb2RhdGEgYW5kIHN0YXJ0IG9mIGluaXR0ZXh0LCANCndlIGFy
ZSBhYmxlIHRvIHVzZSBST1ggbGluZWFyIG1lbW9yeSB3aGljaCBpcyBtYXBwZWQgYnkgYmxvY2tz
LiBJdCBtZWFucyANCnRoZXJlIGlzIG5vIG5lZWQgdG8gaGFuZGxlIGtlcm5lbCB0ZXh0IGluIElU
TEIgaGFuZGxlciAoWW91IGNhbiBsb29rIGF0IA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjYuMS1yYzMvc291cmNlL2FyY2gvcG93ZXJwYy9rZXJuZWwvaGVhZF84eHguUyNMMTkx
IA0KdG8gYmV0dGVyIHVuZGVyc3RhbmQgd2hhdCBJJ20gdGFsa2luZyBhYm91dCkuDQoNClRoYW5r
cw0KQ2hyaXN0b3BoZQ==
