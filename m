Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508C1675887
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjATP0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjATP0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 10:26:44 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49CD501;
        Fri, 20 Jan 2023 07:26:23 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id p1so6010097vsr.5;
        Fri, 20 Jan 2023 07:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHCY4mL/EcA5eqCxZGkg0juV8XwTjSJS4YU5zJqXqHg=;
        b=MkFCmnurndlWBqeDlFmaDdXS1Fj8DI8yhFx0L0ZIoNkFXng564Ps/4/Wsv1Gmf5tZ6
         uLzDmLSgnizE9I9a4BTqGG378RR1FX2xo2IEFwjF9Nnp2FWQpkDEba+cHxaj0P4A8t/L
         UKI2eFvFTGW0mvP8Gf0MlIAB3snDdsR1i8CmXX2wbfQctMD84whh+16PVA132ULJsDix
         L42IwTuZzILeT3FJk3QHvmLzMBn9wuNuqHRifcIZU2zSva9VQmQbwAVUFqgaeZkhMHfL
         4bI5APtkIb0LFtq5ISQS8cHI0/v94Ca+r+XjOm7saX4tkBk+y3bptDFPunGLJFTwku+f
         /I5w==
X-Gm-Message-State: AFqh2kpwKVc+xdmuzUkhcV35Xv/DdNGbhUcb4dLudp1O1OGU+/4QjfVg
        PMthI9r2/mRakcaRS8TtZoc=
X-Google-Smtp-Source: AMrXdXto9umr2qymfvMTYy/kytmz+PEAgBS9qsJJskS9p6hgQzlXaGIA6LglQNK04vyYqMUOuyrYlg==
X-Received: by 2002:a05:6102:274a:b0:3d3:c424:4e68 with SMTP id p10-20020a056102274a00b003d3c4244e68mr10782339vsu.0.1674228382060;
        Fri, 20 Jan 2023 07:26:22 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id c4-20020a05620a268400b006fefa5f7fcesm21656593qkp.10.2023.01.20.07.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:26:21 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:26:26 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
Message-ID: <Y8qyovnr2bkEpldc@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo>
 <Y8olRi9SjcyNtam0@maniforge.lan>
 <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <CAP01T76aNAn2ish+jwFQuMrCk+11Rb_ZmteGe8RsE7ZMy1t4RA@mail.gmail.com>
 <20230120061441.3gifklagiugmkrtd@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <Y8qrt7pdWCS6Gef8@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qrt7pdWCS6Gef8@maniforge.lan>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 08:56:55AM -0600, David Vernet wrote:
> On Thu, Jan 19, 2023 at 10:14:41PM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 20, 2023 at 11:26:37AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, 20 Jan 2023 at 11:10, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 19, 2023 at 11:23:18PM -0600, David Vernet wrote:
> > > > > On Fri, Jan 20, 2023 at 10:28:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > > On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> > > > > > > When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> > > > > > > currently enforces that the top-level type must match when calling
> > > > > > > the kfunc. In other words, the verifier does not allow the BPF program
> > > > > > > to pass a bitwise equivalent struct, despite it being functionally safe.
> > > > > > > For example, if you have the following type:
> > > > > > >
> > > > > > > struct  nf_conn___init {
> > > > > > >   struct nf_conn ct;
> > > > > > > };
> > > > > > >
> > > > > > > It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> > > > > > > struct nf_conn.
> > > > > >
> > > > > > Just running bpf_nf selftest would have shown this is false.
> > > > >
> > > > > And I feel silly, because I did run them, and could have sworn they
> > > > > passed...looking now at the change_status_after_alloc testcase I see
> > > > > you're of course correct. Very poor example, thank you for pointing it
> > > > > out.
> > > > >
> > > > > >
> > > > > > > Being able to do this will be useful for certain types
> > > > > > > of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> > > > > > > series of kfuncs will be added which allow programs to do bitwise
> > > > > > > queries on cpumasks that are either allocated by the program (in which
> > > > > > > case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> > > > > > > its first element), or a cpumask that was allocated by the main kernel
> > > > > > > (in which case it will just be a straight cpumask_t, as in
> > > > > > >  task->cpus_ptr).
> > > > > > >
> > > > > > > Having the two types of cpumasks allows us to distinguish between the
> > > > > > > two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> > > > > > > can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> > > > > > > cannot be. On the other hand, a struct bpf_cpumask can of course be
> > > > > > > queried in the exact same manner as a cpumask_t, with e.g.
> > > > > > > bpf_cpumask_test_cpu().
> > > > > > >
> > > > > > > If we were to enforce that top level types match, then a user that's
> > > > > > > passing a struct bpf_cpumask to a read-only cpumask_t argument would
> > > > > > > have to cast with something like bpf_cast_to_kern_ctx() (which itself
> > > > > > > would need to be updated to expect the alias, and currently it only
> > > > > > > accommodates a single alias per prog type). Additionally, not specifying
> > > > > > > KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> > > > > > > struct bpf_cpumask *, and another as a struct cpumask *
> > > > > > > (i.e. cpumask_t).
> > > > > > >
> > > > > > > In order to enable this, this patch relaxes the constraint that a
> > > > > > > KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> > > > > > > try and be conservative and match existing behavior / expectations, this
> > > > > > > patch also enforces strict type checking for acquire kfuncs. We were
> > > > > > > already enforcing it for release kfuncs, so this should also improve the
> > > > > > > consistency of the semantics for kfuncs.
> > > > > > >
> > > > > >
> > > > > > What you want is to simply follow type at off = 0 (but still enforce the off = 0
> > > > > > requirement). This is something which is currently done for bpf_sk_release (for
> > > > > > struct sk_common) in check_reg_type, but it is not safe in general to just open
> > > > > > this up for all cases. I suggest encoding this particular requirement in the
> > > > > > argument, and simply using triple underscore variant of the type for the special
> > > > > > 'read_only' requirement. This will allow you to use same type in your BPF C
> > > > > > program, while allowing verifier to see them as two different types in kfunc
> > > > > > parameters. Then just relax type following for the particular argument so that
> > > > > > one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
> > > > > > it just visits first member after failing match on top level type). off = 0
> > > > > > check is still necessary.
> > > > >
> > > > > Sigh, yeah, another ___ workaround but I agree it's probably the best we
> > > > > can do for now, and in general seems pretty useful. Obviously preferable
> > > > > to this patch which just doesn't work. Alexei, are you OK with this? If
> > > > > so, I'll take this approach for v2.
> > > >
> > > > We decided to rely on strict type match when we introduced 'struct nf_conn___init',
> > > > but with that we twisted the C standard to, what looks to be, a wrong direction.
> > > >
> > > > For definition:
> > > > struct nf_conn___init {
> > > >    struct nf_conn ct;
> > > > };
> > > > if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn__init
> > > > for both read and write, because in C that's valid and safe type cast.
> > > >
> > > 
> > > The intention of this nf_conn___init was to be invisible to the user.
> > > In selftests there is no trace of nf_conn___init. It is only for
> > > enforcing semantics by virtue of type safety in the verifier.
> > > 
> > > Allocated but not inserted nf_conn -> nf_conn___init
> > > Inserted/looked up nf_conn -> nf_conn
> > > 
> > > We can't pass e.g. nf_conn___init * to a function expecting nf_conn *.
> > > The allocated nf_conn may not yet be fully initialized. It is only
> > > after bpf_ct_insert_entry takes the nf_conn___init * and returns
> > > inserted nf_conn * should it be allowed.
> > 
> > Yes. I know and agree with all of the above.
> > 
> > > But for the user in BPF C it will be the same nf_conn. The verifier
> > > can enforce different semantics on the underlying type's usage in
> > > kfuncs etc, while the user performs normal direct access to the
> > > nf_conn.
> > > 
> > > It will be the same case here, except you also introduce the case of
> > > kfuncs that are 'polymorphic' and can take both. Relaxing
> > > 'strict_type_match' for that arg and placing the type of member you
> > > wish to convert the pointer to gives you such polymorphism. But it's
> > > not correct to do for nf_conn___init to nf_conn, at least not by
> > > default.
> > 
> > Yes. Agree. I used unfortunate example in the previous reply with nf_conn___init.
> > I meant to say:
> > 
> >  For definition:
> >  struct nf_conn_init {
> >     struct nf_conn ct;
> >  };
> >  if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn_init
> >  for both read and write, because in C that's valid and safe type cast.
> > 
> > Meainng that C rules apply.
> > Our triple underscore is special, because it's the "same type".
> > In the 2nd part of my reply I'm proposing to use the whole suffix "___init" to indicate that.
> > I think you're arguing that just "___" part is enough to enforce strict match.
> > Matching foo___flavor with foo should not be allowed.
> > While passing struct foo_flavor {struct foo;} into a kfunc that accepts 'struct foo'
> > is safe.
> > If so, I'm fine with such approach.
> 
> Alright, I'll spin v2 to treat any type with name___.* as a disallowed
> alias, and update the documentation to mention it. I was originally
> going to push back and say that we should just use a single alias like
> __nocast to keep things simple, but it doesn't feel generalizable
> enough.

On second thought, unless you guys feel strongly, I'll just check
___init. The resulting code is going to be a lot of tricky string
manipulation / math otherwise. Not _terrible_, but I'd prefer to avoid
adding it until we have a concrete use-case. And I expect this could be
implemented much simpler using something like tags, once gcc has support
for it.
