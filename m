Return-Path: <bpf+bounces-3501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949EF73EE65
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED09280E35
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94315AE1;
	Mon, 26 Jun 2023 22:08:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823415AC5
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 22:08:59 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F63C00;
	Mon, 26 Jun 2023 15:08:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9b0f139feso53384405e9.3;
        Mon, 26 Jun 2023 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687817334; x=1690409334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pie2BR0RZlocTFwDH7xiMxbIV/j8++CJbN95WHJ3210=;
        b=nHATfCg4JeFPL2nwc6PTC7yvBoNLv0g6D8/rlf8X9Z5CWTs7v8JxhvrHhI32puI+V9
         l+zXh6HKqW0RvIPDWXH0Reb6yTHj1+gQ/OT2wm4EBjDAKmA8Yei8Z9qeDDMjqMtOF8kp
         F5PQKrNBLqkMOpw6hBbzQIzPf11Fr4BCwIeu+rmW91S9pRdAt5c5IFXiRvuJ3PKKN3KB
         z+m1O58vnIKZjnmoQcceyEUjlOiNadlUYZfampxRUes8jaP4kFuLb6GczrXznpARDn3l
         QgMyVZcOm844ZKN0N8RIrmzcFexRZz6FeHFl6oqc1S5zZ57TxAffezgGiFASnVOFMDsN
         rxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817334; x=1690409334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pie2BR0RZlocTFwDH7xiMxbIV/j8++CJbN95WHJ3210=;
        b=McfaKbinupJXe+OSpWpgr1skAyj1H000/njpeL1OyFJEKA0QXAPT44DibtVS4A7j+p
         7za/bHuC+dfDPmvCn5ZKwcT/Npw0ouFWRRnvdj1UhCanLt0adHATSeXOF69xmXgTOqco
         mevD0vn371X1nKoH3+XSK1M6wdoG5lyeg994TV9EAR+aAsTSbCmLJd2VPjEi8+H/LE9R
         8gzJiEtt2S+Pwl8FWgAiFbns+X1ytBko6WRSaWMYLMnCIlH9Lomtf0MuWMnZkAf+214I
         kbmryvpf6qo61qQkAxiqkHG0ldhVwRbUJWF7hosBrmRxd25wEG1OdLdFL4F0sU0BZN9B
         cwiA==
X-Gm-Message-State: AC+VfDza53E9t5qnh3mQuwkYfgmpSPJ35rBkioZew6j4FGq7kBmpZ2g3
	oRksj2HbbcLexTuWYNvS3ZYWxpj63xT+sZ6AZvsV18OOjPs=
X-Google-Smtp-Source: ACHHUZ5RzmoIfh4GMa3viOj81/FjCkIQldQudO6j7GuG/CQvZyvvi6rH10FGecSCy3K8Q3qA6ly6j5Re2ZS1DJqwM1A=
X-Received: by 2002:a7b:ce8d:0:b0:3fb:40ff:1cba with SMTP id
 q13-20020a7bce8d000000b003fb40ff1cbamr1289097wmj.6.1687817333816; Mon, 26 Jun
 2023 15:08:53 -0700 (PDT)
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
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
In-Reply-To: <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 15:08:41 -0700
Message-ID: <CAEf4BzbwZ0uxfNjDcJspuzhTh3MUDBn_BYen-mNhkrGK7pA_Tg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Maryam Tahhan <mtahhan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Thu, Jun 22, 2023 at 6:03=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
>
>
> On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
> > On Thu, Jun 22, 2023 at 10:38=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.=
com> wrote:
> >
> > For CAP_BPF too broad. It is broad, yes. If you have good ideas how to
> > break it down some more -- please propose. But this is all orthogonal,
> > because the blocking problem is fundamental incompatibility of user
> > namespaces (and their implied isolation and sandboxing of workloads)
> > and BPF functionality, which is global by its very nature. The latter
> > is unavoidable in principle.
>
> How, exactly, is BPF global by its very nature?
>
> The *implementation* has some issues with globalness.  Much of it should =
be fixable.
>

bpf_probe_read_kernel() is widely used and required for real-world
applications. It's global by its nature and in principle not
restrictable. We can say that we'll just disable applications that use
bpf_probe_read_kernel(), but the goal is to enable applications that
are *practically useful*, not just some restricted set of programs
that are provably contained.

