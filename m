Return-Path: <bpf+bounces-32565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D190FFE3
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5DB224CC
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CEC19AD7E;
	Thu, 20 Jun 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jir7Gk5k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E450288;
	Thu, 20 Jun 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874395; cv=none; b=jUEgoiRSjonQzs1nPwfmB9LMc4crgZ/QIm6tQC3vDwT/noM7SmxOwbHDCGPhpwTPvcF67rfxcGADu3/xwUAOVAaarJ0OFglqCvLHlnY3erv/QjhxEnMpeBi3xKnCvcifpcE4Iek9NwYj8RZGFDUDSdmh7ejhLfErOO6taJ9IjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874395; c=relaxed/simple;
	bh=a/KjCti6R+6JZx72P0n0Q+rTyMBKjYD4Fta1C7UK/Dg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfF2ou/LL0XBII4bdrs/uibszvqhJIWMzqZ1KOpQwSkQjAcu6dp73JznNdaU3mNVgQBu0LUtwn7N7iguV94XenedJ9emdBCAgUNRev4WCRNlGxq7++bpfLUyGA5Pzq9EiPiplF10N9XBep9m5cE2u9DAg2WUqhxF6xigHe3QDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jir7Gk5k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so593974a12.3;
        Thu, 20 Jun 2024 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718874392; x=1719479192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78uUzESMOdQTWvfYAcQTyK+lGm1Zw7Sc2BeqHShFKEI=;
        b=Jir7Gk5kNfhCYEt0NirnD6d/ESSK/L9UOjKDGvprzRHr9T91XncFkO6OjOP0KpuduG
         PZ7I1ejlB88Q/5XktVtR2GD6pF4VOdPxWNam6Ej71r1uyhHh44Wnn5Z6qLHZRQN5oZfA
         4Sax6s/8geTXeVmvqebpLMaxB1bvkMvqGyqynReWJUNb6q03rJ+AHAsPmmUEm8wMqaih
         nhg0yrSvzy+WCHDht6Xy9WUAB1v3heD38D85dm3RJxNTnGq8+FQxjcfm0pdpbZ5TG2ZT
         EDhO028UdCPprBOQczSMfDZZsRblPxm4mawTyLBM0kXTI6GR17tbEu2UCWg4NqTyc4/b
         Zygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874392; x=1719479192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78uUzESMOdQTWvfYAcQTyK+lGm1Zw7Sc2BeqHShFKEI=;
        b=ppKLu+6yTJZ5/Jd1580MZIGgtd1VPE7yRUUGSsPFS+Uo1J/hPTgKC4fT9+uSVCgzlP
         wZ65qpd52fAaC92gwLNc3e7w4p/WmZcW91U9usH9defGsG1u7OT2MDzBEiwxb6b01Loh
         Jqr3ny7uWkudnmB5TIFUhyH9jfpuUFhyGUTZasFN6yraSXNitptAv29obfBr9E3Tmiii
         iC5F6FbwQpv6RUudC+/hg0FaYB9ZtucIOyPz07Pvb2Jr3xBBlwvLFY0P41sQBVgGG4nw
         eMqun5JeD6HmqyOZ5QTH9QRDXhN+PozIAKcR0gixQTNIHYOLHOcPADqrUF9UsBe8fY63
         HkAA==
X-Forwarded-Encrypted: i=1; AJvYcCUVlHWnd18XYhPg8FiX+JEjdzSpYPj3gjyPnAovSxPtirG68ASGJnQAC2znAsjSsJrKuM8vuknw1HJpgtAFCFnfhP/F+qnobW1OfEUmA0g/Z3IfaVZ5kNQ3R+gj7UmjHz0Yi64x67R2j5uY5VMTqt2+FcSH+qzVkUhkWGRuh8e1SuemWg==
X-Gm-Message-State: AOJu0Yz0boHNerDZ3NFnW1b27tD7/0WvkMSDy4UlmGvD2kV6jxlO6Nmi
	aiJBoqqzft6tGYkSSVj3QUJV+mAgkFVSKnnmYl7Lgtd6DrSwAipG
X-Google-Smtp-Source: AGHT+IGYHPCmAg0EcgWW8sBLz05Oi1dwLaRAw/0OftwpRGxvbdEiRWcysCyM3L2qUl1b/QeM9haRcA==
X-Received: by 2002:a50:d613:0:b0:579:e7c5:1001 with SMTP id 4fb4d7f45d1cf-57d07e6f4ecmr2570839a12.23.1718874392134;
        Thu, 20 Jun 2024 02:06:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d27198948sm45831a12.54.2024.06.20.02.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:06:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 20 Jun 2024 11:06:29 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, nathan@kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <ZnPxFbUJVUQd80hs@krava>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620083602.GB30070@redhat.com>

On Thu, Jun 20, 2024 at 10:36:02AM +0200, Oleg Nesterov wrote:
> On 06/20, Liao, Chang wrote:
> >
> > However, when i asm porting uretprobe trampoline to arm64
> > to explore its benefits on that architecture, i discovered the problem that
> > single slot is not large enought for trampoline code.

ah ok, makes sense now.. x86_64 has the slot big enough for the trampoline,
but arm64 does not

> 
> Ah, but then I'd suggest to make the changelog more clear. It looks as
> if the problem was introduced by the patch from Jiri. Note that we was
> confused as well ;)
> 
> And,
> 
> 	+	/* Reserve enough slots for the uretprobe trampoline */
> 	+	for (slot_nr = 0;
> 	+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
> 	+	     slot_nr++)
> 
> this doesn't look right. Just suppose that insns_size = UPROBE_XOL_SLOT_BYTES + 1.
> I'd suggest DIV_ROUND_UP(insns_size, UPROBE_XOL_SLOT_BYTES).
> 
> And perhaps it would be better to send this change along with
> uretprobe_trampoline_for_arm64 ?

+1, also I'm curious what's the gain on arm64?

thanks,
jirka

