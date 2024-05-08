Return-Path: <bpf+bounces-29098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8168C01DE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F91F24B19
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD812A16C;
	Wed,  8 May 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOVKw7jA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA5128396
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185307; cv=none; b=I0aEwY3Av2Lq5rAic86irtijTTmUQSorSsFSO/eAqTbwBJrRvBuOUhwIi5hWidtt7kD3TuyMjF6FeL2FwMz7WaShjDI8D+I5yf7RDUKKoNBrUI36JHGT/6QfhqFLWL/IyihfCYZ9Qt/HB/t8S8TBgC/xDjEJKzg/pOYkNOv9UVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185307; c=relaxed/simple;
	bh=yt0anHz/CODggydkD/BxGCpJa7v1oYjJtYfcTnDC4d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb+F3CZgXhJc7b+GrOGk32BCdOeFcjovg7Ykeqecv/pB4a+b5e4soB5rsoF3CkqtNZAK+S/TtOgA6Se2Lb2UiKifwwMUGYKFpywwDsW4dYW2r8Jv/G4qmFws2mXBfGh2kYX07SoOeJDRH9CV/ghCDTDOnW12aTKGqTddmVDQ8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOVKw7jA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so3261633a91.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715185305; x=1715790105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RTXXYfzDpDEr7PYoeOfzl228MOXeCt2wHAtc1XnX44=;
        b=GOVKw7jAxPuFR4f88Yi0ZQ60PkKxBhwvrRyXfDbS9BvwJpzms0d6tOKIUTfVcD4N7e
         TqvRvTpncIe1NiuuERkEhNS8SCiJFXOHyvGMHn1d/1DuxQNjct6CaECdGhlGuyuxO2yz
         A3IU2Lgm+EfRCtgTA5zvjo0Q3gkX8ggvihFd/xH6IUGE+nFEWmBGCnt6Z0sY9+EELZbV
         y944Pax0kcb85EGCGmHh09j9asTD96rPyaS4oN8TBD78MtMY8nPy/lkvEEcZOC6myta+
         I6sCg0kXW/8wzTM41krApbj6MhV1BZHvDbe1nR/BIR9bdacCSdU8yh17ukSw8Ti+bM9R
         LLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185305; x=1715790105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RTXXYfzDpDEr7PYoeOfzl228MOXeCt2wHAtc1XnX44=;
        b=OL+zstJTkqBYmvyP/JKCCbjoQwJb/zKpLfQxUwaNwSxZJZY6r/snWxcpG0s9XvLxDr
         IDm50oMCG8SiBWwwp9eiLunKV8gC/ni8VpODgpHfvzoQoKzcRt4yNrGBgJJKaUpgqUj/
         geFbXsJHeo9oRFQVRsD25VZXIDHOO39uVsFp2HcrAN6FSj4NvtJwXZs1j/Xt2GpgSWC4
         St8JZSugPeyfDYZpMb8mLYvdIlaekF7DwUHDrDFeTwAFVjDw/e6SyuJeG2K0dIv5DtvK
         71M6ik6a1iRwzmnjR9+FKRAxnVD12AYZ59KcoW2EtSzcgQUBbT/3MwGKItVcAqFKcv9V
         jdBw==
X-Forwarded-Encrypted: i=1; AJvYcCWiaMflwMXoxZ0ZtajVEoNbxmEwAK4wiR/3lAqUzadxM3foCPRvO1hGHg9IqiOftfkrwt9+VZrvI6DadcQDGuSwV7Ul
X-Gm-Message-State: AOJu0YwGUXSyxg7Vtzs9JFzZQXBLBOuS4ExFZzgpE91ak8tgT7t/dAu0
	Tj0fZc12fzbDQddMuTt9IDI2dI4Nv9/NeyQnEos8iuYoPUb/T41bd3C/lDF309LfaDGIuhV8n3D
	j2jVVVoIF8zJfUxNywwPA9dfRXl0=
X-Google-Smtp-Source: AGHT+IGG1+qodsgbOSarSg1IiyanwxrTyaVtn2nuGhYhrR0gE1Se/BIvFnG+4V7ZtJ5XpMzP/qM+YfQIGYDjIpPKTdE=
X-Received: by 2002:a17:90a:d182:b0:2a7:7cae:8ec9 with SMTP id
 98e67ed59e1d1-2b61649d9d6mr2975877a91.7.1715185305088; Wed, 08 May 2024
 09:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506134458.727621-1-yatsenko@meta.com> <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
 <e20be6d3-b9c7-4a64-add1-f4c7a6d3a4bc@kernel.org>
