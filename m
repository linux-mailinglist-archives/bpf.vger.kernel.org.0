Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01834E305E
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352386AbiCUTCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352385AbiCUTCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 15:02:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E025006C
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:00:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LDkwdk022519
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hgzHVhIk+7FQUsINAVU0e8SOkkg/Y9k/SnG2TjPa2MY=;
 b=jjLH512W6GNnVWFhmmjqGVT7CdYU61CUzfE6WFAV5S2NtClj6bv+LRmmAuw7r6zQ/oH6
 wrPL6CB8xA/MaidVV98+tFy1AOQ1HmmPJ/o2pTVsNiukT9W27Rt5ys17w7/q3rX8mBfT
 MiaRNfxdYYHBabYmwhi6cOcRUkDK+GBhI3w= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewb7jm78h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 12:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRhLwwPU+3iHdoMFjo+lpy/8MgjsIODdYbdrqIfvUqrhuxdoNQ8IUcvOWy9yriJIT6kjpQjwLYrGwEI2Su+FievqxFrxoJWDSdf8bilFVq8/n9MIXR0dhVg6sch6ZdBJE0cp7B1ydESovfr2LPJFxrTUDZhWZlSp6kE+zsr3u8NK029Js78qXLBXPYScDWCUvACFtDuShTZRwGu9uw/yATXeBmsuBYJzJOhwcX95vgnDLoDV+wjVhTr0fEahcVEh8h/ymWJTu83B0aUSETcYU69Hy1nJtwB8B5hJOnQfl7tXKjYWijHokJHhHAzEv1TpzWfjH3mnE9R107x/36CkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgzHVhIk+7FQUsINAVU0e8SOkkg/Y9k/SnG2TjPa2MY=;
 b=Q/oEND17gh65jCbulOOWSp99KRV1mXMjqZ7vRJ+HFcXGXaD7qzp8/Ogf9qJgZrfVq4sudodoiMRD8CltP7nIn7F+tp5Kkdp+qiiaj5k0KEypeVj+Tb/YSXtUAG/PJl2ETz1415Kjd5fFnD+31XGG+uolwdnJ69KkLZEErU222zJVWgaBA577jsj3hUmy81RIbDd5qroQumY75lQ0xjZImssPdrAtSskG0GF61r86mIAhJGBjnsmW5i96uJcO5lSFZQLFVvRsR/VP8UZlBYuOxbhVkwv8Q1ZPjX7FGQZ8uHIlu2zq4tM/DMrNr25363YqB+lMMJfKmpdN2LGvrH5RLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by CY4PR15MB1205.namprd15.prod.outlook.com (2603:10b6:903:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 19:00:39 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 19:00:39 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on
 the caller thread's stack
Thread-Index: AQHYOM8Kq87gJQeSQ0GNh2q/Qbcp76zFhbWAgAKDNQCAALIXgIABf0gA
Date:   Mon, 21 Mar 2022 19:00:38 +0000
Message-ID: <a3270d0687f90ee9a87ec65b6617da4cbf4e3ca5.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-3-kuifeng@fb.com>
         <20220318190917.tecjespuzkegwb2k@ast-mbp>
         <cb3507651829d347ffdcd48678b58c323bce99d5.camel@fb.com>
         <CAADnVQJTyjDM-5Mo_R+B0_gj6tZH5zfP9k1dD48h=Nrc7p8rWA@mail.gmail.com>
In-Reply-To: <CAADnVQJTyjDM-5Mo_R+B0_gj6tZH5zfP9k1dD48h=Nrc7p8rWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab05672e-6c98-4d37-209b-08da0b6d1708
x-ms-traffictypediagnostic: CY4PR15MB1205:EE_
x-microsoft-antispam-prvs: <CY4PR15MB1205B6C65AF02B30DAF7DD97CC169@CY4PR15MB1205.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aD6I3LLZ4KPwbt6EZwGSU+Bp0YwwFb8XssgfNuXmZbcW2GGZNU+jR2W4ycJw7zL0kIm3Qs+Rxa86LrITkBIsGc1SdhT4t2jv1xQ6kqTw7dtqVmzDveoknDjvzDgO6H9y55zMwhf5qYQQkn/u/8KePIXy9HvZDOMx4kXbx99I3cz8u16ytmwNfUTYJdp3xIJy2K97XUBjP28Y/601J930Q+nUVD5GFphEMe1e5UImZtNb3usnXanBGeNBW0TBPUeWBwBWrJJXb8sbX6OKKygte+MMgqKTVLkwqHv/L+ZA2n9DB+USc41C3pquWDEe1NNpmdTLQvwvTiYUhh971DtTARrRafah6OhUo6EJYbR5N7gHGFs/Tj2l9JdsSbe074DREEhYkf8vgZhieQKpkEpQpLk/0OeYkq0zU2LTuS/ONaeEarozCYk8AjTJDuhYMKg23cpN8NlBSRruIJfHti0rW3KWe2edivVGztQe3J5mgcRqnIWYz9rg04AgascJVpDC/DOwOh2U5p0EPk3JjZKCLi/9ggzIAzRhh/LkTJvliLjmnkR10JjhX7NLYV9Vho0mGGcMH4OETRYGPW2JXZ491dFKGKkexV2KsDytr+5O3FpyN3wI8JWN4yi7Uriq48/Y4qy7iNCz6mQdigi2rvyyWRR4pguLdHcMd8DoV2q5VyVmS1MolPrTMfWI3nlSIqrNeHwFh40TOHqqzn20l3PVmU8u4dnvAPb55RJ0qSlQ3wxOL+0Te07znr/0pQU5VG4KoJDvxBSI1l/MFaByzyrN6gO89UCfOtUEW8vRxDC63c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(6512007)(71200400001)(53546011)(6506007)(38070700005)(6916009)(122000001)(54906003)(8676002)(316002)(66556008)(91956017)(86362001)(66946007)(4326008)(966005)(6486002)(38100700002)(64756008)(8936002)(508600001)(5660300002)(186003)(83380400001)(76116006)(66476007)(66446008)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGJCUnlFOGZKcGRtOXZ5RE43Yk9TdlAwd1VHam85ZmkxYVducFVubmFzOVo4?=
 =?utf-8?B?aU44bGJrM254NVY3d2FobHdwbkRsL0VwYXVTanhrN2xxOGxkUThDbVpPcGpy?=
 =?utf-8?B?bGdDUGM2TWdDaDZyc0IrYm05M1dRY2IvWmZMK054MnY4MDdtS3VJRzhTands?=
 =?utf-8?B?NHdXaW9nRzlNSmFMbzhhclFpNExDeS9YT3RnajVsei9leVVSQmZsZmg0NzN6?=
 =?utf-8?B?Wjc0aGlWWjFIakoyVmpBQkFQcVZGVTR6UndaK1YxQ1dNQTBwdnJuYzl2Wnoy?=
 =?utf-8?B?S2FUcmVMbzRzQWE4OHcyYkNoSTF1WGhQTU50bExzcTBWVkw4SEFaZ2NieVNm?=
 =?utf-8?B?WjZxUDdHVU1IcTNYQ2ZFWE9VTkY4N3pNZkMzanRWS3dMSlF6MVZwN25ZaUdp?=
 =?utf-8?B?ZmdVcXB1SEh0L0xWTTZ3aFdZTmZEUEt0WEpFZG5tRHlsamxNallJRVlQelRE?=
 =?utf-8?B?N1ZVU3U4SHFReG81amJxem9QSGsrckxTNWl3OXN5SVlubHhiMXA4RVNlZjJh?=
 =?utf-8?B?TEJNbzZXZW5YQUFZcEoyK0drRlE2K0d2Qko4amNYQUNuTEY1S0pEaG94clRI?=
 =?utf-8?B?TVBYajd4YjdZa1JqdnhNbklNMURuZVFQUi9scFBTWUNEOVJwVjM5UC9XSXUx?=
 =?utf-8?B?Qnd2eU1XYXBVejRzSkp2cUNOZTRiTllVbVk3dzk0TnIzNXF0K0JGOS9zeXpY?=
 =?utf-8?B?T3VBNFFJZWMxbERFYnh6Q2haMVFQaUR5Nm45VmdMVXhuN2k0QkpOem5BS0Jq?=
 =?utf-8?B?SmJyaXJ5Y3dEL1cyRnlja1JWK1FIUmk1SjRaR2FJRUFCMC9ZZjNjN0tQZG5C?=
 =?utf-8?B?bE9Lem42aWpKTHErM2Zickx3SFBKYWpia1JSVkJCYXpoRSsrbDdleElJUnox?=
 =?utf-8?B?eUFkWlZSdXVodWFiN1B4dlBRUXkyRWdwWHBhOVkzTVg3bzBRMU5TM2ZBOCtF?=
 =?utf-8?B?VGQ1cmgxVGx5eWd4cGNNK0hNb1ppRW1IS1BobFdSdmlwTENKd3VoRC9Nc1VE?=
 =?utf-8?B?NDhjVVdDRlRZRnhVNUhzcFZTaHdCV1VVOHJ0SkIwWVhWSi9hbXd0bkpXUXcr?=
 =?utf-8?B?VW1TUi9pWjViYzlscnNkalBpcUQybWZ5d1pVQVQxUVJQejJmc1BSNlhGeWVx?=
 =?utf-8?B?U1Z1ejRQMkJSUnQxbnZMb1FlTXJ6bkhib3ZDRGRYZytDNEV0YWxVaU1BeTBE?=
 =?utf-8?B?RzY3b2luVWJzYW5qNm0yQ3pXSndLMitEZEdkSFhUMWhLTkhuYVVpV2ZzWGx5?=
 =?utf-8?B?YVRaWjZGTzlLb0VaY0YzYXFpeTg3Y3NWRkg4dXhMc3pCYnMwVXRFN0NUYUN4?=
 =?utf-8?B?V3c2VWszei91TkZBcHo4OGZXeUJRMWJsTzNTbkMrbXhlZW9uNk1EYU51cU5J?=
 =?utf-8?B?NTAyc1ZPMGI1eC9BQ0JzS0F1dkxrMG1ieE5KaEpNRVRhamYrNDNBemN2VEdz?=
 =?utf-8?B?TzhYMUIzeU9zdTgyRWVDUTJ4QjlqVUJQWVAwRkpocVRza0g1OFZJYXB1OW9P?=
 =?utf-8?B?aTB2U0Q3UHFqWGtGVVdoUWU0L2JZa2V3Q3NKa3pyTHZhYkhTY0Q5bTF3bWJr?=
 =?utf-8?B?Z0h5OC9MUWptTUUwTlFxY0tZb29EOGpCbloxNXlWWEc4cHI3ak8zT2ZIdkJC?=
 =?utf-8?B?dE0rbjVvMml2VGNTWEhFQmNDb3Z4UFV1Ulo1SWExeUw3a08zcUlqM0pYTWJH?=
 =?utf-8?B?RldhYVhvRmlKYS9DY3QzNm1PdWhpR2Jib012dTlXT1VlV01tQi9OY3ZiVVc1?=
 =?utf-8?B?bmEwOU83RWhEUnZYU1c0Sk4yVTY0U3Nrcmhud0xTYzVJakRmNTJ1TXp4czRx?=
 =?utf-8?B?aVUxL1N6aDNCVy80SUZEczBRRndvMmpwM1krRnVRMmxpeUZaeFl3VktCZ2ZQ?=
 =?utf-8?B?WG9tc2RabXhSSzZteGY2dVExZDNQUGNMdktCWitLaUh4eVlBTFA0cklScmd3?=
 =?utf-8?B?NDJBa2RkTitsRDNlTnJGY25aTHhwc2pXUUFLQ21QcGtSOWZkOGFreUNyV0ZB?=
 =?utf-8?Q?tPNvwSiGYYE3pT5mAZzIh6Y9WMN4Qc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A92298FA7994D4BA3C70ACEE20B0672@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab05672e-6c98-4d37-209b-08da0b6d1708
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 19:00:39.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCZv7Wf3sSGIu96CqJ12kulFCrEVTfbQlqp9RNIiq3HSqQMiDz0rLa/ilqTr41PB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1205
X-Proofpoint-GUID: EdRLxSAhGPdtxpSH5JPNib-wb2K22qfa
X-Proofpoint-ORIG-GUID: EdRLxSAhGPdtxpSH5JPNib-wb2K22qfa
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_08,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU3VuLCAyMDIyLTAzLTIwIGF0IDEzOjA4IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFN1biwgTWFyIDIwLCAyMDIyIGF0IDI6MzEgQU0gS3VpLUZlbmcgTGVlIDxrdWlm
ZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCAyMDIyLTAzLTE4IGF0IDEyOjA5
IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1hciAxNSwg
MjAyMiBhdCAwNTo0MjoyOVBNIC0wNzAwLCBLdWktRmVuZyBMZWUgd3JvdGU6DQo+ID4gPiA+IEJQ
RiB0cmFtcG9saW5lcyB3aWxsIGNyZWF0ZSBhIGJwZl90cmFjZV9ydW5fY3R4IG9uIHRoZWlyDQo+
ID4gPiA+IHN0YWNrcywNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IHNldC9yZXNldCB0aGUgY3VycmVu
dCBicGZfcnVuX2N0eCB3aGVuZXZlciBjYWxsaW5nL3JldHVybmluZw0KPiA+ID4gPiBmcm9tIGEN
Cj4gPiA+ID4gYnBmX3Byb2cuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLdWkt
RmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBhcmNoL3g4
Ni9uZXQvYnBmX2ppdF9jb21wLmMgfCAzMg0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKg
IHwgMTIgKysrKysrKystLS0tDQo+ID4gPiA+IMKga2VybmVsL2JwZi9zeXNjYWxsLmPCoMKgwqDC
oMKgwqDCoCB8wqAgNCArKy0tDQo+ID4gPiA+IMKga2VybmVsL2JwZi90cmFtcG9saW5lLmPCoMKg
wqDCoCB8IDIxICsrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ID4gPiDCoDQgZmlsZXMgY2hhbmdl
ZCwgNTkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+ID4gPiA+IGIvYXJjaC94
ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+ID4gPiA+IGluZGV4IDEyMjhlNmU2YTQyMC4uMjk3NzVh
NDc1NTEzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMN
Cj4gPiA+ID4gKysrIGIvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+ID4gPiA+IEBAIC0x
NzQ4LDEwICsxNzQ4LDMzIEBAIHN0YXRpYyBpbnQgaW52b2tlX2JwZl9wcm9nKGNvbnN0IHN0cnVj
dA0KPiA+ID4gPiBidGZfZnVuY19tb2RlbCAqbSwgdTggKipwcHJvZywNCj4gPiA+ID4gwqB7DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHU4ICpwcm9nID0gKnBwcm9nOw0KPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCB1OCAqam1wX2luc247DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaW50IGN0eF9jb29r
aWVfb2ZmID0gb2Zmc2V0b2Yoc3RydWN0IGJwZl90cmFjZV9ydW5fY3R4LA0KPiA+ID4gPiBicGZf
Y29va2llKTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9wcm9nICpwID0gbC0+
cHJvZzsNCj4gPiA+ID4gDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgRU1JVDEoMHg1Mik7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIHB1c2ggcmR4ICovDQo+ID4gPiANCj4gPiA+IFdoeSBzYXZl
L3Jlc3RvcmUgcmR4Pw0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCAvKiBtb3YgcmRpLCAwICovDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfaW1t
NjQoJnByb2csIEJQRl9SRUdfMSwgMCwgMCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoCAvKiBQcmVwYXJlIHN0cnVjdCBicGZfdHJhY2VfcnVuX2N0eC4NCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgICogc3ViIHJzcCwgc2l6ZW9mKHN0cnVjdCBicGZfdHJhY2VfcnVuX2N0eCkNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgICogbW92IHJheCwgcnNwDQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoCAqIG1vdiBRV09SRCBQVFIgW3JheCArIGN0eF9jb29raWVfb2ZmXSwgcmRpDQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ID4gDQo+ID4gPiBIb3cgYWJvdXQgdGhlIGZvbGxvd2lu
ZyBpbnN0ZWFkOg0KPiA+ID4gc3ViIHJzcCwgc2l6ZW9mKHN0cnVjdCBicGZfdHJhY2VfcnVuX2N0
eCkNCj4gPiA+IG1vdiBxd29yZCBwdHIgW3JzcCArIGN0eF9jb29raWVfb2ZmXSwgMA0KPiA+ID4g
Pw0KPiA+IA0KPiA+IEFGQUlLLCByc3AgY2FuIG5vdCBiZSB1c2VkIHdpdGggdGhlIGJhc2UgKyBk
aXNwbGFjZW1lbnQgYWRkcmVzc2luZw0KPiA+IG1vZGUuwqAgQWx0aG91Z2gsIGl0IGNhbiBiZSB1
c2VkIHdpdGggYmFzZSArIGluZGV4ICsgZGlzcGxhY2VtZW50DQo+ID4gYWRkcmVzc2luZyBtb2Rl
Lg0KPiANCj4gV2hlcmUgZGlkIHlvdSBmaW5kIHRoaXM/DQoNCkkgdXNlIHRoZSBmb2xsb3dpbmcg
ZG9jdW1lbnQgdG8gZmlndXJlIG91dCBvcGNvZGVzLg0KDQpodHRwczovL3JlZi54ODZhc20ubmV0
L2NvZGVyNjQuaHRtbCNtb2RybV9ieXRlXzMyXzY0DQoNCkl0IGxpc3RzIGF2YWlsYWJsZSBhZGRy
ZXNzaW5nIG1vZGVzIGFuZCBjb2Rlcy4NCg0KQnkgdGhlIHdheSwgSSBmb3VuZCBJIGhhZCBtaXNz
ZWQgU0lCIGJ5dGUsIHRoYXQgcHJvdmlkZXMgZXh0cmENCmZlYXR1cmVzLiAgSXQgc2VlbXMgd29y
a2luZyBmb3IgdGhpcyBjYXNlLiAgSSB3aWxsIHRyeSBpdC4NCg0KDQo+IA0KPiAwOsKgIDQ4IGM3
IDQ0IDI0IDA4IDAwIDAwwqDCoMKgIG1vdsKgwqDCoCBRV09SRCBQVFIgW3JzcCsweDhdLDB4MA0K
PiA3OsKgIDAwIDAwDQo+IA0KPiA+ID4gDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgRU1JVDQoMHg0
OCwgMHg4MywgMHhFQywgc2l6ZW9mKHN0cnVjdA0KPiA+ID4gPiBicGZfdHJhY2VfcnVuX2N0eCkp
Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4ODksIDB4RTApOw0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgIEVNSVQ0KDB4NDgsIDB4ODksIDB4NzgsIGN0eF9jb29raWVfb2ZmKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIC8qIG1vdiByZGksIHJzcCAqLw0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4ODksIDB4RTcpOw0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgIC8qIG1vdiBRV09SRCBQVFIgW3JkaSArIHNpemVvZihzdHJ1Y3QNCj4gPiA+ID4g
YnBmX3RyYWNlX3J1bl9jdHgpXSwNCj4gPiA+ID4gcmF4ICovDQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqAgZW1pdF9zdHgoJnByb2csIEJQRl9EVywgQlBGX1JFR18xLCBCUEZfUkVHXzAsDQo+ID4gPiA+
IHNpemVvZihzdHJ1Y3QNCj4gPiA+ID4gYnBmX3RyYWNlX3J1bl9jdHgpKTsNCj4gPiA+IA0KPiA+
ID4gd2h5IG5vdCB0byBkbzoNCj4gPiA+IG1vdiBxd29yZCBwdHJbcnNwICsgc2l6ZW9mKHN0cnVj
dCBicGZfdHJhY2VfcnVuX2N0eCldLCByc3ANCj4gPiA+ID8NCj4gPiANCj4gPiBUaGUgc2FtZSBy
ZWFzb24gYXMgYWJvdmUuDQo+IA0KPiAwOsKgIDQ4IDg5IDY0IDI0IDA4wqDCoMKgwqDCoMKgwqDC
oMKgIG1vdsKgwqDCoCBRV09SRCBQVFIgW3JzcCsweDhdLHJzcA0KDQo=
