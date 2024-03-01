Return-Path: <bpf+bounces-23169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9186E7E4
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E711F2674C
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81217BA4;
	Fri,  1 Mar 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6lJW9JF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89485443F
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316092; cv=none; b=Lr7jn3r+NuMmGAZ/dI8XrdXXosdhyu3xweT1MFpD46RiDuPNJxnqWYp+WtWtHpIGdqMVtoOWZkenbmamwj1RX91McEshN2FiOp8wa5D47zGpmPqxiQRXhjM7VdHL1uJSuI7+uJkLmJnmwnrKGpQMo4oicKez80NGQ37JDKmyETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316092; c=relaxed/simple;
	bh=5h5RqHaUCcXGC8GaAbdgl0uj03Yd49s0jp5Zx6mpcB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIUoIW0Yl0jya59WI9OJ1S8XRxMFrMHMEej2sbT/oL1p4KMv4OFuEpuZjnCqCzk12gWwfAe14UuCkxmMVX7dtvHy08lgBEegp1+n8fIFMyWKMQTNepVGoVWYD8S/cFp4n/lgBIAmfgtNV43WbIrgj6ynhDgA+ioLYF4/E80ZmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6lJW9JF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so1802403a91.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316090; x=1709920890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm/sLBJyT4jcOEXfxvVEZ/lIA30RnuNXzydg6U2f7cQ=;
        b=U6lJW9JFt3rzgjeSbrew0LgeO4gHSJdyE0npsRGK1ZPrPUIciLe1M3kvBizjmHXVcU
         D6WHvTxgdTvSc/YAkuOOejwzl9Bi/NG+J/TUzx0XgocdhIRPvvKvCken4Rt0rKNsWB4Y
         kVVj2tK7oHOgEq0ZFLtok3gH6aXG6bqZmjqTcycPD8fZw4fk7h97Q4FOTj7/R9GIHD96
         A9oFYaVR+5UyQ0BPmSuIr0rNhbmvJE6k45jLYqRjPu4Owvusv/tzasoLxBZQAjdY69lo
         Y8C7Fmcjfc0tWVFa+jvxRhPVuzQO0XA+ourVHa7AQ/BRKyuivWKTpQhPDI4rpydKDeQ8
         h52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316090; x=1709920890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm/sLBJyT4jcOEXfxvVEZ/lIA30RnuNXzydg6U2f7cQ=;
        b=ZnRT71fCrZ2hcZPg+lutfI7tVp7Ti+prV4HpRXMHaIBWuUzfyN+9+vHdgfA1SxCrWj
         22HPgKwZsdR2SG2XlJqfW9TQYd4yQder0OjUCuqIG/DVkqZqXN2LgTQlPfEkO1DZ0mw9
         gFQ9AeduQNWLxK65DlmMHMbgvzzSi6U/BRLp890r36V+KaTFQTchMA2blmImYCBBv7Vk
         XG7LUVHxHTqLHyPTGOiwTzLGLsbHDl2iXI9Bq//54RX2Ns0b5ph9iaQYNodrEkJhuMBK
         jHHv59AD48fghWCuWsv9yqjRgIa9TeIj9hY+FJotdJkWUhAVTVFQb3ImbK6NIteuPWYw
         /4yA==
X-Forwarded-Encrypted: i=1; AJvYcCVKnEBffS96QsWs9kT1IlASfzyE5yXOUwj8H9N6F5ltTvVjveVxlhZ/pEIUSgVHT634fVO+SjbEB1fMA6qE1MsjDFdu
X-Gm-Message-State: AOJu0Yxn8eAqN+wv4PT29zXshCb5xphUQWW3MhIVLfCZPwoSOLddHmA5
	uEOryrcDOs4klNpIFXgNd/27Q/kRnitoNlPNxmxYJlvwBQamTARKLS33VFZp6R7AKigX6DLagJB
	fhOdMpYbVeTfjaOMCP+88wmC2B903Wck8
X-Google-Smtp-Source: AGHT+IF1vmp2dfOCO4QFgvDvGCTZaZ3vD1O8uwzeQNCIYQ2l0TmpiXM5REp+Jl+2xvfGYZ7IV0RDJF8/bWWmWqlcnaY=
X-Received: by 2002:a17:90a:ae14:b0:29a:6086:a8f8 with SMTP id
 t20-20020a17090aae1400b0029a6086a8f8mr2404702pjq.16.1709316089819; Fri, 01
 Mar 2024 10:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228090242.4040210-1-jolsa@kernel.org> <20240228090242.4040210-3-jolsa@kernel.org>
 <CAEf4Bzbga6PK8UNUO5ZHL0Zo3t6xQ8S0tY4Da6aB+AFvm_jjsQ@mail.gmail.com> <ZeBZkmZwYqT7o4So@krava>
