Return-Path: <bpf+bounces-22785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0A869FD6
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9AD284D89
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99024149E0B;
	Tue, 27 Feb 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqHlh4sF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7450A68
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060595; cv=none; b=FN6ElfzInT4Esz8oZWJkm5mSxCds0fIUVv2h6z/VvpgUnP8zZtmkVWjqHfugc36BrwLYSAi361KhsivDidXxWH8vcfBIszSG7ZY0J7akYq/b4aKsSUhKN9k5Pp8K2sj/5aLI6ICMmRNYTJ6l32key8PxAwfzxDqTMBlift4w+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060595; c=relaxed/simple;
	bh=9nLhrXPMhg/lpHUesGNCTSpBc6WvsvSD3/Ew6JjfWno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8VP6zoaSpCX84DwYS1x3vvsZE8NByl+8Mje6GW5bS0RBKTsy4NYkJNNEbV38R3bFYhQD8fZOa6frOT00Ad39mbej+0SKlHUXZAJMqxf/CrLE2PnCJc/N4THKvXHlri4zn44DGgcCrxlO2eDUrKyfTFpbXgnBg8abQf3MwgbTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqHlh4sF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc744f54d0so21375ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709060593; x=1709665393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRRnLAvPnPJL+HqV6rL3Yv2zNLZuv51RwIxNYUJXEyo=;
        b=CqHlh4sF4sqxO6/CJ5naVIdHRRM7Q9iZWUmmVPbm43sC4DyVHXP/fNGOfhXHgNxtyS
         +aszEzGjmPMFDTNz1NdCdAkgmeLGyrl0jVblqHwzYyBEmbG8bpcZXEcm7+EhuCynsPrs
         8ttx2SDGnExpjMU2IYCjVzxvjekbhTgRjbeGqziXaLIHZ4eI0AysYFhhtFVBZShEHN2X
         HDhqyecnkH1758H+tlIqwnuIhblJFcn7PQusxTtitjq9KORYOwBjH4XyXOdbpaRZMuT9
         6zyV1aNssyZd8FnAABZYBjzZZ7gSFjn+KExoYPa9F6/Cp7zdY+waLYb6P3Z0EA4vzjKx
         0f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060593; x=1709665393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRRnLAvPnPJL+HqV6rL3Yv2zNLZuv51RwIxNYUJXEyo=;
        b=UlGSmP5UmjvrHlA244HBkU+n5tPnhj0hC2BQ3QysopaYFVewDgPRmHqxbowmyxK8g7
         HdmL6sQx3OjD0bJH9Vz08fh2lkiqyJBsfur9M70PCfNie63RjssBBhOoYigXhVfw6nRv
         cRQfufMnq8NTtFAf0sKfDhag+u5rja9VO/5hnRKeoKqrTK0oYeSoYIVlDMvB/uTss4cb
         mcKPFNVaH9fESxSxzErRICUHvVtWO4FyKbIBqfk4E4UuJV9fAwvIl/D7pMBVSxErZgwT
         I6fXaeWc12UHCpuYH2lPL5xnrOt2/HdEONEAVXimtboo7GhZoWE/o5I8XPkUwG5OPOr4
         7wjA==
X-Forwarded-Encrypted: i=1; AJvYcCVw4varTehuDjyFuhql3XOgx7YZmft2t6+tWMcpmFn8VHgsHRtIx9maD45bmnzBxacqinASlIjNgHIo8BaRM/FSTkEq
X-Gm-Message-State: AOJu0Yw0LTfSFqDYJUw1rDiHSgNr3als6fno75xo7FW23rKoo0+/MLcq
	HbLwLUmbUMseZTWoqKTenNVyrqAE9GLFMuuX/Yd0r7SpJJwPysm3qiafV3oTWAa4VW+sCaJEbi7
	qobTXlYxwR1BY5DxgE4BvT8K6svHaQb4/PRRI
X-Google-Smtp-Source: AGHT+IEiON4RseddIodoGaU6Nkgdyx9XK12cP+jVYnkT2Xl0+jJS3diTjDQKhKnwCZtjWLmf8ZGXp6rKwXJE33LiWmo=
X-Received: by 2002:a17:902:e1cc:b0:1db:7057:24df with SMTP id
 t12-20020a170902e1cc00b001db705724dfmr323406pla.14.1709060592780; Tue, 27 Feb
 2024 11:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com> <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
In-Reply-To: <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 11:02:57 -0800
Message-ID: <CAP-5=fVmrrkMdNwYPqYbK_M3AKQMqoXEi4whbzoUeoj-ROxzeA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 26, 2024 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Mon, Feb 26, 2024 at 11:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Move threads out of machine and move thread_rb_node into the C
> > > > file. This hides the implementation of threads from the rest of the
> > > > code allowing for it to be refactored.
> > > >
> > > > Locking discipline is tightened up in this change.
> > >
> > > Doesn't look like a simple code move.  Can we split the locking
> > > change from the move to make the reviewer's life a bit easier? :)
> >
> > Not sure I follow. Take threads_nr as an example.
> >
> > The old code is in machine.c, so:
> > -static size_t machine__threads_nr(const struct machine *machine)
> > -{
> > -       size_t nr =3D 0;
> > -
> > -       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > -               nr +=3D machine->threads[i].nr;
> > -
> > -       return nr;
> > -}
> >
> > The new code is in threads.c:
> > +size_t threads__nr(struct threads *threads)
> > +{
> > +       size_t nr =3D 0;
> > +
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               down_read(&table->lock);
> > +               nr +=3D table->nr;
> > +               up_read(&table->lock);
> > +       }
> > +       return nr;
> > +}
> >
> > So it is a copy paste from one file to the other. The only difference
> > is that the old code failed to take a lock when reading "nr" so the
> > locking is added. I wanted to make sure all the functions in threads.c
> > were properly correct wrt locking, semaphore creation and destruction,
> > etc.  We could have a broken threads.c and fix it in the next change,
> > but given that's a bug it could make bisection more difficult.
> > Ultimately I thought the locking changes were small enough to not
> > warrant being on their own compared to the advantages of having a sane
> > threads abstraction.
>
> I can see some other differences like machine__findnew_thread()
> which I think is due to the locking change.  Maybe we can fix the
> problem before moving the code and let the code move simple.

I'll see what I can split out in v2. I don't think findnew will change
and the nr change is trivial. In the previous code the lock is taken
before calling __machine__findnew_thread, which doesn't make sense
when we try to abstract inside of threads, where it should
take/release the lock in the threads and not the machine code. Moving
the lock to __machine__findnew_thread doesn't really make sense as the
__ implies the lock is already held.

Thanks,
Ian

> Thanks,
> Namhyung

