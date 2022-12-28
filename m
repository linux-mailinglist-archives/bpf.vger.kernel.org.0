Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057AC657349
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiL1Gfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 01:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiL1Gfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 01:35:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A89EE1D;
        Tue, 27 Dec 2022 22:35:35 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS5teJD010325;
        Tue, 27 Dec 2022 22:35:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7WJp0Qaeoqu+qOEuxzCGAlD/jFfiEWX4nsoJDzwTi0A=;
 b=huZrWVAkiqBeQkZyYuemKGPaIXJx2Czsofa+2DNCzE3ZM6TV43BdJ+66HjBDXCYhulyA
 yfzGpVUOzJGwYDCzgUmItnhE6lRQRaVszYuETOxp6SJKqrhweCcuZgt1vRECB1/JKwvR
 uwVN6eSsM6cIcNkvTV3N8KQ6Umu4Jaul2Rn8lAb9BhbZp0kFFU+Yd5MS4B+K9/6Z6KXL
 6NE/Vle5PJUOGGlItsGAj3c8Zu74Mpuut+kAb+wSQbxYQ+dNsxqseurgP2kS+52M1IeG
 KwU1Onl2ABZZWzalRUIml72zAFJ5wgDk2HKGVb/B9GkRRegc93WBeDHgMqsQ/7d9mjnr pg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mnyu5s9d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 22:35:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIRShqLYAMfVDugJi3D8JBBWkDk/kRrAqFu2EFMJImBa2G7hksL7LWWfnGCViYgRCLy1QfJ6JevCDoOufzAj+XOQVDchtY8IM5DbuFe0TZGJD6ZAL/BBIKcVcAduV61OeZbJCwG1dZ4XDpNR4wpWtWR7IGHQzgge5fclcEFsH3nd0PNmJtpakfKADzf4ALVtHv8vVtZzhyz2sWekdmi6stUixxO5clxKefQAr7OrALBFH/psCM5iOX+NmKtDKsHjl01HeTqCIaPYJ2HcxBcfstBwGPbHp/f2ScqsCaAF+Y7erKpc9whWG1PFJytX6Av+knmXvwbGePbs+IZU68EkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA/ZjiL1qHOPUGu8eyWw0nf60w4I5B/rPu/wQ8Pin+k=;
 b=lpBxXWaCJiV1uXkOAL2vxgwnyWwPIJbPdMjHuK9cVPJBBmnXwRrbazOb+wPx4r6+/ctqu4o1YA+PJfR5qs4Ic5E2BoEGPbCsPpkYujJZvPBIHZ8da1ccnUKqd/VHBEdeTAZSr14wzT1H4MJW83yNoYKKc8TZwB0SqGo9fPsRK+tNYxueJk2ISczx8LgmTlR7QgP9rnMRmA0Z5A0gIUqgGmHqmoBB/wpTd/dLxGO+3o1OSZpC9nuQiAluMbjUd9EnGCLOt6tiZ4Wzv4jDjhp9Zal/rWOFKepGX3b0FeoDy2MVpJkepevYq3GmtI0xZHCXNpluxr9TMNgDK+3ZEcBBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2928.namprd15.prod.outlook.com (2603:10b6:208:f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 06:35:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 06:35:04 +0000
Message-ID: <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
Date:   Tue, 27 Dec 2022 22:35:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: kernel panic: Attempted to kill init!
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20221222043507.33037-1-sunhao.th@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221222043507.33037-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2928:EE_
X-MS-Office365-Filtering-Correlation-Id: 318f16af-b99c-4166-627b-08dae89da71c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YoJeYwsrce82FyBCW8xGTT1h0T1U+Amlq1vonr8gf6u7eNEB2442/sqO0NYXKSP2HZUAM1fKdniIXK9A1/htjKzWSfSbU5oYgk3//T6ou02YK5bcleIwMmi6SIb0kKhzx4Lw9FryG8UiVsG67KCsf+GYNqYGFfdERvV4vIXxplq1I7/CRbly6kWPp/4tkvDqw6+55cTdyfzcNZHHbFWHsVCJ7qNuo6GNtOQF3bo364SrMrw56FSsRV0JAWn5pohJlm8oO52Ll6irfWz8pylg9/ma8net55xiKOgcWu6WJhKlIek8xCZwlqGztk1by8McsHRMJW1DSXOvPC3yuySMC9Gmkz1+AukfXWmbSQb9pljpY7EbPKyxCNOo3htsaY9PsnjbE2Ghbdvim4INLc+HL/TvkiEH5GqsATBVXRedeyMCJuxii6b5iLHRXa3NaKlH9oRFWVpvXiQCS4v26C4IJt0KbZk7PqTGYDSj7yJcCYyNLVH/ZhynVwvK8Phq9DXq2C5Gctz2PP93n1rc4YYJu++s6+XqjSnfdL8Ji/1ZhGCX5G+7gp1KME9KBeaekT1l30Xg43CVdnyq/nX/BN2k0xa7uwbLuXu2S1SGPVO1CNESW8MUY4dHob6Nyv2Mv9XLwEIbAOxUmWOZwOtI2nxRlZJ1gKg7a/Yclfbzs2k43C5lWcrHTaIRjT6nW+wEZ9PqaSEU0XtX0qF1+ssWzNKLRuIvBJY2/Dga6rY5FTyTf5ppch3tvIJlyesIiYZm68lh5Oq9drcfCqPCFQWBYcIKySQ3dV0FfdqWxI66bKya2G18Na1RoMrG41F20dOMdTOzJuPc/FehMRZwoMt6XQC6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(36756003)(2906002)(7416002)(5660300002)(8936002)(41300700001)(31696002)(38100700002)(83380400001)(86362001)(31686004)(66556008)(316002)(66476007)(8676002)(66946007)(6506007)(478600001)(6666004)(966005)(186003)(4326008)(6512007)(2616005)(6486002)(53546011)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2Fvc2hZTXVVbWgrUWY5Y3lzNmU3UFRVOFQxMEwxKzJXRGFxdzN2STlBMW1G?=
 =?utf-8?B?QmlPWVB0TTVTOGlpT0dtVGtCdVE3VVFmWVpKUEt3cmxxaXp4bjFUUUZRUWNN?=
 =?utf-8?B?Z09HRityaGdYT2VtWVF0RW5WK3JCRzZvWGttVk85b1gwZHJLTTBlaXdmUnl0?=
 =?utf-8?B?T1NoTEZsV3dYczJEVmJ1elY1OUpxM0JBajEyMFdOQUhVZkowb0VxYWs0S0hv?=
 =?utf-8?B?T3djLzZhbGJQcXBPQkprNG9WblNtck1rZ2JnQWhPdUc2N2x4K25GUnlRcWlu?=
 =?utf-8?B?UTBpV1VyZUF1TzhVSmFrSHpZWmRnQ3RVUTE0dnlZcko0azdubms0Zi9zU2dr?=
 =?utf-8?B?d2FCR0kzS2tDZjRZejZNLzkyNmtKZTF0QWc0WU5GUVI1eFdkeWYzWGl6c28w?=
 =?utf-8?B?N0pPRWlKTWl0cGtVVloyQnpkejh4OXlxZFhzeStETWoxdm9kd0NNc08vaGVG?=
 =?utf-8?B?QzRqcFZnZy9rL05tMGF6bE10d2VaYmZSeWZiM0Zwc2ZhbVFTRXh0ZmpVeTNE?=
 =?utf-8?B?U091MmVweTRIUlh3NllsN05HMXN5bWxuUkIvcTU3ckJEamd5UDl2SFUzZExP?=
 =?utf-8?B?U0w3MHpJQkkxYnliZGptUWRVeDZpRmxUTVA4K1l4ZFhSZ2VsWkxBYWdmSzY4?=
 =?utf-8?B?RFd3RzNmMG5xRGMxKzNtT3NJNXFDSWJNMXBqbkVqK2tMMml5NGFYNm1oaHdY?=
 =?utf-8?B?eWN6eTdwL0pFZ3BVYlF4TnZaeDlacGthaTZHY09rYzZiU2IzVERSVVV5YzJX?=
 =?utf-8?B?WFpLYm5ENVUwZUtvRVdSUlNsTUptcVRaM2lVL0htTm5NdzljdG1YREtIcjVu?=
 =?utf-8?B?RVZnc3U1bmNIcHFHQVBaR3ptWkh1RHhNbmRSaGxsNVkwMjIycDFPemUrbDcy?=
 =?utf-8?B?bnozTERMRXg4dUdZenB0S2R1VEszdEF1Slp6MUd5TklZN1ZHcHZFbUJoK0xa?=
 =?utf-8?B?T0pFcFFVQTBJS1VNVi8wOTZJTldCc04xMTM2dlM2MkhmUm9aVkQwVnduRWZm?=
 =?utf-8?B?cmtuS0JTa2UzNmFIWXliUE1WNzByZDRySUhlS2NGbUNrenBzVVFpOWsvYlpy?=
 =?utf-8?B?dmpXai94bjB0U05PcTFFYlNwSktMMkFQSlVjVm5wQVhtYVMvZ2Joa1A5Vk1p?=
 =?utf-8?B?T09pVldsaHRVMzlsbkhsaFNiQWRwNTluMmxPK1dzUHdUZFFVZW50MlRpcmlK?=
 =?utf-8?B?VzJPZXZ3aWRsZy9YMjc3Wm9IVzZCdXU3b1NLazR3Sm9OaWxvSG03QVp1bUtJ?=
 =?utf-8?B?dXNESDhOckhIR0I4cS82VExWN0hKOTdLV0VFM1RKOGlvVy80NVhocDg3VlRR?=
 =?utf-8?B?cFdQMndFYjhDSG84emJpZElxcmNMQnU4Tmw1M2x4UzltSjdGbVN6NlRqZ1E2?=
 =?utf-8?B?aFV3TENnTlpWV2ZVK1dWR0Z0Qkl0K3kwUC9QVU1qNFFvZW1tSTBvNHNJVHJP?=
 =?utf-8?B?NGl1OXhhUFl5SjdWSmRHWG0zSE1Kc0N6VytULzBCVVQ0dkkvdk43dE5FU0tT?=
 =?utf-8?B?SDUwNUJtVDI4QmhVWXdOc09QR0VOWjRxNWtMZ3NCZjd4NWZLK3VIQ2lGSVhF?=
 =?utf-8?B?NkZzVHQvOHFCb3M1U0FhNW9HRE5wV3hweEppVFBnWmZKejNwNFVqVjVwRHFr?=
 =?utf-8?B?VjlBbDZoTk1VT1VyWmpBdmlTaVg0aFo1dWZQdHJRZWM5Z0xydTVoYVZjZEp2?=
 =?utf-8?B?cW1za3p2RlZpdVA3TWtEMTNMRGV3MG10Nm8zakw5eHNJaktaY2NYLzBZY2tS?=
 =?utf-8?B?VUZRb1M0MW5OT3ZSYnpvR2VMd1l2clliT3BZSWtFcVpOb0thakdNUzQrckVp?=
 =?utf-8?B?QTUweXZhWlh4bElBelNOVUxIRzZvcjR1YzZlYW14L25oZ0czVWpReFptZVAr?=
 =?utf-8?B?V2RBVFgwVnN4UXJhSFdyMUFkV2kySnFHZ0NTeWljVVc3QkptT1dYN2dQZllz?=
 =?utf-8?B?R2NMaEdMWkpjZ3RWV1pZM29PNElOWFh3SFdKUVZna21SK2FZa2hkeEdzWUM3?=
 =?utf-8?B?SVJmWDhsSWpnY0lHN3dSMk5QeFd1MWh4UWQ5S2RMNk45ck1XZis1Y0VrekpB?=
 =?utf-8?B?dm9PL0Vkb1dFRkdnWHhRa0wySTd2ZFJ3U2IvdEJWbE9nOWF1VGk1ZThidGZY?=
 =?utf-8?B?Wm5UMnFZNG9kcERoa0JBTXhpK1M2dWRzbmwvVkw5WGN5V0RIbWN0VncrTHd0?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f16af-b99c-4166-627b-08dae89da71c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 06:35:03.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVMar4xAjvXPGZeXIv0BApHSWBQ+qF6E/fLvyt/883b/m/0Ea4mN7sFoGEjjj1NR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2928
X-Proofpoint-ORIG-GUID: k-HCU0ALqRwmt5_ueitg4alaPnGMDD3r
X-Proofpoint-GUID: k-HCU0ALqRwmt5_ueitg4alaPnGMDD3r
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_04,2022-12-27_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/21/22 8:35 PM, Hao Sun wrote:
> Hi,
> 
> This crash can be triggered by executing the C reproducer for
> multiple times, which just keep loading the following prog as
> raw tracepoint into kmem_cache_free().
> 
> The prog send SIGSEGV to current via bpf_send_signal_thread(),
> after load this, whoever tries to free mem would trigger this,
> kernel crashed when this happens to init.
> 
> Seems we should filter init out in bpf_send_signal_common() by
> is_global_init(current), or maybe we should check this in the
> verifier?

The helper is just to send a particular signal to *current*
thread. In typical use case, it is never a good idea to send
the signal to a *random* thread. In certain cases, maybe user
indeed wants to send the signal to init thread to observe
something. Note that such destructive side effect already
exists in the bpf land. For example, for a xdp program,
it could drop all packets to make machine not responsive
to ssh etc. Therefore, I recommend to keep the existing
bpf_send_signal_common() helper behavior.

> 
> This can be reproduced on:
> 
> HEAD commit: 59fe41b5255f selftests/bpf: Add verifier test exercising jit PROBE_MEM logic
> git tree: bpf-next
> console output: https://pastebin.com/raw/FMgyvEnH
> kernel config : https://pastebin.com/raw/XeF6jU43
> C reproducer  : https://pastebin.com/raw/Tag5N893
> 
> func#0 @0
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (18) r0 = 0x0                      ; R0_w=0
> 2: (18) r6 = 0x0                      ; R6_w=0
> 4: (18) r7 = 0x0                      ; R7_w=0
> 6: (18) r8 = 0x0                      ; R8_w=0
> 8: (18) r9 = 0x0                      ; R9_w=0
> 10: (2d) if r0 > r0 goto pc+2
> last_idx 10 first_idx 0
> regs=1 stack=0 before 8: (18) r9 = 0x0
> regs=1 stack=0 before 6: (18) r8 = 0x0
> regs=1 stack=0 before 4: (18) r7 = 0x0
> regs=1 stack=0 before 2: (18) r6 = 0x0
> regs=1 stack=0 before 0: (18) r0 = 0x0
> last_idx 10 first_idx 0
> regs=1 stack=0 before 8: (18) r9 = 0x0
> regs=1 stack=0 before 6: (18) r8 = 0x0
> regs=1 stack=0 before 4: (18) r7 = 0x0
> regs=1 stack=0 before 2: (18) r6 = 0x0
> regs=1 stack=0 before 0: (18) r0 = 0x0
> 11: R0_w=0
> 11: (b7) r1 = 11                      ; R1_w=11
> 12: (85) call bpf_send_signal_thread#117      ; R0=scalar()
> 13: (95) exit
> processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> 
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
>   panic+0x2c4/0x60f kernel/panic.c:275
>   do_exit.cold+0x63/0xe4 kernel/exit.c:789
>   do_group_exit+0xd4/0x2a0 kernel/exit.c:950
>   get_signal+0x2460/0x2600 kernel/signal.c:2858
>   arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
>   exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>   exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>   syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>   do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x55e738964df0
> Code: 00 31 f6 89 ef 4c 8d 05 be 1b 0d 00 48 8d 15 b0 85 0c 00 31 c0 e8 f0 c3 ff ff e9 1c ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 <41> 57 41 56 41 55 41 54 41 89 fc 55 53 48 81 ec 48 01 00 00 64 48
> RSP: 002b:00007ffeb8e87bb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f7
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f29dc8a6bc1
> RDX: 00007ffeb8e87bc0 RSI: 00007ffeb8e87cf0 RDI: 000000000000000b
> RBP: 00007ffeb90b73c0 R08: 0000000000000000 R09: 0000000000000002
> R10: 0000000000000004 R11: 0000000000000246 R12: 00007f29dc3f76c8
> R13: 000000000000294d R14: 0000000000000000 R15: 00007ffeb9686870
>   </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
