Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC06BEED9
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCQQwE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCQQwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:52:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F531B04B0
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:52:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so22873195edd.5
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679071920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22PPd63dWMb4SkCCMOitDvl5rNP6pZiGk7TDT2rl8ew=;
        b=Tg2MZkpUE4sN6OUz3jpc6mDjPTPPQsz8Uo9iDh0PtQ+gWEx2d7fdCn/Yx5cDThlwds
         y+DV1j/4u864uZ6muxNisZapQ54QBpaVUDsSlzblyTLuk/sIlOBo1NPEWmzB4cavb6Gq
         3hW6MfBOQK8HNH41DTYc5fTwpwQUQC+N/j8mwlMpHM+VGrpsGWkVfo2QEXao3rTOlv41
         PXn+lBGbfryyr5wK+m+gGKX8cHFBq2ezF1wdjsan/JV/it1ejiYZzyGW/nR0DR1TSG60
         wH9IZMnOoIvzrx6q0q1PbIbya0uq+6T0H3U1aDgJRx1EipqR0/cCq8IPAoNdAHI103lg
         PCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22PPd63dWMb4SkCCMOitDvl5rNP6pZiGk7TDT2rl8ew=;
        b=fPCUZDXEfp7PEDLDGbMQATBumKfO1eZiTQlk9KHV5Krr/nLvUJmvKmjsXGT/pUjrWj
         iUuCpCisn0QQhxml2jx5ESMwnI75rAg0vUJA2hqHe3bl9lwecVQSW7hRyx5h44PufGZS
         GrqdwSeq2jIGzdKvxeiL9Oq6WnU43zMfLjPYkLfdhT9MSrwICFHNppfzg2ouaDXbUUE3
         t73/C4n2eVshzzNrEf7bmRhDZrPpjWTgc2zKIPqkXEsCPrwmrqd7M+q+Uq86o2BXnFwh
         jm7AAsXh3EIV3RD2jMIYoRBwKJP1Biw+dMgmhTrG4I+Q/UPA0E/8tVGpg2tsha0iP8CP
         Kk7Q==
X-Gm-Message-State: AO0yUKWWTqhWe8vcSg+8cyb3rgqeW26GwAwmZf7YDGd3FUmEQ8FmMmNi
        Qw6/WqpU+inlbEHVWU2VZ+m2wjHa/ZSDxBuHX4g=
X-Google-Smtp-Source: AK7set8edCVWWFu+kQl0FS08beU6ZNmhVdDokdLIO+XUkbkg05KcInxX/BLJaJgckb72roeT4FLJjfphOzjh1A03wk4=
X-Received: by 2002:a50:d4cf:0:b0:4fa:3c0b:74b with SMTP id
 e15-20020a50d4cf000000b004fa3c0b074bmr813456edj.3.1679071920548; Fri, 17 Mar
 2023 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230317114832.13622-1-laoar.shao@gmail.com>
In-Reply-To: <20230317114832.13622-1-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 17 Mar 2023 09:51:49 -0700
Message-ID: <CAADnVQK25mz+9JZrKLEwFbJougyF08_9in=dEdrsvqSOaKRneA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Filter out preempt_count_
 functions from kprobe_multi bench
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 4:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> It hits below warning on my test machine when running test_progs,
>
> [  702.223611] ------------[ cut here ]------------
> [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursio=
n.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: =
G           O       6.2.0+ #584
> [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> [  702.241388] Call Trace:
> [  702.241615]  <TASK>
> [  702.241811]  fprobe_handler+0x22/0x30
> [  702.242129]  0xffffffffc04710f7
> [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 0=
0 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <=
55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000=
000000000000
> [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 000000000=
0000000
> [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 000000000=
0000001
> [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 000000000=
0000000
> [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
00000ca
> [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 000000000=
0000000
> [  702.250785]  ? preempt_count_sub+0x5/0xa0
> [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.252368]  ? preempt_count_sub+0x5/0xa0
> [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> [  702.253918]  do_syscall_64+0x16/0x90
> [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  702.255422] RIP: 0033:0x46b793
>
> It's caused by bench test attaching kprobe_multi link to preempt_count_su=
b
> function, which is not executed in rcu safe context so the kprobe handler
> on top of it will trigger the rcu warning.

Why is that?
preempt_count itself is fine.
The problem is elsewhere.
Since !rcu_is_watching() it some sort of idle or some other issue.
