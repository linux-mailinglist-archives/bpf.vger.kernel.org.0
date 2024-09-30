Return-Path: <bpf+bounces-40624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740398B0AE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795B01F22E4A
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26795188A1C;
	Mon, 30 Sep 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/KblZQ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF917798F;
	Mon, 30 Sep 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738272; cv=none; b=iszhC44W2RMK16kMfPr+R6Ci57DVijYdpjhz0oWeOGTw5d3SYCdz3YEenEHr601mbTbDcf/0QwQwMMBE7YwNsBvAMCqoOg4WmFxDsTyebfxhjXU1+eZ8ioTbI/s6ylt4+LS2aaiJ6d7nLBZC1Ajj66HO7ydr5JV8PJhg3PfNhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738272; c=relaxed/simple;
	bh=Y2N2gMrrP3gdldRLITILmhvAkRtYTdhz+PTlF5q6Ry4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/zEF59fdnwusbClID7M9Wnx/2CJNFwzuLd8cAp4mPQ7hCaDQfRjenwFAxwAJb2EKBuIckWlNPgbd+BiPqgJ+1TecZ8pPIOfKQUhNj/ssjG0Mo7++RuszRERTHX1olKIZusBcbm6N0ZyUfpSNXNSVNoW8VJANmpxWg78CTApATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/KblZQ6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b64584fd4so16349895ad.1;
        Mon, 30 Sep 2024 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727738270; x=1728343070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51cWZof8LQF3H3bDFgOCRd/ObmUG7m4ZND6e3BBb31Y=;
        b=W/KblZQ60QLFW8IPzG93DgTyLrcyZMGnJawjFg2DZjjecl168m9SXhuZ9xM1QlFyej
         K43kUjLDqFvXetB3TTPp3eJusQOpx3vUK7V4X8eLLm0gyXLb0qKXVy13WdCcBOD1m8Ak
         7WmiYuh+j5ryy3EoeMDhGC7Bkbm77XvXAGIS/EULz/uWARwb/qwM3hWl9JFTR1RScKZV
         as6o1PMCe2vyAgAXVbBKp+WjX/vEtaVaqiaVEvYXsZIcp6FWIuIYRp9tgNRDqNgIZtqz
         pJdW1qUwKsqcd2PueWO3JoUd5ZYp2oL4nMYcnB0e9j+DyCZX/b+H5KjGCHbZdNHeo3yZ
         WmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738270; x=1728343070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51cWZof8LQF3H3bDFgOCRd/ObmUG7m4ZND6e3BBb31Y=;
        b=wptGsFGvM3bJHtQXuDzg56968AACsajkildtoJllxkVYOkdoIvNDGBW0QDCDzc5v+E
         m95m4Mmb6MyUrfg63hNp0lSzKMnEaTbxEHN69YZoJDEMyv9ET1TPcxPGbdMKgHje8sMc
         D+FEWR1RrGklHpdvpTqa2QXTBVwmTQmviLZZclCCzOG2PRQTE7QiH+nn52fvGzRPfCNF
         FiWcCAsitkj6YIyiCHMv7gDtJW+rHB8d7QNAxxJyEi5A6Yxfl9IZuAY0CMc3ondHFDpL
         yltygbUOSGBOVaGnPwrfJ4AhUzdyGaEDCaRRW6K28lAaoxzDKfiIcAjBMGhWTghbc9KF
         thLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBIg4UzhpOvRKJXcxar8qoQulfJrXVD1LoFwclkaonVJ64kZZow72ab4A/4LKhBkIsW4U=@vger.kernel.org, AJvYcCWmI4h6R1g4e4XL74Ie+0Dn0JaquK1CWOYmXFF1wSaqf8u1eaCPNW4GqgtUB2/OVyFd9xKWw25BHdh9aAHh@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTOEYz7+bSX7jfRd1QLKtcvo8Z74vPtJv24AAqK0Luske0IPq
	XPDD84vmmSF5mjS+Ug/Ti1kri6rsq0pF+uCdfvnodDzjAcqMlIfTcPvVOIHh0QSIxCaAXNgWbot
	JTixW2GcnOXqDLUCO0oaB49GUf+E=
