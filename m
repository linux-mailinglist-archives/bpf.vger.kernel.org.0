Return-Path: <bpf+bounces-7098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36377156C
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96781C20929
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488155239;
	Sun,  6 Aug 2023 13:47:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F128EF;
	Sun,  6 Aug 2023 13:47:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC868D8;
	Sun,  6 Aug 2023 06:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIqUNTsgIP5JXKxNr9hYYiVtqcf929BrR2a0aV2cqHCv3Fj8GkrSG1e2c0O4ycf330eEHGg/9m+IoXTHNdTdy/7m2fc8bsWzouxokuX6nEOErFRzBBbDpV1+Hm8tyNHdDR3lVFjfCc1UftU/E/rsKjt02E7yXi1IouhsRTbHjJ25lGsaqgo2k0O2WygMU/MvqnsYtAiz87KrLROAqFWaKr78vZq4PA5XzTzxsu+Ryia+jLf4EMra7m+1ew8R0dYW8jDdSZyeRUfKLX1OIqV+cN8pkTBNzv6h0+1tDSaN2zLkNDoz2MX4RhORpRqUhaYgDHPW7/MncuXEHupUiMjoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkGOe3ehavzvt3GdVNV+ZTXERnjis5o5qr4obdJKAhk=;
 b=bJs8fo+veNI3E+8HFIjVWP2sPOs2KyGQ1Nc6vBNk1VaM72hqplvKSowStVXMLge8yJwPj3Dew8mn0oPNCXvZ772FH1afAQW+NtschHQ7nhGvYie7DUzgOM70CXqvFDaSY3uENOMjdtp2e5kxdWdTuF53Zc3vxfxWkrVBSZ3xHjfU7YBYq9HTX/uvlKY77Ha79jEt0fh8NgrbU8LC6F9FCpPWwvmwmoZpI3LRHEXY+tE642YFgLKYgDVTBZ/pktFSZbtnnVT7wbLm9oQUha460D0vvcvZ4SKB5IZxqqA/fyEnRz4Jey+JyC4uk6sfSB9IklLEnJ3lUnRa7TrVn5adZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkGOe3ehavzvt3GdVNV+ZTXERnjis5o5qr4obdJKAhk=;
 b=NO/PKG+yZ6Dgr4/UW3VquUJe8AV5Zgb6txkrpPAJGbg/bnXwO5yJxf5ZWWbQFMANoMsAxlmRIC94Zw5hjdnoM44QLV4GCjBcR3p8b+wIcMInbR3pKccGi9DgOWBNj8uei5r05v/ZzQYOztV+JstJIo8mw4L6AFTm//+Sx7NdKeF41KDzgzfjSnsFFPgqfdeEmJoUUaSvu/+F3wTNsJ2G/yGCombS/XodydxodRis7IPbCDUz9gFmdnlkDCOrVWnQs2fhF+mFy766TvvlqAAd3agXZ5Sw6QSEyCNTZm00qOUroWdhG6G43oFE261CjdfxoCUjkE8VS8a7IdbTSnEGqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 13:47:10 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 13:47:10 +0000
