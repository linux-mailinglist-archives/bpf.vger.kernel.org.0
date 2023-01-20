Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45F1674CE5
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjATF5U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjATF5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:57:17 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01F457FF;
        Thu, 19 Jan 2023 21:57:14 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id r9so3574911oig.12;
        Thu, 19 Jan 2023 21:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AeX0n5P/6nQ0puYJ2WaVnGmquBfR3xgj5fyXPKbKM8=;
        b=Bj0OJGuJUENDv0MwA7ezZswGtJC78OPagOS7g5wWQgRZ5gCdrGOz6/EilzsUMc0cFY
         SsmMq96hNSdYyiNrSmJUZjfyklUM+M+IJu4cfiV92FO2SpZZgyr8OhFkGFJi1Iyl5t9Z
         gEvuG3ET1JMkRMlbir4rNZ7hiOgvFNTDBBl4pdbFQ22q4WGY8ENnaPTd3lHeNm1oG/sW
         Fz/+1q+uX2N8XdefN0w7NVpXqVZeZv0IFaeXtM0RTSewBqjWoawVqT5zOFRIpaZoE2Dj
         8jknl2a6S0At8OySsqkm7mLKf3IV6J/Ue+BIciy6IbKlKEnrSdp0mqloC0cC4o5xWCf3
         8j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AeX0n5P/6nQ0puYJ2WaVnGmquBfR3xgj5fyXPKbKM8=;
        b=EYe4yhnz4dvikjEzTmoflJthIbHGuXsgK2GB+DHVx/vyT3VGQZoh8VkQ6wH1zZ07ye
         QONxHc+7WDia+YSKeYYkpvyWpcGPvsnJD1YqH4QtpH3NAWvUVBmbfBv9Y6AsaVdWcEFi
         4b6NhYDbwFxCwc/1lTSfc5QPsFmtSAwlYTTer6Ywrnsslf9cPVWmrVv4TDtQs4zwobda
         MEw34Fjg6qRuGuzeKF8MKb3qiN283mC0SuVSBlhgP0p0fCsffKCGaZ1NRBqZjBVaSMsp
         Jpiupy3UaNuXWmZenhHPPYI7r3XPMG0sqalVagZ7jUjrYtU35pYARq6bjfczx367+iKZ
         O/Qw==
X-Gm-Message-State: AFqh2kp5d0nNq9fHNkei71Bu5mimapfljt1t/E+CL7/VFyThck5em6ps
        lE4ECXsu5MA4hNd5kj3LbJLyZsX266Yn3hN48O4=
X-Google-Smtp-Source: AMrXdXtf5RhqPlZP7pwS4BmL4Isxlj+9KiXK0v3MNMjFJRx/6UEMFLV3xaabAFAIxzwTcENc76W6Ryn1sa3N1+QxsZM=
X-Received: by 2002:a05:6808:3a91:b0:364:c0a5:1fcf with SMTP id
 fb17-20020a0568083a9100b00364c0a51fcfmr727943oib.58.1674194233430; Thu, 19
 Jan 2023 21:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20230119235833.2948341-1-void@manifault.com> <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo> <Y8olRi9SjcyNtam0@maniforge.lan> <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
In-Reply-To: <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 20 Jan 2023 11:26:37 +0530
Message-ID: <CAP01T76aNAn2ish+jwFQuMrCk+11Rb_ZmteGe8RsE7ZMy1t4RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
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

