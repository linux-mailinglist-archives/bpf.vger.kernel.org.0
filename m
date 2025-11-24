Return-Path: <bpf+bounces-75347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423AC8140C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F6F3A3B02
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181993128A1;
	Mon, 24 Nov 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcBNuRAz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6130C62E
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997041; cv=none; b=bVUcKp81z32yC5H4kLSC2XaaiGoD3Hmj5HMQycxAS4Y7Tk4gzbX7z/RozTuR6fTo5NfNz2SenpnNzQrdD1k0mnzP+dvW7WBkY2JfrhtNLvJVl74jx9PCJs9XjiV/OhViZXojAZDFYSdxxzbgme//hjTCQ4WworEtnGm2zRQgTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997041; c=relaxed/simple;
	bh=Df9bsNtpf61lXTQLERA27IEfVYRZD/OI95zxoDRCLs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqUE/lpiZvE+sCgZHmP/UtOhuYGyzwMKxtxQPR0RxUORMH2wPurOcAM1RjgDxvCapMISiWY7vDsCGqx0PLEEgXASQa8u2HfKEPO2r3F+5E0MEzXPUnptGdkWFYTweUu/b/TCy3v7vh3LsALDOojVLXoTXuCe+4ducWLVUkelcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcBNuRAz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477770019e4so38806795e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763997038; x=1764601838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpdSGRS+xNb0pTwB0mUSQxzBmiO2t5UG75v/4yKLtsc=;
        b=QcBNuRAzcziVe4zMd5Csd3uOtXie2CE1S3a84c46eg/TjXORxEzo1nh2+1LSId8N6Z
         qizgRF46qQNuYWdTabT+wtI4Ju/0qRogvDQRbwBObfVsFfKDMYOga08sKGod6Kom2Z9P
         XnOwwXh2oMZ8yfBqp0Ir3SypPV409tWcqbcs4xuW+B00MN0FTRHGV5dHNZDZ67C28CD6
         0+ND267igL7P/PHN/422nB2UVBFwe5JppUetuEBSu+PfzsPKy/wYJcWFC+6P1bf12Ivd
         jQFJbhqKbBTcl/0XtklR8dLlgneaHxhJNH84URngf69vrpLWDmd5oFu+PK/biejPC0rV
         5gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763997038; x=1764601838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpdSGRS+xNb0pTwB0mUSQxzBmiO2t5UG75v/4yKLtsc=;
        b=CgOabmfEaNkGCW9a8e+XG6bGfIsH0KPWU/aqg4OE0/6uO6qtK/t9Uv60dQKSSM9T2r
         WI9p0PIIvvHBZ7REcXBMYxB2aBbzks4oz0RYgFXNtou2wU/LrGpaihrIDxDWXtzEqah5
         rqqLLJYd57HxCVu8lNmY/EskKw3DCSXAGCFx5LuOmtvTbWglvSez/zNT90cWCD5i/tEP
         xKqyjs2BMvyTnvN/6/DvQCywGZJLAbGFJnaxsgYcbbgYI1L/Bty6ABIRJoZJ/nETzdMp
         u0fxLVVTqwXrS+8ruaywr7Kph7Mu6i3yKKlIa/0iKWhbWAs/GLHclt/bIrnNa5ulgTJ9
         8RRg==
X-Gm-Message-State: AOJu0Ywnxx4wyyB4OmuQceBWTGjGfK/1qSAX9pf1gqcolYtdNuxt6WNV
	9cEqr3eSVXAXawVyM5zTLa6lHIj3C4Ryol0Dah6GB5tt4a14wA84D5Im
X-Gm-Gg: ASbGncuJ+SSuUk4CzYpH65AdyjTA7qBtFxdlSzh+zN4Hfh4q9lsSXlPZSkxkHlqNLG+
	s+kuGYkKfWAsfhSHQkAriAAMkiGUSr+/fj2XzaUzM7T7AbxFirSmAdSBUJTngLeIAmvrPC5G/Cv
	2X2yWHv6hAyt8mMOpjAB9rw8mCRu0rMIjhDENX4LwqtQtHdkl+6vqyt95GsfbwybTfoiRIwtD5I
	HXmhzrfXeUpXFuFOnXJUu2/qC+9LMx98nJUHaPtzi1B5kDlYsAeERiZYdfUwcQbI930NBkc4hiR
	40hJmDyNYB1gDu8r9w6XoObBSJO6FHPl/PpG9o5y/OoJ1rryiC/xDqrhJBE7yOaNmdfW9GjT9k2
	/WShpvrBxE4Ll2gKkJDaXoZt8rrrEolxCLKXZZdd81546MVGw6/NUDMzKwd8KcqR6C18Y28W9fl
	dFtYHDNQqgtexE+tI45xcU
