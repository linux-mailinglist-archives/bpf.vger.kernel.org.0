Return-Path: <bpf+bounces-18324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9319818F77
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F3B24ABE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210D38DFC;
	Tue, 19 Dec 2023 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y8xOiDBc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072254B159
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b72192f7a1so134395439f.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703009410; x=1703614210; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMm17hdBABlvAAX+Jp30S5DFYwbSvzQKlSkr+nKcGZk=;
        b=Y8xOiDBcVTcDaZkfPUd5mjBXhwpfvtLjlCytWhEioqB/ZENL69qgNfwBxTTUk00QiR
         5VVguZfjTwpccHLX8E9ypUyFBeAjoqPqiCupAm+eh54U2/ncxoOwrF5O4p+XdiV3Wfuu
         w/6JqQP+1Vpd+HKuvEOTKx/BkIm0lbNuchXMFvDKKzTw/rcZQmCo1LBNYMHUGp7OzaVM
         6yHrpqBdpzV/WyggxOPGgn1KQoSV8AuYGqOdubi8iJmtztJWfHDeZxcwpUe9KDbQ9aC8
         OHrz5on2WpfFNg8OIgEhGFdQHZCBG65aAFim0ZDTQf/13Kl8Dpwn8j/uDGWquNBvA9Lz
         NWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009410; x=1703614210;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMm17hdBABlvAAX+Jp30S5DFYwbSvzQKlSkr+nKcGZk=;
        b=xVKHAblWN0vfmkSqkU0O/Po2B8eUvh14U0Q+JsInLlJP6+hPLV1Hu5+ArVu3ccqwfp
         r+N/Puvj0z4TltCdJdsmGh+zd79khgVgYiY5PH0SrgH0peUU7NvtnPrg73Fn5uX78Y85
         BMQtZc0hOzO5eXvq6HhcyskKINSjJkfmLp6X3qTGgbPIoG0QLJoV3WZ8hVUK1u1Du20i
         3unfblwnaGB1N+qd5fObvUhBnf2g8JnrTjK5CzXcX71ejSIfAXtxuqXKARh6N69Z7dSK
         invG7YSeQMrinl2/jACtLOzsJd+ECx+TU5F/UTXU3LeGi25CIJlxGoNyRgSfKBRWsp41
         jWYA==
X-Gm-Message-State: AOJu0YyBAvpvltUoqrLqEZbXIItNPWvpwub2lgFlTgszVmZSRUPg3yMQ
	YVbYg7Rjwd2WuZDNtOs5mwQ=
X-Google-Smtp-Source: AGHT+IEhQqJUfiNDfm9kkCk4z2PTctMDc+zGKUmjHSgfspNLWEtaSnc0LKSN7fA9oImITrwb0j5S2Q==
X-Received: by 2002:a5e:df06:0:b0:7b4:37db:9fe1 with SMTP id f6-20020a5edf06000000b007b437db9fe1mr1406301ioq.10.1703009409844;
        Tue, 19 Dec 2023 10:10:09 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id f9-20020a05660215c900b007b34b18c31esm6671939iow.50.2023.12.19.10.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2023 10:10:09 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'Christoph Hellwig'" <hch@infradead.org>
