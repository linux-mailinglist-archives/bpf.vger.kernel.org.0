Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DE5F27D0
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 05:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJCDYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 23:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCDYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 23:24:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9B3CBF2
        for <bpf@vger.kernel.org>; Sun,  2 Oct 2022 20:24:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso6319841pjb.0
        for <bpf@vger.kernel.org>; Sun, 02 Oct 2022 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=L+CoWZhwHjk174aeXHO5g8pvW3vJza1Q8xqymz4CQuc=;
        b=TnZn5C1mrfpH5g/2pny6PUZLAe7Bqol9d8asV3usw3bKqLeyNKBTzZoydSju/6B3pZ
         4ItlQqkRc6NwdEm4dkokPAHcY9IDYnAo+jgSWQGCWdjHvMXrMwk/0JKGfd4WpeQf7f9u
         rl0puT/QqNf+1CQFEpA4aGg8sxs8qIyi13aVeC/z4gJXyDni6z+jcjs36YrcHO9BHqiD
         NE4e1Tq63pcuVOwoMWJFPE5Fs5D3bdBWXuLxkTqV564OeU6Dyhz1CktT4fQxwaHWuwfA
         7zEbjNbrGtLZEmSRy27NYiznW03F6kgna3jWNk4tqBGZVJdg1/vsz9/gKKThkEoNWzpC
         6Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=L+CoWZhwHjk174aeXHO5g8pvW3vJza1Q8xqymz4CQuc=;
        b=EW8Q/zCb+Lms1v2SydilDXrC88mTP0P7hFu1NekVq34tgcD6oEMr4qvFazvJyeWVyi
         hND11LlvURaOjN+sSK42pSUVMoTBHSHnN5BZWTze0xkvDQloys6Yc0lBw/VlGEii1B3s
         TgwUBBEPsypqsS5qd+npSzsG5T5ZzM/okkRFGmmGy0g6ftz8yPEgCEEKERLFRe7MJu3O
         lXCiGSYPNVsQJLBI7MJ5SeM7Mkji/pGdMuM6H/sLN4z1k4G4UaFhkoK4XcZ/JSi5BzXz
         E08YwpgZBRNzv0nlg/6rfxKy865v3dJUmVOu7AyrawrYSnPB1xptyZix/nvwcufIoFe8
         0Fpg==
X-Gm-Message-State: ACrzQf0ykm5EcjvlGxd32rXB0aszlaj1uDQ8s735i1TIuiSn/ki9dzCb
        OyH7OUg17/ddgiLjoD9CZioN5gTPZ90db0KHyL6C5gWB+HU=
X-Received: by 2002:a17:902:8ec5:b0:179:ffdc:ee4d with SMTP id
 x5-20020a1709028ec500b00179ffdcee4dmt17351562plo.124.1664767469725; Sun, 02
 Oct 2022 20:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
 <YzbzweamuZyxLuJ1@krava> <CACG+mBV7xboG9Y5LctyJuGoft42b4gHxbSBDtzPxpnzy+CaxDg@mail.gmail.com>
 <CACG+mBXc2T28-sn4KMRQPRT0k7ejNg1s8qHFOp3HmM5--e4rBw@mail.gmail.com> <Yzmm8pukHcFk5tko@krava>
In-Reply-To: <Yzmm8pukHcFk5tko@krava>
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Sun, 2 Oct 2022 22:24:18 -0500
Message-ID: <CACG+mBVP=+DZutaR5SywJvMOBHay6jh=iK6CcF_Yh5jjHpZmtQ@mail.gmail.com>
Subject: Re: Replicating kfunc_call_test kernel test on standalone bpf program
 (calling kernel function is not allowed)
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > Following up on this, I have moved to kernel 5.19.12 and I'm trying to
> > make any kfunc work.
> > I changed net/bpf/test_run.c to allow for more prog types, like master
> > branch does, since originally it only had the first line for
> > BPF_PROG_TYPE_SCHED_CLS.
> >
> > ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
> > &bpf_prog_test_kfunc_set);
> > ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > &bpf_prog_test_kfunc_set);
> > ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE,
> > &bpf_prog_test_kfunc_set);
> > ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACEPOINT,
> > &bpf_prog_test_kfunc_set);
> > return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
> >                           ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
> >                           THIS_MODULE);
> >
> > I also added my own function to test it out and added it to the SET
> >
> > u64 noinline bpf_kfunc_call_test4(u32 a, u64 b, u32 c, u64 d)
> > {
> >     return a + b + c + d;
> > }
> > //this is inside  BTF_SET_START(test_sk_check_kfunc_ids)
> > BTF_ID(func, bpf_kfunc_call_test4)
> >
> > Now I'm spraying every BPF program I can find to call either function:
> >
> > extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> > __u32 c, __u64 d) __ksym;
> > extern __u64 bpf_kfunc_call_test4(__u32 a, __u64 b, __u32 c, __u64 d) __ksym;
> >
> > Compiling works, and when I run it I get no errors, *except* Permission denied.
> > gist here: https://gist.github.com/hfingler/5c2c0b713299daa6b0ba07fa92ff29de
> >
> > libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied
>
> seems like the kfunc is not found on the set for the program type, I guess
> your change above did not go as expected
>
> not sure what is your goal exactly, but perhaps better than starting from
> scratch would be to take prog_tests/kfunc_call.c and progs/kfunc_call_test.c
> and change them accordingly?
>
> jirka

My goal is to be able to call any kfunc. If I can do that I can add
trampolines to do more interesting things.
Starting from those files is pretty much what I was doing already, but
I started from scratch again.
I was finally able to load the BPF program without the EPERM error. I
think it's working but I'm not sure since I don't know
how to trigger the function so it prints something.

It seems like the error was having multiple calls to
`register_btf_kfunc_id_set` in `net/bpf/test_run.c`. By commenting out
the three
that I added, the function was found on the set and worked correctly.
With the others uncommented, the set find was returning false.
I suppose multiple of these calls do not work on 5.19 but do work on
later versions.
This part of the code on 6.0 (or master) has two calls to
`register_btf_kfunc_id_set` in sequence, but also many changes around
it, like `btf_kfunc_id_set` having only `.set`,
so maybe something was changed on the backend.

    ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
&bpf_prog_test_kfunc_set);
    //ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
&bpf_prog_test_kfunc_set);
    //ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE,
&bpf_prog_test_kfunc_set);
    //ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACEPOINT,
&bpf_prog_test_kfunc_set);
    return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
                          ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
                          THIS_MODULE);

Before I go at it, are there any immediate restrictions on
BPF_PROG_TYPE_KPROBE calling kfuncs? I'll have to figure out how to do
it, but knowing it *can* work does help.

Thank you.
