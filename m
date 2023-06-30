Return-Path: <bpf+bounces-3823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B738D744230
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CF61C20C21
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11A174F5;
	Fri, 30 Jun 2023 18:26:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FB17724
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 18:26:13 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06CE6D;
	Fri, 30 Jun 2023 11:26:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso13744255e9.0;
        Fri, 30 Jun 2023 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688149569; x=1690741569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0/zmvnlJpKZvIlARruFlWqAvW3j+7Mk1XD4qXsyrNc=;
        b=DLGnBpaeFI4fxdiV0KU/e0FFgaj90KX3aPOc5uigGbGTfH1VxbfDDUT6KTRjK0wyul
         9SErluf2vGs/ufGcdRM1YJYq/bIxOaJNRhFcqoDNMUQium38Do2ijXgC/1GwYyYIMyfp
         5ut5agBv+8h+BTc7SIZWAOq1dv/2r1eV/RJe9Y94X9qQS9wl5IxaSEmVJ+iZO22p7hLk
         VHXJhTwSvUsnI/KKVhzQyiLNTQC1PXmN8Yo6AyF/+tKy/fOq5bVec3tQ3hYfFRqSAUk0
         gHyVzX+7GDxaIZt606ME23x+Mt78sQZR3AzOcjmRopXwWlOvzA0o6CxaKJ3OJhcobdeS
         3YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149569; x=1690741569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0/zmvnlJpKZvIlARruFlWqAvW3j+7Mk1XD4qXsyrNc=;
        b=ZOqKr2Q3OK7yLodtua0qCrhVhFFZB/8EIJbM3UmVOXLPPZfF13hbaFUv4g80VouCXI
         m0lXAYmwbP/WcFVRu0QCtMP0Ih1Q5jATCy0v9Fw/lbct96VLjG66jlnCD6bzvKWeOTHW
         3hGAhrRVIQb766goguWDkNxcaU4o0Xz5ryLY45aH4A3bAYgzhIOa0x45Rba5EbsuP0j5
         Kb7Yqq68Ov7pi4Ofs6IE6Jhn7+Sli/mcQK34cb+f1isRDwlSj9EozZ+uXL1gW6Xq3reG
         iDA3TJy8NpJoMdSjC+86ahbfZ9TJLtCKvScDk+XTxvfKsDeBRZsZTXr34UuDvLZbFQPe
         TudQ==
X-Gm-Message-State: AC+VfDzKxKNQZl/GOSHryLP4fFMkV+GFZl39wKyr4VBku+uL20FTj9pz
	rWseG9vNcsVjBqI9DRIWNy226YpAxrKnyJwoG6Y=
X-Google-Smtp-Source: ACHHUZ5d/p4U2j+7/17VdCqKib1W+VbV2RQ3G7qjC6xnks/PsRoJeh+58coaKa02pFLZpgVeR2iDAq7k6aFPTG9hBeI=
X-Received: by 2002:a1c:770d:0:b0:3fb:a506:5656 with SMTP id
 t13-20020a1c770d000000b003fba5065656mr2754851wmi.32.1688149569177; Fri, 30
 Jun 2023 11:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <87sfa9eu70.fsf@toke.dk>
