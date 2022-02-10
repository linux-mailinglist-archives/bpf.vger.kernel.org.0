Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B94B07B5
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 09:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiBJIF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 03:05:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiBJIFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 03:05:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8691088
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 00:05:26 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A5MdAC025865;
        Thu, 10 Feb 2022 00:05:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DV+XHp0WzWpjH78WCtXgF0uW0ianDN25PST0B0nz8Nk=;
 b=okhIxHjRIYgWV9GpUVVix7UIHzvzgpLsiDCZAZV6Rz6eUknKVbD5+ejl2zIcVIXqhDll
 l7rtZsPgoJIH0FM6BrTRDoBdw4+VdJbbv7TM+gzOHi/QCnqY9gqpIxdNRSbXAh5uteHn
 FmxncZz915aIDAz3vfJeesPgiqt81d3Gxj4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4vgh8m6k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 00:05:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 00:05:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsvnz0Y7JnVioFKy84Nodl26U4WhEYUmO+aOtw2XjhwKHQdK5cZLZeKdSiL6u3wurrCn4GMl19x/Yy3XwCcscMETIQwl/BnMWXAf4RzemCBMtVQW61P7g9VzOP/4Bg8PrNHbVKATxuBBncWnWJcKRSSK20Aem7wKIVTTyOv4tDMI8xYedBaqbf2nh2vGWrbbid7Ux62HOgkpJXkuVSrndHlNKkyb6Q/pXYqLMjK8Qg1IszVxg56yGoX3jtQsGk+k61yaOlIvdnYcKle4L7YzherXNxangX135mgU/0qbrRKNL3gP40wwctzqd0onF9kAW8PEmSgVP49jfY116pKCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV+XHp0WzWpjH78WCtXgF0uW0ianDN25PST0B0nz8Nk=;
 b=csGPHQDf/KImImeb/2sq12uQ3Nfz1cc17jtMC8soSKJfCFM7Uwa0u4v7z+zxaXsaY15OgaKOb6x58qdsi5GtcEhv+T8+npoJOGRX5g8gv5d50vywBJleWu6WsMXfl3uIk8kO1cwNjcckaX5MC+faf16nYPiqi+yFQq+IqB9PW4SbgHFgMqyr1TOMLvx0PdbWFSMi+LFYMQjzfk69tDazdf1z4YgC+AxlF4UBXg4QltDhu2vI7w1MdP1hNnf2tFEuLOJXUJNpJ0ENnbKPmnB7NX0a3wt+9Y6TxoXHlD1aCjZJHUmH8t+R+IviVRAIzGWYwgO0YRr+NnnLxltn+UVunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1173.namprd15.prod.outlook.com (2603:10b6:903:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 08:05:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:05:09 +0000
Message-ID: <e74b1aa6-7aa6-d814-5dbf-209506e00553@fb.com>
Date:   Thu, 10 Feb 2022 00:05:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-2-memxor@gmail.com>
 <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
 <20220209195254.mmugfdxarlrry7ok@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209195254.mmugfdxarlrry7ok@apollo.legion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0050.namprd22.prod.outlook.com
 (2603:10b6:300:12a::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf80731-dd8e-40e0-b3db-08d9ec6c0e6e
X-MS-TrafficTypeDiagnostic: CY4PR15MB1173:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1173C3543BEC1AB0ABE52E86D32F9@CY4PR15MB1173.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiSJgC+2zpBOf1n6QPghJFmos+mDLD4VwroLTV4t0oMR+jsIF7LRZfg8B1XgN3dPJ3BYHXe5scGE5njAxtZmj6x2O0ihnWHhckytsF7X9E/KyV9nBSNPtVjU0Ds77tW/vLKDkFGXUzqAoQtsAOq6XEf1vT3SzMyQHCfMrbPZXfULhPApcI2bII+GCVgZD5eeNLws3oPLVKAsRAHs6U1eo8tEs1zKfs7LNpfv/vBopvB/wQ9HIk0LUfMgp3bESjpIYetUhQiEsLxDDulklPNC3ADGDL3E/uLYzu4oRhkEVM89+GaJ6K9Y8GvqHRwUp8nwScbY/xYATDXty0PkhFBRBkOlQa/ghxZyLHxckyDkefDdpR85L0JskPHPhGkpKeCcI7Fn4SE2aTuTA31EvsCDKr8WRaFg9wXcTIgDSuW9scdGMKkT8eOjz1BKRWAPvHIgN0vVFKTelAfOoreBCdYAYEso043JEeSvztasgYx0kxyTTZOI2LZipxYhMibQsfbv7WGpGhV46y/gz1srDyaa/WDu2kmWSFfe0MbC//LflrBISwrC3p4OVXmm3OBvw/EseYAuGR92/vwEtk/FWKZK5I1nOnFZdikwbKDsadYplPehKZotzVasp2NgArUHqanrQSYfLHbS94QWm4mR0GM2PUTfEb2DaS0cryqvnl0kp+n7zacC7k2zEx7mBqd1lfH+0o6ZZlTpXP2JOFH0PV5xQN3MqliPkA2OsRpyeHHfz3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6486002)(6506007)(66946007)(4326008)(6512007)(8936002)(31696002)(86362001)(53546011)(38100700002)(508600001)(66556008)(54906003)(6916009)(316002)(66476007)(6666004)(31686004)(186003)(30864003)(52116002)(2906002)(36756003)(2616005)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVpZTjlhdGZnckRHajFrbEwzendvNTJNZmgzWitYR2h6TDNDa3cvUmYrejd1?=
 =?utf-8?B?MWw0ejQxSHR0d3Fab05CSngvOVNvdld3bE5SMS9ZQVBOK2g3ZVlYeHR0ZXNx?=
 =?utf-8?B?SkRFdFc2bkpZUkpIMWNCdzVGTnNFeW9aT0tCS2FwSzJqVllISXlvTURPQWc0?=
 =?utf-8?B?VlFjemplMTl3ZkF6OXVXNXQ3Mkc1eklOK0U3ZWhaVm1aRnh3a0JzUnB4YVdi?=
 =?utf-8?B?VForS0VDODl0UWh4V1BlWGJUTUVtZDV1RXcyY2VVMXQwSTN0dHQwa1A4cWNM?=
 =?utf-8?B?czU0WjBxQURzeWc3WUhuZWphbVh2T3NDUmJzOC8xcUFGQXlvQndieENOU1Av?=
 =?utf-8?B?WTFlNi9valE1WFdBTWM0REhoSzdjQUdBTElLb3dYZmkzeko0UEF5YnhTN0JT?=
 =?utf-8?B?UjhlYVZRa2ora01SUGpUZk1KYnlFVWRpY3Q4TlN2MkxQRW9ZbzN4YS82bElF?=
 =?utf-8?B?djY3cWVBZHJFeWtyUWJBS2tORDIxVDhzS3RUU2NNeWlkMUZHcFRHOC9CS1hi?=
 =?utf-8?B?aFRQZ2dsQ0MwaUROQ3RqSmJtTVF5RmlwOG1IT0pGRVl1MEN3a1daNTlNOWU0?=
 =?utf-8?B?TE1aTjRWU09mYVNzVDQxa2Jtb3BuY1VzR1hic0dPSTZsYjJQcVdqSFg1VnVF?=
 =?utf-8?B?YVI3bW9ZWEUwaWhPZ0p2OUNwRmdLWDJISWpnZHY5UHdVQlI2SkdYUHZ1SGd2?=
 =?utf-8?B?WUw2bUl4ZlpmbFdaQlBMRzF2eWdEZHBsNmtYMWgxMzJvY2htSGNtNUZ1RkU2?=
 =?utf-8?B?QWFlVEU1dExHK3ZrTlg4cXVSdUZ3V21KZ0c3NkowVVBSZWg1WGdvVFhIbkE5?=
 =?utf-8?B?Wm4rUFh6Z05mYThEOVJ2WHF3a0l4bm9ONEJiYUN5WmNVVU1sUERES2NWY1pO?=
 =?utf-8?B?UVkzd2hxRm13Ny9pV0NKTTJrOWhEK0tiQUNlUzFOd2JQeE9RSWtwRFV1N2d6?=
 =?utf-8?B?Zm5mdXVVQ3hoQnlxQ3hyVlM4RmJYU3JxSE41bXpyTS9mVkgvNW5LQmVUTGtk?=
 =?utf-8?B?OCt0bjNuV2wvWEMxN0xkOHc1ZVJOYk9nNDBzcmJGY2ZXTThSekRVMlVYY1Yv?=
 =?utf-8?B?RUNpMGhJV2U5VThkbDdNYmtKSkNTRUZybkRoYytDeTVuVjdaVzVXSjhPUXl1?=
 =?utf-8?B?T2ZsZHAxMG9OUG9TanNNT3Vuby9zSndGMDA5bXFIRTZRUnhpOGlnKzdhQ0or?=
 =?utf-8?B?dkIzRXFybHg5Z1pBeElNTXRlRHRBLzR4YmdaNDA1NXR2aVl2dXU4eWY2TXpI?=
 =?utf-8?B?Ny8vRHp3eFJrTG5UTkNsMDVmdDU1dCt6TGl4dGFNYW5lRndCOXlsNXF0bVlT?=
 =?utf-8?B?Y2NjVUFsVUxDcHIwQ2h2dG02dDM4VkxrZTRuVHkxSStVUmRKYzRXd0ZsWGNW?=
 =?utf-8?B?cEs3T2xSZXJ0L3RiN3B6M0I0VjNhSUNwdGV5Y2cvYk1CZysxOCsxdjhxTFVr?=
 =?utf-8?B?aGIvZzVoSjV2ZHV6Vk9FVk9hNGlHVkNRQlc1M3UzdUpWbW13NisyMDZaZlh3?=
 =?utf-8?B?VUxoS1Vjc3hEWU8zY3ovTjBlSnBGaGlHZUNESUtJYUcrVS91R3dCQS81aC9F?=
 =?utf-8?B?cWZ4VlIyeUFMczIrNDgxZkwrbklDQWRZMlJYZUhoOE12aXlRZ1d0NjJpRUkw?=
 =?utf-8?B?L2pUNjRMQ0ZxNXg4bG93WjI1c2MwbEljMVhsWFVRSCtvSER3SWJqMHQ4NlFF?=
 =?utf-8?B?UXh1elRMbVl4S2J3M25VWjM4aGdTU3lnNmpiTTZycTlzcTJSRkMxVXE2enV3?=
 =?utf-8?B?TlBQdVlMQk4wMG1Ud20yRnJpT0lXemMzaEpxQkUySjNDTmJKaHlENys4MTNl?=
 =?utf-8?B?ZDhiL1VQZlBzMzZqNG1nZmlUSDkxRkxkYis1SEZGcUhTRHBXQ2s5NlJXNEky?=
 =?utf-8?B?aHFpeEZnQ2xoTE8rVHNRVDNFaTJwOWlqTGU2Q0FuYVArbmd6YkZSMm9GYU9H?=
 =?utf-8?B?cC9abGtudzFneHllQnd5MTQ4VlVkV0VkVnFTT3RuMzBZWTcveDJOUUhnVXE2?=
 =?utf-8?B?Yk83aDlYZFh1YmJWQUZKcFBSQ0tWN1h2MjVZdGVtOW9LNU41NHNvNkdJeEh3?=
 =?utf-8?B?SmNKQXJtbWZTZ1VGalJyb2sxeHNsdnNYUlVhY2RnNWVHb1dQdEdrajJpTlli?=
 =?utf-8?Q?00P1R6lUQs+w6S0qVQgqyUI5u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf80731-dd8e-40e0-b3db-08d9ec6c0e6e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:05:09.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u/m6At+dzCKcCjctRLQDZG4sl6x4FhQ5LOMjExxH+zAeXxoeeY2mshewFKQzlvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1173
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yuSOI-6ZRVlhixwKpibiZ21dwoeh9_RX
X-Proofpoint-ORIG-GUID: yuSOI-6ZRVlhixwKpibiZ21dwoeh9_RX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100043
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/9/22 11:52 AM, Kumar Kartikeya Dwivedi wrote:
> On Thu, Feb 10, 2022 at 12:36:08AM IST, Yonghong Song wrote:
>>
>>
>> On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
>>> When both bpf_spin_lock and bpf_timer are present in a BPF map value,
>>> copy_map_value needs to skirt both objects when copying a value into and
>>> out of the map. However, the current code does not set both s_off and
>>> t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
>>> is placed in map value with bpf_timer, as bpf_map_update_elem call will
>>> be able to overwrite the other timer object.
>>>
>>> When the issue is not fixed, an overwriting can produce the following
>>> splat:
>>>
>>> [root@(none) bpf]# ./test_progs -t timer_crash
>>> [   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
>>> [   16.037849] ==================================================================
>>> [   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
>>> [   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
>>> [   16.039399]
>>> [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
>>> [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
>>> [   16.040485] Call Trace:
>>> [   16.040645]  <TASK>
>>> [   16.040805]  dump_stack_lvl+0x59/0x73
>>> [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>> [   16.041427]  kasan_report.cold+0x116/0x11b
>>> [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>> [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
>>> [   16.042328]  ? memcpy+0x39/0x60
>>> [   16.042552]  ? pv_hash+0xd0/0xd0
>>> [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
>>> [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
>>> [   16.043366]  ? bpf_get_current_comm+0x50/0x50
>>> [   16.043608]  ? jhash+0x11a/0x270
>>> [   16.043848]  bpf_timer_cancel+0x34/0xe0
>>> [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
>>> [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
>>> [   16.044836]  __x64_sys_nanosleep+0x5/0x140
>>> [   16.045119]  do_syscall_64+0x59/0x80
>>> [   16.045377]  ? lock_is_held_type+0xe4/0x140
>>> [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
>>> [   16.046001]  ? mark_held_locks+0x24/0x90
>>> [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
>>> [   16.046569]  ? asm_exc_page_fault+0x8/0x30
>>> [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
>>> [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [   16.047405] RIP: 0033:0x7f9e4831718d
>>> [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
>>> [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
>>> [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
>>> [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
>>> [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
>>> [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
>>> [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>> [   16.051608]  </TASK>
>>> [   16.051762] ==================================================================
>>>
>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---
>>>    include/linux/bpf.h | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index fa517ae604ad..31a83449808b 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>>>    	if (unlikely(map_value_has_spin_lock(map))) {
>>>    		s_off = map->spin_lock_off;
>>>    		s_sz = sizeof(struct bpf_spin_lock);
>>> -	} else if (unlikely(map_value_has_timer(map))) {
>>> +	}
>>> +	if (unlikely(map_value_has_timer(map))) {
>>>    		t_off = map->timer_off;
>>>    		t_sz = sizeof(struct bpf_timer);
>>>    	}
>>
>> Thanks for the patch. I think we have a bigger problem here with the patch.
>> It actually exposed a few kernel bugs. If you run current selftests, esp.
>> ./test_progs -j which is what I tried, you will observe
>> various testing failures. The reason is due to we preserved the timer or
>> spin lock information incorrectly for a map value.
>>
>> For example, the selftest #179 (timer) will fail with this patch and
>> the following change can fix it.
>>
> 
> I actually only saw the same failures (on bpf/master) as in CI, and it seems
> they are there even when I do a run without my patch (related to uprobes). The
> bpftool patch PR in GitHub also has the same error, so I'm guessing it is
> unrelated to this. I also didn't see any difference when running on bpf-next.
> 
> As far as others are concerned, I didn't see the failure for timer test, or any
> other ones, for me all timer tests pass properly after applying it. It could be
> that my test VM is not triggering it, because it may depend on the runtime
> system/memory values, etc.
> 
> Can you share what error you see? Does it crash or does it just fail?

For test #179 (timer), most time I saw a hung. But I also see
the oops in bpf_timer_set_callback().

> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index d29af9988f37..3336d76cc5a6 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -961,10 +961,11 @@ static struct htab_elem *alloc_htab_elem(struct
>> bpf_htab *htab, void *key,
>>                          l_new = ERR_PTR(-ENOMEM);
>>                          goto dec_count;
>>                  }
>> -               check_and_init_map_value(&htab->map,
>> -                                        l_new->key + round_up(key_size,
>> 8));
>>          }
>>
>> +       check_and_init_map_value(&htab->map,
>> +                                l_new->key + round_up(key_size, 8));
>> +
> 
> Makes sense, but trying to understand why it would fail:
> So this is needed because the reused element from per-CPU region might have
> garbage in the bpf_spin_lock/bpf_timer fields? But I think atleast for timer
> case, we reset timer->timer to NULL in bpf_timer_cancel_and_free.
> 
> Earlier copy_map_value further below in this code would also overwrite the timer
> part (which usually may be zero), but that would also not happen anymore.

That is correct. The preallocated hash tables have a free list. Look 
like when an element is put into a free list, its value is not reset.
this in general is fine as later on a new value will be copied to
overwrite the old one, but this is except spin_lock and timer value.
spin_lock probably fine as it just contains a value like unlocked state.
but timer is a problem as timer has been released and reusing the timer
could cause all kind of issues.

Without your patch, if spinlock exists timer is always reset to 0 and 
hence we won't have problems. If spinlock doesn't exist, looks like
we could still have issues.

My above change is really just a hack.

The following is (sort of) a proper patch and with your patch the
selftests do pass in my environment.

commit cf9d4a47d95dc992504a717e4c39bbf2bac8b41c (HEAD -> tmp10)
Author: Yonghong Song <yhs@fb.com>
Date:   Wed Feb 9 19:53:42 2022 -0800

     bpf: clear timer field for new elements in preallocated hash tables

     Currently, when a hash element is freed and released to freelist
     pool, its value is not reset. This may cause a problem if the value
     contains a timer. Since the timer has been cancelled and freed,
     reusing the old pointer may cause various kernel issues including
     hang or oops. This can happen with the below command
       ./test_progs -t timer

     There are two approaches to resolve this. One is to reset the
     timer value when the element is put to the freelist, and the second
     is to clear the timer value when the element from the freelist
     is ready to be used. This patch implemented the second approach.

     Signed-off-by: Yonghong Song <yhs@fb.com>

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d29af9988f37..558f3c40307a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -916,6 +916,12 @@ static bool fd_htab_map_needs_adjust(const struct 
bpf_htab *htab)
                BITS_PER_LONG == 64;
  }

+static inline void check_and_init_timer_value(struct bpf_map *map, void 
*dst)
+{
+       if (unlikely(map_value_has_timer(map)))
+               memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
+}
+
  static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
                                          void *value, u32 key_size, u32 
hash,
                                          bool percpu, bool onallcpus,
@@ -925,6 +931,7 @@ static struct htab_elem *alloc_htab_elem(struct 
bpf_htab *htab, void *key,
         bool prealloc = htab_is_prealloc(htab);
         struct htab_elem *l_new, **pl_new;
         void __percpu *pptr;
+       void *new_value;

         if (prealloc) {
                 if (old_elem) {
@@ -989,9 +996,9 @@ static struct htab_elem *alloc_htab_elem(struct 
bpf_htab *htab, void *key,
                 size = round_up(size, 8);
                 memcpy(l_new->key + round_up(key_size, 8), value, size);
         } else {
-               copy_map_value(&htab->map,
-                              l_new->key + round_up(key_size, 8),
-                              value);
+               new_value = l_new->key + round_up(key_size, 8);
+               check_and_init_timer_value(&htab->map, new_value);
+               copy_map_value(&htab->map, new_value, value);
         }

         l_new->hash = hash;
@@ -1127,6 +1134,7 @@ static int htab_lru_map_update_elem(struct bpf_map 
*map, void *key, void *value,
         unsigned long flags;
         struct bucket *b;
         u32 key_size, hash;
+       void *new_value;
         int ret;

         if (unlikely(map_flags > BPF_EXIST))
@@ -1151,8 +1159,10 @@ static int htab_lru_map_update_elem(struct 
bpf_map *map, void *key, void *value,
         l_new = prealloc_lru_pop(htab, key, hash);
         if (!l_new)
                 return -ENOMEM;
-       copy_map_value(&htab->map,
-                      l_new->key + round_up(map->key_size, 8), value);
+
+       new_value = l_new->key + round_up(map->key_size, 8);
+       check_and_init_timer_value(&htab->map, new_value);
+       copy_map_value(&htab->map, new_value, value);

         ret = htab_lock_bucket(htab, b, hash, &flags);

> 
>>          memcpy(l_new->key, key, key_size);
>>          if (percpu) {
>>                  size = round_up(size, 8);
>>
>> Basically, the above clears new map value timer/spin_lock fields for *all*
>> new items.
>>
>> There are still some selftest failures due to this patch.
>> Could you run selftest, with necessary additional fixes, to ensure
>> all selftests passed?
> 
> Assuming that uprobe ones are unrelated, should I add this diff and respin? Or
> are you seeing other errors as well apart from the timer (#179) test?

Yes, please incorporate my above change into your patch and resubmit.
folks may have different opinions e.g. to clear timer field right
before entering to the free list.

> 
> --
> Kartikeya
