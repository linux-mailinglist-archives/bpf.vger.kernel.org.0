Return-Path: <bpf+bounces-65613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E63B25D94
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13444A01263
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCC27056F;
	Thu, 14 Aug 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/ghJujO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BB259C83;
	Thu, 14 Aug 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156595; cv=none; b=snR8PcrI9j8hVghNxugUf+odvGsyVpAyK87t8t8/cQ1Xo4RTWZ8W4q6bs5CgELvCPu7KUNlJ23pREBKT0y+hzdy21TFtuu3Apj4XKEpjOWKakbn38rVL3XNP2AIhWDg0xXemeL6OOj4P8qtSzBWXkM4qp9lvbNYUagHEx1MmZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156595; c=relaxed/simple;
	bh=oM6L1awDO+Lf57PCSA9Rcd+I1nhhHpKmAlBQd3oE3+M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2RlS5waNxS4qd7tc4KKy1MjzpRU1ecTDAGw8A5lvXFHvH4ByAN/Zv86R/77YntvcwFW9/IpZKzPSO+DAVp80E0UwS0/8Ws0IKPrl7JZ5GSstJXltgdS2ME1kaStjjL1cegFxFFt1UCWoDrIO+RB6AAbQOrcyDEUkHtRKSBwNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/ghJujO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so4108425e9.2;
        Thu, 14 Aug 2025 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755156592; x=1755761392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24gvThZQt+PamVqiUu8cvhUP7JYjfzx9v3glHOB07iY=;
        b=P/ghJujOKor+PDI/zr1PrF0Qq3lphaFj0VIOFfRUSeh05vJneGjDLA7wUf06s57c4o
         rval9LkVDkw4NRgtXWplhck3kpYNM+/ScDgu8sGT/F3U0AzX54p5cLQxZe2y63befVE4
         JcvDFRHlzo7yJmfwpl0dfk3HM1+m2vbpAkD14YxmsRz0QGWOeuTY/qCSvThYyVwERinJ
         0sL4h/xqTHm9pI3bVroGAniGJLWRntuxnd7aKcbxegu5Irt9jlgVhpXWzXH7QwhG+GB1
         m2doo50zRTV/kecwlHJMlfrhoV5oaaX8chn2Biyb9zhPAnYDJB8Rb4zZ/mc+dzty9xwQ
         um5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156592; x=1755761392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24gvThZQt+PamVqiUu8cvhUP7JYjfzx9v3glHOB07iY=;
        b=Sav7NiED9FGanKEzuaeJWHzKIQ4jH7cdX8m0NNMLycyxv8zH5zJTcQrTWZ0/ZTw52R
         nUGnkCnzS2WTkG9uf2vEluHQQPVya4CBHYRonNZ/hCGR51ti8wKOoAovX8sisTgUphuK
         iaPPeFr5iYA4R6tU8PdcRnZZ/cZLfZL25gyMYzgwlLHkM9VDeH95qGZ/sxs3YakWatsT
         3XyRqFl0trzCGLB+aFT3FM988OkUXujDKvoJmiJKIMQlgdbkO48usT1a46Jsai0bifYY
         KiH4LUdbWqN75TsnGxTnfod2WpP1kBVK40vvTB3UflqDtieL7yS/uNsdirS8i9ekyRST
         S5oA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ354hU01ro9d2kPJgSwgFtunCTEMZj+T1GhKqBlVCjTQRocMFlyljH+dtIoyn5one0i8=@vger.kernel.org, AJvYcCVKS9HHB8O8WTf8YQIxwBQEyj8laG26TdmfhQZry3BONUV08oiqxef/DJyX4A6dGiLPBB2VFbz9wGKQX/RnLS4YAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlRYYOVGnpMz4igIelVX+B6YraRBmVrkMahuoGLimXNKEucHz
	v3puiJsAJDEyj1GH7Eqebiy7lWLuDsgL9+UAUI/kry18YYJOtK8IZhjv
X-Gm-Gg: ASbGncuXTUx/A6tjapDihlwpbQ9/l5cIUcOZHKtEPyDceXAv2y9sHGfqBbye9jjlGhn
	jzJ3x51C7NQZfLODSnuyXubdsfUUS1hMNvIeXeWrcyfQaSlr77fDNQ63waq+in6iyTPQTZo1/U+
	sLkFOhY0F9p3IXdZSSuFi6laiJaNDUAy8JmPc2kF+ekucmJtof8Uw134kRmHASaacB3QZl8Ysfs
	DTzXLFY90BZoSVeRX/qJLpVpbvP+9U0tCxuaN9VfMH4AtcfMuP38StjD1qWGAEIG2/I+UvAZ4lw
	8G2GcEk7Myb+OjRl1O4EuA5BHIUA6AvfB8eOPbbWS/iaXlrNX/M/z3hAIaj3P9lCXsm8tbyG
X-Google-Smtp-Source: AGHT+IGioMdTbm/AhBeerR621r/r7v7TtoF5CYistIG4M3xaicdlU/CKMsk9fitA7Oc7ZeaW3HkOrw==
X-Received: by 2002:a05:600c:35d3:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45a1b677897mr10942805e9.29.1755156591559;
        Thu, 14 Aug 2025 00:29:51 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e336csm10675405e9.16.2025.08.14.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:29:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Aug 2025 09:29:49 +0200
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
Subject: Re: [PATCHv2 bpf] bpf: Check the helper function is valid in
 get_helper_proto
Message-ID: <aJ2Qbe1J1eNKbbxZ@krava>
References: <20250813133832.755428-1-jolsa@kernel.org>
 <CAEf4BzbRL47Qm1T1BQrvG6K3itqFHfSdXbOeFG5vKj4yB0QtbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbRL47Qm1T1BQrvG6K3itqFHfSdXbOeFG5vKj4yB0QtbA@mail.gmail.com>

On Wed, Aug 13, 2025 at 03:44:43PM -0700, Andrii Nakryiko wrote:
> On Wed, Aug 13, 2025 at 6:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> > v2 changes:
> > - set bpf_tail_call_proto.func to -1 so we can skip the extra check [Andrii]
> >
> >  kernel/bpf/core.c     | 5 ++++-
> >  kernel/bpf/verifier.c | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5d1650af899d..0f6e9a3d9960 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -3024,7 +3024,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
> >
> >  /* Always built-in helper functions. */
> >  const struct bpf_func_proto bpf_tail_call_proto = {
> > -       .func           = NULL,
> > +       /* func is unused for tail_call, we set it to pass the
> > +        * get_helper_proto check
> > +        */
> > +       .func           = (void *) 1,
> 
> we seem to have BPF_PTR_POISON in include/linux/poison.h, let's use
> that instead of 1?

ah I did not know about this macro, thanks

jirka


> 
> pw-bot: cr
> 
> 
> >         .gpl_only       = false,
> >         .ret_type       = RET_VOID,
> >         .arg1_type      = ARG_PTR_TO_CTX,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c4f69a9e9af6..c89e2b1bc644 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11354,7 +11354,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> >                 return -EINVAL;
> >
> >         *ptr = env->ops->get_func_proto(func_id, env->prog);
> > -       return *ptr ? 0 : -EINVAL;
> > +       return *ptr && (*ptr)->func ? 0 : -EINVAL;
> >  }
> >
> >  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > --
> > 2.50.1
> >

