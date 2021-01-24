Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99B301E57
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhAXTH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:07:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbhAXTH5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 24 Jan 2021 14:07:57 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10OIwIhm007420;
        Sun, 24 Jan 2021 11:07:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lcNrjwOdGfvELB7s257Ii9HoBReJduFr+RVANLIbzUM=;
 b=pVNjtVw8awCvdJO5iyvkid4qlb0BUNZXmFmnrIHk49icWyVqmHPoey5wnY71tBCQOWEt
 3wDaYFRBcBAw3RN4BlLmfDung49yDm7abzPC1vbtf6w+mmSC2Mn/V0cisKUhISeQ73aw
 TBZzT/y7jhqeOgg5yKuhRB/pnNpfhGzDgcI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3694qchgu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 Jan 2021 11:07:03 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 24 Jan 2021 11:07:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNhKNL2qmrqsBcTblWixz8nTEoudWkSjqW0f1+xWtN0Lry9lq1TP6j4qbkeSFzIrZgzjUTsl86GXLDtgwX3vA97vmgIQTSWsnPrCW6TtslqAn2b3fMY4cV0gdC3pzwY2IlgOL7W6zUWi5yED3SIBqFEnKSV9UNISrSEv/PUcuB11wsrmE0BkyuymDK3u45Ykc0XUrVYMB4V+Egksm1+AmDOf0loKybqbFDkrQdcLKNfAsEXZYWPiIVm9jbhoBpQmA1haaaQCvmBTnrK4e1t+MFd5BO79BfIJcB1b5iLrhIX5VVTYASgZ1xUvcekBhtGGu7amVs1NMEeiq7O70zKpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UKV4oWekPG3hblivyv9VXQlgymWei9r9Fr8MDhmkxU=;
 b=D4d+ntbkj647Mc/sAMv1FY6U1D+VeXk/A4cyYWHl79UFL39QYVua4JOl2kEaRQX/azev/F4u8FCPge8TrWFH76PlWprXJiwX9qVi2BULext/amSAMGcG/vdsIhwPzIuSMFZSeMEW2P1F7JRiD1hzZDwBv2GcVA6yk4fsdtL35Emx+ZA2ySi7CaaSDU+aa7tHbA5lIpwfSEeLWDatCr2fGsJWznjHz5BjSWjvDgN9c+oKhe4tSlCYTWks+xveFqYi10WjtQRsJpL/70LbiO0Gt5SXoe8+PA3cNa41qfdONlg0nqzxCequgW7JOxu7Ep6qdjOjrWvPncYJ4gwTC75QPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UKV4oWekPG3hblivyv9VXQlgymWei9r9Fr8MDhmkxU=;
 b=LXE/jwwoDMBjjEBHCsMmeLNQOhENR9QJPw2ByzRZafKB439bgPTEOicar86r0gaLLtJZzi9Dn5KZYxrOFapAv4YPsPhb3vycGaGnBWI627wBgCl9N18PcX1OS9H5NFyWEV0weNakiseKWsfujKekNJcsA9aGTcmTkGRj+xWseeA=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sun, 24 Jan
 2021 19:07:00 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 19:07:00 +0000
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210123004445.299149-1-kpsingh@kernel.org>
 <20210123004445.299149-2-kpsingh@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0d436bbc-7409-2947-7322-f21241df6025@fb.com>
