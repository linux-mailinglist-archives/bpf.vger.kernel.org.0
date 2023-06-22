Return-Path: <bpf+bounces-3178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679BB73A85D
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F63E281A67
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D57200B8;
	Thu, 22 Jun 2023 18:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37021E536
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 18:40:22 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77681A3;
	Thu, 22 Jun 2023 11:40:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f883420152so5446851e87.1;
        Thu, 22 Jun 2023 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687459218; x=1690051218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgNOmKn8cKbknqRSul61vlPJmFXW+ZDy44yXXLuHMmE=;
        b=LF6TIBO++eDh68rTQsEob9ADZkh5vWI4lpWS7p7KkNb8Hwixmd9V8Mh0/6LZ4KIKqJ
         fc54Yt4ph2fbyZ+CUMZIuwj6R2qS7b8jkhrwodCz33BHYiz0WYSvFltf+ciGZPkPkOUe
         KHr3IFlsduj4SPkn+Y/G6CmOl3EhmAAiszPuqYSJacSUmFHLINQwZInSw8ONXKenEWqf
         lWQ5pPr2weaawY2fQlfKOs4Hbzho0hgpSy0ejywVHsy5GsYP/dRAVSI19gfcwvcbawIG
         XIh7Cw7b/CjkzNw5LXdC25TT0LuYRqAF0hNrNkkj3pa4dkrK9EBmBTtajwUmR6FCUBlj
         VJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459218; x=1690051218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgNOmKn8cKbknqRSul61vlPJmFXW+ZDy44yXXLuHMmE=;
        b=HG/BReE5kR3AViXR5w+fHYBIF4HXf86wmaGpkyvP26Qm44c3pmzSaZKqsDmpkgFh7p
         VrHUh3Ap22N1N5fcXy+NLKqxtcokiTVze+ALQYeul76sN7NR2K5uO0gHmk/oIIiQvGUd
         VFIAULwwtDtOWF007iyaRKhca9tZLEJV7ozH26XUQIpERZBbCtDjijlRDmF/Yb89eGmQ
         FN/iWR87S63DDgN9MRgZ1ySzlzDZIJyIzIWUGrIXz4/BP+BxA9hxtxziwU3jr5FYeSBm
         kf4N+Um66lwGib61xNQbcqesMDkpt9KqVkzKmWBmWCBzzIOTJC6SQgGFCLg07aCV1XqP
         SAiw==
X-Gm-Message-State: AC+VfDw9JzBi/6hk8X6L9yuRXcT7Wo7yHot6NKgIZCLtmQNc3TOuQm6d
	nRfHPSyAh6znp1tc3/bkvlKewR9BsbRUjb0zPVo=
X-Google-Smtp-Source: ACHHUZ5Kgc4f77IyAEBBdaI/JojQJUZH5gkn/+Q4Phbs2WDvF3QWBWeVi1Fk61L7EeStDRs5KP8J9WTyrJPxkydbzx0=
X-Received: by 2002:a19:5e0b:0:b0:4f8:72fd:ed95 with SMTP id
 s11-20020a195e0b000000b004f872fded95mr7130722lfb.22.1687459218246; Thu, 22
 Jun 2023 11:40:18 -0700 (PDT)
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
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
In-Reply-To: <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 11:40:06 -0700
Message-ID: <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Thu, Jun 22, 2023 at 10:38=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com>=
 wrote:
>

Please avoid replying in HTML.

> On 22/06/2023 17:49, Andy Lutomirski wrote:
>
> Apologies for being blunt, but  the token approach to me seems to be a
> work around providing the right level/classification for a pod/container
> in order to say you support unprivileged containers using eBPF. I think
> if your container needs to do privileged things it should have and be
> classified with the right permissions (privileges) to do what it needs
> to do.
>
> Bluntness is great.
>
> I think that this whole level/classification thing is utterly wrong.  Rep=
lace "BPF" with basically anything else, and you'll see how absurd it is.
>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using files on disk"
>
> That's very 1990's.  Maybe 1980's.  Of *course* giving access to a filesy=
stem has some inherent security exposure.  So we can give containers access=
 to *different* filesystems.  Or we can use ACLs.  Or MAC policy.  Or whate=
ver.  We have many solutions, none of which are perfect, and we're doing ok=
ay.
>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using the network"
>
> The network is a big deal.  For some reason, it's cool these days to trea=
t TCP as highly privileged.  You can get secrets from your favorite (or lea=
st favorite) cloud provider with unauthenticated HTTP to a magic IP and por=
t.  You can bypass a whole lot of authenticating/authorizing proxies with u=
nauthenticated HTTP (no TLS!) if you're on the right network.
>
> This is IMO obnoxious, but we deal with it by having network namespaces a=
nd firewalls and rather outdated port <=3D 1024 rules.
>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using BPF"
>
> My response is: what's wrong with BPF?  BPF has maps and programs and suc=
h, and we could easily apply 1990's style ownership and DAC rules to them. =
 I even *wrote the code*.  But for some reason, the BPF community wants to =
