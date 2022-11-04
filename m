Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB05619CB9
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKDQNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKDQNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:13:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894A47315
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:13:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4G3pkK012395;
        Fri, 4 Nov 2022 16:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7EYcwuQ5dhrWmJlnRrcF+Yrna35qQCTXpBVjaJubm+s=;
 b=3Eb627pIvdxpXCAhoEX8IBaXyc9W+XCtifLb65hP11oyqEbeNYyIYnRvHg6OpgDSZUCA
 tf3/CrB1rGeqb0l+8INp42Ca6/gR+4bXTkJ4cgSF1VmYbQducQS2eum3UE1LNDtW5BBP
 nURdHtfcNIgM6v6/4m20QCGr/LHq16upQZCmfG35lUgfQTCzK8/MVvKgpaHTq+7jJ9h3
 AVV+3UV/F+xlAnCJ6E0RRcRNYDlFfpQBVkdnyUgIeYTo/rKCNyCIr49Yj5GCQy3ZYxSu
 LBAxo6cR21RLKqAYaWlvnAuLR78Ic7d/5BNBRiRP+IFQhFaMXMTGQPUHrr1a53aQ42u1 bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty38b9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 16:12:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EPGK0029703;
        Fri, 4 Nov 2022 16:12:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr8ys7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 16:12:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHyfV3EQUpS+lloS3vdASHyQr6reKXtppwWEYOIbeZcFwUCfD541MWShjVF6ONmx5im8i5E8r9cji4Ex6zORfEKXEePPuoxE7Huk5cvUGUj5j/OCwFvRCR9rfsdNccGOK+9k5ZLX7SLlwnTsmVOcWXEfX+OwDaERrjxcCZn8tKyH4gjbDjnT8cgj9l6IYhSgLMLH70oq+tFP9xRASO5qoUQYcrq3TjzcPrFzbxq7C7bXkR5med88xKfpbsVHY3RZUHGpQtnziJ3oAIGaliqzSwmEIBH0mG7NtQ9eolSobjwnjam4ri6iBBkcfgb8czVutiPA+PgYHYYOV8pWx3L+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EYcwuQ5dhrWmJlnRrcF+Yrna35qQCTXpBVjaJubm+s=;
 b=UcHOMn8Qz5YgxYqXqXfL2nD5VBDC8u4G98FTnTdzW0FG9zA7VI0a0u/TMWSOzWQ868z7Mgn7XUedDsRykxwJFEVmUS15/GGDVBgum9ubRjUO/TTY5xvcSN7Jzb/TCAuAZtwqdtUyvfQ7HER/Okza/TrffySqowK4gP/ZdozE5keitIMAjF4QP4wGrNvIdASxuW4rh3L2gIOHgZWUFk/lU+cXOlCxADaqscKX0g65uhGtsNkOr8+CJWkJJlYHzGS7Ju5Wb7By7Ji3k5I8DB1jSkfCDnRq8CzRX68Y6J9wffcSZgz4VfvsqAYqWvWsgwdY5A8p3cKkucFS9bjGJDjJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EYcwuQ5dhrWmJlnRrcF+Yrna35qQCTXpBVjaJubm+s=;
 b=SwXZ27o5j4ea4gO6PiHSLART6gu/Cs/Q0dnCz4AEpfqn5zrzpqUv3wIqyln2HLnfkIPfYs+8xepYKOnS/t0dddSi9jc8M4VT8dcHWW+l82Pxo6JtxKVYsRZgoI660KxNNQrqz55GkbxfO7nBggZFP/vujG/K8BocT/aDMaNPqJE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6662.namprd10.prod.outlook.com (2603:10b6:806:2b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:12:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 16:12:33 +0000
Subject: Re: bpf: Is it possible to move .BTF data into a module
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Vitaly Chikunov <vt@altlinux.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <20221104051644.nogfilmnjred2dt2@altlinux.org>
 <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
 <CAADnVQKUeyDwdJ9AZvbxCCVc6hyvm1wdBRg4+3RHx5u5o1wLMA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <43fd3775-e796-6802-17f0-5c9fdbf368f5@oracle.com>
Date:   Fri, 4 Nov 2022 16:12:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAADnVQKUeyDwdJ9AZvbxCCVc6hyvm1wdBRg4+3RHx5u5o1wLMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b13d5bd-5c35-4c7d-68a7-08dabe7f61b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rc3zcmk8B4iBT2AFmhbwKG5uO1b3dGceZtTGasHRTdUmq4/pUyFdRqsML7Q5sLRZ84NrVocClKBqpYPlXnIPB1nM9ADgBhFDGKMEgZgNZCYBECzQuF5VSgoxS9XA4reI7sxHf9/6Pr0rL70MBQjKrENZTCwyqEeh9MnHhHY4L0G0ttOeM+YrEw3RzHAcHNwMFCiGXiDOUMT3yQ/1OWjYYPBZpsaMghwo+8AwaQBpLWeZcR9av9j7lstk9S8W+vhgGYE/M9AawOKj3hg53/frE2rKfA59xwkQHDfZjpaFvOevrbecmKunpa+JB9i/41c/4YaZLVeBH3ngDDzn9PhddpC5lMvm4solrHTYXySnAJixc40tfynShM7AvDQrbU5/LvcQ3plbMP3IfS10eS66A52dxxYYVBVfoet1awrHz3ggNHh55TORHTCvwBsjpeOMWP3djRIktAnadUgfxtYE+XA6VO8T7F3iSufHYhm4vuKNyH4kNuvNdFlFH4YJBbcDiD0PxVHkHGrD1bUDecVy4zGBJxQ0Z29LBl8OM8vbhhnqgSXRRDvBEPa5Qw3XdE8Ga0RGJA20Khom+mhS1yx1cxZnsjo1+SLMsS0oY/I6bwJRf5Dyc8MeSs3lndT0mtPxnLsKFY2FbUHdhII5rscQfnxLifF5NvHe8hnZE1wpWtPTWFTQoLM4YW/n6HL0sDZm1ca8b+A15PQ+XiXFzq5MTB/R5ToWjmjifBHgb8hCFb+GpL0XqFW/0vz4i133YRZH5/xbBqrhRHL5ht+OKam5yqxHEDtqnygTRp6q/Hdmm4s/g5OSSUBXDV6HcZN6itjA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6666004)(36756003)(5660300002)(478600001)(6486002)(66476007)(2906002)(66946007)(66556008)(4326008)(8936002)(41300700001)(86362001)(31696002)(54906003)(316002)(110136005)(44832011)(8676002)(38100700002)(83380400001)(31686004)(186003)(2616005)(6512007)(6506007)(53546011)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVIeXpHai9NR3YzaGh5OUZhT2hPdTA2WS9QcDQ3ZUd3VGFVMzVZUUtUbEQw?=
 =?utf-8?B?OGxDeDVTVnFoNDQxSTBPdDB1Q3EyNUlUbzNYYlRNeHcxT0I4aUlpUno5MGps?=
 =?utf-8?B?cUZFUjdmajlXSkpxQTFuOG1tOXdqUk1QMWs0WjFWdDdwdm9CVWJTZ3VYR05Q?=
 =?utf-8?B?VTlyT0kvMU9yK2ticnVDRXRmSUlsNmZweHFyZTZOQWRCcVZ0ajlFQlBaV3hm?=
 =?utf-8?B?OEdKNkVMOXJIeHBNMDNyMXg3bWYxRys3ZExWSktOdSs4RXhhMElSRHVYSGtW?=
 =?utf-8?B?a1ozbEFDODdZSU4ya3llbUZRb1lrMHNqZHdkdzU0bStYeTNrTHNDdlVYNVNk?=
 =?utf-8?B?RWlQNVNBTjB2dFV0eVF4RHZLaVBNNGZrelNEQkNuNHFNdkNrVjN2WDJmZHd6?=
 =?utf-8?B?VGF5NG8zSVp1Ulp6S0VabGZsMGcxemo2eVJPODEzSlpvcjVuRUt5YWM1dVpi?=
 =?utf-8?B?NjBkWjF0cExyM1h5SlVFZll4a1hNZXBRUDl1cEZzTzdkQSs3SEFDQ3JuSW55?=
 =?utf-8?B?dUpZdnpLQkNqVGVUMk5kczJIRTRCUkR4NEthdnhzVFY3M0RmWHJRb0V2b2wr?=
 =?utf-8?B?OFloalBmcHNrSWNncTMvbnJBckg0UFg3cnlTTWtzOVR6SmI3R3ZjTTBPZEpz?=
 =?utf-8?B?b1QxMm0vRkpSZm95UnRLME5vRW53QzNqajRoRzFpQWFiZHpzZE4rL1lXOEYv?=
 =?utf-8?B?R3ZSUzM0RFJyRU5ldklBaHVEaXZ1VE5IZ29LT2I1aW91M1lJbnFNdkcvalRz?=
 =?utf-8?B?azFPZlU4VThsYXJjTENOSWNLeEFUYXpIRjFaMHVlQkVhSkFUS2h4dDd2R1Rs?=
 =?utf-8?B?djJUejN3bDdreGV0SXU5d2Z0ZDVQa1ZlTGZpNDRONTVicmdLQUJ5UjBaeG1o?=
 =?utf-8?B?T0xJVlE4UWZweXA0Um5zUTlENEFSVWkxcndpQTRYTkF0N3R5UGtkSkpUYjlO?=
 =?utf-8?B?MlhrYnYwaHVXM2xJY2hXRVBvMmdZQkFHMnJNT2xadFFFSlkzSXMyWCtDNmZ0?=
 =?utf-8?B?UDE1U1RlK0dXZDRZNXNzOGc4a2RtOVlqRXpxMmR5NUxYWldSTndsTWF2SkxW?=
 =?utf-8?B?YWQrclNvOVg3M3kya3UrM1AzWUJJRmhTVW1kZk50QWF5akFidmxCRnp4Q2ll?=
 =?utf-8?B?Nmw3aHZxVlZuSEw0bUFacW5SSnp3aTU2dmUyanZqV2QvVkxURUFXYkJsaEVT?=
 =?utf-8?B?WGk3NGQzSEZIM25Qb1hTNDcxaVo3NVNuWTVEOFhEcnNJWkQrcEsxTjEvRzUx?=
 =?utf-8?B?M1Q1L2JEZE12ZGUwZ2wweHEwckJBdlE0cGtIR1BDVHgraHBMM1NMWFlWeDc1?=
 =?utf-8?B?YlZGekJCT3g1YURWcC9xaC8yZnhrWGlLc2ZkbmEvcHcrYUoveEo1ZjZOdmFx?=
 =?utf-8?B?eXc5dWtHRXAzOUhCN1VvbGs0RnNETEVpS1dRMzNEbWdIM3AzY0RENjF5N3Vm?=
 =?utf-8?B?bXNsazFHNXF5M0NsZGlnd0x5YVlOaWdtaU00ckVrNTVmd1lNTDhDT3JPSHV2?=
 =?utf-8?B?ZnE2d1hVNExRV1NIeFBvZXlIMGVRVjZ3aiszSG4yK3RNRkQ0aUNRSkQvcEY0?=
 =?utf-8?B?eDNKMlFVSmlHUS9UcDFiZ2JmWHNubkNFTy82dUp6OTJUNmtFd05HVW4zMzEx?=
 =?utf-8?B?NktDV3owVDlJVFMrcXp1eTZqcGxhK3dmSHl1SmVQRXFRTTlkRG5jUGVYdFg3?=
 =?utf-8?B?VG5GT0dQNVVsLzRLcm81OUUvd3NEZnFIZUVrVzcyaG53RllDdGtCeEwzL3F2?=
 =?utf-8?B?V1NNVUUrenZEYmx6ZGpTRlRlZEE2MEdCSU5wb3VERjk2aVBXOGdhTnB6eWFm?=
 =?utf-8?B?U254TGYyRitvMWRuU0VVNllKS2ZUaXBEZ3I5eGUwS0JIRlBWbmJFbU4xU2RM?=
 =?utf-8?B?TzNiMHd5WFdSSFRVQktsUm9nQWp0SERka2o4ejhSNnJSMjhEZHpwYWdhb2ZF?=
 =?utf-8?B?RkN5dERHVENJQ1lxL2Q1cHVpZER4RWo2Nzk4OVJnRk9xb2pSYU1oMVk2dGZF?=
 =?utf-8?B?clFJTzRXMGg0T29pKy9wZnZNeC9jV3hsb0VVRi9JMzA4Si82SVRzejJHMkds?=
 =?utf-8?B?aG1YVy9hbVloUXNIYTNNVVpMVTR5amRUYk9iei95RWM4Vy9LKzVxRDhTOUhR?=
 =?utf-8?B?VjJBbGZYWm8vdHFXaVQyS1pTR1RqTWF5K3Z3Zi95anFwL1dPaHhOY2MvOVEv?=
 =?utf-8?Q?78xL/0k+6A6doYGC/w8MzXM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b13d5bd-5c35-4c7d-68a7-08dabe7f61b6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:12:33.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOroikdjBcQgwkiGSO/bvgaOTylVDaUTRwfVwgOagmuTQx9N4Jhzly+hAKSXBjy0PzROiCKAipyL+OYklnVx9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040105
