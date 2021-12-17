Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD44783C9
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 04:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhLQDvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 22:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLQDvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 22:51:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925AC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 19:51:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id a23so918276pgm.4
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 19:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svkFhWBzGpKhRie1tF98f7v8mhmkAQISh7J5RBLglAA=;
        b=E2RxD5bWKGJW3z8kmlDP3HXmRGO+YAWlZPP7Kl/vmKh/vb56QSqLA1Wu+onNusI+0C
         +N1gAMQi2r8fK1olHvCt1T9Cp35wkJtWPDweNOzWsSR+1sE2kpR1kDoHe1tMvQenJ4kP
         iYgW/vn6ASfXyE3TId92QKMF4kbKTTBUqCDp0B+iUt5gXq8Ko1dPUQOp3G/HShm/Jneq
         gSfpZPcSkDvO50f9Pt89C/1Wj2kTN8LWKP0hUo07c+2HeT9DLeUuXe7V54UNSvsjRVTh
         QivzgpWSTKwhfeiOLzCX9+7DVp0sZQhMlX7GLTXr9FqLJ6dINMw7So/r/1dOYIp3heZI
         nV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svkFhWBzGpKhRie1tF98f7v8mhmkAQISh7J5RBLglAA=;
        b=KEtxVNwrxeHGaYHflKP7WIAqrHC6rO0AUkZp9a+3Nf6JoiwA5L3U0FatS7k6wIyBM2
         ++sUnb3jbjkF8ey5cm34GaYcKgRYUUrDVUGT3wJCiuQ0WS3M5L6IInVNMkUCcYGAtNki
         BVkPbqimIkWiEEpcgZq7XeHOdeeBAh3EVoBysWxL+wR7kAVzc+VdtM73VqCmxQGkw6CH
         CLuNqDRdTo88vafDPc970IbMyUybRcgJ5/MBVrC3tebDqCQ/RjT+Hg7NJ5KKeqhuUoQR
         BTnpkBQjkwx9zv0MWC1ZsEXXnpffDjVUad4qBgQwb/vrFCEnuSaNe0KBO1+tAcjjX7mx
         vtQQ==
X-Gm-Message-State: AOAM5304Q1BGmJDj9kb6D8enAjiUKb/Gi4kbnTBAwAD+wPNsTLvDUPIF
        m2Vjn5MdDfP9+i0EsQg203Kk+Iunx//rEYdpz3o=
X-Google-Smtp-Source: ABdhPJxffRpdp6tCToRX6l3z/YjxlqCYk8o36DK4q6T5+qj12mpcWC8GhQDLlIh8p2PO1Lwd2KbANFq6V1/2HAFMI3k=
X-Received: by 2002:aa7:9a4e:0:b0:4a2:71f9:21e0 with SMTP id
 x14-20020aa79a4e000000b004a271f921e0mr1136400pfj.77.1639713107797; Thu, 16
 Dec 2021 19:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20211216213358.3374427-1-christylee@fb.com> <20211216213358.3374427-2-christylee@fb.com>
In-Reply-To: <20211216213358.3374427-2-christylee@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Dec 2021 19:51:36 -0800
Message-ID: <CAADnVQ++Lx5mPrkOj9xktPSRESFBdc5KHq3S5HJQ_GZRug4gnw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] Only print scratched registers and stack
 slots to verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, christyc.y.lee@gmail.com,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 1:34 PM Christy Lee <christylee@fb.com> wrote:
> @@ -11256,16 +11306,18 @@ static int do_check(struct bpf_verifier_env *env)
>                 if (need_resched())
>                         cond_resched();
>
> -               if (env->log.level & BPF_LOG_LEVEL2 ||
> +               if ((env->log.level & BPF_LOG_LEVEL2) ||

Why add redundant () ?

>                     (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
> -                       if (env->log.level & BPF_LOG_LEVEL2)
> +                       if (verifier_state_scratched(env) &&
> +                           (env->log.level & BPF_LOG_LEVEL2))

redundant ()

>                                 verbose(env, "%d:", env->insn_idx);
>                         else
>                                 verbose(env, "\nfrom %d to %d%s:",
>                                         env->prev_insn_idx, env->insn_idx,
>                                         env->cur_state->speculative ?
>                                         " (speculative execution)" : "");

Also the addition of "verifier_state_scratched(env) &&"
changes the logic.
Instead of printing "%d:" it prints "from %d to %d" from time to time
which looks really weird.
The "from %d to %d" used to be printed only when
log_level == 1 && do_print_state==true.
It's doing this to indicate that the state was popped from the stack.
It's a branch processing.
When "from %d to %d" appears in the middle of the basic block it's
confusing.
When vlog_reset logic went in the "from %d to %d" became
irrelevant, since they would never be seen anymore,
but for folks who've seen the logs earlier it's odd.

I think it meant to be:
                if (env->log.level & BPF_LOG_LEVEL2 ||
                    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
                        if (env->log.level & BPF_LOG_LEVEL2) {
                                if (verifier_state_scratched(env))
                                        verbose(env, "%d:", env->insn_idx);
                        } else {
                                verbose(env, "\nfrom %d to %d%s:",
                                        env->prev_insn_idx, env->insn_idx,
                                        env->cur_state->speculative ?
                                        " (speculative execution)" : "");
                        }
                        print_verifier_state(env, state->frame[state->curframe],
                                             false);
                        do_print_state = false;
                }

It's all minor. I fixed it all up while applying.
