Return-Path: <bpf+bounces-14130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B997E0AC9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FF21C210B9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3123778;
	Fri,  3 Nov 2023 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYKNYTK/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF021351
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:44:39 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7661AA
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:44:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso379359766b.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699047876; x=1699652676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqK12YU4Nr+HTQaOhLJa+IxuDVDjWTngKpDoglxohiY=;
        b=hYKNYTK/ktVbvzHbcIZ/FqBLmtp5yghqCgvWqhJ/XHZ7KiVhMyVSF66/i1Zrc/iBGr
         93Pei1TI226ssKCm9q79RC4UGN6ZwJNgQ5IFhTvFiUfpJaeomEd25j/iuBJU0tlNpOdl
         ci24Pti760AnoAM+yGZlc/cqJvOIyNPFuug9U4FkLH7MojrjwvePeJ9gp7WDHmjQd+YA
         vV6icyULmeBhDmuj3JLyUoNlrKe/F19tnzpF0cRfNsh7eD9ut7i7ffT11MH5Uw3Z5puj
         CInQqk4NHhYEUIZZG4y2fAzkH6+EhwJTZzsC8rY8SUOM4kli7KrYLl/y5K/HJ1maMQ6c
         kQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047876; x=1699652676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqK12YU4Nr+HTQaOhLJa+IxuDVDjWTngKpDoglxohiY=;
        b=X0jwuC6cuqjmqJFgWAOa4AvzSNitIrPrI29tKVcn/tlVekCEYsiI4u02qCPawIaTqa
         xFBRVjisjL40SRVdutyrKd9nSlA7mpVt2z71iqpR1rMwk0yF8Xn20wsurJxFWqzQRF2L
         +SS/lOkd7XHoq20hwOEvgw7X4a6DJydtyc48A7stxi8ArskzZg2Ylp6RxHvl3RqFa+cn
         MrZuyCyTVrLavyJJUY2163ZT1f3Wbuyw0SDUMlAMCHbXQS+mGbMZ4I4WDvsf5IxX9e8b
         9TkOYmvIcf/VvPR/8sxymvDTdxaTWwP2zDMjdwr4gGHiJLJvCc/CWOjIWrDnGuKlP8U7
         ooXQ==
X-Gm-Message-State: AOJu0YzHrEcZLfYNgWyU4d7Pbsfj+Jnpg2FyClN84+S8kB/IZvBw6VAg
	F5JiHZb3NzCTwvQQ6Pqpq4Ouv5DiksmekbMSxt/kESoG
X-Google-Smtp-Source: AGHT+IEkKVhtdl0Wh5QdGOYDNWuwL74vmeazzuw4QoTh4EQqpaL0sA4ewb7fUF5+23/bcxXMNha+2eaD4SZ0wBh4xGE=
X-Received: by 2002:a17:906:3b94:b0:9c3:cd12:1929 with SMTP id
 u20-20020a1709063b9400b009c3cd121929mr6554571ejf.60.1699045942278; Fri, 03
 Nov 2023 14:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-8-andrii@kernel.org>
 <CAADnVQLXVXfY-pJj0_xSdoOEPnPtQgxzxzEDxFjLki=n80zZAg@mail.gmail.com>
In-Reply-To: <CAADnVQLXVXfY-pJj0_xSdoOEPnPtQgxzxzEDxFjLki=n80zZAg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 14:12:11 -0700
Message-ID: <CAEf4BzbtbiPFaGyjmBTzfq_nZXCkF7k4UY5MD1AOCsKnxAuWoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/13] selftests/bpf: BPF register range bounds tester
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 12:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 5:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > +enum num_t { U64, U32, S64, S32 };
> > +#define MIN_T U64
> > +#define MAX_T S32
>
> I haven't finished the review of the whole patch yet.
> Quick thoughts so far.
> Can you change above to:
> enum num_t { U64, first_t =3D U64, U32, S64, S32, last_t =3D S32 };
>
> 1. min/max names kept confusing me while reading the diff.
>    I read MIN_T is a smaller (minimal) type which is 32-bit.
> 2. reusing enums without LOUD macro names is easier to read.
>
> and similar with _OP macros.

sure, will change

