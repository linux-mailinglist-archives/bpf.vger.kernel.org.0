Return-Path: <bpf+bounces-41738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEFF99A2CF
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908EE1C22E76
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92721643B;
	Fri, 11 Oct 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn94P2AC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF7192D77;
	Fri, 11 Oct 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646567; cv=none; b=LO+NkO/LExOdsgW5SLOdHFXzS2BdOkTklkR3vy1/QsWgyJrJNmMoz/HSXLI8F3Dz9djjy8e7wa/auctHLAzJcKfQ4fKJijLvQEN1TXVn0KvQqzSRkPsp/gjdipVuuciuNWHkj3+eqPLRyfHhuInirn+rdi4+YNUxCbOTQGLjBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646567; c=relaxed/simple;
	bh=jR0Vg9PH9N6L9ImT5L1RdXJfdBNBhz1led3s5mfYkjw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPabOvlro2Us35abKw7bs+4WDiS8EdwStxj9BopvDhnIDLopYQCuzkUe5ownFw35o3JHG3pnSOsu7FEKVz0jYbhDJUjgMdkhX6QXvL/1PBTlmG7rw6/FXpMceoxZ+Ky3rygf/kYT6iSaRQlXg7S8salS7JdyyRvV2MI1iGoOeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn94P2AC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53993c115cfso2580502e87.2;
        Fri, 11 Oct 2024 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728646564; x=1729251364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4q07ab0/hrOSvlbPoknJ98+QL9ESkKYE7w2H0Us7t8=;
        b=kn94P2ACMeayt0zFRQZYihd49phWPXMkTOo2i1qyZ38ORkyzD0lwGyNP4bI5VFL26Z
         iYLG+yw2CllAsvHNGOXEZBnwlvAt9IWQzywb2ZOo8o+WG7TTg/PblgnuAYousYdKUCo9
         y4Nv+GauLgzzzIxc1s7vUUNmlYFUrNDNL89drgcZI1tY8E7n5NqmJyjKVLm2wFddkr6G
         XVKtsp3DdhCGLSBGUYx0xVvww7kKghwiS0QLDp1QwqQcDQV/jS+IN9AtH7C/SQlsTQ/I
         cvDu2ql4fLbvrF7XE0rDqhe25qr6uOM3hGpc3JCOYc/xsYDBFmZ8g86f9xnDp4GXKx5C
         MGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646564; x=1729251364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4q07ab0/hrOSvlbPoknJ98+QL9ESkKYE7w2H0Us7t8=;
        b=JGcSoBIhJn0h4WO4GfpNkXokhpVwf3IacNfrd8GO+hILC2X3h+rhEtixrxW82D7ERN
         2QIeNxVo1aKZ9iPFJWRKw2j9N5mlMiWTDAgrS8XMnUDBHZNLoOeyB8tOeR/OCVIJVm1V
         j9yZkXhRm6+AgoyeZ3jfujzSQK/xvOoz25pjY6jvcQE/388vnC+db9nt6Y9kTdwBTNDi
         9RhSpSB7vWYafjStmDzdR3C6VYejpiV5owZ5BiRws7C/9/b8atte+EifmzU+4Lcm/UHn
         o8jQL/TpnOEOoWltgoF107xn2Rv+rBNkpuJOFWbcy0tf78iVS2IPHGjAeH/FyJZaIXZW
         3i/g==
X-Forwarded-Encrypted: i=1; AJvYcCUPMKtgIbxy8zKHgrdlMUxk2nbJGRdZnAJJTVh1TcRlZVM8ZQLGhe8XicJQdAth/r8vOSI=@vger.kernel.org, AJvYcCUWYy5K2NilWnDJrWvRqsdyGBQoCzxWTyWU77Ckpoyk/bBbvQ/P1SUOKa8hE09aMf6gNP5dAbQB2tw25Srn@vger.kernel.org, AJvYcCUoZR5wIyDog5KhBbOQlNAz+Ofh4DDck8+SYhRlXnz/JKdSPWOH4ByvUsUVhSZwI4pyO9/k/1J01McXPdFqdTGt30Ll@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEu5Muri+TzTUPLsKd18u7yAOrHH9gNrYC9kpN2W6GI1mXT7K
	KMiy/c8pmCPhoEbylrey8FPAHY+78Oan9RZ2VlFGmrP0WLEfvdxg
X-Google-Smtp-Source: AGHT+IF2wg47CMD6+rr34r3+MOEzbKfRWMYRVrgqxm15OMl0DzC5ZLKTeWmjb24ULmkBJF/Myiscfw==
X-Received: by 2002:a05:6512:3e0d:b0:530:abec:9a23 with SMTP id 2adb3069b0e04-539da3c67c4mr1268592e87.17.1728646563910;
        Fri, 11 Oct 2024 04:36:03 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f696sm72414255e9.5.2024.10.11.04.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:36:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Oct 2024 13:36:01 +0200
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
Subject: Re: [PATCHv6 bpf-next 14/16] selftests/bpf: Scale down uprobe multi
 consumer test
Message-ID: <ZwkNoe0vdym48rd6@krava>
References: <20241010200957.2750179-1-jolsa@kernel.org>
 <20241010200957.2750179-15-jolsa@kernel.org>
 <CAEf4BzZ0gOEdYtA5FdZxT_R3mBGBUrGwpvWaMrVQ2AP=bw1c-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ0gOEdYtA5FdZxT_R3mBGBUrGwpvWaMrVQ2AP=bw1c-w@mail.gmail.com>

On Thu, Oct 10, 2024 at 07:27:47PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 10, 2024 at 1:12 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We have currently 2 uprobes and 2 uretprobes and we are about
> > to add sessions uprobes in following change, which makes the
> > test time unsuitable for CI even with threads.
> >
> > It's enough for the test to have just 1 uprobe and 1 uretprobe.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 57 ++++++++-----------
> >  .../bpf/progs/uprobe_multi_consumers.c        | 16 +-----
> >  2 files changed, 25 insertions(+), 48 deletions(-)
> >
> 
> [...]
> 
> >         /* 'before' is each, we attach uprobe for every set idx */
> > -       for (idx = 0; idx < 4; idx++) {
> > +       for (idx = 0; idx < 1; idx++) {
> >                 if (test_bit(idx, before)) {
> >                         if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
> >                                 goto cleanup;
> > @@ -866,18 +858,18 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
> >         if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
> >                 goto cleanup;
> >
> > -       for (idx = 0; idx < 4; idx++) {
> > +       for (idx = 0; idx < 1; idx++) {
> 
> here and everywhere else, either idx <= 1 or idx < 2, no?

right, it's changed in the next patch that adds session support,
I guess I'll combine them as you suggested in the other email

jirka

> 
> >                 const char *fmt = "BUG";
> >                 __u64 val = 0;
> >
> > -               if (idx < 2) {
> > +               if (idx == 0) {
> >                         /*
> >                          * uprobe entry
> >                          *   +1 if define in 'before'
> >                          */
> >                         if (test_bit(idx, before))
> >                                 val++;
> > -                       fmt = "prog 0/1: uprobe";
> > +                       fmt = "prog 0: uprobe";
> >                 } else {
> >                         /*
> >                          * to trigger uretprobe consumer, the uretprobe needs to be installed,
> 
> [...]