X-Google-Smtp-Source: AGHT+IHK2iDlXYVEfqi2Tl7+iFk8srSQDA5ARhfWXXgWo8/borjQvKpdpzQRO1+FeuK/lyYYslNPXw==
X-Received: by 2002:a05:600c:450f:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-477c016b051mr115591525e9.2.1763997038016;
        Mon, 24 Nov 2025 07:10:38 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5b6sm28542823f8f.1.2025.11.24.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:10:37 -0800 (PST)
Date: Mon, 24 Nov 2025 15:17:15 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <aSR2+8fKwyLZ0WjG@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-2-a.s.protopopov@gmail.com>
 <CAADnVQ+MmpDpSsQZW42K3nozcuM5yJMRRZRABjiTiybNQpBJRA@mail.gmail.com>
 <aQxx3Zphpu43l1/p@mail.gmail.com>
 <CAADnVQJmg17Z9jWWZ8ejCCNWcnSU0YeRiDHSp__+A0C8QtTMvg@mail.gmail.com>
 <aRnKXNPkENDiRcnO@mail.gmail.com>
 <CAADnVQLTi6-jCxyGub3eQydf00238LuFdM2e_iXx=GtjZedKcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLTi6-jCxyGub3eQydf00238LuFdM2e_iXx=GtjZedKcQ@mail.gmail.com>

On 25/11/21 06:40PM, Alexei Starovoitov wrote:
> On Sun, Nov 16, 2025 at 4:51 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/11/06 09:08AM, Alexei Starovoitov wrote:
> > > On Thu, Nov 6, 2025 at 1:54 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > On 25/11/05 06:03PM, Alexei Starovoitov wrote:
> > > > > On Wed, Nov 5, 2025 at 12:58 AM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > @@ -21695,6 +21736,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
> > > > > >                 func[i]->aux->jited_linfo = prog->aux->jited_linfo;
> > > > > >                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
> > > > > >                 func[i]->aux->arena = prog->aux->arena;
> > > > > > +               func[i]->aux->used_maps = env->used_maps;
> > > > > > +               func[i]->aux->used_map_cnt = env->used_map_cnt;
> > > > >
> > > > > ...
> > > > >
> > > > > > It might be called before the used_maps are copied into aux...
> > > > >
> > > > > wat?
> > > >
> > > > It is called from fixup_call_arg() which happens before
> > > > the env->prog->aux->used_maps is populated as a copy of
> > > > env->used_maps.
> > > >
> > > > In any case, I will take a closer look and follow up on
> > > > this after Kubecon (which is the next week).
> > >
> > > Pls look at the diff
> > > and also
> > > line 22074:
> > > func[i]->aux->main_prog_aux = prog->aux;
> > > line 22099:
> > > func[i]->aux->used_maps = env->used_maps;
> >
> > [Sorry for the delay, I was travelling and didn't have access to my lab.]
> >
> > I've seen this diff and tested it before sending the previous reply.
> > It didn't work, and it doesn't work now on bpf-next/master: the
> > "./test_progs -a bpf_insn_array/deletions-with-functions" test
> > still breaks.
> >
> > The reason is as follows. There are two cases for which JIT is called
> > differently.
> >
> > 1) For a program without sub-functions the JIT is called from the
> > bpf_prog_select_runtime() function. By this time
> > aux->main_prog_aux->used_maps are populated and thus
> > aux->main_prog_aux could be used; or just aux, as there is only one
> > prog.
> >
> > 2) When program has sub-functions, say one, the jit is called from
> > jit_subprogs() and later the call in bpf_prog_select_runtime() is
> > skipped. The jit_subprogs() is called before the bpf_check()
> > epilogue, and thus not func[i]->aux nor aux->main_prog_aux
> > contain a copy of used_maps, it is only copied later.
> >
> > To make two cases look the same ("aux->used_maps is correct"), I've
> > added
> >
> >     func[i]->aux->used_maps = env->used_maps;
> >     func[i]->aux->used_map_cnt = env->used_map_cnt;
> >
> > Note, again, that in case 2, without this copy, no functions will
> > have used_maps set, even main_prog.
> 
> I see. Thanks for explaining. That's one more reason to split prog and subprog.
> Could you please follow up with the patch to clear them back
> after JITing:
> func[i]->aux->used_maps = NULL;

Thanks, makes sense, sent. (Will send a few more follow ups later this week.)

> it's not great to have pointers to freed memory sitting there
> for the lifetime of the program. I suspect it might confuse
> tools like kmemleak that simply scan 8 byte values.

