Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB474D6AFC
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiCKX3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 18:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCKX33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 18:29:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E11AC2A9
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:28:24 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BIGVIW029742
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:28:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OdRO4asO1bQ/h/XpkWsMhLJSxiOXqxp8DvXuH+ZELOI=;
 b=ki9JlOHQ+ptCtOsnQ/ONuDZaCFNKkqm6lBDRsIuyrjHwSlPv9AlQOSXO8ZfZGQfvrFqb
 5PPSBk0WpZ7EpaMdDrXjFjRoW4FrGpWnnP4eDoVWtpPWNng9EuNydR1SJSaA5RErA9Cf
 Ml61E2hEQ+oeZ66+uGrAfcBPaEMcf9pE4fc= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqee3nj7a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 15:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxAxpfws9jBVZG4ULlCVattK61LqrxTd+fYOD4YgvbeDT+CUD6L2aT1+Bfk/acKcDrYNCgWmpEQCQPkBu8aDfW1x1ftGMRuOOInwbSuHQqZIEKNUL5hRjeEGCO+Cx2VQbj3OtiNFSgoYj/YBfi1vAw/+WSzJSpCEsvXuGK37vBueV4sCoTzMR53u8p1GCxkori7E4cpW1aNbMpeEWvB4emgoAGNpsBuNjObxMg94XO+qd1h7d6xUIGf0Z6D4r1E7xfiUAUde2SEgNOdWcJv8NDX+DU9yzPoMQFt0LWw6QM7VO5/K8pviT87/lMKjJldQOWSkPBbi3rzzMmpqBxFL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdRO4asO1bQ/h/XpkWsMhLJSxiOXqxp8DvXuH+ZELOI=;
 b=Y/OpV/ZWYCMDjGY9mLS4QOUQ7aOsf1IA8/+A7HSVDtTIywhxnkaPPBuIsiflRi3fmmpclH2VBm+Rbq9sES7ONZjjXjVAhplpdGN26q6WsDZpbefSuAoc/K1kNGfMfhqZOeIQsFmcIM/bV7MdpXcujKGicdgzRaaoYyZ7xP+qM4Zvt9iMVO9zhGAYYafjG5bMYbFqdfs6JMkEhsORZ79L8iIcBsgVVIH9QZzGyvKRk7br/vtVxWL0+ujmD6x3KZYG0vTe/f+XCN9mZ4ebJl58SBo4WcRRvPV956BivjJFWMH4xEIMEaMpz+ujdHNSTMrrja6JZ8tzfR+lfEdhXO/vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1389.namprd15.prod.outlook.com (2603:10b6:300:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 23:28:22 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 23:28:22 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next v2 3/5] libbpf: add subskeleton scaffolding
Thread-Index: AQHYNNycoj+LecNs+EGppE3eKBevu6y6y6CAgAAEmwCAAAQKgA==
Date:   Fri, 11 Mar 2022 23:28:22 +0000
Message-ID: <97cd91b96584c7e0d37637b8d4a0ecf04322c964.camel@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
         <b7ab6736af3976a8739f0ed75feb4ca58f5e926f.1646957399.git.delyank@fb.com>
         <CAEf4BzYsTBZwwVrLHkEGJyBsNRKyGCBNJSk3xDAS2z8OT8FL6w@mail.gmail.com>
         <CAEf4BzYPRs6wyAsZqcE7ga15Y1jtbNcAV+a+89vXNbW3ZFyEjw@mail.gmail.com>
