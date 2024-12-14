Return-Path: <bpf+bounces-46982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616459F1C9C
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA21169674
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECE6A33F;
	Sat, 14 Dec 2024 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="BHaK6sEH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FC26AC3
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734153023; cv=none; b=JNoB8W8EOi5dGoAByhCX2S5985sfym8zxrXPLkiSEplYcUgmG6zW1ei1O2qo5Npm7MZ8oSPldWg7Enpm1b+CkbkjA+gow2TKoSbgGj6W+ZjepsNnWJTqlfFm6KGOx9S6t6e3T9lQ8a9t9FdXp0gPRomZgX6dq1Cwz2sFZNoHVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734153023; c=relaxed/simple;
	bh=gQQp8sqD1mD8rskY/KjikTDnBE0xeGB+pX4uJf4qVPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILjuxGj2p+Gx+UlFvBhtGKdCcxg6x4FEqYIZeBd8AccJ8GWrEUSY3xEJbzTjg+KIm2WouF69At7pnaYa8pOCEwjPgNdXet2C23Afxo3ObtMIjLEBQ2ZSuQa2EJCiJ9r8qM0eZ/RQtApmLgeX/eaLS/6My/8IZRuN8CoAQFQAn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=BHaK6sEH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f249f3b2so3126490a12.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734153019; x=1734757819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e6tAySOO4zfoEIpmwTZzV6R7fL9sKuxl6Qlp4GzbRo0=;
        b=BHaK6sEHX7iClNPfQL7PonxhDRCc4rnZhhH8pe9DGuxRJagzbfDkDAbdOgGMt9GqeG
         7Yu9akb2drQ8bbEirZjVGo4aJoJub4UbYLQ7PCj1NCzWkBWcXO/egUd6FkBpSa8Cx4Js
         eUZwHbadMqhnwlAhAimY7+lBsPp8emsY7TVH53/vHxdhwAjYhPHJ92OwFYDTPtTYXRFu
         ZunPJY/z0yR/aHGWn1rYLPdlEmOCS++EYw6QWWUPC+0aJfX7tVSAPT4cnIG4tAt4mTCg
         FqFmjdJZalTN8sbUHM+9lFGC0vapLBT9EdxfQ+biVFCsY9JbqIlKzZl4fNokyh6iTbEo
         L8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734153019; x=1734757819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6tAySOO4zfoEIpmwTZzV6R7fL9sKuxl6Qlp4GzbRo0=;
        b=FB+YeFRsPkZb9V6UKGA7J9+uzsNwaAj79CcCJ0eMeGz4J9ZSrOVYA+lBd3ebBAUQg+
         flWVi+spOFufuUdpKoFxHGlmNhRHYKA/6eWqxXNKA6IsM8QMm5xH5F+J4RL26mhmikCX
         0NiA7IQCIeRxXKnf2QNTsbDPdm6iWZTYcnqhHs7iikr33ZtOx2fhoVjI7XwJy+1L5gup
         UdCAB9vB6BG12LpKbys6Rkw8AvoK3+EO5PSsR2PhduMTAHql8B8Am4QDGAs7+nG596A1
         INmVSwqfWqmi2+RoQDP7/rIINfqnFN0HJnEvzrjM4akhVZyXhAWQGijr30fZyYAcWcFL
         WRIA==
X-Gm-Message-State: AOJu0YxtVk6mpH/wH2mdQbfQQGHWzDNMY69eoC5y7KLYvovcs1fD0yyv
	woD/OjUvEwNjkQSgnR6X3g48jq2aqrNnCUh0A+d82osPPa/9KgIUnq2GYepxQwE=
X-Gm-Gg: ASbGncv1AhrfJIGlv4+tuj+Gl1JZTOLEJu2OX+UfVERNZb31rJZtMVx3/kc1sy7zaOU
	lTbwgMYK72i4Z62tC0xh4dNgdSZ5FjJruhuAizhDPOQx43y4w3wy/c+wrKASUI/eNwRD/RHJUH/
	oYO1Q6eaglAJVfwR5VZJTD2a27H+rcr9m7OpDCp7XeHEq+tdIWquzT1D2KdwimEASEoSFSQ2+ys
	DwwRE4Krwzvr1oPnqSis6eIXu7zvSnZRXhcvjpTBvlndg==
X-Google-Smtp-Source: AGHT+IFt/s1EBMXB+G7X4d71SO+a6dYjvYmbqsxuCYXZI0jN3LOsqzTwEl+6WjQ1kPiG47oWn+F4Tg==
X-Received: by 2002:a05:6402:4499:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d63c3405bfmr12235930a12.18.1734153018954;
        Fri, 13 Dec 2024 21:10:18 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963ced07sm48627466b.204.2024.12.13.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 21:10:18 -0800 (PST)
Date: Sat, 14 Dec 2024 05:12:05 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 4/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z10TpWbexd4JDGps@eis>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
 <20241213130934.1087929-5-aspsk@isovalent.com>
 <CAEf4BzYqRyNCb5WB7JPA_N597LnpLm3e0ykPTP7m1eco_wyYpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYqRyNCb5WB7JPA_N597LnpLm3e0ykPTP7m1eco_wyYpQ@mail.gmail.com>

On 24/12/13 02:18PM, Andrii Nakryiko wrote:
> On Fri, Dec 13, 2024 at 5:08 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > of file descriptors: maps or btfs. This field was introduced as a
> > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > present, indicates that the fd_array is a continuous array of the
> > corresponding length.
> >
> > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > bound to the program, as if it was used by the program. This
> > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > maps can be used by the verifier during the program load.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/uapi/linux/bpf.h       |  10 ++++
> >  kernel/bpf/syscall.c           |   2 +-
> >  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
> >  tools/include/uapi/linux/bpf.h |  10 ++++
> >  4 files changed, 112 insertions(+), 16 deletions(-)
> >
> 
> [...]
> 
> >  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
> >  {
> >         u64 start_time = ktime_get_ns();
> > @@ -22881,7 +22954,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >                 env->insn_aux_data[i].orig_idx = i;
> >         env->prog = *prog;
> >         env->ops = bpf_verifier_ops[env->prog->type];
> > -       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> >
> >         env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
> >         env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
> > @@ -22904,6 +22976,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >         if (ret)
> >                 goto err_unlock;
> >
> > +       ret = process_fd_array(env, attr, uattr);
> > +       if (ret)
> > +               goto err_release_maps;
> 
> I think this should be goto skip_full_check, so that we can finalize
> verifier log (you do log an error if fd_array FD is invalid, right?)

Right... Thanks for catching it!

> If this is the only issue, this can probably be just patched up while applying.
> 
> > +
> >         mark_verifier_state_clean(env);
> >
> >         if (IS_ERR(btf_vmlinux)) {
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 4162afc6b5d0..2acf9b336371 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1573,6 +1573,16 @@ union bpf_attr {
> >                  * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
> >                  */
> >                 __s32           prog_token_fd;
> > +               /* The fd_array_cnt can be used to pass the length of the
> > +                * fd_array array. In this case all the [map] file descriptors
> > +                * passed in this array will be bound to the program, even if
> > +                * the maps are not referenced directly. The functionality is
> > +                * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> > +                * used by the verifier during the program load. If provided,
> > +                * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> > +                * continuous.
> > +                */
> > +               __u32           fd_array_cnt;
> >         };
> >
> >         struct { /* anonymous struct used by BPF_OBJ_* commands */
> > --
> > 2.34.1
> >
> >

