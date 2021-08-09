Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC23E4F54
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhHIWfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 18:35:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9966 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230085AbhHIWfO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 18:35:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 179MWSZQ020251;
        Mon, 9 Aug 2021 15:34:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VFn24ICRjL8kFbEr7FO8oApEtfw/BSdhnFrSsOXB4BU=;
 b=Y4sS6Y2C3PHLISISV1dMlklpziV61ud+5TcfGxiXBYGPyVMVZh9tuFhgrNxS7qkBTafk
 etj3r4xLevHCOuTSuuDYl8Ct86AcESP1m9adlhb/zhkT0ANxVfITsVlhNmJIkg3qO7kK
 2H87gZjOfYhRXQxO7GLykzjBAEZnjeoLgw8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3ab6mmtkas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Aug 2021 15:34:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfDuJ6kPrSmX9bbjaOA75x4CJExovTPbKGXKDCaopLQaWpxwFmNR5IYn6+Jp2SYlw125w4dzd90JGeqmhr+6To6QcR4BwaSdXe1LfTK0IPdP4JT75/Ae4jJK7aGrBK0LVX9wwKBRAEQopH7SWAIsCd7Y/PaewRitJfQL5p6uHTxeHNPEjdTDCSW06Xr/yVkUivjk86NQWS4B8uC5Cl8RC/CflrcZGNE50NElA0L2YMIUQ5GURZmsFIjwtH9nuqQnt5UUEtylkzjfYJ1G1vD4yNtfOcHSLAGY9WLlYytxT+kBR6z8GaZ/eQ0uAnsXLv8N750bBu1fYtxK8U2TvF54aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFn24ICRjL8kFbEr7FO8oApEtfw/BSdhnFrSsOXB4BU=;
 b=Szb+vkKxhRp+iftSTiHRTwScQ9wpafscNEfGKEonf7eoQnRSBmdFutgKDHAEb9CiaNWe2ce2u1HoAQqVdvkWAYSAChz4Gpfs3i7HJIaKvkCIFPqV3+uV14/2eAc9ztfUuoTdmSfNP549QPuIccFb9ZGvbJf5jXyY2CiuU95YKw0cd+3xtfhH79kQpRMZ2pUlluXTdRtETpsqmGQ7IL12wa32BgIEKJKjCQQH2GDJTzl5lvDNmb8PdNXifATxXED9Y1G3fQJci3QnMkiduqX6mzOGAPSK2mEb5+J6Le2RjUttMI2X9bPAu58fVZvokYUaKrZx9XzwsS6pfUzPZzbPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 22:34:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:34:37 +0000
Subject: Re: [PATCH bpf v2 1/2] bpf: don't call
 bpf_get_current_[ancestor_]cgroup_id() in sleepable progs
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        <syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com>
References: <20210809060310.1174777-1-yhs@fb.com>
 <20210809060315.1175802-1-yhs@fb.com>
 <CAEf4BzY+-v4NhMmHnr8agjWj6+O7O-J909+TM1HSZUE6WYifrA@mail.gmail.com>
 <0b299368-370f-2292-2ae6-e86a9bc9a240@fb.com>
 <CAEf4BzaoLuTqp+c7HKmV98=v59xWRhAnCBJ8Ztt0=Vk6zavCVg@mail.gmail.com>
 <db0d54d5-8c11-54f1-45e2-0b85d5f02bd6@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c02034f5-0849-f3aa-bb99-076f2a60d590@fb.com>
