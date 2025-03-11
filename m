Return-Path: <bpf+bounces-53833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54F1A5C8C5
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60993A8847
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C525EF90;
	Tue, 11 Mar 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD8vDNev"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE811E98EC
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707893; cv=none; b=Ow+IYRhC8bvCGUKQHTwNd5eG+THtHWNPk54X3JjPHx1I0QmUyMAcgbbydQxsa8+qayQqO6mAuVXdYtsyMR8HOA8Ojir9ZtTm2y4oBMrEiKznJPbOJH6xSehY4Zj8c5fvcNGkCA8q+BcBwFPNNDFa8NX5qxvm6siW02MGbRFtgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707893; c=relaxed/simple;
	bh=wR9oScK95a1vk8TrLZ6eyBi7wGfn/8hhbzQ5423xjHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyvhHQ1kcxPTXUgNcjdhxnsjngiTAuFMpyYBBE02CikMxPwj/NduyhYZ8Gz5eBdNnbIq5pSbLS7wdriIAyBCuGQjcCqWY6ijsQX1iGuq/mc9j0NXfUYsacE18fypStFFbv3ZtN8NxX+irk/dVsNtaIqaRnYP2F5qG3SeSPe7DlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD8vDNev; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2254093a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707890; x=1742312690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwIV3Y77SvgXvZ7rwy6Gg0gijb11VmEKmcNNXJ2BmPY=;
        b=iD8vDNevO0xAzEg3a4zs5W9yQXGaB6CLmx9ilXkLxv9nZD59JAvzOkUPEun84IA+Za
         x6idUOC/TNxDt6+koGZu+weOIlVKlcGrsqo+bRpMifWxen4q8bi8uw+RVGuRRRfrgW/n
         7VS02s7QIWmzDdc8Mo3zPgIby4RmRujPX9yE+ackovHjgYOewTRxVmX0qAOCUDNrLpma
         Drq8xntTnQuBO7YZz1fc1z+CmbozD9EDY2jVwqalcD9QHClnxorqTB2SOGjnkyF08rMs
         c2wMXwg3AnwQ8M3kclLCnF5E66zpgCO+IOq48XJzT/xOzVBCx41LicGA5/4ocr7ApBEo
         98Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707890; x=1742312690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwIV3Y77SvgXvZ7rwy6Gg0gijb11VmEKmcNNXJ2BmPY=;
        b=thIe08ujlrhwZROvkenn75+Hq5tmAGVw5NMWFVXSact7N3ZaWbUSV5yvzzjQDU5n+1
         cha9LgbdNCzA3W30X7AG0qOQUKuUywW3Rud5Xtvj1okU5/nEdz9KpcUip3dJkNaSbWOJ
         WBcLU/6M/anaRAaHRL0w0NwL38zbpSru3RljnbwN5HWZ6hYpELAVkB0OnVJdw2NeBx9e
         YDwVfce+qDuj4/z0Ej4ck3QouQn2LOJbsyUpj69ybds+TgT2T498mrhlDGDi4FAKlOC5
         BxCEnPYah2ugJc6nb85/I5VPMS6TjTUF09IdJ+S5Ss/5r+TkKaWXLnfwiCKyQjS+jvRe
         qetA==
X-Gm-Message-State: AOJu0YykiHnIFZok+hUBp7fjhNqIUwQTve6/6WvkWLvKFSyj6oQJtek/
	uttt10zTZa3yQGO6qYcDILgAumUf/Y6IUZUwnqu3KxIkBbVF4AkD
X-Gm-Gg: ASbGncuOiA2Q6hEr9BYy02ms0NPkR9GGhNQjX4UG1s0giNFPeavzBhPGJhiQN0PeBZC
	n2bZB0Hyfc50MfmkUdcUv0RLZJt0VqHcpq5/jr6jvuCAezyWwwjjjkeVoxc9N6Fko8QCr9jTMBs
	dX+8ZYixBV3yk3HoW415zMbUTkp4l47lnXhybstsi27EauI5xlLkybCVbnq7trRwwCByTQnTyGM
	kj50NmWcw6t40xmUc6QbnAfmq9xQcSSiITtmGXkpPSxqmPlnua+5qGZyPfETDuGed11OvIMDfby
	qNb1+Hy3/g+a044SKwaEEahC2+QSUn9MBZfBkcM2ik3ZmW+0OCUIksbsj1Q1
X-Google-Smtp-Source: AGHT+IEic7PqZUJM680qY5+iAgGkbn6ypjKTcAgLxuKKXkbXkoOy7f3pVpARm9ZhxQ3KoDp4gJ2D5A==
X-Received: by 2002:a05:6402:1e8a:b0:5e0:8840:5032 with SMTP id 4fb4d7f45d1cf-5e7626039c3mr4810711a12.3.1741707889552;
        Tue, 11 Mar 2025 08:44:49 -0700 (PDT)
Received: from f (cst-prg-86-144.cust.vodafone.cz. [46.135.86.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7476ab2sm8746169a12.31.2025.03.11.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:44:48 -0700 (PDT)
Date: Tue, 11 Mar 2025 16:44:30 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com, 
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222024427.30294-2-alexei.starovoitov@gmail.com>

On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
> +#define __localtry_lock(lock)					\
> +	do {							\
> +		localtry_lock_t *lt;				\
> +		preempt_disable();				\
> +		lt = this_cpu_ptr(lock);			\
> +		local_lock_acquire(&lt->llock);			\
> +		WRITE_ONCE(lt->acquired, 1);			\
> +	} while (0)

I think these need compiler barriers.

I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatiles.html)
and found this as confirmation:
> Accesses to non-volatile objects are not ordered with respect to volatile accesses.

Unless the Linux kernel is built with some magic to render this moot(?).

