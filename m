Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2629600657
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJQFe0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 01:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJQFeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 01:34:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0C324
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 22:34:20 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29GIk8Lc009831;
        Sun, 16 Oct 2022 22:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=WGDHm7Qqp1iy3dXyn0DQi/EC8lsUgA782dI6mKy5Umo=;
 b=l341ZtHhvvleEeORnB1vIna+KPaEco7a+KQIHbZdyfX8kSlfMvGqyo6J+VgZj66BYtSo
 84M0vyEuF2uCX/Gcwk+X5WlfNxAeZJ7aeSR4CRuPcPLop3gScrDhm+bVC/UYTfa8kb0n
 /2vxrkp2RjrcTpeu2w0E7KUYxuVKEzAPp5gQZ8elr86n+XvZtQNNTEDhda2Lb+OJi1ua
 SoeO7stgSw8Gh0Svt2lCipWRH+fFmOV+uIba/mS4Ckp0SKAt/mZYUHi9dWQkgwqpBKhA
 iYIbmV0pHICw7Ps8hL3qJ7yIBC9gXoVjkg8kiTvkLlwWS3Q+mWFE5XRdCFbHMd19dLQN rQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7tpuvja5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 22:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjgb+HmZlUTq7+eBUvuDmpalAXh8OEVhRVWDoq1z9m7eIMIB8525d9BbFu4Hq+ZzzCb+IXHlsjZkKSL7+U7xwJECvsNCViTUKCvuzvOW52B0JseVJnWEZ0GvD5Gm/t3Apdo1ErtPcXxe3B57VlLbXb3QqSAjWM/XYo3DNUMl5nzJRrnN/MratToZjXegvp31uV0itPsf24PUTcypZZuF77sb/PyINGrVYelXbPPFCY5JJnsqTbafHksC2s+O8kSrG0wU+0TsVeywkrj9oYdcqTny+xn9z2DyifOb98P/o6f/5jjVm6AW2sdYm329hQ8C8rPpRuj/eeuL8y1fF4rLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGDHm7Qqp1iy3dXyn0DQi/EC8lsUgA782dI6mKy5Umo=;
 b=cC1UOjy1/JYvdJzbXNLKp80Z13G91EHdhtWPYS4h15z9O9rNVw+GdxHrDzLU2+1TWltDEcU/CWZ1xW8A9dUuWSBnxvIC/tUQEy0Op5n81Mn/E5lThAbx8FguXD+/O091OCjqRmyFjShBGsc1mNmZvLtGh7yKNwA5FbTNbCn1nT6u4fIIG3cT3/rPhWKNmuMdRW1edJiBM5vJ+MqsguVAZSEhc9cm4Wt1DvoJtJULYPNoobrHrLHVuxs1bjlgmT/lOJSmIy7AK0r5SW6WCb/4al1ON1ntkJZplWj7vMackpMIFngY6JalxYD/Z+ZRMN9bIFnYtYdvFso12WrNuI+j9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4467.namprd15.prod.outlook.com (2603:10b6:806:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 05:34:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 05:34:01 +0000
Message-ID: <d1379e3f-a64d-8c27-9b77-f6de085ce498@meta.com>
Date:   Sun, 16 Oct 2022 22:33:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced
 in func_proto
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
References: <20221015002444.2680969-1-sdf@google.com>
 <20221015002444.2680969-2-sdf@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221015002444.2680969-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:208:134::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 043f9896-6f94-441e-ad3d-08dab001326a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB85E2rp2SC/YhcM1Ajn7v9fURcOFd8i/Z8c9++AKOGU8NeOD4wIs0L0fbpnNMpGM5OPywgpv66CR9Qfx/cwVk4GiZzy1UDuHuhfWFiJRwoC7D9o11Iv9jlHh9SCcWlN2fGBpByb0S/CgtMrI9ewn+t6F3ExQ4DXTi20OQ7MYQJq6wB/Vqzl7alQwReCqj16ukLuJkRIj1P30W2RX3D1sYYQlPiZZhIR7hgV5te1FyH44patbQNFpG/IJt7YK3QL40co9fSVG2xkCe6iBY/GzcRcFt4x6nx73y9iw+h2BdEFYBwKokWTFL+wB9X/+qIrsRQjzFBX4qB3azVAdNTiZEs+SF9tQaHbeXlBv6qARwpG8IXBa8q7sC2yAgg4z+Qlbew4aoj34aQ58lDyGIY/aOv4iKj39i83y9FqipaYJ5Xss0qxjV+wRawFpV20SE8jEGcG5a/cL6K+h4O9boQylvFc6fco1mpePzJG0FP8gzE+7Q3RTenX067sHyueLQoNieorwbdQp047TuOQGDG9nXIlroUoTu9bP+DTuHGzxWSHIHVfOyBbVmXcwTkQkHxzFNlM+bEDkG8Ud44RdqdLEZgu6iVQKtMNoOaR4ehTN1rwpp0GxMm93e9onEHGvSqUPmeBK/rH7x7vFozqVuJYVX0CtN79wrZz+XNZEo1UXhhl5DSAnxSxRRqbnlFpAw9w3g6TDiKu8+y3XUXTHf2OS5W0cms7Ut/yuCOp6a2X3DdpaztuOlqtCDX38AoE0YKIRxJbQVoCzBJvYP9GoJ0JRZsO1ovdJTSBm99lTIy6x1kmC4dO3+0bJpl20q8xMxaH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(6506007)(31686004)(4326008)(8676002)(66476007)(66556008)(66946007)(31696002)(45080400002)(6512007)(36756003)(38100700002)(86362001)(478600001)(83380400001)(186003)(53546011)(6666004)(966005)(6486002)(316002)(2906002)(2616005)(41300700001)(8936002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmdLejAySVVBKzZxT04yVXFSdmxzMzI0Q0UxbU9pZlpncW5rVUVWa2xJejRy?=
 =?utf-8?B?RWdTM2M0TFQ4c1FtQmtqVUJxcUU2aWFsWHI0d2tybHZvRWkvajF3azJpSlpD?=
 =?utf-8?B?Q2FhVjBwNFh3TURWNWdFMDlFczZtODNUS1N4SCtGMHpVSDFPa2o3Q0x1Vjlq?=
 =?utf-8?B?UDA2OUJXN3JxM21uRlpLYk1kZldZOWxiVkRMb1FYZ3NtYUtDMFhncVZMRlFo?=
 =?utf-8?B?QWdaRFl6UUQzb3c3Z0N5TXVIbkVLK3kxU0hVT0Npc1B6QVNYdXdMbEo0bDFR?=
 =?utf-8?B?TTVreU53SGZ4MGN1eVZsTzI0YnVkTjNMdzZQb29uZ3RhZmFkc2xYR09LWkZH?=
 =?utf-8?B?NVluWFpBd3BCYXdQcjVBdnc4b0VZV0tjaWpMdWdwam9jMWd6Tk5lM1FGZ3Fi?=
 =?utf-8?B?dFJ5QWRqYVk2OG5lMjRXcjlSelExZThqeTYvSWR5by92UGM4QzlsN2FpUnhr?=
 =?utf-8?B?OXhFUklzYUxYMkpLbHlSQjJHdlNXeTdYdVFaN3hLS05ST28vdlhUbzFHd2JT?=
 =?utf-8?B?SlczeWR2eFlEcDNpWWZtTmFNeG5XQWZ3aUdvd0NIVzIzSEFUMUlrZU9ySFRS?=
 =?utf-8?B?Q3hUWmZESWQzQk9ZdWZRZHVkS0tUVmFKcmZIREtUTlRrTTQzRC8xbkRZTlR1?=
 =?utf-8?B?ZUpXalZlQzNuMWFHeVFNWXJCRi9yQVhpVCtqZHVvaUNhVlYvVHhyRHFOWXRZ?=
 =?utf-8?B?UklmRVVqOG8xYUkzWHVNcFkvanlTY3lWeE9BYkZUVEp3U3NDSkVHUmk2ZVcz?=
 =?utf-8?B?YjlWUlhwam94b1Z6M3R0S1ZmeWRiL3A5b1BENHVreHVtenJvSWxMMG9RODgr?=
 =?utf-8?B?b3NNeVBZalQ0ODBwNGxONVRBaVpSMG5KelYxZGxnKzluV3NVc1dHclF4WmN2?=
 =?utf-8?B?MVpQbmJzVVdYTkhGSWRodGFDdGEyU2VlQXlhMHZJQTdzNjFBRFVOZjEzS0kz?=
 =?utf-8?B?N1NiWEhmY3dMSCtUUGVmWm5Mb2pVU0NvUm1mMGEwTVBTVW1BbHdtU1lyeERt?=
 =?utf-8?B?SDNkWlN2Y1RORFlnaTlDUlVBcHd4VzY5SVZ0b3VRN2V4SjN6ODZ3U2psWXVI?=
 =?utf-8?B?Rk5DZVoyMlRYNVFiZEF6V2ZFOGl5K1E4MVo1Rys3cWI2cS80SW5sMkFaRko1?=
 =?utf-8?B?VHZUMHd1Mlg1amxtZ0ptVVdER2FyL0FHeDVBaXEvck4zMWx4K092a0NnaGJI?=
 =?utf-8?B?V3dpT3ZNNms4L3hueW1LWDAyS3hzQmRYajIwNzdaRWhlT2trdElsNzZ0VHNz?=
 =?utf-8?B?bTZ3NHFZVHJUQ3ZhVTVMQitXVWpXTm1oYThyRnNtRHJHS0xjVC9ZeVhMRmd2?=
 =?utf-8?B?WFFka2EzTDF6cTJUaE42b2NleUdXRTI5Y3VKMnRwZC9FSDNNdmtrald4a3hz?=
 =?utf-8?B?MG5FL1FnMUViaUtvTTlHMUh0NklHZGpTTTJvVzFheVJuYXE4ZzZCdWNTb1Zh?=
 =?utf-8?B?ME4wcFJLV21hVVJLRlEveGpaZjdjMytISVBKTFdkd1pWZUJuRTlDL3FtcUdx?=
 =?utf-8?B?dGxTR0JsM1FWMlFtOG92aXhFMzBueVozc2xkckRHcVZpTlNHSEpteXJGbkNy?=
 =?utf-8?B?clRlbFV2L0ppU1BFSzUyRlMxYkwrZ0RlaCtLbU9JZW0veFZMNVptcjFxWXgy?=
 =?utf-8?B?b3ZLdXNXQXhrZXZmN2Q2SkYwbE81blFDa2Q3VUx2WlRaOTVUbDJTaGxBY1d6?=
 =?utf-8?B?YlY3VTk2MDJsTTAram9TSU5Hd3lpUEJzT2xrSkd4VE5FV2ZBUXljenBYVWYr?=
 =?utf-8?B?OEszNTl5T1dmeDBOSE56QVllVEVSdXYzRlpudXdaNnlKOERlbnlXc0hNZ3E1?=
 =?utf-8?B?dUo2emdTeFhHWE0vcXBxSzhZWnZCa2E3TzZPenppTnV1dHQ3cE15aUFUaDRF?=
 =?utf-8?B?UEM3TmVadHVTL0NwV1J6STBsZ09QaXAzOFpFdUdJdXRsNG5rNktvazBqbHY5?=
 =?utf-8?B?NDVVakVJK0FGeWxjZGswTVJ3NWV2WDluZU5IeGZ2bUxoREJuSGdramlJVXlr?=
 =?utf-8?B?UW45STgwT0dqZ0dCNHBoWUYwT0tveEJyd0JYaGs3dWRUQ3NrdUsycTcwd0hl?=
 =?utf-8?B?T1JJZ3pKSm5kbm03QUJ5VERsME4yZXZuSHBoc25xRDBSYjRrLzdtZnBMT0o0?=
 =?utf-8?Q?gpLOThL49d/vhcOBHq9hrn4Zo?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043f9896-6f94-441e-ad3d-08dab001326a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 05:34:01.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0WZ5ECQYy99upWVzv6B0GuDw37KtT23pf8M2yA7VdIFTiJDyXb64v/4y4hutzCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4467
X-Proofpoint-GUID: zArrCzRMw_OLsP6I06epQnEyICk8oGgl
X-Proofpoint-ORIG-GUID: zArrCzRMw_OLsP6I06epQnEyICk8oGgl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_03,2022-10-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/14/22 5:24 PM, Stanislav Fomichev wrote:
> Syzkaller was able to hit the following issue:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3609 at kernel/bpf/btf.c:1946
> btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
> Modules linked in:
> CPU: 0 PID: 3609 Comm: syz-executor361 Not tainted
> 6.0.0-syzkaller-02734-g0326074ff465 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/22/2022
> RIP: 0010:btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
> Code: ef e8 7f 8e e4 ff 41 83 ff 0b 77 28 f6 44 24 10 18 75 3f e8 6d 91
> e4 ff 44 89 fe bf 0e 00 00 00 e8 20 8e e4 ff e8 5b 91 e4 ff <0f> 0b 45
> 31 f6 e9 98 02 00 00 41 83 ff 12 74 18 e8 46 91 e4 ff 44
> RSP: 0018:ffffc90003cefb40 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: ffff8880259c0000 RSI: ffffffff81968415 RDI: 0000000000000005
> RBP: ffff88801270ca00 R08: 0000000000000005 R09: 000000000000000e
> R10: 0000000000000011 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000011 R14: ffff888026ee6424 R15: 0000000000000011
> FS:  000055555641b300(0000) GS:ffff8880b9a00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000f2e258 CR3: 000000007110e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
>   btf_check_all_types kernel/bpf/btf.c:4723 [inline]
>   btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
>   btf_parse kernel/bpf/btf.c:5026 [inline]
>   btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
>   bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
>   __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
>   __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>   __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0fbae41c69
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc8aeb6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0fbae41c69
> RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000012
> RBP: 00007f0fbae05e10 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f0fbae05ea0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> 
> Looks like it tries to create a func_proto which return type is
> decl_tag. For the details, see Martin's spot on analysis in [0].
> 
> 0: https://lore.kernel.org/bpf/CAKH8qBuQDLva_hHxxBuZzyAcYNO4ejhovz6TQeVSk8HY-2SO6g@mail.gmail.com/T/#mea6524b3fcd6298347432226e81b1e6155efc62c
> 
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Fixes: bd16dee66ae4 ("bpf: Add BTF_KIND_DECL_TAG typedef support")
> Reported-by: syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
