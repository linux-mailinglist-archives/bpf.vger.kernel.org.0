Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812996B98FA
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCNP1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCNP1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 11:27:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE43251E;
        Tue, 14 Mar 2023 08:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ2DEvuXan3lU0u42SCf1iXG4ftfaWWs8S04PJoN3ni5REGGk6ZrdPPlnpH27yS3F9H49qY6BDyRrsm2WrXHhJSCgStqycBIVE9F4zlK0mhTRW8sYSjKSJl9PAFEd+9lPgjTpUoIvv9Bu6LS/FsH4NI7nDEeH/ZGExMo2s24he5PFiuK7Pzv61Xxuj/ytOkz/st4lT9xyevRb8pwpoXgZxXqx++NYnoElTgutClkLSzz90cYRWk2rYH+DYorJupla0glUeciONIDvX35XHfhAVxu0nBE320GqpeucgGJ6YXyqzeJnbMqZqe8tt5JTyPzqTyYoCBO38I8JF0uivFWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4E7W/DyImlX4EgQSOglPve0tXubJyAis/oGSLkugZU=;
 b=CXeoHr8WlB03T/y0hjwBdou991sneYRwZjWX1l/+FrNw/DWUKpL/dMboeIv4Nh4hSWa7+Ys6wuKt4db8rFQBsqCIC7Eph30CvMFMK5HYfA822tURpoVgTcv1sAbd6qC6TOELTft0ug4nsYfz02+Gqdv/ED1X9hI2M3j8ZDYm/BGinnCQyFI+yIwQ/5R8YkZ3RkdJ6icGqokwX3JfA1Crzoflnv1PARW91ZU+hJuxPYy0rWzloQH/mmOZsdnd7TyMcriWqw11bSvF7U8eFAe4ibE3EILNGFNBINkspUMBsOnzwPo/2gTaeDnbzlPnmhwdpQuRgCMFp8QV4gossFhh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4E7W/DyImlX4EgQSOglPve0tXubJyAis/oGSLkugZU=;
 b=hRBH4yHcVFxsZeWrxSKXOuZ1vgIEdqy9zNXhaE77gcBGQECaywGBG6GwPqPL35AC4J81mQN0bIZukms/rCtlq6aQsPXnZxvfFa2+BOqhGF0pjylZNWqFurSIgI+DdHlRpFoDBK3sertzGKn0eHADwkRVJFFDwtgiLVP13canI6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 15:27:41 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%4]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 15:27:41 +0000
