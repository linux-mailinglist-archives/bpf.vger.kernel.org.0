Return-Path: <bpf+bounces-46332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8F9E7BC0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BDF16B0B1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CD213E9F;
	Fri,  6 Dec 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhX0nqKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167E1F9F4C
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523970; cv=none; b=ro5yHReDAL3+BRvILoh/ZkhI6ZAUzfPMrHT9TxoBkMQZ0V1qdCI8GP/QtIiAR/7vj3axlMwd6+FeAuKvLN5dJtcIQwyG9eVRj9olvjJiebCZb0jdk1z+/QMXrPpWXJo/m/rl11KsBvYek3QBkiBxoSxlcVufvcBRCsRRdIKvQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523970; c=relaxed/simple;
	bh=wx5DyUfp8gFzCO0B8kvdPRezfvVlAjuCKBU9xcV5PcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmpReWunugxPeRNb5lAUenH0Fgp6cVEYJ9hIcSu0HdEnC6YJvESA4AQV1o2Taq8M+pEpDktjUwdG1osx7V/mHFPEXgCrMde/pqVc9Pa1FqIVdVvwLSTJCJJx9pmFZ72uDvQezJ7Tc1hGRVWVO7VNeKveW5iErrza8Aihe35yEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhX0nqKM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef748105deso750450a91.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733523968; x=1734128768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4ZFsahDylvXlMTP275LKbeb1NR2ehMQaLe3EMEb6gM=;
        b=RhX0nqKMqhGHUVhDqHPiXH+IPRfv/d9kyUeRhlAv4Na25M7LQzTFhjIzrE1iwkp2Y6
         JjLDqLEenlXvyD+kI1r0IAYV7JZlD+oIvR+Py8xXAjWp1UQ9MUFiAFXI7LoXkKkybLp/
         K90lRsxkJg3jGHZ8HFHunHLerFVvFbwWjInPlmAYhVK1Hzd7hhfAZVMjqhPPM+oArCGJ
         hd2VALD1EAIqn+fJx4X99kJ/2U8/Uxe3dPOSxqJalok9QcVvbua58BdWXhfmgJnhB596
         q39NbunoFkz2MwffgAnPz0kX9WoMFerSc97NvR/G+ah5dpt+KJa6dOmM/O+rgyoiufQF
         CZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523968; x=1734128768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4ZFsahDylvXlMTP275LKbeb1NR2ehMQaLe3EMEb6gM=;
        b=qJ5BhQptqLJlI+qD6e1EqUAZw6wDSIT3U1/Fkku7oS4Uhcxnkzz3sHyK4phR9I2zW+
         g4AcT9pJn0rD2FTSNUxf8h1RhVIlm4OAaEEkngTz970UvEAnPwr74j0cshh8o6eLxqRO
         iRA0Dio7hmyEvK34lCwfFBo6daqEnHk4KtSH/UqTruJdlDPjBM9Wbkmwn9zqICGkB0yw
         5gRZeqGQpjzo0gfmXrrSnCRMzDP8qFCIXlyz0WDqq8Tp/uCMnWWT92y89Rrf0OQc8Ouh
         tQ0O1QMNBIjquxeN0Anu4bIgPIxL2oIYfXIXLTn0rGsVtFROxmLiDSqQq4TPUb+y5d5y
         03eg==
X-Gm-Message-State: AOJu0YwCvnEPtavngdaKlpGUWdSSvJtRaUoHQJ3ldU9O1SBvFhrDbYPT
	TWRT+bgBUurLFZ1q7kmTnNeayTv6QDaNtciLBCcys8awGsvHpQRnP+ZBKyhWWvB/aeAEd9PvPQU
	xxg7ptfIcmSU57sX8slZniLcz/Vc=
X-Gm-Gg: ASbGncsTX2AIP56FtJ43VmCyMhc7eD/E2i17ZAydCWr+WJVcYEcIwBa8z6gMBk3HXcz
	YkIdiFeN7pwqfRrApSgZp9/opgNTg30Z5gus0mRzfGti2nu8=
X-Google-Smtp-Source: AGHT+IHajEUz57FEEBx7k7iab0bXbpTkMudl4S/oRjBlzuoJBMlWfiy/Ikfd0ezAzNetee6zQq8LDhyvT+28vt4KZu8=
X-Received: by 2002:a17:90a:c88f:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2ef69f0b077mr7135071a91.12.1733523968536; Fri, 06 Dec 2024
 14:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206134929.89997-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241206134929.89997-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 14:25:56 -0800
Message-ID: <CAEf4Bzb+D9W31gE=fQ3Pk+7k__Xec00N45wip_hA-GmwUv=vTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add more stats into veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 5:51=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Extend veristat to collect and print more stats, namely:
>   - program size in instructions
>   - jited program size in bytes
>   - program type
>   - attach type
>   - stack depth
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 68 +++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 6 deletions(-)
>

looks good besides the PATH_MAX use, let's fix that (plus a few
nitpicks with style).

pw-bot: cr

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index e12ef953fba8..cda8c83ebf24 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c

[...]

