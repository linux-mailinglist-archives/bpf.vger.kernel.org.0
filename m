Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75C6B1894
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 02:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCIBPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 20:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCIBPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 20:15:48 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB9CCE9E
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 17:15:46 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328MV7F1012926;
        Wed, 8 Mar 2023 17:15:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xOqLrGg1hyPtCx1Z2mP3RKVUfUHXv5Pi2LRk51n2hHo=;
 b=TijDFzlwT19D9nuTgiol572k5HN6M2TS1pcpQxb61qb7mDNGKetLQZtWG+jKkN/P8Vy9
 kqEs1zBvWDAyOYqoUGAYF0BywG+zgiUQ/bBkseYs8pfVTwaZPoJjmNUwYIdgrPS5mWWV
 AnEup/Ci6IzIznTEKuiz38b+nus3dtZ+hSK+bQtQlpyocAihBn6B1ZZrElf2U38lrwWd
 73nklEPeumJ7SUZiQQVhFjBum6zmESbXsk6Oa9yMY+FGqJg+2EabKOzZNLZA2bFrtkdX
 o9enRa18vLozy0ZkZiIP4itCsNmlcYIQ7HCoYTFePngIk2pqyagQVFYYAhvxAMHJ0Rk/ iA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fergbw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 17:15:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rwlrs/vy2DkKBqQmiBPeqiONnJi7M0gIrVAmolljQ+3ZGEmlxh2TtZwpdxXS/Rk+D5Jj+mtTlguNPUJW1kv+WGoJQWsR8KnArFqd5csmlypEJFgoeBtAaOnyw1thRNDQK57ehr+caYtc3ytG5Yh2GgM3r+NaGJkd+RlE7L05Cpvj5ILJCdmfqPIEP6s4fMp8kdKGPLVFC8+RSIf1IFYb+j4Xm4VbPgG76YiCIskUkc6L7XRmaeBfmUlNYC0HURlq73WCO1QzxzPLHSbPJJBYrel2SoYYArDxmzuY2Tn2BUfMrGzwtY9nRRKLgnktmPEvoNt7byzrRIVYrcQTTTZzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOqLrGg1hyPtCx1Z2mP3RKVUfUHXv5Pi2LRk51n2hHo=;
 b=Iamn9DqCA6lmAkzXt/QixTzNjVyCKxPLd+Poecxed7FQWPtaQMU9VRLWixoRCU8KWVe3xttU6kFrLJe3zPomcrCx6eaCQVAQwpixLg9Uz1Jt6Nm2fBFY8scVJ1YJVfO5G0eocZJNpl8Jo5LHlUIsI7toP9QSLUc3TF2rWRd0fH2Ovly1Nq/pv7D4i2VEvQaCPvMjfQP17fvaeiW64c5xaqt4w+t6fPESqvAhsREtHa4wNYuHedZ2HQXMEShjexHOv30BGnnDjgEDx+w5knMnueahw9wCtpY7qkem6lcsBM1SEYwowo7p+Fo4p7R5u36RnWTQKC6RXCOjeGVD8/CMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by MW4PR15MB5272.namprd15.prod.outlook.com (2603:10b6:303:18a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 9 Mar
 2023 01:15:27 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832%8]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 01:15:27 +0000
