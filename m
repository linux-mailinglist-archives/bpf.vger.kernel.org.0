Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503B83A13BC
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhFIMH1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 08:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhFIMH1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 08:07:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159C33pO177966;
        Wed, 9 Jun 2021 08:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nznE1WEahBUP5+rjLk/LKNCc7KWzvk749iV9gXyDyN0=;
 b=b8HrzhcUvCROnsKZi8YwlIEvRaIAx+/cYPUbIuZbbPkbasHIGDTu8+HkGOtBlSw5R3Ot
 gYYkVAayW8jAg5iitzv/XT1QKnQTdaWlgBYbJdhAJWOhhTquFPOHj2mto7SaoyqIuB5G
 e6dY1rJWjrNWlGRYFBBqKG7hVyuF96Xg30vHOrzBd2NILiGY9imVG3phG/0dSdjAiyuo
 JXj4dnD40p9zGxxCPx93DowXfKDkhpYurCDB+HuqMM2638/TiAp3JHHUlLzlQY5buPTk
 vdqgmgUsz9XaF3deUZtdl7EcXP2OyT02Z7BE8E8LcCJP49l6zV6GoW7LXQnEG82+lq+w Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 392vk81cgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 08:05:08 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159C35jE178093;
        Wed, 9 Jun 2021 08:05:08 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 392vk81cfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 08:05:08 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159C3mhl021787;
        Wed, 9 Jun 2021 12:05:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3900w896du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 12:05:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159C4GYT36110726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 12:04:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E14FC4C050;
        Wed,  9 Jun 2021 12:05:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48FA84C044;
        Wed,  9 Jun 2021 12:04:59 +0000 (GMT)
Received: from [9.199.46.41] (unknown [9.199.46.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 12:04:58 +0000 (GMT)
Subject: Re: [PATCH bpf-next 0/1] arm64: Add BPF exception tables
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, zlim.lnx@gmail.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com>
Date:   Wed, 9 Jun 2021 17:34:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20200728152122.1292756-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C7QvzXTwf1jA_hb8C5ZQziVfWwiwxYMH
X-Proofpoint-ORIG-GUID: ODsJlbQ-XEPJFHI732oNsX5bBIo_ho9F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106090059
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On 7/28/20 8:51 PM, Jean-Philippe Brucker wrote:
> The following patch adds support for BPF_PROBE_MEM on arm64. The
> implementation is simple but I wanted to give a bit of background first.
> If you're familiar with recent BPF development you can skip to the patch
> (or fact-check the following blurb).
> 
> BPF programs used for tracing can inspect any of the traced function's
> arguments and follow pointers in struct members. Traditionally the BPF
> program would get a struct pt_regs as argument and cast the register
> values to the appropriate struct pointer. The BPF verifier would mandate
> that any memory access uses the bpf_probe_read() helper, to suppress
> page faults (see samples/bpf/tracex1_kern.c).
> 
> With BPF Type Format embedded into the kernel (CONFIG_DEBUG_INFO_BTF),
> the verifier can now check the type of any access performed by a BPF
> program. It rejects for example programs that cast to a different
> structure and perform out-of-bounds accesses, or programs that attempt
> to dereference something that isn't a pointer, or that hasn't gone
> through a NULL check.
> 
> As this makes tracing programs safer, the verifier now allows loading
> programs that access struct members without bpf_probe_read(). It is
> however still possible to trigger page faults. For example in the
> following example with which I've tested this patch, the verifier does
> not mandate a NULL check for the second-level pointer:
> 
> /*
>   * From tools/testing/selftests/bpf/progs/bpf_iter_task.c
>   * dump_task() is called for each task.
>   */
> SEC("iter/task")
> int dump_task(struct bpf_iter__task *ctx)
> {
> 	struct seq_file *seq = ctx->meta->seq;
> 	struct task_struct *task = ctx->task;
> 
> 	/* Program would be rejected without this check */
> 	if (task == NULL)
> 		return 0;
> 
> 	/*
> 	 * However the verifier does not currently mandate
> 	 * checking task->mm, and the following faults for kernel
> 	 * threads.
> 	 */
> 	BPF_SEQ_PRINTF(seq, "pid=%d vm=%d", task->pid, task->mm->total_vm);
> 	return 0;
> }
> 
> Even if it checked this case, the verifier couldn't guarantee that all
> accesses are safe since kernel structures could in theory contain
> garbage or error pointers. So to allow fast access without
> bpf_probe_read(), a JIT implementation must support BPF exception
> tables. For each access to a BTF pointer, the JIT generates an entry
> into an exception table appended to the BPF program. If the access
> faults at runtime, the handler skips the faulting instruction. The
> example above will display vm=0 for kernel threads.

I'm trying with the example above (task->mm->total_vm) on x86 machine
with bpf/master (11fc79fc9f2e3) plus commit 4c5de127598e1 ("bpf: Emit
explicit NULL pointer checks for PROBE_LDX instructions.") *reverted*,
I'm seeing the app getting killed with error in dmesg.

   $ sudo bpftool iter pin bpf_iter_task.o /sys/fs/bpf/task
   $ sudo cat /sys/fs/bpf/task
   Killed

   $ dmesg
   [  188.810020] BUG: kernel NULL pointer dereference, address: 00000000000000c8
   [  188.810030] #PF: supervisor read access in kernel mode
   [  188.810034] #PF: error_code(0x0000) - not-present page

IIUC, this should be handled by bpf exception table rather than killing
the app. Am I missing anything?

Ravi
