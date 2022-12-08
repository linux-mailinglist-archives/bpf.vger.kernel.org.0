Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98538646B05
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 09:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLHIur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLHIuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 03:50:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F333DEC9
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 00:50:44 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B80OJEr005555;
        Thu, 8 Dec 2022 00:50:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XTrVvhxK8V4MsgiZcytKF+saHNkuzMEloU0H1gzjXuI=;
 b=e1sFUchyYg8jIcSZvPieBmithwK8x0apB3RzH3Vz4mZdEHAHe/qqAuLfC1J6mgrhHVF0
 JqmIzxR1pnH+XCa/cRDsC+ZamkxqAbItFTrYnc/1hYToyXm/VxvCyMabqmincz/XYbbQ
 P2aB9Z2dtm5xO/hc8cpfdVxVrt9vb0c/uViEjMhZ4OH4YRSJLrkStiSlJv8/q/8Iy9+G
 LAXSFHGAnEPn7Jg19o/62OjWgL3sVw9L/HhsB4q/ztdcLLC0cQYTlZ9MgE/lH4dhmGZQ
 NGkwgyzHw31Xu4TwihMuY5QuszEqKPQL1bo3rkOAHS/KjHrWw8+W5Bdb8juPsmMxa7PE KA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mag3gjfa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 00:50:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUcn+BvZTQembLyDydVTwG0p7aAB/k3RASi0rtLWtE6ciIYyI9GHOFp7cpZbAahQDOr/uckUrjg5kzZ+MIAk8xaE/MXBsbAOS7PynET8bfYtprrmBGEYb7rXEiP8UrCj+TX8GTCTXVo+u+130a10ubNyjCp3Ra+A+T8gE3ArKyPIAkIwC3sBuSEfoiFERuRUiP6lv8SsSfH3cP1WSlG0gceNn+O1Tpg+zBpIWTuUVs+OdmuGRhFWaXHhgqPxOtwjXjOYN58s5UtlkK7X9no0+eSLi0JvWA1KLSV80B/NgyzdlC76UcrKLeXpKiWphstlBHjyV9KSSNT3iJDphXITUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTrVvhxK8V4MsgiZcytKF+saHNkuzMEloU0H1gzjXuI=;
 b=lbecHvnDPmL1XsXpMGLEk3S8PhAeQBhLkMTSoStQmCY5e4VTd9ak6A8ituM8FNoqMFt0iuk6PWhKyqYJjzIVfkHT8EEvCJmIHEwDTpw6SrsC6x3F8x0w0Jlxzd3BRPuRK9TwKdspGIq6d2ruMZGramngymvA4GXdITdkbcaZnC5D5fB9DBuYTzJfMCNcXMXhb/FF6SafNmY58jl/wcNXdb0BjihtnQ9bD6dnazWVEyWt1S7hAuGBscbiQo4TdWBErXSzXt069Yuwt3ql1LbY47zTmFlSTR5SeBzCWh8N1c6SkxqNVxzvPUQNRxLMsXXjKfCuHVv+HwqGTGuBmoxYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SA1PR15MB4467.namprd15.prod.outlook.com (2603:10b6:806:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 8 Dec
 2022 08:50:23 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 08:50:23 +0000
Message-ID: <a3a1ad71-d0bf-b174-a29a-a13675a3395f@meta.com>
Date:   Thu, 8 Dec 2022 03:50:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for
 insn->off < 0
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
 <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
 <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
 <20221207180621.zkuztvz7hx4niout@macbook-pro-6.dhcp.thefacebook.com>
 <ea0259d9-2f29-bfbc-011f-810d3e2654a8@meta.com>
 <20221208004734.3deulbouezpiehrg@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221208004734.3deulbouezpiehrg@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SA1PR15MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: a9aa077e-45aa-40af-9782-08dad8f93ea6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVQYqbHaBm7rAvKLJ49M7sFTdCg1Xu2abnA9pj+wd3soh5heFrRYu7QjogP7yIED5bAAL6IQa/N9aGWueNh8e6LZRjQvYpHzUgk8ETm3PLw6at8xYB66zZPqb29vOqMo3MaQVY56pNeJT8elOlcOhqcL+XTcyxpx57voDkUQvsBHhQ5ASheUJGgp6aI2KlVHTT3Sv/Qtib3PSd2DJT/ZCiSmNpv0IBFtpAN8G7q8/pgRmLrwak66ij/d84BJLGh8/KnZYSUoFx9rTTDkr9XuwOA0xMlUb0vwd6hDLsx9CwAomMQBbr7ShUNGefpLMLpT+YF1gQ3AtjiGVVnCDSghx0pv8/De/pAmi20futAga166Qx354UfMgrnWm4q19/4c9cko/wDM0dT1fam+zcMn0QRQEaobH/F91JUzh5o9K+cGpqZir80wVzA5x0jfDie68g2d55xIM8qSjPIf3HJF0V0gGllvqBOakj5KpFUPzTuoDJBmLD3G2Bk6dpVeEuvOtQttJBANELE47jx4lifGpoG1ZJ8YRvu1+LqCpOts5IxS6zeVBW7Q171xf8hvxct7+ucCJkpbWfpPEjlVLihya5jJLMHHHJSXtLW1TEh19QB42/QQHztjBFysFGQ2l7Kf00KxXWq7BZxVw41yKfPNXQi1g9iyy98e4JqZPmrk6y+sujBdawMiK+P1yBnAC3IiTGjFsiQQKGGohWVdBV1HWXIcK1A+rjLSuTs/1qMF8Po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(83380400001)(5660300002)(86362001)(4326008)(8936002)(2906002)(41300700001)(6486002)(8676002)(6512007)(6666004)(6506007)(53546011)(186003)(54906003)(2616005)(31696002)(66556008)(478600001)(66476007)(31686004)(66946007)(6916009)(316002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1cwQXpYcVRCSnc2UWxONVQrZEpUWVBvT04za3lzVWxqaEFLb0FlUXUxTHY4?=
 =?utf-8?B?S2RMUWEzNUlnZm9aeUFpV2M3aERqdE8yYW1rQ3NQUDdTWXR3R2RCWE5TejdD?=
 =?utf-8?B?K1hyVnNYTnhVZTBnYkw1dHhtWVdBeW1SMzJuclU0WTR1NWh4eFZNV2NLLysv?=
 =?utf-8?B?c2lmV1l5WXFXUmNnTWJWTDBadGRKYkhqSW9SNW52bVRreUY4QWNKK1BabHla?=
 =?utf-8?B?bUNDQWF3MlhiS1BEK0ppL3AzWHpTTzhGZXlsRFF4TUtNNGRqeGtwMElwc293?=
 =?utf-8?B?QWpZTUhVZUMyY0txNEZlYUM3ZzhKd1BYTGZxVlB4Zkh6ZzB2Q28yV1NaOGZx?=
 =?utf-8?B?NEl5dTNnTFI3ZisyenpKcCtYNXVIUmdicVhsMVhIZnlUYzJYbEUvTlViUXZF?=
 =?utf-8?B?M0trSXZtMEthS0htY1RNLzk0eFkyYllsRlg0Y1dYaWtxUFR1K29ocWNzdFBi?=
 =?utf-8?B?RHgyenBicGc0aGJCdVp3T0RhVFpPZ0xOWVZWSGkwWFBCalJ3S1NDSzNNMGxN?=
 =?utf-8?B?SjcvV2FYL0lLdUNtRDBYZ25vdVJTV2VKdkdQbVk4V281bjBlVWs4Z2xSdGN1?=
 =?utf-8?B?V2ZrSkdUa0JMRzdsWHpodkp5Z1dXVG0vbjFDa1ZPNUNOOURocHZhR3VkZGEw?=
 =?utf-8?B?S2M3Znpha3RNb0VadU5DNU9jL1EwR0E1ek5BcFB3SXlvT0FvT21tUFNHWWxI?=
 =?utf-8?B?a1dOb01wUGFxWWRKZ01uMjNId1NXa0h4d0VLZzB5OHVrVkZNLzl2TTN2Vi8v?=
 =?utf-8?B?c2hqbWxNZGhMUE5NekRoQms0djdBTnhzdVNKNS8wL2Zka2kwNkRQZ2toamtp?=
 =?utf-8?B?Sm1CVzJkQUgyenczR3FTUVNBa25jb1RMRUpWQmtpTlN2TFNzS2xBT3lYRDl5?=
 =?utf-8?B?SFp5S0dFYW5WeUVHcmhXcmlENkVXaW8vYzZrMFEyQ2hlenRvS3ZGQmdOUzMz?=
 =?utf-8?B?ZE5ubG8xWDVjQ3VjZlpidTAzTkJKaW4rcXNDcVdxZzd1Y2xSTUt1SDNhWVg3?=
 =?utf-8?B?dGszcUVCZFZjNHgvZWJpZjE2OVgyWTJmUTZjcGpxMXd3VVZmdlRCRnFhRkZF?=
 =?utf-8?B?SWdZREZpcG5xY2xIcE5DV1YreWpXWnFYYVJhM1Vua3lNRVhEZkd3RVdaRHdK?=
 =?utf-8?B?SFMwbkE3N2ZZNHZ6WHhGRmdTUGUrZHhrTGJWM2FuQ2JnVVlDc2FFNzRBMk1i?=
 =?utf-8?B?T1JQN2tpaW94UWpqVlhibk1OZVZKcDg3ZG9yeFZTZXQxSlE4Y1RveVdsTGlS?=
 =?utf-8?B?QjhmRzFTUng3Z3dMcUxRY0hwR1l6UWZQOFpRS2ZRbU02dGcvRFFXRHFqZExF?=
 =?utf-8?B?KzJzMXZZVjRuZVVTaHRBSDUwb3g2dXhxUUFzT0QrWUl6cGg3SXcwSlRSSUlP?=
 =?utf-8?B?Rms2MUprc04rZWxMSzFnKzg1RkUxdHcxVE9rck0yWW1LZGdQMVhGNXFqMzV4?=
 =?utf-8?B?UWpBaC9hWE5ZV3JiLzRKR2FYY1VrUGxRSzZPd0FraUF3a20zWE1ub3A4RVQ5?=
 =?utf-8?B?V2kyaHpYZXU1amtMRWdBMWxBbG8zY1pRZnlPU0F2VGZ1VnhjaTExTnd0bktW?=
 =?utf-8?B?emVqT0RveW1aZm95R1gxVUxib3hsZWt0RXc1UHFYZmdBUUNEeTRYRHZyMmFk?=
 =?utf-8?B?WGN2aURtdDRNL0pWZ2hyVFBSeDluUEUzZ1NxSXJuM0lHd25RQk41eUxTcG1F?=
 =?utf-8?B?VVNUdmt0WWIzS25iNVdQdCtMSXdudGZQT28xUFlZcUVON0RVRWxrZWhFVnF0?=
 =?utf-8?B?MWg3MkVKWmU5UWgxMDRLMks3Y01uZmhqZy9wcmJwWUNodkhGbTVLd3NqMDA2?=
 =?utf-8?B?cTVHcFdHNGcyVzJ0YnFPNXNURkZyWFRWdTVqaE1RRGdGMzI5WGh4a050VlBG?=
 =?utf-8?B?MVJFV1ZhYnRqOWx6ZUdYcm5FWUFRNEg4WTNYSDZQNVNabGtWWjJzeHBmUktC?=
 =?utf-8?B?UGlNd1BZOHY1QmV2Zzg5Qjdqa29iYVFyT2J2aVhyaEZGTjBXcVZ4VEg3S0pG?=
 =?utf-8?B?RUlBcXFuVDB2WmJVKytrNmhiazFvN3huWU9zNm9yMjlVcUk1MnJZWmV5Z3R1?=
 =?utf-8?B?cyswUEhyOE9HaTdNTVRQUnNUclg0SGpWQUdZUUI2ZWdpdXpNdFBDQ1NlK1ZO?=
 =?utf-8?B?SVZlZDZVWElVRnRHMDVSaGVLa0owNEhkMDFXcm81SmtGeE1NZ2ZNb013SmRT?=
 =?utf-8?Q?F+95M75x7rmy0eU3ji9JvMc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aa077e-45aa-40af-9782-08dad8f93ea6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 08:50:23.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0qP5rYXeWTN4L1BgarwaVZT6nJSqGjHA7At3f5L5hB3NxiETfpZv6u+J4vYmxPC3zR/g5CbfTvV3rjh3xiYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4467
X-Proofpoint-GUID: JNXfvfsZnQZ38IKg1AYq4hqkOUH73NBs
X-Proofpoint-ORIG-GUID: JNXfvfsZnQZ38IKg1AYq4hqkOUH73NBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_04,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 7:47 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 06:39:38PM -0500, Dave Marchevsky wrote:
>>>>
>>>> 0000000000000000 <less>:
>>>> ;       return node_a->key < node_b->key;
>>>>        0:       79 22 f0 ff 00 00 00 00 r2 = *(u64 *)(r2 - 0x10)
>>>>        1:       79 11 f0 ff 00 00 00 00 r1 = *(u64 *)(r1 - 0x10)
>>>>        2:       b4 00 00 00 01 00 00 00 w0 = 0x1
>>>> ;       return node_a->key < node_b->key;
>>>
>>> I see. That's the same bug.
>>> The args to callback should have been PTR_TO_BTF_ID | PTR_TRUSTED with 
>>> correct positive offset.
>>> Then node_a = container_of(a, struct node_data, node);
>>> would have produced correct offset into proper btf_id.
>>>
>>> The verifier should be passing into less() the btf_id
>>> of struct node_data instead of btf_id of struct bpf_rb_node.
>>>
>>
>> The verifier is already passing the struct node_data type, not bpf_rb_node.
>> For less() args, and rbtree_{first,remove} retval, mark_reg_datastructure_node
>> - added in patch 8 - is doing as you describe.
>>
>> Verifier sees less' arg regs as R=ptr_to_node_data(off=16). If it was
>> instead passing R=ptr_to_bpf_rb_node(off=0), attempting to access *(reg - 0x10)
>> would cause verifier err.
> 
> Ahh. I finally got it :)
> Please put these details in the commit log when you respin.
> 

Glad it finally started making sense.
Will do big improvement of patch summary after addressing other
feedback from this series.

>>>>        3:       cd 21 01 00 00 00 00 00 if r1 s< r2 goto +0x1 <LBB2_2>
>>>>        4:       b4 00 00 00 00 00 00 00 w0 = 0x0
>>>>
>>>> 0000000000000028 <LBB2_2>:
>>>> ;       return node_a->key < node_b->key;
>>>>        5:       95 00 00 00 00 00 00 00 exit
>>>>
>>>> Insns 0 and 1 are loading node_b->key and node_a->key, respectively, using
>>>> negative insn->off. Verifier's view or R1 and R2 before insn 0 is
>>>> untrusted_ptr_node_data(off=16). If there were some intermediate insns
>>>> storing result of container_of() before dereferencing:
>>>>
>>>>   r3 = (r2 - 0x10)
>>>>   r2 = *(u64 *)(r3)
>>>>
>>>> Verifier would see R3 as untrusted_ptr_node_data(off=0), and load for
>>>> r2 would have insn->off = 0. But LLVM decides to just do a load-with-offset
>>>> using original arg ptrs to less() instead of storing container_of() ptr
>>>> adjustments.
>>>>
>>>> Since the container_of usage and code pattern in above example's less()
>>>> isn't particularly specific to this series, I think there are other scenarios
>>>> where such code would be generated and considered this a general bugfix in
>>>> cover letter.
>>>
>>> imo the negative offset looks specific to two misuses of PTR_UNTRUSTED in this set.
>>>
>>
>> If I used PTR_TRUSTED here, the JITted instructions would still do a load like
>> r2 = *(u64 *)(r2 - 0x10). There would just be no BPF_PROBE_MEM runtime checking
>> insns generated, avoiding negative insn issue there. But the negative insn->off
>> load being generated is not specific to PTR_UNTRUSTED.
> 
> yep.
> 
>>>
>>> Exactly. More flags will only increase the confusion.
>>> Please try to make callback args as proper PTR_TRUSTED and disallow calling specific
>>> rbtree kfuncs while inside this particular callback to prevent recursion.
>>> That would solve all these issues, no?
>>> Writing into such PTR_TRUSTED should be still allowed inside cb though it's bogus.
>>>
>>> Consider less() receiving btf_id ptr_trusted of struct node_data and it contains
>>> both link list and rbtree.
>>> It should still be safe to operate on link list part of that node from less()
>>> though it's not something we would ever recommend.
>>
>> I definitely want to allow writes on non-owning references. In order to properly
>> support this, there needs to be a way to designate a field as a "key":
>>
>> struct node_data {
>>   long key __key;
>>   long data;
>>   struct bpf_rb_node node;
>> };
>>
>> or perhaps on the rb_root via __contains or separate tag:
>>
>> struct bpf_rb_root groot __contains(struct node_data, node, key);
>>
>> This is necessary because rbtree's less() uses key field to determine order, so
>> we don't want to allow write to the key field when the node is in a rbtree. If
>> such a write were possible the rbtree could easily be placed in an invalid state
>> since the new key may mean that the rbtree is no longer sorted. Subsequent add()
>> operations would compare less() using the new key, so other nodes will be placed
>> in wrong spot as well.
>>
>> Since PTR_UNTRUSTED currently allows read but not write, and prevents use of
>> non-owning ref as kfunc arg, it seemed to be reasonable tag for less() args.
>>
>> I was planning on adding __key / non-owning-ref write support as a followup, but
>> adding it as part of this series will probably save a lot of back-and-forth.
>> Will try to add it.
> 
> Just key mark might not be enough. less() could be doing all sort of complex
> logic on more than one field and even global fields.
> But what is the concern with writing into 'key' ?
> The rbtree will not be sorted. find/add operation will not be correct,
> but nothing will crash. At the end bpf_rb_root_free() will walk all
> unsorted nodes anyway and free them all.
> Even if we pass PTR_TRUSTED | MEM_RDONLY pointers into less() the less()
> can still do nonsensical things like returning random true/false.
> Doesn't look like an issue to me.

Agreed re: complex logic + global fields, less() being able to do nonsensical
things, and writing to key not crashing anything even if it breaks the tree.

OK, let's forget about __key. In next version of the series non-owning refs
will be write-able. Can add more protection in the future if it's deemed
necessary. Since this means non-owning refs won't be PTR_UNTRUSTED anymore,
I can split this patch out from the rest of the series after confirming that
it isn't necessary to ship rbtree.

Still want to convince you that the skipping of a check is correct before
I page out the details, but less urgent now. IIUC although the cause of the
issue is clear now, you'd still like me to clarify the details of solution.
