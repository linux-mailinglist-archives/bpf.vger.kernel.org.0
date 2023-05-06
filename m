Return-Path: <bpf+bounces-164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354166F8D66
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9D1C20ED0
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705001360;
	Sat,  6 May 2023 01:13:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD410E6
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:13:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B61FDE;
	Fri,  5 May 2023 18:13:43 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCqHd0n6qzLnbF;
	Sat,  6 May 2023 09:10:53 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 6 May 2023 09:13:40 +0800
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko
	<andrii.nakryiko@gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Song Liu
	<song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa
	<jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia
	<kcarcia@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, Ian Rogers
	<irogers@google.com>, James Clark <james.clark@arm.com>, Kan Liang
	<kan.liang@linux.intel.com>, Roman Lozko <lozko.roma@gmail.com>, Stephane
 Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo
 Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
 <ZFOSUab5XEJD0kxj@kernel.org>
 <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org>
 <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <ZFQrT42SyEbCj4om@kernel.org> <ZFUCDVpqXkpGjXBK@kernel.org>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <bf082a2a-f360-95fd-9d18-0702c421b296@huawei.com>
Date: Sat, 6 May 2023 09:13:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZFUCDVpqXkpGjXBK@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On 2023/5/5 21:18, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 04, 2023 at 07:01:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, May 04, 2023 at 06:48:50PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Thu, May 04, 2023 at 04:07:29PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Thu, May 04, 2023 at 11:50:07AM -0700, Andrii Nakryiko escreveu:
>>>>> On Thu, May 4, 2023 at 10:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>>> Andrii, can you add some more information about the usage of vmlinux.h
>>>>>> instead of using kernel headers?
>>>>   
>>>>> I'll just say that vmlinux.h is not a hard requirement to build BPF
>>>>> programs, it's more a convenience allowing easy access to definitions
>>>>> of both UAPI and kernel-internal structures for tracing needs and
>>>>> marking them relocatable using BPF CO-RE machinery. Lots of real-world
>>>>> applications just check-in pregenerated vmlinux.h to avoid build-time
>>>>> dependency on up-to-date host kernel and such.
>>>>   
>>>>> If vmlinux.h generation and usage is causing issues, though, given
>>>>> that perf's BPF programs don't seem to be using many different kernel
>>>>> types, it might be a better option to just use UAPI headers for public
>>>>> kernel type definitions, and just define CO-RE-relocatable minimal
>>>>> definitions locally in perf's BPF code for the other types necessary.
>>>>> E.g., if perf needs only pid and tgid from task_struct, this would
>>>>> suffice:
>>>>   
>>>>> struct task_struct {
>>>>>      int pid;
>>>>>      int tgid;
>>>>> } __attribute__((preserve_access_index));
>>>>
>>>> Yeah, that seems like a way better approach, no vmlinux involved, libbpf
>>>> CO-RE notices that task_struct changed from this two integers version
>>>> (of course) and does the relocation to where it is in the running kernel
>>>> by using /sys/kernel/btf/vmlinux.
>>>
>>> Doing it for one of the skels, build tested, runtime untested, but not
>>> using any vmlinux, BTF to help, not that bad, more verbose, but at least
>>> we state what are the fields we actually use, have those attribute
>>> documenting that those offsets will be recorded for future use, etc.
> 
> Yang, can you please check that this works?
> 
Yes, I've tested this patch and it works :)

Tested-by: Yang Jihong <yangjihong1@huawei.com>

# perf kwork report -b
Starting trace, Hit <Ctrl+C> to stop and report
^C
   Kwork Name                     | Cpu  | Total Runtime | Count     | 
Max runtime   | Max runtime start   | Max runtime end     |
 
