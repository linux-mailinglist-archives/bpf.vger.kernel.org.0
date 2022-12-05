Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E046642AF0
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 16:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiLEPDC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiLEPDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 10:03:01 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E32AE4;
        Mon,  5 Dec 2022 07:03:00 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id v8so5114203qkg.12;
        Mon, 05 Dec 2022 07:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODr/Fr77Jn/Q2JZfHqisVaODrGFusJfe6rnqr48+bMU=;
        b=IZNVCAlFyqQSKBWxpgDtOgSG99C6lZ//WAQHmmexsyTzG9WTd/aZbbBholzuy0XoKR
         hB8kDeHLfRNRiZCGutdciRbhuo5YPY6tIOuIkukQ12IgdGXPCKWv1ACvLeSpG8su13vm
         GeF+gw9HMFyaK/AFk87ufCqZsxVFAVZM98oX9DstRzXlQLpy+XZKnYeXph/DxlKrNiab
         SAszlJLfLW5M4iXMf2Bjfkm5qT6QJFVntMtW8jWIedUCssVNXJHYpvKdywcR4NiGUrqf
         6jTtVCJl0Sbg5E9P7llciFaPe12ij9Tktwi0gjg4jDw9D8xWLpOvpmYxCs0/2UDZUzlc
         f51Q==
X-Gm-Message-State: ANoB5pkPbGC/QtossIgByDkx/svLe/Ari/Ezj8DP8RDwT3qcoDJojZsp
        iX3AmxJKCIWFUpIJUFOC/7s=
X-Google-Smtp-Source: AA0mqf6PQexU3hs3pVsaQ8yYWe6cW0yXoUDIXmLJmkMIwE4Op4k8idt1udusjD0OTIPUsF1mZsq6IA==
X-Received: by 2002:a05:620a:6017:b0:6f3:b4d7:1704 with SMTP id dw23-20020a05620a601700b006f3b4d71704mr72641506qkb.664.1670252579024;
        Mon, 05 Dec 2022 07:02:59 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:33a4])
        by smtp.gmail.com with ESMTPSA id k14-20020a05620a414e00b006cebda00630sm9981915qko.60.2022.12.05.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:02:58 -0800 (PST)
Date:   Mon, 5 Dec 2022 09:02:57 -0600
From:   David Vernet <void@manifault.com>
To:     Matus Jokay <matus.jokay@stuba.sk>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kernel-team@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, sdf@google.com, song@kernel.org, tj@kernel.org,
        yhs@fb.com, "Ploszek, Roderik" <roderik.ploszek@stuba.sk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfuncs for storing struct
 task_struct * as a kptr
Message-ID: <Y44IITgHrhJf5fWJ@maniforge.lan>
References: <20221120051004.3605026-4-void@manifault.com>
 <52f31c6f-7adb-78a4-dec5-8da524b4efa6@stuba.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f31c6f-7adb-78a4-dec5-8da524b4efa6@stuba.sk>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 11:11:47AM +0100, Matus Jokay wrote:
> Hello David,

Hi Matus,

> 
> Your idea behind this patch is cool, but I'm afraid that the
> implementation is incorrect.
>
> As you can see, the task_struct:rcu_users member shares the same memory
> area with the task_struct:rcu (the head of an RCU CB).
> Consequence: *violated invariant* that the reference counter will
> remain zero after reaching zero!!!
> After reaching zero the task_struct:rcu head is set, so further attempts
> to access the task_struct:rcu_users may lead to a non-zero value.

Yes, you're right. Thanks for explaining this and pointing out the
oversight.

> For more information see
> https://lore.kernel.org/lkml/CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com/
> In my opinion, the decision about task_struct:rcu and
> task_struct:rcu_users union is very bad, but you should probably consult
> the memory separation with authors of the actual implementation.

I expect the reason it's like that is because prior to this change, as
Linus pointed out, nothing ever increments the refcount (other than as
of commit 912616f142bf: ("exit: Guarantee make_task_dead leaks the tsk
when calling do_task_exit"), which similarly increments before the
reference could have ever gone to 0, so I think is fine), so we had the
ability to save a few bytes of memory in struct task_struct. Eric
mentioned this explicitly in the commit summary for commit 3fbd7ee285b2
("tasks: Add a count of task RCU users").

Now that the refcount is actually being used as a proper refcount with
this commit, that space saving is no longer an option (unless we rip out
my changes of course). +cc Eric and Oleg -- would you guys be OK with
separating them out from that union? I guess the alternative would be to
check for p->flags & PF_EXITING in the helper, but using p->rcu_users
feels more natural.

> For now, in our project, we use the following approach:
> 
> 1) get a reference to a valid task within RCU read-side with
>    get_task_struct()
> 2) in the release function:
>     2.1) enter RCU read-side
>     2.2) if the task state is not TASK_DEAD: use put_task_struct()
>          Note: In the case of a race with an exiting task it's OK to
>          call put_task_struct(), because task_struct will be freed
>          *after* the current RCU GP thanks to the task_struct:rcu_users
>          mechanism.
>     2.3) otherwise if test_and_set(my_cb_flag): call_rcu(my_cb)
>          Note1: With respect to the RCU CB API you should guarantee that
>          your CB will be installed only once within a given RCU GP. For
>          that purpose we use my_cb_flag.
>          Note2: This code will race with the task_struct:rcu_users
>          mechanism [delayed_put_task_struct()], but it's OK. Either the
>          delayed_put_task_struct() or my_cb() can be the last to call
>          final put_task_struct() after the current RCU GP.

I think this idea would work, but in order for us to do this, I believe
we'd have to add _another_ struct rcu_head to struct task_struct. If we
did that, I don't think there's any reason to not just separate them out
of the union where they live today as it's only like that for
space-saving reasons.

>     2.4) otherwise: call put_task_struct()
>          Note: The my_cb() is already installed, so within the current
>          RCU GP we can invoke put_task_struct() and the ref counter of
>          the task_struct will not reach zero.
>     2.5) release the RCU read-side
> 3) The RCU CB my_cb() should set the my_cb_flag to False and call
> put_task_struct().
> 
> If the release function is called within RCU read-side, the task_struct
> is guaranteed to remain valid until the end of the current RCU GP.
> 
> Good luck,
> mY
