Return-Path: <bpf+bounces-65497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4767BB2444B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C461BC199F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086122EF671;
	Wed, 13 Aug 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U70ShKnN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40132EA48D;
	Wed, 13 Aug 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073641; cv=none; b=fPxMQoI0TaMWWN79VkHx3l6b8M4xXsEOZlOb5vUC75JCqiOCvxSmCYdd+6HgoyHUcT3bNdd1AjRif8Q2SMCshTchWxmq9oM/4iUjLPoBR91wFFqp1vr7ktAcHXI9lNa1AUCWlGTpx2Nu5iZiN4QlsTJlJmBcgqfZTQqidqInkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073641; c=relaxed/simple;
	bh=/qszRlWHvoIufrL5GKpOmzlzy1Jky9JBkVIG7XjN968=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8UQ765LpoSbe36xg/NMVaVWH9nKPEXckSEzOMXiTm7y6LtxOeKUN427UfVXlK1ROT6RHl03xNN+8u+goeQIfZkjSf/x2SejTB1rA6q7/cT3PVNuFQTlH4BV3GFvEJVrRlemRtCOoicEIhWHuZ6SXUIq/TDWetQY3zjhmt7Bqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U70ShKnN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a16e52e54so3016115e9.2;
        Wed, 13 Aug 2025 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755073637; x=1755678437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/DtPY1jzZxWng2JYhBR5D4nrxicC7DCuHQxtcUr3N/M=;
        b=U70ShKnNqD0jbahr0Ybgr9ilZDvKofsvWIaGVRXSlRUjM6EGHaBLrQ1JGGFwm6kf52
         rnccxJfFMH8GBR1fnzkNYEKOAeWXpChy52IRFQ+fSy3XdhX31cZjq4fQ+KjtHYjL71S0
         Gz9CZTjJfPCgG0QLtfW4SY0GcURLuWMblK8cjPneQeyH4lSTKU0Yt4oAttAhbamRN97X
         6IO1oAMR3Y43Frp5kurEfp0/S0DUizY7/g024FKb/dyRyKw/bDsIewXCBaw7VIJCIcry
         is+ZJ0pItuMkMdw6nHBleCs6fGoWycvLTVoQe3HmUxuq+b1x54P5cTgqB46TdRMSW+Tm
         c+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073637; x=1755678437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DtPY1jzZxWng2JYhBR5D4nrxicC7DCuHQxtcUr3N/M=;
        b=el2GEv3W3YyX7OpBSapSOXqtpv+EbnLy5BnfTaXUyN2St6WwYPUMbrKy30fs5LesU2
         duy2lFsr1tvsd8QBLXuOgpsGN4T0SjsCmQfqgkz0tiXherzsHxzvUR3IFxHnHJ+7fhvC
         vCem/KUGhKpIilzoE5csv7y/jzsqkwGxRDVjf0ND+pIwj84oySXRoB+YQAr12rRGfS8x
         9pdCicg5u0SiN4EGI2VhSEBYTf/divHS3mgEVfqnMhN7tlKCP8z8J63eSrUmDzNROW/I
         BCzQZ1gZnuh+anujGbX5MpGkNLTKH/Ur3oJi4404uFTee/eg5LdLsyofqutn22fnwknU
         LguQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGwH8l75WOPsi3suLKbDfrC8LnejXi3nBStmfHB+e2MkJSJ12w0+0L7j1gKAIZGJl2byM=@vger.kernel.org, AJvYcCXn5An0LhwZSG3HoapIFSC+v7LKCOIB64frVNpEJ1sOHAlPgrtSOh8wcPsSS2mJNqp+KVdTTMb0Xy3GG3s7u1H+4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnMPTHfNDtRS/3j+U2xtm4fV4z9ZdLqRiDVtFXBDhsZ5XOKfH
	R7bPC3LVmuVkdSVsiVQZFaQvVQlYAOMA3/E5wuCb1QmayINysGGx3VR5
X-Gm-Gg: ASbGncvbTWecjYw6ewDZ1dBrMZNI5szqkKYvSmSJDr8tKAws/Z0aa55NGs16tKg87Pu
	CVUFPuEW/tP3/zjeRp4lcg9z5xzSX2w15Vlx/M2DfPFZThPFAMKNCuAjmTvc/MUjQuhjeuk7HPA
	0OwJLllr+EfoYTTZ0AqUWop/2ht8nguCIcDolZ20EvjfO9+J2dW7UO61lPOMoHk6FVU31/l8S0O
	w9xfjBrW+PJLuCi/oUS4au1P1Hcr9DibLTNPHNhpbOZgaN4eR0uv3X3LocCRGztylczhZKyzJ1f
	kZuD1R9Mo33Ux+pAfxEZUwFc6wxKGkvQrofz5EgTXc7SRO9DS9Q1G8A6cqb5nCIYFaJOWWAk
X-Google-Smtp-Source: AGHT+IGu3nLYHGtBU4kx2vjSzn0bocNSCnRpLlyhYDDZTduIkjSbcKiqJtoIW4Asj3XRN+QifRXDyA==
X-Received: by 2002:a05:600c:4f45:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45a1665a81bmr15335795e9.29.1755073636803;
        Wed, 13 Aug 2025 01:27:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8ff860acbsm20579120f8f.51.2025.08.13.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:27:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Aug 2025 10:27:14 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Check the helper function is valid in
 get_helper_proto
Message-ID: <aJxMYlqXjVFOX0O4@krava>
References: <20250812221220.581452-1-jolsa@kernel.org>
 <CAEf4BzZBe1BkjJDc858W7rv-Eewk+SAoYKGH3qJYO0DP2H3NBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZBe1BkjJDc858W7rv-Eewk+SAoYKGH3qJYO0DP2H3NBQ@mail.gmail.com>

On Tue, Aug 12, 2025 at 03:32:40PM -0700, Andrii Nakryiko wrote:
> On Tue, Aug 12, 2025 at 3:12 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > From: Jiri Olsa <olsajiri@gmail.com>
> >
> > syzbot reported an verifier bug [1] where the helper func pointer
> > could be NULL due to disabled config option.
> >
> > As Alexei suggested we could check on that in get_helper_proto
> > directly. Excluding tail_call helper from the check, because it
> > is NULL by design and valid in all configs.
> >
> > [1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.com/
> > Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c4f69a9e9af6..5e38489656e2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11344,6 +11344,13 @@ static bool can_elide_value_nullness(enum bpf_map_type type)
> >         }
> >  }
> >
> > +static bool is_valid_proto(const struct bpf_func_proto *fn)
> > +{
> > +       if (fn == &bpf_tail_call_proto)
> > +               return true;
> 
> ugh... what if we set bpf_tail_call_proto's .func to (void *)0xDEADBAD
> or some such and avoid this special casing?

right, that's an option, will change

> 
> > +       return fn && fn->func;
> > +}
> > +
> >  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> >                             const struct bpf_func_proto **ptr)
> >  {
> > @@ -11354,7 +11361,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> >                 return -EINVAL;
> >
> >         *ptr = env->ops->get_func_proto(func_id, env->prog);
> > -       return *ptr ? 0 : -EINVAL;
> 
> so we explicitly do not want WARN/BUG/verifier_bug() if
> !is_valid_proto(), is that right?

yes, I don't think it's verifier bug if option is missing, with this change
we will fail earlier in check_helper_call->get_helper_proto

jirka

> 
> > +       return is_valid_proto(*ptr) ? 0 : -EINVAL;
> >  }
> >
> >  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > --
> > 2.50.1
> >

