Return-Path: <bpf+bounces-2681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84767322E9
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C2281511
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83305101D6;
	Thu, 15 Jun 2023 22:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27A657
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 22:56:06 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13EC272C;
	Thu, 15 Jun 2023 15:55:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9768fd99c0cso271490466b.0;
        Thu, 15 Jun 2023 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686869746; x=1689461746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OIqj0mkVEvQN1nrIc1Z5Ri9jhKdt39NZZowMGmv+P8=;
        b=fJjUP22XueRFN6dD1JCd9oLT8C+wK8r1hcdvrjthTXLEFvWtND7WXX7GDzqjnKbblS
         U/3vl6D2QpYGfs79hv1gvM871QKIgPZbXXfcRNiu3D5u6bMWGVuxG3lN2dzTjd8RDa8n
         /f294YloEDGV64IM3OaYu+rIpRfThX+xJNHhBAIorF0pDMrjX+go8Rnde8rnnNJ8DRy6
         iF5ga0IvEEHixxVAP1avVt4r2k6lieykw8k3mgN1tD0OdyG1y3Z698F3lAdosGIwc1v5
         l8XVi4fbj5HADhfb9M75pyBUs8X9XB+Ml431iXqWQv4e1zPz50dDIkvn9rYWaMaxdZXk
         2Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686869746; x=1689461746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OIqj0mkVEvQN1nrIc1Z5Ri9jhKdt39NZZowMGmv+P8=;
        b=EOnzOoEuWe+H8ZHQaaryrdnZuCcQ2OYEhIfNRI3sPb3wlZUtrfXDoxAQWSj57qU8HC
         0r0+DaPh7OF6idHOsHZqEY7FCj34N5DfDHefsnRl2YzfoKteIgfQwgunCdjsII12wiP0
         lMyJ94bSHrSWX8o/DIfB34jBz/S4soGexHj41qkSKphXofjyR6eLO2cKvkLhcjBp9daX
         Bi46BHOEFfqA6/4FASFSdfziNhahQULvsGAgHGXtdU/7y+m1Ck41aIJRtZTatLX0Gdei
         xvSokLWhDBchUtdR4XNxS43uES5BWZ69P6zxYb04tKiZhJC+DYSe0OOnbtU/rfgeMhmd
         5sHw==
X-Gm-Message-State: AC+VfDxD9Y82l46aYs5DcTfzt/kIJMBu65cDrlw3JTRJwqdbE9szagqo
	tV/aFovwfTj7FvnMSxnOzKfFfribNcCDDVCGW9w=
X-Google-Smtp-Source: ACHHUZ6cDpcEQdp9rrKtPC9PgB9EYKnG+ApbnJZAIXa6V2QdIgiWMGxblRuh+O0QnfrfP+pI8vzTL3Xdiao6GWdFAdc=
X-Received: by 2002:a17:907:2d09:b0:94a:653b:ba41 with SMTP id
 gs9-20020a1709072d0900b0094a653bba41mr157717ejc.15.1686869745922; Thu, 15 Jun
 2023 15:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk> <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
 <87bkhlymyk.fsf@toke.dk> <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
 <874jnal046.fsf@toke.dk>
In-Reply-To: <874jnal046.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jun 2023 15:55:34 -0700
Message-ID: <CAEf4BzZRrm26rzB5MOx-98PstVZxjhR73GiWK+Fjof1oSV_Oxw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com, 
	luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 5:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Mon, Jun 12, 2023 at 3:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Fri, Jun 9, 2023 at 2:21=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@kernel.org> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> >>
> >> >> > On Fri, Jun 9, 2023 at 4:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8r=
gensen <toke@kernel.org> wrote:
> >> >> >>
> >> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> >> >>
> >> >> >> > This patch set introduces new BPF object, BPF token, which all=
ows to delegate
> >> >> >> > a subset of BPF functionality from privileged system-wide daem=
on (e.g.,
> >> >> >> > systemd or any other container manager) to a *trusted* unprivi=
leged
> >> >> >> > application. Trust is the key here. This functionality is not =
about allowing
> >> >> >> > unconditional unprivileged BPF usage. Establishing trust, thou=
gh, is
> >> >> >> > completely up to the discretion of respective privileged appli=
cation that
> >> >> >> > would create a BPF token.
> >> >> >>
> >> >> >> I am not convinced that this token-based approach is a good way =
to solve
> >> >> >> this: having the delegation mechanism be one where you can basic=
ally
> >> >> >> only grant a perpetual delegation with no way to retract it, no =
way to
> >> >> >> check what exactly it's being used for, and that is transitive (=
can be
> >> >> >> passed on to others with no restrictions) seems like a recipe fo=
r
> >> >> >> disaster. I believe this was basically the point Casey was makin=
g as
> >> >> >> well in response to v1.
> >> >> >
> >> >> > Most of this can be added, if we really need to. Ability to revok=
e BPF
> >> >> > token is easy to implement (though of course it will apply only f=
or
> >> >> > subsequent operations). We can allocate ID for BPF token just lik=
e we
> >> >> > do for BPF prog/map/link and let tools iterate and fetch informat=
ion
> >> >> > about it. As for controlling who's passing what and where, I don'=
t
> >> >> > think the situation is different for any other FD-based mechanism=
. You
> >> >> > might as well create a BPF map/prog/link, pass it through SCM_RIG=
HTS
> >> >> > or BPF FS, and that application can keep doing the same to other
> >> >> > processes.
> >> >>
> >> >> No, but every other fd-based mechanism is limited in scope. E.g., i=
f you
> >> >> pass a map fd that's one specific map that can be passed around, wi=
th a
> >> >> token it's all operations (of a specific type) which is way broader=
.
> >> >
> >> > It's not black and white. Once you have a BPF program FD, you can
> >> > attach it many times, for example, and cause regressions. Sure, here
> >> > we are talking about creating multiple BPF maps or loading multiple
> >> > BPF programs, so it's wider in scope, but still, it's not that
> >> > fundamentally different.
> >>
> >> Right, but the difference is that a single BPF program is a known
> >> entity, so even if the application you pass the fd to can attach it
> >> multiple times, it can't make it do new things (e.g., bpf_probe_read()
> >> stuff it is not supposed to). Whereas with bpf_token you have no such
> >> guarantee.
> >
> > Sure, I'm not claiming BPF token is just like passing BPF program FD
> > around. My point is that anything in the kernel that is representable
> > by FD can be passed around to an unintended process through
> > SCM_RIGHTS. And if you want to have tighter control over who's passing
> > what, you'd probably need LSM. But it's not a requirement.
> >
> > With BPF token it is important to trust the application you are
> > passing BPF token to. This is not a mechanism to just freely pass
> > around the ability to do BPF. You do it only to applications you
> > control.
>
> Trust is not binary, though. "Do I trust this application to perform
> this specific action" is different from "do I trust this application to
> perform any action in the future". A security mechanism should grant the
> minimum required privileges required to perform the operation; this
> token thing encourages (defaults to) broader grants, which is worrysome.

BPF token defaults to not allowing anything, unless you explicitly
allow commands/progs/maps. If you don't set allow_cmds, you literally
get a useless BPF token that grants you nothing.

>
> > With user namespaces, if we could grant CAP_BPF and co to use BPF,
> > we'd do that. But we can't. BPF token at least gives us this
> > opportunity.
>
> If the use case is to punch holes in the user namespace isolation I feel
> like that is better solved at the user namespace level than the BPF
> subsystem level...
>
> -Toke
>
>
> (Ran out of time and I'm about to leave for PTO, so dropping the RPC
> discussion for now)
>

