Return-Path: <bpf+bounces-37004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ABD94FD94
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E9B1C21078
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CC39AFD;
	Tue, 13 Aug 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBnUvDV7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA21364A4;
	Tue, 13 Aug 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529262; cv=none; b=nbZUFinBrmPJHGTWyORZBEi47tcM73WVn4b+uS39b9qQtrsSTx6GRgtBQETxplTb0LxveLv0b+BsYuoGxKzVxz24WKCEB88uHpF+YbWjP9dJn8umAD55ksKoSyFWtiGFXo/QmA3g0EOMmQB0z7wFQ6GapPgxVBNNrcioRwHD1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529262; c=relaxed/simple;
	bh=TJoSsv5ABYblOjpvDjHqYsTixnzTW1adFMkqtMzggNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTOl1+8tNCkmXiapnNuEawD2iveL7tXuHqbPVr12++GlhLlJ6gf4CAWF4jSPberZpfRCWvy16VBe2CTgbmQwHq6dSAyBgy1joclhYu//TGTKi44EU/U2YQtxWhqlTtowx74tH/pUrAgTxhtkYhzkL7xpEW755IiB860gQtiZuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBnUvDV7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a80eab3945eso113604866b.1;
        Mon, 12 Aug 2024 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723529259; x=1724134059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6W3pizzixO+op8gso/0Y0Z2ApdaicAeVY96VNeWzoo=;
        b=cBnUvDV7zTmita6Xc8eRkCikwsM8bB+dTucCDBQjaL8X8xcCis8CiSzarlYSsMd4T/
         mLZhSnEed4cF0W14k47PAYNXaCM4UFnhbu8saKBkZivfgNlc+BeYBqWyRQbJyGtZ6Jwl
         OlFyUYfsbr2Z5KgBv9kq2X7wQMd67ASTCGLORJvzohIgVD7Szxz3ZkqN6277A3XrlrgE
         8s4y+33ymslYtrP4TizhOgKIstb0OETtoX0dws+jhxw/hW5T4jZFw3xxA2zyTwu7fdCt
         6c5zvUVlGpXfiYHzW2CcmMcfRVjWbLV58IrrAWaWASelVO8Ro7yiZZxhMz7+OUMaqGCP
         6WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529259; x=1724134059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6W3pizzixO+op8gso/0Y0Z2ApdaicAeVY96VNeWzoo=;
        b=df5mpGgtozftndp2FcCLXS0YM6e6wb/IH2Vv82XK5ODXzBC0j403YZwihCGqq27HX6
         SGDuFom+Ar8jwNKXV5lp7beShK1h3e9B+pIOCRArriFYvbabByTBNAKhyUpcoADAd7a0
         bZvrm5/WaAJIJlIHmxBtLwvrkgJAO5pGQmsyAawVLq9xKIIN/ethHewYCrjwhzPAjPem
         T0g4X0UrDa7YehvFYwLEKqN9fDTaa6XEvdNCr4aEVwlQG/RFPzO9CypyhBWZNH+KdNe6
         Kj0XWGJvXp9D9CFnys59xpFYcifYkgDT7A2nXGY6eu5d0jP7NhKdipBCpaeGYSk7qpU4
         Su9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo8fMIPmtb7Q/EFqyC/Ic26yR1lgyzvQ5GqoyKVLi4RvAj8MSNNA9gDKpx41czTiujF70AYbhdbEZm5lntIepdt0ovfSzwnNrOlbgL2+slxoLvVr2SlL5/UbDg0nJkT4PV
X-Gm-Message-State: AOJu0Yx8YeHCijixw9Ne0b+D0g3jVdGSIoONVSARZpNFqrWSwUUD8HmS
	5SQlqXs5MOGHm5MzEG8dscKCQUzqlt93OFFKkKSPNpgjtEMyQ2SI
X-Google-Smtp-Source: AGHT+IHTWcWRM+Y+tscS4yq8v9ySddW6y+BenvpTNTo7KMVI9XXYGRGZ7LJZc3rJYGFBHxCbukOLZg==
X-Received: by 2002:a17:907:7fa1:b0:a6f:4fc8:266b with SMTP id a640c23a62f3a-a80ed1b598emr188899766b.3.1723529258931;
        Mon, 12 Aug 2024 23:07:38 -0700 (PDT)
Received: from f (cst-prg-84-71.cust.vodafone.cz. [46.135.84.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e4b6sm39584766b.151.2024.08.12.23.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:07:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:07:27 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 12/13] mm: add SLAB_TYPESAFE_BY_RCU to files_cache
Message-ID: <jdsuyu4ny4bzpzncyhuc54vqmnxb6wsshvnvd6eat4cknoxvqd@g4mrvwiokb2d>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-13-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-13-andrii@kernel.org>

On Mon, Aug 12, 2024 at 09:29:16PM -0700, Andrii Nakryiko wrote:
> Add RCU protection for file struct's backing memory by adding
> SLAB_TYPESAFE_BY_RCU flag to files_cachep. This will allow to locklessly
> access struct file's fields under RCU lock protection without having to
> take much more expensive and contended locks.
> 
> This is going to be used for lockless uprobe look up in the next patch.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 76ebafb956a6..91ecc32a491c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3157,8 +3157,8 @@ void __init proc_caches_init(void)
>  			NULL);
>  	files_cachep = kmem_cache_create("files_cache",
>  			sizeof(struct files_struct), 0,
> -			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> -			NULL);
> +			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> +			SLAB_ACCOUNT, NULL);
>  	fs_cachep = kmem_cache_create("fs_cache",
>  			sizeof(struct fs_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,

Did you mean to add it to the cache backing 'struct file' allocations?

That cache is created in fs/file_table.c and already has the flag:
        filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
                                SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
                                SLAB_PANIC | SLAB_ACCOUNT, NULL);

The cache you are modifying in this patch contains the fd array et al
and is of no consequence to "uprobes: add speculative lockless VMA to
inode resolution".

iow this patch needs to be dropped

