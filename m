Return-Path: <bpf+bounces-7099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CAF771571
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5650F281273
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8C523B;
	Sun,  6 Aug 2023 13:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBB3FDD;
	Sun,  6 Aug 2023 13:48:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A00E8;
	Sun,  6 Aug 2023 06:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN7FZSPwqyw1+Z/n5q4R0nL+ygm9bacFXWZMPYZ4fwsRTfCKI75aiUItJw+3aE96YWQKWbXwVZfd48H9i7mItIqBhZ3SHrG63ZM/D8vNtM+r5tS0VpA6uDa4wKYCIljMWAPlSXSIq5Z42DlLHwJh8ytFGeoi1b9sV3o+dgrwUmyN0Hlb/rYa+0nbzOASIX316VGTu88ERwz6rqQnGZt6zKsnHcgSdKZbLXwogzQRSJHhPvZ5wxlAGAK7YWsf6QkMTyQ83tzHum/t7qv72MHK2zyjzycVMAG5I65SBp3Lr2YhB6g6ge9WbTh9dF6AFYQ9bHQQYfHr1i8R1eID0d7rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAZ4jYHRT/WaXyVv8Zmc3nqH0+cV31l6nhqQv1IU0GM=;
 b=Ntu05zVVDd9Rl0/gr91P6v8uQqJvEhKc5vuwVxDjUgZiuiuyK72VdYkY/45LoaTLN63v8tCQhwt+ikvEuKhuXfNv+UmieqFe3kHBX6Tnh5nRfa7jMbJi0PZZUW4LPX0hNXVh20oRrbs/3SLa9bvq0ScuHkVWHYS0L6QyqN8fnJgzXPbkzMOwBGcDsKHP6mc7hxWXQn16iNZdKkw2lyaV64sCpY3OBeeQrh92NB5MW79yAHdSML1cCnly/UsRYAL5SK5/ge0yJ6XslKx7jGQO7CJO7FRGkPfVYqUyH+tnKnlndfCpLVTexu8GxGQYDhv+Jytmn1Gf5lclBsYmy+hwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAZ4jYHRT/WaXyVv8Zmc3nqH0+cV31l6nhqQv1IU0GM=;
 b=T0kJUsvey5ERR/Umk8FPynxLYvDrIcfxw4cjLovyp32j1gqVubJPeNYin6JG/JMwfsBgdbgvmkCxRBAPk2VHPwqaSA1wTZvQQ4zaG2ZaEaj3WWjTEa87YGcDXHEibuwZlEOAQ7XopliG3zpNEz7tW2JJRDHUxFNrc3Cefjuf4soBQJ3UQTlqOj7Cqg/BHc1yRPbrO4y6gIQXLef7rl8zReV8o8rVMdQ/cLU6yFzfJx3WYUGWzAXQZq7HVU+RM1GAVYQUwmr27i0CQERIPk+5K7F2wytmNnI/IDZV5H+546K/5CRoxzDylJiQCdL3nSgR+4Fb4uDYQMnbaHVMgWWTTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 13:48:04 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 13:48:04 +0000
