Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5366B596
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 03:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjAPCYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 21:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjAPCYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 21:24:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EEE6E9D;
        Sun, 15 Jan 2023 18:24:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v23so27714044pju.3;
        Sun, 15 Jan 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYdGKri8CtHw7pZMqbFsWWoymwJanfzpoR/WCEa7wqA=;
        b=bqIEQbSAevenp6u4wVteFOesMjm2Yz4CirXyqqV1T9bm/KL0HjPtTXDxRc1wqTmVEI
         YYtDRjaot3gXha6Oe0mTYfWgFccD6s+0vkjRj7kBxsZuTIFuDFxVQK+MVesYYIU/i/Ju
         jMHoLdy+LxDnY7EPnuN7Aa5NaFYV1p3kzV5biUOqFLSsL8P1Fs4w/hpjqt4Vo1SjSPoT
         AG3umop2gdfKks7nxrXeS7YQw5NThU7JMeiCUxURvlw1HIHO08ZZIHIMis2qggGprBhK
         5NN+O1IFryEFZ6/98pB9OQOeaW5DpM0wgoZfF5VtKGyy4rkAba/LWFnL+mcdiBbQIS8N
         3r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYdGKri8CtHw7pZMqbFsWWoymwJanfzpoR/WCEa7wqA=;
        b=WqXskDyq36gWu5yn5w+JV/dQsMHC7xVApJEPzpvQn/48pq9Z/+KpzOK1IzDsZ2Nnbs
         /20pIF82xb7ICsaqfnRTQL9aAAT8aHrGtOXMlufpTgEimarF9pPFmf+mFlUUh0oc0DFe
         Z0wDpCT1yz5iShkN/QzumiOIVQgIjIl7w83OFIh2FjlE9HdZGAbD6ZGQeOiotQU/oJYK
         HV7uaQC5MmzlrIHoeALLXSLlFwG9vsLW5EahCqt7J866II765P64r6hGQHnhLicjLHFQ
         ug+VgXGFir5ifchfa6XBSLFUxp9RxrkXGuS6DGA8pRrAuL6lTLaAR1wt/gqcRynJY/lg
         LblQ==
X-Gm-Message-State: AFqh2kon8WgyuNxEFK+8vTpuZjeJTDANkxGvDkeuZ1brci9xWM35D5m6
        kRBKh6M63Y5nQhghPcp6mQ==
X-Google-Smtp-Source: AMrXdXvPzRZ2+Y0YCL2Gyodavqy/TNWiYhwWfTzlZ09jZ1uh5p8Cj6DPXHfQ/3R3Yspak0Gnldk3qw==
X-Received: by 2002:a17:902:f610:b0:194:9c02:7619 with SMTP id n16-20020a170902f61000b001949c027619mr303759plg.29.1673835863680;
        Sun, 15 Jan 2023 18:24:23 -0800 (PST)
Received: from smtpclient.apple (n119236129232.netvigator.com. [119.236.129.232])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00186c3afb49esm17954507ple.209.2023.01.15.18.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2023 18:24:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: WARNING in debug_mutex_unlock
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <be494ee3-864d-1a33-e14d-d27712ab6248@meta.com>
Date:   Mon, 16 Jan 2023 10:24:09 +0800
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4BBA1C3-C704-49D3-8E13-18875B27FB47@gmail.com>
References: <20230109074425.12556-1-sunhao.th@gmail.com>
 <be494ee3-864d-1a33-e14d-d27712ab6248@meta.com>
To:     Yonghong Song <yhs@meta.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 13 Jan 2023, at 2:45 PM, Yonghong Song <yhs@meta.com> wrote:
>=20
>=20
>=20
> On 1/8/23 11:44 PM, Hao Sun wrote:
>> Hi,
>> The following warning can be triggered with the C reproducer in
>> the link. The repro starts 32 threads, each attaches a tracepoint
>> into `ext4_mark_inode_dirty`. The prog loads the following insns
>> that simply sends signal to current proc, and then wait.
>> Seems issues in queued irq_work with `do_bpf_send_signal`, also
>> I'm wondering what if the task in `send_signal_irq_work` exited,
>> at the time the callback invoked.
>=20
> Somehow, I cannot reproduce the issue in my qemu environment
> with below kernel config and C reproducer.
>=20
> But could you try the following patch to see whether it
> fixed the issue in your environment?

Tested the below patch on my local machine, seems fixed the issue.

Before applying the patch, the reproducer can still trigger the
reported issue on a latest bpf-next build; After applying the
patch, the warning no longer appears.

The test is conducted on: dfff86f8eb6a (=E2=80=9CMerge branch =
'samples/bpf:
modernize BPF functionality test programs'")


>=20
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 23ce498bca97..1b26d51caf31 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -831,6 +831,7 @@ static void do_bpf_send_signal(struct irq_work =
*entry)
>=20
>        work =3D container_of(entry, struct send_signal_irq_work, =
irq_work);
>        group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, =
work->type);
> +       put_task_struct(work->task);
> }
>=20
> static int bpf_send_signal_common(u32 sig, enum pid_type type)
> @@ -862,7 +863,7 @@ static int bpf_send_signal_common(u32 sig, enum =
pid_type type)
>                 * to the irq_work. The current task may change when =
queued
>                 * irq works get executed.
>                 */
> -               work->task =3D current;
> +               work->task =3D get_task_struct(current);
>                work->sig =3D sig;
>                work->type =3D type;
>                irq_work_queue(&work->irq_work);
>=20

