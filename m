Return-Path: <bpf+bounces-3505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2673EEAB
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C8B280EF7
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260815499;
	Mon, 26 Jun 2023 22:31:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154B1642E
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:31:46 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8EC12D;
	Mon, 26 Jun 2023 15:31:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3110ab7110aso4636373f8f.3;
        Mon, 26 Jun 2023 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687818702; x=1690410702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgMGl5xtwMKvXZ1jFYLYB16WOQYwbh2OhBejAzo/b4c=;
        b=QrFSPDdRHJ9+As+IaqiDXmvkNjSlaSS6o3TGfGw3T9h2XngCyBBlW9I/JdbeF9uGuT
         835JQ/NoWKVW4Hn51Oos4lvbGtU5lDBBolx4Kog5pAmKeEt/LVJsJ+OrO1yeNBJyKbnh
         EnavYf7Lqra6y6uRtnSyRlPb3LT/ASFOBbFqyAGsvkXUWEUkj6HzMDm4tKdlhhQ8Na/K
         GtJn9t0NMRxOTz2rtlE2T7T9exdQlG26QPYwsbRAFjpjQ3m7ECGtkSex6bk2lJ29/UMo
         G0qnN3nvU0nn8YqQqhL/DYARzrM+Z3Fv+Vph/Uu9sOybq1U1YR/AluawVp52ggDf2vRJ
         Kuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687818702; x=1690410702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgMGl5xtwMKvXZ1jFYLYB16WOQYwbh2OhBejAzo/b4c=;
        b=jGYgnzDupmf9PNYyzA+o5n78etGO88xcyTisiylflHwxhpsrwy/fle3lwOxVT9lYX3
         pBgpOxDcBjanvLvzNrS31md789AL91IeN1rRrjp+1nNaodRFnT/EGxrLdkeG7/uIs63p
         XjV1QYYaqf7Qu6bp1oKGrIukc0S7f0/spmzw/ASYorMj63v77UnKaJqpqqMXL0RTWvHj
         gR030Vvj4XFFpc2hyL3TElt7C5xfyxvgNNGwYyaC9HdzhPrDyGhEjXgUt2PjpkbJKpcE
         BoMdBIXq35tUwoXfhEgBR5wF7vDg0RA31JQ6n0NUfe2HZe10dcX3QgsJmdH/YrCfQDo0
         3Yiw==
X-Gm-Message-State: AC+VfDzHaDLSo+mz2L0P8jwn8ZfN05f9w4Jue3IYjVBsC6mSw8Q9x6ZO
	1dzzKHdaxLq9xOu2LBDIl+BgaSOn6G/NcWvC/nU=
X-Google-Smtp-Source: ACHHUZ5oZ85u5w2uz18xvTYKrsPKR1g9hJXa4NKFoKMHz5WEJCPEj+1jUX7Z9eHqkZuJ0sfXVr8V9sIMXM5P6A33iBo=
X-Received: by 2002:adf:fb04:0:b0:30f:bb81:d056 with SMTP id
 c4-20020adffb04000000b0030fbb81d056mr21886696wrr.60.1687818702436; Mon, 26
 Jun 2023 15:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com> <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com> <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com> <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net> <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
In-Reply-To: <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 15:31:30 -0700
Message-ID: <CAEf4BzY5UWLCjDiQ_pfCeKMVJScdk7B4ZaKwi=yaf8ACnaOXLg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Maryam Tahhan <mtahhan@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, lennart@poettering.net, cyphar@cyphar.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 7:00=E2=80=AFAM Andy Lutomirski <luto@kernel.org> w=
rote:
>
>
>
> On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:
> > On 6/23/23 5:10 PM, Andy Lutomirski wrote:
> >> On Thu, Jun 22, 2023, at 6:02 PM, Andy Lutomirski wrote:
> >>> On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
> >>>
> >>>> Hopefully you can see where I'm going with this. And this is just on=
e
> >>>> random tiny example. We can think up tons of other cases to prove BP=
F
> >>>> is not isolatable to any sort of "container".
> >>>
> >>> No.  You have not come up with an example of why BPF is not isolatabl=
e
> >>> to a container.  You have come up with an example of why binding to a
> >>> sched_switch raw tracepoint does not make sense in a container withou=
t
> >>> additional mechanisms to give it well defined functionality and
> >>> appropriate security.
> >
> > One big blocker for the case of BPF is not isolatable to a container ar=
e
> > CPU hardware bugs. There has been plenty of mitigation effort so that t=
he
> > flexibility cannot be abused as a tool e.g. discussed in [0], but ultim=
ately
> > it's a cat and mouse game and vendors are also not really transparent. =
So
> > actual reasonable discussion can be resumed once CPU vendors gets their
> > stuff fixed.
> >
> >    [0]
> > https://popl22.sigplan.org/details/prisc-2022-papers/11/BPF-and-Spectre=
-Mitigating-transient-execution-attacks
> >
>
> By this standard, shouldn=E2=80=99t we just give up?  Let everyone map /d=
ev/mem readonly and stop pretending we can implement any form of access con=
trol.
>
> Of course, we don=E2=80=99t do this. We try pretty hard to squash bugs an=
d keep programs from doing an end run around OS security.
>
> >> Thinking about this some more:
> >>
> >> Suppose the goal is to allow a workload in a container to monitor itse=
lf by attaching to a tracepoint (something in the scheduler, for example). =
 The workload is in the container.  The tracepoint is global.  Kernel memor=
