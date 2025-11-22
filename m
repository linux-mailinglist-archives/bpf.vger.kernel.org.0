Return-Path: <bpf+bounces-75270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C660C7BFFE
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85DC3A5844
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693B1DE887;
	Sat, 22 Nov 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZK+ZW7B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C89svZla"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECD21348
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770758; cv=none; b=rk5dBMGdS4xzv0fetj2cRzM4ExWQDF4kcFmcn7s2I/cvlIjYvTFsLBdkQhTuvkpT5JaVgFdMXZOHq8NYoKN2ojJaAM0jVhAsatz8MGJT/agBKQF7r95k6PONdb8OTpNVTs+ILrDE1SKDoMQAl1SXaDw5E+KQ9FwX3wO+6CXuURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770758; c=relaxed/simple;
	bh=MOW3WvhypnHpthN8MwuNRwcmQ4c66mbeLvnQ3XJCDFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgIfPS0AJ31NzUm2NfhtvID8/9mQb3fVa2wLr3eGWj3Iup63emWNKMkg1LdWATWogTG0feyWFXTAq1SuoGglR0ix5NA7XK6qWluBHRqrqTrzvXgBvCbk40pXFm6ZO7QrTx12fmg/+OJKv4rL8fhupbjMZB73JAVdXq4HAvojWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZK+ZW7B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C89svZla; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763770755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7rtpRj4BMKfOgQjvaUSy0Z7XyjSyu3zr3N4YzScRS4=;
	b=LZK+ZW7BMrIpazYZd34IHxpYweigX10Uy8fCkjwU/Zrwek4QNTlp+vSW4rzIrj5d33orsq
	8cngtpxRU05M8j35F02H8VzvdErBUetd9H5v94J+D+cHnCrlwx0NVgbGr97YsFLLwv0Umc
	UzH5bbl3PEXy/tQceyZIt7bnqYmhrHI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-tOFM7WRSPGC79gdviyvAAg-1; Fri, 21 Nov 2025 19:19:14 -0500
X-MC-Unique: tOFM7WRSPGC79gdviyvAAg-1
X-Mimecast-MFC-AGG-ID: tOFM7WRSPGC79gdviyvAAg_1763770754
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5dfb62a866eso5351202137.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763770754; x=1764375554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7rtpRj4BMKfOgQjvaUSy0Z7XyjSyu3zr3N4YzScRS4=;
        b=C89svZlaiqNhXDyzitOKjVP1wgpRFu6MRU9uIlifFb0xBjyeOGZWw6Cu4Apb16Og/m
         9Q5rFdbv/XW9VCDeBO2Mmyk8neiU+emilAvAvXA9OX44gLViWLqbpubp5Tbcirh+Ep6g
         auLMwJc/FzNlZIG2tpUBFSLuXSJmlSQbGN+8mwUthNERzms62Eiij0j25vsF3NqAfN4J
         3Y3H5nVWINfNMCvcy4DYGxYQw1aSP03I3rk1exhkrqe+frfK3VFRIML/WFrurwfEEpXB
         x2VU8IidQS+FvsqjlJNdugoPu7N0UPU0ExIT6CP0YLrnST8cd2AuTDHAJ1L87PmPWl6z
         EUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770754; x=1764375554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7rtpRj4BMKfOgQjvaUSy0Z7XyjSyu3zr3N4YzScRS4=;
        b=Or+sRpu4nGcJVwybInoHjgJGYBXh+Muht0jMtkg/+xtVW3ELcRSrs+Qk1w8/B0JrY4
         6bV2Hy9RNZszcN+ykD0Mg6FYAJGQwKrkvx5ZlbzdTx4MrvggskjPuVZH9w1phHlViM+N
         g4sZG1GoCDvBViZ7ncEqIP3oh2kFS2eU7nG+NsZZd/eOVOV1PmJ+qFB6MKokr/7hDzGW
         LixIMon5jX1RVh5f7N2wK0ldkLG7FVymFNsR0CSkH9zg7fojiMoHaqOoAEdVSlLw0l4f
         6xzVksSt3seCQ5cKpEVMME4l3YuZI2NzBdI/GnR+/VSmuDSpuFW1WKJCo8J6C54FYovc
         mftQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmh3/jNJa+Wbu5RfvSpGv4oP6tkt/bHTyF4gqn4FuNOwTObdU/6RarZCq5JvYbbhplLNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JKG28qR+AKBCWZqcvLJsGagyXLi4bGEVrWUizzszNRuOFO2G
	lbaHxJrvzouVFYczMqjVz0WrTUyErZvPnPk2OkJTLRQOTvan98mRI4V68wudEOHZxxktCHn2Jzk
	ML/JDb7IvvX/lrFQHi1u67O9DVS714SnV+ruF1Ii8Ndgdvkevj2ePDPyiBtIyucg4Tv3yOuouN/
	jGbqXhNfyxDgjtCGgK1u8EXy53qn10
