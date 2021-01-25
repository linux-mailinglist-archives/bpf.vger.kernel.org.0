Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51C30311D
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 02:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbhAYX6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 18:58:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732073AbhAYTnn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Jan 2021 14:43:43 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10PJg206022182;
        Mon, 25 Jan 2021 11:42:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=i3WBvD7IFwwIxJSdbSn9vqS7YuiaPCRKnCVyDEh3CZ0=;
 b=Zqb5PLtK9DyVHeJQ9JLgqRB5OBaROFiRKLAIeJc8q67t6tnIu9370YdZ9fg5evb84WbI
 kKIaDpqCKW6dNH6NolPOLtvvjcw8VsJcTSVZy7btcZwVZX2fUHAPULwbqV2MH4kRgxEF
 0xmcgbW2K5C2L6HLCcZlEMbDzGVViyG2H+A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 368gbvawxr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Jan 2021 11:42:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 11:42:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTkE8qn0mTzQ0hoXBFYWYsaH1irh8a1FUILOP5kVR78qVcfMU2OX5WEJhYcqpN897QgPZ5ADt4pGioxrvIc3wCm4LdWxdaA3S7NAZs1ScDCp4s1NGkacw2BZ/GB7r9PqcYzz65NH/a7v4/WJwyhceFwljywl9t+bx/0Irvej0LdSzUhn5AwsMA+lVWYHpp56Y69bJRPJgMz/noh29KV2HcSCitwQHjDk1D+uF/9xAKFn1r+qiS+PTAq+qrW7o9kjP72UpLfmEa9k0QC8Jwba2rEvd53LD9IgdysXrTqIO2SVRueMADvG750DZQI495RuXg31sZu898xvpb2PWrKy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3WBvD7IFwwIxJSdbSn9vqS7YuiaPCRKnCVyDEh3CZ0=;
 b=KG77E5JuMvB7jOjPd4QfWPuYEVCqH6Ih3LnyvM/s2NpDWe7t4v8G8sUwT6gEMNb8LAEhcNm4hbYVX3hqbtABIjHCCpdj9ggig/tGGB1NSu3uDBOVaVo2SJBwp1HF/qmIgCMl7Sh5kY6qbvV/gWv2eItsQpGYxSJxDJnSzyPnllN9IG6U0ipBSQn39JrD6vpvFOO0ZQvw3Ee9s4+T8K7AZMWVd7exom4QQoJSS14ediN4/sJmzT6XGTQnQI7RaYSA9h4eLlOKOT6UdNzdPSOpij+CZFyiQTdqJ9kDwYdtfPX3fR+M91baqcEzMNXP2Jf1x1eapnKCwxGI6NR1dU5YKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3WBvD7IFwwIxJSdbSn9vqS7YuiaPCRKnCVyDEh3CZ0=;
 b=f0hdt4Vg+UpO9t+dj7YhbL3uT8cjzrtePqu6A0XL/kBM9qPjFE+5DoIP7HttNTUUtFnRieJfUC9v+wbS/zzisLRnkPDPaORNsg8piTLdxT/8LcXfDitXU3Ukav9se49dT1PtARCtTQfrd2ipWnTHJsKSLMLVRhdziI1DfaUrk8Y=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:42 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 19:42:42 +0000
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210123004445.299149-1-kpsingh@kernel.org>
 <20210123004445.299149-2-kpsingh@kernel.org>
 <0d436bbc-7409-2947-7322-f21241df6025@fb.com>
 <e539bbeb-a667-6ae1-fe40-ddb30bd7c13d@fb.com>
 <CACYkzJ6SuDm7FzQ5Cqk=BrZf1sykh947SNKJffmC7RYS=dydHA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a22e3194-f29a-d7f6-7583-ce009c8decbb@fb.com>
