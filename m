Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3D6271AC
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 19:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKMSgi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 13:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiKMSgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 13:36:37 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90078.outbound.protection.outlook.com [40.107.9.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ED10049
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 10:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2XTZ7bCvIYbPMNbpE9xcYwDBobaMHU7DwM0UleLOwd/vLy2cHykFMwda0CIX2k+cQM0OeT5VoiW92KgUE9WSVI6djXjmgHzCyg7CcnHi1RlcylpRb2e8/Kx025l3s6Nnb5I/oAsKGc4A5X1WrdJIpvb7cwsNbMiRzEcQJ6Pqb7aaR9VjDSJXBNHQWLXGhYWPTh4Wxa0K1qHGrmArkLij+5Zt/oMBpyqYynmHOduRFRjqm3Q52Benugg9waQ1qew7UWy22NBKb7jjMi7KXzeesJDZ5c2RL6WxsHK7YN4VFptzqeyEfp3iBBqfhMccVHJo+AnArlqWVbWRdIgAtrE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjUTINS0pTKxowFtR9cxUflbMqEH6fACYXRE8wIld1Y=;
 b=F2HZZYbw5H9uQKgT30PzVZlmiGlEtN2pXNZOBO+OGP9TINQaeiNNW6NNzF2qxWhp1EXx0ogMHn8at/MP/6E26RS2gBbK74OXfOg5ATBRidtnArxWOUJHQr86j0x8FD1809utZWAxMfx7/MW5E6g5WwKn/AjaJTLWq9uenoqiyrR7+i3G8umB3wUdwyee6EAj+gFbJiaZIopKa4QPpu8vYMc3oTaXe3Jdxdd7s+2/C9TKdAc8uJrV2yAfmIrT4wcPtuMOy0P04Lhj19gkgjJd777gbqPX885RZLurwdGa1fVETa71xkjta2mjVxnMvx1Cf7HBWi2pPR6CIqMDU0E+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjUTINS0pTKxowFtR9cxUflbMqEH6fACYXRE8wIld1Y=;
 b=UDfry8Xi5kaRENdjgj/snrbCpnjdrawPbOKBISHizrOnb9APUz5LiR8oiZlCzSWt6+tZ0JEAMBMc9daDJ3sb3fwBJUnWX6BxUj8BAINDz9BW+xK+XL47qVBUErQeubElRSYM9DjCK6c6VbLBSu5ey2DzQRKy74L8c3mJyXhbrXtRbk7036EGRsDr9Keej+m4lOZZolMYt1qRbnAmbgCKZCi6JBNZovmtWmtEpT+tozZqZPlPmPnGqHho3b8+p6tRN96BpC7OsrsUGcqswqzrzWezekqnM16m6iuFp8t8xhLYEygV6Q95Bvq5tmul5yOxavtEZ5+MrjS8l9uJL8EmYg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1576.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 18:36:31 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 18:36:31 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] powerpc/bpf: use
 bpf_jit_binary_pack_[alloc|finalize|free]
Thread-Topic: [RFC PATCH 3/3] powerpc/bpf: use
 bpf_jit_binary_pack_[alloc|finalize|free]
Thread-Index: AQHY9TThrRs76G/rC06VCEjhPflhMa49M0iA
Date:   Sun, 13 Nov 2022 18:36:31 +0000
Message-ID: <5974ae19-daa2-8079-4a89-990b288d1be9@csgroup.eu>
References: <20221110184303.393179-1-hbathini@linux.ibm.com>
 <20221110184303.393179-4-hbathini@linux.ibm.com>
