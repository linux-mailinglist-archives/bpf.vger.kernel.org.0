Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF4674BD2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjATFLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjATFKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:10:46 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636A80BA4;
        Thu, 19 Jan 2023 20:58:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 7so3281413pga.1;
        Thu, 19 Jan 2023 20:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzzXUnHTmpWWQPG59F1wwVsrnIyCIw61BupAxQyJSRI=;
        b=XlMVGlWmbXFC4EGyZYr6w/6gn9tiEHouHtEfFMYEblbEPz8mfgM98o82W6rUe9xFIE
         NMW/o4YkPyD8QuswSHA7Jo43STK+AdpjSkFBIkV88zCEuEit53fiKj7lAUp0W/3fZcd9
         ClCL685nyt2y6O0WOPH+EgOqT+qVlAC6W5WgcpTxXnNYDNGWw+ztTXzmyklzvycsi+mO
         B2hydSgfIRIHv+lO/fTS0ghOkCPF8y5auQiDTvnNnqss34GwQ9ZGvurRMkkgB07BxiBY
         7/g9FzQ5HCWtiWY4JogyyOeu9cTLm/5cpWt3J83PR/DmXgU9xurpMXqclee9GCsRpk0z
         5MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzzXUnHTmpWWQPG59F1wwVsrnIyCIw61BupAxQyJSRI=;
        b=6gWZjl2qwpwUP+a/a+iK3vB1Id4RoWYTO4Sy5aGG3eBMg7s9edVZpisg1359lSHCZ1
         f1pWlL+Hqd3OLYRpKibyJN0Vimiyk4o1ouPkKyX3cxmFgHFvkvo+d9g06Grb2ONPmuZO
         NlYMpnM5dP4YxdGdj+VzOgu7DEbdNeaPrhtMpIcueaCWmelOhsft10CJCtrEFg6+jy1o
         hbabsTHQVi43IoVj3y8BQMzBn3sYIpdDWfsDeJP5+ubaKpb3mHc/uiqdB0JJVWkM+TO3
         mXOxxnu/bqTq9uLXiPwgeL9vZ8U+7ekB1R6RFCvzTRLC1L1ifYM1JH4Mtd+lMYcnZg/R
         kO2g==
X-Gm-Message-State: AFqh2kpImfjogIjMgdsgkIQTExo0K+Nm+MVp3S1AExGvFEMavdUHTAbZ
        nuTzZLzZ2MH9NE/ZNWUyzWo=
X-Google-Smtp-Source: AMrXdXuE0pUroe2ay/b/UQIYy0GzKBtrp0BNmCQllpLGRlB9bmI60JSEGPaDdhzvul10S8MMAVDmsQ==
X-Received: by 2002:a05:6a00:44cc:b0:58a:fdc8:92bf with SMTP id cv12-20020a056a0044cc00b0058afdc892bfmr13731244pfb.2.1674190699429;
        Thu, 19 Jan 2023 20:58:19 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id k18-20020a628412000000b0058103f45d9esm21717738pfd.82.2023.01.19.20.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:58:19 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:28:15 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
Message-ID: <20230120045815.4b7dc6obdt4uzy6a@apollo>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-3-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 05:28:27AM IST, David Vernet wrote:
> When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
> currently enforces that the top-level type must match when calling
> the kfunc. In other words, the verifier does not allow the BPF program
> to pass a bitwise equivalent struct, despite it being functionally safe.
> For example, if you have the following type:
>
> struct  nf_conn___init {
> 	struct nf_conn ct;
> };
>
> It would be safe to pass a struct nf_conn___init to a kfunc expecting a
> struct nf_conn.

Just running bpf_nf selftest would have shown this is false.

> Being able to do this will be useful for certain types
> of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
> series of kfuncs will be added which allow programs to do bitwise
> queries on cpumasks that are either allocated by the program (in which
> case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
> its first element), or a cpumask that was allocated by the main kernel
> (in which case it will just be a straight cpumask_t, as in
>  task->cpus_ptr).
>
> Having the two types of cpumasks allows us to distinguish between the
> two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
> can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
> cannot be. On the other hand, a struct bpf_cpumask can of course be
> queried in the exact same manner as a cpumask_t, with e.g.
> bpf_cpumask_test_cpu().
>
> If we were to enforce that top level types match, then a user that's
> passing a struct bpf_cpumask to a read-only cpumask_t argument would
> have to cast with something like bpf_cast_to_kern_ctx() (which itself
> would need to be updated to expect the alias, and currently it only
> accommodates a single alias per prog type). Additionally, not specifying
> KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
> struct bpf_cpumask *, and another as a struct cpumask *
> (i.e. cpumask_t).
>
> In order to enable this, this patch relaxes the constraint that a
> KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
> try and be conservative and match existing behavior / expectations, this
> patch also enforces strict type checking for acquire kfuncs. We were
> already enforcing it for release kfuncs, so this should also improve the
> consistency of the semantics for kfuncs.
>

What you want is to simply follow type at off = 0 (but still enforce the off = 0
requirement). This is something which is currently done for bpf_sk_release (for
struct sk_common) in check_reg_type, but it is not safe in general to just open
this up for all cases. I suggest encoding this particular requirement in the
argument, and simply using triple underscore variant of the type for the special
'read_only' requirement. This will allow you to use same type in your BPF C
program, while allowing verifier to see them as two different types in kfunc
parameters. Then just relax type following for the particular argument so that
one can pass cpumask_t___ro to kfunc expecting cpumask_t (but only at off = 0,
it just visits first member after failing match on top level type). off = 0
check is still necessary.

So offset checks still need to be according to OBJ_RELEASE but you can relax
strict_type_match bool for the particular arg when calling btf_struct_ids_match.

All code in your tests will then deal with a cpumask_t type only, including in
kfunc declarations. Same as bpf_nf selftests which don't cast from/to
nf_conn___init and only deal with nf_conn pointers even though semantics differ
depending on how it is used and passed around. Overall more convenient and
simple to use.