In-Reply-To: <CAEf4BzYPRs6wyAsZqcE7ga15Y1jtbNcAV+a+89vXNbW3ZFyEjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f2952e-d650-4e0b-aaf2-08da03b6d578
x-ms-traffictypediagnostic: MWHPR15MB1389:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1389A71BC0A0A87B57C3C939C10C9@MWHPR15MB1389.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQ7NNu1Z7FpumWAgMS3N3NpgImUcI6Bz85d3m/wKvDwRG87XfS7sFRP7ZMS05jOWV4s7LyJ98cu4A8Mdu+91/LZLayt6LAZndRwLvtr6WjKcwaEa1arfJHQnAi6aexRmvZNSzmziY2BcQH9zcBvy0WvQB9vQhWLG5GUq75pM/3rDEdhtJ8xmfz5xcLZlSZf5TufLbv9EjyNNlvj5zKgyDXfxXKFVSFx1IUYerfkOxXOILc2JI9CweCo0pp0eTtIqxYsEJLCbLW35oTu1CqvESXXVlg1UIAUW1PCMqiG7Hng9J4xfcB14CsR59hPE470uH9cg0vBxaeCT2V4cr80ck6+JZf/n98tABDUpcC8XHT/ukKRNlt9TuKiFdSri7LHYbWuwf0cKOWpBOGPJAe+IJPZSD604tHThORf4wBatNrnjB79nUf14qvrV1yxv9LMcL73QFsu0Of0BEFw1PAi6LjfYo+Bv+0XypZz/YBF2kSwNadWoFm8alCeVLFc1ERT/AnsFIdrnzjnLtM3AY/2EWD4EjXXm6MCISBBLmvKa5nn6hDf8GodQT3Pk1a2ERvMdBi6m6q7Vm4aPvD4zhAY1FhdMym3N01CWam2nYhfARo4XClHJpQ4wlxZWgHZf2FzXKjxQqnvid5fWP1z35tOHnis27fiI6AYl75cNwLFrVHROk+7hr39tMvctL/Kw1dwsKwmBJH4+fR1gdW8N2sO+2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(186003)(91956017)(66946007)(66556008)(66476007)(64756008)(4326008)(8676002)(76116006)(5660300002)(86362001)(6486002)(6512007)(508600001)(6506007)(53546011)(8936002)(2616005)(6916009)(38070700005)(54906003)(316002)(122000001)(71200400001)(83380400001)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDVZTlhCTDQ5dXFLZW1qb0FtWXA1SHdwenJWV1QrdUhBVzhKQ3I3LysyVU90?=
 =?utf-8?B?L1RJWmVaL2xxbVZPeERIVkJJN0pUcFh1dVgrSURidGY5VmxsR2FRS3J5VFMx?=
 =?utf-8?B?d3JyNTJiMWxBcXNKS3BPMkhmR0ExZHpUeTh5S0ZiWmRsbHlVVHVydUx4VTkv?=
 =?utf-8?B?b2dOWVh1SlV5NVQreWpUWDdlcU9oSnQzN3Awb21SSm9GUkZPZEdvaHErbkdu?=
 =?utf-8?B?cUZPMWt5YWIxU2M5K3RXbTVKZ2c3Y3YweXd1a2xVTGhhK2MycHRTZ0M5OUcv?=
 =?utf-8?B?UXlxc1czd2ovK1NMVEhtWFdxcWpYNExGSUhRV0ROU3dxYWg2b0RiUnJ1MExR?=
 =?utf-8?B?Vks4Vk05SlNVMFBaY3FLaTlnTkNHWGJDWVR4STFYWUNCR0pScEpHWmlENW5L?=
 =?utf-8?B?dTZheTRwdWVVdnBEVmkrWGFiS0doNDF6cit0YkY0MmYwWmdIRWJsNHRkV0di?=
 =?utf-8?B?bWMzYjRFbWNtUHViSGJvLzArNXB6ZHE4WVl1N0ZSTmtOTTlkbUhBek9OQnE2?=
 =?utf-8?B?U2JVTkE2Z0RMTW0yVG95MDV5WXdiOWhQNUsrV2kzTHZrbjlmellRa2VzQ1Nx?=
 =?utf-8?B?OFNlN0VTZkcwUGRzNWFtL3AzM3VEdDFEWmhNalcyT1JXbTVuZENkWGFjYXov?=
 =?utf-8?B?Sm1tMVNwdTk3ZnNBWEREbHVFSHZ1cVFKeS9LNzVuaWY1YS84UE5PY0ZxcWlQ?=
 =?utf-8?B?SG1KRXpyTUtUbFdCV29uKy90NXV3SDZGbWRtLzRoNWZCNDliclgvWEMrbXJJ?=
 =?utf-8?B?dW5GSlQzOG0wRW9UR0lKMVIxMVBEOGJtcDJJcEwyMTFoUERCdm5RS3FVa2ha?=
 =?utf-8?B?Znk2TklpemZITkIvMXdSK2QxTFM0Y1RyWDczKzllTzhVMk52WTQ3YUI4YXpW?=
 =?utf-8?B?cmVGRnR1NS9wMXN0OFBXcUg4aHk1dnhNU1lJSXJvQnQyTEM2R2pyTjhBQzF4?=
 =?utf-8?B?VG4xaDdIcGVrRjJFOUpuVE94RFAzNy91Q2gybTNMYnJLbXRhdnJFUkJITXVC?=
 =?utf-8?B?R1lyNE5QYUlhVGFMd1Z2Ujl1RHRaZzdGcVlrUUZLV1g4eWxIK0tBYUthMU1h?=
 =?utf-8?B?VFZ2Tm1CZHpReGFtVHI5Y0RWeEJGSmRGYU81alQ1cWE2R3BZNGZvcHM5Znkz?=
 =?utf-8?B?dzR2L0VmN3ozUUxzU21wZTJ6YndkMzVjWDFUU2RDMmFJWFl6TjFrMGdZNWNH?=
 =?utf-8?B?VzFncHJjSkV0WG5Zc0xZRTc4WThzbTU2N25OR1QyaFdEcitrVGhtQndFZ1Bl?=
 =?utf-8?B?ZEFvU0JmSmtSdjJKQW5EQ3g1bXBMMTljcUsyTUtPeXFFTmo3TGZ2bTBCb05F?=
 =?utf-8?B?cGNWU0VYV1JhekFaSityazJYVnFCVGxHMThZZ1hiVlBFWUZuc3FHUUd5cUlw?=
 =?utf-8?B?eksweFdiTmphTUlJWVdyNXRvOEh6eDFySHRvUGdoOSthbDEybHlXSXdqcTBm?=
 =?utf-8?B?Qmk1bHZCS2VPcG8yOVNVcFhGT1R2dTZMZlNOUGtyR0hMZHllZHJnMFkrOEd4?=
 =?utf-8?B?YmpZd3Q5c2R1bkUyNHRSemZwT25zSUtacUN2YWE4eDJ0Z2pERFByY245Sm5k?=
 =?utf-8?B?N2dyRk54TkJ6dmFrTXVHMklrbXBQS1VPRlBUUXoxQWVDZEtsS0ttQmVOWTU1?=
 =?utf-8?B?YkJGNUh2TE5pd3FMaWJkdmFJWmpGcTZZNGcxNkdteFFOaHV6eEVCVFFicVp6?=
 =?utf-8?B?YmIyNTZVRThTcENIdTQzQzJJeUxCUVRZZG1BYWxZVXJMdGR3bzIxYkZidy9D?=
 =?utf-8?B?MlhTMkdUdlNZUE9IM0hhN1UvbC9QMzRJMUpVV1FoaW5rWjFLWEJodUVqVWlv?=
 =?utf-8?B?aE5KNFVqSytOakFxV2I2aHNwTWRQSWFQcDdHMFYreUdGM2c4VXRFL0t3aVBK?=
 =?utf-8?B?QjliWUNNQ2JXZ3IxNkZweDdlNHZDVDZvcFFkNjR6dUROcFN1aHZZZjVUSUFo?=
 =?utf-8?B?SlRMdGR2OWsvcXlpbEFZQWd2OUNSNlJqek1la0lSSmQ5alRSODBZUDFWcXl1?=
 =?utf-8?Q?2uMYiw2itmuJHRnYBbLb5fSgzHZ4+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C391EB305BAC50489A19DC8EC5C86D34@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f2952e-d650-4e0b-aaf2-08da03b6d578
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 23:28:22.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r23cKJTH1SID3VZMNJ1n1whR2TaFq5RIQH8URIQcyT9RGI8He7zGN3RtSDbav8Mg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1389
X-Proofpoint-GUID: sIlExw1tkENc0teqwA6yI2Lv1oZDC9J4
X-Proofpoint-ORIG-GUID: sIlExw1tkENc0teqwA6yI2Lv1oZDC9J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_10,2022-03-11_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIEFuZHJpaSENCg0KT24gRnJpLCAyMDIyLTAzLTExIGF0IDE1OjA4IC0wODAwLCBBbmRy
aWkgTmFrcnlpa28gd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDExLCAyMDIyIGF0IDI6NTIgUE0gQW5k
cmlpIE5ha3J5aWtvDQo+IDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
ID4gDQoNClsuLi5dDQoNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgZXJyID0gcG9wdWxhdGVfc2tl
bGV0b25fbWFwcyhzLT5vYmosIHMtPm1hcHMsIHMtPm1hcF9jbnQpOw0KPiA+ID4gKyAgICAgICBp
ZiAoZXJyKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgcHJfd2FybigiZmFpbGVkIHRvIHBvcHVs
YXRlIHN1YnNrZWxldG9uIG1hcHM6ICVkXG4iLCBlcnIpOw0KPiA+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiBsaWJicGZfZXJyKGVycik7DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+IA0KPiA+ID4g
LSAgICAgICBmb3IgKGkgPSAwOyBpIDwgcy0+cHJvZ19jbnQ7IGkrKykgew0KPiA+ID4gLSAgICAg
ICAgICAgICAgIHN0cnVjdCBicGZfcHJvZ3JhbSAqKnByb2cgPSBzLT5wcm9nc1tpXS5wcm9nOw0K
PiA+ID4gLSAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUgPSBzLT5wcm9nc1tpXS5uYW1l
Ow0KPiA+ID4gKyAgICAgICBlcnIgPSBwb3B1bGF0ZV9za2VsZXRvbl9wcm9ncyhzLT5vYmosIHMt
PnByb2dzLCBzLT5wcm9nX2NudCk7DQo+ID4gPiArICAgICAgIGlmIChlcnIpIHsNCj4gPiA+ICsg
ICAgICAgICAgICAgICBwcl93YXJuKCJmYWlsZWQgdG8gcG9wdWxhdGUgc3Vic2tlbGV0b24gbWFw
czogJWRcbiIsIGVycik7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGxpYmJwZl9lcnIo
ZXJyKTsNCj4gPiA+ICsgICAgICAgfQ0KPiA+ID4gDQo+ID4gPiAtICAgICAgICAgICAgICAgKnBy
b2cgPSBicGZfb2JqZWN0X19maW5kX3Byb2dyYW1fYnlfbmFtZShvYmosIG5hbWUpOw0KPiA+ID4g
LSAgICAgICAgICAgICAgIGlmICghKnByb2cpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHByX3dhcm4oImZhaWxlZCB0byBmaW5kIHNrZWxldG9uIHByb2dyYW0gJyVzJ1xuIiwgbmFt
ZSk7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbGliYnBmX2VycigtRVNS
Q0gpOw0KPiA+ID4gKyAgICAgICBmb3IgKHZhcl9pZHggPSAwOyB2YXJfaWR4IDwgcy0+dmFyX2Nu
dDsgdmFyX2lkeCsrKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgdmFyX3NrZWwgPSAmcy0+dmFy
c1t2YXJfaWR4XTsNCj4gPiA+ICsgICAgICAgICAgICAgICBtYXAgPSAqdmFyX3NrZWwtPm1hcDsN
Cj4gPiA+ICsgICAgICAgICAgICAgICBtYXBfdHlwZV9pZCA9IGJwZl9tYXBfX2J0Zl92YWx1ZV90
eXBlX2lkKG1hcCk7DQo+ID4gPiArICAgICAgICAgICAgICAgbWFwX3R5cGUgPSBidGZfX3R5cGVf
YnlfaWQoYnRmLCBtYXBfdHlwZV9pZCk7DQo+ID4gPiArDQo+ID4gDQo+ID4gc2hvdWxkIHdlIGRv
dWJsZS1jaGVjayB0aGF0IG1hcF90eXBlIGlzIERBVEFTRUM/DQoNClN1cmUsIGNhbiBkby4NCg0K
PiA+IA0KPiA+ID4gKyAgICAgICAgICAgICAgIGxlbiA9IGJ0Zl92bGVuKG1hcF90eXBlKTsNCj4g
PiA+ICsgICAgICAgICAgICAgICB2YXIgPSBidGZfdmFyX3NlY2luZm9zKG1hcF90eXBlKTsNCj4g
PiA+ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyssIHZhcisrKSB7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB2YXJfdHlwZSA9IGJ0Zl9fdHlwZV9ieV9pZChi
dGYsIHZhci0+dHlwZSk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXZhcl90
eXBlKSB7DQo+ID4gDQo+ID4gdW5sZXNzIEJURiBpdHNlbGYgaXMgY29ycnVwdGVkLCB0aGlzIHNo
b3VsZG4ndCBldmVyIGhhcHBlbi4gU28NCj4gPiBjaGVja2luZyBmb3IgREFUQVNFQyBzaG91bGQg
YmUgZW5vdWdoIGFuZCB0aGlzIGlmICghdmFyX3R5cGUpIGlzDQo+ID4gcmVkdW5kYW50DQo+ID4g
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIkNvdWxkIG5v
dCBmaW5kIHZhciB0eXBlIGZvciBpdGVtICUxJGQgaW4gc2VjdGlvbiAlMiRzIiwNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpLCBicGZfbWFwX19uYW1lKG1h
cCkpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gbGliYnBm
X2VycigtRUlOVkFMKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHZhcl9uYW1lID0gYnRmX19uYW1lX2J5X29mZnNldChidGYs
IHZhcl90eXBlLT5uYW1lX29mZik7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
c3RyY21wKHZhcl9uYW1lLCB2YXJfc2tlbC0+bmFtZSkgPT0gMCkgew0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqdmFyX3NrZWwtPmFkZHIgPSAoY2hhciAqKSBtYXAtPm1t
YXBlZCArIHZhci0+b2Zmc2V0Ow0KPiA+IA0KPiA+IGlzIChjaGFyICopIGNhc3QgbmVjZXNzYXJ5
PyBDIGFsbG93cyBwb2ludGVyIGFkanVzdG1lbnQgb24gdm9pZCAqLCBzbw0KPiA+IHNob3VsZG4n
dCBiZQ0KPiANCj4gb2gsIHdhaXQsIGl0J3Mgc28gdGhhdCBDKysgY29tcGlsZXIgZG9lc24ndCBj
b21wbGFpbiwgbmV2ZXIgbWluZA0KDQpUaGlzIGlzIGxpYmJwZiBjb2RlLCBub3Qgc3Vic2tlbCBj
b2RlLCBzbyBpdCBzaG91bGRuJ3QgZ2V0IGNvbXBpbGVkIGFzIEMrKy4gSXQncw0KcmVhbGx5IGJl
Y2F1c2Ugb2YgLVdwb2ludGVyLWFyaXRoIGFuZCAtV2Vycm9yLg0KDQo+IA0KPiA+IA0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiAgICAgICAgIH0N
Cj4gPiA+IC0NCj4gPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4gDQo+ID4g
DQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+ICBzdHJ1Y3QgZ2VuX2xvYWRlcl9vcHRzIHsNCj4gPiA+
ICAgICAgICAgc2l6ZV90IHN6OyAvKiBzaXplIG9mIHRoaXMgc3RydWN0LCBmb3IgZm9yd2FyZC9i
YWNrd2FyZCBjb21wYXRpYmxpdHkgKi8NCj4gPiA+ICAgICAgICAgY29uc3QgY2hhciAqZGF0YTsN
Cj4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5tYXAgYi90b29scy9saWIv
YnBmL2xpYmJwZi5tYXANCj4gPiA+IGluZGV4IGRmMWI5NDc3OTJjOC4uZDc0NGZiYjg2MTJlIDEw
MDY0NA0KPiA+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYubWFwDQo+ID4gPiArKysgYi90
b29scy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiA+IEBAIC00NDIsNiArNDQyLDggQEAgTElCQlBG
XzAuNy4wIHsNCj4gPiA+IA0KPiA+ID4gIExJQkJQRl8wLjguMCB7DQo+ID4gPiAgICAgICAgIGds
b2JhbDoNCj4gPiA+ICsgICAgICAgICAgICAgICBicGZfb2JqZWN0X19vcGVuX3N1YnNrZWxldG9u
Ow0KPiA+ID4gKyAgICAgICAgICAgICAgIGJwZl9vYmplY3RfX2Rlc3Ryb3lfc3Vic2tlbGV0b247
DQo+ID4gDQo+ID4gbml0OiBzaG91bGQgYmUgaW4gYWxwaGFiZXRpYyBvcmRlcg0KPiA+IA0KPiA+
ID4gICAgICAgICAgICAgICAgIGxpYmJwZl9yZWdpc3Rlcl9wcm9nX2hhbmRsZXI7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgbGliYnBmX3VucmVnaXN0ZXJfcHJvZ19oYW5kbGVyOw0KPiA+ID4gIH0g
TElCQlBGXzAuNy4wOw0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KDQo=
