Return-Path: <bpf+bounces-42676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA29A90CA
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42004B20ED9
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19E1FCC6F;
	Mon, 21 Oct 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSXv19IW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE11FCF40
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541667; cv=none; b=gq/sbQBGGQ0+zIDnn9eoxq339K/daIWwr26o25OErz983eFayDozxW8J1Y/o/9olaH4cBzF9k2sMyWHjfu8w9i88a0QYZ/3muJUS7BA501WUwd+soS2LRB2Newf7AibN+ywXCceFHOtLWq200Y0dIX6aZ+qz2+RgGdbr/6wsp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541667; c=relaxed/simple;
	bh=EkPhuzX+HjPlY13EutgPxK+WGoLprc1BWfFI6Ms6UQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5431DrnWsmfR/pfQK2XiznwqNwZLJdfLI1Envn0tfv2x61cIv+nL4s1tIG+nSA2Bzx5TQKSJGxdWXMlXepAwL4ENE+Tu1VSM8e39XOdaGJp0tbbhRrbkoJaGREexpXUTJNt53bfYK8M86VX6LDnW9GON2pCZbJkgwbT7893Ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSXv19IW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso3643240b3a.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729541665; x=1730146465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcmHEPsRBCphHI6eKR363upaFfHA9bLOt1gAsSD6qVo=;
        b=aSXv19IW+OdhmFQamlsRGTe5GLsfSWnQpBVL1YY1W8gmPvGgj01ZjMV7I5MfGb1FUf
         Clj+xsU55J5yAfkMvkKYs3T75gDZ3UMwzM+eg8f5ScbzgIHtLGiW+23YSwN4GmacwHMC
         wXQJ1z7ubrTHUEPHhqVvcdCIbXbTWvHzWI5m0npIX1k2Wo30hx11HZq4LbmTA/8KCU16
         69TFbCuX8fW0wgDILcOVKpEqEeLKf9AeAQndOsoCDggO4VUVhs8+Sm9+q7o0w8IjoF52
         WyrGmjNA6LBRxz+TUQrVtZ40p5EgnUlWtXe1jviqQECiTKsGxJPaCVsUfx1sEp+R/394
         /8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541665; x=1730146465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcmHEPsRBCphHI6eKR363upaFfHA9bLOt1gAsSD6qVo=;
        b=uyWXWweObc8OFwkqj/zMUjc1LFrq569MdgkmplQc/qU9VdNzZOOPvhN0+4nbwwX8KB
         thKCLIexFFq3U3weEd6NEiAOU8vesnKuiQlFR9B1ybHxGN/3LPjwqqjxhgclGD5Np2kL
         /AVzdEfsWOsg0xojZNWFVAnL6sxThc2vcZhyEmO+qc9laVwmchRA/k+Tm6ULePBHb+ld
         sze3/bFQtvl9ehxFeBPSa7kSrKkipe8fqtHeqoRqwWqeylM3Or+7U1RnITiAKvdeOqyI
         tXZJo8Bt/x8jgYFh7jTJbpH0EedeLmIwHjFjesm8NvK/Q+HwNZk71q2sJKUbBqPQgQY1
         htsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW69P+7ReQWesN1i75r9fxw6b58n1zOX7VGZXRPN88A+8tkDvLMPqyq/3IqYapiwHHTTq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGOlqw4gMQplWkerB715GO3YSmZ2EprbSnBuGou4KiDajihe2
	uMlz+thO/mUAtlXjXQeeAkdNZCXCkFoGEFYzCutOiJnfBydrU4M1PJUqsREh2GGMyKKzMj6mbbC
	f6EQVdTyEn4FQgG/eB2jCtAR8J6UFaX74
X-Google-Smtp-Source: AGHT+IFT/pZotbAGwpy+JRMT+V3IJq1eOt43Nu30mKIEFiMZOODcbgmg8Q46FpDyIaz5DD6eaNrJQCZNUT4EPGg8Qbw=
X-Received: by 2002:a05:6a00:180f:b0:71e:80b2:240 with SMTP id
 d2e1a72fcca58-71ee50541famr388128b3a.18.1729541665161; Mon, 21 Oct 2024
 13:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com> <ZxaE_C_Im9-I8OSa@krava>
