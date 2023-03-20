Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F16C18DA
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjCTP2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjCTP1k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 11:27:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF0A37F0B;
        Mon, 20 Mar 2023 08:20:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so48224053edc.3;
        Mon, 20 Mar 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679325648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kw+qaW0IRgkPXI2zqL3VUWrpjrCLz4zhcfmeF4b5oA=;
        b=C5MmYe4hIyT+Y8n015wyAjPw9sbmwsnOwL0EYcCzMatk6V2UeEdFsIBWApWBC/JRH+
         IzFVJp6kQ6UyD7VPU9rM2g6xQkJR9HdAvhqjTVVkC6wsv3MPqL/RA2huyAkX4ijUb3bq
         11t9uV5QP+7qHjTC8ZmZnyuGLE9cy4A6zeYE3aJHRaA5VWonHd5ju6lHsKChZ7iaPIIo
         kFMvzed/JjSPTn9pgDxKMziaUvyWBHdoYvYynJdsMopzdgnOPxg5xyoX9XdC4r/XZMbN
         GcrXhR42MvmXJyXxOUj38F24XDCvYn/gVjIOm3bwEydBB2/02H8EkMsRf44aejX0LmZc
         7RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kw+qaW0IRgkPXI2zqL3VUWrpjrCLz4zhcfmeF4b5oA=;
        b=iUzn6jtoMV/VxstEXl2WooR31o7K36nu+Dmw+3EFdKfMrhb212kxWfrxkN+ZRPWsZ/
         qJaiuaYK5g5xpoZWXr5XAuXEPshm3CSdTSxR24YSLfDHl0Z/7/8UHPlG2Ub0LAumHg04
         iH/hHKPlHAwNA/et78bvtasDunG0jYpuWv4D/Yqep80lISJYz31BFZSFkC1PkYBQnHQk
         8ATs8zsZyfdY9I/BsSCyDyO3LO+ezxijL/ofdUcCzQJFBVN217HluzD9ucq5Hv4Ol44o
         9WdBzw27ZWJorqBmmamoixih22V830YTKQLoLxIEYcyEjGUoVDjxQajmBHaZ+u3j4zl7
         NSYg==
X-Gm-Message-State: AO0yUKWt1PmWKKptS6bZti1hu7178CF4/24lM5T+gjTTE23U66x0A+cX
        P8Ul8Y8veckCQwVQl6bn5SJZoaQD5zoS2SD15bY=
X-Google-Smtp-Source: AK7set+Q0q+E+Sb7r+JKFFBfzrPzalPnaL3jlI25hjs4owdnUGqXQmQeZs5QC1jSLJ07ZIrQYRKsGqeRwskdeiuTu2U=
X-Received: by 2002:a17:906:4d84:b0:92e:a234:110a with SMTP id
 s4-20020a1709064d8400b0092ea234110amr4340421eju.3.1679325648130; Mon, 20 Mar
 2023 08:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230317035227.22293-1-starmiku1207184332@gmail.com>
 <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALyQVayJaZ_s9yuL07ReZRmTT52ua7B+92CdYnLi9GiegpOKNw@mail.gmail.com>
 <20230319164714.zu6kqylibrzug4ja@dhcp-172-26-102-232.dhcp.thefacebook.com> <CALyQVazN_KTOhNVowuOV4FSr_zd5htCaBJ+xKgCDaL1LgVG50Q@mail.gmail.com>
In-Reply-To: <CALyQVazN_KTOhNVowuOV4FSr_zd5htCaBJ+xKgCDaL1LgVG50Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 20 Mar 2023 08:20:36 -0700
Message-ID: <CAADnVQJXAkyCd0vXPQa54gQgRpvG4Z7N+JD3+HXcbFb-+O=GLA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 5:28=E2=80=AFAM Teng Qi <starmiku1207184332@gmail.c=
om> wrote:
>
> Yeah, we got your points. There are two key questions. The first question=
 is
> that preempt_disable() and preempt_enable() will be conflicted with vfree=
()
> before the mmap_read_unlock().

What does this sentence mean?

> The second question is that thousands callers
> of up_read() only make sure irqs_disabled() =3D=3D false needed fixed if
> the mmap_read_unlock() is fixed.

that doesn't answer my question either.

> Detecting ebpf bugs can be challenging since it is difficult to prove tha=
t a
> bug can be triggered during runtime, as well as fixing the bug. We decide=
d to
> give up this patch that fixes the possible sleep-in-atomic bug in
> bpf_mmap_unlock_get_irq_work(). Instead, we will focus on improving our s=
tatic
> analysis tool to find ebpf-specific bugs.

Please don't.
