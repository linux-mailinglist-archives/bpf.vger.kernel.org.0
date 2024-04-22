Return-Path: <bpf+bounces-27480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C108AD62D
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF6C1C215B2
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503161BC58;
	Mon, 22 Apr 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIC0Sjcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDB1BDC4
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819348; cv=none; b=X+rEI5OkqTq/+ShYnG6jxSL3YE/epB/Rn9rbw95nahT1nNjd4AV+gH9seukfFmVv2+SyfLWT8b6eP4bn3aUnU1TtxvbzMxQViYgenMmxdsKsi8pQ0V06VNa36UxElFdCGmmPlgivfv9vjAL/SM81URo5CStLmRCe6jYqDE53BG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819348; c=relaxed/simple;
	bh=lQag+mwHQ3ZYRt9XZzQkfRj70ukrJzzFRdWzfTvkxj8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRKPMi+QhM0RbyIQx2/YW8+iuFmwi3eanXHoos9mPMbkfguV9RHK9e4PYamxL0iFJG4EvR7B4u3phiVraolj3gDe/JgupTgowCYyT3boU+m2AfmXcXSVvbafms/GAle73zRROjeru6sAeH0LM7Ib6QYxv0IFRwiHa4SBbGmW7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIC0Sjcr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-417f5268b12so51044565e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713819344; x=1714424144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atImVZ9CmYUE6yfYyj80y14TqFwtqmHcIxvZB/wanWg=;
        b=RIC0SjcrsC5tD3M25i4ry2tsiYXzaq6ittQR0YgSHcta4ncbCVGNLkYTgCdhHftmZr
         jWQ5OFBFeAeSvDqAPIrlJK1jh3J3yPvm+28nWoN9dyacSdMYOxnQVe/yjsR7URa6zIlw
         u3l1FV8L9avxSuLrV6mGLBOD7R9MRXfExCc4jgeoZ91g58b3aTaqrxEwayS2zNlq7UZH
         h5YWPUqLgYK4OF/iAQ4XxBEf4H7rBTxkQ44jfiyl1KcGBMexCyKUfY+RgRrzkLKnrHjS
         pEFtUhDmA1vcMLKrM3j9Ddw2hRmVs9QLjmWZZRdpvM1ZeE/QVxLQWR3fzK9jlG3biUrW
         dzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819344; x=1714424144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atImVZ9CmYUE6yfYyj80y14TqFwtqmHcIxvZB/wanWg=;
        b=MqWoqLkIcSMNG797CW3A8ON9GT2lInuSk5yAZGqYIFczHCkSMo4gBi2nKEV9u+C4Oy
         7zgAPCZt1piIcSaAGVa66NuOLXSi6ouGTNBLvev5gLnnJbwVtcvSMSH2+jZlvsWQalAk
         Nb0NcjEnFqcAB/MNBImyStXxpRsZR3/HHKmKPOcd/KYo0IzOmWgSiiQeq8q1Y1UNlJa8
         5tVI4aaWILB8uinGumT7Zdk5OJJIgfGTlXisqOlLN+/ISilUaOQLucpyN71yDMQc8DZO
         nu1+SssguKytTiEMAPO9D3lB2SqYdOa6CHOXIbtNT0ODqpCfK8w6J/iYIQsyXZ/gbp6I
         xGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFmTBPOGxaHKytXmTXQ27eUzAmRdvk+egLEJL+eGXvcB9Dc1z4DmxYX35hs7VKkNdfAVnAQhAJe8eDwUhnL0xnFWcU
X-Gm-Message-State: AOJu0YwrIUVOl0Md2SwQOk1K3SJ8BSxGfbKoJmtAw4/LyW7YeRmGDcAR
	C/lfyrogJl03X64HZDw+7RRC4Fi7VhHcchzniQzC8e/BEEeRHjY5
X-Google-Smtp-Source: AGHT+IHFUwDJq7tLalKX0CoEQniH/GUO/ZJZR9PLppXJyLR7+JDP6gl+vlQLvYpEkN3X9B1/VecKIQ==
X-Received: by 2002:a05:600c:458e:b0:41a:9c24:8d7 with SMTP id r14-20020a05600c458e00b0041a9c2408d7mr1370831wmo.30.1713819344327;
        Mon, 22 Apr 2024 13:55:44 -0700 (PDT)
Received: from krava ([83.240.62.18])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b0041a5b68ea32sm4613262wmb.27.2024.04.22.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:55:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Apr 2024 22:55:40 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add support for kprobe multi session
 cookie
Message-ID: <ZibOzFKa0Ndpek4w@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-4-jolsa@kernel.org>
 <CAADnVQLAgVgf__rxd+C_RO1+ELEKOcLP5eN3V9QGWkpBvUT59g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLAgVgf__rxd+C_RO1+ELEKOcLP5eN3V9QGWkpBvUT59g@mail.gmail.com>

On Mon, Apr 22, 2024 at 10:48:25AM -0700, Alexei Starovoitov wrote:
> On Mon, Apr 22, 2024 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for cookie within the session of kprobe multi
> > entry and return program.
> >
> > The session cookie is u64 value and can be retrieved be new
> > kfunc bpf_session_cookie, which returns pointer to the cookie
> > value. The bpf program can use the pointer to store (on entry)
> > and load (on return) the value.
> >
> > The cookie value is implemented via fprobe feature that allows
> > to share values between entry and return ftrace fprobe callbacks.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/verifier.c    |  7 +++++++
> >  kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 68cfd6fc6ad4..baaca451aebc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10987,6 +10987,7 @@ enum special_kfunc_type {
> >         KF_bpf_percpu_obj_drop_impl,
> >         KF_bpf_throw,
> >         KF_bpf_iter_css_task_new,
> > +       KF_bpf_session_cookie,
> >  };
> >
> >  BTF_SET_START(special_kfunc_set)
> > @@ -11013,6 +11014,7 @@ BTF_ID(func, bpf_throw)
> >  #ifdef CONFIG_CGROUPS
> >  BTF_ID(func, bpf_iter_css_task_new)
> >  #endif
> > +BTF_ID(func, bpf_session_cookie)
> >  BTF_SET_END(special_kfunc_set)
> >
> >  BTF_ID_LIST(special_kfunc_list)
> > @@ -11043,6 +11045,7 @@ BTF_ID(func, bpf_iter_css_task_new)
> >  #else
> >  BTF_ID_UNUSED
> >  #endif
> > +BTF_ID(func, bpf_session_cookie)
> >
> >  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> >  {
> > @@ -12409,6 +12412,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                                  * because packet slices are not refcounted (see
> >                                  * dynptr_type_refcounted)
> >                                  */
> > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
> > +                               mark_reg_known_zero(env, regs, BPF_REG_0);
> > +                               regs[BPF_REG_0].type = PTR_TO_MEM;
> > +                               regs[BPF_REG_0].mem_size = sizeof(u64);
> 
> Are you sure you need this?
> 
> } else if (!__btf_type_is_struct(ptr_type)) {
> 
> block should have handled it automatically.

yes, but only as read-only memory and we need the bpf program to be able to write
to it

I'll double check that, but AFAICS we can't set r0_size/!r0_rdonly before we reach
that if block, because bpf_session_cookie has no arguments

jirka

> 
> > +__bpf_kfunc __u64 *bpf_session_cookie(void)
> > +{
> 
> ...

