Return-Path: <bpf+bounces-74539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C72C5ED78
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB4324F6AC5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6B33E352;
	Fri, 14 Nov 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxsqXnlF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B0346E69
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144321; cv=none; b=WPVKIzVzTcA0aA3qZ8uSvB4SYoncZXVmsfH3Mfqn3MKjvQ7Zpox2FANrzSwDyzVNNpx4g+i9YxMSqyXlhtSFa1h05rS/Q28XHwdyUKkJu68X0gr/MiqtMq9U+sJQgCbXEwEaXgz8byDEQ6zUQCTMURMfDCbtkz1JmI+8nZs13oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144321; c=relaxed/simple;
	bh=hwXc30euJwlR+uhUVA4FPEnI1Xv55xDSMtUH+BPRUnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCDgnf97hGx/FCvQ6reSunUZhuLWWFsr+6OgnMgNGllt8WNHt8iLgr/bo7h1vDYAbPKSKXorm3QnPFiL3RXMdUW9mNBq/AG0NObDND5oRj+GkK+gTIKn1KKwiXpVMHtX1BwU/CAUEioaESCT0oBmyPCnekERTDS0M7uqKfIrnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxsqXnlF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so14525ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763144319; x=1763749119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KzP+NemwGcSP2u7s3rN3i0Z2CyQQNEEBl1VA/yfTqw=;
        b=OxsqXnlFc6hkUON6m4qb0PkYb1gNfjLDjc4Cds5E9wD1qiLq4IS8c16AnbjpKZwUif
         kqSmK2x+NGbX9NsocThwPT0ZzVG2wrfQAMPk4t530r0Hk01ViJQ9vUYSJecIew+UeOPA
         2piC8bbMYC25clw8taWJl+ZQCf5vxeB81mdq3rXp62j1sWeOJ/oLD/zfEU/T7tPrARiw
         XAlobTECZxLfEHEAwmTfIDBkx9+NfpINqgIq2Oeys0CacrPE94GZSAKvwPJoidvc67Oc
         39U6VSbWnyDvI0T0QpQT5dSBlEScbaE4TFW2aFjHciTmjo6StGLLB8nVasPGQTPCP6WX
         j2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144319; x=1763749119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KzP+NemwGcSP2u7s3rN3i0Z2CyQQNEEBl1VA/yfTqw=;
        b=IC0fFXZmm2524buFd/Aw7g27DO2Tdx8V3OAxnkMfxneN8L9gjQ1vo7GDO3cqYK0syI
         VBVht7ik5x0Yh/m8ODLQXIcj6G/0CckJFxXqIL6mnarXy3qo+y/bEBfCYSPQKeII7Z1h
         lWfGo61YhRKdFW7jS1lmu8Wn6FO1QVVePiGGJGSMJFyE1sDVVJPG7MCyCwoFNtpq2xAv
         IFWsRK305WAIBJjQGrVmbV5cSRITHUtAzvRnhv6+rIk38gcHkysK8SShsS2eKUiKR4sZ
         qLPVCpaK/F6u6b3WjU7eqDZYWhK3igfxmsbwy91hnpSHqO65RerPo1mJeLRaGp7sGnlt
         JGUg==
X-Forwarded-Encrypted: i=1; AJvYcCXHEq6P894GGjTSbRl+L0vOarN3hfJqPkqpes/rjm/dbX37NZw91dExmXWpsRzw5Xsm46s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCG9mDHipmKKQrLwER6mG5S6UZ7F1Y03robCduQK2ZVtzu9QC
	nRqxzmPrDcwJhtLQhWyoGHtVx8OYDsiGKT7Aj86G4hWlLMdSHMkfP+YvHqFU7Dm9r4TllZo7El9
	5eeS3aueK9H8t8p/7mh5QAhOcausshj7fObjKszcE
X-Gm-Gg: ASbGncvohsiw+ogXVceeOAOAPtI5eGLPfI26I13362Jpm0jbgiXh7En0D9cz4W6ybxt
	FjFhk4EXd7K+ucHvVmNFlgS3gRaJVQOKis1d+i1ICftpb3d1ssnxnz9tBlcbiwLMVfKuvjI2+ia
	7K0Q954Y1oBA/hyDnMJ0P+Uq/vTO3GCq8CT51lj73+/kHHBvZ+zrHJpJFj7O+MLRCgy+4R+iOh2
	TCuH1GYJFOAayWp5KHQJptMk+lghVcgqmFuUiYoKqnETlQW1LGTdAhGs8U0r5zuQsVzDKDkogtc
	sLJz+Z610fm7LNqiIYkBeZ66
X-Google-Smtp-Source: AGHT+IFw2SsmHcPYSfaITCH61/lfAwZOX4Ie+CiVqPf7I1wEfaQvcVeeHyjIYn31Ou3HmV7slqOGTtRNXXFTFSilGb8=
X-Received: by 2002:a17:903:1a68:b0:295:5405:46be with SMTP id
 d9443c01a7336-299c6bb2635mr22845ad.1.1763144319029; Fri, 14 Nov 2025 10:18:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-5-namhyung@kernel.org>
