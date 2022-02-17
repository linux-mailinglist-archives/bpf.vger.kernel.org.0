Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4299E4BA0EA
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiBQNVf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 08:21:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiBQNVf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 08:21:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B572AE714
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 05:21:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HCQB8I027716;
        Thu, 17 Feb 2022 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8pPjBBeL3DwOZ4T7/Oz5mYE9fGjGMxQmNJzQIqT1XRI=;
 b=TOjBA6xa7qH2fh22/H03IjqwIghky9wi0aed6GK2+MsHCdddXkAVCULPWuzpwolBLd6C
 WnKmumPt3YacnUobgL9Unydzouj6+Pm1CXID2iZVHs5P+RvYHBjHPJ+HyrUTRzClad3q
 IgxembNus17THFQSd6D7E3cSbMXDFITl2B9CFifiJ6LhutW/3aiZjvDHBYYijFui/fbY
 a3NSVNYcmerw9EgA3Y6gUPmMGDNpk+4sS7PXWUUn6nmR292oZvAOUqWpaBQYos0DppjH
 FROUNvwtTjuWCJFoVNgtHPsH6RoML9OxWVkwjXpRIf7BzOP2uIGkqDsUlPG+s8GLp0d1 ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr95x55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:20:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HDAZaX034289;
        Thu, 17 Feb 2022 13:20:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3e8n4vy2ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuTmNccdYzNNRxDeIFsZ7BWbW/cNXbhGrET6ZWKm8NZDxOG592HmyCFa545O1WTXnLZiC17D+LYrHFA2On2llrlMSYxKGKRKBIyPyM1ZRZ3RG7k+9fScuIGSRbnohQE8x7DupDJQsHkyvNOeZzAkSSRRnojKAxNa+5yVx8XTNpTKPdDda8zsl5kEzrkoofflvcHs/b271aEgzGQGDQas3k7y8qcW69XA1F7+TJ5oxQvSVQvlQby5GRdfZV/gXTRBOUk9fDsNaJTcK2r/5vG09xh5oqjGQJM2BcDl+tG67r+uEWf8tLYbEaPi7StUZR59UWYev55iu+NZEWe4BmMxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pPjBBeL3DwOZ4T7/Oz5mYE9fGjGMxQmNJzQIqT1XRI=;
 b=McG6L+73HhK5jU/gHnblNr4iRUyadCZcO8i0enCXfnkAAylmE/LAk3SRaDKU5g6xVr+ckgG51mMIld+ty15RBU9g+mz6wr7CsDCJ5jsX0Rz8EA9+dB0XvuV0cmCAzdC2A0E2S57viogCUTex4ggTYzjOA4W1YM+K87X2Fv8R1VJit+Zq5nR4GpA+aQKHEDNXwlWHu/V0d4TlFr5hbMr0GAZd9EtXghYyWYZWDomiMvboI/xmiLCiB9hNck7vsqAIyK7zru+/5b/UJSwet9hFBlRYpto/1UAvhu0yDOxv53/g6kyibiW2qa7clrtPHFC3DRjT7GuViIV4Bx22Ohp2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pPjBBeL3DwOZ4T7/Oz5mYE9fGjGMxQmNJzQIqT1XRI=;
 b=nTNXKS8/qlA+zDp5Eyct4WweU5OlApFyU6VLVs6gexBy3MCQNaKyb8Z9ZX50C+u86NY6fRCicgmvT6IKtmz8N8jftsZ0AkXIltaxyU/2oxuWH3VLhutgX4+B7mwWFuGf1kJtVv+KXqFViErla33HDQgEKepz0GpcW90kKsyv5bc=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Thu, 17 Feb 2022 13:20:44 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::25fc:97f5:a9fb:f7b3]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::25fc:97f5:a9fb:f7b3%6]) with mapi id 15.20.4975.018; Thu, 17 Feb 2022
 13:20:44 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>, david.faust@oracle.com
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
        <87sfy82zvd.fsf@oracle.com>
        <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
        <87ilvncy5x.fsf@oracle.com>
        <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
        <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com>
        <87czlr4ndp.fsf@oracle.com>
        <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com>
        <87pmodgpe8.fsf@oracle.com>
        <5e20c3e3-8074-9a94-ae9c-1ffa3c65ec82@fb.com>
Date:   Thu, 17 Feb 2022 14:20:36 +0100
In-Reply-To: <5e20c3e3-8074-9a94-ae9c-1ffa3c65ec82@fb.com> (Yonghong Song's
        message of "Thu, 27 Jan 2022 08:42:03 -0800")
