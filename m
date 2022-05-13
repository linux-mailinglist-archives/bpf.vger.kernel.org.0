Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC752597B
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376382AbiEMBmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiEMBmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:42:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453A6C568
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:42:34 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMLWl023293;
        Thu, 12 May 2022 18:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UZDr6INhcds66+ula2b84B0sew4Tj6aS82Pqd/CXbKI=;
 b=UKjwwDpfvd3LJuoAdR9KuZIsqOco+slTxc+9zLE1qQ6YLPidpVnhx2X5Am6oWODxcYeO
 DUjqL5TL/y24pOC2PkSu/49TgeyL9SuPf4yUXJd6T6PEtlZ+RP6CFtYzUS+ZjlpE9y1+
 pfSvuDtE3ojmD5a5IMAYAaWZ1/4TtEPQsbs= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g17vytxub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWE5JFNHjLQTOLOFOfkrF5Jj2xaYyxNNA6NrLRpc3B71IxNHOGqspx4YEKSK0sj2OO8gul3M6FDlSrozgPabraj+lzQ3DSvQb4BEmCS8/MklWVDtZ2EM1agNDxRfTK3NP5llHdJH8stiHoCk5r3e5u6NGwq2vuDT8B+OFnNzb0clTkxcqnBVDzrJIo/Hn/fWgzqPUeXasel/lciXgpLNHSxeJV8XCNJCfi/yim46DzfteqX3ooNcCaxlV5T2lW6ZNCaSr/20oamoa2t1aukKXXIixuluODwb0LEaDl+zBLMrsIMc+jT+Dm9zlDfdgPTf+xPoWQ15EBNDGNgEtovZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZDr6INhcds66+ula2b84B0sew4Tj6aS82Pqd/CXbKI=;
 b=mUdmQOnAuuf1PPPC62p0pJ9C4XfULq6ptQzl3uNbb2NBD6RsRCreZUnT2r+ejWTQcweo378uF4KsG48bKrP7CHnd/n9Is0GeZz9kys9XIFiU+6Ol6PiqveFLYr56T50jaXJDxQTNbmh3PGiKdQyKBCLju/vP2fH1rHeX6DqoghVjl3sqlGtgd99WypUIBUmx+zvX5211YsA4qqF2k2yF3myLwGsasey/yiV1qDonM42+1mOtG+m3Y/G/Cw8pSjKQyhibtPnDyesGXrEJW5b7XMdBCHgyDnJtb2GPjUD63NWlNW1LCTVabACFdxqI6CgMFBPwyh1L1bu0hdRkt3AcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1643.namprd15.prod.outlook.com (2603:10b6:3:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:41:54 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 01:41:54 +0000
Message-ID: <f52ded4c-2d62-66dc-8e9d-9a4ba8671c02@fb.com>
Date:   Thu, 12 May 2022 21:41:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage
 get
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, kernel-team@fb.com
References: <20220508215301.110736-1-davemarchevsky@fb.com>
 <20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:408:f7::19) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8731f6a1-e32d-4f86-57ba-08da3481c290