X-Google-Smtp-Source: AGHT+IGcWS0XZYCX/k8q1Dti6cK0hUtuZOdWz41n1PPDqIExuIP6VxSZxLmhoXWwHJ+Wt+SkuqJdjnL6STw3eoPzrqE=
X-Received: by 2002:a17:903:230f:b0:20b:6d47:a3b1 with SMTP id
 d9443c01a7336-20b6d47a97emr101618135ad.21.1727738270415; Mon, 30 Sep 2024
 16:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409261116.risxWG3M-lkp@intel.com> <20240926072755.2007-1-eric.yan@oppo.com>
 <CAADnVQJ5xCsBg057gKOQOYA1+9pD-X86bjYJVrTbpRNstvW=DQ@mail.gmail.com> <TY0PR02MB5408EE044112DE9640CB06FFF0762@TY0PR02MB5408.apcprd02.prod.outlook.com>
In-Reply-To: <TY0PR02MB5408EE044112DE9640CB06FFF0762@TY0PR02MB5408.apcprd02.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 16:17:37 -0700
Message-ID: <CAEf4BzZ1uFeY1YgL1t5Rcp60a_gXZ0ap3_8=ZOaP9G98_CXfow@mail.gmail.com>
Subject: Re: [PATCH v2] Add BPF Kernel Function bpf_ptrace_vprintk
To: =?UTF-8?B?54eV6Z2S5rSyKEVyaWMgWWFuKQ==?= <eric.yan@oppo.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, kbuild test robot <lkp@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:29=E2=80=AFAM =E7=87=95=E9=9D=92=E6=B4=B2(Eric Ya=
n) <eric.yan@oppo.com> wrote:
>
> This patch is mainly considered based on the Android Perfetto (A powerful=
 trace collection and analysis tool, support ftrace data source).
> The output of bpf_trace_printk and bpf_vtrace_printk in ftrace is like:
>   app-12345 [001] d... 654321.1970001: bpf_trace_printk: blabla..
>
> FUNCTION field of this kind of message is 'bpf_trace_printk', and there's=
 no standard syntax format for it.
> Currently, Perfetto doesn't collect 'bpf_trace/bpf_trace_printk' trace ev=
ent by default, but does support
> 'tracing_mark_write' function style by default, such as:
> app-3151    [000] d.h1.  6059.904239: tracing_mark_write: B|2491|BPRF-315=
1|TracingFunc
> app-3151    [000] d.h1.  6059.904239: tracing_mark_write: E|2491
>
> Therefore, it's considered to add this kfunc to output formatted BPF mess=
ages to ftrace like trace_marker,
> allowing perfetto to collect and parse 'tracing_mark_write' events by def=
ault and eventually visualize them in the perfetto UI.

This does seem like a bit of an overkill to add a new kfunc just to
have "tracing_mark_write" instead of "bpf_trace_printk". Is there any
chance that perfetto can be changed to also track bpf_trace_printk,
perhaps with some pre-agreed upon prefix or something? E.g,

app-3151    [000] d.h1.  6059.904239: bpf_trace_printk:
!B|2491|BPRF-3151|TracingFunc
app-3151    [000] d.h1.  6059.904239: bpf_trace_printk: !E|2491

Generally speaking, bpf_trace_printk() shouldn't be used in production
setup (much), so perhaps parsing everything from bpf_trace_printk() is
OK (assuming it follows this vertical bar syntax)?

