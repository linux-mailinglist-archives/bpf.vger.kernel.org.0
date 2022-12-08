Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24A7646664
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLHBS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHBS5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:18:57 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE868DFEC
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 17:18:52 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B80P6Wa028705;
        Wed, 7 Dec 2022 17:18:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xYd2PU0B/K4uNrZwJc2rzz+uaB40DnKdii0X3G42Wms=;
 b=JZ2TON2wuvcs9Y5cgkkADqJiHmZ8ISPMC7/72Br9eXGz6VvOugPUlP5qc46FgWB0HWPb
 qk6/8ommL/qKt+NPkWztLBh3ESo1neux8k5NzBDM+gBgQxVmyrRLRBFgr1Q4IBNVFG9M
 HzDAaxVAsHTVBHD934YF1L5cHrL7AJcBEB4cDktrf6XkXwrwK1xL41IJ7PxubDp+dNXN
 PAd8W6eIzpyqCxCU6xos4fjFvwVvIFGDuVZGXlocztc/qWkq7SnQO2XhtHd/PVjljcqD
 UMpojss9B3IL+wn+S+mceFQOWFhiEq9pD4TIYAjXrQpejgeKct6kVocH8X5c6GC0Tp23 Dw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3man55f525-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 17:18:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7Q+VefKBL/ukFkaS9DLFcnx0q++4Gpc6VivKpWfAmcc13HT3Wsu3haNkq7zFXFd+pq530Y3yeH99FRTHi8/4HT4KCpG9IGQI5GZxKvyA7USC24nQE6TzMM1ajLX4HxjfdavfYi+r6R9tp7lLuj3hB5Ajep01tR98S7DOUletwTf4JVKeaxcImO1z+n7orG7VqqHekErcrCP0DMaSqSvBQmjaSbqru5LOPpId0fvwufEJv4E1Fciy9PnDHfj7rkdZKtTgtsLlcuTwuDyT21Pj70iml8EB7IxmsbCI0+15+9tKKQ9hKdfeVPqPxar9QXycLv8P8U5VxXERZwiiBlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sakl3USRDxnpjuD6ZGd2MxNpxCL8xzAalKBzDY1qC4=;
 b=eZIwMPQ3QiUWtesyvi1knmA1IE34FH3KaOzpQIvlFlm+OMFcD9sWIjzdLkX8GzxKeI+RMonYLQCYjgKqbmJC9d4z/TZgLQ2Bvm/PUxf6vJfgoGRJwcjv87BBgiRD64nyTVVAkKffuvlc5lAS0m/qp6PSsxYeSvShIF8rFE0yfaAxE6CNr8fBnmgdkoPh1qtLb4QUxoavkFs71fX37HsFAnQHQaPqNRq3MZyXWwdnV8cllfy8fPZmE3kV5lwxUXg0uhosJzPkqXV3x5rUrF+CXEtpzdq0/yhfsZyoVFPp4TMSWF3X+WNIAQgNAZu0VH/Li6xRQHRzSV2BkgS1NKxL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by DM6PR15MB3052.namprd15.prod.outlook.com (2603:10b6:5:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 8 Dec
 2022 01:18:29 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 01:18:29 +0000
Message-ID: <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
Date:   Wed, 7 Dec 2022 20:18:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|DM6PR15MB3052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8930e2db-ef19-4200-54c4-08dad8ba1cf8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 737+UV1YNuKg2xKHlgBFxFmPVZojaOUd3mXlQ2GtOrgKJL+v0NFBHVBw7I2V1Q1nuDHXr5JCwu/gJu9jH+hrT6HpmSQ41NDdvoXWaC7C2gnhFmiI9OioGDurzogZGafKmnOw2+SVrkLfTCzB45IJ17SjqxBt4rt14Y6j9g5N/SXL4X0fOkv+SuukteaVy2D24MLzmtxzh4Fc+enj4cx/1THmgeUwZm+dNHPuAaoOg4xkSY7DwIKxvzTGZfiiMiU1YQz6y3VfBNwBdnUeCcpcyhPuVvfffV7GnjNqnSywZJueUQmrjpRPwpgaRpHPg7n48kf8XRgoUH9Dbsr3TTQextRf569Bc30Hhq3fhteVwJNqT3+02ymoZhJOdWA7yJtmEhsiyg2tP+27zlAMo2iv+kSSWr8W3UsrQCdVN1o10DsWjSN9wJVUUzdRdjAyuQWrOut207AYru1mFATrch2jNyeBiZAbpbBZxXqcd2Q7nJABbATCUzTikSCmqZ6c9QBg4nnt2f0IY9VkQr5rjmRZa6XlJU+j24QWhtiHSnvJ2Hrwh6EYpnVUML4YM+CgH+b92fng7NmJ8ctqtlKoqA41Kc46V1tJJ7JfLw4dLG5+RP/k2Mm9B8JLX2DFHw7qTuOvk1wRG+YeFwJvyXc0U0rF7mD6conB1cf10m+gH8vEXCzTTopq0Ib+z85CgBui4CIFkdxQNyX37Do0nz5A3OwW2w5jqdIOA5Sj8CsRg5HCKt5zQ62JwvvxZDsIY1UREQwH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(8936002)(2906002)(6512007)(6916009)(31696002)(41300700001)(86362001)(54906003)(186003)(36756003)(30864003)(6506007)(2616005)(316002)(53546011)(83380400001)(5660300002)(66476007)(66946007)(31686004)(66556008)(66899015)(6486002)(4326008)(478600001)(38100700002)(8676002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitsNW1OUDU4SGNXRkI4eUtUb2xCc1VyemNuU0FVZ2k1Zklvb3RMZDBnQlhT?=
 =?utf-8?B?NEhrU2U5ZWdpQUs0TW9MRnZKWkRqT0Z5QWl0dzhBdDMxRmdiNGpKaEhacmVu?=
 =?utf-8?B?WEdrOWRoZmNCWkNNc2taZW5mWDR6RDV3bVJWQlhYcGo1VDBSVm1GNWNGYkFq?=
 =?utf-8?B?VnlNMUdBaXdRZ2J3OTl5Sm1KOG5hK0F4WkIxUXhya3hIVm9RcVF6Mm0ybmxE?=
 =?utf-8?B?ZGUzaHdpMWp5ZmJlYlVlVFpkVVV2NHFseG5uTHk3N2tWSnFtRWlVVTVCZWdT?=
 =?utf-8?B?Q1E5cE90RVpwWWgyMi9FK0tuaktRV0lpc0EwcExER0QzM00rTVVqZ2dZcFRm?=
 =?utf-8?B?dWZ3Q2pqSWFxaG96VVJ1VE9pY3R6aVVXSVVHQ2laY0ZVaitsSEZxOTBEb1Rh?=
 =?utf-8?B?MWJzWXZXQURwTk9TRlNabmI0TkRoUm5pSWtzU2ZKNFFRMlRKTTh6VXBCSXpY?=
 =?utf-8?B?MzcwakpSQkt1dlRxQytjRHNMenNiL0tFc2twN2I5WHRHVUU2enJJUHZlLzh6?=
 =?utf-8?B?dVRYU1JGc1NuK0NHK2lqN1FzNGVhdjV2TXhpd2JmN2xEbEpZeXdTcTJNaEhv?=
 =?utf-8?B?Ulp0bmp3VDljaFlHQlcxL3c3RjdUYVM5Vml5VDBYR3Vua2ttdmV5UXpzd3VM?=
 =?utf-8?B?M1NSb1RMcTBrU1Q2NVFwZjhzdTd0d2gyN01UenFZWU1OOXRmR1RjZDFZV2Nt?=
 =?utf-8?B?emNWTmF3TnB2VmJzMEp6WE9BL3RqTjA1NDhqak1OcHBVTThkMjdXMHo2ajJ1?=
 =?utf-8?B?dmRkYzRaNWhGWHF6TlRqR1NScURxNkZnYkhGNzNWUW5BZDRpSzBxaXZkUGdt?=
 =?utf-8?B?UFptaWY2VVVYOWVnTXJndlkyalV2SFh2OElXRXAybTVwWHVHZkJ2WXhmdlh1?=
 =?utf-8?B?cENTeTRmbnArVzUvL0pMSlRJWjZkaEZWdWRNcGpXVEkxbXJWUmNpTHh0aTlT?=
 =?utf-8?B?YzhvMjdCM0tEbnN2LzdWaEhJdWFLMkZGS2lPT2pBY1Jka0R0bi9Ra3JwU1Jn?=
 =?utf-8?B?aHpGZjVBTm1FY0hGNjY0eUlGQXNBelBQR3owQ2lkMjNZU2tMOURuSlF0c01T?=
 =?utf-8?B?MHhhTnhhNFJ2RWMxeWxLbzBWZHI5Rk1pRXRrT092c2hFSURGZ1FacUdPY3dH?=
 =?utf-8?B?RG9hWVFXVDFIb0VYQ3F5K3AxeERFcFhlUXpZWVl6ekdWY1drRGQ2R2VJWnBs?=
 =?utf-8?B?bjBIdEluZmFYOUtYYlpsaXhaZnYrZVB5Rm84cmVxMEtNbnBBMXUxa2g5SXly?=
 =?utf-8?B?aTVQWkJRT1hPeUZFdFFMSWs4OG9NL3kvRHlhUm56RHRTZUczbTlIKzlTL3pY?=
 =?utf-8?B?am5sU1hwdVZLTDBSRHBrRmE1N21UODR4TGlZYXFYUkxwNE9ZNHJOY3loQ0ZE?=
 =?utf-8?B?d01wd0N3Q09iaC8wdUlNK1lyUkdGTUdTRWgxQlZaUndNc1NrWEJsbDFOYXVP?=
 =?utf-8?B?aVBYRFR5ZS9iNlBCY25RTDZjcE4xbzZRVjQ2ektzYUtFN283N3hMbFdmTmFt?=
 =?utf-8?B?UFBDNFY5V0hyY3BiOEo0aHhrWmRYNmkrWGx0UVduNURJcHE5d2EvN2xsQUIx?=
 =?utf-8?B?VXczbXg0b1RXRXRsYnlnalFZelliNXpsM3NFTUJuSVVCS1JWdlFzR1lkODZG?=
 =?utf-8?B?eE1Jakh6azZuYzY2MFFVR0lxWkM4V0R1Zko1Y0VHV0R3ZUd2cS9JczJKRHhu?=
 =?utf-8?B?SldCMXEzRU93MHVTOWU5RzVQZENZSlBMTzVWMWppUEtNamtrK1Z2V1grVC9I?=
 =?utf-8?B?N3RiaFVsUEdEYnVML0lTWTNTKzBUMGFSUE8yUng4TTVhV2dTR2x4YWkvWjZx?=
 =?utf-8?B?UlU0emxraUNKMnM1eG1sSWNCaFU5OHFHa3RYdmNHTFFtOHc1YWJHQjJSM2Zl?=
 =?utf-8?B?azhMY1M3aDNUZWpCaHB3OUlqVVVCSWU5QlVxZUwyUlduYkVjeWw1YXZ6S3FV?=
 =?utf-8?B?dU90L0Y3eXpiaHZjN0s3ZnJzTlBBMXhmdS9ubzNVZXZhWThHc1Y1M00vZGxa?=
 =?utf-8?B?TkRiSlpvSkR2QTRqbTZhQXkyOW9WYXgrNmFCL1dQL0ZhczRHcG05TllRcDZP?=
 =?utf-8?B?VVRtZEszWDRWNWt2czh6NUM5L1BvWmUza0lmTUl0YXZydmpmaWxKajJ4MFdF?=
 =?utf-8?B?V0QvMnZieGxUbHZHcWtrSC9xdjRMYlVHajIvazZkQUJCdlRGcEZXZ0FlbTlS?=
 =?utf-8?Q?v70Xwg1JhKyDDTpnzSqDwRc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8930e2db-ef19-4200-54c4-08dad8ba1cf8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:18:28.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShQdRfkor6TfP54N6F4z/5cjYTkMv33f2CSZejniRx5NYZJ1guQhtX5PrNMA2t2DGIWY6iDB1bki42IxoQNiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3052
X-Proofpoint-ORIG-GUID: _AG5twds-8gynMMf3LREyG6FRM8OTo38
X-Proofpoint-GUID: _AG5twds-8gynMMf3LREyG6FRM8OTo38
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 6:06 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 05:28:34PM -0500, Dave Marchevsky wrote:
>> On 12/7/22 2:36 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, Dec 07, 2022 at 04:39:47AM IST, Dave Marchevsky wrote:
>>>> This series adds a rbtree datastructure following the "next-gen
>>>> datastructure" precedent set by recently-added linked-list [0]. This is
>>>> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
>>>> instead of adding a new map type. This series adds a smaller set of API
>>>> functions than that RFC - just the minimum needed to support current
>>>> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
>>>>
>>>>   bpf_rbtree_add
>>>>   bpf_rbtree_remove
>>>>   bpf_rbtree_first
>>>>
>>>> [...]
>>>>
>>>> Future work:
>>>>   Enabling writes to release_on_unlock refs should be done before the
>>>>   functionality of BPF rbtree can truly be considered complete.
>>>>   Implementing this proved more complex than expected so it's been
>>>>   pushed off to a future patch.
>>>>
>>
>>>
>>> TBH, I think we need to revisit whether there's a strong need for this. I would
>>> even argue that we should simply make the release semantics of rbtree_add,
>>> list_push helpers stronger and remove release_on_unlock logic entirely,
>>> releasing the node immediately. I don't see why it is so critical to have read,
>>> and more importantly, write access to nodes after losing their ownership. And
>>> that too is only available until the lock is unlocked.
>>>
>>
>> Moved the next paragraph here to ease reply, it was the last paragraph
>> in your response.
>>
>>>
>>> Can you elaborate on actual use cases where immediate release or not having
>>> write support makes it hard or impossible to support a certain use case, so that
>>> it is easier to understand the requirements and design things accordingly?
>>>
>>
>> Sure, the main usecase and impetus behind this for me is the sched_ext work
>> Tejun and others are doing (https://lwn.net/Articles/916291/ ). One of the
>> things they'd like to be able to do is implement a CFS-like scheduler using
>> rbtree entirely in BPF. This would prove that sched_ext + BPF can be used to
>> implement complicated scheduling logic.
>>
>> If we can implement such complicated scheduling logic, but it has so much
>> BPF-specific twisting of program logic that it's incomprehensible to scheduler
>> folks, that's not great. The overlap between "BPF experts" and "scheduler
>> experts" is small, and we want the latter group to be able to read BPF
>> scheduling logic without too much struggle. Lower learning curve makes folks
>> more likely to experiment with sched_ext.
>>
>> When 'rbtree map' was in brainstorming / prototyping, non-owning reference
>> semantics were called out as moving BPF datastructures closer to their kernel
>> equivalents from a UX perspective.
> 
> Our emails crossed. See my previous email.
> Agree on the above.
> 
>> If the "it makes BPF code better resemble normal kernel code" argumentwas the
>> only reason to do this I wouldn't feel so strongly, but there are practical
>> concerns as well:
>>
>> If we could only read / write from rbtree node if it isn't in a tree, the common
>> operation of "find this node and update its data" would require removing and
>> re-adding it. For rbtree, these unnecessary remove and add operations could
> 
> Not really. See my previous email.
> 
>> result in unnecessary rebalancing. Going back to the sched_ext usecase,
>> if we have a rbtree with task or cgroup stats that need to be updated often,
>> unnecessary rebalancing would make this update slower than if non-owning refs
>> allowed in-place read/write of node data.
> 
> Agree. Read/write from non-owning refs is necessary.
> In the other email I'm arguing that PTR_TRUSTED with ref_obj_id == 0
> (your non-owning ref) should not be mixed with release_on_unlock logic.
> 
> KF_RELEASE should still accept as args and release only ptrs with ref_obj_id > 0.
> 
>>
>> Also, we eventually want to be able to have a node that's part of both a
>> list and rbtree. Likely adding such a node to both would require calling
>> kfunc for adding to list, and separate kfunc call for adding to rbtree.
>> Once the node has been added to list, we need some way to represent a reference
>> to that node so that we can pass it to rbtree add kfunc. Sounds like a
>> non-owning reference to me, albeit with different semantics than current
>> release_on_unlock.
> 
> A node with both link list and rbtree would be a new concept.
> We'd need to introduce 'struct bpf_refcnt' and make sure prog does the right thing.
> That's a future discussion.
> 
>>
>>> I think this relaxed release logic and write support is the wrong direction to
>>> take, as it has a direct bearing on what can be done with a node inside the
>>> critical section. There's already the problem with not being able to do
>>> bpf_obj_drop easily inside the critical section with this. That might be useful
>>> for draining operations while holding the lock.
>>>
>>
>> The bpf_obj_drop case is similar to your "can't pass non-owning reference
>> to bpf_rbtree_remove" concern from patch 1's thread. If we have:
>>
>>   n = bpf_obj_new(...); // n is owning ref
>>   bpf_rbtree_add(&tree, &n->node); // n is non-owning ref
> 
> what I proposed in the other email...
> n should be untrusted here.
> That's != 'n is non-owning ref'
> 
>>   res = bpf_rbtree_first(&tree);
>>   if (!res) {...}
>>   m = container_of(res, struct node_data, node); // m is non-owning ref
> 
> agree. m == PTR_TRUSTED with ref_obj_id == 0.
> 
>>   res = bpf_rbtree_remove(&tree, &n->node);
> 
> a typo here? Did you mean 'm->node' ?
> 
> and after 'if (res)' ...
>>   n = container_of(res, struct node_data, node); // n is owning ref, m points to same memory
> 
> agree. n -> ref_obj_id > 0
> 
>>   bpf_obj_drop(n);
> 
> above is ok to do.
> 'n' becomes UNTRUSTED or invalid.
> 
>>   // Not safe to use m anymore
> 
> 'm' should have become UNTRUSTED after bpf_rbtree_remove.
> 
>> Datastructures which support bpf_obj_drop in the critical section can
>> do same as my bpf_rbtree_remove suggestion: just invalidate all non-owning
>> references after bpf_obj_drop.
> 
> 'invalidate all' sounds suspicious.
> I don't think we need to do sweaping search after bpf_obj_drop.
> 
>> Then there's no potential use-after-free.
>> (For the above example, pretend bpf_rbtree_remove didn't already invalidate
>> 'm', or that there's some other way to obtain non-owning ref to 'n''s node
>> after rbtree_remove)
>>
>> I think that, in practice, operations where the BPF program wants to remove
>> / delete nodes will be distinct from operations where program just wants to 
>> obtain some non-owning refs and do read / write. At least for sched_ext usecase
>> this is true. So all the additional clobbers won't require program writer
>> to do special workarounds to deal with verifier in the common case.
>>
>>> Semantically in other languages, once you move an object, accessing it is
>>> usually a bug, and in most of the cases it is sufficient to prepare it before
>>> insertion. We are certainly in the same territory here with these APIs.
>>
>> Sure, but 'add'/'remove' for these intrusive linked datastructures is
>> _not_ a 'move'. Obscuring this from the user and forcing them to use
>> less performant patterns for the sake of some verifier complexity, or desire
>> to mimic semantics of languages w/o reference stability, doesn't make sense to
>> me.
> 
> I agree, but everything we discuss in the above looks orthogonal
> to release_on_unlock that myself and Kumar are proposing to drop.
> 
>> If we were to add some datastructures without reference stability, sure, let's
>> not do non-owning references for those. So let's make this non-owning reference
>> stuff easy to turn on/off, perhaps via KF_RELEASE_NON_OWN or similar flags,
>> which will coincidentally make it very easy to remove if we later decide that
>> the complexity isn't worth it. 
> 
> You mean KF_RELEASE_NON_OWN would be applied to bpf_rbtree_remove() ?
> So it accepts PTR_TRUSTED ref_obj_id == 0 arg and makes it PTR_UNTRUSTED ?
> If so then I agree. The 'release' part of the name was confusing.
> It's also not clear which arg it applies to.
> bpf_rbtree_remove has two args. Both are PTR_TRUSTED.
> I wouldn't introduce a new flag for this just yet.
> We can hard code bpf_rbtree_remove, bpf_list_pop for now
> or use our name suffix hack.

Before replying to specific things in this email, I think it would be useful
to have a subthread clearing up definitions and semantics, as I think we're
talking past each other a bit.


On a conceptual level I've still been using "owning reference" and "non-owning
reference" to understand rbtree operations. I'll use those here and try to map
them to actual verifier concepts later.

owning reference

  * This reference controls the lifetime of the pointee
  * Ownership of pointee must be 'released' by passing it to some rbtree
    API kfunc - rbtree_add in our case -  or via bpf_obj_drop, which free's
    * If not released before program ends, verifier considers prog invalid
  * Access to the memory ref is pointing at will not page fault

non-owning reference

  * No ownership of pointee so can't pass ownership via rbtree_add, not allowed
    to bpf_obj_drop
  * No control of lifetime, but can infer memory safety based on context
    (see explanation below)
  * Access to the memory ref is pointing at will not page fault
    (see explanation below)

2) From verifier's perspective non-owning references can only exist
between spin_lock and spin_unlock. Why? After spin_unlock another program
can do arbitrary operations on the rbtree like removing and free-ing
via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
free'd, and reused via bpf_obj_new would point to an entirely different thing.
Or the memory could go away.

To prevent this logic violation all non-owning references are invalidated by
verifier after critical section ends. This is necessary to ensure "will
not page fault" property of non-owning reference. So if verifier hasn't
invalidated a non-owning ref, accessing it will not page fault.

Currently bpf_obj_drop is not allowed in the critical section, so similarly,
if there's a valid non-owning ref, we must be in critical section, and can
conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
and-reused.

1) Any reference to a node that is in a rbtree _must_ be non-owning, since
the tree has control of pointee lifetime. Similarly, any ref to a node
that isn't in rbtree _must_ be owning. (let's ignore raw read from kptr_xchg'd
node in map_val for now)

