Return-Path: <bpf+bounces-31018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16478D6097
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E111C233C2
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0FD157469;
	Fri, 31 May 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3AAlO7s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B015575A
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154719; cv=none; b=T2fG+coRPoHq4kVC0Bxv+NyP2l5JCiacPwmsn1l8kGCRzxHJPzkMBcmXZNV/eWqWqtYH7CMWfrSZhf/5PrR/z5jTXxjLltKhkyirqZPwxzV5bYFh9pAHpD5bFZB4WqkUsrN2tkWpEKh1IaMiHTel127eJNXKAMyhQ888RyEojC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154719; c=relaxed/simple;
	bh=fWUJ437g8evNcSkD9+9GJC+3hqmaNOKkRxKMUblKHT4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMDmJcXFoKYJRXt8uI1EEsVnkyRwRjtHv+GP8yc1D+U7z5fB1o+Zxfaa3hZhoMLBP1docFXveC5fj4g5NwxO6IoZoBcsStdW+48gV4k8y4iFHVHMjvGfb+vemIaYUYSFpM40uZxy+AlzNo/mRQawTfukfsVDiF1SGfN19bdwMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3AAlO7s; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5cec2c2981so100421766b.1
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717154716; x=1717759516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5FVVvSwCCmu0S5jIBqQXKaEjLlRbNlncywpUPqCYDo=;
        b=V3AAlO7suhB0WauyKkjrge6HxKk+l76FQj4k0zeMaQS258V04XbSesVfxoqlfa4ngz
         eqfzT0bsChfVZPOc4DCDNj1+jgbqtzAzCJShPCJtjI8SUlnxg+JXZ7lmGJ0NSXWQd5UM
         OOryfQT4mdk7oQPEgE1WaxYZ9Lb48FpaH2V5LS3Uw28J+CCltNDIRkF9bCHv8rPiVpPH
         jRAi1l5j6dv7KM1zNR0eqNiu9ZTdyLdjpPQjyfDmx/q5zILCO+T7w6qr9z9SMkdjWjtK
         PD0Lo6fUpS0azkOGrOwmpMBG/YQn9LvE81nQjDBQ2w+4C2PhmU2TaVb+MfQbwti4pvRl
         GWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154716; x=1717759516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5FVVvSwCCmu0S5jIBqQXKaEjLlRbNlncywpUPqCYDo=;
        b=klrRR+1ea4K0GEKL7NSEg+rcBWGwAU7xnJDQz4Xlf4qNIFRbExrI83bl3BgGDRvdBI
         78M+Z6JpZfIBLCImkTug0iq7jajay/lMi/UPMntG0pEy5aeoRQBK+Dw8gsg0pRc3j1SC
         wS6a/XjDtaRz+jswgPbuUBHqzMICsaJThsUBKnkkX92CaORPu/ot5Q7q6u+mebFGSOzs
         2Xp3meQGjX5PQbAoojTF9Uvd0Pr74cVj6psRtciDHyLfFOp7geTekC+aqslkvD7t9UhB
         aIbYDR2QGH9IYFWURFrlSnTVwwt1MTHkSbRVbjy534My6SI0U6lcGscaC5LVicV7L9E0
         a46w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7TbHI0XLpdEQsDfgJVQ9iMoqNyeMWQFgFKtcTL0vUxraOTOrWcZEPLcQG6FtEQcKCjXJLh9s+PTLVC7wB1Xm2Yd+
X-Gm-Message-State: AOJu0YyokpNNSU8pf1mBJmX+kQBJbwicbXsdevFlmBZ13zjDmPCh0guM
	MyEw8PMWeQ1Cpf06WucnSkzf9CSKnrc6CQSxV7oVsqkgCDme5RlX
X-Google-Smtp-Source: AGHT+IFOps9iLUZi/wjLlMTJDh9LpDOXYk0yrjE51a6apEq33iXlKezaOKQl1oBVwd8kf1fhHP8hIg==
X-Received: by 2002:a50:8ad0:0:b0:578:57b9:8e13 with SMTP id 4fb4d7f45d1cf-57a36361c9cmr1268115a12.10.1717154716199;
        Fri, 31 May 2024 04:25:16 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d3c3sm902555a12.59.2024.05.31.04.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:25:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 May 2024 13:25:14 +0200
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
Message-ID: <ZlmzmstEQSMp-6_i@krava>
References: <20240531101550.2768801-1-jolsa@kernel.org>
 <20240531103931.p4f3YsBZ@linutronix.de>
 <ZlmpoWed0NmeZblH@krava>
 <20240531104922.ZgOadg-G@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531104922.ZgOadg-G@linutronix.de>

On Fri, May 31, 2024 at 12:49:22PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-05-31 12:42:41 [+0200], Jiri Olsa wrote:
> > On Fri, May 31, 2024 at 12:39:31PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2024-05-31 12:15:50 [+0200], Jiri Olsa wrote:
> > > > The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
> > > > by Sebastian [1].
> > > > 
> > > > Instead of adding more ifdefs, making the session kfuncs globally
> > > > available as suggested by Alexei. It's still allowed only for
> > > > session programs, but it won't fail the build.
> > > 
> > > but this relies on CONFIG_UPROBE_EVENTS=y
> > > What about CONFIG_UPROBE_EVENTS=n?
> > 
> > hum, I can't see that.. also I tested it with CONFIG_UPROBE_EVENTS=n,
> > the CONFIG_UPROBES ifdef is ended right above this code..
> 
> Your patch + v6.10-rc1 + https://breakpoint.cc/config-2024-03-31.xz

ah there's also CONFIG_KPROBE=n

kernel/trace/bpf_trace.c is enabled with CONFIG_BPF_EVENTS,
which has:

        depends on BPF_SYSCALL
        depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS

so I think we chould combine both like below

jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..cb202a289cf6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11124,7 +11124,11 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+#ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_cookie)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
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

