Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E54535418
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 21:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiEZTsy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 15:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiEZTsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 15:48:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846767092F
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 12:48:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QJ6pF7022317;
        Thu, 26 May 2022 12:48:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : to :
 cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=DH6tKAUrqossR/RiFVcWxjwxFZh3k/HtMSDHudRzTbU=;
 b=ak4UMvzz85xwneizBCjWkhM2UgmohYUQ+xfATI7uciwawAM31+pXDz32WTcVJnX5g8Tj
 6+4KCuviGI7vcezaBSMAUZ6dU1GqTn1AG3NpPBBvoXfG5YzK7yL0At6BEbPcl9Fvlt2a
 xgl5WxbVxBDBunMqj8YYEB5/dp5nYsMClVw= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9puasd2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 12:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf3E/L+q4/FlZwLKLqhhXZqWi2S3qZpLGs/3jSoVOYOv5Q+zfABZ9feBxXJzOSHvBcxeDmNQ6VPZ3uZmCz6yRRaCi2Xn4rKjfwjRJY0M/qjgUsW8dezU2QweXQ2jOxOChwrCyV+/SP2n7H0Yk0LGsZrkhGetAtZtQ1WP5SX65BWWq8eW5vxm3M14GHuGC8BIqCTKWgnXfEYmBlyKEkrOJwitZNs9U1TG+yteRp6SJttNllyB3T6sXj0km0I5aJv/aftDOj3Y76Fr9pljiUDqKOYWadlGv58fSu77ALJf/ubQr09Qfs4AprBmbtsCm0zTnWMorNlCWqo92cYUjhyhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH6tKAUrqossR/RiFVcWxjwxFZh3k/HtMSDHudRzTbU=;
 b=jLaS63z31XzjmOrPx9Gk8SQTPgwWDfTHRGHxkfjPgmkkuk7+21ngG9vhsZ7QYbd+akrrdsVb0Ucxptll5nycvgDVN1eYG/qXMMhMrq6LQNTC52EPGmS2/80VMp5OwycYujf2gPQqqqh8nGY/qDkwRKzyFH2h7a/bgHHhw+HxpzJFjycE/WMEQonUncEJpAM2+Y/pvkkt+ta0N2eFFmZZbSYT49S9N0xVfyxlLgUVe2+vq+rd3zs6YKNu6Hx3ESr+gwr630jnDEhefsJd4ZjUIybEaH5IhkRbMsUTt8v6HGONMV8VrALxmf6EUcSIvYVAiDzjn6/vdsB8x7sdDGaPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5444.namprd15.prod.outlook.com (2603:10b6:208:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 19:48:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 19:48:45 +0000
Message-ID: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
Date:   Thu, 26 May 2022 12:48:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Content-Language: en-US
To:     masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
From:   Yonghong Song <yhs@fb.com>
Subject: help to debug a kretprobe_dispatcher issue with 5.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe9fb35-54cf-488e-6225-08da3f50be84
X-MS-TrafficTypeDiagnostic: IA1PR15MB5444:EE_
X-Microsoft-Antispam-PRVS: <IA1PR15MB5444243BCB7BDCFB0D347505D3D99@IA1PR15MB5444.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ae3MeVs389Eo1mi1iBfLy1MV9KNLjtPuhSQ2idukO4vvpNUCGgaUs7ju4o/q45BR9w56xX6kpnlTYWZ5d9NAkj230OTVZO+HMTpeNE755iTFELASzq3ay5o2jOx/jPmC9mgjWq8mg1R/FSOyCY998pV2MNZMVa0KJpILRDEvHDPBIO4YGUa7yxEUmW+4n84Hw+WKsetair7gt/Wy3+kIyJtyywM4+oJKWxHm/u40afxD2CTzBtn0lg8xPHKkJ0Ppf9eQbxI4EHcD8tKM7E9FYTC6PQhlkR8Lzlg54awgYb9U3Xn1N7BLxKw2vy/dcZV/HLc7qCN0ZGv+325r9MmO21bq/Ob0Dqfz9BLWEPZXdMOh9dAFB1joK1ksVHnYol3t1U4FuBBnsuYJbqwXCf3lVRhPcgNkzqSEpk6CATQP+GEd5U+Wc+MPyYUPI/sah1oPSgkWUQlfGxNuDtb9XinQhL16fy62Kre4x/LnKUioalG4nIm5TKkYOKNrAl17ZDVjvEV/2NZHuID9UyBFUTuofkrFUob2+itNF2ct4SgzVIIv3zpDGexEdplVpEseB31XlWsLhI4YSP3Is/NLhPOctFDQprpVO0syJd2nzo+VqNPntPTyynV7/Z2xnUmOyzwzE66PxB+ZZHrSE62Ern6JgwyCWVgMQCPEj8Vm+h4WeYwErLAqOMUizOUNO45MRgpJbZtq3vL0WBtwiae8uIG1f/xuw2+GKa7ADqHqnzDdfls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66556008)(186003)(8676002)(31686004)(2616005)(83380400001)(52116002)(66946007)(8936002)(5660300002)(86362001)(38100700002)(6512007)(4326008)(6666004)(6506007)(31696002)(316002)(2906002)(54906003)(110136005)(66476007)(508600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2F6WGhoQm0wZTlVK2MyUzErL04zaWZaaGRUUzhRWU5Hc0podys0ZVg1WDBp?=
 =?utf-8?B?a2M5RkpMUG9vZkNVN1dwdGlkZjRmdFZjMmtDY0ZyUm8zR3phS2M2MUN6QnJD?=
 =?utf-8?B?aUg5ekNVbFllU0FUdlRWM1Vic1Nvb0tubWtKNGhRd3Q4dUpvb2NDVlE1aFRi?=
 =?utf-8?B?dGZGU3FJSE5uajBLdUVMNndOV01QLzhQN24xcUFQd2JGOHdLOGZ5N3RpRzNx?=
 =?utf-8?B?RDJzWVgvYU5YdDNNSDBCaWdoWTJ5d0JWak1WRmtOSkVvOFB2TG1Ic05sV3h6?=
 =?utf-8?B?ZkYvUHZFb2U2NFZDQUVZM2tPNm92Z2NtMitxNmhTYzBzVSs0UnFQK01PNEpZ?=
 =?utf-8?B?Qy9LUDlGcWk0bEZ4eTNTOHpjYmdqQUo5OG1TWUhvaEdpWGtENWJkRzdvNHBP?=
 =?utf-8?B?WVYxSncyTXNoRE50NjZ0S1dxUzFhZk5DSDJKNlBHMy9zRFgzZ2JHOUJEeUNF?=
 =?utf-8?B?VHBNMUd1RWZNaysxdEdrcDV1L2JXMlA1TlJVU3VtRnZaQU0ySVlqOEE5NW5E?=
 =?utf-8?B?QUZteXlpYUtrRkx0U2JsV0tBcEFGWVEyc2ZOTkw1UjVNM3VucmRldEdQVHNN?=
 =?utf-8?B?TjVNR1ZKdHlHeG1odTlwN1NCNlVDV2tQeDBhWEpjL3V0aVN3OUk2S1dYMjJh?=
 =?utf-8?B?VGVUMnlWSUhvT2U2bnpoTnlyUHBEOXMvbDF6UiswbWxlVjFNZFAwYlR0ZmQ2?=
 =?utf-8?B?a2lhWlNCVlhlYWxWeXNLa2x3a0JJTDdNVEFaRlNXZC9kd1hmbFNvRkExeWpI?=
 =?utf-8?B?M1R0SE80T09WU1Zxb0xZRkFTMUNhUnE0VmFmQ2JmUkljd0cxTklsbjQ2UUgy?=
 =?utf-8?B?ZzU3VkRnWnhUMHNOS3BEVGdqbEI5QXM1VE5CNEwya25aT1hGSDdTN1M2N0xY?=
 =?utf-8?B?Zm9hUUgxK1g3TEt1NlZsZWtaNGlUSVVBT3hsNE55ZFdkU2xMaEppY3BqQnRO?=
 =?utf-8?B?UmpzYXpFbFArRHhyOXE0Y1FLNFd5ZGNQOUZQYlNDeHVGTmZGeDhxa3ZaOWxo?=
 =?utf-8?B?WG4xcFFaMlhTMGQzNUFHVHlxWEVtZ0dBeHhNa055ZXVWMGF1TnB4c09xVmRE?=
 =?utf-8?B?ankyanh2RTJLRWRNM1VBbjNlczJIbC9zVnUwRFFRaUI4N3d5YUdjVVFvdUla?=
 =?utf-8?B?SU1NbTBoamNwT3ZxNFpQUnFRendlQlgzVnlyRHA2MmllbXgreXNyS3hlT29u?=
 =?utf-8?B?TkpSSUQ1aUtxK2FuTnN1L2JsTFA3WWVKSkMwTFpGeVlWTEs1Qmx1STgyYUli?=
 =?utf-8?B?Y0dKdmUrWmZocW1hS2pTdkJXQ2RwZXRwUTNEVG1JMyt5T1NTRFNMS0srZ21m?=
 =?utf-8?B?MlNRVXpkVlc2S3VWSTRrRjlKSng1SHBLc0tuUVI1aEFhSzhGQmxhNC9PYkE2?=
 =?utf-8?B?WDRUcS9XMk9SUThCL3BtRXRPWVY4LzJXWTNGM0Q5aXIyQTlodmFyckVRendN?=
 =?utf-8?B?K2hXdHJKODlTQnROVE1GNFNxenhMeUFTVVR3VkZ0SjZBcjBKaVdSdGMrUXI4?=
 =?utf-8?B?OGJURnpuOGk5ejZZdjF5Q1UxT29YYmlzWDdzck0rdVZ5MDBoQ08xeVgzWFVi?=
 =?utf-8?B?M1VTSE9nbnd2bmM3L2FQUk02cWM1bUdtQkRob2ZNQ2xHeFpTQWM3cnJaK29N?=
 =?utf-8?B?UmtZRmVzWDQyV08xNGc2MUhTdkhpNHNkbHAwK1QvSHRRVEJJRlNCcTV6N3I0?=
 =?utf-8?B?WUdvV0xjSFp2SC9Ta2Q2VldBWHdwQk12czJGU2htZUxrQXVjZFZLK0V1RVpl?=
 =?utf-8?B?UzBoRFpaZEkwNEkzZnFYQjBhTG5IY3Y3ODJ0K3pWMk45V1N5L2tHcXdOSjJC?=
 =?utf-8?B?aXFrcm9zWXdhSXBybmQvNHQxYlliN1phN0ZGWjFXV1F6WTVGeDBDa1MvQ0NB?=
 =?utf-8?B?UUxCSDBhMW5MZWkzL3hWVnpyeWV3V1hGWERzOUhhSHo2RHd3L2NESnFKeWFN?=
 =?utf-8?B?VHQrbUhpN2JXQnp4WGdDV0J3dENpeEFNN3pGZHdQcWIwVjVvcXdlTjRNSzU4?=
 =?utf-8?B?bTRzWk1XVDdFem8wR0tvZTlvTDVhejZmdFdQdW5Jd1d2cXNOZnhCUFgvLy9h?=
 =?utf-8?B?STlvSDNJQk41enZ6NitmZkVydmNqMVhrWlptKzFXMWwwcVRmdHJYeXUyNlda?=
 =?utf-8?B?MUEyRTNqT0xXbnBWN1FhTTBTa3hkbGhpRmFhOGk2TFR1Wlo0eDJxZngwOCtB?=
 =?utf-8?B?UzZvY3UvdFpodEZKaHlYVWpscnlSRVJtSXNyUS9aNm9JaXdSWmcxMlVtZVhr?=
 =?utf-8?B?dThVdXVYRFZuNjhxeE9CbnMwSEFCZmZiZ2hERTdoMXo3enpqdkVuc3VEdzNS?=
 =?utf-8?B?MFRTVlJjT0ViV1orMTRPaXZaWnVCNGpjb1lCeXVPVExZWmJ4S1dFVFQ2dkxT?=
 =?utf-8?Q?WokLja8GSdDRB0bA=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe9fb35-54cf-488e-6225-08da3f50be84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:48:45.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOVFuishVNsvnX0oyBPanuKROIVkWVvrBKgYTrJL4cIEQ0T6OBNs4I9okhDoFk5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5444
X-Proofpoint-GUID: ZNcJJhnhNqFgfrdHi3v3osZh9-jDVXer
X-Proofpoint-ORIG-GUID: ZNcJJhnhNqFgfrdHi3v3osZh9-jDVXer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_10,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Masami,

In our production servers, with 5.12, we hit an oops like below:

Backtrace:
#0  kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1744:2)
#1  __kretprobe_trampoline_handler (kernel/kprobes.c:1960:4)
#2  kretprobe_trampoline_handler (include/linux/kprobes.h:219:8)
#3  trampoline_handler (arch/x86/kernel/kprobes/core.c:846:2)
#4  __kretprobe_trampoline+0x2a/0x4b
#5  0xffffffff810c91e0
Dmesg:
...
[1435716.133501] BUG: kernel NULL pointer dereference, address: 
00000000000000a0
[1435716.147783] #PF: supervisor read access in kernel mode
[1435716.158411] #PF: error_code(0x0000) - not-present page
[1435716.169039] PGD 6df216067 P4D 6df216067 PUD 6aad80067 PMD 0
[1435716.180714] Oops: 0000 [#1] SMP
[1435716.187343] CPU: 19 PID: 3139400 Comm: tupperware-agen Kdump: 
loaded Tainted: G S         O  K   5.12.0-0_fbk5_clang_4818_g9939bf8c1268 #1
[1435716.212570] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive 
MP, BIOS YMM16 05/24/2021
[1435716.229803] RIP: 0010:kretprobe_dispatcher+0x16/0x70
[1435716.240089] Code: b5 3d 00 48 8b 83 d8 00 00 00 8b 00 eb d8 31 c0 
5b 41 5e c3 41 57 41 56 53 49 89 f6 48 89 fb 48 8b 47 18 48 8b 00 4c 8d 
78 e8 <48> 8b 88 a0 00 00 00 65 48 ff 01 48 8b 80 c0 00 00 00 8b 00 a8 01
[1435716.278001] RSP: 0018:ffffc90001d77db8 EFLAGS: 00010286
[1435716.288797] RAX: 0000000000000000 RBX: ffff8884b586fa00 RCX: 
0000000000000000
[1435716.303416] RDX: 0000000000000001 RSI: ffffc90001d77e30 RDI: 
ffff8884b586fa00
[1435716.318037] RBP: ffff8884b586fa10 R08: 0000000000000078 R09: 
ffff888450a944b0
[1435716.332659] R10: 0000000000000013 R11: ffffffff82c56d38 R12: 
ffff888765e5ae00
[1435716.347278] R13: ffff8884b586fa10 R14: ffffc90001d77e30 R15: 
ffffffffffffffe8
[1435716.361896] FS:  00007f3897afd700(0000) GS:ffff88885fcc0000(0000) 
knlGS:0000000000000000
[1435716.378427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1435716.390264] CR2: 00000000000000a0 CR3: 0000000674c5f003 CR4: 
00000000007706e0
[1435716.404882] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[1435716.419502] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[1435716.434121] PKRU: 55555554
[1435716.439876] Call Trace:

Our 5.12 is not exactly the upstream stable 5.12, which contains some 
additional backport. But I checked kernel/trace, kernel/events and 
arch/x86 directory, we didn't add any major changes except some bpf
changes which I think should not trigger the above oops.

Further code analysis (through checking asm codes) find the issue
is below:

static nokprobe_inline struct kretprobe *get_kretprobe(struct 
kretprobe_instance *ri)
{
         RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
                 "Kretprobe is accessed from instance under preemptive 
context");

         return READ_ONCE(ri->rph->rp);
}

static int
kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
{
         struct kretprobe *rp = get_kretprobe(ri);
             <=== rp is a NULL pointer here
         struct trace_kprobe *tk = container_of(rp, struct trace_kprobe, 
rp);

         raw_cpu_inc(*tk->nhit);
         ...
}

It looks like 'rp' is a NULL pointer at the time of failure. And the
only places I found 'rp' could be NULL is in unregister_kretprobes.

void unregister_kretprobes(struct kretprobe **rps, int num)
{
         int i;

         if (num <= 0)
                 return;
         mutex_lock(&kprobe_mutex);
         for (i = 0; i < num; i++) {
                 if (__unregister_kprobe_top(&rps[i]->kp) < 0)
                         rps[i]->kp.addr = NULL;
                 rps[i]->rph->rp = NULL;
         }
         mutex_unlock(&kprobe_mutex);
         ...
}

So I suspect there is a race condition between kretprobe_dispatcher()
(or higher level kretprobe_trampoline_handler()) and 
unregister_kretprobes(). I looked at kernel/trace code and had not
found an obvious race yet. I will continue to check.
But at the same time, I would like to seek some expert advice to see
whether you are aware of any potential issues in 5.12 or not and where
are possible places I should focus on to add debug codes for experiments.

Thanks!

Yonghong
