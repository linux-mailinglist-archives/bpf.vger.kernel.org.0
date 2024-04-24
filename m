Return-Path: <bpf+bounces-27669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E198B0882
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C5E288723
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C71E480;
	Wed, 24 Apr 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkINtDUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2415A4B2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959027; cv=none; b=UK617b2lPVoGb6j4WUGOFO1bZK9C/rg1OB9MiZUkKDmmdCfsnRzOgiYZ0DTdf53uX2E+x84JbR/ckEYvPmqo3u4B7f+aF+75tTyDHAD8E8CoFiTnWY7Ae3k6nr52yp1Fh6OMVAt7AYFAskVYeH7jY0OqjllK6A0LsPleH7HRYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959027; c=relaxed/simple;
	bh=SQe3H0hh9ibcj9kbEcsrU+NTg4WTTUSbRrTDw2PA1JU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMLgyQ6BYvxH5AKdMiP37ePgJVJMwHA+a3INT901EvnBdZIZuFWlVE6DPhWphWY6JM8EQKeA6COCsOvdrMsIFEoREpKTYNeFmR1xLrGUiY4+KR4Cb4NNDwaRs12KEvksYzNvfcxOoKMV+4NiNiPWM+yPBwDHJnCmUDKC4OgUUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkINtDUs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5894c1d954so22575466b.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959024; x=1714563824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h4Q2pM64u51jWGYDeX1dWVNmKmFwqU5DnhoCw0JzcOM=;
        b=nkINtDUs2mTkIfAEPImsG7zfQf4/hvzrWJeqj/5H3dos2AafZ8z0xvPlJLkj2EHrQo
         wD9BS9hXmQIudqMuM0kO/v40RkbWWRpB9iyhJincHoqfWrKgPb7UJh5iS0vEJo6ahvSE
         mHuBVCjmI5NeDc5S/excpztBR6jYAAQunTlZHI7SEbSeFgCBwN4/DZZOdCBhmA5EfTTf
         1Rnq4epJexyZ8s866/j3N6VLqI/n+AuxJhnvbXprpO/fUNwc+H/rILgH2hx25oT3u9IV
         5ErgV6bWx+xDsnXijrkimw8wP8EVVA/H0S04AqvSpOAFBA+tIK4S/ajuovwJYRo4q/4W
         VPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959024; x=1714563824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Q2pM64u51jWGYDeX1dWVNmKmFwqU5DnhoCw0JzcOM=;
        b=UhnCsQm6uj1vV9vn3kLJGZ14+2s+KLyoZqV6oiSSKIVe3KJ5uTmXE1LnYapBgZHnZD
         jokKwz/TO8oges0kzhg8cOMN1Y02q+Yy/ZnPfdcFElPz49lYxOHtl7OOeKipPnvVl5c6
         l+XLOXny7mXfC6h07DHivQQGAry98dkCm7upqAd9aXe6tmgexa0Uwf39kH4NZgPB4UXd
         jZ8MJciT6y/8z9869X4zZsmlLSnRnuxYov8jgW729SbHPitjegrbMWioviXyfaZPsHl0
         S9tg6Zxse1kj1cSZtfRd+eASfPGuwogaxQ7vHQVTUTu+NTb6UJG54seOMWtbtMX++VxB
         ahZw==
X-Forwarded-Encrypted: i=1; AJvYcCXo25rRMHRERx33734rzbTJKh6DoWK6BspnVwA/AywQk9OFDVmoxZ02Xi+ScBZnph+AG5RhpksKG9uhu5HMKpCr2x7Z
X-Gm-Message-State: AOJu0YxWodwN2ID2CGOjXzc91+xHlrbNl07GfxqMqnMtGXffKb9qLMSw
	j6VWxoWdqa4sZMK0V2pO/MKLEGIs28BjSHgmJ5Ekq0o1Ki+ArPek
X-Google-Smtp-Source: AGHT+IEIv093J702vaKhApzY9juv3/PJtMFPQvlgCp6LOGoDEqPoq2TFd/SLftoGm97krvK+fN4ACQ==
X-Received: by 2002:a50:d718:0:b0:56e:10d3:85e3 with SMTP id t24-20020a50d718000000b0056e10d385e3mr1763532edi.13.1713959023812;
        Wed, 24 Apr 2024 04:43:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d3-20020a50f683000000b0056e59d747b0sm8122613edn.40.2024.04.24.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:43:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:43:41 +0200
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 0/7] bpf: Introduce kprobe_multi session attach
Message-ID: <ZijwbSFR9E_IkbcF@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <CAEf4BzbAjGcrqLi4+rjU5JALHPF5CjAww4fexassr3vWe4FaZw@mail.gmail.com>
 <662894a735565_61405208b7@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <662894a735565_61405208b7@john.notmuch>

On Tue, Apr 23, 2024 at 10:12:07PM -0700, John Fastabend wrote:
> Andrii Nakryiko wrote:
> > On Mon, Apr 22, 2024 at 5:12 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > adding support to attach kprobe program through kprobe_multi link
> > > in a session mode, which means:
> > >   - program is attached to both function entry and return
> > >   - entry program can decided if the return program gets executed
> > >   - entry program can share u64 cookie value with return program
> > >
> > > The initial RFC for this was posted in [0] and later discussed more
> > > and which ended up with the session idea [1]
> > >
> > > Having entry together with return probe for given function is common
> > > use case for tetragon, bpftrace and most likely for others.
> > >
> > > At the moment if we want both entry and return probe to execute bpf
> > > program we need to create two (entry and return probe) links. The link
> > > for return probe creates extra entry probe to setup the return probe.
> > > The extra entry probe execution could be omitted if we had a way to
> > > use just single link for both entry and exit probe.
> > >
> > > In addition the possibility to control the return program execution
> > > and sharing data within entry and return probe allows for other use
> > > cases.
> > >
> > > Changes from last RFC version [1]:
> > >   - changed wrapper name to session
> > >   - changed flag to adding new attach type for session:
> > >       BPF_TRACE_KPROBE_MULTI_SESSION
> > >     it's more convenient wrt filtering on kfuncs setup and seems
> > >     to make more sense alltogether
> > >   - renamed bpf_kprobe_multi_is_return to bpf_session_is_return
> > >   - added bpf_session_cookie kfunc, which actually already works
> > >     on current fprobe implementation (not just fprobe-on-fgraph)
> > >     and it provides the shared data between entry/return probes [Andrii]
> > >
> > >     we could actually make the cookie size configurable.. thoughts?
> > >     (it's 8 bytes atm)
> > >
> > 
> > Attach cookie is fixed at 8 bytes and that works pretty well. I think
> > beyond 8 bytes there is no clearly "right" size. A common case would
> > be to capture arguments in kprobe to handle in kretprobe, and there
> > you might need at least 40+ bytes, which seems wasteful. So I want to
> > say that it's probably good to hard-code it to just 8 bytes (enough to
> > store timestamp and you can even fit in some flags if you reduce
> > timestamp precision from nanoseconds to microseconds), or use it as an
> > index into array or some other data structure.
> > 
> > let's keep it simple?
> 
> +1 for keeping it simple. Use it as a key if you need more.

ok, it's true then it'd be tricky wrt verifier being able to check
the proper size and it does work with attach cookie so far

jirka

