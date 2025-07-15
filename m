Return-Path: <bpf+bounces-63291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4FB04DE2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FA03B67E2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495322C3268;
	Tue, 15 Jul 2025 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAquGVMc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D7126F0A;
	Tue, 15 Jul 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547139; cv=none; b=tUsfvPoj2lbaeBDIqfQ1omUUw62Vc+mmi7BQHwl4npB1kGQsz8TV/BhJVOcJX6b6HOF4y5xEcMHaN/O/bm+QsCDZaqR83jDJ7SiXucIfd7gUCGA/tEzTLPS0NgeC9ALL7/QS57zK9Ua1tNju5f55wuKkYa4pkZueowqUYz7qnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547139; c=relaxed/simple;
	bh=kXntKam1q3hzYcIOmReMX0oacTt9qmD3C+KXc4cokog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keyNQPAWbcOQxpGA0ShhM9NOl1Eyq5B7w5cPryk9c99bJ/qbCCc9PFHx4eCNdpMi4TgKKH4bHhiGlgfmOFmdUeEVZrYYNUvvjkReBg/YXNBfcUj+Lu4+t7cqq347aBAqsLo0YzwEmeX2bTB+zKu3SCNDjvBuGCcUUZXqC7Y2zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAquGVMc; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e8b8893ef6dso2621233276.1;
        Mon, 14 Jul 2025 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547137; x=1753151937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXntKam1q3hzYcIOmReMX0oacTt9qmD3C+KXc4cokog=;
        b=JAquGVMcDnMw8zosE8YTqcfDYnKa52lM9WY6mIVOmYk8WIaL+2fvCeyykYoTeGbwhU
         dbckpKNUVXek0Hphe48RcDykY3g91QsBh4lw2UaiZ7zbB40/Bj3exd+OzawYufAbR1kE
         8MMRQgjyUHRp/npFwnLLOmyldyyYfk9NgNb595sxG/sDxA+ukKphDovGjax7P0lR7UTS
         v5+p2liHiTW6bn91aw1KEgVJWni8kBl5Xysq4MtEP84jpLhUBsiBjMnQ4yKhV35xE6xb
         8NLN9AOZawXnZJPHhGXjl6dIJKMfnHLyuPvyBwWfEFnigVXn8cUucTxhJ6EFL41ZCHd7
         1vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547137; x=1753151937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXntKam1q3hzYcIOmReMX0oacTt9qmD3C+KXc4cokog=;
        b=RB1M1DKkv4/xUWlNg3OOZ+KbkYB67p9WkcmkQ0hEq9m98/gYMLW2ou8J15DuvwgpLx
         sSOHuR2tZlZfCRzZaM377R9iezNl/WlzBlWE6PEJ/4uO3dtJ4zFLq428iFRgBv3BJte7
         J7dV2W+b4+YjxEEyKYueUuFLui6UBOQgsDxgbEy00h/zMaZyawhHoypcWRqFaiGgpsH6
         2keB8zHuT7g8uUxSMV270Epi+zHS7z+yzOSraE2EAnjpV4gtltbSQiYJvn/8QjT2W1rr
         Yv7LKTPR0hEV1edXHemBaX91jPKbm+45/yVj9tCZcqHPH0HLb35Xdrz4pQ+cpUBkB0I/
         ERaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzTIHfzfHlvr2Ss4ZlLGq/TrXcXs/SJIa01iwyBFMmqYhMtwglkeZZZMsygxXGFGGCoO4=@vger.kernel.org, AJvYcCWkSRRL7lKGoGR995sOtmwyU3HuEwhafB/kWKJ4OQtlTDJch7TKnxBYFJJlT48U3ytfAjSaqEWH45huvWe1@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwcxavAsddh9ymyUnn1SrihB5LAY597T97+p5QId8CBkKagL6
	pDLw93xln5XBdQr2cwYQ2SCgaMQtmeZiL/XwuPLIgBfWDE4n2Wu5/jCs4amofWIYXdBnWhhSOnj
	qCvEggoYNnSsFfYib1Kth5Ccyi2Bqrfc=
