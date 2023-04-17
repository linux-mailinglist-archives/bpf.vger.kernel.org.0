Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856346E5517
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDQXUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDQXUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:20:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C48448B
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:20:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id xi5so68483443ejb.13
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681773618; x=1684365618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PR0bcHADpHaARMVXRVVBxLPqOl6AwH5QfKfEvPgTrw=;
        b=jUxxngzW0x4EVsH6vdrrsMmyW2KC+1ig/y6zdYZav6lqxm3iJ3RPwYfNPsYVWC5oOY
         3R1QL+Cdw0oIm6mftal3IEsOqi07ZpdCXRQvBkP5suHW8xeUHOuUwtZRmNeuTXXvN6yP
         nsrNXvZ0nsZgJo/5VLpjBc3HPRp0BBvTEiaA1jUBD9is39PfUX1uJ4Bbx3z/sgVhbLqa
         fo2enlPwaicD1HncVz59GgY3deeDkVKskvo/uQsJCuuUCGZFwXWI+Eiq2cUNqV+niGLR
         PCmj6vAkzrNlvr/sOySq57kcPKPJQvbptM5HHn7xL+qmeJHNJEI+ybmi7FcZ4zaiNNE0
         lWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681773618; x=1684365618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PR0bcHADpHaARMVXRVVBxLPqOl6AwH5QfKfEvPgTrw=;
        b=EzFj1ed2bbTRr9Grha/z8kMihD6JxyOyZUOyVcUzj9qcqeQzgrikXPL1pgZRoE6/Uw
         mC7UZGNafI9uTT1esTcOZZogDm1Bs7LWgjXHXSY8+blo1ca+FwDQDRUxe5ckxLgpzumD
         i8HerOUBIqzvOeuRMuqJXCun2q8BAPZQmQk5TO03jmuTKNb7Tb+iRcjHZ5R3X3KZRK+/
         QL+ew/uiH4bBBGTYJ701DS/H7Sk++3AY8qhChMVQfSI7XIwWNaEuyYZYUJCHRRKT6L6I
         yOgxrXbsgckF72sy74W733eiiDsMkMcedOKlcVSSUTsQ0ZbtIEb7jm9nK+f6p4AHcjsj
         onLw==
X-Gm-Message-State: AAQBX9f9irfG3LyqQM0CF2/FDrqoUwzGW5LO3CUr2ZUAz51u0gNMxtd1
        fa62eiEjMeYBD2VUxihIK/WZiVSkG/G+Bv2hk1I3IB4H0wg=
X-Google-Smtp-Source: AKy350YK7e5Nr7xZYqVJvco+oH3qJc1s9qdQRBScD3ME2LNmUVR0IVVt/NEHCJzdjMWc1qVzf8JgrWGPbWE9G5reE3Q=
X-Received: by 2002:a17:907:f85:b0:92e:a234:110a with SMTP id
 kb5-20020a1709070f8500b0092ea234110amr4362594ejc.3.1681773617792; Mon, 17 Apr
 2023 16:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230405004239.1375399-1-memxor@gmail.com> <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
 <20230407021519.j5esh3lbt6c6goz5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <wlbng3zbk63ezpy7bqv7oezcwc7ctgbp3wy7fvvdeh7cauejzi@ub67so7yzamb>
 <20230412194306.ltiiutzilk25hnll@macbook-pro-6.dhcp.thefacebook.com>
 <w6j2sqr77mtsldysqjx5fs4ohso45ac352azjpzneqdarm2mwh@2i7tnmwd35dr>
 <20230413234152.c5canwh6imvbf5al@dhcp-172-26-102-232.dhcp.thefacebook.com> <a3pa3elhn3yirvblwvq7ib4e4c335qs2wctjo5gxmq3l2izv35@jgeabqmiojnl>
In-Reply-To: <a3pa3elhn3yirvblwvq7ib4e4c335qs2wctjo5gxmq3l2izv35@jgeabqmiojnl>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Apr 2023 16:20:06 -0700
Message-ID: <CAADnVQ++MV_kdph+QLfQJNPs+toa5Q0L3aJjXb2MUojgKKfLpQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks in
 helpers and kfuncs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 9:45=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> > I think the check after bpf_call insn has to be no more than LD + JMP.
> > I was thinking whether we can do static_key like patching of the code.
> > bpf_throw will know all locations that should be converted from nop int=
o check
> > and will do text_poke_bp before throwing.
> > Maybe we can consider offline unwind and release too. The verifier will=
 prep
> > release tables and throw will execute them. BPF progs always have frame=
 pointers,
> > so walking the stack back is relatively easy. Release per callsite is h=
ard.
> >
>
> After some thought, I think offline unwinding is the way to go. That mean=
s no
> rewrites for the existing code, and we just offload all the cost to the s=
low
> path (bpf_throw call) as it should be. There would be no cost at runtime =
(except
> the conditional branch, which should be well predicted). The current appr=
oach
> was a bit simpler so I gave it a shot first but I think it's not the way =
to go.
> I will rework the set.

It seems so indeed. Offline unwinding is more complex for sure.
The challenge is to make it mostly arch independent.
Something like get_perf_callchain() followed by lookup IP->release_table
and final setjmp() to bpf callback in the last bpf frame.
is_bpf_text_address() will help.
We shouldn't gate it by HAVE_RELIABLE_STACKTRACE,
since bpf prog stack walking is reliable on all archs where JIT is enabled.
Unwinding won't work reliably in interpreted mode though and it's ok.
bpf_throw is a kfunc and it needs prog->jit_requested anyway.