In-Reply-To: <20221110184303.393179-4-hbathini@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1576:EE_
x-ms-office365-filtering-correlation-id: 8c3d4baa-30c6-4ef0-99c6-08dac5a5fc2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iF38NvLGdE1qJCDRJz4+Jm3EQgg8z2XNeXtS7IUVCET/kCwtvzIdRNs1vubZL0dIN08PhJ/pi5yIA8JTTMcEe+60d6zZN1QxUZHMOIFp4sa0SgP9c92z4k72dtX63FsRJ+u6viZQadHJKWzjBccwL6qSYJjTJ93O8vmc2qO3j/e0a0aGZ21B3mjg52wPY6SqTY/Pm2fN57GFkahFSVAHprnT0H7TYijYmoH0Q5TUWHoSNnFPlrYQPa5nuPV7acZVi6de3GrecYAZf+Gar14XehG5UcrTyVfhlNZD6G2nPaSEvEyUu3bjGHghEZ7wYPC7fOyR56Cnu4QBuoPL922LuuSYtXENyvpMe9ZXkdIxaBO+r8yRL3tA4lsxU0Y9XAzQoNS7yG93oK6gueUielemi2DoSSpTtjxVHPOXrI6tPwNjuVqH4Ax9wPKapjtyEVcF4DHHZKwsaxOIR4iedOv3yQHiCC+dCMoaiKfhDNY4qth+q+jFR6jKyN649pivPut1m0UCee7UN9XVAk80vI7bIr2f2mn5ZRRJJ0YVY1P4vvd+yEpqFgN+1748AM4zGo1H6uLvyPEg22DYsYmX2X9SWVxn+mmEFer6+ciexjCd3BX+R9OAsOfdGEPVDoQuNR5o6mpF9YLkhJUjOuuTpeupCJP+hZp58LOgG0gYKFA5QaqxUvNdafVAms/sCbAnQhHRhZmhZA6XHYhl3P97A+K+d0hpteKoT1Wwj13h5BQIyW7U3I1EzeTKPznE865ra2fVE53pIzrnuJyCA83gxVrWCi2s613VCHcf6+/eiW3wjERDXcoFcJppu14UJ8TAjMEZQyUrgfQ+GaZJCYw0htQ+qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39840400004)(346002)(376002)(396003)(451199015)(44832011)(31686004)(2906002)(76116006)(91956017)(66946007)(66476007)(66556008)(8936002)(5660300002)(64756008)(4326008)(66446008)(41300700001)(8676002)(478600001)(6506007)(6486002)(71200400001)(36756003)(2616005)(83380400001)(6512007)(26005)(66574015)(54906003)(110136005)(186003)(316002)(122000001)(38100700002)(38070700005)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xqZjNkZExWNkxlY05SOFpqdXlYNTZLd1dKZk1hQWZQZnFLcTJrR2hqbmZT?=
 =?utf-8?B?blBNSWhNL1RVbGtIWC9SM1pzQXdXTmpMSjQ4Ly83RWR3MDlkcm0rUElUSFRr?=
 =?utf-8?B?QldTZUJOay81ZDJZdXgxMEZWOTZjOVc3aVd1ZGZEUzBJTzl6ZFJpUFUrVUJH?=
 =?utf-8?B?bFFsU0Vjc0E2MytNMkpaV0FITjlzbzM4OWR2ZlFYMGxHUjRrSGsrNWE4UDZB?=
 =?utf-8?B?UDZYTXpkNmE4N0lJTHFOMXNka0NveU93dWF0VExodEUxYkRNeS9Kd0p5Wm8y?=
 =?utf-8?B?anRvMG8zNlhyWUYyY1htazhSUHZtOCtLYWUwbTVaOGhWREM0NXdyMTVkN1VT?=
 =?utf-8?B?c0ViaEdrYlFwekM4S3VycEZNRTY1VXdsS1VoUnJsSjh0M1V4ZVRaQ3dDMVVQ?=
 =?utf-8?B?UTlSVVp2TUpDZkIxcEE2VHNnRFYwcDlFTDRlNTNjczFxN0tqQm4zYnFyZHN2?=
 =?utf-8?B?WjR6UFIzV0c4bUtIOHZoZzlaSnVHYU9jeDBQS1pGTkR6bmdyQ0NuNlpFU29z?=
 =?utf-8?B?bjc3Q0hadlBPTVF6QmdHenBMVGZucExrdUZQL21kVndjY2QvTTBQKzhIV3FG?=
 =?utf-8?B?NEN4eUdHaFBUQ2NnSDRaNzNRL2RXMVVZb2hJSWdxZE00dGhsYVpkSmNEZHFO?=
 =?utf-8?B?bXduS2N0eWZiNlNSRHN6ckpiaFRkemtZQVNqWitTcjdOVWpvNHFFVjhpYmtR?=
 =?utf-8?B?R013UW9FL09wcTBnSHF3ZVJwNU1YTHZyeEIxUUVKUFY1NTFrd1FHMlpqRTZG?=
 =?utf-8?B?ZXlIbFpMZDE0S2F2MGpWbEhsY1l5N1o2ZE4xQXI1bDZSbUZUS0JJWkFZTGta?=
 =?utf-8?B?NzVIK0tpYnpDeFllRFF1WS9ka3lwdk11YTAyUGpKKzRjWnptUWFDTWF5RC9i?=
 =?utf-8?B?LzdLMjdZeXRPUkN5dXVFZU80dmhYelNKQlcrS3BkS1hGRUF2RWcxdTg5WG1Q?=
 =?utf-8?B?TXZwQWJwTS8rZEtoQVkwK3BwUnN0dXVNNDFwM0FWVUR3UUJTYnFJY1B2bVJY?=
 =?utf-8?B?K01QTnpoUDltS2RrQlEra0hZMU5YWno5RXFDWGpVOXZSa1B0UGQwcUo3TW1Y?=
 =?utf-8?B?cFI0RU5VbHF2Q3Z0bGd2RTNydDBiRUp4NzNhaWhJR3VLVkNYQ2xCei85b3RE?=
 =?utf-8?B?WXhMTHBwbHRpRnhyVGdESzJ3SGN2dGhKdENSTGxDRW1PMTZMWEJzMEk2SnJa?=
 =?utf-8?B?Ui84b0s3SXV1VU95VmE5R0Z4T2NyWGJYcE9oN3E1UERGTzNLT0wwRG1kQkNh?=
 =?utf-8?B?blEzcUJ5ZXBxN25kd1dmWkwyYTV2RWtzT254WEdPSTFONzRYc3NTUnZWOGlT?=
 =?utf-8?B?TlhkKy9iTkJGUEN4amJZVWtXNDFIV0hlYzYvQ1BqUFoyTlkvU3VmaVNXQ3d5?=
 =?utf-8?B?WjFVL1VZcmIydzVGS0xlQnIrdWtzRlpkN3JZVmgzbEZqWmFZbWJ1bzhMbTZR?=
 =?utf-8?B?UFVGLytBSlNMUWRoVmY2VmxZVUZ3ZGR0VWpmbjA0QTZ3S3FKY3N5eTN2YmpL?=
 =?utf-8?B?VG1FRENiSVRKTUc5TVpiOHA3YW40eUxZcm5CMzE4T3dYalY5RDBmZXAvelR3?=
 =?utf-8?B?bWtPV0daMGVUL25BVnNMbEtSZDU4OHhsa3RzN0tlL0FqQnJaM0hFTWtmMC9a?=
 =?utf-8?B?ZlFvMG5nOVJ0S2UwV1RTRm5IUFk5Q2ZxTk83RmorMFRDWVBIVC8rd0EySmdv?=
 =?utf-8?B?cFdIcHFRNWRNK2RLZjRhbmZZV1FpRHh5aU02M2Uzc0o5VU1qOVEvV051a0ND?=
 =?utf-8?B?TWR3TW04cXB6MEFWSWhSUW9DUUxMTFN1WkJBb0FaeWtHYWIwVlh4YVBkOUIz?=
 =?utf-8?B?dkRmKzlRcEt0ZVJyemRkR0RSWW1vbTN4MHZnSlhnQXp2d3UzVm80Z3JCbWth?=
 =?utf-8?B?VmM4L1JxUlBOa2hlV2JQVzV5WUg4VDFadDhQV2ppM0JPNVZFN1ZsaHJnTDQw?=
 =?utf-8?B?VjJkS2tkSUw0dmFyYkZTTmk5WnAybEFlRUozZzlxcERhMGRxSXdqeHI1WVBS?=
 =?utf-8?B?aWFFU25wdGlRRWtudTkzZWd3eG5iOUk5eWJZM05zNytrNGJGVzBJM0ZIdHZ2?=
 =?utf-8?B?N2xrNnk5NUlIRVJvTGwyOHJ4Z3UrTlQ4bGJPZEVrNFlwTy8ybnJNT1FUdThn?=
 =?utf-8?B?elJlUjJGMmJiYm9qWDJwY1lndHNacFViYnlDSldrSzRGY2sxV1JDNWp2T0xE?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B83B04C95DC4544F9F371F4C0B94CE7A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3d4baa-30c6-4ef0-99c6-08dac5a5fc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 18:36:31.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNNwGUQiw5CNihsV42T9awAJxNObo//uM9SMxJvpGgc0OOSd5qYH/DeMgQriud82O7+I9u48qc0XmdgXegC+v0YK0X9yf9aTHhz7i59JnMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1576
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

