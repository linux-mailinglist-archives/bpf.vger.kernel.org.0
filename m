Return-Path: <bpf+bounces-58600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F05ABE4C0
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25443A7E7B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6D28C5C2;
	Tue, 20 May 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaFsiuTp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BD288CA5;
	Tue, 20 May 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773065; cv=none; b=rEdSx6CSlKlRO7/Z+pTkwvco6fw4aFUi0EAvhXIXJLxbcK8sUcTLTNIRU8wHbiDPAZeF9b1PnLnVBgbh4hQPcHm39p3L+hWMu3Q4w1AbpgElo80jhva09WzCuatnpo9sBIwUQJm9Ng4lcymuEj8arc+SnU+BHsXsrBLmvU1342Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773065; c=relaxed/simple;
	bh=xgNMllPyPQbD/jsNqHCtVrLImV9tm2A22847oz+aSxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5M0SYa4CRoLqErlgc/kZpCXErJZRv4cb30t1lHfk+mdtfmAJJ7F8xdRo9U+vT6mLn+5ceCCccxY5gP6paG1tFhy8QrYZcdYrjvnxvqdkUDC/fzYWIX4xaBrYjZv8H8bYV82zaOQUkUwn8V1Te2QXO0nLdr2lRkwSFpZotFU14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaFsiuTp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3108d54332eso30341a91.2;
        Tue, 20 May 2025 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773063; x=1748377863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrnzUd/yQLqyU7Ecj4tNRoixyaCDlqm4F4WRkVeusgI=;
        b=kaFsiuTphJH2OOxWuWNS3mLTQX5fFs4G11RVc/fDEaSjqvY5eYUAjNe/AIOkU2tG1H
         cz8rULH2zV/x2wQhXpD1Ld2hY+WmbyPS6en3NI96VBAV7S5SzyQwYGChz1M11EIFHocO
         bnt5DKDZMSKj4EaHp8R40E6o33lL4h9N1qUVOuKrLJwDozcj+3hKCvShg2BTHr744rjn
         WoUr+a4O/CqHCxKmB+WvUfqe9B6wvtOxSh/G/r/sgAjlRUyfmLdZuIkat1kVXzAuTwIb
         Zu279uk7YQQ28duItfAFy+vZDWCj+dj3sqZFDDzpVcyiJ0qL9dtMelMC5wxfdJkrOMev
         f/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773063; x=1748377863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrnzUd/yQLqyU7Ecj4tNRoixyaCDlqm4F4WRkVeusgI=;
        b=go5ZAhs82y5bx+F+D5BUcR+9bRGYcVY6jTEHwDdUw17SOAnaKq0fH83CzGuadppqku
         qJ++u3/WGyY8JAfwAN5HRdC1OkR75SZnBcf2J+GWWIuG3AFce0vniVbrPT9N3uPSY7p0
         PXiIHOyym8FMd6m5CY8AMaszQW/ZmZhUjlqC7p+r8Dg8B0rC7Bcohbn0rVa7G3An9Epg
         bki6fBar/4Rnrcgqy+ful/NE/kJ9k4I9lntULKmKHMOaOm8yrlKwlXpYGxYcfaWYgwuJ
         jGvgyVjQCLEQlF1KuH0t8hRKfjWjOCBx8G60bkVSvVq7/+GawU4Dbc9SLm4zLG/+QNfP
         sGFA==
X-Forwarded-Encrypted: i=1; AJvYcCUnAuQWoqwMPg60wOgNVTUMFpkXQd2u8BS98qhxt23Ju7aJs6YE+eoHOQ2E8soPVkQLn10=@vger.kernel.org, AJvYcCUx4kVQTSBfrPKi2WmZolWKObHCobrMsNU31QYk3xUwjXebOOxziuqP16XWYG2SVpCIPCq8DtxINZL0cltV@vger.kernel.org, AJvYcCX61FDYb5L+3QRvZct7b1eYKUk+iyXLscCBWGnshSiLERnnWeAKTMJe1nlEs+DG4MXSkg6HEeUxlii6hw8dAjnyCebn@vger.kernel.org
X-Gm-Message-State: AOJu0YwKK/tEuSDDScmczoMOa6CZ/9YWrrSoWTeI2OTQ2dI5R883VsGL
	ut5BkIL3YsPbNWHVchiEfPTwb3gK8XK5yMZlA1/GBMm3QQxOuJsCzY8c9ER6XrVYglixpV1fY10
	5XW7L7/EqV2rtEYFzA+kFLtj0b+iYTNk=
X-Gm-Gg: ASbGncvZaC8GJ9PpB1B5B/dVYt3M8z/OsLGrN3oN3mkkdy2liU+6UkYKBBFijiFO2i9
	AUreNoNlXv2ahSAOqgvIjuB9hehkoPKVQ+fZcX+EiGbMDV3q49ckXlU2SekZbyZ1WFEuJvW+uB+
	nnDMFm00NDGSvc5mMI/bi/yTi52mazVfpvibQMmLeRvc+/SZPWMLQ1fJd9NOM=
X-Google-Smtp-Source: AGHT+IE4ybAlv//BF8DsZphTTjPnCY4hzs7HwyQTj6wNk6+OE/f/W7jgi+Jk5MPxTYQ39xpfrlKnAcwF17FlNzlsbyk=
X-Received: by 2002:a17:90b:4a:b0:30a:4ce4:5287 with SMTP id
 98e67ed59e1d1-30e82fbd3a0mr34472432a91.0.1747773063310; Tue, 20 May 2025
 13:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520054943.5002-1-xuewen.yan@unisoc.com> <CAADnVQKZti=SXM=4owtk9jEqGMcD0mUqb46PNYwhquYfyORUuw@mail.gmail.com>
In-Reply-To: <CAADnVQKZti=SXM=4owtk9jEqGMcD0mUqb46PNYwhquYfyORUuw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 May 2025 13:30:51 -0700
X-Gm-Features: AX0GCFsY3sKiVL7c-RoHprUTofVqmOmNX1pZbpz9SDyWTlzwI07QmpOPvE0uocs
Message-ID: <CAEf4BzaHFPpz9QmVNOHH_hJ-KOF+wsimGqBYRnNwAhz7zcj35w@mail.gmail.com>
Subject: Re: [PATCH] Revert "bpf: remove unnecessary rcu_read_{lock,unlock}()
 in multi-uprobe attach logic"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, xuewen.yan94@gmail.com, 
	di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 10:51=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.co=
m> wrote:
> >
> > From: Di Shen <di.shen@unisoc.com>
> >
> > This reverts commit 4a8f635a60540888dab3804992e86410360339c8.
> >
> > Althought get_pid_task() internally already calls rcu_read_lock() and
> > rcu_read_unlock(), the find_vpid() was not.
> >
> > The documentation for find_vpid() clearly states:
> >
> >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> >
> > Add proper rcu_read_lock/unlock() to protect the find_vpid().
> >
> > Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >  kernel/trace/bpf_trace.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 187dc37d61d4..0c4b6af10601 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3417,7 +3417,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
> >         }
> >
> >         if (pid) {
> > +               rcu_read_lock();
> >                 task =3D get_pid_task(find_vpid(pid), PIDTYPE_TGID);
> > +               rcu_read_unlock();
> >                 if (!task) {
> >                         err =3D -ESRCH;
> >                         goto error_path_put;
>
> hmm. indeed.
>

yep, my bad, missed find_vpid() restrictions. revert LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Jiri ?

