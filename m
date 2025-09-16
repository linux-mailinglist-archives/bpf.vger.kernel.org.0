Return-Path: <bpf+bounces-68566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379BB7E876
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19244189184A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773442BE053;
	Tue, 16 Sep 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R68aJfKz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914132BEFEE
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062545; cv=none; b=RMkhtwcVdzB+e5FVS8sGSgjILLqwLmFkTFrtv0RJXIJeQZz9Ono7egBWA9+3IMF1nMCKX7/Z2xAHgQ+VYnPz2rwgJvFXg1YcRKT2Cj9PYf6ENS7F1Yo08Mxzz4z+/dkcF0cBU8oHEGK2b72aQbqoBJq0BD2sdBgIDFKSjogBesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062545; c=relaxed/simple;
	bh=haldCVuvjO2lqBVr9ZGuUD05ifs7dMo0m4Gcyj8Dfew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+oi/cIMTnAt3zK8BOxLDtvT1jYPAEwVdwGnYI0asu7wt2+HHn84VeHe4G8B9lBwJApQqs47xNDqIKksTL1gznAEKZ+w31gk6v20sSl7mpiwevXN9BqSzhfV0nYqjaVsFGv//viSoe8ZqJ8HMM9JbaBWlAjt33jY22cBOrQwUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R68aJfKz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77b91ed5546so365798b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758062543; x=1758667343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NeqLuLjCCjLncW/lSedt5sAbSbFXOMNawocV0CX+MjA=;
        b=R68aJfKzjOmHnSPC6/9Y8KXyHJ1gxvf62vDGJk/g0CnuzuMNSrU5KLx6pDRLPSQF/k
         XMlAiBK6465GBE8FANRzjFcgJeYXwlevgNzBcKnPU3G27CehhpjoSAvLjLoqeODdkifd
         MedML3Q6RR8tdgh0bitXKo7DhRhMm+cNbXn1jrzuInWyViVP2QWGlNmJ5T62K5MgKqWO
         vZvyP/hIu+vKUaJ4hEWXlHKCB3vhTLLSUCCPWKB4SLgv0xDGrH8eWTbi8g8DcylufltP
         AI3kFOBmE5cSyZriJKIW2k+mVWjq6aOdbCPXE46nPFzvfRfcDgG8W956rlBYu+plkL2A
         RbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062543; x=1758667343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NeqLuLjCCjLncW/lSedt5sAbSbFXOMNawocV0CX+MjA=;
        b=ZUeMxL3yA630lyUWNpsM0yp7hU+pTYFEYdTb/bcEpg+nzBi4E65N8dt3BKT3qI3ylh
         H8uuFeKUKNlnRxx0roNgv3s6N7in5FjjHTfuiXiunyt6dcIs8nNE4W2C7QDXamXtz87T
         EIltepHX7Z+uUoZ2jJDjGHA5iSe2Er6AbRqvmJAIOw/SIC/6V6PYnwybJOdgTfScY8qs
         9pm0JIrLRzkUZvGxfaK37ZswDKJxH5gYwY0uFDvNlZLTUMUma/3ldhQOmYxiEn4M0g+O
         FFk9Tvq+YSBySo7RUpUNmOyfJKY+RjvG6gm4QufbWAiwP1sAcjT+7tKmSDCcRtJJzs7u
         J9tA==
X-Gm-Message-State: AOJu0Yx1TYHukziHvMS4gv4/A1zWiQgzlOpuLpZqmFb5jKS2If68kbu3
	0mEHQvtWijnH95+5qpNBJLrtRGpkM2FuLkMsZeaIXFEi7rcj1+lxSKgl
