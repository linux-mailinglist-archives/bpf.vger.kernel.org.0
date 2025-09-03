Return-Path: <bpf+bounces-67252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BDB41544
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 08:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E12A1A80E6C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47F2D7DF8;
	Wed,  3 Sep 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeYXdPqv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9A1F4C85;
	Wed,  3 Sep 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881352; cv=none; b=S6ohQDj3HHuPKxwOP1MjEMnX5Oa9VWMwAhAr3N5VXc0vsjciSQrVj4IARIHY2i886OFud7dfgMXCVVClgP0jDGltgTSHx6XB5Uny+7e788UtRsflo3/MwLS4sms9VLem4ISguulLN8iu+k9XEBfRS1BEZcoYXURGpZITRwZ5I10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881352; c=relaxed/simple;
	bh=VKDDUFkjSE9CGEFhn34XiIXcmBotIjb0JeBdb9kfin8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm4HbYa0lw7V1jEU6KpkXJUimCLFTZA96aWVYbdVPV6gYwiyN5FO7cCKvHAAOTfs6nj0E3996yp9CPr+PhEwjLMWpyTTo0HV9o1tkIF+DJbt526B2CL3iqXeij6RCWNBOGsE7auPuQL9/bG0aTvLnJH3eVcRb2cArNSkRbNBDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeYXdPqv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b042cc39551so427951066b.0;
        Tue, 02 Sep 2025 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756881349; x=1757486149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvfdvwn4MWwVzT27s1je2c1Mwv/CXN5VinreI+VRApk=;
        b=MeYXdPqvFRe9R99kkbyL5Q3Laww4Jc81+e2P1wf4kXORm4L6AyW1gju2v5PQTPlLtj
         BHm2+xW2uWbOcWRNpxFRwaEBiUwCHzegGdQpegxFI8pSGFknxluXgFhXU8O/KzSpKObT
         fW9I88qE6OkuqyZFDXMrDW97ZuRAH8A75KSlmF85v6QGoTFl5IIfAt//AzPVz+Qo4FJ/
         ds4a0rtPT/Zh49iKTfqaq4N0AHkJYMStdjEMDnmHZl85zoN6jEx4xYDY5/oYfLOw33jP
         hEYqfiPPtGz29VvDNa5ZkH1EWfxKnSLF3VOUE84YWNYLbJBj1vvBgl6S2Ve8dFC7gyRa
         T4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881349; x=1757486149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvfdvwn4MWwVzT27s1je2c1Mwv/CXN5VinreI+VRApk=;
        b=YP6DdRDAOS5K+vvwjBNOw7ImVBPDVNJLDNL/N5dW2VUBWfE+ryTgG57XmncHIdBBzz
         Rup75c1KBqNPs6Bd06Pgl5/a9dI8dNMnPqdiaN8SuPXnwcXL8AUEEwQ6cqYeWgeWEsQg
         CrMg5n4XXIsXFv1qKoE1n4acdRMTA/9qVksqYpK3TMvwDpreQeyAtIOwdkLPSHloRceg
         GkdGgZWmB3Rk1kfqw03++lYrZPeE4ohsnLbSmP1IzN5a6EPxotAO2PYD1Oy/yk8tLu9a
         ol41pGT+g/V9NTzVnmD68qVyGjuZZfUXYPfyw43iWdwCl9PKOfC5lDtkz/qO9xMaPxo9
         gJeg==
X-Forwarded-Encrypted: i=1; AJvYcCUsvwLf8nt17Jknr+PemmyhsIBHpI6rlBdsTka5YWwHxULCcYcG6PvdrAPak8FLHzzaCxk=@vger.kernel.org, AJvYcCV4JZISUQGlXe+oZIv12CcWM9G62QQ6BYvRvrBoB6wdKPCAZoTxCcoJMeVIkhsi12XsrITHaPRzYY+BaiNt@vger.kernel.org, AJvYcCX8xIVuf+iTRxg5b0UmkEO4xiaHCmZGgqZjek2P6aVcuTA8Xh/KL79Si0/x0OqTWyZRMf0ugkx13gRKnjfP7hVU/3Th@vger.kernel.org
X-Gm-Message-State: AOJu0YynaUVlmHdhjGUXxWGbY1m43qRvqb7/HumiO8WQlUt4idyJwfu9
	KHe2Io/JBWqNoHC0prxAlQrCM9o6FYVMFRJdkg2Q5YF6iiPM8tzUEk1A
