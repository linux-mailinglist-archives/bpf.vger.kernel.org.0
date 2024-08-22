Return-Path: <bpf+bounces-37900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE91A95C0E1
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFEB1C22DD7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D647180A81;
	Thu, 22 Aug 2024 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoIvAlA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD05357CBE
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365809; cv=none; b=HB3ej7Gpoir5h/LcH1/n9IAclRXcfYgPYYGhmD6JBCuuntRSqbVw4rzStKvlSBZfekONS3cxmNVTFp4NOjvwCvG5e2hwlUN1lY3aZoOQ9gsFh3NtV69m4nCKOK/7zor+SjrxMkGjuENmLNqcnJirJXgd/E7FMt8BDsSeMdYUUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365809; c=relaxed/simple;
	bh=0QF1tltFngBxvRdyIewFNQ1XFzLzRZH4h1QWgP7PpJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICeHhfyn0Gzr7SSkMqLFoF8yQ/rhC+aFjfHZPddkz7kGMpF8nhmrO0d7hkpQVoWRkf9S3Za8+gjSptQPtBG170eScS9xmBCXYzFQ/GLex7uoYrBOcTPlh84lLB29rTOGkkfAPlVG6Ejf7Dnu1oN7RYTvxx2JNAOisvVWT8AL5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoIvAlA7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20202df1c2fso16371705ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724365807; x=1724970607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqhqKoI/l84vjOqjfd6KOM3UtlqVlQaMdb1XPu0LyVU=;
        b=KoIvAlA7UUrHFnn+McRPSzUgp35bD1stL/sebLVEgj3Db+k2kfgGJJShm84cqfcAsu
         p2G1qmFjW71n29OwLbkNZcS1kct9wmTWM4nyfQQWZlsPP92gPW8MpU3X2QeNZntsePzF
         1N6lLFRVIvS6QcG7Z8SBraBOEHlDhkMXTdTdcV48qFehA9cmhwxDTq0xRPQKJo3huUma
         j+YefLiMQRR5I4kEDISRm3Z2Gia/ftYPeAe7Mml6GWwgFcNvmQ2alfmUr1IcNCFDQhO3
         w5A5/w/769e6dxQYv9xUcn8nDUAbi7bbt7dsYi595d0pBK5TQ8ZwcTSOdpunDwVBdYFA
         Rk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724365807; x=1724970607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqhqKoI/l84vjOqjfd6KOM3UtlqVlQaMdb1XPu0LyVU=;
        b=owIxWMFr7b1MrIDG5JWbShE9p1WXrxAeYg3lZZzpg+hfXJFQdjMQBlGJ2U/hdfoM9B
         dHuzpq/zmiizpZQNfkJRU+RHAPmPIY9TwiQakIIB+JdSSLihvuw3SGvGB0McT1461cGR
         n/8gZJpuYhLU3a/lVB7YRGYhP0kMsBnLDipQjqhq7R3Mrg6BCAc29nvHLnrr3Ih+PLYD
         LRh4tgiGKGSlHM0ZrzVUXP39vLbt+ti/FglD2Uhwpgl89uyi0599w8DfAFIVNU+9zlUe
         TheMgjz+eaCe4sWcgYeVTwz7udfrRh+8G1R3WP36zME7dbgboLRp5T6klV6MFEubIY4T
         X4Hw==
X-Gm-Message-State: AOJu0YwJTX6YNfzdQFFrx4R8Hw89jMrZTw5i1OrFg0PDiLC9wzB9w/EM
	Ks7bSWfQYzL21AHzv4/lPbZ657Vl25zOnBtW61KRW/57bYegxvck+jvs+Xxu39Bsr6vkSKr2tOf
	Bk7A8Q3RvBYVKPAiXJfMPL5mL/YE=
