Return-Path: <bpf+bounces-27672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382318B0889
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9B51C233E3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63B15A4B4;
	Wed, 24 Apr 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVKztNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AC15A4A4
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959096; cv=none; b=cWILqF8WLdlKz//uwsDMdAFzURlxLKfQS//CftjWLrg+mUAPe07NAr+GQBbyP0ontcY0kMU9MX+pEmPfG3/KnFGEFhO2LDBOBZeo7I3vd6d3uorUzctCiU+XiKpP+Lc6OFeV8u/eib3r2pXNh7e9DWwUFJdrIHmmkUtqfcVOPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959096; c=relaxed/simple;
	bh=4nslSm9HwjNkRGbF5xMmFDYbYcTTmY8u18BliXqIM84=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIP2hFbMxnfhHx3YnrgFbK7SNZUgXLnn9+jaRbI6ziP5V/UTwfc4D5TuYRRdfC/7rTPgy0aWeaIxh1GwayGV+zDREcgKKVccy+QLTzziXM8E4xBAjPGcZyRR4e+HDBwmNczEgdG2GlW959QWjnGEasmDn0TvvDDD+GagkouxKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYVKztNo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5873c52f10so308157966b.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959093; x=1714563893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4V3FnC/MfE+QLpr/chXJ9YexKEqeVm5WfNgoOGd4jhY=;
        b=FYVKztNoz74jro6d8gxkU4nMntIyDFrbGzyM9/Tp8EISFQEV3BZdTjHa0QuNHqlkNv
         Uxn9CJ3hfY5jKqLQbk5ySgDIquOANeMGdXnNfOkOq93MtZQ4M4AD1IyY93yx8ufUEerR
         V38fWIf7ON2J00dHR5wEUnEpPebIW4n+2eSZAhjYzyTux1f1BWkMduRmNIz78NLrneDT
         7oQ1ai6iN0adg15FluqsVnfMimasqUxmCLx3eG5IBJsJOJ2rcVVL/JjOSEFuEirTF66H
         rZAR9+YPx+Zc/JxCyn+6M4058C3IymNT7yT968H5cTKCn7jperrvRQskTpnjz1VPwqny
         3NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959093; x=1714563893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4V3FnC/MfE+QLpr/chXJ9YexKEqeVm5WfNgoOGd4jhY=;
        b=J9BVTfHth2teLef1DS/yAmVlyGRPG9h2iOtzqccKAKovz9GySjw8Fn01PfzyjyOoH8
         iGsFAw6F1LdCMXISmfDR500TnUO+862wtPloYVDI4HKo4dmqZNBi0//WwH9bmCNulX0w
         V4aHl28TCzC+9RiINkrqgXkWjWkHOJETgAsNmN8j7I+VUJCcjW5h0WlMeI1t2cGEZjp0
         lU30ir51jySrf+W+CCzPcza2R1GDElRqLbQ8Ifq3y1gXRHngywjsGI23jsOFW72F1QYa
         iYZdIAmiPZeOx1EMS9rrXQ9AkpgFHJfdlPHZHTEQ5+jh27Z5BGU4BGeuNOlN3xyYzWVa
         qOmA==
X-Forwarded-Encrypted: i=1; AJvYcCUj24WCrkiOWyTC2Egx/12wL1fMP25fWNYWGJ/UX5np0oU1Wt0pAOfZYTvQM6Xib7ftsJxHXADit2ttT6apSZjX8En4
X-Gm-Message-State: AOJu0YwFhOcd8xWWeJRtrQ4TimLtdqvHZyuJgJHX/FvwKGZrFx0QQBcK
	t4lgqsOaqFL9GUQU6m50ublRxXQuEpUWJhGGlwipd+B1m9uQtx6K
X-Google-Smtp-Source: AGHT+IG7M7JbU1eMuLX22fPa8EvdzapoDDlewH6rxsUfki6KraU7TK3GbK/QUKpaHM9nQQjl/zcZvQ==
X-Received: by 2002:a17:906:a214:b0:a58:73f0:4d1a with SMTP id r20-20020a170906a21400b00a5873f04d1amr1349807ejy.70.1713959092759;
        Wed, 24 Apr 2024 04:44:52 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qt3-20020a170906ece300b00a5887fed95dsm1257251ejb.2.2024.04.24.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:44:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:44:50 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add kprobe multi session test
Message-ID: <ZijwsrKWCbo57vUE@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-7-jolsa@kernel.org>
 <CAEf4Bza2oReiAMhO3bUwP9LmdQ=+u98gEd2Vz_zGmB1PUVi4-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza2oReiAMhO3bUwP9LmdQ=+u98gEd2Vz_zGmB1PUVi4-Q@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:27:14PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 51628455b6f5..d1f116665551 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -4,6 +4,7 @@
