Return-Path: <bpf+bounces-63413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4092B06E03
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3EA168665
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D000285CA5;
	Wed, 16 Jul 2025 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRAum/J2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C810A1E;
	Wed, 16 Jul 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647566; cv=none; b=dHOnV9ORbKs6g4z0kseFHy0SWR6RB1LkIq4iz0kckXTJcPlCL22hfzIMSlIUmonaGpjiurIzVLpKkJAxdd7WDQc1FbkvfRtD/rbPuHAJPEI/UlN/tEPoMJH6YUYqHD2YSTvuy2YTNWPMbg5QxQij3IawwWNgaMJzZ5HSqI1ebv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647566; c=relaxed/simple;
	bh=xzw9n5h0vb3VBRoDkMvgNC/mlzbG8DQ/R1GZjQjZYu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCMtibeXFlHYrd8Gr2t3HOmVEmlMcG9cceDVbxZ1O34ZIFBmI+vqpsLHNl6CixR/mWbqxqzOaBo+PPaT55m6a8/2NMLrYReeUJY9STie9wQzXAI4aFe9c/+f8Nxc/SkqdbsAG8v9LxJ1e9ZKb0IOmPZ4K5ErJHbqjn4iczzHkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRAum/J2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8f179e1bso64977035ad.1;
        Tue, 15 Jul 2025 23:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647565; x=1753252365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZbt95KbFg2hOt+HZBpdMbfT6AMCghvtO+LjH60IXS0=;
        b=dRAum/J2qDKT2fp265TABmyB0vYyswjG6kU+E3+dbGJge+lmqrTlPguDzGC81SNf6G
         ecZ4/Yora3MZ3pUrvWe2MCSg/b5mKfAqHQA4HZ8kiLfh0EmvbIWeu6K1gwV7oUPJ/hrl
         gRebZwtNlWcxnSl3xzgQ32ooaUpkTvEmQfHpuVkHg1hkHs0ZrHv3WvoIzmtm/yNOvEl0
         aIPsfS05F51WeyGHTVgAmhkoera2fFU3rS4TN2j7kNaFfhWtYx1I/P99sbHjdzqhQ1p8
         kcL0R3V0HoBPeGGFrIvuWa8v6lOqNUk8HNBk4Ytd5EY6leDdlVo7MI0/XNppc1USbnee
         8l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647565; x=1753252365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZbt95KbFg2hOt+HZBpdMbfT6AMCghvtO+LjH60IXS0=;
        b=c5W/8wzImTUWsWu9Kd7RsMzVG87j9CWf+KeUunbbZ7A/1l6g4zyzd44knRBxa/+eAp
         G5bxXNkB9YsZPkqABDpxMGZCdFjjPEThTFUdzwN9Sl/PidnmBuOfC5ZPY2lI7pyGBhej
         9kOKYMjMOhxDkeesv2BMmao61m7Y5TxLoNX5CTAvW4E5X4ySug6mM37jcC+ARIPlVFKH
         AAcvLMxnzdMoLFPZrNeXOF10S4EETsg8NT/8GMj+ikCjQR+Ncl416XKw3RLOab+NDcLP
         i9auqDZ3LpT4avqz9rBdXnZiDbjvV0esWlIH38ObO8T8KTy1i1YWSLLu8LCCLfFqDF7/
         9n7A==
X-Forwarded-Encrypted: i=1; AJvYcCVrf9XKVSOystgModvj8LoG6p6IKOfrf2l248TI7uUqBBmG6jx8L5DLhSG/j1aJnMnT8K0=@vger.kernel.org, AJvYcCXMmtR0+sragkR1+jGmk7dmr3XWxgy+8dJkBDQaeOmLO1weza/OBglIStn4OX2ha8jVuK8t44VEXhl/WifE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvbc3PFJ5iwTrn+xcXU9fKKRzVMRf15U5Qso6qWbP4lgz4Heuu
	V4YJBB8++ek4vEyIVsHjFGAMqlfHhUF5AWrmMjODLLX9z6cW8UCXUXMDGhmhKUSA+zaKQuO4TGX
	Zq2QFchgeuz4G3qtWyU0clTUd6pyPDUI=