Message-ID: <9589bcf9-56fd-5eca-adad-91bc11a21fd7@nvidia.com>
Date: Sun, 6 Aug 2023 16:47:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
To: Ido Schimmel <idosch@idosch.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com> <ZMz9u+yZtk8vf+OP@shredder>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <ZMz9u+yZtk8vf+OP@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: e1060d45-5f16-42f5-3c4f-08db9683a1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FurTXei5THSxpjwni3BpJS07+tBfJNZYH6YZmeynVAwHx798GKyohcUcaXTEfKc09UooCpAITD/p3iQEHLMPAxSjTo0hNFR6cknuKaq2sRjOYIgsLBe751KbO4lOQ6GdG1eToWilCfpyDx6/Cuv6U8mMcG8bC6yKPQjCsvLQeWc0kRnfjccCokG5/9HxmFnJnA0Uga03VX63CwFJ43fNum9oQBTZYekpQ5ugbd7+n5IfgxeTNkQOw4HSdZdVqXcywM3JDH4ZWRSlg5UP2F91N7wtpSDvRJww9AKf3oFaEdeqvK4WkeZnkDcBIT3f2ynhPFgj07CklZYTaYeBrL3rdjQjIZ/u5ukwb8xJPJnKJhYOGLgHZDn3fsN1TgP+iz0bmE4E0D7qcBuyCXwf4HMLW1Z3Fc441aeHEjAJorhrug6jKFarys+CviXebNcAkMmeQN4CRjnbSSFto9XB1XAICkj0Co8L1l2Yq7MQJOz/YIkaPWAs5DTPvFCfXRxJLakf2krTYoXfnjAeX5jUgMvFMiWg4btEwuaAOE5yYp3niKMJ2X2yav5TvsMwGApk6xUJwGOcgbU4Xxzee2qMfklXx7lnPolgITIoFj7giQP5J4lWmUfTHcpefIz7EyS95ZD7RZVZgK1KBjz+Sj8K/hibWmigdxhgxCZBj67HUykx2xOld9QqoYPMRcpaI/W0SK2s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(1800799003)(186006)(451199021)(83380400001)(31686004)(2616005)(38100700002)(2906002)(6916009)(4326008)(5660300002)(316002)(8936002)(8676002)(66946007)(66556008)(66476007)(966005)(86362001)(6512007)(478600001)(31696002)(6666004)(6486002)(41300700001)(36756003)(6506007)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhyRlBSUFdOckVqZ2lYbVpHZjhBVzFGS1ZscWVRMjVTY2k1cmpHTElNSkhC?=
 =?utf-8?B?RVhCQ0lNTjRycWhGUjBlbVJ1YmVvSExUUUxEZDc3NU42N25ldVZBb1JoK0xn?=
 =?utf-8?B?dkk0cjgzbzh5eURtMnEyZzBOOENRM3dpNGJpUm9NcXl5SmpUV0kwWHZZd1ph?=
 =?utf-8?B?M1hGd2g3MkNwd3JnNmtNMFpIZjFhU09MVjZYUnREc2NjdlV5U3FkTDZyc2ZX?=
 =?utf-8?B?ckU1WDk2RGhMRWJHRWJabHNpS1NFcjRmNm9HOXNWeUhHU3lVcldDb3FGK2hO?=
 =?utf-8?B?dTk3dEpZWjVRUkJTVzQ4T3NoMkcvZEpCbS9IWm5hSXJoR1ZZVE8wbTY0RUhl?=
 =?utf-8?B?WkNoN09hSzR2ZnZ3Y2wranVldFJEcUJUMmdwNXVlVWF0RGgrWUpTSURiRDRs?=
 =?utf-8?B?RUs4ZVNRUWJmeCs2ZzZ6N3NDb1lybGlWZ2UyL1JLMjBaVlRpZyswbTBrVEF1?=
 =?utf-8?B?V1ZLcjZGWnB5ZVM4WU5uWjJUS1JobTZ4TWxuejc3QTcyNGVXdGVTbkRsaDBH?=
 =?utf-8?B?by95QmZ2VUNqbERFMDI5ZUtwMXQyMXNnZlBwYVJCRUZ1ejd5OTNHWHo3aGND?=
 =?utf-8?B?OWJTU2ZEOFQ5YjYvanIyNnlyM1p1RVh0dVBOR3A1N2NQaE01Q0dia0FvVHh4?=
 =?utf-8?B?RERTWmhnd3RkZWphV25YdHZmR0dWcDdraHBmNmRHT3huZjNML2FZT2xBYmti?=
 =?utf-8?B?eW9xZ1FnTW8xMUVESVhCOHk0bE90SUZSbEMwYVVjZCt1Z1NCUzBDakJjYXBw?=
 =?utf-8?B?WTd3eVRBeExmaDRXODhEeDBNaHR4KzFhWmVCcXZrTUUxVWVSRGdVemhaUkxX?=
 =?utf-8?B?Q0ZwMFYvM0JkNm56c29KN3ZYdzJWWW9ZRTJoM1FEdnQwOWlYdWgrOHNWdHVq?=
 =?utf-8?B?UnNqUWxybXNTRCttMXNCdnZuV1VHMHNWUnpRTFdTWkUyUXpkeXQrZXJpdTVZ?=
 =?utf-8?B?aXM0VmhQSmEyQUJtSGdmSjZYaFphTGF3aVdKREVFTURNYlREdFFRRXJXVldh?=
 =?utf-8?B?T29nL2VpL1VKQzdVNzVOUDliSFhFWEhvZ29kMkkrNmUrMVFORUk5M1hTZ29R?=
 =?utf-8?B?aXJtOWkzbGdYbU1aRVZsUW9rcElxbktZWWx3S3J6M2xVQmcxOHl6NHZXVEVp?=
 =?utf-8?B?MG96REhrbi9YOEtZeEVOMXJ0dERQSi80cVYvVHk1cXhWZVo0dEhIc3R1SlJ0?=
 =?utf-8?B?eGZHK2FpRTRBZnFYZkhaOTc0Z0VsNDdQU0VQVzlWd2E5QVE1MGRLMnZMaVZs?=
 =?utf-8?B?djgrR1VDWll5bCtOVW1McXNDaC9LNTRtYmRyS2pxR0tvam0zN3hyTGdYYndr?=
 =?utf-8?B?NlpJVzVqNHhmTUZUM2hLbHNDeG1kMitreWQ4OG9Mbk0wL0o5Vk1YTzNMbzlU?=
 =?utf-8?B?bHdESmZzeGRORTNkc0c2UnNIeEJGL21iL0xMeWFVQ0JDTVAyb244QUE5d1g4?=
 =?utf-8?B?ZHhDbUx1enRrSHNvV2ZzczVxV3RnQnhET2RHWVlCYkFPaTYxa0M4UzVnLzND?=
 =?utf-8?B?dVJYTXBVVHIzemtGYVhzQmdlbzZSV1JscGNERk5jUzhmUk52QnFVWm1yb3Nw?=
 =?utf-8?B?SXJENmpycTR3bjhXQ2hkdW1WOVl2NzVUd1AzL2hTS2lZZjVaajluUDBNKzlz?=
 =?utf-8?B?TFFURzFldUpLRDRDTkdwTFVzSHpkU0NVaVNSUndIOW9MeE5OdkVXajUyR0ty?=
 =?utf-8?B?dXBDd2J0WkpzdFRTZGsyTFJPUWdDQnpFUUtFMUowNC8wNTBhR29VMHhkR2Jk?=
 =?utf-8?B?ekxxVkZjcDYvU3c3ZDI0MjJNSFZGenlSbVlucjMzc3NTTlAvR1pKcHN3MjZP?=
 =?utf-8?B?Z1l1VjR6Ulp1dW9qejhWbzByQXNKaVRxdUNOQzRMVU11TTVqNmp5TkRsWFNq?=
 =?utf-8?B?ZkNrbHJ5U2tKZGlud1pXU2tFUHoySEFTTEsrUnNRRUMrTGtCazFONXh6YjhZ?=
 =?utf-8?B?UXVsNjhuTnBXNytxUHNuNXRtc3BMc1pKZkcwZWZXeGxqckNWRTRXYjUwVlFa?=
 =?utf-8?B?SkhSNks2bExYNDRLUUNCczNJNU9MT0hDYWJmVU1zOUtTNENTbUhDZWJldUkz?=
 =?utf-8?B?S2VidXFzSk04dXBSQUpSTnF0dW1memZVcWh5V0ltcC9UYis4NlhINlBmd01F?=
 =?utf-8?Q?h1P3JDB+yy7qUx9+4WBMYcfeK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1060d45-5f16-42f5-3c4f-08db9683a1a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 13:47:10.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1rl+/WXnsHx58bZkfBE4SaUJ1f2EUUqhgqN4g85eHrt/MxXHtc6rwuFsDUNaib7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 16:31, Ido Schimmel wrote:
