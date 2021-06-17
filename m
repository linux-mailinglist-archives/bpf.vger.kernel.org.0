Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F63AACD9
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhFQHBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 03:01:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhFQHBO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 03:01:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H6X100052374;
        Thu, 17 Jun 2021 02:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MOSoqprioi3J3jNEOxKjrY+bjTUAw6ikDWLjHlpTfQs=;
 b=lrlALBvDH90+yQCIe/UE6PGSZPGOiZyLkh0C8LCylOwZI8MBKW3PjQSrTPPE23PoRD3y
 dBavN/kyxWZ2u0jJACmR3btGcEeybWFteWl0G5F54OlSL6pqjvTMBuG0TchWeIry1aN9
 8M3RPvYvpZ3Nwq+rJRluRyTqIxD2dyOIc2VLeTRnJhUWpUuwiBrSgx7XQ96UdHZqBNQZ
 ChdDGEWgthdc333uFwz2m57MdX+JSXxRtizL8JwFdl/suQeKf7tEDsXDFrfShMvf8s87
 W5HePsWrwVEm27o7Ti6b7DBu0ilRF41ReJ99Ky9ARAgtbgsk1uuiej+fUR/QdDT223Xb +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397yshay5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 02:58:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15H6XehQ054156;
        Thu, 17 Jun 2021 02:58:45 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397yshay4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 02:58:44 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15H6qsi3023133;
        Thu, 17 Jun 2021 06:58:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8tgsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 06:58:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15H6vVWs38011214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 06:57:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296C8AE053;
        Thu, 17 Jun 2021 06:58:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1B8DAE055;
        Thu, 17 Jun 2021 06:58:34 +0000 (GMT)
Received: from [9.199.38.219] (unknown [9.199.38.219])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 06:58:34 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/1] arm64: Add BPF exception tables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com>
 <CAADnVQJsCkSdqCaQt2hretdqamWJmWRQvh+=RvwHmHAOW2kL6g@mail.gmail.com>
Message-ID: <fedff32f-e511-a191-22b0-bf421bdcce2a@linux.ibm.com>
Date:   Thu, 17 Jun 2021 12:28:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJsCkSdqCaQt2hretdqamWJmWRQvh+=RvwHmHAOW2kL6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vgoqyBQVSOuUmOiILep6vhm-7KE95vnP
X-Proofpoint-ORIG-GUID: 1FfKNZDdzK1yBybhSOaMqKtWYyJ-p89b
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170045
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

Sorry to bother you again!

