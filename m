Return-Path: <bpf+bounces-75853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE139C99B57
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 02:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EB73A43BE
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7A1D618E;
	Tue,  2 Dec 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaIZxlsG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39553F9D2
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637785; cv=none; b=cGBLqDyLUvuIYIN55Oc1XvlDQDogECoigGTHcO28viz6tr0P+78CS7DFdO4CqJFn6xMzoySF8WYnt2vyvEBxcX6F3rTKce3t6Apc+w7rNYOTjkCU9gcouwgsiYq1K7jHrqt5r6A6FaKbTSjnconIHfG6BACO2nsQh1MyvDKj3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637785; c=relaxed/simple;
	bh=fx8Slcay7ujvA9t2WKlgcE4Vi+TvaCX8okT/+Nw/SE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTHoLp1m1RFvAxHeAIRDib9Xtw/MzEvKi+tJ8+q0k2tyXg2yOnnKqq8FO9PutwzS75CnsEAL5GqPIdZqzGLQUBLZcwaHQckLRqKOFpgDCOyfjRYRZLenU38zo+lvRuL8+1Y4P8pIG2AHQMti+TIlTysDox+t3G1bepJ3E/2V6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaIZxlsG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso1142457f8f.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764637782; x=1765242582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szt2Mtf04VJJMA3huw3LwkNpjgtBKPYS4MiQjEEj3rs=;
        b=FaIZxlsGL+kZM9X6nwgABfGz2MVORILF0FQxKdzkmSG+0N1N1hperWj0NWJjRZ3tNc
         1nmutl7lYZCFT+DKMkW23Kk+QFJKT3aw8LuM8ZwCvfv9caFtIYoqA+KDkejoKI7vaskO
         XJweuKW4qCOX8Yc7xmg1wuWjKQ5dJTv5lHnsnOgzcADgTc5msgr/HMS91tEewl0QvkAO
         IxD/CdIHER2JS5t6Fbn4EK5twVs5FJsmqc5RDj4qq84aGcsBngM12KXN55aZklZwrYdu
         HmKtZy/Scb2VDQ+1lotJZlTW/RM49Qi6Oo6/S0R8+zKKsRhU2i1SaMA3yAovcK8rtHK7
         P/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764637782; x=1765242582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Szt2Mtf04VJJMA3huw3LwkNpjgtBKPYS4MiQjEEj3rs=;
        b=GG8Y97kHHlSTgSv1TapTWyMG07bgb0HoykvvP6WH/pmIxtWMUSFUDYJksjxqK8eBXc
         6Y1vMXYubbgc6nTv5TCNkkSPqWXvQRgUIM+uGe39c7W/u7u2hTq47zBRxfpOgYwIbM5+
         xeLM320Gi57Ps9+vLH3L8i8wC3K6MMmG/27B6C6wt/dQCiwWN1j9GaAxkqGyZp8rUxGK
         cAdCrUStAG+3NvwFUBQGXakt4Rx90W/hhbWhzCRSsVWQWyHDoivvJS+Vu/Mtrb7sHdYD
         Fdk1gsY/ViUJ0Dd6GVkZfq7/J9yQ+nj5xWiDIc8KgiQLWLu9MlDMPjRdqvDuY5z0Lh+M
         60Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUViA78pK2mRT48pri/PQVkCgUx7kByZptgPSqF+ZO8FDb1xY5Va8bQqdxYAfl9Zb+AQls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYXT47vsZPPAHQuZDqXWVohOjml/TxnX1f5S9HTBL2JYMuw9H/
	7GvTr5rMUUperglrf0/BrxtT6+6NZUiDaOvldyqVmL1TaCjDGzw/MACDjmbZKQdURZHPb0Oc6Uz
	nzj2noFFPprzUKHoY45G3kL177vzbTSs=
X-Gm-Gg: ASbGnctuu37zsi0FEOUlN+i9nUNSad0WpSIT3pktdVITm0Ci9S87BTK4R1e6xO+S6Xx
	CMk+FN0TUln4wR8p9i+R+8ol/Y/TxDA5rHZDrbWd5G06Fb1W6zoIwXeewH7aAxVzwM/8c+0O1Gm
	p59PivmGugmJX4D6OWEdF0EZlTUjo6uIt+YIuozJ9asjwDdWhw0msMpDxfH5rjOwt5Q1RVipDHx
	m8xdZT+Op9lyJ4So3N87QOoThg7hQGYBZZ4fMlIvmBC16xKo2tX3Z1ag53O9DH41H5ek378u4DU
	jdXN1O10lMkdzeARBsDOp0UwnrF5
X-Google-Smtp-Source: AGHT+IE4QVmBkAfuhCz9noFv4cBjzecOoS4F++oIbkbPwpzoHJ5MqtEUFeVwmn42unH0JLpt69vgN69hzdtzHdyfJ0M=
X-Received: by 2002:a05:6000:2dc5:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42cc1d35666mr41384040f8f.40.1764637782125; Mon, 01 Dec 2025
 17:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202001822.2769330-2-ameryhung@gmail.com> <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
In-Reply-To: <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Dec 2025 17:09:31 -0800
X-Gm-Features: AWmQ_bnkjn40mxBMuaQluzKzlmlBZEfXO_2GtsOKaYjenGQw8pmHxRcFUBpL_KM
Message-ID: <CAADnVQ+NHPc03DEFfB0Txaza8r+vWSM=jivKg=KApKzF+qvzcw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a
 tail call callee program
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:35=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools=
/testing/selftests/bpf/prog_tests/tailcalls.c
> > index 0ab36503c..e4a5287f1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>
> [ ... ]
>
> > @@ -1648,6 +1649,28 @@ static void test_tailcall_bpf2bpf_freplace(void)
> >       tc_bpf2bpf__destroy(tc_skel);
> >  }
> >
> > +/*
> > + * test_tail_call_cgrp_storage makes sure that callee programs cannot
> > + * use cgroup storage
> > + */
> > +static void test_tailcall_cgrp_storage(void)
> > +{
> > +     int err, prog_fd, prog_array_fd, key =3D 0;
> > +     struct tailcall_cgrp_storage *skel;
> > +
> > +     skel =3D tailcall_cgrp_storage__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open_and_load"))
> > +             return;
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.callee_prog);
> > +     prog_array_fd =3D bpf_map__fd(skel->maps.prog_array);
>                      ^^^^
>
> Should the return values of bpf_program__fd() and bpf_map__fd() be
> checked before use? Other tests in this file validate these return
> values (see test_tailcall_1 and similar tests which check for < 0).
>
> Without checking, if either function returns a negative error value,
> bpf_map_update_elem() could fail for the wrong reason (invalid FD),
> and ASSERT_ERR would still pass, potentially masking issues with the
> actual kernel restriction being tested.

Chris,

note... AI is wrong here.
We don't check FDs returned by these getters because skeleton open_and_load=
()
succeeded.

