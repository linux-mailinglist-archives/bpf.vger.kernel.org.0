Return-Path: <bpf+bounces-21711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D226E8504F1
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99243284B45
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780335BAE0;
	Sat, 10 Feb 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFgicwri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48E5BACE
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578983; cv=none; b=m1Uaur62r2gmH8uHfdvqvgF7lPS+YwDTRX8Tc90jL0emfv/1pMmaoRJdMGxp4ThFhSS7vuytDkrrtPF+Hpks1gNiOFL3x62dnJfusdYwVWYfasKmzeoQio1WJrAuiHxikzRdISbVT6Rm6REjXSZaLgev2sKOnk7rWKChaYmnpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578983; c=relaxed/simple;
	bh=mrTNddr28jhGS9bmPOZnP5yKu6GClMtu4P4480yfQ2k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsV7BcSxUyj0R6Wv+jq0kqHdixvv7rVwb7woKj/Mm/k17VTZ27cDnWl4tCojpB8DFWXww4mm1zY7ByMOI7SSNXwrTwKu9rTO0ZRjyZyNQSygtZXUqENGhzRiBs5sKdczhjttlipH5/wGQaluAWJithAFXgN9p3ZNzpvA61y4Ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFgicwri; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410ad88f70dso234165e9.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707578979; x=1708183779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1VGShOeCUc1sc1IHAtuPxlMJPHZ3JJa4pFuuO3Y3Rr8=;
        b=lFgicwri4ZdfdKtpTANYX0ZGcrhpTN3wawR1D8xG61gItR+NGjMxCEfbPctURPr7x+
         +LFtM8HhJLKrju/jDLzH+BRMDsAefsbADfdURmLlbpQRIWawhvzxduCB6XGEiYK2FxYm
         IwPWP9AiDTwnDxIwMlFfR2r/pEiy8PdCxOPPKVpJb5t9gE1T/Pv9gsh5N0zKNL0jE5lr
         F8NAkDIxBCBJ7VynBUAipHmsmup34yLgYA5f65LNdfLxRPbYN//C/RlsZqEYFmLRcV4O
         YP/xxIDIKEUGwuGC2wxkPnzEiS/7zQYgSLXZ9vodai2uIgJswn1x5S9Yg0ff4TvxR1kP
         yTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578979; x=1708183779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VGShOeCUc1sc1IHAtuPxlMJPHZ3JJa4pFuuO3Y3Rr8=;
        b=CzCjvZjs66XZt0rhXpa2YqDyTT3aXfulUzZedtXoLvUCZH9PIWdUnAsgEEmqxucUYm
         wnA4yN7/6BTwMjz+mmvuS0lgqHXF9h0cTq14EGlIQr36nB+tYRBrCtlRtMNgyaFEbosQ
         P9c/sO1XlGbZSwX2LI4Moe1DdZ/4gCWhTTrZu21SJjOEhJc9KqUh0u4aPhYQU5mny4Mw
         8ComeQv57WCnGOsQyeDvmwzkBxW51W4zE2yR+pLWZLlpaKByTOConKfJEuQD0jf4dW0B
         nozGqM21Q9bgpHU/8wQ80C38hc68Kh4qTMk+FUL1JW/HmoBPtmFbJXMGJGKrbhccLRaH
         W6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVL0hv9OpUpiVB6LSqJ1JkcqhFj7KBK2DHwKIXpCunpVS3QZocCggShLdFzJuJZFwoz8++Ab7W8CnHN5Dcm0PDv0Xbk
X-Gm-Message-State: AOJu0YzmOJZKS7I/iRMuQAmdK7iK30ygEU1AsSh+AHY/mMaQUQT7OHSu
	J3OiHgb0rJ5WaQexIIIYoKyZb05NTzjiIvpRSfq+FlUnPW44A2EA
X-Google-Smtp-Source: AGHT+IHVX+rNOgDNKLEHvBrWXQa4r1hfCvntB21A4l+ySQ3IBClQqGm4/tmVvyP4iqdpkz8cD2iz8A==
X-Received: by 2002:a05:600c:4fcf:b0:410:6ff3:9a50 with SMTP id o15-20020a05600c4fcf00b004106ff39a50mr2063784wmq.24.1707578979236;
        Sat, 10 Feb 2024 07:29:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOWY20YsZICxyu8JSC+6lwkQ8ouDsKV18ggQm0IuVjRUiz3nMVKV4Df7a3wj6BeexwlKIRn3Hi+HvfyE6hnK6NktZvHGiozg9+iiQdmk1ic4dbKE1rsRVmKrSzVcU5lx2cKmnbUzlhaU97DX/FxFeBGjQ6XtKs4JxieSC23X+rdfuO5ZUykolUAfEcFZaiOd/pyPXCzfH43eAMOymXKgq/hk5adF/BU+xgh5YtTrZRtZ7OnTHz1w17ZX5QdlFDKMCMVQTETIk4PpZaosLwXAZaZIrjx1maKEU2uHekw6IselnZa1GflTYOEWVWOyf3wIgiZoDt6xnq2T9/Sw2xOTIpb8sgtQrtkIkchmT7OUIa7OUn/y+wwhJi
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d404d000000b0033b4dae972asm2095192wrp.37.2024.02.10.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:29:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 10 Feb 2024 16:29:32 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH RFC bpf-next 2/4] bpf: Add return prog to kprobe multi
Message-ID: <ZceWXBXGum-tF3sV@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <20240207153550.856536-3-jolsa@kernel.org>
 <CAADnVQKi+o5LE+oLCvpL5PmVX2BjJdt9a2HEQiXmTgXRLYV+zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKi+o5LE+oLCvpL5PmVX2BjJdt9a2HEQiXmTgXRLYV+zA@mail.gmail.com>

On Thu, Feb 08, 2024 at 11:05:06AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 7, 2024 at 7:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> >
> > In addition it's possible to control the execution of the return probe
> > with the return value of the entry bpf program. If the entry program
> > returns 0 the return probe is installed and executed, otherwise it's
> > skip.
> 
> Let's not sneak in a big change in behavior like this.
> 
> > @@ -2828,8 +2832,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >         struct bpf_kprobe_multi_link *link;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > -       return 0;
> > +       return kprobe_multi_link_prog_run(link, link->link.prog,
> > +                                         get_entry_ip(fentry_ip), regs);
> 
> This is big.
> What motivates this change?

hm, this makes the difference only when the new interface is used, so I
thought about it as part of the new interface.. but right, if existing
programs are attached with new interface and un-aware of this, that might
cause issues

in tetragon we use logic where the entry probe does some filtering and
related return probe either gathers other data or quit based on that
filter result

with this change we can eliminate return probe being triggered completely
when the entry filter does not pass

jirka

