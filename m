Return-Path: <bpf+bounces-40448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED26988C9C
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C241C20F8B
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BD1B5ECD;
	Fri, 27 Sep 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPAorfIA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1418454C
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477277; cv=none; b=KfgPhZMk37CXMNgV1itRlq/r9uS+FSIx62avahCRwRRgFoiXmHPxp4hiwlhv0XG9zvwRQLw1Rmy3q4OAAzWM7NgntsvyO4yFB5ohlnokzrBy92BlbNsjyrK041+GcH3/wfK5rsuT7G/CRJo/ysJonIO4FRzo9LjhD1P8SzgTbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477277; c=relaxed/simple;
	bh=FQfIr7jzAoDhAfZjzrswTSW8FjXr0k3mM883uYy/ujw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDcUyXnh8zgBuLL7hucd2pmhmn3B2YlsmesYqRNv74piJ8QfQlqtIfuj32pz4cwFlHqTpLLjjuP8ldMLwZyL3O+BpPzLtd8vLliqfsTKD2c5WJRHStWzT2fKrM058ntBrftExIli7HAskefWCOjKpR2j78Dl9jf9cyN2Si8GVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPAorfIA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso2003610a91.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727477275; x=1728082075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwVyJcBXBN3eeCAv9Z+fuqkqA0rSxy10ro02THGBNtk=;
        b=CPAorfIABlbIzki6taCEwyXZfCWSR5Kx5UQZdQvADozriMrqT1hpG499UQ8uT0gg/q
         3KxIWLILR4g3L/r57IKJpNGRMtysIMbtBkPny8Z68nxWXI41iz9PI+wbiuIDOGg67vvj
         F7fRK4Gt6Nf3JbRhq0iUKpQZuU8qnPRp8F0ZNScSZPqPbvutUMnqV80Y5bWECUcsXMEw
         k2Se3E6u8AeYBBwIwBbafXp0Uz40K9am6BrIAZlsB3lupFRk78LgUvhnUyAQXSwqtZS9
         OFnZpNyTw7Id5qC5577u1YlMlgEqSIE3viFr4WCqq5ZGSt3lP9FXxxyd0YmjMgiB9iGF
         3byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727477275; x=1728082075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwVyJcBXBN3eeCAv9Z+fuqkqA0rSxy10ro02THGBNtk=;
        b=EQhw/KXPJKWlG152yMATVKHLbTbllfweJ9JzWS2kxUI0KgRhXL8sPyj5ysJthtcbop
         ka5x6J7xsvmkJAcRTFgYU+hC3kOf3ZgTZhQpVO3d2sZEPNageqOrXmsTjPTBarSx2xRj
         lgvmUB/ImDm8zunUARhOlicrni86rfkP1Zs1EzybULuuebXaH2s40DndPNspNai28C44
         +S6x4UMT4j+SYN+cYOYfPYvAg4CNbCFpe2IA9rKrQLUjypFvzbuy1AKHD4OPv3YoY3JX
         636JYatblgKYvHQALA/uMkyrHdKFFJ5emPXN7gXbUPjefn0Rj1bTK6FmtlTthMdqDuPi
         KArQ==
X-Gm-Message-State: AOJu0YyAvmJO0dWKlcFsG6CYEsUw6zUiR6XVEG/gGVVLtitnYH6Tw0Ff
	bHlKEhU+7SsGUDcnxxIaYm8JArbhDRXYLgHMLSiynqsCpQ662yfQQBeOJCzIdgES0wOrMeC6W4z
	FzZ58hv1il0wu91MHxVX7BLLzYuI=
X-Google-Smtp-Source: AGHT+IF8CzCCwgZGaiEoPTufy/VLGrLMKypk2hLJC9QQjm/Jp50Ig9lJcpuJ2agqxMirRUm1qwfeQgy4VYYbYtXes7E=
X-Received: by 2002:a17:90a:d3c1:b0:2dd:4f6b:6394 with SMTP id
 98e67ed59e1d1-2e0b8b3a24cmr5462117a91.19.1727477275087; Fri, 27 Sep 2024
 15:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 15:47:42 -0700
Message-ID: <CAEf4BzYJRak7x0yn+g_zaAHUgJS0va2rcQL4uQ7LXDH3b3PAbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 1:40=E2=80=AFPM Mykyta Yatsenko
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
> An example:
> ```
> $ sudo ./veristat --log-size=3D1000000000 --top-src-lines=3D4  pyperf600.=
bpf.o
> Processing 'pyperf600.bpf.o'...
> Top source lines (on_event):
>  4697: (pyperf.h:0)
>  2334: (pyperf.h:326)   event->stack[i] =3D *symbol_id;
>  2334: (pyperf.h:118)   pidData->offsets.String_data);
>  1176: (pyperf.h:92)    bpf_probe_read_user(&frame->f_back,
> ...
> ```
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 132 ++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 5 deletions(-)
>

Looks pretty close to the final state, see some nits and some
potential problems below. We should figure out the verboseness bits
before applying this, though.

