Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8B52B470
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiERIJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiERIJy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 04:09:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151F377E6
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 01:09:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKFDEX031997;
        Wed, 18 May 2022 01:07:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lluMADym5nNWSHtuHZYIMFsH2Bj4/QvlMJBKcZJgLYo=;
 b=pE8JtJMOURCVLvAZFBsF2oz4AKmXgGqn8qHl9b6lw05ULmUg3aPZFgMjT1Q36o5p55Ui
 O5q+JeA/tiuPPLy0TJGqk4cSkZbNcybUgA781qeSrceKAfQFRftCwqN4UgvDx7hV3t2P
 nWn3X6ln7sX9FyqtAMm4jgmrrU4oVqDu9qM= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ck0ee1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 01:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBPCnv1Z02HXB4w+c6h+fuHrNO7lEzULF9BdmFezKdwZLaYczXBxRvb8oYJI1/0r968iwMp3w5YYJl/UU//OVjSDy1RlMJDTZL1Yzi0B2Jx6SmoAam35Ik5gqkiJf/nM/Cmcg8lx7puU7Rpa6BkX8wECZE0JjYKKKQMre5XfUSAuPNbSWdHXgpgg+nl/Q3Z6UGw1ef16rCaRhbdv6xC9WktmW7EQjaaBSNdI+C4RCD+XmuNzBASg+5rnj2YmqO1e1JPrekTa/z34r8PVsY4CFsBRL6mXmeZkgo/5Baky5Hu8TFGyVUhxkv1oe485iGTYVkyomttQgfTd8q9IIaaHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lluMADym5nNWSHtuHZYIMFsH2Bj4/QvlMJBKcZJgLYo=;
 b=CRYwFHw2le15mqCstaLjNHIfruy8lMtvdIuP53+DM6dT0d5LAJXLlC+l+Rym6Kvd5qy8FFzIyHdo5EbZaCt79H143azNCEtDXsLXcdnIpkLmTCZl5n2F/42IO9KQIsxh6KDKLA8Q/ebl4vrgYGOlpEMPGeG/9hdpxKDhbLq1k4Zs1At8m5xu/5tFPlY5IbuaB01MHJTd/TJ2cDNTyxoCg0/VzQDoG+Bqw0OeKzhNslEJg28Z1vHBwcoJcvO6r4ef6Jzsxa6KIY46VKRQqNSs0vjGXcp/1irl//wFf2v8AKiW0jFIAfY9wwpm54Gp719pEHQb0YReUxRR+IhLZfbj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB3088.namprd15.prod.outlook.com (2603:10b6:208:f5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 08:07:23 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%8]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 08:07:23 +0000
Message-ID: <86619b8e-05b7-82a5-9f9f-144e41d3b91a@fb.com>
Date:   Wed, 18 May 2022 04:07:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [RFC PATCH bpf-next 2/5] bpf: add get_reg_val helper
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-3-davemarchevsky@fb.com>
 <20220512152938.hfm64odsrrqlvfiy@dev0025.ash9.facebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220512152938.hfm64odsrrqlvfiy@dev0025.ash9.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0003.prod.exchangelabs.com
 (2603:10b6:207:18::16) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6a8d755-728d-4382-730d-08da38a5705f
