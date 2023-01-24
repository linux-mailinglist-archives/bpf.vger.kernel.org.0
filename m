Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867E7679FF1
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjAXRR1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 12:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjAXRRZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 12:17:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAB4CE46
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:17:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id az20so40955889ejc.1
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1H6jtEPJJHC2ZJkbfQQZk5FIlfKQ58clKHcYIWaRHY=;
        b=ghxO/vhdM15ZoreKxXSZv22syVyjY6JKbo/oV4SgnOcYI6KQpU+BEmwDWiLhGmIw10
         Qyc2xoi5HlQHVP3zQjwwYt3ipaj3yHE2dGfrHszk0G7ZzpbWwIA4rL7qQooA6eXW6tOD
         v+iP1ht9TC7EqbhlA3hwcoXyXZWLNlNbf/fTI648bS6+U9VZkd+vwBraUrcqHMs6UbT+
         HtBRN+HCcAstcwdzUiOVcAY7CdFDKSoqvu9GeYbex3oSmFd5AF7cdh5JKeI7wpmGwGWb
         dGC81gpTeumxKCzeQb4EIUKD0cNd1ojrXiHT6k2+Zd5d5Hn0WTKcBzakTK3cRgjKpOpM
         uTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1H6jtEPJJHC2ZJkbfQQZk5FIlfKQ58clKHcYIWaRHY=;
        b=Yuf4myiJ586q4eSwGFCG/+W2uNHnueJkH9hBsq1cCUWAj7en2hoL4YwKLSkGmR/IYv
         P8G1Zn9HSH1Kn7ULJoduOZRgfeoNFqdl2oQmqupGXPhky7koxXeUT44tWqcX2U+K+D2l
         tX610M8mIWjiCwwJOkWtmJGxFgnTbQqMSeg9ZaFvrm1hYooybr4N/4Go3QSH9xxNOSoq
         X3vWHltTfcbmwAkMZMHQlgnkg+hw9MgZByK1ldEfMg3pF0pJm2IPXy02M5O98Qon7HT3
         tprbWjdduKElKHWqKM4cjDNaPQcKleYNFJjeDDmdFzHE+4JaUQV0G0zuvtJY3/esAEkH
         qE5A==
X-Gm-Message-State: AFqh2kpT+ciYPFWzrrA0bWLMFyN0hRzSYKptHFI4pGCyeOxKpAOdjNvV
        EtSU34MzU9HK2dsoUk+n0yAYxxelJ6blMVF/nL8=
X-Google-Smtp-Source: AMrXdXugoLv8TeZQCKPUgxLhwfEftJm9hTYlm8FOTKE6d80Ul4WfynlTOroXEKQdGCpDDOvPwxvET/eJ7h8gxH3W/cA=
X-Received: by 2002:a17:906:b106:b0:86d:d78d:61a5 with SMTP id
 u6-20020a170906b10600b0086dd78d61a5mr3082060ejy.253.1674580639409; Tue, 24
 Jan 2023 09:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk> <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net> <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
In-Reply-To: <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 Jan 2023 09:17:07 -0800
Message-ID: <CAEf4BzbAt_Yp-GkAr3Ov4x_v2cawzuJXC5ux4NA-FZ2rv6PCAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Wed, Jan 18, 2023 at 8:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 11:48:59AM +0100, Daniel Borkmann wrote:
> >
> > My $0.02 is that I don't think we need to make a hard-cut ban as part of this.
>
> The hard-cut is easier to enforce otherwise every developer will be arguing that
> their new feature is special and it requires a new discussion.
> This thread has been going for too long. We need to finish it now and
> don't come back to it again every now and then.

I wish that we could grant exception at least to complete dynptr
basics (bpf_dynptr_is_null, bpf_dynptr_get_size,
bpf_dynptr_{clone,trim,advance}) so that it is consistently provided
as a unified set of helpers. Similarly, for open coded loop iterator
(3 helpers), I believe it would be better for BPF ecosystem overall to
work on any BPF-enabled architecture and configuration (no matter JIT
or not, BTF of not, etc), just due to generality and unassuming nature
of this functionality.

But it is what it is, let's move on.

>
> imo this is the summary of the thread:
>
> bpf folks fall into two categories: kernel maintainers and bpf developers/users.
> - developers add new bpf features. They obviously want to use them and want bpf users
> to know that the feature they added is not going to disappear in the next kernel.
> They want stability.
> - maintainers want to make sure that the kernel development doesn't suffer because
> developers keep adding new apis. They want freedom to innovate and change apis.
> Maintainers also know that developers make mistakes and might leave the community.
> The kernel is huge and core infra changes all the time.
> bpf apis must never be a reason not to change something in the kernel.
>
> Freedom to change and stability just don't overlap.
> These two camps can never agree on what is more important.
> But we can make them co-exist.
>
> The bpf developers adding new kfunc should assume that it's stable and proceed
> to use it in bpf progs and production applications.

It's unclear what this means for library developers (libbpf, libxdp,
and others), but I guess we'll find out with time.

> The bpf maintainers will keep this stability promise. They obviously will not
> reap it out of the kernel on the whim, but they will nuke it if this kfunc
> will be in the way of the kernel innovation.
> The longer the kfunc is present the harder it will be for maintainers to justify
> removing it. The developers have to stick around and demonstrate that their
> kfunc is actually being used. The better developers do it the bigger the effort
> maintainers will put into keeping the kfunc perfectly intact.
>

[...]

>
> > The 'All new BPF kernel helper-like functionality must initially start out as
> > kfuncs.' is pretty clear where things would need to start out with, and we could
> > leave the option on the table if really needed to go BPF helper route when
> > promoting kfunc to stable at the same time. I had that in the text suggestion
> > earlier, it's more corner case and maybe we'll never need it but we also don't
> > drive ourselves into a corner where we close the door on it. Lets let the infra
> > around kfuncs evolve further first.
>
> Going kfunc->helper for stability was discussed already. It probably got lost
> in the noise. The summary was that it's not an option for the following reason:
> kfuncs and helpers are done through different mechanisms on prog and kernel side.
> The prog either sees = (void *)1 hack or normal call to extern func.
> The generated code is different.
> Say, we convert a kfunc to helper. Immediately the existing bpf prog that uses
> that kfunc will fail to load. That's the opposite of stability.
> We're going to require the developer to demonstrate the real world use of kfunc
> before promoting to stable, but with such 'promotion' we will break bpf progs.
> Say, we keep kfunc and introduce a new helper that does exactly the same.
> But it won't help bpf prog. The prog was using kfunc in production,
> why would it do some kind of CO-RE thing to compile 'call foo' differently
> depending whether 'foo' is kfunc or helper in the given kernel. And so on.

Correct. If we'd anticipated promotion of kfunc to helper (but it
doesn't seem like we do), we'd need to have kfunc with a different
name from its corresponding helper's name to avoid massive pain for
users. So if we were to add bpf_dynptr_is_null() as kfunc with an eye
for it to be stabilized as helper, I'd vote to add it as something
like bpf_kf_dynptr_is_null() or something, and then eventually add
bpf_dynptr_is_null(). That will at least less painful abstraction in
user's BPF code (and libbpf's helpers, if any).