In-Reply-To: <e20be6d3-b9c7-4a64-add1-f4c7a6d3a4bc@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 May 2024 09:21:33 -0700
Message-ID: <CAEf4BzYzbCTV8cr-mCpVy5dco+1j1oig7SVPEmBjvKJEyb5JFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 4:30=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> On 07/05/2024 22:02, Andrii Nakryiko wrote:
> > On Mon, May 6, 2024 at 6:45=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
> >> diffing and forcing more natural definitions ordering.
> >>
> >> Use `normalized` argument in bpftool CLI after `format c` for example:
> >> ```
> >> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
> >> ```
> >>
> >> Definitions are sorted by their BTF kind ranks, lexicographically and
> >> typedefs are forced to go right after their base type.
> >>
> >> Type ranks
> >>
> >> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> >> next order:
> >> 1. Anonymous enums
> >> 2. Anonymous enums64
> >> 3. Named enums
> >> 4. Named enums64
> >> 5. Trivial types typedefs (ints, then floats)
> >> 6. Structs
> >> 7. Unions
> >> 8. Function prototypes
> >> 9. Forward declarations
> >>
> >> Lexicographical ordering
> >>
> >> Definitions within the same BTF kind are ordered by their names.
> >> Anonymous enums are ordered by their first element.
> >>
> >> Forcing typedefs to go right after their base type
> >>
> >> To make sure that typedefs are emitted right after their base type,
> >> we build a list of type's typedefs (struct typedef_ref) and after
> >> emitting type, its typedefs are emitted as well (lexicographically)
> >>
> >> There is a small flaw in this implementation:
> >> Type dependencies are resolved by bpf lib, so when type is dumped
> >> because it is a dependency, its typedefs are not output right after it=
,
> >> as bpflib does not have the list of typedefs for a given type.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 259 insertions(+), 5 deletions(-)
> >>
> >
> > I applied this locally to experiment. Generated vmlinux.h for the
> > production (a bit older) kernel and then for latest bpf-next/master
> > kernel. And then tried diff between normalized vmlinux.h dumps and
> > non-normalized.
> >
> > It took a bit for the diff tool to generate, but I think diff for
> > normalized vmlinux.h is actually very usable. You can see an example
> > at [1]. It shows whole new types being added in front of existing
> > ones. And for existing ones it shows only parts that actually changed.
> > It's quite nice. And note that I used a relatively stale production
> > kernel vs latest upstream bpf-next, *AND* with different (bigger)
> > Kconfig. So for more incremental changes in kernel config/version the
> > diff should be much slower.
> >
> > I think this idea of normalizing vmlinux.h works and is useful.
> >
> > Eduard, Quentin, please take a look when you get a chance.
> >
> > My high-level feedback. I like the idea and it seems to work well in
> > practice. I do think, though, that the current implementation is a bit
> > over-engineered. I'd drop all the complexity with TYPEDEF and try to
> > get almost the same behavior with a slightly different ranking
> > strategy.
> >
> > Tracking which types are emitted seems unnecessary btf_dumper is doing
> > that already internally. So I think overall flow could be basically
> > three steps:
> >
> >   - precalculate/cache "sort names" and ranks;
> >   - sort based on those two, construct 0-based list of types to emit
> >   - just go linearly over that sorted list, call btf_dump__dump_type()
> > on each one with original type ID; if the type was already emitted or
> > is not the type that's emitted as an independent type (e.g.,
> > FUNC_PROTO), btf_dump__dump_type() should do the right thing (do
> > nothing).
> >
> > Any flaws in the above proposal?
> >
> >   [1] https://gist.github.com/anakryiko/cca678c8f77833d9eb99ffc102612e2=
8
>
> Hi, thanks for the patch - and thanks Andrii for the Cc. I didn't have
> time to look at the code yet (will do), but the idea looks great.
>
> My main question would be, how much overhead does the sorting add to the
> BTF dump, and if this overhead is low, is it even worth having a

I actually measured. I didn't save numbers, but it was something like
50% slower in current implementation (and with simplifications I
proposed it should be faster still, probably), so not a lot slower.
It's not noticeable in practice.

So yes, we can probably make this a default. I'd probably still leave
an option to dump using "natural" BTF order, just in case.


> dedicated command-line keyword to trigger the sorting, or should we just
> make it the default behaviour for the C-formatted dump? (Or is there any
> advantage in dumping with the current, unsorted order?)
>
> Quentin

