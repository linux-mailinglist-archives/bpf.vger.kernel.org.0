Return-Path: <bpf+bounces-63293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB86B04DFC
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9425F1AA4876
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E32D0C60;
	Tue, 15 Jul 2025 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPyPEBm8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23418C008;
	Tue, 15 Jul 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547773; cv=none; b=EGJDZGSqmJs6GC8/KZUn6xVoB8LXNqdPjPLMFHPedmXQ0akJfx3NwJXoiR4U7/4FwUtp1pn1p1crlR0V7YWKw1/UVphE17/ruaeyqI0giBN2XBcIG9jyxyWZMkDaEqpeZhVblKtGBW0nl0iP3jg0T+LNjYaM80a6pl0az346H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547773; c=relaxed/simple;
	bh=lH7vw+0VMvidDpIROFoi2w0pI9o4r2LHm7pgBxK2eXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWmkgPoe4ZELpKscK64tgutOoKKXRxjYkQKnpP8dGJHNzVOnIjM15IJobiWLqdiqZwuxkY9pFHrgE63jHmCKd3pnBDqi8ydg0Cyev8QfmPBcp1J/smIVrgq0jjEDCTuNYjhy41tSB3psgo+bdNvi/ndS0kViZxjuItxZ7Cy73qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPyPEBm8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3313242f8f.2;
        Mon, 14 Jul 2025 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547770; x=1753152570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS7yd44npN8Movrab/3mdBNN7fSheGmuxloVE5wvxOY=;
        b=OPyPEBm8NZCsTK/NTR9eOoX5nHiSRhMZtHZvvtBAQyI7Cjabev6HPuNK5OvRl9sFji
         s+UVx1uaVfLocVyU9EUnzINlvk5EVPq0/JgV3d51Oa8jc1J3/Ze5LSLrGFLVt4bkWPXA
         b7TvLHwFubjiIto8HGHQiakyRtx+RReFmrHZepMXOw+ALUljnZEemigkWRfSztaWshNB
         dS3OvA1pGdG0w4pJ0IBUS51R8fVEVxWHMgJXdwnVpqVeuM/OzqX/0CoS8MAYj+JqJNxE
         yMpAW9YE93SWreyWnAJr9txOCLvAARD9XlvWlBdSIJ3+IiGri7C1JXHd7bYn2yeOx61Y
         7vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547770; x=1753152570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS7yd44npN8Movrab/3mdBNN7fSheGmuxloVE5wvxOY=;
        b=V7K7NOJ3nbJBQtZteHjzohwXQp4KDZH1oe2+rrSC/HBcTncXZmJc7KZhxY/fmKgK4r
         CGuYzJS5B6sCcgq6PeUxeiBG8ou+cNzxAptq2m1+phU4u77nkzD8S5usKJaKGBWiIPMD
         FgzVijCq3IQWdSPqXrURWBeZ+J+LOl0q29MCMmonw8T/W95Ytj6QICHjMNsL6gAXDg3d
         9SP3+Z33M89a1mQU6XL1dv5MsRJw4bk2WwgWni1gve7LeFUlTR61SPufzC2J8m975+mv
         1QZNEdrRtWYUGhDAzRui9oFaZ/3feaM75NUqhcqA/sPfvoH4XlYoQ/4E//30buPNK9dp
         EWwA==
X-Forwarded-Encrypted: i=1; AJvYcCWXyd9kUpkOtJKzASFqlQVMGBemhoH2yq79WWkF6q87a+OfcknJLbzglEuzrp7IPrmrn53Z+gQp9MHMEE9j@vger.kernel.org, AJvYcCXF8f6ApNDRv8hn05FMmW1uThQwvcNyY8xar7QaqALFHdlwqWuWe5/FIZi7fCPzWbbvQik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjPePu5k5/oW/GPx+XFmd60VhpeO5vZvF8ArUMQA9AS06xZxy
	bfBpkUGK/2yRZ4jlya/CxDwrX5UTREfv8kqOggaVJ6e+DWazmWCFDuQrrjWwCjBjcIBfin3h7fT
	sYwOa26u1jaEjaRpcyYlC29U6M0oRpHM3nIIF
