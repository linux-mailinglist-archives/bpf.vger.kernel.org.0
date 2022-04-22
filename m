Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F95E50AEB1
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 06:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379112AbiDVEIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 00:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVEIg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 00:08:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B214E3B1
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 21:05:44 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LNWgAk017015;
        Thu, 21 Apr 2022 21:05:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7Rn0ulGjQ657XRXKC54gy8W4uXtnHR1bn1ybRjUNsDI=;
 b=ou9hZsh+ihs+HNTNMsQr2ya+wB4+JOB/O4uik9wMpM6ZBO/lJaGp4pC6OkRuKhqT6zH6
 1mdlKF/TV7bQx9ovzzsupAy7E1hOOJFR4Jl1idF7O8my+cMvt/SqEolfK3u79JMcjrpH
 55vT6//WDpSI4YbFDIYdIzRIKDa64IF+mvE= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fjtd417pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 21:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7t1w4MvM485VxjqueDOJ3S0H8EFtGPtvd5+dA+HzIf4GOW5QsCpEdIkAlTDJaskvVR5uzH02ucFFyVMZhgfgR93ewxrlIgPjiEiR1tZxjcy6Hu7e+K0k0g8+zE4pvZz7onUVfUKC7V7AA1NJN4oZEpvVsvxvfNc0w7CdD6bPGG2hTB74jWvOK/8//rkRZPQiYXjW5cmjypmNlLEjr0q33pTkt0BU2QrWvWtOwd47UITeucjWwH2sqJ+HQ3bQs2VwC9MX5hZWDVhS6IK2cEltn40unTjbaxnyhr9NyhQZ4REzmJigf09jCEKU7/vepQ41o61VPHNcjUwn/BmL7qsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rn0ulGjQ657XRXKC54gy8W4uXtnHR1bn1ybRjUNsDI=;
 b=mmGyZK8u7WGNZcS3NM0pQyiZUsEgJQRIG5x/1csTygpnqOuu813LHdjnXvWlLSTkrlIaXynwzvcClC5ejPgEoukpmdmPPvRs+6zMFWoNdVg+UNEUMggzM4yDsKxhzYVwShY8DnZ4u2kZinY4s/+4bNncsGzWOW0HdN6VRD25fBwkfTQwh9y1Pa4+hCaBia7yvoxLQP7Vbb8+sNbgT4IMwz3x0McIqt1fRpd894RHuZamteCsRtYhlBxoYFeQeQE+YmPpY5P++AyySR3Bdd523cQSp6wEkzjbmizgn3VkNBnY9sXqFKXUPnVY5GvbZ8mhkyiRxZ96AAOuSCmuBiOEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN8PR15MB2881.namprd15.prod.outlook.com (2603:10b6:408:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 04:05:26 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%9]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 04:05:26 +0000
Message-ID: <5d14e267-298b-d4b5-07bf-704a36aa8aa5@fb.com>
Date:   Fri, 22 Apr 2022 00:05:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH bpf-next 0/3] Introduce local_storage exclusive caching
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
 <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220422014030.opvbgrfvdnxzwfxl@MBP-98dd607d3435.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57328332-3aa0-486e-3b98-08da241554d6
