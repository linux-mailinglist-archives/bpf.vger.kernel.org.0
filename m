Return-Path: <bpf+bounces-60702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25038ADAA2D
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE731887BFB
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1C209F45;
	Mon, 16 Jun 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFu1j3bR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977A1A76D4
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060971; cv=none; b=E6QFQJupHjTUK40k0VhgQ3pgjaDX5BcFuni3ya877Qj3l4ScNU+L98ynyjAa5AxwMQfpRucCC19cEDR4Tk973shBFBtDxd9VPE+4q8nGQCC6nklF+dfJvoDGJeBbI80m+EkSxRubInoRyMkvyDnoQj0dnbjO8Xo4UsPf2bNp+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060971; c=relaxed/simple;
	bh=99zm8+fJ/yg2polt7yhQuLYu38j0s2Z4sOGKcm03lE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6omPOWDw1dHbDS2nwjcDDCqiorUKY5tjknKtRRrHO01pu5t3koHZ9i+XYFzDCIhCA7aEGysHPc4OefJPJG9wgwAT0lJqrUmpxr27RT3WQNcWDxm1A5XucFyAItDL4/TWiT9fHx5Mm1a82H1xaXy5yS6tjl4olBkbYUDtnux6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFu1j3bR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234d3261631so27927815ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750060969; x=1750665769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4jz3c26qgTS17pNWfZkALrQ2YVKsIqmlGHhd6+HAvLY=;
        b=FFu1j3bRzMa6Y7y4RLlRgbmd9+zppZdROXLtfr6nxKOOcb9QE4bx9xFVjApKsEuA42
         Zwp8/ofqiF0612CyYUR5e7u3TIJggbFU58rhAZfvcuLYjMKjYZdGgDbgzncWy3Irfaw3
         kSC4Bru5S7AQ+3ux2EaIExUOgwOk7C1OpKcydQYrhU3RWixKSALNRBtycsydx421dmXt
         Gq9AxLLfyzH0B6wS5K2Yh0fPvdoMbargX7IJih1j+VloNsKmM39kvu9DRONlpE9ctIHI
         bSOh1zXSf7CHwJ4UAkRWS8+PgiCBXy9bFjsi1+eB1oL9FJ5tKzrYyb1geE3gYX0PmPH8
         AZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750060969; x=1750665769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jz3c26qgTS17pNWfZkALrQ2YVKsIqmlGHhd6+HAvLY=;
        b=X+vyWMh9Fnpxk4FRKViA3a/4/hkvlkiY+3HGGYmkTvk/mrb9RsRl9r9BgJQuwkJIM6
         U8K8LqEID2PChwTUCRmHMzJ+/KY1wQ+ZYlnPZutryV6AePIlmgaLzPJWmdKuwTQpkuZa
         ocLWHLuColMD0wOLnIWSQR3I6jNZMCFwWRxdnx2jM/tSblOWHXHa8M2gUNYpCP4yn6UN
         BZChbYZ6KKaoi/jkh+4ng3InU2RVDyZAkcu3w0LuZYGg76ne/tkGDahl1zHHoQz4syGC
         fN+sFAFFumRm03quSIutnuFbDpDJz9aUnv/8007fSLpNMwnjo9M5QzE731bEeFhM/C/N
         9FsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSmZb0dwHDADNwovUXJZxCHNQGibcaDMOiaA5IXnEqaXkLujqy7b3RoATHbgwEe0bl8as=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQ/StRpvCXzLmxRQWIbTgsL+YHOlPsbupBgFjDQif/MGsIJmw
	HTylQjZiuWE4dMNyCpUONakf6lbQsRWJa2ceA9N6SNSoQTeU1R/Ge4Eq
X-Gm-Gg: ASbGncscFRxDDComzl4uWtfr99RdpahSYFfg5INpj59IPU7ysVAQlYXQic46NPWejTN
	mUdxKd13a9vrbBoutKSydD5o8qXGUwS/jPUpVq4gyZ8FX1daqRYOjHBzSZpKksHuByygTudvLX3
	kp+9WjgmUACkQwv3v0BcBlsV2quSJ4710KQmQrwdmiEvRtFCRHe2VbVY5iu7MiR30K+HJ1P5G3M
	7JCcG6QrzB1fA6Jbbhb9j4yaRqyewYSpb+CuOV6eEaZG5eZd0fDqVxx0TygTZjiBmODxLxWn0QO
	nFW2A4O3gcCB/cGsgLuTAN+IszD1EASwhxo6h/qI5RgXb9x4FeX7YSoXhcZb+33/r6Mr
