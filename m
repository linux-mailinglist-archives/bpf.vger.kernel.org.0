Return-Path: <bpf+bounces-60547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE71AD7EE2
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF693B087C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2F2D8773;
	Thu, 12 Jun 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXny83TG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E82233140;
	Thu, 12 Jun 2025 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770871; cv=none; b=sFtLIw3fUecpLfB1XylT58pq4/ZJDJPfMphT76vi7lzS93/vNr5iOtoYoYvxJOmzUu4aTueWXQt/Wy1AhE2vzRj4zH+0ScJZynLs5ZrY4EGWdHCpgbyexP6X8A0zsK0liW2yymQIh73UywkioLjbVcktNYoEYVornofI98FhRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770871; c=relaxed/simple;
	bh=atF+EYocQCk1rmvpg9cscQ5ifNYcqFKvdJiMYijPVHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2Mg/K5ipe6ZBeLQqRhqZRAcDeP8re8OXLiOUksivdx9U+EamwxNUyGsctlgNvXbaBu/IFw+3pWV+bhwC2RQQCZvhQja5+c1jDaowP+X5nrLCsDctK6I4KYfw8oNWUE8uj91Dyvt1dPdBZrid3XafhbJIG+4Ord+jrwhNtwA7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXny83TG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4476d381so1373873a12.0;
        Thu, 12 Jun 2025 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749770869; x=1750375669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atF+EYocQCk1rmvpg9cscQ5ifNYcqFKvdJiMYijPVHQ=;
        b=GXny83TGpcAZoj8BMphzmBzIfhAjGghwgyKZQOb94uBojqcZ0f3z+MAkSfAB/ywDjw
         gcmtQbgEZNUBprXpnTst19i/cPIaxUF0WOWrnarBj9eup4n5BPHTIKVnLVWMlkzraBuj
         arIQ6gWwVHYnH27707av8WpzigB3AqjvLtI7k+qRUJUmtycFeqeKzfCNC4H/UXQo++P+
         Top0UtY5tFhTcyM6ZMofCnCApIfXLl/2+JAKqfegM7IVz6KSE65U8Kefprov3p6noXcu
         TvBPc+GFgMWK9xk31sfL1h9qgIDfzEy4IXd0snjh7UIyUSTqX1uJyabQI//d7+TSjfbf
         C79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749770869; x=1750375669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atF+EYocQCk1rmvpg9cscQ5ifNYcqFKvdJiMYijPVHQ=;
        b=l53snUtpm55oEOYZYitwiGZJP8AlK8Np2//n8UCF8h3tnw60sedZsbIDHAsAlZRrFu
         +Fc8FjEsrrRqPYCbSqoLJzUb65CIpibo4iBabNNRM14qxtOWwQi9mEu9rmKwljNObQSW
         WmtOvxQCzP+HrF32ocYRFzJjvfDJ0t4obtzyXz5iB52pfzfa04IFjNgggNgdq2+i2aM3
         eFUKkZNm2kaLT12qK++2zQlI22R8lJnjzHtLzQMRRlkaOF2CDBg0hnyO4XmW2haIcsbU
         mLL6xLu6lJrjx0hG6HUzT4Mrr9htNNSHgv+OAA2Pt2SsR3/YwSJ2bIe7D0ttWbv9IOdj
         fcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVxMoWCHBzOppr7/AxuzDNX2nuz3G4M9l0nr1VG6OSLmnMVz8q6S99e98i33mHEe9LVUptFr5kwbROx8t2shJZ2d8K9@vger.kernel.org, AJvYcCWlQPK3SIbQsmOu7tx39eGPP1zuGvvLlGAVjp9Y8qf8e/4YwNt8fveg0cw+JhUAhDQkpi1Bgtlassg8gwF2@vger.kernel.org, AJvYcCXtPjSabknqfJK+Ua9Pkb3d/YwkbMq4A94D93I/NsKv58AUhYHWQ9piLqhjfyCOqxmrrwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6cOxC+SvQqEzWQHUpUyAnRj9maEX1HctLZ69hRtIR3iu8SOy
	Xa1AG4/fzO/FzkQgJPQxidhHodFvCcVN4mym94RcDSX74qveknWr8NJBNKSUrP5LGKj+aV7SpRj
	QXuSMV5cGnlrxE0iEhuQkTHZLqkuqY2A=
X-Gm-Gg: ASbGncvF3Q6sZHKmamNj1SfJijJylsjK5P5PlK4QtmUXOFRnSr5rNsQ5ZYdco0veaX1
	OeCw9Lrnqx4ONlFY1PE9Q55kMYjyanlGJz1N1f2vj0fUc4ahvdlAqIZdBAmrivqL/byZE1ZIq9f
	92hPggbtimB177lbgPNPsa81I2rFDnmJ6MVuxBTvzyPYqkMIadSWXljUN1hjw=
X-Google-Smtp-Source: AGHT+IEzzpDco3Fuexy3Q4tv43B4lOQ5wSMPzAANo9hUSWLlGJg4zvkSgiYVEidfD8idIr/LR7Omg3H1+gknRpUpedM=
X-Received: by 2002:a05:6a20:d48c:b0:21f:4ecc:119d with SMTP id
 adf61e73a8af0-21faeeab2bfmr466444637.7.1749770869221; Thu, 12 Jun 2025
 16:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev>
 <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com> <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com>
In-Reply-To: <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 16:27:37 -0700
X-Gm-Features: AX0GCFuG1j7XqXwpxPfCGYZlUdp1A89WoDqKaHTopi4Uj0_x08EdUEorCPrcTvY
Message-ID: <CAEf4BzayBd9e5c9fiEPgDKPoRm-E4uB_u__xKcRpXDz18kNnkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 2:29=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> > >
> > > The bpf_d_path() function may fail. If it does,
> > > clear the user buf, like bpf_probe_read etc.
> > >
> >
> > But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
> > though. Especially given that path buffer can be pretty large (4KB).
> >
> > Is there an issue you are trying to address with this, or is it more
> > of a consistency clean up? Note, that more or less recently we made
> > this zero filling behavior an option with an extra flag
> > (BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
> > more akin to variable-sized string probing APIs rather than
> > fixed-sized bpf_probe_read* family.
>
> All old helpers had this BPF_F_PAD_ZEROS behavior
> (or rather should have had).
> So it makes sense to zero in this helper too for consistency.
> I don't share performance concerns. This is an error path.

It's just a bizarre behavior as it stands right now.

On error, you'll have a zeroed out buffer, OK, good so far.

On success, though, you'll have a buffer where first N bytes are
filled out with good path information, but then the last sizeof(buf) -
N bytes would be, effectively, garbage.

All in all, you can't use that buffer as a key for hashmap looking
(because of leftover non-zeroed bytes at the end), yet on error we
still zero out bytes for no apparently useful reason.

And then for the bpf_path_d_path(). What do we do about that one? It
doesn't have zeroing out either in the error path, nor in the success
path. So just more inconsistency all around.