X-MS-TrafficTypeDiagnostic: BN8PR15MB2881:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB28812012C8CCFB2D2100BB39A0F79@BN8PR15MB2881.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kUU6FXoS2bRcTbuQ4WJ8EEgwaO4gxZ4gIMwMXZSB5I3TDlRgydNXJ8FUuWpXFRJFDDdsdd1SgBN4SVDfwWXaDL9Db8lgUGyR+gZgdW8D4bdQPhrrqzetszauDNKsnutDGoKbkSFaNKdY3ZQbGj/F1LlG9ru+3zuPy5zizibE5hDsxWAJISQuTmEDh9/ROZUMSKdOHb+QO5xzRrL+5p1CM+5xfikqlefDaeUOTFtaZUXbpiOelJJJye+tvJXtaiB1YNOat/eSKCIkuzWFe3UuvDv8EbyyBcYGkXsfd+t6B28jSqqZje1xSxLOjb4RQfuCzsiV8G9cskdHHr3x89d6e9jVuIaWVKhfbBqWXN8Vlct8LbJa/zkradyIGMlYaPEH/cbWeCzf3xO/FmRj63PtYhuUSWosKSvTv7k1WfZcwwqr2cO+fPsQNN6YEp6ouymyCXZNoUAOWegwuDtmqOLctIcRlgM5pYKBDHBGiDtBwHOXaJBjTsCC5vEKfyrZn+kgbnKe+lTAMdES1ZMZ95n5qscgtjNYoNLYc/gFktEwd4mxnfchgEyvzwPUuA4f4nOSiLIQTPARWEZlGB4gG59ivUYnQF+08VSEcryJDkJP8jgtSMeyuViv88vYqUbPdZWiwF/+QjlZgGblkvTOdkp7TpmNdZj62xXc41g2Kk/yIZYKguxNsHDDkwt7HOLd5n2LnHQS8P2d3dqjZck7lgkrbn1LLSnc/nghIbXcC1d3UVc9Pb8TkRnODtI2QvKT7PG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(8936002)(6506007)(6512007)(6666004)(508600001)(86362001)(186003)(54906003)(6916009)(316002)(2616005)(83380400001)(36756003)(66556008)(6486002)(53546011)(66946007)(66476007)(38100700002)(8676002)(31686004)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExiK1cvMlFVNnFIODJYZmthdkViQ1VER2lZNnhLWFkyVi9iaVlJWmh2dFZG?=
 =?utf-8?B?TXdaRWh3dnREVUd5c2w2K3MvbFY0dVM5YVBsMHNoVnZFMWNXUFZGb2FxVmJh?=
 =?utf-8?B?d0g2eWl5S0JQN1Y1Q2lyN29RN0lVQUVielFydmhZRHNoZnJUbDhFNHgrOEp5?=
 =?utf-8?B?WTkvKy9MMDNKWmI2UVdZOW5YUmNPaVByMEFtU1RBcEh6N0U3eWZZY2RFbGJP?=
 =?utf-8?B?b3d0Zy9HQzJma0VXZjk3MWtGczVnRUFvMkF4TnRvVFZnNDF3Q3UvMVF6ZnlF?=
 =?utf-8?B?K0t0NjVsNytHTStFbGJRNExkeDVDZ0U2NDZIWFQ0Q2RHOWdUUTNOS2ZLK0V1?=
 =?utf-8?B?T3BFUzNaaXR3MGNTVDVpbFJEN256WEVYSzh5bVZGek1OSWlMWWpZenlqejNm?=
 =?utf-8?B?WkRaNmVVUHJiWCtDb1F1WUJLRTZaSzF0dUlPRFVsUkhvS0NwbWpoSSt0QkZN?=
 =?utf-8?B?d3dNanEvRXpvZWJ5SXlzMlBKZHl2amxGV2hLYkNlQTh2MzdYdzhocWRjN3ZU?=
 =?utf-8?B?Y2hyNlp3UGhrWFJPb290ZWRzeDE5NDE3ZkdQRnQyd1RPaEFBcnJkd0Z4Q09O?=
 =?utf-8?B?UURpQmF6SnlXaWxRbHBvaU5PSXBXYmIvSVQ5cUlYbTA3Q0ZxZTdxQWVkYlRU?=
 =?utf-8?B?ZjZyQzBqZkFPR0FUYWQ2RnZZc2JpN2wxdUt4S3cyM0JJUkpoZ1VGUHk2Q0JT?=
 =?utf-8?B?T1lwN08rTjFla2FYSmZhSlJZNUxGb3dOcXFXcE5RZ1JJalpNTHRCaDZqQnYx?=
 =?utf-8?B?NUR2ZERpS2djYSs5TytKWVFzNGI0U3dtR1BwWWR6RWtDcElCcXdvR3grMFNt?=
 =?utf-8?B?d0Jlam9NS0ZvNEU4aVo4Q2xFS2FlN05rMDFDTUl2V29iL2s0MXF3NGtrMktL?=
 =?utf-8?B?LzNFWFdZU0hXUVNFM1J4NUNUL0plQzcxbVJhcnRUcExEcjA2THlrOVJsenpi?=
 =?utf-8?B?V2Z6TXpaVVUyTWkxeXBmMDZEaTVMVlh4cEZYVTkzYVprNXJ0QUh2N1poVjFV?=
 =?utf-8?B?MVI0bDk1QmxmR09hM0ZtUVA0VitnQUo2YVdwOG9uaUc5eERnTHdvQ2FlMVl2?=
 =?utf-8?B?d2VoMVBRaTFMS3IzaVBRLy9zTmM5V3hGRU1hSWYrUS9QeDJCTFZZTFlBS3VR?=
 =?utf-8?B?dlZmTmtRVmhleGp2cG9JSktmUWJvY3JDWWFnVHN5WE9zeTNRWFdCRURWYk8z?=
 =?utf-8?B?MUp5YzM5Nkwwb2YremlRSjJVRXlDYlllOXpENGd6S1RUaUhLOXl1Um55aFJR?=
 =?utf-8?B?VjJuT1VCQnNaOWFuNWdtZVBsS0czUitmUUxTN0pQbkdUblZpd0JPZkE2MFRZ?=
 =?utf-8?B?bDdKeDBWc0Z5UVNwVnBuSlR4RFZEU2pCelc4T3FNYmI3dVdHb29GcDArUXpR?=
 =?utf-8?B?UjFpTmE0K3ozVTlicXJrOElWU3hYZ2p1WW10YWlBRlJCODhlRXRqdUZlZXFs?=
 =?utf-8?B?RXBvNU1IQ3l2QlJjUWJQaTY0WitxOHNSOXNBakdlSnpDZ0g4aUxML24yR3FW?=
 =?utf-8?B?K1QzNGVKWjhLbXFWL3JqRVJzY1E5czRkSm9xQnlXRGFLdngyL3Q1b3Bna1ZP?=
 =?utf-8?B?QlFVRUxZSUgvZ1pvN3lGOFpKWjJRNUV5bm5IemhCYTRCZStHS25kRmF3TnhR?=
 =?utf-8?B?dzdhb2U4eWxzNDVuQmlpY2t5aGxIaHFISklhZ1RtVXZ0OXZxeCswMTFKV0ZK?=
 =?utf-8?B?K1pVSnBLeEtzZXdQUzlVU2FndERTakRXVmJMN3BpWEM5aVFlRUlFQ3NZdncv?=
 =?utf-8?B?dGZKU2V6RGdrU0NhMzUxWGMwUjhKZTVTT1NZVDR3MjgxMGtPUjFHYUYvdDlt?=
 =?utf-8?B?RWJHYjZMT2Q5Vmtxa1VsRURaZHpwakR3bUpTOXdlbFBzVU5OTysvSjdHTkNN?=
 =?utf-8?B?RlJhY2Z6WTcyVjQvNG5CM1kraGNzMkxBRURDNVE1clo1RkNlVzRlbDRWZjZx?=
 =?utf-8?B?Y3M1alhoTGo3NFBhTS9aM25yZXhSL0EyMHFPY3ZSR2VMSFJFenpld3JBWFRo?=
 =?utf-8?B?OXJITXM0M0gwSXNCT3gyem5ZNDFMeVowRk41ZWpLU0tzSmtoOTkvcU5YVXgz?=
 =?utf-8?B?NVJob00wdEdRR3h2RWYvRXVPK1VMeUtoYXVOUnk4VXVlemlzVTlhMytXTTJO?=
 =?utf-8?B?bTdLT1plSll4VzZPNUU1dmdUdXlLUWljbllHOXNRV3hLRHdaZWQ0b05YUElv?=
 =?utf-8?B?bUxhK0NPeno2TUxUdFVjSS9RWlg1c3lMbEwxdlNNdDNXL21nWTNSR2I4enlX?=
 =?utf-8?B?MnRBUWhxRDlxazNEdWhlUnVBQTZMdmFyQ1JJUXp1SFRlV0NiWU1tM25HZlp4?=
 =?utf-8?B?ZlJiOFN4MnFmOUY0NTl4bzM4bTNSWTl2MTFvaEpxYTlZblJWS1VGdktuZ2t4?=
 =?utf-8?Q?YxgkoaxTCrOmiySmdnuNRWA9tlvR8f3TtclZd?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57328332-3aa0-486e-3b98-08da241554d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 04:05:26.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEyPUCN3pvjGO27KsPGj91wnhf8wuWUT7ALdjEttGTzgb+UVTnJUD+IIvmVnIuLqVnjpy7cKfHCzA8lsovzanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2881
