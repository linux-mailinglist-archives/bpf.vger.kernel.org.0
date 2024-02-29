Return-Path: <bpf+bounces-23035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCEC86C6C8
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD71F22019
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621E63CB5;
	Thu, 29 Feb 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt/JpD4A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB560BA7
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202274; cv=none; b=nwIR2SkRuwhUiTaul44nv1SpusQatdOMKX1/tiejI656ku29i2ZnBWB+bE1UvL+JgK2uwu/is/VpVhNkFGl3IBZ3UtVOg8w74Sw/r3LvWYIe8AhiDFEZ+Q+D/AdUlbtKDI5X5x9h5XmZJPQc3lPaKSVJc6ywztHqTZgY5ge08CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202274; c=relaxed/simple;
	bh=mywfT/K52WhqsXhMUnYHfEGBfBx0fM/6DCEhZgsM+m8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/VGCeEdIw/Fo/IuTmB3nNptuqaYCs4YrbllolD8KNFXZWXmC+kzwvMqEYTwVGtjtfpDTBRJ+bgctmh9jKxThGtKExrchbKNM2bunZdlyMey2Lf46318XjN3AK0eC23oZ31mfZ3xYppe1WT0IYd0O59VETmma6OFehakNKdUOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt/JpD4A; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so7906251fa.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709202271; x=1709807071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSM0yqVNr9pbupLtycXvida+yiilRqT6umNQwsM9j2g=;
        b=Lt/JpD4A23KpP8zWxnmTApYYzD3X75UpZdFoo03yNTMNvFYAozf6dfiG0GBw8w9xe2
         WitZtKHW847JP2XXmxsVFTXECcfTZtNwZH+Q4yI1gDxO0X7EuA7VjTuOORe2s5kfALaG
         aOJ2DRx0Ny/Mdb8mwLTS/OFx32kiEF+kf/mejHU9ENvj5fWyCd8pJPCqyZkjItrGgs8h
         EXqxmHzItlm1P43XMwdoimvfkAd3W7ieDHUK0frZrpT5yUslCuess1aOvqkGR59pOjrs
         bO4dis6/CA9OJyhD7q0WLKhh+dbzL2owdPecJ6Ec2nsxkUSOZ5BW+w5d+RbCJZro1FrG
         X4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202271; x=1709807071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSM0yqVNr9pbupLtycXvida+yiilRqT6umNQwsM9j2g=;
        b=ucJc7Qmdsrqcs90MkiU8GUcrGXPcLE0SewUR5a+031apB1oAgzAhe0UbfkrnceXir1
         AMZF4Z35FhayZ8zG6J/xw+YSWhJz64gb+uq+C5D2pPV4euRqH4OPhk4nIA+DG8L1ZuSx
         YewNYWOqfVatSFaM71IBKIWwj/B/PFRHDjSlxOxoIrbjQpA0Qt+2nurcVQX6OfXvr4To
         xH6SeNd3jXi7B5Dx16K0YLxJin8BSRa5JgK+pBdgxT6VaZ1nqaNnkbvDDwpV6Rl0AXav
         zYiAbGUJbCYy7bptroj+s3NlaPo/+hPveGw55toH5qKLsH2nnQWbFVTywB95xs/UoNbM
         rb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIw+YdryS97NnRUWDcnMonsW2lbok/VPyFGHdlcQx0nfqgFYaeZ9mLdmXRhurxLXV5yUHwCuWEHKNag7OPJrK+xpr+
X-Gm-Message-State: AOJu0YxjdsFkfqoVzS/B+sLsR4krzHeFxPlJ13lBIlppCKxuhwXB/Luj
	BUBeJotWTJlLujExeWCtvB8NHKkRn4NDO0N01CqSMuJR94++I4Dv
X-Google-Smtp-Source: AGHT+IGPCARuq+eE6Gw725GWNzJaofwuGjXnzqK/3ItvrsLqIi1+zkhogSBGYBl/Ve/EloBGmpGxgA==
X-Received: by 2002:ac2:46d3:0:b0:512:e8eb:f964 with SMTP id p19-20020ac246d3000000b00512e8ebf964mr974374lfo.37.1709202270338;
        Thu, 29 Feb 2024 02:24:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q14-20020adf9dce000000b0033df49c9d00sm1083649wre.17.2024.02.29.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:24:30 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Feb 2024 11:24:27 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFCv2 bpf-next 3/4] libbpf: Add support for kprobe multi
 wrapper attach
