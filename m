Return-Path: <bpf+bounces-484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EC701EA1
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EBD2810BF
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85E79C6;
	Sun, 14 May 2023 17:12:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8496FA0
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 17:12:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4040C0;
	Sun, 14 May 2023 10:12:44 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34EFIs9j031681;
	Sun, 14 May 2023 10:12:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9BPlB9sq8wFeziZs0MERpAS1OnMy/a81B5axDQj3p20=;
 b=It4Qr9yBWQH2Q6uYXqX+7iRkWb1Y5Un2D4kaqHKbI3BcVXn61AT6zDps/j1E9ivRPaYP
 97sPMRA5TDyUJk5hkcWwE58tmIPtmD2UmmWSPATgTdsWH9ejW22FDbEY3/ZJYjfImoql
 pHty3VmEbTb6cV4WKp0Vroq5E6Nthj+BrLY+zpc1/JpvTljvAtIYwofTsUj9kicvJV+M
 ul2Lay5mtkThv/AcUIaBCtaG2wJOVlTjeMC2kWNLxGnAk/vKAHSHQuNezV4+VTsOW2Ob
 lsWmikR2bG9oN8Y66RnumS69lnUUBnyLVZOjYdZIuqh1SZUQpJzcyYRgBQ6JRyYYvfQo Ew== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qj629y24r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 May 2023 10:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt2I04MFPq1WkF0pOm98XL6og8Q+GWYm5ikJmQigQNcX6mf/g8OsAV8W4AnfwPreJ1osZDTNG94HZDZjP/7SNt+0v1xCnLejQihd9IidrIkvo9iWSvPmnrNXZo+Pgm+zXtuuTcT11mda/VW0hcGrZwkbnHkdGmZ5FGrkJSt6LUIP1rJmc07m9AKc9lcPKIakUmoQDwyk2DtmBUQjuYTpKPmam+x+vSgBUWgvW7wX+S68qfESgywb/dKbE4fliuVsWwGrvimmoKF69RW8wbY9n+QOrPHQcOVWhSN/kEaSjtSqxEj7GKoSpxxSJWg5ITfpHegk5Es8wrQZiHt5yy0j4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BPlB9sq8wFeziZs0MERpAS1OnMy/a81B5axDQj3p20=;
 b=gN9qk1FrJoHx4Xy/e+YDBCla36DVcfYF1QKLgJN3kySvDwA8MX9hmvSWl1Y8WlucxWJU04pLFuktbZs2/DakYKGJOIdG4IKTpGzAg4xb9kyVez1peSImJ6B9x+f67BUNDtZQ/lWwrcBhBepCdYAqKNvnW27IfbAT7UPntglczqZHsb1dG9tqaQyFNxzdlZ8uk39VVpwQDWU8fym3rv7ibP40/Tp2jXmuIXpiNiJq6t/uvRHSo7vczvPUsIF85kUzpcbkCtwm0fvy8b93bTB1hGv/0p2qWYLdW5OXQC3rnEKOhXR0t1NYKZ2C/KsZjJ7SSzpEvQK9VVmh21GPiri6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6243.namprd15.prod.outlook.com (2603:10b6:208:471::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 17:12:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 17:12:00 +0000
Message-ID: <024f3c9c-98ee-6a8f-e188-01b459fb4a96@meta.com>
Date: Sun, 14 May 2023 10:11:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
        Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
        Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230510122045.2259-1-zegao@tencent.com>
 <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com> <ZFvUH+p0ebcgnwEg@krava>
 <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
 <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
 <20230513001757.75ae0d1b@rorschach.local.home>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230513001757.75ae0d1b@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5621f8-0047-4b9d-5f50-08db549e5449
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yb47Q70Xr1XEy84uRmDwMzaYcWWVHzulyzIwc98gw385cH3UHGVoIaPHMwzPFaDsIRlh8JJ8b8EHAsE6V4Hd+sQePDqwDPWmpHSewd/I6LZMF1aJiHjSNgKYwHzla10AnhWk9paZ7+8fUuAdaDYLoc62NchaZJZNkP9mr9gN0C5QjM4Y9jZ4pybYC5TlhSn1GKLOzmpyg0TGLRnwxLrL1nqVQF/dVfVfAniQtWyhBWURTcy366vvfSMaZi8J/WvyiQ7Sv+CCMiTVB2QYMF9BL3YRa5T8VHeFf8z4LhbsTxHBIkN4p67kF6JK1kfzq44ioTahNQXg0f8eEMfSIr9bqRcnxxiTKafKZuTVhlMbzAWyuC8KMyoixM67VKGbtvQ0mdHojKJZN7tNInd/lu24f2FLpyvY4/vd8K384y3yXS7N5UYsvQBtlMpOUJL2FhLVmw2lKezsBAxoHOcD61nKPNsoq8GBtvpk200plnN75jKioWWh11WGo/pW7dntBFeYMMWW00ro1IS/HFBGQ7rozQh7Cby7jUZWJoepU1JVIPpaAuwO+GnoHEukNJ4dhTAk6aowggvvNJ5I3u1B+/lpuj60ieSrRR7LYdRjbUEIPo80ryntjy7tq4fay9L7seBn0DGhjap/gBWKyGyNnPTdqw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(54906003)(478600001)(66556008)(66476007)(6916009)(4326008)(66946007)(6666004)(6486002)(316002)(2906002)(8936002)(8676002)(41300700001)(5660300002)(7416002)(31696002)(86362001)(36756003)(38100700002)(2616005)(83380400001)(186003)(53546011)(6512007)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW5pZzlVOGVnUXNZckRhTi9YN3psWjJKdzI5ZmJsMDZNa3ZXV1pSazFyS0JS?=
 =?utf-8?B?em1ESVFUb2hZUVhiQnd6alNZcEVFMlc0Z2FsYjllbkVkUm5qc05zNW1XaUg3?=
 =?utf-8?B?a0JENkt0RzlBcnVITU0wSmpxa215Y2phTmJ3OUhWbUtnTXdqb29COHV3dmtl?=
 =?utf-8?B?KzlzMEF2SmdXV3BxY1BWbThOOThzVGU2TTNhTm1jcXpNNGdXR2VRTHA4Nm4w?=
 =?utf-8?B?elJDSzVMN2pnYVJxcndIVk1iUS85czZ4cVJjNGFZRVRmQm10T3BGbzJ4N1JX?=
 =?utf-8?B?OVNqRmk1bW9HR0lESjJxNzJtZHBlVW4wTnIyY1JLRStURUlUVmwxVmNOSGhR?=
 =?utf-8?B?aUhDN2N1S1QrMzVvb0piK1lRM3hKemgySFJydHR4SG95SEFOQnNUaGkxRkw3?=
 =?utf-8?B?Uyt0RzRiT2tLWDEyVDhsNzdXWUxHeGtBMkV5d2JjUnpJMS9saENPUmRyWEV0?=
 =?utf-8?B?Q3BTSXVJTnB4VVd3V2UvcWpHSWk2QXZWV3NpcFQ2WVdmSS9wdFlLcHhwUUlz?=
 =?utf-8?B?LzRUYUR3ZHMyOUN0dFJZU1dQNXo1U0dSRWxWUDRMNHZoYmZIQ003cHBUTWxI?=
 =?utf-8?B?NkdRUk1uQldXY2ZsS1l4L3MyMzhhdmN0clBha3JOT1VFTjgxS1dmNFBYVXRE?=
 =?utf-8?B?RlcrVzNJOUg0SVlQVUJOSXlsb3FLbWRuRmp2cndoYUFFcS8zaisxbDcwNEZp?=
 =?utf-8?B?VVpnR0Z4S1RDUU9wNFY0ZXRjd1g4TmllazhiQlVnUC9yZGw2R0VLVkVJL0xh?=
 =?utf-8?B?c3pldnJEcGN2UGtaRjNrQVBHMll2dC9OQldkemtKSWN2UzNaU2R6dUR6bWZq?=
 =?utf-8?B?TkY3TEovUndJT3UwdnAxekh0L1lEd1ZBZndrdFliOTRJMmNCZlhXenJTYlh6?=
 =?utf-8?B?NFdWMnZpWUhMeUFNdFNyLzZrT0ZId0lGd24xZmF4SEU0TmZ2Uy83VVc1NHZ5?=
 =?utf-8?B?amxacGRjTGVHdGx2eVFBNnRjdzNSYkNFYzVkT3ZEZ0ZxVVdEa3ZjNlRKZito?=
 =?utf-8?B?b1JsdTJjRmxoa00xWjVxODRhNjFicE5ydGR1T0VNTzZIOGZ2dkYyTWw2Yk5t?=
 =?utf-8?B?WDlja2VIaTVKVER6K2U5Z0hWa0ZPM3VRSFQ5ek9iTElzZkVDaFpCVURNOU9u?=
 =?utf-8?B?akJ1UmZySjd1cFYxT3RvSGVVVnZlcUplNzhNNVo1Z1JHaFZxZkVIT1EybURh?=
 =?utf-8?B?cFRyWFZ1ZWlkWjFpWWt5UWJLckYvR2o5REw2VU5hS25IN0orZW1FZm5MeFd0?=
 =?utf-8?B?V2ZnNU9NcGc4M1lqUnh3ek8wUU43MWFiaW9mU0ZFWU1KbmtvemdTT0tvS0hR?=
 =?utf-8?B?TUJYazlkdGtUYzJ4Y3lKcXRCNDU4czNnR0VwZythZ0JJeDVVcWU0b1FaSUFE?=
 =?utf-8?B?MkhabXB3cVRiQTVPc0EvWitad0d5Q3YrV0N1b3gvVDljZmtIVkVsQ3o5VWUz?=
 =?utf-8?B?QmdwdS8xWFNMZi9YSS9tMkU3QVhsWENLUDNIRXdkMTdGbG5RMHQ1QlZTZDVl?=
 =?utf-8?B?L014Tm9Oek5iTXp0eHpLNmJqeWhYWTF1QUNrbi9mT0R5OG0wZEo4UHg3Vzds?=
 =?utf-8?B?WWN3bnQ5TStQSFpjRnNGNjJlNFRaaC9VeURSTG0yeXliL3prT29oc1J1WjJm?=
 =?utf-8?B?TlRETitrRDJHckhkNXlnZVVXMnp4Rit6RTdPM3VzOTd2aXlLNUxOb3lvcWRz?=
 =?utf-8?B?bkZNT2dJaDF1L2hMQ2F5emZuT0hvUWlmeHJTVGRNYXp3YVNkb3p2RVlRTUpQ?=
 =?utf-8?B?bHZYVmh5TytuTTREQlZQSmpkMmtWem1xTytwRDZ2UWZaNXJ2NHZ3V2gwZEVM?=
 =?utf-8?B?SjBvNUduV1hkc1MxSkZDRVVpeG1mSUNvS3R2VXlVLzZpMVppUDBNdHJkY1hV?=
 =?utf-8?B?TkhBdjZBVURKNGQ1Z2FIVnpiY0g3Z2VOMlhIVmFHeFNYODdMWTNSVmdnMlNI?=
 =?utf-8?B?WDFnUGxZblVTNEF1UDdXbE12V1Q5SkppZmFiTUQxTElPNWorbnIrM2xZRzRB?=
 =?utf-8?B?bStWVWRiNm9lZ3QyenUzd3J4WlVsZWpjbjRqNmdnbzhCRUY4K21iUmxmd0Jt?=
 =?utf-8?B?SGdQNGtrbkcyZ0Vldm8wY2xNbkNXTGNGT1ZUelBmQXBlb2lLenVNQnM4WVZy?=
 =?utf-8?B?M0swRjNGYUxlUlJ0Wkx3bWlMN29CQS8vM2piMm9DWXVqWi9LZTEyOUcxOTlD?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5621f8-0047-4b9d-5f50-08db549e5449
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 17:11:59.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tv+bx65sTmE71uygGD4xNb8NCSZNk7u78rB8G7N3/Ao+KNNzClY7nnRM3d1WCZQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6243
X-Proofpoint-GUID: D69aH2apLPnWprgUP1Wco3aa7kYbEE1J
X-Proofpoint-ORIG-GUID: D69aH2apLPnWprgUP1Wco3aa7kYbEE1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_13,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/12/23 9:17 PM, Steven Rostedt wrote:
> On Fri, 12 May 2023 07:29:02 -0700
> Yonghong Song <yhs@meta.com> wrote:
> 
>> A fprobe_blacklist might make sense indeed as fprobe and kprobe are
>> quite different... Thanks for working on this.
> 
> Hmm, I think I see the problem:
> 
> fprobe_kprobe_handler() {
>     kprobe_busy_begin() {
>        preempt_disable() {
>           preempt_count_add() {  <-- trace
>              fprobe_kprobe_handler() {
> 		[ wash, rinse, repeat, CRASH!!! ]
> 
> Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
> versions, or fprobe_kprobe_handle() needs a
> ftrace_test_recursion_trylock() call.

Currently, in verifier we have:

BTF_SET_START(btf_id_deny)
BTF_ID_UNUSED
#ifdef CONFIG_SMP
BTF_ID(func, migrate_disable)
BTF_ID(func, migrate_enable)
#endif
#if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
BTF_ID(func, rcu_read_unlock_strict)
#endif
#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
BTF_ID(func, preempt_count_add)
BTF_ID(func, preempt_count_sub)
#endif
#ifdef CONFIG_PREEMPT_RCU
BTF_ID(func, __rcu_read_lock)
BTF_ID(func, __rcu_read_unlock)
#endif
BTF_SET_END(btf_id_deny)

         ...
         } else if (prog->type == BPF_PROG_TYPE_TRACING &&
                    btf_id_set_contains(&btf_id_deny, btf_id)) {
                 return -EINVAL;
         }

Since we do not have a explicit deny list available to user space,
the above checking will prevent to trace a few functions for
tracing prog (fentry, fexit, fmod_ret).

For fprobe_kprobe case, if we can construct a user visible deny
list which will be the best. Otherwise, we can add a
btf_id_deny_fprobe btf set which should work too.

> 
> -- Steve

