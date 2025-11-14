Return-Path: <bpf+bounces-74447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84DC5AFB8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7872B3B3999
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E19270557;
	Fri, 14 Nov 2025 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd0oMkks"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32401221578
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086501; cv=none; b=Ck/Zml6qa5ovCxOOR12rgcgqYoGB2r/4fXvUKWzm9bUQIAe3Tew5in7NL1EWJ9/Amot6u64Di/x6RV5xTKYlhRCCogNrFJBl+rzl16XxYWbNJU0EFpOOenGG4uqkkNKIFf9YtjelqWabFpLKYe6xKFciHLetasyVbR4ksidrfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086501; c=relaxed/simple;
	bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcEZZkjTEPAsNanbKL2oa8pX53jjiNKojvdJ7jvULFewhLnLnZrTqtq9JETr6Z8fVSuEMdTFg5CPcxTtIgZxNgMS4DDKpVb+RkDxAxrLnmnD9wv+xQMDLx4Mr/6cc48p2JMwK7H0j89FVf3PzSVBwlZkammNzrFVDO0iK0VIb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd0oMkks; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7869704so1120962f8f.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 18:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763086498; x=1763691298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
        b=bd0oMkkshisMBRYqle4/GGpclAISJqLbZ+xruRN34Rdx9k/dtEG3NWlHSfo2PeeTJn
         KQLijeJZIq7sAh+6o9I2XwTjpgJTXL7i0aS+Zg6hylkz18G4HiMPDHjBrP8+N/llJZaI
         4C8mKB/TIzKDds6Zc8sHYv7sqN67PSia9MB0R1yUxYdWGgzv3nc+Nr6mE1T3uKQ4Z7MK
         u3Ar4l8LetksG0HcjXF8uyc5zZ8d4a17+b9gSkqhGHlrwHQ2xa6/bmEwSCpuIHhlkKRl
         JeDmFJhinkg1zGCTibTHA80KI6h9GhKTcybwfdplHfwFYMzOHUNw7bdLdhhma6ELCSEJ
         E8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763086498; x=1763691298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
        b=pxqOGAykXT7ogkqwluHDjC/PHckOCQDZKdym01zAfE1gLobyzDb+fOeXjS2zosuyYX
         zAA5n4VXUsqdN8Kw5g08Xn/5HsveiV7WLFqzqZKaxEL6sc+ZcNeRVgnrvJ5iGFNwTuEP
         yPyol1lpXBGsSmhqv4pUs6xHdROMLc+R7WjQxD7ub46kDYFlqWMZIhtyFbIQsLRHMffH
         hPvx1Mr8zo+oZN9WHxk5eqWA4sBQDaafUDgfg/Kil39LXjulQ/VdxP8rXLits+6doNnd
         pI7R/b+MEZd4kTC75QkXlwPfCYxr4PpnAsVBWsdt3J7zilMVdCJdn9t1HG4i/an9TYpu
         vlYg==
X-Forwarded-Encrypted: i=1; AJvYcCWVLJoNrRf0pssTdvVILE1P34RWuUEFyVVOB90wx0IuagLZOkmHISYLUJBf2VstGKrWhP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5acWcF3KuqmRsrWQSzaIFA6qdOAmP70tAXIO4LzNO6eN/2vP
	8Wx7v0Cd5dwEtv2icj3uwu2AOkdsy5GRn634BvtlK5+SCSlRYbV6F2Fd+9tK6rqvPIr59DMzKLl
	fFz3jfLpulyjiPuo8Uq/TT6jYcqejM8k=
X-Gm-Gg: ASbGncvvsToNRCN5swnI/3XEbbx3eiiXoYt9So7Pd/3BDszyiSS3+cuyaKPnicpMlhz
	+K2q+0V/5bwFMTF17M8xExDxD+MEGmqhTvcuFmC9UTggGWnuZhXgqnTJYFekGEjN2+4eQDRaQgr
	RDo/HJa/0u1sF7fJRscH9EyDisCwefj+ryp5egGaOBN85lkTPAEuOsgMt7sYJklf8JkIe8XTZ9Z
	GHGAmJqGxJb9C549vtBzefXA2j+5EF/m1XmJIVjvGlWrMgxeG+iFpOMRlZdfWsnrz9G2wVgugn5
	rRk/WkWOi3yYmd/l00lkNESNzwxMrFG18Sed5vQ=
X-Google-Smtp-Source: AGHT+IGq8Zt+pVviat5YdddCLTZlt3qtwpaXQ99vIA+FGg9ovsF0ZqTybYh6tjDO47bdjpp3Oq69PypcopQt8kTYvao=
X-Received: by 2002:a05:6000:430d:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-42b5933dbf7mr870772f8f.6.1763086498404; Thu, 13 Nov 2025
 18:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com> <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
 <aRaPnq2QJN1iFF_3@x1>
In-Reply-To: <aRaPnq2QJN1iFF_3@x1>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 18:14:47 -0800
X-Gm-Features: AWmQ_bk2T-XSB88o6iYBIKRGd2t1lxi3j-bcbJRWYtMwoIYC3mxjS1Y5-B6Hi_U
Message-ID: <CAADnVQKaGgRemVtOQRgg=UmZCu5N1p6=XT+YW-668hy6dod6UA@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	dwarves <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 6:10=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 06/11/2025 01:28, Ihor Solodrai wrote:
> > > > This series refactors a few functions that handle how BTF functions
> > > > are emitted.
> > > >
> > > > v3->v4: Error handling nit from Eduard
> > > > v2->v3: Add patch removing encoder from btf_encoder_func_state
> > > >
> > > > v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.so=
lodrai@linux.dev/
> > > > v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.so=
lodrai@linux.dev/
> > > > v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.s=
olodrai@linux.dev/
> > > >
> > >
> > > series applied to the next branch of
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> >
> > Same rant as before...
> > Can we please keep it normal with all changes going to master ?
> > This 'next' branch confused people in the past.
>
> I think the problem before was that it sat there for far too long.
>
> I see value in it staying there for a short period for some eventual
> rebase and for some CI thing, to avoid polluting, think of it as some
> topic branch on the way to master.

I'm still missing the value proposition.
Right now Yonghong is also sending pahole patches,
Ihor will start moving things from pahole to resolve_btfid,
Donglin ais lso working on btf sorting,
and finally Alan has large loc* patchset.
Some or all of them will conflict.

What do they suppose to use as a base?
'next' branch? All of them or some?
How will you differentiate and educate developers ?

Really, 'next' branch is not a good idea.