Date:   Mon, 25 Jan 2021 11:42:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CACYkzJ6SuDm7FzQ5Cqk=BrZf1sykh947SNKJffmC7RYS=dydHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f74b]
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1946] (2620:10d:c090:400::5:f74b) by BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 19:42:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86a98693-10b9-43be-eecd-08d8c169617d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2837:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2837E6E76FE1C9263EF5CA72D3BD9@BYAPR15MB2837.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:30;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkoTH3nEoGFZigHHEtKEIjKvJz+H3H9VuTntctHeJbiU+ck7i7yhUH8boYzvfYHyW9TpDFuL+Iyg2Bc9x1WHxTgefCcJAat5zb7nQrVHBQm+8QD/04jWAAnDZEz3qpdOCCZT98bihKhWZh8yr1gxgGSwaRIpc2lwJgC6c/IrjAnCBTD57HDO3vxT1ohwkGQaGLBJFERlG5WdPIAWZRj6Dnv4j/44Vi8jRW4Yp68TVLZ6oYLOtdU0ap0e3/NwZBNWggdrODF+VclK2aHIpjJsz5sPSzeP13/LZHszcjhIGVYIgQkrORoKXG26LDDdZrxmtcRe6EBkANt3R/qv6aA0LjG8wi7h60FktUuEAI5ub2cGKZk5GXbHYqBDyo5KY+BkNXvolzT/Y/ei9RRa2JYZnLVE860ZYU4nlrGQeHSz97a6eR+xpEB/wOrF5oGUASj9A67Jd2xCtAznXZ3DSBVQpqXKT2VHKQ/hGNsvgAj7ZQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(2906002)(4326008)(52116002)(66476007)(54906003)(66556008)(5660300002)(6486002)(6916009)(86362001)(31696002)(31686004)(316002)(8676002)(66946007)(186003)(16526019)(2616005)(53546011)(36756003)(8936002)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2xpdXdzODdUYXo2NFF6UjU5R2NBWHpqTjJ1SWE5OVhrY2dlUzRqdEJyd1Nt?=
 =?utf-8?B?WG02SmE5WnJ1NGZ3SUlSYU9PbWtqODM1Q0JCd3E2UzY3ajA4V0g4NnppNkJ5?=
 =?utf-8?B?elYzaDNkRjl3QXVOVjIxYnZrcVQ0NDlabi94WW4ycFZ0RjU3YUpCNi9zK1Yr?=
 =?utf-8?B?SDNPZVRmZVBJeTE5cjFvQ3dzSmhPNitiTmd4ZHlvTU9rV254eUtyK3NmOVVU?=
 =?utf-8?B?cEErcThNNWx6TDZENmt6MUREbk1odlRMMjF2Z2IxVVZ2UkVXdHlEUFlwSGph?=
 =?utf-8?B?NjEzeENGQTRSV2VDdi9PYkdVTHcyVVF2R3hOZUVSa09BckdMeXVuTWFJYlR5?=
 =?utf-8?B?L2lCRVVzdWdmRUEzNzBlSEdEZ3hLSUpKZGJkZ3loTzB0WHpRdWpNNDlqQmNu?=
 =?utf-8?B?bk45bTlqRFdEa29DZ205eWZzMEVYMkF3M1RFcmsyZTgwSXNuV0pJeFBiOGE3?=
 =?utf-8?B?TTByU2FFdzEyZS8zeVI5cWRzWkh0TEZiYXRHb3JhU1hhSU1TTW5JMXE2MU1r?=
 =?utf-8?B?VnJBd2l5UERqRXpmdXpMNDVQbE13L2FsY0xzVllWVzJNK2duckFZeWgyVk9D?=
 =?utf-8?B?TXg2NDhOTlRETEY5M0IvN1Exd2hlZUNseUp3Yzd0Zzc5MER5KzhkcDA2OXdp?=
 =?utf-8?B?WHNaM2ZhZDJ0cHdvZmxqTkhHMHVJZ1BPN0NCWDhENEpyWE1seVNpTU1FbFpa?=
 =?utf-8?B?VU1JbmdGOFEvd0FHMHljb1krVU5yTmFsMmNmNUxyOXpRV1NMTFpOeTRrSGts?=
 =?utf-8?B?aUVTMVA3d01xalhQcUpJcFExUk9rcEc0dnlFTWJWWk5vVmE5c2o4ZlBTK3JS?=
 =?utf-8?B?SHJHcUs2aWNxaUZtdnI2K3lyWU9hNDFXQ1Z1MzFIa0IzcDJXcDJzSndTNE9Z?=
 =?utf-8?B?dHBTZHZ0em10TW5aOGlacFVTOG43ekVPN0dJblAvdDVzaE85Zi9VdU44VDlE?=
 =?utf-8?B?dWZrRnBOV0tpTEhlVThQS2NFRjNnY090YWV1MzJHdVZKaklKbmlrZmxtV0V5?=
 =?utf-8?B?Yms0QnBOVlNDcU9aREcyMVV6T29maWt2eXlmSUJKeGo3RmJoZUxHSlhQUnBU?=
 =?utf-8?B?enR2bFdaUlZabGE4VUdLN0xRN0FLeWM0NzgvanpuMUJVYlgzM2M3Zk4yOU55?=
 =?utf-8?B?YmJXYzJyOVMrNE9pcjY5eVZ6NjlMNEN3OHhaRSt1dE00MW1OUnBBamsvdE5L?=
 =?utf-8?B?US8xN3BHdjNUK25renJmamdWL05Wc1IrTTJSQlYwc3daakZDTmFqUUlzVGcv?=
 =?utf-8?B?VmI3Um5iZEYxTzl6eElBMDl3enVENnczbUtqam1EdUdGdy9KRkZoNEJxTEYx?=
 =?utf-8?B?NUZSOHZTbGFzcmw0a3FBUUQvR2xScVFBVlg4ZnBhNkZUNzg5OUJLV0g0T0FL?=
 =?utf-8?B?VzdzemtTd0pXQTFGYWVncUkrNG9TRzNYaEJDRW03OFlVUmFFV3RQZHN0MDBi?=
 =?utf-8?B?dWI0YzFDbVdjUHhsVHYzWDFGdDFHMVd5TnhENW1QcVYwOThvVXB3cHlxT1JU?=
 =?utf-8?Q?M4QlvA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a98693-10b9-43be-eecd-08d8c169617d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:42.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERH3IXuwbrHlPtriPneTJPvrAZAVEicKZXzXNxYMs9YYaPKiwLKydCdeuXJmDpJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_08:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/25/21 9:53 AM, KP Singh wrote:
