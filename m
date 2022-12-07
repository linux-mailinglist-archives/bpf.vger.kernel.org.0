Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0864637B
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLGVtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLGVtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:49:21 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2089.outbound.protection.outlook.com [40.107.12.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55B862F5
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZrBXAeCZ8SbQdSejJSWjA83gJ1VIjKf9A2gBqnJH42d/0m211fLuqzstSlOos7mSzQixeYs/mwYai1WCv0wYJ8xncZzVEA6witI2eSoYS05ahOV5OF+LzONx9UaLOHc/EZeBXkWg3Nv5X1R/1rdNJ7Epwbu2HGYT+Gt9O/EDCGVHG8rObEUs5CNsVk6dFuk1HGsQWjdKBkLNGugIzfwM/DTajuLwWc9JkNFVZmjGrNj9So8W5OvrOOaAgF/toGKvLTcWU6y9DXmeky+YYvugf3FGv+Fe7BdDhjd60ChcG1dRwN99J7npyL5u3EcyDSAxSbd92Ey1aWQEPA6IRtBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftpE7YS/i9poAfjx1mg0oXFLeksMXzBaokvd9jn2fOM=;
 b=Y1MnABtpMaoc8fd2h2rjwjevLb0j2UTSUzt5b4EnVh4tGqiRDLd37in3c5W/Z7IeKTeSeaoyW2ondEe67HaYVVw2NgoH4XqJ4alyI3WQ9lusR3K5kg3Lz7bcBf8GNYVt7P5QCI/0AeI/oVIdfx9IFkBuEhqgZ6hXPLjea/OjHd5UALCX9hsOhH5ZemGDSt21wH+1ovmciewrMBYNwhROvMjd+mTgCfD/O5NK2rmt8BbNF1oHip5NHc7PHmowxJq8m4LpZUbGWsHoXr8WF8avzLDO7EP/hzKSWkrZspE43pwX+FcIL7Hh7+dCmkawGdeEp5Sqrj51c8sBIGCKhKq7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftpE7YS/i9poAfjx1mg0oXFLeksMXzBaokvd9jn2fOM=;
 b=yXqsX8SJ8OrKPeOoAHvSuz1w1OmjWFhFxev37hDzRp34siwuBCVRkstwjwp6D2NcneppWgYUxhUKZ4IV05m+T6p17IqE+tEVh20c1cE+RaeRdir7XVvJW+N+LRraUGzRt3bVG0PgZeFho/jJM3JNihNdYcOkchahYF8cyi2/+j5XjSBqBpxGCGk0AqRfxKHpkZqgCUvqMMJr5H61Pzkdk2wkWItxj7fg51tYgErmYF9wszm7nqBxyXaKYz9ufQxekPdSLk7vxu5YlMuERqrpSGNcFOGjoo9h8KeG8Y/SsdeEjy7w6OIMsBUIdmOfsxhDUzbP3tqfTcDtugEoUkMaqg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:48:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 21:48:55 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Thomas Gleixner <tglx@linutronix.de>, Song Liu <song@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq4/PciAgBaVcoCAAHZiAIAAbN6AgAESV4CAARoiAIAAri6AgABmeACAAHVtgIAADBoAgAcClYCAAUHIgIAAFYsAgABGIICAAAxKAA==
Date:   Wed, 7 Dec 2022 21:48:55 +0000
Message-ID: <4f7d2060-b2a7-46e7-0195-989b7d9a49dd@csgroup.eu>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
 <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx> <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
 <87h6y7dix4.ffs@tglx>
In-Reply-To: <87h6y7dix4.ffs@tglx>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2156:EE_
x-ms-office365-filtering-correlation-id: 2928ce9d-10c0-4d29-af4f-08dad89cd67f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YN50hrewn/c6CTywIpbRn77a5NBN2nZynNJVeMZVGovJ7ZolvLXSut0ap+udYu4CsAOo+gu+4gJGHRcE0icMIILB0g8uewbFYNhTNWYba5HOUfXKGl7nghF+oCDKcQAdqPwaI9bHxijiQO+vEpGSpxda6LmZtMFH8k796HSUzYit7h5ZCcqtYFP9F0XK6dxtgl23TpcpPvk9mEkUeRhexbl09h1Qtyahg5DFz7f0+Ph4Ikv2JsSICMeeUGXTEKznU0kgelg00SpyoK1wIK9CDvl9Lrolbzlg6dVtf3As7JWjX1lz+HBvvo/naBLY7Ni7coiOFHf5EmNmJfUiuThNiwBIz9cAgtUrLISK/e+3pgOQAMkPI84iIZAnzCnFL0viZsmmNdOK+FjkasaP9cX5pJ69qLAb8oxBXaTtU0FiqA8Ia+UA5XZDdKG/VshKLakwON+pJwhgW2OxCQHADvHAPGKjRj/N5fWH/NObsaSK6hI+mvOGe6zYQre0Ezm0+c3DCjYUdAfpCpJ8cihkQ2djvn3ZVo5/ByJ4Zo5yynbe9lPY51O0Zz5W9ghrqI4jR2SUr0tBgvBc9VaV37DpjUcOVXYe2hI2cPiiL0MKeRfNN6uqw+HoHUcBwQP13xpYyr5TDCmxBNFty0STV41IZiYxlNSxiW/GOszVtK1hy1nCyQOqD5bP3msPoiTdJqIeAOQQUFzSH4D4FEMreM4g0rUgCnGElhUHa7HHan1lAYNl5LEKDfeXrAFugpjuPIhn2lkNgZ0jb1Aaq6z8F0LJdRNR2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(41300700001)(38100700002)(2616005)(2906002)(186003)(83380400001)(5660300002)(36756003)(122000001)(44832011)(478600001)(8936002)(7416002)(6486002)(38070700005)(6506007)(31686004)(71200400001)(66476007)(91956017)(66446008)(76116006)(8676002)(64756008)(31696002)(66556008)(66946007)(6512007)(316002)(26005)(4326008)(86362001)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWt2WVh3dkplT3M3ODRtdXNEdGd3NUlkdVBvRXNoYWxlVWZ2bStkSzJxeFl1?=
 =?utf-8?B?VTZnNHlGTis2RkFqa1NUSVRVTXNiQVIzdUd2RE9HZ2ZFMnRqcktLSi9aK3ZE?=
 =?utf-8?B?cE1VaElCOGtzSzJrL1pZUTkzZ0VUUVJGWiszMmZESkZNbWxKZFpDQVcwc3Jx?=
 =?utf-8?B?bHdPMk1KMHJFSWVPNFRxZjZjTDZmaTlod09pa3RjaVQybndnazlEdUFCUUtv?=
 =?utf-8?B?NGl0Y0NzYlVlSXJSTGJWUGdhSFkyZytGc0hhbzNycXcwOFV4NkN3cXh4VUtw?=
 =?utf-8?B?MFdHTFc3V3pzTGUwUGhHTGY3eDBCcEhsK0FrT1djTm41OXByUEVPYWhLQmJL?=
 =?utf-8?B?M0xPVzNQRmUzM2ZoMFVYRFZhMTczSnlyeTkrOUtxQUtOSTI5eVZxZGtDNU9M?=
 =?utf-8?B?dmErUERkT2Z1MkphK0FCSVFMVmdudDliRE1vNVdQNlE3OWg3WDJwTUNVUGpK?=
 =?utf-8?B?QmxiT3R6d3Npb0twZnJDYmVXcFcxNU5lVnVTcTBIUk44bmNuQ0ViS2w4a1E2?=
 =?utf-8?B?ZDg2OERqb28zb2VhbHlZWHRQUStMNEtUUGIyUW9QVE1nN2VzL1VTZmo0MTU3?=
 =?utf-8?B?aTJOUkZDeVZFdkZrWk1Yd1RvU1VReG5hY3lYRWtnYXVnQTRubVZOMTRuT1h2?=
 =?utf-8?B?anYzbGg3VDNaZHlwWkhwTXNad3hEeTZnT3VCTXZ0cVBOTFpZOEZvOWtMTGNT?=
 =?utf-8?B?OEtwaXBqeG1xR3BaeVFuKzkybEN0cCtLeTkyb21Lb2EvVlQ1OGZwSHRuTGs4?=
 =?utf-8?B?TTRrTkdORE1PQmZuM1JKTjY2bnZGSXJWNGtVR1V0dHZXQjB3V2ZtRmorNXl6?=
 =?utf-8?B?ZDBwc0FKSllidDY0dEwyQkNpd0VzTXFqeTlrV0NvTXJDQmFwYVhiQ1JwRzVW?=
 =?utf-8?B?aElxVitLYmtUMGV1RDNZd1dac1FkREtWZ01aSEhwRTRiTGt6NnNDNzlVa3Y1?=
 =?utf-8?B?OThZb0k3WXhGdlU2OUVNZGEzT0FydjFDenB6NmRoSEFSL1d5NkJRUHdEREo2?=
 =?utf-8?B?TmErVHMvdWJJMW16aGJIQ2FqOGtmTGs3SG5uMCswY2JLaGVXckRNaDR1S0k4?=
 =?utf-8?B?NGdFOHZOdjhWbTltU1JXeGxTbUc0bStXelJsUUFxbXFlWEFNZnhaeVNLSkw4?=
 =?utf-8?B?WnpFdFhhYUR6dkhUcE5LdXZtVEdlL09FSkRkaUVZbWpSaER4U1dva2JRUjZm?=
 =?utf-8?B?OGNuVnE3UmdyYlJsNUc3MGgvQkY3ajhZMjZZSHlscjV0OWlKbVQ2M05ZQjc2?=
 =?utf-8?B?QTJBUGxvUXhJMUFENzM0VFBxTE4yRGEzNkxjNHJDaVFlY2FFUWE2UzRSa3V4?=
 =?utf-8?B?OUlSZjhXZFM2VGtmRm03UFNBOHlpZ2xJZG1wbGNoK2VPQkk0MlB6enBQRXRU?=
 =?utf-8?B?aTlQZkVBMlVkQm5LZmNJT29lWE81WDJ4M2Z5T25FQmJvUFNaMnJDdDdST3NL?=
 =?utf-8?B?Q1d1QWN6dHJjZUJDV3FOaWk5VFZsQjViWUdib0RxbUdBQkJxK0Rvc3hsZk5n?=
 =?utf-8?B?NFI0amhtUWpoWXRFWDJYcU1HRndEQmdvbnhrekU3azFvRXFlcnFnckhLdVQ5?=
 =?utf-8?B?TGVCbkkwaFlDRlFCQ1B3L3ZNenpGMFZlRC9MNTFNWU9ubytSR1J6NmczSEF3?=
 =?utf-8?B?R0V1djlTTzNKZmhoODRlckxUeFBQUFo1cWVIR2xWdk5xcmphRjVEcm5kTkZO?=
 =?utf-8?B?Y2YxcU5VTHd4azNDemkrWlFWVHg5RTJJOEg2R245YytRSkJxdFNOanJ0M1BX?=
 =?utf-8?B?YmJEUmRWcW9yZmZLTWFwaUhXZVpBT1BYdU1BK1BEZ2tUaVV4Mlg3UWQrWnpK?=
 =?utf-8?B?ZXlYNlhDam04WWN3dFlmM2tRUFFjcjRBZjNOcXhzYnU0c0JWQW90cWVNcncr?=
 =?utf-8?B?S203UWpMTEQ5bTJoRnJHRmF6amp3MFdQR3pUWU43cFE5N1FuaUl5UWNNZ1ha?=
 =?utf-8?B?SGN5YzhzbDlRMTEydGtId3lydGdEVllkSXdxNzlESUQyK1JlMVphbng0SVJW?=
 =?utf-8?B?ZVBSZk9vQ2pBOG1Bd29waW40N216VTdiZlJBUGJjZ3h6NS9HL2x1bFo4SkdM?=
 =?utf-8?B?SkU5UkhrMEUzUG4yMnN2ODZvME1LOXNuZXdqcW1ybkZNM3I3OXYrYVhUdy9y?=
 =?utf-8?B?NEs2VDNZcDhQRUN6NTdFRWdKQ3ZzYzMxczY3cjN2SmpXRld0Rkt0TlN2TFNu?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BE26C6BF18A89448BFDB38FB6966579@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2928ce9d-10c0-4d29-af4f-08dad89cd67f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 21:48:55.0911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXn72YxEc/wZB8bu7dSGbcmjaJCVrx2r2bAnTEvrhMbCTCAR9HjuxffjFgYWLQZrcsTcVK9ivtl+cAaquBi0csxKWblz84wy19ljd1HnO7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2156
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA3LzEyLzIwMjIgw6AgMjI6MDQsIFRob21hcyBHbGVpeG5lciBhIMOpY3JpdMKgOg0K
PiBDaHJpc3RvcGhlLA0KPiANCj4gT24gV2VkLCBEZWMgMDcgMjAyMiBhdCAxNjo1MywgQ2hyaXN0
b3BoZSBMZXJveSB3cm90ZToNCj4+IExlIDA3LzEyLzIwMjIgw6AgMTY6MzYsIFRob21hcyBHbGVp
eG5lciBhIMOpY3JpdMKgOg0KPj4+IFRoZSAidXNlIGZyZWUgc3BhY2UgaW4gZXhpc3RpbmcgbWFw
cGluZ3MiIG1lY2hhbmlzbSBpcyBub3QgcmVxdWlyZWQgdG8NCj4+PiBiZSBQTURfU0laRSBiYXNl
ZCwgcmlnaHQ/DQo+IA0KPiBDb3JyZWN0LiBJIGp1c3QgdXNlZCBpdCBmb3IgdGhlIGV4YW1wbGUu
DQo+IA0KPj4+IExhcmdlIHBhZ2Ugc2l6ZSwgc3RyaWN0IHNlcGFyYXRpb246DQo+Pj4NCj4+PiBz
dHJ1Y3QgbW9kX2FsbG9jX3R5cGVfcGFyYW1zIHsNCj4+PiAgICAgIAlbTU9EX0FMTE9DX1RZUEVf
VEVYVF0gPSB7DQo+Pj4gICAgICAgICAgIAkubWFwdG9fdHlwZQk9IE1PRF9BTExPQ19UWVBFX1RF
WFQsDQo+Pj4gICAgICAgICAgICAgICAgICAgLmZsYWdzCQk9IEZMQUdfU0hBUkVEX1BNRCB8IEZM
QUdfU0VDT05EX0FERFJFU1NfU1BBQ0UsDQo+Pj4gICAgICAgICAgICAgICAgICAgLmdyYW51bGFy
aXR5CT0gUE1EX1NJWkUsDQo+Pj4gICAgICAgICAgICAgICAgICAgLmFsaWdubWVudAk9IE1PRF9B
UkNIX0FMSUdOTUVOVCwNCj4+PiAgICAgICAgICAgICAgICAgICAuc3RhcnRbMF0JPSBNT0RVTEVT
X1ZBRERSLA0KPj4+ICAgICAgICAgICAgICAgICAgIC5lbmRbMF0JCT0gTU9EVUxFU19FTkQsDQo+
Pj4gICAgICAgICAgICAgICAgICAgLnN0YXJ0WzFdCT0gTU9EVUxFU19WQUREUl8yTkQsDQo+Pj4g
ICAgICAgICAgICAgICAgICAgLmVuZFsxXQkJPSBNT0RVTEVTX0VORF8yTkQsDQo+Pj4gICAgICAg
ICAgICAgICAgICAgLnBncHJvdAkJPSBQQUdFX0tFUk5FTF9FWEVDLA0KPj4+ICAgICAgICAgICAg
ICAgICAgIC5maWxsCQk9IHRleHRfcG9rZSwNCj4+PiAgICAgICAgICAgICAgICAgICAuaW52YWxp
ZGF0ZQk9IHRleHRfcG9rZV9pbnZhbGlkYXRlLA0KPj4+IAl9LA0KPj4NCj4+IERvbid0IHJlc3Ry
aWN0IGltcGxlbWVudGF0aW9uIHRvIFBNRF9TSVpFIG9ubHkuDQo+Pg0KPj4gT24gcG93ZXJwYyA4
eHg6DQo+PiAtIFBNRF9TSVpFIGlzIDQgTWJ5dGVzDQo+PiAtIExhcmdlIHBhZ2VzIGFyZSA1MTIg
a2J5dGVzIGFuZCA4IE1ieXRlcy4NCj4+DQo+PiBJdCBldmVuIGhhcyBsYXJnZSBwYWdlcyBvZiBz
aXplIDE2IGtieXRlcyB3aGVuIGJ1aWxkIGZvciA0ayBub3JtYWwgcGFnZQ0KPj4gc2l6ZS4NCj4g
DQo+IEBncmFudWxhcml0eSB0YWtlcyBhbnkgc2l6ZSB3aGljaCBpcyB2YWxpZCBmcm9tIHRoZSBh
cmNoaXRlY3R1cmUgc2lkZQ0KPiBhbmQgY2FuIGhhbmRsZSB0aGUgQHBncHJvdCBkaXN0aW5jdGlv
bnMuDQo+IA0KPiBUaGF0J3Mgd2h5IEkgc2VwYXJhdGVkIGZ1bmN0aW9uYWxpdHkgYW5kIGNvbmZp
Z3VyYXRpb24uDQo+IA0KPiBOb3RlLCBpdCdzIG5vdCBzdHJpY3QgY29tcGlsZSB0aW1lIGNvbmZp
Z3VyYXRpb24uIFlvdSBjYW4gZWl0aGVyIGJ1aWxkDQo+IGl0IGNvbXBsZXRlbHkgZHluYW1pYyBh
dCBib290IG9yIGhhdmUgYSBzdGF0aWMgY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUNCj4gYXMgY29t
cGlsZSB0aW1lIGRlZmF1bHQuDQo+IA0KPiBUaGF0IHN0YXRpYyBkZWZhdWx0IG1pZ2h0IGJlIF9f
aW5pdGNvbnN0IGZvciBhcmNoaXRlY3R1cmVzIHdoZXJlIHRoZXJlDQo+IGlzIG5vIGJvb3QgdGlt
ZSBkZXRlY3Rpb24gYW5kIGNoYW5nZSByZXF1aXJlZCwgYnV0IGNhbiBiZSBfX2luaXRkYXRhIGZv
cg0KPiB0aG9zZSB3aGljaCBuZWVkIHRvIGFkanVzdCBpdCB0byB0aGUgbmVlZHMgb2YgdGhlIGRl
dGVjdGVkIENQVS9wbGF0Zm9ybQ0KPiBiZWZvcmUgZmVlZGluZyBpdCBpbnRvIHRoZSBtb2R1bGUg
YWxsb2NhdG9yIGluaXQgZnVuY3Rpb24uDQo+IA0KPiBEb2VzIHRoYXQgYW5zd2VyIHlvdXIgcXVl
c3Rpb24/DQo+IA0KDQpZZXMgaXQgZG9lcywgdGhhbmtzLg0KDQpDaHJpc3RvcGhlDQo=