X-Google-Smtp-Source: AGHT+IEmMBiCOoh0zphDpbjgLErbUmBa7G8O5U6kwvcvaNywLH3ftdsu/fKQrwUTFZn/Lv8OZg0ough+UZNcw/Fksak=
X-Received: by 2002:a17:90b:4a43:b0:2d3:b7be:e558 with SMTP id
 98e67ed59e1d1-2d6447afaffmr732226a91.8.1724365806998; Thu, 22 Aug 2024
 15:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820152433.777663-1-yatsenko@meta.com>
In-Reply-To: <20240820152433.777663-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 15:29:55 -0700
Message-ID: <CAEf4BzYjzfK9ppcrLg6As_8egG4f49HjeG-UGzNgBg9qtao0Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: emit top frequent C code lines in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:24=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Production BPF programs are increasing in number of instructions and stat=
es
> to the point, where optimising verification process for them is necessary
> to avoid running into instruction limit. Authors of those BPF programs
> need to analyze verifier output, for example, collecting the most
> frequent C source code lines to understand which part of the program has
> the biggest verification cost.
>
> This patch introduces `--top-lines` and `--include-instructions` flags in
> veristat.
> `--top-lines=3DN` makes veristat output N the most popular C sorce code
> lines, parsed from verification log. `--include-instructions` enables
> printing BPF instructions along with C source code.

Hm... I think --include-instructions needs a bit more thought to be
useful. Just one assembly instruction isn't all that useful, we should
be thinking in terms of blocks of assembly instruction, probably...
But then not sure how to take that into account when calculating top N
frequencies...

Not sure about all that. For v2, let's drop the assembly instructions
parts and try to get --top-lines logic right. We can then see how it
works in practice and adjust and extend as necessary.

>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 160 +++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>

Ok, #1 problem is that --top-lines is useless without -vl2, so we
should either check that this is specified. Or maybe better force
verbose log internally without actually emitting it, probably it's
better.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 1ec5c4c47235..977ab54cba83 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -16,10 +16,12 @@
>  #include <sys/stat.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> +#include <bpf/hashmap.h>

well, great for veristat in kernel repo, but this is libbpf-internal
thing and I'd like to avoid relying on it in veristat to make Github
sync simple.

