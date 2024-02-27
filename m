Return-Path: <bpf+bounces-22780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54C869DC0
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD871F22D17
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2A14DFE7;
	Tue, 27 Feb 2024 17:31:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118104EB4C;
	Tue, 27 Feb 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055107; cv=none; b=Qn2w9MGQle+21Om1xg1f+PSLtsRBHsqo4Gip9j2e9dVFI8Uzfw7ge5bok6GflxabmE69jsYjGZITmH0gcAmFTEeZvidfdBYy3wbEWPDmhnoKL/PGbhXl6OQA5Mb4uZNaPfCPf+SFCaaHZDzQECAyY29NOsV8U6q0hkUb024Ewck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055107; c=relaxed/simple;
	bh=N4qrca1gfNLM7XkrrAkeiIRez2lQIublb/jwq59mkcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Acr3wva4AHXSlP2JA056regS4qTt4G6DESGAnQiAzMXdEj4ljeiMq0EcggvDuPF7mrzqXkKKHRMM6fVwx7b9k38UUILRoDKlX35R65P7+xpChwsrLIxGnFY6BtYTmpfW8SPRJzgbLYSZ40B8S/pXNj1085kH341HTCau3mksgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc9222b337so26716125ad.2;
        Tue, 27 Feb 2024 09:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709055105; x=1709659905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPTm1iNR6NeamAnZRn8ji0Wn/OzjaL8ol//B5bTYhxE=;
        b=H8YXRpSsMSARCT8EkE56YPxIO3BhN/vkBea6Tu8GTn9XtmJfJzHlsll3TlKlMTtCxO
         LSoMqv9qW5T6ixbu3ByoJMsDUUFQNWg17SVhAaufmPPBkaUxb4cSA3WVYWrBol97WL3p
         YX1O37rNWR50lEZWwByz5h2LMDkPbtmRfg0d+V1j5QD727JeEtV0N7Vb/wiW6zoKuiSF
         wRKOYAH4IwYn3fhy7Ta9P26BLpz0fU/RriAWATIX6MbSyyWY7HtKq71FtXi2QzXsBnGS
         t2DQx4MsJR3Vj9AwFdhy77zGdbeS05b/0M5+kMGU2HIINMQSknYyHyqQGy3nBG+91oZj
         9L1A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ch6HqYEF2YCfKD11RDaGTrmzDKR3922h09noKaxuHWKBeyVxYaPl/8PoWvj8MtHEG9Swb7HHPt9NwFzlxn3uNS5Ypb1VWzo4fCqP4E38F9OBZcc4+IHmL4IvhRcbpy6GcfuoS7pg1eaFKWsreaEiZ+t0K4uF6j6Eo7Yoqbg56v7B7Q==
X-Gm-Message-State: AOJu0YyXsCElPHyA/Soif6SLA0iYrdJiPj6VFBOh6voBQfZT5nqWFFnp
	+YYfxoSiltFclfVWJAQMGnK5xq8EZuvuytR9/DjxRzoIJKnPT5KmRO9JyUJxtWdyooLmCxkrppf
	Ek+fepnWHML72/AQkTkK6yB9Qc0M=
X-Google-Smtp-Source: AGHT+IEYnA++zMUlSPGbKP161F1yBAC/gQGUg58ZRFIL5eD1XfGpeOtD1G827LxcOTVtzAYilTC/PZifSULEVoZx0LM=
X-Received: by 2002:a17:902:6e16:b0:1dc:82bc:c073 with SMTP id
 u22-20020a1709026e1600b001dc82bcc073mr8293776plk.41.1709055105322; Tue, 27
 Feb 2024 09:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com> <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
In-Reply-To: <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 09:31:33 -0800
Message-ID: <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Feb 26, 2024 at 11:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Move threads out of machine and move thread_rb_node into the C
> > > file. This hides the implementation of threads from the rest of the
> > > code allowing for it to be refactored.
> > >
> > > Locking discipline is tightened up in this change.
> >
> > Doesn't look like a simple code move.  Can we split the locking
> > change from the move to make the reviewer's life a bit easier? :)
>
> Not sure I follow. Take threads_nr as an example.
>
> The old code is in machine.c, so:
> -static size_t machine__threads_nr(const struct machine *machine)
> -{
> -       size_t nr =3D 0;
> -
> -       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
> -               nr +=3D machine->threads[i].nr;
> -
> -       return nr;
> -}
>
> The new code is in threads.c:
> +size_t threads__nr(struct threads *threads)
> +{
> +       size_t nr =3D 0;
> +
> +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> +               struct threads_table_entry *table =3D &threads->table[i];
> +
> +               down_read(&table->lock);
> +               nr +=3D table->nr;
> +               up_read(&table->lock);
> +       }
> +       return nr;
> +}
>
> So it is a copy paste from one file to the other. The only difference
> is that the old code failed to take a lock when reading "nr" so the
> locking is added. I wanted to make sure all the functions in threads.c
> were properly correct wrt locking, semaphore creation and destruction,
> etc.  We could have a broken threads.c and fix it in the next change,
> but given that's a bug it could make bisection more difficult.
> Ultimately I thought the locking changes were small enough to not
> warrant being on their own compared to the advantages of having a sane
> threads abstraction.

I can see some other differences like machine__findnew_thread()
which I think is due to the locking change.  Maybe we can fix the
problem before moving the code and let the code move simple.

Thanks,
Namhyung

