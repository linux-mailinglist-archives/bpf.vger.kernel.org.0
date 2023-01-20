Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BB674CAE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjATFmH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjATFl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:41:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB3AD3F;
        Thu, 19 Jan 2023 21:40:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so624686pjq.1;
        Thu, 19 Jan 2023 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOq/E+eWAxR3m2c7HHpMPBELzCOkd3FAZMP6lbhfN14=;
        b=qYljow2z7HCHKOpjOtpG3wPSdhrUCuI0s3F+vmd+uxt4ke3scB+XV6nNekqb8qnpoF
         q1BqqTSKMH7ERPohtcch+jgY3hAHWvClDZh8x4Kfha37jGrlmgK50aFIwnonCupS3XN/
         +iqN8cyHh8AZGj/JmIq6aaSrx40f8zVcVQYgHJZN289FLGuRBJsJjli4CslG5eMsgmxZ
         ikFkCSMK8vTN2m2CbnFsc6lBOx6tZeRsY1ObkuZjG9KBEPScDamarQlt8xizyI+N5YWd
         YOvaWUtazMEWJkGbZy1txeuFmf/vR+s1+fO9ou1T4u5XjFQnUcf06C73n3O/tXur6J3t
         sHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOq/E+eWAxR3m2c7HHpMPBELzCOkd3FAZMP6lbhfN14=;
        b=Au/RrBYocRDitdSLhjS+PsIxvraTBsw9GcEEbptpJSEOeg9jRF6avHp3Qr4FdiTpGT
         KEaE53P9Tlcr+ns0I7Q+eH2N9SOz/eWGt53AOo334HWyt36AeiHzajd0jEO96zhXLKzQ
         s6oXxhQ5cyQOQfL8dpf0zMouZY9aCnSBBG/9mrLAINmAwOTDYu+Z+OIf6UW74Nh7H1oP
         Y+YzupQNCgHBGD/j50KlTBujtNbU/F5SW+fJC/iCztPtZaZAGDKIO+KZmFEEgte+ldjW
         S2ThfKI4W/X0wAZbO0drgSKvHAm7GjSV/rRcgxzIEy/0N8Ax+4usFoOq/mbyqjy7HtRt
         F7Yg==
X-Gm-Message-State: AFqh2kpcegP2mldibHzg/R+JloxPzr1pvTFCZCXMMV1bzFDEhCmhxhKF
        4dVoK+xivByVFxox9bucZ6c=
X-Google-Smtp-Source: AMrXdXuDwJXY+VutahkW4qUmvB2nzoSoJ1elA/5uiyiVVm3MQxu+93x3xEDSBLEk1Ow47nczsT0eMQ==
X-Received: by 2002:a17:902:e5c9:b0:194:d0ad:53f0 with SMTP id u9-20020a170902e5c900b00194d0ad53f0mr6159588plf.9.1674193231756;
        Thu, 19 Jan 2023 21:40:31 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b0019479636f84sm11987243plx.11.2023.01.19.21.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:40:31 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:40:27 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
Message-ID: <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo>
 <Y8olRi9SjcyNtam0@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8olRi9SjcyNtam0@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 11:23:18PM -0600, David Vernet wrote:
> On Fri, Jan 20, 2023 at 10:28:15AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> > > When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> > > currently enforces that the top-level type must match when calling
> > > the kfunc. In other words, the verifier does not allow the BPF program
> > > to pass a bitwise equivalent struct, despite it being functionally safe.
> > > For example, if you have the following type:
> > >
> > > struct  nf_conn___init {
> > > 	struct nf_conn ct;
> > > };
> > >
> > > It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> > > struct nf_conn.
> > 
> > Just running bpf_nf selftest would have shown this is false.
> 
> And I feel silly, because I did run them, and could have sworn they
> passed...looking now at the change_status_after_alloc testcase I see
> you're of course correct. Very poor example, thank you for pointing it
> out.
> 
> > 
> > > Being able to do this will be useful for certain types
> > > of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> > > series of kfuncs will be added which allow programs to do bitwise
> > > queries on cpumasks that are either allocated by the program (in which
> > > case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> > > its first element), or a cpumask that was allocated by the main kernel
> > > (in which case it will just be a straight cpumask_t, as in
> > >  task->cpus_ptr).
> > >
> > > Having the two types of cpumasks allows us to distinguish between the
> > > two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> > > can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> > > cannot be. On the other hand, a struct bpf_cpumask can of course be
> > > queried in the exact same manner as a cpumask_t, with e.g.
> > > bpf_cpumask_test_cpu().
> > >
> > > If we were to enforce that top level types match, then a user that's
> > > passing a struct bpf_cpumask to a read-only cpumask_t argument would
> > > have to cast with something like bpf_cast_to_kern_ctx() (which itself
> > > would need to be updated to expect the alias, and currently it only
> > > accommodates a single alias per prog type). Additionally, not specifying
> > > KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> > > struct bpf_cpumask *, and another as a struct cpumask *
> > > (i.e. cpumask_t).
> > >
> > > In order to enable this, this patch relaxes the constraint that a
> > > KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> > > try and be conservative and match existing behavior / expectations, this
> > > patch also enforces strict type checking for acquire kfuncs. We were
> > > already enforcing it for release kfuncs, so this should also improve the
> > > consistency of the semantics for kfuncs.
> > >
> > 
> > What you want is to simply follow type at off = 0 (but still enforce the off = 0
> > requirement). This is something which is currently done for bpf_sk_release (for
> > struct sk_common) in check_reg_type, but it is not safe in general to just open
> > this up for all cases. I suggest encoding this particular requirement in the
> > argument, and simply using triple underscore variant of the type for the special
> > 'read_only' requirement. This will allow you to use same type in your BPF C
> > program, while allowing verifier to see them as two different types in kfunc
> > parameters. Then just relax type following for the particular argument so that
> > one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
> > it just visits first member after failing match on top level type). off = 0
> > check is still necessary.
> 
> Sigh, yeah, another ___ workaround but I agree it's probably the best we
> can do for now, and in general seems pretty useful. Obviously preferable
> to this patch which just doesn't work. Alexei, are you OK with this? If
> so, I'll take this approach for v2.

We decided to rely on strict type match when we introduced 'struct nf_conn___init',
but with that we twisted the C standard to, what looks to be, a wrong direction.

For definition:
struct nf_conn___init {
   struct nf_conn ct;
};
if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn__init
for both read and write, because in C that's valid and safe type cast.

We can fix this design issue by saying that '___init' suffix is special and
C type casting rules don't apply to it.
In all other cases bpf_cpumask/cpumask would should allow it.

__ro suffix idea will keep moving us into further discrepancies with C.
