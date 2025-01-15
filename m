Return-Path: <bpf+bounces-48929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B5A124AD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D61416789C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27F241A1B;
	Wed, 15 Jan 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeLY14PJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCA2419F1;
	Wed, 15 Jan 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947543; cv=none; b=cUHt+SNZIFokkgbMqQ8V6e/uaNfChATon0Q/anRnCu1W3NqhxZLZXoDoy1VT5vj3Nr3jNcUPf2CUy3BljwOQGBIF2TAUpAf8ciRJGmlo0r7GNEdLFLE7yi9Q295a72UghEaRs0FB7R4yYHab305jaz05j8TDJOV+DjPs9EK7mRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947543; c=relaxed/simple;
	bh=k0wySE/W9PdgK9R/IGIsg5yhD2Ui66g0ZQh7BLDybNo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtVCVKZlNVlnc0ZhpvO13D5KZtFp0UfzmiobYqmN4QzKOKyJzdmYJaMAMITojSYFtT7qbIZ2Y97LSgvLE+IMQv3IFsjsTjX4L6olz/wk5ZgUND7YZ1CVO4r5N7vT3LV4evNT0Pu/zArDnTfbCYyqdiedLTvLaVzTA7XQfvCb/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeLY14PJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so13665666a12.2;
        Wed, 15 Jan 2025 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736947539; x=1737552339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auSYLspHLDyp68x4yixLaBHj0jYNkKdI+38xPboCV/4=;
        b=WeLY14PJtjsYwSJu3BDVROXjQQlDJBk1BMSTY5bjX/s3adHzfWt76qYaZg3cLC/+Hd
         r6bxQQKSjTGPTzza+G8Viv7mNy0UCvoc3NQQhyAz3Ygiy/wXj36VJLeHg0qRB28uiR5L
         MrjTm2sYfIxCsBFjwFsWVbv3BMpEvzWFFDdcoKNOtmueA1cf50KUR7eWYpnQK+txL9aJ
         UrRkJezvVyn83yige2BC8zFhYTpC0vAExEl5VVie1W0LQaJ3WX//TIz5tS6hwQhzV/+w
         K0O9tXjk3BejG9yW7Eek8Wep8Up6p4Eri0fiCaTDcNqkaGRfQRHY6+iO4dQ3r5waxvOB
         NSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736947539; x=1737552339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auSYLspHLDyp68x4yixLaBHj0jYNkKdI+38xPboCV/4=;
        b=fLFCn/z07mLGKjS+claNkQmin8t4zCU+AqaLc2JdHSP4HJbeQnCDAahWwhxLmPu9Fg
         KTyIJ+SvwUOEc48Ujdzzp11b8UeLBFl0i3LASJTsPO3LONgFpnXFZTBNJEHrelfJKbtb
         6ZvuMFBTA8ulo44lcSiq6jUqQkLhjDbY1+fi532Tv+AumozGRRc7j7qdT88wSlcTsdo/
         YKOzJqZH+6YqSPfsA0vYuTBO6HFpvMxlXboq16VdR56P/RXNNeknDtoywnsoNqg90JU4
         WOYDCD/9wfOx9sidH7IEqhhlJ8Il/iOvR8JvnezNu+p524TJGGQoX34MaXd52TIuDZdD
         g2qA==
X-Forwarded-Encrypted: i=1; AJvYcCUXvC7RtNLDv7YzrBEvLDRWwUZ5YRRf9sxQL/whFtI4BN/KHRHpz/9Zyfojr5RIHuTmyTg=@vger.kernel.org, AJvYcCUvlsltzIZU7fzeyTgGe8SklLVYIXKl3z5+pCwm8PIQaPF+0Ilnmv3wKCqgxlgamtyViffkqKhix6mpafo0aiSNz9jE@vger.kernel.org, AJvYcCV/g47lmrOPxB/0/42YaiZPpNng8gvSdSPLUi946tX4Z9xKEzRplaTz4u/rI3/VpddiiVm2FibLEbo+JVkA@vger.kernel.org, AJvYcCWOndHM+SsGaFF/R9O2wL8gfTPxbARz+mMFQPdHBBt/BQsY6hHNQevfMVcAG2WiIQL0dZTvd1upv/0S@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiNMjvqY7LXKYBYId/ONxHvDCdQuGlhhPBPY127Ua6A9kEKMh
	/yFtNt/ci13qsklckZh3h2yoRy/rUJvljnhYjysCYgNpTdt1Vb7+
X-Gm-Gg: ASbGnctiuTicscUA0780dQhVNyJmyeUviLwSlNO60FMHyWX0kF0sZj7YaCCZwK/AD3Z
	sYT8JLvYt69P4q6If1EkG4t4srnJDxcHL2fyaK/SmAgDm2ObMDmeOqsBs0QEZz4jOOxEE6Z3F3s
	qXHp2XIg2ukKN/sbJo9OmBU4WovDnjpBQM2izVbWiFoEVTt2KGRi39GlwHbqA7pnrFc9wZbXYy7
	u7PVAC2qHXA1UTuh9ShG3W+WTTUHecLyeYYAEzNaNw=
X-Google-Smtp-Source: AGHT+IF//qiTd/sJwf8LZVdtKQhRkLFte2MHy53PRqfwjBng1sN+EmV7EN3Bv+GVf1rqQKdQUB1/2w==
X-Received: by 2002:a17:907:7e91:b0:aa6:4a5b:b729 with SMTP id a640c23a62f3a-ab2ab6f3447mr2873058866b.33.1736947539048;
        Wed, 15 Jan 2025 05:25:39 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95647b6sm754434766b.115.2025.01.15.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:25:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Jan 2025 14:25:36 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Eyal Birger <eyal.birger@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4e3ULmddAuLBVMr@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4eBs0-kJ3iVZjXL@krava>

On Wed, Jan 15, 2025 at 10:36:51AM +0100, Jiri Olsa wrote:
> On Tue, Jan 14, 2025 at 06:25:20PM +0100, Oleg Nesterov wrote:
> > On 01/14, Jiri Olsa wrote:
> > >
> > > ugh.. could we just 'disable' uretprobe trampoline when seccomp gets enabled?
> > > overwrite first byte with int3.. and similarly check on seccomp when installing
> > > uretprobe and switch to int3
> > 
> > Sorry, I don't understand... What exactly we can do? Aside from checking
> > IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?
> 
> I need to check more on seccomp, but I imagine we could do following:
>   - when seccomp filter is installed we could check uprobe trampoline
>     and if it's already installed we change it to int3 trampoline

nah, other threads could be in there already.. :-\

jirka

>   - when uprobe trampoline is getting installed we check if there's
>     seccomp filter installed for task and we use int3 trampoline
> 
> other than that I guess we will have to add sysctl to enable uretprobe
> trampoline..
> 
> jirka

