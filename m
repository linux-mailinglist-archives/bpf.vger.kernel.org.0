Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968D5660635
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAFSL5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAFSLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 13:11:55 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022025.outbound.protection.outlook.com [40.93.200.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FB7622D
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 10:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNH7JavT0Xw9FDceuTZ4Qqkm4S60OADt93PL06z6/NVFcP+xy2md39DEPA//twyIswM0wbYqDZR+KidW7JL74f6UtjvxARFQO6rrqYWUpfjA6iiQlWmUUi4E2YMfZ2FXtr3G6hRY2zHwRZnSCEYumL9HFbTYvjHeJ18XIHgf1ll96ko0TxMAVVTgS1eyuqlum1OaHcRK6PjUZLro7x2ohLxans1LV9/VmD57jLfVET/Q48hkXE3em6+XldAMnrD5jEprJUtufCeJFU7wpONZm9w2N+6AS3TlWDK4dd6hjrUKb/CHf99ewCnimruefvYbGsHtwgn8Fz15fq8Wk65L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cfUlQTdnF/6O/2NC/mmfxagvSHqLo/twGDZbst0BLc=;
 b=CNNi+h/etPZ0TvaI+Gyz2okXpzwa/pOA6CjLo8DvBaJXhVFz4d5J7A3r31gKuYzaXiL9tjcIju/PVTp/Zgdm6IoVWXqTxuxY1UopLptAXjeYBeADxZtt/BUFBZLB0uXG1yfVfTy+8qTS5+yyJL1tgYt6JFz2IFATA+5/X01uWQ+u+HT9arKJ0kpQzyagDJs+DgZnn4D+xdXq0D4ROiWLd3o6OmieG7Hzwy4IqqAiZrckTW+6mwI+PlBRDmaGo722vrCIMaJ1TlK/Zy+l+uCh7or9jLpf9w8YkfXcfW7r6l4srCNy78iGCRVjXSArGn2ZI1W/rtaFUshyyA3cFR3mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cfUlQTdnF/6O/2NC/mmfxagvSHqLo/twGDZbst0BLc=;
 b=LpqpvkXn/mWO2t7lbF8V/ORVTJ3kQN8rb95IiMWyO230z8UXXDdYCWb9NmKrc0IEJoIGjK+uqUfe6ztor2TloT6xQy+ZPI3M32w9UFSYEpA0eD0nermEYlab3mNot4sYrvHRX690Nxb94RXXurAAWC/8gvHrywt/MiP5tczv9nQ=
Received: from BN6PR21MB0788.namprd21.prod.outlook.com (2603:10b6:404:11c::17)
 by PH7PR21MB3359.namprd21.prod.outlook.com (2603:10b6:510:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.5; Fri, 6 Jan
 2023 18:11:52 +0000
Received: from BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::86f8:961e:9dfe:e7b5]) by BN6PR21MB0788.namprd21.prod.outlook.com
 ([fe80::86f8:961e:9dfe:e7b5%14]) with mapi id 15.20.6002.005; Fri, 6 Jan 2023
 18:11:51 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "sdf@google.com" <sdf@google.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
Thread-Topic: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow,
 and underflow
Thread-Index: AQHZISNUJN/U8BCkwUW2LD2+a+VNg66QLeeAgAFnYYCAABqEMA==
Date:   Fri, 6 Jan 2023 18:11:51 +0000
Message-ID: <BN6PR21MB07880DB65051DCAC6F8D0021A3FB9@BN6PR21MB0788.namprd21.prod.outlook.com>
References: <20230105163223.3472-1-dthaler1968@googlemail.com>
 <Y7cefSXEQ3M3C9pk@google.com>
 <51a639d4-c140-a10e-cd67-fff92ebcda9d@iogearbox.net>