Date:   Mon, 9 Aug 2021 15:34:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <db0d54d5-8c11-54f1-45e2-0b85d5f02bd6@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: MWHPR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:320:31::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1ad4] (2620:10d:c090:400::5:61de) by MWHPR18CA0046.namprd18.prod.outlook.com (2603:10b6:320:31::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 22:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ea353e-878f-4582-1204-08d95b85de8c
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB417608CDF56322C516AD552DD3F69@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsUryXrkQeIEEFEG/i2OyxFXf+EgcLFbCbsWELMJwnIuSduNSYRehLVr5YX1N6TAEOAZryG7vFby/+eqZ/LWnImzriVFgnxUfE+R1igWXx41dU7Hwo4lmWhjBL0sG3gwX3rz1ql+dsc7Fs7qYpkpEVWV5RseYeQvUg6f9ZGFN+52GCA6GHL5XprT7qLeW5OZw52tVB/QLiYd4Q8YjWu4NAjT3Ux5VxNS5ixYbpnTqJPuYP5o5U5tWirBk4040ZQcw4B70PhG2FAHFl1wRVo2tzG1P3CWoc7HhjWQ9TQJYPOwHTc96oV58zsJRjpICX1Rdt403Co0S0XcTt1QBEfbBDCCitAL18ACqqQFhES1OOSty+/FidCNxR5avAey9PUUOc7MZOeURmBl5digzyLy2PxFo5pGI6+SqI15ZBfww5DJtzYvC4EZER1udGIZmf/oNG12A5UAYBU31pM/XTuRvb8HJhpTbCF6UHwRZ1M2IVfcVE9/FXb1BqHckpCwN8sqUvkXKlRQ9Vcw9YsFFW4QL5oHQrGN4jGd2lY+t9NtAbdXFl7PNJsOhY28JCfmDzKbwHbuR1/GddECsybGG+ZXiT0XfT7K5kzI3RnhYiosqVnKT6ewH8BX3RmAC3V+T87mmRnYDnnitOe5PGtRKf+f0Mr1owkOpahFuMtbDD+KtvSGlI+V8uIAeUnDKBg3rVjYUpzJpImFOtigmZ9f49wRrCNWB/x/wbmvSGu+RzQxpiv5J46HxcvGoLQwrV6ecdkAPd83UX/VewbE9vLGOOl/gKzVXAA0fMmoMzPNgmauR1AoHSHhvd+sLFJrhzRIfB0N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(83380400001)(86362001)(6486002)(31696002)(8676002)(186003)(966005)(4326008)(38100700002)(478600001)(2616005)(54906003)(66476007)(66556008)(2906002)(316002)(36756003)(8936002)(66946007)(53546011)(31686004)(110136005)(5660300002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXpjblRhV1A1d2JtVnZvVGJqUDNweDdwcWh1dGNuSXZtbThjOHNQRjJmVzBG?=
 =?utf-8?B?L0VJTGpmNzdxMjFYcGhYMHRGUUtJMmtKdlJmcGVGQ1ZnZ2VvYmJZa0hia04y?=
 =?utf-8?B?L2pjSlQ4WDZHTml5RitCY1BsRGNkdzEzaHFDUG8wN081VjQyU3Jkd2x2SmVU?=
 =?utf-8?B?WVlqUHhFN2VZM2hMN2lGcHlJVmtwRU4xY1FzVG9ZdENlYUcweitNSXNBSFdi?=
 =?utf-8?B?M1hNOGRXK20vT3JqZDYvY3ZWZFlLWWdUR1JneW1PQ2dUUTFuU1JpaERsN2NJ?=
 =?utf-8?B?V1dUQWtjUytkaVNHOGhkV0NrSmxZdm1GZTB3Mkh5SFB6RkZhYStlOUxIaG9v?=
 =?utf-8?B?MEJrSTIxMkROM0JoZkxYQzBVYUtnZDdaR2tCSWk0b25rNWVSNitjMXIyRFlj?=
 =?utf-8?B?SWtwWVFsOEZaNGtjWmI1STlKZWZNZFNhUE5UNE5TNTZmYTNPOGRDVy9vWTFD?=
 =?utf-8?B?UGV3YTZScEsrTjhyNkhwa3NBUG82L2Mrak14aUd1NjUwRlpNZ2dwWE9LRStF?=
 =?utf-8?B?VzhrZGNvTWtJeEFlZjdrMExnU1Zhc2VERStiY3R2WnAvcmhxSmtlMG5QYWk0?=
 =?utf-8?B?KzJsTHhxS0pNRytmWjEwdkxoRjVPbVlvQmY5Tk8vMDFMaUV3TEpiUU0reDRq?=
 =?utf-8?B?bnh2dFFzOVRadjBpYmUrQm5QUkJUdDZhRytZRXdUUkNIbE5hMmk5YUl4SkxW?=
 =?utf-8?B?c05pNGlLMUZ2SHhCczcvVllGU3UrNW5GKzZveDJTUWc0VUdvbmQvT0hFd2Ez?=
 =?utf-8?B?VWFHU3lDTXErWSsycUlmSXpyRERuK3hJUE1HeTJnNW1oVDM3OVprTVNyRFV3?=
 =?utf-8?B?STZRNWdaMnhHVUpPQUJrUFBHRDdQdTNWemp1MWlWa2pwRFV5ZitXZ1lKcFIw?=
 =?utf-8?B?TjJNNzEySkZiQzNOdUIwNlFucy9XVEhYaU1uOFErOFh2NE0zNS8wRTlRVmpR?=
 =?utf-8?B?d0FsOWxxdFFXOTlNR1phU3hWRUdXNzJaN1JvRGJtMm9VTFF2alZtRDVXMUtj?=
 =?utf-8?B?ME0zRE8xVjVneW9XVUxSdkhzVUVSQlZFcVdnZmZEbDhBU0pyVWZSeVQ5TzRK?=
 =?utf-8?B?UjhWSzc3NkN4N21OWXVaWGltZkdUbWl0WFc2RzdMTXBid0prRnd1aXliVHY2?=
 =?utf-8?B?Mi9XTHJjajRKb2JWUFJpMDBzNUoyREowdmE3eEptZ2d2TFVXUzhMS1dNQzUv?=
 =?utf-8?B?VTdHd0ZjTFFMSERlSFAwd0orcU91UFJra2F5MjVpVVVBTXVUcHFqdmJYZ0dN?=
 =?utf-8?B?MWlFTmF2ODNRQnNvdytuN0grWGlvWmNncUFBT0lXcEs3U3pzKysyNzRmR0VR?=
 =?utf-8?B?OVFrcDNwS0FEMEFPWDkrV25reThXaEpCbCt0Qnh1MFRXYTVyWitjUmdGamFE?=
 =?utf-8?B?c3RpUUozcHhVRFZMc2dFb213MmpPMldWenlzRzNVMGk0K1pEYURpZzRSY2E5?=
 =?utf-8?B?R1IxSnhUeTNUVS91ZE5aOEJCNVN3K1BJNGYrSVBoN2pVTzROeUwvTGI5MjNk?=
 =?utf-8?B?UEpPRHc4YkxkN2NqREE3YkZYT2MxTzFKTm04RGUwcnJXY2dyMHovTG1SdFp5?=
 =?utf-8?B?YW1CMUs4YmVKRjd1a2p4bnM5SVlZNGgwMDh2SVZWMkhQaWFUT1crTzgxMzZs?=
 =?utf-8?B?bW9ZUVZwUldsSHNRSEtEeFZKRlZFK0UyMi9NMDEzVTBPNVlxNWNrN1pJZ3c2?=
 =?utf-8?B?S1I5VVB6N0ZXc1I0d1o4VEJ1bFJCLzUyK2JhbjBQTzZHSGZjMW1ET2h4ZUJt?=
 =?utf-8?B?eVM4QkxleS95NDdUZ1ZDeWNJdUF5RHdEVUVUcDQyTlJFTyt2aXNWRzlzRkFP?=
 =?utf-8?B?cE9FVURMaVFQOWowcFpwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ea353e-878f-4582-1204-08d95b85de8c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:34:37.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSO/0vcX1bHjy/yYJ8ZizVoEwwIbGhb4tTO0qXAtPAWZdennH2zxnI4798Apywcx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FL869ixxMbvhIX7zgHPiY-OmmDrZdxBO
X-Proofpoint-ORIG-GUID: FL869ixxMbvhIX7zgHPiY-OmmDrZdxBO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/21 1:29 PM, Daniel Borkmann wrote:
> On 8/9/21 7:58 PM, Andrii Nakryiko wrote:
>> On Mon, Aug 9, 2021 at 10:41 AM Yonghong Song <yhs@fb.com> wrote:
>>> On 8/9/21 10:18 AM, Andrii Nakryiko wrote:
>>>> On Sun, Aug 8, 2021 at 11:03 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>> Currently, if bpf_get_current_cgroup_id() or
>>>>> bpf_get_current_ancestor_cgroup_id() helper is
>>>>> called with sleepable programs e.g., sleepable
>>>>> fentry/fmod_ret/fexit/lsm programs, a rcu warning
>>>>> may appear. For example, if I added the following
>>>>> hack to test_progs/test_lsm sleepable fentry program
>>>>> test_sys_setdomainname:
>>>>>
>>>>>     --- a/tools/testing/selftests/bpf/progs/lsm.c
>>>>>     +++ b/tools/testing/selftests/bpf/progs/lsm.c
>>>>>     @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, 
>>>>> struct pt_regs *regs)
>>>>>             int buf = 0;
>>>>>             long ret;
>>>>>
>>>>>     +       __u64 cg_id = bpf_get_current_cgroup_id();
>>>>>     +       if (cg_id == 1000)
>>>>>     +               copy_test++;
>>>>>     +
>>>>>             ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
>>>>>             if (len == -2 && ret == 0 && buf == 1234)
>>>>>                     copy_test++;
>>>>>
>>>>> I will hit the following rcu warning:
>>>>>
>>>>>     include/linux/cgroup.h:481 suspicious rcu_dereference_check() 
>>>>> usage!
>>>>>     other info that might help us debug this:
>>>>>       rcu_scheduler_active = 2, debug_locks = 1
>>>>>       1 lock held by test_progs/260:
>>>>>         #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: 
>>>>> __bpf_prog_enter_sleepable+0x0/0xa0
>>>>>       stack backtrace:
>>>>>       CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      
>>>>> 5.14.0-rc2+ #176
>>>>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>>>>> rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>>>       Call Trace:
>>>>>         dump_stack_lvl+0x56/0x7b
>>>>>         bpf_get_current_cgroup_id+0x9c/0xb1
>>>>>         bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>>>>>         bpf_trampoline_6442469132_0+0x2d/0x1000
>>>>>         __x64_sys_setdomainname+0x5/0x110
>>>>>         do_syscall_64+0x3a/0x80
>>>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>
>>>>> I can get similar warning using 
>>>>> bpf_get_current_ancestor_cgroup_id() helper.
>>>>> syzbot reported a similar issue in [1] for syscall program. Helper
>>>>> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
>>>>> has the following callchain:
>>>>>      task_dfl_cgroup
>>>>>        task_css_set
>>>>>          task_css_set_check
>>>>> and we have
>>>>>      #define task_css_set_check(task, 
>>>>> __c)                                   \
>>>>>              
>>>>> rcu_dereference_check((task)->cgroups,                          \
>>>>>                      lockdep_is_held(&cgroup_mutex) 
>>>>> ||                       \
>>>>>                      lockdep_is_held(&css_set_lock) 
>>>>> ||                       \
>>>>>                      ((task)->flags & PF_EXITING) || (__c))
>>>>> Since cgroup_mutex/css_set_lock is not held and the task
>>>>> is not existing and rcu read_lock is not held, a warning
>>>>> will be issued. Note that bpf sleepable program is protected by
>>>>> rcu_read_lock_trace().
>>>>>
>>>>> To fix the issue, let us make these two helpers not available
>>>>> to sleepable program. I marked the patch fixing 95b861a7935b
>>>>> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>>>>> which added bpf_get_current_ancestor_cgroup_id() to
>>>>> 5.14. I think backporting 5.14 is probably good enough as sleepable
>>>>> progrems are not widely used.
>>>>>
>>>>> This patch should fix [1] as well since syscall program is a sleepable
>>>>> program and bpf_get_current_cgroup_id() is not available to
>>>>> syscall program any more.
>>>>>
>>>>>    [1] 
>>>>> https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
>>>>>
>>>>> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
>>>>> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id 
>>>>> for tracing")
>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>    kernel/trace/bpf_trace.c | 6 ++++--
>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>>> index b4916ef388ad..eaa8a8ffbe46 100644
>>>>> --- a/kernel/trace/bpf_trace.c
>>>>> +++ b/kernel/trace/bpf_trace.c
>>>>> @@ -1016,9 +1016,11 @@ bpf_tracing_func_proto(enum bpf_func_id 
>>>>> func_id, const struct bpf_prog *prog)
>>>>>    #endif
>>>>>    #ifdef CONFIG_CGROUPS
>>>>>           case BPF_FUNC_get_current_cgroup_id:
>>>>> -               return &bpf_get_current_cgroup_id_proto;
>>>>> +               return prog->aux->sleepable ?
>>>>> +                      NULL : &bpf_get_current_cgroup_id_proto;
>>>>>           case BPF_FUNC_get_current_ancestor_cgroup_id:
>>>>> -               return &bpf_get_current_ancestor_cgroup_id_proto;
>>>>> +               return prog->aux->sleepable ?
>>>>> +                      NULL : 
>>>>> &bpf_get_current_ancestor_cgroup_id_proto;
>>>>
>>>> This feels too extreme. I bet these helpers are as useful in sleepable
>>>> BPF progs as they are in non-sleepable ones.
>>>>
>>>> Why don't we just implement a variant of get_current_cgroup_id (and
>>>> the ancestor variant as well) which takes that cgroup_mutex lock, and
>>>> just pick the appropriate implementation. Wouldn't that work?
>>>
>>> This may not work. e.g., for sleepable fentry program,
>>> if the to-be-traced function is inside in cgroup_mutex, we will
>>> have a deadlock.
>>
>> We can also do preempty_disable() + rcu_read_lock() inside the helper
>> itself, no? I mean in the new "sleepable" variant.
> 
> Yep, we do that for example in c5dbb89fc2ac ("bpf: Expose 
> bpf_get_socket_cookie
> to tracing programs") as well (the sock_gen_cookie() disables preemption).

I think rcu_read_lock() is enough. For all the cases I mentioned in the 
above, we already have migrate_disable(). Together with rcu_read_lock(),
we should be okay. For non-sleepable programs (tracing,lsm), the helpers
are protected with migrate_disable() and rcu_read_lock().

> 
> Thanks,
> Daniel