Moving on to rbtree API:

bpf_rbtree_add(&tree, &node);
  'node' is an owning ref, becomes a non-owning ref.

bpf_rbtree_first(&tree);
  retval is a non-owning ref, since first() node is still in tree

bpf_rbtree_remove(&tree, &node);
  'node' is a non-owning ref, retval is an owning ref

All of the above can only be called when rbtree's lock is held, so invalidation
of all non-owning refs on spin_unlock is fine for rbtree_remove.

Nice property of paragraph marked with 1) above is the ability to use the
type system to prevent rbtree_add of node that's already in rbtree and
rbtree_remove of node that's not in one. So we can forego runtime
checking of "already in tree", "already not in tree".

But, as you and Kumar talked about in the past and referenced in patch 1's
thread, non-owning refs may alias each other, or an owning ref, and have no
way of knowing whether this is the case. So if X and Y are two non-owning refs
that alias each other, and bpf_rbtree_remove(tree, X) is called, a subsequent
call to bpf_rbtree_remove(tree, Y) would be removing node from tree which
already isn't in any tree (since prog has an owning ref to it). But verifier
doesn't know X and Y alias each other. So previous paragraph's "forego
runtime checks" statement can only hold if we invalidate all non-owning refs
after 'destructive' rbtree_remove operation.