Message-ID: <0adcfa56-f50b-dd81-0d85-96148b4ce438@meta.com>
Date:   Wed, 8 Mar 2023 20:15:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 bpf-next] bpf: Refactor release_regno searching logic
Content-Language: en-US
To:     Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20230214190551.2264057-1-davemarchevsky@fb.com>
 <CAJnrk1bYbVd2AHH71eiaD6gY4r3sMjMFVGHmwvAY3BqJOQLVhQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAJnrk1bYbVd2AHH71eiaD6gY4r3sMjMFVGHmwvAY3BqJOQLVhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:208:134::33) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|MW4PR15MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae18646-dfe7-468d-4bcc-08db203bc472
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZirN7eitiLWFntB91urDylWPTqQ3MENqhIb3U5uUOHIkeD82kgVhBX6Pm3DjuWiC8FHR6wByXWVWcZ8r+u0P7l27IMIPHOXb1EU2D22sxQsVEswJNwJ1iD0nKV3OpnW8PXSw+vepePmQrPv5wu4QFDIPrZWly+29bW+KZ9Av2YydLZclC2OLYgL9avMA/dbPOyN/yLzGn8BWXNuTdKB73U6fiCRnstfQBje77USe0z28dbMECx8epTEuNmkiAqbE8mqXMPpbxzcWLgSDOsW74fXJJ7VZ9SdQz++59uILHbKFxQsuQKZAcC8rehTc75HPUfmM0hneCTHt0S/56jUZyxUtApU/qwJMTknUTjwvgJ0IPD6FQtRo8T0owwXqkzQB66PjSP2ZbAZifF/nDdVjo59dfhWruiQpjkv8KpUkPFrgCOTUR9diOZsl1Vgl5+VPGt4F1pF56q4BMSiYiGmT4kjDmc+EmJR5KZKg1dQgsoMy/USH0JX6kYcWsqbtWBY6Sfi84jNaxJH3r5nVJN6JdToIkYIPfyrYIPO9Gk1Qht3OW+4JqOEqrd0hWDvEmF78cNmpSuyrLc8JHH9qwhj145GarQBBSFRh+h6MVkUv3CfAafc9VdE24bJbE+JkgiVf0DrCLn9VaEs8XELbrKUyOTUHmc6iW1RqukU8KxKHyKQUEDtDWSatELGZ8i0Bhfv4GYWWxGZLm9nr7laE32h2FOpoINvNKne/dgwuCQ173guw2zlDOeDCtKNU/pkIYIgYnADxgylYkQPtkj1r5tj4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199018)(478600001)(5660300002)(38100700002)(54906003)(83380400001)(110136005)(8676002)(4326008)(66476007)(66946007)(66556008)(316002)(41300700001)(36756003)(2906002)(8936002)(2616005)(6506007)(30864003)(53546011)(86362001)(31696002)(31686004)(6512007)(186003)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJXdzNES3dpRjRkUU9Sa1gwRExnWXZYbStKMHB2eTlMU295d0NsYkNmdkdT?=
 =?utf-8?B?ckJYRzZNQTBhWDlDQVppNEpCRWJreEJUMW5mS1lGcTRQbHRmOEJlcXBtcEFR?=
 =?utf-8?B?ZFZIMGZhckp1d3NlQkhKcVIwVWY0K3k5L1p2YUh5UWpNZVZTOUQvak1YS1Rp?=
 =?utf-8?B?TCtGMWwwc3V3Ym5WZU5HRVlXM3VaNGZWOUhmcUZkTG9xTjY1NmZOaU10dUJs?=
 =?utf-8?B?TitIT2ZhZndYZmxnSDJYeUhqWnhOTnE5bHZFR0x6M2xteFNZOUJ0azlqQXo5?=
 =?utf-8?B?U253YWZQbi9CY09jS2ZSb3NjMEpFVndVNmFTZTdTdlVTcktyQWFMczZEdWRM?=
 =?utf-8?B?V0tXR0h2bTJremRTU21yNnZ5alNWNE9YMDdiRVlRbzM2SDgwY2hGbGlzRnlC?=
 =?utf-8?B?UEVVREJ4ck14dUV6bjFtN3pXTlYxWGJoUTM0elBGUWY1UW1Ob3JzaThjR01m?=
 =?utf-8?B?M05aVTRHY2Jodnd6REtoTldTTGQrNnd5TnhIR1JFV1l4Zm9vNUtuR28xaytB?=
 =?utf-8?B?SWhRelJHSkhETHN1cFhwblgxVnZHQ0p5ckNrQUE1cG0vQTErbG1YckFqOWox?=
 =?utf-8?B?RFlJd3JLaFBUQzNxOG83MDMrZmdML0hNNWQzSmw1ek05aGtKWEtudDB2aWtl?=
 =?utf-8?B?L1ZQaUc4UlptM0tqUHRaVkRSWVlndm95WXJVdlBUMHhNcDBTZEZxcitvNUNu?=
 =?utf-8?B?MzZPL2FhYXFOemFldXAzbVdWK3NZSlIrYkpiWm5zaGF6QVBtd1o1Tk1yMGEw?=
 =?utf-8?B?Mm1uM3NSakhOQURIYzJjeUVraDc2SFdTUXQ2cndRNWwxb0xGVnM3ZStESnZi?=
 =?utf-8?B?a2ZQZzdiMmVzSFRxWVFSeGNlVGlpb0dUbHJoTzVvSzhMU2hxUG43bHRUTVI5?=
 =?utf-8?B?M3lyTUxNUlBuNktFdTNvMndmcjRJLzEvVHRUbzd5T2pnVG8zLzAvYmdxS05M?=
 =?utf-8?B?blBHNHp1MHpNQmltbWNQVjN4Q21kVFk5cUVxM0xyOUU1NWQyQk1QYm8rU09X?=
 =?utf-8?B?ZncrTmdaY25Yb29PZzVGbmNNOHE2NWZJRVR4Um9TZ21oNFl6TlhjdDRkQTYr?=
 =?utf-8?B?MVBjUG1TaU51ME5kaWVxOXEyRDBHSFBIdzA0V0EzNVlnK0VvOGNKbFBqOHAr?=
 =?utf-8?B?NUJQd3NYemJ5K0p1VkN0ZXZxV0Jmb0FBV05oUCszN1VyUHhjdmRWK2NqRlZz?=
 =?utf-8?B?RUdUY09ubDFITGhrUmxCZEJkN2ViQnJPQW5abXBuT3NPd2c1czRWTWlEYWFj?=
 =?utf-8?B?c3MwK3JpekZWMlBXMkdtWVJaRzI4L2ZFRUxZOS9FbEh3aGYrWldyR1NhVmFG?=
 =?utf-8?B?RG9TMTZNWXpMdFdrZGsxQ3VDRmM1eUtPeGxPUzRoNzJ5VHpaUWxha0ZRcWJv?=
 =?utf-8?B?M0pucnZPcVpFeTBaci9uNXVmeHhJQ3RCK3lia1krU0s0R0ZyTjhBWXgrdzBS?=
 =?utf-8?B?RzNRMVdTU0JjREUrUjZCZFlGK21ROEhkbFpyc1BaMzV6YU55MTBUMW9IRFNJ?=
 =?utf-8?B?VkZmZGlvZUtsYk9BdlFKV3lXb1ZUMy9pZUE3WDlDN2VZVk1nRDB4LzVCK3kw?=
 =?utf-8?B?UmtqTjlYVlZZeElneXBVd084QllNRm5aL3dLYnJZbUdZdElidnpWeEp0d3Rs?=
 =?utf-8?B?MDliVkRIc3RpUDFmeUYxRXhDcEhmcWx6dkR2NWhCa3kxYm1wcDlnMVVwYThK?=
 =?utf-8?B?YWtRSHFaekhvbFA4QnBwTDlCSXFkdWErWkxhY0RuWS8xNS9WdmZKYkw3QnMx?=
 =?utf-8?B?K3VId0ZqZDZhWGFHTlNjeG1veVBIZ3ZUdG5rR3Y0clVSMHVZTU0vaEZrR2xS?=
 =?utf-8?B?WjdlcGxwakJ4QUlhOFd0WlFNRUoxaU1FU1NzdGhDOHE3VUFpWGo5dm1nM1FM?=
 =?utf-8?B?QU5UeUR0Uy9rb1MzeTRndjVuL1lsQjJBdzB3YWVqVlFOemFOMkx5NzUxelIy?=
 =?utf-8?B?dnhyQm1GY3RZVEF6VVBNekpqQi84bHhGOGxENVJKZGE5a1hrQ2krSGhzdGdQ?=
 =?utf-8?B?NUUwQTh6THhFN2NsTVhsdGc3Ui82MnppYm1hTjg4azZhL1g1Q3k5K3NsRGpy?=
 =?utf-8?B?bXlrcTgwTGlkdmFWVS91WTVlSS9qQ3dFSXovVWVwVVY3aHpLWnNodlhtRVAy?=
 =?utf-8?B?N0RCb1YvWk96Q29FcWVET3VsdEJwZWpWSGVmWjRUeFNaRmdCb0lkbDFGWTdR?=
 =?utf-8?Q?CwG0SGMGtXskQHeuhjFSXQg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae18646-dfe7-468d-4bcc-08db203bc472
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 01:15:27.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Ht6PhKqHQwsuGPvzuAPOgwlBdKCctpN4f5Cyf8GQh9DOqbp16wmgAUbcasb9E+LltQ8WRPEpU/6FZmYqPYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5272
X-Proofpoint-ORIG-GUID: gBEuB4ZNRa_SKmw1dyqO58uAMvcPisno
X-Proofpoint-GUID: gBEuB4ZNRa_SKmw1dyqO58uAMvcPisno
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/14/23 4:13 PM, Joanne Koong wrote:
> On Tue, Feb 14, 2023 at 11:17 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
>> that examines each individual arg (check_func_arg for helpers and
>> check_kfunc_args inner loop for kfuncs). This patch pulls out this
>> searching to occur before individual arg type handling, resulting in a
>> cleaner separation of logic and shared logic between kfuncs and helpers.
>>
>> The logic for this searching is already very similar between kfuncs and
>> helpers:
>>
>> Kfuncs:
>>   * Function-level KF_RELEASE flag indicates that the kfunc releases
>>     some previously-acquired arg
>>   * Verifier searches through arg regs to find those with ref_obj_id set
>>     * One such arg reg is selected. If multiple arg regs have ref_obj_id
>>       set, the last one (by regno) is chosen to be released
>>
>> Helpers:
>>   * OBJ_RELEASE is used in function proto to tag a particular arg as the
>>     one that should be released
>>     * There can only be one such tagged arg
>>   * Verifier confirms that only one arg reg has ref_obj_id set and that
>>     that reg matches expected OBJ_RELEASE arg
>>     * If OBJ_RELEASE arg doesn't have a matching ref_obj_id arg reg, or
>>       some other arg reg has ref_obj_id, it's an invalid state
>>
>> It's a long-term goal to merge as much kfunc and helper logic as
>> possible. Merging the similar functionality here is a small step in that
>> direction.
>>
>> Two new helper functions are added:
>>   * args_find_ref_obj_id_regno
>>     * For helpers and kfuncs. Searches through arg regs to find
>>       ref_obj_id reg and returns its regno.
>>
>>   * helper_proto_find_release_arg_regno
>>     * For helpers only. Searches through fn proto args to find the
>>       OBJ_RELEASE arg and returns the corresponding regno.
>>
>> The refactoring strives to keep failure logic and error messages
>> unchanged. However, because the release arg searching is now done before
>> any arg-specific type checking, verifier states that are invalid due to
>> both invalid release arg state _and_ some type- or helper-specific
>> checking logic might see the release arg-related error message first,
>> when previously verification would fail for the other reason.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>> v2 -> v3:
>>  * Edit patch summary for clarity
>>  * Correct err_multi comment in args_find_ref_obj_id_regno doc string
>>  * Rebase onto latest bpf-next: 'Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"'
>>
>> v1 -> v2: https://lore.kernel.org/bpf/20230121002417.1684602-1-davemarchevsky@fb.com/
>>  * Fix uninitialized variable complaint (kernel test bot)
>>  * Add err_multi param to args_find_ref_obj_id_regno - kfunc arg reg
>>    checking wasn't erroring if multiple ref_obj_id arg regs were found,
>>    retain this behavior
>>
>> v0 -> v1: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevsky@fb.com/
>>  * Remove allow_multi from args_find_ref_obj_id_regno, no need to
>>    support multiple ref_obj_id arg regs
>>  * No need to use temp variable 'i' to count nargs (David)
>>  * Proper formatting of function-level comments on newly-added helpers (David)
>>
>>  kernel/bpf/verifier.c | 220 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 153 insertions(+), 67 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 21e08c111702..c0d01085f44f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6735,48 +6735,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>                 return err;
>>
> [...]
>>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                              int *insn_idx_p)
>>  {
>>         enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>> +       int i, err, func_id, nargs, release_regno, ref_regno;
>>         const struct bpf_func_proto *fn = NULL;
>>         enum bpf_return_type ret_type;
>>         enum bpf_type_flag ret_flag;
>> @@ -8115,7 +8178,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>         struct bpf_call_arg_meta meta;
>>         int insn_idx = *insn_idx_p;
>>         bool changes_data;
>> -       int i, err, func_id;
>>
>>         /* find function prototype */
>>         func_id = insn->imm;
>> @@ -8179,8 +8241,37 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>         }
>>
>>         meta.func_id = func_id;
>> +       regs = cur_regs(env);
>> +
>> +       /* find actual arg count */
>> +       for (nargs = 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
>> +               if (fn->arg_type[nargs] == ARG_DONTCARE)
>> +                       break;
>> +
>> +       release_regno = helper_proto_find_release_arg_regno(env, fn, nargs);
>> +       if (release_regno < 0)
>> +               return release_regno;
>> +
>> +       ref_regno = args_find_ref_obj_id_regno(env, regs, nargs, true);
>> +       if (ref_regno < 0)
>> +               return ref_regno;
>> +       else if (ref_regno > 0)
>> +               meta.ref_obj_id = regs[ref_regno].ref_obj_id;
> 
> nit: I think it's easier to read if this ref_regno logic gets moved
> below the release_regno logic, so that all the release_regno logic is
> together
> 

Sorry for resurrecting this old thread. I sent a v4 which
applies feedback from this message, except for this nit and one
other suggestion (addressed below).

I agree with this readability nit, but did not apply the
suggestion as this weird order is intentional in order to match
the pre-refactoring order of error checks as much as possible.

>> +
>> +       if (release_regno > 0) {
>> +               if (!regs[release_regno].ref_obj_id &&
>> +                   !register_is_null(&regs[release_regno]) &&
>> +                   !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
>> +                       verbose(env, "R%d must be referenced when passed to release function\n",
>> +                               release_regno);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               meta.release_regno = release_regno;
>> +       }
>> +
>>         /* check args */
>> -       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>> +       for (i = 0; i < nargs; i++) {
>>                 err = check_func_arg(env, i, &meta, fn);
>>                 if (err)
>>                         return err;
>> @@ -8204,8 +8295,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>                         return err;
>>         }
>>
>> -       regs = cur_regs(env);
>> -
>>         /* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
>>          * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
>>          * is safe to do directly.
>> @@ -9442,10 +9531,11 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>>  {
>>         const char *func_name = meta->func_name, *ref_tname;
>> +       struct bpf_reg_state *regs = cur_regs(env);
>>         const struct btf *btf = meta->btf;
>>         const struct btf_param *args;
>> +       int ret, ref_regno;
>>         u32 i, nargs;
>> -       int ret;
>>
>>         args = (const struct btf_param *)(meta->func_proto + 1);
>>         nargs = btf_type_vlen(meta->func_proto);
>> @@ -9455,17 +9545,31 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>                 return -EINVAL;
>>         }
>>
>> +       ref_regno = args_find_ref_obj_id_regno(env, cur_regs(env), nargs, false);
> 
> nit: I think we can just pass in "regs" as the 2nd arg
> 
>> +       if (ref_regno < 0) {
>> +               return ref_regno;
>> +       } else if (!ref_regno && is_kfunc_release(meta)) {
>> +               verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
>> +                       func_name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       meta->ref_obj_id = regs[ref_regno].ref_obj_id;
>> +       if (is_kfunc_release(meta))
>> +               meta->release_regno = ref_regno;
>> +
> 
> I think we also need to check that if the kfunc is a release func then
> there can't be more than one arg reg with a set ref_obj_id (the
> earlier call to args_find_ref_obj_id_regno doesn't catch this since we
> pass in false for err_multi)
> 

This "if more than one arg reg w/ a set ref_obj_id, consider
last such arg reg to be ref_regno" logic is preserving existing
behavior.

But more generally, RELEASE is really a parameter-level thing: if the function
is RELEASEing some passed-in resource, that parameter should be tagged as such
(OBJ_RELEASE type flag in helper func proto does this more cleanly IMO), then
there's no need to rely on heuristics to guess what's being released. Might
as well preserve the pre-refacotring heuristic here and move to parameter-level
flags for kfuncs eventually.

>>         /* Check that BTF function arguments match actual types that the
>>          * verifier sees.
>>          */
>>         for (i = 0; i < nargs; i++) {
>> -               struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
>>                 const struct btf_type *t, *ref_t, *resolve_ret;
>>                 enum bpf_arg_type arg_type = ARG_DONTCARE;
>>                 u32 regno = i + 1, ref_id, type_size;
>>                 bool is_ret_buf_sz = false;
>> +               struct bpf_reg_state *reg;
>>                 int kf_arg_type;
>>
>> +               reg = &regs[regno];
>>                 t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>>
>>                 if (is_kfunc_arg_ignore(btf, &args[i]))
>> @@ -9528,18 +9632,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>                         return -EACCES;
>>                 }
>>
>> -               if (reg->ref_obj_id) {
>> -                       if (is_kfunc_release(meta) && meta->ref_obj_id) {
>> -                               verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
>> -                                       regno, reg->ref_obj_id,
>> -                                       meta->ref_obj_id);
>> -                               return -EFAULT;
>> -                       }
>> -                       meta->ref_obj_id = reg->ref_obj_id;
>> -                       if (is_kfunc_release(meta))
>> -                               meta->release_regno = regno;
>> -               }
>> -
>>                 ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>>                 ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>>
>> @@ -9585,7 +9677,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>                         return -EFAULT;
>>                 }
>>
>> -               if (is_kfunc_release(meta) && reg->ref_obj_id)
>> +               if (is_kfunc_release(meta) && regno == meta->release_regno)
> 
> I don't think we need the "is_kfunc_release(meta)" check here since
> meta->release_regno is set to a regno only when is_kfunc_release(meta)
> is true
> 
>>                         arg_type |= OBJ_RELEASE;
>>                 ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>>                 if (ret < 0)
>> @@ -9747,12 +9839,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>                 }
>>         }
>>
>> -       if (is_kfunc_release(meta) && !meta->release_regno) {
>> -               verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
>> -                       func_name);
>> -               return -EINVAL;
>> -       }
>> -
>>         return 0;
>>  }
>>
>> --
>> 2.30.2
>>
