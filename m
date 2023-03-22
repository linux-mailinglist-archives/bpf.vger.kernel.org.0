Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532566C5970
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCVWap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVWao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:30:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7432D71;
        Wed, 22 Mar 2023 15:30:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ew6so16130944edb.7;
        Wed, 22 Mar 2023 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679524242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QLl8vMNxdNYTNJRni7qyxlQy2GoNfkt5JAqpn8X/jA=;
        b=HcODVErCjG4Q1mfAoct6KhasZfZjPAFe0VT3WE3xDi9gBnRF1lDWCGYbxG/FZ3m2DP
         0L55vBwKDf+Aoeo/+t8vTpO9lbVtI7nxtirf5dy4pjV8DJ9CMB9OiXm5ZF+fxK4couSQ
         JX92p+6TGxTUpAE+kjTP1EQf5pU1g6va2SVaiRQzD+2cUWJ0CC5B0U2iTBSt+vMPEn8k
         QflosHq6Yi789+PrV+QVkANAV9au0D8/C4nBBiUxBsUiRMX2u0eo5vcIOxXM0lBKU2w+
         bbSjIxxgqx9OaR1KEnxj0mAirXjM6dQCnXjfRdyqoOOMiZOmqbjkb8qM3jH9GBVektTA
         T0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679524242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QLl8vMNxdNYTNJRni7qyxlQy2GoNfkt5JAqpn8X/jA=;
        b=Fiqyb2kf37f/47K7N5760r4DA/Br2NMY5tOZsrjlyjs3IkVmLZ/oLtvJvuPCsfV6/F
         W3yeKf6qy0SzCFPPz4jsSS0oW8p7VuFfdHmS0bCBWTtYsrO1d7xZnP4FepJGOgrR2w3P
         ZOVvJYTfrFHz4VPtf9FVRTCIC//DanOPhlGJCRGTDAj0FsTJcY9RR2CbUBdUhOnPUMIc
         ZnwaA2HrXoQVU6f8FNHLzWZrBfOUdaZ6PMuHOkAl6kBtKFWhTxMN6A2YL7nwZFG7EKMy
         bVD6JYEEMQvEbPzx+9vsUta2QL/BYP07BWDlbO0MFNZITDN9J7DKXN/u/TK+oIJVksrK
         u+kA==
X-Gm-Message-State: AO0yUKVPDdje+ldwp77sESbi7D+3Qn/mPHWRCNOY1+t3Ux1nkFxLueCK
        11fdfkVNu8CkP6fwxfXW6sA8LkVh94rbvIYEBss=
X-Google-Smtp-Source: AK7set9PaJ/GHfrsDsDny5Sdu+i/JfxT3R1zGb7vdX6pWyzVUibYwKoNuAfCFvKqy7gacihKdgsB1/cq1C5jUT+Pfxg=
X-Received: by 2002:a17:906:2cc5:b0:931:c1a:b517 with SMTP id
 r5-20020a1709062cc500b009310c1ab517mr3935188ejr.3.1679524241553; Wed, 22 Mar
 2023 15:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230317035227.22293-1-starmiku1207184332@gmail.com>
 <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALyQVayJaZ_s9yuL07ReZRmTT52ua7B+92CdYnLi9GiegpOKNw@mail.gmail.com>
 <20230319164714.zu6kqylibrzug4ja@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALyQVazN_KTOhNVowuOV4FSr_zd5htCaBJ+xKgCDaL1LgVG50Q@mail.gmail.com>
 <CAADnVQJXAkyCd0vXPQa54gQgRpvG4Z7N+JD3+HXcbFb-+O=GLA@mail.gmail.com> <CALyQVawAZQ=K5RCnq0yz+g3fUT6vd5h15wMAeGXnDwdrZi87Qg@mail.gmail.com>
In-Reply-To: <CALyQVawAZQ=K5RCnq0yz+g3fUT6vd5h15wMAeGXnDwdrZi87Qg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Mar 2023 15:30:30 -0700
Message-ID: <CAADnVQKct7yFRwXeQapvQeMd8BbqxsTtyNGG9Ey=s154Dcifnw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: bpf: stackmap: fix a possible sleep-in-atomic
 bug in bpf_mmap_unlock_get_irq_work()
To:     Teng Qi <starmiku1207184332@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 3:26=E2=80=AFAM Teng Qi <starmiku1207184332@gmail.c=
om> wrote:
>
> We are returning to this possible bug because it is better not to give up=
.
> Please don't mind any previous retreats.
>
> The reason we are only fixing the mmap_read_unlock() function is that our=
 goal
> is to develop a static analysis tool to detect bugs in ebpf. According to=
 the
> tool's output, we found that the mmap_read_unlock() function may be calle=
d
> indirectly by ebpf hooks in a context where preemption is disabled, which=
 may
> lead to sleepable function calls through this code path.
>
>
> kernel/bpf/mmap_unlock_work.h:52 mmap_read_unlock(mm);

bpf rcu scope is a 1st non sleepable line.

> include/linux/mmap_lock.h:144 up_read(&mm->mmap_lock);
> kernel/locking/rwsem.c:1616 __up_read(sem);
> kernel/locking/rwsem.c:1352 rwsem_wake(sem); <- preempt_disable()

and this is 2nd non sleepable line.

> kernel/locking/rwsem.c:1211 rwsem_mark_wake(sem, RWSEM_WAKE_ANY,
>  &wake_q); <- raw_spin_lock_irqsave()

and this is 3rd.

> kernel/locking/rwsem.c:566 wake_q_add_safe(wake_q, tsk);
> kernel/sched/core.c:990 put_task_struct(task);
> include/linux/sched/task.h:119 __put_task_struct(t);
> kernel/fork.c:857 exit_creds(tsk);
> kernel/cred.c:172 put_cred(cred);
> include/linux/cred.h:288 __put_cred(cred);
> kernel/cred.c:151 put_cred_rcu(&cred->rcu);
> kernel/cred.c:121 put_group_info(cred->group_info);
> include/linux/cred.h:53 groups_free(group_info);
> kernel/groups.c:31 kvfree(group_info);
> mm/util.c:647 vfree(addr); <- oops, sleep when size of group_info is larg=
e
>
>
> Our focus has been on detecting and fixing bugs in ebpf, and we were not
> previously aware that vfree() might be called in other contexts where pre=
emption
> is disabled.

preemption and non-sleepable are not the same.

> Additionally, you mentioned that rwsem_wake() calls
> preempt_disable(). Upon investigating the code path, we discovered anothe=
r
> occurrence of raw_spin_lock_irqsave() in rwsem_mark_wake(). We understand=
 that
> our tool does not currently account for context operations from helpers t=
o
> sleepable functions.
>
> To address this limitation, we have decided to enhance our tool's capabil=
ities
> to collect and display information on context operations in the callee fu=
nctions
> of helpers and potential callers of sleepable functions. However, this wo=
rk will
> require some time. Consequently, we have decided to abandon this patch be=
fore.
>
> At present, we are uncertain about how to fix this potential and theoreti=
cal
> bug. One potential solution could be to replace the use of kvfree() with
> kfree_rcu() in groups_free(). Among the callees in put_group_info(),
> groups_free() is the only one that may call sleepable kvfree(). Therefore=
, we
> propose modifying groups_free() to ensure that put_group_info() does not =
sleep.

Do not fix what is not broken.
So far you haven't demonstrated that this stack trace is possible.
