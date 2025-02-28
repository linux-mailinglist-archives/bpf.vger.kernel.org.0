Return-Path: <bpf+bounces-52839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E0A48EB3
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FABC188C12F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959213213E;
	Fri, 28 Feb 2025 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO1oQo0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815333F9C5;
	Fri, 28 Feb 2025 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710327; cv=none; b=GYLJNA2fUvvKwZ23ZtvkJzq51yYp+xjejhfQ4Zy90SJjKWk/Yq3X99ybv5HYsaErAQ3wFuP01XdYS1LdwnB0UhdOkuMnrjrgmz7+sNrq98aIoj2MNX70vgGbqnPyEcvNdY4TkjditIIZuCnkOgCvcqryGKV53NsdKJ89FkUNicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710327; c=relaxed/simple;
	bh=wTl+6suWfVWNjI2QDtKlaLtgW+3UnSdIn2Bvqd3KqzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFgxb3lRZvHN9Jowt5o2H/QqkH2py7hR4CnHSFxzAHSYieL/fCofi2i+/6CeZPC/O8vj1bDxra6euyNa1yzqqaPMmcAaeqJ2FJiA8zK7BprMK+EMWpDvNdJK0x5rwoud96qq9pIc+REWIXDTWLOwdpsSMJZybtdcS6ev3bdlRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO1oQo0w; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f6475f747so784163f8f.3;
        Thu, 27 Feb 2025 18:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740710324; x=1741315124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoBqsBD3ysLcM4e3KRNWw21mQNnLhpprTefQSLdSqQY=;
        b=AO1oQo0wfKIX3JrTGdtaoTWBUYO4Xq/yhJUkSSz+flECjmslzGX7I3lOEaiMafJhaR
         /IDsf2HiFcBBEvt3JY0mUwi8KadchvlFxxkLRxPvKx2vxGPwyDQ0hxCVEOohSwpujf0J
         ECiPliJJqOB+y6bmfQ6iCgHtISghKN9nuArBMgAXSPzI5YH8NhG9sGhvR4MvSNLRMv4H
         Yxkn4oaqbZcMv/l6ZIzjP5b+3RUeSxbohdCWQXitYkdcYS3CDf33IELHRxKCFUtwD/5w
         imbIrf6Bu31PGyozoNCIGZIJQkiHI9KdR0agdlQexdRkYIXYsPEznvUsWmGdNIHVN4uF
         yNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710324; x=1741315124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoBqsBD3ysLcM4e3KRNWw21mQNnLhpprTefQSLdSqQY=;
        b=Gd4+iDp5tUhkZEMcbzzMRa2pLb4vcDBoW+VdwPWp+vEcNn+8qlMUTI/voyjkP+Io2w
         6LY/CuojfPpgz2kyNSy2NUE3noqySQP7oQtv1xzXytJ1aLaL2y+Dg1YaYvF/uCUBu0/h
         F77c9TYIl6ACgKsZXSei04fyCaeGrE8Lvg+o6XII1iKauZLDRGUG2u399eLPzOQpwmC9
         y9JAb5zSl8rbighX4LA4rLK5g657FHCoovVxX2YtP0QnqCKlyseVa4CWzDHj4K1E46sk
         mbItUeMQ5jx9MBWYr1uu8V5q80zzz5RJHmwPWCm3S5DK7wFD2NVvGCq6JyOam191Btyz
         /icg==
X-Forwarded-Encrypted: i=1; AJvYcCVNuAoOEL3TRg9qPiWE/uycdSgb/VzfyrOeQW3PevV42YXUX2t/kxo1wSNvQCX/GrX9kNU=@vger.kernel.org, AJvYcCX+T7jYhDa5fZtMXoqB9efgyZLhxNK3Q//7opfny6Xcgy3IhizH7KzsCAM89/xrNa41Eyy+chUwO6K1xxoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmrbK2qFPaEJnXjSB4MYcvsO0Z6rhX9BkeAF0ARpBmVI/t+TN
	f+cWwD9hYruTAE9kTzPguOCD+RkqiHi3xwccLdw380/nI+BbDEBOxGW9eXwx5/gL41+xjQPChjY
	OSgEEw+Gxs3PntbsgCLDj8KYq5yo=
X-Gm-Gg: ASbGncuSvXWtaIw0mMdG2YX+SQ+SwqvH7QknlCaG0Dok/WTvWDs7TsX2HoGQ5p8yAYL
	BWY5sQveDeQweBLW9e7QMAbvUXt2waYPPZljPzXZEDt2jJlCf6DTY+Pu/rZxgM4k40HRbV6dlhG
	6MvOh4gtS61SZG057Dx1PjlkAfucVo56QzhTN9PBw=
X-Google-Smtp-Source: AGHT+IHHUVN8pdOLxPiHueTU0QLajCkPg25IcTRmNfN13XZ3nQFOqe3EiK/BvDtPzD7FNCGs9sWOqXCxNOLyezYVOn0=
X-Received: by 2002:a5d:6c63:0:b0:38d:cbc2:29f6 with SMTP id
 ffacd0b85a97d-390ec7ccfa9mr1056754f8f.17.1740710323747; Thu, 27 Feb 2025
 18:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org> <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 18:38:32 -0800
X-Gm-Features: AQ5f1Jp8U-Bmf7p8ZlWNM4BemWGGrzKJMXHZIaLw2Adsg_t2xas0lQsBC715yCw
Message-ID: <CAADnVQK1bekF9XH7EHCciXeyiB_W_jXBO9+tJoL17X0YtmGjng@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:23=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> >> +static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bp=
f_prog *prog, u32 kfunc_id)
> >> +{
> >> +    u32 moff, flags;
> >> +
> >> +    if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, k=
func_id))
> >> +            return 0;
> >> +
> >> +    if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL &&
> >> +        btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> >> +            return 0;
> >
> > Not from this change but these can probably be allowed from TRACING too=
.
> >
>
> Not sure if it is safe to make these kfuncs available in TRACING.
> If Alexei sees this email, could you please leave a comment?

Hold on, you want to enable all of scx_kfunc_ids_unlocked[] set
to all of TRACING ? What is the use case ?
Maybe it's safe, but without in-depth analysis we shouldn't.
Currently sched-ext allows scx_kfunc_set_any[] for tracing.
I would stick to that in this patch set.