X-Gm-Gg: ASbGncs6Y6mjAQyl/ZTSggt17aoAK/9ACYmPu7qIdjjdIZAdEwIVLY0tvoYSLj3P5c7
	qUnO/1a9QgNTBAP80enC+1wPn20lWRhhXI+EtRiIXLK1UfUmSh1GkjjAX/dQ1GrVyeOKxGlNF1d
	6on59/9xDKW4pfGHyf7SJrLwU5ukdJEtNhcfz0tzbKGzQbWI3BwLqfs7tRXL4iAxR8UBg=
X-Received: by 2002:a05:6102:c4f:b0:5df:b31d:d5ce with SMTP id ada2fe7eead31-5e1de3b25a1mr1630839137.28.1763770753985;
        Fri, 21 Nov 2025 16:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+aoefvB37BjKVPhW2cTzTDAMFr4WytQkAu7Yd9jNRzcZtCUB7eX19TtJlZip6Bkbr+HHyU6QSEvj0fzQAeC8=
X-Received: by 2002:a05:6102:c4f:b0:5df:b31d:d5ce with SMTP id
 ada2fe7eead31-5e1de3b25a1mr1630830137.28.1763770753685; Fri, 21 Nov 2025
 16:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763031077.git.asml.silence@gmail.com> <6143e4393c645c539fc34dc37eeb6d682ad073b9.1763031077.git.asml.silence@gmail.com>
 <aRcp5Gi41i-g64ov@fedora> <82fe6ace-2cfe-4351-b7b4-895e9c29cced@gmail.com>
 <aR5xxLu-3Ylrl2os@fedora> <1994a586-233a-44cd-813d-b95137c037f0@gmail.com>
In-Reply-To: <1994a586-233a-44cd-813d-b95137c037f0@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 22 Nov 2025 08:19:02 +0800
X-Gm-Features: AWmQ_blClujpDv7dQhjfukVwLN0dHGKoJkNNVry2owNYnkLRuqrvkIlWp2Y8FuA
Message-ID: <CAFj5m9KfmOvSQoj0rin+2gk34OqD-Bb0qqbXowyqwj16oFAseg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] selftests/io_uring: add bpf io_uring selftests
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 12:12=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 11/20/25 01:41, Ming Lei wrote:
> > On Wed, Nov 19, 2025 at 07:00:41PM +0000, Pavel Begunkov wrote:
> >> On 11/14/25 13:08, Ming Lei wrote:
> >>> On Thu, Nov 13, 2025 at 11:59:47AM +0000, Pavel Begunkov wrote:
> >> ...
> >>>> +  bpf_printk("queue nop request, data %lu\n", (unsigned long)reqs_t=
o_run);
> >>>> +  sqe =3D &sqes[sq_hdr->tail & (SQ_ENTRIES - 1)];
> >>>> +  sqe->user_data =3D reqs_to_run;
> >>>> +  sq_hdr->tail++;
> >>>
> >>> Looks this way turns io_uring_enter() into pthread-unsafe, does it ne=
ed to
> >>> be documented?
> >>
> >> Assuming you mean parallel io_uring_enter() calls modifying the SQ,
> >> it's not different from how it currently is. If you're sharing an
> >> io_uring, threads need to sync the use of SQ/CQ.
> >
> > Please see the example:
> >
> > thread_fn(struct io_uring *ring)
> > {
> >       while (true) {
> >               pthread_mutex_lock(sqe_mutex);
> >               sqe =3D io_uring_get_sqe(ring);
> >               io_uring_prep_op(sqe);
> >               pthread_mutex_unlock(sqe_mutex);
> >
> >               io_uring_enter(ring);
> >
> >               pthread_mutex_lock(cqe_mutex);
> >               io_uring_wait_cqe(ring, &cqe);
> >               io_uring_cqe_seen(ring, cqe);
> >               pthread_mutex_unlock(cqe_mutex);
> >       }
> > }
> >
> > `thread_fn` is supposed to work concurrently from >1 pthreads:
> >
> > 1) io_uring_enter() is claimed as pthread safe
> >
> > 2) because of userspace lock protection, there is single code path for
> > producing sqe for SQ at same time, and single code path for consuming s=
qe
> > from io_uring_enter().
> >
> > With bpf controlled io_uring patches, sqe can be produced from io_uring=
_enter(),
> > and cqe can be consumed in io_uring_enter() too, there will be race bet=
ween
> > bpf prog(producing sqe, or consuming cqe) and userspace lock-protected
> > code block.
>
> BPF is attached by the same process/user that creates io_uring. The
> guarantees are same as before, the user code (which includes BPF)
> should protect from concurrent mutations.
>
> In this example, just extend the first critical section to
> io_uring_enter(). Concurrent io_uring_enter() will be serialised
> by a mutex anyway. But let me note, that sharing rings is not
> a great pattern in either case.

If io_uring_enter() needs to be serialised, it becomes pthread-unsafe,
that is why I mentioned this should be documented, because it is one
very big difference introduced in bpf controlled ring.

Thanks,


