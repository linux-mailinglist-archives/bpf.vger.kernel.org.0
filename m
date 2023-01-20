Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187B674C47
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjATF2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjATF1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:27:55 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13C4ABCB;
        Thu, 19 Jan 2023 21:23:16 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id i12so3155144qvs.2;
        Thu, 19 Jan 2023 21:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHPXPC0BMX6sTs60Cw/eJV++Bo/jj1HUB4gDhIXLxjc=;
        b=y4e+82k89Fc9lHpt69n0XF2PVgrSWKz4iSysAmiFBjXAWNIwZ6ZDOrgFU1l3C6pX/e
         ejyOkToUJgTqnCpL0/Jp5SltSjB/9CVELfvStOi3GADnprDlGWognv3bchIg3cA6+5tc
         c6WWb7E1TODMGzWn4Xe75VLPrJp1XJ0YHG48+Pqi85kY1oxY/KX7c12gIHjzZcn1TAYd
         aDbWPI9MOzwdsHj7HBjqvyjMsbwQD/sWGueLMQ0QpnjKzdpJxf+I2WxCa9RqiPlFHo2I
         sOAtOdZ9cmFem+N6aIEMIWxi7K3s2JfFz6PKavMDFgc/2Ctc/T4+/L3y9BtyKACjVQzk
         8yVw==
X-Gm-Message-State: AFqh2kovqd1LIbmQwv0MDJZtwSXeuFfyyvC8CKrwOzA/Ln7gdUJf7mlW
        UVvpLyILrZijtEDCcLZUpX3olUEQA/aE2qFR
X-Google-Smtp-Source: AMrXdXur3UYcJqIQnvqtkk3dTTuzhe2hJHvV5HBY+uFXJ94Y7/MAi18vNtaPzwOYQmt0O7aAgg7AcQ==
X-Received: by 2002:a0c:e042:0:b0:4c7:6119:a7fc with SMTP id y2-20020a0ce042000000b004c76119a7fcmr49954520qvk.40.1674192195045;
        Thu, 19 Jan 2023 21:23:15 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id l14-20020a05620a28ce00b007062139ecb3sm13990130qkp.95.2023.01.19.21.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:23:14 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:23:18 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
Message-ID: <Y8olRi9SjcyNtam0@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120045815.4b7dc6obdt4uzy6a@apollo>
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

On Fri, Jan 20, 2023 at 10:28:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> > When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> > currently enforces that the top-level type must match when calling
> > the kfunc. In other words, the verifier does not allow the BPF program
> > to pass a bitwise equivalent struct, despite it being functionally safe.
> > For example, if you have the following type:
> >
> > struct  nf_conn___init {
> > 	struct nf_conn ct;
> > };
> >
> > It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> > struct nf_conn.
> 
> Just running bpf_nf selftest would have shown this is false.

And I feel silly, because I did run them, and could have sworn they
passed...looking now at the change_status_after_alloc testcase I see
you're of course correct. Very poor example, thank you for pointing it
out.

> 
> > Being able to do this will be useful for certain types
> > of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> > series of kfuncs will be added which allow programs to do bitwise
> > queries on cpumasks that are either allocated by the program (in which
> > case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> > its first element), or a cpumask that was allocated by the main kernel
> > (in which case it will just be a straight cpumask_t, as in
> >  task->cpus_ptr).
> >
> > Having the two types of cpumasks allows us to distinguish between the
> > two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> > can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> > cannot be. On the other hand, a struct bpf_cpumask can of course be
> > queried in the exact same manner as a cpumask_t, with e.g.
> > bpf_cpumask_test_cpu().
> >
> > If we were to enforce that top level types match, then a user that's
> > passing a struct bpf_cpumask to a read-only cpumask_t argument would
> > have to cast with something like bpf_cast_to_kern_ctx() (which itself
> > would need to be updated to expect the alias, and currently it only
> > accommodates a single alias per prog type). Additionally, not specifying
> > KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> > struct bpf_cpumask *, and another as a struct cpumask *
> > (i.e. cpumask_t).
> >
> > In order to enable this, this patch relaxes the constraint that a
> > KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> > try and be conservative and match existing behavior / expectations, this
> > patch also enforces strict type checking for acquire kfuncs. We were
> > already enforcing it for release kfuncs, so this should also improve the
> > consistency of the semantics for kfuncs.
> >
> 
> What you want is to simply follow type at off = 0 (but still enforce the off = 0
> requirement). This is something which is currently done for bpf_sk_release (for
> struct sk_common) in check_reg_type, but it is not safe in general to just open
> this up for all cases. I suggest encoding this particular requirement in the
> argument, and simply using triple underscore variant of the type for the special
> 'read_only' requirement. This will allow you to use same type in your BPF C
> program, while allowing verifier to see them as two different types in kfunc
> parameters. Then just relax type following for the particular argument so that
> one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
> it just visits first member after failing match on top level type). off = 0
> check is still necessary.

Sigh, yeah, another ___ workaround but I agree it's probably the best we
can do for now, and in general seems pretty useful. Obviously preferable
to this patch which just doesn't work. Alexei, are you OK with this? If
so, I'll take this approach for v2.

> 
> So offset checks still need to be according to OBJ_RELEASE but you can relax
> strict_type_match bool for the particular arg when calling btf_struct_ids_match.
> 
> All code in your tests will then deal with a cpumask_t type only, including in
> kfunc declarations. Same as bpf_nf selftests which don't cast from/to
> nf_conn___init and only deal with nf_conn pointers even though semantics differ
> depending on how it is used and passed around. Overall more convenient and
> simple to use.