> On Mon, Jan 25, 2021 at 6:22 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 1/24/21 11:06 AM, Yonghong Song wrote:
>>>
>>>
>>> On 1/22/21 4:44 PM, KP Singh wrote:
>>>> The script runs the BPF selftests locally on the same kernel image
>>>> as they would run post submit in the BPF continuous integration
>>>> framework.
>>>>
>>>> The goal of the script is to allow contributors to run selftests locally
>>>> in the same environment to check if their changes would end up breaking
>>>> the BPF CI and reduce the back-and-forth between the maintainers and the
>>>> developers.
>>>>
>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>>
>>> Thanks! I tried the script, and it works great.
>>>
>>> Tested-by: Yonghong Song <yhs@fb.com>
>>>
>>> When I tried to apply the patch locally, I see the following warnings:
>>> -bash-4.4$ git apply ~/p1.txt
>>> /home/yhs/p1.txt:306: space before tab in indent.
>>>                   : )
>>> /home/yhs/p1.txt:307: space before tab in indent.
>>>                           echo "Invalid Option: -$OPTARG requires an
>>> argument"
>>> warning: 2 lines add whitespace errors.
>>>
>>> Maybe you want to fix them.
>>>
>>> One issue I found with the following script,
>>> KBUILD_OUTPUT=/home/yhs/work/linux-bld/
>>> tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
>>> I see the following warning:
>>>
>>> [    1.081000] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
>>> 101, name: cat
>>> [    1.081684] 3 locks held by cat/101:
>>> [    1.082032]  #0: ffff8880047770a0 (&p->lock){+.+.}-{3:3}, at:
>>> bpf_seq_read+0x3a/0x3d0
>>> [    1.082734]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at:
>>> bpf_iter_run_prog+0x5/0x160
>>> [    1.083521]  #2: ffff88800618c148 (&mm->mmap_lock#2){++++}-{3:3}, at:
>>> exc_page_fault+0x1a1/0x640
>>> [    1.084344] Preemption disabled at:
>>> [    1.084346] [<ffffffff8108f913>] migrate_disable+0x33/0x80
>>> [    1.085207] CPU: 2 PID: 101 Comm: cat Not tainted
>>> 5.11.0-rc4-00524-g6e66fbb10597-dirty #1257
>>> [    1.085933] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>> BIOS 1.9.3-1.el7.centos 04/01
>>> /2014
>>> [    1.086747] Call Trace:
>>> [    1.086961]  dump_stack+0x77/0x97
>>> [    1.087294]  ___might_sleep.cold.119+0xf2/0x106
>>> [    1.087702]  exc_page_fault+0x1c1/0x640
>>> [    1.088056]  asm_exc_page_fault+0x1e/0x30
>>> [    1.088413] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xbc8
>>> [    1.089009] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb
>>> 49 89 df 4c 89 7d d8 49 8b
>>> bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7
>>> 48 89 7d e8 48 89 e9 48 83 c
>>> 1 d0 48 8b 7d c8
>>> [    1.090635] RSP: 0018:ffffc90000197dc8 EFLAGS: 00010282
>>> [    1.091100] RAX: 0000000000000000 RBX: ffff888005a60458 RCX:
>>> 0000000000000024
>>> [    1.091727] RDX: 00000000000002f0 RSI: 0000000000000509 RDI:
>>> 0000000000000000
>>> [    1.092384] RBP: ffffc90000197e20 R08: 0000000000000001 R09:
>>> 0000000000000000
>>> [    1.093014] R10: 0000000000000002 R11: 0000000000000000 R12:
>>> 0000000000020000
>>> [    1.093660] R13: ffff888006199800 R14: ffff88800474c480 R15:
>>> ffff888005a60458
>>> [    1.094314]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xbc8
>>> [    1.094871]  bpf_iter_run_prog+0x75/0x160
>>> [    1.095231]  __bpf_prog_seq_show+0x39/0x40
>>> [    1.095602]  bpf_seq_read+0xf6/0x3d0
>>> [    1.095915]  vfs_read+0xa3/0x1b0
>>> [    1.096226]  ksys_read+0x4f/0xc0
>>> [    1.096527]  do_syscall_64+0x2d/0x40
>>> [    1.096831]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [    1.097287] RIP: 0033:0x7f13a43e3ec2
>>> [    1.097625] Code: c0 e9 b2 fe ff ff 50 48 8d 3d aa 36 0a 00 e8 65 eb
>>> 01 00 0f 1f 44 00 00 f3 0f
>>> 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77
>>> 56 c3 0f 1f 44 00 00 48 83 e
>>> c 28 48 89 54 24
>>> [    1.099232] RSP: 002b:00007fffed256bb8 EFLAGS: 00000246 ORIG_RAX:
>>> 0000000000000000
>>> [    1.099922] RAX: ffffffffffffffda RBX: 0000000000020000 RCX:
>>> 00007f13a43e3ec2
>>> [    1.100576] RDX: 0000000000020000 RSI: 00007f13a42d0000 RDI:
>>> 0000000000000003
>>> [    1.101197] RBP: 00007f13a42d0000 R08: 00007f13a42cf010 R09:
>>> 0000000000000000
>>> [    1.101868] R10: 0000000000000022 R11: 0000000000000246 R12:
>>> 0000561599794c00
>>> [    1.102486] R13: 0000000000000003 R14: 0000000000020000 R15:
>>> 0000000000020000
>>>
>>> Note that above `cat` is called during /sbin/init init process.
>>> ......
>>> [    0.964879] Run /sbin/init as init process
>>> starting pid 84, tty '': '/etc/init.d/rcS'
>>> ......
>>>
>>> I checked the assembly code and the above error info and the reason
>>> is due to an exception (address 0) happens in bpf_prog iterator.
>>>
>>> SEC("iter/bpf_prog")
>>> int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
>>> {
>>>           struct seq_file *seq = ctx->meta->seq;
>>>           __u64 seq_num = ctx->meta->seq_num;
>>>           struct bpf_prog *prog = ctx->prog;
>>>           struct bpf_prog_aux *aux;
>>>
>>>           if (!prog)
>>>                   return 0;
>>>
>>>           aux = prog->aux;
>>>           if (seq_num == 0)
>>>                   BPF_SEQ_PRINTF(seq, "  id name             attached\n");
>>>
>>>           BPF_SEQ_PRINTF(seq, "%4u %-16s %s %s\n", aux->id,
>>>                          get_name(aux->btf, aux->func_info[0].type_id,
>>> aux->name),
>>>                          aux->attach_func_name, aux->dst_prog->aux->name);
>>>           return 0;
>>> }
>>>
>>> In the above, aux->dst_prog == 0 and exception does not get caught
>>> properly and kernel complains. This might be due to
>>> ths `cat /sys/fs/bpf/progs.debug` is called too early (in init process)
>>> and something is not set up properly yet.
>>>
>>> In a different rootfs, I called `cat /sys/fs/bpf/progs.debug` after
>>> login prompt, and I did not see the error.
>>>
>>> If somebody knows what is the possible reason, that will be great.
>>> Otherwise, I will continue to debug this later.
>>
>> I did some investigation and found the root cause.
>>
>> In arch/x86/mm/fault.c, function do_user_addr_fault(),
>>
>> The following if condition is false when /sys/fs/bpf/progs.debug is
>> run during init time and is true when it is run after login prompt.
>>
>>           if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>>                        !(hw_error_code & X86_PF_USER) &&
>>                        !(regs->flags & X86_EFLAGS_AC)))
>>           {
>>                   bad_area_nosemaphore(regs, hw_error_code, address);
>>                   return;
>>           }
>>
>> Specifically, cpu_feature_enabled(X86_FEATURE_SMAP) is false when bpf
>> program is run at /sbin/init time and is true after login prompt.
>>
>> The false condition eventually leads the control to the following
>> code in do_user_addr_fault().
>>
>>           if (unlikely(!mmap_read_trylock(mm))) {
>>                   if (!user_mode(regs) &&
>> !search_exception_tables(regs->ip)) {
>>                           /*
>>                            * Fault from code in kernel from
>>                            * which we do not expect faults.
>>                            */
>>                           bad_area_nosemaphore(regs, hw_error_code, address);
>>                           return;
>>                   }
>> retry:
>>                   mmap_read_lock(mm);
>>           } else {
>>                   /*
>>                    * The above down_read_trylock() might have succeeded in
>>                    * which case we'll have missed the might_sleep() from
>>                    * down_read():
>>                    */
>>                   might_sleep();
>>           }
>>
>> and since mmap_read_trylock(mm) is successful with return value 1,
>> might_sleep() is called and hence the warning.
> 
> Do you think this needs to be worked around in the script? If so, I would
> prefer to do it in a separate patch so that we capture all the details.

I do not know how to fix it right now and am doing some further 
investigation. Agree that this should not block your current patch.

> 
> - KP
> 
>>
>>>
> 
> [...]
> 
>>>> +}
>>>> +
>>> [...]
