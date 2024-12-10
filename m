Return-Path: <bpf+bounces-46440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B329EA398
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38BA165A6D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A4AD24;
	Tue, 10 Dec 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="depne28a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEF6FB9;
	Tue, 10 Dec 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790229; cv=none; b=Xo1+6ZP5GyjjHyE18I0mkv3CEhm0QaCaSeO/V8FaINnSl5i3mLfH3IzrH1e2xKU1SP7D8mVEc/xp7HO8m1C1Vv4BJnW0jVNN5BtygZaJk5b1rOn+70Jo8VKjOJvodpFMpFespftO14gBC0zMO5lKyu/lsBKT9F3WaaqAT0ujXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790229; c=relaxed/simple;
	bh=kApmzV/SzSLrBWhdK94VNwB/+dzHEEFezTowie9+IfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAUaB8QiQMGxGxWJU4vL2IRDgwWWKA4MPf8Vlqykd7dxX5m0JTg5ePW7QxJW5PJf3y3l1pV5aZKqWr82qDOVB+pP9I3bVhndvxkNX2rnT7tuOhUIbp60vvGF3YS6X38koMlzZBHCrSDsUmmpE4v/d03flIPvjRyrSCTw4a4y2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=depne28a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7242f559a9fso5018367b3a.1;
        Mon, 09 Dec 2024 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733790227; x=1734395027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG0Bwq+MseoC81hdPPvLH0+mmvnEp0X9Csn6ZS4D2+E=;
        b=depne28aso6ZYdXWmE887xu6ZkcQHl2u1iF/X+JbGEZz9PFqk7z3KuS60qlzvNBlEN
         zrKhIM0P+0/Eyk3rYtBQxnSudc4M2BRsp8Qc8xLfzHeZoDzjNG1xU/Chv87Lbr61cdPs
         QtZ4eclxcATd1ZlfZsmdCXr6HqIbuBpB2DHAQcCgdVGMeszkSfbOcIpuTRloQSrq4GOL
         iSZ8MMG5ugX7QqPOv1Ho2G7O9gVFo7T5zf3pSu7CSzMkpgF+hw5rciyW+YEYXJ/dDQlC
         ad66iefFANKvbezQ+LKi+U7eRR9WM243GAqgU6ORTWg4b3AW6cfQTm2++33FTaP8Tpbs
         COOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733790227; x=1734395027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG0Bwq+MseoC81hdPPvLH0+mmvnEp0X9Csn6ZS4D2+E=;
        b=vu3Kg1jOOYjIYvusgGpu3nWbR+h2ZpuBHEkE38v9CFTHXOBKZDD1BRsqdSDpmQRsFe
         8LZm0o120b5KBhQbRRVP8Ykcw3sV0EvQrO2uCoqtBJKRyBgDgC2ZkVeGHn3Mcm1dL6qs
         N/gaVsFFTVNnve54DebHYbUwPjYTvdWvYbRkBsZMQnAof1fd4ZTbLBN1Zuq/mtvfbyb9
         H7gqedfEiLIwM7wfIhe4dEnOkucyVkKobTIBCqcZoPvjTR48IcHnblOVooG4agtbNALX
         p5eE4HewYfQCDWMmsTN1qlU9X1wluyEy1eJh3SSatAhf1o3H35MuucadDc/aJiorE8ep
         IlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgQlARiEdzOIfyNgnCh2+icUy/V9ZMUPXeZN/6nfR6uE7hVpxsLSMcWG2OwbBVtZWDB7c=@vger.kernel.org, AJvYcCWBPx+ttQ1IKTszMBrlLhmn+HsKfpQf1fz61fk0HQbWCFvvpaZ+q2DlCC4IYICR00A7RBLhzdN98hY2+77y@vger.kernel.org, AJvYcCWxrHT9EpqkN+akeRaTJBMFjQtIoTeGX159y5spkidVA41R5DqHHEXCnAQ3BLTqnida3Q30OXgPqHJPwUs+nGMPoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEPbY3Fek0ykJ6/BUd+76IdA7+oRyLg9d0lZU2BnvYiek7fM+
	Ol2U3Fa4HAz0IO4XvvpjLclUPFaJ0yF6h2z1ubl/oqHR7vEkZMlkkbKxy5RFQzpLYX8tQfAYdJH
	On3O1jcX36aQaOIDzB8BEi74TphY=
