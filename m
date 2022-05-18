Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FEC52C272
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiERSea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 14:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbiERSeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:34:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F311CEEED;
        Wed, 18 May 2022 11:34:22 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IHDWND030997;
        Wed, 18 May 2022 11:34:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BxeQEfAHYAnS1zRiKPAV6HwkjbUlWUje/Eezwkv746U=;
 b=DavC8xU0xJJj9ZihueLR1yCGx40089qHbfQrUtpZH+Gq4tTfUfpGdOMiH9oG4cYdRA4Y
 v9dTqYTS/FesI0EX9XlI5yDbqwS0AdzsohElo+AtP2V2wvMvdUmb7li1Qn+KfQGZe34j
 RJIk+iEHB+2+YOL23e5DASDep0mxqM6lqt8= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836v1wa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjvHUpD0PoopT/WGNuIg50TJVyNF5fQMi9G+19a99C28A2CXl7Xc4gKtbDHKU+dQh7EYkPbjWM47HD4cgyyGHGBibH5m/RORXg1aZvUDgvBA4v92lh1sVtJIlGJ1po/oU6m0p0NQ95UM7CnjHY5FVoYldWD+iXujDNLwbp6x8h2NtGN2WRZ3KT10KMYg7bItCcFJa7iOVRQT5T9NflnU04Vz2RyobLFz0Mlszy2doB1npcrHb59l6vX24O99JCyHUGGMbDkOXJnS8MWT+yIz9qJ3Mo4NnuQL1+ve1s2xAC20seKV2p7zkVrMSOr6QCEdKrX70TvVAVpeIB3b2R0t4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxeQEfAHYAnS1zRiKPAV6HwkjbUlWUje/Eezwkv746U=;
 b=EYwfdEC65fZhaw8CTHiCUI4pfl2BQyXXv1nP3C9zxmcHwOdVXNb4hVPYec4jf3sfvqz1kpjI33fhqVrEoKm0koiu7kw/BTzsCLHSf0ox+aTIXDBC/Bw9ctsd7OYLHjRK+uaG9qp3S3DQIdDurEuurfx0bjzK8Oywtu/38OHTKB4KW7SijwYYXfSpP8pvEnk2yt1SP+/Hw4J0D1p+/xkH9cwDNuWCNmInuXcEx4a1o6ZUP3EAOj1S/GqZaS7AhDk6Pm9twkUtWke6YH07frYZLKrQTDVioG1Kaki0tDsxgr+ota3ncQgE4XEy9PJObncmISbPmwxIGw2I8cBSxuYTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB2541.namprd15.prod.outlook.com (2603:10b6:208:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 18:34:18 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 18:34:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Topic: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Index: AQHYaOeQGQ/WNhSrw0WYR6bm3RcCIa0k4kgAgAAXq4A=
Date:   Wed, 18 May 2022 18:34:18 +0000
Message-ID: <A4019486-85F3-4900-8073-6879608706B1@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
 <20220518170934.GG10117@worktop.programming.kicks-ass.net>
In-Reply-To: <20220518170934.GG10117@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a115b7c-5e6b-402b-7a9c-08da38fd04ed
x-ms-traffictypediagnostic: MN2PR15MB2541:EE_
x-microsoft-antispam-prvs: <MN2PR15MB25411969A7DE72C6AA3A3640B3D19@MN2PR15MB2541.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/HPbOGaMzChcM+U5BBeGa8GAXUf00KCb6YNr49NryWJCiuyN/mWUyK9iK51TMQ84Leet2QSkW2ZV4Aa57RNR+jvPIkA/nx8ZUfZ3CusRFVj5zZN+XalW6xqYSOegVez1wK5EVEdkuKzkxzCjMCMETYgDRRFFWROI7lIF20RcLCfb7F2kfl+woefJkWa6kUSF6ReW9NtibCDGg7mzdSscJFTss25B9KXn1hHCWa3GlvBRITfUIDAxST4vhh8hOjwYgt7lMukyj1/bGkd4Lw3xDeU2sx2ssZNIMLkJAM8WjPowri636e6o7ctdtx00MI9r/tYVrZIs1FXUXFj4I7dvw6opn+lO7eg3GeSABIuID46hzM7jlvmMZWi9P4DnH4xcr03SkNzKgtgNQ/jlg57dNAFu8zabrMJsInKvf8IVdjO8D1pxYshXL8jnCde4jDsRfSV/CMdYzDcG6ZeDRW/9z2UHAmuJ6ue7fC7GpBM2f7jLPJSUvQitxqOUngNFPRMeyrxew/vGNdjUuZ8+N4rm/s6gFCFIjWV+c2Tw91qX+FRCxMVFqKP+90g4oLgt6sOHLTZJ4E+qiAU/lZxObslH2g+HFtD58Bt/NVTF4s5SbNseF4IHpLfW6FPLHGhgqvihCBbfmJJDeNrPyEGjXdKd2DQFitZDhQY6QcdZeayh9niMnQUoFEYG54cODqJlEboafoc7Uv3+Cnq1Y+RZ7Ev6HDy6aDVqoszxFCsEMz5Dav/cR+Ig4Kn5tQUFpTeES0b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(38070700005)(6512007)(122000001)(38100700002)(2616005)(6506007)(53546011)(5660300002)(66946007)(64756008)(76116006)(66446008)(66556008)(66476007)(6916009)(54906003)(4326008)(83380400001)(86362001)(91956017)(316002)(508600001)(36756003)(71200400001)(8676002)(33656002)(8936002)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3g1MjBUQ3Y5R0N2KzRibkRUTjdqK24xb29HellLc2NZY0sxSHhWMFhTazFn?=
 =?utf-8?B?QlkwQnRYV2RrTUcwYy9xdnRxQ3hGZG4xd1FWTkpMdGtKQlIvUWRBYnhHc2xD?=
 =?utf-8?B?Y1piTnYxelg2RkdXb2FjUGtXaGY2dU1rTXREMEtkYzRNSXRCeWduQytLdFpW?=
 =?utf-8?B?NXRXOFduQVNIL0VBZHRiRDVYcDltUFJnMW9jWjNaanVGV2pKR3djMHBGazcr?=
 =?utf-8?B?SDVENDNSRmJsZ2w1UW9DTnF0cElyai9sSDR4Ulc3VWRSZ2pmZlR6cE1ncENn?=
 =?utf-8?B?TVZCOG1icTR0bTFOZmNOdXpBOGx3OTFGNUR2UlhwMDdOMGpxa3laNjR4bUdn?=
 =?utf-8?B?SEpRZzVkNWorU09wTEliWDlqVjh0c2J2czZBTEZlbWVNcElDMDlQMTROT0h1?=
 =?utf-8?B?Y1AwZVJpLzlJd3hZNHVKTG5jdFRXZithUlNBUzZyQkRKN1Q0NnYxRnNqdm15?=
 =?utf-8?B?WkhwZEx5cUZISUNpNGVKSEVjS0RYYzZvclZ5eEZqUlVPaEpMc0tZay9FYS9T?=
 =?utf-8?B?MDBTWVErd3RQR1RoYy9PVzhGR1RONHZvTmNOc0xTZFZvSnJ1OTBwNzFxQzEw?=
 =?utf-8?B?NFE1UGpRODNWTGtSSzAxZE1tend0ZTlIdjJXNmtSb1JNc1hHc0pwdnNDcUxk?=
 =?utf-8?B?QzdCUjBLTEZZMWtUR2I0ZU9MbzRXZUFhVnl3TmcxbDNMc2lvYUlTYXFiUUZy?=
 =?utf-8?B?Rk8xTG5oMDBRVURKZ1Rndk0zVlN0a243ZWFtTmg1VzR3R3BYSnR2R3FmbnRv?=
 =?utf-8?B?OXgwMnpUaXFZTE5BQkc5eW1XS2FWbGRTTy9QN0haRWoxWmtxa3dJRVIyUHhG?=
 =?utf-8?B?azAxUDVCeWhjcTlVbG5MNWw2NGxzRkJRZEJzMVkxL2o5d3FVUTJueHdTaFg4?=
 =?utf-8?B?ZFVKOTQ1dG5udXdDSjc1cSt0VDhLSnlQRkoybTNZSzJ3bUNaS2dEeFQyTXRr?=
 =?utf-8?B?R1NCaG56cmlJMHZlOEtuQWNreGlZN3hPRDBJL3dVR3ZDd3RUTHlKTmNNOFdG?=
 =?utf-8?B?Z1BHNHdqWHZ5M2kxVHhHMllnQnZLbzRNcXVoSVA2N0FCeTcvOTJsc0dZbEo1?=
 =?utf-8?B?VG4zNXU2SUtoWW1OZENxNDdhVklvTmJ0WjR3S1dLRDY4V1J0dEpXRmFDb3Bn?=
 =?utf-8?B?SWp1aVUxZjhsa1hPUHhLWFpaZkVJVndDUUJFeUxhcklDOWc1TzQ5S0pKekpO?=
 =?utf-8?B?aUdScHkrN3ZyTVpTSzNKNkNVVlI3dWhLYjZIOUpoZHB2NVd4cmlGOTJTbklJ?=
 =?utf-8?B?dVFmV0pLczNIY1ZqeDBzUXNCR3BEcUdoV1kwcjJMWThORTUrVWFkWGJrMzQ5?=
 =?utf-8?B?RDc3b0JJQndiY3JxL245d3o3NnQzTVJvUndpbHdieE41VytoTjh1VmdQc3or?=
 =?utf-8?B?ZDBGRmxGWlFIWUVlMm92MkxGN1ZSNVFVRDV5SlgrYmpJRlJoQzkzeU1yMENT?=
 =?utf-8?B?dEQ1d3YxUjFibzdKYkJvQit2UlRUaDE3L2RpdlJwU29sN2xCWUN4RXBac0lY?=
 =?utf-8?B?WDZlc3hNbUx4Y2o2S1dOTWlZeFJqVWMzbTErbWJNSldacXlpZlpMQ28yYy9T?=
 =?utf-8?B?OGU4ZVdsdWgvOFExOFpxcW9CR2tvOXM0anJrOFlQR0VtSlZjdlpKUTE2OUg1?=
 =?utf-8?B?ajB1UzZFZGNGclZINjdmWkUzYWQrMnBWTW96WHNCVUxoT29qd0xOKzNTb3Nr?=
 =?utf-8?B?WGRPbHZRemxWeXNIVitSOGR5Zm8yTzlWYWdWbVJFT0RaWWR0SElScmhNQU1k?=
 =?utf-8?B?cEhmWDNycHhNeGIrNlZNZUlWU0IyY1kwbnNvMXFDUXR6WGYwN2dPNXIyb0w2?=
 =?utf-8?B?K1VydHRMVVhCVEhXU0JaMTVvWHlFY014K1VUMVFicnZ4K2Fva2JlbTJlTkh3?=
 =?utf-8?B?UVh6TWxUYld2L3ZFWTRRTmdzdklNaXdjRUx4STIrS3V5WmVZZDhRRkNnNERH?=
 =?utf-8?B?dTc5enVKYldPSmhlNnRxdGJSeEFna3djRWdxTjBTaDZZcnpZN0FZV1FnS1M2?=
 =?utf-8?B?ZEwrQjVvZmI0VC9PSDFxUFBUSE16c01OY2svV2I1cWFBZjJjcmdHVEsyVkhH?=
 =?utf-8?B?T1ZkVkQ4QUMrbFJrK0t1ZTcyRVVwenF0WEltNkVucytGUVJKcHpOUFlULzY0?=
 =?utf-8?B?M1N6VGtwTVp6dVFIN3VKcjdTQW45YUJidEswbW9CTVJOTnRhenhnWlFBVzB3?=
 =?utf-8?B?WnB3OWV0SlM4Ymh5TUlXYUxKQ1EwSGxxcDJ2NXZ1VkhOMklJR2FNMWZmZ2k5?=
 =?utf-8?B?ME5vcWVRQXU3N2VOM1ZhTHJVM1pTNHJBRk45WnRsYW1ZV0VWU0JDbUROM21r?=
 =?utf-8?B?bW9Tdk9hWUl5aTRVb28yL090NFdoNElLTzB6NzBUR3FNNU5jRjdKUFZ0UGd4?=
 =?utf-8?Q?J1ZgHzNRSlrwE9JDLHuIKqULSfVkIxc9rERML?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7133D1BD412E140A35AD2D42FCDF9CB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a115b7c-5e6b-402b-7a9c-08da38fd04ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 18:34:18.6743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgDa9J4+hqkqekwgG4fRIc/XR7To4jKK+NN2QQ1vuGpdcZ1H+DOSw6GcGJwibgEpaFwaZ53ZvUhuX9XoD2UsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2541
X-Proofpoint-GUID: xheJV9WGQNV5Kicl-3DxPhTRb49SuGqL
X-Proofpoint-ORIG-GUID: xheJV9WGQNV5Kicl-3DxPhTRb49SuGqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE4LCAyMDIyLCBhdCAxMDowOSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFN1biwgTWF5IDE1LCAyMDIyIGF0IDEw
OjQwOjQ4UE0gLTA3MDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgbWVtc2V0IGxp
a2UgQVBJIGZvciB0ZXh0X3Bva2UuIFRoaXMgd2lsbCBiZSB1c2VkIHRvIGZpbGwgdGhlDQo+PiB1
bnVzZWQgUlggbWVtb3J5IHdpdGggaWxsZWdhbCBpbnN0cnVjdGlvbnMuDQo+IA0KPiBGV0lXLCB5
b3UncmUgZ29pbmcgdG8gdXNlIGl0IHRvIHNldCBJTlQzICgweENDKSwgdGhhdCdzIG5vdCBhbiBp
bGxlZ2FsDQo+IGluc3RydWN0aW9uLiBJTlRPICgweENFKSB3b3VsZCBiZSBhbiBpbGxlZ2FsIGlu
c3RydWN0aW9uIChpbiA2NGJpdA0KPiBtb2RlKS4NCg0KSG1t4oCmIHdlIGhhdmUgYmVlbiB1c2lu
ZyBJTlQzIGFzIGlsbGVnYWwvaW52YWxpZC9zcGVjaWFsIGluc3RydWN0aW9ucyBpbiANCnRoZSBK
SVQuIEkgZ3Vlc3MgdGhleSBhcmUgZXF1YWxseSBnb29kIGZvciB0aGlzIGpvYj8NCg0KPiANCj4g
DQo+PiArCXJldHVybiBhZGRyOw0KPj4gK30NCj4+ICsNCj4+ICsvKioNCj4+ICsgKiB0ZXh0X3Bv
a2Vfc2V0IC0gbWVtc2V0IGludG8gKGFuIHVudXNlZCBwYXJ0IG9mKSBSWCBtZW1vcnkNCj4+ICsg
KiBAYWRkcjogYWRkcmVzcyB0byBtb2RpZnkNCj4+ICsgKiBAYzogdGhlIGJ5dGUgdG8gZmlsbCB0
aGUgYXJlYSB3aXRoDQo+PiArICogQGxlbjogbGVuZ3RoIHRvIGNvcHksIGNvdWxkIGJlIG1vcmUg
dGhhbiAyeCBQQUdFX1NJWkUNCj4+ICsgKg0KPj4gKyAqIE5vdCBzYWZlIGFnYWluc3QgY29uY3Vy
cmVudCBleGVjdXRpb247IHVzZWZ1bCBmb3IgSklUcyB0byBkdW1wDQo+PiArICogbmV3IGNvZGUg
YmxvY2tzIGludG8gdW51c2VkIHJlZ2lvbnMgb2YgUlggbWVtb3J5LiBDYW4gYmUgdXNlZCBpbg0K
Pj4gKyAqIGNvbmp1bmN0aW9uIHdpdGggc3luY2hyb25pemVfcmN1X3Rhc2tzKCkgdG8gd2FpdCBm
b3IgZXhpc3RpbmcNCj4+ICsgKiBleGVjdXRpb24gdG8gcXVpZXNjZSBhZnRlciBoYXZpbmcgbWFk
ZSBzdXJlIG5vIGV4aXN0aW5nIGZ1bmN0aW9ucw0KPj4gKyAqIHBvaW50ZXJzIGFyZSBsaXZlLg0K
PiANCj4gVGhhdCBjb21tZW50IHN1ZmZlcnMgZnJvbSBjb3B5LXBhc3RhIGFuZCBuZWVkcyBhbiB1
cGRhdGUgYmVjYXVzZSBpdA0KPiBjbGVhcmx5IGlzbid0IGNvcnJlY3QuDQoNCldpbGwgZml4IGlu
IHRoZSBuZXh0IHZlcnNpb24uIA0KDQo+IA0KPj4gKyAqLw0KPiANCj4gT3RoZXIgdGhhbiB0aGF0
LCBzZWVtcyBmaW5lLg0KPiANCj4gQWNrZWQtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBl
dGVyekBpbmZyYWRlYWQub3JnPg0KDQpUaGFua3MsDQpTb25n
