Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D37651259
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLSTGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLSTGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:06:21 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2081.outbound.protection.outlook.com [40.107.9.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023A65EE;
        Mon, 19 Dec 2022 11:06:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBzZLlThbWZoZl/40wx4fev93zo8TmNBEYczIK1uiNEtWmCDTDZN+VVlGuRHalTTvpx82u5z1rKCHFmSoBIvJP1oVHSoH6Mixjh3YMfzknasaCdcmgBPFt03R/tf/C7I93dLxT25IXqOAfBad3p1CnFPUN/HivErSaeYVxiPLSAGuzuwRxclxEU32J1wENnCK3+RYKRyOIQN118Rvjl693OurIeMOSYaky3LtYFx80wHa1oe4o3G2NMJ4tlY+swPUAG5n+WlFn1s6TD3CTWOpMpyt9UDXkMC+CiF0NYN696qDhFp09SJmbnmGEori1srWF2puavvL2Mu+46EHJSsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6iPrMfJgxTsOlQyMon4vOGHkfSuU5mcajfjSup812Y=;
 b=PaNedae8om0Xrgjwc5Unq5vbJZMYbXtvfdoEVpuj5dPyRsO7iLDuj/bvZUXkRtH8Kv0R4XLBYnsMgAWNWrSwlnhEwgbojRBkRoBijfzXlq9pHq25DnUzscHbcKUol8j+YGNZ1AcWQ6t2l/0yVuRbfUQmrGxXyqxRsdFCCJbtgONZW8gTD2+9DrGli1BQSEa58VV924+0KPNKtBDEGAzouAJy+bUFTPUquxg7VW2CTTNhGuH8Ei0oMqwiqQ4eUfoL2G7NclJAA5AHiyqgohka62ermTpWOPFsg/XBDPFNy75QLmfS/fSAK3cfGQplz6mtjTWKAIGb+ypQiaAd3nIczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6iPrMfJgxTsOlQyMon4vOGHkfSuU5mcajfjSup812Y=;
 b=WsEMvg92eDpVPgsfRgXyxSEm6GV4MYm+HF6vIfkTwhqo4PS0gVwp5EjM7cpWdlV88aQ6vAvFJYgtSfhdiS0LBacI53Svbui2jGub0pgvHZr4gKj8o4hCzhoGIfaRPEG2qw1z3Y4urs+IH1geyNCylb88fZJsHPyeqTWQ7iQZixmK3qqrbW8kSc1emJAS5QrtjRxlmzj8f46WpHz+wFbkC0rXfyFapq1TDwFL6UChrLHKu5pxHDQ5yK9SDI6cwr3E8RaI7nKV2ZbX1WwmaZZSuWZU4bgYMMsyZ2e7H0dawKnspxN6HFaBs2tkzor1C79WWMqDDbPN7HfypqW++ZMDJA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2326.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:06:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:06:15 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v1 06/10] powerpc/bpf: Perform complete extra passes to
 update addresses
Thread-Topic: [PATCH v1 06/10] powerpc/bpf: Perform complete extra passes to
 update addresses
Thread-Index: AQHZBVqCkj8YuVwOdECCOwoQkmb0la5rr0QAgAn/9YA=
Date:   Mon, 19 Dec 2022 19:06:15 +0000
Message-ID: <57406145-4199-00f7-8593-da2f498116f1@csgroup.eu>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
 <c13ebeb4d5d169bda6d1d60ccaa6cc956308308d.1669881248.git.christophe.leroy@csgroup.eu>
 <1670926819.9nqhz2fj7v.naveen@linux.ibm.com>
