Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7B621D5E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKHUDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 15:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKHUDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 15:03:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221B25D0
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 12:03:25 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8JRPVL005797;
        Tue, 8 Nov 2022 12:03:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3Pd8j7SZp1cJfUp37ynoBpDYXuu+kInVZz0H/zjXE3A=;
 b=FNeLVJql0ISl1f27dEgMITyDrvHBjjkRcMa8MA+NsNCwfQq2xbWDy8EeZSVe4iPs3vt+
 icZCRF/AD9lAQK8Pa5ubvl8IDIKCNyBWge5SPB4TrnnKhdU/vVnur1n1HZbFkM+1BVWy
 /UsT1l4stVUrzavy7Lt7DqQVPLRbSF3aEyiLVoS1KOD0dx4MUX2mUY9sixat8uxDlSnI
 B/TbfILx8+DTlMBKaJPaLp839AEqFZ4NYLl48f7gOWsIFPG7f2jMpiVwTDeaYCtwN1L+
 tj5aZDSG0WOmUfJGr9N9D9gm7SqpnaAYbve816aNAnh0sh03HPUEkRRWvMbpXr9D7m8Z mg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kqcc5rapg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 12:03:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfH456djw8oFhdccF9IgKxPpQPKq2NTbsoV1eCOQD7twPd8waNVVaV7MDiYqGuxddz+9YYMmg1zpvMWsGyMsjAXroKRQIjhqVG9rFEfKVIHBDaLs9e6Cqg36DklkIH+oJtm5XckRGNSkuxOkidp8/dT0BugoHGZFvF3a1Bpg4EvW4yWc38Vf/i1l6ZrWGK1ddLmS6pqkp6cuviusBp6nnxyUDEFv9rfOXpxZIUEt9fg1mPsnUHw1pEc1x86sCdUKzUnf9GjVrFM2krOMHMeLiyTmDLgBaUMTHvKIAPST2PQLwx976Gnu91AEelwEiIHMzqYZhUqP8AgXgSikS5XF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pd8j7SZp1cJfUp37ynoBpDYXuu+kInVZz0H/zjXE3A=;
 b=CYcQ0XNi7vgH7O59Dm54xtrqiyhm/3NWlrBxfHDNa5DprRPwPfeRrfc5hWwtZqKzJrDVr0b1dtSLtSVXFUX0iwVJcY3SpUall3zrr9/6wCy0lWnF+KOlcL44v8VtVpPilRVFLdEmC4wTMnFgXvmw7sYXdT+3cnhE2CypnZZJtJwXxFmQwoebzIHBgtPHONAPZqZlsL2t0f573PI5w+w0bxPX/5hBkD0cY/sJE4VZlMDS2MEAs8SRD5NHRpTTVsTI3wfRtoI2gQSxuo6FuvsVCLQNPPhvIwQRNUU/9svS4811+8csQnwt4ijSIgKUabboA0DnYsyIebSqP5/gXkSG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2334.namprd15.prod.outlook.com (2603:10b6:805:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 20:03:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 20:03:06 +0000
Message-ID: <04ed904e-a901-70ea-ddb6-a87aa5bd2736@meta.com>
Date:   Tue, 8 Nov 2022 12:03:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 5/8] bpf: Add bpf_rcu_read_lock() verifier
 support
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074114.264485-1-yhs@fb.com> <20221108170452.jq24rymkfeozxtwj@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108170452.jq24rymkfeozxtwj@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB2334:EE_
X-MS-Office365-Filtering-Correlation-Id: 126574f9-8a1d-43cd-680b-08dac1c4401f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mHPZusv4PHDs6XhVux99ym8eQyKcyYKN/Yhch5Ycv6FK2L1VlCrL3Xp/s4GKLM76EiB4dKrBEZI0Cv4pB5fZX+dzIi7NwL2yfcBcCaAQMf61GuObmb2F+5vJNlx2vKN/2wyaZadYpDxoGKY98MwbxW1a1hUBVXNyb3lzwFUsDmCOtnUy5oIBaUOSNx2P0biHzzO6vHpplC7z8QjnalpLUD+G0e0WKUySiRQiJ/E0oPKTi5PdnOGx17PLSqOIwyXTlIaUKw/zNbAc7I7/5M/bR1qikJZ+dDwhVBxay93YwJpUfx739Ih6v+/xRLCY24PREcKmxB9cAdxdyPbnVzSG5u6ASJg1/iRkt5X2yXMK05RP+l6HTzEzIE2Wfrz4JasYnrnE6xH981AugvE0FClDAM4cSapPRSwF/ugEjI9V8NsCJ9vIRm0jFQ0wnWWssALvHQhmsGLJY02+3ACe4R26XkElr4KSxYyHwQPNSwrSobk7WgvBL7/Dwm7T6kVNXX6o/6Y9jlY/8HaRXdAHKcymjou++RdPeF6ONMt1vAVFebQnkNwG3j9Ar7bSNZuwjGDewGfkjlSsXlmDt12DraiUTN4SC32C3GnMCTjUAxny9Yl8fJY1cd7QM63cvrKehWryWnidWoKjvtRZFsZ+NZYYmLdFCEOOykzw8ezzI6sVcCUe1xQr/44s8v+v1vrhL1lR7tLumGvYtBmM5bDqumJKdAa20n5i52x7FUKTpsBCQAkAf4R5EEbsakkblDdzgdZYY0NWI0aVLmER6LgnkEf2FWsjbvbz5j5uSlB7WCzgds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(38100700002)(2906002)(4326008)(8936002)(8676002)(31696002)(86362001)(6506007)(2616005)(186003)(6512007)(53546011)(110136005)(316002)(54906003)(66946007)(6486002)(478600001)(66556008)(5660300002)(66476007)(41300700001)(31686004)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHErUXJ1YjJpYXhybkIydEE0dDlZVjcwT1BKdUFKVys4WjdNano5ejcxYXRO?=
 =?utf-8?B?aGlYTHV3NnRTWWs2SnlIR0FwSTdSVmtWUDJwTTdzRmRUSTlpTXJvUkR4ZTQ1?=
 =?utf-8?B?WS9tVGMzU01TU3NtS3Y3dms5cHdjWUIxZHh6OVpPZlBQRUdZMFp1VEFFcjRG?=
 =?utf-8?B?VFM1UlBtTnBMckREZWYvS0xtRTJPeDBRUnh5L3A1cFZkM21pOERFT3gxSFkw?=
 =?utf-8?B?VC8wNHNOaWpRWi9LUXlZRHZqZkIzTFB2RUJ4cUFCSXhXQXV4NXk1dGwvb1hr?=
 =?utf-8?B?UGhhOXhreDFaWmxsZVFMSGRZdzRMNTUzWTNiYlhTaWd0d3c5eFBpNDhVNUln?=
 =?utf-8?B?RnIzK1BDU0RqcERwNGI0VXI4T1kzT2JPMHFZN2R6bW1VWWlaZWJPWGc1NzJl?=
 =?utf-8?B?azQ2Rzc4Z2Fwc1JUVjQ4YU8xbVl1YzQ4enRuZHFKbGFrT3h3bFBxNzZDRTBU?=
 =?utf-8?B?NkdkczVMdG0vVHJtMks3c3FrQ1dadlRwMi9CRmlxSVZscVJrTitmVGRwTENM?=
 =?utf-8?B?cFpZQ3ZnSjFsY2IrWlZDYW05anc5ZVFuaEFvU1V4Y3ErTysydk91WEtFb3RX?=
 =?utf-8?B?Ulp0TmVmRHFNVXJLVkkwc0F1cEI5NFNRbUttNEZrcGxRaG5ITUNoZ3V2WnVV?=
 =?utf-8?B?WVRPV1hxMWoyOHZlbG1sSkZiV1Y2QXJmRStHbS9QZDZ1MjFrVjY3U3Z5Yk4x?=
 =?utf-8?B?ejc0VU1iLzBpT1NuZzFhaWhrNWFadC9VL1VySHF3dHJJV3FSUzg2bjVaUnFK?=
 =?utf-8?B?TkdNYzdoUm5qS2Q3M25KdTY3Y1MzSWl6eUZyZ2poUE91MG8zTHFvcTBDbEgx?=
 =?utf-8?B?VFZMZVZIRjBQR0RDUlEra1NwYXRpSzFrcjVzRGtOdTVDZktJQlFnVCswYnB5?=
 =?utf-8?B?YUZEOStjSGhIRHBHeGs2ZkU1WUlzdUZ2QU95VWJ2MEpzTE1jdzd0WWt0QWhW?=
 =?utf-8?B?czl6c1dFRmpVcmpBTXcwNzRqRW93RVk5MXJhYnkwS1Z0aFVZcmFsbEdjbmkw?=
 =?utf-8?B?MEtKaGVYTGF3N2o3c09OdGdLS25LRE9rMkNFb3hMNGE0Z1ZtWGtWMW1WRmZn?=
 =?utf-8?B?ckt4ZU9BNDFyZFRiRWVqL29BeEhUTEVxeGRkOE9LM2lwMXl3ZEE1VDJEdXVN?=
 =?utf-8?B?ckZmcEFCL2ZnaGpiRFhHdWpsbWdiZ2xUUTRzSXN3Y2x3VXByeS9NNzNqbjBy?=
 =?utf-8?B?YzNFK1F5WC9vRy9hZDYvakVBdzFERlBuTzhMTTZZMkZySEdYdnJXMVdNRmN1?=
 =?utf-8?B?S0p3SzcxaE8vT240c0dWc3hEbVZPOUZMNkVFV2NpakZUV2xUYzNPTGgrdW8w?=
 =?utf-8?B?cWpmcTJleUZITEtsQlFpdzBRcjlJalU1N0FXUmFmM2p5N2hDeW9TbkJmNER3?=
 =?utf-8?B?MDRDYU9jRlJJbmJoZE44UXRDbWx6MCtVMG5MUHFIakJlQmRMNkRXQmxGbnlO?=
 =?utf-8?B?SCt0TFc1VG1oZytUOWxCUmVGUzhCSTJCZXB6cUJJL081Y25tT3lOY21lN2hQ?=
 =?utf-8?B?NTJPSG5JSUpUYVY1UGZSTGltUC9BV2YxV2o1V3h6R0FHOEYzd0xsbzBFQXhl?=
 =?utf-8?B?QXlIUHRSRkRwRUVtZGpyNmk3MzdwbTVSZFVoL1RvL3U5cXU5KzhBVGNadGZO?=
 =?utf-8?B?MTRzd0I0bjBEa0NSb3VObWJCTDVBcUFmL1pBOXdXdnBIQjc0bDlsbXIzTWg2?=
 =?utf-8?B?WjY4ak90ZFowS0ZvdFRzS0llOUVyM095NXRXQzd5bEhKdjZoSUljSmswNnkw?=
 =?utf-8?B?WXdnVUJsYS9NK0h4R0t3dFJTOGdGR1BKdmNzenFvZnpmRG51bzBnR2VOUzBr?=
 =?utf-8?B?TkpZTHB2RncyRWx4TVpZYjBjM2V1Y1lDMThleXlSSUtkZGNuc0ZuNS9GYWxS?=
 =?utf-8?B?MzI2TTZsdTRUbUtEcS8xeTI4ZjNrM0xoWVMzd1FQeWloalduWnRrbzNkbkhK?=
 =?utf-8?B?KzJQRWdaUEh1aVhBT1hMcFBDQy8wdVdiUlRlZDBSYXJ0Zzg3NHF2ZG1BSUVo?=
 =?utf-8?B?aW9TUkJVeFZLb3FsU2lhcDBlSFNzaTJ3SUZvb0U5aFZPblJta0FjUU9lUVVi?=
 =?utf-8?B?ajBadHZqY1pRWTZlOEJhSVh5bjBMaHFPcUxPVzd2LzlvTFBLSnI1cmNvc1o5?=
 =?utf-8?B?WHo0RG81VVRPRlY3dm5jSlB0czJvdk04UDJNNWQ5Z281cTBJdFJSaHBEaUlx?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126574f9-8a1d-43cd-680b-08dac1c4401f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 20:03:06.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pHTJKY52GUW42kfkEWaB/Ni5nEDGKzSm3C7lubqQ1snOMx9vGvG67OBu4lGxcuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2334
