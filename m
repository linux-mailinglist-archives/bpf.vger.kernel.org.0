Return-Path: <bpf+bounces-39382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1EF9725D4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A6FB22F39
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0C18E756;
	Mon,  9 Sep 2024 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjkH3xtG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C918D63B;
	Mon,  9 Sep 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925499; cv=none; b=BB2Tm7kI+oFkpGngEI3yNDLubkrjJ7k6HsQ98MbdgwMtQZaSkXrGkQSb2zBo9fPFE1vNCuh/fP0WrViOBUBIXag9fbfOUR+fj7IrBYm2wHspcFsfxcuyvFCTn+ZLLwFBxFulPzVjyuB9o7s6fk1FpFGFj4FZLYK0udAdRWGVQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925499; c=relaxed/simple;
	bh=7DTVLnohJEOefkviwSySP+nNAh+v9KgGKrrR93bBtC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rop9G/yHV81E63Zt10yIXFEe1/05W3oWCD2kGIAZAi5otflRJhdMz+FIU9CbBKclgkxcV5s52dqJv45D/WOVwNab4koLIceKcr3jK9sRUyNe3damM7qg7BhFlSUr0uQ8Md92gLMb5kMuOCMsIMiNaZ8EsSQWGKlJP1DdgKv5wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjkH3xtG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so3547755a91.0;
        Mon, 09 Sep 2024 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725925497; x=1726530297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TCbPVwWw5y2MJqaZqUPq2JZzNV+G5qbq/8j+l8H2fM=;
        b=BjkH3xtGklHdHgZQl1oPW29QKqA7DdRKvOg+MNMSvjU6HisPMYrFDE3vYIvrUEyTzJ
         9LLv4FV0XN7UDqMVUUXKVLPVG7a3stAcYXV7bbE6CJyxVskpxrQKT24kMhNHzw26itUR
         yI3hiTtSwqRhKYtWRfm4R174FExWHbxYDrA5Ogp/oCAWlnHMM3sPDZ36jtvJYI8dwxDQ
         eLpvpCXuOIAqnMXLKyR59Yl5ca4zdAxR9Th3Qwt0Z7zfEdFLGAgbtB0yiHcZiL1d+A1H
         jkIRStRveUmVHnKdu3+u3g+JIrMUAkX3BibHpTw+qv6GCruS2Sq2zVgjsa+ixeyTTvPe
         MYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925497; x=1726530297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TCbPVwWw5y2MJqaZqUPq2JZzNV+G5qbq/8j+l8H2fM=;
        b=KUE5Ff1cUQ+kQuE9tlyrwBn7COJJYKIDdlwLb7EE3WovXPHGv6jqw7DeAfZGY52+T5
         6v2K9GIishJmGEAEAxjTuQXc9BwGESOTZclig2Ju+TgCOVRG2qL8UXFLbyC5XItEJQ/o
         v+2VTBmrKJxj1mmbA8H0gDm7K0LjB6V/J175pt5PRLSW6rKXBcqvdsqPS+kZdhJEBEEl
         a2IZt4gpACnYyKOv0HglGNBkfqsLpO4+IB/2mE7dFvyrZV+4Hb6a454ukMyBFQptDgI9
         YpCc4nooasIMS64TeQ9kWpYivqM5CXMQZBvtq+7wy/vuEfGDuosEb4FiTbLEroW8ILtU
         hPIw==
X-Forwarded-Encrypted: i=1; AJvYcCVcLWjndjlQCOHsK50pVU78OqR5gO3bjHN8VtcF1ou8Ca3gIAA1SNCwUWpYd+u+PD41Urr8u/8dECuPTgbA@vger.kernel.org, AJvYcCVzfdBg7QTj6+HPJ25wgLCoVMQSk4gDQ3CfDfaLSuTp8NRxxM6LFlw9Vv34UjtBuvp7y74=@vger.kernel.org, AJvYcCXPu+IRNBHikMkiiqIv77wYDcHdHziCqW7DCewy5fhbHaegpxOSmdQLrQ/pfYDxGnwOT+qtNbYPsOfoBVhzaywX4Rkj@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRaG20hdqF6NkrdtzxEVNGfgSJWEfPGkvzcpKFievqb18eNI7
	D+q1HRNa54GxFoODJSlub3X/q+CX4r16KiUaMw06r8LkFwc7F9RtKEtsW6F3tl35NPaWOSYZRO4
	OIMaRZRyTz6xy4TPbllyECuVSS8Y=