X-Gm-Gg: ASbGncuYUWVYq2ioQFmo9C4HLQhSeqe7uramNkVkmt97PkdjK0+zuR1PO+Ex+ONKrzY
	5uL3/YNejZMz12tbiMgcv/ejpe59q0mvJsbAbNUsYiBAsA3XdR9mLJKnJ8bkjJV3py4LmsKnR1N
	SZxGKlnfLD8wnUAJE9/7BVPl5x3TMJxKaSc8pRBfPCMVyo+MRV9AbFqTmbM5QkYqlZZccBE429t
	rdl7ik=
X-Google-Smtp-Source: AGHT+IEitsAvfjlLesg16dXKN9icya/6JJ64IjqPLneFVcZcK2vUVt97Gwrqjkxz24artDbluZrv2FUXFarAfc/S9U4=
X-Received: by 2002:a17:902:dacb:b0:235:1b91:9079 with SMTP id
 d9443c01a7336-23e2573640cmr23069065ad.32.1752647564588; Tue, 15 Jul 2025
 23:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715075755.114339-1-shankari.ak0208@gmail.com>
 <CAADnVQJ6_pB8ZU2Cw5S6nB4J-6s7bw5Fp-Hst9M_EE9=HxN8+g@mail.gmail.com> <27c7c76c-becf-47b1-812b-05f260a8cd85@linux.dev>
In-Reply-To: <27c7c76c-becf-47b1-812b-05f260a8cd85@linux.dev>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Wed, 16 Jul 2025 12:02:00 +0530
X-Gm-Features: Ac12FXy6Tp67UctEQFKfmmjnR_XmlFFeJ4lxL_LtloIpi0KU9qVJL8w8_NajKHo
Message-ID: <CAPRMd3m9NtGXfH3kDWLq-Lu63i1ww4znDJ9aG6ho5J3+Ow_bnQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: restrict verifier access to bpf_lru_node.ref
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
>
>
> Also you misread the kcsan report.

> It says that 'read' comes from:
>
> read to 0xffff888118f3d568 of 4 bytes by task 4719 on cpu 1:
>  lookup_nulls_elem_raw kernel/bpf/hashtab.c:643 [inline]

> which is reading hash and key of htab_elem while
> write side actually writes hash too:
> *(u32 *)((void *)node + lru->hash_offset) =3D hash;

Thanks for the clarification. I misattributed the race to the ref
field, but the KCSAN report indeed points to a data race between a
reader, lookup_nulls_elem_raw(), accessing the hash or key fields, and
a writer, bpf_lru_pop_free(), reinitializing and reusing the same
element from the LRU freelist without waiting for an RCU grace period.

> I think it is possible. The elem in the lru's freelist currently does not=
 wait
> for a rcu gp before reuse. There is a chance that the rcu reader is still
> reading the hash value that was put in the freelist, while the writer is =
reusing
> and updating it.
>
> I think the percpu_freelist used in the regular hashmap should have simil=
ar
> behavior, so may be worth finding a common solution, such as waiting for =
a rcu
> gp before reusing it.

To resolve this, would it make sense to ensure that elements popped
from the free list are only reused after a grace period? Similar to
how other parts of the kernel manage safe object reuse.

--
Regards,
Shankari



On Wed, Jul 16, 2025 at 2:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/15/25 7:49 AM, Alexei Starovoitov wrote:
> > Also you misread the kcsan report.
> >
> > It says that 'read' comes from:
> >
> > read to 0xffff888118f3d568 of 4 bytes by task 4719 on cpu 1:
> >   lookup_nulls_elem_raw kernel/bpf/hashtab.c:643 [inline]
> >
> > which is reading hash and key of htab_elem while
> > write side actually writes hash too:
> > *(u32 *)((void *)node + lru->hash_offset) =3D hash;
> >
> > Martin,
> > is it really possible for these read/write to race ?
>
> I think it is possible. The elem in the lru's freelist currently does not=
 wait
> for a rcu gp before reuse. There is a chance that the rcu reader is still
> reading the hash value that was put in the freelist, while the writer is =
reusing
> and updating it.
>
> I think the percpu_freelist used in the regular hashmap should have simil=
ar
> behavior, so may be worth finding a common solution, such as waiting for =
a rcu
> gp before reusing it.