X-MS-TrafficTypeDiagnostic: MN2PR15MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3088F58AB2A2786FA3C6315FA0D19@MN2PR15MB3088.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tlvb4F2cvj84MdSWW/mqOSi93dLAj/Ea5RmwEGIXrxCpLfd6IrUEHP1QR9yjwllJXVS57SdbZUA8V0qDxuAfRcX+v3530nh+NsSLMStI6DTlgTqTry/dZBPfU2J7PITJcieSLEjijZ5gqNhbOP0lZT0Be7Hht28ziPzMyQDtDFZB/m90n4DdWssKPUa3tRFH8LCTWanJIGGan0nSgDtIzj3HNXxZx5aP4/pzUsVIdMYkyYk6rApKe3NTjwq27TW8wIPxLrfv5uk3S1ntlqNfqwn5/tQUt3kBaDyN99eklE462byH8C92r9KEIjtALNzukCoWaXhSKGjaRvDNAMRxEAwSvgYbhvUpHrgt+Vf1Q6YcR8DvpI9d3nCi5RI//7fi3P3q44YRo0a3HpIY+nIdf3qSYA2CtiinJCoYA37KIvtCKqAhz9VsYzOpmNegfZ/8qPABGN7Kd76NcNcvMqQxg3qZICh64K0BYbJpctFtv1NM6gS7T2F1nJZEk67fNFc1NsZrRk9kimBniVNb4wf9uTUp+l42hy/WRmA3ypo7cLlqLj+cTvbAJowFuS7aa9hrA2zNMe55Vmvivlp1rQhme6gQLfzW4v4CTJSrWrd1uLhonKuIe8bKHbxegWOw4I2rJ5kfRRUyJgYlkudrgSPDl5/wbwYfayFvEharSy99octogU3PaBRSS3awXPz+hXDuZPLAPYMptpNR1FpA9gF94FBsIpJz9eyE8lNwFyAyd6Df8uc/yRVkuNjny++Fxd9i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(31696002)(54906003)(5660300002)(6916009)(8676002)(4326008)(30864003)(66556008)(66476007)(508600001)(186003)(66946007)(2616005)(316002)(8936002)(6486002)(38100700002)(53546011)(36756003)(31686004)(2906002)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVFL0x5bzRxdW5sN0dWUTh5T2tKWUxIdnRkS0J4TGphUlQwd05VMnRvS2tZ?=
 =?utf-8?B?eFA0Y1dlL0JiNk5VZWQvUXc1c2E4WlZhYi9yc0pXRjB5aFZwdUZXUTI4Nlph?=
 =?utf-8?B?aUg4Sk1VZzQzRWcxUUdHQ1I1MWZacXZNRjk3VGNVQksvYTZKOExoL1QwMXFI?=
 =?utf-8?B?OGI5RUdwam8rZGJYMDB6NzNKeXBtRjJkWUlpR3JOek13a2VJMjBEeC9CLzVL?=
 =?utf-8?B?eHJDN2JkNUd4VWtYS256K2FPN3JMUzhBSjJWM1N4Y2xVQXp1MUJDeUZlaEh0?=
 =?utf-8?B?a1I2OXo0bTB4MTZEeEVjVmdJVlpVSHVoaW1jQkRnc21wb0F3U3VPTGU1NjBo?=
 =?utf-8?B?Mms1S3pRZzRSTEJKMnVDRkRPZ0NDSlZzN2R3b2tPdUNyayszU2dUSEZoQkdu?=
 =?utf-8?B?em9XdC96bUw0Z2NobHJvT2I2MjdPUzRqa2dFSytteXZBNDNSZnh1SWFleC9F?=
 =?utf-8?B?b212MkFlNXRaeTNkU0ZkY0h1ZCtMblJJTW42bVhjVjRybTU2UWUwY0NySkV0?=
 =?utf-8?B?aU5RcUR4Z3QxMlZYTnV0cTRoOTliUVBpNFQ4d3BMcVYyY0srS2ZvUVpsUUdr?=
 =?utf-8?B?dmhZS3kyTkE5OWgyNXZYMkhWYkIrbzN5SnVmQUY2eml1ZUlxQ0gxN2EyM0ty?=
 =?utf-8?B?ekdXMy92TlA3KzV4QTN6V2VEWEJDWEZ3amtSdlRUOGNLbHBSY0RURVdnY2tZ?=
 =?utf-8?B?MWxPOGRaOUJCak4yS3YxcDd0ZEd3YXlJKzJpSUxMRVhMSVpvN3VxOWlTWi9j?=
 =?utf-8?B?R1NYWkIzN1ZrTkdQL0E0QkZ4QklyRUZxVElMTFBiNnlCNmNnYUU2My9iU3VR?=
 =?utf-8?B?eXlIcWpUSmtvZHhGMlliMUpoUTdWdm5JTUp3QjQvU1BXbjRUZDJnbkNEYnBF?=
 =?utf-8?B?Z055ZUc1RmVJWksxUnZGS015WmFmc0JMWGdBRTJYTGZKVkIyNGxHd0k0N1k5?=
 =?utf-8?B?bStmdkRmcDh0cEZOL1pocFA4QTlrRTVCdnlrbUhuN1lMYnVBRmViUXFLTW1h?=
 =?utf-8?B?bUZIbTV4a000UXh5WjFtKzBrdm51QnNHSzVVT1RqTVZYb2NIZnZ6SDVrNkh5?=
 =?utf-8?B?VjljcGtJR01ib1hIeTM4UXVWVVkybXpycmJGQTQ1VUwzd05UZk8raWJpSWJG?=
 =?utf-8?B?QzlPOTJEMkJYcGhwQUxMc0d0SU9NU0NLdVdKUXExbzVWcis2SzNsd283WXVl?=
 =?utf-8?B?ellBUFBKdjJjQWY5bi9iNmNJTWg5YWpqbzk2TTdvTEZWU0xyYk5oUWVaS2tj?=
 =?utf-8?B?aGVFOGF4dkcvSnpDK1JjUmowUDJQcnQ3UWZabUx0RFFlR1lWckx1bkJpczVC?=
 =?utf-8?B?Y2FxZExiSVNLWHNqbVJ4aWxydnFCTkd5MzdYNGE5UnFlZ3pYeTNXbENXSHla?=
 =?utf-8?B?SUtkYmVGOUhGUXpWWGxQTHQ5WWx5MVdFRFZHRmhyRFhiSHFGdXkydUdXTG41?=
 =?utf-8?B?YU9NaGY3eHVpNG5mTlR4VzYvTzYxb1FCNGZrdW05Z1Q4TjR0cUpnRWVHT0dm?=
 =?utf-8?B?eDNhamFjdjM2dkphN2FrSHNzeVBQOExGUXRHUXA0VkJ2RTR5cW5CTTV4ZDVZ?=
 =?utf-8?B?MzJBMFE5blNHRXpyd0p1NUNPdW9JZVlEVm9YN2JPVThRWDEwYVJuU1RjOExt?=
 =?utf-8?B?VUtBWGdXZy9acWIyRi9nSzRrcGN5dHRmaE9WOCtOUTJjT2hFU1ExN1g5RjJG?=
 =?utf-8?B?eXVsR2pqTDArczFtM2V6aGo2RkQ1ODFNVnJ5Y28zYUo4S05ua1g1TDc5TlRD?=
 =?utf-8?B?dzlHODVHTTljTDVMaGhGSjlNblUyRFJKSmIwZk8zU1VYdlE3cm1BcFFCSlQy?=
 =?utf-8?B?OWNVMU5lVUpXblA0ejdSTHNQMGxqb1dsYWZtcXIrSzhwSCtMSE1oRnRpaUdz?=
 =?utf-8?B?QXRIdjdhRnovNmJOUjdoMEVJVEhwMHJITEk0SW5lVTgybTkyenhWY1YwazF0?=
 =?utf-8?B?dG1yeGhUelNIUFhsNTJIMXZLWHViSVAvQUdJbk5GV1BuTG5DbWlPUFhVbXlG?=
 =?utf-8?B?V2NjNXpLWW41cmVMTUZpbndzeUNIcUlHWXUrSVlFWE9iS0Uwa1htYXpPdU4z?=
 =?utf-8?B?TWp5RkpkRGx1enVtU1hZWEJKRmhMM1pCTUU4d050ZGxsMlFZbzNURVRCRXBF?=
 =?utf-8?B?VDRWWndpendwUUwyVXZPS0hZdEc1bWUzYWg4dmQ4d2IyRytuNzZ5VTF3YUdh?=
 =?utf-8?B?YUgyR3JCcmxaNWpZVTdZZkg4TDNSeXhCL0VpQ09XMGY3YjJFUEQ5U0t6bG4w?=
 =?utf-8?B?UDAxZG5ZWjJ0ZnNHN2RUbHUrQ2F1MEtYWjh4a3RYR0xtNUE3KzhkSDArZmgv?=
 =?utf-8?B?SUM1NlNZalQwZW9WdnlTa0JLQWdDM3FZa0kzcThhdDYveko0bzc5MzAxeGZp?=
 =?utf-8?Q?1xq9Vi/btFDvZWfwkiN4caY2yD5bthZFA3+Om?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a8d755-728d-4382-730d-08da38a5705f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:07:23.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4Ch7W3psBsEMRH7KEdh/T+F9JJA6D3JqTFRqXpB4etdIPA9QYGs/eOXA9dDIn5tnJeMvorq+TCKp2LqJZGg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3088
