Return-Path: <bpf+bounces-42726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61D9A9639
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 04:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E30D1C22CED
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438B1386B3;
	Tue, 22 Oct 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9XkHrdT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97D7E59A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564057; cv=none; b=ggd37n6ttRXsw0l7ZUYe3v2OsBGoKViSBoyo41bonjWJBrTkRfQXt+1OK9AzX7XyqsDSpOrsR6A1fw45nDAwQPY31cQCdzoxtVGosMiOe0FYef1BKzBpcM433nw+D0Qe6YS0H2IrsAD+mxW9rehHAgCWbIyTiu7LUkqesYRXtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564057; c=relaxed/simple;
	bh=WwCK47q1tPITMFxKMHERvcNHGnu95DfM0VSTvVFqYcs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbK4YIJVmtJMPZX/MrVvvGmiZblHT+IL6zuv+rZLgN1qR2IGOI7T6RymR+W8WM4awCkg+knBNuYxaf+c9jl87GZ2Hb7TP2gb5jRvATiJzo27wsFxFdhcbgWZLn4F2gTZaD8c2gZO9/Pm74TA5DZpWSKLTnpNv/4y3yG8aT/QteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9XkHrdT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c767a9c50so47428065ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729564055; x=1730168855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=trLRpjt9YO30OOvFC2e1xtO2N7mjnkyC9vGimxBHS9U=;
        b=M9XkHrdTjwBBXJExsQbUTEVQ/eeY+1RBE1PPNtqkcR766f8fBBESv8qdOffTty6+F6
         SqD5vmGayhRpxeORArAdZKaWyKdmhj4QYAf+eEOEEm7uF1f50IJl3XUO3h2mHleibuO0
         LuA49ZT2AQ3dwgBkOFdimB58mfSeeQKQxbX5O1jhhzh7O1PWXuYRVreTCgyJ4pSpnDNq
         TP/bok8ezna7OgMY0HWKPdYLgwc0hV0T21t2E3QQgn9meSE8BXTasif/E996Lv+tFgwj
         pzR/kPGkc8m+Jh68aqrnMbKmaxUjJzTeRZNH9iuLthDlGRW2Vy8nULYk0Fc9jAvQwpIg
         qHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729564055; x=1730168855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trLRpjt9YO30OOvFC2e1xtO2N7mjnkyC9vGimxBHS9U=;
        b=GznGhsgGmLtoHzNXer0lX2Tu7hPsD/U4pU+dHdR4HVBH6Ti9+KGAtiqsleg9A2L/wr
         8eixNPPYn9oBU2lDcVeMrqE77DFOULM8OMaAwEcVsAPlwg5t0CA7VMZWSiWn3rV1gKDu
         TxEXu3zwuaZBZFd7E7rBXmEk2MlxstaJqOZ7ldCZqzukDBau4u45AKZibrr0fWNw4Yxt
         C1dwBOilSPdKWbWO6fSYGbB7TMRnXOBg2RZGgDLfWqvBZePRItvJti8YFe+oAGjb+zvB
         gFkEj52Kzy4K41ktc5Xn9Itiu967GGz6J0Z3I9S4KSH6Zhsks4R5sqQ13uLV3+wzi9L3
         wgwg==
X-Gm-Message-State: AOJu0YygPMZmDfH3MeLdZqPaMSJYcQX9CLqQVVFUg4RJd/CmKKUGhwb2
	NhCFFWww0aYkFAf5wXTw5Iinzp+KZn++XVE5oJ0dAtQCJBqHl4ZGgQZADA==
X-Google-Smtp-Source: AGHT+IEOOfwAQYKnJd5ilVgmDG8NfQRJfeRJL3iNKohgE9XU1hBABaaxZd3iC84lXkZhJEx9sWQqfg==
X-Received: by 2002:a17:903:32d1:b0:20b:8c13:5307 with SMTP id d9443c01a7336-20e5a8c3befmr157317235ad.33.1729564055432;
        Mon, 21 Oct 2024 19:27:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee895dsm32792755ad.23.2024.10.21.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 19:27:34 -0700 (PDT)
Message-ID: <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history
 is too long
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 21 Oct 2024 19:27:30 -0700
In-Reply-To: <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
References: <20241018020307.1766906-1-eddyz87@gmail.com>
	 <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 19:18 -0700, Alexei Starovoitov wrote:

