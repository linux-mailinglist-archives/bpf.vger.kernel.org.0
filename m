Return-Path: <bpf+bounces-15506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9017F2579
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4811C218A9
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD719BC0;
	Tue, 21 Nov 2023 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJKTKnuE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1ADA0
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:44:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4009257a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700545482; x=1701150282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1p/Citb8MJZ5QAFEOZWbybfEP43i7Y7MqEsGtlUowTs=;
        b=BJKTKnuEUjVZ/yNBUgIK40j/HZPaOtGjZaV62gzN6ldzSyeOKlvwRC4kLzjFH5UqPf
         XTJjkUOaMC7g1Q1RaOcqNKgJ9ZeofXvN2Q1BHKbbzNBt1Eu507RO0Tw4C2vlbSUWxeVJ
         xaKckvg3yX5nqwBZBIP3DSFJu6jo3NcBJwd5xxbG52+X/0U/sJQnvG68nxTEbBLOFKow
         7Jl+HkoD3YcGWzKUjshL8aVI5Ru4fke2Hkfya2xpWTIovc+QBNZG2BFSUdoIMPJWktUU
         4te62bWMMvRjX/tUFvLtDfWqqvTCoVu5Eq5/+YV1M8rKCFnelff1LV5K1qSlpkJxZcZb
         deSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700545482; x=1701150282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p/Citb8MJZ5QAFEOZWbybfEP43i7Y7MqEsGtlUowTs=;
        b=R7FSpELDnEMFNeLuIUGffs9d2WD0aAFSuJs18RlyIw4njqaLpB8LCL6Q2cGDNsOdn7
         Dh/K9MlgEsfjTIfMHUIQOMlA1GonjbXQDh/x8Eeh1PhbIoxA1PJjCt3HkYYEebHz7xc/
         1MsTvYr7fByppaw9ZSRVpNp9xxtl4Rj46OfABoXAegXJOGPWWVao0R3K49J1xhYim98z
         fKdy12SjHLZbhOL99B/REz6VY1f4nt5wAWHiQVupHh3Ke/Ha0PDhLr60BHcwvaikMcXY
         DkUZmV/JLWWiwzfzvXSX4ScO4gdDwF6YO7sTl5oHzUciAptqbo9jATAdGFBYorUkRs2q
         y61A==
X-Gm-Message-State: AOJu0Yxwb2bgPz/2FCKlra0/5t5ehcOSBbFDbjqZt5rkxX5+QFohpegt
	6JGj+9Ejk3uWaF+FaKDP1sckrgCWo9I=
X-Google-Smtp-Source: AGHT+IEj+hJpXYRrf+pQjdIhHT8w/FOtiXKxEh1k24thOqa8zQ4y0svVpNos7lvoXGxNf8Zjm+q9sQ==
X-Received: by 2002:a05:6a20:244d:b0:187:5302:4b2e with SMTP id t13-20020a056a20244d00b0018753024b2emr12503812pzc.41.1700545482492;
        Mon, 20 Nov 2023 21:44:42 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8eb])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090aa38a00b0028328057c67sm6298351pjp.45.2023.11.20.21.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 21:44:42 -0800 (PST)
Date: Mon, 20 Nov 2023 21:44:39 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Message-ID: <20231121054439.jdnkoz4doe7jtdus@macbook-pro-49.dhcp.thefacebook.com>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>

On Mon, Nov 20, 2023 at 09:59:24AM -0800, Dave Marchevsky wrote:
> +void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)

should be static?

> +static int task_storage_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
> +{
> +	void *data;
> +
> +	if (!(map->map_flags & BPF_F_MMAPABLE) || vma->vm_pgoff ||
> +	    (vma->vm_end - vma->vm_start) < map->value_size)
> +		return -EINVAL;
> +
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());

why? This is mmap() syscall. What is the concern?

> +	bpf_task_storage_lock();
> +	data = __bpf_task_storage_get(map, current, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE,
> +				      0, true);

0 for gfp_flags? It probably should be GFP_USER?