> >  #include "trace_helpers.h"
> >  #include "kprobe_multi_empty.skel.h"
> >  #include "kprobe_multi_override.skel.h"
> > +#include "kprobe_multi_session.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "bpf/hashmap.h"
> >
> > @@ -326,6 +327,52 @@ static void test_attach_api_fails(void)
> >         kprobe_multi__destroy(skel);
> >  }
> >
> > +static void test_session_skel_api(void)
> > +{
> > +       struct kprobe_multi_session *skel = NULL;
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       struct bpf_link *link = NULL;
> > +       int err, prog_fd;
> > +
> > +       skel = kprobe_multi_session__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_session__open_and_load"))
> > +               goto cleanup;
> 
> return?

ok

> 
> > +
> > +       skel->bss->pid = getpid();
> > +
> > +       err =  kprobe_multi_session__attach(skel);
> 
> nit: extra space
> 
> > +       if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
> > +               goto cleanup;
> > +
> > +       prog_fd = bpf_program__fd(skel->progs.trigger);
> > +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +       ASSERT_OK(err, "test_run");
> > +       ASSERT_EQ(topts.retval, 0, "test_run");
> > +
> > +       ASSERT_EQ(skel->bss->kprobe_test1_result, 1, "kprobe_test1_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test2_result, 1, "kprobe_test2_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test3_result, 1, "kprobe_test3_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test4_result, 1, "kprobe_test4_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test5_result, 1, "kprobe_test5_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test6_result, 1, "kprobe_test6_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test7_result, 1, "kprobe_test7_result");
> > +       ASSERT_EQ(skel->bss->kprobe_test8_result, 1, "kprobe_test8_result");
> > +
> > +       ASSERT_EQ(skel->bss->kretprobe_test1_result, 0, "kretprobe_test1_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test2_result, 1, "kretprobe_test2_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test3_result, 0, "kretprobe_test3_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test4_result, 1, "kretprobe_test4_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test5_result, 0, "kretprobe_test5_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test6_result, 1, "kretprobe_test6_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test7_result, 0, "kretprobe_test7_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_test8_result, 1, "kretprobe_test8_result");
> 
> see below, even if array of ksym ptrs idea doesn't work out, at least
> results can be an array (which is cleaner to work with both on BPF and
> user space sides)

I recall in past we used to do that and we switched to specific values
to be more explicit I guess.. but it might make sense in here, will try it 

SNIP

> > +static int session_check(void *ctx, bool is_return)
> > +{
> > +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> > +               return 1;
> > +
> > +       __u64 addr = bpf_get_func_ip(ctx);
> > +
> > +#define SET(__var, __addr) ({                  \
> > +       if ((const void *) addr == __addr)      \
> > +               __var = 1;                      \
> > +})
> > +
> > +       if (is_return) {
> > +               SET(kretprobe_test1_result, &bpf_fentry_test1);
> > +               SET(kretprobe_test2_result, &bpf_fentry_test2);
> > +               SET(kretprobe_test3_result, &bpf_fentry_test3);
> > +               SET(kretprobe_test4_result, &bpf_fentry_test4);
> > +               SET(kretprobe_test5_result, &bpf_fentry_test5);
> > +               SET(kretprobe_test6_result, &bpf_fentry_test6);
> > +               SET(kretprobe_test7_result, &bpf_fentry_test7);
> > +               SET(kretprobe_test8_result, &bpf_fentry_test8);
> > +       } else {
> > +               SET(kprobe_test1_result, &bpf_fentry_test1);
> > +               SET(kprobe_test2_result, &bpf_fentry_test2);
> > +               SET(kprobe_test3_result, &bpf_fentry_test3);
> > +               SET(kprobe_test4_result, &bpf_fentry_test4);
> > +               SET(kprobe_test5_result, &bpf_fentry_test5);
> > +               SET(kprobe_test6_result, &bpf_fentry_test6);
> > +               SET(kprobe_test7_result, &bpf_fentry_test7);
> > +               SET(kprobe_test8_result, &bpf_fentry_test8);
> > +       }
> > +
> > +#undef SET
> 
> curious, have you tried implementing this through a proper for loop? I
> wonder if something like
> 
> void *kfuncs[] = { &bpf_fentry_test1, ..., &bpf_fentry_test8 };
> 
> and then generic loop over this array would work. Can you please try?

yep, will try, let's see if it gets nicer

jirka

