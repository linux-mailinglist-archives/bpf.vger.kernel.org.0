Return-Path: <bpf+bounces-42939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386F9AD343
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955191C22147
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE721CC158;
	Wed, 23 Oct 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTb5P/9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F41BD038
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705744; cv=none; b=fe8EIovYnby/atU8zDJ0gRCUzwbIxzwDcmFcE1ttudS4xl9P4JXmHu2apyXnZZOgkjaslCRFccsGApDxK0qysv6facDkvgbc0breP3o5Hh98TjdPWzQmR+B/D5c3R/twEVCSV+qd/ILd52WpM9x9dBni7fzRCjoOG/j0HhL81L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705744; c=relaxed/simple;
	bh=xA50z0KjuzeOJKnz1Ro2AGGwBA6ttElwmlTXqhWw42c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZzUqQ+z5Do/C+UDah2JcPbQURGiiR6WOZh00PTjsTER4qADqp/WB7VVFacIg3FNEO6fuB5iE7dy5HU67GAXyZ98c6RFvlm8cdhkV/lWCAtl9OmNmtlxq11O38rQuJQYF66kMJrLXzV9LRxJ3vd/kLRN8r0M5ulprAys7hiCx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTb5P/9P; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so24197a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705742; x=1730310542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN4JBq+v5bQzo7R6upNJ8g4B3I5dq5RhPij+eEFH4WA=;
        b=GTb5P/9PCD68xnmHqmtf5lzjY4o/3byLgdJCmr3eGDLAwfyezwneoKPYccL3C82PGL
         RkTMNcWtsuDdEM+ZSg1QzaK5JqWfnx4fDc0f7drfl4bD0fGO44jnH0AVeY0Is/4ZhYM+
         +1GHjdT4cZAQ0Avm4Vf96JdTaqp6ZKy8y7tQF55UY+L3L7r5bFeaJ40Va4xTLk8pmNKS
         rgXSO8pjtWyH54jDkMYsCQ+dYjMT9/LuiW1uKyF2/wBhC/PGTWKhvzfWXeBBfEfF0Ju3
         MajISS19NGpL1ZLa5SAdCd3OvcnuQB4YEugwhOGQpjAFkOUlAuUkkh/0y9Ocbx3z26N4
         3Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705742; x=1730310542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN4JBq+v5bQzo7R6upNJ8g4B3I5dq5RhPij+eEFH4WA=;
        b=tjUVlmFJeA8Mkcz/wmVxDLtmHkCMLY76T7pM3ePsUKJK5CViob53A+ojVC07/tyv31
         IwZg+5vrwq8lB0TNuTVzXYDEr+xlfp4WtKQ7lEAaIJBK3OTA5Uz5a69rutKjzSkltcnC
         KzczdSks3hBHkKIgGHBN+4p/zVV0CL0rc8MFsE3q5EUJD5JPgQ7E7qIRLuo3lqDb/3wN
         4h9qIruMS2//nyCr9qy99/iphV7AwacUR00isL2JOwf8F9A0vGQReMEdv+Gu2kGFl45J
         5gfh7bWZa59pDqNkwKzPojgnuuWaXfnXvpwGOeIYgavr7/yn+ncSHkto1hS5Q3+UMmEs
         p4fQ==
X-Gm-Message-State: AOJu0YzXQnRVW5LBtade0ONUYN2q7UGWbmi41oAieByeCMIYily70lW+
	eCdkuYjOZnJ4uzLK8j0CkjVWFa4TMFeS+kayJKFcoSlXDwCzN3r8IJKkcn9t7NtXG6iAcDbWO0Z
	zTcY547WhYeF59eqLGTQltu7UfhU=
X-Google-Smtp-Source: AGHT+IFiqZL8qcgHNNXZS9oSqf58armnOV1jTirP9bHR1gOoAkFTetuTXfJuBe+6aylAGYeL/KLlg6so0tw693tSG+I=
X-Received: by 2002:a05:6a20:b68a:b0:1d7:1277:8d22 with SMTP id
 adf61e73a8af0-1d978bd2592mr4636258637.43.1729705742027; Wed, 23 Oct 2024
 10:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023155314.126255-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241023155314.126255-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:48:49 -0700
