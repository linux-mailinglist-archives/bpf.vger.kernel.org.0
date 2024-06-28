Return-Path: <bpf+bounces-33388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E991C981
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB299B23945
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DC81ABA;
	Fri, 28 Jun 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAs7S9XK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294578C8B;
	Fri, 28 Jun 2024 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616383; cv=none; b=OXez6iy0XBIhWv1dWy/K6iB13OhGySI5O/l1mTgoRS5/US7Tya5fh0nIqPnhzkUPXUfR1RHYXtCyqCCZviS2Ou9Ts87guI5GCLDdKL/2u27Tbx8ea5mjEYMhrJwVN3AjR8HgcUPi1dGJwsylcwHf8GV6PXvN5ld5HrlmiVa20KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616383; c=relaxed/simple;
	bh=1sshCpT+0EycR4rf2JwnncQxgvXJDIezprx6cwy48gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbWtShASMFbdz6ctNJWk4LnzI9oE724ZpckmyxseVjydO4377ivKL3UZasqDFm7d7woalgEcnLGr1I5a12elT5DfLglonyhGyZGdFv9nKAPuPDbGj1iUhzM6pO+YMUY/esOpglljBCSzr9nn1xBeB16exnR5jjI3uHjPnIGHklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAs7S9XK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa2ea1c443so8774585ad.0;
        Fri, 28 Jun 2024 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719616381; x=1720221181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPbFviwPsE9tM/dVYGBsIcnnS8pzc1tI10a/z4Viceg=;
        b=eAs7S9XKGDSGRdMicw7Gts6tVDRn54OZab5t87TIV8cJfLoyclthbkj0meUCtrnnj2
         YX24/ZoiM1BWJkF7V2bbnPjSJenK5MQafDyGYby/SXcHbz7f9C0U+mmDoTfSLjMpdyk4
         hISprEu/fTo/O4/MkFm4PKVSdZ0kCRBY5fE1q1xwG274LfUY6o9P0+8deAwbJwBMZL+z
         2EaYxI0hMqHhqNTLJkYcmiEXkf9cLttuY9RaQqXduHijt2ov6evfs0P9BAYUKXl1IEtV
         Q+l4oi44Kd3DvorvXELusmUiXI6W0QPAw4bY2IqrTDtkMAYZybh156GQGBnAkoOegDQM
         q4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719616381; x=1720221181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPbFviwPsE9tM/dVYGBsIcnnS8pzc1tI10a/z4Viceg=;
        b=boyxS05+Lmr2N7AbHCMhI4JgZY9z3TjHze51mIG3p0i63Pwyc1quAdSjmD3Xb+H09E
         d9owSE4tvtAAaqqwZb6d1ImaOR6faUcLhQN3JYbcXb1juFGIdCY2hpiS9r2nuYt9+Ell
         H4KdhsYJcim1kbuI4d+ukf290OHHfWZFEMnRsa1RI5Pp5dZynVpBTNgAcy28tyB5KCqL
         B1qrzj0KEXr5zwoTeUt+o5mVPC2hsH1j8ZS8F3wkmbwWztHUmbeSGrAep5Bk6lexe1Ll
         zIX5R77Z6AX6RLOlvRJntD8hvX+a9sMb9yGE01oIxGF+GiazDoRXQunoHjMfuJceUL13
         ybpg==
X-Forwarded-Encrypted: i=1; AJvYcCUpCm3Al6FABVunq3DunbzRfxR+ZrhVSOKxa8jUXTF58L12U3Ol/t/7fRaYyBhwEPbI10cvHylkKqHHk2iDn1w5IiJ01Qdq6mdJZXQlwS0U6fWdOzZMyty2NZ+3zlcecM60
X-Gm-Message-State: AOJu0YwvsSTqwJCv2MIvexlu5BEyyTyGUBHqv1CzvmyOiL7Ls34T3VGg
	zxfoHW+U97ntIIJzPIZp38RbuvvninLETw1jWoQ40H0vbP5gbQp3
X-Google-Smtp-Source: AGHT+IGbQGQYeVcgQiCfQj0hVKk7f2EV83ovxNX17a+d9LnTOdo1hGizn6b3TpU/lV9v0Wqdf/0QGA==
X-Received: by 2002:a17:902:dacc:b0:1fa:cea0:c5fd with SMTP id d9443c01a7336-1facea0c66amr18268285ad.50.1719616381067;
        Fri, 28 Jun 2024 16:13:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2ea7sm20889825ad.81.2024.06.28.16.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:13:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 13:12:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement
 scx_bpf_consume_task()
Message-ID: <Zn9De_70fy-DVA-_@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
 <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
 <Zn8xzgG4f8vByVL3@slm.duckdns.org>
 <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
 <Zn9BZB8tE-CySXnn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn9BZB8tE-CySXnn@slm.duckdns.org>

Hello, again.

On Fri, Jun 28, 2024 at 01:04:04PM -1000, Tejun Heo wrote:
...
> Not a stupid question at all. It's just that all the existing interface is
> based on IDs. This is partly because there's not much the BPF code can do
> with the DSQ data structure and partly because DSQs are usually not accessed
> multiple times in sequence (ie. if the BPF code isn't going to look it up
> and hold it persistently, it's going to have to look it up each time
> anyway).
> 
> The multiple lookups aren't the end of the world. They're all on a resizing
> hashtable, so lookups should be pretty low cost. It's just a little bit sad
> to look at.

Just a bit of addition and a question. scx_bpf_consume_task() is maybe named
too generically and I have a hard time imagining it being useful outside
iteration loop. So, it does work out kinda neatly if we can tie the whole
thing (DSQ lookup, barrier seq) to the iterator.

The reason why this becomes nasty is because I can't pass the pointer to the
iterator to a kfunc, so maybe allowing that can be a solution here too?

Thanks.

-- 
tejun

