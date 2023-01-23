Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7367852F
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAWSnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 13:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjAWSnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 13:43:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633324497
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 10:43:44 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NIORpu032493;
        Mon, 23 Jan 2023 18:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vqkq5Dsnzk6qPfO/ju/Mi04aICXPD+5jRbSPYWqynpQ=;
 b=g6ImHOPlE9I/jsAqAY+w8GXOMeuypOB1KQIPd0ui8jN3H6k2FuRMofKZtpRcTI65O+Cu
 gqa218ceJfbK4GO/Z1oknifSqbimqcrF+9yP3fayblzVEt0RKVTRheVtSr9iLRVHPVpo
 SQrdkvqp0K+cnnkAffe4+1caHRhBZb2g9BIwHCarsupBkoJG2cqTpgZIfsz9RJ6N6gkg
 iW1da2EO7MgRyISStW3jn6DwzhJRhKBEVu6yCyDWYDTh5uMTs423rgAeYxsOSbDf6uwj
 yEOUURyNLMmVQnPszFkUyZv6J6cK29+wlKNgEaTntEoJsuam/u1Gg/WAZh02453ggCqo kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86ybbkmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 18:43:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NHfJOA011687;
        Mon, 23 Jan 2023 18:43:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g3e4v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 18:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIiA9v+93y35aqyz3qR9aQcOgYcoPga5s2oAv9EE0HCkGHuvuW7gBJH/TSSV1jf3+ZYqp/IDWw4boo0j2htJkSL+TX7ys2l/4AEARuGmsCM8UkAqgdgNrBvn34gfYGlvgSp3lU09hWsDJS9Puk1661jHXjqgS+fOcYK5jfKH9NK6gW8Ljm9+YiGII3YBibo3e9UtQKfKnsVNgfUY/2wIY87O3JZnIxnVDZ1Xoiu3cMv47z/AHfpkJAsFcjTg8ZlLxipP1sRgkkw+8VQEPvnPLAv95lGl4yqRybdszZRIJ8OIgVQR69qATfz+vZBD2mE2d9vJn4zx/Bfg/zPUc6cVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqkq5Dsnzk6qPfO/ju/Mi04aICXPD+5jRbSPYWqynpQ=;
 b=mJLQoxXDPau8J+++I0oL1mSo1eUgqTn+KXL+XTl++v7JvmEmBP171aamcqCtaL9sLnyPnoGclJvMAuBStXr20gaFeFhlSvGI4YteCLDxj5o4/h1igFxQg/pWOrVE+fwj6dqAVnNKMfzGTqFOGbgs3L1UlG4MPJfzpGq6MDUBjvM9s633wRPsbeYcONftAum6gKrSBTyybMPt1trtjfvU8UcuDW293XFUZU0vZtmdFhvg6GD/mTgXmrFETxh0rj4z1gO+DkJCU0yt4YdxAdYNRlS+iH4dYWd76eN0SAlHwAqCDkU/fDlg6N7Dcq6eFFl5i+R07cFk0UxHeN5zdq2uAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqkq5Dsnzk6qPfO/ju/Mi04aICXPD+5jRbSPYWqynpQ=;
 b=zjemMATqVbMrCpaB7c87rLcblrq9EUTgWSkhH+drso01Q2IqnQsDr+6cZKfrDqtOXHhg3mo/0oB6zah0I+vQrSV8d1KyqT6Tazj4JGsPleFsCEnojkMTXz6cfRiZFocGfxn+CwEuTxc+dzvzfTUnk6q3HcPvkXYk4zumaA8liyM=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by DS7PR10MB5071.namprd10.prod.outlook.com (2603:10b6:5:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Mon, 23 Jan
 2023 18:43:32 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::6b7d:5afd:3d9e:e5aa]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::6b7d:5afd:3d9e:e5aa%6]) with mapi id 15.20.6043.014; Mon, 23 Jan 2023
 18:43:32 +0000