Date:   Sun, 24 Jan 2021 11:06:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210123004445.299149-2-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:a361]
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1946] (2620:10d:c090:400::5:a361) by MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Sun, 24 Jan 2021 19:06:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ef7dc2-b092-411a-6992-08d8c09b3a0b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2456:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2456ECDBF4994E75385ED31ED3BE9@BYAPR15MB2456.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1/MXCyUqrKJBfRv90QYXShj78qq/xuzF2YoNPmef3hrI67cvxR8U4X+2VxSnSEI54zkCMCjUsRpNR0Ru0nZGSCSNunh6zULBmc0A2r50iQ8FeX2kb04kX8wg/DpjXs4LKPfPZrv/vANbalSZyZZpzYTJez1pZz/mGqd6zZG3NTJnkMNS6ZAOSslxhdhJXjgCXTz+nVSNdBdUSh2PTys+kO3Hif7TiN0Ei02i+gkWzlbwJPwRcJJsB5+m1PzftlbodVX77DTaMn+CgDgcf8ize5HFsNDphZVecRmCWy4N7LG18W93OGuVsLs19vdeowmx4P/w+0mHEbfkA1fuHELYvIIxVw95TB4rl+TMkPwiYz6SjItfruPp9+flGOkw0ICL+PWCOlG6iNwsWYTRzo1MWHjrUTITJIAK3ThLssyHo7N8QgTIHRHr7apeLqsrh2DyiMXO2TfD99zLEcglCkOgTYIzd25B7CU9y/dI0nid3D5wY5T3eVz4sYWiP0IBTPOWStcyNIVW98NHI0rmixGxYtAekg9/2M3BPoOq9BTSCGZDnpRShmtFdV4mOJnTi2Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(2616005)(2906002)(83380400001)(6486002)(54906003)(5660300002)(316002)(52116002)(66476007)(66556008)(186003)(66946007)(4326008)(31686004)(16526019)(53546011)(31696002)(8676002)(36756003)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K1ppRXNYOXlFU3UrQVZ0d01IdkY0Zk5ta0VRV1ZMRkRsTmlTUkczSWFudkRI?=
 =?utf-8?B?Z1BRYW1nU1ZLdG1STVhVYnBCYitSMzczNSs1NUdXQnREM0UzTEJrSjkrYzhD?=
 =?utf-8?B?ZEZ6dXJvS1o3TGZWQkZ3WTJrazM3TW1SbUpvZXpneFBkdnJtbjZuM05sN0NL?=
 =?utf-8?B?OGZ6NVlyZ1JidXJpMUVrY3RqQVphZ1JGZWR1aURqYm1PWUhvejhSaGpqWWFH?=
 =?utf-8?B?RityRDFkQUxxcHpFd0VLNGlxOTRRY3NRd0o5UDRCdXJ2SnhWTVdPTU9pNm43?=
 =?utf-8?B?UHA1TkZTRmdsL3R1N3RuNGR2dTVoRHZiWVZrMFhvdzEzdTN1MkdPeFdIcE91?=
 =?utf-8?B?dm9MNHQzeUxwUUh1VG13VDFjUTM5UVRYcVJRWU9yWWlkamNmRFhiNGN5NzlF?=
 =?utf-8?B?ejd0UHZHYUVPSWtmalpFekdjbWVtWWtDVVFmYjFoZ0NCN01nc0dVY2h3QlE1?=
 =?utf-8?B?U2QxMDNic0lYcXRZTDYrbU81NlZNc0F4clBsRFJTU2RSVnp2OUplODFMZ2NM?=
 =?utf-8?B?OHppa0l2R1MvMUJXcEFMUFI4TXN2K0xhS3hWaGh5cDdTOWNSTXRHUVJaTTZ2?=
 =?utf-8?B?M0t2OXlKOStSNi9oV3R0blpkd0ZhWDlZRHp0QkpPc3ZtNE8vcm81czFDUzI2?=
 =?utf-8?B?SGFtVFdrMys1T1RuVWdRWS9rZ0xYYzlpK3pEMG5GWmxYMTNWTDRQRERXR3M4?=
 =?utf-8?B?b05LbmJhWE5oblJDMXBtS1dSNDNlTzF0bVRsTVJObjROa1MwTmpQbG5TNW1S?=
 =?utf-8?B?bnhDMWhKQXFGLzRnczg3cWZCenZ5eVp6QytFbnNsUHVBcUJKblVVcDVZT0tK?=
 =?utf-8?B?c25aRGVvamsvYmRGWUpuY0lMMWlhN1dtUkhQamExZlpIeDBNZnRJWDQ2R2Iv?=
 =?utf-8?B?cmdpS0VHTlFPWlhrMnllWVRlRkNKUFdMNHNQL1owb2NvdkI5MjJzY3ljaWUr?=
 =?utf-8?B?NXF6dWZ4enUrbjZRdFpmTEhHSjBxOU5kUHU5UjBkMDIwZXpBNlRXbjhDU0pB?=
 =?utf-8?B?alM5MkZzeDV1QjVScm9Jbyt3NWhRdVF2ejV4bFNLb3JMUWYvaFZSYzBsRjRh?=
 =?utf-8?B?SlNxbWVvUFdNa2dRNGs4YnR6OVQ2MXUyTkRqcHpJdkw4MUUxSVZjcTN3VTN3?=
 =?utf-8?B?Vk1wVFBZNUg0dXBEdnU3WWVnMzdhV1Fud1R0R3hPdlZGMEdGWUpzM25oODJR?=
 =?utf-8?B?V0FGNFhhbW14S3Z1NmxuRXNBT2U4MnpJQ0NId0NSSy8zbFhVRDZMOHFIQ0h0?=
 =?utf-8?B?R1QyZG5sak1CbFZQTFpMMUhJVmtMSDd1MzJXdDc5MGFqL0ljSlk1aG53YUQw?=
 =?utf-8?B?SGlmU2RZaDVNanZUb3luOUduRlZEdFE0UkpJRGkrZHc3V1VRcXVBc0RCb0lP?=
 =?utf-8?B?WXczNk5ya3dpSHRCb1FUSnJicFN1ckdLTHNxMFp6VzlUMkgwZlozU3UzVVQx?=
 =?utf-8?B?ZVU0YUtTM0k4bFpld1JXVExGaVZXcjN5Y3NLTnFoR0hsQnNxRkN1T3p3eTJx?=
 =?utf-8?Q?MVMqrg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ef7dc2-b092-411a-6992-08d8c09b3a0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2021 19:07:00.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGyj4k0OcRHiZgQgDPv51Ygx2PyQ+47VxLBtIT+UmVDvisPNcnYF5bm/O4SHiHbY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_08:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/22/21 4:44 PM, KP Singh wrote:
> The script runs the BPF selftests locally on the same kernel image
> as they would run post submit in the BPF continuous integration
> framework.
> 
> The goal of the script is to allow contributors to run selftests locally
> in the same environment to check if their changes would end up breaking
> the BPF CI and reduce the back-and-forth between the maintainers and the
> developers.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Thanks! I tried the script, and it works great.

Tested-by: Yonghong Song <yhs@fb.com>

When I tried to apply the patch locally, I see the following warnings:
-bash-4.4$ git apply ~/p1.txt
/home/yhs/p1.txt:306: space before tab in indent.
                 : )
/home/yhs/p1.txt:307: space before tab in indent.
                         echo "Invalid Option: -$OPTARG requires an 
argument"
warning: 2 lines add whitespace errors.

Maybe you want to fix them.

One issue I found with the following script,
KBUILD_OUTPUT=/home/yhs/work/linux-bld/ 
tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
I see the following warning:

[    1.081000] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 
101, name: cat
[    1.081684] 3 locks held by cat/101: 

[    1.082032]  #0: ffff8880047770a0 (&p->lock){+.+.}-{3:3}, at: 
bpf_seq_read+0x3a/0x3d0
[    1.082734]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: 
bpf_iter_run_prog+0x5/0x160
[    1.083521]  #2: ffff88800618c148 (&mm->mmap_lock#2){++++}-{3:3}, at: 
exc_page_fault+0x1a1/0x640
[    1.084344] Preemption disabled at: 

[    1.084346] [<ffffffff8108f913>] migrate_disable+0x33/0x80 

[    1.085207] CPU: 2 PID: 101 Comm: cat Not tainted 
5.11.0-rc4-00524-g6e66fbb10597-dirty #1257
[    1.085933] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.9.3-1.el7.centos 04/01
/2014 

[    1.086747] Call Trace: 

[    1.086961]  dump_stack+0x77/0x97 

[    1.087294]  ___might_sleep.cold.119+0xf2/0x106 

[    1.087702]  exc_page_fault+0x1c1/0x640 

[    1.088056]  asm_exc_page_fault+0x1e/0x30 

[    1.088413] RIP: 
0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xbc8 

[    1.089009] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 
49 89 df 4c 89 7d d8 49 8b
bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 
48 89 7d e8 48 89 e9 48 83 c
1 d0 48 8b 7d c8 

[    1.090635] RSP: 0018:ffffc90000197dc8 EFLAGS: 00010282 