>  #include <libelf.h>
>  #include <gelf.h>
>  #include <float.h>
>  #include <math.h>
> +#include <linux/err.h>
>
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> @@ -179,8 +181,16 @@ static struct env {
>         int files_skipped;
>         int progs_processed;
>         int progs_skipped;
> +       int top_lines;
> +       bool include_insn;
>  } env;
>
> +struct line_cnt {
> +       long cnt;
> +       char *line;
> +       char *insn;
> +};
> +
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
>  {
>         if (!env.verbose)
> @@ -206,6 +216,8 @@ const char argp_program_doc[] =3D
>  enum {
>         OPT_LOG_FIXED =3D 1000,
>         OPT_LOG_SIZE =3D 1001,
> +       OPT_TOP_LINES =3D 1002,
> +       OPT_INCLUDE_INSN =3D 1003,
>  };
>
>  static const struct argp_option opts[] =3D {
> @@ -228,6 +240,9 @@ static const struct argp_option opts[] =3D {
>           "Force frequent BPF verifier state checkpointing (set BPF_F_TES=
T_STATE_FREQ program flag)" },
>         { "test-reg-invariants", 'r', NULL, 0,
>           "Force BPF verifier failure on register invariant violation (BP=
F_F_TEST_REG_INVARIANTS program flag)" },
> +       { "top-lines", OPT_TOP_LINES, "N", 0, "Emit N the most frequent C=
 source code lines." },

"Emit N most frequent source code lines."

Doesn't have to be C, in general.

maybe let's call it "--top-src-lines" to be a bit more specific?

> +       { "include-instructions", OPT_INCLUDE_INSN, NULL, OPTION_HIDDEN,
> +         "If emitting the most frequent C source code lines, include the=
ir BPF instructions." },
>         {},
>  };
>
> @@ -337,6 +352,17 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>                         return -ENOMEM;
>                 env.filename_cnt++;
>                 break;
> +       case OPT_TOP_LINES:
> +               errno =3D 0;
> +               env.top_lines =3D strtol(arg, NULL, 10);
> +               if (errno) {
> +                       fprintf(stderr, "invalid top lines N specifier: %=
s\n", arg);
> +                       argp_usage(state);
> +               }
> +               break;
> +       case OPT_INCLUDE_INSN:
> +               env.include_insn =3D true;
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -817,6 +843,24 @@ static void free_verif_stats(struct verif_stats *sta=
ts, size_t stat_cnt)
>         free(stats);
>  }
>
> +static int line_cnt_cmp(const void *a, const void *b)
> +{
> +       const struct line_cnt **a_cnt =3D (const struct line_cnt **)a;
> +       const struct line_cnt **b_cnt =3D (const struct line_cnt **)b;
> +
> +       return (*b_cnt)->cnt - (*a_cnt)->cnt;
> +}
> +
> +static size_t str_hash_fn(long key, void *ctx)
> +{
> +       return str_hash((void *)key);
> +}
> +
> +static bool str_equal_fn(long a, long b, void *ctx)
> +{
> +       return strcmp((void *)a, (void *)b) =3D=3D 0;
> +}
> +
>  static char verif_log_buf[64 * 1024];
>
>  #define MAX_PARSED_LOG_LINES 100
> @@ -854,6 +898,120 @@ static int parse_verif_log(char * const buf, size_t=
 buf_sz, struct verif_stats *
>         return 0;
>  }
>
> +static char *parse_instructions(char *buf, char *buf_end)
> +{
> +       char *start =3D buf;
> +
> +       while (buf && buf < buf_end && *buf && *buf !=3D ';') {
> +               char *num_end =3D NULL;
> +
> +               strtol(buf, &num_end, 10);
> +               if (!num_end || *num_end !=3D ':')
> +                       break;
> +
> +               buf =3D strchr(num_end, '\n');
> +       }
> +
> +       return start =3D=3D buf ? NULL : strndup(start, buf - start);
> +}
> +
> +static int print_top_lines(char * const buf, size_t buf_sz)
> +{
> +       struct hashmap *lines_map;
> +       struct line_cnt **lines_cnt =3D NULL;
> +       struct hashmap_entry *entry;
> +       char *buf_end;
> +       char *line;
> +       int err =3D 0;
> +       int unique_lines;
> +       int bkt;
> +       int i;
> +
> +       if (!buf || !buf_sz)
> +               return -EINVAL;
> +

let's make sure we don't call print_top_lines with not buffer instead ?

> +       buf_end =3D buf + buf_sz - 1;
> +       *buf_end =3D '\0';

and buffer should be valid, so no need to zero-terminate it (verifier
guarantees that)

> +       lines_map =3D hashmap__new(str_hash_fn, str_equal_fn, NULL);
> +       if (IS_ERR(lines_map))
> +               return PTR_ERR(lines_map);
> +
> +       for (char *line_start =3D buf; line_start < buf_end;) {
> +               char *line_end =3D strchr(line_start, '\n');

any reason we can't use strtok_r() for this?

> +
> +               if (!line_end)
> +                       line_end =3D buf_end;
> +
> +               if (*line_start =3D=3D ';') {

let's check that it starts with "; " with strncmp() and skip space as well?

> +                       struct line_cnt *line_cnt;
> +
> +                       line_start++; /* skip semicolon */
> +                       *line_end =3D '\0';
> +                       if (hashmap__find(lines_map, line_start, &line_cn=
t)) {
> +                               line_cnt->cnt++;

so as I mentioned, I'd like to avoid the use of libbpf's hashmap. How
about we just add each string's offset within the buffer into a
(rather long sometimes) array of u32s. Then implement custom
comparator that would compare actual strings within log buffer by its
offset. Sort such indices this way, and then (reusing this comparator)
implement "unique" operation just like std::unique. Then we'll only
need to re-sort indices (but now taking their total counts), and emit
first/last N items.

Basically, keep it cheap by using offsets, but otherwise rely on NlogN
sorting to avoid hashmaps.

> +                       } else {
> +                               char *insn =3D NULL;
> +
> +                               line_cnt =3D malloc(sizeof(struct line_cn=
t));
> +                               if (!line_cnt) {
> +                                       *line_end =3D '\n';
> +                                       goto cleanup;
> +                               }
> +                               line =3D strdup(line_start);
> +                               if (!line) {
> +                                       *line_end =3D '\n';
> +                                       free(line_cnt);
> +                                       goto cleanup;
> +                               }
> +                               if (env.include_insn)
> +                                       insn =3D parse_instructions(line_=
end + 1, buf_end);
> +                               line_cnt->insn =3D insn;
> +                               line_cnt->line =3D line;
> +                               line_cnt->cnt =3D 1;
> +                               err =3D hashmap__add(lines_map, line, lin=
e_cnt);
> +                       }
> +                       *line_end =3D '\n';
> +
> +                       if (err)
> +                               goto cleanup;
> +               }
> +               line_start =3D line_end + 1;
> +       }
> +       unique_lines =3D hashmap__size(lines_map);
> +       if (!unique_lines)
> +               goto cleanup;
> +
> +       lines_cnt =3D calloc(unique_lines, sizeof(struct line_cnt *));
> +       if (!lines_cnt)
> +               goto cleanup;
> +
> +       i =3D 0;
> +       hashmap__for_each_entry(lines_map, entry, bkt)
> +               lines_cnt[i++] =3D (struct line_cnt *)entry->value;
> +
> +       qsort(lines_cnt, unique_lines, sizeof(struct line_cnt *), line_cn=
t_cmp);
> +
> +       printf("Top C source code lines:\n");

nit: there is no need to say "C source code", it's just "source code"

> +       for (i =3D 0; i  < min(unique_lines, env.top_lines); i++) {
> +               printf("; [Count: %ld] %s\n", lines_cnt[i]->cnt, lines_cn=
t[i]->line);

[Count: %ld] prefix is super verbose. Let's just emit a number of
occurrences without any extra "Count" text.

BTW, newer verifiers emit file location information now which looks
like " @ test_vmlinux.c:82", it would be nice if we could detect that,
parse it out separately (at the very last moment, during output) and
reformat everything to something like:

123: (test_vmlinux.c:82) <the rest of source code line>

Make sure to use something like %5d for frequency, so at least that
part is nicely aligned

> +               if (env.include_insn)
> +                       printf("%s\n", lines_cnt[i]->insn);
> +       }
> +       printf("\n");
> +
> +cleanup:
> +       hashmap__for_each_entry(lines_map, entry, bkt) {
> +               struct line_cnt *line_cnt =3D (struct line_cnt *)entry->v=
alue;
> +
> +               free(line_cnt->insn);
> +               free(line_cnt->line);
> +               free(line_cnt);
> +       }

we really shouldn't be allocating so much for strings, we have one
huge string and we should be dealing with indices into the buffer

pw-bot: cr

> +       hashmap__free(lines_map);
> +       free(lines_cnt);
> +       return err;
> +}
> +
>  static int guess_prog_type_by_ctx_name(const char *ctx_name,
>                                        enum bpf_prog_type *prog_type,
>                                        enum bpf_attach_type *attach_type)
> @@ -1048,6 +1206,8 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>                        filename, prog_name, stats->stats[DURATION],
>                        err ? "failure" : "success", buf);
>         }
> +       if (env.top_lines)
> +               print_top_lines(buf, buf_sz);
>
>         if (verif_log_buf !=3D buf)
>                 free(buf);
> --
> 2.46.0
>