X-Gm-Gg: ASbGncu7USdyrO7tqQjwD/PeWYqb1lMMyQKJOT0riTgEChFsk/V4L0Kv6Rwq99sZysZ
	6kMueWSmpwesFDNVw13xdvy7h9OQlLn4C/auoJotUxHS6rGdYz+M=
X-Google-Smtp-Source: AGHT+IEEqlsSBYngjr4I5z0qBa7qDAeyOkQYrJ+3t8fJvEGOKj8iNJGzxCVjtHr374G9uWB30FHNlkoNKT4rxGjYCLg=
X-Received: by 2002:a05:6a00:23c1:b0:725:9f02:4894 with SMTP id
 d2e1a72fcca58-725b818830cmr22999161b3a.24.1733790226031; Mon, 09 Dec 2024
 16:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108061500.2698340-1-namhyung@kernel.org> <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1> <Z1cdDzXe4QNJe8jL@x1> <Z1dRyiruUl1Xo45O@x1>
 <CAEf4Bza5B9rSX7cw4K0iC-gW+OeEATLCcQ=6KGfmuxfJ2XOhvA@mail.gmail.com> <CA+JHD91Ai_ObUye4Unz2e2Hku2BH5_+0q3HyUtf7ay23uDnkjQ@mail.gmail.com>
In-Reply-To: <CA+JHD91Ai_ObUye4Unz2e2Hku2BH5_+0q3HyUtf7ay23uDnkjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 16:23:33 -0800
Message-ID: <CAEf4BzZVM=q2yPrt34AyiVJYiB1cAu2Y=4zCKkYFZ0N-Ai6BRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:33=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Mon, Dec 9, 2024, 8:00=E2=80=AFPM Andrii Nakryiko <andrii.nakryiko@gma=
il.com> wrote:
>>
>> On Mon, Dec 9, 2024 at 12:23=E2=80=AFPM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>
>> > and additionally the type is not like the one you added to the barebon=
es
>> > vmlinux.h:
>>
>> > =E2=AC=A2 [acme@toolbox perf-tools-next]$ git show d82e2e170d1c756b | =
grep 'struct bpf_iter__kmem_cache {' -A3
>> > +struct bpf_iter__kmem_cache {
>> > +       struct kmem_cache *s;
>> > +} __attribute__((preserve_access_index));
>> > +
>> > =E2=AC=A2 [acme@toolbox perf-tools-next]$
>>
>> > But:
>>
>> > =E2=AC=A2 [acme@toolbox perf-tools-next]$ uname -a
>> > Linux toolbox 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Mon Dec  9 12:33:35 -0=
3 2024 x86_64 GNU/Linux
>> > =E2=AC=A2 [acme@toolbox perf-tools-next]$ pahole bpf_iter__kmem_cache
>> > struct bpf_iter__kmem_cache {
>> >         union {
>> >                 struct bpf_iter_meta * meta;             /*     0     =
8 */
>> >         };                                               /*     0     =
8 */
>> >         union {
>> >                 struct kmem_cache * s;                   /*     8     =
8 */
>> >         };                                               /*     8     =
8 */
>> >
>> >         /* size: 16, cachelines: 1, members: 2 */
>> >         /* last cacheline: 16 bytes */
>> > };
>>
>> > =E2=AC=A2 [acme@toolbox perf-tools-next]$
>>
>> > Do CO-RE handle this?
>>
>> I don't know exactly what the problem you are running into is, but
>> yes, BPF CO-RE allows handling missing fields, incompatible field type
>> changes, field renames, etc. All without having to break a
>> compilation. See [0] (and one subsection after that) for
>> "documentation" and examples.
>>
>>   [0] https://nakryiko.com/posts/bpf-core-reference-guide/#defining-own-=
co-re-relocatable-type-definitions
>
>
>>
>  The doubt is the extra layer of unnamed unions in the BTF for the kernel=
 that's not present in the minimal representation shipped with perf.

anonymous unions or structs are transparent to BPF CO-RE relocation,
so that shouldn't be a problem

>
> - Arnaldo

