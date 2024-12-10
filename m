Return-Path: <bpf+bounces-46533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A69EB92B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E931889BE2
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4321B1422;
	Tue, 10 Dec 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYmy/KeY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5C23ED59
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854724; cv=none; b=TafUCt3+lcrhCwXNkrAcotirigxrBzI6sGI++m5qkDuuUsJfj1uBIgUWPKOuEeunBUEQEG1ksnC+ccF6tZLBdYmvu7jsmFWIgniQdHD2iwDf0B9ogovpx9ppyq9PL0+bS8HmSSGAvgCBqt/EdCJhdmMY7vxk4/2GCxpvlZ9c6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854724; c=relaxed/simple;
	bh=YrOyUTKRR60i73ta2j9LVI+Soy0Z8NwY6D8L7NX7LL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orGY4nk7AiQfCiohiVP0HM3AHeQapVMsYvNpc5BqX8vEvp61arnrdqyT/kJcHFGp3Wwy/aAiC8RXHjgWTRru2fxBvFUb40ZiX7fgNmWGuHGKVL7vqnfuo80LDN7W9hxh5iK5u2+OqqLw6FTLftM6kcDVszRkfCQTPho4ZTGqgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYmy/KeY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21675fd60feso12475395ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733854721; x=1734459521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZVfpjWpOiIQ0GrKMR4GWqKcJj9ZdTxidDKccX9BS+c=;
        b=GYmy/KeYl3Km6o7sSzw4ytD6zFw6kyhFkFnaFfMdAhp6stWakKPn2ISJVl/dQE6+ve
         YPvHW+4M/0AqkyQIHNLnQggWEFx4LS5GZ9qI3+vdolylCUpyVTKUjt40G2uQE3VLOIRp
         2fKa7W+IG8PQJJ8apa14aPOH7TqFOpiCC8WGx0RKuyrd7lmKWepGyoptdVWGNEfAftBM
         F25TXDgiVMUP31J6c+/i6qxcN8JR9gqZ5xH+tCDF0EHe+pPaETy+YIhTmn5dOa4Fdk7Y
         f3tf13bBLweqbspnqOes8R5jlUW0FqJYRuOzAdE9bkDs3QA3y1M8MsQlZ39kTWCKOPRs
         bkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854721; x=1734459521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZVfpjWpOiIQ0GrKMR4GWqKcJj9ZdTxidDKccX9BS+c=;
        b=VTz9Kht5+DlZ2o1vgs7U5hSZIdw1ChJiawx+uHpZMIxo2xmtRRKgWs0TjQ0P4ALw0m
         OS+OeBQMzcq0ecP1OtGNhb4RPY8uk6pTYaZZRKEGP9TMxUaY26mI1YsBNfknPjlgSlcH
         GCE8sgRAo6mS0aXBT+293JmqO/qtXWrYepSKvefyE1+BeSV3USCYYIWhDsu49xBvCP90
         SrS9itHmKdC+toZVCj8tc6lRJChKtlHBorzzl1MdJiz4GlAjNGN0UBLEHNBuZgxEgPOZ
         jg4pIT/FvDv+9hxNGvxrkxH85ulrE4CBID6abVxIvh3gF/7NF7eYxeVmQUyTquuQVC0W
         k6uw==
X-Forwarded-Encrypted: i=1; AJvYcCXmmhrx1wJEJWlFplh581oH+eLQbrZU6i0B6R7Tbd0WvjKEqjYaZ9XjmKlo+n4pYbrLMxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRP38in+4bHnn1Y7jePlibtg+PqM10Sl1fwbXNB+HW0j1n7pRS
	n7R6fhCnekeO/aDX0EQV2O8zGxzYyEMJL8GRApS90x9LJHEM54W1zYgsP3GPBkAT+0HW9W45qlJ
	ZH4tOxo6xtm/AZ1++1qlXM353aVFxdw==
X-Gm-Gg: ASbGncsZuWuIGkks98WUvp0lyDG5LAkGMLJ2n+YK0OkiXULLFVz9br3Nnd3lXMyhqRL
	MYWitwpEHs/uj057s7smX5mWsxdPZViguRNYRXW245lcj4wHYv8s=
X-Google-Smtp-Source: AGHT+IFSH5aJi6hsmmkrhzPmDyNUUOfPmKRwUjuLpkQ/+POKrp/f3QJdDUOocEv7gX9BeE/ovu/PCnSkG/sWaq7sdAw=
X-Received: by 2002:a17:90b:5405:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2ef6955fa47mr26756721a91.8.1733854721074; Tue, 10 Dec 2024
 10:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis> <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis> <Z1gCmV3Z62HXjAtK@eis> <CAADnVQJyCiAdMODV3eVxk-m6C3xAR0mKCJYgYqUzcXypKcWwcQ@mail.gmail.com>
In-Reply-To: <CAADnVQJyCiAdMODV3eVxk-m6C3xAR0mKCJYgYqUzcXypKcWwcQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Dec 2024 10:18:28 -0800
Message-ID: <CAEf4Bza6i3nda+7XPcfmVEckwGfmvsvPmakf_VQhFHEWoVTh4A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 10, 2024 at 12:56=E2=80=AFAM Anton Protopopov <aspsk@isovalen=
t.com> wrote:
> >
> > >
> > > This makes total sense to treat all BPF objects in fd_array the same
> > > way. With BTFs the problem is that, currently, a btf fd can end up
> > > either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> > > it is to merge those two.
> >
> > So, currently during program load BTFs are parsed from file
> > descriptors and are stored in two places: env->used_btfs and
> > env->prog->aux->kfunc_btf_tab:
> >
> >   1) env->used_btfs populated only when a DW load with the
> >      (src_reg =3D=3D BPF_PSEUDO_BTF_ID) flag set is performed
> >
> >   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
> >      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
> >      sorted by offset to allow faster search
> >
> > So, to merge them something like this might be done:
> >
> >   1) If fd_array_cnt !=3D 0, then on load create a [sorted by offset]
> >      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
> >      above.
> >
> >   2) On program load change (1) to add a btf to this new sorted
> >      used_btfs. As there is no corresponding offset, just use
> >      offset=3D-1 (not literally like this, as bsearch() wants unique
> >      keys, so by offset=3D-1 an array of btfs, aka, old used_maps,
> >      should be stored)
> >
> > Looks like this, conceptually, doesn't change things too much: kfuncs
> > btfs will still be searchable in log(n) time, the "normal" btfs will
> > still be searched in used_btfs in linear time.
> >
> > (The other way is to just allow kfunc btfs to be loaded from fd_array
> > if fd_array_cnt !=3D 0, as it is done now, but as you've mentioned
> > before, you had other use cases in mind, so this won't work.)
>
> This is getting a bit too complex.
> I think Andrii is asking to keep BTFs if they are in fd_array.
> No need to combine kfunc_btf_tab and used_btfs.
> I think adding BTFs from fd_array to prog->aux->used_btfs
> should do it.

Exactly, no need to do major changes, let's just add those BTFs into
used_btfs, that's all.