X-MS-TrafficTypeDiagnostic: DM5PR15MB1643:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB1643DE0F847C8B119998F2A1A0CA9@DM5PR15MB1643.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVttT0n7OvW+OhQsKF+adWQTm8h7zkj/wgT4SKq7652GwC7OWJsxtxx1RvFOc1dIVR7venbX+tILFScpvlrQK28TyutzRfn8dpMBJk1+ZwTa66WfHPmxduy1CHrvwQTOYSYyuIm7ldAxJg76a29O9UWa2B2XByMoLa5maCXLV39U7ozj8HFujqE224Isk2KeK6xpCP1RLDd6/rRavAfwy1vdlXpoQJXBzDiDdeUaxMwWjxS5lt2kMGrRwsfzUcb927to7OXz+YlMnrjBlW6twNlfr2L2FlrVb+FF9CzoShOb8A27ZUPcC+yiFsRHidaUIQImLItE+/+c6EeM4QgPiqQeFuoIokQsVEqCYjwM4G2jPR7NOf57fYe2wnUwcHI14tdOc4mKhyTgmE3/abap49mZEeUZQQMCMnqUjtFnUSzNZnsmOKOodtQvG6sdcHug9aXl/qdQrJGqU3RCkZnkC16wcyQ5el3CLPuLP53QfwwxMv7P1EKIS+Wf0++aVmAjxMSCIW52Y+g86fLznsiVZgAt3oH4zOeITs7EPCrDDi3YDg6xuHLlL3Zi12KCD4zoA5Xk72wo5UVFZAHPDNMmsldl9fd2y25ZPKtmGceW0YtzT2lgTbu/59JxSAr93Haxq0+BoDz8sGsD3fcfAm7x0BOIK23pRlwpEO4YdF35HpfJe52fcIiK01AiKj3ilaw5S3uloGx/1yvunsAqcxGjLXOZuQBpLJ7bTxgBkS5QFLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(66946007)(66476007)(66556008)(4326008)(8676002)(86362001)(508600001)(54906003)(2616005)(6512007)(31696002)(53546011)(6506007)(6486002)(8936002)(2906002)(186003)(316002)(6916009)(5660300002)(31686004)(36756003)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0M2cjR6VGQ5TEcrd1lBa3pvY0dLT0N0TmdHSm5tL2ZxRGxkVGh5UURsd2RH?=
 =?utf-8?B?VlZYWFlHMldZenBCZFpLM29YNjFXZllEVmtzd2lBWUQydzRmT0NFVHZueDZW?=
 =?utf-8?B?c0N1bHlZRkEvbkdHMmk5Y0NlQVBFQmwwaUhwMzNXa0RGV05lblNydWNFcGRz?=
 =?utf-8?B?bzBBcERaTm56dVZFeG12MTNlbVhNVERJWHBaQmI2bkNyQmtWT3o0L2VEZHRJ?=
 =?utf-8?B?OFYxM3dub0lNdlhDWTJkclppK08yZnNmNndMbEVrSlBsYnBicVd6d1I4S0lU?=
 =?utf-8?B?OGNKVEpydWxxUGlNSjk0Nkd3dDVJQ0VjWDJraFJGSC9LWGlsZmdwWUVzMXRK?=
 =?utf-8?B?SzlzTll5cm9NYlE2ZmpId1VJVnI1UTIzdnUrT2ovRkdqbDdtY2lZVStmSGM0?=
 =?utf-8?B?OVBMUkF6L1pFblNMTVlnTTVxRHFCRlpvVFE5eUhIVG5xcjNCMVNkdThnMlpi?=
 =?utf-8?B?ZVNuS25lVWxTemljRHNhRk1PM0pvZk84d1pzUWNMa0hxbEpvOFJWMlV6U1Y3?=
 =?utf-8?B?QmZLbVQ4V3E4dGl0Zzl6b3Y5OG4ybWhQV3JyeHRaeCt3UjYxcWpGeGNEcVZi?=
 =?utf-8?B?SXBBS1BlOXI1VWkrUlVGK2l2ejFCbVk3TkJXb3d4TjY3cXpkODNrZTZkVVdR?=
 =?utf-8?B?WGtUSVI4Z0JnOUx1UHVCQlNERmF0cWRhOEVDMHlQZ2J1L1grZTF4eHoxYWNM?=
 =?utf-8?B?bnN0QnU2VHpyRHdvV2xEYjdRZHBlT3dyVEdYRnlEcXBpUkZGenJHTXhyT3BN?=
 =?utf-8?B?RGdEU2VMZUJoMVMweDBhT3NNV09TY2VPZlREM2U0SFd6dnBSeWV6Qno0M3l3?=
 =?utf-8?B?eWhwTXoyZFJITnJHdDMvUE5mVnZUMG9rQkd2REl6d2VJT0JWd1ZLWW5RYmhR?=
 =?utf-8?B?RkNPTmNPQzJ4K1NzaUVhTkJXZlBING43NXVzN0pjSUpLTU1raG1mYzB5UG0w?=
 =?utf-8?B?ZTIyc2FQckp5b0FzTGFjaEtlK2FIaEVySWs2VEhMMllzYmxvYU9lRjYwYmpV?=
 =?utf-8?B?dUdET1pISWdyZno2NnpiZlFGSFMvTWlMZmlhL0NoenlNYlNMNHY3Q2U1RnF4?=
 =?utf-8?B?WmErUndMYWF6eFZJbE1OaTYwUjkxWTEyOXhJZytkYlFUS1F5SnJreWhWalUz?=
 =?utf-8?B?WnpTNlNXdVkva0xLa2hza2c1QTJKVE8wZDN2WWRvUUV0VTZhU3BpTmhWeW03?=
 =?utf-8?B?b3dtQ3pzQjRwVHpoWWdDQ2hvcXdPaVNvYUVuYUhUZWovL25uSkxTR2FObXhz?=
 =?utf-8?B?eGVRL3NqMGU2US91WEZSZGQ2YndEN2tQUlpvL0VYc1dCK0sxdnBQSmdsc2Vn?=
 =?utf-8?B?cTgwK1V3em45YTJ5UHpPeEhaSkYxR09hdVJQMnpTQ1NtZmt0c2tMaUFSVEFp?=
 =?utf-8?B?d1g1bHVwU2VLM1NhbWFISi9Od1RaZjIza1dMdUFleHAwbGkwN0tISktDaXdT?=
 =?utf-8?B?VEVoT1VweVpVS1U1WW9qZjU2cWZLdExwNDZTQ0VkcStCYXF0aUkvNkw4WE9F?=
 =?utf-8?B?ZUllRTlyUEpHMGk0MHZFZVVOWkJpKzFreVFYWmROVFlTc1ZEZm81UUFIYnlS?=
 =?utf-8?B?eHZFdUlwekNmamxzUGY5MEQ3STZXUExSRndhdVcyWWNwZVFLR2ljZVJHWTdv?=
 =?utf-8?B?VW82aXVtRWdTaW1FZlB0dWM0dklCZVFUeVlMdzcrTE5NalBKNXpFNTR4SE16?=
 =?utf-8?B?Ukx3cnNqTDhtcjlwM1gyWlVjKzBrd3RCTHQ0bXpCMk9WSGY5SzJQdmJPVGxV?=
 =?utf-8?B?YnU1WHJTSmpEREhZRHhDSnNpc29kTzVDR0w1OS8zREcrNzZwVHpMd2UrTlZH?=
 =?utf-8?B?SmFKYWpJVkNPWGVINkdHV214eHc2Y3dVakRRVndOT3lRcFVPVUdmeXZweUp5?=
 =?utf-8?B?N0RYWXkyRllmeWtyMUxzZU5HWGtaMEVOSmhKdjdLenR4M0tJZHZhVzVmaUsx?=
 =?utf-8?B?ZHdoVElnUXBMeGwwcUZNL3pLbVR0Nzhta0RUWVI4NkpEYjNvUVdVTkxBbWtx?=
 =?utf-8?B?bzdQZmQzWFJFOURVNTAwdTdmQXV0bTVmeVJBS2FUVEtvaU1PczlZZURJODBN?=
 =?utf-8?B?TmdlNEhqZnNIRkdlQzlSbDFLcE82dUFpTVBoVjdMRWluUUkxcTlFendpUmxS?=
 =?utf-8?B?S3RzSnIxU2hzeDRzTlRwMWIyaGVPdzRaeHZ2dWg0eHJuQ01kQ01VeUJzcjFZ?=
 =?utf-8?B?Z1FBSUtxdEs1Y2xRN2JyTHpHQWNkRFYveWl3U2d5K2Zlelh4Y09TdDExbmVT?=
 =?utf-8?B?akNjVjJOUXZjU09qR0VFU2FrOUJIR21IYmNLUlYwMUxqOTJITkZuYlZ6MUtM?=
 =?utf-8?B?RXdYM0pBRmI0NHFQeW40VzRQS3VCYzZaQkM1VWJ6UE1RbGtieTFBUT09?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8731f6a1-e32d-4f86-57ba-08da3481c290
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 01:41:54.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5iR9LXgoJAom3PiZqJtQa0IIQO4S03KvoRS2K7D4wcmAp6tYR3/sRdb+VvKrbcC8mGkQsPQMMXJCAlnfyWOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1643
X-Proofpoint-ORIG-GUID: WmFRQwn0aDut3zp293Cd4q_rR31PT4sV
X-Proofpoint-GUID: WmFRQwn0aDut3zp293Cd4q_rR31PT4sV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/22 1:33 PM, Alexei Starovoitov wrote:   
> On Sun, May 08, 2022 at 02:53:01PM -0700, Dave Marchevsky wrote:
>> Add a benchmarks to demonstrate the performance cliff for local_storage
>> get as the number of local_storage maps increases beyond current
>> local_storage implementation's cache size.
>>
>> "sequential get" and "interleaved get" benchmarks are added, both of
>> which do many bpf_task_storage_get calls on a set of {10, 100, 1000}
>> task local_storage maps, while considering a single specific map to be
>> 'important' and counting task_storage_gets to the important map
>> separately in addition to normal 'hits' count of all gets. Goal here is
>> to mimic scenario where a particular program using one map - the
>> important one - is running on a system where many other local_storage
>> maps exist and are accessed often.
>>
>> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
>> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
>> bpf_task_storage_gets for the important map for every 10 map gets. This
>> is meant to highlight performance differences when important map is
>> accessed far more frequently than non-important maps.
>>
>> Addition of this benchmark is inspired by conversation with Alexei in a
>> previous patchset's thread [0], which highlighted the need for such a
>> benchmark to motivate and validate improvements to local_storage
>> implementation. My approach in that series focused on improving
>> performance for explicitly-marked 'important' maps and was rejected
>> with feedback to make more generally-applicable improvements while
>> avoiding explicitly marking maps as important. Thus the benchmark
>> reports both general and important-map-focused metrics, so effect of
>> future work on both is clear.
>>
>> Regarding the benchmark results. On a powerful system (Skylake, 20
>> cores, 256gb ram):
>>
>> Local Storage
>> =============
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 20.013 ± 0.818 M ops/s, hits latency: 49.967 ns/op, important_hits throughput: 2.001 ± 0.082 M ops/s
>> local_storage cache interleaved get:  hits throughput: 23.149 ± 0.342 M ops/s, hits latency: 43.198 ns/op, important_hits throughput: 8.268 ± 0.122 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 6.149 ± 0.220 M ops/s, hits latency: 162.630 ns/op, important_hits throughput: 0.061 ± 0.002 M ops/s
>> local_storage cache interleaved get:  hits throughput: 7.659 ± 0.177 M ops/s, hits latency: 130.565 ns/op, important_hits throughput: 2.243 ± 0.052 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 0.917 ± 0.029 M ops/s, hits latency: 1090.711 ns/op, important_hits throughput: 0.002 ± 0.000 M ops/s
>> local_storage cache interleaved get:  hits throughput: 1.121 ± 0.016 M ops/s, hits latency: 892.299 ns/op, important_hits throughput: 0.322 ± 0.005 M ops/s
> 
> Thanks for crafting a benchmark. It certainly helps to understand the cliff.
> Is there a way to make it more configurable?
> 10,100,1000 are hard coded and not easy to change.
> In particular I'm interested in the numbers:
> 1, 16, 17, 32, 100.
> If my understanding of implementation is correct 1 and 16 should have
> pretty much the same performance.
> 17 should see the cliff which should linearly increase in 32 and in 100.
> Between just two points 100 and 1000 there is no easy way
> to compute the linear degradation.

Agreed that being able to choose an arbitrary number of local_storage maps for
the benchmark would be ideal. I tried to do this in an earlier iteration of the
patch, but abandoned it as it would require a bcc-style approach, something like
generating .c bpf program with python at runtime, then running through libbpf
loader.

The easiest path forward is probably just generating bytecode and using raw API.
Will give that a shot, hopefully the test prog is still comprehensible in that
form.

> Also could you add a hash map with key=tid.
> It would be interesting to compare local storage with hash map.
> iirc when local storage was introduced it was 2.5 times faster than large hashmap.
> Since then both have changed.

Will do.
