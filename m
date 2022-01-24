Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB09A49815C
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiAXNtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiAXNtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 08:49:01 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AFC06173B;
        Mon, 24 Jan 2022 05:49:01 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id l196so7291195vki.5;
        Mon, 24 Jan 2022 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aj38IaVnXYx+x1A1doARypfeAoVaF/taRd19BcR4B6I=;
        b=d69Pyyt1Tzm4Aq+3vXx6tSt7Tuq+aXARucnUglPjz4hMkFlOsN3PlnYUJv4tA/dNsB
         CdqypmoiZnP/F6bGJrR9LgUXVUDjXLJozC8aEQv8iagHEGIr/JILFJaNwWXUJxLOK+QQ
         dKHOIBRwmgNCy5zuf8DvDcDUGx7tzaG1HGaqBMXxYto5kctG85iLZLo7kESLbnqOVQEM
         gi3WGwUiqA4bkr7E9gaJI8CEnNoI6oPnFzRvcjiiHDO4/9/qdB5o3UtTEIuEvjjfdPmA
         JP6LzgnPE6tGA9bR2M/Rd1AmdasCq++FX1YGn2l9Qr33kRR4PKW7ZxBVh3n3bhenntBK
         LdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aj38IaVnXYx+x1A1doARypfeAoVaF/taRd19BcR4B6I=;
        b=Anm6J/32PyHLEhMRpl5N7CqlVf8uESRUUwzwgXIVhjyC6MXUoKCVUXsVEU7SG0MkX0
         GT4dqHpj6whna4viaoL9QtsCUYZwiP0EdrjKZgHUqtMqnqWYj5cARoGedLzQ8RMjp5hv
         OfBfy6ir4FOyRap/NyjQzXxLVRiRn8V2NLTVuTJopHPp0rJtypvOz6bLAyXcInZ5gBfJ
         ZSmm8A4TGtVNOwzzPXsRPuvggXyFVh8NOun+8j9ht6afCLydVBrAcue/1TjEezRjvva6
         KSvbTpTSaJKAWjwJI/q0GfgtYLWAO/jqVWtnicgEYK/3kBhdSvKJMNPgtQV+7kMF+p0S
         UUWg==
X-Gm-Message-State: AOAM5307ekuMq61D75SIQy/j6TtZ9Bqtq1nEhD6XnmkDhP2uXJT1Tito
        VNlWhG4qDk5eIddbz0OsRlAFeGIejAPE01nR4LQ=
X-Google-Smtp-Source: ABdhPJyOr+/HJHNM133NyMbAoYF5br8Wo1udUq6zf/saWTMRp7kDRPx7a3CljS30+L4KC6pvbG2HZlp+PyCW+8Kj9kA=
X-Received: by 2002:a05:6122:7d3:: with SMTP id l19mr5385227vkr.34.1643032140554;
 Mon, 24 Jan 2022 05:49:00 -0800 (PST)
MIME-Version: 1.0
References: <87o85ftc3p.fsf@smart-cactus.org> <CAADnVQ++57u30cdooEqXSDVGEgKTy70TChg8+2h8mihHbwdpOg@mail.gmail.com>
 <CAP-5=fVSSGa3dyg64GYN=-PDmj1aUa8pR0U71FMoZ6U_6Mu0+w@mail.gmail.com>
In-Reply-To: <CAP-5=fVSSGa3dyg64GYN=-PDmj1aUa8pR0U71FMoZ6U_6Mu0+w@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Mon, 24 Jan 2022 13:48:49 +0000
Message-ID: <CAGnuNNuQm27sy4SKBkMoM5FE2F6QawPATW0c30nXmz3xyXfzkQ@mail.gmail.com>
Subject: Re: Sampling of non-C-like stacks with eBPF and perf_events?
To:     Ian Rogers <irogers@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ben Gamari <ben@smart-cactus.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just FYI I have plans to make a BPF variant of Austin
(https://github.com/P403n1x87/austin) as an alternative to the
ptrace-based austinp variant
(https://github.com/P403n1x87/austin#native-frame-stack). This will
then do what pyperf does, plus all of Austin's other features, like GC
sampling etc...

On Mon, 24 Jan 2022 at 12:50, Ian Rogers <irogers@google.com> wrote:
>
> Hi Alexei and Ben,
>
> This sounds awesome! Somewhat off-topic, I wonder if we could include
> the pyperf and ghc support in regular perf? I think there is an
> assumption that these languages are a minority concern, but I think
> everyone would benefit from being packaged with perf, being kept in
> sync with how the APIs evolve, code reuse, etc.
>
> Thanks,
> Ian
>
> On Fri, Jan 21, 2022 at 4:05 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 17, 2021 at 1:53 PM Ben Gamari <ben@smart-cactus.org> wrote=
:
> > >
> > > Hi all,
> > >
> > > I have recently been exploring the possibility of using a
> > > BPF_PROG_TYPE_PERF_EVENT program to implement stack sampling for
> > > languages which do not use the platform's %sp for their stack pointer
> > > (in my case, GHC/Haskell [1], which on x86-64 uses %rbp for its stack
> > > pointer). Specifically, the idea is to use a sampling perf_events
> > > session with an eBPF overflow handler which locates the
> > > currently-running thread's stack and records it in the sample ringbuf=
fer
> > > (see [2] for my current attempt). At this point I only care about
> > > user-space samples.
> > >
> > > However, I quickly ran up against the fact that perf_event's stack
> > > sampling logic (namely perf_output_sample_ustack) is called from an I=
RQ
> > > context. This appears to preclude use of a sleepable BPF program, whi=
ch
> > > would be necessary to use bpf_copy_from_user. Indeed, the fact that t=
he
> > > usual stack sampling logic uses copy_from_user_inatomic rather than
> > > copy_from_user suggests that this isn't a safe context for sleeping.
> > >
> > > So, I'm at this point a bit unclear on how to proceed. I can see a fe=
w
> > > possible directions forward, although none are particularly enticing:
> > >
> > > * Add a bpf_copy_from_user_atomic helper, which can be called from a
> > >   non-sleepable context like a perf_events overflow handler. This wou=
ld
> > >   take the same set_fs() and pagefault_disable() precautions as
> > >   perf_output_sample_ustack to ensure that the access is safe and abo=
rts
> > >   on fault.
> > >
> > > * Introduce a new BPF program type,
> > >   BPF_PROG_TYPE_PERF_EVENT_STACK_LOCATOR, which can be invoked by
> > >   perf_output_sample_ustack to locate the stack to be sampled.
> > >
> > > Do either of these ideas sound upstreamable? Perhaps there are other
> > > ideas on how to attack this general problem? I do not believe Haskell=
 is
> > > alone in its struggle with the current inflexibility of stack samplin=
g;
> > > the JVM introduced framepointer support specifically to allow callgra=
ph
> > > sampling; however, dedicating a register and code to this seems like =
an
> > > unfortunate compromise, especially on x86-64 where registers are alre=
ady
> > > fairly precious.
> > >
> > > Any thoughts or suggestions would be greatly appreciated.
> >
> > Hi Ben,
> >
> > if you're sampling the stack trace of the current process
> > there is no need for copy_from_user and sleepable.
> > The memory with the stack trace unlikely was paged out.
> > So normal bpf_probe_read_user() will work fine.
> >
> > This approach was used to implement 'pyperf'.
> > It walks python stack traces:
> > https://github.com/iovisor/bcc/tree/master/examples/cpp/pyperf
> > What you're trying to do for haskel sounds very similar.



--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