Message-ID: <4281ccc7-99db-69df-6675-5c8b5509abc3@oracle.com>
Date:   Mon, 23 Jan 2023 10:43:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <f3963ae2-2a9c-b8b4-2b19-ebbcc7863b8d@meta.com> <873581i72k.fsf@oracle.com>
Content-Language: en-US
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <873581i72k.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3213:EE_|DS7PR10MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: ead76da4-7c73-4d49-1f0b-08dafd71ba23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA88rS4zspJ0y8KAKMWg8kBhrp+xojGYPY3OOCTocXjnr2sAwn5bFoZvf3y6y+6LxugsLd0ptRlvnVIyaJCUQjCUZn/VVZaW6vEvJddnDKk64HwrkAq038n8qnK2oRcrOC0LYqAFuMGrb/aGNhqzKnklC5wHThiXHvr0Ls9hVCF9fiT2n3S33B/WhOEHMGgYDadsqldDXzv2Pnp2E8iLBaaUHaXWvThw6eG6LZPY9XUflAKySc6YpwHq9a1gfeAiYWviAnQJnDDHOuI9oxv0pXIkE9aV0+Nmpq786axKJZwbrP+CZZDH62v1LEyfwfpY4ocGdjjrtgeQukOpFqhWjue93fC083Ds4v0dLpvEwlfOOhmt16fucvFcKvn1dG9NsnPpWH+ekIKWYTB8ZXGdzuT+PfpMrJkSPraYsDZBKGUN8/5aclTXmWsWYKZjTbotAsxgK9ZyyyH/PD9n/MG8LFkQDDkeY1DqxtTkRPKBcPK/P2G3x2HR7G1GTkfistZ7rgl/cGrY6Y8OOQHOKB2Xo/EAbqcyopmky/V7SEaaocQY49f/Z1HDJJZive0pzGpphNTkk8030GLS833+FTkorOjcGp0MQesiTyw5itKpLdplXL8B/A3EIEvmmeww94DfvcWRJHo+0Uk3u4ZoQzwsVxIW7GOEhj6X+K46k2ooOKYNO+lqGzv+XSW9cUTQy9MMG4A32Sfqmx5Xbsto2e7YpHheNJd2+zXP+cFFNSqqUtZTEKYWcLMFX7egpisH7SVFKWlw3SGmQAsfDkAPsbIDeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(478600001)(6512007)(31686004)(966005)(2616005)(4326008)(8676002)(186003)(26005)(6506007)(83380400001)(6486002)(316002)(66556008)(66946007)(66476007)(41300700001)(53546011)(8936002)(44832011)(2906002)(5660300002)(38100700002)(31696002)(54906003)(110136005)(107886003)(86362001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VsTnhodnN5ckNnOEdQRStyQU5ZVXRSMW5kMUhHNmx0ZFVScVF6N0NuRUln?=
 =?utf-8?B?Szk3K3k3S0IzWlJabnNyVHowTUlhSEpZdlc5QTR1TlZEUzZydUtIU3liVXEw?=
 =?utf-8?B?Rm1DZkxOeEpHK2w3c1dGNEhlMmRnRVV6NnJpL0xTKytyeUQxVE1yKytDMXAr?=
 =?utf-8?B?TXc1aXBvQVdyUzMzNUY0VU0xSVpuVHBKd3E5QmlvQ0xVQ1pNeVZLaWJNWlNk?=
 =?utf-8?B?azBoc09DSUVQdXo2WXBUKzJCbVJ1SER2VWQ2R0g1NjRRaGtIU2J5eXNUWmhV?=
 =?utf-8?B?ZVNKTzMzM0NWV1N6U2lGeGJUZXRwT0JiRllBcmg3QTFhUmhTSDg5WW1FUXBT?=
 =?utf-8?B?TnZXVWhXWW82VUhXVHRQWWpuamFGN09FTnExR2RlRFQvOTYyQTkwTXZNdndz?=
 =?utf-8?B?VlZZR3FYeUh3WWNsS0RJUjVxblVaK2hoVDF1ZE1HVHZxM3dXdkZodEpFVE9J?=
 =?utf-8?B?OTIzSWlaeVFPV29SWnRMN2w5WkI4ZnlEWXVVUmxlMGUxTHl5NUVTVTZyNWhQ?=
 =?utf-8?B?UHZVUGFvSWJNcW8zeFQ2ejdqYmUzU2FPeXBzTGlJQ1FPaHdSM0U2UWttUEw0?=
 =?utf-8?B?cmhxRU5TTGVHeHY3T1Nib3hWcmFiZExqM1cySTZkZG9oTGFDcndkWE9KZFNk?=
 =?utf-8?B?bThUS0l0Z1ZHU0VZdFo0OHFnT1N3ZmFCeVg2aEp5YTVPL0QyTU95czcwQms3?=
 =?utf-8?B?N1h1anRGM0FGeFNYLzlNSU51Y0J0NUtFdlVLU3RJS0RqY0k1c3hCV0RSUDJh?=
 =?utf-8?B?dHZRTlJ1NmtNMGhka0l3WHBBcEVESHFrcnJpaC9vemJtdmtRblFyVHQ3QWx0?=
 =?utf-8?B?NzI4RVd4N0F2TzVRakdta3pob2I4N2kzNFhieUEzbCt0dTg1Ym41MWdsOE1V?=
 =?utf-8?B?dlZtM05KUlg4dnhxVDJyR0RYdjVPNU5OSjhNbFVLWGJIZThtTlVUN1pLVmlu?=
 =?utf-8?B?Rm9OcnZTeGlHV0Qwc2xmS0cveVZFQ2l5V3NZMWJNbUt6bzNFUC9HUTlVQVBq?=
 =?utf-8?B?dVZvWFNKSGdxY3grc0svOUhyOGg1dEgxSGFvbXFzRWJtQmdsVWgrTDNlNUR5?=
 =?utf-8?B?QkwwdXFRdXVLSHk3RW9VU29NbUtJUHhZZitNUUJXYmpBeXk3cVRETEltVkVN?=
 =?utf-8?B?YTdkbWo2OTMxcGoxSVhwUVhkaWh3b3ZSQldZUEM3VXBDVHV0d1ZRbjRUMUts?=
 =?utf-8?B?dUlaMzF6ZVNCY0hUck5LR01MVHhxdTRHMVJpMjZUTU92S3dXNkgrdXVIUVNp?=
 =?utf-8?B?VVliSjdJaW5xdDdZQXArekVmS3NZd2VkdTFhcVk4YnhoUHdmaGZ5QW1qNkk4?=
 =?utf-8?B?MW9GakVmM1NLZlJ2UElCYmhmelppa0ZVZzNrSU9wWGdIOGJqNlMwZWFlOVVs?=
 =?utf-8?B?R25HSXRsVFErNlFQck1iWmpGZ3cvK1ByL3JFaENSLzFZd29KT3dGUndab0Rx?=
 =?utf-8?B?T1BpNXlVbjRPWHQwWlJ6Q2hSeFBKTjRDVUZ1ZEZvZ1lTNGdiZDVhY2J6T21r?=
 =?utf-8?B?OUwrQ1UyNXE2Sng1WTBoZVV5bHRHUHEvMDFRVStyTWNsUWtJTzZSemJZcUxI?=
 =?utf-8?B?ZGs4ZVFITURRVFNKWmR3bHppSDFWYkh1RGo1OFhweHhyM21WZkdiVGxyR3o1?=
 =?utf-8?B?QUFNRi9OM1ZsN1JJNHVoUW14SWJ0NGx2UkxNMHVmREI3UmFlVUltSlpDOEta?=
 =?utf-8?B?bmF2bDVKWDJPQjQzcjFWd1lkRmpoRFBXQXUzRXFqeTlFQ245TWlLam40V2lK?=
 =?utf-8?B?VllqelEvczRoVVFSWmNTKzdnelhablM2NlFBZFFUSWp3TlFEOXlaa29QVXFW?=
 =?utf-8?B?R0hNeU82QWU1YjJmMjdxZk1ZM2RUQ0lqbVJCT2JWQzdJbk5jMzVSRUdESUlV?=
 =?utf-8?B?b0NiWUU1UkRmU1NiazJNSDVYL0FSa1MwOVE1VXJuSlppeFQwZzlyT2QyWnoy?=
 =?utf-8?B?TTlsYkhYeTRweWZGK0paaGxsaER6b2llaGZPdzJVNVdvNFc0UENrNmJOZWk4?=
 =?utf-8?B?bld2QzFsWWNnV2pFNE8rbWpldURtcWU4d1J4bzN2V3AxWGYvL3NCUGZyZGsv?=
 =?utf-8?B?b0pxQmdGaWY1cC9uOW9ONWJlZG9EYVdnbFRtTWEyYTJONkovbDlzNDBjL1BP?=
 =?utf-8?B?a09ad3BsUVl3d1MxQldoejh3emZ1bG12SXJVakxvek95RHpCTXJ6QkFEdmg3?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MEc/QycM4CLB9UV3clO4pYxvj+UESFe3BuDaDSZN0F6xYs9/1nhrtfJrQauOLn6kwpDOa2f8X1VO6FqZMHy0z/q+WxHhaCS9Oz23Y2qfdvqM1p4vdI6Pqe3L/SnXvWp7J9h5V1bIsriJiQ5L/NcC2MXyk/S3TRFGhOXijctu2hG2PLVP6qfw1sDwxkX4LVcSx+ClRUyoxAOQPd0eZRIZEL4jRAQl/hvzqiBopdJz+ldFAKmNIjR0/+TED7O4ZIZZQXv55WAIJT4NlGLZST9swtphp+eWTjvnRkF1ibFAHRKv9hvVQUgF4COFJF0092VqkOKzYJWEmMVZQaTeZfHzxaXzJgXvmukxhCSFrwpuQHD1ODqFwtmV+5I4Af7fEDs5orSXmyLZJVd4Bs2hYERHR8oc/724GanuizYCAKgUyFkTy6YURRYWPFeucKXWHxGG+gFz9WFRj6M6skHQUd9hz0kLp4ULLML+aTvSSsFW3iV24RQQ8nnzbhroNJ03VLG3imlXjRvipyxpFvITOllSSC4nAS8ww1CLXMTdnouCG1YUpSqfc+ioKrYxefQYUrViv6zVsMwiVdxa0EJVZG97PZsVqjI29ZFiuzNDZwfBbvZYuQA4teV/VAXm4G4Yo1+XlBL2eO+0RPRY01MeFiheoOdn1q1bBsjlUnInV+TbMW2WdXMo4veEOlK2S6Ys8cN1unybvEznREbdllxp7UfvrKhDRZncajmjUQ7oR2hwiVrrRXgL9jrMo/7bA0Uk/oixmTx0vqqAF4kexwNnnCQ3Kmn0KP7u6VpQv713OI/xN8i2IfD0HIpxp1IhK96kOWbyBmw587VXsDDn2CFwvAIcs5pZdT9t2trfevXjJPN7rT5DI2CsrTR0/DvQMpzpILynt7iMkLHOs/wi1nV5mwRiPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead76da4-7c73-4d49-1f0b-08dafd71ba23
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 18:43:32.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o3xjvQSbAZvM4SbTM9HOQr96G//05R7izBsCRy6csLiWW/1Cj7TfPq1gKcRvAYFNFoNAnDL/ejGrTP72Vm3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230180
X-Proofpoint-GUID: IiALqjv4UKwfxkGI0LiJhSnpxyQTmDnD
X-Proofpoint-ORIG-GUID: IiALqjv4UKwfxkGI0LiJhSnpxyQTmDnD
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/23/23 07:50, Jose E. Marchesi wrote:
> 
>> On 1/5/23 10:30 AM, Jose E. Marchesi wrote:
>>> We agreed in the meeting to implement Solution 2 below in both GCC
>>> and
>>> clang.
>>> The DW_TAG_LLVM_annotation DIE number will be changed in order to
>>> make
>>> it possible for pahole to handle the current tags.  The number of the
>>> new tag will be shared by both GCC and clang.
>>
>> w.r.t c2x attribute syntax discussion in 01/19 office hour discussion.
>>
>> I have checked clang c2x syntax w.r.t.
>> btf_type_tag and btf_decl_tag. They are both supported
>> with clang 15 and 16.
>>
>> See:
>> https://clang.llvm.org/docs/AttributeReference.html
>>
>> The c2x btf_decl_tag attr syntax is [[clang::btf_decl_tag("")]].
>> The c2x btf_type_tag attr syntax is [[clang::btf_type_tag("")]].
>>
>> $ cat t.c
>> int [[clang::btf_type_tag("aa")]] * [[clang::btf_type_tag("bb")]] *f;
>> [[clang::btf_decl_tag("cc")]] int foo() { return 5; }
>> int bar() { return foo(); }
>> $ clang -std=c2x -g -O2 -c t.c
>> $ llvm-dwarfdump t.o | grep btf | grep tag
>>                   DW_AT_name    ("btf_type_tag")
>>                   DW_AT_name    ("btf_type_tag")
>>                   DW_AT_name    ("btf_decl_tag")
>>
>> I double checked and the c2x syntax above generates the *same*
>> type IR and dwarf compared to __attribute__ style attributes.
>>
>> [...]
> 
> Thanks for checking.
> 
> That matches our impression that C2X type attributes actually order the same
> way than sparse type annotations, at least in the cases we are
> interested on.

I have been experimenting with the C2x syntax in GCC and the results are
similarly promising. It looks like with the C2x syntax, the 'type_tag's
always associate in the same way as sparse.

For GCC the syntax is (or will be)
  [[gnu::btf_decl_tag("foo")]] and
  [[gnu::btf_type_tag("bar")]]
respectively.

I am not sure it is necessary to use the C2x syntax for decl_tag, iirc
there are no issues with the __attribute__ syntax for decl_tag. Either
one should be ok.

With C2x syntax, in the internal representation and in the generated
DWARF, the type_tag attributes are attached to the same elements of
the declaration as sparse attaches them to.

I checked all the examples we looked at and it seems they are
all "fixed" with the C2x syntax, in that GCC agrees with sparse.
For example,

$ cat ex2.c
int __attribute__((btf_type_tag("tag1"))) * __attribute__((btf_type_tag("tag2"))) * g;

We saw that this example was problematic with the __attribute__ syntax
in that GCC associates "tag1" with (int **) while sparse associates
"tag1" with (int).

Using the c2x syntax, "tag1" is associated with (int) and "tag2" with
(int *) the same as in sparse:
$ cat ex2-c2x.c
int [[gnu::btf_type_tag("tag1")]] * [[gnu::btf_type_tag("tag2")]] * g;
$ bpf-unknown-none-gcc --std=c2x -c -gbtf -gdwarf ex2-c2x.c -o ex2-c2x.o
$ bpftool btf dump file ex2-c2x.o
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] TYPE_TAG 'tag1' type_id=1
[3] PTR '(anon)' type_id=2
[4] TYPE_TAG 'tag2' type_id=3
[5] PTR '(anon)' type_id=4
[6] VAR 'g' type_id=5, linkage=global


I also spent some studying the C2x draft standard [1] to check whether
this ordering is documented by the standard or up to the implementation.
  [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
  (I think this is the most recent draft, dated 3 Sep 2022)

I believe the "sparse-like" ordering is in fact required by the
standard, which is great for us.

The relevant section is 6.7: Declarations. Section 6.7.12 covers only
syntax of attributes themselves. The ordering/association rules are
documented by the sections for each component of a declaration. Section
6.7.6 is particularly relevant, 6.7.6.1 discusses pointer declarators
specifically.

From my understanding, the general rule is that an attribute modifies
the element of a declaration immediately to the left of it, which is
the same as the intuitive sparse ordering.

So it seems like using the C2x standard attribute syntax may be a
very nice solution to our problem. But we should keep in mind that C2x
is still a draft so this attribute syntax could potentially change.
