Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820BA58CC07
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiHHQU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHHQUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 12:20:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FD31AB
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 09:20:23 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278CljaV013957;
        Mon, 8 Aug 2022 09:19:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=J/hqwKR9pQecyvhBSopOuGH3c2G8uWyLBWgmQBo+iZM=;
 b=oLL8HrWKnSYnzKgjSf1m9rZ5eg2s689OPwKXxvIInPrwlhJJHMFT09fZQWjNmKRNX/ZX
 dJzWkkUS1MYbxiMnZfpumVc8l+UHUuQTwy9GO5GCD5ArxSRFz6tv1tNXnoH8FX8OdXS5
 vyL5X5LlLeX52rQESUmsMyqu0a3pKF47MSY= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hskmnk8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMQTj2vRHTnwxZ8WKq7nc+vafRxF6aXlLeIIXW0fXNMLevS8vwl99sU0jxYCkycH7JJ89YrQo1Wdf+E2OnQ6TY5LEhlmeyj9yanczEF0g0NU4TL75d13IpLoBtO7E/EvOQRMer2hQ24DqBCRYheNLGD619cvUcpqxN1z9h4XibQ4saObfJ55H3y3LGOrtBK6tA0SbGummKbZ5DT/3bbs59bO3mtoVMVpkmED8Z1xwWsOYx9v92Ok0NqgqKNlGIqWHMmIoFoIwyJEzcmhHe4WmDtB37GEaBveNVEcr6fH4BCQSoyj2pGqAiBCov3CiRtZt73bjKu70cHEaa66+h4fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/hqwKR9pQecyvhBSopOuGH3c2G8uWyLBWgmQBo+iZM=;
 b=clnOXsNysBmV/QfiliTkJVzccLccmHfqzrww/or62dAU3Vu7RtHCONyfJ+g/pavgCqkDaLTv0kBLBSqweJdZuS+CL7DlX/EhH8IY4QTNY+huYLKclup3XmRS7w9LwCdBSPDcuYAJpWt4MOq+6LBp/Ek/V45lHAysojMQslw0Efxc0Kt6PHB7kG484Q3pxhQkQqi/o1XdMsVUd8l3MD8t0ULtneUxtLScYyAQE9UkDlPdKFzVhCLenhpnqBT09Vmnsnwl4n5JfUGtRetM702U2glK3iJ9Pamc1cIDqtjf3KyBmZ4LydkXghcX5jsIsxZClZ4FATFoTOnJZ+iP0FdWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3728.namprd15.prod.outlook.com (2603:10b6:208:1b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 16:19:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 16:19:44 +0000
Message-ID: <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com>
Date:   Mon, 8 Aug 2022 09:19:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in
 prealloc_lru_pop
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "toke@redhat.com" <toke@redhat.com>
References: <20220806014603.1771-1-memxor@gmail.com>
 <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com>
 <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17c140c3-4f11-4502-fb1a-08da7959ce1a
X-MS-TrafficTypeDiagnostic: MN2PR15MB3728:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ieKSJCQBRvFP2K1XulUj81mWLh7SduCs7HESAADH0OHV0zVjBl0lxF+9A58hoy88sYTdwd2d2n+bDGkeBbgaI0LdOwoFwqDPHt0qG5B8N1HHwFILjKRyrpl9Lloml56iVuuYSrR6mI1BiB9JZwJBpJbJENFnBhViNBu+aaV3bRZ3ePx1qC1C8B2+Pt5m2h4wVZq/gKT2YjBFBJIRdxpHJzhclISt/RnPw/pfcd9OPGN9A+By2bfj5sCNAp+9VOjYt18hYkAfZ5WGHDTLnP3trLMnc55rak5zZx2APRyi3NdOzLH4o/aWR1b4JnJNS782YBnoMNcho9GeMyqb9CoiGO2epv0TjC5XqVevuADnMYLN+qlcaBPZp8TeW/G+O7q2rmPMy4sOnynRyXURO3ZZi5JuAHGUCUonOnFZJxpSzqioybXLyW3HpAkX+jP7Ewe/PNGeF8WnJfisZqqqLm40K2cyV3cID6dVTy4NZccaOK4393IWI13uB1zPa4XOQLGAjiVN7bjCcAE4QAJ9fMkvd/udQG7zEevwDekWKVlWLhuOOSbFZChQF7Lp7uNrPah7AFxSShchmTGckbuWniMtvgDV8Jjou1gm0Ds2JiEBxhs5jMqCA4nX8IFJKCHJdLABoU6NEllgjg+XTItGdwOmgpY75Nlj3IvNb6p4Ow5Tt79GjyAea71KMLEV1Vc50maP8qgvEzjgY3mX5cJcid+i/+lh6IkyjpYV5ZPcbaclw+J1qXp18wMZBuKqERPHuub8s4tHN0WYsMxhFJyK0C+mcAMiSVKytrfhJxkVKCq2sDS7//o47j7PyV9qvxV2VSVXr2ADhPIClkqiPPAM7iz9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(5660300002)(2906002)(36756003)(6486002)(6916009)(316002)(478600001)(54906003)(66946007)(31686004)(8936002)(38100700002)(86362001)(6512007)(41300700001)(31696002)(6666004)(6506007)(53546011)(66556008)(8676002)(4326008)(66476007)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzg4YlZMMlZLOGFCUmYzVDNHYmhvQmNNMVN2dUJsY1NDRjZzY3BkSmVjTk1h?=
 =?utf-8?B?dVpRSjNEVHZXSFJrZ0htcGFhMFExVGF5NzBua3VtMEdHUEpyQk1nZjhvVk02?=
 =?utf-8?B?MHlpL21OUURaZ3AwUDRXZDRVWjQxSmlXVk5mbFA2TEpYMEEyYk0vMFRpek9o?=
 =?utf-8?B?a09DL3ZhM2M1N3ZCSWlldDRUdTU5TXo1cWdxblZOZ2dkZkY5eHZOczJpTGJs?=
 =?utf-8?B?di9nS0hUTVpQeUdpOThvamtLYkt3QVgzU1d0STlTUjlHdnJ4OVlzWnVsMGxl?=
 =?utf-8?B?YWo3N2tuMXVsbFVYSjhVc21HZnJJRElkVGpmcWh5aHZvMXBKWm13L2FQSytV?=
 =?utf-8?B?Rkh2WGlZTW04YlREQnZQK2NsdnJVLzlOZU9udWZITkgyM2xPRDAraVBUWWNv?=
 =?utf-8?B?YkdaZGVTYzVlaVZ5R3M1RVhLRjZQZnhOOGJxMzdLeFFONXhCRHlubFFjY0hr?=
 =?utf-8?B?N3VxQ3NmU2lEeUhDcnBaNWpIaEppQ2dLcURreWE1b0NSQWRST3J2RTJhaUxL?=
 =?utf-8?B?Z21jYzVUTmtzVjVrdUh4a3RGQUl6UDNNZTd1ejVabXAveDdjeW5DMUtBWFhN?=
 =?utf-8?B?STZXR0NRMW9aQSt3T0Q4RW1yZ211Zy9jTFpaT3BoU1hYT0wvOXhIdi96UUdp?=
 =?utf-8?B?UEhVYllna0k1S1NwUFhjV2tCdThzaXRUWnNzdnVpYzUvOUNOY2hxa1M0MlRj?=
 =?utf-8?B?UTZJVEpyTW9peUtoMDIwdUxtWDIzYktSdURLSisyeDl1ZHpaSUZJS3l3VjFP?=
 =?utf-8?B?cnN3VXhSZkt3SHZ6WmVpb1Z5bmZDcm80NnE2NjJCb0RYNmduSUlIVmkvSFV5?=
 =?utf-8?B?bUJjTUJPbmZwQ2tlc01haDlRd2xjbFVaQlhNbXFZT0FCRGhPMjNkK2Q4R0hj?=
 =?utf-8?B?RlQzSEtIVHlkVitIcFlna0ZrNnlMM3JKM2pLNDByQm9DQUVDRUFYQVFuNUQ0?=
 =?utf-8?B?QmczR2lmNTFnOTlhbDBEVmRzL2Y5QXQ4UGhBMmJoRWpvUXJSVmkxNTZsQ01X?=
 =?utf-8?B?d294SFllb29HN3c1dXJubXV4dXpqNUU1K1hieFFuSHB0c0RRK1JBbU9MY1F1?=
 =?utf-8?B?cnBVZnRxaWVkenBKa0YvbW5uMXB2Q1ltYXJWT3VyQ3Z2anJlZld2Yy90eGtX?=
 =?utf-8?B?WWhEek5uYUtiU3RVbzgrTnRyUHYwL0orUUxvWjhBcVNsSi9rVTgxRHk0Tnhv?=
 =?utf-8?B?UXJ2bWRsNDBrN1MwOG16ZGdZaUlUdm10Nnp5QnoxbWYwRzNiU0gxMDVTOUdZ?=
 =?utf-8?B?ME12ckhXVHhaOTliaWE1ZUtkRkp2dHNTeVhzN2NIT3JST2ZzRXNVdnhaRUJv?=
 =?utf-8?B?UHVvMTNielJ0WWovVDU5WVVuZm13c3Z4UGhaNFZGbWpoNkdvSS9zSkNWQzZ4?=
 =?utf-8?B?VWV4b0FUSGRmQUNXOFFmTVBFbGF0UW5HanVTQXpQNVFJWFMxcW5kOEwzUnY4?=
 =?utf-8?B?YjVJaTRRWStyZ1pGSVM2aFZ2ZFlBSzlUV21oYmVCeDVteHdNSXJ0YTk1RW1o?=
 =?utf-8?B?RVR4c2hBbHAyMExoM0czOHBGdXI1SXJzaXhEeHBvbjZRRTZkS3JoQXdBbzJj?=
 =?utf-8?B?azFvNTlqYmY5Y3FWVjd5SjBLZDFKdnFFZUVUZUkzeEtuR2pzWlR4bWZEeGF0?=
 =?utf-8?B?UXlHUFd1TmRFRFRybkRkcWpYRlYxZW1mZ3lGejBJQWJWM3hQNlpaQ20zRmow?=
 =?utf-8?B?NDNWeUtBOS9sTUxOY2h5cjkrSURPSUdPN2xCL0J6RDRQN1pIdy8yc3hoUzNv?=
 =?utf-8?B?WVpBQTJlZ0JZbDJxdE9pdU0xSmdzd3pvS1dZaDlVZjVxZGRsNXV6QzBCUXlt?=
 =?utf-8?B?d2xyc1Jsc29ZQTNwcG1ic1pScWpDcmF4ZzFYZjBjSFMyUnNKZFh6NUdRYXZQ?=
 =?utf-8?B?K0JzZU9Ic2N0bS9nc2IwbTBaRXVUb3o2VDMzb1dKOWlad0krcWpsZE1DSG1Y?=
 =?utf-8?B?TTFtazhCbGs5eTRLa0JINXlDYlVCbWlZZG1HbHhMMk1SdEFiSHFQVzJINUlS?=
 =?utf-8?B?K2lPMlA4S3R5Vk56d0txeCtXT043QjMvZkFSa3NET0NScHp5cEZETVZIWjha?=
 =?utf-8?B?cjR2SmpZSmlmODdJQThlVGNnZlNESStBUXNlTUZiRXZZb2x3U242MHJEUGxy?=
 =?utf-8?B?ZlNQekVvTWk1dTZTalEwRDVMOFZNbVE1RlN0Y1hTOVUxeTJRcWhVYXVPeExn?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c140c3-4f11-4502-fb1a-08da7959ce1a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 16:19:44.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfdkfk7mRlUiTUkDoPlE4nW2+ahH9iX2DczXeD2+3NT3tIVgbkG4QtWsGD+LZm5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3728
X-Proofpoint-ORIG-GUID: 1tJtobGLb0eGtkDDgdeewYia6LqB8qY-
X-Proofpoint-GUID: 1tJtobGLb0eGtkDDgdeewYia6LqB8qY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/8/22 4:18 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 8 Aug 2022 at 08:09, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
>>> The LRU map that is preallocated may have its elements reused while
>>> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
>>> only check_and_free_fields is appropriate when the element is being
>>> deleted, as it ensures proper synchronization against concurrent access
>>> of the map value. After that, we cannot call check_and_init_map_value
>>> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
>>> they can be concurrently accessed from a BPF program.
>>
>> If I understand correctly, one lru_node gets freed and pushed to free
>> list without doing check_and_free_fields().
> 
> I don't think that's true, there is a check_and_free_fields call on
> deletion right before bpf_lru_push_free in htab_lru_push_free.
> Then once the preallocated items are freed on map destruction, we free
> timers and kptrs again, so if someone has access to preallocated items
> after freeing e.g. through an earlier lookup, we still release
> resources they may have created at the end of map's lifetime.
> 
>> If later the same node is used with bpf_map_update_elem() and
>> prealloc_lru_pop() is called, then with this patch,
>> check_and_init_map_value() is not called, so the new node may contain
>> leftover values for kptr/timer/spin_lock, could this cause a problem?
>>
> 
> This can only happen once you touch kptr/timer/spin_lock after
> deletion's check_and_free_fields call, but the program obtaining the
> new item will see and be able to handle that case. The timer helpers
> handle if an existing timer exists, kptr_xchg returns the old pointer
> as a reference you must release. For unreferenced kptr, it is marked
> as PTR_UNTRUSTED so a corrupted pointer value is possible but not
> fatal. If spin_lock is locked on lookup, then the other CPU having
> access to deleted-but-now-reallocated item will eventually call
> unlock.

Thanks for explanation. Originally I think we should clear everything
including spin_lock before putting the deleted lru_node to free list.
check_and_free_fields() only did for kptr/timer but not spin_lock.

But looks like we should not delete spin_lock before pushing the
deleted nodes to free list since lookup side may hold a reference
to the map value and it may have done a bpf_spin_lock() call.
And we should not clear spin_lock fields in check_and_free_fields()
and neither in prealloc_lru_pop() in map_update. Otherwise, we
may have issues for bpf_spin_unlock() on lookup side.

It looks timer and kptr are already been handled for such
cases (concurrency between map_lookup() and clearing some map_value
fields for timer/kptr).

> 
> It is very much expected, IIUC, that someone else may use-after-free
> deleted items of hashtab.c maps in case of preallocation. It can be
> considered similar to how SLAB_TYPESAFE_BY_RCU behaves.
> 
>> To address the above rewrite issue, maybe the solution should be
>> to push the deleted lru_nodes back to free list only after
>> rcu_read_unlock() is done?
> 
> Please correct me if I'm wrong, but I don't think this is a good idea.
> Delaying preallocated item reuse for a RCU grace period will greatly
> increase the probability of running out of preallocated items under
> load, even though technically those items are free for use.

Agree. This is not a good idea. It increased life cycle for preallocated
item reuse and will have some performance issue and resource consumption
issue.

> 
> Side note: I found the problem this patch fixes while reading the
> code, because I am running into this exact problem with my WIP skip
> list map implementation, where in the preallocated case, to make
> things a bit easier for the lockless lookup, I delay reuse of items
> until an RCU grace period passes (so that the deleted -> unlinked
> transition does not happen during traversal), but I'm easily able to
> come up with scenarios (producer/consumer situations) where that leads
> to exhaustion of the preallocated memory (and if not that, performance
> degradation on updates because pcpu_freelist now needs to search other
> CPU's caches more often).
> 
> BTW, this would be fixed if we could simply use Alexei's per-CPU cache
> based memory allocator instead of preallocating items, because then
> the per-CPU cache gets replenished when it goes below the watermark
> (and also frees stuff back to kernel allocator above the high
> watermark, which is great for producer/consumer cases with alloc/free
> imbalance), so we can do the RCU delays similar to kmalloc case
> without running into the memory exhaustion problem.

Thanks for explanation. So okay the patch looks good to me.

> 
>>
>>>
>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>

>>> ---
>>>    kernel/bpf/hashtab.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index da7578426a46..4d793a92301b 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -311,12 +311,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
>>>        struct htab_elem *l;
>>>
>>>        if (node) {
>>> -             u32 key_size = htab->map.key_size;
>>> -
>>>                l = container_of(node, struct htab_elem, lru_node);
>>> -             memcpy(l->key, key, key_size);
>>> -             check_and_init_map_value(&htab->map,
>>> -                                      l->key + round_up(key_size, 8));
>>> +             memcpy(l->key, key, htab->map.key_size);
>>>                return l;
>>>        }
>>>
