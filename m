Return-Path: <bpf+bounces-14305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FACD7E2C97
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C881C20CD8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B229D0B;
	Mon,  6 Nov 2023 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViBPj2pG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AED28E17;
	Mon,  6 Nov 2023 19:03:20 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0223BB;
	Mon,  6 Nov 2023 11:03:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso715669466b.1;
        Mon, 06 Nov 2023 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699297397; x=1699902197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po8rIN0UE2EVDqSENb5hU9jONiWYxIx8ngSOAiRM/mM=;
        b=ViBPj2pGMgtXLPfCgAYi0yDHHxrLs5SfbbuIeBSF2w0vkmWFFIYkFCBQXS1zspXWo7
         CL0YiNlhGfS41sfaDfO/VM9QECNp1O3psBfbY5WQZwkrBvTLVM32wgJOJVpZ8HPi/tCk
         jv35nIbMfTDt4Gb9azTSc3PyTPZBPKobOs5/DJUUvPAFhyLJ3epLiYveo34iLYcigG83
         qEIldEFiPbfCN7pwV0ycE3dEqK1w7rth55YyKZ7E84K+EhzWGgVBqmKG30OV4s/RNVsb
         vKnlXdEU19nLRWErx4VQJoM0AD4Eb8loqHEAGYlOdi0yr+CTEU/sxJAJFEdqd85wuKs1
         XErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297397; x=1699902197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po8rIN0UE2EVDqSENb5hU9jONiWYxIx8ngSOAiRM/mM=;
        b=h0BCbFCBtRBEDxqH6ySoYTJPKSYI0CWfSh28cZHHhRrK0kXBHX0HRIDUhU4dIe2+zA
         dqE/SLFmUVHJFTJD5GaVpg8zEH2ReouhbCSPjnNrrTqi/0JHtezBAsOgU2zpOrDi3Ogk
         ZIjO3m7oOzxT4RrsignSC8vlWwM5Zf8X9PUBH2bLDrn4Ie0KqxK66mUMNyxXLNgiGZJG
         EJk72x1TZKDQ2aFG+8fEKOiqcRHSxUw29Nxb5nd1CmjeV41FHXJrp6qMd6hFIuzsDWUG
         3gN+Svoodn/AaDx/UNYPC1pKnHMdp/ZRKQO39BIK3h+RAuKWalhs3Q7mS1zHI5Jze6Sj
         M28Q==
X-Gm-Message-State: AOJu0YzOTwgcnJwMAJ92fIJpbuMyJEfxnjQOKr9D1QtzYm+avYdrpKnv
	+7cPWrtznbVsXTrBH+qaE1Z22Kv/loChW1kJP7U=
X-Google-Smtp-Source: AGHT+IGBgeJg/bNsD5dwJoZXLqPVs31CF6CY8+BoPeEjCL4gXQFiXcF/I4SXJow0aqntHGmOxou7y6/uTzGpe7ivH3w=
X-Received: by 2002:a17:907:368a:b0:9c5:1100:9b8c with SMTP id
 bi10-20020a170907368a00b009c511009b8cmr13952016ejc.56.1699297396812; Mon, 06
 Nov 2023 11:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-10-andrii@kernel.org> <7ff273d368f3f7dd383444928ca478ef.paul@paul-moore.com>
In-Reply-To: <7ff273d368f3f7dd383444928ca478ef.paul@paul-moore.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 11:03:05 -0800
Message-ID: <CAEf4Bzaxv4uHK=+_vwZuvgBgq8L6d4JwxTSGxZgU44LwWYhDug@mail.gmail.com>
Subject: Re: [PATCH v9 9/17] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free
 LSM hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Based on upstream discussion ([0]), rework existing
> > bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and instea=
d
> > of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
> > program struct. Also, we pass bpf_attr union with all the user-provided
> > arguments for BPF_PROG_LOAD command.  This will give LSMs as much
> > information as we can basically provide.
> >
> > The hook is also BPF token-aware now, and optional bpf_token struct is
> > passed as a third argument. bpf_prog_load LSM hook is called after
> > a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux were
> > allocated and filled out, but right before performing full-fledged BPF
> > verification step.
> >
> > bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
> > consistency. SELinux code is adjusted to all new names, types, and
> > signatures.
> >
> > Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can be
> > used by some LSMs to allocate extra security blob, but also by other
> > LSMs to reject BPF program loading, we need to make sure that
> > bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc one
> > *even* if the hook itself returned error. If we don't do that, we run
> > the risk of leaking memory. This seems to be possible today when
> > combining SELinux and BPF LSM, as one example, depending on their
> > relative ordering.
> >
> > Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
> > sleepable LSM hooks list, as they are both executed in sleepable
> > context. Also drop bpf_prog_load hook from untrusted, as there is no
> > issue with refcount or anything else anymore, that originally forced us
> > to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certain =
LSM
> > hook arguments as trusted"). We now trigger this hook much later and it
> > should not be an issue anymore.
>
> See my comment below, but it isn't clear to me if this means it is okay
> to have `BTF_ID(func, bpf_lsm_bpf_prog_free)` called twice.  It probably
> would be a good idea to get KP, BPF LSM maintainer, to review this change
> as well to make sure this looks good to him.
>
> >   [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul=
@paul-moore.com/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++--
> >  include/linux/security.h      | 12 +++++++-----
> >  kernel/bpf/bpf_lsm.c          |  5 +++--
> >  kernel/bpf/syscall.c          | 25 +++++++++++++------------
> >  security/security.c           | 25 +++++++++++++++----------
> >  security/selinux/hooks.c      | 15 ++++++++-------
> >  6 files changed, 49 insertions(+), 38 deletions(-)
>
> ...
>
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index e14c822f8911..3e956f6302f3 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
> >  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
> >  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> >  BTF_ID(func, bpf_lsm_bpf_prog)
> > +BTF_ID(func, bpf_lsm_bpf_prog_load)
> > +BTF_ID(func, bpf_lsm_bpf_prog_free)
> >  BTF_ID(func, bpf_lsm_bprm_check_security)
> >  BTF_ID(func, bpf_lsm_bprm_committed_creds)
> >  BTF_ID(func, bpf_lsm_bprm_committing_creds)
> > @@ -346,8 +348,7 @@ BTF_SET_END(sleepable_lsm_hooks)
> >
> >  BTF_SET_START(untrusted_lsm_hooks)
> >  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> > -BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
> > -BTF_ID(func, bpf_lsm_bpf_prog_free_security)
> > +BTF_ID(func, bpf_lsm_bpf_prog_free)
> >  BTF_ID(func, bpf_lsm_file_alloc_security)
> >  BTF_ID(func, bpf_lsm_file_free_security)
> >  #ifdef CONFIG_SECURITY_NETWORK
>
> It looks like you're calling the BTF_ID() macro on bpf_lsm_bpf_prog_free
> twice?  I would have expected a only one macro call for each bpf_prog_loa=
d
> and bpf_prog_free, is that a bad assuption?
>

Yeah, there is no problem having multiple BTF_ID() invocations for the
same function. BTF_ID() macro (conceptually) emits a relocation that
will instruct resolve_btfids tool to put an actual BTF ID for the
specified function in a designated 4-byte slot.

In this case, we have two separate lists: sleepable_lsm_hooks and
untrusted_lsm_hooks, so we need two separate BTF_ID() entries for the
same function. It's expected to be duplicated.

> > diff --git a/security/security.c b/security/security.c
> > index dcb3e7014f9b..5773d446210e 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
> >  }
> >
> >  /**
> > - * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
> > - * @aux: bpf program aux info struct
> > + * security_bpf_prog_load() - Check if loading of BPF program is allow=
ed
> > + * @prog: BPF program object
> > + * @attr: BPF syscall attributes used to create BPF program
> > + * @token: BPF token used to grant user access to BPF subsystem
> >   *
> > - * Initialize the security field inside bpf program.
> > + * Do a check when the kernel allocates BPF program object and is abou=
t to
> > + * pass it to BPF verifier for additional correctness checks. This is =
also the
> > + * point where LSM blob is allocated for LSMs that need them.
>
> This is pretty nitpicky, but I'm guessing you may need to make another
> revision to this patchset, if you do please drop the BPF verifier remark
> from the comment above.
>
> Example: "Perform an access control check when the kernel loads a BPF
> program and allocates the associated BPF program object.  This hook is
> also responsibile for allocating any required LSM state for the BPF
> program."

Done, no problem.

>
> >   * Return: Returns 0 on success, error on failure.
> >   */
> > -int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
> > +int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr=
,
> > +                        struct bpf_token *token)
> >  {
> > -     return call_int_hook(bpf_prog_alloc_security, 0, aux);
> > +     return call_int_hook(bpf_prog_load, 0, prog, attr, token);
> >  }
>
> --
> paul-moore.com

