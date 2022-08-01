Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306935873E0
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiHAWWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiHAWWe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:22:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41543E6D;
        Mon,  1 Aug 2022 15:22:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271MEUGb028796;
        Mon, 1 Aug 2022 22:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QsW/rk/XF2CA7UHOFmOLBneOLNTggfo3Hdsj6Asf6pw=;
 b=TqlJaOl+9Um5eEtxmlc0+CCTm3ogZqMAd7nkeZA+XliXzX1tnQIgGpCByL0zknMKPdMA
 Yyz7jEoYPSE0dQQUHEbEGwWdsI/RK/AFM7Dn20kAduTg9FZV74PZyJhrRnD+WptXyNGi
 mfsSaqGLg0gee3r/zjc9FJKZBBsNNmpkmQ3gFG+qje51gDhEMqghSBaqK3hPiO+RZh7A
 T2F0nuaHk9wSEEnnpyZUzq3eVM3X1EzKDOOpJ8wiX/kSDoQlPOxal4bp1VzcMpm7x5iZ
 Io3XJt0NkszbCMHe9m7UulJ6U1pLOP0NhOCLbwxwzUbRf4blxMVovM+r/+y+SyjtVll/ tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80w4ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 22:22:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271KCk0P003887;
        Mon, 1 Aug 2022 22:22:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31qrnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 22:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqysgw5O7xyibjE67BFZGDf6i/P2HusL+y+p8P8zQT6XASoWrbv/bR9hgg2H61ey5pRKrFVWKEjo9/PApMgkPA0UxEiabLy/mpyVaOXgR/mXD/jh+ynO5hsWCFxksNyEu8MNkf7+c0KXBjgI8RJ+Rqq7dT4o75fVOHyl+W2lhZTp1oXmkWxXpuFoZxmmFVPoyY9TrMw6nHWPSdG3DXRxtciDWQum1kbHpJi09OvZvCOLwMWdvpQ/7ViFZMqk16Vb+bc1oVG2vIq7wARmKoX6JMtRcdvOaCHyYQEtvc5Up6HuTBibkDi8QcvbwmAP1T2Up4/tkH8rzH8KC3pLSp/dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsW/rk/XF2CA7UHOFmOLBneOLNTggfo3Hdsj6Asf6pw=;
 b=Jz/Qwf5PKmqffKcQMvlfMerwe9DqTDmhx6KcZqcG2m8St4DXQeH/tXbMGlu6AznNUKpg+j8y2mY5U+NVDypk92kuJ10upm7tJURm0SXY0dsT7QuksoY55zZene0W+4O/Z7cQ/SQ1hQsMsvnheAtxzmZgmLKdkg+Zhpi8bR3Gz2rKvmma2nsNqLrDBRG/42AeCJcUdSe29f/Z8hE57cFrIqtIUrs2qqSP+ma9PaCjOpNQWbVsELQAWVoSZZ7VPoUfl6lZQMBO65lG9jYdmSe+eKgPcZndDplyRIhp5ubDcN1daLjOXc1dYHkU1ghZTX60vO42yO9NerdXRAqXDGF5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsW/rk/XF2CA7UHOFmOLBneOLNTggfo3Hdsj6Asf6pw=;
 b=YJe4mu5nrTHCwgFoHW0Sx5nwWN/Mh+fmYrXxCzZjBbo7Ie9UJ5NeLh0Az33IyLr0wjSeJHAlmb2kNKejRRNCnLL2EtYFZjp9KCpA7df2EVK7fXz1yGHFGFgqfkcQ+db8ZpzDZPFYwvFeybVFoQYOD/ZZIrH7GrpVl1AyY/x1Sbw=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 22:22:04 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::815f:640c:8792:186b]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::815f:640c:8792:186b%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:22:04 +0000