X-Gm-Gg: ASbGnctGCTgtynzy/ZeSKFwS046Nuqd54oixzZRntQIg1pnT0R2biQMgJXBRC/C90i1
	++Ms1sywWUwVys8EmQEXcSdDiCjET70N9+ONWH3TPV8acKCjaTBIhyyVvtnfjV0RLobi+V1WnOF
	Vze907KTXH6mqgcDvAmpLcz3I5tH4Kopb8xzw6q2wpk3KpEqSDcEBz6Uol1jnPvmVPn17lmQZef
	zMuPsF1/2tpEpYSf5PerjWraf862B3UEpm4zfiupigcKPqZ5GwuK/fLsKFkY7hd5IufEFS+G/aB
	MV7RVQO7Yi7Y4t0EwP4frJjyv79URH5xn0audGpK05SmV5kJl+q0a5EGgTWdAinWeXUKFzZh39u
	psJd+IqFKEj/qcYEfCWUaPdgHMbRV3rAKEOFVXCk5eaaisw==
X-Google-Smtp-Source: AGHT+IHpd/QUDBL2DUkqQZQTfOlohd0ZHJEPgQVMM0SpSpyMtHM31XfZpJoE3GjgJdEyVno7TuBz4Q==
X-Received: by 2002:a05:6a00:1790:b0:772:7c7e:cc27 with SMTP id d2e1a72fcca58-7761209bd95mr18665338b3a.5.1758062542761;
        Tue, 16 Sep 2025 15:42:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47d7fsm17291236b3a.31.2025.09.16.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:42:22 -0700 (PDT)
Message-ID: <e011fbe6e1e715243b9d1166d7a125036cbb6b9b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: dont report verifier bug for
 missing bpf_scc_visit on speculative path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 
	syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Date: Tue, 16 Sep 2025 15:42:20 -0700
In-Reply-To: <CAEf4BzYJW+O6CD5+V1wP3uF0=BBVNLrUwM+co7Pps8HF13p3Ng@mail.gmail.com>
References: <20250916212251.3490455-1-eddyz87@gmail.com>
	 <CAEf4BzYJW+O6CD5+V1wP3uF0=BBVNLrUwM+co7Pps8HF13p3Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 15:33 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -1950,9 +1950,24 @@ static int maybe_exit_scc(struct bpf_verifier_en=
v *env, struct bpf_verifier_stat
> >                 return 0;
> >         visit =3D scc_visit_lookup(env, callchain);
> >         if (!visit) {
> > -               verifier_bug(env, "scc exit: no visit info for call cha=
in %s",
> > -                            format_callchain(env, callchain));
> > -               return -EFAULT;
> > +               /*
> > +                * If path traversal stops inside an SCC, corresponding=
 bpf_scc_visit
> > +                * must exist for non-speculative paths. For non-specul=
ative paths
> > +                * traversal stops when:
> > +                * a. Verification error is found, maybe_exit_scc() is =
not called.
> > +                * b. Top level BPF_EXIT is reached. Top level BPF_EXIT=
 is not a member
> > +                *    of any SCC.
> > +                * c. A checkpoint is reached and matched. Checkpoints =
are created by
> > +                *    is_state_visited(), which calls maybe_enter_scc()=
, which allocates
> > +                *    bpf_scc_visit instances for checkpoints within SC=
Cs.
> > +                * (c) is the only case that can reach this point.
> > +                */
> > +               if (!st->speculative) {
>=20
> grumpy nit:
>=20
> if (st->speculative)
>     return 0;
>=20
> ... leave the rest untouched ...
>=20
> ?

I did this on purpose.  In the comment above I explain why the error
is valid only for non-speculative path, so want to have code and
comment in sync. Tried inverting the comment to explain why it's not
an error on a speculative path and it is confusing.

>=20
> > +                       verifier_bug(env, "scc exit: no visit info for =
call chain %s",
> > +                                    format_callchain(env, callchain));
> > +                       return -EFAULT;
> > +               }
> > +               return 0;
> >         }
> >         if (visit->entry_state !=3D st)
> >                 return 0;
> > --
> > 2.51.0
> >=20

