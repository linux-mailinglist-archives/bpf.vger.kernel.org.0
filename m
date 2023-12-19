Return-Path: <bpf+bounces-18269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C77F818366
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67AF1F24E79
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7510101EF;
	Tue, 19 Dec 2023 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7YW4Tak"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4758475
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e3901c2e2so2379256e87.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 00:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702974795; x=1703579595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WjuR2cOSot7LVLVZ63kUM0uCZTgB9PZs0GuW36ctkxU=;
        b=c7YW4TakF1nzLqnKshGuE9RR+EnIpNf+Y4RcjN1oV6cY+noHMRzRrB3fU5c4wCAMtN
         mRmXSqSlI68OJ5PGKB2ZEc7naIsWYmXO7Bu4mSgElKSaoXWs3Nu3gxw/kgKE6gQ83pww
         P/o2P10QCB2JEt1aFfoF7gf5+ywSdvQ1GqOGCSImBhSc4TPrDarL1z5aeydhTjbiOtPx
         Smef9S2MqAFadcabuUvqVTEEZUojYFNRgeWw/lF3eS4bdLW6qqqfNWJc64tQ08gArvoJ
         RfwSTOrejLBS7Yun7QM5Jzt2xthQiC6iTbE2kUpAqK6Hh0WI2oI4iW+07rvxT1gAniXr
         P2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974795; x=1703579595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjuR2cOSot7LVLVZ63kUM0uCZTgB9PZs0GuW36ctkxU=;
        b=MR7vQ3osJxMm3Ju2nxXEHzm5lbS7CddlvJGZHhX37GsRLsNvd7WGcJqtuEFEr702md
         6Y9sfqZt/3yCbYHIfpcdUaSlmOosdcVRNATcKygIKdyo3gjom8sCOl9PUBj6Nvm3mlN7
         b3AAd9WdD7KH1qa5v0HxL2/e/BfOoUL+2LLAIXhPkE7WQxche6U3qpuUMoTNLI2QBOV1
         UEJwhYO6z+PvVJkl0MT5CnogR7ZvUri8TEAn63aRSYEy19CFwcF+9GI/MPpndS+jRBKf
         zkZVV9WAhqPDaSUATJSZpHH7YXJKfsP7YhKzQ7PpjjF8PmVAvdEMrHsUR3sRGW3gb5HM
         DhLA==
X-Gm-Message-State: AOJu0Yy5Kd2lC8jBJkzmUfvReGLMTUIJdWaDlSwDErvQDQzbVZWG0J6f
	fvI5YNSdv6QDbHn9/nFnl8U=
X-Google-Smtp-Source: AGHT+IEWDdPtktfrcifHEXRZ0ECNiYXGNNVn1hA2Ar1OvJC7Op9ua5S8SBJVY8DNwqrpDs2aspFATA==
X-Received: by 2002:a05:6512:3b0d:b0:50e:d18:bd6e with SMTP id f13-20020a0565123b0d00b0050e0d18bd6emr7211361lfv.71.1702974795322;
        Tue, 19 Dec 2023 00:33:15 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q3-20020a5085c3000000b0054ccac03945sm11117389edh.12.2023.12.19.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:33:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Dec 2023 09:33:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Fail uprobe multi link with negative
 offset
Message-ID: <ZYFVSJqB3tiz5ttR@krava>
References: <20231217215538.3361991-1-jolsa@kernel.org>
 <20231217215538.3361991-2-jolsa@kernel.org>
 <CAEf4BzaE7DPtetyE-EBvW_QJcO9vHOAanh7aPWEXemB=J3b_Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaE7DPtetyE-EBvW_QJcO9vHOAanh7aPWEXemB=J3b_Mw@mail.gmail.com>

On Mon, Dec 18, 2023 at 09:56:38AM -0800, Andrii Nakryiko wrote:
> On Sun, Dec 17, 2023 at 1:55 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently the __uprobe_register will return 0 (success) when called with
> > negative offset. The reason is that the call to register_for_each_vma and
> > then build_map_info won't return error for negative offset. They just won't
> > do anything - no matching vma is found so there's no registered breakpoint
> > for the uprobe.
> >
> > I don't think we can change the behaviour of __uprobe_register and fail
> > for negative uprobe offset, because apps might depend on that already.
> >
> > But I think we can still make the change and check for it on bpf multi
> > link syscall level.
> >
> > Also moving the __get_user call and check for the offsets to the top of
> > loop, to fail early without extra __get_user calls for ref_ctr_offset
> > and cookie arrays.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 97c0c49c40a0..492d60e9c480 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3391,15 +3391,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                 goto error_free;
> >
> >         for (i = 0; i < cnt; i++) {
> > -               if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
> > +               if (__get_user(uprobes[i].offset, uoffsets + i)) {
> >                         err = -EFAULT;
> >                         goto error_free;
> >                 }
> > +               if (uprobes[i].offset < 0) {
> > +                       err = -EINVAL;
> > +                       goto error_free;
> > +               }
> 
> I applied this because it does fix the problem, but the whole
> reshuffle of offsets in front of cookies is pointless, because of the
> common for() loop. You are saving one or two __get_user() calls before
> failing.
> 
> If we really want to do validation first, reading offsets should be in
> its own for loop, then uref_ctr_offsets in its own, and then cookies
> in its own loop as well. That way we read and validate the entire
> array before reading another array. Please consider a follow up, if
> you think it's important enough.

ok, thanks

jirka

> 
> 
> >                 if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
> >                         err = -EFAULT;
> >                         goto error_free;
> >                 }
> > -               if (__get_user(uprobes[i].offset, uoffsets + i)) {
> > +               if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
> >                         err = -EFAULT;
> >                         goto error_free;
> >                 }
> > --
> > 2.43.0
> >