In-Reply-To: <1670926819.9nqhz2fj7v.naveen@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2326:EE_
x-ms-office365-filtering-correlation-id: 6c64529c-0789-46d6-aedb-08dae1f41a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8umwz5aMt0IqeE3CrmP8I453IW/fUwLX4LD7qL3Fz/kZ3hjELN9+SI9ZmrgVgaRQ8PEv7Nl862x4Vh2RivSIiW97t07g/prtzPHg9Sl8zmtDmIPQZcYBrYDNJgAYN3iNVhs7Kytc1/kwXVaqEK6Su7joLI8pTg8s2fkjTJHNF5W0XrL9Cy0jKYc8VkDq1waJKIdlDP5OVmG4iPDFYxMHA64m+ZjWDag+YBBKx4t3Up9d/fxlN2Ny2pu2U1iOE5E7Qyu58NwKoksKLP6FnovmGkvBMDaraiyrbnMLT1LpgVxrNix3lU75oZslKurQkgs+QG4Mqk8zW2XqtLyPnvMcYhXEsbEcJv69zDeyVCfnRBtdknI8f2yY8u3RniKX0bPD7wPfhA7mFSQuZEPhQBYTewe3tYauSu9+noRodP4SGnLGUzdadGcUZA9wwAKlbUrbtaSDWYv3DGIJ+LyqrGAL6ygGavtc+BD/+K0JS7pcVQGRGdwWUOhhKA2kxtMaFCNCWOLOLYezzDjoIhTpoeFcnBgPQI100EboAO37Qtl7Hfdn1m4rqDQN6OZWPuwoPh7u1sLh9fb49bb/7W0NUfmjfj+3aM3qDDcXASAY7hSuKjfZkTaOknsct58/IYD99uo9H4BzvdMpqswQqdj8XOarDJ9e6fuPFHQFLWKCfqPAlmzzNSN+E3zHuSadgX/QbfLs4DPFfbwqm6bgHbsynhWKMsIi3Hr5OcfJV4H2GbJM42hrid61gyFcDz1EZFNG6ln6k9NJSNCgg9lulVeTYediA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(346002)(39850400004)(451199015)(83380400001)(2616005)(66574015)(86362001)(31696002)(122000001)(38070700005)(36756003)(38100700002)(8936002)(316002)(54906003)(66446008)(64756008)(66476007)(2906002)(110136005)(76116006)(66946007)(66556008)(8676002)(7416002)(4326008)(5660300002)(31686004)(44832011)(91956017)(6512007)(186003)(26005)(6506007)(15650500001)(41300700001)(6486002)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVB4ckJhVGZUR2xsanIyemsrVXJYdExGUHlLTU84UzlSMFR5MXZKazljTExa?=
 =?utf-8?B?RUErR0d3RVl4d2VaQXJ0ek05OERneXNDOTNmT3ZrS1BRRVlPeEZyV3ZvSFlJ?=
 =?utf-8?B?U0VrR1dqUzR3ZGFSd1IxNFljU2wrRlQvR2ZabWM2bE1DL21MRVpDdzlIcGlL?=
 =?utf-8?B?QzJtZVhtdmVMVURJWUZrdENQMGgyNWZPTnRuelZhYWZhdGxzbDJoa1dkSzBR?=
 =?utf-8?B?V2lIdExVUmxBVGcwNWZzUkp1TlB5QStwd045S2F6cUdJVUEvY0lFUmtoVytI?=
 =?utf-8?B?WVcxNVVkbDBnMmJvdDBnMXVXMk5rOS9xLzhEZkpKYXVsSVNHWUUxeHA0RjBM?=
 =?utf-8?B?NmNmalZzWmpQcHlKQys3QVduSEhYU2tMcXRjNkljNkRjNGk0SldQMEptLzUr?=
 =?utf-8?B?N0tCRnBybEJTUkoxVGRROWppWDAxMVpxL0E1Wkp0ZW00YjFuTm5NVktVUWdv?=
 =?utf-8?B?MnR3K3U3YVAzU3lhT3lIMWh6UVpPcUxBU0M4ckRiZXRqbENHTG5XTFF4a3NL?=
 =?utf-8?B?N25KVUVCYW4xQjJuT0pzcm9GUUl2RXdjc2lWSnhvS0czeUNSdEM5SU02ekVv?=
 =?utf-8?B?Si9aUlpWcjNFNEg0U1pkWHZtSnZ2Nm8vaTZNa3ZEQlZrN1hkd1E3cGthRzZt?=
 =?utf-8?B?SG5hcHI2WTFhYnZ1a2pUVXo1Tko2c2ZTcEhnNHpQa2xHanlSMGpneUZjYVJt?=
 =?utf-8?B?Y2I1VUxQb1kzMEJsTzVtNXlRcnA2c3VkdTlidkxXcnpRWkpWZjZub0xGaFdu?=
 =?utf-8?B?KzdmZEUvOGUva2NjSGwxb21kZ1NSamFuQmxTdzFubG5oVGxDRUpSNkd2dWEw?=
 =?utf-8?B?djk4N0JLNVltc0JYNVVuT01jQVNhb3UwNE5xZE5VUkJhYzkyd2p2UzFoZHUw?=
 =?utf-8?B?V2VuR1ZPODlXWG9TdFJJSUNhbXV2SGFRcHA3dU5MU09ySmlBTFo3anJxVSt5?=
 =?utf-8?B?aDBEcGIzNG9FS25WSnNqaW9DdzcxdWFjZm5PazhBM3phSzE5dlczTElMdHlM?=
 =?utf-8?B?azFQQm9HaEJGUFRqdm9Rc1lTWmRmcng5YXF6cE4yalVKNjlDaG5Jc2orNDZW?=
 =?utf-8?B?eDlyWEpYbUdnYThrYTdlb1VSRzdXbTdoczVPTjYxdjA0d0VQcEFYWTFGOVVv?=
 =?utf-8?B?VFZIL1BFQTVwMkZKdnVtNzhMZE1HTm9PN0JXUmE3ZmQ3RFYyLzNGUEo4RStI?=
 =?utf-8?B?R1FWWkU3VVM0MkZweGZubEgvYmtJNk5PYSthOTZ2bHIxWUJ4dW5rOWNnaDFH?=
 =?utf-8?B?dVd1ZU9zUlNoWUwyZ0l3TmVYcEZud2hvbXJ6TWgvOTlnSnp1OFJadGJBakZ5?=
 =?utf-8?B?Wm1xWXd0VzJZU05IUDJIaGg1bTkvdGlVbE5SUzBLb2FYVzlmRlBXRzRIK1Nw?=
 =?utf-8?B?ZFA3VERpYlJ5TGxYUFRsM1NZb3pEMGdVNjNTUlRPRnI1SVA3L1dYUWp4ZFFS?=
 =?utf-8?B?cU1WbjYxNUhPYkEybkJocFFQQy9FVUNsaEtkQlpYVnJnbkxJc2E0Yjlrc09n?=
 =?utf-8?B?U1FZRmZvdHZFNFMycFNlbXhLS1F6UHQ2OHl3aDlkUjliSEpWclpDK2s3OUpa?=
 =?utf-8?B?OU1wTTZKbzR0R0RxbStXMjM4T3E2K0dYMFJtYVNWZzV6ZENKbGFFUGtvQTFl?=
 =?utf-8?B?Z3lNQ0FGdC9PbXFjTm1IT0JwZnZWVGV2aGVMT3pXZTJxN1lZQkhOVWdaS2E4?=
 =?utf-8?B?QTdZUVNobDZsbXBPUUsvWm1jTkNnZHVuR2taTUJCQnZ3VHZZMVF4SzF6elJF?=
 =?utf-8?B?b2wzK1NtQnppR24yaTh0ek1uZHg4RDBuZmtkMUxzTG1oelM2S0tENWFxYTM1?=
 =?utf-8?B?QWdDc2N2ZjJ4bEwxUTFkcS9rVmxXT0l1U1I0b3JQSGdjeUI1UWt2K0d3Q3VI?=
 =?utf-8?B?RzhCYTB0VUNnRERLbGJyL2U5eHF6NXdHNHJCZUdKVWR1NnlEQzBBYlJsT0Rm?=
 =?utf-8?B?VDlDVk5TaG9hczVQU2RoVHZTUGNTT2JuWUZkdzVQNStXNXRza1oxVXNBV2xs?=
 =?utf-8?B?RGcrWDVRSGMxcno3Yko5emRjcW94MldSQXl1enowN2ZROTVxUnRMaVkraXF0?=
 =?utf-8?B?dkxmeUlDdm45VGpGVVpQa1ZWMDVhQVFkOHEwaGJhMndzOXcxcHBBTUlFUTZ4?=
 =?utf-8?B?dHgrRU1FRnQxTFlnUXlDQ0ZxWEdWWmZyT2ZWTHpsdzRMS2ZJNTlRd0ExbUlv?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D5039039A35AB43A2B6B6DF8088CB92@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c64529c-0789-46d6-aedb-08dae1f41a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 19:06:15.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sd3faY/dZF/TGCzPC5woXl4c9rWY0l2kJhZXBUfqbMf/SwWfoX5XbKe1xLYblWndTIQOXtxHEn4tIWPnKyvxCrtMCNmy8DpGjvUqfuz0zoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2326
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDEzLzEyLzIwMjIgw6AgMTE6MjMsIE5hdmVlbiBOLiBSYW8gYSDDqWNyaXTCoDoNCj4g
Q2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+IEJQRiBjb3JlIGNhbGxzIHRoZSBqaXQgY29tcGls
ZXIgYWdhaW4gZm9yIGFuIGV4dHJhIHBhc3MgaW4gb3JkZXINCj4+IHRvIHByb3Blcmx5IHNldCBz
dWJwcm9nIGFkZHJlc3Nlcy4NCj4+DQo+PiBVbmxpa2Ugb3RoZXIgYXJjaGl0ZWN0dXJlcywgcG93
ZXJwYyBvbmx5IHVwZGF0ZXMgdGhlIGFkZHJlc3Nlcw0KPj4gZHVyaW5nIHRoYXQgZXh0cmEgcGFz
cy4gSXQgbWVhbnMgdGhhdCBob2xlcyBtdXN0IGhhdmUgYmVlbiBsZWZ0DQo+PiBpbiB0aGUgY29k
ZSBpbiBvcmRlciB0byBlbmFibGUgdGhlIG1heGltdW0gcG9zc2libGUgaW5zdHJ1Y3Rpb24NCj4+
IHNpemUuDQo+Pg0KPj4gSW4gb3JkZXIgYXZvaWQgd2FzdGUgb2Ygc3BhY2UsIGFuZCB3YXN0ZSBv
ZiBDUFUgdGltZSBvbiBwb3dlcnBjDQo+PiBwcm9jZXNzb3JzIG9uIHdoaWNoIHRoZSBOT1AgaW5z
dHJ1Y3Rpb24gaXMgbm90IDAtY3ljbGUsIHBlcmZvcm0NCj4+IHR3byByZWFsIGFkZGl0aW9uYWwg
cGFzc2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9w
aGUubGVyb3lAY3Nncm91cC5ldT4NCj4+IC0tLQ0KPj4gwqBhcmNoL3Bvd2VycGMvbmV0L2JwZl9q
aXRfY29tcC5jIHwgODUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiDCoDEg
ZmlsZSBjaGFuZ2VkLCA4NSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9w
b3dlcnBjL25ldC9icGZfaml0X2NvbXAuYyANCj4+IGIvYXJjaC9wb3dlcnBjL25ldC9icGZfaml0
X2NvbXAuYw0KPj4gaW5kZXggNDNlNjM0MTI2NTE0Li44ODMzYmYyM2Y1YWEgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcC5jDQo+PiArKysgYi9hcmNoL3Bvd2Vy
cGMvbmV0L2JwZl9qaXRfY29tcC5jDQo+PiBAQCAtMjMsNzQgKzIzLDYgQEAgc3RhdGljIHZvaWQg
YnBmX2ppdF9maWxsX2lsbF9pbnNucyh2b2lkICphcmVhLCANCj4+IHVuc2lnbmVkIGludCBzaXpl
KQ0KPj4gwqDCoMKgwqAgbWVtc2V0MzIoYXJlYSwgQlJFQUtQT0lOVF9JTlNUUlVDVElPTiwgc2l6
ZSAvIDQpOw0KPj4gwqB9DQo+Pg0KPj4gLS8qIEZpeCB1cGRhdGVkIGFkZHJlc3NlcyAoZm9yIHN1
YnByb2cgY2FsbHMsIGxkaW1tNjQsIGV0IGFsKSBkdXJpbmcgDQo+PiBleHRyYSBwYXNzICovDQo+
PiAtc3RhdGljIGludCBicGZfaml0X2ZpeHVwX2FkZHJlc3NlcyhzdHJ1Y3QgYnBmX3Byb2cgKmZw
LCB1MzIgKmltYWdlLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgY29kZWdlbl9jb250ZXh0ICpjdHgsIHUzMiAqYWRkcnMpDQo+PiAtew0KPj4gLcKgwqDC
oCBjb25zdCBzdHJ1Y3QgYnBmX2luc24gKmluc24gPSBmcC0+aW5zbnNpOw0KPj4gLcKgwqDCoCBi
b29sIGZ1bmNfYWRkcl9maXhlZDsNCj4+IC3CoMKgwqAgdTY0IGZ1bmNfYWRkcjsNCj4+IC3CoMKg
wqAgdTMyIHRtcF9pZHg7DQo+PiAtwqDCoMKgIGludCBpLCBqLCByZXQ7DQo+PiAtDQo+PiAtwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBmcC0+bGVuOyBpKyspIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCAv
Kg0KPj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBEdXJpbmcgdGhlIGV4dHJhIHBhc3MsIG9ubHkgdGhl
IGJyYW5jaCB0YXJnZXQgYWRkcmVzc2VzIGZvcg0KPj4gLcKgwqDCoMKgwqDCoMKgwqAgKiB0aGUg
c3VicHJvZyBjYWxscyBuZWVkIHRvIGJlIGZpeGVkLiBBbGwgb3RoZXIgaW5zdHJ1Y3Rpb25zDQo+
PiAtwqDCoMKgwqDCoMKgwqDCoCAqIGNhbiBsZWZ0IHVudG91Y2hlZC4NCj4+IC3CoMKgwqDCoMKg
wqDCoMKgICoNCj4+IC3CoMKgwqDCoMKgwqDCoMKgICogVGhlIEpJVGVkIGltYWdlIGxlbmd0aCBk
b2VzIG5vdCBjaGFuZ2UgYmVjYXVzZSB3ZSBhbHJlYWR5DQo+PiAtwqDCoMKgwqDCoMKgwqDCoCAq
IGVuc3VyZSB0aGF0IHRoZSBKSVRlZCBpbnN0cnVjdGlvbiBzZXF1ZW5jZSBmb3IgdGhlc2UgY2Fs
bHMNCj4+IC3CoMKgwqDCoMKgwqDCoMKgICogYXJlIG9mIGZpeGVkIGxlbmd0aCBieSBwYWRkaW5n
IHRoZW0gd2l0aCBOT1BzLg0KPj4gLcKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqDCoMKg
wqDCoCBpZiAoaW5zbltpXS5jb2RlID09IChCUEZfSk1QIHwgQlBGX0NBTEwpICYmDQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnNuW2ldLnNyY19yZWcgPT0gQlBGX1BTRVVET19DQUxMKSB7
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBicGZfaml0X2dldF9mdW5jX2FkZHIo
ZnAsICZpbnNuW2ldLCB0cnVlLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZnVuY19hZGRyLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZnVuY19hZGRyX2ZpeGVkKTsN
Cj4gDQo+IEkgZG9uJ3Qgc2VlIHlvdSB1cGRhdGluZyBjYWxscyB0byBicGZfaml0X2dldF9mdW5j
X2FkZHIoKSBpbiANCj4gYnBmX2ppdF9idWlsZF9ib2R5KCkgdG8gc2V0IGV4dHJhX3Bhc3MgdG8g
dHJ1ZS4gQWZhaWNzLCB0aGF0J3MgcmVxdWlyZWQgDQo+IHRvIGdldCB0aGUgY29ycmVjdCBhZGRy
ZXNzIHRvIGJlIGJyYW5jaGVkIHRvIGZvciBzdWJwcm9ncy4NCj4gDQoNCkkgZG9uJ3QgdW5kZXJz
dGFuZCB3aGF0IHlvdSBtZWFuLg0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYnBmX2ludF9q
aXRfY29tcGlsZSgpIGlzIGNhbGxlZCB0d2ljZSBieSANCmppdF9zdWJwcm9ncygpLCBzZWNvbmQg
Y2FsbCBzZXRzICdleHRyYV9wYXNzIiBkdWUgdG8gaml0X2RhdGEtPmFkZHJzID0gDQphZGRycyBi
ZWluZyBzZXQgYXQgdGhlIGVuZCBvZiBmaXJzdCBwYXNzLg0KDQpDaHJpc3RvcGhlDQo=