>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexei Starovoitov <alexei.starovoitov@gmail=
.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 =
1:10
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E7=87=95=E9=9D=92=E6=B4=B2(Eric Yan) <eric.=
yan@oppo.com>
> =E6=8A=84=E9=80=81: kbuild test robot <lkp@intel.com>; Andrii Nakryiko <a=
ndrii@kernel.org>; Alexei Starovoitov <ast@kernel.org>; bpf <bpf@vger.kerne=
l.org>; Daniel Borkmann <daniel@iogearbox.net>; Hao Luo <haoluo@google.com>=
; John Fastabend <john.fastabend@gmail.com>; Jiri Olsa <jolsa@kernel.org>; =
KP Singh <kpsingh@kernel.org>; LKML <linux-kernel@vger.kernel.org>; Martin =
KaFai Lau <martin.lau@linux.dev>; oe-kbuild-all@lists.linux.dev; Stanislav =
Fomichev <sdf@fomichev.me>; Song Liu <song@kernel.org>; Yonghong Song <yong=
hong.song@linux.dev>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] Add BPF Kernel Function bpf_ptrace_vpr=
intk
>
> On Thu, Sep 26, 2024 at 12:28=E2=80=AFAM Eric Yan <eric.yan@oppo.com> wro=
te:
> >
> > add a kfunc 'bpf_ptrace_vprintk' printing bpf msg with trace_marker
> > format requirement so that these msgs can be retrieved by android
> > perfetto by default and well represented in perfetto UI.
> >
> > [testing prog]
> > const volatile bool ptrace_enabled =3D true; extern int
> > bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const void *args, u32
> > args__sz) __ksym;
> >
> > ({                                    \
> >     if (!ptrace_enabled) { \
> >         bpf_printk(fmt, __VA_ARGS__);     \
> >     } else {                              \
> >         char __fmt[] =3D fmt;               \
> >         _Pragma("GCC diagnostic push")    \
> >         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")  \
> >         u64 __params[] =3D { __VA_ARGS__ }; \
> >         _Pragma("GCC diagnostic pop")     \
> >         bpf_ptrace_vprintk(__fmt, sizeof(__fmt), __params, sizeof(__par=
ams)); \
> >     }                                  \
> > })
> >
> > SEC("perf_event")
> > int do_sample(struct bpf_perf_event_data *ctx) {
> >         u64 ip =3D PT_REGS_IP(&ctx->regs);
> >         u64 id =3D bpf_get_current_pid_tgid();
> >         s32 pid =3D id >> 32;
> >         s32 tid =3D id;
> >         debug_printk("N|%d|BPRF-%d|BPRF:%llx", pid, tid, ip);
> >         return 0;
> > }
> >
> > [output]:
> >        app-3151    [000] d.h1.  6059.904239: tracing_mark_write: N|2491=
|BPRF-3151|BPRF:58750d0eec
> >
> > Signed-off-by: Eric Yan <eric.yan@oppo.com>
> > ---
> >  kernel/bpf/helpers.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c index
> > 1a43d06eab28..1e37dae74ca6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2521,6 +2521,39 @@ __bpf_kfunc struct task_struct *bpf_task_from_pi=
d(s32 pid)
> >         return p;
> >  }
> >
> > +static noinline void tracing_mark_write(char *buf) {
> > +       trace_printk(buf);
> > +}
> > +
> > +/* same as bpf_trace_vprintk, only with a trace_marker format
> > +requirement
> > + * @fmt: Format string, e.g. <B|E|C|N>|<%d:pid>|<%s:TAG>...
> > + */
> > +__bpf_kfunc int bpf_ptrace_vprintk(char *fmt, u32 fmt_size, const
> > +void *args, u32 args__sz) {
> > +       struct bpf_bprintf_data data =3D {
> > +               .get_bin_args   =3D true,
> > +               .get_buf        =3D true,
> > +       };
> > +       int ret, num_args;
> > +
> > +       if (args__sz & 7 || args__sz > MAX_BPRINTF_VARARGS * 8 || (args=
__sz && !args))
> > +               return -EINVAL;
> > +       num_args =3D args__sz / 8;
> > +
> > +       ret =3D bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &dat=
a);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt,
> > + data.bin_args);
> > +
> > +       tracing_mark_write(data.buf);
> > +
> > +       bpf_bprintf_cleanup(&data);
> > +
> > +       return ret;
> > +}
> > +
> >  /**
> >   * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
> >   * @p: The dynptr whose data slice to retrieve @@ -3090,6 +3123,7 @@
> > BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)  BTF_ID_FLAGS(func,
> > bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)  BTF_ID_FLAGS(func,
> > bpf_iter_bits_destroy, KF_ITER_DESTROY)  BTF_ID_FLAGS(func,
> > bpf_copy_from_user_str, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_ptrace_vprintk)
> >  BTF_KFUNCS_END(common_btf_ids)
>
> Why new kfunc?
> Use bpf_snprintf() and follow with bpf_trace_printk() ?

