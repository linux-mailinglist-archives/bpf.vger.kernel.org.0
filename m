Return-Path: <bpf+bounces-31877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447590444A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12529289095
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91C7F486;
	Tue, 11 Jun 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXgab5on"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A074386
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133292; cv=none; b=Z1c4wPO6cwyGs0JLJcmwsjYSTQC5lasPh5o2WAlNJ0+EUEItlrAYIUazJ1Hr+8iFNrssz58wrxVoXIltEWunU7iLj0iR1sS9Ftb//9n+y9Y43X0jP+L0bYdSfUrxkq0DzzN5f6AEVPA4xL5kE/SXH2eNAQopY1nfhL6cjoOel38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133292; c=relaxed/simple;
	bh=KT31bgb0v7xBS6c94xss59CBmRE8r4q5CV+cAw5d1ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeLuF5/UXaHbxXQTAxuVwVl/+y3zXkX7gGYkT0A4GjIWBEAyyt1rqxe12rUlHoSMFydVquWlw+TY8rvMOl7vuu1EeulZORy+ZUzsY79a4TfLFaNBgns4QxbN3lr8EIGMYnwQcPhsG/+IQE05XHhAHilvcnDgXx28hvKOAHLsAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXgab5on; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f1da33826so202552666b.0
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718133289; x=1718738089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo7EddzmKB1vd9veJ7RQB83qJCbVq7PGYCB9bnd/o6Q=;
        b=BXgab5onjW7d/fTv5vbH53+3K/kyGTxs+vfpmd2N8SghrrvI4TS+UF90jNM26rnBLI
         5sCBmf2Bsfis5jtRiTNib12T8dopAxW5B9RZqrSuGjw2EBWTs+a4dGwyegTxrbUTioq2
         eR+FUjsif5B4asg/woSEAd7eDmhZLoQPTyt77HyDWSauowNkNDxSWK/WvtF6sZdpLohb
         gkPojjHBUkSGWt14n7ZlRFMUsOMFCkJ4y0O5cnQG6F6PTcQN5xK5tGvCyRps1Q61lCbh
         hMmrpO5W0C65+xqUU/FDaCPvs1OuykayWRYkt5tQIb7+G535i+qqevmCNxRPOWmlzd65
         H2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718133289; x=1718738089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mo7EddzmKB1vd9veJ7RQB83qJCbVq7PGYCB9bnd/o6Q=;
        b=YtlUnRaKrJ/9Nh6YoFam2r1AC9ldhw0+y0ui/x2ac9w9Q75vgRfW6FszpePeKwH5eV
         1zOGEWJu79zGoFrGP/DUN+621V/ATeATmWohvSD1LKDFOlCLE25AZ+HKGa0UQISIItTq
         7OpFOn0CKKo9gIEkpQq/Gz9oLIT3uiNk1v9s7LxHCu00xwoAxQHUt2iKuT9M0nDU/Kr7
         TXM4aspKrQDtiWHwS7qV0a/IWtJXu/EgneGT0fgPqOqnvYrBY38J4aQ6GI4LNeLKpuDD
         mUZ4YjcothZZNoZxE935sWQX05YYmHLrssRiKVgaAjWq2Qv1AphT5RAbt3YLIWgz0ar5
         lGlA==
X-Gm-Message-State: AOJu0YzSKlFUEhCI4YcM/YRWnan9PdD6yFN08QtoifG/a5MWmtG2Xer3
	Tgk9HCh5L2Ze4h8KUXJ8yF90WcQxGW+puNk3gbxblesPPRihixbJKudZo7AbsE69kF0bVoRMwaP
	DDGcEfveWKukQVw7Z8ozm9JieIbw=
X-Google-Smtp-Source: AGHT+IHWaeq/XCPHl4MhGj1XBB3MPeuqR6hMm4eqh2g85ffYs+ER22fUO9SB40UPo4g6aCaPjPzn7fyK5CvSJig+Qc0=
X-Received: by 2002:a17:906:1653:b0:a6f:1445:9de8 with SMTP id
 a640c23a62f3a-a6f1445f005mr665845366b.54.1718133288553; Tue, 11 Jun 2024
 12:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608092912.11615-1-dev@der-flo.net>
In-Reply-To: <20240608092912.11615-1-dev@der-flo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jun 2024 12:14:36 -0700
Message-ID: <CAADnVQ+8KtnmH_pbtPg0qujVxkceddoowqiD0VV6MekmmvdKUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Return EINVAL instead of NULL for
 map_lookup_elem of queue
To: Florian Lehner <dev@der-flo.net>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:29=E2=80=AFAM Florian Lehner <dev@der-flo.net> wro=
te:
>
> Programs should use map_peek_elem over map_lookup_elem for queues. NULL i=
s
> also not a valid queue return nor a proper error, that could be handled.
>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  kernel/bpf/queue_stack_maps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
> index d869f51ea93a..85bead55024d 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -234,7 +234,8 @@ static long queue_stack_map_push_elem(struct bpf_map =
*map, void *value,
>  /* Called from syscall or from eBPF program */
>  static void *queue_stack_map_lookup_elem(struct bpf_map *map, void *key)
>  {
> -       return NULL;
> +       /* The eBPF program should use map_peek_elem instead */
> +       return ERR_PTR(-EINVAL);

The commit log, the code change and comment are highly misleading.
bpf prog cannot call this function due to the verifier restrictions.
bpf syscall cannot reach this code path either.
This is effectively a dead code.
But if there is a verifier bug or obscure sequence of events
and bpf prog manages to call this function then it must return NULL.
ERR_PTR(-EINVAL) will look like a valid addr to a prog and it will crash.

pw-bot: cr

