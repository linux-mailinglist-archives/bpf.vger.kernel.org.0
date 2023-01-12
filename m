Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1FB667A7D
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjALQPh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjALQPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:04 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2769DE91
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 08:11:57 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-14fb7fdb977so19330294fac.12
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgVxxQrUTt43NguNyUGqGnxyKULEgqUKl07aL7uYzdo=;
        b=Q8bzF/n7IJmPimw5Zr3v0FjjxragIqrUUu/hqllGJrurc+JFIyt9Y7pT4rSA5dKeRU
         Kx56tZlgncpeA7iAyWIHewhK7YY1avy09GIyhx/8AJkN+SCbLAp8YYYpgwNAn8NkBJzz
         oODykWJ4eR8bd1iRaZ/N8R5anmFfNdhzv08BduezM5PxOEsBbWUY4iDnMgLbFv0JULJk
         2aWEfnKhkOAJYFraUt/V1iCrBeSBLJhJZ+Acbs8eFVyGO0kDHPIFhF9PVGyew56P5C13
         YNXJuNFco81KBrErheJYGsdkuOPTA073owxBy4L9Pc2bThL6+LIhkuR5ch07JotqDt8U
         EPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgVxxQrUTt43NguNyUGqGnxyKULEgqUKl07aL7uYzdo=;
        b=f/fUIUu6ifD8ceBuexIqpbLZCdl3nFO4H+yDwuB75ZieUYZ53vTqnzvQrWSKU1sNV8
         jEBAMIsoAC1vSF43hxSaN3PFGquqzCR3v5KyM3tlR59ghebffD0sJtyQSnEBOeG0/Nil
         w3b9bwsCkIpCmSk2OA7ZAsiNInQM+n4VOy09QsK+EmmaUta0rcOeONjwZkDsfuN2ntyh
         a3IfDfcTrN+cZql4WzZc33N6BL7NnrduTsq8VBMvZKMUJqrcUTFtpft7PknmF2PlA8L6
         hZkq6oy9Jgzv4vqCgJcZtHv0CUt1jgMwfCFnOt5cVh6rVk34gndSUffbXyowQlAgf1El
         Nsvg==
X-Gm-Message-State: AFqh2kre2LQVCBjQ/IcEu+3edKTPFRIb4+qC/NpLVoFddYHeySRXMJQz
        BtgVfBtGrIly4AqeLSRLZ08Z/dhhKVv6nBMYJ1uZVxFJLW0=
X-Google-Smtp-Source: AMrXdXshBcDBZuyhPB0kSSrPWP0JYIgYYZz7C1diZvULlXrzkf4I+YebffKrgGBih5YQv/bV52ao5y2Ic8CtHcusQnE=
X-Received: by 2002:a05:6870:459d:b0:143:58c3:e6c5 with SMTP id
 y29-20020a056870459d00b0014358c3e6c5mr7609383oao.182.1673539916731; Thu, 12
 Jan 2023 08:11:56 -0800 (PST)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Fri, 13 Jan 2023 00:11:18 +0800
Message-ID: <CAHb-xauaGvVZrtRzCNNV370oc8swk2z3WYnLSMb3xy=rpLgOQw@mail.gmail.com>
Subject: Kernel Panic in 4.19 ARM machines
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

My ebpf program based on libbpf(v0.7) causes the kernel 4.19 (ARM
machine) panic:

Kernel panic - not syncing: softlockup: hung tasks
CPU: 3 PID: 2524351 Comm: sshd Kdump: loaded Tainted: G
Call trace:
dump_backtrace
show_stack
dump_stack
panic
lockup_detector_update_enable
__hrtimer_run_queues
hrtimer_interrupt
arch_timer_handler_virt
handle_percpu_devid_irq
generic_handle_irq
__handle_domain_irq
gic_handle_irq
el1_irq
smp_call_function_many
kick_all_cpus_sync
bpf_int_jit_compile
bpf_prog_select_runtime
bpf_prepare_filter
bpf_prog_create_from_user
seccomp_set_mode_filter
do_seccomp
prctl_set_seccomp
__se_sys_prctl
__arm64_sys_prctl
el0_svc_common
el0_svc_handler
el0_svc

Then I test the same ebpf program on kernel 4.19 (x86 machine), the
kernel DOES NOT panic.
I test it on kernel 5.10 (ARM machine), the kernel DOES NOT panic.

Thus I guess this is a kernel bug related to ARM arch and has been
fixed in 5.10.

Does anyone know any kernel bug or patch related to this issue?

Thanks
