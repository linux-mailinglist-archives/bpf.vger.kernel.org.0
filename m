Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F665BB91
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 09:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjACIDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 03:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjACIDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 03:03:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8514C0D
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 00:03:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jo4so71787974ejb.7
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BCssOR015L7W9qKOrUZJPin1yKRB1qvw0qh3HgRxNg=;
        b=O+UkQVhVG429osEeU4dnFiliAaJIeJqRS/WNMginhrmpjY4xz2Vyq5U5u8NRY8PRRf
         UqV4XqfgMkzx4hB9avLK9X08VpCQ/SnKqw2vw2dNNFtR5XdwcVePEntOsWR704BEA49b
         n7bJPxq3ifTWoPUpAysrdkJyMJlsG6ZuK4Ix+b/GKDQogeZdkySK8OqFy8Z2cAiJTPNr
         5/Qi3Jd2U2rAWweOBSX3WtUFA0/j+wt8bCns05kebjHNagIhG0QNylg68gCUDNSUtZIS
         HX1dZhR+dVCdOL2rMxF+ikVwOS3CfZjIDiUiB+7crSouG2wNmQn50wbwXo4EZivwYjae
         4EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BCssOR015L7W9qKOrUZJPin1yKRB1qvw0qh3HgRxNg=;
        b=jRHJMRropWmTgN27dLPF0HPq32rnJu8i1DOebobWZ3JgOWQ1zCBcWdE3ylcZj8qfeC
         f9ePHCsc0G9hWDeHepR3WubFi47xoHHNDA+fXfE2G5T9uOFCeZ6qXvAjUfPaCfrbRg0e
         bKxQArZ/E5Qi8ePTzFByxTJ3ZQA90oiIrVT3koxwXcnChVJO5xhwntLEsGERTIVAoK5F
         B4IQGUx1CZhJULiZyCweIw6TlYFGS2DjnTBsMWQFyp1wxylBg5dOGlSbP8fjuegRlBRq
         TEheo0gNJpfRlC6MOWR8NXZjnRbwVlyKiFYBYWZCjBCwMVpGRbzTWSSmR4BuTNaZP097
         V/SQ==
X-Gm-Message-State: AFqh2koeJc12Wmp399sTYM/B4UlWSd3qqCOBegO78MDG1mtGa3kDs4sp
        HHjk/MZvd9/2LknlhP1qjqVpL6P6sQ8=
X-Google-Smtp-Source: AMrXdXsIcc8KTA469GOHjVtqejQAiUOLdxOg9MwIB+cdLLyjof4Dp01alVABuIDMG+7F+bD3fnPZdw==
X-Received: by 2002:a17:906:279a:b0:7c1:10b4:4742 with SMTP id j26-20020a170906279a00b007c110b44742mr36137287ejc.55.1672733020373;
        Tue, 03 Jan 2023 00:03:40 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0084c70c27407sm8313389ejh.84.2023.01.03.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:03:39 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 3 Jan 2023 09:03:38 +0100
To:     Victor Laforet <victor.laforet@ip-paris.fr>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yhs@meta.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: bpf_probe_read_user EFAULT
Message-ID: <Y7PhWlqdG/TjwT75@krava>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
 <Y6sWqgncfvtRHp+b@krava>
 <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
 <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com>
 <5692f180-5b78-48e0-b974-b60bd58c0839@Spark>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5692f180-5b78-48e0-b974-b60bd58c0839@Spark>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 02, 2023 at 11:07:50PM +0100, Victor Laforet wrote:
> Thanks!
> 
> I have tried to use bpf_copy_from_user_task() in place of bpf_probe_read_user() however I cannot seem to run my program. It fails with 'unknown func bpf_copy_from_user_task’.
> If I understood correctly, this function should be in ‘bpf/bpf_helpers.h’?

the declaration is in bpf_helper_defs.h, which is included by
bpf_helpers.h, so you need to #include it

> 
> Another quick question:
> I have set the bpf program as sleepable using ‘	bpf_program__set_flags(skel, BPF_F_SLEEPABLE);'
> I couldn’t find any other way to do that. Is it the right way to set it sleepable?

should work, but you could specify that directly in the program
section name, like SEC("fentry.s/...")

