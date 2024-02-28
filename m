Return-Path: <bpf+bounces-22963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEC86BC4E
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93311C225B1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC37291F;
	Wed, 28 Feb 2024 23:44:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B013D2E3;
	Wed, 28 Feb 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163853; cv=none; b=iSgUdBDvEw95S6YZAtJ7jABDeg0AlzSB7+MPou40BCxclefAQwq1bqbQOE6cOVCyUFvEsXDVIbhTmMkEFynNbuGDiTxRx34zT8rguvHiwdSYcrzcERLCyuaXZ8GoDmldfcSr5Snx6dTy6FYUA12mEnSlyU5arLh7HgfAk/AnRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163853; c=relaxed/simple;
	bh=Bun5m8G8ZzV7ghqTD6WFlwdCGqvE8zICLBqsMSfoowQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgJKcaeJnCAO1DmFUyEyfiqnzzlq6qcYKtydeRO9jUlAlr7hN3dIMVQ+lsgKWgcTKP8DaUry3rIRcwkdx0cMif7dZoCP65HOp/AJfs7RIR/hlrFjJRoARe5ThkWt5+I9Vj8moNRPOuPZZ7v8jaOliYJZOcbI94le8gTtLO4Xulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso246030a12.0;
        Wed, 28 Feb 2024 15:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163851; x=1709768651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z2mKmaKj61Pf7pJc9lk5Bc9rbWv418rABeaEWh7OCw=;
        b=M1QHbuC8e4WYt/BV8w6YfPy1Fcdkmoeg1tiTIM8zMlTMsXDjt9OGDK896nWwS0ZFZU
         zSt3fM1k/e63thE2rARqhYZ7ePQhAXvUDUzeUMzv4wrCou5Z85RWsKsww5D6HbfN2W38
         ztjX2CRgf2dMc857XrrUmoONfQ2tkAs7KtASqaWP+LmTQflzHaYyWOqbt+L5/+cVLgb6
         pGN5kTPEraubkpN9/IeXdX81zayKldHjjxQ1UO+pmUtVKl3V5ConhJtM04ilIye0RFXU
         gMU5D5UptQvErnvEho6zdBCJfcFdNYj537ERr/yCmMT+iSWk1f15eOMAbNYuBVAs+pQE
         t1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXPf+RSiGcOoagnIMf/0EWHrc81ZcX3xUlVNtYgc0ZXJLWsRXGlxhoEGZzYHZt3BCJ0pPC9282yB+ZXEYmbX4rt5lTe2kPl8ipIqW6tkgTU8TNbL5kRDaTmf0BIm2DcEOclBW4aY6ukQCCVeY26C/yzAnGzOEBwkPgN35i59qWZM6YXEg==
X-Gm-Message-State: AOJu0YzmueW24zWK1LsIQ/33nn5opazAv5mMZfCokNk7d0zJPoLvsb5M
	VS4NQyNqJL+O0N/phAE9mLZqomkNxJtV16CY3crrXXv+Ip0y70aolpoMV6y2wHZkHq/Xn9c9XHF
	HSqVtWn1HgOgnlK3gqWTEGyqDT1U=
X-Google-Smtp-Source: AGHT+IGpXyr6rC4PgckoEC9vlZ9CvQ+9sOZHQ5msGedCpWHTuAGfHXRpjzvh8PLTjI5km7wdxKh2/j2tbDhvW4NDFNg=
X-Received: by 2002:a17:90b:4b4f:b0:29b:b70:5ace with SMTP id
 mi15-20020a17090b4b4f00b0029b0b705acemr248351pjb.16.1709163850993; Wed, 28
 Feb 2024 15:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
 <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
 <Zd41Nltnoen0cPYX@x1> <CAP-5=fWv25WgY82ZY3V1erUvCb+jdhLd_d91p4akjqFgynvAgg@mail.gmail.com>
 <CAM9d7cjJTf_yed9nwXZkBPr6u6NH5n+V+u0m6Zgsc1JBy_LdyA@mail.gmail.com> <CAP-5=fWKdp7rf+v7t_T_0tU0OxQO9R2g+ZH7Ag7HgyBbGT3-nQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWKdp7rf+v7t_T_0tU0OxQO9R2g+ZH7Ag7HgyBbGT3-nQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 28 Feb 2024 15:43:59 -0800
Message-ID: <CAM9d7cj-kxaQc18QG_cd6EzsDbk7vmhYqg-XzCV+g5oi9Giwww@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Feb 27, 2024 at 10:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Tue, Feb 27, 2024 at 1:42=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> > > > > I can see some other differences like machine__findnew_thread()
> > > > > which I think is due to the locking change.  Maybe we can fix the
> > > > > problem before moving the code and let the code move simple.
> > > >
> > > > I was going to suggest that, agreed.
> > > >
> > > > We may start doing a refactoring, then find a bug, at that point we
> > > > first fix the problem them go back to refactoring.
> > >
> > > Sure I do this all the time. Your typical complaint on the v+1 patch
> > > set is to move the bug fixes to the front of the changes. On the v+2
> > > patch set the bug fixes get applied but not the rest of the patch
> > > series, etc.
> > >
> > > Here we are refactoring code for an rb-tree implementation of threads
> > > and worrying about its correctness. There's no indication it's not
> > > correct, it is largely copy and paste, there is also good evidence in
> > > the locking disciple it is more correct. The next patch deletes that
> > > implementation, replacing it with a hash table. Were I not trying to
> > > break things apart I could squash those 2 patches together, but I've
> > > tried to do the right thing. Now we're trying to micro correct, break
> > > apart, etc. a state that gets deleted. A reviewer could equally
> > > criticise this being 2 changes rather than 1, and the cognitive load
> > > of having to look at code that gets deleted. At some point it is a
> > > judgement call, and I think this patch is actually the right size. I
> > > think what is missing here is some motivation in the commit message t=
o
> > > the findnew refactoring and so I'll add that.
> >
> > I'm not against your approach and actually appreciate your effort
> > to split rb-tree refactoring and hash table introduction.  What I'm
> > asking is just to separate out the code moving.  I think you can do
> > whatever you want in the current file.  Once you have the final code
> > you can move it to its own file exactly the same.  When I look at this
> > commit, say a few years later, I won't expect a commit that says
> > moving something to a new file has other changes.
>
> The problem is that the code in machine treats the threads lock as if
> it is a lock in machine. So there is __machine__findnew_thread which
> implies the thread lock is held. This change is making threads its own
> separate concept/collection and the lock belongs with that collection.
> Most of the implementation of threads__findnew matches
> __machine__findnew_thread, so we may be able to engineer a smaller
> line diff by moving "__machine__findnew_thread" code into threads.c,
> then renaming it to build the collection, etc. We could also build the
> threads collection inside of machine and then in a separate change
> move it to threads.[ch].  In the commit history this seems muddier
> than just splitting out threads as a collection. Also, some of the API
> design choices are motivated more by the hash table implementation of
> the next patch than trying to have a good rbtree abstracted collection
> of threads. Essentially it'd be engineering a collection of threads
> but only with a view to delete it in the next patch. I don't think it
> would be for the best and the commit history for deleted code is
> unlikely to be looked upon.

I think the conversation is repeating. :)  Why not do this?

1. refactor threads code in machine.c and fix the locking
2. move threads code to its own file
3. use hash table in threads

Thanks,
Namhyung