Message-ID: <9b2a3f48-44bc-3719-9ba1-b60f9382a5ba@amd.com>
Date:   Tue, 14 Mar 2023 20:57:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com> <ZAtG43JZkUoO9XkF@kernel.org>
 <ZBBc5SQK2OhIGtGy@kernel.org>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZBBc5SQK2OhIGtGy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef90227-30e1-49c9-24e0-08db24a0a61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQ87fL/Jps8TMbaO/YGVbiezq+BO/uYU1wulLSIwU4bucSITGywjYKOZerEz0GKyrRvaqA9d/D5WyugmHaOoBQSWT9CB4Cg6EdO+s1EarUMQX+x+XUf68JLKg5ZfzesvuogRZDKGdQXsvM71z7F2hCjpMTr33tqNts9Cmo9RB2V6BM024cLKJm8+i+ohFZxVRgB4ZyfBeKih/TZdVK60aKFYvSkU05C3Mk9tOe529jxzShHhAdsJw73F1h+qrbSCjSSvO+7fLZTKUyLo5+3gCVQnxgzaAG5kTAO2MMvWbclkEQUXQMc3WmTYGfgBwDSMAJtH/NFedFtm7HQjGlhJOgFW+OyCWT4c6QOJ5dEjyCNe7E6PpkzA8KT2pvU6C3Aq6VT+4Qih/VMgkZNHb30MeaWSPB1Mf2UDq/fCMrtvI3PCOdyapK9pXifMgvA/bCYmjY3pvF/87sRWC0apURqEK4cISfRSboHW3hOmaS6X7rQndsCOyrSgNIokyZ8e/2PbuglY0OwoM4baRZUIRLI8F9H16fHYkn7W/2GdZUu4xuTFX0lZ+fcpM+qMhwsArZxkDSghB57xo8k0esFj3b5hoclLnj9cEm1yg4COJ0ZEU0R+BtXHDwWsCyA0l1FKcKFYp4qFZRZLrkUYFNttH2UEbIz/a4+crdrP9yITGIxPK8dNDoW3FEbdGFrUNECf1cYSrOFeVgxq100xk1sY3fh70i7wQUBM4rlkULStWT6WTyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(6512007)(6506007)(26005)(36756003)(6666004)(6486002)(66946007)(66476007)(478600001)(66556008)(8676002)(4326008)(6916009)(83380400001)(316002)(5660300002)(54906003)(44832011)(38100700002)(86362001)(2906002)(31696002)(53546011)(186003)(41300700001)(2616005)(7416002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFCaEhWWU9vWXJJUWVyTWZVNDUwdDQ5d3FIQUNSZnZwODFlVnczcmN2Ui8z?=
 =?utf-8?B?WmdBNm5HQTc4RExYUW9uWlIxS3RYSnRJY0tRb1FrOVhOMks5U01tdExZN21B?=
 =?utf-8?B?ZHhIVVJJZDRvQW9oZm41MHlzWGNGUTBETXdzdmMyVjhtRmpDdGY2TS9udklT?=
 =?utf-8?B?RDlZb3NWYitDMkdLaHlMd0UvRGNqeHBZNithTTZEYUtwZ2YzaHVHZmE4Z0xh?=
 =?utf-8?B?SXgva1VGVWVvYnhXODcrQTRCVEY5RjRNanNxcGx1bVJCYjBYMEdFckN5QlBt?=
 =?utf-8?B?VjRnYU9KbWdMbUhBeEFXckdGNU9BVnIxUzhVZlR0TDlVVGNUMEpTT2hmaHZ5?=
 =?utf-8?B?bUoya1d6aUxqQ0ZUbkxvYzZQRjRjbDQ0RVBlUXEzSVBXVW9tRS9uUkpIeXd3?=
 =?utf-8?B?VHpycmFzMVozS1VDR2tuS1V0eEM5dW41dXcrQ1FjUDR1TkpXS3hIaWErN0Vy?=
 =?utf-8?B?bmxBUlhYb2JzRU9nVlVxVDFaa3hIcU9ja1FpUG5sMEFQVFdYZExIVDJncDIz?=
 =?utf-8?B?Ym5yU25EbHhkVVNLck80VzhXMnVmZUNyb1JVOEdhVzlvL0FsenBtZGNCdlpl?=
 =?utf-8?B?eEM0aGRXMHBabWdha2pGQlhmNTJDaFZRNS8xMkoyQjhiYVpmVzNlVGdMNzhC?=
 =?utf-8?B?dWFwUzQwbUQ3RUwrTVNPa2ExdDlmdGFQOEVPSmxRc01PUG43QXZKdXd1SFJq?=
 =?utf-8?B?Tmw1ZnpZanA2VmVBZnN3bTliaDhPb0lxL3pwZjkvTzB6VHNxMUJmRm1idHdQ?=
 =?utf-8?B?c0wrcFVvVnhHUDUrL3VPL3dXSzJDRW5SeHZibldvZjF3dld4OXIraW03dmNB?=
 =?utf-8?B?TlhyMHZUZUNvbXZtbUZ5UzR1VW16VjVIK1Fxc0x1SUVWaDVRU0ZlN3FzTmtC?=
 =?utf-8?B?YjJmb1cwVDR0bTcydHVzL1RlRCtXdCtDeWxMUXczclJGeENBakxCRU44cThF?=
 =?utf-8?B?N1pReVZxTVlrSEtWNG5sMEdCV214VlJBMkc4aXZjdlBDUkplQVJHV01paU9j?=
 =?utf-8?B?a1h0ZEJKLzI0UUg0QTFpUzBNQnlrMGxJNVVMNXJ2YnNBSVAyRFlYblJlOVR1?=
 =?utf-8?B?eGJRM0N3WnJtRUdteDBHd0lTbjl0SXJkRVByVnlxa1RmeWlZYUt1ZWx5T1ZY?=
 =?utf-8?B?T3VUQnRmYmJLY0ZoZlU1NVdaenZ0Rm54Z3g3UlhEbFBRR093QTZIV1RNR3o3?=
 =?utf-8?B?UEFOeWF5TkU0U2ZBU25vQW42NnZtMVREeFpyN1NTdjNVWW1vUG85MFl3Sk51?=
 =?utf-8?B?Qk14VCtqUDZGYzkrZHpJK1djbDdhUSttT3hUTzVWVEY3Q1hPVFl2dVpqL0Q0?=
 =?utf-8?B?dEJ2enlMZDV3Z05BTmZMVjQ2Z3V0c2kyQXc3ODQxZHUzUmM2NDMvb0FHVU9j?=
 =?utf-8?B?bUFQSDUvZVA0VU9tT1NTRnYrYUY2OEhKUDNMUExRWWxJZXA5TmozV3YxZnh6?=
 =?utf-8?B?cEUzczY1TDlzRnJkbVF2ZUhjZkY1WWs1bFhoaUpZNFZpTVZZOUVJTTg1NGZG?=
 =?utf-8?B?RWp4TnpCc3djc1JpSkI1cng3cHp6clQ5R1pNN2M2S0lOWkE0T0hvM3J3cnlV?=
 =?utf-8?B?Unc2VDVPRW9uTzZldkhUWTdJSkJXSmRmeFRGOVBMMEJsRlBmK04xd0I0V1NC?=
 =?utf-8?B?ZGZiM2YzVWFSMzJyT2NIUjY1UkdJNVp1QWtpNU1SZXhoaWpTSWlrNTF3OVhL?=
 =?utf-8?B?SlNWa20rcFNEd2IyWnV5NEs2S09TbW5xM1ZKNEExMWQ0clozK0tLYTZuQ1Fw?=
 =?utf-8?B?QVpDYjF1bXZCeHdJaDVKRUZOU2JqalA1Q2RJdThZcEVQSmlCMnFzUkRvTWRH?=
 =?utf-8?B?WWV2VHRYTGFVOTN5MU9xdEdMVlRFY2tKRFpGTGpJcTlmbkY1MWk5c0Y1cm4w?=
 =?utf-8?B?SXZ2eXZ6Z2g0ckV6K2l3blVhZTVtZ21rZnNzQ05WWU1PczZ6YitsNnJiZmRt?=
 =?utf-8?B?VTlEZUNoWHk3TGxUcXE2NnFTNHdPVzhsVm43eUcwS3JtSDFHN1hhOS9oWGtR?=
 =?utf-8?B?NVVJeHdaZjF0dFpMdy8yMWt6N2Y2UlQ0OHp1cHNBU1pDc0VLM0VOSE9EcS8z?=
 =?utf-8?B?TVptUXlGV09yYkZKbTFTTmh3RDNJVUpscGNEakI2aUtLSkVyczhsZUhTYjgx?=
 =?utf-8?Q?BC7fAHVaj7CVBFzgOZvhZI3rG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef90227-30e1-49c9-24e0-08db24a0a61d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 15:27:40.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGO4mUF3lqqTZJS8zRwPIXPKQLKf73e9wvXWczqApYG/IBfJAv2iDIA4STRh19OB1eD+szjchAL2nJ+lPHMLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14-Mar-23 5:09 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 10, 2023 at 12:04:03PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Mar 10, 2023 at 03:28:03PM +0530, Ravi Bangoria escreveu:
>>>> It requires samples satisfy all the filter expressions otherwise it'd
>>>> drop the sample.  IOW filter expressions are connected with logical AND
>>>> operations unless they used "||" explicitly.  So if user has something
>>>> like 'A, B || C, D', then BOTH A and D should be true AND either B or C
>>>> also needs to be true.
>>>>
>>>> Essentially the BPF filter expression is:
>>>>
>>>>   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
>>>>
>>>> The <term> can be one of:
>>>>   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
>>>>   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
>>>>   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
>>>>   mem_dtlb, mem_blk, mem_hops
>>>>
>>>> The <operator> can be one of:
>>>>   ==, !=, >, >=, <, <=, &
>>>>
>>>> The <value> can be one of:
>>>>   <number> (for any term)
>>>>   na, load, store, pfetch, exec (for mem_op)
>>>>   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>>>>   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>>>>   remote (for mem_remote)
>>>>   na, locked (for mem_locked)
>>>>   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
>>>>   na, by_data, by_addr (for mem_blk)
>>>>   hops0, hops1, hops2, hops3 (for mem_hops)
>>>
>>> I think this and few examples should be added in perf-record man page.
>>
>> Agreed, and even mentioning cases where it overcome problems like the
>> filtering you mentioned for AMD systems.
> 
> So, what do you think is best? Wait for v5 or apply v4 and then add
> documentation and other touches as followup patches?

I'm fine with both :)

Thanks,
Ravi