X-Gm-Gg: ASbGncsRdW5+L9aNmNcJsZuod4lPc0KjUTGwJdGHI4xO3HP1a7BNUNaygoGQHvlX7ym
	8tmlyzkdXU+Qno1jBtmauGskLKqrl76/q0ucYmCrX73HzYCYKdEocGaa7mw1/CWwjc+NnKoi8C0
	+Sps4Ep7K6m4A4OJGoX/YXyeff9aqnm30d5tIxIkiisdcjQKHtGXSJ0LEhHxRKzwWvOO7OF1vyp
	s4//+c=
X-Google-Smtp-Source: AGHT+IG/lWMkAlN2VrFO88hLDbAjfqDApA/KV7sI9HExEYGFvuRltNjjOA8GMMDPmuVVnA4pe7ovLnHs4Xa0vSeh0dw=
X-Received: by 2002:a05:690c:398:b0:714:429:edc5 with SMTP id
 00721157ae682-717d5b8019cmr206077407b3.4.1752547137072; Mon, 14 Jul 2025
 19:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-2-dongml2@chinatelecom.cn> <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
In-Reply-To: <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Jul 2025 10:37:52 +0800
X-Gm-Features: Ac12FXzqQhnaWiRfM-YgvgG2vgfyHGtPahc_P3L2PPbJQwnT9wjWeD_NuqxdtyM
Message-ID: <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > We don't use rhashtable here, as the compiler is not clever enough and =
it
> > refused to inline the hash lookup for me, which bring in addition overh=
ead
> > in the following BPF global trampoline.
>
> That's not good enough justification.
> rhashtable is used in many performance critical components.
> You need to figure out what was causing compiler not to inline lookup
> in your case.
> Did you make sure that params are constant as I suggested earlier?
> If 'static inline' wasn't enough, have you tried always_inline ?

Yeah, I'm sure all the params are constant. always_inline works, but I have
to replace the "inline" with "__always_inline" for rhashtable_lookup_fast,
rhashtable_lookup, __rhashtable_lookup, rht_key_get_hash, etc. After that,
everything will be inlined.

In fact, I think rhashtable is not good enough in our case, which
has high performance requirements. With rhashtable, the insn count
is 35 to finish the hash lookup. With the hash table here, it needs only
17 insn, which means the rhashtable introduces ~5% overhead.

BTW, the function padding based metadata needs only 5 insn, which
decreases 5% overhead.

>
> > The release of the metadata is controlled by the percpu ref and RCU
> > together, and have similar logic to the release of bpf trampoline image=
 in
> > bpf_tramp_image_put().
>
> tbh the locking complexity in this patch is through the roof.
> rcu, rcu_tasks, rcu_task_trace, percpu_ref, ...
> all that look questionable.
> kfunc_mds looks to be rcu protected, but md-s are percpu_ref.
> Why? There were choices made that I don't understand the reasons for.
> I don't think we should start in depth review of rhashtable-wanne-be
> when rhashtable should just work.

In fact, all these locking is not for the mds, but for md. For mds, we prot=
ect
it with RCU only, what complex is the md. So the logic for the hashtable
that we introduced is quite simple. We allocate a now struct kfunc_md_array=
,
we copy the old one to it, and we assign it to kfunc_mds with
rcu_assign_pointer().
And we free the old one. That's all.

We need to protect the md the same as how we protect the trampoline image,
as it is used in the global trampoline from the beginning to the ending.
The rcu_tasks, rcu_task_trace, percpu_ref is used for that purpose. It's
complex, but it is really the same as what we do in bpf_tramp_image_put().
You wrote that part, and I think you understand me :/

For the fexit/modify_return case, percpu_ref will be used in the global
trampoline to protect the md, just like that we do with __bpf_tramp_enter()=
.
When releasing, we will kill the percpu_ref first. Then, we use
rcu_task_trace to ensure the rest of the bpf global trampoline is finished.

Maybe I should split this part (the release of the md) to the next patch(th=
e
bpf global trampoline) to make it easier to understand?

Thanks!
Menglong Dong

