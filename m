Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07855A74A6
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 06:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiHaD7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 23:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHaD7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 23:59:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48103B0B20
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 20:59:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27V0pkUA002633;
        Tue, 30 Aug 2022 20:59:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YMbBilcJJZXOBtk2rfRbDP4Ofn5VAI56qsIRHR8j9co=;
 b=Ppjp6BwFJnSkx//1r4O6VPMqnLjW2GhfBLDh7a4OByjvDCq7liIjgP/IRnvGPhzoQyQM
 CyvdvX8RcvcTiv0eEgyr4GfCXzskmjbb0RDFlZEi4lD78xbfiBvkJino3XlbwI8tMJqX
 5AqIZLCPaZ840cS+vEgWlZ218Bq/TAo7b0U= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j9hpwnrt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 20:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5ptXjg404stji8h22x3nJF+N+DEq7grpqjNQKeELCUY1uCu5y80J+d1G/j/BdzDHrFdZVqEXtlH7KiI/7sSKmxixvn9EW6a5AgvMv1zwX2fSEVn88JYa+7tQ2cAebosz1xgH6ub/36gc9LVFtL6GMGsk3Efjlg5IMAcPZnCWIhaMmXrgGoJRcI25Fp/RXtCiElHSRP7ZCRen67c86620bWtZw5tPv3HajFN5s5w9SsRZxKezFcF1BoICTze2tfXZ8qdjKJZ7BsOi9hjZhAtv+U6N4Qviee7UJ2SDmqf+vLj4b13QSFktVxiB9DiXPI+e09ZNlsB+KMxzPfD1TqxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMbBilcJJZXOBtk2rfRbDP4Ofn5VAI56qsIRHR8j9co=;
 b=IWUv4rMiYJ0KQjKpzr2X3JwUJmEdVH762ZCjQ64WYQcWeZsBsOjOJTcBuJkNor1h5lBeq3nFenCXJc/xO5I6TrZK5rkj2+7LCBJcvPIkZTi01WGrhg2+Wc+ms8WuVWrQ81ivl+6CKCd+E8NTNgXqVR8y0pqdbpPYZkvf8XrAW9CAQO9tIcKnZwJ534eTQubqVXEy8kIax3LijGfFm6ZyaydAfeHEMqKeNS96vgNiEaN2Z/KNq1UqqNnsYB5SNV+MRv3EWZP8y3pPB3smULJEYKRGZF/gbhAGYYO8eAOwyw7WcYBjt5LMVH8c8T/SexHfVvzHAnIhl1foZNLuA3YyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BYAPR15MB2727.namprd15.prod.outlook.com (2603:10b6:a03:15b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 03:59:14 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:59:14 +0000
Message-ID: <9a9bf37e-a2a0-af4d-0c39-961263c9d1e8@fb.com>
Date:   Tue, 30 Aug 2022 20:59:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
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
 <e9b60730-3e60-edde-f2cc-8ad7c5adec04@fb.com>
In-Reply-To: <e9b60730-3e60-edde-f2cc-8ad7c5adec04@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d52744-429f-493e-c01c-08da8b052b33
X-MS-TrafficTypeDiagnostic: BYAPR15MB2727:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04nYTkEQ2k19eg16oXomhuk+8K+nAs3Nv8hTETm1K9eZPCbAaQuo4mBNCalwjk+/+a0JD87F/2osM0y6c+Hn10cmXWM4c1ZcWOQ+L/YXbGZOF253pyzTq1Rbih3Yh5nZLXv19hbx+Ie0Wc9d0BWeeZcfUE0d+lnty2np2w6ZmauvXL9amM0lMob6Jtcsq1kYPvewmCJT+yx2TmCWcmZd9gx4g22pjoUGmrcuBW6FlkfepEfALidmZjkkz87jSTuuaTW8I5N3SedJaypGNFn1jMlslGPLN4Vbt3i2aSxGSnxnPZyef0iQdpnzqCInkQdgLE8ajofikIsv5346pgcPW+VX5ftf1yKLopmP5MEePKQEr+SQGWHerb1OMAkXaSH3IafCaHa4vN+g3ftVCWXksNkVkdgvWXGGQqxNZP6ONK5PgwY9M6riu4Z7ysIjvb4TiCG9TvMUh6Vqy4pWFcF0RSioe5e4jsp61Uoh28JSZZNkBS/Yt5sb49zXK7Z4PB6ZI0xOJvVBt6DcCTnZDQ5FHdAbm/jePPfR6zPwMc8eo1OGwcDTq0AhlD03BmsYYf4WIzNwiATxoWKEx9FSfrqOiJTJI4olDxjuQ/12Xi8nRoxgehq3a4VMd2R2akvM971r8IY+UX9IAlL+9a8VVCDSaUG7syT4LVl9xvfow0hnP3NpvCqN6QbrIXydkIqM6f8vIMtBQECxL2bf9Gcl4DM68S6R39zn15wAJztWg93/oG2DpMgIdojAKwLII+oKiUdikjglmNJJyQ6uq4QLHUnh0D5aT9xp2iDM/AP9OU4BLvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(6486002)(316002)(110136005)(66556008)(66476007)(31696002)(66946007)(8676002)(31686004)(86362001)(36756003)(5660300002)(8936002)(478600001)(41300700001)(2616005)(6506007)(53546011)(2906002)(6512007)(6666004)(38100700002)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXBFd0s2ZnA0bEFkUDExN2FXU0IvMHhyN3RjQTA0Vy8zWjc5RWh2Tk9kYzQ1?=
 =?utf-8?B?RXcxT3F5RmFmMGJKSStQRS92SERxWnpua252dnNic3VYSkZsWHVXUHpPb3lX?=
 =?utf-8?B?bU1BZ0tiYkt4SjRBOHFnTUJZOUJ0c0NLa2h4N3k0cDk2NEhIKzA3UEFaQ2FQ?=
 =?utf-8?B?WisxOVpxZktZaGtDWW9uTzF3dnlCbzRsRndJekVIL1pmaXJSTDE4RTEwMVFH?=
 =?utf-8?B?ZXA0eHZ1STg3T1htaWkvNmJkL09IRHZJSkV0am1RdWl4TUN3N0ZQbFMxUHla?=
 =?utf-8?B?M0lZbUsyUHdzd1RrbVkrQlNIOTMrQXdFc2d3Qy90cWJHeUo3a1M4dThSSjNW?=
 =?utf-8?B?Nm1ubnF1SEJwWnZXNG4zYldUSmlQejAyZzl6eENXSHRadFhaeG5vb0dDOW5S?=
 =?utf-8?B?MWVRWi9Ncmt5ay9HeUdWSnVvbnNoMUlRQzk2Y3FYcWduNVhZMC9uazJham5X?=
 =?utf-8?B?UEhSL1ZpdGRtbW9VSFpqcEJ2WWZraENhb0o2VmU1bitKN2xnTmlLQm9LeUxk?=
 =?utf-8?B?d1VFOFBjVnQ1MkZLbVRMbDBraXJLa2hsbW9kK1JjaXQxV2VBdDh1WHhZR08r?=
 =?utf-8?B?SlNhc1JiaUVndXRUb1JTeFM4VUlaQVpuS3M0QkVwT1JydmU2QjJjZGpXWGpn?=
 =?utf-8?B?NjU4b1NndXgzS0tYekJhU3Z2cHV3VzNWQks3MGQyUzFPbnZtSGluUUFBUER5?=
 =?utf-8?B?RWdmcCtHUkREMnlDTm52dE1QdThyWnMxY0RTWFFRMFRaeW1EZCtiSkgzY3ZJ?=
 =?utf-8?B?aXd0SGUybFBydkF2b0c3UHg0SjBScFZxbjJRbG9zdys1aUI0N3lyL2l4VDEr?=
 =?utf-8?B?eDI2KzE1Vmg0YVE0c2phWC9ycDhjM1VSZkVJamdEbzZXdXJuZTIrZXpxaXFI?=
 =?utf-8?B?cGtta1VjRUJyUUNMaDFoMmprc2FNSWlidnNnQUQrZ0ROcFRlTTUwNWFyRjgr?=
 =?utf-8?B?ZkY5RUJJZGRHY3hSMWtjVkVtQnQrSGpZaUh0S3RYaEtCT25WeEhBNnJYVGhK?=
 =?utf-8?B?M2FvbkRsd2FJY1FGWTd2THkzVm5FWEdNaGl0d0o1dWx6VVFsQWxxb0JPY2Nt?=
 =?utf-8?B?ZUZuMFByR3h5dGxxRUo2dDRCVFpneDZLN1lJVlp6QW56QXdydTZwL0Y1ZXdJ?=
 =?utf-8?B?WDhyWmVEZGRGS1lJMllsdDJPMXJxdXFqU1JRRG5sRXN2VE1GZm5pUmIwcVVx?=
 =?utf-8?B?M1lIZk5SM2VRdTBUOEozVlRUOS9yZTM5RjdTVXNSZFZ3VFZWU0htZlc2SXc5?=
 =?utf-8?B?MFhDbU11NHE4ODFvOE1KVEZRYXI1aGVOQWo2OGJxUkhPandTZHA0QUp2U3dD?=
 =?utf-8?B?b1BYRGhEU3NERElZcGRHMFBBUXhVcFlOQ0d3Rm9Gd1loZ3JFYXM4UGF5c1Nm?=
 =?utf-8?B?UHNDenM2clRkaDBha2tUUy8wWVRZQllOOE1DbzZHb3M5RUJEU1ZtRWQ2RHpn?=
 =?utf-8?B?b0VMUXh6Y2cwTXNVR01OTm9BNlFXL3d2U0FwZFViZW1CUVBvUE94Y3JabmJl?=
 =?utf-8?B?eDNMMDF0U1FLWFU2WlJXci9aTXA2VG9UYTB3cElMczdwTy8rTG9VMUVub0Va?=
 =?utf-8?B?S1VJeW1tc0lXcTdqWkRhVktXVWt3bll5bEJMNXJ5dXFQQ000a240aThaRm5x?=
 =?utf-8?B?TkJFTFhoUUdrR3hCVUU3UW9TRjJqSDh4dnpGckZhTkVtSFcwOVNCNVB0SGNz?=
 =?utf-8?B?RzQvTTFxZDFkRWhoclhMcDk4aU50aTJtaVZUa2ZOQ1B4b0JvZ3hNUjdhSkpR?=
 =?utf-8?B?L1B5eEN0SkZFTmxTelBqVzBHY1djeUF6aDA1T21JKzg0WnoyMVlYZzVqZ3NM?=
 =?utf-8?B?QkprYmF2VXY3dzVUNkxEQnZGMnpsZ3NEaE4xUmkyaWJNWG03NUZSTyt6WUlj?=
 =?utf-8?B?U3VRME5Ma0xkQWdOV1VOYUVZVjlKN1RaVFJhMzdhTHduYU5BREc1dDZNVmNU?=
 =?utf-8?B?ODh2RUtiVGJOMC8yQWc3VTdHQU0vVVNCeTE4TDZSNHFDNER0Y1dTTkpJelQ2?=
 =?utf-8?B?aU5ESFBxUnRWL1hiQk5VUURCdWhlbFRHcEwvOHlnaXpPNDY4L0JrczdJU29r?=
 =?utf-8?B?cmtFRk9hblpBZFBza0oxZVlsM2lRTkhXSEhFcTY5WHBUbXlVcHJGT2ZMdTVJ?=
 =?utf-8?B?cUs1bUV1aGlMb2NvVVhTSmpiU0dGMVNtWWIraUxvb0FCNFNhc1AyK3pTVXZv?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d52744-429f-493e-c01c-08da8b052b33
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:59:14.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQxo4W7cmI225XVQYKydEPp8p1EtnUXjcB37H/0dLb8ccn8yZk0KaZiGEIZPg4CA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2727
X-Proofpoint-ORIG-GUID: qxIuFFpbBDEyYZ-WGElwOb-aPd9_UC7k
X-Proofpoint-GUID: qxIuFFpbBDEyYZ-WGElwOb-aPd9_UC7k
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



On 8/30/22 7:37 PM, Yonghong Song wrote:
> 
> 
> On 8/30/22 5:35 PM, Kui-Feng Lee wrote:
>> On Tue, 2022-08-30 at 16:54 -0700, Yonghong Song wrote:
>>>
>>>
>>> On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
>>>> Allow creating an iterator that loops through resources of one
>>>> thread/process.
>>>>
>>>> People could only create iterators to loop through all resources of
>>>> files, vma, and tasks in the system, even though they were
>>>> interested
>>>> in only the resources of a specific task or process.  Passing the
>>>> additional parameters, people can now create an iterator to go
>>>> through all resources or only the resources of a task.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/bpf.h            |  25 +++++
>>>>    include/uapi/linux/bpf.h       |   6 ++
>>>>    kernel/bpf/task_iter.c         | 184
>>>> +++++++++++++++++++++++++++++----
>>>>    tools/include/uapi/linux/bpf.h |   6 ++
>>>>    4 files changed, 199 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 9c1674973e03..31ac2c1181f5 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -1730,6 +1730,27 @@ int bpf_obj_get_user(const char __user
>>>> *pathname, int flags);
>>>>          extern int bpf_iter_ ## target(args);                   \
>>>>          int __init bpf_iter_ ## target(args) { return 0; }
>>>> +/*
>>>> + * The task type of iterators.
>>>> + *
>>>> + * For BPF task iterators, they can be parameterized with various
>>>> + * parameters to visit only some of tasks.
>>>> + *
>>>> + * BPF_TASK_ITER_ALL (default)
>>>> + *     Iterate over resources of every task.
>>>> + *
>>>> + * BPF_TASK_ITER_TID
>>>> + *     Iterate over resources of a task/tid.
>>>> + *
>>>> + * BPF_TASK_ITER_TGID
>>>> + *     Iterate over resources of every task of a process / task
>>>> group.
>>>> + */
>>>> +enum bpf_iter_task_type {
>>>> +       BPF_TASK_ITER_ALL = 0,
>>>> +       BPF_TASK_ITER_TID,
>>>> +       BPF_TASK_ITER_TGID,
>>>> +};
>>>> +
>>>>    struct bpf_iter_aux_info {
>>>>          /* for map_elem iter */
>>>>          struct bpf_map *map;
>>>> @@ -1739,6 +1760,10 @@ struct bpf_iter_aux_info {
>>>>                  struct cgroup *start; /* starting cgroup */
>>>>                  enum bpf_cgroup_iter_order order;
>>>>          } cgroup;
>>>> +       struct {
>>>> +               enum bpf_iter_task_type type;
>>>> +               u32 pid;
>>>> +       } task;
>>>>    };
>>>>    typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 962960a98835..f212a19eda06 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -110,6 +110,12 @@ union bpf_iter_link_info {
>>>>                  __u32   cgroup_fd;
>>>>                  __u64   cgroup_id;
>>>>          } cgroup;
>>>> +       /* Parameters of task iterators. */
>>>> +       struct {
>>>> +               __u32   tid;
>>>> +               __u32   pid;
>>>> +               __u32   pid_fd;
>>>> +       } task;
>>>>    };
>>>>    /* BPF syscall commands, see bpf(2) man-page for more details. */
>>>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>>>> index 8c921799def4..0bc7277d1ee1 100644
>>>> --- a/kernel/bpf/task_iter.c
>>>> +++ b/kernel/bpf/task_iter.c
>>>> @@ -12,6 +12,9 @@
>>>>    struct bpf_iter_seq_task_common {
>>>>          struct pid_namespace *ns;
>>>> +       enum bpf_iter_task_type type;
>>>> +       u32 pid;
>>>> +       u32 pid_visiting;
>>>>    };
>>>>    struct bpf_iter_seq_task_info {
>>>> @@ -22,18 +25,107 @@ struct bpf_iter_seq_task_info {
>>>>          u32 tid;
>>>>    };
>>>> -static struct task_struct *task_seq_get_next(struct pid_namespace
>>>> *ns,
>>>> +static struct task_struct *task_group_seq_get_next(struct
>>>> bpf_iter_seq_task_common *common,
>>>> +                                                  u32 *tid,
>>>> +                                                  bool
>>>> skip_if_dup_files)
>>>> +{
>>>> +       struct task_struct *task, *next_task;
>>>> +       struct pid *pid;
>>>> +       u32 saved_tid;
>>>> +
>>>> +       if (!*tid) {
>>>
>>> Add a comment in the above to say that this is for the *very first*
>>> visit of tasks in the process.
>>>
>>>> +               pid = find_pid_ns(common->pid, common->ns);
>>>> +               if (pid)
>>>> +                       task = get_pid_task(pid, PIDTYPE_TGID);
>>>
>>> 'task' is not initialized, so it is possible task could hold a
>>> garbase value here if !pid, right?
>>>
>>> Also if indeed task is NULL, here, should we return NULL here
>>> first?
>>
>> yes, it should return earlier.
>>
>>>
>>>> +
>>>> +               *tid = common->pid;
>>>> +               common->pid_visiting = common->pid;
>>>> +
>>>> +               return task;
>>>> +       }
>>>> +
>>>> +       /* The callers increase *tid by 1 once they want next task.
>>>> +        * However, next_thread() doesn't return tasks in
>>>> incremental
>>>> +        * order of pids. We can not find next task by just finding
>>>> a
>>>> +        * task whose pid is greater or equal to *tid.
>>>> pid_visiting
>>>> +        * remembers the pid value of the task returned last time.
>>>> By
>>>> +        * comparing pid_visiting and *tid, we known if the caller
>>>> +        * wants the next task.
>>>> +        */
>>>> +       if (*tid == common->pid_visiting) {
>>>> +               pid = find_pid_ns(common->pid_visiting, common-
>>>>> ns);
>>>> +               task = get_pid_task(pid, PIDTYPE_PID);
>>>> +
>>>> +               return task;
>>>> +       }
>>>
>>> Do not understand the above code. Why we need it? Looks like
>>> the code below trying to get the *next_task* and will return NULL
>>> if wrap around happens(the tid again equals tgid), right?
>>
>> The above code is to handle the case that the caller want to visit the
>> same task again.  For example, task_file_seq_get_next() will call this
>> function several time to return the same task, and move to next task by
>> increasing info->tid.  The above code checks the value of *tid to
>> return the same task if the value doesn't change.

Okay, I did a little more investigation. The above code is correct.
But the comment does not clearly describe why. The real
reason we need this is for subsequent iterations from task_seq_start().
Basically we have

    task_seq_next();
    // return to user space
    task_seq_start()
      task_group_seq_get_next()

In above task_group_seq_get_next() needs to retrieve the task which
is the to-be-visited task during last task_seq_start/next/show/stop() run.

The comment can be as simple as below.

	/* If the control returns to user space and comes back to
	 * the kernel again, *tid and common->pid_visiting should
	 * be the same for task_seq_start() to pick up the correct
	 * task.
	 */
> 
> Could you explain when task_file_seq_get_next() will call this function
> several times? IIUC, from the following code,
> 
> +static struct task_struct *task_seq_get_next(struct 
> bpf_iter_seq_task_common *common,
>                            u32 *tid,
>                            bool skip_if_dup_files)
>   {
>       struct task_struct *task = NULL;
>       struct pid *pid;
> 
> +    if (common->type == BPF_TASK_ITER_TID) {
> +        if (*tid && *tid != common->pid)
> +            return NULL;
> +        rcu_read_lock();
> +        pid = find_pid_ns(common->pid, common->ns);
> +        if (pid) {
> +            task = get_pid_task(pid, PIDTYPE_TGID);
> +            *tid = common->pid;
> +        }
> +        rcu_read_unlock();
> +
> +        return task;
> +    }
> +
> +    if (common->type == BPF_TASK_ITER_TGID) {
> +        rcu_read_lock();
> +        task = task_group_seq_get_next(common, tid, skip_if_dup_files);
> +        rcu_read_unlock();
> +
> +        return task;
> +    }
> +
> 
> task_group_seq_get_next() is only called once per task_seq_get_next()
> for BPF_TASK_ITER_TGID.
> Maybe I missed something?
> 
> 
> 
[...]
