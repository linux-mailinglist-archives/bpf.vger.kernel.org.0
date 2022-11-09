Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6962295E
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIK60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 05:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKIK6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 05:58:14 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11023021.outbound.protection.outlook.com [52.101.64.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CADF3F
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 02:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEKhcER5/CtkCuNrXnLWWCBO982QYFmvwZQyRbJz/xtIt9SipVr2YAl12pdEXJBlu1H74IMMIUvddVXX7Lf2tUraP75sNKsi5NPD0U5+kt/MVdx8ATrwlr4R0xEUpS4RL50s97YQw5jM6phs4FBKAtss2rreClUX7oTSSdcSDX3OuZu9D1ajQWB66/0qhFqKKi/nSqZ8W0WZiecnXWr2Ug2SAihSsT7kcprI1ymqQi7vBjJ17yKYY4d6CB89KgvuAk4WQStu1lfvOiyC6ctWzQg5V+JFpYKKPpz58rIs+O3GgIUG9QuawFVj74BFhYux59VvRpuzRMlgO/WKzWQ9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19WruFnkVxCyoFGQK2IqY058us91Cr+F8b6jvhcdH9M=;
 b=ljfYnMva/OFwN9ZH1lgOpxBJ+NZi9OSQJzC5OJGH4b9A9vp3awtTFz5ieu77GrtDahOedrM3Or1IjOVp5QTETr2OjLTmhsBX3uC3JjlMCP9liFTrf9fVQivzYQIekhH6CzzQET3dPkklv3lNh54d9Dm/cXuRjEM59u2ZsdEXyPfc6v+AGjO4p835+LaQU7GMFoZCYQYExJyNEF/kWKHK5F8B2RxQXBD+KrlL8dR2nj+VqttUmWpqoKFa5Q+LkAWimtDVwKFS13kUCNcKS10EKNodZvXBDHw3MkQ989LO3OM7jZ63oQ609wzsGBgLjpnHnMzEEl1bULA2z7af2IZGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19WruFnkVxCyoFGQK2IqY058us91Cr+F8b6jvhcdH9M=;
 b=Me0qd3aH2izS68jjLafjZT1aKAdfyMuxPFTAYEB+S6wfwrP+1zBpMZSAH0roh+g4Cteb+IhMAjIHdydIPS/D3wgYzvObLFGSinommzw/4xYfkR9X6GQBNmvx1+cowlj5wGVdatOlgNWm8BFchBi2d2XTueqQxfBVQywVx6JyHrw=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 PH7PR21MB3070.namprd21.prod.outlook.com (2603:10b6:510:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 10:58:05 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d%6]) with mapi id 15.20.5834.002; Wed, 9 Nov 2022
 10:58:05 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Topic: [PATCH 3/4] bpf, docs: Use consistent names for the same field
Thread-Index: AQHY6hHww8vuy8V9aUCZB6BNkmxeJ6415w8AgACY7YA=
Date:   Wed, 9 Nov 2022 10:58:05 +0000
Message-ID: <DM4PR21MB34401726648E72101037AF36A33E9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
 <20221027143914.1928-3-dthaler1968@googlemail.com>
 <CAADnVQKZFkr8T9g=kQRujDWMH_i2P2Ge_jBFG6wjqO6PazfFEw@mail.gmail.com>