> >
> > No matter how much you break down CAP_BPF, you can't enforce that BPF
> > program won't interfere with applications in other containers. Or that
> > it won't "spy" on them. It's just not what BPF can enforce in
> > principle.
>
> The WHOLE POINT of the verifier is to attempt to constrain what BPF progr=
ams can and can't do.  There are bugs -- I get that.  There are helper func=
tions that are fundamentally global.  But, in the absence of verifier bugs,=
 BPF has actual boundaries to its functionality.

looking at your other replies, I think you realized yourself that
there are valid use cases where it's impossible to statically validate
boundaries

>
> >
> > So that comes back down to a question of trust and then controlled
> > delegation of BPF functionality. You trust workload with BPF usage
> > because you reviewed the BPF code, workload, testing, etc? Grant BPF
> > token and let that container use limited subset of BPF. Employ BPF LSM
> > to further restrict it beyond what BPF token can control.
> >
> > You cannot trust an application to not do something harmful? You
> > shouldn't grant it either CAP_BPF in init namespace, nor BPF token in
> > user namespace. That's it. Pick your poison.
>
> I think what's lost here is hardening vs restricting intended functionali=
ty.
>
> We have access control to restrict intended functionality.  We have other=
 (and generally fairly ad-hoc and awkward) ways to flip off functionality b=
ecause we want to reduce exposure to any bugs in it.
>
> BPF needs hardening -- this is well established.  Right now, this is acco=
mplished by restricting it to global root (effectively).  It should have ac=
cess controls, too, but it doesn't.
>
> >
> > But all this cannot be mechanically decided or enforced. There has to
> > be some humans involved in making these decisions. Kernel's job is to
> > provide building blocks to grant and control BPF functionality to the
> > extent that it is technically possible.
> >
>
> Exactly.  And it DOES NOT.  bpf maps, etc do not have sensible access con=
trols.  Things that should not be global are global.  I'm saying the kernel=
 should fix THAT.  Once it's in a state that it's at least credible to allo=
w BPF in a user namespace, than come up with a way to allow it.
>
> > As for "something to isolate the pinned maps/progs by different apps
> > (why not DAC rules?)", there is no such thing, as I've explained
> > already.
> >
> > I can install sched_switch raw_tracepoint BPF program (if I'm allowed
> > to), and that program has system-wide observability. It cannot be
> > bound to an application.
>
> Great, a real example!
>
> Either:
>
> (a) don't run this in a container.  Have a service for the container to r=
equest the help of this program.
>
> (b) have a way to have root approve a particular program and expose *that=
* program to the container, and let the program have its own access control=
s internally (e.g. only output info that belongs to that container).
>
> > then what do we do when we switch from process A in container
> > X to process B in container Y? Is that event belonging to container X?
> > Or container Y?
>
> I don't know, but you had better answer this question before you run this=
 thing in a container, not just for security but for basic functionality.  =
If you haven't defined what your program is even supposed to do in a contai=
ner, don't run it there.

I think you are missing the point I'm making. A specific BPF program
that will use sched_switch is doing correct and right thing (for
whatever that means in a specific case). We as humans designed,
implemented, validated, reviewed it and are confident enough (as much
as we can be with software) that it does the right thing. It doesn't
try to spy on things, doesn't try to disrupt things.

We know this as humans thanks to our internal development process.

But this is not *provable* in a mechanical sense such that the kernel
can validate and enforce this. And yet it's a practically useful
application which we'd like to be able to launch from inside the
container without rearchitecting and rewriting the entire world and
proxying everything through some external root service.

>
>
> > Hopefully you can see where I'm going with this. And this is just one
> > random tiny example. We can think up tons of other cases to prove BPF
> > is not isolatable to any sort of "container".
>
> No.  You have not come up with an example of why BPF is not isolatable to=
 a container.  You have come up with an example of why binding to a sched_s=
witch raw tracepoint does not make sense in a container without additional =
mechanisms to give it well defined functionality and appropriate security.
>
> Please stop conflating BPF (programs, maps, etc) with *attachments* of BP=
F programs to systemwide things.  They're both under the BPF umbrella.  The=
y're not the same thing.

I'm not conflating things. Thinking about BPF maps and BPF programs in
isolation from them being attached somewhere in the kernel and doing
actual and useful work is not useful.

It's the end-to-end functionality including attaching and running BPF
programs is what matters.

Pedantically drawing the line at the BPF program load step and saying
"this is BPF and everything else is not BPF" isn't really helpful. No
one cares about just loading and validating BPF programs. Developers
care about attaching and running them, that's what it all is about.

>
> Passing a token into a container that allow that container to do things l=
ike loading its own programs *and attaching them to raw tracepoints* is IMO=
 a complete nonstarter.  It makes no sense.

