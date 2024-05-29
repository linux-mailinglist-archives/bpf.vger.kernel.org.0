Return-Path: <bpf+bounces-30864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED08D3EED
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802DC1C20C75
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144A199E9E;
	Wed, 29 May 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvSBY69j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383842045
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011271; cv=none; b=IOJQg5NY5bYBXyk+m6q1IOMY9KQnEl5oIUK2IXFZM5A9A5ZEHhHf9beLggi+pr/ImwrbQn840pU/ncfUoGuLqWIt4dPW30TWMdwDeUC5IYQOZwK7dB5oHEyNIWP/EBzZm28tzI8zTuWgdFd04gw7WJTLKkGkKwc90Ph1L2Dxctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011271; c=relaxed/simple;
	bh=ZfIitmtzGwl5VPEaKN/6kNUjbHE/4oSNMSSElo4qmvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSmnIvWAJ6VVfwsxMZXZHJnkwMS2+XdOOR8oO823Yytf5RN0RigXm4NUKc5wNltvtLBxJDALvNqAgB61SytatjTlzTXVFVmbbKYY9ANAxu/mVdsIsMyI1/limVTmkZcEQqY8iWLRGBgA7dYi4CAM8G4AfNZDVY9eYqN+28pEkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvSBY69j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso805635e9.2
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717011268; x=1717616068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxWIGRdqMaUIhQkfS53/FIAQqDlbd1Iee0ROS9pkZW0=;
        b=mvSBY69jR0hLpqTjUwnbkb8oh/eyaxEHgSECUI/Z+p/nvA/y0Jsl5e+mglkUuINnzL
         fImxjveMhRUatrRazUx7y7rUrYvBL3sH6VvF/4OmT3Z8vYaFg2Vii6ycxm8welDoc9jr
         aAFBiJjhbibxyMBztwv5zGFjsSBb+C58hlkWCl2lNo5Yy6Y+4b5IY4CR6ZZe31W1+db8
         6I4AFPTAYHPsslUFxkOkgFmy4JvbHDMlNyjULejZpf4M2HSxQWaQwHwlWOdCspiUPY6g
         CT9O87GCqGkmKSTE+j7zi7TtML9XMdISAgtBHwsea0QLSVmpgSE45W9ljTgeSPo9T/sO
         rbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717011268; x=1717616068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxWIGRdqMaUIhQkfS53/FIAQqDlbd1Iee0ROS9pkZW0=;
        b=D2ZiDy002L+kHM1uL/EJZs8SzdWfWE57fH7sLnD25RRMwQQS9dVBKSJZH6irpP5wCu
         QSkRefct8mY198yJQdcWslR+mkdmJpD1ObO2+FPudMkPI8YDvG8SE/ptvoFt1reY9H9d
         cyJDB0OhbxL9S9ral9Cawr38ErmQZgYroqyPyTt71vz191zufkR1vIK64g5eWA3yFR0b
         FQBBUzwHSAKw/Q+0MHehTtEEnBjt3cSkzzb49Cl6S1RyudcZRiI/VlwVxzuw34Wi3Hvn
         EZ3+cvCgXYURAw/npwtUfG+yliiLum+ljLbDvvOaPXC/rKDPYp8dG5u7dWjzRO4+RseJ
         gajw==
X-Forwarded-Encrypted: i=1; AJvYcCUnOo81dL21Z62Jh5FzIEcc9NQ6Egu5PTTCQ/knIJUKFnrli3jPzGEPmZruxZqN61y8ZhU0vgAnDBOaCX5I+8D9qidX
X-Gm-Message-State: AOJu0YzfZ0/CgGY+glq3rw5TMq7SGiCokdWLdh6ZteL0Lo9/HX0etLcF
	6+d5Pus62eRIMWkFflXzfiyhmEHu1wCX8e1xssj4qOw67bpGvzyn
X-Google-Smtp-Source: AGHT+IHz7pxi2RC/1VdeL1JDDsKX3upcxLL6XfDtLSyz4rGEzHhD4xqDnOSwz/QKTDp10PbHV6AH5Q==
X-Received: by 2002:a05:600c:35c9:b0:418:3eb7:e8c6 with SMTP id 5b1f17b1804b1-421278130d6mr1252475e9.5.1717011268010;
        Wed, 29 May 2024 12:34:28 -0700 (PDT)
Received: from krava ([83.240.61.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852404d8esm8770166a12.47.2024.05.29.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:34:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 May 2024 21:34:25 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] bpf: Use an UNUSED id for bpf_session_cookie without
 FPROBE
Message-ID: <ZleDQSK4TgJLJDUl@krava>
References: <20240529124412.VZAF98oL@linutronix.de>
 <CAADnVQKdAo-=DMMyLJaAR_CHBZq=W=LsYxk=Tna2G+tXLnfLqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKdAo-=DMMyLJaAR_CHBZq=W=LsYxk=Tna2G+tXLnfLqg@mail.gmail.com>

On Wed, May 29, 2024 at 09:18:48AM -0700, Alexei Starovoitov wrote:
> On Wed, May 29, 2024 at 5:44 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > bpf_session_cookie() is only available with CONFIG_FPROBE=y leading to
> > an unresolved symbol otherwise.
> >
> > Use BTF_ID_UNUSED instead of bpf_session_cookie for CONFIG_FPROBE=n.
> >
> > Fixes: 5c919acef8514 ("bpf: Add support for kprobe session cookie")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/bpf/verifier.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 77da1f438becc..436f72bfcb9b9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11124,7 +11124,11 @@ BTF_ID(func, bpf_iter_css_task_new)
> >  #else
> >  BTF_ID_UNUSED
> >  #endif
> > +#ifdef CONFIG_FPROBE
> >  BTF_ID(func, bpf_session_cookie)
> > +#else
> > +BTF_ID_UNUSED
> > +#endif
> 
> Instead of this fix..
> Jiri,
> maybe remove ifdef CONFIG_FPROBE hiding of this kfunc
> in kernel/tace/bpf_trace.c ?
> The less ifdef-s the better. imo

yes, that seems to work

Sebastian, do you want to send it as v2 or should I post it?

thanks,
jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..cc90d56732eb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3519,7 +3519,6 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 }
 #endif /* CONFIG_UPROBES */
 
-#ifdef CONFIG_FPROBE
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void)
@@ -3568,4 +3567,3 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
-#endif