[...]

> >     0: r7 =3D *(u16 *)(r1 +0);"
> >     1: r7 +=3D 0x1ab064b9;"
> >     2: if r7 & 0x702000 goto 1b;
> >     3: r7 &=3D 0x1ee60e;"
> >     4: r7 +=3D r1;"
> >     5: if r7 s> 0x37d2 goto +0;"
> >     6: r0 =3D 0;"
> >     7: exit;"

[...]

> > And observe verification log:
> >=20
> >     ...
> >     is_state_visited: new checkpoint at 5, resetting env->jmps_processe=
d
> >     5: R1=3Dctx() R7=3Dctx(...)
> >     5: (65) if r7 s> 0x37d2 goto pc+0     ; R7=3Dctx(...)
> >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> >     7: (95) exit
> >=20
> >     from 5 to 6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> >     6: R1=3Dctx() R7=3Dctx(...) R10=3Dfp0
> >     6: (b7) r0 =3D 0                        ; R0_w=3D0
> >     7: (95) exit
> >     is_state_visited: suppressing checkpoint at 1, 3 jmps processed, cu=
r->jmp_history_cnt is 74
> >=20
> >     from 2 to 1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> >     1: R1=3Dctx() R7_w=3Dscalar(...) R10=3Dfp0
> >     1: (07) r7 +=3D 447767737
> >     is_state_visited: suppressing checkpoint at 2, 3 jmps processed, cu=
r->jmp_history_cnt is 75
> >     2: R7_w=3Dscalar(...)
> >     2: (45) if r7 & 0x702000 goto pc-2
> >     ... mark_precise 152 steps for r7 ...
> >     2: R7_w=3Dscalar(...)
> >     is_state_visited: suppressing checkpoint at 1, 4 jmps processed, cu=
r->jmp_history_cnt is 75
> >     1: (07) r7 +=3D 447767737
> >     is_state_visited: suppressing checkpoint at 2, 4 jmps processed, cu=
r->jmp_history_cnt is 76
> >     2: R7_w=3Dscalar(...)
> >     2: (45) if r7 & 0x702000 goto pc-2
> >     ...
> >     BPF program is too large. Processed 257 insn
> >=20
> > The log output shows that checkpoint at label (1) is never created,
> > because it is suppressed by `skip_inf_loop_check` logic:
> > a. When 'if' at (2) is processed it pushes a state with insn_idx (1)
> >    onto stack and proceeds to (3);
> > b. At (5) checkpoint is created, and this resets
> >    env->{jmps,insns}_processed.
> > c. Verification proceeds and reaches `exit`;
> > d. State saved at step (a) is popped from stack and is_state_visited()
> >    considers if checkpoint needs to be added, but because
> >    env->{jmps,insns}_processed had been just reset at step (b)
> >    the `skip_inf_loop_check` logic forces `add_new_state` to false.
> > e. Verifier proceeds with current state, which slowly accumulates
> >    more and more entries in the jump history.
>=20
> I'm still not sure why it grew to thousands of entries in jmp_history.
> Looking at the above trace jmps_processed grows 1 to 1 with jmp_history_c=
nt.
> Also cur->jmp_history_cnt is reset to zero at the same time as
> jmps processed.
> So in the above test 75 vs 4 difference came from jmp_history
> entries that were there before the loop ?

    0: r7 =3D *(u16 *)(r1 +0);"
    1: r7 +=3D 0x1ab064b9;"
    2: if r7 & 0x702000 goto 1b;
    3: r7 &=3D 0x1ee60e;"
    4: r7 +=3D r1;"
    5: if r7 s> 0x37d2 goto +0;"
    6: r0 =3D 0;"
    7: exit;"

- When 'if' at (2) is processed current state is copied (let's call
  this copy C), copy is put to the stack for later processing,
  it's jump history is not cleared.
- Then current state proceeds verifying 3-5-6-7. At (5) checkpoint is
  created and env->{jmps,insns}_processed are reset.
- Then state C is popped from the stack, it goes back to (1) and then (2),
  at (2) a copy C1 is created but no checkpoint, as env->{jmps,insns}_proce=
ssed
  do not meet thresholds. C1's jmp_history is one entry longer then C's.
- Whole thing repeats until ENOMEM.


