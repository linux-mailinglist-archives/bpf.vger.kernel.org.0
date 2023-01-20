Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF8674D27
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjATGOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATGOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:14:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD57CCC8;
        Thu, 19 Jan 2023 22:14:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so3372118pgs.3;
        Thu, 19 Jan 2023 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvS62MabEwznOfP/YHG+rl8hUle1JuEjs8xzOFILzYw=;
        b=BKga+8LWNVo/8QWKnHBo5rEfXkVKWx3Q1qMF+glRxDOGZ6V99/sJ525058DTetMGmd
         8ILgKNZ641KpiJNnzFrXmKezS9WQbDHip+r1wzqCmZx9iDoD9zyGhjpAeShPTAeLSHpC
         /GdkjuLTBIPtq2rn6iVJh0mXMQjd6ukDut2rgPp5QnXKDOf9BBk6ciMctFlwSprbO4A3
         N6Tywc0+jWVDMLW6FQnHWjv6rBlTjCjjWssTZwHslto3YUZxCyOYQT2Uzot8zuKBFviN
         Fc2At5vtNo3vzqpKnkE5DfH2Rn9poiO4rJkHGWKyHABtZn+t1pOVrSYFZ3C0yP58Z06A
         BqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvS62MabEwznOfP/YHG+rl8hUle1JuEjs8xzOFILzYw=;
        b=ZMsF0GTUtDWOzBv5TgU9LcA/fT/4SC9IIEudA9/7gek/45s9sQkcTTfOoBb6t1LCs7
         janck20AXnCg4hUm5FV4p+zN+ayveUvDeUCbold50Ne+9ssxDJ3NqoLicmKq8mybWx+s
         5N7W/PfC5DXq8OJlZ4doS43YY1cfvckjwYFxcfmgrl3wRH8y2mvNHPEwcqSirKMvAPAP
         oTXk+MobkPXUWURPKzjbr3ywADodGkG4xHAB4Jud79OTmHY8zJPTyEJG/x+/EDdKDesB
         vufDhbilVR/D1dK6FduHLn2OEJ1fqB10cfbNBBQnLuZPo7Vvl0+rVoKWIOvxdFZ6/28V
         l04w==
X-Gm-Message-State: AFqh2kqGsXJDakEg5CE0/R/Xw4aVLEGAgzZ+wLKuB6lwccfJep3clErY
        sZRMOByhoFo+R+gyfqPbB++KsvDgJLE=
X-Google-Smtp-Source: AMrXdXuz5gBun0lovSAZplpJSHQqXouuA9yq3Oh3VbNvoLsw7nQeP+SlfAg+1NUcXnQPqf+qucsLTA==
X-Received: by 2002:a05:6a00:21c9:b0:58d:f607:5300 with SMTP id t9-20020a056a0021c900b0058df6075300mr9942292pfj.8.1674195284500;
        Thu, 19 Jan 2023 22:14:44 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id d124-20020a621d82000000b0056bbeaa82b9sm24992187pfd.113.2023.01.19.22.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:14:44 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:14:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
Message-ID: <20230120061441.3gifklagiugmkrtd@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo>
 <Y8olRi9SjcyNtam0@maniforge.lan>
 <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <CAP01T76aNAn2ish+jwFQuMrCk+11Rb_ZmteGe8RsE7ZMy1t4RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76aNAn2ish+jwFQuMrCk+11Rb_ZmteGe8RsE7ZMy1t4RA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 11:26:37AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, 20 Jan 2023 at 11:10, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 11:23:18PM -0600, David Vernet wrote:
> > > On Fri, Jan 20, 2023 at 10:28:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> > > > > When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> > > > > currently enforces that the top-level type must match when calling
> > > > > the kfunc. In other words, the verifier does not allow the BPF program
> > > > > to pass a bitwise equivalent struct, despite it being functionally safe.
> > > > > For example, if you have the following type:
> > > > >
> > > > > struct  nf_conn___init {
> > > > >   struct nf_conn ct;
> > > > > };
> > > > >
> > > > > It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> > > > > struct nf_conn.
> > > >
> > > > Just running bpf_nf selftest would have shown this is false.
> > >
> > > And I feel silly, because I did run them, and could have sworn they
> > > passed...looking now at the change_status_after_alloc testcase I see
> > > you're of course correct. Very poor example, thank you for pointing it
> > > out.
> > >
> > > >
> > > > > Being able to do this will be useful for certain types
> > > > > of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> > > > > series of kfuncs will be added which allow programs to do bitwise
> > > > > queries on cpumasks that are either allocated by the program (in which
> > > > > case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> > > > > its first element), or a cpumask that was allocated by the main kernel
> > > > > (in which case it will just be a straight cpumask_t, as in
> > > > >  task->cpus_ptr).
> > > > >
> > > > > Having the two types of cpumasks allows us to distinguish between the
> > > > > two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> > > > > can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> > > > > cannot be. On the other hand, a struct bpf_cpumask can of course be
> > > > > queried in the exact same manner as a cpumask_t, with e.g.
> > > > > bpf_cpumask_test_cpu().
> > > > >
> > > > > If we were to enforce that top level types match, then a user that's
> > > > > passing a struct bpf_cpumask to a read-only cpumask_t argument would
> > > > > have to cast with something like bpf_cast_to_kern_ctx() (which itself
> > > > > would need to be updated to expect the alias, and currently it only
> > > > > accommodates a single alias per prog type). Additionally, not specifying
> > > > > KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> > > > > struct bpf_cpumask *, and another as a struct cpumask *
> > > > > (i.e. cpumask_t).
> > > > >
> > > > > In order to enable this, this patch relaxes the constraint that a
> > > > > KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> > > > > try and be conservative and match existing behavior / expectations, this
> > > > > patch also enforces strict type checking for acquire kfuncs. We were
> > > > > already enforcing it for release kfuncs, so this should also improve the
> > > > > consistency of the semantics for kfuncs.
> > > > >
> > > >
> > > > What you want is to simply follow type at off = 0 (but still enforce the off = 0
> > > > requirement). This is something which is currently done for bpf_sk_release (for
> > > > struct sk_common) in check_reg_type, but it is not safe in general to just open
> > > > this up for all cases. I suggest encoding this particular requirement in the
> > > > argument, and simply using triple underscore variant of the type for the special
> > > > 'read_only' requirement. This will allow you to use same type in your BPF C
> > > > program, while allowing verifier to see them as two different types in kfunc
> > > > parameters. Then just relax type following for the particular argument so that
> > > > one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
> > > > it just visits first member after failing match on top level type). off = 0
> > > > check is still necessary.
> > >
> > > Sigh, yeah, another ___ workaround but I agree it's probably the best we
> > > can do for now, and in general seems pretty useful. Obviously preferable
> > > to this patch which just doesn't work. Alexei, are you OK with this? If
> > > so, I'll take this approach for v2.
> >
> > We decided to rely on strict type match when we introduced 'struct nf_conn___init',
> > but with that we twisted the C standard to, what looks to be, a wrong direction.
> >
> > For definition:
> > struct nf_conn___init {
> >    struct nf_conn ct;
> > };
> > if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn__init
> > for both read and write, because in C that's valid and safe type cast.
> >
> 
> The intention of this nf_conn___init was to be invisible to the user.
> In selftests there is no trace of nf_conn___init. It is only for
> enforcing semantics by virtue of type safety in the verifier.
> 
> Allocated but not inserted nf_conn -> nf_conn___init
> Inserted/looked up nf_conn -> nf_conn
> 
> We can't pass e.g. nf_conn___init * to a function expecting nf_conn *.
> The allocated nf_conn may not yet be fully initialized. It is only
> after bpf_ct_insert_entry takes the nf_conn___init * and returns
> inserted nf_conn * should it be allowed.

Yes. I know and agree with all of the above.

> But for the user in BPF C it will be the same nf_conn. The verifier
> can enforce different semantics on the underlying type's usage in
> kfuncs etc, while the user performs normal direct access to the
> nf_conn.
> 
> It will be the same case here, except you also introduce the case of
> kfuncs that are 'polymorphic' and can take both. Relaxing
> 'strict_type_match' for that arg and placing the type of member you
> wish to convert the pointer to gives you such polymorphism. But it's
> not correct to do for nf_conn___init to nf_conn, at least not by
> default.

Yes. Agree. I used unfortunate example in the previous reply with nf_conn___init.
I meant to say:

 For definition:
 struct nf_conn_init {
    struct nf_conn ct;
 };
 if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn_init
 for both read and write, because in C that's valid and safe type cast.

Meainng that C rules apply.
Our triple underscore is special, because it's the "same type".
In the 2nd part of my reply I'm proposing to use the whole suffix "___init" to indicate that.
I think you're arguing that just "___" part is enough to enforce strict match.
Matching foo___flavor with foo should not be allowed.
While passing struct foo_flavor {struct foo;} into a kfunc that accepts 'struct foo'
is safe.
If so, I'm fine with such approach.
