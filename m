Return-Path: <bpf+bounces-74271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD26C5106A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9845C3A5D2F
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AD2EF66E;
	Wed, 12 Nov 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hEHdimdQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A62ECEA7
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933810; cv=none; b=BCT0P91N/3w3wxTCoXJ71LwvNSxjCS5jXHn2rA3mOTLc1E4YtuLWAUG4mnyHw733q7xd2SVdH9kb929eW/Dku1iFviFQurMoNGqUhyzZ2FfYY/CM3J51A57vx7cqBwSeQsm0TViAYVzDh1TTgEr2ohwGQk5rJd2bZoEsvwr/NRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933810; c=relaxed/simple;
	bh=vQGEuOEI5CcliGhoSpli1L+Hj54P/8blyd40sP9gSxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdDryfraQGBn3YBk6apNNfR+Pb3iiXejqtm5oX/DM8+a6YEvlT1RLohksZnRVBomBK50PZTb6DG2Mi4YmcPkhuqfllSSfEhjhjs5XKw6BFXX7HrbNYfn/O99v7VwVfinBIC78A9junGUi3RHYgADNnJG/Vy0XEE0nw2GqZ/9NbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hEHdimdQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso706901a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762933807; x=1763538607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipL3Z/6wC6GRR63sS5vId/ptcyhjHxEgUXfHm/LakcE=;
        b=hEHdimdQqrJZbhfw9mvGHyq7rfhp84Azrx0gry1bPRHTdG8f22gD2OL0GA2oGBU5Gf
         ekAfxxBO4vHF56sNu2h8bQq2IM8btoSuuTlnPATXj7/Jk3Z8Z1QiU/BnJdVgibbr0BI4
         T5mbbqn8lFDxNp1J7cLdJ/p7F49KY1OXaIxqK9eWVHOxiB8MK5TpI9uJ+XcHPETqhb8G
         xwwyTIFjEu3d7uLd5nsbndZXfPog6fGyKLJ8oJ6UL4N6Zw3P9xf9YRLAZlSe2oeZblQD
         gWaKa1LJWRF0DeXl9elOZFE7jKzh2EEXOdKDe642naCoXfMsr/anzAk9+AITTOAryKF+
         VxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933807; x=1763538607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipL3Z/6wC6GRR63sS5vId/ptcyhjHxEgUXfHm/LakcE=;
        b=HdOEAm6CZSgSHc/Wh78G3K3EzlzB4ONH8T20Rw07otKFoCt0YnVl52wBefpX3S3T64
         w8zZb+L781WEsPuQC6X4xdyv2xfb/GxJB0rIPEegd0rF35UAm+ctzLoFFHfNycxf8w21
         UYnU7cA9hJb2ouRIDxwKhc6o+NsnEflXNHp4lUqPgHsWkP4KuQALiUeyoET4zZrHPZVu
         12IO48qUcCr9TsohO3OA08aKZDQf6ynmvrDjudBan90mHbz36DJkBy4dVMT2qHE27Ukp
         Jt8xVlOAW6RvIBdzkCV8CikByjeG28vREGYxB9G0ZRVS/oGr1FSyg7+N7RXcpbVzKFUL
         zcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW89LsLmTnACBbwVSxFmcsxJJ0JufIdVGhjQib/sgdZUvphBtQ8IkawXeEwZJuPouueDpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccX1PxrmEx9BPQaEj5eNfu9Ajx+1m7LEJcFgEEPLxskpfVGgr
	mn0kmkk4e24T2dPD3WG+YfSGMnmoybgTet5cx7mCgpZse1aa+R10M8pyNzqTTU1oNBg=
X-Gm-Gg: ASbGncvzZ8KyBYFkhp4N8pa6x74RLWWw9iXAy/JQMY5LpV/liznBqNorRq54wqaX89u
	ouI/Mf0+6qEPrnJpjrDip2ed3hCKzW9wY5bpJ7KlN46FX3arXV+3tRZUmPMXHj+BkP7/D3Mhu0l
	4j8Sj52GFW3zX9To5GZEy6xv9C99hCmO9/0/WDHewzkKJ0dfPDbVTA0P2TKIpbw3dckG7fvf3tD
	Tx0kY2rhOwVV4bq1n2NAqsKEo/1yxlYOrRjJpZ/S69v0FGhvYvgXf3MXKirpAU/eeuoxsULcL8i
	/UYC1SiZquzUSMWD1hQ05Pd9aO3I8s+JOH/XM3RQaam5AbOsTa0Xrc2x33IuMu7sE9hw+DYIffc
	EsarbculNU37EtHfM2dYtcXWv1zJ8SfZopiqJNPA04wQ/D5/c9HT5Abpk78pj4v4X5AFnQ87aPf
	Jmb024T0ZS6liJ5A==
X-Google-Smtp-Source: AGHT+IFkrb3GSMhhW1bzYaSDD1E5kGgIrUWkWimOuuxU6/CLGbZTn7iNA2cGrP2NCWseV/3pUPbNoQ==
X-Received: by 2002:a17:907:7e8e:b0:b73:2bc4:ebf with SMTP id a640c23a62f3a-b73319649c1mr168849366b.2.1762933806298;
        Tue, 11 Nov 2025 23:50:06 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm1583946166b.52.2025.11.11.23.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:50:06 -0800 (PST)
Date: Wed, 12 Nov 2025 08:50:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
Message-ID: <aRQ8LQWxoRF0kgXk@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-3-roman.gushchin@linux.dev>
 <aRG0ZyL93jWm4TAa@tiehlicka>
 <87qzu4pem7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzu4pem7.fsf@linux.dev>

On Tue 11-11-25 11:13:04, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
> >> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> >> an out of memory events and trigger the corresponding kernel OOM
> >> handling mechanism.
> >> 
> >> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> >> as an argument, as well as the page order.
> >> 
> >> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> >> can be declared and handled in the system at once, so if the function
> >> is called in parallel to another OOM handling, it bails out with -EBUSY.
> >> This mode is suited for global OOM's: any concurrent OOMs will likely
> >> do the job and release some memory. In a blocking mode (which is
> >> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
> >
> > Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
> > sense to take the oom_lock based on the oc->memcg so that this is
> > completely transparent to specific oom bpf handlers?
> 
> Idk, I don't have a super-strong opinion here, but giving the user the
> flexibility seems to be more future-proof. E.g. if we split oom lock
> so that we can have competing OOMs in different parts of the memcg tree,
> will we change the behavior?

The point I've tried to make is that this OOM invocation is no different
from the global one from the locking perspective. Adding an external
flag to control the behavior might be slightly more flexible but it adds
a new element. Unless there is a very strong reason for that I would go
with the existing locking model.

-- 
Michal Hocko
SUSE Labs