TGUgMTAvMTEvMjAyMiDDoCAxOTo0MywgSGFyaSBCYXRoaW5pIGEgw6ljcml0wqA6DQo+IFVzZSBi
cGZfaml0X2JpbmFyeV9wYWNrX2FsbG9jIGluIHBvd2VycGMgaml0LiBUaGUgaml0IGVuZ2luZSBm
aXJzdA0KPiB3cml0ZXMgdGhlIHByb2dyYW0gdG8gdGhlIHJ3IGJ1ZmZlci4gV2hlbiB0aGUgaml0
IGlzIGRvbmUsIHRoZSBwcm9ncmFtDQo+IGlzIGNvcGllZCB0byB0aGUgZmluYWwgbG9jYXRpb24g
d2l0aCBicGZfaml0X2JpbmFyeV9wYWNrX2ZpbmFsaXplLg0KPiBXaXRoIG11bHRpcGxlIGppdF9z
dWJwcm9ncywgYnBmX2ppdF9mcmVlIGlzIGNhbGxlZCBvbiBzb21lIHN1YnByb2dyYW1zDQo+IHRo
YXQgaGF2ZW4ndCBnb3QgYnBmX2ppdF9iaW5hcnlfcGFja19maW5hbGl6ZSgpIHlldC4gSW1wbGVt
ZW50IGN1c3RvbQ0KPiBicGZfaml0X2ZyZWUoKSBsaWtlIGluIGNvbW1pdCAxZDVmODJkOWRkNDcg
KCJicGYsIHg4NjogZml4IGZyZWVpbmcgb2YNCj4gbm90LWZpbmFsaXplZCBicGZfcHJvZ19wYWNr
IikgdG8gY2FsbCBicGZfaml0X2JpbmFyeV9wYWNrX2ZpbmFsaXplKCksDQo+IGlmIG5lY2Vzc2Fy
eS4gV2hpbGUgaGVyZSwgY29ycmVjdCB0aGUgbWlzbm9tZXIgcG93ZXJwYzY0X2ppdF9kYXRhIHRv
DQo+IHBvd2VycGNfaml0X2RhdGEgYXMgaXQgaXMgbWVhbnQgZm9yIGJvdGggcHBjMzIgYW5kIHBw
YzY0Lg0KDQpUaGlzIHBhdGNoIGxvb2tzIGhlYXZ5IGNvbXBhcmVkIHRvIHg4NiBjb21taXQgMTAy
MmE1NDk4ZjZmLg0KDQpJIGRpZG4ndCBsb29rIGludG8gZGV0YWlscywgaXMgdGhlcmUgcmVhbGx5
IGEgbmVlZCB0byBjYXJyeSB0aGF0IA0KcndfaW1hZ2Ugb3ZlciBhbGwgZnVuY3Rpb25zIHlvdSBj
aGFuZ2VkID8NCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgb2sgeW91IG5lZWQgaXQgZm9yIEVNSVQg
bWFjcm8uIEJ1dCB0aGVuIHNvbWUgb2YgdGhlIA0KZnVuY3Rpb24gdGhhdCB1c2UgRU1JVCB3aWxs
IG5vdyB1c2UgcndfaW1hZ2UgaW5zdGVhZCBvZiBpbWFnZSwgc28gd2h5IGRvIA0KdGhleSBuZWVk
IGJvdGggaW1hZ2UgYW5kIHJ3X2ltYWdlID8NCg0KTWF5YmUgeW91J2QgaGF2ZSBsZXNzIGNodXJu
IGlmIHlvdSBsZWF2ZSBpbWFnZSwgYW5kIGFkZCBhIHJvX2ltYWdlIA0Kd2hlcmV2ZXIgbmVjZXNz
YXJ5IGJ1dCBub3QgZXZlcnl3aGVyZS4NCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYXJpIEJh
dGhpbmkgPGhiYXRoaW5pQGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9u
ZXQvYnBmX2ppdC5oICAgICAgICB8ICAxOCArKystLQ0KPiAgIGFyY2gvcG93ZXJwYy9uZXQvYnBm
X2ppdF9jb21wLmMgICB8IDEyMyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gICBh
cmNoL3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcDMyLmMgfCAgMjYgKysrLS0tLQ0KPiAgIGFyY2gv
cG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wNjQuYyB8ICAzMiArKysrLS0tLQ0KPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKyksIDcxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wLmMgYi9hcmNoL3Bvd2VycGMvbmV0
L2JwZl9qaXRfY29tcC5jDQo+IGluZGV4IGY5MjU3NTVjZDI0OS4uYzRjMWY3YTIxZDg5IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcC5jDQo+ICsrKyBiL2FyY2gv
cG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wLmMNCj4gQEAgLTE4MSwyMiArMTgzLDI1IEBAIGJvb2wg
YnBmX2ppdF9uZWVkc196ZXh0KHZvaWQpDQo+ICAgDQo+ICAgc3RydWN0IGJwZl9wcm9nICpicGZf
aW50X2ppdF9jb21waWxlKHN0cnVjdCBicGZfcHJvZyAqZnApDQo+ICAgew0KPiAtCXUzMiBwcm9n
bGVuOw0KPiAtCXUzMiBhbGxvY2xlbjsNCj4gLQl1OCAqaW1hZ2UgPSBOVUxMOw0KPiAtCXUzMiAq
Y29kZV9iYXNlOw0KPiAtCXUzMiAqYWRkcnM7DQo+IC0Jc3RydWN0IHBvd2VycGM2NF9qaXRfZGF0
YSAqaml0X2RhdGE7DQo+IC0Jc3RydWN0IGNvZGVnZW5fY29udGV4dCBjZ2N0eDsNCj4gLQlpbnQg
cGFzczsNCj4gLQlpbnQgZmxlbjsNCj4gKwlzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKnJ3X2hl
YWRlciA9IE5VTEw7DQo+ICsJc3RydWN0IHBvd2VycGNfaml0X2RhdGEgKmppdF9kYXRhOw0KPiAg
IAlzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKmJwZl9oZHI7DQo+ICsJc3RydWN0IGNvZGVnZW5f
Y29udGV4dCBjZ2N0eDsNCj4gICAJc3RydWN0IGJwZl9wcm9nICpvcmdfZnAgPSBmcDsNCj4gICAJ
c3RydWN0IGJwZl9wcm9nICp0bXBfZnA7DQo+ICAgCWJvb2wgYnBmX2JsaW5kZWQgPSBmYWxzZTsN
Cj4gICAJYm9vbCBleHRyYV9wYXNzID0gZmFsc2U7DQo+ICsJdTggKnJ3X2ltYWdlID0gTlVMTDsN
Cj4gKwl1MzIgKnJ3X2NvZGVfYmFzZTsNCj4gKwl1OCAqaW1hZ2UgPSBOVUxMOw0KPiAgIAl1MzIg
ZXh0YWJsZV9sZW47DQo+ICsJdTMyICpjb2RlX2Jhc2U7DQo+ICAgCXUzMiBmaXh1cF9sZW47DQo+
ICsJdTMyIGFsbG9jbGVuOw0KPiArCXUzMiBwcm9nbGVuOw0KPiArCXUzMiAqYWRkcnM7DQo+ICsJ
aW50IHBhc3M7DQo+ICsJaW50IGZsZW47DQoNCldoeSBzbyBtYW55IGNoYW5nZXMgaGVyZSwgYSBs
b3Qgb2YgaXRlbXMgc2VlbXMgdG8gb25seSBoYXZlIG1vdmVkIA0Kd2l0aG91dCBhbnkgbW9kaWZp
Y2F0aW9uLiBXaHkgdGhhdCBjaHVybiA/DQoNCj4gICANCj4gICAJaWYgKCFmcC0+aml0X3JlcXVl
c3RlZCkNCj4gICAJCXJldHVybiBvcmdfZnA7DQo+IEBAIC0yMjcsNiArMjMyLDggQEAgc3RydWN0
IGJwZl9wcm9nICpicGZfaW50X2ppdF9jb21waWxlKHN0cnVjdCBicGZfcHJvZyAqZnApDQo+ICAg
CQlpbWFnZSA9IGppdF9kYXRhLT5pbWFnZTsNCj4gICAJCWJwZl9oZHIgPSBqaXRfZGF0YS0+aGVh
ZGVyOw0KPiAgIAkJcHJvZ2xlbiA9IGppdF9kYXRhLT5wcm9nbGVuOw0KPiArCQlyd19oZWFkZXIg
PSBqaXRfZGF0YS0+cndfaGVhZGVyOw0KPiArCQlyd19pbWFnZSA9ICh2b2lkICopcndfaGVhZGVy
ICsgKCh2b2lkICopaW1hZ2UgLSAodm9pZCAqKWJwZl9oZHIpOw0KPiAgIAkJZXh0cmFfcGFzcyA9
IHRydWU7DQo+ICAgCQlnb3RvIHNraXBfaW5pdF9jdHg7DQo+ICAgCX0NCj4gQEAgLTI0NCw3ICsy
NTEsNyBAQCBzdHJ1Y3QgYnBmX3Byb2cgKmJwZl9pbnRfaml0X2NvbXBpbGUoc3RydWN0IGJwZl9w
cm9nICpmcCkNCj4gICAJY2djdHguc3RhY2tfc2l6ZSA9IHJvdW5kX3VwKGZwLT5hdXgtPnN0YWNr
X2RlcHRoLCAxNik7DQo+ICAgDQo+ICAgCS8qIFNjb3V0aW5nIGZhdXgtZ2VuZXJhdGUgcGFzcyAw
ICovDQo+IC0JaWYgKGJwZl9qaXRfYnVpbGRfYm9keShmcCwgMCwgJmNnY3R4LCBhZGRycywgMCkp
IHsNCj4gKwlpZiAoYnBmX2ppdF9idWlsZF9ib2R5KGZwLCAwLCAwLCAmY2djdHgsIGFkZHJzLCAw
KSkgew0KDQpTb21lIG9mIHRoZSAwcyBpbiB0aGlzIGNhbGwgYXJlIHBvaW50ZXJzLiBZb3Ugc2hv
dWxkIHVzZSBOVUxMIGluc3RlYWQuDQpUaGlzIGNvbW1lbnQgYXBwbGllcyB0byBzZXZlcmFsIG90
aGVyIGxpbmVzIHlvdSBoYXZlIGNoYW5nZWQuDQoNCj4gICAJCS8qIFdlIGhpdCBzb21ldGhpbmcg
aWxsZWdhbCBvciB1bnN1cHBvcnRlZC4gKi8NCj4gICAJCWZwID0gb3JnX2ZwOw0KPiAgIAkJZ290
byBvdXRfYWRkcnM7DQo+IEBAIC0yNTksNyArMjY2LDcgQEAgc3RydWN0IGJwZl9wcm9nICpicGZf
aW50X2ppdF9jb21waWxlKHN0cnVjdCBicGZfcHJvZyAqZnApDQo+ICAgCSAqLw0KPiAgIAlpZiAo
Y2djdHguc2VlbiAmIFNFRU5fVEFJTENBTEwgfHwgIWlzX29mZnNldF9pbl9icmFuY2hfcmFuZ2Uo
KGxvbmcpY2djdHguaWR4ICogNCkpIHsNCj4gICAJCWNnY3R4LmlkeCA9IDA7DQo+IC0JCWlmIChi
cGZfaml0X2J1aWxkX2JvZHkoZnAsIDAsICZjZ2N0eCwgYWRkcnMsIDApKSB7DQo+ICsJCWlmIChi
cGZfaml0X2J1aWxkX2JvZHkoZnAsIDAsIDAsICZjZ2N0eCwgYWRkcnMsIDApKSB7DQoNCjAgPT0+
IE5VTEwNCg0KPiAgIAkJCWZwID0gb3JnX2ZwOw0KPiAgIAkJCWdvdG8gb3V0X2FkZHJzOw0KPiAg
IAkJfQ0KPiBAQCAtMjcxLDkgKzI3OCw5IEBAIHN0cnVjdCBicGZfcHJvZyAqYnBmX2ludF9qaXRf
Y29tcGlsZShzdHJ1Y3QgYnBmX3Byb2cgKmZwKQ0KPiAgIAkgKiB1cGRhdGUgY3RndHguaWR4IGFz
IGl0IHByZXRlbmRzIHRvIG91dHB1dCBpbnN0cnVjdGlvbnMsIHRoZW4gd2UgY2FuDQo+ICAgCSAq
IGNhbGN1bGF0ZSB0b3RhbCBzaXplIGZyb20gaWR4Lg0KPiAgIAkgKi8NCj4gLQlicGZfaml0X2J1
aWxkX3Byb2xvZ3VlKDAsICZjZ2N0eCk7DQo+ICsJYnBmX2ppdF9idWlsZF9wcm9sb2d1ZSgwLCAw
LCAmY2djdHgpOw0KPiAgIAlhZGRyc1tmcC0+bGVuXSA9IGNnY3R4LmlkeCAqIDQ7DQo+IC0JYnBm
X2ppdF9idWlsZF9lcGlsb2d1ZSgwLCAmY2djdHgpOw0KPiArCWJwZl9qaXRfYnVpbGRfZXBpbG9n
dWUoMCwgMCwgJmNnY3R4KTsNCg0KMCA9PT4gTlVMTA0KDQo+ICAgDQo+ICAgCWZpeHVwX2xlbiA9
IGZwLT5hdXgtPm51bV9leGVudHJpZXMgKiBCUEZfRklYVVBfTEVOICogNDsNCj4gICAJZXh0YWJs
ZV9sZW4gPSBmcC0+YXV4LT5udW1fZXhlbnRyaWVzICogc2l6ZW9mKHN0cnVjdCBleGNlcHRpb25f
dGFibGVfZW50cnkpOw0KPiBAQCAtMzM3LDE3ICszNDgsMjYgQEAgc3RydWN0IGJwZl9wcm9nICpi
cGZfaW50X2ppdF9jb21waWxlKHN0cnVjdCBicGZfcHJvZyAqZnApDQo+ICAgDQo+ICAgI2lmZGVm
IENPTkZJR19QUEM2NF9FTEZfQUJJX1YxDQo+ICAgCS8qIEZ1bmN0aW9uIGRlc2NyaXB0b3IgbmFz
dGluZXNzOiBBZGRyZXNzICsgVE9DICovDQo+IC0JKCh1NjQgKilpbWFnZSlbMF0gPSAodTY0KWNv
ZGVfYmFzZTsNCj4gLQkoKHU2NCAqKWltYWdlKVsxXSA9IGxvY2FsX3BhY2EtPmtlcm5lbF90b2M7
DQo+ICsJKCh1NjQgKilyd19pbWFnZSlbMF0gPSAodTY0KWNvZGVfYmFzZTsNCj4gKwkoKHU2NCAq
KXJ3X2ltYWdlKVsxXSA9IGxvY2FsX3BhY2EtPmtlcm5lbF90b2M7DQoNCldvdWxkIGJlIGJldHRl
ciB0byB1c2UgJ3N0cnVjdCBmdW5jX2Rlc2MnDQoNCkFuZCB0aGUgI2lmZGVmIGlzIG5vdCBuZWNl
c3NhcnksIElTX0VOQUJMRUQoKSB3b3VsZCBiZSBlbm91Z2guDQoNCj4gICAjZW5kaWYNCj4gICAN
Cj4gICAJZnAtPmJwZl9mdW5jID0gKHZvaWQgKilpbWFnZTsNCj4gICAJZnAtPmppdGVkID0gMTsN
Cj4gICAJZnAtPmppdGVkX2xlbiA9IHByb2dsZW4gKyBGVU5DVElPTl9ERVNDUl9TSVpFOw0KPiAg
IA0KPiAtCWJwZl9mbHVzaF9pY2FjaGUoYnBmX2hkciwgKHU4ICopYnBmX2hkciArIGJwZl9oZHIt
PnNpemUpOw0KPiAgIAlpZiAoIWZwLT5pc19mdW5jIHx8IGV4dHJhX3Bhc3MpIHsNCj4gLQkJYnBm
X2ppdF9iaW5hcnlfbG9ja19ybyhicGZfaGRyKTsNCj4gKwkJLyoNCj4gKwkJICogYnBmX2ppdF9i
aW5hcnlfcGFja19maW5hbGl6ZSBmYWlscyBpbiB0d28gc2NlbmFyaW9zOg0KPiArCQkgKiAgIDEp
IGhlYWRlciBpcyBub3QgcG9pbnRpbmcgdG8gcHJvcGVyIG1vZHVsZSBtZW1vcnk7DQoNCkNhbiB0
aGF0IHJlYWxseSBoYXBwZW4gPw0KDQo+ICsJCSAqICAgMikgdGhlIGFyY2ggZG9lc24ndCBzdXBw
b3J0IGJwZl9hcmNoX3RleHRfY29weSgpLg0KDQpUaGUgYWJvdmUgY2Fubm90IGhhcHBlbiwgeW91
IGFkZGVkIHN1cHBvcnQgYnBmX2FyY2hfdGV4dF9jb3B5KCkgaW4gcGF0Y2ggDQoxLiBTbyB3aHkg
dGhpcyBjb21tZW50ID8NCg0KPiArCQkgKg0KPiArCQkgKiBCb3RoIGNhc2VzIGFyZSBzZXJpb3Vz
IGJ1Z3MgdGhhdCBqdXN0aWZ5IFdBUk5fT04uDQo+ICsJCSAqLw0KDQpDYXNlIDIgd291bGQgbWVh
biBhIGJ1ZyBpbiB0aGUgY29tcGlsZXIsIGlmIHlvdSBjYW4ndCB0cnVzdCB5b3VyIA0KY29tcGls
ZXIgZm9yIHRoYXQgeW91IGNhbid0IHRydXN0IGl0IGZvciBhbnl0aGluZyBlbHNlLiBUaGF0J3Mg
b2RkLg0KDQo+ICsJCWlmIChXQVJOX09OKGJwZl9qaXRfYmluYXJ5X3BhY2tfZmluYWxpemUoZnAs
IGJwZl9oZHIsIHJ3X2hlYWRlcikpKSB7DQo+ICsJCQlmcCA9IG9yZ19mcDsNCj4gKwkJCWdvdG8g
b3V0X2FkZHJzOw0KPiArCQl9DQo+ICAgCQlicGZfcHJvZ19maWxsX2ppdGVkX2xpbmZvKGZwLCBh
ZGRycyk7DQo+ICAgb3V0X2FkZHJzOg0KPiAgIAkJa2ZyZWUoYWRkcnMpOw0KDQo=
