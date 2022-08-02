Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAD587CDC
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiHBNGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBNGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 09:06:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0625F
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 06:06:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s16so3302925ilp.3
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4xI4KhaKApTzyvQaN+vM+hT6fkkMT1iiqHfb2UmIAM=;
        b=n+msJj5c2Q4PH9tv5g18oRCPmM5j6+JrXIoNS+9vxZ2eJh+fIM/w+2j1uAheo2t1qk
         iXySL24jELEZxuMj5FdjuRIEny5PMjRe1xYnOUzOdY+YHhrNsdISHfNQvmitq4+TNMW+
         XYSpcK8lnrLOP9A1jg2DIr2Cv0cuyN1QNAhABMvEDs7bwcf44GdDEBE2RRb+Dyp6Ip0a
         KLdij1Un9uRVePJrX1HMNf9Yekoz5dAq/0gqIzVxjKp120PcyWd1L0TcKW3CgKQEj42s
         Q0sWpUQpubgtzC+Bb/FKtws3Vjoi0VERJraIPjMlsEfyfHjHzP+3tqhSQp+LI5S/haY8
         PZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4xI4KhaKApTzyvQaN+vM+hT6fkkMT1iiqHfb2UmIAM=;
        b=8Qujqv7bmcx/yaGAR4IOxVUU4MxYtmhsS1QEMdn6VfvG/XTs/ZpIuxnH0tl4+Yd3E1
         izrgpzc8VUlkIQ/cMIkW6p9qNIt7wJ8nmXz1vmWVle9JUlAp9E4cTt5hnZ0hPDX6g3ht
         qHejIOepNLY+dNZaOEeu35/gkUnVqEU2j21KDERaL/WH1mm0aiLmK3msmRGylIsl9OQb
         V/73ovRlCLRsKCnPtwX1D5xtHRnBxjsB2a2mrd75xPT42+gYBGKHz14+4E+MOKN36W50
         Hpn1cn4fxm7ZkAXa7VvZiPnMgEKTrpq3Ru+YsfNhwkv+U1SiKtFaCSPRs7OmRicYBHKL
         AJcQ==
X-Gm-Message-State: AJIora9kvW4htA60Zk+ut/O2TnV6IlevmzViN1ci/B+mhuOUlH3DoX7h
        eQnYAIMeoKAOu3x1o4hPSqHwjpyzLFg6xpSJe9k=
X-Google-Smtp-Source: AGRyM1twLm3f7WITf7NZ6Pdj0EhnnVMy74bc6IcazbmSfzdoGmcAXA7FZbFh7V8v0+Tsp+4cXsWgOsCiSsMcXD2BAsg=
X-Received: by 2002:a92:d606:0:b0:2dc:e2d1:b75b with SMTP id
 w6-20020a92d606000000b002dce2d1b75bmr8262234ilm.91.1659445567847; Tue, 02 Aug
 2022 06:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-11-davemarchevsky@fb.com> <33123904-5719-9e93-4af2-c7d549221520@fb.com>
In-Reply-To: <33123904-5719-9e93-4af2-c7d549221520@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 2 Aug 2022 15:05:31 +0200
Message-ID: <CAP01T754Hk3C23nYvZPR6oFQYPWVWwoGzDftEsRhXi231Ay2kA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and
 PTR_ITER_END type flags
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Aug 2022 at 00:46, Alexei Starovoitov <ast@fb.com> wrote:
>
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> >       if (__is_pointer_value(false, reg)) {
> > +             if (__is_iter_end(reg) && val == 0) {
> > +                     __mark_reg_const_zero(reg);
> > +                     switch (opcode) {
> > +                     case BPF_JEQ:
> > +                             return 1;
> > +                     case BPF_JNE:
> > +                             return 0;
> > +                     default:
> > +                             return -1;
> > +                     }
> > +             }
>
> as discussed the verifying the loop twice is not safe.
> This needs more advanced verifier hacking.
> Maybe let's postpone rbtree iters for now and resolve all the rest?
> Or do iters with a callback, since that's more or less a clear path fwd?
>

Can you elaborate a bit on what you think the challenges/concerns are
(even just for educational purposes)? I am exploring a similar
approach for one of my use cases.

On Tue, 2 Aug 2022 at 00:46, Alexei Starovoitov <ast@fb.com> wrote:
>
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> >       if (__is_pointer_value(false, reg)) {
> > +             if (__is_iter_end(reg) && val == 0) {
> > +                     __mark_reg_const_zero(reg);
> > +                     switch (opcode) {
> > +                     case BPF_JEQ:
> > +                             return 1;
> > +                     case BPF_JNE:
> > +                             return 0;
> > +                     default:
> > +                             return -1;
> > +                     }
> > +             }
>
> as discussed the verifying the loop twice is not safe.
> This needs more advanced verifier hacking.
> Maybe let's postpone rbtree iters for now and resolve all the rest?
> Or do iters with a callback, since that's more or less a clear path fwd?
>
