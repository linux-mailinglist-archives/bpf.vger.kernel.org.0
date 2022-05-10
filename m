Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF85221B2
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbiEJQyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiEJQyN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:54:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452F293B5A
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:50:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLsKJ002037
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cVh/rhCH6RuG0OX1yoySEASPX3Za9rM0HjIQP4vViPY=;
 b=JV1GJoD4Actz7R/HcQGjMbofDNVK1asV5ctuS2UYwX1QwZWvW0htiNpu/75xYoC17oho
 JYWOjJnlE+EkhkCD1u8U6AxR3bL7RZzhJbmlAOiqhmOa7o5ioYB00DwyJDLx2DLbxSqS
 66Kd4V92Hth9d2fOlxMIgA+8LjHVG+Xx/Hs= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fygdk486f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 09:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8DrzBpLwI+bTugzj63jWyN2v5Dbga2aYnXVB3NbtMTPXb2hsgKS/Kvk40PfPefN0akYwxUtugr6leSuOl8VIFOVk+KRNGRMq3s2Vqd6GEyqawqUkJQyULxVYocyJ9LirPBmoA3oL8kmpyzjOUtRIDnKLNbgWsS7XKEjPqz5g7AdhE5xAyqepbBZvyw1DoqTPt0TAtBhea2tRwy433V552pWtEJe0zJU/Imp1VS8A5X0qct2O5fKx/9aVZwNjly06BRbRgc4HySFHUGhojQWQo0W1YpPPfflp3O1ddxicy1IP6eyiUZFo8QifzReJxDSn50dExB3TmDuM7h0U3yNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVh/rhCH6RuG0OX1yoySEASPX3Za9rM0HjIQP4vViPY=;
 b=j6ZJwffL7ClDQToLRmgDPsNAd5TRaOrcHoScAEw4MXN6Sj+oCYpEG8EWDALRecWBb3O+wWpi9AUKyTSlIIhgDQpd/ug7qPoA0kUJqm5nDPdwGX0I8ISGyLwLF1xm5kPX1uFYE5ahux75y2FY9nLfJDC2eWoFEiGwsgzLLZe43wV1Q3REzH3oXFK0ayagP3e7qNVkflsJN+JnKd/wwMPy3z0/wFO9zhaGZPN6pDZ/6IolD8dNu38SV4KNowlJkFvGRvNFc5TnAjyGSWgcl0Kp7A3IvDNPKHKEGuCdm+KLH2SJJgdlavf2eTfjh+Iycs5maEZFHMAaB9Wc/ZNF1e+4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MWHPR15MB1488.namprd15.prod.outlook.com (2603:10b6:300:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 16:50:12 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:50:12 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Thread-Topic: [PATCH bpf-next v7 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Thread-Index: AQHYYorC8KCGnXcvEE2P4o3lCtRESK0W5zsAgAFvtYA=
Date:   Tue, 10 May 2022 16:50:11 +0000
Message-ID: <1a148de6020659b44349c20b48033805e7973efd.camel@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
         <20220508032117.2783209-2-kuifeng@fb.com>
         <CAEf4BzYa5sUK5m8-tAS7DRwugaqVdp+1Wvu_DEkRU5TfQtjE+w@mail.gmail.com>
In-Reply-To: <CAEf4BzYa5sUK5m8-tAS7DRwugaqVdp+1Wvu_DEkRU5TfQtjE+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7031aa83-3418-4806-4171-08da32a52646
x-ms-traffictypediagnostic: MWHPR15MB1488:EE_
x-microsoft-antispam-prvs: <MWHPR15MB14882B02EAC0AC6597EEC818CCC99@MWHPR15MB1488.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lNlbdtRMqmBhjvl6QnUCSh2xAr/4al6oPUr13H0oGyWQDttX7+ewtoGv2KWXcfqF+dYJwp5OWI6IzdOzjP0NvCMGGUU/9usaAwNaQkF5VLWkW3V+x9B15O3w6RzBIAmJriPp6whhtb8pAy+CqNJzl98Y5JSFQYjGLTiD7HyLtalnF64XLLbghytzN2gHsVzbaFRxIF5M8dBz689ME+WSlNossqHxO6d7S59zWxpp8qFGHNlhf/PeF5fel+78jxoVducG1wm3bqPqk2WAAAppfghxU52DxqL6rjeddR07jx4BWsWrutzggRlDKELF9cvoiCOMwPlLQPx4F7pKOaKVjmyiasw6MAdZMj0heGPrXHk+3keTqnb2RDM+EmlLgt+tlAoitlE/g4OU2xGF7RpCoVuEGL1q1aOaF0xvbGsXWJeMNdBoBwD7tct6p2pgP6wmPP6ipOMNPKZfhO9pXR3VcF5n5CSXOrLpEKZO4MMLOZVXrZ0oNigXzm9SeSv5KnTjcrninoPwV9CfMQh0oJLiR7IgrvXUljauPoqjPzsGbCHu+zOlRrR/t+5vgyu5p2mK1Z+EinE5orAYBcbM6EoCOwRPe9UQLPEhj3QOy7HLz3biwt4JkcqmZyu6VWzYoPu7gSp4B3vveUI7kT05zLqvD2ADgF0QzAfC3NRUaXjPGZTwr5rE16tr3JDKIYth4ESDmmqaNm4kQWj4h9kwoULusw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6512007)(66946007)(76116006)(86362001)(66476007)(64756008)(66446008)(316002)(6486002)(508600001)(186003)(2906002)(4326008)(54906003)(8676002)(71200400001)(6916009)(38100700002)(122000001)(2616005)(38070700005)(6506007)(8936002)(83380400001)(36756003)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJGcVJLUm5hUmRSOW1GNDhZaEczZWczb0JjUzBpd3dSZG14RVZ4dEtrRE1u?=
 =?utf-8?B?bHdsc0hhSy82ZmlwTUJsT0pkNTJQenRkR1NKb2pBeVZNNFF4Y09MbXFNdXpP?=
 =?utf-8?B?elVEMGZHbFNkT3l0Umptdnl5d2dlYmpjZ2F0RlhoRUhmVWF0VU16RS9SMldU?=
 =?utf-8?B?QWJiaU9ZTlVWNWQwYWRySU16ZnhmU0doOHRaUDBSTU1YZUNacm5tSU9qUDZl?=
 =?utf-8?B?S0tNNGhQRG50S1laVTg2Mnp6QzhyaGRQZ1IydlUwTlRERGRUNExVTUZRcjFW?=
 =?utf-8?B?bURpYWNlZ1pDeC9qUE5CQkJTbDV5SUhtUXE0VEtyb1h6MmNubFRYUlkyZFJP?=
 =?utf-8?B?MDU5MmtJeGJDUHVvLzkxZlB0eEpoMTBxbklVL1B6SGFJYjFZU1FVc082MUw2?=
 =?utf-8?B?dTZaU2ZYSllFNm52Rk9zeEpmMDlEOVFFWThHMWhJSkJ6VURtNWM4V3NHZmFn?=
 =?utf-8?B?VG54REpRbURCZFk4MG9QU0QzWmY5TE1vRUJsd2xkMlVBQ2tuZzA3SFAzRGZS?=
 =?utf-8?B?Z21VYTZnSU1jcHpZNkNRQ2tDN0FkNHBKVElucFNNMFdBaFc1aytKMGN5Nm9Q?=
 =?utf-8?B?QUZGY2NQNHJ1OWpTRlVZWjNNN2p0SGhKMGM5QjNKNndaSVNTMDBwdk02MHZS?=
 =?utf-8?B?dC9CUHpuc0t5UTl4UUxHajBKZlhhcXRTc0NUbGt6WlJxaW90TUNHUVp2b2h5?=
 =?utf-8?B?NlRzWjUxRFVNcGptNlJSd3NnRVcxdm5UQkFBTk52aWFBT0lhdmJNZ3J0YmIx?=
 =?utf-8?B?RWd4MmhQekxNaUVCaTdlaitabWdPUStsdjVZOW5tVnNLUktBcGpVdW1sRkQx?=
 =?utf-8?B?TXVpS2NVa0hPZnQ4TE5KajcwQ2pZU0p3UUc4eG9CdHpaUFo3Tis4REY4RUhm?=
 =?utf-8?B?M1hYR3RDU0NZNk9WaUdXdllBODBKZko0OFY3czFtRnBXUWlzZEJ6b2tEbFV5?=
 =?utf-8?B?aENsZ3lHck1LTExCRUwzNHF3Q2R1M1J6ZHZ0WTQza0J0a1pRampMczRVYUxn?=
 =?utf-8?B?QStudld4QTlrQXkrQzJMNXZ6OHVzZjVMUlBYZEFuR0FmYzRpcTJ2NkhBQzJB?=
 =?utf-8?B?Qmg5QW13eWRndW04NnJMMU0wSEE1dmdlazRwN3NyZlFqYWExd3U3Z1ExY0Uv?=
 =?utf-8?B?RGsydkhHcjB3NnY0Y1BkNFFCM3dDaUs0WDJJWWRRQndDcytJZjJiMnlxTEtV?=
 =?utf-8?B?NFJaYUZzWnd3UEhKTkl5SHcvcElGSUdEc0Z1SmdnY1UzaWdaQWFSNEJnYXhi?=
 =?utf-8?B?ekp6VGpUT1I2NE1hTmc3QnZJU0ozcVgrakNpWEFyTmV1UnNZL2pZSC9hYk1y?=
 =?utf-8?B?R0xJOGp4ejBta25iZStXcnloQzRwZHpzcWVqT1dPcUlhTm9HK3BDT0VsbEZy?=
 =?utf-8?B?RXd1dWUrbi9neXJYUEJRQ0FWNEdDaWZDem95UGJHdHpYNGNDRi9KQXVqMC9H?=
 =?utf-8?B?UUZ1RlJYQnU0cTBJb0V0bTRKcm8yQmJxR2lFbldCZ2p5MTh2NkFuQjk0SENu?=
 =?utf-8?B?RVNTM0ZqV0JoUDZUWHFrSmgyTUVNK3IrZE96Vy80d0ZxaS9IMGpCcVBYTjJW?=
 =?utf-8?B?Snp2Szk2N3lsWHQrTXNlbGtRVXNTTk5nVEJoSzVCeFpIZW1FVk9VZDBYdEhH?=
 =?utf-8?B?VG1MRjlaSDJzMDV6VmFVaW95ODFYQ214NlFMTzNzdS96Q1BNWHNKNTlwaHZN?=
 =?utf-8?B?SC9iTlpHT0plV1RsWXE3Z2Y4dDB3VEZIZE5PNDUwbWFXN1lncnR4dWRIamJR?=
 =?utf-8?B?T3U1andBczVtdmpCQk8wRUxQeEVSdFVPdm51bFlGU3NHckZuL0RiRUFvbFl6?=
 =?utf-8?B?QUd5Ri9UcXlQUXVQK2toclVkaitQWW9iVEN2andTWHJwNjhFZW13Qy9FR2Jx?=
 =?utf-8?B?VnppN1Nld2l4Wk54QTNvSG5ZS0xranE1MTJQN2JEWnArYkRqc1FJSTlPUm03?=
 =?utf-8?B?K1ZCUzRscmhqcWZSVGJBK2NOV0lqNGZjSGtiOHlnM1RYM3RTRndIMko2S2hP?=
 =?utf-8?B?K3RCSzV1NEFoNGM1MS95Y21aRjIxTVZuSWRvS2pMWUFGOU9EQ3dFVm01RXVa?=
 =?utf-8?B?OHo0VkN3eWRQUmNWemhwOTdpb2lTbTM3ZTZTZW5nNk9ITVhIdXJoSnNFTXNT?=
 =?utf-8?B?YlR0cnBNZEh0SUs5KzVIaGFLZGNSRXo5MDJLZVFoZ2oxQVZ1UXNYS2ZucGtz?=
 =?utf-8?B?ZzNiSVlvdGw2YzFTVTJ0U0N2d0hWcUxaVkZkRlBTakoyb2xCUlJwZWNuZDly?=
 =?utf-8?B?T1lyNmFYWktqMWl3ZmtBeGJoZ1pFbzFtdmhXRDhGNTRlS2tVY2VLOEJIZzBx?=
 =?utf-8?B?S2VXMEI2dlpYZklLMFFuY1ozcUtxTjV5a2k5WW41WkpqWWJoRS9Ed2VRdG82?=
 =?utf-8?Q?Pvtcxej/9Y29qAm943QifN41Uayjw4eFu5IGj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <824F8C0AB70FFD4AB867B77CE978DC6D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7031aa83-3418-4806-4171-08da32a52646
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 16:50:11.8852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLCmhuBUlcRosCHK+c/l5xh5SZIa0Hy0oToB8jCg2uzgGmHxJ2pD2PXFQ71+oHcP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1488
X-Proofpoint-ORIG-GUID: YqWDT5AYDrxT4H7wlb8V1EtauTpLdTbf
X-Proofpoint-GUID: YqWDT5AYDrxT4H7wlb8V1EtauTpLdTbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_04,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTA5IGF0IDExOjU0IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFNhdCwgTWF5IDcsIDIwMjIgYXQgODoyMSBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBSZXBsYWNlIHN0cnVjdCBicGZfdHJhbXBfcHJvZ3Mg
d2l0aCBzdHJ1Y3QgYnBmX3RyYW1wX2xpbmtzIHRvDQo+ID4gY29sbGVjdA0KPiA+IHN0cnVjdCBi
cGZfdHJhbXBfbGluayhzKSBmb3IgYSB0cmFtcG9saW5lLsKgIHN0cnVjdCBicGZfdHJhbXBfbGlu
aw0KPiA+IGV4dGVuZHMgYnBmX2xpbmsgdG8gYWN0IGFzIGEgbGlua2VkIGxpc3Qgbm9kZS4NCj4g
PiANCj4gPiBhcmNoX3ByZXBhcmVfYnBmX3RyYW1wb2xpbmUoKSBhY2NlcHRzIGEgc3RydWN0IGJw
Zl90cmFtcF9saW5rcyB0bw0KPiA+IGNvbGxlY3RzIGFsbCBicGZfdHJhbXBfbGluayhzKSB0aGF0
IGEgdHJhbXBvbGluZSBzaG91bGQgY2FsbC4NCj4gPiANCj4gPiBDaGFuZ2UgQlBGIHRyYW1wb2xp
bmUgYW5kIGJwZl9zdHJ1Y3Rfb3BzIHRvIHBhc3MgYnBmX3RyYW1wX2xpbmtzDQo+ID4gaW5zdGVh
ZCBvZiBicGZfdHJhbXBfcHJvZ3MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcg
TGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGFyY2gveDg2L25ldC9icGZfaml0
X2NvbXAuY8KgwqDCoCB8IDM2ICsrKysrKysrKy0tLS0tLS0tDQo+ID4gwqBpbmNsdWRlL2xpbnV4
L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM2ICsrKysrKysrKysrLS0tLS0tDQo+ID4g
wqBpbmNsdWRlL2xpbnV4L2JwZl90eXBlcy5owqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gwqBpbmNs
dWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKga2VybmVsL2Jw
Zi9icGZfc3RydWN0X29wcy5jwqDCoMKgIHwgNjkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+ID4gLS0NCj4gPiDCoGtlcm5lbC9icGYvc3lzY2FsbC5jwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAyMyArKysrLS0tLS0tLQ0KPiA+IMKga2VybmVsL2JwZi90cmFtcG9saW5lLmPCoMKgwqDC
oMKgwqDCoCB8IDczICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+IC0tLS0NCj4g
PiDCoG5ldC9icGYvYnBmX2R1bW15X3N0cnVjdF9vcHMuYyB8IDM2ICsrKysrKysrKysrKysrLS0t
DQo+ID4gwqB0b29scy9icGYvYnBmdG9vbC9saW5rLmPCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+
IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHzCoCAxICsNCj4gPiDCoDEwIGZpbGVz
IGNoYW5nZWQsIDE3NCBpbnNlcnRpb25zKCspLCAxMDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0K
PiBUd28gdGhpbmdzIHRoYXQgY2FuIGJlIGRvbmUgYXMgYSBmb2xsb3cgdXAsIG90aGVyd2lzZSBM
R1RNOg0KPiANCj4gQWNrZWQtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpQGtlcm5lbC5vcmc+
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiAtaW50IGJwZl9zdHJ1Y3Rfb3BzX3ByZXBhcmVfdHJhbXBv
bGluZShzdHJ1Y3QgYnBmX3RyYW1wX3Byb2dzDQo+ID4gKnRwcm9ncywNCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBicGZfcHJvZyAqcHJvZywNCj4gPiArc3RhdGljIHZvaWQgYnBmX3N0cnVj
dF9vcHNfbGlua19yZWxlYXNlKHN0cnVjdCBicGZfbGluayAqbGluaykNCj4gPiArew0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBicGZfc3RydWN0X29wc19saW5rX2RlYWxsb2Moc3Ry
dWN0IGJwZl9saW5rICpsaW5rKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoCBrZnJlZShsaW5r
KTsNCj4gDQo+IFRoaXMgd29ya3MgYnkgYWNjaWRlbnQgYmVjYXVzZSBzdHJ1Y3QgYnBmX2xpbmsg
aXMgYXQgdGhlIHRvcCBvZg0KPiBzdHJ1Y3QNCj4gYnBmX3RyYW1wX2xpbmsuIEJ1dCB0byBkbyB0
aGlzIHByb3Blcmx5IHlvdSdkIG5lZWQgY29udGFpbmVyX29mKCkgdG8NCj4gZ2V0IHN0cnVjdCBi
cGZfdHJhbXBfbGluayBhbmQgdGhlbiBmcmVlIHRoYXQuIEkgZG9uJ3QgdGhpbmsgaXQgbmVlZHMN
Cj4gYQ0KPiByZXNwaW4ganVzdCBmb3IgdGhpcywgYnV0IHBsZWFzZSBzZW5kIGEgZm9sbG93LXVw
IGZpeC4NCj4gDQoNCkZpeGVkIQ0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgYnBmX2xpbmtfb3BzIGJwZl9zdHJ1Y3Rfb3BzX2xpbmtfbG9wcyA9IHsNCj4gPiArwqDC
oMKgwqDCoMKgIC5yZWxlYXNlID0gYnBmX3N0cnVjdF9vcHNfbGlua19yZWxlYXNlLA0KPiA+ICvC
oMKgwqDCoMKgwqAgLmRlYWxsb2MgPSBicGZfc3RydWN0X29wc19saW5rX2RlYWxsb2MsDQo+ID4g
K307DQo+ID4gKw0KPiANCj4gWy4uLl0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9icGYvYnBm
X2R1bW15X3N0cnVjdF9vcHMuYw0KPiA+IGIvbmV0L2JwZi9icGZfZHVtbXlfc3RydWN0X29wcy5j
DQo+ID4gaW5kZXggZDBlNTRlMzA2NThhLi40MTU1MmQ2ZjFkMjMgMTAwNjQ0DQo+ID4gLS0tIGEv
bmV0L2JwZi9icGZfZHVtbXlfc3RydWN0X29wcy5jDQo+ID4gKysrIGIvbmV0L2JwZi9icGZfZHVt
bXlfc3RydWN0X29wcy5jDQo+ID4gQEAgLTcyLDEzICs3MiwyOCBAQCBzdGF0aWMgaW50IGR1bW15
X29wc19jYWxsX29wKHZvaWQgKmltYWdlLA0KPiA+IHN0cnVjdCBicGZfZHVtbXlfb3BzX3Rlc3Rf
YXJncyAqYXJncykNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
cmdzLT5hcmdzWzNdLCBhcmdzLT5hcmdzWzRdKTsNCj4gPiDCoH0NCj4gPiANCj4gPiArc3RhdGlj
IHZvaWQgYnBmX3N0cnVjdF9vcHNfbGlua19yZWxlYXNlKHN0cnVjdCBicGZfbGluayAqbGluaykN
Cj4gPiArew0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBicGZfc3RydWN0X29wc19s
aW5rX2RlYWxsb2Moc3RydWN0IGJwZl9saW5rICpsaW5rKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKg
wqDCoCBrZnJlZShsaW5rKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBicGZfbGlua19vcHMgYnBmX3N0cnVjdF9vcHNfbGlua19sb3BzID0gew0KPiA+ICvCoMKgwqDC
oMKgwqAgLnJlbGVhc2UgPSBicGZfc3RydWN0X29wc19saW5rX3JlbGVhc2UsDQo+ID4gK8KgwqDC
oMKgwqDCoCAuZGVhbGxvYyA9IGJwZl9zdHJ1Y3Rfb3BzX2xpbmtfZGVhbGxvYywNCj4gPiArfTsN
Cj4gPiArDQo+IA0KPiBZb3UgYWxyZWFkeSBkZWZpbmVkIHRoaXMgb3BzIHN0cnVjdCBhbmQgcmVs
ZWFzZS9kZWFsbG9jDQo+IGltcGxlbWVudGF0aW9uDQo+IGluIGtlcm5lbC9icGYvYnBmX3N0cnVj
dF9vcHMuYywgd2UgbmVlZCB0byByZXVzZSBpdCBoZXJlLiBKdXN0IG1ha2UNCj4gdGhlIGJwZl9z
dHJ1Y3Rfb3BzLmMncyBub24tc3RhdGljIGFuZCBkZWNsYXJlIGl0IGluDQo+IGluY2x1ZGUvbGlu
dXgvYnBmLmguIEFnYWluLCBkb24ndCB0aGluayB3ZSBuZWVkIGEgcmVzcGluIGp1c3QgZm9yDQo+
IHRoaXMsIGl0J3MgbW9zdGx5IGNvZGUgaHlnaWVuZS4NCg0KRml4ZWQhDQoNCg0KDQo=