Message-ID: <CAEf4BzYrh-nQgWUs0c446cYsvwm=Z-Mqp7rwhAV7oHomOUK7Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: increase verifier log limit in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:53=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> The current default buffer size of 16MB allocated by veristat is no
> longer sufficient to hold the verifier logs of some production BPF
> programs. To address this issue, we need to increase the verifier log
> limit.
> Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
> increased the supported buffer size by the kernel, but veristat users
> need to explicitly pass a log size argument to use the bigger log.
>
> This patch adds a function to detect the maximum verifier log size
> supported by the kernel and uses that by default in veristat.
> This ensures that veristat can handle larger verifier logs without
> requiring users to manually specify the log size.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 42 +++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index c8efd44590d9..a8498b1a2898 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -16,6 +16,7 @@
>  #include <sys/stat.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> +#include <bpf/bpf.h>
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <float.h>
> @@ -1109,6 +1110,45 @@ static void fixup_obj(struct bpf_object *obj, stru=
ct bpf_program *prog, const ch
>         return;
>  }
>
> +static int max_verifier_log_size(void)
> +{
> +       const int SMALL_LOG_SIZE =3D UINT_MAX >> 8;
> +       const int BIG_LOG_SIZE =3D UINT_MAX >> 2;
> +       struct bpf_insn insns[] =3D {
> +               {
> +               .code  =3D BPF_ALU | BPF_MOV | BPF_X,
> +               .dst_reg =3D BPF_REG_0,
> +               .src_reg =3D 0,
> +               .off   =3D 0,
> +               .imm   =3D 0 },
> +               {
> +               .code  =3D BPF_JMP | BPF_EXIT,
> +               .dst_reg =3D 0,
> +               .src_reg =3D 0,
> +               .off   =3D 0,
> +               .imm   =3D 0 },
> +       };

I reformated this:

diff --git a/tools/testing/selftests/bpf/veristat.c
b/tools/testing/selftests/bpf/veristat.c
index a8498b1a2898..e12ef953fba8 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1115,18 +1115,8 @@ static int max_verifier_log_size(void)
        const int SMALL_LOG_SIZE =3D UINT_MAX >> 8;
        const int BIG_LOG_SIZE =3D UINT_MAX >> 2;
        struct bpf_insn insns[] =3D {
-               {
-               .code  =3D BPF_ALU | BPF_MOV | BPF_X,
-               .dst_reg =3D BPF_REG_0,
-               .src_reg =3D 0,
-               .off   =3D 0,
-               .imm   =3D 0 },
-               {
-               .code  =3D BPF_JMP | BPF_EXIT,
-               .dst_reg =3D 0,
-               .src_reg =3D 0,
-               .off   =3D 0,
-               .imm   =3D 0 },
+               { .code =3D BPF_ALU | BPF_MOV | BPF_X, .dst_reg =3D BPF_REG=
_0, },
+               { .code  =3D BPF_JMP | BPF_EXIT, },
        };
        LIBBPF_OPTS(bpf_prog_load_opts, opts,
                    .log_size =3D BIG_LOG_SIZE,

Applied to bpf-next, thanks!

> +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +                   .log_size =3D BIG_LOG_SIZE,
> +                   .log_buf =3D (void *)-1,
> +                   .log_level =3D 4
> +       );
> +       int ret, insn_cnt =3D ARRAY_SIZE(insns);
> +       static int log_size;
> +
> +       if (log_size !=3D 0)
> +               return log_size;
> +
> +       ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insn=
s, insn_cnt, &opts);
> +
> +       if (ret =3D=3D -EFAULT)
> +               log_size =3D BIG_LOG_SIZE;
> +       else /* ret =3D=3D -EINVAL, big log size is not supported by the =
verifier */
> +               log_size =3D SMALL_LOG_SIZE;
> +
> +       return log_size;
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1132,7 +1172,7 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>         memset(stats, 0, sizeof(*stats));
>
>         if (env.verbose || env.top_src_lines > 0) {
> -               buf_sz =3D env.log_size ? env.log_size : 16 * 1024 * 1024=
;
> +               buf_sz =3D env.log_size ? env.log_size : max_verifier_log=
_size();
>                 buf =3D malloc(buf_sz);
>                 if (!buf)
>                         return -ENOMEM;
> --
> 2.47.0
>

