Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40283656CB7
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiL0QAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 11:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiL0QAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 11:00:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA28293
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 08:00:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t17so32832888eju.1
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEqkMqh+UVbfYHZNXKZVpDPM0M5bCn3Dv02suB8xhbw=;
        b=P19QUH6sDeuLc1ynMYfj+1M8ALFpfr3ni/zBSObhZozfmm3C/AZv2C1eFb6+NuLH8R
         fPyzyGxXk97gLIRP6WTYQfQA+HwlvVv5GK2Z2RC36L9NLra3tzCfipn6Ph2L/m1sIsOq
         I3B4j0/TqDfGa01rPgOcV87EPEKKWpQOQPW/JJyYGyDmGETyijv8Yx8MgfFA+hJ6aD5u
         R7jct8Tx9zuSJSkPKrLiwdE9+4KZFZjRB1ZB7nBYB8S9QNahORxMpWFaWWorObEksLg7
         nuEP83VVIrBe6VkoCIaGEZvoOYGYOB8SXGWmC0B7I6rZ46jeCM07dHWP4EfosPx7ueJX
         NsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEqkMqh+UVbfYHZNXKZVpDPM0M5bCn3Dv02suB8xhbw=;
        b=k7jz//VvCMTjxOiv4HlygXUF3X1PWw+EsHNFoPVKyXNt7ExLaziAYMrv3BvoHQCq7z
         HSPO0H8NeppfcGatRvxs3pqS1lIO3G49iUPdYuCb6u717qJGRlmLEAx+2z7g9fSHRN2/
         KLYQFb8bYvfO9gGg7BqR8TeFHjorDeulNNxV7n2h5VsuGUBBrrf4OMx7Uf3zzAtSzys9
         vbcKDWF9hj4IO3wKxkVdLRMzEGyYe4pBLNCzYx5NOFrlXjia3ZxWE3CtTj3AJvJvMxow
         sTZqm2Ler4JzKcP3nE0OY4g0/op7bELjvBG0TQhaP1LHL5BKxLpPLZIf+cA9XXcxDKSc
         cezQ==
X-Gm-Message-State: AFqh2kqxkQkHXLOqyRtMmS9zJUKWYGK57X4fdpnjNjPJWZFT7HVfhx5c
        3sYMDPXFBI0DEBF6xFf0KvwBmaC93UI=
X-Google-Smtp-Source: AMrXdXu+tT1D6yETJK/Hd0nHg7Ort5ujbALKwFK/Qov6R4XiKEzwb2xRF+3uBI8ywhM9Z8AdsgbQrQ==
X-Received: by 2002:a17:906:704a:b0:83f:cbc0:1b30 with SMTP id r10-20020a170906704a00b0083fcbc01b30mr16555217ejj.10.1672156845386;
        Tue, 27 Dec 2022 08:00:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v14-20020a1709067d8e00b007c127e1511dsm6256575ejo.220.2022.12.27.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 08:00:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 27 Dec 2022 17:00:42 +0100
To:     Victor Laforet <victor.laforet@ip-paris.fr>
Cc:     bpf@vger.kernel.org
Subject: Re: bpf_probe_read_user EFAULT
Message-ID: <Y6sWqgncfvtRHp+b@krava>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
> Hi all,
> 
> I am trying to use bpf_probe_read_user to read a user space value from BPF. The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read_user. I haven’t been able to make this function work reliably. Sometimes I get no error code then it goes back to EFAULT.
> 
> I am seeking your help to try and make this code work.
> Thank you!
> 
> My goal is to read the variable pid on every bpf event.
> Here is a full example:
> (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
> 
> sched_switch.bpf.c
> ```
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> 
> int *input_pid;
> 
> char _license[4] SEC("license") = "GPL";
> 
> SEC("tp_btf/sched_switch")
> int handle_sched_switch(u64 *ctx)

you might want to filter for your task, because sched_switch
tracepoint is called for any task scheduler switch

check BPF_PROG macro in bpf selftests on how to access tp_btf
arguments from context, for sched_switch it's:

        TP_PROTO(bool preempt,
                 struct task_struct *prev,
                 struct task_struct *next,
                 unsigned int prev_state),

and call the read helper only for prev->pid == 'your app pid',

there's bpf_copy_from_user_task helper you could use to read
another task's user memory reliably, but it needs to be called
from sleepable probe and you need to have the task pointer

jirka

> {
>   int pid;
>   int err;
> 
>   err = bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
>   if (err != 0)
>   {
>     bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
>     return 0;
>   }
> 
>   bpf_printk("pid %d.\n", pid);
>   return 0;
> }
> ```
> 
> sched_switch.c
> ```
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/resource.h>
> #include <bpf/libbpf.h>
> #include "sched_switch.skel.h"
> #include <time.h>
> 
> static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> {
>   return vfprintf(stderr, format, args);
> }
> 
> int main(int argc, char **argv)
> {
>   struct sched_switch_bpf *skel;
>   int err;
>   int pid = getpid();
> 
>   libbpf_set_print(libbpf_print_fn);
> 
>   skel = sched_switch_bpf__open();
>   if (!skel)
>   {
>     fprintf(stderr, "Failed to open BPF skeleton\n");
>     return 1;
>   }
> 
>   skel->bss->input_pid = &pid;
> 
>   err = sched_switch_bpf__load(skel);
>   if (err)
>   {
>     fprintf(stderr, "Failed to load and verify BPF skeleton\n");
>     goto cleanup;
>   }
> 
>   err = sched_switch_bpf__attach(skel);
>   if (err)
>   {
>     fprintf(stderr, "Failed to attach BPF skeleton\n");
>     goto cleanup;
>   }
> 
>   while (1);
> 
> cleanup:
>   sched_switch_bpf__destroy(skel);
>   return -err;
> }
> ```
