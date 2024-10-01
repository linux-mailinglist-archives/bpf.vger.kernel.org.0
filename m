Return-Path: <bpf+bounces-40702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA52498C4AA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E6B247CE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470D1CC150;
	Tue,  1 Oct 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea4hVeZJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458B191F81
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804347; cv=none; b=amAXuKO9vIT+AGg8LEQ+1BYXwDAhGldjY7efy9tHfNkDfDVrB8dIHmk80psqoLqNGA5rVfZDSYk0A8G+/FRa2GgpDDXkyWofxhAZCwX8MyGquoWkWqetu8s4x6hZrzfpuIhQWLV8FOnK44jOT8ly14Me/ElX9+MgTAaiKQq6rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804347; c=relaxed/simple;
	bh=3bAFmiBpVzZvd3WLIJU5CnWYx+zG/cpd2kbwMG01iLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZMHTcIu7ZLJEaXjuIyF+M7ptH1omXJLkvAuaLdmViYynJxaXCilo8WjRET6ocf9HpJeN1OqPRGD3eG9rBf2IKHvREUS8neCyLyTorEerZ0oaAZN88p7sADkUFVjdC+dHZmVhVTFU/sfBr6tQ71Ikk2kBNDJHFRDLspBlaoISCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea4hVeZJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so3897615a91.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727804345; x=1728409145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyIMtEtXoA0EaKrFy742lzNDoPSfqUkOq5OcFZOCXAM=;
        b=ea4hVeZJkS15GJSgCOr1rAf3R+1efmVAZ5eFFen+T1YALfXYhZ9Rj+vpdq/btXUX2X
         YIXkfltH13hZAU5Hxg2q5g6JWCN2p857iabyiMBsllBd187OS5gpTgSKHB2EL2S9/rCf
         ptw0XnWzi3YCAz0R5MJxPvQhG5g6WZPxO2jPdj0SXq2EwJkamuHDQQh/NnA42kD0HsZA
         wJIZnO/6qxNqMDgbgbItp1YbHRYFBOmS2pV7j56TmkhyfdqAPvIW9obfR7DTZUs6g5vT
         3DCHph6oyCQ4hYa0Rvflsy96oBpjt+d4840luPyfD6x2DUqjfKw3pVp6mjkUAhiA3xYC
         a8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804345; x=1728409145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyIMtEtXoA0EaKrFy742lzNDoPSfqUkOq5OcFZOCXAM=;
        b=DuevEpqBIkwIRpLVjkrDKcQHvQKOUB37KP808VND1PqiTVIjnvsqjaz4CYsD8W2FIo
         Vt4nRd21LL7zikr01V7Wu9xEBrZAzvVnn1XF70e28F7Dm4Kb99cSkq1gl7W013lBsrJS
         ki3aXvXw7LSZSI+/6v1dIZcs6pGYzhr8Gmhq2ctTDyjidejLUsYJdhbid38BzZd9UtG5
         57/xv6en5jyI5cOJ7993zwAbN3q406pyy743Idb8vnOLCO9gbNwq4qOpYtlopNBmYU3s
         kPLvGnfW4WiQbK58XKN04ZOxUV2W6THvfuGotD5r1WMrIST+O7IKmC4zkuNxqW7KLozW
         RFkQ==
X-Gm-Message-State: AOJu0YwTEz8Vqz16m38sfVpVkXUg5RWnJK8xDk1fBMqmiluH4we8GX2L
	A9B1ZA5++KG6t0CPxAJciNtF7rIAdDLvHwiRkb17cPw0FdkGZ7Z9Iiget1jHYKVvzcRvY4sDe6V
	MZVwVDiOCsn211dJxWgVrGjSIZv4=
X-Google-Smtp-Source: AGHT+IHPx+kLQphNzDhCvJM1HecXhCVzM95Ubkyex8NPLBOdFVEEGKsYHcmAow/303v+7jju8JOwmfbK6xVgxk1REho=
X-Received: by 2002:a17:90a:fa01:b0:2e0:d957:1b9d with SMTP id
 98e67ed59e1d1-2e18456b614mr616643a91.13.1727804345384; Tue, 01 Oct 2024
 10:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930231522.58650-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240930231522.58650-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:38:53 -0700
Message-ID: <CAEf4BzZrno+L5pdbLosWNniJxp7ps9AfPa8k-QA1uQF2Rf8yqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: emit top frequent code lines
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:15=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Production BPF programs are increasing in number of instructions and stat=
es
> to the point, where optimising verification process for them is necessary
> to avoid running into instruction limit. Authors of those BPF programs
> need to analyze verifier output, for example, collecting the most
> frequent source code lines to understand which part of the program has
> the biggest verification cost.
>
> This patch introduces `--top-src-lines` flag in veristat.
> `--top-src-lines=3DN` makes veristat output N the most popular sorce code
> lines, parsed from verification log.
>
> An example of output:
> ```
> sudo ./veristat  --top-src-lines=3D2   bpf_flow.bpf.o
> Processing 'bpf_flow.bpf.o'...
> Top source lines (_dissect):
>     4: (bpf_helpers.h:161)      asm volatile("r1 =3D %[ctx]\n\t"
>     4: (bpf_flow.c:155) if (iph && iph->ihl =3D=3D 5 &&
> ...
> ```
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 127 ++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 2 deletions(-)
>