In-Reply-To: <ZxaE_C_Im9-I8OSa@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 13:14:12 -0700
Message-ID: <CAEf4BzZ6b7drmHJN=Sf8Mjq6VB1Drg5g0LyeyN4URCRS63qTzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: increase verifier log limit in veristat
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 21, 2024 at 03:16:16PM +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > The current default buffer size of 16MB allocated by veristat is no
> > longer sufficient to hold the verifier logs of some production BPF
> > programs. To address this issue, we need to increase the verifier log
> > limit.
> > Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
> > increased the supported buffer size by the kernel, but veristat users
> > need to explicitly pass a log size argument to use the bigger log.
> >
> > This patch adds a function to detect the maximum verifier log size
> > supported by the kernel and uses that by default in veristat.
> > This ensures that veristat can handle larger verifier logs without
> > requiring users to manually specify the log size.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  tools/testing/selftests/bpf/veristat.c | 40 +++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/sel=
ftests/bpf/veristat.c
> > index c8efd44590d9..1d0708839f4b 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> > @@ -16,10 +16,12 @@
> >  #include <sys/stat.h>
> >  #include <bpf/libbpf.h>
> >  #include <bpf/btf.h>
> > +#include <bpf/bpf.h>
> >  #include <libelf.h>
> >  #include <gelf.h>
> >  #include <float.h>
> >  #include <math.h>
> > +#include <linux/filter.h>

this is kernel-internal header, which will be a problem for Github mirror, =
so...

> >
> >  #ifndef ARRAY_SIZE
> >  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > @@ -1109,6 +1111,42 @@ static void fixup_obj(struct bpf_object *obj, st=
ruct bpf_program *prog, const ch
> >       return;
> >  }
> >
> > +static int max_verifier_log_size(void)
> > +{
> > +     const int big_log_size =3D UINT_MAX >> 2;
> > +     const int small_log_size =3D UINT_MAX >> 8;

nit: MAKE_ALL_CAPS, given they are fixed constants

> > +     struct bpf_insn insns[] =3D {
> > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > +             BPF_EXIT_INSN(),

... let's instead either define these macro locally or just hard-code
bpf_insn structs as is (thankfully we need just two)

> > +     };
> > +     int ret, insn_cnt =3D ARRAY_SIZE(insns);
> > +     char *log_buf;
> > +     static int log_size;
> > +
> > +     if (log_size !=3D 0)
> > +             return log_size;
> > +
> > +     log_size =3D small_log_size;
> > +     log_buf =3D malloc(big_log_size);

we don't really need to allocate anything. We can pass (void*)-1 as
log_buf (invalid pointer), set size to UINT_MAX >> 8, log_level =3D 4.
If the kernel doesn't support big log_size, we'll get -EINVAL. If it
does, we'll get -EFAULT when the verifier will try to write something
to the buffer. No allocation.

pw-bot: cr

>
> IIUC this would try to use 1GB by default? seems to agresive.. could we p=
erhaps
> do that gradually and double the size on each failed load attempt?

The idea is that verifier will only page in as many pages as there is
an actual log content (which normally would be much smaller than a
full 1GB). Doing gradual size increase is actually pretty annoying in
terms of how the code and logic is structured. So I think this
approach is fine, overall.

>
> jirka
>
>
> > +
> > +     if (!log_buf)
> > +             return log_size;
> > +
> > +     LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +                 .log_buf =3D log_buf,
> > +                 .log_size =3D big_log_size,
> > +                 .log_level =3D 2

no need for log_level =3D 2, just use 4, we don't need to fill out the
buffer, we need a verifier to check parameters.

> > +     );

LIBBPF_OPTS() macro define a variable, so please move it to the
variable declaration block above.

> > +     ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", i=
nsns, insn_cnt, &opts);

nit: let's use TRACEPOINT instead, we had some problems with
SOCKET_FILTER on some old Red Hat distro due to how they did selective
backport, so best to avoid it, if possible.

> > +     free(log_buf);
> > +
> > +     if (ret > 0) {
> > +             log_size =3D big_log_size;
> > +             close(ret);
> > +     }
> > +     return log_size;
> > +}
> > +
> >  static int process_prog(const char *filename, struct bpf_object *obj, =
struct bpf_program *prog)
> >  {
> >       const char *base_filename =3D basename(strdupa(filename));
> > @@ -1132,7 +1170,7 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
> >       memset(stats, 0, sizeof(*stats));
> >
> >       if (env.verbose || env.top_src_lines > 0) {
> > -             buf_sz =3D env.log_size ? env.log_size : 16 * 1024 * 1024=
;
> > +             buf_sz =3D env.log_size ? env.log_size : max_verifier_log=
_size();
> >               buf =3D malloc(buf_sz);
> >               if (!buf)
> >                       return -ENOMEM;
> > --
> > 2.47.0
> >
> >