X-Proofpoint-GUID: O9oG7XDdjF2IzJ-suMXmW35yFkd7MQQI
X-Proofpoint-ORIG-GUID: O9oG7XDdjF2IzJ-suMXmW35yFkd7MQQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/12/22 11:29 AM, David Vernet wrote:   
> On Thu, May 12, 2022 at 12:43:18AM -0700, Dave Marchevsky wrote:
>> Add a helper which reads the value of specified register into memory.
>>
>> Currently, bpf programs only have access to general-purpose registers
>> via struct pt_regs. Other registers, like SSE regs %xmm0-15, are
>> inaccessible, which makes some tracing usecases impossible. For example,
>> User Statically-Defined Tracing (USDT) probes may use SSE registers to
>> pass their arguments on x86. While this patch adds support for %xmm0-15
>> only, the helper is meant to be generic enough to support fetching any
>> reg.
>>
>> A useful "value of register" definition for bpf programs is "value of
>> register before control transfer to kernel". pt_regs gives us this
>> currently, so it's the default behavior of the new helper. Fetching the
>> actual _current_ reg value is possible, though, by passing
>> BPF_GETREG_F_CURRENT flag as part of input.
>>
>> For SSE regs we try to avoid digging around in task's fpu state by first
>> reading _current_ value, then checking to see if the state of cpu's
>> floating point regs matches task's view of them. If so, we can just
>> return _current_ value.
>>
>> Further usecases which are straightforward to support, but
>> unimplemented:
>>   * using the helper to fetch general-purpose register value.
>>   currently-unused pt_regs parameter exists for this reason.
>>
>>   * fetching rdtsc (w/ BPF_GETREG_F_CURRENT)
>>
>>   * other architectures. s390 specifically might benefit from similar
>>   fpu reg fetching as USDT library was recently updated to support that
>>   architecture.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  include/uapi/linux/bpf.h       |  40 +++++++++
>>  kernel/trace/bpf_trace.c       | 148 +++++++++++++++++++++++++++++++++
>>  kernel/trace/bpf_trace.h       |   1 +
>>  tools/include/uapi/linux/bpf.h |  40 +++++++++
>>  4 files changed, 229 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 444fe6f1cf35..3ef8f683ed9e 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5154,6 +5154,18 @@ union bpf_attr {
>>   *		if not NULL, is a reference which must be released using its
>>   *		corresponding release function, or moved into a BPF map before
>>   *		program exit.
>> + *
>> + * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_regs *regs, struct task_struct *tsk)
>> + *	Description
>> + *		Store the value of a SSE register specified by *getreg_spec*
> 
> Even though this patch only adds support for SSE, if the helper is meant to
> be generic enough to support fetching any register, should the description
> be updated to not imply that it's only meant for fetching SSE? IMO the
> example below is sufficient to indicate that it can be used to fetch SSE
> regs.