In-Reply-To: <ZeBZkmZwYqT7o4So@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Mar 2024 10:01:16 -0800
Message-ID: <CAEf4BzZ_5-nORBS-MrZBLbUUmZ3j3txJhhZxHPLkP-n1SnFQfg@mail.gmail.com>
Subject: Re: [PATCH RFCv2 bpf-next 2/4] bpf: Add bpf_kprobe_multi_is_return kfunc
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 28, 2024 at 05:23:45PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > >  static int
> > >  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> > > -                          unsigned long entry_ip, struct pt_regs *re=
gs)
> > > +                          unsigned long entry_ip, struct pt_regs *re=
gs,
> > > +                          bool is_return)
> > >  {
> > >         struct bpf_kprobe_multi_run_ctx run_ctx =3D {
> > >                 .link =3D link,
> > >                 .entry_ip =3D entry_ip,
> > > +               .is_return =3D is_return,
> > >         };
> > >         struct bpf_run_ctx *old_run_ctx;
> > >         int err;
> > > @@ -2830,7 +2833,7 @@ kprobe_multi_link_handler(struct fprobe *fp, un=
signed long fentry_ip,
> > >         int err;
> > >
> > >         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> > > -       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_=
ip), regs);
> > > +       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_=
ip), regs, false);
> > >         return link->is_wrapper ? err : 0;
> > >  }
> > >
> > > @@ -2842,7 +2845,7 @@ kprobe_multi_link_exit_handler(struct fprobe *f=
p, unsigned long fentry_ip,
> > >         struct bpf_kprobe_multi_link *link;
> > >
> > >         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> > > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), reg=
s);
> > > +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), reg=
s, true);
> > >  }
> > >
> > >  static int symbols_cmp_r(const void *a, const void *b, const void *p=
riv)
> > > @@ -3111,6 +3114,46 @@ int bpf_kprobe_multi_link_attach(const union b=
pf_attr *attr, struct bpf_prog *pr
> > >         kvfree(cookies);
> > >         return err;
> > >  }
> > > +
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +__bpf_kfunc bool bpf_kprobe_multi_is_return(void)
> >
> > and for uprobes we'll have bpf_uprobe_multi_is_return?...
>
> yes, but now I'm thinking maybe we could also have 'session' api and
> have single 'bpf_session_is_return' because both kprobe and uprobe
> are KPROBE program type.. and align it together with other session
> kfuncs:
>
>   bpf_session_is_return
>   bpf_session_set_cookie
>   bpf_session_get_cookie
>

We can do that. But I was thinking more of a

u64 *bpf_session_cookie()

which would return a read/write pointer that BPF program can
manipulate. Instead of doing two calls (get_cookie + set_cookie), it
would be one call. Is there any benefit to having separate set/get
cookie calls?

> >
> > BTW, have you tried implementing a "session cookie" idea?
>
> yep, with a little fix [0] it's working on top of Masami's 'fprobe over f=
graph'
> changes, you can check last 2 patches in [1] .. I did not do this on top =
of the
> current fprobe/rethook kernel code, because it seems it's about to go awa=
y

do you know what is the timeline for fprobe over fgraph work to be finished=
?

>
> I still need to implement that on top of uprobes and I will send rfc, so =
we can
> see all of it and discuss the interface
>

great, yeah, I think the session cookie idea should go in at the same
time, if possible, so that we can assume it is supported for new
[ku]probe.wrapper programs.


> jirka
>
>
> [0] https://lore.kernel.org/bpf/ZdyKaRiI-PnG80Q0@krava/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dbpf/session_data
>
> >
> >
> > > +{
> > > +       struct bpf_kprobe_multi_run_ctx *run_ctx;
> > > +
> > > +       run_ctx =3D container_of(current->bpf_ctx, struct bpf_kprobe_=
multi_run_ctx, run_ctx);
> > > +       return run_ctx->is_return;
> > > +}
> > > +
> > > +__bpf_kfunc_end_defs();
> > > +
> > > +BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> > > +BTF_ID_FLAGS(func, bpf_kprobe_multi_is_return)
> > > +BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> > > +
> > > +static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 =
kfunc_id)
> > > +{
> > > +       if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_=
id))
> > > +               return 0;
> > > +
> > > +       if (prog->expected_attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> > > +               return -EACCES;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set =3D =
{
> > > +       .owner =3D THIS_MODULE,
> > > +       .set =3D &kprobe_multi_kfunc_set_ids,
> > > +       .filter =3D bpf_kprobe_multi_filter,
> > > +};
> > > +
> > > +static int __init bpf_kprobe_multi_kfuncs_init(void)
> > > +{
> > > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_k=
probe_multi_kfunc_set);
> > > +}
> > > +
> > > +late_initcall(bpf_kprobe_multi_kfuncs_init);
> > >  #else /* !CONFIG_FPROBE */
> > >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
> > >  {
> > > --
> > > 2.43.2
> > >

