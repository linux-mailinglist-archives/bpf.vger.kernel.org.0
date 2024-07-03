Return-Path: <bpf+bounces-33788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B39266E7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1673D1C21CCD
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F5185094;
	Wed,  3 Jul 2024 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf3MRJo0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6918C05;
	Wed,  3 Jul 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026982; cv=none; b=LkPbfo3uHnW5Cx803c+syeTuMnApb4XJuoiiKgLvc/dxAJHeEoOhhKh8kPacdnBy/FTkXT/VnmjzsynwDJivPeAPkaaJ+jjl37XuuFPnixfe1e7gpKmziAPxeRWmbjG45qJCtAN7uMs+xMddVGbGNxZXepFK3Z1lHLFWoakRpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026982; c=relaxed/simple;
	bh=GpCQ9s99vtysxYyflh4+5pib1ndqx7HCeTQvstu6KoY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg3nRFIB+X6P9B/Un+4mP8I2+p/zF/l9aIdbpt/7CPttgWP2N9LHbObG2rIt8/bEhUr4SDWfqvX1Hb5xANaW2liqRfNPtzt2Dz+il0d31qvQAEQIMC7w95zF7lRXQIzJZZYoss0+gOJasnottaT+OKLFGzjuD29Mv28ks+dF7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf3MRJo0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe785b234so59099481fa.1;
        Wed, 03 Jul 2024 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026978; x=1720631778; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGn/Lf+szICu3QdxchnIP0hAuEbZz0rx6SpOAaLzgoQ=;
        b=Lf3MRJo0JEFsMVgufgrqfm2308b9x/Ge0o72pSlYMM/a6iMa7UuxFfBzWQN+ylgr52
         9SCZCjkmFZkFN217AJiuxz08/EPiyvd4s6CF8nzgtqTFEaobVcCuuD2BuLpzJeSmXu/e
         MrlzbFdth4ORcnJ5ZIGom2gkZRwo5GRf6CXaAD3BlPhCwHnkXSqFXEMYDUBH9/M9405Y
         lIFxU4XtsOTFBaPAfYVzcd5uXQ6U3dhkIgoN0KSr4pcRw452R6rF/yUYtwni7r+fGpmE
         zTPMH+fuyVHTjyuwpSIeQHP7lQzUeyjlU+GbFB/uS/wdKSeVMmVxtq4n8mC2C6cpP03O
         tbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026978; x=1720631778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGn/Lf+szICu3QdxchnIP0hAuEbZz0rx6SpOAaLzgoQ=;
        b=hRHvrJ711KHKTWSj9psBMfp4/pSEl5JqMjkmsHFFh08cuUPmK4isa4PAFGlduG+IAA
         NZRqpTL0K+X3CcIUFRX7jX37oxt0I4X+gND7tHqhIT/DEqZFg5ude+b6wKLssomOpNMw
         SVZQJOWW7gw+9vZ6oxG+EvoOs+CF1k1MlfVasLmz2GV8kYw0tzo88As83ptvhnc1AaID
         tbcFX3rPThvGBKF8NXJM8abc8Vhqk1SWx5gtcQpcu9XpYJ17ucYLKKJiSRxM68Rbpwhm
         1klO/f/g9dfKpn3bADsO3yypy6hNbrs/8Pvc6ORpGTL/pES58cPCaQ3BrxuNWH2/LYxb
         9t1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfk9QnUkC57GeR13qpBu/jYJw/CaMY09ZroFQbNawcrvn4wrCwsCzyorNHNh0kEWMjZkYR3YOWxFER48EnNiGXFi11sX57rB2F3SHlD2QfsI/MsXVAA0uBngcaPX2fh9wJx++fL8GW/7itGCdXgB42Gc5r8eye4OrC0EPVvU3XWVKGjX8t
X-Gm-Message-State: AOJu0YxcprHCvmD6dpuP3T4c//14iRnkAXQgdwQ1yGKQKyOR+L881tkI
	3tiv0AtTD4V/ODhwbDtuCsPqHydEfoty3wpPH5PmdG5QTDq9Z+1p
X-Google-Smtp-Source: AGHT+IEade44h+o9MJx+aimlmTczVWUE6ZE0Y8eiROFH+1TtIAO8fcvWhZz31VKjR7nG46JS2X33qg==
X-Received: by 2002:a05:651c:1551:b0:2ee:80b2:1ea2 with SMTP id 38308e7fff4ca-2ee80b225c9mr26926531fa.40.1720026978363;
        Wed, 03 Jul 2024 10:16:18 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm246046165e9.32.2024.07.03.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:16:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 19:16:12 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCHv2 bpf-next 8/9] selftests/bpf: Add uprobe session
 recursive test
Message-ID: <ZoWHXERaW8jgaJD_@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-9-jolsa@kernel.org>
 <CAEf4BzYRPVHQyi-gU3C8B8J93tRe8T47dXi+0iYYw81Wen_uvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYRPVHQyi-gU3C8B8J93tRe8T47dXi+0iYYw81Wen_uvg@mail.gmail.com>

On Tue, Jul 02, 2024 at 03:01:35PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 9:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe session test that verifies the cookie value is stored
> > properly when single uprobe-ed function is executed recursively.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 57 +++++++++++++++++++
> >  .../progs/uprobe_multi_session_recursive.c    | 44 ++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
> >
> 
> Nice!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> [...]
> 
> > +static void test_session_recursive_skel_api(void)
> > +{
> > +       struct uprobe_multi_session_recursive *skel = NULL;
> > +       int i, err;
> > +
> > +       skel = uprobe_multi_session_recursive__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_recursive__open_and_load"))
> > +               goto cleanup;
> > +
> > +       skel->bss->pid = getpid();
> > +
> > +       err = uprobe_multi_session_recursive__attach(skel);
> > +       if (!ASSERT_OK(err, "uprobe_multi_session_recursive__attach"))
> > +               goto cleanup;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(skel->bss->test_uprobe_cookie_entry); i++)
> > +               skel->bss->test_uprobe_cookie_entry[i] = i + 1;
> > +
> > +       uprobe_session_recursive(5);
> > +
> > +       /*
> 
> nit: unnecessary empty comment line

ok

jirka

> 
> > +        *                                         entry uprobe:
> > +        * uprobe_session_recursive(5) {             *cookie = 1, return 0
> > +        *   uprobe_session_recursive(4) {           *cookie = 2, return 1
> > +        *     uprobe_session_recursive(3) {         *cookie = 3, return 0
> > +        *       uprobe_session_recursive(2) {       *cookie = 4, return 1
> > +        *         uprobe_session_recursive(1) {     *cookie = 5, return 0
> > +        *           uprobe_session_recursive(0) {   *cookie = 6, return 1
> > +        *                                          return uprobe:
> > +        *           } i = 0                          not executed
> > +        *         } i = 1                            test_uprobe_cookie_return[0] = 5
> > +        *       } i = 2                              not executed
> > +        *     } i = 3                                test_uprobe_cookie_return[1] = 3
> > +        *   } i = 4                                  not executed
> > +        * } i = 5                                    test_uprobe_cookie_return[2] = 1
> > +        */
> > +
> 
> [...]

