Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B56574410
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiGNE7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 00:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiGNE7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 00:59:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35020BE6;
        Wed, 13 Jul 2022 21:54:45 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DICf8f009029;
        Wed, 13 Jul 2022 21:54:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=V0wHd+YqMZUYKZzruhkn8Pvhx+6eEHHJhiVDTUkOp1A=;
 b=YdiqcVkCgyGpY0L98LIJzH+KJ0l/39r8ZHpl4qJK1l17735gLNGynvTmDBCuQEIZqtlc
 JUvQ1y1/63BEXLElwYc4CPJa2YDY8az2ci0yF/AMT/gr1ua00bM3BGSHjbbmzDqlLlY4
 mINK1jB1jB8N8zBfZq8y/k09Ftp4uGdrvfQ= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f8w72-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 21:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up5TZjquts6HRh9tdpi2KM92wYj7D+cInTmEDsSK+XKkI0Iwy08GvJNQUM0bGje1yA6qcdR3iqqhE4IIwAidy43hh3EURV9VzS8wevNNxF0x+6SDzzhFuBeRLuzfDzO0d+8k3CGwoSyw0leMep3du/cj/LJL9YuLmfOE2G+miFnpyumq+aDgRg4qwHnyu5ftMCV5DfTpEFFD+AEYWTzdJcvdA1e0BCZHbhKIOl/IuuiCmGM26lJ4nbifWFjSGwWiYaGvS2t3kwbughM1tFVWVCFclSN9Zs7gxQ0D7bWDM2PwM8YjXIrtB97bravhLvyfe2Cke/bKkUAF7SIdVLwolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0wHd+YqMZUYKZzruhkn8Pvhx+6eEHHJhiVDTUkOp1A=;
 b=NEAz/sk4oPwREercaE+a20bWMK40hgIiqisTU0PskJCY5BNfC6oYPBq8miBUjvGBhAPGc/+NNB6ldvj8U6TLusuEBCLiPzfBs831lVfVeJA784RtkuyJHBwcEU3mx0/2vGJ2wuSRJhAfhImG0iE8UBGWj0tn5eszW8blsxGBVqI36MUfPjps/dyJCQT985nsPEqwUe6Qmc8k/JgkVwt8Pesuhr5prSpoqDiBdvGQ1aMo5IGTj+YJFsrDMY2UYfaBXBJ8LDwF8chFvlFS8iAvvwFZ3dlEap2DUEdiMlqHxhPVWjSeq75VWeQsU2NYGKZQq8+eilt8cFc0tlvuu0bA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN6PR15MB1764.namprd15.prod.outlook.com (2603:10b6:405:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 04:54:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1%4]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 04:54:41 +0000
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
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18E8oAgABfaYCAANKuAIAACKAA
Date:   Thu, 14 Jul 2022 04:54:40 +0000
Message-ID: <8AC2399B-F3B2-4F91-B18C-D9D3D5085471@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org> <Ys6ZkDUhRZcmvPYy@infradead.org>
 <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
 <Ys+aVKFJaQd130Pn@infradead.org>
