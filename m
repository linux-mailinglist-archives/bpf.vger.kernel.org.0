Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226C4D90A0
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbiCNXwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 19:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNXwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 19:52:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FB1D321
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:50:55 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22EMaUKo000950
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0CDxMtYZjJdQVoVp9qvoAi2xN9YZnCPM5O5FKjiOitU=;
 b=qe9U6Yv0k39CvgZpMVxBhYz41qzoxqJbrXbtRilgD100HUx4kQgw2DsCCmduJMA45WPo
 4QwwDSGujca2/AR2cggmnHC6Ca6VkCyER4GRPCdhdOob3PDqEeALAdr8phy20H7/Bai+
 YbMxJED+h+/BeJ4zc2zHIdrLUEac449O434= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3et8k03v38-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWxGvG1vGoPyrT5QbreO0wB4IeKyrIeEJUefjXauMSje5m5ZpxVd0g4sG0SSapsoDdGMGAYff50pNm8rZi97DhGwxbCNe5hGUwBgZt+yLdH0TP1Uf0pycFin9dzwl2IRNgxvIEuiBq7wwWzOVZC+KFOghRBZKCyuZQFGfSvKGLsp8h7m8LonIVtIRUu32s94UTRaS6fR5VATFexqkFtQgciadS9Uvg7xQTk4C3BW6UzpBhg5xQMPs9XC4ilWTMR7sdChZLxxG13c44nz1NtR5Q472ALXrOmEsHoUsgJQ8I+Qks7VWnE21P740BChY0mRRPRFzXPBvuuEG1IOmXbKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CDxMtYZjJdQVoVp9qvoAi2xN9YZnCPM5O5FKjiOitU=;
 b=egpsoCJbTyh2JW29uoNjT2GSzUFsYu7Tj7JekHMX1m6nITo9L1SQUlDa7QRAimw3U4zwgFp0ScRxAaZ4m5Q9ArsioBLmdOj2h3CJk7U43BtJ/03C5X+CoYNWvs9mF/uBCPp7W/e+DFSjv4T7Es1BKXNgu7xAzszkIBK1dcb4K0fb5e/HieKw+qpBQfAiWyKonbz0NQe9ELyDhRZvXYF64gsK1YFlZj85uBC+U3WP5W5726OiAGEw1I01aXK9GtRxwvPRRPqcRT6LSuR0PcJVYCVxQaKeh5mKU0bj3V8bWPLvbK2oMZk1giVyukOE84D5JRntl9yjCnwPZDniI4YTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB3376.namprd15.prod.outlook.com (2603:10b6:208:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 14 Mar
 2022 23:50:51 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:50:51 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton
 functionality
Thread-Topic: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYNNynSUaoaODNZUS3ATdQuBmOqay62PMAgAS4l4A=
Date:   Mon, 14 Mar 2022 23:50:51 +0000
Message-ID: <2636cbb9d5207841340d7b17d893227c1576c982.camel@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
         <f262f63b36d00d4a77d1166bcaffe7684b6ebbee.1646957399.git.delyank@fb.com>
         <CAEf4BzaVt=+g2gKpMqsNH5JGSvEJnjnDHW7ueFFgcUtBv1z01Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaVt=+g2gKpMqsNH5JGSvEJnjnDHW7ueFFgcUtBv1z01Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c9ab465-aedf-4eea-612f-08da061578ad
x-ms-traffictypediagnostic: MN2PR15MB3376:EE_
x-microsoft-antispam-prvs: <MN2PR15MB3376A7E176FCD429497ACEF4C10F9@MN2PR15MB3376.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYaeat6SF4Idzj9QXpF9cJv0Tg5bDZYtoodmFueVhB+3Tux9GzNr4o1qXQM+PAPVKNOPZyo6R3XrHVWNquGzxvMgGAHCh+1ptJtxrqqT8x4lE+6CNeuHUtY48zALwkyFO9bccnNT6XyeUATa0CJgUGX+JhA8zKF3jKCw7LmaFQxdgPd6N1MzRlO30GkpYzavuKrw8ZChUKgr0lhbEjN5fNFeeTB2PPInupz+a0hUjKcOEN3UE52V5rQV4qQd09O9gxDdhRxTdz6iuVgMFgpAORwCZDakSCOLduAkAe7JmtvMEULoDPEon9KZNO433D2t7HbNhJJX6fq7kYvyypPScGeI87lo84zcknLWILpjKD6OpKK3Wz8GT9cHzCNGR1qzWtOy5UK5eiFFTaJKwdBGa2UAHE/WQQc8NrfvhIKLWTMiwdxI4041rlJ7INDIL7pA8zO1C6rGGREFZ2l+YVo0qYt1u+B1j+swd2GWlt4pj7PuUibiSahnL3IQ27joujCCQWfWc+6is74Qqa/F0+Eo4OGRfPheiPqvjPjj7lmNZlMZ2liFNr9nXNLkPmyVzQBkwnaqIBTybCGGDqL7bEOO4xWEovN++F7IBRMZu64GUECftWkBKxLuk2j1Nmx9/dqgyO4Ka9p6OFxgvsSYaBVsCizHQpQonnNPvfevm6fTtZ9r5SNJnmkvOZYBzogOyuv8QHVbKydJvtqR4NgM3DMjDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(122000001)(91956017)(36756003)(6916009)(316002)(8936002)(66946007)(54906003)(76116006)(66556008)(64756008)(66446008)(2906002)(66476007)(5660300002)(71200400001)(6486002)(2616005)(86362001)(186003)(8676002)(4326008)(6506007)(6512007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWVTQVdyRGIwUW5zbi95RmJRZ1Z3c1piT0s5TjNURGl5ZGhVWFk1dElETXRw?=
 =?utf-8?B?ZGdzZkE3cEQvSUo3UmIrZk5wSnVVT3pMSmJBVVE4b3dvTWFTS0ZvZzJPQmth?=
 =?utf-8?B?RVBQUlRYUlUrNGFtN3hhKzkwTEVQQWZBMmRra3NMQmU5aitWK3Fobll3eEIw?=
 =?utf-8?B?QVJPOVJtdnJzcEpYeWdrMW1nMEdwN05Ub2Vrd1I4dDQ1ckxSZ093MDV0Snl5?=
 =?utf-8?B?aFhvemlpWDF6R0xvS0xoNXVUeXBqdmlLOFY5WWMxQjVkV0UwdXcweFp6UExt?=
 =?utf-8?B?NC8wRHV4M0NsTGRyS1dRTysrcUlORXJwbzcyOS9CZFl6dVFnN3ZBRmQyeDZu?=
 =?utf-8?B?ampudDNoeGZHckVqVWs1Q1FBK0d6M0JPMzdsRk1KM3F5WkFMaEQ3eVlLQmlB?=
 =?utf-8?B?QVRwYzJRSldma1pscUVIRGdYbWpTRnJyS3EyZStFYnpkWStXc1A3QmtRTzBa?=
 =?utf-8?B?R200T0h4N2pab3Q1R0RveU92TkE2NkNNdE1BQWJRZWVHaE1oQkxRMmVWNGpL?=
 =?utf-8?B?a253aHZmd0dYdlNFa1lmODlWeVc0dEsrUkJrUEdzZlpKREdLWUZ3dXNqb3RI?=
 =?utf-8?B?VzFSMlpXZ1Rac01HZytWU0JYK2dyYWY4VTVwYWNpUUhxTWt0b2FIdnBxaGpo?=
 =?utf-8?B?aGlRblg3NXNSdFlwRTZ6UjhOQlA1WDdyZ0tZUWlneHJZQm9HRDRadzNNRnlN?=
 =?utf-8?B?VE53djFWL05UUnMvSkhQQjFCZ204RFkyeDJlejd4U3pFRUY1WnlTWElTZmVF?=
 =?utf-8?B?RG15bHkxMTJSWWNJSFpNM1lpeURYd2JMUXVGVW5OMmZlRUJFWWF2ZFBjbzdN?=
 =?utf-8?B?LzdMY1ZjcG10ZTkySDJzUy9zWE9VdVAxdEZCZ1BOMXg4dUtCUW4rT043KzI2?=
 =?utf-8?B?OW9wSUV0bVo2V0pPcXFSaWZWT1Bvay9JZElwcmcrazRoVVdqc1JMeDI3am8w?=
 =?utf-8?B?RVVOalpQbVp1b3puUzJJQjFpbGt5RFJiQkZQbWFIekVQVmVLazRJYVlRM0NT?=
 =?utf-8?B?Y2ViMkVCM0l5V2ZmNDd1dmN0eTc3OXFSMkZVWEplS2ExTHl3dXZLcldQZjNk?=
 =?utf-8?B?RmQ2T0dBMHBCMVVCVnYwOHh4OVpwYjVybGJUbFI4UHBTVHdtTzRKcDMrWFZB?=
 =?utf-8?B?dnZqc0ZyOTVtYWxRN3NUY0Z6K2l6eXdCVitCK0FHUDJPcmNVd3IzbmVEZzlN?=
 =?utf-8?B?L3VKMmpjVGJEZ05SNGVlNENpYU1qTDZNSFhzK3N4cisrQzN4RHhXeU5zcDVu?=
 =?utf-8?B?dkxNS0dKY0RpcWVjU3RFQmNmYTZ1MzBGMkl3dEdSV2dCUTZUaVFkTG4wbnV2?=
 =?utf-8?B?YUQxcUUzNmtMQVoxNWdoTmpjWXFlWWpOYThZa2JscDhrdzRLNU0wem5CckVS?=
 =?utf-8?B?M0poaTFYbk8vSmxrRExWbWxmQzlSZDB0SE1DYVhNWi84S0haMlhyUm83ZDRU?=
 =?utf-8?B?eTRpWVVnMU92UTBJUW40RTV3SUhNR0V6QmJnNWppeGI2VDM4T3N3a0FFbjdI?=
 =?utf-8?B?S09xTEFUbldLYkR4T2ZmSnE2TmYrbkhKNUZoZHBjMFozYmhCbzJBL0tWUUlh?=
 =?utf-8?B?cXhHanMzSnRNa2tJeEhBcFpSVUNsRlZpNGVzbVVCZHVaV3VIMzhoa09mSTNR?=
 =?utf-8?B?TTIxZnc5L3d2Q21YNWorTlcxVFJYSGxVSW83d3NDTnJmM0tNSVRwT0sxNHQy?=
 =?utf-8?B?NFJGUHJVbm5vdXpUbC9FTThJSmJxZFphSkNQNHZaUGYzdlFhTXA2QzIrN2tS?=
 =?utf-8?B?VUVKQ1hEc2ozWUVrYmhnRVczNzlVay8zQml2dHlpMGFiRVZHRm9La0NpcDNo?=
 =?utf-8?B?K0dtOTdXeUZpY0x3bHluZlFBWFdjKzNnRXhzM1BoNE9pUGFGb21JNTNPWDhp?=
 =?utf-8?B?SUJNenFxT1NCVkU1UmkxdnV3Q2k2MVBMOU14UEY2dEdxN2MzSXAwaHpDTHM4?=
 =?utf-8?B?MEFpUzZzTTl0bm9oclpYOFppZ1ViQXRleG9uaVJYallPODhVZkdVOXZnQ2RJ?=
 =?utf-8?B?REJZRFdjSlVVRE5lRWhYSGt3SXhHU1NSWDlLSzdUM1JxRWZyS1NYUy95MC9S?=
 =?utf-8?B?K2dtN2E5YUF1KzVQRzRZb1hPYzZOLzBNTGxKS2dvczN0WGY3MjJvT3dGeHVL?=
 =?utf-8?B?aGpZMHUxYldIV1NMVDZydDd2bTRIeHpZQzcvaEhNQ2pmenFjamYxdDJweEJx?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <205146A454FEF7418B7A682ECB8D7F92@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9ab465-aedf-4eea-612f-08da061578ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:50:51.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGH4agBBRMvu91xnHhiexywMazbk3bJtk1qcfhEpBTcPaSW8iy4COiMp7TLWne51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3376
X-Proofpoint-GUID: 7Lsa3fkO-t_TuIpNKoNWj9evncT3wePM
X-Proofpoint-ORIG-GUID: 7Lsa3fkO-t_TuIpNKoNWj9evncT3wePM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTExIGF0IDE1OjQwIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IA0KPiB3ZSBzaG91bGRuJ3QgbmVlZCBvciB1c2UgbmFtZSBmb3Igc3Vic2tlbGV0b24gKGlu
IHJlYWwgbGlmZSB5b3Ugd29uJ3QNCj4ga25vdyB0aGUgbmFtZSBvZiB0aGUgZmluYWwgYnBmX29i
amVjdCkNCg0KTGV0J3MgaGF2ZSB0aGlzIGRpc2N1c3Npb24gaW4gdGhlIGJwZnRvb2wgZW1haWwg
dGhyZWFkLiBIYXBweSB0byByZW1vdmUgdGhlIG5hbWUNCmluIHRoZSBNYWtlZmlsZSBhbmQgZmFs
bCBiYWNrIG9uIHRoZSBmaWxlbmFtZSB0aG91Z2guDQoNCj4gPiANCj4gPiAgJChUUlVOTkVSX0JQ
Rl9MU0tFTFMpOiAlLmxza2VsLmg6ICUubyAkKEJQRlRPT0wpIHwgJChUUlVOTkVSX09VVFBVVCkN
Cj4gPiAgICAgICAgICQkKGNhbGwgbXNnLEdFTi1TS0VMLCQoVFJVTk5FUl9CSU5BUlkpLCQkQCkN
Cj4gPiBAQCAtNDIxLDYgKzQyOCw3IEBAICQoVFJVTk5FUl9CUEZfU0tFTFNfTElOS0VEKTogJChU
UlVOTkVSX0JQRl9PQkpTKSAkKEJQRlRPT0wpIHwgJChUUlVOTkVSX09VVFBVVCkNCj4gPiAgICAg
ICAgICQoUSlkaWZmICQkKEA6LnNrZWwuaD0ubGlua2VkMi5vKSAkJChAOi5za2VsLmg9Lmxpbmtl
ZDMubykNCj4gPiAgICAgICAgICQkKGNhbGwgbXNnLEdFTi1TS0VMLCQoVFJVTk5FUl9CSU5BUlkp
LCQkQCkNCj4gPiAgICAgICAgICQoUSkkJChCUEZUT09MKSBnZW4gc2tlbGV0b24gJCQoQDouc2tl
bC5oPS5saW5rZWQzLm8pIG5hbWUgJCQobm90ZGlyICQkKEA6LnNrZWwuaD0pKSA+ICQkQA0KPiA+
ICsgICAgICAgJChRKSQkKEJQRlRPT0wpIGdlbiBzdWJza2VsZXRvbiAkJChAOi5za2VsLmg9Lmxp
bmtlZDMubykgbmFtZSAkJChub3RkaXIgJCQoQDouc2tlbC5oPSkpID4gJCQoQDouc2tlbC5oPS5z
dWJza2VsLmgpDQo+IA0KPiBwcm9iYWJseSBkb24ndCBuZWVkIHN1YnNrZWwgZm9yIExTS0VMUyAo
YW5kIGl0IGp1c3QgYWRkcyByYWNlIHdoZW4gd2UNCj4gZ2VuZXJhdGUgYm90aCBza2VsZXRvbiBh
bmQgbGlnaHQgc2tlbGV0b24gZm9yIHRoZSBzYW1lIG9iamVjdCBmaWxlKQ0KDQpXZSdyZSBub3Qg
Z2VuZXJhdGluZyBzdWJza2VscyBmb3IgTFNLRUxTLCB0aGF0J3MganVzdCBjb25mdXNpbmcgZGlm
ZiBvdXRwdXQuDQpUaGlzIGlzIHVuZGVyIHRoZSAkKFRSVU5ORVJfQlBGX1NLRUxTX0xJTktFRCkg
b3V0cHV0cy4NCg0KPiANCj4gY2FuIHlvdSBwbGVhc2UgYWRkIENPTkZJR19CUEZfU1lTQ0FMTCBo
ZXJlIGFzIHdlbGwsIHRvIGNoZWNrIHRoYXQNCj4gZXh0ZXJucyBhcmUgcHJvcGVybHkgIm1lcmdl
ZCIgYW5kIGZvdW5kLCBldmVuIGlmIHRoZXkgb3ZlcmxhcCBiZXR3ZWVuDQo+IGxpYnJhcnkgYW5k
IGFwcCBCUEYgY29kZQ0KDQpTdXJlLg0KDQo+IA0KPiBsaWJicGYgc3VwcG9ydHMgLmRhdGEubXlf
Y3VzdG9tX25hbWUgYW5kIC5yb2RhdGEubXlfY3VzdG9tX3doYXRldmVyLA0KPiBsZXQncyBoYXZl
IGEgdmFyaWFibGUgdG8gdGVzdCB0aGlzIGFsc28gd29ya3M/DQoNClN1cmUuDQoNCj4gDQo+IGxl
dCdzIG1vdmUgdGhpcyBpbnRvIHByb2dzL3Rlc3Rfc3Vic2tlbGV0b24uYyBpbnN0ZWFkLiBJdCB3
aWxsDQo+IHNpbXVsYXRlIGEgYml0IG1vcmUgY29tcGxpY2F0ZWQgc2NlbmFyaW8sIHdoZXJlIGxp
YnJhcnkgZXhwZWN0cw0KPiBhcHBsaWNhdGlvbiB0byBkZWZpbmUgYW5kIHByb3ZpZGUgYSBtYXAs
IGJ1dCB0aGUgbGlicmFyeSBpdHNlbGYNCj4gZG9lc24ndCBkZWZpbmUgaXQuIEl0IHNob3VsZCB3
b3JrIGp1c3QgZmluZSByaWdodCBub3cgKEkgdGhpbmspLCBidXQNCj4ganVzdCBpbiBjYXNlIGxl
dCdzIGRvdWJsZSBjaGVjayB0aGF0IGhhdmluZyBvbmx5ICJleHRlcm4gbWFwIiBpbiB0aGUNCj4g
bGlicmFyeSB3b3Jrcy4NCg0KVGhpcyBmYWlscyB0byBldmVuIG9wZW4gaW4gYnBmdG9vbDoNCg0K
bGliYnBmOiBtYXAgJ21hcDInOiB1bnN1cHBvcnRlZCBtYXAgbGlua2FnZSBleHRlcm4uDQpFcnJv
cjogZmFpbGVkIHRvIG9wZW4gQlBGIG9iamVjdCBmaWxlOiBPcGVyYXRpb24gbm90IHN1cHBvcnRl
ZA0KDQpJZiB3ZSB0aGluayB0aGlzIGlzIHZhbHVhYmxlIGVub3VnaCB0byBzdXBwb3J0LCBsZXQn
cyB0YWNrbGUgaXQgc2VwYXJhdGVseSBhZnRlcg0KdGhlIGJ1bGsgb2YgdGhpcyBmdW5jdGlvbmFs
aXR5IGlzIG1lcmdlZD8NCg0KDQotLSBEZWx5YW4NCg==