Cc: "'David Vernet'" <void@manifault.com>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Jakub Kicinski'" <kuba@kernel.org>
References: <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com> <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com> <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com> <20231212233555.GA53579@maniforge> <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com> <20231213185603.GA1968@maniforge> <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com> <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org> <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
In-Reply-To: <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
Subject: RE: [Bpf] BPF ISA conformance groups
Date: Tue, 19 Dec 2023 10:10:07 -0800
Message-ID: <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKoHfZj5uHVGAGiwHvRzOg12FLYygKw8KxkAzczMysBTloCHQIk6QWGAWJPEj4BybpNsgH6K/FdAa4N7FEApYq+pQJboihlAe8iqfCubA4ykA==
Content-Language: en-us

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Monday, December 18, 2023 5:15 PM
> To: Christoph Hellwig <hch@infradead.org>
> Cc: David Vernet <void@manifault.com>; Dave Thaler
> <dthaler1968@googlemail.com>; bpf@ietf.org; bpf <bpf@vger.kernel.org>;
> Jakub Kicinski <kuba@kernel.org>
> Subject: Re: [Bpf] BPF ISA conformance groups
>=20
> On Thu, Dec 14, 2023 at 9:29=E2=80=AFPM Christoph Hellwig =
<hch@infradead.org>
> wrote:
> >
> > We need the concept in the spec just to allow future extensability.
>=20
> Completely agree that the concept of the groups is necessary.
>=20
> I'm arguing that what was proposed:
> 1. "basic": all instructions not covered by another group below.
> 2. "atomic": all Atomic operations.
> 3. "divide": all division and modulo operations.
> 4. "legacy": all legacy packet access instructions (deprecated).
> 5. "map": 64-bit immediate instructions that deal with map fds or map
> indices.
> 6. "code": 64-bit immediate instruction that has a "code pointer" =
type.
> 7. "func": program-local functions.
>=20
> logically makes sense, but might not work for HW (based on the history =
of nfp
> offload).
> imo "basic" and "legacy" won't work either.
> So it's a lesser evil.
>=20
> Anyway, let's look at:
>=20
>    | BPF_CALL | 0x8   | 0x0 | call helper         | see Helper        =
|
>    |          |       |     | function by address | functions         =
|
>    |          |       |     |                     | (Section 3.3.1)   =
|
>    =
+----------+-------+-----+---------------------+-------------------+
>    | BPF_CALL | 0x8   | 0x1 | call PC +=3D imm      | see =
Program-local |
>    |          |       |     |                     | functions         =
|
>    |          |       |     |                     | (Section 3.3.2)   =
|
>    =
+----------+-------+-----+---------------------+-------------------+
>    | BPF_CALL | 0x8   | 0x2 | call helper         | see Helper        =
|
>    |          |       |     | function by BTF ID  | functions         =
|
>    |          |       |     |                     | (Section 3.3.
>=20
> Having separate category 7 for single insn BPF_CALL 0x8 0x1 while =
keeping 0x8
> 0x0 and 0x8 0x2 in "basic" seems just as logical as having atomic_add =
insn in
> "basic" instead of "atomic".

If a platform exposes no helper functions, then 0x8 0x0 and 0x8 0x2 have =
no
meaning and in my view don't need a separate conformance group since a
program using them would fail the verifier anyway.

0x8 0x1 on the other hand wouldn't be invalid just due to the imm value,
and so tools (compiler, verifier, whatever) need some other way to know =
whether
it's supported, hence the conformance group.

> Then we have several kinds of ld_imm64. Sounds like the idea is to =
split 0x18
> 0x4 into "code" and the rest into "map" group?
> Is it logical or not?

I don't know of another easy way for a tool like a compiler (LLVM, gcc, =
rust compiler,
etc.) to know whether map instructions are legal or not. =20

That said, I think map_val() is problematic for a cross-platform =
compiler...
https://elixir.bootlin.com/linux/latest/source/Documentation/bpf/linux-no=
tes.rst says
"Linux only supports the 'map_val(map)' operation on array maps with a =
single element."
Now if one platform supports it on one type of map and another platform =
doesn't, then
the compiler has to magically know whether to allow this optimization =
(compared to
requiring using a helper function to access the map value) or not.

> Maybe we should do risc-v like group instead?
> Just these 4:
> - Base Integer Instruction Set, 32-bit
> - Base Integer Instruction Set, 64-bit

If there's platforms that would support one of the above and not the =
other
(are there?) then I agree splitting them would make sense.

> - Integer Multiplication and Division
> - Atomic Instructions
>=20
> And that's it. The rest of risc-v groups have no equivalent in bpf =
isa.

Dave