[    1.091100] RAX: 0000000000000000 RBX: ffff888005a60458 RCX: 
0000000000000024
[    1.091727] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 
0000000000000000
[    1.092384] RBP: ffffc90000197e20 R08: 0000000000000001 R09: 
0000000000000000
[    1.093014] R10: 0000000000000002 R11: 0000000000000000 R12: 
0000000000020000
[    1.093660] R13: ffff888006199800 R14: ffff88800474c480 R15: 
ffff888005a60458
[    1.094314]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xbc8
[    1.094871]  bpf_iter_run_prog+0x75/0x160
[    1.095231]  __bpf_prog_seq_show+0x39/0x40
[    1.095602]  bpf_seq_read+0xf6/0x3d0
[    1.095915]  vfs_read+0xa3/0x1b0
[    1.096226]  ksys_read+0x4f/0xc0
[    1.096527]  do_syscall_64+0x2d/0x40
[    1.096831]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    1.097287] RIP: 0033:0x7f13a43e3ec2
[    1.097625] Code: c0 e9 b2 fe ff ff 50 48 8d 3d aa 36 0a 00 e8 65 eb 
01 00 0f 1f 44 00 00 f3 0f
1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 
56 c3 0f 1f 44 00 00 48 83 e
c 28 48 89 54 24
[    1.099232] RSP: 002b:00007fffed256bb8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[    1.099922] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 
00007f13a43e3ec2
[    1.100576] RDX: 0000000000020000 RSI: 00007f13a42d0000 RDI: 
0000000000000003
[    1.101197] RBP: 00007f13a42d0000 R08: 00007f13a42cf010 R09: 
0000000000000000
[    1.101868] R10: 0000000000000022 R11: 0000000000000246 R12: 
0000561599794c00
[    1.102486] R13: 0000000000000003 R14: 0000000000020000 R15: 
0000000000020000

Note that above `cat` is called during /sbin/init init process.
......
[    0.964879] Run /sbin/init as init process 

starting pid 84, tty '': '/etc/init.d/rcS'
......

I checked the assembly code and the above error info and the reason
is due to an exception (address 0) happens in bpf_prog iterator.

SEC("iter/bpf_prog")
int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
{
         struct seq_file *seq = ctx->meta->seq;
         __u64 seq_num = ctx->meta->seq_num;
         struct bpf_prog *prog = ctx->prog;
         struct bpf_prog_aux *aux;

         if (!prog)
                 return 0;

         aux = prog->aux;
         if (seq_num == 0)
                 BPF_SEQ_PRINTF(seq, "  id name             attached\n");

         BPF_SEQ_PRINTF(seq, "%4u %-16s %s %s\n", aux->id,
                        get_name(aux->btf, aux->func_info[0].type_id, 
aux->name),
                        aux->attach_func_name, aux->dst_prog->aux->name);
         return 0;
}

In the above, aux->dst_prog == 0 and exception does not get caught 
properly and kernel complains. This might be due to
ths `cat /sys/fs/bpf/progs.debug` is called too early (in init process)
and something is not set up properly yet.

In a different rootfs, I called `cat /sys/fs/bpf/progs.debug` after
login prompt, and I did not see the error.

If somebody knows what is the possible reason, that will be great.
Otherwise, I will continue to debug this later.

> ---
>   tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
>   1 file changed, 353 insertions(+)
>   create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> 
> diff --git a/tools/testing/selftests/bpf/run_in_vm.sh b/tools/testing/selftests/bpf/run_in_vm.sh
> new file mode 100755
> index 000000000000..09bb9705acb3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> @@ -0,0 +1,353 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -u
> +set -e
> +
> +QEMU_BINARY="${QEMU_BINARY:="qemu-system-x86_64"}"
> +X86_BZIMAGE="arch/x86/boot/bzImage"
> +DEFAULT_COMMAND="./test_progs"
> +MOUNT_DIR="mnt"
> +ROOTFS_IMAGE="root.img"
> +OUTPUT_DIR="$HOME/.bpf_selftests"
> +KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/latest.config "
> +INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX "
> +NUM_COMPILE_JOBS="$(nproc)"
> +
> +usage()
> +{
> +	cat <<EOF
> +Usage: $0 [-k] [-i] [-d <output_dir>] -- [<command>]
> +
> +<command> is the command you would normally run when you are in
> +tools/testing/selftests/bpf. e.g:
> +
> +	$0 -- ./test_progs -t test_lsm
> +
> +If no command is specified, "${DEFAULT_COMMAND}" will be run by
> +default.
> +
> +If you build your kernel using KBUILD_OUTPUT= or O= options, these
> +can be passed as environment variables to the script:
> +
> +  O=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> +
> +or
> +
> +  KBUILD_OUTPUT=<path_relative_to_cwd> $0 -- ./test_progs -t test_lsm
> +
> +Options:
> +
> +	-k)		"Keep the kernel", i.e. don't recompile the kernel if it exists.
> +	-i)		Update the rootfs image with a newer version.
> +	-d)		Update the output directory (default: ${OUTPUT_DIR})
> +	-j)		Number of jobs for compilation, similar to -j in make
> +			(default: ${NUM_COMPILE_JOBS})
> +EOF
> +}
> +
[...]