pw-bot: cr

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 1ec5c4c47235..854fa4459b77 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -143,6 +143,7 @@ static struct env {
>         char **filenames;
>         int filename_cnt;
>         bool verbose;
> +       bool print_verbose;

let's not do that, if we need to pass log_level to the kernel due to
top_src_lines, then that should be coded explicitly, not relying on
implicit "verbose" flag.

But also consider that there are two verbose levels for the kernel:
LOG_LEVEL=3D1 and LOG_LEVEL=3D2. We probably should default to LOG_LEVEL=3D=
2
if --top-src-lines is specified *unless* user explicitly specified
-vl1. Please play with different combinations and see if they make
sense.

log_level=3D2 is extremely verbose, so if the user specified -v (and not
-vl2), they will be surprised by extra verboseness.

>         bool debug;
>         bool quiet;
>         bool force_checkpoints;
> @@ -179,11 +180,12 @@ static struct env {
>         int files_skipped;
>         int progs_processed;
>         int progs_skipped;
> +       int top_src_lines;
>  } env;

[...]

> +static int print_top_src_lines(char * const buf, size_t buf_sz, const ch=
ar *prog_name)
> +{
> +       int lines_cap =3D 1;
> +       int lines_size =3D 0;
> +       char **lines;
> +       char *line =3D NULL;
> +       char *state;
> +       struct line_cnt *freq =3D NULL;
> +       struct line_cnt *cur;
> +       int unique_lines;
> +       int err;
> +       int i;
> +
> +       lines =3D calloc(lines_cap, sizeof(char *));
> +       if (!lines)
> +               return -ENOMEM;

start with lines_cap =3D=3D 0, skip this calloc(), let realloc() do all
the work (lines should be initialized to NULL, of course)

> +
> +       while ((line =3D strtok_r(line ? NULL : buf, "\n", &state))) {
> +               if (strncmp(line, "; ", 2))

nit: with strncmp() and strcmp() I find it much more readable explicit
=3D=3D 0 or !=3D 0, otherwise my brain instinctively understands it in
exactly opposite way

> +                       continue;
> +               line +=3D 2;
> +
> +               if (lines_size =3D=3D lines_cap) {
> +                       char **tmp;
> +
> +                       lines_cap *=3D 2;

nit: generally speaking, it's common pattern to have some starting
minimal length that's a bit bigger than 1 or 2, so e.g., you'd do

lines_cap =3D max(16, 2 * lines_cap);

> +                       tmp =3D realloc(lines, lines_cap * sizeof(char *)=
);
> +                       if (!tmp) {
> +                               err =3D -ENOMEM;
> +                               goto cleanup;
> +                       }
> +                       lines =3D tmp;
> +               }
> +               lines[lines_size] =3D line;
> +               lines_size++;
> +       }
> +
> +       if (!lines_size)

nit: lines_size =3D=3D 0 (it's not an error code and neither is it bool,
so explicit zero comparison makes more sense, IMO)

> +               goto cleanup;
> +
> +       qsort(lines, lines_size, sizeof(char *), str_cmp);

nit: probably would be better to use sizeof(*lines)

> +
> +       freq =3D calloc(lines_size, sizeof(struct line_cnt));
> +       if (!freq) {
> +               err =3D -ENOMEM;
> +               goto cleanup;
> +       }
> +
> +       cur =3D freq;
> +       cur->line =3D lines[0];
> +       cur->cnt =3D 1;
> +       for (i =3D 1; i < lines_size; ++i) {
> +               if (strcmp(lines[i], cur->line)) {
> +                       cur++;
> +                       cur->line =3D lines[i];
> +                       cur->cnt =3D 0;
> +               }
> +               cur->cnt++;
> +       }
> +       unique_lines =3D cur - freq + 1;
> +
> +       qsort(freq, unique_lines, sizeof(struct line_cnt), line_cnt_cmp);

nit: sizeof(*freq), besides being shorter, it also won't need updating
if we rename the type *and* it shows connection to freq[] itself quite
explicitly

> +
> +       printf("Top source lines (%s):\n", prog_name);
> +       for (i =3D 0; i < min(unique_lines, env.top_src_lines); ++i) {
> +               char *src_code;
> +               char *src_line;
> +
> +               src_code =3D strtok_r(freq[i].line, "@", &state);

what happens if the line doesn't have '@' in it, which will be the
case on older kernels? Can you please test all this on some old kernel
with a different verifier log output? It shouldn't crash.

tbh, it feels like strtok_r is a bit of an overkill here. I'd just
strrchr('@') (note reverse search), if it's there, extract everything
to the right as file name, otherwise assume the entire string is
source code line. This will handle both old and new verifier log
formats

> +               src_line =3D strtok_r(NULL, "\0", &state);
> +               if (src_line)
> +                       printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line +=
 1, src_code);
> +               else
> +                       printf("%5d: %s\n", freq[i].cnt, src_code);
> +       }
> +
> +cleanup:
> +       free(freq);
> +       free(lines);
> +       return err;
> +}
> +

[...]