In-Reply-To: <CAADnVQKZFkr8T9g=kQRujDWMH_i2P2Ge_jBFG6wjqO6PazfFEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f573880b-3341-46ca-bf2a-4c46a18e7bd7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-09T10:57:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|PH7PR21MB3070:EE_
x-ms-office365-filtering-correlation-id: bba180e1-bb94-4939-f199-08dac241479d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0d60+XBa+s4twNQZYysqIXNRye4Kqv1e8YcuiLLZR0Fu7YpIbJtdy4zJgFbdrvbFsyHOIUqW9NBWraYA9+q0MhX5jVCWRgV7A3r7xxvyD2DD6aYXaVnFUHmDlP4JwH7NbNFqD4SO3hxrHOpeIM7THNWbcgTuQGbmRF9AfKjsDpQmcX5kNl20PdKMocHl3++tdq1V9JVXdgRKdwAeNlpWbmkIiVeYMmUuYsADGaKxSurcthKZocWNlI6u1IdHzSj3RDthsrW5pIqxJt1vExwtHlhoVkJyUpH0OSDTrrAQhBJmjl5/cUzYLOVvzSSQFWQQYgIhB37qhe7HbBcaGKDF00HkJzhCyXnAUvQt0lNzO6CzLQMHdxSOuiTSqBaUXzmONa8yZ0Vv685lnDoQnbCSIQJjR6MB+vU6VxNYx7Bpap38bsXVrZuvMLYCoFjJiX21BD5wp1d9YhYaHS+1RR4NQ1Y9lMwMe70AS/ZTcr/n3nutDosowCBdqRl9FNylIA4SUrxzyXV7MSH736CyqqqOt5ls0NdXG0L3alF3XqIuc0xKnGuivqX9JbOZ6Ho9ACUob2lzhIDtjstdlxWzv5a1muI52zPR2rulUJak7EZZfUL8/kfEflmmpOPtDjKLnxu684O4RjvWKWIKJOG/TZ2IYIA9JiHE0ttwKr2sdLNi/xTX6rLuhGRAUxQxNQwHCExG+EmSyXGayCrVZ3rxzUjMYeEtPOYIhA6G1Heha+LoCi7u0tqsNd7v6wvijeajpGM7Fzo288kzAaILl7yvU/LG0jyV8iZ/nNyGMeY4kw90SGMDMyO+Lq+OEQmwheqfII81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(110136005)(316002)(66446008)(9686003)(64756008)(7696005)(66476007)(4326008)(8676002)(478600001)(6506007)(53546011)(10290500003)(66556008)(66946007)(76116006)(41300700001)(2906002)(4744005)(5660300002)(8936002)(186003)(52536014)(83380400001)(8990500004)(38100700002)(122000001)(82960400001)(82950400001)(38070700005)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZGMXNlalhCVkxKRnlPdTRaQ2s1aEs2ZCttalpkTmxHY3laUi9YODluOExp?=
 =?utf-8?B?SGxNK3FpQkJMN1hWdGQ2K1ZpdUdCTXQzeTBsRHJkYjRBbmhkSWszMDFXY3F4?=
 =?utf-8?B?RFdFMHU3VWlnc2pZb1lIcnZDUmNHMVVldUNleGVqRWhyRHdhZkVaWlZsNUVs?=
 =?utf-8?B?c2pwb3FUZEEyQ0Q4YUxFeThuQWJpWGVibUpjbWNSUGVKUlZocm90aVBzbkNQ?=
 =?utf-8?B?TWNCcGdVQzdjWHBTWHFuUEdTaGpMaGJ3YVhKNDNOdjN4MGQvbWpoajdnUkQ2?=
 =?utf-8?B?WkhvNWczQ0JLM3dnTlNhazF1TVRFY3FtdTYydW9Lc3hsTURlWkhqeXArWVox?=
 =?utf-8?B?dXNIaWRDOVk1WlE4dGZRTllvMFVPZm11b29BWlp2ODZhVW9IdlhGNUl5Mzhw?=
 =?utf-8?B?S01jbndRVDZJSDNUU1ZmMGVLYVBISElYdjRDOW9rb3FoZ0k5eSt5dVJBZzh3?=
 =?utf-8?B?SHRwdTdsUW9lOGd0ai9VamF2ZFJSc0FuZHNwak95ajMzWGdZSkZIY2xqeXc2?=
 =?utf-8?B?STk5Ri8wdEhTN0drb09WRG9LNVpjdUxrR0prTW9qRGZHZDBUVGppTmZPTm01?=
 =?utf-8?B?Q0NXVFRtU0F4M29nTmFMTjNtZURtNFR1NzlrWFlZSThsK0tobTRRUk5jenho?=
 =?utf-8?B?bk1Lb2xLOVI5QmdETzBrbmdXYXl5cENSQlBhTittbnhOckgzSDQwVmlNVG9J?=
 =?utf-8?B?cU5UOW5Iemx0N1JEMElIU24xcjVjSW42SHpBN0lvUmYvR1MvKzRMN1BJdnhH?=
 =?utf-8?B?MDNTR2ZlaDRDREs0N1QxSXdLV0tIaW9GSm5lK3RQUGFYRDN4d3JCcVVoR1ha?=
 =?utf-8?B?dHE2QWt4U1Nualpqei9YVmNkRXhjaFk3Q2RkYUxnWGUrYU1TeDZZWXphdWZu?=
 =?utf-8?B?blZBUzh0ZFNQbEEzZk1TbUVmYkwzaTBwSE0rV3JtWXVvQjhmUjVGa1VyQ0Y1?=
 =?utf-8?B?dE5TL2hhb1JGVzk3aEhFSHZnVmp1ay9XMHk0OVRMbXB1WGFLQkk3MXZNTTlR?=
 =?utf-8?B?Nm44dXFlT1BObjZsRmRZcWVKak15RjI4TVl0T29XZm44czhvVTRvRXo3N2hG?=
 =?utf-8?B?V0EwM2dhaDJ3dU9YcVB2elV6STZGeTJSaDNvcGd6NGVqbEZVb3c0blR1L3I4?=
 =?utf-8?B?U1RTcjRjKzhtSjk5b0QwYmFTQ3Fhc1lkSUlteHg2ZUJJaGF1bHlwSDE3RXU2?=
 =?utf-8?B?eDRTRkxteVhnOHpFVk9qcHR5bFVWM1VXRlpTdWgxd2lVMUtKaW9hYTRkVUlB?=
 =?utf-8?B?cm00eVdxekFMNmhHdUlENXRFWTI4MURzWmZFaytVR1ZlcnhkcTF2amNvR3lP?=
 =?utf-8?B?Ny9tN3prMVdxY1JPMis0ME5DK0p4UzB0QVFWRVNJZTY2UHp0RmdMYWJQQTJo?=
 =?utf-8?B?UU5qZkRhZVF4T0p1M0FmeHg0blMzNitRZHBybnJVdjRTTkF1cGpxSFozQi90?=
 =?utf-8?B?Q2hUUkNCaUFacEhuM2ZTdzJVbjRaYS9hOUtvejBEQUZhUXo5YXlQRWRiYVkx?=
 =?utf-8?B?WmhTZklqWUpRRlhxdUNkbTg4a1hzVUhoU2w5VXJhNE9tWDRMUGc5RnJYZzk2?=
 =?utf-8?B?U0RpRWJmdDVrL25uSDBVNGFVdkgwd1ZEQWdxMUVpWlgrMTVpaVlBQjRncjYz?=
 =?utf-8?B?U2lsUHhldmF4NmZmcjNIU3pMVlRCSWpSVTdxWkZidno0Nk1xcU9ZQXNtZkZO?=
 =?utf-8?B?N01Na3Z5bTM0TEpSZ2xqM3pYZDdGMzVoZjVFMDRickN4azd3TGVFKzJ3YXlU?=
 =?utf-8?B?M3N5TUlxV3hBUmh1VnNhL2gzYThPRXJrOFZ0U04vdklVM0swYTFjcVU0TGtH?=
 =?utf-8?B?UTAwR001QmJDalUzSHNlMjVkNThmbFdwVDVzUjd5NWhnVkNZMWxoNlZaeW4v?=
 =?utf-8?B?ajhuZlBoSWxGZHR2OXFpdUlJcWlDNjVVa2RadHJBb0pKcWJIa2Q2aFcwdUYr?=
 =?utf-8?B?blk4TXpUZks0aTViRlp2eFlQZ3h0QmJKcDY0azdUM1lVcG1oNVVNSkdYMzll?=
 =?utf-8?B?N1FkdnczTEVIbjk4czhPN2ZNRmI0MmNyeWdMVjJyU0NHRkxRdTZsS29nakRK?=
 =?utf-8?B?aXo1K3ZZSG43eXRZWXdwdkR1cmNmUkdydmJRdktrcW9YbnhxMUxPOEJvMmhW?=
 =?utf-8?B?NDRXQlBuLzV5NFNXS0NWY2kyRUNUKzZGZHE0N0pQdStHZlVqTVNUYTFkOXI4?=
 =?utf-8?B?UjZKRS9adWV0YUc4OW95OTBDdmlhSzh3UkJ6M3ZjWWtNRUpray9sNGd2SmV1?=
 =?utf-8?B?TExpbVhBaGZpWldsMWhRbnQ5KzNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba180e1-bb94-4939-f199-08dac241479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 10:58:05.6073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMOVQXlICWaCBrYgWpzOTmtW+sdV3tUEjBHCnXkD1ZhKbLqBOL2qpCCfM7LO/y3m1h7yFGXf24FMM95uO/nGWepWzB3XzrPSI+lj+/CwZxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZTog
DQo+IE9uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDc6NDYgQU0gPGR0aGFsZXIxOTY4QGdvb2dsZW1h
aWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ICsNCj4gPiArVGh1cyB0aGUgNjQtYml0IGltbWVkaWF0
ZSB2YWx1ZSBpcyBjb25zdHJ1Y3RlZCBhcyBmb2xsb3dzOg0KPiA+ICsNCj4gPiArICBpbW02NCA9
IGltbSArIChuZXh0X2ltbSA8PCAzMikNCj4gDQo+IEFyZSB5b3Ugc3VyZSB0aGlzIGlzIGNvcnJl
Y3QgY29uc2lkZXJpbmcgdGhhdCAnaW1tJw0KPiB3YXMgZGVmaW5lZCBlYXJsaWVyIGluIHRoZSBk
b2MgYXMgc2lnbiBleHRlbmRlZD8NCj4gTWF5YmUgdXNlOg0KPiBpbW02NCA9ICh1MzIpaW1tIHwg
KCh1NjQpKHUzMiluZXh0X2ltbSkgPDwgMzIpID8NCg0KSSBhZ3JlZSB0aGF0IHdvdWxkIGJlIGNs
ZWFyZXIsIHdpbGwgdXBkYXRlLg0KDQpEYXZlDQo=
