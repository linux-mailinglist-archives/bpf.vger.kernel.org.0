Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AF2AF9A4
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKUUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:20:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgKKUUD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 15:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605126001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kl1+EpU6WV2MSvXsPMxfpYfCyZuz1jV31Ln9/UIb1eo=;
        b=N+ILbglSK6mmgNYEvF5XZMsnr51xzXDy8q3EzK9B3Pqi8MlFtAlmT8KYd8Wkx/Q6lTzxHK
        GmakEYSRwmCsyyr2CDXidEwUFcon6KgY95G2DN+iLgtUK/7NnC3NvtVR4BGfcIskC/xjYH
        8m9O9SV+5uH6vh3A2R/CA/LimeL5Nz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-X7yYI2AXN3WDuMKwZ73a4w-1; Wed, 11 Nov 2020 15:20:00 -0500
X-MC-Unique: X7yYI2AXN3WDuMKwZ73a4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CCE2103098C;
        Wed, 11 Nov 2020 20:19:57 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B31176642;
        Wed, 11 Nov 2020 20:19:30 +0000 (UTC)
Date:   Wed, 11 Nov 2020 21:19:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201111201929.GB619201@krava>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 11:59:20AM -0800, Andrii Nakryiko wrote:

SNIP

> > +       if (!fl->init_bpf_begin &&
> > +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> > +               fl->init_bpf_begin = sym->st_value;
> > +
> > +       if (!fl->init_bpf_end &&
> > +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> > +               fl->init_bpf_end = sym->st_value;
> > +}
> > +
> > +static int has_all_symbols(struct funcs_layout *fl)
> > +{
> > +       return fl->mcount_start && fl->mcount_stop &&
> > +              fl->init_begin && fl->init_end &&
> > +              fl->init_bpf_begin && fl->init_bpf_end;
> 
> See below for what seems to be the root cause for the immediate problem.
> 
> But me, Alexei and Daniel had a discussion offline, and we concluded
> that this special bpf_preserve_init section is probably not the right
> approach overall. We should roll back the bpf patch and instead adjust
> pahole's approach. I think we should just drop the __init check and
> include all the __init functions into BTF. There could be cases where
> we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> security cases), so having BTFs for those FUNCs are necessary as well.
> Ftrace currently disallows that, but it's only because no user-space
> application has a way to attach probes early enough. This might change
> in the future, so there is no need to invent special mechanisms now
> for bpf_iter function preservation. Let's just include all __init
> functions in BTF. Can you please do that change and check how much
> more functions we get in BTF? Thanks!

sure, not problem to keep all init functions, will give you the count

SNIP

> >
> > +static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> > +{
> > +       struct parameter *param;
> > +       const char *name;
> > +
> > +       ftype__for_each_parameter(ftype, param) {
> > +               name = dwarves__active_loader->strings__ptr(cu, param->name);
> > +               if (name == NULL)
> > +                       return false;
> > +       }
> > +       return true;
> > +}
> > +
> 
> I suspect (but haven't verified) that the problem is in this function.
> If it happens that DWARF for a function has no arguments, then we'll
> conclude it has all arg names. Don't know what's the best solution
> here, but please double-check this.
> 
> Specifically, two selftests are failing now. One of them:
> 
> libbpf: load bpf program failed: Permission denied
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> arg#0 type is not a struct
> Unrecognized arg#0 type PTR
> ; int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> 0: (79) r6 = *(u64 *)(r1 +0)
> func 'security_inode_getattr' doesn't have 1-th argument
> invalid bpf_context access off=0 size=8
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> libbpf: -- END LOG --
> libbpf: failed to load program 'prog_stat'
> libbpf: failed to load object 'test_d_path'
> libbpf: failed to load BPF skeleton 'test_d_path': -4007
> test_d_path:FAIL:setup d_path skeleton failed
> #27 d_path:FAIL
> 
> This is because in generated BTF security_inode_getattr has a
> prototype void security_inode_getattr(void); And once we emit this
> prototype, due to logic in should_generate_function() we won't attempt
> to do it again, even for the prototype with the right arguments.

hum it works for me :-\

	#27 d_path:OK

with:

	[25962] FUNC_PROTO '(anon)' ret_type_id=17 vlen=1
		'path' type_id=729
	[31327] FUNC 'security_inode_getattr' type_id=25962 linkage=static


perhaps your gcc generates DWARF that breaks the way you described
above, but I'd expect to see function with argument without name,
not function without arguments at all

what gcc version are you on?

when you dump debug information, do you see security_inode_getattr
record with no arguments?

thanks,
jirka