In-Reply-To: <51a639d4-c140-a10e-cd67-fff92ebcda9d@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a979090b-d594-447f-98d4-5e501a6a9e98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-06T18:02:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR21MB0788:EE_|PH7PR21MB3359:EE_
x-ms-office365-filtering-correlation-id: 38285557-4d0b-4452-a294-08daf0117c61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imu9T3PGHuhkDSURpA83eyZfHPDMeXTtmeMZUEmEh8FA0XMDcEzgi14A9qAEj6jVsogTOa5HUYE0XcdKYEWdoqRn0v3B7hOfcZAXBzqe6Kp2VvZ1ddjulWdlfpcqur17lvKpQpCy3NZzK+LxvxSqNUfkWek6/dHpUgNDNCA532DvwrFhF5PRgW6WqWjNoGGnkwjvxvZvlcbCf8HDzBlnKs9xfF4emAv66OUl1So0zF0WU+try7v/r64BZg3YU3/52kQgeibmm6rxDGrzs5vUiOMJWWj2DkaAyL4huzFgJDVxZNvHYAl4BDHOmLbq0B2O0yIakU0f7jacFCYroMVNkasYIdrTv5TbfWaQpdjNoWEnS/OSg764ohktOiI2+jj5DUkrgrxtT6pQ7nBqXIbCUBCi73tTmCtIhcSvBPUJhvUGTXt4RstIYSFY1bQFahUBkz19ohKAJo0KNnBHab1iSxq35pxumTIINulKbjwRa+WYIrALit5ykHoYJkbxedJQZvVNRFm9mE2jazmsKBWPk/+5tmGLj6xMDWHFjU5uLXjXT3tJ2XMUhzk3JP/iFWbZF4cJTK78XcPYi2m88PdHDW/YYdkX391c92F1Hf4PH9A7/H21mNQwovpvtV1gG3SWIZV5oo/m8ydjcCbtLyyJKeJBby3jX4uJC2S/Cu7GS53hMnt/9wM/OtpC2/I7qEF0v6JasfIfd9akgaSBBz5sexqoS8qruTFs+64/JZ1/NZ7fQu8+Qx9kOwCnddYbJYATR6zAFFBKIwLVs8v6kD8CDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0788.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(186003)(71200400001)(316002)(54906003)(478600001)(110136005)(10290500003)(33656002)(38070700005)(55016003)(86362001)(6506007)(122000001)(82960400001)(82950400001)(2906002)(26005)(9686003)(38100700002)(7696005)(8990500004)(66556008)(966005)(41300700001)(52536014)(76116006)(8676002)(66446008)(64756008)(8936002)(66476007)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnNRbWlZSExMNTEyR3R1SFRacWd2N1hnMTN2ajNIN1JLbmI4dHM5bW81VlpF?=
 =?utf-8?B?Y040eVY2WENPZlhNeHJjanBHbk9JcDJqZ2N1WFVuTDFxcENrVmNGdWt0cDJt?=
 =?utf-8?B?ZzFzdTNPbERDYy9MeWxQSE42cDRIckdIbWtSYVQ3MTJENENDcVZTNVpZOTho?=
 =?utf-8?B?aVBybGZDbDY2bmVpbUFyQllIVDlaektqMXg3YVFHZk9ocXUyU3FUM2dnbWw0?=
 =?utf-8?B?OU1ZSFdONUhGWmcwK3hYdDU1SmZZTkZ1ZzRyTU95eS9Jc1VFQzBrNHFpTFdK?=
 =?utf-8?B?M1VWMmVrajFqWEw4TkFLc3NjcUVndVNBN2N4UTJUNHNUVGd1aUhMU0J5a0FK?=
 =?utf-8?B?cXNHRzVMaVUwS0pyT2JSNmlPZGJtZGVUZStRNEtqbmZUQ291Umxmb3RPZU5R?=
 =?utf-8?B?RXJ5RFFWTlR0L2hYMlgvSDFwRDNyRWFXN1NVU1phWUNJNU15ZnBhbloyUzB3?=
 =?utf-8?B?dzF2ZDErOGVveHVYMFh5K25mM0kwb0RRdUZ2bmlhdi9iYkpBTlVOOWlpZFFl?=
 =?utf-8?B?OXRReTVibTJVZ1M0azV2UWZZMTJlK1QvVDRXdWZmOG9JQ28rdU92VHZkTmFL?=
 =?utf-8?B?enZhM3BFL2dTeFU5Qi9DRjdSM05NT2piS25xbVlSZGxncW1vRE9YQTVuaW1Q?=
 =?utf-8?B?SVpTam1Wam1SdU1ZeHpyN0N1cWJLS0tDQ2xybUx2T2l1TjRQdm9aZi9EK2dt?=
 =?utf-8?B?YkthaVdsT3pPWjcrOWQvaktIVkJGZkNUVFFRRnJYUkFYVkVHMmhmODhaMWI3?=
 =?utf-8?B?dUpPMGtmZWMvMm9UNkZMR1hsa2dQVDZsc3YwY0RPT05VU2R2WjdTNk9MTVly?=
 =?utf-8?B?ZFVCekUrMkZjWVFodFp1SWZjdFN4c3FSU3J2Uk93aGpyY1BjK1krNGlmdkF3?=
 =?utf-8?B?dE90VU9sVVZpMENrN2d3cWE1S1JOY0Q5MnB4SnMyZG5vd1h4ZEFjTnowTUlw?=
 =?utf-8?B?NVhQbFQrTTRUUkQ5TlVxcldDUHVWNU9wS1gya2ZxbGIrK1RFZGk0S0k3dWI2?=
 =?utf-8?B?ZHlvV0pOeWRvZ1lXSVlQVGVUcVYwQkpacGk4S3JsSENwUUdCQTdEaEtEaW5t?=
 =?utf-8?B?dDNkeUNxWnZaSVA0ejZzZWtkY0N4K0hKMW5qYTZ2N084Q21HNUtGYU93cDN6?=
 =?utf-8?B?UkwySlN2RjFqTHNhNTlyZDhuTmRiZTVFeVEvTG5qa3pmNThTaFk2N0ZaaVJm?=
 =?utf-8?B?c2JlaVExVGhCR25JaURvem5vMGJWejlFaks4eUFkUGQydlRpOTV4VXJsWEdu?=
 =?utf-8?B?UXZsdlNabm9EUU5iY2hPZVFWeXpxd3c4dVp2MG5GVzJaSDBsZjJJbXp6Mll3?=
 =?utf-8?B?R2dka0tXekdRQTQyV3VqRE92Nm9TVWV4RGRIS3ZzaldXVG5mR3NxVE9KVTNp?=
 =?utf-8?B?SkR4bE1ZRUUvbnpqM040MERXeEwvOWpIVTlEa1I2NnVwd29FTGNmMnZ1ZlVx?=
 =?utf-8?B?Y3FyWUNXN3hyY3ZnNnJhR3NtR2pwQkJ0UXBTcWR1M2RvQXpma1RmTnpnQWNx?=
 =?utf-8?B?K1N0Z0R3Tmg5MHNaekVCOTVzSDM2OXgyM3NuYVFFR3lEOEt6U2tqM0hwK2xu?=
 =?utf-8?B?anlaTkV5cmM2UHA2VTM1a0RGQTJ2RGdnelFtemtpL1A3V3J5cTlWSHF3T3Ft?=
 =?utf-8?B?Z0E4RCt6TThnUjJmWmR6bG1zTVpzdHlvbjRhMXNtSEorNXFYNzAzYWd1VGFR?=
 =?utf-8?B?NW5VY2R6aUNmdnNaR1Vja3NTN1NXUTFoaldOVnNIVzlpdFdIemFSSVZGc21t?=
 =?utf-8?B?SmZjOHJJcWdCOHN0MStreVdRUzYxaHExZ3d4eTk2QTBHVFJnaEJYSnJSYXZ2?=
 =?utf-8?B?VnVuVm5hR0QwY3JRdHA2QjU5WCtGalRycFpZVjYzSy8ralVGb2Zic2xUOWJn?=
 =?utf-8?B?d3R0Wkg5d0FicTZMbXdraU1lYzUrbURtanBOS0NHZkF0N0h2OW5lOUVYN1ZT?=
 =?utf-8?B?ZXZUd2t5SCt2aWpKYXVWWkd1eWtxYWhWSm0vekk3QW04L3Q3Z3M4aHNQaGxo?=
 =?utf-8?B?UEVkWGM0TXpOdXBLQjRTT2dWNENnUTVZc3RXL2doSzk0V1I4YWNDWTBQTkR1?=
 =?utf-8?B?T0pxcURKNkFjV3dReVlGeG41Zk82OU1PS3hsRkw1ZE45ZldMNW5SS0ZlcG0v?=
 =?utf-8?B?dzBxMC81MDJnSnVrWXdLMGRHMGZXaUo1VmluczJrYTZ4N1NSbHczV0ZpbzEw?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0788.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38285557-4d0b-4452-a294-08daf0117c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 18:11:51.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrLWiEZZwhbtg2cvHKIGFOuP+IHjLWGsmrM5ar3LkRMAUVmqk1/FcPAvh0PddFGDJaOQTJGpQwwJpsYvmls5Y7fXai3XBqMaWnhgY4gSQQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KWy4uLl0NCj4gPj4gK0Fsc28gbm90ZSB0aGF0IHRoZSBk