On Fri, 20 Jan 2023 at 11:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 19, 2023 at 11:23:18PM -0600, David Vernet wrote:
> > On Fri, Jan 20, 2023 at 10:28:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> > > > When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> > > > currently enforces that the top-level type must match when calling
> > > > the kfunc. In other words, the verifier does not allow the BPF program
> > > > to pass a bitwise equivalent struct, despite it being functionally safe.
> > > > For example, if you have the following type:
> > > >
> > > > struct  nf_conn___init {
> > > >   struct nf_conn ct;
> > > > };
> > > >
> > > > It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> > > > struct nf_conn.
> > >
> > > Just running bpf_nf selftest would have shown this is false.
> >
> > And I feel silly, because I did run them, and could have sworn they
> > passed...looking now at the change_status_after_alloc testcase I see
> > you're of course correct. Very poor example, thank you for pointing it
> > out.
> >
> > >
> > > > Being able to do this will be useful for certain types
> > > > of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> > > > series of kfuncs will be added which allow programs to do bitwise
> > > > queries on cpumasks that are either allocated by the program (in which
> > > > case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> > > > its first element), or a cpumask that was allocated by the main kernel
> > > > (in which case it will just be a straight cpumask_t, as in
> > > >  task->cpus_ptr).
> > > >
> > > > Having the two types of cpumasks allows us to distinguish between the
> > > > two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> > > > can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> > > > cannot be. On the other hand, a struct bpf_cpumask can of course be
> > > > queried in the exact same manner as a cpumask_t, with e.g.
> > > > bpf_cpumask_test_cpu().
> > > >
> > > > If we were to enforce that top level types match, then a user that's
> > > > passing a struct bpf_cpumask to a read-only cpumask_t argument would
> > > > have to cast with something like bpf_cast_to_kern_ctx() (which itself
> > > > would need to be updated to expect the alias, and currently it only
> > > > accommodates a single alias per prog type). Additionally, not specifying
> > > > KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> > > > struct bpf_cpumask *, and another as a struct cpumask *
> > > > (i.e. cpumask_t).
> > > >
> > > > In order to enable this, this patch relaxes the constraint that a
> > > > KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> > > > try and be conservative and match existing behavior / expectations, this
> > > > patch also enforces strict type checking for acquire kfuncs. We were
> > > > already enforcing it for release kfuncs, so this should also improve the
> > > > consistency of the semantics for kfuncs.
> > > >
> > >
> > > What you want is to simply follow type at off = 0 (but still enforce the off = 0
> > > requirement). This is something which is currently done for bpf_sk_release (for
> > > struct sk_common) in check_reg_type, but it is not safe in general to just open
> > > this up for all cases. I suggest encoding this particular requirement in the
> > > argument, and simply using triple underscore variant of the type for the special
> > > 'read_only' requirement. This will allow you to use same type in your BPF C
> > > program, while allowing verifier to see them as two different types in kfunc
> > > parameters. Then just relax type following for the particular argument so that
> > > one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
> > > it just visits first member after failing match on top level type). off = 0
> > > check is still necessary.
> >
> > Sigh, yeah, another ___ workaround but I agree it's probably the best we
> > can do for now, and in general seems pretty useful. Obviously preferable
> > to this patch which just doesn't work. Alexei, are you OK with this? If
> > so, I'll take this approach for v2.
>
> We decided to rely on strict type match when we introduced 'struct nf_conn___init',
> but with that we twisted the C standard to, what looks to be, a wrong direction.
>
> For definition:
> struct nf_conn___init {
>    struct nf_conn ct;
> };
> if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn__init
> for both read and write, because in C that's valid and safe type cast.
>

The intention of this nf_conn___init was to be invisible to the user.
In selftests there is no trace of nf_conn___init. It is only for
enforcing semantics by virtue of type safety in the verifier.

Allocated but not inserted nf_conn -> nf_conn___init
Inserted/looked up nf_conn -> nf_conn

We can't pass e.g. nf_conn___init * to a function expecting nf_conn *.
The allocated nf_conn may not yet be fully initialized. It is only
after bpf_ct_insert_entry takes the nf_conn___init * and returns
inserted nf_conn * should it be allowed.

But for the user in BPF C it will be the same nf_conn. The verifier
can enforce different semantics on the underlying type's usage in
kfuncs etc, while the user performs normal direct access to the
nf_conn.

It will be the same case here, except you also introduce the case of
kfuncs that are 'polymorphic' and can take both. Relaxing
'strict_type_match' for that arg and placing the type of member you
wish to convert the pointer to gives you such polymorphism. But it's
not correct to do for nf_conn___init to nf_conn, at least not by
default.

In the future we may do:

union bpf_subtype {
  type A;
  type B;
  type C;
};

And using the relaxed rule allows all types at off = 0 to be passed to
kfuncs expecting type A/B/C for bpf_subtype *.
bpf_subtype is a fake type. We're just using the type system to
enforce different API usage for the same underlying kernel type.

> We can fix this design issue by saying that '___init' suffix is special and
> C type casting rules don't apply to it.
> In all other cases bpf_cpumask/cpumask would should allow it.
>

I'm just saying the triple underscore is not visible to the user.
You can declare kfunc that is:
struct foo___x *foo_alloc(void); in the kernel as
struct foo *foo_alloc(void); in BPF program and avoid all the
casting/ugliness and still enforce semantics around use.