y is global unless something that is trusted and understands the containers=
 is doing the reading.  And proxying BPF is a mess.
> >
> > Agree that proxy is a mess for various reasons stated earlier.
> >
> >> So here are a couple of possible solutions:
> >>
> >> (a) Improve BPF maps a bit so that BPF maps work well in containers.  =
It should be possible to create a map and share it (the file descriptor!) b=
etween the outside and the container without running into various snags.  (=
IIRC my patch series was a decent step in this direction,)  Now load the BP=
F program and attach it to the tracepoint outside the container but have it=
 write its gathered data to the map that's in the container.  So you end up=
 with a daemon outside the container that gets a request like "help me moni=
tor such-and-such by running BPF program such-and-such (where the BPF progr=
am code presumably comes from a library outside the container", and the dae=
mon arranges for the requesting container to have access to the map it need=
s to get the data.
> >
> > I don't think it's very practical, meaning the vast majority of applica=
tions
> > out there today are tightly coupled BPF code + user space application, =
and in
> > a lot of cases programs are dynamically created. This would require som=
ehow
> > splitting up parts of your application to run outside the container in =
hostns
> > and other parts inside the container.. for the sake of the mentioned ex=
ample
> > it's something fairly static, but real-world applications look differen=
t and
> > are much more complex.
> >
>
> It sounds like you are describing a situation where there is a workload i=
n a container, where the *entire container* is part of the TCB, but the par=
t of the workload that has the explicit right to read all of kernel memory =
(e.g. bpf_probe_read_kernel) is so tightly coupled to the container that no=
 one outside the container wants to audit it.
>
> And yet someone still wants to run it in a userns.
>

Yes, to get all the other benefits of userns. Yes, BPF isolation
cannot be enforced and we rely on a human-driven process to decide
whether it's ok to run BPF inside each specific container. But why
can't we also get all the other benefits of userns outside of BPF
usage.

BPF parts are critical for such applications, but they also normally
have a huge user-space part, and use large common libraries, so there
is a lot of benefit to having as much userns-provided isolation as
possible.


> This is IMO a rather bizarre situation.
>
> If I were operating a large fleet, and I had teams developing software to=
 run in a container, I would not want to grant those containers this right =
without strict controls, and I don=E2=80=99t mean on/off controls. I would =
want strict auditing of *what exact BPF code* (including source) was run, a=
nd why, and who wrote it, and what the intended results are, and what limit=
s access to the results, etc.  After all, we=E2=80=99re talking about the r=
ight, BY DESIGN, to access PII, payment card information, medical informati=
on, information protected by any jurisdiction=E2=80=99s data control rights=
, etc. Literally everything.  This ability, as described, isn=E2=80=99t =E2=
=80=9Cthe right to use BPF.=E2=80=9D  It is the right to *read all secrets*=
, intentionally.  (And modify them, with bpf_probe_write_user, possibly sub=
ject to some constraints.)

What makes you think this is not how it's actually done in practice
already (except right now we don't have BPF token, so it's
all-or-nothin, userns or not, root or not, which is overall worse than
what we'll get with BPF token + userns)?

Audit, code review, proper development practices. Then discussions and
reviews between team running container manager and team with BPF-based
workload to make decisions whether it's safe to allow BPF access (and
to what degree) and how teams will maintain privacy and safety
obligations.


>
>
> If this series was about passing a =E2=80=9Cmay load kernel modules=E2=80=
=9D token around, I think it would get an extremely chilly reception, even =
though we have module signatures.  I don=E2=80=99t see anything about BPF t=
hat makes BPF tokens more reasonable unless a real security model is develo=
ped first.

If we had dozens of teams developing and loading/unloading their
custom kernel modules all the time, it might not have sounded so
ridiculous?

>
> >> (b) Make a way to pass a pre-approved program into a container.  So a =
daemon outside loads the program and does some new magic to say "make an fd=
 that can beused to attach this particular program to this particular trace=
point" and pass that into the container.
> >
> > Same as above. Programs are in most cases very tightly coupled to the
> > application
> > itself. I'm not sure if the ask is to redesign/implement all the
> > existing user
> > space infra.
> >
> >> I think (a) is better.  In particular, if you have a workload with man=
y containers, and they all want to monitor the same tracepoint as it relate=
s to their container, you will get much better performance if a single BPF =
program does the monitoring and sends the data out to each container as nee=
ded instead of having one copy of the program per container.
> >>
> >> For what it's worth, BPF tokens seem like they'll have the same perfor=
mance problem -- without coordination, you can end up with N containers gen=
erating N hooks all targeting the same global resource, resulting in overhe=
ad that scales linearly with the number of containers.
> >
> > Worst case, sure, but it's not the point. These containers which would
> > receive
> > the tokens are part of your trusted compute base.. so its up to the
> > specific
> > applications and their surrounding infrastructure with regards to what
> > problem
> > they solve where and approved by operators/platform engs to deploy in
> > your cluster.
> > I don't particularly see that there's a performance problem. Andrii
> > specifically
> > mentioned /trusted unprivileged applications/.

Yep, performance is not why this is being done.

> >
> >> And, again, I'm not an XDP expert, but if you have one NIC, and you at=
tach N XDP programs to it, and each one is inspecting packets and sending s=
ome to one particular container's AF_XDP socket, you are not going to get g=
ood performance.  You want *one* XDP program fanning the packets out to the=
 relevant containers.
> >>
> >> If this is hard right now, perhaps you could add new kernel mechanisms=
 as needed to improve the situation.
> >>
> >> --Andy
> >>

