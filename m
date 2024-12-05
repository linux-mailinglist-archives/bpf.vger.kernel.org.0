Return-Path: <bpf+bounces-46189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E99E6183
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641A0283B60
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78991CEEA0;
	Thu,  5 Dec 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTeztsDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D349627
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733442671; cv=none; b=DkLPb7jW1xPnLA2/mBi/3046e6PXrhw9sUmQK6rG0btAbq5buaZhoJbgB/m3nWRFWu4JRihE3Oh/ZxHE4r8nKBDupjExemNwelovFLHcNPwJBm2QR6raEndFP6pEDXjewLkCMYo02G0y3adbjvpa2YMR6Ojm0cwk2lyQtbV29r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733442671; c=relaxed/simple;
	bh=sF4kHpwua/zZJGB2Jh7CYz/fZZ0FNNHdWoTIZmw4uos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9HM2n97uAdRVzqw07mQEAp+gDBzAnMUfdUEPnPOdi9/x8i+LES0qAr3zPJDSUJ3gssNWeA/RyfXNIfu0ya7ffjVN0hkFlGcSJ+pFhpDeMtlEw7nUQJba0z78BmZLs3ROOvlckR8HpLbAsH6ogs8DUqtJBk17weOq6z7nulu6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTeztsDl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724f0f6300aso1778584b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733442669; x=1734047469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WZAhxWSXfLoykAs8NuUk8iJKB+Wf7ER30olGHv3YyI=;
        b=WTeztsDlW9Ln97olFkiyzTK3QJnVCVxLvYGy2yj1ekvp26BWfytQAeTuenUvwZ9E5H
         K5VIlUsYI4bEIoN7u13UxT3NF8bIYgtePCfggF+2sSVBwLZuujDBEXaw5sNfP0MtW7nq
         Vpr9aepcAnS0NX0YkmeYUPv8UIVafgItZcHFY9KM7dmJCRwgxyDmwZ23IdTGVQcPHMZI
         azGK1LvOwtlbUgxG+GD/e1j+5Nr5TsEKH3rVcLApcDnHfHuDmyf9Q+QlVU+AVAqCKL2V
         chxDHCjvcGrF9AnxAOabjPGWs1G8mWsa+nH+WnoYRiEkWCb/v3k2SzNsrKb7I2lo4LB5
         hZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733442669; x=1734047469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WZAhxWSXfLoykAs8NuUk8iJKB+Wf7ER30olGHv3YyI=;
        b=PxZ8vnzvXvROxM0WiLSVfVJBg8zwu3xAPQGUVJU76SQyh6L10nTfENHEPPEILwGHw9
         b7AepI1+5qKZYQzU4pWRo6kV5C7HmMY0uVAwXvvjeJks5NlSwjhKmHUzXXI5hs15CYfa
         avdABFC11n+QjS7vamb6b3N3rZ0saYn4QseIT85VWDNl7eyOY2puxaH9v0hf9ceDK4Xo
         UxvdKtzK25QujkOzH7W1C0FmRZo4A+9sETXodH69+pf8dQARGtegfsTeSIgfwd2Jm6O4
         +09+s2/+hOyyzL0ZlTZVuwV/U08V84rqAIvMpbPRl1WbRQtEgAIaICNtxDPuzmeijHT/
         iqcQ==
X-Gm-Message-State: AOJu0Yw97b21gs+Hi4/tJGqsWx5XI8PjrkXDrhqVE9YXkwGLTRyTzL/p
	FwJKwodQC2JDxZXQT8baXAGC4GMhh/+9bOaeoQiSouGFOjdEWH1TlTL4++WYVF+bpvjHDI5o9YX
	R/mbswiMrWH3L6UbvDU1vq7NBO9g=
X-Gm-Gg: ASbGncuObJCtQhYyIq7qCz8mijojXGNVdyaUioTSgLD1dsY1O9Dgui7L57Ias7wDbIb
	XiSndE9Wa98RqJSL9boVEQWYp8d826nShBkjqfICYOxMroLA=