--------------------------------------------------------------------------------------------------------------------------------
   (s)SCHED:7                     | 0005 |      1.440 ms |         3 | 
     1.377 ms |     165822.963188 s |     165822.964565 s |
   (s)SCHED:7                     | 0001 |      1.388 ms |         2 | 
     1.377 ms |     165822.963188 s |     165822.964565 s |
   (w)e1000_watchdog              | 0002 |      0.532 ms |         1 | 
     0.532 ms |     165823.806777 s |     165823.807309 s |
   (w)flush_to_ldisc              | 0005 |      0.524 ms |         1 | 
     0.524 ms |     165824.255219 s |     165824.255743 s |
   (s)NET_RX:3                    | 0002 |      0.512 ms |         4 | 
     0.247 ms |     165824.254103 s |     165824.254350 s |
   (w)wq_barrier_func             | 0003 |      0.394 ms |         1 | 
     0.394 ms |     165822.964179 s |     165822.964573 s |
   eth0:10                        | 0002 |      0.250 ms |         4 | 
     0.115 ms |     165822.964814 s |     165822.964929 s |
   (w)wb_workfn                   | 0005 |      0.208 ms |         1 | 
     0.208 ms |     165823.998558 s |     165823.998766 s |
   (s)TIMER:1                     | 0002 |      0.205 ms |         4 | 
     0.077 ms |     165823.806548 s |     165823.806626 s |
   (s)SCHED:7                     | 0002 |      0.185 ms |         5 | 
     0.049 ms |     165824.255119 s |     165824.255168 s |
   (s)TIMER:1                     | 0003 |      0.167 ms |         4 | 
     0.079 ms |     165823.998326 s |     165823.998405 s |
   (s)SCHED:7                     | 0000 |      0.165 ms |         4 | 
     0.073 ms |     165823.807235 s |     165823.807308 s |
   (w)flush_to_ldisc              | 0003 |      0.156 ms |         1 | 
     0.156 ms |     165824.255723 s |     165824.255879 s |
   (s)TIMER:1                     | 0007 |      0.152 ms |         2 | 
     0.100 ms |     165823.358416 s |     165823.358517 s |
   (w)vmstat_update               | 0001 |      0.094 ms |         1 | 
     0.094 ms |     165824.256460 s |     165824.256554 s |
   (s)RCU:9                       | 0001 |      0.088 ms |         4 | 
     0.040 ms |     165822.964728 s |     165822.964768 s |
   (w)vmstat_shepherd             | 0000 |      0.078 ms |         1 | 
     0.078 ms |     165824.256321 s |     165824.256399 s |
   (s)SCHED:7                     | 0007 |      0.066 ms |         2 | 
     0.038 ms |     165823.358528 s |     165823.358566 s |
   (s)SCHED:7                     | 0003 |      0.057 ms |         2 | 
     0.034 ms |     165823.998412 s |     165823.998446 s |
   virtio0-requests:25            | 0000 |      0.056 ms |         1 | 
     0.056 ms |     165824.255959 s |     165824.256016 s |
   (s)TIMER:1                     | 0000 |      0.055 ms |         1 | 
     0.055 ms |     165824.256164 s |     165824.256219 s |
   (s)RCU:9                       | 0005 |      0.045 ms |         3 | 
     0.023 ms |     165822.964728 s |     165822.964751 s |
   (s)RCU:9                       | 0002 |      0.028 ms |         2 | 
     0.017 ms |     165823.174539 s |     165823.174556 s |
   (s)RCU:9                       | 0007 |      0.016 ms |         1 | 
     0.016 ms |     165823.358571 s |     165823.358587 s |
   (s)RCU:9                       | 0000 |      0.013 ms |         1 | 
     0.013 ms |     165824.256264 s |     165824.256278 s |
   (s)RCU:9                       | 0003 |      0.011 ms |         1 | 
     0.011 ms |     165822.973142 s |     165822.973153 s |
 
--------------------------------------------------------------------------------------------------------------------------------