X-Proofpoint-ORIG-GUID: T1k4H0K3NWE6db0x55Ciqo_bd7eFLJkg
X-Proofpoint-GUID: T1k4H0K3NWE6db0x55Ciqo_bd7eFLJkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 9:04 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, Nov 08, 2022 at 01:11:14PM IST, Yonghong Song wrote:
>> To simplify the design and support the common practice, no
>> nested bpf_rcu_read_lock() is allowed. During verification,
>> each paired bpf_rcu_read_lock()/unlock() has a unique
>> region id, starting from 1. Each rcu ptr register also
>> remembers the region id when the ptr reg is initialized.
>> The following is a simple example to illustrate the
>> rcu lock regions and usage of rcu ptr's.
>>
>>       ...                    <=== rcu lock region 0
>>       bpf_rcu_read_lock()    <=== rcu lock region 1
>>       rcu_ptr1 = ...         <=== rcu_ptr1 with region 1
>>       ... using rcu_ptr1 ...
>>       bpf_rcu_read_unlock()
>>       ...                    <=== rcu lock region -1
>>       bpf_rcu_read_lock()    <=== rcu lock region 2
>>       rcu_ptr2 = ...         <=== rcu_ptr2 with region 2
>>       ... using rcu_ptr2 ...
>>       ... using rcu_ptr1 ... <=== wrong, region 1 rcu_ptr in region 2
>>       bpf_rcu_read_unlock()
>>
>> Outside the rcu lock region, the rcu lock region id is 0 or negative of
>> previous valid rcu lock region id, so the next valid rcu lock region
>> id can be easily computed.
>>
>> Note that rcu protection is not needed for non-sleepable program. But
>> it is supported to make cross-sleepable/nonsleepable development easier.
>> For non-sleepable program, the following insns can be inside the rcu
>> lock region:
>>    - any non call insns except BPF_ABS/BPF_IND
>>    - non sleepable helpers or kfuncs
>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
>> allocation flag) should be GFP_ATOMIC.
>>
>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
>> this pointer and the load which gets this pointer needs to be
>> protected by bpf_rcu_read_lock(). The following shows a couple
>> of examples:
>>    struct task_struct {
>>          ...
>>          struct task_struct __rcu        *real_parent;
>>          struct css_set __rcu            *cgroups;
>>          ...
>>    };
>>    struct css_set {
>>          ...
>>          struct cgroup *dfl_cgrp;
>>          ...
>>    }
>>    ...
>>    task = bpf_get_current_task_btf();
>>    cgroups = task->cgroups;
>>    dfl_cgroup = cgroups->dfl_cgrp;
>>    ... using dfl_cgroup ...
>>
>> The bpf_rcu_read_lock/unlock() should be added like below to
>> avoid verification failures.
>>    task = bpf_get_current_task_btf();
>>    bpf_rcu_read_lock();
>>    cgroups = task->cgroups;
>>    dfl_cgroup = cgroups->dfl_cgrp;
>>    bpf_rcu_read_unlock();
>>    ... using dfl_cgroup ...
>>
>> The following is another example for task->real_parent.
>>    task = bpf_get_current_task_btf();
>>    bpf_rcu_read_lock();
>>    real_parent = task->real_parent;
>>    ... bpf_task_storage_get(&map, real_parent, 0, 0);
>>    bpf_rcu_read_unlock();
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h          |  1 +
>>   include/linux/bpf_verifier.h |  7 +++
>>   kernel/bpf/btf.c             | 32 ++++++++++++-
>>   kernel/bpf/verifier.c        | 92 +++++++++++++++++++++++++++++++-----
>>   4 files changed, 120 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index b4bbcafd1c9b..98af0c9ec721 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -761,6 +761,7 @@ struct bpf_prog_ops {
>>   struct btf_struct_access_info {
>>   	u32 next_btf_id;
>>   	enum bpf_type_flag flag;
>> +	bool is_rcu;
>>   };
>>
>>   struct bpf_verifier_ops {
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 1a32baa78ce2..5d703637bb12 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -179,6 +179,10 @@ struct bpf_reg_state {
>>   	 */
>>   	s32 subreg_def;
>>   	enum bpf_reg_liveness live;
>> +	/* 0: not rcu ptr; > 0: rcu ptr, id of the rcu read lock region where
>> +	 * the rcu ptr reg is initialized.
>> +	 */
>> +	int active_rcu_lock;
>>   	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>>   	bool precise;
>>   };
>> @@ -324,6 +328,8 @@ struct bpf_verifier_state {
>>   	u32 insn_idx;
>>   	u32 curframe;
>>   	u32 active_spin_lock;
>> +	/* <= 0: not in rcu read lock region; > 0: the rcu lock region id */
>> +	int active_rcu_lock;
>>   	bool speculative;
>>
>>   	/* first and last insn idx of this verifier state */
>> @@ -424,6 +430,7 @@ struct bpf_insn_aux_data {
>>   	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>>   	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>>   	bool zext_dst; /* this insn zero extends dst reg */
>> +	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
>>   	u8 alu_state; /* used in combination with alu_limit */
>>
>>   	/* below fields are initialized once */
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index d2ee1669a2f3..c5a9569f2ae0 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5831,6 +5831,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>   		if (btf_type_is_ptr(mtype)) {
>>   			const struct btf_type *stype, *t;
>>   			enum bpf_type_flag tmp_flag = 0;
>> +			bool is_rcu = false;
>>   			u32 id;
>>
>>   			if (msize != size || off != moff) {
>> @@ -5850,12 +5851,16 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>   				/* check __percpu tag */
>>   				if (strcmp(tag_value, "percpu") == 0)
>>   					tmp_flag = MEM_PERCPU;
>> +				/* check __rcu tag */
>> +				if (strcmp(tag_value, "rcu") == 0)
>> +					is_rcu = true;
>>   			}
>>
>>   			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
>>   			if (btf_type_is_struct(stype)) {
>>   				info->next_btf_id = id;
>>   				info->flag = tmp_flag;
>> +				info->is_rcu = is_rcu;
>>   				return WALK_PTR;
>>   			}
>>   		}
>> @@ -6317,7 +6322,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>>   {
>>   	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>   	bool rel = false, kptr_get = false, trusted_args = false;
>> -	bool sleepable = false;
>> +	bool sleepable = false, rcu_lock = false, rcu_unlock = false;
>>   	struct bpf_verifier_log *log = &env->log;
>>   	u32 i, nargs, ref_id, ref_obj_id = 0;
>>   	bool is_kfunc = btf_is_kernel(btf);
>> @@ -6356,6 +6361,31 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>>   		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
>>   		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
>>   		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
>> +		rcu_lock = kfunc_meta->flags & KF_RCU_LOCK;
>> +		rcu_unlock = kfunc_meta->flags & KF_RCU_UNLOCK;
>> +	}
>> +
>> +	/* checking rcu read lock/unlock */
>> +	if (env->cur_state->active_rcu_lock > 0) {
>> +		if (rcu_lock) {
>> +			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name);
>> +			return -EINVAL;
>> +		} else if (rcu_unlock) {
>> +			/* change active_rcu_lock to its corresponding negative value to
>> +			 * preserve the previous lock region id.
>> +			 */
>> +			env->cur_state->active_rcu_lock = -env->cur_state->active_rcu_lock;
>> +		} else if (sleepable) {
>> +			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region\n",
>> +				func_name);
>> +			return -EINVAL;
>> +		}
>> +	} else if (rcu_lock) {
>> +		/* a new lock region started, increase the region id. */
>> +		env->cur_state->active_rcu_lock = (-env->cur_state->active_rcu_lock) + 1;
>> +	} else if (rcu_unlock) {
>> +		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_name);
>> +		return -EINVAL;
>>   	}
>>
> 
> Can you provide more context on why having ids is better than simply
> invalidating the registers when the section ends, and making active_rcu_lock a
> boolean instead? You can use bpf_for_each_reg_in_vstate to find every reg having
> MEM_RCU and mark it unknown.

I think we also need to invalidate rcu-ptr related states as well in spills.

I also tried to support cases like:
	bpf_rcu_read_lock();
	rcu_ptr = ...
	   ... rcu_ptr ...
	bpf_rcu_read_unlock();
	... rcu_ptr ... /* no load, just use the rcu_ptr somehow */

In the above case, outside the rcu read lock region, there is no
load with rcu_ptr but it can still be used for other purposes
with a property of a pointer.

But for a second thought, it should be okay to invalidate
rcu_ptr during bpf_rcu_read_unlock() as a scalar. This should
satisfy almost all (if not all) cases.

> 
> You won't have to match the id in btf_struct_access as such registers won't ever
> reach that function (if marked unknown on invalidation, they become scalars).
> The reg state won't need another active_rcu_lock member either, it is simply
> part of reg->type.

Right, if I don't maintain region id's, no need to have 
reg->active_rcu_lock and using MEM_RCU should be enough.

> 
> It seems to that simply invalidating registers when rcu_read_unlock is called is
> both less code to write and simpler to understand.

invalidating rcu_ptr in registers and spills.

Let me try to implement this and compare to my current approach. I guess
MEM_RCU + invalidation at bpf_rcu_read_unlock() should be simpler as you
suggested.

> 
> Having ids also makes the pruning algorithm unecessarily conservative.
> Later in states_equal, the check is:
> 
>> +	if (old->active_rcu_lock != cur->active_rcu_lock)
>> +		return false;
> 
> which means even though the current state just holding the RCU read lock would
> be enough to prune search, it would be rejected now due to distinct IDs (e.g. if
> the current path didn't make exactly the same number of rcu_read_lock calls
> compared to the old state).

That is true. We should also check old/new verifier state. If both
verifier state are not in rcu read lock region. The above check can
be ignored. But agree this becomes a little bit more complicated.
