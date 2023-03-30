Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF56CFAD2
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjC3Fi7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjC3Fi6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:38:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37449D8
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:38:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so72006503edd.5
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680154708; x=1682746708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvapKzY03PB9kAaxB3Nt+lI3LuzgN0YjQL78u0hLuaM=;
        b=qomxeqQqEXdGbZoOIPddUar+dRgZ2/JWT+l5Cjqb9CxZWrF30cKAMPkoc7D7g/ogBr
         YJPFo2nE+63LM55tLZOIjuyUmikLEECDKEaJeiv1uNfY9KjyJSNEsZHkIBTiqagTGRoN
         1nQUaICLH4l33weFaplhwnc02WclhWeEJqTyRpCJ0EVJ0Qj6ktBUsQZfKAZHvqhRtnMP
         nwDybt7Dxj+vCFj8XtoFINN6vL6PaBIoD9gWKJ1/yfgRaZOVz1V/MwucLbhgU2NfeC3q
         968k6o8iNR5Vd2k2JAZAwaIwKKF0HTLbe1ZJwrBkWxr7AEbO0BOBvLCb54shMqdoNQgV
         wqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154708; x=1682746708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvapKzY03PB9kAaxB3Nt+lI3LuzgN0YjQL78u0hLuaM=;
        b=udKA5Ve86hRz+aG1VnwlEJx9fGKYJ/l5X3aPoeMEd7kJgVTFeivv/ggCQ51BQWfMOL
         rbtDwLZ3VXhGBvwTXQe7FiFjCa3rQFRXOvoZlA6JRe8oirds5fjhkJQ7JP/A6WpwFBk8
         /sFSetKyn8rnyYyL8dLL6KahYsVCoCLij0ACRRYsxYFuWjTzmx0jQ8DszbSDzXQUZKKo
         6GvmfNIqoaQXgFn/gNzgos84Ja2bzdrwRyjiwI2epQt/xtuPeWOsCY3B/nlLe7hmmRPc
         Fd24wrNJsZq32Pv7NCT9u7vpd+fKZNMwdNF33Kjo48MUhk3wLUVGp1x6lXPmo1Q7w6ws
         eV/g==
X-Gm-Message-State: AAQBX9emv4u94hiByPUUqyz6PBEmLMJ+7gUBKXMcQlJSdl686ONHHNMO
        25/RG4E4B9IpNyRfSP5AqWj3z9iu/W8WmUad12w=
X-Google-Smtp-Source: AKy350ZHNlnx/7yOeZl9mRv6xQMgwnwDmFsRybucIGRc4PbmZ8TN9ZYJSebvj1pfYWVYwq9Aqw1El9b+qXKweerKgTM=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr10911742edi.3.1680154707635; Wed, 29
 Mar 2023 22:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230327185202.1929145-1-andrii@kernel.org> <20230327185202.1929145-4-andrii@kernel.org>
 <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
In-Reply-To: <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Mar 2023 22:38:16 -0700
Message-ID: <CAADnVQ+hSFfkcJ=Ni_4UnW5sx93GdBMKSGcT1RujWkaonZN-OQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] veristat: guess and substitue underlying
 program type for freplace (EXT) progs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Wed, Mar 29, 2023 at 11:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> > SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable as
> > is through veristat, as kernel expects actual program's FD during
> > BPF_PROG_LOAD time, which veristat has no way of knowing.
> >
> > Unfortunately, freplace programs are a pretty important class of
> > programs, especially when dealing with XDP chaining solutions, which
> > rely on EXT programs.
> >
> > So let's do our best and teach veristat to try to guess the original
> > program type, based on program's context argument type. And if guessing
> > process succeeds, we manually override freplace/EXT with guessed progra=
m
> > type using bpf_program__set_type() setter to increase chances of proper
> > BPF verification.
> >
> > We rely on BTF and maintain a simple lookup table. This process is
> > obviously not 100% bulletproof, as valid program might not use context
> > and thus wouldn't have to specify correct type. Also, __sk_buff is very
> > ambiguous and is the context type across many different program types.
> > We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine in
> > practice so far. Similarly, some program types require specifying attac=
h
> > type, and so we pick one out of possible few variants.
> >
> > Best effort at its best. But this makes veristat even more widely
> > applicable.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I left one nitpick below, otherwise looks good.
>
> I tried in on freplace programs from selftests and only 3 out 18
> programs verified correctly, others complained about unavailable
> functions or exit code not in range [0, 1], etc.
> Not sure, if it's possible to select more permissive attachment kinds, th=
ough.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for testing and important feedback.
I've applied the set. The nits can be addressed in the follow up.

What do you have in mind as 'more permissive attach' ?
What are those 15 out of 18 with invalid exit code?
What kind of attach_type will help?