Message-ID: <875ypdvdcr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::14) To DM6PR10MB2890.namprd10.prod.outlook.com
 (2603:10b6:5:71::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fffa64f0-dd52-4767-4903-08d9f2184d4f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4509649C54F475F514AD77CB94369@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J3insK0sbtyPJECTanhx6/BH2w/PFkDq/RxKTh8YD3SMPfKa1PnrXSWU0/PxuVVdRfCvwZ4yuQluj+PzDlLqkM698wZJxPkMx2TOgySZJVdaEB9uj5h/JrdpNlFGADBgN8NhKA4FTk1Ruz6u+Bc4sEZfSN6AnFwhYv9wBYK5SUa1im0BD7YmXgyj79AT+Y5IvsUt2xffvOkkVUHE1CXRWvifz1DLl5TUMztEY8A6tV28TDmmeh4qEhN3TcnLR0ZNaH8DuDph6GhU5uXRGorGtboMgkAV7U2u/CpyvNS0v9ZTlbnBz5hVoUZQmgtnCrt6gjo6uRB8E58lnELCTwFJQGr6yIO3TRyAnengUy7ax203m5I0PKAraz7uyQqZ+Hz9B2HWOBr3J4uXAn1nkgNMYNDRI8UbcGvG0WR4q41qo9tmFEDwe7705HQfifCpDlWWfS55FCEhn5N2V+CsI98z8I5Lkjbzpw9KXVxdLAW02mtNat/lE2geYiDZWX+JXDJW4oWphX/Upmgtqa7wlTjPAcXPi3UHwKGkgBwJCvIs0J6x6FOUxv9QP/6WAWOCmQwcfWQStsqMC3lm4Gmk5jFnU3h5hmZmZseRLJx4z4LLdlMVsOsqrs7YiTwD4it9uCsPSfHDBvqIhYzuS+eo2KFn4jbzh7FLZZAKLt0o9j50TAcEVFEQTwX4jWmul39KrXHpkW5q618jkhh8678e+3I1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(316002)(53546011)(38350700002)(6506007)(6916009)(6512007)(54906003)(86362001)(8936002)(2906002)(83380400001)(6666004)(52116002)(66946007)(4326008)(38100700002)(66556008)(8676002)(66476007)(26005)(107886003)(2616005)(36756003)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WHi5wIXQSvJ46MyWBg2g8HKJccWlLgOmuzt292okVYaYrFE7mn0M3+sDC5qi?=
 =?us-ascii?Q?o+nVtocMIAU/3BxocHg3Wo2GZIXOk9Iyba2wk85eD6yIpcXqns2b7UkG8rlj?=
 =?us-ascii?Q?If1gBWxiqtmmxwGO35TrjN64pFLB4Gs47LWQNy75TD4fXTk6ji7thVvHU5Ao?=
 =?us-ascii?Q?pc4St70vzh6I4i5+QkuEZofVFSUIufC84g7GaeNqhq+rUrffaiv1ekvudZ2+?=
 =?us-ascii?Q?+dSVgdvKTdxE+1A3OJImQwYkNLhpn2WYoQ/vq0EYfunX9RVB+Qxt4QW0toE4?=
 =?us-ascii?Q?q2Q5+8XbLEcH+ERVLGVt/2+xxelKR9xAUY51WcubYEmwtbP5UKKKZ49ILRZF?=
 =?us-ascii?Q?zr1JQszXavRiqdvSscsiE2D1CtJj6dwxoeZXeBZ8xKlmBwtzeabUxM1z5GLf?=
 =?us-ascii?Q?KbzlqT7yEwgIOeNVClXuvGslFvD2Rv19DD4zzu06VybXweGluXj4yXUkQdis?=
 =?us-ascii?Q?Bi0tDDtgnH1Lx+TYQ3FoWRoQMA2bez9v3IPkYrUIaKFLun+4g69NeieyTiNi?=
 =?us-ascii?Q?MxmryxVFRBNDL5b+ePQCGDqqIhBU3CYXuHICDAIYclg+tq1dkHRtoQREFkte?=
 =?us-ascii?Q?VnYYX5OOWbop3VAQHd35O1AUWP93kAg1cuXj/rRSSaeN8U+Ehuc1gFtjKDiq?=
 =?us-ascii?Q?kbAwqSLcvE1nIanYXKIusf1hPL2Ofl1PeJjE2ZpFaUh5zc5teCzFuhkByAZL?=
 =?us-ascii?Q?GVzaJah1RGZxseuBWcmhMBOX8l5oNWt1KWw2jQGPWWa3fISMiR99tRkiE6Bo?=
 =?us-ascii?Q?9H3dLa2I74yG9U79KnFKVXo2Q7u7FBKRZu0zX88AavFKqg3o4bu1M6KG4S78?=
 =?us-ascii?Q?IHmuRakdL7ySdJtn8Pz99OQGJ9gc41x2/s0cqJo8MT+iGIIoJf0oc9dCuoA7?=
 =?us-ascii?Q?H2XsAdTYXcJAko0bvwee71Jo8XEBNxndS97lHyzqMoz+ccA/M4PCjHcVAZWK?=
 =?us-ascii?Q?tfnlJ/cju80phRLshsY5x2uDNCkSd4MB1KDpdbc9n8kCTZfZASN+6Kv4SL1C?=
 =?us-ascii?Q?JCvxM2Ui3MjWL0G43QsUOos3841Om0OXr2wy5cay3ldGtgW/skFWsqfHE2Ke?=
 =?us-ascii?Q?kcNFb/UtcgeALk0653HUen0vSGpyxpfI1mSE+blyfMijw/90XelLbwklGOvW?=
 =?us-ascii?Q?326usNDUmkIui2prU9BT2asMNh00hyPHKIWnwi0yuCtHKjHVg8gO+uf1BxCR?=
 =?us-ascii?Q?K8hdkO56QbU0nMAv9/jzFyeR6C4Tergi3JJurYdfbwuRr3LiuyDBm7yDdmtp?=
 =?us-ascii?Q?adPlBZkidW3n4HzS0VeFOQnWGok3dCsjm0+nCP0ZeGdMPuHnQHJHjHvnCKiw?=
 =?us-ascii?Q?lsbNQmji/Mcwmme0MKeJxJUG03xpk3UxUQxS8czrAjtUIm6+N2UJjm36kXqD?=
 =?us-ascii?Q?iusBJEfx7N4u7Y4t2ZLC0r7TiK0KhuPtrVBgQ+GWI0gu2/BDB/MnBGzb3tUl?=
 =?us-ascii?Q?SEJzneNEsZ/VfKTsM1VP7ONgqN/HruTsxMAtTqMyQ8SybEZQC63jjEG0P6gh?=
 =?us-ascii?Q?EbAHplHqN0SvOMLfxrXCHAqhGkJV4MPyvYaXl0YvDrEjsIaxR1J73wS7Gd/g?=
 =?us-ascii?Q?97KtL3pjAM6D8AM8pvtSsD/87t1pds8QHrUtmcEBA1CwvTbVKhfjOdvDU88i?=
 =?us-ascii?Q?KvGpWZwySzCOlFxEzxdFwfVAgfDX40wVtBb0bUOegn7ohbWwMf6P45pDPL7Z?=
 =?us-ascii?Q?Ts25xg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa64f0-dd52-4767-4903-08d9f2184d4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:20:44.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F8kEY8lds7PNvYCFljld9m4BwuynPGOKzzuD+RH+24DLNFeYBfSKkJMZmE2wTiFUIpMqoU7Xz4ylTHB72KMt0ykJGYc+9BE3RMvlv4+feM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170060
X-Proofpoint-GUID: 65xoUCjeVE7ZiAjaidT6hYX3m1MBh94r
X-Proofpoint-ORIG-GUID: 65xoUCjeVE7ZiAjaidT6hYX3m1MBh94r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 1/27/22 7:38 AM, Jose E. Marchesi wrote:
>> 
>>> On 12/20/21 1:49 AM, Jose E. Marchesi wrote:
>>>>
>>>>> On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
>>>>>> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>>>>>>
>>>>>>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>>>>>>       as members of struct types.
>>>>>>>
>>>>>>>       The motivation for this was originally the way the Linux kernel
>>>>>>>       generates its BTF information, using pahole, using DWARF as a source.
>>>>>>>       As we discussed in our last exchange on this topic, this is
>>>>>>>       accidental, i.e. if the kernel switched to generate BTF directly from
>>>>>>>       the compiler and the linker could merge/deduplicate BTF, there would
>>>>>>>       be no need for using DWARF to act as the "unwilling conveyer" of this
>>>>>>>       information.  There are additional benefits of this second approach.
>>>>>>>       Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>>>>>>
>>>>>>>       However, it now seems that a DWARF consumer, the drgn project, would
>>>>>>>       also benefit from having such a support in DWARF to distinguish
>>>>>>>       between different kind of pointers.
>>>>>> drgn can use .percpu section in vmlinux for global percpu vars.
>>>>>> For pointers the annotation is indeed necessary.
>>>>>>
>>>>>>>       So it seems to me that now we have two use-cases for adding support
>>>>>>>       for these free-text tags to DWARF, as a proper extension to the
>>>>>>>       format, strictly unrelated to BTF, BPF or even the kernel, since:
>>>>>>>       - This is not kernel specific.
>>>>>>>       - This is not directly related to BTF.
>>>>>>>       - This is not directly related to BPF.
>>>>>> __percpu annotation is kernel specific.
>>>>>> __user and __rcu are kernel specific too.
>>>>>> Only BPF and BTF can meaningfully consume all three.
>>>>>> drgn can consume __percpu.
>>>>>> In that sense if GCC follows LLVM and emits compiler specific DWARF
>>>>>> tag
>>>>>> pahole can convert it to the same BTF regardless whether kernel
>>>>>> was compiled with clang or gcc.
>>>>>> drgn can consume dwarf generated by clang or gcc as well even when BTF
>>>>>> is not there. That is the fastest way forward.
>>>>>> In that sense it would be nice to have common DWARF tag for pointer
>>>>>> annotations, but it's not mandatory. The time is the most valuable asset.
>>>>>> Implementing GCC specific DWARF tag doesn't require committee voting
>>>>>> and the mailing list bikeshedding.
>>>>>>
>>>>>>> 3) Addition of C-family language-level constructions to specify
>>>>>>>       free-text tags on certain language elements, such as struct fields.
>>>>>>>
>>>>>>>       These are the attributes, or built-ins or whatever syntax.
>>>>>>>
>>>>>>>       Note that, strictly speaking:
>>>>>>>       - This is orthogonal to both DWARF and BTF, and any other supported
>>>>>>>         debugging format, which may or may not be expressive enough to
>>>>>>>         convey the free-form text tag.
>>>>>>>       - This is not specific to BPF.
>>>>>>>
>>>>>>>       Therefore I would avoid any reference to BTF or BPF in the attribute
>>>>>>>       names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>>>>>>       makes very little sense to me; the attribute name ought to be more
>>>>>>>       generic.
>>>>>> Let's agree to disagree.
>>>>>> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
>>>>>> come up with the best ISA that would JIT to those architectures the best
>>>>>> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
>>>>>> only. Hence it's called this way. Whenever actual users will appear that need
>>>>>> free-text tags on a struct field then and only then will be the time to discuss
>>>>>> generic tag name. Just because "free-text tag on a struct field" sounds generic
>>>>>> it doesn't mean that it has any use case beyond what we're using it for in BPF
>>>>>> land. It goes back to the point of coding now instead of talking about coding.
>>>>>> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
>>>>>> go ahead and code it this way. The include/linux/compiler.h can accommodate it.
>>>>>
>>>>> Just want to add a little bit context for this. In the beginning when
>>>>> we proposed to add the attribute, we named as a generic name like
>>>>> 'tag' (or something like that). But eventually upstream suggested
>>>>> 'btf_tag' since the use case we proposed is for bpf. At that point, we
>>>>> don't know drgn use cases yet. Even with that, the use cases are still
>>>>> just for linux kernel.
>>>>>
>>>>> At that time, some *similar* use cases did came up, e.g., for
>>>>> swift<->C++ conversion encoding ("tag name", "attribute info") for
>>>>> attributes in the source code, will help a lot. But they will use a
>>>>> different "tag name" than btf_tag to differentiate.
>>>> Thanks for the info.
>>>> I find it very interesting that the LLVM people prefers to have
>>>> several
>>>> "use case specific" tag names instead of something more generic, which
>>>> is the exact opposite of what I would have done :) They may have
>>>> appealing reasons for doing so.  Do you have a pointer to the dicussion
>>>> you had upstream at hand?
>>>> Anyway, I will taste the waters with the other GCC hackers about
>>>> both
>>>> DIEs and attribute and see what we can come out with.  Thanks again for
>>>> reaching out Yonghong.
>>>
>>> Hi, Jose,
>>>
>>> Any progress on gcc btf_tag support discussion? If possible, could
>>> you add me to the discussion mailing list so I may help to move
>>> the project forward? Thanks a lot!
>> We are in the process of implementing the support of the BTF
>> extensions
>> (which is done) and the C language attributes (which is WIP.)
>
> Sounds good. I am happy to answer questions if you have any.
>
>> I haven't started the discussion about DWARF yet.  Will do shortly.
>> You
>> will be in CC :)
>
> Thanks a lot, Jose! I am looking forward to the discussion.

Just a heads-up.

We are still working on the GCC implementation of the tags.  Having some
difficulties with the ordering of the C type attributes.

Regarding the DWARF part, GCC uses DWARF as the internal "canonical"
debug info, and the BTF is generated from it.  This means we had to add
a DWARF DIE for the pointer tag qualifier anyway in order to convey the
info to BTF.  So now it is just a matter of emitting it along with the
rest of the DWARF.