In-Reply-To: <Ys+aVKFJaQd130Pn@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35310173-57f2-4a96-e845-08da6554f649
x-ms-traffictypediagnostic: BN6PR15MB1764:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doAzMNhdqcg+iaZCNKfxUgnZT2soWdVXpx5fCSnYY9Jp9J5sw0VLlMnl2wX3xPiFU82P8YL1hmnWCNoZwqhQBJKJ76YIiiwbds54o/Ae1RHEbnRRtyD2XHk0HY8YAGMW0hpk4tZMYDwJyjE6SnO72M8bDZ4P3zyM+uMASOCvY8HPujX3q7WATZhRJ9Uoew+e4VDEtQnhJlyQkH5I8A1CmiMvA0boN42v9BNT5llPsdTc9rs0ZpK0ODq/IT8JoooIzF3B5wwc7yuY4qmIkdJCmdY3YbBclwfDMifrc6nUXrdCdOT39XDS8C3pCTQ6XBt9Z4v29suRajPMHh31+Dcat2gMk3raW9GUgmVHFZL8tMXT5n6GJGvX99NnESKHl9wqHTQ1NF170cJCsu2rITZ/BPOR3VruWMIlVt2qZlmi5L8HIgo7CBw/yvfSb7Ux9/6Uku3r1DeHK7fB++saZDwFJ0UHmtQ8UEI1x5I1iS5IMcPEQ5Q+87IWb1RWGTyab1tWFF9cQ+GFJnvoovyYWViC37QcPOlkYNqA6N+ynJ6d9h266nzITI71+a7Ihk4Fl1GnbFc06xlOw8T0vw74d7SmLRDQOC3b4LbGrJwF9iLP4rTs2RSANiJRQ5WSIV0y4qUckL9QyunI7R2CuT2I1NHo5qyDsuffpXxCZVt7PX+0q14CCqdB5wZyvHZYA7WVvoCokgeOaTzN8+hrCKuOccMxsg9/+cZkKmClyg6lzTiQLHMpq0ajeVZVVHjAbNNMU1R5CNpm3TGZ6Z0zX47hpP6ORbcWAsL7qIbX4Avwi3/iQLuSW1P59JcHUkvMgst0CwhtDnBroDklnGpuC6Z4UZbbhiBMjaSBXIZmCrANbWSfiYCGATn6TcXQtgx68bLd8RGO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(966005)(76116006)(41300700001)(66556008)(478600001)(8676002)(71200400001)(64756008)(6512007)(66446008)(6486002)(6506007)(66946007)(91956017)(86362001)(316002)(6916009)(53546011)(54906003)(66476007)(83380400001)(4326008)(122000001)(2616005)(38070700005)(186003)(36756003)(33656002)(8936002)(5660300002)(7416002)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iQL943EOKpXWgcDfStJ3ZHK102GmBZCFOrsyyouEYL2esxqmtvkyqGFETBEv?=
 =?us-ascii?Q?blrJd8xizL4HB7YKORG4Bg7fS9Iwbpc/EdXyFBbFUTJHI/yqJ6DkwO4og3VQ?=
 =?us-ascii?Q?3C+Bc1CZFIaVPK5ZcZdv6EmQLCXjPKJgfKYQh0rIc5U00u/jD2+ViVzKvcPX?=
 =?us-ascii?Q?659acBr3t2wLDofKEmQR5QF/dtWAQ4d+jDrc5I4bA6AyS5KobpBh/2L227RS?=
 =?us-ascii?Q?RBf8kN5dBjGoLN3XwXfJBH3p7PcYW+Mo/eI9oG8s7Y/qcEAxGukt0wHE+w1D?=
 =?us-ascii?Q?y+GjWBBVCS2/RgxrhLMzuoL650Sqcmj063jvjHOUyFe5nH1uMn2uFKihodkV?=
 =?us-ascii?Q?UBOH8Xmn4B6FcalTWPl2vAcetcpihbA6EMMr75l6sxE9mFqtn5WcPngyVFoc?=
 =?us-ascii?Q?TSZ+EvNIbuA1EpfCXpohivB1Mma542kJDM+mih9u8fA701QX3QdobOkmrq95?=
 =?us-ascii?Q?sLDI/1uth6MokYLqMSYFRK/grCwkbbAQr1utdvELsGdMfd/s5LdATwTOZOY4?=
 =?us-ascii?Q?7IIQjp+I8vFcFzRxkTD+uFK/gpPa8DVA8543aT+LskZ+6IGBgDPy56Fwe/cy?=
 =?us-ascii?Q?2D79dMGYRVSG4i0HFBrO4+p+tb6w+AV3BZZJf3XxGI5PLBjyB0+4bYtyNsxN?=
 =?us-ascii?Q?iy1F0FTZnQ5u9uBmKC9H16n7gzo2khFcevNksjyuH1uC33R7kDDiGVHT0TCh?=
 =?us-ascii?Q?+NGrrFrumJp+qkerVhfOM/cj61bE0o/sjKOKSZ6jxcO6DSMQiyo2z+qEZHGw?=
 =?us-ascii?Q?Qv2mh4kbTKziKFjhsUfnzCzGD3emtMl+v2qP9HSH7QxZ//iMRY2Gr1/Kj7vP?=
 =?us-ascii?Q?41eVPtqmsFiq2mSvje1blEZwpgiY8s3fK8JKlViQCTjAM6yi0EfyW+GHWvU7?=
 =?us-ascii?Q?CKgpoCJ0GrD+0hO+Xt05n89FKdVYugUGACMcmpUk7+2AumgN68U8klzjl88X?=
 =?us-ascii?Q?mN15PLzIt+JtS+6iir++SDSuHxX6bJVNjPsm9Y0RsMXGUryU81jxPdjN6eHw?=
 =?us-ascii?Q?4xSL3TzQlV2GX1PHDqzZQ9MywOlA7V/O4SX0r/hAcJFjQydD6qpj8UWGoNgT?=
 =?us-ascii?Q?YAMzGo0DhATRNjrZ0GB4TtByuVQhZYykyuo8KPLrogFt6QQvlb3iyYK1fWKT?=
 =?us-ascii?Q?5YCe5r9hjUZTYGdJunngQEErlFRzkfVD+Zb9EEgJBsIlKuVRYgZ8dA9CBPKa?=
 =?us-ascii?Q?neuXlNceS9GmUovJMqwsNDjT5idqTSF9zwz/fzOgIDB9uir2BCrqk9JHigIb?=
 =?us-ascii?Q?xrJeYX9y7aW8YJnLCuw5yHpQcBMqdnR2jRZkCNg8Cx1UpAwvXxNX1d5L2DzE?=
 =?us-ascii?Q?Zq8OIlsCSQEIbBdlmXU/9dhwBitSBOro5sX4zBN4MFOL+OGZs8vj5F4q1yzh?=
 =?us-ascii?Q?rIjnqoVeqCzRWQEydUq6NN59dwLfLCGTsDDPTliZbFFezi3k1IG2Z3r7k6tb?=
 =?us-ascii?Q?J7v7EBHPUW9iV6ImNDGO6JlLFTe0SejoG3hsT+9BXZ4GdP0qlVvCwkoZDw0x?=
 =?us-ascii?Q?2I/gDI/yT9BSB16SYI1R+zm25YpCzPI1LOEd3d7sjPOjtxFM1G9eM2qsjf6x?=
 =?us-ascii?Q?elKsjLgcpF9SBIIrhbov6H8UIgyIt7RMBQI1Lc4EgJre6Tk5EPGETb+jbutM?=
 =?us-ascii?Q?NRUc2eneAVOY41leNRGH4sM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A067FF11929B764BA085D22AFB80AC28@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35310173-57f2-4a96-e845-08da6554f649
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 04:54:40.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJaw49qNl/A4R6+tY3kRgffNoUQc8jDDESSG84KBjZp8u371jyTFLoH2BwiPD6h0w4lfHkxcZD7KIqx3WAUnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1764
X-Proofpoint-ORIG-GUID: lcxUlixPYWoj6TgcDrQHi5UwiefQxS2v
X-Proofpoint-GUID: lcxUlixPYWoj6TgcDrQHi5UwiefQxS2v
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_03,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 13, 2022, at 9:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Wed, Jul 13, 2022 at 03:49:45PM +0000, Song Liu wrote:
>> 
>> 
>>> On Jul 13, 2022, at 3:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>> 
>>> NAK.  This is not something that should be an exported public API
>>> ever.
>> 
>> Hmm.. I will remove EXPORT_SYMBOL_GPL (if we ever do a v2 of this..)
> 
> Even without that it really is not a vmalloc API anyway.  

This ...

> Executable
> memory needs to be written first, so we should allocate it in that state
> and only mark it executable after that write has completed.

... and this are two separate NAKs.

For the first NAK, I agree that my version is another layer on top of 
vmalloc. But what do you think about Peter's idea? AFAICT, that fits
well in vmalloc logic. 

For the second NAK, I acknowledge the concern. However, I think we 
will need some mechanism to update text without flipping W and X bit in 
the page table. Otherwise, set_memory_* w/ alias will fragment the 
direct map, and cause significant performance drop over time. If this
really doesn't work because of this concern, we will need to look into 
other solutions discussed in LSFMMBPF [1]. 

Thanks,
Song
[1] https://lwn.net/Articles/894557/