> On Thu, Aug 03, 2023 at 02:10:51PM +0300, Gal Pressman wrote:
>> Our nightly regression testing picked up new memory leaks which were
>> bisected to this commit.
>> Unfortunately, I do not know the exact repro steps to trigger it, maybe
>> the attached kmemeleak logs can help?
> 
> [...]
> 
>> unreferenced object 0xffff88812acdebc0 (size 16):
>>   comm "umount.nfs", pid 11626, jiffies 4295354796 (age 45.472s)
>>   hex dump (first 16 bytes):
>>     73 65 72 76 65 72 2d 32 00 eb cd 2a 81 88 ff ff  server-2...*....
>>   backtrace:
>>     [<0000000010fb5130>] __kmalloc_node_track_caller+0x4c/0x170
>>     [<00000000b866a733>] kvasprintf+0xb0/0x130
>>     [<00000000b3564fca>] kasprintf+0xa6/0xd0
>>     [<00000000f01d6cb3>] nfs_sysfs_move_sb_to_server+0x49/0xd0
>>     [<000000009608708f>] nfs_kill_super+0x5f/0x90
>>     [<0000000090d4108b>] deactivate_locked_super+0x80/0x130
>>     [<000000000856aeb1>] cleanup_mnt+0x258/0x370
>>     [<0000000040582e39>] task_work_run+0x12c/0x210
>>     [<00000000378ea041>] exit_to_user_mode_prepare+0x1a0/0x1b0
>>     [<00000000025e63dd>] syscall_exit_to_user_mode+0x19/0x50
>>     [<00000000f34ad3ee>] do_syscall_64+0x4a/0x90
>>     [<000000009d3e2403>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> This one is caused by commit 1c7251187dc0 ("NFS: add superblock sysfs
> entries") and fixed by [1], so I'm not sure the bisection result is
> reliable.
> 
> [1] https://lore.kernel.org/linux-nfs/6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com/

Thanks, maybe there is more than one issue lurking.
We ran the bisect a few times, it always came back to this commit.

