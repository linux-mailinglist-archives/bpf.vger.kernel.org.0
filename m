Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9306A5CEA
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1QQJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 11:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjB1QQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 11:16:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F532B613
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 08:16:07 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31SFxBSX016293;
        Tue, 28 Feb 2023 08:16:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=a1o10LyP7kkmourCtQeKSDI/0/9ieXA7G8CA4+vqiWY=;
 b=B82WWNnrZCTGnZ4XBSu6O1a8/U7Z1RAZMp0j9DlNNMWgxPNMUZ1leW5hGnC9EmBrDxrF
 HcAN3Vq2TTi/Kvz/wosUErHXL55L+3IEEjTTEOkZxyamUv9W53QVx/Scd+nvIPCcA0oF
 GiLa8pKLglOwB5pehNK4j7iR/Ct52DjGnlezvOBpKsX6xnzClWZPZLQOWHZAeEaWZtSA
 x2clLAXU9WnJGYZGlRKb8h/itdgBlANG1xPPhEyKCSZD3D8kjE/ZQ1jfQpDj4gQIuxeE
 yj3xnBfJi3MFuJRVb+ENQw4ekcp1Fd0/QlTh5gD/GUemw+EI4k2T7wK8rov/uERfK7Ei BA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p1ah7umyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 08:16:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag9Ih1TDKPHsywc3Qw/X1X2tR/ZJfhq/DboXG7RBKwC8DjV0S1Q/Smr1MleLfud6CMN6m9Rqglwu5Mhzh5gWajHosWR0tQfs78t5kQRbkOTkTBFMKtTIBxRC3yA3RpYiRg28up2K9GIjPYj/pwW/PXQ29jNATRVjIq4di6ZQx4e4ovyQSc/F7qsVmQcRB0+uyW+tSLU4drRNB3ujaMLUxUQJ16F+7oiI/isoD/a7pBD8M5aoGPiC1VPiz9EvycmuPJfV/RouxdIJQON1wLOPsuyt7fYX7mk+H0mzAm/FjPaGRlIYlb64rSUo6NTfvP2IzWKvlb4xmfMBV+QPOTiQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1o10LyP7kkmourCtQeKSDI/0/9ieXA7G8CA4+vqiWY=;
 b=BdNnRmDhFTdCqm0fsd7ZabrLT9RI2TCAXgtQDcpussQZE31WJi4TVVet9SlozRmHaKP86TwGCNNuLYA2bni5U2KRJ3rumlkja7GKOiYa1zgw+C3y5qxyyzX3DJu1wdaQSv4w0EFUcoKbk/laiPuc8IlfgA3OzarVaYLpKOtfTBLHCvuEMctwhUEQzX+beusyn1zOaukCF+k1tHn0dWH4iZ0o9mAhxIongebB8hr9RP/zEEQPxyosDfN1e2Avq0GXNFH4HBZwzThr6a5SjjOOHiPga+PlQkJr2aZyjJC+U+oOq6gvdTsAa63MjT5sqphvmeC4aIAmrSikqnWhyvnvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4476.namprd15.prod.outlook.com (2603:10b6:303:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 16:15:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 16:15:57 +0000
Message-ID: <061f1d21-2336-6e49-9090-3da671375e63@meta.com>
Date:   Tue, 28 Feb 2023 08:15:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V5] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
References: <87r0ua7fu8.fsf@oracle.com>
 <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com>
 <87h6v6i0da.fsf_-_@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87h6v6i0da.fsf_-_@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fefb9f-a7c7-4d09-41f2-08db19a71340
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQYTlKfSSwWTGQGqluFW6nih7jO+0oR6n9J6fOPBumcB9c9ovhLxSmbFCfns8zqXuDZ+AV7QmKMys68UEtJXznINEJOs7EW9OOFlTAYxJLQDBdmYF9HNkXZA1MfzyqJLAOMngVbgHg6d8c9jCblAk6lVbVVeSvRITrZ7/5j7rS21XigKZMb+a3aAtzXV0X26NRz3qXnmDKOZcBJ8sCFRnsXPiBVBTJy/ft4CE90ijFIYcf7Jo6CgEVPlLHRa07y5O3u2V7cTmWxHP4dDOBkAO6Z/WQw9/Qlp3g04k1nsFhDWxrPmEjQvnxSnNCHqE1ord5PghzrVqkG/dt4aCjppgg4u1s/mfOnkGWQoYvEp6msVS3/6J02YweouoBvpkQS95W4S/9oJm/Da8DDlg6ofWK41ZjPeI2UYhRj3/UO3+TouUEM92YFQ4hQmYYh7wRADU7Qv9yhwefcHTOBHQH3wOVif3hF0JLqWDBG/4JNoNbP3DFG64EdEih0EXv0v3t0JtzP8U2N7YXnmwxdywCfItFlhBi5EpWwL/2Ih309LFxmIdKeFwB/cPu9J2ZEG3VyrdrjzEJijXOpD/CnXXJO3Lh9pxZeZwoPz+7HhOVy3//pNzBYZYzfdc8b6Nr6uMeMbY3RO9pdYVS4WWzemkcDDtXRUYexALg05A24GKPU3Dj9J0+6iquV8zt7E/rW8ZkLJgfOOC/R6q2tMYLyg+6MGnx9MPiqeTJWtxe0kilO5Id4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199018)(36756003)(31696002)(6666004)(6512007)(6486002)(6506007)(38100700002)(53546011)(186003)(2616005)(110136005)(316002)(41300700001)(54906003)(2906002)(66946007)(4326008)(66476007)(5660300002)(8936002)(478600001)(66556008)(8676002)(83380400001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZ2ZjNreW9RcTlYaVBRM1RXclo5UjFCUlpuRkdTb1d5RHdHVmFQWis5UkpZ?=
 =?utf-8?B?dmdOa1BXSGRodU8wQkg4RkVKUnF1aS9rdDA2K1Qxb2xVeWJ5NC9xK2RFd1Vs?=
 =?utf-8?B?OTErdlNkTkl4UmcyYU9YMjFFQVIyOTFRdmF2WVdXWjJDU1JEREptWXUrUnVQ?=
 =?utf-8?B?dGVmV2p4akVETWhUMUVmZUtiZEIrRThrRFFQTHdodmg0eFB4V1ZkMXV1aGR4?=
 =?utf-8?B?U0hBTkgxVHdOTFdtR0k3OW5CVXFnQm1CL1laVFFaT0E1UWEyQ3RzZUVHc1Bm?=
 =?utf-8?B?dVh0WE1ncXU1K2ViR0tsd0x3Uno3Z3B3dEFQTGI0djhJeW5OM3B6cWVBOUNn?=
 =?utf-8?B?NWdYSU5oQlhnMTErQmIvenR6bStzTG1xS3E1amkvMmI1RFlISk90ZFhHZkU0?=
 =?utf-8?B?VDBWcldEeFFWV3ZrRERsTDQ4M1RyaGZmOU9kYWY0QWlVS0l4QU1QV3htb0lh?=
 =?utf-8?B?U3RGWFAzT0oyNlpWSG1NbjFkU1ZTSFduMDJ3ZXoyeEd0T1FaOUR1bWdLNnQx?=
 =?utf-8?B?eG9pRlRpdE5TOGpYVFFLVjVEOExFdG55S09qMVdLeGx1MjlKNjJxeVE0cGox?=
 =?utf-8?B?enZEVDNRUURhczZSNXhwZ2oyMkZ1aStxVWkzR1JnL1lQQ3p2c1V5ZHB1Ynhu?=
 =?utf-8?B?SDlJRzJzcWt6ZEVCK285cUZrU0VuRDMyRjNkTmRPa01qbTR6RVQvYWZaMDIr?=
 =?utf-8?B?S2QwOU4vekhMYkxEV1hYK2QvZk5TUFRSTnVIbEpNMi84VDB5c2h1Yk1xME5M?=
 =?utf-8?B?WndMQ2ZwUXZWT0IvVkM2WE50OG9pcXZnRVdBT3RTS0ROS3BQWDFxOUZqK3dI?=
 =?utf-8?B?dnlmY29wZSs2V1A3RW82QklOU2kzSWtENWNMdlRFTVA2aGZjZHlZY3o4ZkRn?=
 =?utf-8?B?bmUySGl6NDBWSk84KzRmWEhmMG40cGgrUkdWVDdSVzNmWFBBcC9SYmVrUmRY?=
 =?utf-8?B?Ulh3R2R4eCthTUl5WmVucDU3REFrYk1jZFRtWU9PTlpJMFp2eXRGcTFXWm0r?=
 =?utf-8?B?TUVkRlBjMVBYdXBxN3U3VGoyNUdveUV0RmU4bGU0ZTk0ZUFVbWh4WmlzbktV?=
 =?utf-8?B?SVNCbkNqK0NKUis1dkczVStBa21oVXdnWlZHSFB6Rk4rSVY5WjduazJNRE9v?=
 =?utf-8?B?KzhMdkFvQWRvQVZUcnVubTZWMmw1UG9WcCtwR3V5NXRWYUVHUGg5MFpyakg5?=
 =?utf-8?B?SXdseU9lcWNYellOSEg2N1V4QUh1cFNoUUIybVhILy9yOThIQ1cvbkNqeW8x?=
 =?utf-8?B?aXJKQ2JpNDhhVytzZ01UekpHeVNDWlBHOWdPZnFMVGxCS2FNTStsUXdDdFlH?=
 =?utf-8?B?NzhqMTUzL1V4U3hubG1nTkpHMU9Jc1FNMzZRQVl0VDFTTVovUDJ1OUFMbVVl?=
 =?utf-8?B?dGcyUElqZFE3V21QUVpVdTRWd3Y3Yk1NbVoyUU40SUZyVWlscmtxa2k1VkJZ?=
 =?utf-8?B?MmRzVm5qaEZTTWR5TWQwRlpVeEZHWEh2T0dBYUFDd0FIMnNxdHdpbWE5YjV5?=
 =?utf-8?B?ZzR4MVlWNGZQdUVVbVRNb0pEWEMrN3pJZ0ZKc1dWY3BxazFRV0tqSEV3elBH?=
 =?utf-8?B?bk1rKzhoQTBrdFRaSVRuNDVsVndxU2lqZVpYSWdtNEo3Z1FpUFdBM2xjb3ZB?=
 =?utf-8?B?RmhEYXEramxsSTVxVlZKTDlLTTdvUUZOLzVCdi9UaWdBTG5WVS9uaGhGV1Np?=
 =?utf-8?B?R0dhNW5VeW9Cb0kvcGhHYnREU3VLR3htYmIySjk1OEpVZjVXU1BOUTJiU3Fx?=
 =?utf-8?B?R0FJVlZuSnA0MGtUYmZSY2s3NFR5VFNVK1hyWFIvSmQwQ3BGQ2NPVThsb2k3?=
 =?utf-8?B?emxTaE5kb0xSdFN5TjgwV0dXLzFaTmlWMnIwc01PR1VOR2pIQTlhQ3NlMTgx?=
 =?utf-8?B?NFQzSm1mQTNoNXAvSWQvNlVHS1lUOHJMWkdtQnVBbVNjYVVhb1ZlV0N1Z2w5?=
 =?utf-8?B?ZHh6cTd1bGp1R3RyR25DUUlTNERwMGZoRjVSNUx1VThxRmNLL3dITW82MmVp?=
 =?utf-8?B?VWZqOUd3U3JVdEszZHVOT2E2SnNmSUFja005c0Q1Sk5kMXB2K0h4K0xHN2xz?=
 =?utf-8?B?b1BBK3p4Ym5uTEIyQ3RmaTFzeWdodDR2c1ZNVkJwdnZOUFd3bFZyK3IwTFlx?=
 =?utf-8?B?RzZPUkFIWlRTWFVyOTNOQk5NQW1yK1I1UFgwTGE1eHJhMkNqVFY5ZVZXUlFC?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fefb9f-a7c7-4d09-41f2-08db19a71340
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 16:15:57.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQElEMz0kvrDhRseh0FXqnzadDMAIip6fOu3uHIKBZrS35ogBrLP9Q6RZJd2Ov/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4476
X-Proofpoint-ORIG-GUID: JGpd9dTIR2fZWF0xWtDI9RcgYGYiM-JM
X-Proofpoint-GUID: JGpd9dTIR2fZWF0xWtDI9RcgYGYiM-JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_13,2023-02-28_03,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/23 1:51 AM, Jose E. Marchesi wrote:
> 
> [Changes from V4:
> - s/regs:16/regs:8 in figure.]
> 
> [Changes from V3:
> - Back to src_reg and dst_reg, since they denote register numbers
>    as opposed to the values stored in these registers.]
> 
> [Changes from V2:
> - Use src and dst consistently in the document.
> - Use a more graphical depiction of the 128-bit instruction.
> - Remove `Where:' fragment.
> - Clarify that unused bits are reserved and shall be zeroed.]
> 
> [Changes from V1:
> - Use rst literal blocks for figures.
> - Avoid using | in the basic instruction/pseudo instruction figure.
> - Rebased to today's bpf-next master branch.]
> 
> This patch modifies instruction-set.rst so it documents the encoding
> of BPF instructions in terms of how the bytes are stored (be it in an
> ELF file or as bytes in a memory buffer to be loaded into the kernel
> or some other BPF consumer) as opposed to how the instruction looks
> like once loaded.
> 
> This is hopefully easier to understand by implementors looking to
> generate and/or consume bytes conforming BPF instructions.
> 
> The patch also clarifies that the unused bytes in a pseudo-instruction
> shall be cleared with zeros.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>

Acked-by: Yonghong Song <yhs@fb.com>