X-Proofpoint-ORIG-GUID: NlyxCJTfWBGLbMLvxLM_9uXluB2R_YiE
X-Proofpoint-GUID: NlyxCJTfWBGLbMLvxLM_9uXluB2R_YiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_01,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/22 9:40 PM, Alexei Starovoitov wrote:   
> On Tue, Apr 19, 2022 at 05:21:40PM -0700, Dave Marchevsky wrote:
>> Currently, each local_storage type (sk, inode, task) has a 16-entry
>> cache for local_storage data associated with a particular map. A
>> local_storage map is assigned a fixed cache_idx when it is allocated.
>> When looking in a local_storage for data associated with a map the cache
>> entry at cache_idx is the only place the map can appear in cache. If the
>> map's data is not in cache it is placed there after a search through the
>> cache hlist. When there are >16 local_storage maps allocated for a
>> local_storage type multiple maps have same cache_idx and thus may knock
>> each other out of cache.
>>
>> BPF programs that use local_storage may require fast and consistent
>> local storage access. For example, a BPF program using task local
>> storage to make scheduling decisions would not be able to tolerate a
>> long hlist search for its local_storage as this would negatively affect
>> cycles available to applications. Providing a mechanism for such a
>> program to ensure that its local_storage_data will always be in cache
>> would ensure fast access.
>>
>> This series introduces a BPF_LOCAL_STORAGE_FORCE_CACHE flag that can be
>> set on sk, inode, and task local_storage maps via map_extras. When a map
>> with the FORCE_CACHE flag set is allocated it is assigned an 'exclusive'
>> cache slot that it can't be evicted from until the map is free'd. 
>>
>> If there are no slots available to exclusively claim, the allocation
>> fails. BPF programs are expected to use BPF_LOCAL_STORAGE_FORCE_CACHE
>> only if their data _must_ be in cache.
> 
> I'm afraid new uapi flag doesn't solve this problem.
> Sooner or later every bpf program would deem itself "important" and
> performance critical. All of them will be using FORCE_CACHE flag
> and we will back to the same situation.

