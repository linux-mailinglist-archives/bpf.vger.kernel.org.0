Return-Path: <bpf+bounces-38304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3243962F6E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322851F23841
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C41AAE24;
	Wed, 28 Aug 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEO7VoQo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE391A76B9
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868678; cv=none; b=fs3z51yNeoK1/uwEea3TU4O7nI38fQNYIFev4N/QVwaAltU1VaVf0NlCaXX/s0k8KSVSs+StcZc5fT2sB2XR1lK2CPmnMvCUWsqJdy8Od7sU2oOEwyZR+YdxY5Lmm3gGpxYv8ECpgywa6sxlMVAGkDJ94NeXClAxJAimGgx70us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868678; c=relaxed/simple;
	bh=oX9CNVm7xzROQJvNuUwl0Bu3r4lb0mT+cCalwtQynRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTSZyTGSUILhiu1rCDc670A3P6kCzs1ztPFewazhm9/WcHH6VI3L88rNX8Y2Yy2or3aJCP4V+lVpdcKb0rYj0b7Atf8BK5Eab4HliUKcvUn/U7avQEwMgUg2X2OawDzWWG0EQdgBe8q6D2HT6pcY0bFCLdBG48iXfY7vC3+RvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEO7VoQo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso5185807a91.0
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868676; x=1725473476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqaB26jignlTsb75pyi69H5phOSTe06TWWyyqyq61sU=;
        b=EEO7VoQokqISdixMyqZiVNoSXriXHPN/ZaLngI7N6jv4ewUuMefYbBQbGRH+O67bof
         XWQpQzGD9NivQ/eNRpiIMJzuRrhwaX2DBO8/s1XU9mRmvS5vwIb7pBPRUzCkIMWJzAA5
         q0GzGpAcQ57+IviA3t/Tmfsva5nGivlYlKpf05yIB/xhcViQIUfeT0V16Whp+8SS/PlM
         PFSBHdgfIddF7xCezbXHhwiUIJuia18P2RTB636dRRel+52igIeiEd05jxZMd98YfKzh
         KKCEoFEY0wG5SYsQliplCu2xq7PHsAfDdwoWeisPtry5JrYxdugBzxEeq8sWH4xgdvPY
         7gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868676; x=1725473476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqaB26jignlTsb75pyi69H5phOSTe06TWWyyqyq61sU=;
        b=N0obkPVH7EtJs94D6t0bKrNb7KS+L2xtsl61MOIeoUsSpvZ7vKmPvCnjIo5y3jRuDY
         xj8LDDnVV6mFFTfQVwn0ItltY8SLCGKWsseUfXk35ITWdfe9W5F9t5ByQKvaDEPmO7Uj
         5FMxYT0QhQcaiWisXC4hCGXkB1wNpak3r1cQAQCaWPEJ2cNLQ1z1mKiG8M6BxakRf8An
         ciUo+vXS/Z5k1Ha1uATHyyqCxy0ldRMaUqurf32tz+LDv4THtEEI+o9aMFm8Al3kA8/D
         BRYFDRcds2YULsX4EMeRjvmrKiuSxzCnrBH8/P0UdF3GyX5cC0IMrp59+8c7VBnhVXaA
         s3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9EaM5Wo80tzvbmhGPz090HLEw5zuEEXZp5Wrq9Z3X/9C7CYuoX5+tXWx/xIi1JfbKhcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEA3yIuogJibpMGSh7zeL36v+UqE70exbq1gPRBH1E+Qeo8far
	jowds615xiwZ9Aov+NDwBek8yWfVlf6GmzWTlTABsVymRAUwdRGK/6zMd03izPIAL2Gu3HXJI8Q
	jnPPkhiyfSNKG3sDxFLaj7t3ztoE=
X-Google-Smtp-Source: AGHT+IGy78YHrosrqhX/VFXIC67Kb1WwKAMjiUetOl9GSuPfrMkIPOcuILQZnWSQlujJWo4wUmoL6hyiLzCcC0bDIiE=
X-Received: by 2002:a17:90a:3983:b0:2c9:3370:56e3 with SMTP id
 98e67ed59e1d1-2d856391ebbmr128033a91.34.1724868676420; Wed, 28 Aug 2024
 11:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827203721.1145494-1-andrii@kernel.org> <ktql72figcdzhjtu56mnjyxqvma4s7wf3g65ygd4kdsjovsbwl@4zltm7wh237q>
