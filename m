Return-Path: <bpf+bounces-40404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D119882EB
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C4284D38
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602A1898E6;
	Fri, 27 Sep 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUMMlhzu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B3187547
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434732; cv=none; b=B/3Pz0YatPsG3q+giJmCFFmtMwN+meA7du1WVhZ2vuL1u++QlOhiSmZqaorlgYGWItL+b2Kbg5VAbqJaB1uO9XjGuwVja29Ex7JfRpiF/XwRfqu2ePMBWIzn5ChH4YQOnEf6Q5atTyjDqhGtKM9yu7ediNhfGbATJEtf7yZtzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434732; c=relaxed/simple;
	bh=UrFSOcg0Bp/hJicukadGJKz9v3YSyWIlwdrgbZL3R+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dz5Y9x+/r5yFWUXKOYHtVx8zHprdLxqBemUjHKtrCZIgSnKIHa+vWHWdHSUpuTqnnB2pEUUlxMz/OtZ2r965LKSJXZYLcDmgWMcf5jWkyNcGYoeA7fBYlY0CRY0+SsdQwRgQVbhlSH4/0Jn45FO/7+k+fuVsQp6+Zj8S+jw9qvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUMMlhzu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068a7c9286so20948935ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727434730; x=1728039530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlDfva4zyYqv8+dpVhRM/FQXaa09JRi6wxCATWUFQcE=;
        b=fUMMlhzuzgZnv1IywlkJaPvzH5DA+I8t6biW0kJ9ytDOU8x3Xt3qCbkyZl+jzx5Idb
         lUdGtUgrXKoKTrwqGGF7aU7CfpKuyNZAYO6sR+ab8GmUdVOPXKkzuxvx3O59wGKIBvt8
         cMN7hRoL22HaPqNQSKDVmodiR7Ni9WQwWOoGF1SJVNiR9Q4al0nV4mC3WtZD4S/6tP2E
         wzS8v0U5bqGM9yNV4EpcF08Bbzm9RoeCCw58eI2C/eFGmaS8fOD6p0lF7E9WsPRQqfCu
         ZGSbX30bXffXX2sAjIFmaZfrZOVPIIJr8uP5+GTx140HYzu4rjU4TlGVC3jvMdaPqw6K
         2Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434730; x=1728039530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlDfva4zyYqv8+dpVhRM/FQXaa09JRi6wxCATWUFQcE=;
        b=YiIIvnDIAtBqLbikVICrd1N8opunAJCbBc5UEIIbKVxugCRtlZFSCK4pPssMLH05/q
         MbiNpylh1ttbCu337KkOBaFesOXWcvuXUZpqfRNLzAEsfkHRvXGhNZ7pb41quyJRsBkr
         hl5WyMkhLcdJT8EeCi5bgk5P1+ookJ5Xu33kxz5mrDeYGpu07ecSKFfDQIWFkQ7cFLIh
         vIG/+pAdLuGdySlGVfQdeqYIXl+D0uvKnBC8KxymreZ8PE9Odp5qLhepgvJWpH7g8v50
         ZbWhTGtyFTp3gtSjGePi4pSzeW/PZedYiNuFOxbS50KjTs9qSPMZuu5CnogXGe2N+y9c
         K8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7tUprK/Iy5l7lU++BIsUz88+ddjfsJ6c7vpaGIHeu8CULl3JL5Suzl3Qmi3BsWj8c0OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppWrjppLdketlfssBSpBlexFpICgO/RnYB9rZSA74RS/fjDSK
	nV1b+YrZ2ufWzGPjrZRU+DCdyK6WwryUtuqG30xVW/ViB+bmz8Z4
X-Google-Smtp-Source: AGHT+IHc9zIwMjYXtzWASQpTmuOX4KsdwIKc879Sa9V4XDleBLQObsFsHKg3CCN6PZ0yFeDAqxXfhA==
X-Received: by 2002:a17:902:cecc:b0:205:809c:d490 with SMTP id d9443c01a7336-20b3757fea4mr47930725ad.16.1727434730214;
        Fri, 27 Sep 2024 03:58:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8ee83sm11690815ad.63.2024.09.27.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:58:49 -0700 (PDT)
Message-ID: <48e8e97225f8d022c230184ae27b1c1926778420.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Prevent extending tail callee prog
 with freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Fri, 27 Sep 2024 03:58:44 -0700
In-Reply-To: <0583343e-874c-4af7-a405-3e939a34762f@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
	 <20240923134044.22388-3-leon.hwang@linux.dev>
	 <ab4afb61e39cea42fb2ae2f4a2e134415417bbf6.camel@gmail.com>
	 <0583343e-874c-4af7-a405-3e939a34762f@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 15:19 +0800, Leon Hwang wrote:

[...]

> > E.g. suppose the following sequence of events:
> > - thread #1 enters prog_fd_array_get_ptr()
> > - thread #1 successfully completes prog->aux->is_extended check (not ex=
tended)
> > - thread #2 enters bpf_tracing_prog_attach()
> > - thread #2 does atomic_read() for tgt_prog and it returns 0
> > - thread #2 proceeds attaching freplace to tgt_prog
> > - thread #1 does atomic_inc(&prog->aux->tail_callee_cnt)
> >=20
> > Thus arriving to a state when tgt_prog is both a member of a map and
> > is freplaced. Is this a valid scenario?
> >=20
>=20
> This patch series aims to prevent such case that tgt_prog is a member of
> prog_array and is freplaced at the same time.
>=20
> Without this patch series, a prog can be extended by freplace prog and th=
en
> be updated to prog_array, or can be updated to prog_array and then be
> extended by freplace prog, in order to construct such case.
>=20
> This patch aims to prevent "be updated to prog_array and then be extended
> by freplace prog".
> The previous patch aims to prevent "be extended by freplace prog and then
> be updated to prog_array".
>=20
> So, in order to avoid the above case:
>=20
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index a43e62e2a8bb..da4e26029a33 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -948,7 +948,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *ma=
p,
>         if (IS_ERR(prog))
>                 return prog;
>=20
> -       if (!bpf_prog_map_compatible(map, prog)) {
> +       atomic_inc(&prog->aux->tail_callee_cnt);
> +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->is_extended=
) {
> +               atomic_dec(&prog->aux->tail_callee_cnt);
>                 bpf_prog_put(prog);
>                 return ERR_PTR(-EINVAL);
>         }

I'm not sure this really solves the issue.
Documentation for both 'atomic_inc' and 'atomic_read'
(used in bpf_tracing_prog_attach()) says that these are operations with
relaxed memory ordering. Meaning that e.g. 'atomic_inc' executed
inside prog_fd_array_get_ptr() is not necessarily immediately visible
for other thread executing 'atomic_read' in bpf_tracing_prog_attach().
I think that some memory barrier is needed (non-relaxed func variant).

But all this gets unnecessarily complicated, neither
prog_fd_array_get_ptr() nor bpf_tracing_prog_attach() are executed
often, I think that 'tail_callee_cnt' and 'is_extended' should be
protected by a mutex.


