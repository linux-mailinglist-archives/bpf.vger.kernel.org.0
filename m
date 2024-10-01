Return-Path: <bpf+bounces-40662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6D98BD4A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B5C1C239F6
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0991C331E;
	Tue,  1 Oct 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyAnF3QE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6736C;
	Tue,  1 Oct 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788680; cv=none; b=C6RI6xD7rn/4FqYK+oXo00uEfveXFT2MGZM/Stg1ieh3lKHxJhNj8Z1Kmzut4f8ApDpfyhJdrcONlA7hAqo+9NCCx8TXoFAK1VUxUkmpKQhN72/qSTQW7CmNgQ8TfTlfhXWLQxas7rAwecuM7mQmNDmqWVcWsvOHvXMXXCFbjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788680; c=relaxed/simple;
	bh=3Lnn3b6a+bzqrtqcNgvMyynEZGV5TpMOK4C3Mg04p4A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtrxlflLU+njCyb6bad0HYPe82AKCAK0xs5DsbAfs6oz3RzxwBhYi5XZvCAUPLvbFppY30NrAwL7key9WTcDvYxlCx0TVQaLxnYDnN9MqNdHS0IimScKQtGeuXfVCQ+5pRkl35dNQv4h8HyV7Dxf/eJOOIrbqcjWwNdhTMidAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyAnF3QE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so48912275e9.1;
        Tue, 01 Oct 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788676; x=1728393476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwI1wizLZFtR98Oh3Ppbe4a5eSbOCCyeGQ6mFq0NpZE=;
        b=hyAnF3QEu8Hi2RXki0w4lJNy0SdOxG2WuzUbtgZb8I45IQ2ZKesGm8iB3PJ7W0GsMd
         SYhbVRLLf7dahkqxbImyhiVMxphqU2WtqsFH07wJk10ZbUkDavJ6s2om332kogpVeTDz
         hWAZtn79GzyS5O+gkOSAnRXhIasNMBhNDYUJoBsdrD1j4G9qDxt+nikf3sR0oJTg2Nff
         EVUDb1+rgbIo8apZzPdEFtzdiEVQ/AhCtdoJd/xA0SlF5E3bQs9wVO1M5gg7ppVzCYPg
         a/89ULwA01sl75jreMsCOIeMIAsrYDPDoJvEv5zgOMGJElYiSglB8w/GwDZkVQbXlbG9
         1C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788676; x=1728393476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwI1wizLZFtR98Oh3Ppbe4a5eSbOCCyeGQ6mFq0NpZE=;
        b=pAidUOXJT5+wKdb67hfXkcTnVqv9BelHOpU7GNI6MsxUs9Z5Hgim1P55e7jU6+ak23
         fHM9skvSAdskKpoZ1c8FCl/noRtl9dWa+loruumBQC8uw70/xCIh6zOy/uCG99X6iago
         oeM/vGacVe/c4awkOaK0YtcqsiBU+IeiEutLLRWWdhHjLfhyLXJ+LeFj80mcmyEZBi/1
         TrJ8cKcS/rCaYBEYqzQ8UgZQaPtdleDTjAQV7aHEJF0QrpUzf4qjapHMOd3GhbEDJWsB
         16BrGE4WjK+ApzUctg7CnAHNm8ivWBjr3AhDVyrq0eVeHpDYCfuq0ZkJMWmXsBZRtxCQ
         OWrw==
X-Forwarded-Encrypted: i=1; AJvYcCUdWE8BlIyKL3WQSHH02qKt6Hd7vfJtp0hPi7w6mPidR4UHCcyTy2ue345k8JO0wWC3Ff4=@vger.kernel.org, AJvYcCVL4F1MnNqQeHBQS+TU1qVmm3Q6IO8dWK1h2+z6JP2FJt2OEpw89kMcOm6kb7HO29wXjDPo0QckQcFFKq5m@vger.kernel.org, AJvYcCXrp94Pb67bm9pTYfLqe4/XP0lASiS7+vQUTjwsJmW1j4p9HfMTybiZfso0w2+/U2xS4+Tt3jQR/UdxiGG7Cv/3AQsh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Mok3HY3umJzOgbL0kg+1CJUwx+ovvIR1vUZMBrPdG809sXcJ
	4kuZpMxHdmma8FKrfkKBItDDJOTKALFrcBsy+9Ypu5AD7PdhO8ul
X-Google-Smtp-Source: AGHT+IFwi0dx5JiwybOjr5yPPX550bJD1pQIMiHPwmkt4VRuxSwJaQxwpU/Nn16PMv0HWboipc7tkw==
X-Received: by 2002:a05:600c:1912:b0:42c:a905:9384 with SMTP id 5b1f17b1804b1-42f58441468mr112681265e9.20.1727788675954;
        Tue, 01 Oct 2024 06:17:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e2ffa1sm130873315e9.41.2024.10.01.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:17:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Oct 2024 15:17:53 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 03/13] bpf: Add support for uprobe multi
 session attach
Message-ID: <Zvv2gciCj-0mAnat@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-4-jolsa@kernel.org>
 <CAEf4BzZfy1H2O-uY3x9X7ScsJTXHgqjZkcP7A0tMmhmvubF-nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZfy1H2O-uY3x9X7ScsJTXHgqjZkcP7A0tMmhmvubF-nw@mail.gmail.com>

On Mon, Sep 30, 2024 at 02:36:08PM -0700, Andrii Nakryiko wrote:

SNIP

> >  struct bpf_uprobe_multi_link {
> > @@ -3248,9 +3260,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> >                           __u64 *data)
> >  {
> >         struct bpf_uprobe *uprobe;
> > +       int ret;
> >
> >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > +       ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > +       if (uprobe->session)
> > +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> > +       return ret;
> 
> isn't this a bug that BPF program can return arbitrary value here and,
> e.g., request uprobe unregistration?
> 
> Let's return 0, unless uprobe->session? (it would be good to move that
> into a separate patch with Fixes)

yea there's no use case for uprobe multi user, so let's return
0 as you suggest

> 
> >  }
> >
> >  static int
> > @@ -3260,6 +3276,12 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
> >         struct bpf_uprobe *uprobe;
> >
> >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > +       /*
> > +        * There's chance we could get called with NULL data if we registered uprobe
> > +        * after it hit entry but before it hit return probe, just ignore it.
> > +        */
> > +       if (uprobe->session && !data)
> > +               return 0;
> 
> why can't handle_uretprobe_chain() do this check instead? We know when
> we are dealing with session uprobe/uretprobe, so we can filter out
> these spurious calls, no?

right, now that we decide session based on presence of both callbacks
we have that info in here handle_uretprobe_chain.. but let's still check
it for sanity and warn? like

        if (WARN_ON_ONCE(uprobe->session && !data))
                return 0;

jirka