> @@ -688,6 +698,11 @@ static struct stat_def {
>         [PEAK_STATES] =3D { "Peak states", {"peak_states"}, },
>         [MAX_STATES_PER_INSN] =3D { "Max states per insn", {"max_states_p=
er_insn"}, },
>         [MARK_READ_MAX_LEN] =3D { "Max mark read length", {"max_mark_read=
_len", "mark_read"}, },
> +       [SIZE] =3D { "Prog size", {"prog_size"}, },

nit: "Prog size" -> "Program size", this is UI ;)

> +       [JITED_SIZE] =3D { "Jited size", {"prog_size_jited"}, },
> +       [STACK] =3D {"Stack depth", {"stack_depth", "stack"}, },
> +       [PROG_TYPE] =3D { "Program type", {"prog_type"}, },
> +       [ATTACH_TYPE] =3D { "Attach type", {"attach_type", }, },
>  };
>
>  static bool parse_stat_id_var(const char *name, size_t len, int *id,
> @@ -835,7 +850,8 @@ static char verif_log_buf[64 * 1024];
>  static int parse_verif_log(char * const buf, size_t buf_sz, struct verif=
_stats *s)
>  {
>         const char *cur;
> -       int pos, lines;
> +       int pos, lines, sub_stack;
> +       char *save_ptr, *token, stack[PATH_MAX + 1] =3D {'\0'};

PATH_MAX is both an overkill and is unrelated to stack depth string.
Let's just hard-code it to something like 256 or 512, and drop the
STR/_STR stuff

>
>         buf[buf_sz - 1] =3D '\0';
>
> @@ -853,15 +869,24 @@ static int parse_verif_log(char * const buf, size_t=
 buf_sz, struct verif_stats *
>
>                 if (1 =3D=3D sscanf(cur, "verification time %ld usec\n", =
&s->stats[DURATION]))
>                         continue;
> -               if (6 =3D=3D sscanf(cur, "processed %ld insns (limit %*d)=
 max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
> +               if (5 =3D=3D sscanf(cur, "processed %ld insns (limit %*d)=
 max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
>                                 &s->stats[TOTAL_INSNS],
>                                 &s->stats[MAX_STATES_PER_INSN],
>                                 &s->stats[TOTAL_STATES],
>                                 &s->stats[PEAK_STATES],
>                                 &s->stats[MARK_READ_MAX_LEN]))
>                         continue;
> -       }
>
> +               if (1 =3D=3D sscanf(cur, "stack depth %" STR(PATH_MAX) "s=
", stack))
> +                       continue;
> +       }
> +       token =3D strtok_r(stack, "+", &save_ptr);
> +       while (token && token - stack < PATH_MAX) {

why this PATH_MAX condition? I'm not following what we are guarding
against here, tbh

> +               if (sscanf(token, "%d", &sub_stack) =3D=3D 0)
> +                       break;
> +               s->stats[STACK] +=3D sub_stack;
> +               token =3D strtok_r(NULL, "+", &save_ptr);
> +       }

for the strtok_r() loop, see parse_stats(), I think it's nicer than
having to separate strtok_r() calls

>         return 0;
>  }
>
> @@ -1146,8 +1171,11 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>         char *buf;
>         int buf_sz, log_level;
>         struct verif_stats *stats;
> +       struct bpf_prog_info info;
> +       __u32 info_len =3D sizeof(info);
>         int err =3D 0;
>         void *tmp;
> +       int fd;
>
>         if (!should_process_file_prog(base_filename, bpf_program__name(pr=
og))) {
>                 env.progs_skipped++;
> @@ -1196,6 +1224,14 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
>         stats->file_name =3D strdup(base_filename);
>         stats->prog_name =3D strdup(bpf_program__name(prog));
>         stats->stats[VERDICT] =3D err =3D=3D 0; /* 1 - success, 0 - failu=
re */
> +       stats->stats[SIZE] =3D bpf_program__insn_cnt(prog);
> +       stats->stats[PROG_TYPE] =3D bpf_program__type(prog);
> +       stats->stats[ATTACH_TYPE] =3D bpf_program__expected_attach_type(p=
rog);

styling nit: I'd add an empty line here to separate multi-line
jited_size logic a bit

> +       fd =3D bpf_program__fd(prog);
> +       memset(&info, 0, info_len);

styling nit: and I'd invert here to keep fd > 0 check right next to fd
=3D assignment

> +       if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> +               stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +
>         parse_verif_log(buf, buf_sz, stats);
>
>         if (env.verbose) {
> @@ -1309,6 +1345,11 @@ static int cmp_stat(const struct verif_stats *s1, =
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
> @@ -1523,12 +1564,27 @@ static void prepare_value(const struct verif_stat=
s *s, enum stat_id id,
>                 else
>                         *str =3D s->stats[VERDICT] ? "success" : "failure=
";
>                 break;
> +       case ATTACH_TYPE:
> +               if (!s)
> +                       *str =3D "N/A";
> +               else
> +                       *str =3D libbpf_bpf_attach_type_str(s->stats[ATTA=
CH_TYPE]) ? : "N/A";
> +               break;
> +       case PROG_TYPE:
> +               if (!s)
> +                       *str =3D "N/A";
> +               else
> +                       *str =3D libbpf_bpf_prog_type_str(s->stats[PROG_T=
YPE]) ? : "N/A";

another nitpick: we normally have "?:" together without a space
between those characters

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

