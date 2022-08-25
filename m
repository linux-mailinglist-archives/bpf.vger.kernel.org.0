Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC55A056F
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiHYA4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiHYA4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:56:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F744546
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:56:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27P0il5l011971
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:56:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nHyLL/JW9q6MsitwbvaegbaCJWPBxPlM/cMGXqwVPMA=;
 b=hLHDqKM59z12G1x61nFUA6TWAzU+jU3ColXUCEi1sfFNQWdABJipjDgoiF3jycLgUY3s
 aDP6R1WOaJZsXNJf+w5vuYXApCA/L9bGNZ9KEw+oPz3w46GZmYwHo2QRWnlN7RGy2ffB
 wybi03D6zJdhw/lMonI2JjXHFt0EQDVsyy4= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j5xcgg5d1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpzAxYHgofL5FScvdqJsguyTbGvddsKbm1R369Q8hxehmuv2iV+ZIHuO+62Ms3tvtVpd9vFpfpqoMDMpEphkDyPjWrUbqwF30o5NFXU6q00NLuuOP+WZglGIrdvVq3tKJKvlwqygqzdBPoiDq+KWKTXRLAHTqGnl5MvqbSG9NzRS6GS65wG80PL5X+g1A2awoGxaIQFzdhimQ8VTj4p6Nu277ODVJ2t2q6M94hxWL/IS19sQ2BginV34AXhywCLRGJJ26bX3kaAcRTxNkYZ7XuHwV5jtXVmc5Zihq0rKUoIHuNnBgOnNd5SwD5YvXYCmQ7M9TdlDN0mtBWddo0NRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHyLL/JW9q6MsitwbvaegbaCJWPBxPlM/cMGXqwVPMA=;
 b=a6EX89bCyDBPaC628rsOCcicWWTeWU84oGvMh3BsSdFxahuLATZizWmdb5Vtmapd9olKA7jTHNbYi5VsmsPXjmuMbsSYtdlrs1DsxaKrrgu4PErMoQEtc8zTbjxAcl6RkODKb7TFRoxzcF2hT1sBbEwHBjT7JOVe/AAXK5ppCv8bXyv7BEV5DTwJ1/ox6IocyIvJbzXVj+Qy1T4hTj4/tjO2wkgyAMBJXYdI5tXAIf7U3qLQh3I/SNd8KZ3SnKDwStyuw7udLVvSZF9q+jXeyvXKwys1f3I1DfYwXOVb3zDFfJWsb5w2EbsAXWNgdYWMo6px4dLqrd8gar2+iLvUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2855.namprd15.prod.outlook.com (2603:10b6:a03:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 00:56:31 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f830:c4f2:86dc:9b4]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f830:c4f2:86dc:9b4%8]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 00:56:31 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "memxor@gmail.com" <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Thread-Topic: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Thread-Index: AQHYuB2D39OSH+rKI0eOgpEXWGYdfA==
Date:   Thu, 25 Aug 2022 00:56:30 +0000
Message-ID: <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 543c7c74-5bef-4d08-9342-08da8634a61b
x-ms-traffictypediagnostic: BYAPR15MB2855:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9N4oUAMrjRDg04O40xuLdMwURhkC+Ynjgd0bTE7Hf2VuAaRfEqdEEPNDKc3er+YiV2ducpr1HasdoFkSkckewn6VsdSZ3HnnD99FgwwaA712Q+N99NtviwIyN0CexsGNvQ6ra/pKmcSO1vfwJC7e7fRpfiygHxQ1WzJG4ozEiekgMWA/FLmUto2Qa+fJKNu7ot+lnutDnsL7X4GJ768FjzQQBojESe/FGO+IW2X/BxMOKG9fslsbw6pqEj0J7eFseSko5HhctUEqAXSSGHbiIOWTtjfx3B5oFMFgzT5BneNA4j2AvnwTOeemcaKFXvCtHfofj/IWb1TAjHKf17xAZb34xDsYaN2AHKceUQ5L5KCXtwhJmeCk1YytVjpBT1BZVoNESvqzAkykQIeQYj2Ze4bxL2aF4HCot4tDKMDoLQpAiEpQulJpjrocgTmdy70C05Gcsy9Q/C5ACuQZJ9ZAzqYmwtoWe7yse8uDAbYzbDTGL+vdEQWq2R3rpdk/4zWTuLpy77JrnNfzO1KHa6Hq06MUeMOvRMQ3Ld+EFKiPckcKyGiCQ60DxVT2KplK1YuYu55L94Rpbw72IHAQI+K3NdfA7XxbsUknmgIvGn+wkEk9AvhS8B/6KFTqKnA35dPmB6xq9CL4N4UJ5HEbwmbBpZkecJjF+HCi+HW7NiIMl7ndF6cxM5mZfX7feRIyQKTJs88txi0p3JKn1xpidh6YyMp0L6tZ1V3aRn/p2b3WrPyxR/Hwa4jVPsCC8q0oVMyq8CpcKKVOPddFlzP4VbNmUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(76116006)(110136005)(66556008)(86362001)(66946007)(8676002)(4326008)(64756008)(54906003)(316002)(66446008)(38070700005)(186003)(38100700002)(478600001)(2616005)(71200400001)(66476007)(6512007)(6486002)(6506007)(122000001)(36756003)(41300700001)(83380400001)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGsrODYzeTdxcDlLVzMrVEVySjA2c2hKcWZSWlRqVE9CVHhFODk2RXd1Qnly?=
 =?utf-8?B?ZEdRVkZDRkI3VW8wWVMvbVU0OVFOeWdvZ1NPeWdaL0U2dUdYRWRxczhyK3JZ?=
 =?utf-8?B?ZDRreWFsa3RtSzhTZHByRzZOeGIvSWtTeVMrWmllQnNTZ2I1NWVlN05TRWlh?=
 =?utf-8?B?VlI0dmR0cVVuK0YvUjlsVDNUdzJDS3orc3FWQ2ZOMERoSUtYcjJ4eG4vbjEr?=
 =?utf-8?B?REJRNHFBc1hrL1FPNTlBWVZBa21ZVS95YzNEc1hKaXBmZ294UEUvMFRVT1la?=
 =?utf-8?B?ZHdINmFZVnBta0xTWmg5VmhFUTZ2QVdoN01Mb2lEZjNGSVY3MktuTllBMEFj?=
 =?utf-8?B?Mkx4cm54VmRmMmU4L2daVEtXVHlFSFlOT3ZSclQ1dFdBeXFCZUViSnFuSmp6?=
 =?utf-8?B?STVEeVArcGlwb0c3UlVWUkVQYzVoWUkvNjBQR0JxQzdZdFc1d3c1bkZDd3p6?=
 =?utf-8?B?NER6U3RXYTNmcE9vQUEvMXpqQjg2d3dFV2lOcm9WUHZEY2hqS1czMFA3dlBQ?=
 =?utf-8?B?Y21LRDdzbm9wbXJaZkhsWnA0RDh6YWFqTENTYnBwMVVqMmw2dTI2K0FvaXd5?=
 =?utf-8?B?STB1R2htWG8xbGgyNFU0U3RqSUN1L2o3R2lBTGxuM1JMRXlPUDN2Z29uOGcw?=
 =?utf-8?B?a1Z2Y09BdkFjTmJvdVl1Uzg2YmJmRFpRbGNlOUJyR3pld2czdStGSXVNa1U5?=
 =?utf-8?B?bC9ES284Q3VsVGxIQUJnSmxWbFZuOFVWQU9WeXB1OXZqM2piejZROXdPLzUx?=
 =?utf-8?B?WFF1b2Y2SFhYcjdLTmcrVm1wTjJpalNFeFI2V3pxSTQxRUMvNUxYa3FXdWw4?=
 =?utf-8?B?MzBBV01WdzR1UElsdExPeTd2ckpzaDEwbGszV2hmL2RrSGkwRG9nUU5BTjhG?=
 =?utf-8?B?Rkg1Vnd1YUpiWm1nMk55S0IrNEtZZGluOEUvU1BiZlpZMXFZKytQbENUVjRD?=
 =?utf-8?B?bTZwTzlSWWptN2dvSVk0Wi9iWlJaby9wMEEwWnJFVGhnaGw4cjlpbHF0TE4v?=
 =?utf-8?B?QWlHU2hvVDl2QW42WXFiUXd1eU1VYVd3SUF4RWJhREVkNW1kUmZlc29HU2Fp?=
 =?utf-8?B?R1VkaTNWYmtOa1p3NE9SMW10WHJQYlFWMDViV2Nnb0d2NUtYK1hDNzEyaHhh?=
 =?utf-8?B?WncrTUt5NHNsTTlzeGppQkpZcGhjZWNpc3ZZS3NDNTk0bU9YZmYrWUR3Znh2?=
 =?utf-8?B?YUE2NHhscnI1cHdCTGQ2VU00NzlHR0l4RDdnZXhNMHNIZW9oaXJhVWlST3NU?=
 =?utf-8?B?UUdOTnFJMWkrTFp5Qk9HTFo3KytzMmVmbm0wSnVTWkRqSXpnbzQ3aE5yTzhF?=
 =?utf-8?B?WktMWVZuOEhQclRPMGNWSGZxejVlNHNtamV4SHRHZ2lFR0p3OVhLTmY0ZmVo?=
 =?utf-8?B?MXc2ZVJONUFwQ1RTSTVzd0NYdWtIM2JSalVwT3doY1dNVzV6ZFZqZnVnR2hs?=
 =?utf-8?B?aHNEeUdDSFdVTmlRM0VDZUppRU9TcmR6MXNDOE9jT2UwaVFkYnM2WE41dlJZ?=
 =?utf-8?B?b1M3SlJnWTQrSEppUElHRTYzOFM0a1p3M3JVQ3FCdXhRTWZ3em1TZUcrMXg5?=
 =?utf-8?B?VXpHdUVkTWcxRDh5TllidGswL2R5aElQQ1BHWFgyc2haVm81eG9GNk5PalJ1?=
 =?utf-8?B?VmlkUHQ0T3lTT1IrdVQ5SllTd2lwUEFSVDd0eTFTYjlONnBrUlpOWlBqVkw2?=
 =?utf-8?B?QnNRZE5TTVJzRXZoWmZsZkhXQmpFVm05NVp3SlNVVmRicDRRamZNYVBOenBu?=
 =?utf-8?B?T2FFaWZGUXJSRFF1ajYyMnV1YzA5a3lwWFplejN6dW8zSWdHWmlNUkFNMHU4?=
 =?utf-8?B?M1EzcXZhSjZDdjdwdm53Si93Z1FPWkpLT0lITlQrbFBKUzRDaHhxTmhCQU8v?=
 =?utf-8?B?MTVsQURWSnRtVlRtV1h2M3R6KzhSQzF6cVZ4UzhITTl3a25IL2hUbG03REow?=
 =?utf-8?B?Ri9CQkNuaExtb2ovZzhOdENCUWZjNldlQmp1TlhBOW03WW5ldVg4WnRVMnBS?=
 =?utf-8?B?TU5uQzJWUXV0eFVTSDM2L2NvWm85UWtrL1o1T2VNTHJoS3pheHk1Zm9vK3BO?=
 =?utf-8?B?eHhhRHpmQTVzRXEvZUxTWS9SY1MzVjYybHdqaWFRVzVVNnlWdGhQaWhORVZZ?=
 =?utf-8?B?MTZrc0NISzZhUUZJeWpiSGJDNmczc2g2dmN1OENBbDltVlpuS3JRNys5Wm84?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <944A094387A6594285042880B36DF25B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543c7c74-5bef-4d08-9342-08da8634a61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 00:56:30.9280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUed1u/N//Zu5T9EK8cTCzM8Quj8L28D5IWxj4AFQxDc5c9aote+cfJcs0986NVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2855
X-Proofpoint-GUID: IJRqPeAM3pNv9AnhmxXBEvu1Qt7y3D1I
X-Proofpoint-ORIG-GUID: IJRqPeAM3pNv9AnhmxXBEvu1Qt7y3D1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QWxleGVpIGFuZCBJIHNwZW50IHNvbWUgdGltZSB0b2RheSBnb2luZyBiYWNrIGFuZCBmb3J0aCBv
biB3aGF0IHRoZSB1YXBpIHRvIHRoaXMNCmFsbG9jYXRvciBzaG91bGQgbG9vayBsaWtlIGluIGEg
QlBGIHByb2dyYW0uIFRvIGJvdGggb2Ygb3VyIHN1cnByaXNlLCB0aGUgcHJvYmxlbQ0Kc3BhY2Ug
YmVjYW1lIGZhciBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gd2UgYW50aWNpcGF0ZWQuDQoNClRoZXJl
IGFyZSB0aHJlZSBwcmltYXJ5IHByb2JsZW1zIHdlIGhhdmUgdG8gc29sdmU6DQoxKSBLbm93aW5n
IHdoaWNoIGFsbG9jYXRvciBhbiBvYmplY3QgY2FtZSBmcm9tLCBzbyB3ZSBjYW4gc2FmZWx5IHJl
Y2xhaW0gaXQgd2hlbg0KbmVjZXNzYXJ5IChlLmcuLCBmcmVlaW5nIGEgbWFwKS4NCjIpIFR5cGUg
Y29uZnVzaW9uIGJldHdlZW4gbG9jYWwgYW5kIGtlcm5lbCB0eXBlcy4gKEkuZS4sIGEgcHJvZ3Jh
bSBhbGxvY2F0aW5nIGtlcm5lbA0KdHlwZXMgYW5kIHBhc3NpbmcgdGhlbSB0byBoZWxwZXJzL2tm
dW5jcyB0aGF0IGRvbid0IGV4cGVjdCB0aGVtKS4gVGhpcyBpcyBlc3BlY2lhbGx5DQppbXBvcnRh
bnQgYmVjYXVzZSB0aGUgZXhpc3Rpbmcga3B0ciBtZWNoYW5pc20gYXNzdW1lcyBrZXJuZWwgdHlw
ZXMgZXZlcnl3aGVyZS4NCjMpIEFsbG9jYXRlZCBvYmplY3RzIGxpZmV0aW1lcywgYWxsb2NhdG9y
IHJlZmNvdW50aW5nLCBldGMuIEl0IGFsbCBnZXRzIHZlcnkgaGFpcnkNCndoZW4geW91IGFsbG93
IGFsbG9jYXRlZCBvYmplY3RzIGluIHBpbm5lZCBtYXBzLg0KDQpUaGlzIGlzIHRoZSBwcm9wb3Nl
ZCBkZXNpZ24gdGhhdCB3ZSBsYW5kZWQgb246DQoNCjEuIEFsbG9jYXRvcnMgZ2V0IHRoZWlyIG93
biBNQVBfVFlQRV9BTExPQ0FUT1IsIHNvIHlvdSBjYW4gc3BlY2lmeSBpbml0aWFsIGNhcGFjaXR5
DQphdCBjcmVhdGlvbiB0aW1lLiBWYWx1ZV9zaXplID4gMCB0YWtlcyB0aGUga21lbV9jYWNoZSBw
YXRoLiBQcm9iYWJseSB3aXRoDQpidGZfdmFsdWVfdHlwZV9pZCBlbmZvcmNlbWVudCBmb3IgdGhl
IGttZW1fY2FjaGUgcGF0aC4NCg0KMi4gVGhlIGhlbHBlciBBUElzIGFyZSBqdXN0IGJwZl9vYmpf
YWxsb2MoYnBmX21hcCAqLCBicGZfY29yZV90eXBlX2lkX2xvY2FsKHN0cnVjdA0KZm9vKSkgYW5k
IGJwZl9vYmpfZnJlZSh2b2lkICopLiBOb3RlIHRoYXQgb2JqX2ZyZWUoKSBvbmx5IHRha2VzIGFu
IG9iamVjdCBwb2ludGVyLg0KDQozLiBUbyBhdm9pZCBtaXhpbmcgQlRGIHR5cGUgZG9tYWlucywg
YSBuZXcgdHlwZSB0YWcgKHByb3Zpc2lvbmFsbHkgX19rcHRyX2xvY2FsKQ0KYW5ub3RhdGVzIGZp
ZWxkcyB0aGF0IGNhbiBob2xkIHZhbHVlcyB3aXRoIHZlcmlmaWVyIHR5cGUgYFBUUl9UT19CVEZf
SUQgfA0KQlRGX0lEX0xPQ0FMYC4gb2JqX2FsbG9jIG9ubHkgZXZlciByZXR1cm5zIHRoZXNlIGxv
Y2FsIGtwdHJzIGFuZCBvbmx5IGV2ZXIgcmVzb2x2ZXMNCmFnYWluc3QgcHJvZ3JhbS1sb2NhbCBi
dGYgKGluIHRoZSB2ZXJpZmllciwgYXQgcnVudGltZSBpdCBvbmx5IGdldHMgYW4gYWxsb2NhdGlv
bg0Kc2l6ZSkuIA0KMy4xLiBJZiBldmVudHVhbGx5IHdlIG5lZWQgdG8gcGFzcyB0aGVzZSBvYmpl
Y3RzIHRvIGtmdW5jcy9oZWxwZXJzLCB3ZSBjYW4gaW50cm9kdWNlDQphIG5ldyBicGZfb2JqX2V4
cG9ydCBoZWxwZXIgdGhhdCB0YWtlcyBhIFBUUl9UT19MT0NBTF9CVEZfSUQgYW5kIHJldHVybnMg
dGhlDQpjb3JyZXNwb25kaW5nIFBUUl9UT19CVEZfSUQsIGFmdGVyIHZlcmlmeWluZyBhZ2FpbnN0
IGFuIGFsbG93bGlzdCBvZiBzb21lIGtpbmQuIFRoaXMNCndvdWxkIGJlIHRoZSBvbmx5IHBsYWNl
IHRoZXNlIG9iamVjdHMgY2FuIGxlYWsgb3V0IG9mIGJwZiBsYW5kLiBJZiB0aGVyZSdzIG5vIHJ1
bnRpbWUNCmFzcGVjdCAoYW5kIHRoZXJlIGxpa2VseSB3b3VsZG4ndCBiZSksIHdlIG1pZ2h0IGNv
bnNpZGVyIGRvaW5nIHRoaXMgdHJhbnNwYXJlbnRseSwNCnN0aWxsIGFnYWluc3QgYW4gYWxsb3ds
aXN0IG9mIHR5cGVzLg0KDQo0LiBUbyBlbnN1cmUgdGhlIGFsbG9jYXRvciBzdGF5cyBhbGl2ZSB3
aGlsZSBvYmplY3RzIGZyb20gaXQgYXJlIGFsaXZlLCB3ZSBtdXN0IGJlDQphYmxlIHRvIGlkZW50
aWZ5IHdoaWNoIGFsbG9jYXRvciBlYWNoIF9fa3B0cl9sb2NhbCBwb2ludGVyIGNhbWUgZnJvbSwg
YW5kIHdlIG11c3QNCmtlZXAgdGhlIHJlZmNvdW50IHVwIHdoaWxlIGFueSBzdWNoIHZhbHVlcyBh
cmUgYWxpdmUuIE9uZSBjb25jZXJuIGhlcmUgaXMgdGhhdCBkb2luZw0KdGhlIHJlZmNvdW50IG1h
bmlwdWxhdGlvbiBpbiBrcHRyX3hjaGcgd291bGQgYmUgdG9vIGV4cGVuc2l2ZS4gVGhlIHByb3Bv
c2VkIHNvbHV0aW9uDQppcyB0bzrCoA0KNC4xIEtlZXAgYSBzdHJ1Y3QgYnBmX21lbV9hbGxvYyog
aW4gdGhlIGhlYWRlciBiZWZvcmUgdGhlIHJldHVybmVkIG9iamVjdCBwb2ludGVyDQpmcm9tIGJw
Zl9tZW1fYWxsb2MoKS4gVGhpcyB3YXkgd2UgbmV2ZXIgbG9zZSB0cmFjayB3aGljaCBicGZfbWVt
X2FsbG9jIHRvIHJldHVybiB0aGUNCm9iamVjdCB0byBhbmQgY2FuIHNpbXBsaWZ5IHRoZSBicGZf
b2JqX2ZyZWUoKSBjYWxsLg0KNC4yLiBUcmFja2luZyB1c2VkX2FsbG9jYXRvcnMgaW4gZWFjaCBi
cGZfbWFwLiBXaGVuIHVubG9hZGluZyBhIHByb2dyYW0sIHdlIHdvdWxkDQp3YWxrIGFsbCBtYXBz
IHRoYXQgdGhlIHByb2dyYW0gaGFzIGFjY2VzcyB0byAodGhhdCBoYXZlIGtwdHJfbG9jYWwgZmll
bGRzKSwgd2FsayBlYWNoDQp2YWx1ZSBhbmQgZW5zdXJlIHRoYXQgYW55IGFsbG9jYXRvcnMgbm90
IGFscmVhZHkgaW4gdGhlIG1hcCdzIHVzZWRfYWxsb2NhdG9ycyBhcmUNCnJlZmNvdW50X2luYydk
IGFuZCBhZGRlZCB0byB0aGUgbGlzdC4gRG8gbm90ZSB0aGF0IGFsbG9jYXRvcnMgYXJlIGFsc28g
a2VwdCBhbGl2ZSBieQ0KdGhlaXIgYnBmX21hcCB3cmFwcGVyIGJ1dCBhZnRlciB0aGF0J3MgZ29u
ZSwgdXNlZF9hbGxvY2F0b3JzIGlzIHRoZSBtYWluIG1lY2hhbmlzbS4NCk9uY2UgdGhlIGJwZl9t
YXAgaXMgZ29uZSwgdGhlIGFsbG9jYXRvciBjYW5ub3QgYmUgdXNlZCB0byBhbGxvY2F0ZSBuZXcg
b2JqZWN0cywgd2UNCmNhbiBvbmx5IHJldHVybiBvYmplY3RzIHRvIGl0Lg0KNC4zLiBPbiBtYXAg
ZnJlZSwgd2Ugd2FsayBhbmQgb2JqX2ZyZWUoKSBhbGwgdGhlIF9fa3B0cl9sb2NhbCBmaWVsZHMs
IHRoZW4NCnJlZmNvdW50X2RlYyBhbGwgdGhlIHVzZWRfYWxsb2NhdG9ycy4NCg0KT3ZlcmFsbCwg
d2UgdGhpbmsgdGhpcyBoYW5kbGVzIGFsbCB0aGUgbmFzdHkgY29ybmVycyAtIG9iamVjdHMgZXNj
YXBpbmcgaW50bw0Ka2Z1bmNzL2hlbHBlcnMgd2hlbiB0aGV5IHNob3VsZG4ndCwgcGlubmVkIG1h
cHMgY29udGFpbmluZyBwb2ludGVycyB0byBhbGxvY2F0aW9ucywNCnByb2dyYW1zIGFjY2Vzc2lu
ZyBtdWx0aXBsZSBhbGxvY2F0b3JzIGhhdmluZyBkZXRlcm1pbmlzdGljIGZyZWVsaXN0IGJlaGF2
aW9ycyAtDQp3aGlsZSBrZWVwaW5nIHRoZSBBUEkgYW5kIGNvbXBsZXhpdHkgc2FuZS4gVGhlIHVz
ZWRfYWxsb2NhdG9ycyBhcHByb2FjaCBjYW4gY2VydGFpbmx5DQpiZSBsZXNzIGNvbnNlcnZhdGl2
ZSAob3IgY2FuIGJlIGV2ZW4gcHJlY2lzZSkgYnV0IGZvciBhIHYxIHRoYXQncyBwcm9iYWJseSBv
dmVya2lsbC4NCg0KUGxlYXNlLCBmZWVsIGZyZWUgdG8gc2hvb3QgaG9sZXMgaW4gdGhpcyBkZXNp
Z24hIFdlIHRyaWVkIHRvIGNhcHR1cmUgZXZlcnl0aGluZyBidXQNCkknZCBsb3ZlIGNvbmZpcm1h
dGlvbiB0aGF0IHdlIGRpZG4ndCBtaXNzIGFueXRoaW5nLg0KDQotLURlbHlhbg0K
