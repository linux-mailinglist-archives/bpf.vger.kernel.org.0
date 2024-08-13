Return-Path: <bpf+bounces-37006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DA94FDBA
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71DA1F23DBE
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9C3BB21;
	Tue, 13 Aug 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpp8QfbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09A3218B;
	Tue, 13 Aug 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529890; cv=none; b=S8ivkWZCnto4QVfnSfdWL+CV7xngqbobexNdw/xILruNoGeajsMSj4gaDvSytyD450yZNHVlRCGDD11qrc9Hg1q0hplhb4ibWBxvFMK7wDTpW4zQ7U+4c3rE+GCAoDqYvNT3GyZm0dG/Nv9Uu0QRjNMx6f6BH7A5CP0FzzTqWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529890; c=relaxed/simple;
	bh=/Ei6GoN2hxx7Ohgs4IlFABwqjL70ijI6xfsf2Q/iUHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt2sHIrpjIWBDlUBr26F/rkovVshtSrulssjunvNutn6KKVG4m+R090NjAOflm8ashQe/7JAepwn2D2MQtgLB2cShPng863HXHLZbAcu0I4KaPpVYf1UfgIQIV+yjCxIWDjZV/+qoX7O1mEUIyBqRmdPXKtvLSq3tNhaS1sEZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpp8QfbE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aac70e30dso568704666b.1;
        Mon, 12 Aug 2024 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723529887; x=1724134687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16pKIYRPYzAZ2cVZGoDKE+g4e+Tu4+gU68ARoHo8H9E=;
        b=dpp8QfbE/rcdScINSvN4mH2meYoq5Hi2KZ7iW2ejFUz18kesvv1dGXcZlCZFG8XeHy
         fDxTtQ0ReAZE3mce3iOf9YBVPvjDYWEo/W5FBJT38zpDvROGLd2UAIZHPr7T2jGPq7fv
         +1mx2NTrdTq8l/GySOTz0e7iVNtG92OqYet0TmWURBFeubOV1S8oxBY9PMxEUpnJSc/V
         hHWcBS3L3zUZywQIEM3NM+lGoqqctYEknSAnZu/I8MVLTSw/Y+jxn5tI4CjB/vzyZlSD
         Ac5k5g/n4OxNxNxo5hGBSfJOBNuN5F7QyBPumactwzPPgOIIlRZkNFbJOTVfRHnZYKEN
         GjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529887; x=1724134687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16pKIYRPYzAZ2cVZGoDKE+g4e+Tu4+gU68ARoHo8H9E=;
        b=BuLwvI4TpX7fi16MdbHeo1XU2Ug8foi5SlZsHWIxQZM5dooz3FCvYyf6avDrFVPVvq
         s85G05mL2nOxkivBkAavLTaoddO4qrRwM8fdhrboCE0sF7eV0HkXsixMzafhw/9BbUD/
         v9H6CSYHhOYrvMaVpphAt//f00mNyNFa8aCEFGJULUd3vis8VRdq4hsB42eFNitoAgwU
         7etPrGBCaAwtjW4J2bPNLw8ByioVxz9hZjGeIacEPgTdcxcj53EEgsq4tTIQZDMCsWIQ
         2RftzEX1DsjDK14AiAfzVD4lrt43fXBEGdj1qRjsh7pb/CFB/VFe2fm7+APaXwmtG3BD
         mjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcA1AWhoMw5COms2fL9gAOpTuQbzVWYdHB14TbJMoeelH+EXH0JULvPvUE9D3JPYmBgEBL0DbzvjubL87RkyDzs+tamdkTPg8eX4AsEhbR6LOK3ZqvptsNeIJOzZif/0WQ
X-Gm-Message-State: AOJu0YzzPVostkixM8dUB5k2v2GiGXAbM/9m6ntdMo+JP1mqGY43O6GK
	2cxhK3MdMpfhvimESSJhsXIaNHb+eaR7bSrrL6Oz4k87Bu9MxWpd
X-Google-Smtp-Source: AGHT+IFgZG9it8OjdYZb1L8HgN1g3Lf1MfTdxpAh434F1nFJT65wNOswN2hy9m/9TLGYCshL1AT9Rg==
X-Received: by 2002:a17:907:7d8c:b0:a7a:91e0:5f1b with SMTP id a640c23a62f3a-a80ed2dc9c4mr166308266b.68.1723529886757;
        Mon, 12 Aug 2024 23:18:06 -0700 (PDT)
Received: from f (cst-prg-84-71.cust.vodafone.cz. [46.135.84.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f4183aa5sm40432566b.211.2024.08.12.23.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:18:06 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:17:57 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
Message-ID: <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-14-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-14-andrii@kernel.org>

On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> attempting uprobe look up speculatively.
> 
> We rely on newly added mmap_lock_speculation_{start,end}() helpers to
> validate that mm_struct stays intact for entire duration of this
> speculation. If not, we fall back to mmap_lock-protected lookup.
> 
> This allows to avoid contention on mmap_lock in absolutely majority of
> cases, nicely improving uprobe/uretprobe scalability.
> 

Here I have to admit to being mostly ignorant about the mm, so bear with
me. :>

I note the result of find_active_uprobe_speculative is immediately stale
in face of modifications.

The thing I'm after is that the mmap_lock_speculation business adds
overhead on archs where a release fence is not a de facto nop and I
don't believe the commit message justifies it. Definitely a bummer to
add merely it for uprobes. If there are bigger plans concerning it
that's a different story of course.

With this in mind I have to ask if instead you could perhaps get away
with the already present per-vma sequence counter?

