Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459E64F86D
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQJWD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 04:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLQJWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 04:22:01 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD7B1E9
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 01:21:58 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH7AJIq023663;
        Sat, 17 Dec 2022 01:21:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KCH3VvtCF/AP4A5Het3jlP307BakptsEBvHaYP2BuP0=;
 b=fZ37YiIQFej+aRdRPnNIWqT1FS7K3w/6GvGMCxjfzNYlV4heY3UicdlKAnFzxX80QJRI
 2BX1CXUDBj38ITPHtm+naSpTIjdIzjbmUOacCEAOLMxS2NWdYKQKPxDICbHL406x1yYi
 V0HWEh1ajlAqY2jEW9YcNX7jDU672xcoSaxaei05dS0zk1hDp2poiLulsobHOUq/Hrq8
 KBnI3EhkHE0+pespTsjCLTOz4g5wofhDnTfVaIONrlEsB+sjCT4+yBzmQ4H92yMM6y9A
 yKE6lt4lH2WrqjsQYemQrSlXvK96P8Zha/sEZh7KF2QwvpyxjGDl10GCn5dI7W5ASOqK RA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6uh8vp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 01:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2Y1V5O4Fbpcq9dpS3IsKY9bK42b/MPo4KR41uAkbQBFAfry0ovyy7zjHzHb7/iheSEP87BkxY8lWrREXXglN7JR8BgNbYpg53s8kjPJLH09B7Lkozs227GsHysrGBcxf6wftIVX+Z1FvrsCP/+sn+HjWfVJnRvPv53Uwp8538CfrhEQhvLzADi73ceOvpl3ZAz39zPmiJzEGD47gk99kB7rFNjaaQsf4xi9FKawzxIofTumVp3ggaYwesaIC1A1lspbzEXSE0mN5SuoFUBCvRjJYEvimB8Eiku0i39tteZVRVuWdjwnRo4EpK8pB1b/F10G2f/L/gJhzo58/whp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCH3VvtCF/AP4A5Het3jlP307BakptsEBvHaYP2BuP0=;
 b=DD7qROStwhEk1H8f+CAkffsxBjMqiekYc45hkcjzW6HXt7GW350yqCSsxjPLRf6vyHsqc9VVdXZBEq9eKpS4jm8BhA3KiEHdVA0Ulh1WDhc9QzgTneQnc8fcSBHLPVPYqM/eoqvo48yWNPOOV/dYW/2UCyjmb+25vjpfhTJTcRQcBQ7zY5Z67xHvowKbhN3YvyLTmglXizShYpHVrwwwUxsl4UKZT0DQVvlVany0e7qAjPnq3K2oEB68n27jFh19JkvXN3levsEUlIHzknYfFvbAxQuuQkM3lhv50GXXXK1Mahdo3pccFMEuH/gX4ZgqfiMaufsIMVW6G5GeRm7ZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CY4PR15MB1637.namprd15.prod.outlook.com (2603:10b6:903:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 09:21:39 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 09:21:39 +0000
Message-ID: <54cee23f-e785-e5ea-368f-ab989c346354@meta.com>
Date:   Sat, 17 Dec 2022 04:21:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-3-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221217082506.1570898-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CY4PR15MB1637:EE_
X-MS-Office365-Filtering-Correlation-Id: b10e57f3-396c-46e0-6c19-08dae0101a61
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wpRXy7suDwJt8qylDDkMCtMdwkY5pdledBXNxESdphEgpQLU26h8pNKgAu5wFUUIjOgvkNg1joH+4V+pJ5jxnb5KZi1aMXjBchjFKDUUTkylFYHWSn/dM7F2kBnWvcFcq1uJMvTk4kphOTiltb7GzbYpmLlcCzlm0ycZ1XX4qL5TnghjVXWl87CN2LBB3Hkj4vwiwlbynsCf438EzDEBhdAgZbts+dOYX8NgpO+q//sXBtZdEmXLPxs4OuDqd1yTGqb8xA9S8fdPD6/xApeso6PlEWovZZJ022nHNBOFqIEP73CTpQHTU56Tw/x0hQ9P7jlWbqNnPTez2SoOajs8sCguFGhjl6G0ajJ15JRqk6wto3UxJPQ2tFJyW6T73i1Tdqzm0OJKPJ2sjzTQsDH1TEXy+tVSzO/xIfDBSnwh8tzePmcxjolr3I9gVft8ti8YSllCbERlmhLawPYI4EUOW3y4vM0gTRjUqKZH7qrtZnHjXKqwS3ffTa+rajavsDnyjMhq5PhnIduT1B++NGorQCUnGVvmqHi5PTIceGUvzJhsbkF/9OdlfVAUNSnK1g8saWNcr1pWOXJ9owu0d67lif3ufVLehDs5AfXxvLitmE5gnlZRwcCrT+3MYCpgJ1W4CDZMcA3rX5vcDXMvx1BaL5h0ZPRhWpr3pqRVk5XkZshzU4/OGHYq3fncdJ/P/gYnxYpQEZKZ2BXhHxL7G7PPIj0CzNqEJ/cMvKuyzuCV1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(4326008)(8676002)(41300700001)(2906002)(83380400001)(186003)(31686004)(5660300002)(2616005)(8936002)(54906003)(316002)(66556008)(66476007)(66946007)(86362001)(53546011)(478600001)(6506007)(6512007)(38100700002)(31696002)(36756003)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVYYWNkREc0d1FKaU5jWm1BT3Q5c2g5ejdneWhlRFVEMnpSK2RPbzVjMnUr?=
 =?utf-8?B?cVVJOTZHaitHL25NOXh2dzlOYjBTYUVjaCtXUFZlSzJVTnYvTG1RenlSM3kv?=
 =?utf-8?B?aFpmU2p6RFpzcGJNVC9waExrcUJjOWZvY01ha3lTSnBPa0RnQzBwbWpCdG0r?=
 =?utf-8?B?WTJnNTdmWWd1eHdrS1Z1VDdKcGpjWTNaZExoWVMxeWpkMEIzM1hja3hEZVV5?=
 =?utf-8?B?V3VZS3BobTlXUEVHV2lORThKZnVDQXpVNHc2c1FGYzFnWWgzeWI3MnJPbksw?=
 =?utf-8?B?OHBob2hWNm5rWDRzQzhHd09YVWdXT0d3ekFVVit2bUpPay9NR0YwK0RnVzkv?=
 =?utf-8?B?djBTRzMyd21BbHZ4M0hTSTlIL3ZiTGY5NGc1N2xvUitUVkR2WGtmaWFid3cy?=
 =?utf-8?B?R1BsZktpbjVZdzBjTzRKWGYyOEVhSVVrWHNOL3Z2SnJwLzVhTmNvMUV4eGRz?=
 =?utf-8?B?UTJXcWpHbWlrRU81MzlPdSsvS0RDZGZMVHFTSSt6Y0YvMit5NFY4a2l4eCsx?=
 =?utf-8?B?QjFxZWlSUldla29POGltbkNmMXQyUjhhajlmd0prNUFPRlNsQjYwTVFoWmEy?=
 =?utf-8?B?NERyNnh6Y2FJR2k4NFgveWFaa3ljeWpkdFZoVDkrVzNhc2Q2WFNXWFdRK29L?=
 =?utf-8?B?R0k5T3hPWXFRV0F4Y2hNMzEwR2hYZGUyaTQ3YVdLb1ZhVUxNWXdNRzk4ZzRK?=
 =?utf-8?B?K2k2VWRuQllTU2h3czRWdWQ5dkR0eVZKa0YxYUxIWHdwYWk0TW1ONmFkUXRq?=
 =?utf-8?B?bFFweTFSaUk4MFdsTFpQbll5L0ZGeWQrZnVaRjI3a3IwYUg0WTVZdFRyaytj?=
 =?utf-8?B?elBZLzErZjJtcVl6NGcwQ2NVdWhqdkRCZFhEaGdPUmEraW9sSkVGWkZsd0F0?=
 =?utf-8?B?M3A4bUNZNUVoSjBzVlUwMGw5bCtCczlvQmdZWUpCU1VEeHpub0J1eXJMVGxV?=
 =?utf-8?B?bDB3SEk1LzdYdUxteUl2bE5VaWx4eld0SVo3eG5IdFNjU3R1TlJjeHd1UjFm?=
 =?utf-8?B?OWVGa0h3SVkvOFpGOFI4V2xUY20wQlNJcHY3SDVDYmpYUU95c1FsUXVwTnJl?=
 =?utf-8?B?OERQSk9oNEZiM01XVURFUjZCazZMRThON3lBT2NiTUlJQm5yTXlVUXRHa3oz?=
 =?utf-8?B?MEhDd2tueWZ2ZVlkWXJHMVcwRERseW94ODFlODBIa2htSmJaOU15ZDJJVjI5?=
 =?utf-8?B?Z1h0aHVnVGR0YWZJZTM3OWRZSFpVUmE0ZVdyekZVQ0lyOTNhZTZVRWJhekJY?=
 =?utf-8?B?a3hnL1ZVUW1GYmdjenVGMXNoV2wzZkJxc0xvNlhvZmJEWlFrakZlaTFWZnI0?=
 =?utf-8?B?VW15V0ZoelA5U3ByaHNWb0todDg4WkphZjkwTkpyMEtOanltV0N6cjNJZ3R0?=
 =?utf-8?B?NHFPd3RpdlpEMWlmOGRFYThrTTk4Snd2RVlTb016SmFFV1JFNDZvcVpGbFNQ?=
 =?utf-8?B?eCsrT0dpbGZxZlBpTmxzTUk3QkZld3hTOW5zTmdCUThHTHFiWEowbkFSWDJC?=
 =?utf-8?B?M0tKazBIcndBd3dKOFU2VEJuRld2T3UrTHNTNzdkMHhnN1duVDFMQkszczRX?=
 =?utf-8?B?eGc4NUVJZkR1RjFNdmJCS0R4cUVnQi9TcHY3d1lJRVdyN3dzNHgxdUVzb2RE?=
 =?utf-8?B?cFNWVm8xR0VCSngxRjNyTHd6NWdMRzBxVHRGaG1qNHk0UHVSaC9icS84QzlO?=
 =?utf-8?B?M2hLeTJVTFQxb1ZBTTNtdWZ3bGFmZWlkN3Y3ZTA1Um1UcHVKVHIrOGxBdnNn?=
 =?utf-8?B?cVNOUEJZWklRTlJzaWhpTTBZTnAzaEc1dE5xVHlQWnNJVWEzTXJyajhBdkIr?=
 =?utf-8?B?ek1UVDZxMXk4TW91UnNZbThhUC9kVHhHc1lycGZKVkxUQ3BRN3kzdENDSVJx?=
 =?utf-8?B?bWpOSzNoZEhGNmY1S1RScGVrdy9JNDZSMDRHbFcrVEcwdnZhKzFDd1E3QkM1?=
 =?utf-8?B?UHlYRFVSYVZjN3kxek1FbVBWOXN5ZW5RUCtmLzR0ZjJyTWI3WWlxVkxYMjF5?=
 =?utf-8?B?YVZpNmQvWVJSTFRabVlneUs5Y1RidUZvSE1FVTNRa29ncktzK0toVzRGWGx4?=
 =?utf-8?B?SUFhZ3Rzc285ODFsRlV0RmZGbjNQZzJQQWFMd0swZC82SjVwUlZBcmYwRk9m?=
 =?utf-8?B?NkdWRzlQRC9yTWVaVGNaS3VyY084VVQ1N0k5VU9sbHFBSENESElMWTFpN3pY?=
 =?utf-8?Q?abd2Uyq4QMvhbNF5yOGni98=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10e57f3-396c-46e0-6c19-08dae0101a61
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 09:21:39.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zQF8nQ5FZjL8WugqUaX+Y9AUMUwv1VzXy9Zysrs8OCKC9Q6UiBrVHzrK00T417KhY2R4L2u1NP3J+fLYM6qYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1637
X-Proofpoint-GUID: AflnGJe1TzW57wA_lKOXft6t9ktodc5G
X-Proofpoint-ORIG-GUID: AflnGJe1TzW57wA_lKOXft6t9ktodc5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/17/22 3:24 AM, Dave Marchevsky wrote:
> This patch introduces non-owning reference semantics to the verifier,
> specifically linked_list API kfunc handling. release_on_unlock logic for
> refs is refactored - with small functional changes - to implement these
> semantics, and bpf_list_push_{front,back} are migrated to use them.
> 
> When a list node is pushed to a list, the program still has a pointer to
> the node:
> 
>   n = bpf_obj_new(typeof(*n));
> 
>   bpf_spin_lock(&l);
>   bpf_list_push_back(&l, n);
>   /* n still points to the just-added node */
>   bpf_spin_unlock(&l);
> 
> What the verifier considers n to be after the push, and thus what can be
> done with n, are changed by this patch.
> 
> Common properties both before/after this patch:
>   * After push, n is only a valid reference to the node until end of
>     critical section
>   * After push, n cannot be pushed to any list
>   * After push, the program can read the node's fields using n
> 
> Before:
>   * After push, n retains the ref_obj_id which it received on
>     bpf_obj_new, but the associated bpf_reference_state's
>     release_on_unlock field is set to true
>     * release_on_unlock field and associated logic is used to implement
>       "n is only a valid ref until end of critical section"
>   * After push, n cannot be written to, the node must be removed from
>     the list before writing to its fields
>   * After push, n is marked PTR_UNTRUSTED
> 
> After:
>   * After push, n's ref is released and ref_obj_id set to 0. The
>     bpf_reg_state's non_owning_ref_lock struct is populated with the
>     currently active lock
>     * non_owning_ref_lock and logic is used to implement "n is only a
>       valid ref until end of critical section"
>   * n can be written to (except for special fields e.g. bpf_list_node,
>     timer, ...)
>   * No special type flag is added to n after push
> 
> Summary of specific implementation changes to achieve the above:
> 
>   * release_on_unlock field, ref_set_release_on_unlock helper, and logic
>     to "release on unlock" based on that field are removed
> 
>   * The anonymous active_lock struct used by bpf_verifier_state is
>     pulled out into a named struct bpf_active_lock.
> 
>   * A non_owning_ref_lock field of type bpf_active_lock is added to
>     bpf_reg_state's PTR_TO_BTF_ID union
> 
>   * Helpers are added to use non_owning_ref_lock to implement non-owning
>     ref semantics as described above
>     * invalidate_non_owning_refs - helper to clobber all non-owning refs
>       matching a particular bpf_active_lock identity. Replaces
>       release_on_unlock logic in process_spin_lock.
>     * ref_set_non_owning_lock - set non_owning_ref_lock for a reg based
>       on current verifier state
>     * ref_convert_owning_non_owning - convert owning reference w/
>       specified ref_obj_id to non-owning references. Setup
>       non_owning_ref_lock for each reg with that ref_obj_id and 0 out
>       its ref_obj_id
> 
>   * New KF_RELEASE_NON_OWN flag is added, to be used in conjunction with
>     KF_RELEASE to indicate that the release arg reg should be converted
>     to non-owning ref
>     * Plain KF_RELEASE would clobber all regs with ref_obj_id matching
>       the release arg reg's. KF_RELEASE_NON_OWN's logic triggers first -
>       doing ref_convert_owning_non_owning on the ref first, which
>       prevents the regs from being clobbered by 0ing out their
>       ref_obj_ids. The bpf_reference_state itself is still released via
>       release_reference as a result of the KF_RELEASE flag.
>     * KF_RELEASE | KF_RELEASE_NON_OWN are added to
>       bpf_list_push_{front,back}
> 
> After these changes, linked_list's "release on unlock" logic continues
> to function as before, except for the semantic differences noted above.
> The patch immediately following this one makes minor changes to
> linked_list selftests to account for the differing behavior.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 53d175cbaa02..cb417ffbbb84 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -43,6 +43,22 @@ enum bpf_reg_liveness {
>  	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>  };

[...]

>  struct bpf_reg_state {
>  	/* Ordering of fields matters.  See states_equal() */
>  	enum bpf_reg_type type;
> @@ -68,6 +84,7 @@ struct bpf_reg_state {
>  		struct {
>  			struct btf *btf;
>  			u32 btf_id;
> +			struct bpf_active_lock non_owning_ref_lock;
>  		};
>  

I think it's possible for this to be a pointer by just pointing to
struct bpf_verifier_state's active_lock. Why?

  * There can currently only be one active_lock at a time
  * non-owning refs are only valid in the critical section

So if a verifier_state has an active_lock, any non-owning ref must've been
obtained under that lock, and any non-owning ref not obtained under that
lock must have been invalidated previously. 

This will keep bpf_reg_state size down. Will give it a shot for v3,
wanted to leave it in current state for v2 so logic in this patch
is easier to reason about.

Actually, if above logic is correct, then only valid states for
non_owning_ref_lock are "empty / null" and "same as current verifier_state",
in which case this can go back to being a bool. But for non-spin_unlock
invalidation points (e.g. rbtree_remove), we may want to keep additional
info around to avoid invalidating everything, which would require
re-introducing a non_owning_ref identity.

>  		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> @@ -223,11 +240,6 @@ struct bpf_reference_state {
>  	 * exiting a callback function.
>  	 */
>  	int callback_ref;
> -	/* Mark the reference state to release the registers sharing the same id
> -	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
> -	 * safe to access inside the critical section).
> -	 */
> -	bool release_on_unlock;
>  };
>  
>  /* state of the program:
> @@ -328,21 +340,8 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	/* For every reg representing a map value or allocated object pointer,
> -	 * we consider the tuple of (ptr, id) for them to be unique in verifier
> -	 * context and conside them to not alias each other for the purposes of
> -	 * tracking lock state.
> -	 */
> -	struct {
> -		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
> -		 * there's no active lock held, and other fields have no
> -		 * meaning. If non-NULL, it indicates that a lock is held and
> -		 * id member has the reg->id of the register which can be >= 0.
> -		 */
> -		void *ptr;
> -		/* This will be reg->id */
> -		u32 id;
> -	} active_lock;
> +
> +	struct bpf_active_lock active_lock;
>  	bool speculative;
>  	bool active_rcu_lock;

[...]
