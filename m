Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3596C8DF1
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 13:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCYMUc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 08:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYMUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 08:20:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FC83E2
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 05:20:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so4199278wrz.7
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679746829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5G8v4j/lG0DmUtRkOp52G1RCRZ1eHzinQT+7xMSjDKY=;
        b=Fl25KlIwbvS0zT+lJ+3v0YL1EJ7spxxQPBudxmE3yex8KDacNiDTeVMnoRQsB9LwLR
         bv996luzrrb30CZBROCiFk91/QVwh2Rasa/Aa6oi0fzDyvXowP81tUsIfuGsj0tzbvcP
         A07rCPYGigx/BT/qjFF8jN1CGvOW2an0k2sZVW65BJjtccvsfzuefvtK23o3mvs6BsFK
         1BOJsbkHnZedYi4L7PLLMRgoiQ9/2FYySTtVCWyLr+7LDAxcxwn9aWOMX5EUZBTWtVyT
         ZlCCfA2IDJ2MZH4Cgm3PXXLqC2RJIzDQdb3SKpiVVFDyi6f8FQSiI8+N5slEYKlwTGKg
         PSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5G8v4j/lG0DmUtRkOp52G1RCRZ1eHzinQT+7xMSjDKY=;
        b=UY96qxP0syZl7Qqh0Z8KFXAxCK9igWaR7wEL90GYb6cWDXB3Ryclfqj68n3dPC4hFq
         C5DDrytctFKgiZL/9zLayQMLC8JR010UuZfjK+0wJM1Wt0dlNIe8oRPzeLqjnaRMBS4s
         RK3PVQZxZ7TCN6A3big/IW6Fxbg7lGNWvKYDvyyryQwkdiwF9murrmtZcbTkne8wNVyw
         mcexMkKz09fdXNKBQ+t0tYl+s7qBbZ0U+Ut3x2aDOkwpCPCr6Rk5OOYUCSEJ0KJR7l79
         hUZ9TYJUrDUnCDlLo9SUn2g3wpm9uuqpuypQHoC3GC9nZf9dFkXEFJ4JvYN5Od2DeXIj
         rcLQ==
X-Gm-Message-State: AAQBX9dCpw+ckAqgP08mmSm8oGjI0POuwTRdr1At8fZYxWchToxlMzpM
        t52uZbROmhBmeb5TMmnED3A=
X-Google-Smtp-Source: AKy350Ym1mLbNPm1NuYv5mPJj5w6vzyE8HOP6/ngm7lTpBwDZr85p5rrRsSJhGQk30zCV5Fl0VspBg==
X-Received: by 2002:a5d:4f09:0:b0:2d7:579b:1259 with SMTP id c9-20020a5d4f09000000b002d7579b1259mr4998872wru.13.1679746829423;
        Sat, 25 Mar 2023 05:20:29 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m9-20020adffa09000000b002c70d97af78sm20673947wrr.85.2023.03.25.05.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:20:28 -0700 (PDT)
Message-ID: <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Sat, 25 Mar 2023 14:20:27 +0200
In-Reply-To: <ZB5pFYZGnwNORSN9@google.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
         <ZB5pFYZGnwNORSN9@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-24 at 20:23 -0700, Stanislav Fomichev wrote:
> On 03/25, Eduard Zingerman wrote:
> > This is a follow up for RFC [1]. It migrates a first batch of 38
> > verifier/*.c tests to inline assembly and use of ./test_progs for
> > actual execution. The migration is done by a python script (see [2]).
>=20
> Jesus Christ, 43 patches on a Friday night (^_^)
> Unless I get bored on the weekend, will get to them Monday morning
> (or unless Alexei/Andrii beat me to it; I see they were commenting
> on the RFC).

Alexei and Andrii wanted this to be organized like one patch-set with
patch per migrated file. I actually found the side-by-side comparison
process to be quite painful, took me ~1.5 days to go through all
migrated files. So, I can split this in smaller batches if that would
make others life easier.

Also the last patch:

  selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline as=
sembly

was blocked because it is too large. I'll split it in two in the v2
(but will wait for some feedback first).
=20
[...]

> Are those '\' at the end required? Can we do regular string coalescing
> like the following below?
>=20
> asm volatile(
> 	"r2 =3D *(u32*)(r1 + %[xdp_md_data]);"
> 	"r3 =3D *(u32*)(r1 + %[xdp_md_data_end]);"
> 	"r1 =3D r2;"
> 	...
> );
>=20
> Or is asm directive somehow special?

Strings coalescing would work, I updated the script to support both
modes, here is an example of verifier/and.c converted this way
(caution, that test missuses BPF_ST_MEM and has a wrong jump, the
 translation is fine):

https://gist.github.com/eddyz87/8725b9140098e1311ca5186c6ee73855

It was my understanding from the RFC feedback that this "lighter" way
is preferable and we already have some tests written like that.
Don't have a strong opinion on this topic.

Pros for '\':
- it indeed looks lighter;
- labels could be "inline", like in the example above "l0_%=3D: r0 =3D 0;".
Cons for '\':
- harder to edit (although, at-least for emacs, I plan to solve this
  using https://github.com/twlz0ne/separedit.el);
- no syntax highlighting for comments.

Pros for string coalescing:
- easier to edit w/o special editor support;
- syntax highlighting for comments.
Cons for string coalescing:
- a bit harder to read;
- "inline" labels look super weird, so each labels takes a full line.

[...]
