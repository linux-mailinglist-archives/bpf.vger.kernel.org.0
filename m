Return-Path: <bpf+bounces-52567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76311A44AB1
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF216C71A
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAC198831;
	Tue, 25 Feb 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcUpqPht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B418DB3F
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508788; cv=none; b=EL4EyGaycwJUlamlyDexQLlFhMrw47BlcKd1Ltd157Qs6FjR82aHbZyifJ6CK9VRS65jZEfm600vTSeMXoTjCC4HlR64rGXn9fpHy+RZOhDxt2qOccB5mNV2+lbgIrqFAuqTUaaUx+C9vb37KsQIpUCX6y4c0Y4Nsy0Kz8JXYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508788; c=relaxed/simple;
	bh=XRReKA+k2SXdffrztygbiQ7OICeS15lfpOAzcHoaRW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyLfCLSAUUobM1Zz4QvzV2WtnVbDoXI3rSRii36Yhvm5mGxqC0rQ31T5BbLLJCkVVlbn7Zoeq49GgF5z/F2Bo++dsv8JxOTKx/LTkG8J4T2IZhhwLnlkpKeB4zJV0UG4M+aj6gBUwkFRhZ1IOm/8p1Pgo+r+r5/4jxArUAXCyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcUpqPht; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so3553493f8f.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508785; x=1741113585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYqa1+wcqNSXEbPyPwibRsEKzR32TvJUpCBy/bf53lc=;
        b=UcUpqPhtA2bMCZj6L0se3Y37TTL4YJ3xY++crcRyqJTNQ9YnKcAAaGW+dggFUbzFCV
         UpaEzTZ5o4qV/n6n5DUsIQ6z8sPir/44ya+SQTiidCobabgnDYqbxXg3kogeQIWkzwxK
         BwFXlqgeOFiKcjpNazyH1leH9Hto8eS3T/9pgqRpUbdSVf9j/pMaanrNkZ8OTwkU5g8p
         ie7Ye9bH2zBzfZpymw1pRaggOiC+hzGF83bbyQO76N4NK+s2kAFkKOZKVk3fCdxd2Ose
         XuRtM7yUpgskLfmvkhdQ2dW8PebQ5Kex/Jj0ahag8rSCysvEl6j9Rfwhcr414wsGxM+1
         uLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508785; x=1741113585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYqa1+wcqNSXEbPyPwibRsEKzR32TvJUpCBy/bf53lc=;
        b=N+par8zGEZGp1iah8J4JYXSXoLyE46wSQVDDTlQIBXAgk5t67lQaIdFdKxYJcmaPRE
         603pOkXnmOyvibbdJrxQCY64811X82l6owckmMu6T7ZFKB+rMHzQPjhDrrDnZAVFZhiP
         2/tuz1ORVBgh2xmRnw1JQ1TRYjBbNRlRlkpkZstxG+tGPeK44alyCuTar/yjBmnbc94C
         vjWjOJca/Qt1N5xvquNuqi8Tv+C8GZ0EKA4bO2/t2uJxbu1WJH5RjC8x2u55qoEnxldQ
         zd3QaXp0qXk/u3k3+/OLJMYjx/q7gspLiKpAfvQGXU8pCCQICx5hRQboSXcMU+y/UI27
         zXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQYEzWH6ubO+xLO6kqKQ1peMoRH7tWh9+ZYjroggYRqNHzAy6mgjxtgBFSkq8lvg3mKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5JATyt74zLZ2yYH4GM9osYxhFLZoH2rHDnZFGyf4vtVhhKJh
	7ug+a628C9uZdz3wo4BP660TlF6VRpq98/GJoMitM6S+GGMM86jvtDHxGMGK54lvUdsrhFG7Xwc
	J5jmS4IS1/lpRB94t0bCi8lxJnBA=
X-Gm-Gg: ASbGncuQIO2qAvcDY9I5a0bH8d0PvZWrbU/gZK+vAGxxn9tuVzzxQ8YaJ+S2NZT6Kyo
	rc7RXbTgtgwcjCujMVss8Cx3FZAS7Wcjg1m3A5LZCWTGyuASyVBTfAGz+YvVib6uAN4OK7sx+tg
	vLskt2/MNDf0gTxiGrhxEMse4=
X-Google-Smtp-Source: AGHT+IHPILCkYLPOC97ZeiA2HC/0g0GlziaqQOwvBXy1rsBdXD/VOZwjHzMI5l5iqCnYibojrODQOGhd+Dee3Uumo8o=
X-Received: by 2002:adf:f744:0:b0:38f:32ac:7e70 with SMTP id
 ffacd0b85a97d-390cc638c19mr2903482f8f.49.1740508785073; Tue, 25 Feb 2025
 10:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114606.3500-1-laoar.shao@gmail.com> <20250224114606.3500-2-laoar.shao@gmail.com>
 <CAADnVQKUYP8e_u5QWGHK_fi_LKyOO3voFkHyRLCuw9-qKiFmDQ@mail.gmail.com> <CALOAHbCM_9NotV3UqeOiK-s_Cd-HAUS+1L834Di1Pw75iyTCOA@mail.gmail.com>
In-Reply-To: <CALOAHbCM_9NotV3UqeOiK-s_Cd-HAUS+1L834Di1Pw75iyTCOA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 10:39:31 -0800
X-Gm-Features: AQ5f1JoE8BAeWH30pVhmmX58K_lDAhdJCx6ELrnvWIY6JObEuHJqhrO24YwS4Lg
Message-ID: <CAADnVQK12yzwC=10yxoYUs02iCpkH+tZe881Dnc2_8j3cxsFdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated
 with __noreturn
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 3:46=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT =
&&
> > > +                  btf_id_set_contains(&fexit_deny, btf_id)) {
> > > +               verbose(env, "Attaching fexit to __noreturn functions=
 is rejected.\n");
> > > +               return -EINVAL;
> >
> > Just realized that this needs to include
> > prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN
> > since it's doing __bpf_tramp_enter() too.
>
> I will add it.
>
> >
> > Also the list must only contain existing functions.
> > Otherwise there are plenty of build warns:
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol xen_start_kernel
> > WARN: resolve_btfids: unresolved symbol xen_cpu_bringup_again
> > WARN: resolve_btfids: unresolved symbol usercopy_abort
> > WARN: resolve_btfids: unresolved symbol snp_abort
> > WARN: resolve_btfids: unresolved symbol sev_es_terminate
> > WARN: resolve_btfids: unresolved symbol rust_helper_BUG
> > ...
>
> I missed these warnings.
> It looks like we need to add "#ifdef XXXX" to each function.
> Alternatively, could we just compare the function name with
> prog->aux->attach_func_name instead?

Strings are much less efficient than btf_ids.
Especially comparing across many strings.
To minimize ifdef-s lets remove all functions that bpf cannot
attach anyway (that are not in available_filter_functions).
Then drop all that call panic/BUG equivalent,
since refcnt on trampoline is irrelevant at that point.
That will remove even more functions.
At the end the list will be short with few ifdef-s.
This is a temporary workaround anyway, so let's not get too creative.

