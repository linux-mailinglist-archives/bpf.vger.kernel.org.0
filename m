Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8FF645F50
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLGQyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLGQx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:53:59 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2073.outbound.protection.outlook.com [40.107.12.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F99360EAC
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 08:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJq0UpOXII42Mff1dvT2048k/HxpCziXNn1TE+q5GzUaPlLsXEjoRkXmWPuZdXEcy7eRRS/ALIJac5xIRNz5ybOWihYsaSUWHK00Qopr5+e71kFQc391DZHL7yZPfxgF0TjoRriMnZMLBT4jIcY/r5p1FltQ4hcRwNWahrZNWM3OMMa8F+ywD/LMy/nWNXc4kD4D6oOJDTLiS1ZN4rIvqrQqrsFlnMzUVNduM0nRhgBzmqOBBkXztIytgyeGo+0nj2LyJLOXV39W45z2P35moSrqio4TuyKjrV3K7CwOlt3cIDCKmlJNToq5OJ7rEBLzIZ/25At6phjT1saVbaI7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdWYAN6GRoJ0YszEtQY7knmCxIcLjcSZmLQY4Ds2Jas=;
 b=hkg6bSD5YH8SIvegpE+sNo82P9SAJpoXVIgtYcS+8LIY6nJd/DvhAHRc40GRGTuUmiCfTOk4Et5E8N/cmxPM9iET+egVODTsM3WfhQa7rTlI4TcmHFmfOjhh2RQIyiTLrQ6/xF1hs2RBzY2v/RvKOTBHBrRyIGQMzocxXWZZgttJ029zi6SNIWdC9DJDj4SEiHusEvu5a/IQq5ZijFVF9G5LJd7LNThWC4c/BH0SsnFCJcXCh+mlWCtMoUrUMXRCKPELDFntEHCgDL424qlzhbyJhBpfMKwE3ShT+Qyp0UY229RUbdkFK6SDv815217pGhEjK5/IXsxOBORY6EI5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdWYAN6GRoJ0YszEtQY7knmCxIcLjcSZmLQY4Ds2Jas=;
 b=JxYHW318QVKtNHXCqXMAxrBd/O9pbJvZxHqzUb7ybtH4/6Nd6Tm9//0AZuBgkJ1ZbAPLgefsmZLM+oWk+FPGMw8pOb9MFtjT7JdEX5XuDPMybzmD7uxUrSvo3KuwW8P0MXIH2uEibGRpDhiJPtQMdmm/js6OALizUtD1GSfwE9NFhstPtbClczHVC5nxv1U+1oVMqDz/j1Q6682+/qFSb8ee7O678feUg3+d+0oaooI1z6PVJSP9f/iFMLB/OjdiEjbBnxbtXgNpgNTDK1fonX941sgd5ikruHwZi2nvyI0gmUte2pRQmZ4QOJXVkJVyUVQQ0dW7DLnbXWJw0blUIA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3158.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:53:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:53:56 +0000
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
Thread-Index: AQHY8voad8K6jE28j02RCI2Gw4PNuq4/PciAgBaVcoCAAHZiAIAAbN6AgAESV4CAARoiAIAAri6AgABmeACAAHVtgIAADBoAgAcClYCAAUHIgIAAFYsA
Date:   Wed, 7 Dec 2022 16:53:56 +0000
Message-ID: <de7c70bc-94df-a372-ecfe-d2c707ad9014@csgroup.eu>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx>
 <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx>
 <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx>
In-Reply-To: <87v8mndy3y.ffs@tglx>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3158:EE_
x-ms-office365-filtering-correlation-id: 6451628d-7c9a-4e81-8227-08dad873a10c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBAtMR2MXZqX/FcZnKqH4V28DI52Km8MvYhwxznL2p2LdZV7sXqRiJ4od/Ux+ljGnODlWHs1H8DzcAI1l5IJ7SwfGT6/QR/p4g+nOwyUPiKIfwgt/ARtNMe+YqWJmIKlWXifL/gmCJ+XEh8/vwH2pPcIkMFlo1Tmf/4L5sWh6ZteqFs4DhZhfjRqOVtCYk7f8F+8IhIWuQEkn8p/r+6qI4I2R60taIE2gSWJAps9Nr9/KI591lTZ3vpTw8kKuzudmtAxVSFnBPjqhnBjUE5fxMr2wRBXddVb7bltfgSYNqDLUruHlbmWXmKbBNQYHQkWrp+ysg0mDexpbdrlZ2/jkrYX5vwXArETKe48bxm9TgVe2O5WXJs2DsjWh/iKGvJBjL6NeEN87evSsCaGAPXipgxenk+Pcp86CnDI6dX2/vtOYpdjhuut6JWP1AgWgWChw2TkGB1LTVnjjU0CdIcZTTMI/OSI6GnBdTHBQIyviBHpQ5KqfVSbucK6GalEnLi4NxVhbAUIuhSCOQD9FEXLxEn+oe16xtnaxqqLvso2wgsB5sFnuGQlk/OeBrGbqjpei87PpzLn8heDQLx+aM+UT5D9jGuT8qsBVRy8+2vo2GcHBlrMAyWWkVYpZpo6oudxkrRxxpMQySKW/XuDSw7/YtAGO9sYBC2QUKh+SXVMVRvuYuM6Sf+3kaLg3+rtXFW8ew5VGH/lc/37fuZQXszT+AuQwepMuDxxlKwIwpFQpBLrBNm8dowrMiwSjg37mBHs73jkNEtiZvz6VwDoeyUaog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(83380400001)(122000001)(8936002)(31696002)(86362001)(44832011)(91956017)(2906002)(4744005)(5660300002)(7416002)(38070700005)(41300700001)(4326008)(186003)(478600001)(26005)(64756008)(6506007)(6512007)(66946007)(2616005)(8676002)(66556008)(66446008)(110136005)(6486002)(31686004)(66476007)(54906003)(316002)(76116006)(38100700002)(71200400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVUUmV0MVpkWWRnSG5HbTRXNkRxbVpMcFRFcVVnVWJsaVA1ZUs2cGcyRUZG?=
 =?utf-8?B?clFvTW02N0JQSzNWMksrNkdCK0k5RTVXRHMrMmVLeE5IOWdZemtYbmNSNVVr?=
 =?utf-8?B?Y0FSb0xXbDFzWVg5aW16MmFwSEpSZzE3Mkw4SzhlTDVXVmtXeEVUY0krVWoy?=
 =?utf-8?B?SG1lN2tZaFFmaU1UVUxnMDVreTNhQnhjYVRtOWtVOGFSdW1RZEpoVEllMVJa?=
 =?utf-8?B?K0dBU2lQZGtXUUJDdi9sNGl5QUJHV2pRVExmUkVtTUlOM0dYUTBCRmJSVVh0?=
 =?utf-8?B?MXRMM0dlVzFWRGVRakZFMVRhc0FEWlhzM25lVWdBQTJ5MUxLTUc3Y21taStB?=
 =?utf-8?B?NWIwdWViYUJRSVB6Q1lSeHFxb3ZLUVJJS3htL1F1dThyUWN4eE83ZHFmZUdG?=
 =?utf-8?B?NWF0UHdWNjhiaS9XMEg3ZGFmUmsrWnFtUkNidTNRRVNNck9zU2ZxSWpOSDIr?=
 =?utf-8?B?VEViN09kaU1nQTVEeUFUTDlkQ2hTT0kxSk53Z09QRFZiOElhclJNZXZpMFJ0?=
 =?utf-8?B?M2lLb0NkSCt0b3JkWTBybVNNS0VPZmVmeUd2NHNYRjBvTVJYcmt2bHYwRE5R?=
 =?utf-8?B?NDh3OTFtTnJsSDU4SFd0Q0Z2SUowbDBNdHhDY2YrK0N4TmdoSSs4eG1RYlhs?=
 =?utf-8?B?T09rY3FGc3RqSlpZcTdhR3VuYml2WFFUaUliK3dTaEVoWmhPT2ZOUDNyRk9W?=
 =?utf-8?B?U1VKUDEya2RLUktGNkNUY3UvN0t2dVFPNnROaGZOaXVyTUtiNzFOYnZ1NFJC?=
 =?utf-8?B?VW8yZ1N5RjJDM3Byc1BISFlDaGJqS0VNOWRrdWE3WnBSclB5d1lWM3BhSUFa?=
 =?utf-8?B?OE9SK05WYS90QzhDc3JlTWJ4Ymo1R2dwWi9WcEQ1YlQ2L0JXNWhkVWJEZjRp?=
 =?utf-8?B?YzNBbkZlcDIvVFB5ZWdIZDdpQjRsOWpMdjhCeFBVN1BwUDM3a0JSdThHd3Fy?=
 =?utf-8?B?Rzlqd2t5bVFkVjB4L2J2UkNYVVZQUWE2MWc1NmtsWTkzZUUxZGdscGlRRVpD?=
 =?utf-8?B?Yk5DcjdNeVlzZEp1akJ0MWEvTUVSNjdHanNMZ202cDJDT0ovRHBKTnVRTzZS?=
 =?utf-8?B?SWlmY25Gcjk3UmEvelgxcE9WQkMwOG5sdmNLQm54Q2xYSHpOcXlzYWw1TjJ1?=
 =?utf-8?B?TjF2M2Mxbkc3UHF1bnN3Q3ZLSkFrRHNmNWsxL3I2Z1c2Ti9SUEJxdU9oaFZS?=
 =?utf-8?B?TENxck5pZ0dIWXlHRU02STZreE9jYWJEQW50YTFreStKZERobjNlVXNjeERI?=
 =?utf-8?B?S3JLdG1ENTNxUW1veWtFYnlUWFMwMWgrNjlZdWtxUmhJZGJxMjFUeHYrMFMy?=
 =?utf-8?B?elJQQVFkTCtJOU5VSVk2TnFUZFplcDVYUDA0UzZ2c2RwMENaQzYxaW1rcmR1?=
 =?utf-8?B?eHB5OHpsSWFuQzdmOG9FS1BYakY0TWI5SGhrVCszSXhnTXJub1NXSTBoTWUx?=
 =?utf-8?B?RTRQUUg4VkMxRHYxSndYUVNaNU1OQ3lVVzZ4SnU1SzdZaURQMHNjZm5aR3Vy?=
 =?utf-8?B?cDlHUitKRjIxbC9JRlJ3U3IwQlR3STBRcVgxazNlMW0xNDkvV0NBR3Z0d0Nh?=
 =?utf-8?B?U0I3V0lzakV1V1dJQk5Bam1MK3ZxUk8vQ0xQWDFFVDQ0eTdFcXBDT3pwK0lY?=
 =?utf-8?B?dEFlZWNxRkIwNmJ4YW12a1RublZUMDlSb05zWVJxdzlPZncxdXVYb3NINDhC?=
 =?utf-8?B?RCtFYmlnMWFHQVFIMGhPaGRlL1d3RFJodFBFazFacFNkNDJzbnZmYk9LajBr?=
 =?utf-8?B?b3EzbGZVTytzL1hjV3pvaVZsRm81QStRemFhcW1tQVBYWWpBM0hhTVowRmwx?=
 =?utf-8?B?MFhacUw5TUxzLzA0ZVVUdmQ3ZTRKYndpVFlYeGlPUUVWeXlqNENuSGhIT2NR?=
 =?utf-8?B?eDgxNHBidllTVHNlMEZDSU1DdlFEdzNkY3p4UldoKzlNckpUMEhRZ3RWT2pj?=
 =?utf-8?B?WFNoeVhVV2NHcUJXcFlDSWFtK1B4ZGxpZkp2WkxmbVlTLzJCdFJnZ2J2N3Ew?=
 =?utf-8?B?OE00L3lmRTM0bm5sTHZRUndnZ3RTcEhTUWRBUFRJUUtkVUQwWEVNNFdaTHR3?=
 =?utf-8?B?V3NXQjlUdStETUQ5TXp0QTltQnNza0g2R3llWWFCU2RjTVBGSzBIQVBrVHBJ?=
 =?utf-8?B?VUUzVVFlVXNBa0J3T05qVE1UWDJ3dHFEWS9rV0JmY3VBNnNjdFJTZ3dJVUNr?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <299C8C4E02E88247862249255ADDB6E0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451628d-7c9a-4e81-8227-08dad873a10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 16:53:56.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h17Qp7CmGaMElIvlCJR2COzSQWtdGQodGLg5JEDc+IcnQStGpVGKHVhoyka+6hcxLIfM7uNX26XCNwEF1/11bzGRf8A2jQOJLaGwIDcXgJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3158
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA3LzEyLzIwMjIgw6AgMTY6MzYsIFRob21hcyBHbGVpeG5lciBhIMOpY3JpdMKgOg0K
PiANCj4gVGhlICJ1c2UgZnJlZSBzcGFjZSBpbiBleGlzdGluZyBtYXBwaW5ncyIgbWVjaGFuaXNt
IGlzIG5vdCByZXF1aXJlZCB0bw0KPiBiZSBQTURfU0laRSBiYXNlZCwgcmlnaHQ/DQo+IA0KPiBM
YXJnZSBwYWdlIHNpemUsIHN0cmljdCBzZXBhcmF0aW9uOg0KPiANCj4gc3RydWN0IG1vZF9hbGxv
Y190eXBlX3BhcmFtcyB7DQo+ICAgICAJW01PRF9BTExPQ19UWVBFX1RFWFRdID0gew0KPiAgICAg
ICAgICAJLm1hcHRvX3R5cGUJPSBNT0RfQUxMT0NfVFlQRV9URVhULA0KPiAgICAgICAgICAgICAg
ICAgIC5mbGFncwkJPSBGTEFHX1NIQVJFRF9QTUQgfCBGTEFHX1NFQ09ORF9BRERSRVNTX1NQQUNF
LA0KPiAgICAgICAgICAgICAgICAgIC5ncmFudWxhcml0eQk9IFBNRF9TSVpFLA0KPiAgICAgICAg
ICAgICAgICAgIC5hbGlnbm1lbnQJPSBNT0RfQVJDSF9BTElHTk1FTlQsDQo+ICAgICAgICAgICAg
ICAgICAgLnN0YXJ0WzBdCT0gTU9EVUxFU19WQUREUiwNCj4gICAgICAgICAgICAgICAgICAuZW5k
WzBdCQk9IE1PRFVMRVNfRU5ELA0KPiAgICAgICAgICAgICAgICAgIC5zdGFydFsxXQk9IE1PRFVM
RVNfVkFERFJfMk5ELA0KPiAgICAgICAgICAgICAgICAgIC5lbmRbMV0JCT0gTU9EVUxFU19FTkRf
Mk5ELA0KPiAgICAgICAgICAgICAgICAgIC5wZ3Byb3QJCT0gUEFHRV9LRVJORUxfRVhFQywNCj4g
ICAgICAgICAgICAgICAgICAuZmlsbAkJPSB0ZXh0X3Bva2UsDQo+ICAgICAgICAgICAgICAgICAg
LmludmFsaWRhdGUJPSB0ZXh0X3Bva2VfaW52YWxpZGF0ZSwNCj4gCX0sDQoNCkRvbid0IHJlc3Ry
aWN0IGltcGxlbWVudGF0aW9uIHRvIFBNRF9TSVpFIG9ubHkuDQoNCk9uIHBvd2VycGMgOHh4Og0K
LSBQTURfU0laRSBpcyA0IE1ieXRlcw0KLSBMYXJnZSBwYWdlcyBhcmUgNTEyIGtieXRlcyBhbmQg
OCBNYnl0ZXMuDQoNCkl0IGV2ZW4gaGFzIGxhcmdlIHBhZ2VzIG9mIHNpemUgMTYga2J5dGVzIHdo
ZW4gYnVpbGQgZm9yIDRrIG5vcm1hbCBwYWdlIA0Kc2l6ZS4NCg0KQ2hyaXN0b3BoZQ0K