Relic from a less-general initial pass. Will update.

> 
>> + *		into memory region of size *size* specified by *dst*. *getreg_spec*
>> + *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
>> + *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
>> + *	Return
>> + *		0 on success
>> + *		**-ENOENT** if the system architecture does not have requested reg
>> + *		**-EINVAL** if *getreg_spec* is invalid
>> + *		**-EINVAL** if *size* != bytes necessary to store requested reg val
>>   */
>>  #define __BPF_FUNC_MAPPER(FN)		\
>>  	FN(unspec),			\
>> @@ -5351,6 +5363,7 @@ union bpf_attr {
>>  	FN(skb_set_tstamp),		\
>>  	FN(ima_file_hash),		\
>>  	FN(kptr_xchg),			\
>> +	FN(get_reg_val),		\
>>  	/* */
>>  
>>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> @@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
>>  	__u64 running;
>>  };
>>  
>> +/* bpf_get_reg_val register enum */
>> +enum {
>> +	BPF_GETREG_X86_XMM0 = 0,
> 
> I know we do this in a few places in bpf.h, so please feel free to ignore
> this, but the C standard (section 6.7.2.2.1) formally states that if no
> value is specified for the first enumerator that its value is 0, so
> specifying the value here is strictly unnecessary. We're inconsistent in
> how we apply this in bpf.h, but IMHO if we're adding new enums, we should
> do the "standard" thing and only define the first element if it's nonzero.
> 

I don't feel strongly about it. I'd say "explicit is better than implicit", but
that doesn't apply here unless the specific value of BPF_GETREG_X86_XMM0 or 
others matters. But this isn't the case. Will remove.

>> +	BPF_GETREG_X86_XMM1,
>> +	BPF_GETREG_X86_XMM2,
>> +	BPF_GETREG_X86_XMM3,
>> +	BPF_GETREG_X86_XMM4,
>> +	BPF_GETREG_X86_XMM5,
>> +	BPF_GETREG_X86_XMM6,
>> +	BPF_GETREG_X86_XMM7,
>> +	BPF_GETREG_X86_XMM8,
>> +	BPF_GETREG_X86_XMM9,
>> +	BPF_GETREG_X86_XMM10,
>> +	BPF_GETREG_X86_XMM11,
>> +	BPF_GETREG_X86_XMM12,
>> +	BPF_GETREG_X86_XMM13,
>> +	BPF_GETREG_X86_XMM14,
>> +	BPF_GETREG_X86_XMM15,
>> +	__MAX_BPF_GETREG,
>> +};
>> +
>> +/* bpf_get_reg_val flags */
>> +enum {
>> +	BPF_GETREG_F_NONE = 0,
>> +	BPF_GETREG_F_CURRENT = (1U << 0),
>> +};
> 
> Can you add a comment specifying what the BPF_GETREG_F_CURRENT flag does?
> The commit summary is very helpful, but it would be good to persist this in
> code as well.
> 