# perf kwork lat -b
Starting trace, Hit <Ctrl+C> to stop and report
^C
   Kwork Name                     | Cpu  | Avg delay     | Count     | 
Max delay     | Max delay start     | Max delay end       |
 
--------------------------------------------------------------------------------------------------------------------------------
   (w)neigh_periodic_work         | 0001 |      0.568 ms |         1 | 
     0.568 ms |     165839.038372 s |     165839.038941 s |
   (s)RCU:9                       | 0000 |      0.292 ms |         1 | 
     0.292 ms |     165840.176224 s |     165840.176515 s |
   (s)TIMER:1                     | 0000 |      0.260 ms |         1 | 
     0.260 ms |     165840.176206 s |     165840.176466 s |
   (w)disk_events_workfn          | 0001 |      0.256 ms |         1 | 
     0.256 ms |     165839.038327 s |     165839.038583 s |
   (s)RCU:9                       | 0001 |      0.204 ms |         1 | 
     0.204 ms |     165839.038213 s |     165839.038417 s |
   (s)SCHED:7                     | 0001 |      0.153 ms |         1 | 
     0.153 ms |     165839.038231 s |     165839.038384 s |
   (s)NET_RX:3                    | 0002 |      0.132 ms |         3 | 
     0.184 ms |     165840.175984 s |     165840.176168 s |
   (w)ata_sff_pio_task            | 0001 |      0.124 ms |         1 | 
     0.124 ms |     165839.038852 s |     165839.038976 s |
   (s)SCHED:7                     | 0000 |      0.122 ms |         2 | 
     0.193 ms |     165840.176244 s |     165840.176437 s |
   (s)RCU:9                       | 0007 |      0.106 ms |         1 | 
     0.106 ms |     165838.982220 s |     165838.982326 s |
   (s)RCU:9                       | 0003 |      0.092 ms |         1 | 
     0.092 ms |     165839.040098 s |     165839.040189 s |
   (s)TIMER:1                     | 0001 |      0.085 ms |         1 | 
     0.085 ms |     165839.038179 s |     165839.038264 s |
   (s)SCHED:7                     | 0007 |      0.078 ms |         3 | 
     0.086 ms |     165839.990180 s |     165839.990265 s |
   (s)TIMER:1                     | 0007 |      0.077 ms |         3 | 
     0.081 ms |     165839.990136 s |     165839.990216 s |
   (s)TIMER:1                     | 0003 |      0.076 ms |         1 | 
     0.076 ms |     165839.040066 s |     165839.040142 s |
   (s)RCU:9                       | 0002 |      0.075 ms |         2 | 
     0.088 ms |     165839.118209 s |     165839.118297 s |
   (w)flush_to_ldisc              | 0006 |      0.070 ms |         1 | 
     0.070 ms |     165840.175332 s |     165840.175402 s |
   (s)TIMER:1                     | 0006 |      0.067 ms |         2 | 
     0.085 ms |     165838.908056 s |     165838.908142 s |
   (s)TIMER:1                     | 0002 |      0.067 ms |         2 | 
     0.074 ms |     165840.175076 s |     165840.175149 s |
   (s)SCHED:7                     | 0006 |      0.065 ms |         1 | 
     0.065 ms |     165838.908107 s |     165838.908171 s |
   (s)SCHED:7                     | 0003 |      0.051 ms |         1 | 
     0.051 ms |     165839.040115 s |     165839.040166 s |
   (s)SCHED:7                     | 0002 |      0.046 ms |         2 | 
     0.048 ms |     165840.175123 s |     165840.175171 s |
   (s)RCU:9                       | 0006 |      0.035 ms |         2 | 
     0.036 ms |     165838.913051 s |     165838.913087 s |
   (s)BLOCK:4                     | 0001 |      0.023 ms |         1 | 
     0.023 ms |     165839.039281 s |     165839.039303 s |
 
--------------------------------------------------------------------------------------------------------------------------------

Thanks,
Yang

