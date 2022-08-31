Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF35A73F4
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 04:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiHaCiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 22:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaCiB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 22:38:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038C9C530
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:38:00 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V0puFH029551;
        Tue, 30 Aug 2022 19:37:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=r8UNKyqegjsOFViIcELUNR0oMghbfc+XziaXIWVYTkI=;
 b=GjXdQMpK5M6cjC9jXBS+FDraznxPm1Rd2ldJhUqFEMUyfL2YQgue1uszfcFMFstPSFjn
 a4UvdsQVFSd26bAEfcjbi4iMgTSW3eiVYCCXgwdFPOLyLChdh9GG9VPaLZ7xepK4SgnF
 HvDSACVtIxXRZuV+Nihz11T/dwyOQ+T5T1Y= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6j70nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 19:37:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ0E3oHJ4BTF8OBeZzq51oNtuwvgFjw+5o+LaH1ECyfYtA8/d2LG3NcsoZpFSJT4uqwpjDlB+2hiyU0Lsru/hD/7k2iB+1paElChTCYvtcgjAlUfN7e9vnE6HrQlzHBEc7L+4pbIhaqeppk+Ar4zqyqULiQefbmOPdQTK8OnXMJB5NT88WDKhxUR/8Uhh+8Bjtji6bIIIc4d6veLfv345lp5VlnTlahBrRn/ViTZUdGeMCVmfe6sLrtL0htn/DPnUQwY7aQxb16R7y/BC+G2xQGV8zbGgLJvr5rOF0RPLO4PBz1qvgFMiiySA0Ty9l4dnwRhfu5KX4w5QH1Il2JzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8UNKyqegjsOFViIcELUNR0oMghbfc+XziaXIWVYTkI=;
 b=Ah5r4yc17Xquyw4hC3F1aXxuA0yIyaWohgZtrdNkaw/k6mNwbdSOAxigB+J+y7LKYLo6FcxH+33RjlQaNd9DcoA1Hgtn5bKxZ87NetzJqzFhUxN3/Nbhjdb9LMjBMGW78I7UKyuKRwQJgnV/TPZS6F4epUcsVMMI1L9BFen5BptFUs6ydUXeI0EY9tAOZMIV3rEMAv1ylFf18Jn4kTRoSHeV5divnDfAdDrO9VS1UpbF7Z3m8GO0p34V3xVxRO0Tg5V2EpbXO13L9m/0d75GReldqM/ib9K/sapBsmSK49FCUHIcqVi3+ZcyZ2qvFT5EwcKI4ZEOodRz+4LB2Jmq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1270.namprd15.prod.outlook.com (2603:10b6:903:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 02:37:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 02:37:42 +0000
Message-ID: <e9b60730-3e60-edde-f2cc-8ad7c5adec04@fb.com>
Date:   Tue, 30 Aug 2022 19:37:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-2-kuifeng@fb.com>
 <463f8b46-dd40-a91a-b7fe-36846d4c6a34@fb.com>
 <eedcedd719364a1c1b845113f19af5a7f617f99a.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <eedcedd719364a1c1b845113f19af5a7f617f99a.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64344de8-e621-48a2-fa0b-08da8af9c761
X-MS-TrafficTypeDiagnostic: CY4PR15MB1270:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcr6qoRCvPHtk3iwJSk55ecU538RZmit9mizP7xHewpFblsy1Od1/fYhQtahN1XPa2u/oB7qfmEbjnZ5p3mjZ/NL39J3O3KcGXuhoXTN2f1i266JOSK8+1XGSQaHIJutO3Ry1uc1E5QTIWWapddekmuDxZNpBp4WhJkJeq3JxBWLUrE4xb4ZakiUdwFLoEHeaxbSqoaDcABwAv0ov3DiiFXwythmYeIiKAKJMnmy2cE1ms60S8MZmgnOzBoDa3qy+KDFIUnIsnuek75wC7bmj6iUjFeix6zPoUFzUNwyDfGCmBWORemhB3djTWoOgxHRPuT6cP1E5ktg9sYlFJQnXg44AdQguPM539Zt8izHw+Z4W7jjnSI6SHezxVnjEYbZahI8bTBJnpTrBheZ1iwKmBCts19HcXOR3AnIE8AEbDgb8Peya9ako7EJfn40uzSmZUvtTlChirmI+8guW6QvS+I8aXhuaBwGVPtiN6izyAcN/dRRpZU9nuIyruJ0ZqdSPDIMTkLRuMDvBOVFAYZlUgaKXti3EfPxyFcxxCWi6HmRNfDSimiLT8sXbsaUOPFsSsVKZrgt8qg2Gz5O8djR3KrTuVdm/lNPXIMip+7qSzTJw5sK40vpG/hLpMlMSfvXmXg3+Sg8UxujdwzrclJQdpSBvmeqtC71U7Tiu8XvFmOxfuW40c+GzTppsZdDH9Jihz00IqihQ5Dw2dDp4cBGd2dEjcXDc6LMwp/b0LSH9UrA6Fbn8nAHsseXwbw0caYl/xyBzhQcTJBXAKAbvGJxgL2Qb+TjYL39GQMgQOFvPIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(2616005)(36756003)(110136005)(316002)(38100700002)(86362001)(31696002)(186003)(83380400001)(2906002)(53546011)(6486002)(8676002)(41300700001)(66556008)(66476007)(478600001)(66946007)(6512007)(31686004)(8936002)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emE5cno1L2VCK0xVT1kzVUwxSTZ3K0E5RkN3MXlQa0J5SjRnSnBmZ0FnRDF5?=
 =?utf-8?B?a05HRW80OVZ0TU1La1JnaG9WTEVRb1ZMdkJMckJobWNiWk4wbGk0K1RiWDRQ?=
 =?utf-8?B?SzF6TzlQeEFDS1R6Z1VERTJvRkZFcWh2RHJoU3I3MmJQcW5UTEtsTGhIKzZP?=
 =?utf-8?B?VkxhUWlTZlVnRWM2MXorSk9ybjBCL1JJUkxrcC81Q2hEK2Zia05yK2RzcG9M?=
 =?utf-8?B?QnlRTFEyWkVxc2NmVG5hYVJEYmN2TEdFYnZMcVdVczg5WWozN1BtQ1QrQjNB?=
 =?utf-8?B?RlZFamFUZ2FHcEVnWm1DMlh1ejJqZWJEcnNITS9iS2NMMXNKZkNXNzZiVkhU?=
 =?utf-8?B?aDY2QzZqclg0eWsxN2hPZ20zYkkzdnoxejEvdGJSalpkTU0xZWxGdU1vUWtN?=
 =?utf-8?B?c1pZS2ViZVRKaWRLTU9OcFRlSThaQXRCM3dyL0JQSnJRRlQ4TGhNdll4bE04?=
 =?utf-8?B?ZzJ4d21NWStEMWlTQlZnOVp6YzJIZndnMTdrakJIQ09YN1BoRC9HQ2NPQ2tW?=
 =?utf-8?B?SmtWT1g1YVhpeGxkcTN2WWkrZTNWckMwbE12cnNybFN0anR4QkZRa2wxdkQy?=
 =?utf-8?B?TVlIWC9RTnJRZStiWll3V2FoV25WQXh6L1lkYXJoaWlNRTNXUnI5YVhSVStq?=
 =?utf-8?B?R25kOERrR1JOU3hZNG1XbERuNFY3a0N2M29OVkJJQW9uc092Tk5ReWNqT05E?=
 =?utf-8?B?ZnNZYlBRKzRvUGFhNTl0c0xWS1JGbHFzSjI1Rzh1ZkZMbXlQZHVVcnpmOWQv?=
 =?utf-8?B?T2M4SUlrWHZQMlZKUFdLbzBZbUhMZDl2VWVWaVI0MmZtQ2FNNW5mTDlST1lR?=
 =?utf-8?B?ck1Rb083QXFQbnhoUzlDdXYrTzY3cGVGU0tvOFhseEhTZWZWcElxS3pEZ0NZ?=
 =?utf-8?B?YjdkNlhvME54SjFEOWg1RklpcmJvSlBZTkZnNWxEc2xCbGhlSmFCY2RZRm43?=
 =?utf-8?B?RU5OK29Id3p2WXJrK08zZUswWWMvWXRTQm5wYUtFcFIyK3RyQmRtUEMwR3Nk?=
 =?utf-8?B?allPMW1YWENuQUtCUW5TRldhMVZaS1NjQk9lWDNPa3ZPOGdac2xIdHU1OHVW?=
 =?utf-8?B?ak1GNFNlNzVKbHhMSUNMb1ZqZ2cwNi91UTRPV0NVZnNsMkhRL0hCNDMwUnVC?=
 =?utf-8?B?U3VHb0U4bWRyNWtUeFFGRHJ5aUdFWlF6YnBJSFl4VXEzcTlxRTlZS0dxVnpF?=
 =?utf-8?B?WGl3UWlxMGcxUS9Od1p5c0MxSTVJWFZkUXExcGlmaGlkWDJYSUw0cE0yVnpp?=
 =?utf-8?B?dUNhNVdRdTVwVnZQdWNkZXZGMGY3UTQ1YnlLMDY0a3VMeUNqa1g2ZkIvZ0Fn?=
 =?utf-8?B?ZW1KMGNlVzlPV0tDZEo3R3hwTDhFTGhKeXpiSnh5ZFlVNitYcFV3MWhTSmlM?=
 =?utf-8?B?VnFQbm4zV0xTSGovVDBLVnZ0ck1tbnhubU8rUDZKQVNpMFVPVkFjdUZMVHpv?=
 =?utf-8?B?Mkp2U1lCc1hINkd1SzlEZTlXTThHUHRRU1R4Rm5MYnZCdnluS0xudGFEa1Bu?=
 =?utf-8?B?RTcxOXR2OTNmcnBaeVBGMkxDWU9tS29XNHU5T3h6ck9zZDV0aXB2S0lCRm5Q?=
 =?utf-8?B?YzQ0SUhoWVFhTzNYdmVGQmFIQWNPbEF4c3FrdmFYK0Y0eWtYU29pOFJHVTJq?=
 =?utf-8?B?MG5GU2ZtUlA1MWl2VjUrV3UzVGFlby9xMThFLzd1SncrU0ZGd24xUXlEdGRJ?=
 =?utf-8?B?cHJ5Z2NMUm1KRS9DVDlQYk5ZcU5uMkI2bm5CTVNmTk8xTS9NMTdueTlJdDN3?=
 =?utf-8?B?U1hYTXJlaUVqSTRvbTB5TVkvWlBkYm9yWkhGeEIyQU50Z3RQQVE2aTFJeXI5?=
 =?utf-8?B?OFRYS0l3ZVk3OFlteWM5UWlXQnV4dmNmWkRxa0ZPbFVITm9ra1JscjkvcGw4?=
 =?utf-8?B?V3psZEdERWFjNjlhNkg3SkcyclpGanNuSUI3VEo4RUsweVozaDN6UVRydGZX?=
 =?utf-8?B?Z05MRmJhUGNzdGdzbzkzVDVreVRYbEJzN0RNbit3TWdSRTN6S3l3TWF1bVdC?=
 =?utf-8?B?VWVTMWp5WmJ1OHlGTEpYV0laL3NKYysvd2hFT2tNaUJxMGhXS2c3ek9sTjBk?=
 =?utf-8?B?c040dkhKUlhCVWI1LzkwZWwyZWtXSVNTT216NTR4c2MzVlUxR2VvUmVFZ2FO?=
 =?utf-8?B?QlZ2ekF1RXZYWmp1RksySThLM3BVL295dGluWjY0d2ZablVlK1FNbUNLUXBZ?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64344de8-e621-48a2-fa0b-08da8af9c761
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 02:37:42.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cn08av0EocHqaEHGj32SCopCJzB1AidE0AKEWNGkXqNeEv0QaFG+C1/UAhHc6+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1270
X-Proofpoint-ORIG-GUID: ObyyCG03t37o2u37exYT5QKBOU-4jwaV
X-Proofpoint-GUID: ObyyCG03t37o2u37exYT5QKBOU-4jwaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/30/22 5:35 PM, Kui-Feng Lee wrote:
> On Tue, 2022-08-30 at 16:54 -0700, Yonghong Song wrote:
>>
>>
>> On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
>>> Allow creating an iterator that loops through resources of one
>>> thread/process.
>>>
>>> People could only create iterators to loop through all resources of
>>> files, vma, and tasks in the system, even though they were
>>> interested
>>> in only the resources of a specific task or process.  Passing the
>>> additional parameters, people can now create an iterator to go
>>> through all resources or only the resources of a task.
>>>
>>> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>    include/linux/bpf.h            |  25 +++++
>>>    include/uapi/linux/bpf.h       |   6 ++
>>>    kernel/bpf/task_iter.c         | 184
>>> +++++++++++++++++++++++++++++----
>>>    tools/include/uapi/linux/bpf.h |   6 ++
>>>    4 files changed, 199 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 9c1674973e03..31ac2c1181f5 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1730,6 +1730,27 @@ int bpf_obj_get_user(const char __user
>>> *pathname, int flags);
>>>          extern int bpf_iter_ ## target(args);                   \
>>>          int __init bpf_iter_ ## target(args) { return 0; }
>>>    
>>> +/*
>>> + * The task type of iterators.
>>> + *
>>> + * For BPF task iterators, they can be parameterized with various
>>> + * parameters to visit only some of tasks.
>>> + *
>>> + * BPF_TASK_ITER_ALL (default)
>>> + *     Iterate over resources of every task.
>>> + *
>>> + * BPF_TASK_ITER_TID
>>> + *     Iterate over resources of a task/tid.
>>> + *
>>> + * BPF_TASK_ITER_TGID
>>> + *     Iterate over resources of every task of a process / task
>>> group.
>>> + */
>>> +enum bpf_iter_task_type {
>>> +       BPF_TASK_ITER_ALL = 0,
>>> +       BPF_TASK_ITER_TID,
>>> +       BPF_TASK_ITER_TGID,
>>> +};
>>> +
>>>    struct bpf_iter_aux_info {
>>>          /* for map_elem iter */
>>>          struct bpf_map *map;
>>> @@ -1739,6 +1760,10 @@ struct bpf_iter_aux_info {
>>>                  struct cgroup *start; /* starting cgroup */
>>>                  enum bpf_cgroup_iter_order order;
>>>          } cgroup;
>>> +       struct {
>>> +               enum bpf_iter_task_type type;
>>> +               u32 pid;
>>> +       } task;
>>>    };
>>>    
>>>    typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 962960a98835..f212a19eda06 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -110,6 +110,12 @@ union bpf_iter_link_info {
>>>                  __u32   cgroup_fd;
>>>                  __u64   cgroup_id;
>>>          } cgroup;
>>> +       /* Parameters of task iterators. */
>>> +       struct {
>>> +               __u32   tid;
>>> +               __u32   pid;
>>> +               __u32   pid_fd;
>>> +       } task;
>>>    };
>>>    
>>>    /* BPF syscall commands, see bpf(2) man-page for more details. */
>>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>>> index 8c921799def4..0bc7277d1ee1 100644
>>> --- a/kernel/bpf/task_iter.c
>>> +++ b/kernel/bpf/task_iter.c
>>> @@ -12,6 +12,9 @@
>>>    
>>>    struct bpf_iter_seq_task_common {
>>>          struct pid_namespace *ns;
>>> +       enum bpf_iter_task_type type;
>>> +       u32 pid;
>>> +       u32 pid_visiting;
>>>    };
>>>    
>>>    struct bpf_iter_seq_task_info {
>>> @@ -22,18 +25,107 @@ struct bpf_iter_seq_task_info {
>>>          u32 tid;
>>>    };
>>>    
>>> -static struct task_struct *task_seq_get_next(struct pid_namespace
>>> *ns,
>>> +static struct task_struct *task_group_seq_get_next(struct
>>> bpf_iter_seq_task_common *common,
>>> +                                                  u32 *tid,
>>> +                                                  bool
>>> skip_if_dup_files)
>>> +{
>>> +       struct task_struct *task, *next_task;
>>> +       struct pid *pid;
>>> +       u32 saved_tid;
>>> +
>>> +       if (!*tid) {
>>
>> Add a comment in the above to say that this is for the *very first*
>> visit of tasks in the process.
>>
>>> +               pid = find_pid_ns(common->pid, common->ns);
>>> +               if (pid)
>>> +                       task = get_pid_task(pid, PIDTYPE_TGID);
>>
>> 'task' is not initialized, so it is possible task could hold a
>> garbase value here if !pid, right?
>>
>> Also if indeed task is NULL, here, should we return NULL here
>> first?
> 
> yes, it should return earlier.
> 
>>
>>> +
>>> +               *tid = common->pid;
>>> +               common->pid_visiting = common->pid;
>>> +
>>> +               return task;
>>> +       }
>>> +
>>> +       /* The callers increase *tid by 1 once they want next task.
>>> +        * However, next_thread() doesn't return tasks in
>>> incremental
>>> +        * order of pids. We can not find next task by just finding
>>> a
>>> +        * task whose pid is greater or equal to *tid.
>>> pid_visiting
>>> +        * remembers the pid value of the task returned last time.
>>> By
>>> +        * comparing pid_visiting and *tid, we known if the caller
>>> +        * wants the next task.
>>> +        */
>>> +       if (*tid == common->pid_visiting) {
>>> +               pid = find_pid_ns(common->pid_visiting, common-
>>>> ns);
>>> +               task = get_pid_task(pid, PIDTYPE_PID);
>>> +
>>> +               return task;
>>> +       }
>>
>> Do not understand the above code. Why we need it? Looks like
>> the code below trying to get the *next_task* and will return NULL
>> if wrap around happens(the tid again equals tgid), right?
> 
> The above code is to handle the case that the caller want to visit the
> same task again.  For example, task_file_seq_get_next() will call this
> function several time to return the same task, and move to next task by
> increasing info->tid.  The above code checks the value of *tid to
> return the same task if the value doesn't change.

Could you explain when task_file_seq_get_next() will call this function
several times? IIUC, from the following code,

+static struct task_struct *task_seq_get_next(struct 
bpf_iter_seq_task_common *common,
  					     u32 *tid,
  					     bool skip_if_dup_files)
  {
  	struct task_struct *task = NULL;
  	struct pid *pid;

+	if (common->type == BPF_TASK_ITER_TID) {
+		if (*tid && *tid != common->pid)
+			return NULL;
+		rcu_read_lock();
+		pid = find_pid_ns(common->pid, common->ns);
+		if (pid) {
+			task = get_pid_task(pid, PIDTYPE_TGID);
+			*tid = common->pid;
+		}
+		rcu_read_unlock();
+
+		return task;
+	}
+
+	if (common->type == BPF_TASK_ITER_TGID) {
+		rcu_read_lock();
+		task = task_group_seq_get_next(common, tid, skip_if_dup_files);
+		rcu_read_unlock();
+
+		return task;
+	}
+

task_group_seq_get_next() is only called once per task_seq_get_next()
for BPF_TASK_ITER_TGID.
Maybe I missed something?



> 
>>
>>> +
>>> +retry:
>>> +       pid = find_pid_ns(common->pid_visiting, common->ns);
>>> +       if (!pid)
>>> +               return NULL;
>>> +
>>> +       task = get_pid_task(pid, PIDTYPE_PID);
>>> +       if (!task)
>>> +               return NULL;
>>> +
>>> +       next_task = next_thread(task);
>>> +       put_task_struct(task);
>>> +       if (!next_task)
>>> +               return NULL;
>>> +
>>> +       saved_tid = *tid;
>>> +       *tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common-
>>>> ns);
>>> +       if (*tid == common->pid) {
>>> +               /* Run out of tasks of a process.  The tasks of a
>>> +                * thread_group are linked as circular linked list.
>>> +                */
>>> +               *tid = saved_tid;
>>> +               return NULL;
>>> +       }
>>> +
>>> +       get_task_struct(next_task);
>>> +       common->pid_visiting = *tid;
>>
>> We could do quite some redundant works here if the following
>> condition is true. Basically, we get next_task and get a tid
>> and release it, but in the next iteration, from tid, we try to get
>> the task again.
> 
> Yes, I will move 'retry' and move next_task to task to avoid the
> redundant work.
> 
>>
>>> +
>>> +       if (skip_if_dup_files && task->files == task->group_leader-
>>>> files)
>>> +               goto retry;
>>> +
>>> +       return next_task;
>>> +}
>>> +
>>> +static struct task_struct *task_seq_get_next(struct
>>> bpf_iter_seq_task_common *common,
>>>                                               u32 *tid,
>>>                                               bool
>>> skip_if_dup_files)
>>>    {
>>>          struct task_struct *task = NULL;
>>>          struct pid *pid;
>>>    
>>> +       if (common->type == BPF_TASK_ITER_TID) {
>>> +               if (*tid && *tid != common->pid)
>>> +                       return NULL;
>>> +               rcu_read_lock();
>>> +               pid = find_pid_ns(common->pid, common->ns);
>>> +               if (pid) {
>>> +                       task = get_pid_task(pid, PIDTYPE_TGID);
>>> +                       *tid = common->pid;
>>> +               }
>>> +               rcu_read_unlock();
>>> +
>>> +               return task;
>>> +       }
>>> +
>>> +       if (common->type == BPF_TASK_ITER_TGID) {
>>> +               rcu_read_lock();
>>> +               task = task_group_seq_get_next(common, tid,
>>> skip_if_dup_files);
>>> +               rcu_read_unlock();
>>> +
>>> +               return task;
>>> +       }
>>> +
>>>          rcu_read_lock();
>>>    retry:
>>> -       pid = find_ge_pid(*tid, ns);
>>> +       pid = find_ge_pid(*tid, common->ns);
>>>          if (pid) {
>>> -               *tid = pid_nr_ns(pid, ns);
>>> +               *tid = pid_nr_ns(pid, common->ns);
>>>                  task = get_pid_task(pid, PIDTYPE_PID);
>>>                  if (!task) {
>>>                          ++*tid;
>>> @@ -56,7 +148,7 @@ static void *task_seq_start(struct seq_file
>>> *seq, loff_t *pos)
>>>          struct bpf_iter_seq_task_info *info = seq->private;
>>>          struct task_struct *task;
>>>    
>>> -       task = task_seq_get_next(info->common.ns, &info->tid,
>>> false);
>>> +       task = task_seq_get_next(&info->common, &info->tid, false);
>>>          if (!task)
>>>                  return NULL;
>>>    
>>> @@ -73,7 +165,7 @@ static void *task_seq_next(struct seq_file *seq,
>>> void *v, loff_t *pos)
>>>          ++*pos;
>>>          ++info->tid;
>>>          put_task_struct((struct task_struct *)v);
>>> -       task = task_seq_get_next(info->common.ns, &info->tid,
>>> false);
>>> +       task = task_seq_get_next(&info->common, &info->tid, false);
>>>          if (!task)
>>>                  return NULL;
>>>    
>>> @@ -117,6 +209,45 @@ static void task_seq_stop(struct seq_file
>>> *seq, void *v)
>>>                  put_task_struct((struct task_struct *)v);
>>>    }
>>>    
>> [...]
> 