X-Google-Smtp-Source: AGHT+IEpQEo8PlpDD2nq3yI/YoJR42W8+fwrbt9HNQoN6QUt5CtBW5WhktqmUPrR/VPVoIPAZUek11Q/BQ4L8fb/hxU=
X-Received: by 2002:a17:90b:4f4b:b0:2ee:bc7b:924a with SMTP id
 98e67ed59e1d1-2ef6aaeeeb0mr1560806a91.28.1733442668878; Thu, 05 Dec 2024
 15:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205193404.629861-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241205193404.629861-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 15:50:57 -0800
Message-ID: <CAEf4BzbV-dt7vEmQ3yCdiVw5qBWE1WekY_Stoo+vf_3QUXOOgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add more stats into veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:34=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Extend veristat to collect and print more stats, namely:
> - program size in instructions
> - jited program size
> - program type
> - attach type
> - stack depth
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 51 +++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index e12ef953fba8..0d7fb00175e8 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -38,8 +38,14 @@ enum stat_id {
>         FILE_NAME,
>         PROG_NAME,
>
> +       SIZE,
> +       JITED_SIZE,
> +       STACK,
> +       PROG_TYPE,
> +       ATTACH_TYPE,
> +
>         ALL_STATS_CNT,
> -       NUM_STATS_CNT =3D FILE_NAME - VERDICT,
> +       NUM_STATS_CNT =3D ATTACH_TYPE - VERDICT + 1,

this doesn't sound right, because PROG_NAME isn't a number statistics

>  };
>
>  /* In comparison mode each stat can specify up to four different values:
> @@ -640,19 +646,22 @@ static int append_filter_file(const char *path)
>  }
>
>  static const struct stat_specs default_output_spec =3D {
> -       .spec_cnt =3D 7,
> +       .spec_cnt =3D 12,
>         .ids =3D {
>                 FILE_NAME, PROG_NAME, VERDICT, DURATION,
> -               TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
> +               TOTAL_INSNS, TOTAL_STATES, PEAK_STATES, SIZE,
> +               JITED_SIZE, PROG_TYPE, ATTACH_TYPE, STACK,

I think SIZE or JITED_SIZE might be good candidates for default view,
but not all of the above. I think we can also drop PEAK_STATES from
default, btw.

>         },
>  };
>
>  static const struct stat_specs default_csv_output_spec =3D {
> -       .spec_cnt =3D 9,
> +       .spec_cnt =3D 14,
>         .ids =3D {
>                 FILE_NAME, PROG_NAME, VERDICT, DURATION,
>                 TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>                 MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
> +               SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
> +               STACK,

this is fine, we want everything in CSV, yep

>         },
>  };
>
> @@ -688,6 +697,11 @@ static struct stat_def {
>         [PEAK_STATES] =3D { "Peak states", {"peak_states"}, },
>         [MAX_STATES_PER_INSN] =3D { "Max states per insn", {"max_states_p=
er_insn"}, },
>         [MARK_READ_MAX_LEN] =3D { "Max mark read length", {"max_mark_read=
_len", "mark_read"}, },
> +       [SIZE] =3D { "Prog size", {"prog_size", "size"}, },

drop "size" alias, it's too ambiguous?

> +       [JITED_SIZE] =3D { "Jited size", {"jited_size"}, },

this probably should be prog_size_jited or something like that (I
know, verbose, but unambiguous)

> +       [STACK] =3D {"Stack depth", {"stack_depth", "stack"}, },
> +       [PROG_TYPE] =3D { "Program type", {"program_type", "prog_type"}, =
},

let's drop "program_type", verbose

> +       [ATTACH_TYPE] =3D { "Attach type", {"attach_type", }, },
>  };
>
>  static bool parse_stat_id_var(const char *name, size_t len, int *id,
> @@ -853,13 +867,16 @@ static int parse_verif_log(char * const buf, size_t=
 buf_sz, struct verif_stats *
>
>                 if (1 =3D=3D sscanf(cur, "verification time %ld usec\n", =
&s->stats[DURATION]))
>                         continue;
> -               if (6 =3D=3D sscanf(cur, "processed %ld insns (limit %*d)=
 max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
> +               if (5 =3D=3D sscanf(cur, "processed %ld insns (limit %*d)=
 max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",

is this a preexisting bug? why we didn't catch it before?

>                                 &s->stats[TOTAL_INSNS],
>                                 &s->stats[MAX_STATES_PER_INSN],
>                                 &s->stats[TOTAL_STATES],
>                                 &s->stats[PEAK_STATES],
>                                 &s->stats[MARK_READ_MAX_LEN]))
>                         continue;
> +
> +               if (1 =3D=3D sscanf(cur, "stack depth %ld", &s->stats[STA=
CK]))

heh, not so simple, actually. stack depth is actually a list of stack
sizes for main program and each subprogram. Try

sudo ./veristat test_subprogs.bpf.o -v

stack depth 8+8+0+0+8+0

so we have to make some choices here, actually... we either parse that
and add up, and/or we parse all that and associate it with individual
subprograms.

I think we can start with the former, but the latter is actually
useful and quite tricky for humans to figure out because that order
depends on libbpf-controlled order of subprograms (which veristat can
get from btf_ext, I believe). Not sure if we need/want to record
by-subprog breakdown into CSV, but it would be useful to have a more
detailed breakdown by subprog in some verbose mode. Let's think about
that.

> +                       continue;
>         }
>
>         return 0;
> @@ -1146,8 +1163,11 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>         char *buf;
>         int buf_sz, log_level;
>         struct verif_stats *stats;
> +       struct bpf_prog_info info =3D {};

this should be initialized with memset(0)

> +       __u32 info_len =3D sizeof(info);
>         int err =3D 0;
>         void *tmp;
> +       int fd;
>
>         if (!should_process_file_prog(base_filename, bpf_program__name(pr=
og))) {
>                 env.progs_skipped++;
> @@ -1196,6 +1216,13 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>         stats->file_name =3D strdup(base_filename);
>         stats->prog_name =3D strdup(bpf_program__name(prog));
>         stats->stats[VERDICT] =3D err =3D=3D 0; /* 1 - success, 0 - failu=
re */
> +       stats->stats[SIZE] =3D bpf_program__insn_cnt(prog);
> +       stats->stats[PROG_TYPE] =3D bpf_program__type(prog);
> +       stats->stats[ATTACH_TYPE] =3D bpf_program__expected_attach_type(p=
rog);
> +       fd =3D bpf_program__fd(prog);
> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> +               stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +

please check that this is total length including all the subprogs

>         parse_verif_log(buf, buf_sz, stats);
>
>         if (env.verbose) {
> @@ -1309,6 +1336,11 @@ static int cmp_stat(const struct verif_stats *s1, =
const struct verif_stats *s2,
>         case PROG_NAME:
>                 cmp =3D strcmp(s1->prog_name, s2->prog_name);
>                 break;
> +       case ATTACH_TYPE:
> +       case PROG_TYPE:
> +       case SIZE:
> +       case JITED_SIZE:
> +       case STACK:
>         case VERDICT:
>         case DURATION:
>         case TOTAL_INSNS:
> @@ -1523,12 +1555,21 @@ static void prepare_value(const struct verif_stat=
s *s, enum stat_id id,
>                 else
>                         *str =3D s->stats[VERDICT] ? "success" : "failure=
";
>                 break;
> +       case ATTACH_TYPE:
> +               *str =3D s ? libbpf_bpf_attach_type_str(s->stats[ATTACH_T=
YPE]) ? : "N/A" : "N/A";
> +               break;
> +       case PROG_TYPE:
> +               *str =3D s ? libbpf_bpf_prog_type_str(s->stats[PROG_TYPE]=
) ? : "N/A" : "N/A";

let's not have x ? y ? z pattern, please do explicit outer if like we
do for VERDICT

pw-bot: cr

> +               break;
>         case DURATION:
>         case TOTAL_INSNS:
>         case TOTAL_STATES:
>         case PEAK_STATES:
>         case MAX_STATES_PER_INSN:
>         case MARK_READ_MAX_LEN:
> +       case STACK:
> +       case SIZE:
> +       case JITED_SIZE:
>                 *val =3D s ? s->stats[id] : 0;
>                 break;
>         default:
> --
> 2.47.1
>