X-Gm-Gg: ASbGnctC5zG+vj+WkvAwo0u6RfCx6hO/JXY+ozUjBV2bdQhMgxNcWxe4MC+M3LOd9oT
	7+yAma/F6eQhLsMP2rN0J+xqW4xXOdfC+mWcIjBVFSZcer/aDDAV0iMzlrXI6e0TpfWc+SZtc/Y
	rLrxIwg2DUt3FiGJeH4ai1l+Ws2MKf7jdmzMzdJ3Hpn2/8OFXzhSJ/bxb9GCuA8z9SX8orArX3r
	CcyQKJtn/J/g7t3+OswMlxWmcOoekBYT8k85HYC3XyMGko=
X-Google-Smtp-Source: AGHT+IGbyGDdffe3l+nGor0S7uheY0AtOugk3rY5TV63ZpU11ee8MHJj25YN9CZ1nJUJBYKa5mfwb1CyLWHmnAy68RU=
X-Received: by 2002:a05:6000:144b:b0:3b6:4c3:1129 with SMTP id
 ffacd0b85a97d-3b604c31146mr4333246f8f.57.1752547769978; Mon, 14 Jul 2025
 19:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-2-dongml2@chinatelecom.cn> <CAADnVQ+zkS9RMpB70HEtNK1pXuwRZcjgeQjryAY6zfxSQLVV3A@mail.gmail.com>
 <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com>
In-Reply-To: <CADxym3ZGco3_V7w8+ZrJwnPd6nx=YKwYASWcUFOFyLe7L5oa_w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 19:49:18 -0700
X-Gm-Features: Ac12FXxinYffbQpH-r8LzQ5-PpDeASv0EyyyDfXWuJZgfPeqo1VtW1ADJltf5Mw
Message-ID: <CAADnVQJYLSp0X-LiPftaDvU+SnJL84sgGM0M-=uQgq4g8=T=zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:38=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Jul 15, 2025 at 9:55=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > We don't use rhashtable here, as the compiler is not clever enough an=
d it
> > > refused to inline the hash lookup for me, which bring in addition ove=
rhead
> > > in the following BPF global trampoline.
> >
> > That's not good enough justification.
> > rhashtable is used in many performance critical components.
> > You need to figure out what was causing compiler not to inline lookup
> > in your case.
> > Did you make sure that params are constant as I suggested earlier?
> > If 'static inline' wasn't enough, have you tried always_inline ?
>
> Yeah, I'm sure all the params are constant. always_inline works, but I ha=
ve
> to replace the "inline" with "__always_inline" for rhashtable_lookup_fast=
,
> rhashtable_lookup, __rhashtable_lookup, rht_key_get_hash, etc. After that=
,
> everything will be inlined.

That doesn't sound right.
When everything is always_inline the compiler can inline the callback hashf=
n.
Without always inline do use see ht->p.hashfn in the assembly?
If so, the compiler is taking this path:
        if (!__builtin_constant_p(params.key_len))
                hash =3D ht->p.hashfn(key, ht->key_len, hash_rnd);

which is back to const params.

> In fact, I think rhashtable is not good enough in our case, which
> has high performance requirements. With rhashtable, the insn count
> is 35 to finish the hash lookup. With the hash table here, it needs only
> 17 insn, which means the rhashtable introduces ~5% overhead.

I feel you're not using rhashtable correctly.
Try disasm of xdp_unreg_mem_model().
The inlined lookup is quite small.

> We need to protect the md the same as how we protect the trampoline image=
,
> as it is used in the global trampoline from the beginning to the ending.
> The rcu_tasks, rcu_task_trace, percpu_ref is used for that purpose. It's
> complex, but it is really the same as what we do in bpf_tramp_image_put()=
.
> You wrote that part, and I think you understand me :/

Sounds like you copied it without understanding :(
bpf trampoline is dynamic. It can go away and all the complexity
because of that. global trampoline is global.
It never gets freed. It doesn't need any of bpf trampoline complexity.