Message-ID: <2dbffe19-6b28-2ce6-b367-960f2250a12a@oracle.com>
Date:   Mon, 1 Aug 2022 15:21:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] libbpf: skip empty sections in
 bpf_object__init_global_data_maps
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220731232649.4668-1-james.hilliard1@gmail.com>
 <Yug2iYQyd0TNlnHW@krava>
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <Yug2iYQyd0TNlnHW@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 319da031-ed55-4cca-6e37-08da740c4309
X-MS-TrafficTypeDiagnostic: CY5PR10MB6141:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcLYnV7QRlDxOzCPTnlajkdTGyUQP7hrOKKja56n0CZACVg6qU82I4x/74M3dN1XDAVbE2Y7QMDlDb527R9Swx3BEUo10xyyMnH1zn19uTk7PZi+T2+37zkFAx1JOppPP6fHWd5uj54sAQDXyRxAr8PV79EOz2cfHsV1FtPeMDs5PMKXU/0bm+MfLbrYW5Y22fEI0TfIfVfagiGZ1YVkD/yvs7yBE5N69xUhRv9SK21jp+pX1NxT8TUOCvMxRhRYLmzeBltfkTCGvH9q4pNl4vjBs6oZ6BxdApWVCiAmjAhrVBIQ9yfWYtbbitUZ+IE5ookuy5JduqJh8ynZnn8He2XytU6KphBZ18iphO6LLXidyYt0nBMSpWB9tdjpSZM/aBGGuKoFtmjqi3nmhBaTk8QLKXKvWzH29xWNIcf34e3WpFuNDzaQVZHVQeSIMn5VEN9kZydU2eGXvzNAMbLxQ6tnpV+eWjO6qCLq2fCMFtVhaFhejW6a6AORGTcs5wjX39O8wAV6dFt3dKblBTjs0ZE+rCAwryOz8RqCbMhLdGUaGwsXsb99qy0hCCTWCH7v/QpXyVdYj0P1OAD4mCd3VI9YFfjrEBJ8vp+T9NaEt8bDBIQ7CTg0suWU1+MeFOzp4v4DD2BDTvfNz5+pzr0DgbP7R5Yx7Df9+bdLeqZAt55JfjC8TGzAa8VWh4FprVHLq+YL7V8w1LxkInfoJJyGO2cbHqRToWJ62fkp2OvguBiDhMGDW6cF+ak7Z/KO+VoZomBEltvS/LSzVxKQ5+zYtw/E67C5AoiPQod5tQcpUTmspRvOdYxfR2a2UdmEchj9vzmhmRrB5vGHSUuoy5YGbGbeFtTnlsTlSB5hvWK7zfl8bvRXB2ITWftNEr39tT9Xn/+Qv5Xhj4C2rhXKPszd2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(44832011)(6512007)(6506007)(2906002)(53546011)(2616005)(6666004)(186003)(41300700001)(86362001)(31696002)(8936002)(38100700002)(66946007)(66476007)(6486002)(66556008)(478600001)(4326008)(8676002)(54906003)(316002)(966005)(7416002)(110136005)(31686004)(36756003)(5660300002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1R6b0Uycmo3Uk1WMlBaeUxkbkdsMUMvd0ZSVmlZT1dNWm5zYkpadmh6dyt0?=
 =?utf-8?B?QjZjQW1FNWQvL0EvYlNROU9GSGx6SmdyQjVTZGIwMW1oTzVmTFpUMkFKUlM2?=
 =?utf-8?B?dnJBbklJVE1JVjRWaTA0R1pEMmthMEVoOTV3cjhGblFXNGt6MnM2QzZEZWdS?=
 =?utf-8?B?TDIyZnIvVERnaVV3WDQ1cHFEMlhVNStGMHNVOWh2UjRQbnRNeTk4Y2Nqc3g4?=
 =?utf-8?B?VE5YWHRnbFNXRmNsWUZibWR1NDlIZ0t6NExYUit4TE9Oc2ZHVlNNcDczeWhs?=
 =?utf-8?B?YXB4aFU3RkJ2M0JKa2w5UGxGdStvb25jVnNFYXV2QW51QU91M1owVzJqaWM2?=
 =?utf-8?B?dnVvOUtmclFKZnhuQXZpZmpKNVdnaTBRNVF6eEtGSWhGZzU4cFhZbFY4MFdx?=
 =?utf-8?B?djJKS3Y0TFdQMGF4ajkyZWtwR2M5UUVsTTZEKzVxbTMzTVJKUGN0Um5GM0Iy?=
 =?utf-8?B?bk1vaGVQb2psM0VMME5iYmRnWEpabm5QajdkZmNoV1U2OTFEc0dpOUxoc2RK?=
 =?utf-8?B?SXY1UHhIOEdyNGRac1RzRyt1NXZYczJqNWNtMGVrNDllUW5xczIxM3FDVzly?=
 =?utf-8?B?Y2xaZThFa2Z4V3ZFakhCK3JpcDl1THFndU1jYm8zZXBHb0JjelJuYmNEcDVB?=
 =?utf-8?B?VzNmRHQxaHVSRDdBZ1VwMUZMUkY0aS9jVHUzL2huTnp1cnBZSm5Wbzh4VjEr?=
 =?utf-8?B?RTBXRmlYWnpKTlpjemNyQ2UvQmJLWWNrdUFmU3lpcWdlaXVpSkg0YnJRWVJy?=
 =?utf-8?B?TXpxSEh3cktsdFBBRG1JOWxOMkdDbmpJMjI4NUcrZ1VCVUpzUXo3aTMyZjd1?=
 =?utf-8?B?aGZRdFBuNWMvTk9qSUZFVVVHcW9RTTZDZ3h2cmwwZE0xejRVYmNwL21XSTlW?=
 =?utf-8?B?M2Jnc2t3QlhXalo2cThrMmRabnJUUzZRbFdXcVhGMG9UdUozYnEyVVVqS0lN?=
 =?utf-8?B?RVU3NzYwd1REZWZBVElYR0dzak5CMmRUMzRUMDc1RTRiTEJrRW5QVEp1REJQ?=
 =?utf-8?B?TXBjOUtER3h2UExnMWRWeWpQSmljZXdIa2pwK2FhLzZmTElEcHdTc0t4QjhT?=
 =?utf-8?B?amduMG8yK2FaOGtpcGI1ckRnNG81enN5alFQQ1dBZmhUK3Fra3JaUTYzVzZY?=
 =?utf-8?B?eEZocnM5blJTaFYzbEsxdENwM0lYRzU1b2UvbkVtZ2hnZmxpVEpobW5sd3BR?=
 =?utf-8?B?VVVaeHE1YXE2QnBtZnMvNUxNaUpUYVMrNEpodnIyN0hnQ3gvSzJ2RFlLYjZ0?=
 =?utf-8?B?TXdkd2p0SG4rUU9EbWl3Z0h1VjI2aGxaQXJ3QlBLOExzSUV2S2dWQ2JBTyta?=
 =?utf-8?B?VW95RnBHbElGSWZjcytKeWRyT1V2eVhNeDRBU1QrM041RHNRbTZwaXRqMGts?=
 =?utf-8?B?bTcwanZOaXRRTVp0Nm1YMGg5MGdtSWFZMXBBZW5lUkdwUEpSRWduaS82ZnJF?=
 =?utf-8?B?dFA3WXpkQndiZ1pXYnN5Q0paTU1LN1VQeUIzVGZhaVN0TVdGR2FqWURJaWxV?=
 =?utf-8?B?cEI3YkY2TWZ0K0lDemJwWVI1R2VZdGxWMHFETVNjWkl2Q2doSVFtVVJHblFG?=
 =?utf-8?B?WXVnRjRKOVUrWHQ5RmUybTF1K2dQUnpzUzVtOUpicHlrQUtLai9mVy92bzlW?=
 =?utf-8?B?YjF6ZkVRN282WWlDVHN4dWZsRWFhWFdRRStiK0V5dVBmbDFMd0JabDhDLy9U?=
 =?utf-8?B?ZFNJK3NYaExmUmwwRm9XSGR0RllMaWV3bzBUVnhSOEw0dmJTVGV4QUZVRity?=
 =?utf-8?B?bDFUQlRJU2hIYWdwbXF1RDBMd21FMlNSZXhkNDhHWG9sRDRwbStIdGVuaUdR?=
 =?utf-8?B?ZE8rZWt5WVZSNGl6UUR2amdlVk9hd2tOcWY2VkNYK2NPNXZQWW5wOTlST0Mw?=
 =?utf-8?B?dUpLdCtqNDJqVkpLQjA3dGhBSldyVjRZSTI1Qi9iVktHUWJ5anV2cmx0ckpJ?=
 =?utf-8?B?SlN6aVp0RzZrWTNqdlptbWRWZTFWaHZNOTZpanM5NldqaGhwNHJlNEdnSCtj?=
 =?utf-8?B?aXRXQVlFaVV0VDlWclBFUjl3SzFhNzBTT25KbXFWWVRtbFZCRmxRd3pud2lM?=
 =?utf-8?B?dSs2WVJTRlR3RUZjMTRibDUxdkw0eTgvR0NFNUg4UndRc2w4VW16dzRqY3ZY?=
 =?utf-8?B?VllqcTd1cWFSK3FXZkUzQWRtTUJaZmZnNHBiQWhhUjl5WG5QdytkYm5lQ0V5?=
 =?utf-8?Q?RBCDXLQD2Xf12F9WpLo0Dng=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319da031-ed55-4cca-6e37-08da740c4309
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:22:04.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rapDPeRrFNQteMUCRgVg87iGtXjylT45vpl/XhkPwmZEtgI1huP76MzpiWUjhd1my/5M4OZgaoV6WW0wkTcMVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010112
X-Proofpoint-ORIG-GUID: hu4nG8JbSDKfo4npvQovxRNjaqW3jFqI
X-Proofpoint-GUID: hu4nG8JbSDKfo4npvQovxRNjaqW3jFqI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/1/22 13:24, Jiri Olsa wrote:
> On Sun, Jul 31, 2022 at 05:26:49PM -0600, James Hilliard wrote:
>> The GNU assembler generates an empty .bss section. This is a well
>> established behavior in GAS that happens in all supported targets.
>>
>> The LLVM assembler doesn't generate an empty .bss section.
>>
>> bpftool chokes on the empty .bss section.
>>
>> Additionally in bpf_object__elf_collect the sec_desc->data is not
>> initialized when a section is not recognized. In this case, this
>> happens with .comment.
>>
>> So we must check that sec_desc->data is initialized before checking
>> if the size is 0.
> 
> oops David send same change but I asked him to move the check
> to bpf_object__elf_collect [1] .. but with your explanation this
> fix actualy looks fine to me

FWIW, I only just got back to actually making that change. This
patch has a much better explanation than the one I sent so +1 from
me also

David

> 
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/YuKaFiZ+ksB5f0Ye@krava/
> 
>>
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 50d41815f431..77e3797cf75a 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>>  	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
>>  		sec_desc = &obj->efile.secs[sec_idx];
>>  
>> +		/* Skip recognized sections with size 0. */
>> +		if (sec_desc->data && sec_desc->data->d_size == 0)
>> +			continue;
>> +
>>  		switch (sec_desc->sec_type) {
>>  		case SEC_DATA:
>>  			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
>> -- 
>> 2.34.1
>>