X-Google-Smtp-Source: AGHT+IG7Aznbv6hNEl2flZuv1SVrBLAMVxMZvwWfv2JeuH3rJpIqQ8CBsC8sy46uv46dVflMt9YdLvSRwHnK90exuEk=
X-Received: by 2002:a17:90a:7087:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2dad50f9fc1mr14664283a91.37.1725925496997; Mon, 09 Sep 2024
 16:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909074554.2339984-1-jolsa@kernel.org> <20240909074554.2339984-5-jolsa@kernel.org>
In-Reply-To: <20240909074554.2339984-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 16:44:44 -0700
Message-ID: <CAEf4BzYpH_2f0eHwQG205Q_4hewbtC9OrVSA-_jn6ysz53QbBg@mail.gmail.com>
Subject: Re: [PATCHv3 4/7] libbpf: Add support for uprobe multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:46=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in uprobe session mode
> with bpf_program__attach_uprobe_multi function.
>
> Adding session bool to bpf_uprobe_multi_opts struct that allows
> to load and attach the bpf program via uprobe session.
> the attachment to create uprobe multi session.
>
> Also adding new program loader section that allows:
>   SEC("uprobe.session/bpf_fentry_test*")
>
> and loads/attaches uprobe program as uprobe session.
>
> Adding sleepable hook (uprobe.session.s) as well.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
>

[...]

> +static int attach_uprobe_session(const struct bpf_program *prog, long co=
okie, struct bpf_link **link)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .session =3D true);
> +       char *binary_path =3D NULL, *func_name =3D NULL;
> +       int n, ret =3D -EINVAL;
> +       const char *spec;
> +
> +       *link =3D NULL;
> +
> +       spec =3D prog->sec_name + sizeof("uprobe.session/") - 1;
> +       if (cookie & SEC_SLEEPABLE)
> +               spec +=3D 2; /* extra '.s' */
> +       n =3D sscanf(spec, "%m[^:]:%m[^\n]", &binary_path, &func_name);
> +
> +       switch (n) {
> +       case 1:
> +               /* but auto-attach is impossible. */
> +               ret =3D 0;
> +               break;
> +       case 2:
> +               *link =3D bpf_program__attach_uprobe_multi(prog, -1, bina=
ry_path, func_name, &opts);
> +               ret =3D *link ? 0 : -errno;
> +               break;
> +       default:
> +               pr_warn("prog '%s': invalid format of section definition =
'%s'\n", prog->name,
> +                       prog->sec_name);
> +               break;
> +       }
> +       free(binary_path);
> +       free(func_name);
> +       return ret;
> +}

why adding this whole attach_uprobe_session if attach_uprobe_multi()
is almost exactly what you need. We just need to teach
attach_uprobe_multi to recognize uprobe.session prefix with strncmp(),
no? The rest of the logic is exactly the same.

BTW, maybe you can fix attach_uprobe_multi() while at it:

opts.retprobe =3D strcmp(probe_type, "uretprobe.multi") =3D=3D 0;

that should be strncmp() to accommodate uretprobe.multi.s, no?
Original author (wink-wink) didn't account for that ".s", it seems...

(actually please send a small fix to bpf-next separately, so we can
apply it sooner)

> +
>  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                          const char *binary_path, uint64_=
t offset)
>  {
> @@ -11933,10 +11969,12 @@ bpf_program__attach_uprobe_multi(const struct b=
pf_program *prog,
>         const unsigned long *ref_ctr_offsets =3D NULL, *offsets =3D NULL;
>         LIBBPF_OPTS(bpf_link_create_opts, lopts);
>         unsigned long *resolved_offsets =3D NULL;
> +       enum bpf_attach_type attach_type;
>         int err =3D 0, link_fd, prog_fd;
>         struct bpf_link *link =3D NULL;
>         char errmsg[STRERR_BUFSIZE];
>         char full_path[PATH_MAX];
> +       bool retprobe, session;
>         const __u64 *cookies;
>         const char **syms;
>         size_t cnt;

[...]

