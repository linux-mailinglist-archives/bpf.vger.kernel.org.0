Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E13572EDE
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiGMHNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGMHNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 03:13:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045926323
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 00:13:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D4IEZw003002;
        Wed, 13 Jul 2022 07:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=97ZdVe2DUD5sjFd57jNPbsJcimxC8t+73bGzfXljyQQ=;
 b=PLWaKAGhvF8e46pcWFw6kqIhH+bdFLI/Kj00Qwgfm/xWkfGyiRU1rRyApLT1OA2dMtyu
 fTkT3LJXveb/HtnRmt9KrlX2KcQAKemho5PxDGiEaUWF73qTmbVXg21d5S5lRF1Ys/JI
 BRWm9+RzaCSPmraE9t1UscOR1gv7Zzs66wF4h7h0aFBcJXUndBQXjSGDojAgXjSVnuQi
 35EJkbw7rRdSrSBA5kqS63opVHm9Dt0Uiv9QKTNn7NhEtycNLDjtIqLhniapYU8BMZpk
 2dObLGmHDY62b4bY7yQhdJ6/3F5ZtfMJJ4Rg1Li1qn+9gpMcx/RroA7a+YwZ2Mw0TXiB Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r192ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 07:12:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26D7BSo5001883;
        Wed, 13 Jul 2022 07:12:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044nw8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 07:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLd4KuKkwEvj4xr88qFRXVOP9UZCMrNcSL/CBK74Q3jo8CNTp8kgpqhEt5ACX+a68KPK/scwJmE/mthOtU1SMzUb7+jLVETo+1B1ZLL7OKW4E+/U3x184xGRV1JUgCMLXv8VkMPZuukGJG32uPWFqhZhpZ+07OenkXmR7NqWyyag/DEp9+p6SC+1LSt7DVD4cadZBSVSEc2/toDdRsrP7WE0AcGVUOuxizPmpXX1BNnGQVxO7ZExWUrEOYWK5p5vtNDZxYs3kYLn3atD6KBGlDQZG5mEHG6m1BIBRtLI+gypQqMHWi7TPd9aRjQXbpbWxd9WxQMcjYC/iLooDTCx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ZdVe2DUD5sjFd57jNPbsJcimxC8t+73bGzfXljyQQ=;
 b=NWqthXv3uD68Jm7hT33N43NoaiQH2NYOCS7fnKcSGDtVMWKt7h9OLAvnmUrq1ym7o8g6oghtje5ovDpx3Na0cOpsVxWLpj9Oy0EgxY+6T46RxDVJzF9rdk4DGrIAIJ7I0FwuUdyTMT05G7sFZoIsERUHfjZWQ868DCDczOx2v5EQ7S1md3se54zl//oGrK8dNbqVK66nZix5rgjq5JoOm1bT76MYZfFVCExu6U8xOLnJNus3VggbiNqWlkn+XUpO0u2QPYEhqE6V6Oo5eOSGu6z0N/Jv/vi9rS7Y3gG16IIy5iKQi+XkD7coM/n82ZPBN+/Z1PYtWlIGNJqJhaSsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ZdVe2DUD5sjFd57jNPbsJcimxC8t+73bGzfXljyQQ=;
 b=egmMiSLpcreAd8i5qki6l9a/5pieR1tCpxFSitMna4WsdM5/nq+9IzYyG+8l+JqW8x3BENW3o8Ygyb73IIGzluJ84xCXyGNwAcO/9kIwUilNf9mOi6uXDor43v4CIrcHom/Ic1QbsSDzOeSX/zwax4wU7VNNW57KH1k89l56zAo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM5PR1001MB2361.namprd10.prod.outlook.com (2603:10b6:4:2f::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 07:12:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:12:45 +0000
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing
 support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220707004118.298323-1-andrii@kernel.org>
 <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
 <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com>
 <cc50280e54d463d5da703e85770c87ede3f2655d.camel@linux.ibm.com>
 <CAEf4Bzb=oT5PzYjM+aDeAg76yB8KpROWcdanqLZ+G6qtdFsAqA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <eb339ec7-9d7c-b96e-179e-b84751499808@oracle.com>
Date:   Wed, 13 Jul 2022 08:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4Bzb=oT5PzYjM+aDeAg76yB8KpROWcdanqLZ+G6qtdFsAqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a20f7a-0d13-484d-ccb0-08da649f1587
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2361:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtJjvlydysata4JX5KkYr7utl2U1d7/kbDhgWYi0sRDIOACLakEB4OaIPmwcFTe9JJbH/5NIqcaWcWh7HHX7EbeeWeGhiz7bTcUoMUtlzXps0pTDHhRZuh+DQB/LFgxcEznWfsRhSFqPQjXjOTIp6zysuO2ISJPrUMAKK0/diNdHE+3E34tnanEcumApFbDrP377mQ9K7pdVyLXXko4Kt/H3KE2q09YMGcuh2hccmbW4dGMGBIY7jK1/Vqi6thtiQ7R04iuJc8H5RSYGIUzaEUVg+5LEPmmk7IWwVfaRT/rjkdwHpyE/XAraq4XTGWBZqlic7OpI6U5WV2fhwi953RB7yrQ0Y/pjMDEX0FG01LkZTYsKEmzfbBxxA314YHhzZrFBKwvb3vmyHPIdqEZTn4k5gfOM9s4ofWRS5rQP1da2h8BoJz9NjA++m0DGFtgwGFyFLWJOc0WFTkujpaucuSUGxCBYhSE0ILkokMKtLWMmsHIUWLCkW459jqPArShPG7C+ytdhXlpB2LXSH2HuZaZQmk6k9NZu9BrGxpg+sYGOhA9SC1UAMn+CcYsaPHDqbmLWYNSUslxpyU/GIW+AvhNV0LvmkPzMP3/6UBhhdozrLppbBY91cvBwtxB3SYypyIDpvwroKHzaHfN1x6R7JOLPSxcz0W3EW0QyQzDPyINrF7ydzBD80nf86Jw/xRj9PLDUspcHK1iuwBhYjE9lxlkP0yfV5G+gKGq8sfDlc1Y3mPoJOe9Kjd5UAWT3FaqF+Pjxn2GbfoyRQdGciUlrZrz8ZrAnqA4VDfYhbXEfMW/Qcn91D21GzQIIEz/uAbeO7htwJbTcJYwhA1icQ6xCqnooD4S+/VOF3WtgG6Majtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(6512007)(41300700001)(4326008)(66556008)(31696002)(52116002)(83380400001)(6666004)(66476007)(6506007)(66946007)(8676002)(53546011)(8936002)(54906003)(110136005)(6486002)(2906002)(86362001)(38100700002)(31686004)(2616005)(36756003)(44832011)(5660300002)(186003)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VQOWhuWTk2Q3h6NVJVUEwxNmY0MUdFMlN1eVkreVF0VEc2NU4vK3pmUjUv?=
 =?utf-8?B?V25CM2RGcndKMUcyWjVBSjJLS28rMmJsZDRlRFVLTFcvbkhEbjlPWlQ0cFhu?=
 =?utf-8?B?L3JjTVBzcmRaVUJrVE5zZWlwbW1LaXR0aHlzMlZlb2oyOTdLTlBvK0dJMlBV?=
 =?utf-8?B?TnRYZCsvUVZPUnlVRjVTNXdBTjkxRXJLd250R2dRbDFDb2QvRVV2N1NTWHd4?=
 =?utf-8?B?K3I3b1MycXJUNktvN2t3bkhTa0NBNnVjbE85cExXTXREZDlZZFFyRXRCSmNG?=
 =?utf-8?B?eC9kRS9SdHlQQ1pERC9qVXZVVFpidXhGb3RwejNJS2dhUlpUTHRoelh3a0Y5?=
 =?utf-8?B?Q1B2UjFJQStqZGlqb0hFdzBraXNtUXQzSmlPeEFYK25wOGl2cHB1N2c5YTkx?=
 =?utf-8?B?bi8zSmNHSmQxUnBhT2N0M1lSSU1NRFNaMnRrdGpNRmM0SHN0aVIyU1JqMUFh?=
 =?utf-8?B?Rnhjdk40cG82SXI4T0xnNXBSQjFMLzBmSGd1b0F5T0p2VTFuKzNQOVl4OFNs?=
 =?utf-8?B?RTJqVTNOK2NVY3VHSzFzNUNWQU55bHhBV0FkQWVBb2lNWllRalZiRnJqeGc0?=
 =?utf-8?B?TmYzS1ZLbXYvUEl6Y3B1K1E4OC9mNmQ2dk01RU8wS3FZS2dpbTRHcHJUSHlQ?=
 =?utf-8?B?VTdyTE82ZVAwV0wyNTlJaWJZc2VkUU5pdjdYcllUMVAvelRuWDE4UXd5SUEw?=
 =?utf-8?B?UFYvVFBpUkl0SVJJZktDRGZIcmw4U0ZmYmhZUmZ2THk2VU1wbHFCSm9jKzhl?=
 =?utf-8?B?eUlXNXhNT0dHam1xVmY5UStCbHUyVEJCUk5vbTR0OE0wOWFING00N2NOdDhM?=
 =?utf-8?B?ekxoZ1NTemUxZW9BWmlENnFLUVN0NlZ4NzZXQy9kR25qdGd3TVB5WVJMb3Q0?=
 =?utf-8?B?TEdkUlFEZVd2Y1VJaUw4MUVFbS9iY3IyeS9BZVpvZlM4NlpPOW5QcDFmcUJW?=
 =?utf-8?B?NkhqWFZQMXdtdGJySUF2M2I1K3FRMUdidGd5ZDhaL1lHNGVvcG9tV0xGVjJq?=
 =?utf-8?B?VGtFd3p0QldTUjE4UGlabTRpR1dYT2VhaHpmakNMZ3RCZkpEb1pnSDRsRXh0?=
 =?utf-8?B?dTBabE5BSDV6OGF1ZklIMDRmdGRkb3o0SGpsZVVEcklDOHhvNmdENGFYdEdv?=
 =?utf-8?B?M0JzQmlFNEJYaUZ0L2ZqeWUzOWFBeG9BTWdvY3BVOTdzWU5aWkVaQ3Bxb2F6?=
 =?utf-8?B?bGd5V0hZZllWUFJnTTB6WHRRazBCYzhUSzZtZy9kd1J2VlRvRExHcngrV1FI?=
 =?utf-8?B?T2R0RVVJSExvTGpRdzdLa2dhVGRRcmNPOWxmTzQ4aGdVK2tqTjVwMHRSSGlh?=
 =?utf-8?B?VXc2Y2h5cFNaMWFJSW00RVYybGo1YWxUSGxSOUVBQkFWdGM1U1RiNitMbzdw?=
 =?utf-8?B?azVPaDhCZ0JZK1pWcnRGQVpIKzY5Ny9RVmxjMmlyL09vaDJOMmpmVjlHUGpF?=
 =?utf-8?B?dW54c0NITmdBUUNMYTB5QWd4bDRhQ09ZQ0Y0SVlLbUFqR25LS1VRdW1xOHY1?=
 =?utf-8?B?TkY1eUh2WXlLc2NjUFpwdjNUYk5ibDFaQ3c3aDNad3ZERkxpV2lqc1lGd2JO?=
 =?utf-8?B?QjU5TWF5aU5hZm5PdzVORExlUU5LeExTNlY5OTF3WEJPQ3J3eUhrRzd2cEtp?=
 =?utf-8?B?eEFUdVQ1OTUzUmNGYWxEVmNhVDBJL1BESG9OQVlRSUdVSXErMEZ2STMxQ0dw?=
 =?utf-8?B?M3NncER5K0NEamhDaDYyNTlQQXMyd2dhY3FVSEdUbUZ6U3hLZDVpVHNEaG1s?=
 =?utf-8?B?OWxFUWlJbjZ2QkJDak1YZldPYmdvdVNIb1BNYStoY0oyN28rZ2hsWnRRVUJx?=
 =?utf-8?B?WlEvZ3pIK0xGdytaS2JYUG1adnNuVjJGWm9pdVBJQit6WTFVTGk3U04zVEZB?=
 =?utf-8?B?Z0UrZmJCTWJaNEkxb3IrTFhZWXV1OE1tQ3FTQlNEUXV0Vm9OQW9QcG90YmRm?=
 =?utf-8?B?NEMzdzVyYmtVOEprMnRsOTd3M3l1cC9UV2JCbCtHL1YwRm9IcGc2Mk9jSCs0?=
 =?utf-8?B?R3hCQzdWSkh2TmI3SWZaSWdHR0hTTFpMUVBlSXVrMEVSc0s1SEN0M1lZY1Qr?=
 =?utf-8?B?U01CQnBOTWhhUGdjQjJjQ0VnMU10SzVJUDd0NStQblZjbjFGUnMrdVVqVVhk?=
 =?utf-8?B?VTQ3QzJaRlNDQTVEWFZFTHUwaGpQUUV4L2M4bFhST3JLc1VsSFp4L2ZrVk1q?=
 =?utf-8?Q?JxQ1jEJtsl0vvZBKKIGQEY4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a20f7a-0d13-484d-ccb0-08da649f1587
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:12:45.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlA97sm4FI5ZBHpqu0HBE9yd5eydjsNZRvxjb3/dxU9fdApvjxT+idzThGU5zGW4RTzTTgAJgqg2I7lDHHdoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2361
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_01:2022-07-13,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130030
X-Proofpoint-ORIG-GUID: GIyKaC9RIC-RGhBW3aEASWJ_lQq0KuFR
X-Proofpoint-GUID: GIyKaC9RIC-RGhBW3aEASWJ_lQq0KuFR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/07/2022 05:24, Andrii Nakryiko wrote:

> Sounds good! I'll add that to bpf_program__attach_ksyscall() doc
> comment (and to commit message). I'll implement those new virtual
> __kconfig variables that I mentioned in another thread and post it as
> v1, hopefully some time this week.
> 

This is really useful, thanks for doing it! I tested on arm64,
only issue was the tracefs path issue that I think was already
mentioned, i.e. for me it took

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4749fb84e33d..a27f21619cfc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4685,7 +4685,7 @@ static int probe_kern_syscall_wrapper(void)
         * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
         * syscall wrappers
         */
-       static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
+       static const char *kprobes_file = "/sys/kernel/debug/tracing/available_filter_functions";
        char func_name[128], syscall_name[128];
        const char *ksys_pfx;
        FILE *f;

...to get the feature probing - and hence auto-attach to the
right arch-specific probes - to work.

Alan
