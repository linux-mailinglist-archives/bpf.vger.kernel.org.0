Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1A58E34B
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiHIWft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 18:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiHIWfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 18:35:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221066127
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 15:35:31 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JQJBT029080
        for <bpf@vger.kernel.org>; Tue, 9 Aug 2022 15:35:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=S4sBa1NmOPCs2wjjTKJks589KCObVzboJCFs97/Y02E=;
 b=dnJ/aMdHULXbumAPNWiDFSoXjK1QvpaOrIU+x4LYPpClin2Fh3ctE98Eh+a9WoURcCI2
 Fopa6xl8VtayRAlNSVVX+fqKARuDiKwO5h28rs+rfZ8wwRY1ucFAUDsZ/zIcdAZIazyU
 XAzxIggatWMogyNaRzrgjc1mnUi/e0twoOE= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huwqx9cr1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 15:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJY3fZjWjlNeUCZMevZ6pDa1v52Vc/9JIVhB5X9ysDq0Q5PsDYx++7X3NGY2viPHrNRhTFoHFMgSpl1KEduXk6hPDWpJ8s2EK3vtTZejKVUnkGRJ2tWRqljpOT23NMWgBntEaZxptkYXAMSsYOrkPEA4deTOgkqLYZs9q657XRXkYzm9aacjaGh5OndsusYBs7FeGRyCIRAsfKER7YC9+9uTuF1wkQjQePukps3tbKcnS1il658FFaHC7mHtU3bsXoh5m9WneCnojuBkSxgtjscFb3xn7NN+XmCGLMnksb6SRb5Co/OPVEBVZh1uKyPZGsAKSZX5DGPpuPrDO66iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4sBa1NmOPCs2wjjTKJks589KCObVzboJCFs97/Y02E=;
 b=X2AgfMjKA5yNk+yN4MZ98sXfO8DMNaOZqeM/lNYcN3vNjti2JZQNMe1zIwO5pzCPb5y8lwTf+2XolQ6SM+TcRyFzyyAy0DxUsBg7hj+DI7jeSSzQtgTYwMTtYQ3ODaRDVjvlYsqgEf+nvdQuKaCnN2viPq2LWp2lVU8WyQOhZVzz3qEeJD21C7cPe1m/XFkRhwtr9buCOASgrZDPrr/Mmr+qpEb202PS8O14DA8DucDO1KdKG6lh/6eSwqYAq6gHwPDfErOmHcKKp1eeqETtv9C7oPlRWWzjIzj+8or0lO/za/sb3M4Rt8a7F886pOPPr4s4r2pyQlItnQ+XA0FMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BN8PR15MB2961.namprd15.prod.outlook.com (2603:10b6:408:84::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 22:35:23 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 22:35:23 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYrCnrPMK/hfinLkaNht0cHU8UHq2nIeGAgAAGagA=
Date:   Tue, 9 Aug 2022 22:35:23 +0000
Message-ID: <a667947bbd9da453017e2eb4b53b6523bdb110be.camel@fb.com>
References: <20220809195429.1043220-1-kuifeng@fb.com>
         <20220809195429.1043220-2-kuifeng@fb.com>
         <CAADnVQLjHpfFQDn_1mXj7+o6E8Dsmatr0jeozPAk5rV8hcLWfg@mail.gmail.com>
In-Reply-To: <CAADnVQLjHpfFQDn_1mXj7+o6E8Dsmatr0jeozPAk5rV8hcLWfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd8bdbe-4e97-4d7e-1fd8-08da7a5772b9
x-ms-traffictypediagnostic: BN8PR15MB2961:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTxlLBuWaSbHV2t2j1bgNL70v5huiHbqh+LfD8Rbjq/WwP7mpysHx7Lqx8kDf9J3XsO5EESFfKveAymO2DtejIGW4jcGaciGII2brj4dfBZr906w80rPKHAvjUpIcsFlHi3QPFslIp25CHSYf+w/Gyk92fIlsmiThhAfDEPtti8NSyR7G8/QbBEtzlOKO36U9jBxChgpsFjFm3z9b9uC41nw+CDzlyc3B/gQRQ804zh5B8+rodXICKUhA0pbc4fLVxF/U/RBr6UA2o8rln85xNMqd2945GSl6zkJaUE/9sj18bmSpONEtt/18NyRhmyqEOHD5rdzS9a2tsXN39msUjTYB9yW477mv3Kj/iJ+DFQ4IcAxzpGJSMupIvbsWO1Dbwb4zOxo6woG755cd8kSoFqbx4oB0Q00K3IMSspLP/ae4Tv+xDU45NJUHuBiSRBgkJFV5ig+dWAf92QTxinPJCFbtzJkGdXCgllfPbXTzKI4uH3VUKU+GInCs+jXW21XbinSiA8kl2aNQwe0qo1W3m0DwbtWq+25D9lP/xSG3fRkCgTMtifVvaKpjm4oQDZMtelzSxrsynd31QfW83mYXABu/T3qzFUVgOuXEqhkSfpYrcsB3b5PqeXNJhCyauvUNI85z4JXPZQBAL5CYdhz+N3WJzOJDVUEbsgwvCexZXp4Yc6/1pIBo6IdfdpOaMgtHDrqTxseZTke2hSU+6aMjecV+q3+NvzHEByuLn7kWkCbogTLgl4NYX5bUTYzYKJYO9+ammrawb1wwfcF5rDVJ1d94tPX36R7VXAbTyb33n+JFizxporbRkx/t4eSqAjo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(5660300002)(2906002)(76116006)(66446008)(66556008)(478600001)(4326008)(66946007)(54906003)(6916009)(66476007)(316002)(64756008)(71200400001)(6486002)(8676002)(6506007)(122000001)(53546011)(38070700005)(36756003)(41300700001)(6512007)(186003)(86362001)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFRiTE5iMGhjZllsWXFmTDFINC94dDJoUEJvSHdOTW96NjZJRlBXSENHTzdK?=
 =?utf-8?B?RURsM1lXSjVGazQzM3QyUDdETHhDaEdWelFISktWVGhRVS9CRGFhdWkxekdH?=
 =?utf-8?B?eDhISTR5MUViTk1aWWxUc3o4eDdJU21WSG5vSSt4cURLOUJ6VUxUZnFsWnZC?=
 =?utf-8?B?K2svbzZTK0VoQWVPc2ZQMXFRRDVxaUgxTFlsQWtJemFQQm1UNzFJMjdnejAz?=
 =?utf-8?B?S1oxQWNJcU1KcGFJdEcxd2tGU0xwejF1SE13RWt3ZXVya1NERGI0QXdZTG8x?=
 =?utf-8?B?TXlhdUdmRk1pdjV2aFZDZEFFaUIrZGU5SDU5TnNreTRjc2IwVnd6TnJQUXJp?=
 =?utf-8?B?aXFNcm9obkNvbmErbXp4TDNyVUYzcG9NbEwxQ3hKOGJWUlJQeWRJRStPbU5H?=
 =?utf-8?B?b3E2c0pjdnZKR3VtMTJhUTFGbGpETkllYmJnMUFabEtTTnlITmRRcHVZcFFP?=
 =?utf-8?B?ZzVJaVo0RndINFdqbU42Z3loWTU3QWxHZEpCcmRRa25pdnFiWDYzZ0twVGkr?=
 =?utf-8?B?Sk9LN1l6QjNPamU1WlJ6Z1k1NC9DYlJzd1RDaFFEdTZaZVVyd1Z0djhla0lt?=
 =?utf-8?B?T1V6UmpmTkdkSVpwdXNTRjcrWmNtMGZjOW9JTmx3OGJIb1hEck00VlJlYTZ1?=
 =?utf-8?B?M20xZkRIQ21yaXdFeUVmQ1BycE52SG5VMUFWd3VnYmVwcFhlVERPaWR0clpN?=
 =?utf-8?B?NmdQQVlEcGVwY1BEdWZYMGk1SlVubTgvRHhvYVZQWUlVWHAvMjhlMkE4eklM?=
 =?utf-8?B?d1pTSThJUHJ4d0hDWU1mbG85aGtPMUZ1MXBzZkxMc2JRVGt1RytEOXdJQkhw?=
 =?utf-8?B?NVdXTThXU0t4dlJQSDRTN3FiRDVMUG1xaVFHL3M5dEtaYTBuM09TMWZUajVh?=
 =?utf-8?B?b0FMZTR2WEVvdUJJbWZicUVPNzFraTJJVVZGaHAzS001dzBYbVFKQi9xQXpa?=
 =?utf-8?B?R1gvYnU2aXpJUDZDbVhKa3FLT1JtOTR6b1RzR2t3TkI4Zk9USURXVmgvVlJD?=
 =?utf-8?B?S0FmTytId25UYURUSHYrRStJRUd2dGhSWlUwSFFTTWNEaDhERHBPK2lSZFNj?=
 =?utf-8?B?ZFI0NlJoZjc1NWJ1cUgrVy81OGpYWmFjeGE2MGh1allRZkw4d2RTKytFNkIr?=
 =?utf-8?B?TjdvUjFVUTJMOEZBZkhOZWNpNmZtdVFIczg0MVlSbkZmYkFWSm1mb3pLSjFq?=
 =?utf-8?B?ME1OTXkzVS9rZkNMTjRRMzdjT3dGVzZGOHRGbUE0aDM1aldtR1cxQmR6ZFg0?=
 =?utf-8?B?QXRBL3ZFc1hJN3hrdUNleTRJd3JUZHRhR3krYWFrSmJzUUJJcWhkT3pteE9l?=
 =?utf-8?B?aWsxNkV6Nk9iTENnTmkzbmI2ZGpUSjVJMy9PZDNaR2UyclgxYThkVTJGQUY4?=
 =?utf-8?B?elJTYXpBMHhvRHBnd3JOaGNXeHRLY2R2aW41M2hRcmhSVlFjUW5qMTZmcnAz?=
 =?utf-8?B?V2t6N3VGNWVJMWRTcU5wL0MyaGNrN2d0TjBvVi9JcTlZYkJkVVNGT1NnYlk3?=
 =?utf-8?B?bVVBR0tWZm15dVBsTVYwdzdrZ2F2UEFxSWJ6UTRpUmZxNlN4Z2lrMTFCSnJJ?=
 =?utf-8?B?OTBTcjZFbkMzQ2YxL0dMamxzWkFJTXZGM1NTbkhuaEk0NStaV1VSZTE0T1Vi?=
 =?utf-8?B?VTlXcnhCajMzakV1MkRQL0dLdTN2NlpmTXpiRitsVzZwM2RrTVhuZFBWSGRF?=
 =?utf-8?B?MW5xWTdnS2dhRGlNT1ZBMlN0eHF2ZDFLYnRTZlZWc2JhSUovSDdLR1VmUi9S?=
 =?utf-8?B?dy9UV2N2T3RqbDI5eW5wdVBxK2hCTEE4S0hQcGdjMXh1VEFmMlVnaHJUeDNH?=
 =?utf-8?B?WHBLVG1sRmZFZ1A2cUp4YTdEL2xSSUlIWVRNWmtpd0JKY1NHTWlCekRxTXd1?=
 =?utf-8?B?Y01UeEFlUWRrWHkra2pKanB4dTV4UklFYXJSUmV5cW9iSm00N2MwQUZsUnNs?=
 =?utf-8?B?NGk0clBnZ3FBcWxwNzRtT2xWQTZPMGpTdXBBSW1TNXZnUmQ5VDhRcEFjSDlr?=
 =?utf-8?B?SVdhSFJ5eU1abmo2ZHRBeXJ5YVdyNVlLUjl0ZWNGNkhvTnZEOFo5N3ByNkZn?=
 =?utf-8?B?eUhmKzRhdnZObmpyVVdadFZjQzV1amVZQWYyeEFwcTN0eWtsUm10NTdVRTJq?=
 =?utf-8?B?OW5SQ0tocFJEbmx6SEJZNFZ6cUxpa0RLZ2FWVVhtZDd1U1g4OHpZb2YwazFT?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D65B0B9BB45844AAF3860A9E2D7D76@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd8bdbe-4e97-4d7e-1fd8-08da7a5772b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 22:35:23.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJ3I47V/HXMVjbvxLcGVFlhNTEgfUrOUMhj0QhWAv8aYExEE4zDrmcqGzhhkGclr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2961
X-Proofpoint-GUID: Nkc7nNYi5r0ENdM-0DDKn0RjF6q8zwNO
X-Proofpoint-ORIG-GUID: Nkc7nNYi5r0ENdM-0DDKn0RjF6q8zwNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTA5IGF0IDE1OjEyIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gVHVlLCBBdWcgOSwgMjAyMiBhdCAxMjo1NCBQTSBLdWktRmVuZyBMZWUgPGt1aWZl
bmdAZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhh
dCBsb29wcyB0aHJvdWdoIHJlc291cmNlcyBvZiBvbmUKPiA+IHRhc2svdGhyZWFkLgo+ID4gCj4g
PiBQZW9wbGUgY291bGQgb25seSBjcmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwg
cmVzb3VyY2VzIG9mCj4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZl
biB0aG91Z2ggdGhleSB3ZXJlCj4gPiBpbnRlcmVzdGVkCj4gPiBpbiBvbmx5IHRoZSByZXNvdXJj
ZXMgb2YgYSBzcGVjaWZpYyB0YXNrIG9yIHByb2Nlc3MuwqAgUGFzc2luZyB0aGUKPiA+IGFkZGl0
aW9uYWwgcGFyYW1ldGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9yIHRvIGdv
Cj4gPiB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFz
ay4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4K
PiA+IC0tLQo+ID4gwqBpbmNsdWRlL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCA4ICsrCj4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8wqAg
MzYgKysrKysrKysrCj4gPiDCoGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKg
IHwgMTM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gPiAtLS0tCj4gPiDCoHRvb2xz
L2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8wqAgMzYgKysrKysrKysrCj4gPiDCoDQgZmlsZXMg
Y2hhbmdlZCwgMTkwIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBiL2luY2x1ZGUvbGludXgvYnBmLmgKPiA+IGlu
ZGV4IDExOTUwMDI5Mjg0Zi4uYmVmODEzMjRlNWYxIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9icGYuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYuaAo+ID4gQEAgLTE3MTgsNiAr
MTcxOCwxNCBAQCBpbnQgYnBmX29ial9nZXRfdXNlcihjb25zdCBjaGFyIF9fdXNlcgo+ID4gKnBh
dGhuYW1lLCBpbnQgZmxhZ3MpOwo+ID4gCj4gPiDCoHN0cnVjdCBicGZfaXRlcl9hdXhfaW5mbyB7
Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX21hcCAqbWFwOwo+ID4gK8KgwqDCoMKgwqDC
oCBzdHJ1Y3Qgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBicGZfaXRl
cl90YXNrX3R5cGUgdHlwZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuaW9u
IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIg
dGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUz
MiB0Z2lkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHUzMiBwaWRfZmQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gK8Kg
wqDCoMKgwqDCoCB9IHRhc2s7Cj4gPiDCoH07Cj4gPiAKPiA+IMKgdHlwZWRlZiBpbnQgKCpicGZf
aXRlcl9hdHRhY2hfdGFyZ2V0X3QpKHN0cnVjdCBicGZfcHJvZyAqcHJvZywKPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgK
PiA+IGluZGV4IGZmY2JmNzlhNTU2Yi4uM2QwYjllMzQwODlmIDEwMDY0NAo+ID4gLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgK
PiA+IEBAIC04NywxMCArODcsNDYgQEAgc3RydWN0IGJwZl9jZ3JvdXBfc3RvcmFnZV9rZXkgewo+
ID4gwqDCoMKgwqDCoMKgwqAgX191MzLCoMKgIGF0dGFjaF90eXBlO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogcHJvZ3JhbSBhdHRhY2ggdHlwZQo+ID4gKGVudW0gYnBmX2F0dGFjaF90eXBlKSAq
Lwo+ID4gwqB9Owo+ID4gCj4gPiArLyoKPiA+ICsgKiBUaGUgdGFzayB0eXBlIG9mIGl0ZXJhdG9y
cy4KPiA+ICsgKgo+ID4gKyAqIEZvciBCUEYgdGFzayBpdGVyYXRvcnMsIHRoZXkgY2FuIGJlIHBh
cmFtZXRlcml6ZWQgd2l0aCB2YXJpb3VzCj4gPiArICogcGFyYW1ldGVycyB0byB2aXNpdCBvbmx5
IHNvbWUgb2YgdGFza3MuCj4gPiArICoKPiA+ICsgKiBCUEZfVEFTS19JVEVSX0FMTCAoZGVmYXVs
dCkKPiA+ICsgKsKgwqDCoMKgIEl0ZXJhdGUgb3ZlciByZXNvdXJjZXMgb2YgZXZlcnkgdGFzay4K
PiA+ICsgKgo+ID4gKyAqIEJQRl9UQVNLX0lURVJfVElECj4gPiArICrCoMKgwqDCoCBJdGVyYXRl
IG92ZXIgcmVzb3VyY2VzIG9mIGEgdGFzay90aWQuCj4gPiArICoKPiA+ICsgKiBCUEZfVEFTS19J
VEVSX1RHSUQKPiA+ICsgKsKgwqDCoMKgIEl0ZXJhdGUgb3ZlciByZW9zdXJjZXMgb2YgZXZldnJ5
IHRhc2sgb2YgYSBwcm9jZXNzIC8gdGFzawo+ID4gZ3JvdXAuCj4gPiArICoKPiA+ICsgKiBCUEZf
VEFTS19JVEVSX1BJREZECj4gPiArICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVzb3VyY2VzIG9m
IGV2ZXJ5IHRhc2sgb2YgYSBwcm9jZXNzIC90YXNrCj4gPiBncm91cCBzcGVjaWZpZWQgYnkgYSBw
aWRmZC4KPiA+ICsgKi8KPiA+ICtlbnVtIGJwZl9pdGVyX3Rhc2tfdHlwZSB7Cj4gPiArwqDCoMKg
wqDCoMKgIEJQRl9UQVNLX0lURVJfQUxMID0gMCwKPiA+ICvCoMKgwqDCoMKgwqAgQlBGX1RBU0tf
SVRFUl9USUQsCj4gPiArwqDCoMKgwqDCoMKgIEJQRl9UQVNLX0lURVJfVEdJRCwKPiA+ICvCoMKg
wqDCoMKgwqAgQlBGX1RBU0tfSVRFUl9QSURGRCwKPiA+ICt9Owo+ID4gKwo+ID4gwqB1bmlvbiBi
cGZfaXRlcl9saW5rX2luZm8gewo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMsKgwqAgbWFwX2ZkOwo+ID4gwqDCoMKgwqDC
oMKgwqAgfSBtYXA7Cj4gPiArwqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBQ
YXJhbWV0ZXJzIG9mIHRhc2sgaXRlcmF0b3JzLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
bnVtIGJwZl9pdGVyX3Rhc2tfdHlwZSB0eXBlOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdW5pb24gewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9fdTMyIHRpZDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX3UzMiB0Z2lkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF9fdTMyIHBpZF9mZDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH07Cj4gCj4gU29ycnkgSSdtIGxhdGUgdG8gdGhpcyBkaXNjdXNzaW9uLCBidXQKPiB3
aXRoIGVudW0gYW5kIHdpdGggdW5pb24gd2Uga2luZGEgdGVsbAo+IHRoZSBrZXJuZWwgdGhlIHNh
bWUgaW5mb3JtYXRpb24gdHdpY2UuCj4gSGVyZSBpcyBob3cgdGhlIHNlbGZ0ZXN0IGxvb2tzOgo+
ICvCoMKgwqDCoMKgwqAgbGluZm8udGFzay50aWQgPSBnZXRwaWQoKTsKPiArwqDCoMKgwqDCoMKg
IGxpbmZvLnRhc2sudHlwZSA9IEJQRl9UQVNLX0lURVJfVElEOwo+IAo+IGZpcnN0IGxpbmUgLT4g
dXNlIHRpZC4KPiBzZWNvbmQgbGluZSAtPiB5ZWFoLiBJIHJlYWxseSBtZWFudCB0aGUgdGlkLgo+
IAo+IEluc3RlYWQgb2YgdW5pb24gYW5kIHR5cGUgY2FuIHdlIGRvOgo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fdTMyIHRpZDsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMiB0Z2lkOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fdTMyIHBpZF9mZDsK
PiAKPiBhcyAzIHNlcGFyYXRlIGZpZWxkcz8KPiBUaGUga2VybmVsIHdvdWxkIGhhdmUgdG8gY2hl
Y2sgdGhhdCBvbmx5IG9uZQo+IG9mIHRoZW0gaXMgc2V0Lgo+IAo+IEkgY291bGQgaGF2ZSBtaXNz
ZWQgYW4gZWFybGllciBkaXNjdXNzaW9uIG9uIHRoaXMgc3Viai4KCldlIG1heSBoYXZlIG90aGVy
IHBhcmFtZXRlciB0eXBlcyBsYXRlciwgZm9yIGV4YW1wbGUsIGNncm91cHMuClVuZm9ydHVuYXRl
bHksIHdlIGRvbid0IGhhdmUgdGFnZ2VkIGVudW0gb3IgdGFnZ2VkIHVuaW9uLCBsaWtlIHdoYXQK
UnVzdCBvciBIYXNrZWxsIGhhcywgaW4gQy4gIEEgc2VwYXJhdGVkICd0eXBlJyBmaWVsZCB3b3Vs
ZCBiZSBlYXNpZXIKYW5kIGNsZWFyIHRvIGRpc3Rpbmd1aXNoIHRoZW0uICBXaXRoIDMgc2VwYXJh
dGVkIGZpZWxkcywgcGVvcGxlIG1heQp3b25kZXIgaWYgdGhleSBjYW4gYmUgc2V0IHRoZW0gYWxs
LCBvciBqdXN0IG9uZSBvZiB0aGVtLCBpbiBteSBvcGluaW9uLgpXaXRoIGFuIHVuaW9uLCBwZW9w
bGUgc2hvdWxkIGtub3cgb25seSBvbmUgb2YgdGhlbSBzaG91bGQgYmUgc2V0LgoK
