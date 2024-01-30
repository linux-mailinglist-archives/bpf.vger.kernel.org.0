Return-Path: <bpf+bounces-20693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AEF841F62
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D241C22E0B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A0605C7;
	Tue, 30 Jan 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKhiHydm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683A5BAFC
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606765; cv=none; b=hIy7vh1ITecUpNkrAwKFyO8vnGwXBuKi+PJnn87k7hCVjz4QI2Bit0ulJrlQBefSr6gCDP9blnLbN9LuXduCulB0A3VjrYmyJYD250dWRzFew8E6jqkmdr9ZM6VNImQLhA5WlaFruokreqYYxeQjvRkXVWKWU0HdT3AvGGvdhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606765; c=relaxed/simple;
	bh=si/8jUIli0jY6NUQwHwTmQNVedvwj3T+pYnM+tOtbq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw23v+Fx/bnwZtXV3acrbdhRHUO5i9spBFere3jDJiLqRsJP2k03u/slEM5ZXT14xeG5qRiPjSdDqe7p98LbiltvD1B31564PIOiXquXArp6Pn7PkywU14Wh1CeH+xDzlG9+yiE+nB9XgIMmULG4h5OUiUDlgB5uTBwoXuBe6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKhiHydm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3122b70439so496206666b.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706606756; x=1707211556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsWHtoewXaR/B06erFaonZAzbdssFVbTKgOGwBdGAjs=;
        b=JKhiHydmXbmD+4fvsIxEER2PC3wsr8BIE1eCJ7Gl2dr8RAsTaOoY/Sjfp8ZILBsSZb
         smiehxcP+cHy8Wy8kfhYH3fACcBHcw4gS296rPAMToi4+oV+YgOQTUswlCepue29c6br
         O3ovia7rfXoSaEK6W3xE8oyAudhkjNTNN7GRVdFgpG5vqMfzLB8cY3mVLuTJXrTXxri5
         utvgmE/ERLWvId1v6GtdiPgdQ3KlxXNRa4/1xRlLK5CLeIe/z7M5H0wvseyAPB8L0F7L
         VKHFUftBbMjLdgtFqIWs+5hwuqnK7394OIm84DY2Iok2bRnB28ipnCQpkma1UMKJ8055
         W1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606756; x=1707211556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsWHtoewXaR/B06erFaonZAzbdssFVbTKgOGwBdGAjs=;
        b=QxxsJXD/o3oX37aXy/fOBPCXiolrYEfS1cxXQsu+8vNmPkIQWtpVX5GAsOZy4rssA9
         CcRIJqqPobQGz3S7rt4hpKLJNChyiDuDfShewBRaPMKjcstyoUEI59G/MJrRDr2nkMfS
         l9uPULygQ7ziZwkB1c+yT6FNDPfstWF8uw3tB4Shd5S1Br+3IfbWBlk4bR2EfvixfpdO
         FO4g11FP/PQ9UALhN0RrccPtH1ggoFBhV7Vp7Jxvsh9H5TqUba6jsfEd3oI6rq1TgLwe
         EDwqyCfWiOkoqVDuz2J09dCnRB6hF6SmZqqcgA6M9k/BlGLFy77ziu47AwNx/ym5Z5kU
         T9uA==
X-Gm-Message-State: AOJu0YwWlYKkEJbz4yzseXqJ+X2M1tb5/gyxwU86rYXhXQ6FrXD+V6bU
	3YWA3TSRhMdoc/Cgcogf8i5Xxilv7ciSw663pJFdtvAva4ZjOY5m
X-Google-Smtp-Source: AGHT+IHWevS+fn1sBDR9/7Q+FISwM3WI139lwj9MflU7Sh0XLgUSBeYSTMyq2HApC7/4skMeReflqQ==
X-Received: by 2002:a17:906:f896:b0:a19:940f:b9d3 with SMTP id lg22-20020a170906f89600b00a19940fb9d3mr6350544ejb.25.1706606755755;
        Tue, 30 Jan 2024 01:25:55 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906394e00b00a2ccddf9a7dsm4872339eje.124.2024.01.30.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:25:55 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jan 2024 10:25:53 +0100
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org,
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"olsajiri@gmail.com" <olsajiri@gmail.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"Williams, Dan" <djwillia@vt.edu>,
	"Somaraju, Sai Roop" <sairoop@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>,
	"Craun, Milo" <miloc@vt.edu>,
	"sidchintamaneni@vt.edu" <sidchintamaneni@vt.edu>
Subject: Re: [RFC PATCH] bpf: Prevent recursive deadlocks in BPF programs
 attached to spin lock helpers using fentry/ fexit
Message-ID: <ZbjAod-tqcjQJrTo@krava>
References: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>

On Wed, Jan 24, 2024 at 10:43:32AM -0500, Siddharth Chintamaneni wrote:
> While we were working on some experiments with BPF trampoline, we came
> across a deadlock scenario that could happen.
> 
> A deadlock happens when two nested BPF programs tries to acquire the
> same lock i.e, If a BPF program is attached using fexit to
> bpf_spin_lock or using a fentry to bpf_spin_unlock, and it then
> attempts to acquire the same lock as the previous BPF program, a
> deadlock situation arises.
> 
> Here is an example:
> 
> SEC(fentry/bpf_spin_unlock)
> int fentry_2{
>   bpf_spin_lock(&x->lock);
>   bpf_spin_unlock(&x->lock);
> }
> 
> SEC(fentry/xxx)
> int fentry_1{
>   bpf_spin_lock(&x->lock);
>   bpf_spin_unlock(&x->lock);
> }

hi,
looks like valid issue, could you add selftest for that?

I wonder we could restrict just programs that use bpf_spin_lock/bpf_spin_unlock
helpers? I'm not sure there's any useful use case for tracing spin lock helpers,
but I think we should at least try this before we deny it completely

> 
> To prevent these cases, a simple fix could be adding these helpers to
> denylist in the verifier. This fix will prevent the BPF programs from
> being loaded by the verifier.
> 
> previously, a similar solution was proposed to prevent recursion.
> https://lore.kernel.org/lkml/20230417154737.12740-2-laoar.shao@gmail.com/

the difference is that __rcu_read_lock/__rcu_read_unlock are called unconditionally
(always) when executing bpf tracing probe, the problem you described above is only
for programs calling spin lock helpers (on same spin lock)

> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 65f598694d55..8f1834f27f81 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
>  BTF_ID(func, __rcu_read_lock)
>  BTF_ID(func, __rcu_read_unlock)
>  #endif
> +#if defined(CONFIG_DYNAMIC_FTRACE)

why the CONFIG_DYNAMIC_FTRACE dependency?

jirka

> +BTF_ID(func, bpf_spin_lock)
> +BTF_ID(func, bpf_spin_unlock)
> +#endif
>  BTF_SET_END(btf_id_deny)