Message-ID: <ZeBbW_6ooCd_tQm9@krava>
References: <20240228090242.4040210-1-jolsa@kernel.org>
 <20240228090242.4040210-4-jolsa@kernel.org>
 <CAEf4Bzb28J0i_Xud+ZnBHM+urOf9T8HYp++JJghQKT3xfsfLcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb28J0i_Xud+ZnBHM+urOf9T8HYp++JJghQKT3xfsfLcw@mail.gmail.com>

On Wed, Feb 28, 2024 at 05:23:57PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 1:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for specify wrapper mode in bpf_kprobe_multi_opts
> > struct object and new bpf program loader section:
> >
> >  SEC("kprobe.wrapper/bpf_fentry_test*")
> >
> > to load program as kprobe multi wrapper.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 38 +++++++++++++++++++++++++++++++++++---
> >  tools/lib/bpf/libbpf.h |  4 +++-
> >  2 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 01f407591a92..5416d784c857 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8944,6 +8944,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
> >  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_kprobe_wrapper(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > @@ -8960,6 +8961,7 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> >         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> >         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > +       SEC_DEF("kprobe.wrapper+",      KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_wrapper),
> >         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> > @@ -11034,7 +11036,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >         int err, link_fd, prog_fd;
> >         const __u64 *cookies;
> >         const char **syms;
> > -       bool retprobe;
> > +       __u32 flags = 0;
> >         size_t cnt;
> >
> >         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
> > @@ -11065,13 +11067,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >                 cnt = res.cnt;
> >         }
> >
> > -       retprobe = OPTS_GET(opts, retprobe, false);
> > +       if (OPTS_GET(opts, retprobe, false))
> > +               flags |= BPF_F_KPROBE_MULTI_RETURN;
> > +       if (OPTS_GET(opts, wrapper, false))
> > +               flags |= BPF_F_KPROBE_MULTI_WRAPPER;
> 
> probably error out if both retprobe and wrapper are set?

ok

> 
> >
> >         lopts.kprobe_multi.syms = syms;
> >         lopts.kprobe_multi.addrs = addrs;
> >         lopts.kprobe_multi.cookies = cookies;
> >         lopts.kprobe_multi.cnt = cnt;
> > -       lopts.kprobe_multi.flags = retprobe ? BPF_F_KPROBE_MULTI_RETURN : 0;
> > +       lopts.kprobe_multi.flags = flags;
> >
> >         link = calloc(1, sizeof(*link));
> >         if (!link) {
> > @@ -11187,6 +11192,33 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         return libbpf_get_error(*link);
> >  }
> >
> > +static int attach_kprobe_wrapper(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
> > +               .wrapper = true,
> > +       );
> 
> nit: keep on a single line?

ok

> 
> > +       const char *spec;
> > +       char *pattern;
> > +       int n;
> > +
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("kprobe.wrapper") */
> > +       if (strcmp(prog->sec_name, "kprobe.wrapper") == 0)
> > +               return 0;
> > +
> > +       spec = prog->sec_name + sizeof("kprobe.wrapper/") - 1;
> > +       n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> > +       if (n < 1) {
> > +               pr_warn("kprobe wrapper pattern is invalid: %s\n", pattern);
> > +               return -EINVAL;
> > +       }
> > +
> > +       *link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
> > +       free(pattern);
> 
> is it guaranteed that free() won't clobber errno? or should we record
> it right after attach call (and stop using libbpf_get_error())?

hum, I copy&pasted from the attach_kprobe_multi, so did not think of that ;-)

anyway man page says:
  The free() function returns no value, and preserves errno.

so we're good

thanks,
jirka

> 
> 
> > +       return libbpf_get_error(*link);
> > +}
> > +
> >  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >  {
> >         char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 5723cbbfcc41..72f4e3ad295f 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
> >         size_t cnt;
> >         /* create return kprobes */
> >         bool retprobe;
> > +       /* create wrapper kprobes */
> > +       bool wrapper;
> >         size_t :0;
> >  };
> >
> > -#define bpf_kprobe_multi_opts__last_field retprobe
> > +#define bpf_kprobe_multi_opts__last_field wrapper
> >
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> > --
> > 2.43.2
> >