LGTM, I played with it locally, works nicely, thanks!

I did a few tweaks before applying, see below for details.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 1ec5c4c47235..977c5eca56f7 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -179,6 +179,7 @@ static struct env {
>         int files_skipped;
>         int progs_processed;
>         int progs_skipped;
> +       int top_src_lines;
>  } env;
>
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -206,6 +207,7 @@ const char argp_program_doc[] =3D
>  enum {
>         OPT_LOG_FIXED =3D 1000,
>         OPT_LOG_SIZE =3D 1001,
> +       OPT_TOP_SRC_LINES =3D 1002,
>  };
>
>  static const struct argp_option opts[] =3D {
> @@ -228,6 +230,7 @@ static const struct argp_option opts[] =3D {
>           "Force frequent BPF verifier state checkpointing (set BPF_F_TES=
T_STATE_FREQ program flag)" },
>         { "test-reg-invariants", 'r', NULL, 0,
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
> +       { "top-src-lines", OPT_TOP_SRC_LINES, "N", 0, "Emit N most freque=
nt source code lines" },

I added 'S' as a short name, I found --top-src-lines too much pain to type =
:)

>         {},
>  };
>
> @@ -337,6 +340,14 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return -ENOMEM;
>                 env.filename_cnt++;
>                 break;
> +       case OPT_TOP_SRC_LINES:
> +               errno =3D 0;
> +               env.top_src_lines =3D strtol(arg, NULL, 10);
> +               if (errno) {
> +                       fprintf(stderr, "invalid top lines N specifier: %=
s\n", arg);
> +                       argp_usage(state);
> +               }
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -854,6 +865,115 @@ static int parse_verif_log(char * const buf, size_t=
 buf_sz, struct verif_stats *
>         return 0;
>  }
>
> +struct line_cnt {
> +       char *line;
> +       int cnt;
> +};
> +
> +static int str_cmp(const void *a, const void *b)
> +{
> +       const char **str1 =3D (const char **)a;
> +       const char **str2 =3D (const char **)b;
> +
> +       return strcmp(*str1, *str2);
> +}
> +
> +static int line_cnt_cmp(const void *a, const void *b)
> +{
> +       const struct line_cnt *a_cnt =3D (const struct line_cnt *)a;
> +       const struct line_cnt *b_cnt =3D (const struct line_cnt *)b;
> +
> +       return b_cnt->cnt - a_cnt->cnt;

for ordering stability, I added a fallback to line_cnt->line string
comparison, if counts are equal

> +}
> +

[...]

> +       printf("Top source lines (%s):\n", prog_name);
> +       for (i =3D 0; i < min(unique_lines, env.top_src_lines); ++i) {
> +               const char *src_code =3D freq[i].line;
> +               const char *src_line =3D NULL;
> +               char *split =3D strrchr(freq[i].line, '@');
> +
> +               if (split) {
> +                       src_line =3D split + 1;
> +
> +                       while (*src_line && isspace(*src_line))
> +                               src_line++;
> +
> +                       while (split > src_code && isspace(*split))
> +                               split--;
> +                       *split =3D '\0';
> +               }
> +
> +               if (src_line)
> +                       printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line, =
src_code);
> +               else
> +                       printf("%5d: %s\n", freq[i].cnt, src_code);
> +       }
> +

added printf("\n") to visually separate the output a bit

> +cleanup:
> +       free(freq);
> +       free(lines);
> +       return err;
> +}
> +
>  static int guess_prog_type_by_ctx_name(const char *ctx_name,
>                                        enum bpf_prog_type *prog_type,
>                                        enum bpf_attach_type *attach_type)
> @@ -1009,13 +1129,14 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>         stats =3D &env.prog_stats[env.prog_stat_cnt++];
>         memset(stats, 0, sizeof(*stats));
>
> -       if (env.verbose) {
> +       if (env.verbose || env.top_src_lines > 0) {
>                 buf_sz =3D env.log_size ? env.log_size : 16 * 1024 * 1024=
;
>                 buf =3D malloc(buf_sz);
>                 if (!buf)
>                         return -ENOMEM;
>                 /* ensure we always request stats */
> -               log_level =3D env.log_level | 4 | (env.log_fixed ? 8 : 0)=
;
> +               log_level =3D (env.top_src_lines > 0 && env.log_level =3D=
=3D 0 ? 2 : env.log_level)
> +                       | 4 | (env.log_fixed ? 8 : 0);

this felt a bit too crowded, so I switched this to one extra if, and
left original log_level assignment untouched

>         } else {
>                 buf =3D verif_log_buf;
>                 buf_sz =3D sizeof(verif_log_buf);
> @@ -1048,6 +1169,8 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>                        filename, prog_name, stats->stats[DURATION],
>                        err ? "failure" : "success", buf);
>         }
> +       if (env.top_src_lines > 0)
> +               print_top_src_lines(buf, buf_sz, stats->prog_name);
>
>         if (verif_log_buf !=3D buf)
>                 free(buf);
> --
> 2.46.2
>

