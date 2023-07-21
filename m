Return-Path: <bpf+bounces-5607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFE75C6B9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E4282229
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170791E514;
	Fri, 21 Jul 2023 12:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB353D75
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 12:16:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9B1722;
	Fri, 21 Jul 2023 05:16:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6pSG1VZ1z4f3kFc;
	Fri, 21 Jul 2023 20:16:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCHGDMOd7pkEEXZNg--.21603S2;
	Fri, 21 Jul 2023 20:16:16 +0800 (CST)
Subject: Re: [PATCHv2 bpf 2/2] bpf: Disable preemption in bpf_event_output
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230720085704.190592-1-jolsa@kernel.org>
 <20230720085704.190592-3-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0b963b18-4933-3b70-3dc6-6c7150bcf7bb@huaweicloud.com>
Date: Fri, 21 Jul 2023 20:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720085704.190592-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCHGDMOd7pkEEXZNg--.21603S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1rWFyxKF47JrWkJw13Jwb_yoW8Zry7pr
	93GayxGr48Jw1jqa1Dtry0g3W0yanrZF9xGr4kWFW5Zw43WrZ5CFyIyrsYgF98urWUZaya
	qayktw42y3Z5Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/2023 4:57 PM, Jiri Olsa wrote:
> We received report [1] of kernel crash, which is caused by
> using nesting protection without disabled preemption.
>
> The bpf_event_output can be called by programs executed by
> bpf_prog_run_array_cg function that disabled migration but
> keeps preemption enabled.
>
> This can cause task to be preempted by another one inside the
> nesting protection and lead eventually to two tasks using same
> perf_sample_data buffer and cause crashes like:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000001
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0010) - not-present page
>   ...
>   ? perf_output_sample+0x12a/0x9a0
>   ? finish_task_switch.isra.0+0x81/0x280
>   ? perf_event_output+0x66/0xa0
>   ? bpf_event_output+0x13a/0x190
>   ? bpf_event_output_data+0x22/0x40
>   ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
>   ? xa_load+0x87/0xe0
>   ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
>   ? release_sock+0x3e/0x90
>   ? sk_setsockopt+0x1a1/0x12f0
>   ? udp_pre_connect+0x36/0x50
>   ? inet_dgram_connect+0x93/0xa0
>   ? __sys_connect+0xb4/0xe0
>   ? udp_setsockopt+0x27/0x40
>   ? __pfx_udp_push_pending_frames+0x10/0x10
>   ? __sys_setsockopt+0xdf/0x1a0
>   ? __x64_sys_connect+0xf/0x20
>   ? do_syscall_64+0x3a/0x90
>   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Fixing this by disabling preemption in bpf_event_output.
>
> [1] https://github.com/cilium/cilium/issues/26756
> Cc: stable@vger.kernel.org
> Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
> Fixes: 2a916f2f546c bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Hou Tao <houtao1@huawei.com>

With one nit above. The format of the Fixes tags should be 2a916f2f546c
("bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.")