In this scenario, if 16 maps had been loaded w/ FORCE_CACHE flag and 17th tried
to load, it would fail, so programs depending on the map would fail to load.
Patch 2 adds a selftest 'local_storage_excl_cache_fail' demonstrating this.

> Also please share the performance data that shows more than 16 programs
> that use local storage at the same time and existing simple cache
> replacing logic is not enough.
> For any kind link list walking to become an issue there gotta be at
> least 17 progs. Two progs should pick up the same cache_idx and
> run interleaved to evict each other. 
> It feels like unlikely scenario, so real data would be good to see.
> If it really an issue we might need a different caching logic.
> Like instead of single link list per local storage we might
> have 16 link lists. cache_idx can point to a slot.
> If it's not 1st it will be a 2nd in much shorter link list.
> With 16 slots the link lists will have 2 elements until 32 bpf progs
> are using local storage.
> We can get rid of cache too and replace with mini hash table of N
> elements where map_id would be an index into a hash table.
> All sorts of other algorithms are possible.
> In any case the bpf user shouldn't be telling the kernel about
> "importance" of its program. If program is indeed executing a lot
> the kernel should be caching/accelerating it where it can.

It's worth noting that this is a map-level setting, not prog-level. Telling the
kernel about importance of data feels more palatable to me. Sort of like mmap's
MAP_LOCKED, but for local_storage cache.

Going back to the motivating example - using data in task local_storage to make
scheduling decisions - the desire is to have the task local_storage access be
like "accessing a task_struct member" vs "doing a search for right data to 
access (w/ some caching to try to avoid search)".

Re: performance data, would adding a benchmark in selftests/bpf/benchs work?
