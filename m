Return-Path: <bpf+bounces-33778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3689264DD
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263A71F23AFA
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB517C7C4;
	Wed,  3 Jul 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV1ak5Tv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EE522F;
	Wed,  3 Jul 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020700; cv=none; b=ZFPk8LnoOk7y5MtGV7nFoZx2N5ZblYx54IAfoHmuC8+QfCc23eKv04JkMrGBJscdf5jdjF9hfMlwFCwcAZlMm7VkhvjiLTZeFiQPxjYk5VOBx+SyFL+jffmi1Ik6qvcLWU/ePdLFb9/z2CNwD9hVea1zJkkXLTIqpI1vnn+HKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020700; c=relaxed/simple;
	bh=W6d779gQlWaYtbc9wFUlOaJBpHXd3o1tMTSodUuObKg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXsXWnjgsnLCglYdxXgALTVGH1TuROWlq6wsmceACyxDsUXtxzA+a1ZgizIP396Gx71Mw8g85rzHSUT5ahGFftfGt7z0XpwP2SYt36NKVg/ueyMTlynIr1NjcVPsfDEcWibp+oaZ1t8LMA+eEiIqveWGu0n7Q0F/DpY8tmDU+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV1ak5Tv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so66433911fa.1;
        Wed, 03 Jul 2024 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720020697; x=1720625497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGl8r8h2GWzUcRtvAkjsagE5Fs/gKmnMGkSQ5k3nUdw=;
        b=OV1ak5TvHZbew0FtvSQmfBJ9ufyyPygUAlzLe3P/6JNShgJohPkAkb+OEz+vNjHQpR
         yhDBsrOgnYLH6XnB79V3vBUI478smQa6veuBoiCth+p2k2Gsw2Qr87FJG3vMDqJxxRk1
         L7npVRMBiBhdW5lHvFtfYWUlcJ3VZdwuZ1ZzK7hncOr8qWMX5soN8n3qm2i/17JwEl3r
         gjeIXaGu2cANxdJ4wfYxYsfwZZESdQqfH4x+ViIgrwtNHO8Ly08daTKIGch+8npqrlUR
         B5yR8bacLtbSv3+3yBPD3MmW37nWyRrgN1S8wLxMTuaky74SRASuhSbjlSNkSdQKU6HL
         v7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720020697; x=1720625497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGl8r8h2GWzUcRtvAkjsagE5Fs/gKmnMGkSQ5k3nUdw=;
        b=AQWS7uWu2EMjd86GscYnGv0DmMaMmg5OCnaOySn4Rtyb+D5gt9wDP2qh179Q1uEDCk
         2586jQ6E2gsWAOoUcoxiXYG0sJwXCFpRkYLfikivLRpL6KQqljCc0T3E5cKZ/1Y7Y6Q7
         dJwKrdOXa1gBv0d9/FoRK8rIepOHuwFPs8DKEaMSMUEY21I0Ire7yLAwMn0S5n1pxI86
         lrCHzvZ2v+aUTJg0UpW/Ms4oXPkE2XPIkmOirDoLVGfyA0A8zHB6x65l9itdl7y/9Zia
         Y9Wkpk/E64N5Az3fNUa1JjGG0NPPoTOzqNcpqRK4k40WR+mfxEgujn2IbX3iifdSRupP
         /FnA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2q8ezuDY9UZlScTAZzzkQaXgCYdv7OuX6B+Jdj6U36Kha34nB6hk8wbsvLvWVIKuprz8jiEt2EUyZNYfwv32KDkfxVRSpknn8YnC1OJmqdeQXxXOyILBEFsWfC+Ugu8qAiuITz8439dPh+YVqsfT+tsslTbkJuzn1ZLXmzksqqt6lVKz
X-Gm-Message-State: AOJu0YztjByMSoK/kZxRXLMe9p4c3FdGENDy9XlHhM+R0v1JG+ECS1tP
	MD8qVOcFhyTI1bahPQiUcVeKhiY00PNNPbwilBXZqTTvC5FKa0us
X-Google-Smtp-Source: AGHT+IEN6ACOKucYGCCELlsOgPL2NGmIpamNDcedLgopqiZwApy/KcRgIey9drUN5OhzEXUMB4f6/w==
X-Received: by 2002:a2e:9a11:0:b0:2ee:89a5:95d4 with SMTP id 38308e7fff4ca-2ee89a596femr5948591fa.6.1720020696997;
        Wed, 03 Jul 2024 08:31:36 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42573c55ff4sm219598615e9.46.2024.07.03.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:31:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 17:31:32 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <ZoVu1MKUZKtPJ7Am@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240702130408.GH11386@noisy.programming.kicks-ass.net>
 <ZoQmkiKwsy41JNt4@krava>
 <CAEf4BzYz-4eeNb1621LugDtm7NFshGJUgPzrVL7p4Wg+mq4Aqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYz-4eeNb1621LugDtm7NFshGJUgPzrVL7p4Wg+mq4Aqg@mail.gmail.com>

On Tue, Jul 02, 2024 at 01:52:38PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 2, 2024 at 9:11 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Jul 02, 2024 at 03:04:08PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:
> > >
> > > > +static void
> > > > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > > > +{
> > > > +   static unsigned int session_id;
> > > > +
> > > > +   if (uc->session) {
> > > > +           uprobe->sessions_cnt++;
> > > > +           uc->session_id = ++session_id ?: ++session_id;
> > > > +   }
> > > > +}
> > >
> > > The way I understand this code, you create a consumer every time you do
> > > uprobe_register() and unregister makes it go away.
> > >
> > > Now, register one, then 4g-1 times register+unregister, then register
> > > again.
> > >
> > > The above seems to then result in two consumers with the same
> > > session_id, which leads to trouble.
> > >
> > > Hmm?
> >
> > ugh true.. will make it u64 :)
> >
> > I think we could store uprobe_consumer pointer+ref in session_consumer,
> > and that would make the unregister path more interesting.. will check
> 
> More interesting how? It's actually a great idea, uprobe_consumer

nah, got confused ;-)

> pointer itself is a unique ID and 64-bit. We can still use lowest bit
> for RC (see my other reply).

I used pointers in the previous version, but then I thought what if the
consumer gets free-ed and new one created (with same address.. maybe not
likely but possible, right?) before the return probe is hit

jirka