and it's just certain program types that can sleep:

	[jolsa@krava bpf]$ grep SEC_SLEEPABLE libbpf.c
	...
        SEC_DEF("uprobe.s+",            KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
        SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
        SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
        SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
        SEC_DEF("iter.s+",              TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
        SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),

jirka


> 
> Victor
> On 28 Dec 2022 at 20:41 +0100, Yonghong Song <yhs@meta.com>, wrote:
> >
> >
> > On 12/28/22 6:00 AM, Victor Laforet wrote:
> > > Yes I am sorry I did not mention that the example I sent was a minimal working example. I am filtering the events to select only preempted and events with the right pid as prev.
> > >
> > > Would bpf_copy_from_user_task work better in this setting than bpf_probe_read_user ?
> > > I don’t really understand why bpf_probe_read_user would not work for this use case.
> >
> > Right, bpf_copy_from_user_task() is better than bpf_probe_read_user().
> > You could also use bpf_copy_from_user() if you have target_pid checking.
> >
> > It is possible that the user variable you intended to access is not in
> > memory. In such cases, bpf_probe_read_user() will return EFAULT. But
> > bpf_copy_from_user() and bpf_copy_from_user_task() will go through
> > page fault process to bring the variable to the memory.
> > Also because of this extra work, bpf_copy_from_user() and
> > bpf_copy_from_user_task() only work for sleepable programs.
> >
> > >
> > > Victor
> > >
> > > ----- Mail original -----
> > > De: "Jiri Olsa" <olsajiri@gmail.com>
> > > À: "Victor Laforet" <victor.laforet@ip-paris.fr>
> > > Cc: "bpf" <bpf@vger.kernel.org>
> > > Envoyé: Mardi 27 Décembre 2022 17:00:42
> > > Objet: Re: bpf_probe_read_user EFAULT
> > >
> > > On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
> > > > Hi all,
> > > >
> > > > I am trying to use bpf_probe_read_user to read a user space value from BPF. The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read_user. I haven’t been able to make this function work reliably. Sometimes I get no error code then it goes back to EFAULT.
> > > >
> > > > I am seeking your help to try and make this code work.
> > > > Thank you!
> > > >
> > > > My goal is to read the variable pid on every bpf event.
> > > > Here is a full example:
> > > > (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
> > > >
> > > > sched_switch.bpf.c
> > > > ```
> > > > #include "vmlinux.h"
> > > > #include <bpf/bpf_helpers.h>
> > > >
> > > > int *input_pid;
> > > >
> > > > char _license[4] SEC("license") = "GPL";
> > > >
> > > > SEC("tp_btf/sched_switch")
> > > > int handle_sched_switch(u64 *ctx)
> > >
> > > you might want to filter for your task, because sched_switch
> > > tracepoint is called for any task scheduler switch
> > >
> > > check BPF_PROG macro in bpf selftests on how to access tp_btf
> > > arguments from context, for sched_switch it's:
> > >
> > > TP_PROTO(bool preempt,
> > > struct task_struct *prev,
> > > struct task_struct *next,
> > > unsigned int prev_state),
> > >
> > > and call the read helper only for prev->pid == 'your app pid',
> > >
> > > there's bpf_copy_from_user_task helper you could use to read
> > > another task's user memory reliably, but it needs to be called
> > > from sleepable probe and you need to have the task pointer
> > >
> > > jirka
> > >
> > > > {
> > > > int pid;
> > > > int err;
> > > >
> > > > err = bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
> > > > if (err != 0)
> > > > {
> > > > bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
> > > > return 0;
> > > > }
> > > >
> > > > bpf_printk("pid %d.\n", pid);
> > > > return 0;
> > > > }
> > > > ```
> > > >
> > > > sched_switch.c
> > > > ```
> > > > #include <stdio.h>
> > > > #include <unistd.h>
> > > > #include <sys/resource.h>
> > > > #include <bpf/libbpf.h>
> > > > #include "sched_switch.skel.h"
> > > > #include <time.h>
> > > >
> > > > static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> > > > {
> > > > return vfprintf(stderr, format, args);
> > > > }
> > > >
> > > > int main(int argc, char **argv)
> > > > {
> > > > struct sched_switch_bpf *skel;
> > > > int err;
> > > > int pid = getpid();
> > > >
> > > > libbpf_set_print(libbpf_print_fn);
> > > >
> > > > skel = sched_switch_bpf__open();
> > > > if (!skel)
> > > > {
> > > > fprintf(stderr, "Failed to open BPF skeleton\n");
> > > > return 1;
> > > > }
> > > >
> > > > skel->bss->input_pid = &pid;
> > > >
> > > > err = sched_switch_bpf__load(skel);
> > > > if (err)
> > > > {
> > > > fprintf(stderr, "Failed to load and verify BPF skeleton\n");
> > > > goto cleanup;
> > > > }
> > > >
> > > > err = sched_switch_bpf__attach(skel);
> > > > if (err)
> > > > {
> > > > fprintf(stderr, "Failed to attach BPF skeleton\n");
> > > > goto cleanup;
> > > > }
> > > >
> > > > while (1);
> > > >
> > > > cleanup:
> > > > sched_switch_bpf__destroy(skel);
> > > > return -err;
> > > > }
> > > > ```