Yep.

>> +
>>  enum {
>>  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
>>  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index f15b826f9899..0de7d6b3af5b 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -28,6 +28,10 @@
>>  
>>  #include <asm/tlb.h>
>>  
>> +#ifdef CONFIG_X86
>> +#include <asm/fpu/context.h>
>> +#endif
>> +
>>  #include "trace_probe.h"
>>  #include "trace.h"
>>  
>> @@ -1166,6 +1170,148 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>>  	.arg1_type	= ARG_PTR_TO_CTX,
>>  };
>>  
>> +#define XMM_REG_SZ 16
>> +
>> +#define __xmm_space_off(regno)				\
>> +	case BPF_GETREG_X86_XMM ## regno:		\
>> +		xmm_space_off = regno * 16;		\
>> +		break;
>> +
>> +static long getreg_read_xmm_fxsave(u32 reg, struct task_struct *tsk,
>> +				   void *data)
>> +{
>> +	struct fxregs_state *fxsave;
>> +	u32 xmm_space_off;
>> +
>> +	switch (reg) {
>> +	__xmm_space_off(0);
>> +	__xmm_space_off(1);
>> +	__xmm_space_off(2);
>> +	__xmm_space_off(3);
>> +	__xmm_space_off(4);
>> +	__xmm_space_off(5);
>> +	__xmm_space_off(6);
>> +	__xmm_space_off(7);
>> +#ifdef	CONFIG_X86_64
>> +	__xmm_space_off(8);
>> +	__xmm_space_off(9);
>> +	__xmm_space_off(10);
>> +	__xmm_space_off(11);
>> +	__xmm_space_off(12);
>> +	__xmm_space_off(13);
>> +	__xmm_space_off(14);
>> +	__xmm_space_off(15);
>> +#endif
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	fxsave = &tsk->thread.fpu.fpstate->regs.fxsave;
>> +	memcpy(data, (void *)&fxsave->xmm_space + xmm_space_off, XMM_REG_SZ);
>> +	return 0;
>> +}
> 
> Does any of this also need to be wrapped in CONFIG_X86? IIUC, everything in
> struct thread_struct is arch specific, so I think this may fail to compile
> on a number of other architectures. Per my suggestion below, maybe we
> should just compile all of this logic out if we're not on x86, and update
> bpf_get_reg_val() to only call bpf_read_sse_reg() on x86?
> 

I generally agree with this comment and rest of "make ifdefs more sane"
comments. Per Alexei's comments on this patch some refactoring is in order to
try to avoid ifdefs altogether, but will do a sanity pass on any that remain.

>> +
>> +#undef __xmm_space_off
>> +
>> +static bool getreg_is_xmm(u32 reg)
>> +{
>> +	return reg >= BPF_GETREG_X86_XMM0 && reg <= BPF_GETREG_X86_XMM15;
> 
> I think it's a bit confusing that we have a function here which confirms
> that a register is xmm, but then we have ifdef CONFIG_X86_64 in large
> switch statements in functions where we actually read the register and then
> return -EINVAL.  Should we just update this to do the CONFIG_X6_64
> preprocessor check, and then we can assume in getreg_read_xmm_fxsave() and
> bpf_read_sse_reg() that the register is a valid xmm register, and avoid
> having to do these switch statements at all? Note that this wouldn't change
> the existing behavior at all, as we'd still be returning -EINVAL on 32-bit
> x86 in either case.
> 
>> +}
>> +
>> +#define __bpf_sse_read(regno)							\
>> +	case BPF_GETREG_X86_XMM ## regno:					\
>> +		asm("movdqa %%xmm" #regno ", %0" : "=m"(*(char *)data));	\
>> +		break;
>> +
>> +static long bpf_read_sse_reg(u32 reg, u32 flags, struct task_struct *tsk,
>> +			     void *data)
>> +{
>> +#ifdef CONFIG_X86
>> +	unsigned long irq_flags;
>> +	long err;
>> +
>> +	switch (reg) {
>> +	__bpf_sse_read(0);
>> +	__bpf_sse_read(1);
>> +	__bpf_sse_read(2);
>> +	__bpf_sse_read(3);
>> +	__bpf_sse_read(4);
>> +	__bpf_sse_read(5);
>> +	__bpf_sse_read(6);
>> +	__bpf_sse_read(7);
>> +#ifdef CONFIG_X86_64
>> +	__bpf_sse_read(8);
>> +	__bpf_sse_read(9);
>> +	__bpf_sse_read(10);
>> +	__bpf_sse_read(11);
>> +	__bpf_sse_read(12);
>> +	__bpf_sse_read(13);
>> +	__bpf_sse_read(14);
>> +	__bpf_sse_read(15);
>> +#endif /* CONFIG_X86_64 */
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (flags & BPF_GETREG_F_CURRENT)
>> +		return 0;
>> +
>> +	if (!fpregs_state_valid(&tsk->thread.fpu, smp_processor_id())) {
>> +		local_irq_save(irq_flags);
>> +		err = getreg_read_xmm_fxsave(reg, tsk, data);
>> +		local_irq_restore(irq_flags);
>> +		return err;
>> +	}
> 
> Should we move the checks for current and fpregs_state_valid() above where
> we actually read the registers? That way we can avoid doing the xmm read if
> we'd have to read the fxsave region anyways. Not sure if that's common in
> practice or really necessary at all. What you have here seems fine as well.

I think if we check that fpregs_state_valid is true before reading the reg val,
we'd need to disable irqs for both the check and the read, since an irq could
come and clobber regs between check and read in a sleepable bpf program.

> 
>> +
>> +	return 0;
>> +#else
>> +	return -ENOENT;
>> +#endif /* CONFIG_X86 */
>> +}
>> +
>> +#undef __bpf_sse_read
>> +
>> +BPF_CALL_5(get_reg_val, void *, dst, u32, size,
>> +	   u64, getreg_spec, struct pt_regs *, regs,
>> +	   struct task_struct *, tsk)
>> +{
>> +	u32 reg, flags;
>> +
>> +	reg = (u32)(getreg_spec >> 32);
>> +	flags = (u32)getreg_spec;
>> +	if (reg >= __MAX_BPF_GETREG)
>> +		return -EINVAL;
>> +
>> +	if (getreg_is_xmm(reg)) {
>> +#ifndef CONFIG_X86
>> +		return -ENOENT;
> 
> On CONFIG_X86 but !CONFIG_X86_64, we return -EINVAL if we try to access the
> wrong xmm register. Should we just change this to be return -EINVAL to keep
> the return value consistent between architectures? Or we should update the
> 32 bit x86 case to return -ENOENT as well, and probably update the last
> return -EINVAL statement in the function to be return -ENOENT. In general,
> I'd say that returning -ENOENT if a register is specified that's
> < __MAX_BPF_GETREG seems like the most intuitive API.

They're both handling erroneous input, but "this isn't even valid for the entire
arch" feels worth distinguishing from other bad input complaints. I don't feel
strongly about this.

> 
>> +#else
> 
> Is it necessary to have this ifdef check here if you also have it in
> bpf_read_sse_reg()? Maybe it makes more sense to keep this preprocessor
> check, and compile out bpf_read_sse_reg() altogether on other
> architectures? I think that probably makes sense given that we likely also
> want to wrap __bpf_sse_read() in an ifdef given that it emits x86 asm, and
> getreg_read_xmm_fxsave() which relies on the x86 definition of struct
> thread_struct.
> 
>> +		if (size != XMM_REG_SZ)
>> +			return -EINVAL;
>> +
>> +		return bpf_read_sse_reg(reg, flags, tsk, dst);
>> +	}
>> +
>> +	return -EINVAL;
>> +#endif
>> +}
>> +
>> +BTF_ID_LIST(bpf_get_reg_val_ids)
>> +BTF_ID(struct, pt_regs)
>> +
>> +static const struct bpf_func_proto bpf_get_reg_val_proto = {
>> +	.func	= get_reg_val,
>> +	.ret_type	= RET_INTEGER,
>> +	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
>> +	.arg2_type	= ARG_CONST_SIZE,
>> +	.arg3_type	= ARG_ANYTHING,
>> +	.arg4_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
>> +	.arg4_btf_id	= &bpf_get_reg_val_ids[0],
>> +	.arg5_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
>> +	.arg5_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
>> +};
>> +
>>  static const struct bpf_func_proto *
>>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>  {
>> @@ -1287,6 +1433,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>  		return &bpf_find_vma_proto;
>>  	case BPF_FUNC_trace_vprintk:
>>  		return bpf_get_trace_vprintk_proto();
>> +	case BPF_FUNC_get_reg_val:
>> +		return &bpf_get_reg_val_proto;
>>  	default:
>>  		return bpf_base_func_proto(func_id);
>>  	}
>> diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
>> index 9acbc11ac7bb..b4b55706c2dd 100644
>> --- a/kernel/trace/bpf_trace.h
>> +++ b/kernel/trace/bpf_trace.h
>> @@ -29,6 +29,7 @@ TRACE_EVENT(bpf_trace_printk,
>>  
>>  #undef TRACE_INCLUDE_PATH
>>  #define TRACE_INCLUDE_PATH .
>> +#undef TRACE_INCLUDE_FILE
>>  #define TRACE_INCLUDE_FILE bpf_trace
>>  
>>  #include <trace/define_trace.h>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 444fe6f1cf35..3ef8f683ed9e 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -5154,6 +5154,18 @@ union bpf_attr {
>>   *		if not NULL, is a reference which must be released using its
>>   *		corresponding release function, or moved into a BPF map before
>>   *		program exit.
>> + *
>> + * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_regs *regs, struct task_struct *tsk)
>> + *	Description
>> + *		Store the value of a SSE register specified by *getreg_spec*
>> + *		into memory region of size *size* specified by *dst*. *getreg_spec*
>> + *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
>> + *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
>> + *	Return
>> + *		0 on success
>> + *		**-ENOENT** if the system architecture does not have requested reg
>> + *		**-EINVAL** if *getreg_spec* is invalid
>> + *		**-EINVAL** if *size* != bytes necessary to store requested reg val
>>   */
>>  #define __BPF_FUNC_MAPPER(FN)		\
>>  	FN(unspec),			\
>> @@ -5351,6 +5363,7 @@ union bpf_attr {
>>  	FN(skb_set_tstamp),		\
>>  	FN(ima_file_hash),		\
>>  	FN(kptr_xchg),			\
>> +	FN(get_reg_val),		\
>>  	/* */
>>  
>>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> @@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
>>  	__u64 running;
>>  };
>>  
>> +/* bpf_get_reg_val register enum */
>> +enum {
>> +	BPF_GETREG_X86_XMM0 = 0,
>> +	BPF_GETREG_X86_XMM1,
>> +	BPF_GETREG_X86_XMM2,
>> +	BPF_GETREG_X86_XMM3,
>> +	BPF_GETREG_X86_XMM4,
>> +	BPF_GETREG_X86_XMM5,
>> +	BPF_GETREG_X86_XMM6,
>> +	BPF_GETREG_X86_XMM7,
>> +	BPF_GETREG_X86_XMM8,
>> +	BPF_GETREG_X86_XMM9,
>> +	BPF_GETREG_X86_XMM10,
>> +	BPF_GETREG_X86_XMM11,
>> +	BPF_GETREG_X86_XMM12,
>> +	BPF_GETREG_X86_XMM13,
>> +	BPF_GETREG_X86_XMM14,
>> +	BPF_GETREG_X86_XMM15,
>> +	__MAX_BPF_GETREG,
>> +};
>> +
>> +/* bpf_get_reg_val flags */
>> +enum {
>> +	BPF_GETREG_F_NONE = 0,
>> +	BPF_GETREG_F_CURRENT = (1U << 0),
>> +};
>> +
>>  enum {
>>  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
>>  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
>> -- 
>> 2.30.2
>>