In-Reply-To: <20251114070018.160330-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:18:27 -0800
X-Gm-Features: AWmQ_blIn9FPzbqWVrNRIeh4sCUbVi7z3bYxmWUsnQiKhuY7T4bQSxWY7IG1-gQ
Message-ID: <CAP-5=fUWcmi3VfYb92+ndTse1p+=jkb4B0AS3WnAucX7kgAkRA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Handle the deferred callchains in the script output.
>
>   $ perf script
>   ...
>   pwd    2312   121.163435:     249113 cpu/cycles/P:
>           ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsym=
s])
>           ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
>           ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
>           ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
>           ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
>           ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
>           ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.k=
allsyms])
>                  b00000006 [unknown] ([unknown])

Does this unknown value correspond to the cookie? Can the cookie and
deferred data be added to the kernel stack trace output?

>   pwd    2312   121.163447: DEFERRED CALLCHAIN
>               7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x=
86-64.so.2)
>               7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/l=
d-linux-x86-64.so.2)
>               7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-l=
inux-x86-64.so.2)

Can we display the cookie here so that the user callchain can be
matched with the kernel part?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-script.c | 89 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index cf0040bbaba9cbc9..3b2896350bad2924 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2719,6 +2719,93 @@ static int process_sample_event(const struct perf_=
tool *tool,
>         return ret;
>  }
>
> +static int process_deferred_sample_event(const struct perf_tool *tool,
> +                                        union perf_event *event,
> +                                        struct perf_sample *sample,
> +                                        struct evsel *evsel,
> +                                        struct machine *machine)
> +{
> +       struct perf_script *scr =3D container_of(tool, struct perf_script=
, tool);
> +       struct perf_event_attr *attr =3D &evsel->core.attr;
> +       struct evsel_script *es =3D evsel->priv;
> +       unsigned int type =3D output_type(attr->type);
> +       struct addr_location al;
> +       FILE *fp =3D es->fp;
> +       int ret =3D 0;
> +
> +       if (output[type].fields =3D=3D 0)
> +               return 0;
> +
> +       /* Set thread to NULL to indicate addr_al and al are not initiali=
zed */
> +       addr_location__init(&al);
> +
> +       if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_nu=
m,
> +                                         sample->time)) {
> +               goto out_put;
> +       }
> +
> +       if (debug_mode) {
> +               if (sample->time < last_timestamp) {
> +                       pr_err("Samples misordered, previous: %" PRIu64
> +                               " this: %" PRIu64 "\n", last_timestamp,
> +                               sample->time);
> +                       nr_unordered++;
> +               }
> +               last_timestamp =3D sample->time;
> +               goto out_put;
> +       }
> +
> +       if (filter_cpu(sample))
> +               goto out_put;
> +
> +       if (machine__resolve(machine, &al, sample) < 0) {
> +               pr_err("problem processing %d event, skipping it.\n",
> +                      event->header.type);
> +               ret =3D -1;
> +               goto out_put;
> +       }
> +
> +       if (al.filtered)
> +               goto out_put;
> +
> +       if (!show_event(sample, evsel, al.thread, &al, NULL))
> +               goto out_put;
> +
> +       if (evswitch__discard(&scr->evswitch, evsel))
> +               goto out_put;
> +
> +       perf_sample__fprintf_start(scr, sample, al.thread, evsel,
> +                                  PERF_RECORD_CALLCHAIN_DEFERRED, fp);
> +       fprintf(fp, "DEFERRED CALLCHAIN");
> +
> +       if (PRINT_FIELD(IP)) {
> +               struct callchain_cursor *cursor =3D NULL;
> +
> +               if (symbol_conf.use_callchain && sample->callchain) {
> +                       cursor =3D get_tls_callchain_cursor();
> +                       if (thread__resolve_callchain(al.thread, cursor, =
evsel,
> +                                                     sample, NULL, NULL,
> +                                                     scripting_max_stack=
)) {
> +                               pr_info("cannot resolve deferred callchai=
ns\n");
> +                               cursor =3D NULL;
> +                       }
> +               }
> +
> +               fputc(cursor ? '\n' : ' ', fp);
> +               sample__fprintf_sym(sample, &al, 0, output[type].print_ip=
_opts,
> +                                   cursor, symbol_conf.bt_stop_list, fp)=
;
> +       }
> +
> +       fprintf(fp, "\n");
> +
> +       if (verbose > 0)
> +               fflush(fp);
> +
> +out_put:
> +       addr_location__exit(&al);
> +       return ret;
> +}
> +
>  // Used when scr->per_event_dump is not set
>  static struct evsel_script es_stdout;
>
> @@ -4320,6 +4407,7 @@ int cmd_script(int argc, const char **argv)
>
>         perf_tool__init(&script.tool, !unsorted_dump);
>         script.tool.sample               =3D process_sample_event;
> +       script.tool.callchain_deferred   =3D process_deferred_sample_even=
t;
>         script.tool.mmap                 =3D perf_event__process_mmap;
>         script.tool.mmap2                =3D perf_event__process_mmap2;
>         script.tool.comm                 =3D perf_event__process_comm;
> @@ -4346,6 +4434,7 @@ int cmd_script(int argc, const char **argv)
>         script.tool.throttle             =3D process_throttle_event;
>         script.tool.unthrottle           =3D process_throttle_event;
>         script.tool.ordering_requires_timestamps =3D true;
> +       script.tool.merge_deferred_callchains =3D false;
>         session =3D perf_session__new(&data, &script.tool);
>         if (IS_ERR(session))
>                 return PTR_ERR(session);
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
>