On 6/11/21 5:42 AM, Alexei Starovoitov wrote:
> On Wed, Jun 9, 2021 at 5:05 AM Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>>
>> Hi Alexei,
>>
>> On 7/28/20 8:51 PM, Jean-Philippe Brucker wrote:
>>> The following patch adds support for BPF_PROBE_MEM on arm64. The
>>> implementation is simple but I wanted to give a bit of background first.
>>> If you're familiar with recent BPF development you can skip to the patch
>>> (or fact-check the following blurb).
>>>
>>> BPF programs used for tracing can inspect any of the traced function's
>>> arguments and follow pointers in struct members. Traditionally the BPF
>>> program would get a struct pt_regs as argument and cast the register
>>> values to the appropriate struct pointer. The BPF verifier would mandate
>>> that any memory access uses the bpf_probe_read() helper, to suppress
>>> page faults (see samples/bpf/tracex1_kern.c).
>>>
>>> With BPF Type Format embedded into the kernel (CONFIG_DEBUG_INFO_BTF),
>>> the verifier can now check the type of any access performed by a BPF
>>> program. It rejects for example programs that cast to a different
>>> structure and perform out-of-bounds accesses, or programs that attempt
>>> to dereference something that isn't a pointer, or that hasn't gone
>>> through a NULL check.
>>>
>>> As this makes tracing programs safer, the verifier now allows loading
>>> programs that access struct members without bpf_probe_read(). It is
>>> however still possible to trigger page faults. For example in the
>>> following example with which I've tested this patch, the verifier does
>>> not mandate a NULL check for the second-level pointer:
>>>
>>> /*
>>>    * From tools/testing/selftests/bpf/progs/bpf_iter_task.c
>>>    * dump_task() is called for each task.
>>>    */
>>> SEC("iter/task")
>>> int dump_task(struct bpf_iter__task *ctx)
>>> {
>>>        struct seq_file *seq = ctx->meta->seq;
>>>        struct task_struct *task = ctx->task;
>>>
>>>        /* Program would be rejected without this check */
>>>        if (task == NULL)
>>>                return 0;
>>>
>>>        /*
>>>         * However the verifier does not currently mandate
>>>         * checking task->mm, and the following faults for kernel
>>>         * threads.
>>>         */
>>>        BPF_SEQ_PRINTF(seq, "pid=%d vm=%d", task->pid, task->mm->total_vm);
>>>        return 0;
>>> }
>>>
>>> Even if it checked this case, the verifier couldn't guarantee that all
>>> accesses are safe since kernel structures could in theory contain
>>> garbage or error pointers. So to allow fast access without
>>> bpf_probe_read(), a JIT implementation must support BPF exception
>>> tables. For each access to a BTF pointer, the JIT generates an entry
>>> into an exception table appended to the BPF program. If the access
>>> faults at runtime, the handler skips the faulting instruction. The
>>> example above will display vm=0 for kernel threads.
>>
>> I'm trying with the example above (task->mm->total_vm) on x86 machine
>> with bpf/master (11fc79fc9f2e3) plus commit 4c5de127598e1 ("bpf: Emit
>> explicit NULL pointer checks for PROBE_LDX instructions.") *reverted*,
>> I'm seeing the app getting killed with error in dmesg.
>>
>>     $ sudo bpftool iter pin bpf_iter_task.o /sys/fs/bpf/task
>>     $ sudo cat /sys/fs/bpf/task
>>     Killed
>>
>>     $ dmesg
>>     [  188.810020] BUG: kernel NULL pointer dereference, address: 00000000000000c8
>>     [  188.810030] #PF: supervisor read access in kernel mode
>>     [  188.810034] #PF: error_code(0x0000) - not-present page
>>
>> IIUC, this should be handled by bpf exception table rather than killing
>> the app. Am I missing anything?
> 
> For PROBE_LDX the verifier guarantees that the address is either
> a very likely valid kernel address or NULL. On x86 the user and kernel
> address spaces are shared and NULL is a user address, so there cannot be
> an exception table for NULL. Hence x86-64 JIT inserts NULL check when
> it converts PROBE_LDX into load insn.

IIUC, there could be 3 types of addresses a BPF prog can have:

1. NULL ptr. Which is handled by adding additional check in BPF program.
    So this won't cause a fault.
2. Valid kernel address. This will never cause a fault.
3. Bad address. This is very unlikely but possible. IIUC, BPF extable
    is introduced to handle such scenarios. Unfortunately, with any type
    of bad address (user or kernel), extable on x86 never gets involved.
    Kernel always kills the application with error in dmesg.

Please let me know if I understood it incorrectly.

TLDR;
To check the case 3 further, I tried with bpf/master, this time without
reverting your patch. I added a dummy structure and a bad pointer to it
in task_struct.

   diff --git a/include/linux/sched.h b/include/linux/sched.h
   index d2c881384517..4698188bcf45 100644
   --- a/include/linux/sched.h
   +++ b/include/linux/sched.h
   @@ -646,6 +646,10 @@ struct kmap_ctrl {
    #endif
    };
   +struct dummy_task_ele {
   +       int dummy;
   +};
   +
    struct task_struct {
    #ifdef CONFIG_THREAD_INFO_IN_TASK
           /*
   @@ -771,6 +775,8 @@ struct task_struct {
           struct mm_struct                *mm;
           struct mm_struct                *active_mm;
   +       struct dummy_task_ele           *dte;
   +
           /* Per-thread vma caching: */
           struct vmacache                 vmacache;
   diff --git a/kernel/fork.c b/kernel/fork.c
   index dc06afd725cb..ed01f25edd8e 100644
   --- a/kernel/fork.c
   +++ b/kernel/fork.c
   @@ -2116,6 +2116,9 @@ static __latent_entropy struct task_struct *copy_process(
           retval = copy_mm(clone_flags, p);
           if (retval)
                   goto bad_fork_cleanup_signal;
   +
   +       p->dte = (void *)0xd12345;
   +
           retval = copy_namespaces(clone_flags, p);
           if (retval)
                   goto bad_fork_cleanup_mm;

And with below change in testcase:

   diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
   index b7f32c160f4e..391c1b3da638 100644
   --- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
   +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
   @@ -21,6 +21,6 @@ int dump_task(struct bpf_iter__task *ctx)
           if (ctx->meta->seq_num == 0)
                   BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
   -       BPF_SEQ_PRINTF(seq, "%8d %8d\n", task->tgid, task->pid);
   +       BPF_SEQ_PRINTF(seq, "%8d %8d %d\n", task->tgid, task->pid, task->dte->dummy);
           return 0;
    }

I see the same issue:

   $ sudo bpftool iter pin bpf_iter_task.o /sys/fs/bpf/task
   $ sudo cat /sys/fs/bpf/task
   Killed

   $ dmesg
   [  166.864325] BUG: unable to handle page fault for address: 0000000000d12345
   [  166.864336] #PF: supervisor read access in kernel mode
   [  166.864338] #PF: error_code(0x0000) - not-present page

0xd12345 is unallocated userspace address. Similarly, I also tried with
p->dte = (void *)0xffffffffc1234567 after confirming it's not allocated
to kernel or any module address. I see the same failure with it too.

Though, the same test with bpf_probe_read(task->dte->dummy) works fine.

Ravi