X-Proofpoint-ORIG-GUID: lhOqfux6QVolRYAmsnUw2z4NalroYxkP
X-Proofpoint-GUID: lhOqfux6QVolRYAmsnUw2z4NalroYxkP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/11/2022 15:59, Alexei Starovoitov wrote:
> On Fri, Nov 4, 2022 at 7:35 AM KP Singh <kpsingh@kernel.org> wrote:
>>
>> On Fri, Nov 4, 2022 at 6:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
>>>
>>> Hi,
>>>
>>> We need to reduce kernel size for aarch64, because it does not fit into
>>> U-Boot loader on Raspberry Pi (due to it having fdt_addr_r=0x02600000)
>>> and one of big ELF sections in vmlinuz is .BTF taking around 5MB.
>>> Compression does not help because on aarch64 kernels are
>>> uncompressed[1].
>>>
>>> Is it theoretically possible to make sysfs_btf a module?
>>
>> I think so, it may need some refactoring and changes
>> but, yeah, in theory, the module could ship with the
>> kernel's BTF information which can then be initialized by the module.
>>
>> Curious to see what others think as well.
> 
> Yeah. That request came up a few times.
> Whoever has cycles to work on it... please go ahead :)
> 

We've experimented with this a bit for the global variable patch
series, where global variable BTF is a tristate config
parameter, and if set to 'm' the BTF for variables ends up in 
vmlinux_btf_extra.ko instead (patch series forthcoming; it was 
stuck behind the dedup issues which took a while to uncover). 
One approach would be to extend that scheme such that 
CONFIG_DEBUG_INFO_BTF=m I guess?

The only thing that might require change is the name; vmlinux_btf
might be a more appropriate module name than vmlinux_btf_extra
perhaps? Thanks!

Alan
