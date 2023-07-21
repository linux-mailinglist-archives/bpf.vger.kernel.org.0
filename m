Return-Path: <bpf+bounces-5605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B267375C5FC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41331C21696
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A011DDD5;
	Fri, 21 Jul 2023 11:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319871D2FF
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 11:40:21 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3A1FD7;
	Fri, 21 Jul 2023 04:40:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6nfj5TMxz4f3v5D;
	Fri, 21 Jul 2023 19:40:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXPyqabrpkgGXXNg--.17912S2;
	Fri, 21 Jul 2023 19:40:14 +0800 (CST)
Subject: Re: [PATCHv2 bpf 1/2] bpf: Disable preemption in
 bpf_perf_event_output
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230720085704.190592-1-jolsa@kernel.org>
 <20230720085704.190592-2-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5aa65b1b-6395-c555-be51-5d5dad92af6a@huaweicloud.com>
Date: Fri, 21 Jul 2023 19:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720085704.190592-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXPyqabrpkgGXXNg--.17912S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4kXr1kJr1DCr1DKrWUCFg_yoW8Xw1kpr
	Z7GrWSyr4DJw10v3y7Jw1xAa4kAa1UX3ykWr4xG3yYvw47ur4kKay7Ka1ruFyUurn0qa4f
	JayDJ3y2v3y8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/2023 4:57 PM, Jiri Olsa wrote:
> The nesting protection in bpf_perf_event_output relies on disabled
> preemption, which is guaranteed for kprobes and tracepoints.
>
> However bpf_perf_event_output can be also called from uprobes context
> through bpf_prog_run_array_sleepable function which disables migration,
> but keeps preemption enabled.
>
> This can cause task to be preempted by another one inside the nesting
> protection and lead eventually to two tasks using same perf_sample_data
> buffer and cause crashes like:
>
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffffff82be3eea
>   ...
>   Call Trace:
>    ? __die+0x1f/0x70
>    ? page_fault_oops+0x176/0x4d0
>    ? exc_page_fault+0x132/0x230
>    ? asm_exc_page_fault+0x22/0x30
>    ? perf_output_sample+0x12b/0x910
>    ? perf_event_output+0xd0/0x1d0
>    ? bpf_perf_event_output+0x162/0x1d0
>    ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
>    ? __uprobe_perf_func+0x12b/0x540
>    ? uprobe_dispatcher+0x2c4/0x430
>    ? uprobe_notify_resume+0x2da/0xce0
>    ? atomic_notifier_call_chain+0x7b/0x110
>    ? exit_to_user_mode_prepare+0x13e/0x290
>    ? irqentry_exit_to_user_mode+0x5/0x30
>    ? asm_exc_int3+0x35/0x40
>
> Fixing this by disabling preemption in bpf_perf_event_output.
>
> Cc: stable@vger.kernel.org
> Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Hou Tao <houtao1@huawei.com>