X-Gm-Gg: ASbGncu5aoRZyJmfVKOMRjcGTlH1TTpLvdVSP3GZXf5KeBU7aQDkqdCfapZH05q44dN
	4G6siIAcT7dctKlCCvK6KwGPMa9omXijWnH1o8MbsYgfyLQt81ZlLpfC8q3wTtkHY19zvcGfKAh
	BY1tPGSfSXfKwtORut3g45ZfjF98Ul+UbmU82JjsdMSkutKA+ErwAum/GOHtozdEavGBy2Xy6f1
	4AtFGYSxAsEa8bcyNS3S+6bbNe4evOyEpapGKoPKSuJXq39/pGkn7xiJm9Zuo+Soxtte2l/iwcC
	qrn7D0AEdb4mdjKeU57PC52JClnX+s/6kOXqbeYqYjL2m3G0RbvGD5Bf3Vdja9kBy35L3kl/zHX
	37SxIqRsxWU8=
X-Google-Smtp-Source: AGHT+IEsmH7PS5Q8+fV1xMANfVu1IKygSzSEpa29HzvqOZCHGyvxHTeDnYLarY3pFEHip3EMrASMOA==
X-Received: by 2002:a17:907:86a7:b0:b04:48b5:6e9e with SMTP id a640c23a62f3a-b0448b59eafmr643967966b.10.1756881348838;
        Tue, 02 Sep 2025 23:35:48 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff15fccad1sm1105780566b.108.2025.09.02.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:35:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 08:35:46 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 04/11] bpf: Add support to attach uprobe_multi
 unique uprobe
Message-ID: <aLfhwmf7lkIYQvBt@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-5-jolsa@kernel.org>
 <CAADnVQ+MntzHdwSe_Oqe7CU=E3yjko=7+9GTnapsPWwe4oqpsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+MntzHdwSe_Oqe7CU=E3yjko=7+9GTnapsPWwe4oqpsw@mail.gmail.com>

On Tue, Sep 02, 2025 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 2, 2025 at 7:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach unique uprobe through uprobe multi link
> > interface.
> >
> > Adding new BPF_F_UPROBE_MULTI_UNIQUE flag that denotes the unique
> > uprobe creation.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 3 ++-
> >  kernel/trace/bpf_trace.c       | 4 +++-
> >  tools/include/uapi/linux/bpf.h | 3 ++-
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 233de8677382..3de9eb469fe2 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1300,7 +1300,8 @@ enum {
> >   * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> >   */
> >  enum {
> > -       BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
> > +       BPF_F_UPROBE_MULTI_RETURN = (1U << 0),
> > +       BPF_F_UPROBE_MULTI_UNIQUE = (1U << 1),
> 
> I second Masami's point. "exclusive" name fits better.
> And once you use that name the "multi_exclusive"
> part will not make sense.
> How can an exclusive user of the uprobe be "multi" at the same time?
> Like attaching to multiple uprobes and modifying regsiters
> in all of them? Is it practical ?

we can still attach single uprobe with uprobe_multi,
but for more uprobes it's probably not practical

> It till attach single uprobe with eels to me BPF_F_UPROBE_EXCLUSIVE should be targeting
> one specific uprobe.

do you mean to force single uprobe with this flag?

I understood 'BPF_F_UPROBE_MULTI_' flag prefix more as indication what link
it belongs to, but I'm ok with BPF_F_UPROBE_EXCLUSIVE

thanks,
jirka