aXZpc2lvbiBhbmQgbW9kdWxvIG9wZXJhdGlvbnMgYXJlIHVuc2lnbmVkLA0KPiA+PiArd2hlcmUg
J2ltbScgaXMgZmlyc3Qgc2lnbiBleHRlbmRlZCB0byA2NCBiaXRzIGFuZCB0aGVuIGNvbnZlcnRl
ZCB0bw0KPiA+PiArYW4gdW5zaWduZWQgNjQtYml0IHZhbHVlLsKgIFRoZXJlIGFyZSBubyBpbnN0
cnVjdGlvbnMgZm9yIHNpZ25lZA0KPiA+PiArZGl2aXNpb24gb3IgbW9kdWxvLg0KPiA+DQo+ID4g
TGVzcyBzdXJlIGFib3V0IHRoaXMgcGFydCwgYnV0IGl0IGxvb2tzIHRvIGJlIHRydWUgYXQgbGVh
c3QgYnkgbG9va2luZw0KPiA+IGF0IHRoZSBpbnRlcnByZXRlciB3aGljaCBkb2VzOg0KPiA+DQo+
ID4gRFNUID0gRFNUIC8gSU1NDQo+ID4NCj4gPiB3aGVyZToNCj4gPg0KPiA+IERTVCA9PT0gKHU2
NCkgcmVnc1tpbnNuLT5kc3RfcmVnXQ0KPiA+IElNTSA9PT0gKHMzMikgaW5zbi0+aW1tDQo+ID4N
Cj4gPiAoYW5kIHMzMiBpcyBzaWduLWV4cGFuZGVkIHRvIHU2NCBhY2NvcmRpbmcgdG8gQyBydWxl
cykNCj4gDQo+IFllYXAsIHRoZSBhY3R1YWwgb3BlcmF0aW9uIGlzIGluIHRoZSB0YXJnZXQgd2lk
dGgsIHNvIGZvciAzMiBiaXQgaXQncyBjYXN0ZWQgdG8NCj4gdTMyLCBlLmcuIGZvciBtb2R1bG8g
KG5vdGUgdGhhdCB0aGUgdmVyaWZpZXIgcmV3cml0ZXMgaXQgaW50byBgKHNyYyAhPSAwKSA/DQo+
IChkc3QgJSBzcmMpIDogZHN0YCBmb3JtLCBzbyBoZXJlIGlzIGp1c3QgdGhlIGV4dHJhY3Qgb2Yg
dGhlIHBsYWluIG1vZCBpbnNuIGFuZCBpdCdzDQo+IHNpbWlsYXIgZm9yIGRpdik6DQo+IA0KPiAg
ICAgICAgICBBTFU2NF9NT0RfWDoNCj4gICAgICAgICAgICAgICAgICBkaXY2NF91NjRfcmVtKERT
VCwgU1JDLCAmQVgpOw0KPiAgICAgICAgICAgICAgICAgIERTVCA9IEFYOw0KPiAgICAgICAgICAg
ICAgICAgIENPTlQ7DQo+ICAgICAgICAgIEFMVV9NT0RfWDoNCj4gICAgICAgICAgICAgICAgICBB
WCA9ICh1MzIpIERTVDsNCj4gICAgICAgICAgICAgICAgICBEU1QgPSBkb19kaXYoQVgsICh1MzIp
IFNSQyk7DQo+ICAgICAgICAgICAgICAgICAgQ09OVDsNCj4gICAgICAgICAgQUxVNjRfTU9EX0s6
DQo+ICAgICAgICAgICAgICAgICAgZGl2NjRfdTY0X3JlbShEU1QsIElNTSwgJkFYKTsNCj4gICAg
ICAgICAgICAgICAgICBEU1QgPSBBWDsNCj4gICAgICAgICAgICAgICAgICBDT05UOw0KPiAgICAg
ICAgICBBTFVfTU9EX0s6DQo+ICAgICAgICAgICAgICAgICAgQVggPSAodTMyKSBEU1Q7DQo+ICAg
ICAgICAgICAgICAgICAgRFNUID0gZG9fZGl2KEFYLCAodTMyKSBJTU0pOw0KPiAgICAgICAgICAg
ICAgICAgIENPTlQ7DQo+IA0KPiBTbyBpbiBhYm92ZSBwaHJhc2luZyB0aGUgbWlkZGxlIHBhcnQg
bmVlZHMgdG8gYmUgYWRhcHRlZCBvciBqdXN0IHJlbW92ZWQuDQoNClRoZSBwaHJhc2luZyB3YXMg
YmFzZWQgb24gdGhlIGVhcmxpZXIgZGlzY3Vzc2lvbiBvbiB0aGlzIGxpc3QgKHNlZQ0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYnBmL0NBQURuVlFKMzg3dFdkN1dneHFmb0I0NHhNZTE3YlkwUlJw
X1NuZzN4TW5Lc3l3RnB4Z0BtYWlsLmdtYWlsLmNvbS8pIHdoZXJlDQpBbGV4ZWkgd3JvdGUgImlt
bTMyIGlzIF9zaWduXyBleHRlbmRlZCBldmVyeXdoZXJlIiwNCmFuZCBJIGNpdGVkIHRoZSBkaXZf
ayB0ZXN0cyBpbiBsaWIvdGVzdF9icGYuYyB0aGF0IGFzc3VtZSBzaWduIGV4dGVuc2lvbg0Kbm90
IHplcm8gZXh0ZW5zaW9uLg0KDQpTbyBJIGRvbid0IGtub3cgaG93IHRvIHJlY29uY2lsZSB5b3Vy
IGNvbW1lbnRzIHdpdGggdGhhdCB0aHJlYWQuDQpJZiB5b3UgZG8sIHBsZWFzZSBlZHVjYXRlIG1l
IDopDQoNCkRhdmUNCg==