In-Reply-To: <ktql72figcdzhjtu56mnjyxqvma4s7wf3g65ygd4kdsjovsbwl@4zltm7wh237q>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Aug 2024 11:11:03 -0700
Message-ID: <CAEf4BzaONQ8FY8TzdXycH+L6yvgox+ve2_BHOjmONvpf5pbX3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix bpf_object__open_skeleton()'s
 mishandling of options
To: =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:29=E2=80=AFAM Daniel M=C3=BCller <deso@posteo.ne=
t> wrote:
>
> On Tue, Aug 27, 2024 at 01:37:21PM GMT, Andrii Nakryiko wrote:
> > We do an ugly copying of options in bpf_object__open_skeleton() just to
> > be able to set object name from skeleton's recorded name (while still
> > allowing user to override it through opts->object_name).
> >
> > This is not just ugly, but it also is broken due to memcpy() that
> > doesn't take into account potential skel_opts' and user-provided opts'
> > sizes differences due to backward and forward compatibility. This leads
> > to copying over extra bytes and then failing to validate options
> > properly. It could, technically, lead also to SIGSEGV, if we are unluck=
y.
> >
> > So just get rid of that memory copy completely and instead pass
> > default object name into bpf_object_open() directly, simplifying all
> > this significantly. The rule now is that obj_name should be non-NULL fo=
r
> > bpf_object_open() when called with in-memory buffer, so validate that
> > explicitly as well.
> >
> > We adopt bpf_object__open_mem() to this as well and generate default
> > name (based on buffer memory address and size) outside of bpf_object_op=
en().
> >
> > Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> > Reported-by: Daniel M=C3=BCller <deso@posteo.net>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 52 +++++++++++++++---------------------------
> >  1 file changed, 19 insertions(+), 33 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index e55353887439..d3a542649e6b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -13761,29 +13763,13 @@ static int populate_skeleton_progs(const stru=
ct bpf_object *obj,
> >  int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
> >                             const struct bpf_object_open_opts *opts)
> >  {
> > -     DECLARE_LIBBPF_OPTS(bpf_object_open_opts, skel_opts,
> > -             .object_name =3D s->name,
> > -     );
> >       struct bpf_object *obj;
> >       int err;
> >
> > -     /* Attempt to preserve opts->object_name, unless overriden by use=
r
> > -      * explicitly. Overwriting object name for skeletons is discourag=
ed,
> > -      * as it breaks global data maps, because they contain object nam=
e
> > -      * prefix as their own map name prefix. When skeleton is generate=
d,
> > -      * bpftool is making an assumption that this name will stay the s=
ame.
> > -      */
> > -     if (opts) {
> > -             memcpy(&skel_opts, opts, sizeof(*opts));
> > -             if (!opts->object_name)
> > -                     skel_opts.object_name =3D s->name;
> > -     }
> > -
> > -     obj =3D bpf_object__open_mem(s->data, s->data_sz, &skel_opts);
> > -     err =3D libbpf_get_error(obj);
> > -     if (err) {
> > -             pr_warn("failed to initialize skeleton BPF object '%s': %=
d\n",
> > -                     s->name, err);
> > +     obj =3D bpf_object_open(NULL, s->data, s->data_sz, s->name, opts)=
;
> > +     if (IS_ERR(obj)) {
> > +             err =3D PTR_ERR(obj);
> > +             pr_warn("failed to initialize skeleton BPF object '%s': %=
d\n", s->name, err);
>
> Ideally we'd do the same dance here for the name that we do in
> bpf_object_open, right? Otherwise the warning may be mildly confusing if
>   > pr_debug("loading object '%s' from buffer\n", obj_name)
> earlier refers to a potentially different name?

Yeah, true, but I'm not really happy to add this "name resolution"
duplication of logic here, tbh. Also validation of options, etc. Let's
keep it as is, it's very unlikely someone will be overriding the
object name.

>
> Seems minor, though. Thanks for the fix.
>
> Reviewed-by: Daniel M=C3=BCller <deso@posteo.net>

