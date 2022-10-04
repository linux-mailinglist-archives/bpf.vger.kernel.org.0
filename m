Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEA5F4938
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJDSXu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 14:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJDSXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 14:23:48 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021014.outbound.protection.outlook.com [52.101.52.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5ED5850F
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 11:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvt6sKDAOiPHnMT49Chgf4LBDEg51zmssa/9Gyd5YW+aIgwV+ufTTpkNxEQue+cBQRKT3DxIfEF5tVo+LkRU4Ai6tCguj2RoPx4ycfXeTByg2+DrCngfash+xDyjZS+CRDHKcPTapCJlG4ggGy71GGkMlPda7m7P3gJzGiS6/PhNIMCickz3iuWHP+Y5G73rtFZ4biUthdE4zv5c3UtcLPB/fUXbXTBq5imF9T9G9xX2qtjzqsgERKzKFu/K2IwsQISwB7Ql2Gwv6eP8TRTgbsFlAKqOWBHxLzjSDHsxUMU5uzDG80d6hJDspDCQb0pV5exd2p4NCVGbYc72GfqU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UolFRfkALW2vkDDf3CDx074rbrItyBck2JSNIBw4boc=;
 b=kKJdhWtzVl617OKA6NaeaPhDR341T2UEjlAHB3wmvKTa0DBD72wgviy8CYDRTb1f7/lSReDU01sTXLn35I66deXHw6jJ74e3JqKd3idUcNNfK5mjJKhEiIPYOhxAKiFimwQ23o6qTzBXj/CIfvN/N+EeDuLalYR5DugDWH2anss371DY0h6J0vggq9txxJNJW0kVcHcX5+bQsNJtVgahp2JsZ1e0Xrqa3dk1mlHvG2Z/WKd5qsRlrgvi2oqKn1v3lCT6GsbP3xQhbPdaSxpk4/RtWR/SNdXD6ad29jvt7ZPyjL27DG40LececR5yqEeszY5Z8mdNnPTNJ+Q8K7kTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UolFRfkALW2vkDDf3CDx074rbrItyBck2JSNIBw4boc=;
 b=bWV0viXdcRadxaSynohZmrQ0ojLZz//ejC42MZ0T4amxwRj7Q8byPWNu9vizKDgztqCLV5zZ1TtqZK6LXfbuh4M6pOuzEDSZp0gD2LcmaFiaF1iIFpHFTKTCIjNt9iDGDIQi+rTQilhnjWHjNY/OH+a9z/xANFDKkcT9/tbPKCw=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 CY8PR21MB3801.namprd21.prod.outlook.com (2603:10b6:930:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.8; Tue, 4 Oct 2022 18:23:45 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 18:23:45 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: RE: div_k. Was: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by
 zero, overflow, and underflow
Thread-Topic: div_k. Was: [PATCH 07/15] ebpf-docs: Fix modulo zero, division
 by zero, overflow, and underflow
Thread-Index: AQHY0qNnkHKOYI8p1UG845fwAHqmHq34d7+AgAAQ4JCAAAHbAIAACxbAgAARhYCABdEJwIAADw2AgAAJWpA=
Date:   Tue, 4 Oct 2022 18:23:45 +0000
Message-ID: <DM4PR21MB3440DC0EE41F65013FE15E45A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com>
 <DM4PR21MB34409A021A6658DDAAB3B5AEA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQKYb9fB2-AcPB0sMbE_pT2cQhOiKQw0q5rPxXHZ-6eXTw@mail.gmail.com>
In-Reply-To: <CAADnVQKYb9fB2-AcPB0sMbE_pT2cQhOiKQw0q5rPxXHZ-6eXTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fa0ca8e1-6fd1-473e-9b99-04cdfcc2b930;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T17:58:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|CY8PR21MB3801:EE_
x-ms-office365-filtering-correlation-id: cdd5036a-42d0-4a69-1703-08daa63592f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6o8gS4SRt0rbs1X8T4Sv6zA3Je3XklPU80tiJ0rsMIOShnF+737VkP4GJ0Jii5N4BKX5ihWzFnDoPW2xKOqvUbLRTPYva8wcYmFKpYne84YvzC13JYvtyQNBazN9t68M2N7cIbM9Tgoom4Cm19Ew3P00PSBPTmnOBzcNnFawDsW8o4dBAzSlyEc0aebaUSr8uPNLfxeX2lYHwX1Rby81nKSdAQEIZTs8aKfe7pexshE45xMDMTVqgoTnq2J90bQkZms9K0fLN5Aw3iUtqfix7Af1ovn5dG8PFAVccgx4RjhEzWj7ngexG/BNC+uX6eYREyjsqhhSXHvT12QZTLu15HsMhFMrqb1WRFeM23+tvpKFzbumQRAlrJbANPNokiO+v9jf2gcNgBdzYH/FNQ0ouvTIS/Fuv9PFeKQe7GXKruZkvMOYkRlNe1Sad7S28pjjGXwYctDxQ1v6B9YnxEO2zZnqTzWxFs11E1W2JhaSKDpSLBgrS/dgP1al9dYxkcEzXlLnNXi92d0OThHLzLMTRMRNWq3TqBRJVYHhRXjKeNY7Xp5S8QZzEDBoeV5PcXCp1F4NcQRvohkgIcW7qqL/Rdm65zTTd8GFeNqzQcsoyKZcfvCK3f0LtZe46QYq7JxqDoDstZd8ed6+tnJeYPjXTe9IQZqASw1bKaBdue/EIHDCYSh1gB5O0GH4XYg7gL+mz2U2HBieMZTuzwmZsWwvwgZ9ZFrTYLJlumcunaO7uVsgYQfR8tdB9xCLQtSYQEF8wGvPRiCTHndEo0/M7oClhjFMOZcpwW3PQVF9AwFanTeVhCrcxLppbetLGPjKmod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(86362001)(8936002)(52536014)(2906002)(5660300002)(41300700001)(33656002)(38100700002)(82960400001)(82950400001)(186003)(66946007)(110136005)(316002)(55016003)(76116006)(54906003)(122000001)(38070700005)(66476007)(8990500004)(66446008)(66556008)(4326008)(8676002)(64756008)(71200400001)(478600001)(83380400001)(6506007)(9686003)(26005)(7696005)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE5uM21BOHlRaEVLOHhOdkR4YzZKbi9IUWg1c1VBT3cvZkpuWFgzNExpSDJ2?=
 =?utf-8?B?dHR3cTFPZGlJQ1VXajJWTmNWRm53WVcwN1Yra3NoYkFyM3k3aEEwNnVGSUhC?=
 =?utf-8?B?NHNKVGJPSEFmZzRGZlBEL3oyZGxINW52MHhYV3E3RUJ6UldITFZGMVF1UHpZ?=
 =?utf-8?B?a28wWnltbVJ5QmFPampqQUw0MkgxRER6Ky9LYkNCbm5qLzdaZk04RzhoUUpU?=
 =?utf-8?B?NlNKemg5OVVsVTJtVmc5VDZvUXJyTnBQaWF4UUkxZVlsNlJaMmhpczFIRkxY?=
 =?utf-8?B?ZFMyQTFlTHNOU3JsZE03Ykw2amJvbmErOUVKRDkzOExWQ0lmZVZzeklHYlYw?=
 =?utf-8?B?UnNrUVlJNEE3djlKSldSOHY5NDZzVm8vOHF3NzZ5MVZTdlNhY2FIN1VSVTVl?=
 =?utf-8?B?Wi83ZGVxZDlXM3FNOWN6MkJvcjIxTElRNmhyaWhHM0dnM1lSRE83ZHlmYVhw?=
 =?utf-8?B?V0NuSkkvaG9OYmtCM3VoV2wwdVV5WDJFL0hDMXNrV2cyLy9vYk9lWEUybTZB?=
 =?utf-8?B?RE1YbmRlVFEvV01ac3ZZenlRRVVlaHBjUGVmckt2c01Sdjc5cDM0MmcrYjNX?=
 =?utf-8?B?LzZ4bUh4VGc0T0JBamhGVGMvQVZBeGRRTFphL2FkVG01TzkwRlBSd3h4OTBD?=
 =?utf-8?B?ajc0M3dlb250RzRaNFVldytidm9JOU1vaU1uYmE4Q25DYTYxaXNPZWdnMjFY?=
 =?utf-8?B?REhxS0J0S0tOakl4bWFrUTh2NEZKenBSR0g5Z1FmcVkveUxGU08yeDBCQlgz?=
 =?utf-8?B?ZENiMTE1U0JBWVZ1dEg4Q0tGVmJuR2o4ZXRlVG9Cckl5Z0dGcEhkbC9PZEI4?=
 =?utf-8?B?OTlUWFpJS3M2WU9ML2lRZmM5M3dOWEZzS0NnY0NHdW9YaGlxWDhFZUVDMmZT?=
 =?utf-8?B?RVYxZ1p3Wkwxb3NLYU9qODNZWkZ4eDJ1MDhQRk1oci9QZjAyYTFpdjBiYmZZ?=
 =?utf-8?B?dW5NTlIzSzh4UHVVQWxNVjd0MTlUemJsRkR5ekRDaVpnZk5sVmYxNXVhM2gr?=
 =?utf-8?B?RGoyMjVkMVlYb1VTeENTWko2RU4rWXBIK01PYUpKY3FxWVJxM3RCZFV1Vnl6?=
 =?utf-8?B?eGdXVHRycllvcGJLZkNscC9BZ3dYblJCUUY5QjhldTVmQTAvcG0rMjkrNXRI?=
 =?utf-8?B?RXJBWU5TUkU1ei9NL0cvalNTWlg0eWVsWEp4c3pVdXZyNnZBSEh6My9wVzJN?=
 =?utf-8?B?eDdzNDAwZmZ3SnRRNXZ4QjFpc3ZnblI1TE9oczZNNElzU2gxd1NZelQxa0Yx?=
 =?utf-8?B?eUxzMXlpOWF4MWxaWm1ZZVdRbll1SkJCNHorYVQ1UWQySmxnN2JCdlcvRzlS?=
 =?utf-8?B?L3EvcHQ0NmpLYW81OW10QUlKZkdRUjNTdUNNL2RYY3Mxb0lUamh0UW5mcWR4?=
 =?utf-8?B?NTVTeHh6U21BeFAvNVFrNmllLzNvRnpuS3BMVlNha0kvem1OY24wWUNCQjZX?=
 =?utf-8?B?aUpNWmt4Q2tNeXJpYXZPbXY0VEJaTzUxVnVobkhiZ2F0MFZHSnB0VU8yR05j?=
 =?utf-8?B?YWppTGQ5enRxSllkZ1RiVTRpbyttQU51SEYwSW8yOE5SV1hhSFlEZUUyc1Nx?=
 =?utf-8?B?VmtqT3haekltYjN3a3RrbkVkN1hDc2t5MWxBSmE1TWlnRFJkeFhETjMrNm9m?=
 =?utf-8?B?YVgwSGhlUXAycms1eDU0RUpYTmJ5Y1pQNEkzTE1TOVJhOG0wQVNHWnpMdWFz?=
 =?utf-8?B?STBWNnhzcmpBSmVGZUZIa3lhZXhFeFdVY08yUFM4emJRNEJyaS9uWWNDTDlI?=
 =?utf-8?B?c3NQalZ0T3JhNlBmaGlhK1pLbmRDV2ZRazlKT1dWSDRQUmJVSGJldEVjMDBL?=
 =?utf-8?B?OWJ2UFhzcThybmpvNmlKM1hXTUZVQjFselVHVFFvc2EvWi9zSFpXbDZNcmha?=
 =?utf-8?B?amVVdk11U1NubnV0NFlWTEdGKzg4NlVZMjdueEdaR1RvNE1aUUMwRGpPenR0?=
 =?utf-8?B?QWl5NktOYjE0cjBJelo3K3BPdUgwRU5sSDF5eG4vdUM0Qk81L3IwdDhVMmhw?=
 =?utf-8?B?VnVmdGNHQ2VKYjBHV3BMcE8reGZnZXYwRGs5Q0hycW1RbGF3MEptdWxNT001?=
 =?utf-8?B?cWx4TGZySGVlUFpPeWp0QkVjWDVWaDlJZStIejlzTTYzMUdPcEVxdGs2SUtz?=
 =?utf-8?B?L3RmcmVvZ2duRWhIbXNINjBXVFFHSUpqZzFoNVppVGR1WlZubDVDN1M4WGk1?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd5036a-42d0-4a69-1703-08daa63592f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 18:23:45.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V35X3VW92DKSFABkWHQZ4lqLCVIvix8VkAZ1ncFoXBA9KM8PfjJcvjiKdU1PJskPEOdX5TItFTVuyn0IsqZ/30QshkiT2paZIP4IrvV6G2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3801
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToN
ClsuLi5dDQo+ID4gV2hhdCBpcyB0aGUgZXhwZWN0ZWQgdmFsdWUgZm9yIHRoZSBmb2xsb3dpbmcg
NjQtYml0IEJQRl9ESVYgb3BlcmF0aW9uOg0KPiA+ICAgICByMCA9IDB4RkZGRkZGRkZGRkZGRkZG
Rg0KPiA+ICAgICByMCAvPSAtMTANCj4gPiBJcyBpdCAweDEgb3IgMHgxMDAwMDAwMGE/ICBpLmUu
LCBpcyB0aGUgLTEwIHNpZ24gZXh0ZW5kZWQgdG8NCj4gPiAweEZGRkZGRkZGRkZGRkZGRjYgb3Ig
dHJlYXRlZCBhcyAweEZGRkZGRkY2IHdoZW4gZG9pbmcgdGhlIHVuc2lnbmVkDQo+ID4gZGl2aXNp
b24/DQo+IA0KPiB4ODYgYW5kIGFybTY0IEpJVHMgdHJlYXQgaXQgYXMgaW1tMzIgaXMgemVybyBl
eHRlbmRlZC4NCg0KQWxhbiBKb3dldHQganVzdCBwb2ludGVkIG91dCB0byBtZSB0aGF0IHRoZSBx
dWVzdGlvbiBpcyBub3QgbGltaXRlZCB0byBESVYuDQoNCnIwID0gMQ0KcjAgKz0gLTENCg0KSXMg
dGhlIGFuc3dlciAwIG9yIDB4MDAwMDAwMDEwMDAwMDAwMD8NCkFzc3VtaW5nIHRoZSBhbnN3ZXIg
aXMgdG8gemVybyBleHRlbmQgaW1tMzIsIGl0IGNvbnRhaW5zIHRoZSBsYXR0ZXIsIHdoaWNoDQp3
b3VsZCBiZSBjb3VudGVyLWludHVpdGl2ZSBlbm91Z2ggdG8gbWFrZSBpdCBpbXBvcnRhbnQgdG8g
cG9pbnQgb3V0IGV4cGxpY2l0bHkuDQoNCj4gQnV0IGxvb2tpbmcgYXQgdGhlIGludGVycHJldGVy
Og0KPiAgICAgICAgIEFMVTY0X0RJVl9LOg0KPiAgICAgICAgICAgICAgICAgRFNUID0gZGl2NjRf
dTY0KERTVCwgSU1NKTsgaXQgbG9va3MgbGlrZSB3ZSBoYXZlIGEgYnVnIHRoZXJlLg0KPiBCdXQg
d2UgaGF2ZSBhIGJ1bmNoIG9mIGRpdl9rIHRlc3RzIGluIGxpYi90ZXN0X2JwZi5jIGluY2x1ZGlu
ZyBuZWdhdGl2ZQ0KPiBpbW0zMi4gSG1tLg0KDQpZZWFoLg0KDQoiQUxVNjRfRElWX0s6IDB4ZmZm
ZmZmZmZmZmZmZmZmZiAvICgtMSkgPSAweDAwMDAwMDAwMDAwMDAwMDEiLA0KIkFMVTY0X0FERF9L
OiAyMTQ3NDgzNjQ2ICsgLTIxNDc0ODM2NDcgPSAtMSIsDQoiQUxVNjRfQUREX0s6IDAgKyAoLTEp
ID0gMHhmZmZmZmZmZmZmZmZmZmZmIiwNCiJBTFU2NF9NVUxfSzogMSAqIC0yMTQ3NDgzNjQ3ID0g
LTIxNDc0ODM2NDciLA0KIkFMVTY0X01VTF9LOiAxICogKC0xKSA9IDB4ZmZmZmZmZmZmZmZmZmZm
ZiIsDQoiQUxVNjRfQU5EX0s6IDB4MDAwMGZmZmZmZmZmMDAwMCAmIC0xID0gMHgwMDAwZmZmZmZm
ZmYwMDAwIiwNCiJBTFU2NF9BTkRfSzogMHhmZmZmZmZmZmZmZmZmZmZmICYgLTEgPSAweGZmZmZm
ZmZmZmZmZmZmZmYiLA0KIkFMVTY0X09SX0s6IDB4MDAwMDAwMDAwMDAwMDAwIHwgLTEgPSAweGZm
ZmZmZmZmZmZmZmZmZmYiLA0KDQpUaGUgYWJvdmUgYXNzdW1lIHNpZ24gZXh0ZW5zaW9uIG5vdCB6
ZXJvIGV4dGVuc2lvbiBpcyB0aGUgY29ycmVjdCBiZWhhdmlvcg0KZm9yIHRoZXNlIG9wZXJhdGlv
bnMsIGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkuDQoNCkRhdmUNCg==
