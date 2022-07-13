Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00C573A89
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiGMPtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiGMPtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 11:49:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4951D337;
        Wed, 13 Jul 2022 08:49:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DE95HT001963;
        Wed, 13 Jul 2022 08:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ykONdxFH1ImNbVmXkqbp+clV4B0BGUx3CSlt2OzIMGU=;
 b=f4Bnv9eWiX15fgF0DevzihirPI4QY9q1TVk83iWCikTQVl+YuVMSKKzr5W+AxN+eFoVk
 rkGVM0dG4+3Cuty3AQWx9+jYufXYT3ES0GE05ewbAduoTMJ2St9r6XujM4VeE+xRRx+M
 pAkFazW7ljKKtyJOMwqUpGbc++CtvtFGsDw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5hmqjx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:49:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1c23B812T7gDYEWO4KWTICoSGoMu4L0kam2k48lNU3JvdJzVr6X1HPI/+Vov3ymxxbM7WxeOOhQ1r2GUfGOsgFrbW5V44q99nLJxpS3SwDF3o/0I7OMaIzPRYGu9wLWzRDgZUQCIuD0wE4nTXucXruSX+Sopk0E0iBdiqsbhb7C5VxyTkEkMS3VftEM5IaLTJIK1Cq0l5cpdhMh5MfEaoLxYUrK++AYrfzWziAxmplBetwYiDe9l53OZxQdCD93Rm3efPJT5TsIYBfDXtNj6O+zaE1KaQutActedsgscc/DqtACIaYlV/SMK88aiF2Dd0jNQP9DAnZqtyVSef7O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykONdxFH1ImNbVmXkqbp+clV4B0BGUx3CSlt2OzIMGU=;
 b=mHjB8Hv5OhK4FFI2bZ5UcFYc8mAze+HdymSmpxIFa2l6h3WOW2CgcF5QpuAFES85tZo2I8s3tmt7NZJjCZclCy1zRfWqmk6kPRrUG/5rcIlG3JUMJuRijthB8ajRotx3iMvNo4/mjASqOy9Z/QX/fgG9yLda9aRxtwGYIBCb1fyRtIQk+MyhnmSwgXo5Y2UhGWvRw9T5aHNTiSM6o1ej0ctK+SDSleKBJnSxDiCQzUk59xSI8ga13NeedFcSXXq0VDB8qvftBs0w4k00alNkp/83zzyH1+ShOEQ1h92t9DGgmWUNoXufeXTX/IzM7vBT8Ytu0YWmpv9wD1gv44o4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB2575.namprd15.prod.outlook.com (2603:10b6:208:129::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 15:49:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1%4]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 15:49:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Topic: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18E8oAgABfaYA=
Date:   Wed, 13 Jul 2022 15:49:45 +0000
Message-ID: <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org> <Ys6ZkDUhRZcmvPYy@infradead.org>
In-Reply-To: <Ys6ZkDUhRZcmvPYy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bc0eae6-b8c1-426f-6857-08da64e74f6a
x-ms-traffictypediagnostic: MN2PR15MB2575:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nfRdRhDbEBy4fvmfReT61wFnZtj2kDahZB2ceksx4U/fAQo+3uCLg/ZVMz0j9dm8YaVtcfmLd6qjT80/JJfexcnWoMOFNz9mF7+P+fH1U/+qK58a9tV8MBadaPYF26qa4Nwd/Zd+jye2ppMV7BBoEggqT5VKEau7h4xObcLRfiA83gVd8t7qWzmi+hoKunYFzHpMYHXK8LrNrFT7o4DxFAF5tTRwuZ9rQAMbN9DplAfVujO2hFl9lpz7DJ4EsceK43dhfY+fSUc/SxAWwABpMI8jujB5kvjrUILxuoD8CwvSKRyTpXWsSYyXNKqt71M9k97eIJgOUqWdDs4tfJ6L0Jvc8ZlzrKAXT8RxNnROWeQZYnr48kOa5dHlG35tzhKYjjfYP6iNVNotaljh2bBWm7STvSt0HOyrD/jU+g8h8qXHj/ExO5MpT1r0BMnp5CaWpXEOVnMuDMafdRvuMBaXu0maMdnlwCodyf2qcQIQ0UUmwJDJ3mqG8oNFFCY8kps5WIhm0tpBBvG2rapNL7OqFaN241HU9lY/jj+ORwnUeEv5PrIpBfF1h4xEOGUfsHimtAl3n0+TnYaOhosnH4c9eZjoGlg7tnGqmmvm0WPc1DbWyyrIAK0Kg5C+ey0JmFYWoe3vUOWCxW1UcmgCT9TnEdJut01E9L9t/OzpeI1ei94qXs/VpG3f7npb72Sw4ZuARDEbwwTOJvAQz0OhrRrQTTBkDSuBwX2/ynDTZh7o8e4QzFGiS+4CjtAXmnN4T1msn8DgokqgkPK8TKiUTVPRnD73tHpBgxQuO+7C1pup62ZLdag92/eyNwDeu0O4xZTW9eSF4prxR3HcRMfOD4m6z7tfHpdrEa/zMe6XzaUY/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(186003)(6512007)(41300700001)(38070700005)(5660300002)(36756003)(7416002)(6486002)(33656002)(478600001)(53546011)(6506007)(2616005)(38100700002)(71200400001)(4326008)(316002)(8936002)(2906002)(66946007)(122000001)(6916009)(8676002)(66446008)(66476007)(76116006)(66556008)(91956017)(54906003)(86362001)(558084003)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?op9uKDAlQSGQcrNCw2tSi0Su53uDgLSc8CxoF+FV8N9ZhAuUx7c3drlFz3Lx?=
 =?us-ascii?Q?q8YFDs08OVOTJNPGsfujajcZfASGeFzSUcA2ytkdkVwWKj3DtDaaDmxbcXWZ?=
 =?us-ascii?Q?hd4IVj2FEojiLU2RoRYAVCM9ZrE1yYA7XJIFvhhFJrX4ybDdiLQ4QF3o9RSc?=
 =?us-ascii?Q?MKUgb131YH6HV0Ap+YjBjNSQIe2750Hx9Hs4pW9puSZap7FmW3Yfrjau5ccX?=
 =?us-ascii?Q?OV5U/zlQyfKbu7N9C7PttSU2LtHhIpl1VvMeuOn4z0W/ppGWgcjQ0bpqyNNG?=
 =?us-ascii?Q?uiGBNrRSWP7etB1fwAEyUVomQSvl20SVJPQzm1ITBH95FptuMF0dHL7JONP8?=
 =?us-ascii?Q?aJTARGfBhPzNhNrN+qp7iDCpfxkYyC1Hq43efsgR3O1UvsTj0dXbUusIaAOq?=
 =?us-ascii?Q?Ti91ctwInRI3C/cotxChc8PmRagWWwZigFPcvGj8hyieFO0bif8dqH5VDZwA?=
 =?us-ascii?Q?bz+HqqFlpqFz2PejRYVRa/Sm//GA0z4Np4E30VsVELIgmIJ/geMTAoF4x22o?=
 =?us-ascii?Q?yyFMvGJqclDljZHq4c7o4pxXwi4A8vOqixHZuQw3XDin6Y5OFpLPZyhP/fBd?=
 =?us-ascii?Q?UeE2TtfuIqBAbB4fY9viMrb86qxrJLbx72jSQ6aoJYl5D6Yr0COgH5CcstG7?=
 =?us-ascii?Q?I2fYu4zBHOuS3DWIKEGAgNmZxb7C1grwnyEoNNFVZuLb+Lu2qFWkPrESwnau?=
 =?us-ascii?Q?Nolxg/U+np8krRiPvI2IME7BjqJKT6Tt1Av4W87jQEWFqT2qcNWMYUEju1c3?=
 =?us-ascii?Q?3hkFBw2PRPApxQ3Vu2432Bdk7XeHWvf0DCBT3V/u94AQTizjtueDhTvaU8aw?=
 =?us-ascii?Q?ZQZnRvXsh2I+o25OvLGgaYSdi/GxqoVUiYaqTPiYm6iP5jygnzOxZTzlHJoc?=
 =?us-ascii?Q?Gz4Ouat/2Hyxdp2QV+6NXl3tXJJiICp8ouHpTNLbMQ5bffBAaJ2BHBI1rabh?=
 =?us-ascii?Q?9VHd4YkXh5ugTq0pp+9yLuR4bR7bZN6/bT8MYkv8tw4AXAM2OFpQ1kw+Ekq4?=
 =?us-ascii?Q?t1L5HkV9P31JYwaJ9VLnaiPJ1AfsjlB3RNE42UP2JAr80aJ41+b7CPF2TE3t?=
 =?us-ascii?Q?xf6QerrpWthfD+Z4ekXpEZWPXka/hwI2uUtt4Ix+CTNlGAaEY9AjzvZ1qnxf?=
 =?us-ascii?Q?d1e798S7MQQRs0RbdeHTiImlpRWk0m1v47PkypJHecU7mdGO7CKFtNRU6mE1?=
 =?us-ascii?Q?3mNuHISZFvDRFqXddu6FcMGd/be9B+5ywf+iSvx4nfNmWcx7wgqNxwOG/Jkp?=
 =?us-ascii?Q?trFPqsIu4NCV0K1G5p4k5lKc8baoIO3Stai0GX+PC7gRtwTHZ/xqJlbgHK6A?=
 =?us-ascii?Q?2TV9O3I6ts2qZ51ShebqEoFJIcfTx9vLEnX1ZSaUrlG2MSWsnWGI/y1Nsx0S?=
 =?us-ascii?Q?kwoAUDHQ9KkGd6XKWstWYtAbRo1scusGUhmjTFing06NiFbc4rZKGv1OdElx?=
 =?us-ascii?Q?UUfFF7I6lhZCNAlkBNxcBypgbsjQd1iJ37EcDbK4qTtuhvDanDWkpCPDoP45?=
 =?us-ascii?Q?9lav9KMuZ/XqrMsX9LnfpGr0L1bnU6Y1pvIe0VTK9H1W99o6FJmaUYkjRq8x?=
 =?us-ascii?Q?GOvSesMDdmhbowlXwBZ6/VUa6ySO7LJXdEm1+dIc2l966f3oxKrs3sDD+91d?=
 =?us-ascii?Q?xshV+3G2QETY8aTba2hp2Wc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78A227140EE24A43A728D419B909931D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc0eae6-b8c1-426f-6857-08da64e74f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:49:45.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5j3zvlXm+BIVZmv4+ENiFxJspjPHmFlhtxvfkp9Q7cGYEEILTNiJ8pT/D9JhkEam2dpTfquxks6mGWCKTRH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2575
X-Proofpoint-ORIG-GUID: dbXtYWIVfi265wJK4vtTI0tlNsLMUMF-
X-Proofpoint-GUID: dbXtYWIVfi265wJK4vtTI0tlNsLMUMF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_05,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 13, 2022, at 3:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> NAK.  This is not something that should be an exported public API
> ever.

Hmm.. I will remove EXPORT_SYMBOL_GPL (if we ever do a v2 of this..)

Thanks,
Song