bury its head in the sand, pretend it's 1980, declare that BPF is too privi=
leged to have access control, and instead just have a complicated switch to=
 turn it on and off in different contexts.
>
> Please try harder.
>
> I'm going to be honest, I can't tell if we are in agreement or not :). I'=
m also going to use pod and container interchangeably throughout my respons=
e (bear with me)
>
>
> So just to clarify a few things on my end.  When I said "level/classifica=
tion" I meant privileges --> A container should have the right level of pri=
vileges assigned to it for what it's trying to do in the K8s scenario throu=
gh it's pod spec. To me it seems like BPF token is a way to work around the=
 permissions assigned to a container in K8s for example: with bpf_token I'm=
 marking a pod as unprivileged but then under the hood, through another ser=
vice I'm giving it a token to do more than what it was specified in it's po=
d spec. Yeah I have a separate service controlling the tokens but something=
 about it just seems not right (to me). If CAP_BPF is too broad, can we bre=
ak it down further into something more granular. Something that can be assi=
gned to the container through the pod spec rather than a separate service t=
hat seems to be doing things under the hood? This doesn't even start to
solve the problem I know...

Disclaimer: I don't know anything about Kubernetes, so don't expect me
reply with correct terminology or detailed understanding of
configuration of containers.

But on a more generic and conceptual level, it seems like you are
making some implementation assumptions and arguing based on that.

Like, why container spec cannot have native support for "granted BPF
functionality"? Why would BPF token have to be granted through some
separate service and not integrated into whatever Kubernetes'
"container manager" functionality and just be a natural extension of
the spec?

For CAP_BPF too broad. It is broad, yes. If you have good ideas how to
break it down some more -- please propose. But this is all orthogonal,
because the blocking problem is fundamental incompatibility of user
namespaces (and their implied isolation and sandboxing of workloads)
and BPF functionality, which is global by its very nature. The latter
is unavoidable in principle.

No matter how much you break down CAP_BPF, you can't enforce that BPF
program won't interfere with applications in other containers. Or that
it won't "spy" on them. It's just not what BPF can enforce in
principle.

So that comes back down to a question of trust and then controlled
delegation of BPF functionality. You trust workload with BPF usage
because you reviewed the BPF code, workload, testing, etc? Grant BPF
token and let that container use limited subset of BPF. Employ BPF LSM
to further restrict it beyond what BPF token can control.

You cannot trust an application to not do something harmful? You
shouldn't grant it either CAP_BPF in init namespace, nor BPF token in
user namespace. That's it. Pick your poison.

But all this cannot be mechanically decided or enforced. There has to
be some humans involved in making these decisions. Kernel's job is to
provide building blocks to grant and control BPF functionality to the
extent that it is technically possible.


>
> I understand the difficulties with trying to deploy BPF in K8s and the co=
ncerns around privilege escalation for the containers. I understand not all=
 use cases are created equally but I think this falls into at least 2 categ=
ories:
>
> - Pods/Containers that need to do privileged BPF ops but not under a CAP_=
BPF umbrella --> sure we need something for this.
> - Pods/Containers that don't need to do any privileged BPF ops but still =
use BPF --> these are happy with a proxy service loading/unloading the bpf =
progs, creating maps and pinning them... But even in this scenario we need =
something to isolate the pinned maps/progs by different apps (why not DAC r=
ules?), even better if the maps are in the container...

The above doesn't make much sense to me, sorry. If the application is
ok using unprivileged BPF, there is no problem there. They can today
already and there is no BPF proxy or BPF token involved.

As for "something to isolate the pinned maps/progs by different apps
(why not DAC rules?)", there is no such thing, as I've explained
already.

I can install sched_switch raw_tracepoint BPF program (if I'm allowed
to), and that program has system-wide observability. It cannot be
bound to an application. You can't just say "trigger this sched_switch
program only for scheduler decisions within my container". When you
actually start thinking about just that one example, even assuming we
add some per-container filter in the kernel to not trigger your
program, then what do we do when we switch from process A in container
X to process B in container Y? Is that event belonging to container X?
Or container Y? How can you prevent a program from reading a task's
data that doesn't belong to your container, when both are inputs to
this single tracepoint event?

Hopefully you can see where I'm going with this. And this is just one
random tiny example. We can think up tons of other cases to prove BPF
is not isolatable to any sort of "container".

>
> Anyway - I hope this clarifies my original intent - which is proxy at lea=
st starts to solve one part of the puzzle. Whatever approach(es) we take to=
 solve the rest of these problems the more we can stick to tried and truste=
d mechanisms the better.

I disagree. BPF proxy complicates logistics, operations, and developer
experience, without resolving the issue of determining trust and the
need to delegate or proxy BPF functionality.