In-Reply-To: <87sfa9eu70.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jun 2023 11:25:57 -0700
Message-ID: <CAEf4Bzb0bVD_fuU4Oz1oXKdwLpG1t=7d5MV3OhniHUUiysWE8g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 4:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > This patch set introduces new BPF object, BPF token, which allows to de=
legate
> > a subset of BPF functionality from privileged system-wide daemon (e.g.,
> > systemd or any other container manager) to a *trusted* unprivileged
> > application. Trust is the key here. This functionality is not about all=
owing
> > unconditional unprivileged BPF usage. Establishing trust, though, is
> > completely up to the discretion of respective privileged application th=
at
> > would create a BPF token, as different production setups can and do ach=
ieve it
> > through a combination of different means (signing, LSM, code reviews, e=
tc),
> > and it's undesirable and infeasible for kernel to enforce any particula=
r way
> > of validating trustworthiness of particular process.
> >
> > The main motivation for BPF token is a desire to enable containerized
> > BPF applications to be used together with user namespaces. This is curr=
ently
> > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be nam=
espaced
> > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to =
BPF
> > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safe=
ly read
> > arbitrary memory, and it's impossible to ensure that they only read mem=
ory of
> > processes belonging to any given namespace. This means that it's imposs=
ible to
> > have namespace-aware CAP_BPF capability, and as such another mechanism =
to
> > allow safe usage of BPF functionality is necessary. BPF token and deleg=
ation
> > of it to a trusted unprivileged applications is such mechanism. Kernel =
makes
> > no assumption about what "trusted" constitutes in any particular case, =
and
> > it's up to specific privileged applications and their surrounding
> > infrastructure to decide that. What kernel provides is a set of APIs to=
 create
> > and tune BPF token, and pass it around to privileged BPF commands that =
are
> > creating new BPF objects like BPF programs, BPF maps, etc.
>
> So a colleague pointed out today that the Seccomp Notify functionality
> would be a way to achieve your stated goal of allowing unprivileged
> containers to (selectively) perform bpf() syscall operations. Christian
> Brauner has a pretty nice writeup of the functionality here:
> https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-u=
nprivileged-container-development
>
> In fact he even mentions allowing unprivileged access to bpf() as a
> possible use case (in the second-to-last paragraph).
>
> AFAICT this would enable your use case without adding any new kernel
> functionality or changing the BPF-using applications, while allowing the
> privileged userspace daemon to make case-by-case decisions on each
> operation instead of granting blanket capabilities (which is my main
> objection to the token proposal, as we discussed on the last iteration
> of the series).

It's not "blanket" capabilities. You control types or maps and
programs that could be created. And again, CAP_SYS_ADMIN guarded.
Please, don't give CAP_SYS_ADMIN/root permissions to applications you
can't be sure won't do something stupid and blame kernel API for it.

After all, the root process can setuid() any file and make it run with
elevated permissions, right? Doesn't get more "blanket" than that.

>
> So I'm curious whether you considered this as an alternative to
> BPF_TOKEN? And if so, what your reason was for rejecting it?
>

Yes, I'm aware, Christian has a follow up short blog post specifically
for using this for proxying BPF from privileged process ([0]).

So, in short, I think it's not a good generic solution. It's very
fragile and high-maintenance. It's still proxying BPF UAPI (except
application does preserve illusion of using BPF syscall, yes, that
part is good) with all the implications: needing to replicate all of
UAPI (fetching all those FDs from another process, following all the
pointers from another process' memory, etc), and also writing back all
the correct things (into another process' memory): log content,
log_true_size (out param), any other output parameters. What do we do
when an application uses a newer version of bpf_attr that is supported
by proxy? And honestly, I'm like 99% sure there are lots of less
obvious issues one runs into when starting implementing something like
this.

This sounds like a hack and nightmare to implement and support.
Perhaps that indirectly is supported by the fact that even Christian
half-jokingly calls this a crazy approach. That code basically is
unchanged for the last three years, with only one fix from Christian
one year after initial introduction ([1]) to fix a quirky issue
related to the limitation of pidfd working only for thread group
leaders. It also still supports only BPF_PROG_TYPE_CGROUP_DEVICE
program loading, it doesn't support a bunch of newer BPF_PROG_LOAD
fields and functionality, etc, etc.

So as a technical curiosity it's pretty cool and perhaps is the right
tool for the job for very narrow specific use cases. But as a
realistic generic approach that could be used by industry at large for
safe BPF usage from namespaced containers -- not so much.


  [0] https://brauner.io/2020/08/07/seccomp-notify-intercepting-the-bpf-sys=
call.html
  [1] https://github.com/lxc/lxd/commit/566d0a3b3cbe288787886c2f3bf5b250ceb=
930b0


> -Toke
>