X-Google-Smtp-Source: AGHT+IElJIiw7rSpOXXn4JoezKlYcU8CJvTXdE7qwJZ1osUX/OAPJ0qyhbfDvHJdHhsLzdiP74doYA==
X-Received: by 2002:a17:902:f686:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-2366b14d340mr131716435ad.25.1750060969452;
        Mon, 16 Jun 2025 01:02:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1919sm55958135ad.66.2025.06.16.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 01:02:48 -0700 (PDT)
Message-ID: <9c419c4791301c7b5451802c0989812fabed1543.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory
 allocations in memcg statistics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team	 <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 16 Jun 2025 01:02:47 -0700
In-Reply-To: <CAADnVQ+NMO2_fGE8XevgFVFgSCSYU14RrqDhtbwF-zZuzn8Ebg@mail.gmail.com>
References: <20250612130835.2478649-1-eddyz87@gmail.com>
	 <20250612130835.2478649-2-eddyz87@gmail.com>
	 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
	 <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
	 <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
	 <CAADnVQJxQMEdbdTrDSZyb+SWxdwjJYWx6F6jmkff=OAeEoSTPQ@mail.gmail.com>
	 <60dc085263d7d746f5c223f8df85f55679786c7f.camel@gmail.com>
	 <CAADnVQ+NMO2_fGE8XevgFVFgSCSYU14RrqDhtbwF-zZuzn8Ebg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 19:25 -0700, Alexei Starovoitov wrote:

[...]

> > verifier_loops1.bpf.o    loop_after_a_conditional_jump                 =
128
>=20
> This one caught my attention.
> We have few other tests that reach 1M insns,
> but I think they don't consume so much memory.
> What happened with this one?
>=20
> __naked void loop_after_a_conditional_jump(void)
> {
>         asm volatile ("                                 \
>         r0 =3D 5;                                         \
>         if r0 < 4 goto l0_%=3D;                           \
> l1_%=3D:  r0 +=3D 1;                                        \
>         goto l1_%=3D;                                     \
> l0_%=3D:  exit;                                           \
> "       ::: __clobber_all);
> }
>=20
> I suspect we accumulate states here and st->miss_cnt logic
> either doesn't kick in or maybe_free_verifier_state() checks
> don't let states be freed ?

This one is a single chain of states e.g. at l1:

  {r0=3D5} <-parent- {r0=3D6} <- {r0=3D7} <- ... <- {r0=3D<last-possible>}

And if a state has branches it won't be deleted, the st->miss_cnt will
just remove it from explored_states hash table.

I inserted a function to measure exact number of states and memory
allocated at 1M insn exit [1] and it says:

  sizeof_state_chain: 46401520, num_states=3D25001, ...

So, it's 46Mb of states and 25K is the peak_states veristat reports
for this test case.

128Mb - 46Mb -> a lot of memory remains unaccounted for, but after
disabling KASAN veristat reports 66Mb. Still, 20Mb are used for
something, I did not track those down.

I made a mistake collecting statistics with KASAN enabled, here is
updated top 5 for selftests with KASAN disabled.

File                      Program                        Peak states  Peak =
memory (MiB)
------------------------  -----------------------------  -----------  -----=
------------
pyperf600.bpf.o           on_event                              5037       =
         136
pyperf180.bpf.o           on_event                             10564       =
         109
strobemeta.bpf.o          on_event                              4892       =
          98
pyperf600_nounroll.bpf.o  on_event                              1361       =
          72
verifier_loops1.bpf.o     loop_after_a_conditional_jump        25000       =
          66

And here is updated top 5 for scx:

File       Program                          Peak states  Peak memory (MiB)
---------  -------------------------------  -----------  -----------------
bpf.bpf.o  lavd_select_cpu                         2153                 22
bpf.bpf.o  lavd_enqueue                            1982                 21
bpf.bpf.o  lavd_dispatch                           3480                 14
bpf.bpf.o  layered_dispatch                        1417                  8
bpf.bpf.o  layered_enqueue                          760                  5

Absolute numbers dropped down significantly, relative ordering not
that much.

[1] https://github.com/eddyz87/bpf/tree/loop_after_a_conditional_jump-memor=
y-usage