Message-ID: <aa2a2ab1-1058-df2a-9fbb-19dd4f5edcd4@nvidia.com>
Date: Sun, 6 Aug 2023 16:47:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuba@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
 <5247bfae-c0fc-99e0-04a4-55e2019bfdc7@linux.dev>
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <5247bfae-c0fc-99e0-04a4-55e2019bfdc7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: c8129cfd-6d9c-4573-6146-08db9683c1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQoWbI4doHugeqD1bQe61cddbUiBM5BXOGO/CtaDvJzpabFSN7OPdz8GeBSloKJNAnzB0undNdzlhlBRq9wv7608GWy2iUOMbZosy0ukYASbruy3Z6M7bRaUI6uth9sPkkEdcjJvYh+5tgFI9h6qrLofGpa3LUK0tUJgcQLoyDJ1ox2kGXk+Xjf7fluDitIcUS2VeSkBs7RdktMSVANMlnYRULaeMlcPxso0WQfHJ8tRJq/KktaPz0V+V4vnLLrB5xFW/W7ac5iPI49um8ygH3LEQEp1EgEosnxZRvcn8W6BeONf/GRzEXDf0C4pUXapaUG59PV8Ardgcjcl0FZxIrZZe0NxZmfsvyTPGwU4Mj3x+rEWl22eDnqFrvEoqOGz77pifkB9Sv3WT5StOq6k9x2aUrlCL/q8tLYpxfTqRJHUH+QJt0gc88xxus4UPUNx4cmY9iNOmC7A8NDW7GB/Fg0BFVM9vANFDrfGqgsPvhN+Gf+wXUwvYSAMhDfBWEiVBsYklXUagGzGESQ+TkkKpvQM4MNkLfcXY5AVRJWbzcoerYlqeFS/yrMfD/VE0stAEF8ClNKoXFJ5/gyQK0QHv0N9vEP6GHXEItVE/afAzxxIbTadmhvrxRlWDKRlYtr/EMRT2+TtjeC52gAWOd8aBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(84040400005)(1800799003)(186006)(451199021)(83380400001)(31686004)(2616005)(38100700002)(2906002)(6916009)(4326008)(5660300002)(316002)(8936002)(8676002)(66946007)(66556008)(66476007)(86362001)(6512007)(478600001)(31696002)(6666004)(6486002)(41300700001)(36756003)(6506007)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1g1bnZSZmxuZ0Q0bGY4SUhpckVPVGdaS1VHb0pCanFCdnJnOS9rd0dQakVa?=
 =?utf-8?B?cy9BK0piTkczQmRhOXN6SlJKTkdDNzMxQkF4YmFZdXFqVG8xcDNoYURzbXdU?=
 =?utf-8?B?R1grcmgzanp0dEFNM043eFdIcHg3Ym11eWxVMW55VkE5MVFYTlhQZXR6ZEpD?=
 =?utf-8?B?TG91VWU5WU42UVdnU3o3WU5TTGxneVZIOHhIRDFDd0VrUmNkY3Q5VzJqczJn?=
 =?utf-8?B?R3ZmWDJ1ZTh5c3NEN2JSd09tMzNmS0d3ekxWN3UyUmJYNDk5dFppWjVoNFFO?=
 =?utf-8?B?STNPYzRIbktLVTdQanJYR3Qwb3RLRDluOGhyV2lFcG0rZHIwT0JlSW9DNXVq?=
 =?utf-8?B?dkhrTmc2ZDFkWld5TVhUMno2bVFlMGxuMlVQUWNLcExoOFpxbG5tZ0FOTFBy?=
 =?utf-8?B?Mllab0taS0ZWc1ozc0tFMGt1VEZBMzRCSEN0dGRnVzNtSGdxaHVZNjUvd280?=
 =?utf-8?B?UTNuQkRBckpldThyS0x3L25XVUpnVTFJZ0tHRDRZOFV6dHRlbTlNdk9PakI1?=
 =?utf-8?B?WFg4OHJodncrcHJGWlZ1KzMrMUFjSXl0VjdBaDdENmYzZDBjZkplN21lWHpl?=
 =?utf-8?B?RU4vdWYwVDJrOXVkYllXNEMyN1VhMzhSKzMyZFZXQWRKMGVvVGc0VlBQYStI?=
 =?utf-8?B?Tk9BU3BMb3BzOU5mazlRcWJXb0lkaURaaThoSlI1Ny9ycU4yLzdJNDd6SEQx?=
 =?utf-8?B?RWVkOTR1K1RzZGxhTnlVamRkOEM3VmIwOC9lUWRPazNHUXo5eUtEbmJlN3dZ?=
 =?utf-8?B?QzdGcERLa014UXIzdGdCQkM2czBKODBVbXBNUStMSHhlcTduMHhHWFZ3cG5i?=
 =?utf-8?B?SG1JaUpXTmZqTHVzUURCRUlhOUl2bW8rank3VUV0VVBwTmhKektMcnduR3FK?=
 =?utf-8?B?T3lRQkdKZGRsR0M4TTlhWThoc0ZGQlRPQ3FhZHNyNjMrczZVTFUvUjg5Z0VY?=
 =?utf-8?B?YTVqMVU4eEpydE9YMlN3VkwzbUJlL2dla1l6bk44Qm1ycXl4Sm9VeFBxRmtq?=
 =?utf-8?B?R3JXc3p4bmdGNDQ3NmtwWjJ1STJtbGFRckN2WmZITUI4R1N0YVhnZENucy9a?=
 =?utf-8?B?SU9DbEdwRWhSWUFkRklyTU5xcGExMkswcTVHcmwzcC9ndFljRC9tN2tvdEdC?=
 =?utf-8?B?Z0ZyMkZuS0hoTG9ja2JmeHpLTFJTTjNVK254bjJEZVdQT3BMMDVrYTBxdUI0?=
 =?utf-8?B?eEtwVUk0UHRaWEpya3ZOMlJESG0wY1BHNmdlSHFjdm15OHpPcnhzMkFPL04r?=
 =?utf-8?B?MUdJZnVhSkREUmVEV1BHRGNXeTBRZi9PNVRNekRITkJXZGxzdnY1UXVtR1kv?=
 =?utf-8?B?d0VGUTNtUVdDaUtHcmtPWWZTUDUxTWhZbHFZa1VaRC9FQWhUak9hZXBiUC9F?=
 =?utf-8?B?dnluakF6RDUvVWY3U09lbi80cUF1Z0ZsTUdOaHhwbFBsb3NpYklxSjhubENw?=
 =?utf-8?B?WEtqLzVmQXhPQXlnem1DNStSNEpmWE1VdjhRRXUycE1IQjAvYk1BT2E1Y01T?=
 =?utf-8?B?VmdFNHQvZmxTUGE4KzMzN0JnblNXQmtmUnpBaXY1Q05YeHMrWjNmSWl1REZo?=
 =?utf-8?B?SnN2eWxjaExHSEI5TUlQZjl6aklZcGVKdFRBb1FXbjV3bkVOc29DU3JGWC9Y?=
 =?utf-8?B?UmduVTM3ZXlsK1BSM3NYWlhtY0N0Y09GOSszRS93blNXSlBsb1laM05ZRnNE?=
 =?utf-8?B?dWZGUG00dUU1YWZkdURJY2tFU09aQnZmS24vY1V6Mk0rQ0NqUVlRNFZyS1Ro?=
 =?utf-8?B?N3REcTdaTVdRWDlXNUxXYmZndXhkTnF6dTNRTlVCUzA1ZmNCbVNSSFhkcUsr?=
 =?utf-8?B?Tk9qNFBXMHFoRFVMaVBjdDkvalQ1eUg5amJCWlhhMWllUmo3Nk42bWZMTnNX?=
 =?utf-8?B?aDBrMnJWSWR5MGtSV21iaDF3RExvcSs4ZDdJeVFFM25pQlJPaUdVTXNubkF1?=
 =?utf-8?B?UVU4T1lsSUFORTAreW9vZndaY0JTTi9rWUE4dFRPMGdMSkYvTDdOUDk4OERD?=
 =?utf-8?B?YU9SUEs3TVVVRXlHNTJqUUxuT0pvQm9kbmdHMk1rZWtDazBwWHNtNlBOWklw?=
 =?utf-8?B?empHNFVFRlBEKzBqelV4MElJRnZNcUUrMGJPeFFzbEVmSTVBNXIrRVZhbFNl?=
 =?utf-8?Q?M4CjZuD2nkeN4SBWR/0lvjVdu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8129cfd-6d9c-4573-6146-08db9683c1dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 13:48:04.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc54JZfMatO4yo2VWRAxS9NgBsvrZhtioOBBkUrPsMxgjbGqXVHOetLUQ3w6kAHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 2:48, Martin KaFai Lau wrote:
> On 8/3/23 4:10 AM, Gal Pressman wrote:
>> On 22/07/2023 2:33, Daniel Borkmann wrote:
>>> On qdisc destruction, the ingress_destroy() needs to update the correct
>>> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
>>> Therefore, fix the typo.
>>>
>>> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with
>>> link support")
>>> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
>>> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
>>> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>
>> Hi Daniel,
>>
>> Our nightly regression testing picked up new memory leaks which were
>> bisected to this commit.
> 
> Thanks for the report. Can you help to check if it can be reproduced
> with the latest net-next which has a tcx fix in commit 079082c60aff
> ("tcx: Fix splat during dev unregister")?
> 

I think the issue is resolved after this patch, but we're still verifying.
Thanks!