It doesn't matter to me which combination of type flags, ref_obj_id, other
reg state stuff, and special-casing is used to implement owning and non-owning
refs. Specific ones chosen in this series for rbtree node:

owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
            ref_obj_id > 0

non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
                PTR_UNTRUSTED
                  - used for "can't pass ownership", not PROBE_MEM
                  - this is why I mentioned "decomposing UNTRUSTED into more
                    granular reg traits" in another thread
                ref_obj_id > 0
                release_on_unlock = true
                  - used due to paragraphs starting with 2) above                

Any other combination of type and reg state that gives me the semantics def'd
above works4me.


Based on this reply and others from today, I think you're saying that these
concepts should be implemented using:

owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
            PTR_TRUSTED
            ref_obj_id > 0

non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
                PTR_TRUSTED
                ref_obj_id == 0
                 - used for "can't pass ownership", since funcs that expect
                   owning ref need ref_obj_id > 0

And you're also adding 'untrusted' here, mainly as a result of
bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
instead of becoming a non-owning ref. 'untrusted' would have state like:

PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
PTR_UNTRUSTED
ref_obj_id == 0?

I think your "non-owning ref" definition also differs from mine, specifically
yours doesn't seem to have "will not page fault". For this reason, you don't
see the need for release_on_unlock logic, since that's used to prevent refs
escaping critical section and potentially referring to free'd memory.

This is where I start to get confused. Some questions:

  * If we get rid of release_on_unlock, and with mass invalidation of
    non-owning refs entirely, shouldn't non-owning refs be marked PTR_UNTRUSTED?

  * Since refs can alias each other, how to deal with bpf_obj_drop-and-reuse
    in this scheme, since non-owning ref can escape spin_unlock b/c no mass
    invalidation? PTR_UNTRUSTED isn't sufficient here

  * If non-owning ref can live past spin_unlock, do we expect read from
    such ref after _unlock to go through bpf_probe_read()? Otherwise direct
    read might fault and silently write 0.

  * For your 'untrusted', but not non-owning ref concept, I'm not sure
    what this gives us that's better than just invalidating the ref which
    gets in this state (rbtree_{add,remove} 'node' arg, bpf_obj_drop node)

I'm also not sure if you agree with my paragraph marked 1) above. But IMO the
release_on_unlock difference, and the perhaps-differing non-owning ref concept
are where we're really talking past each other.
