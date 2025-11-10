Return-Path: <bpf+bounces-74052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B7C45A5A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF421890C80
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BF2FF173;
	Mon, 10 Nov 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XY3ljPL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684A21D58B
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767088; cv=none; b=TDOvBWyYwMjB16P4guYCjmVu/OwrPGPQrcjxR19+ehh24cgurI81QsT1zicT4qWGPAOC5298rYl0QhgiGd345k0Jipx+nkCRnLJ/CfEk+gn291Om2uIqJ9Zg12H0TydjJOpNVUSpDAqGubFHi9BBc8JNZ9Rv4/YI3AZGv5+IrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767088; c=relaxed/simple;
	bh=m/QU9kQD+zT8DY4zIk3dOkJ1ZJpquGhCSedUwO/1RWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0aSdjyd5KT1I6bYpt7+EQ7bsCTPcHdJmKfn0POhhbQKaMnYjLFfHj5sP3573+pehIcq2j7NTZLTq9KNjxSamjTG28zJCRjC3CN8nFggMeKjhR6egyHeGIYjFhVlRH9eVObHPJqvh2XOwVWMw9LUTCi64EUufRYsgcwAzpmL/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XY3ljPL/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso5676751a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767084; x=1763371884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=XY3ljPL/xz1PQLkTjPFNbhtiMBR5eX9KKnZQv5AyRYFMxUWJ6VLil4Y1DxchnMjhll
         Z6Thdyt6ZTKoDRU8m+7LF+v+WIZLu0MNuQ+l7vb9kgrYO+2Raz37L9sl14Yg4kLBmTS6
         Xqc7RBHzOECH85qlwdkAKDh1VsrPu01H5K8zYypoBFUTUJjNqq9RUk7rvb/uORuRgdhJ
         0/fPp+EhkZOnkdvs7O+pN7NtttOAw9/OHDyR3QZcKp6ry65UbYDMTaUkguZWzSwRVRNO
         Q4o5zW9ZpgYFS5tnZiekPs94bXeFh4EAh2ZxSQLhxeY6yOrZgeAADEccH0blVkqIDSY8
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767084; x=1763371884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amfX240/D0izGpL77kjzwIZmsTrj0WyJRpbOWOmEfmw=;
        b=Q6WvM51DC1J+JiIC4Pm7V8AnLBhPW33vwdz3roumBo8OcP/qTxgc/jBEcemxzhDq/m
         Y7RHYT5TC0DNtZPMh7xk4JOLUhprZPeLD76LQOaiSzCxT/E5FWQVHW45zEQIxZ0lx/Iy
         U+4OMZEteGJ4DDuAtEDnrY54ZoyuUbNvUDOilsvR4UUFMKvCM/HZVxum7oXqILxroTYq
         tUxdYY7V6KsKBseAdqpmsIKk4nZPO0SnXE1LGeoMYKgZhgKpx/qyemx0LfkIzEQPgC1L
         i1tJ4nyFUuqAEOBarNSFj6BaZuHwUPSPPb5ZOyA/7VPlsOH3WIzPoEG6waME3tJMHJcL
         36hw==
X-Forwarded-Encrypted: i=1; AJvYcCUD7nRqJb65vXBrCxi8voRJxptBcRAhUUDZwNWrPcWVq9K0LpZfFt6KBxyOBL5vb/ElFJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxY8Y48ANaEY44eKqlWqIY7fMD6hH6+2bm80d0gZiujJaiGxgU
	R6YxjtrXkByUiw6Ik+hQCZ50OE2W3SjKVeo83uyHnTLqlIywQBAr251hAeZseSBPkFo=
X-Gm-Gg: ASbGncuJO5i0cOAk8bA+Ne7CNePgxipJVRQ4Qp6B28PaPX40LVtAMdSn/b2VLMJlmhe
	nVjdCXVKfFCb4PhM+WaZcxVe+fEGD7/EkPDDlcpriwThfUZAwqX7o2UQqaWGHrQ2cnvTgK++WRY
	14I95h8IuCvza1cK5tYww52QZN5jWasBNTl6MRDUx2HEXa1lBjMDVQhux4ofh8PcqsjgokENz3l
	h6pWpmM8Son9WTSP4BJtz4oz/R2R26xb++sLPQoHJvdF622sdhy1vAcBz26bk50JHZTnYpYuWsv
	vM2YSdINf9hP6HTr1fDRppoB67lGSQInf1fqUa1TVntSCDxajZUy82eVHQ6d2PIcPMIccTo9GLI
	GrXlql/XsPbYxx/+gsO7fqAHljMrxClWylkiZ0EWWsAjDAN64EjfdI+NWIMRbtRQDlRU0rAJq7Q
	0o8YUkJtZS5XrBpw==
X-Google-Smtp-Source: AGHT+IE/txm/8jWMiSkfFFCpyrIegQ7dxW+BtDPga3eQ9vjewsDB6p7h+vXBqAcuv9gNMfcv8ZCOVw==
X-Received: by 2002:a05:6402:278e:b0:640:976f:13b0 with SMTP id 4fb4d7f45d1cf-6415dc11776mr5564134a12.12.1762767084330;
        Mon, 10 Nov 2025 01:31:24 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64184b6c7e4sm3018332a12.24.2025.11.10.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:31:23 -0800 (PST)
Date: Mon, 10 Nov 2025 10:31:22 +0100
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
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
Message-ID: <aRGw6sSyoJiyXb8i@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-4-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
> Currently there is a hard-coded list of possible oom constraints:
> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
> Also, add an ability to specify a custom constraint name
> when calling bpf_out_of_memory(). If an empty string is passed
> as an argument, CONSTRAINT_BPF is displayed.

Constrain is meant to define the scope of the oom handler but to me it
seems like you want to specify the oom handler and (ab)using scope for
that. In other words it still makes sense to distinguesh memcg, global,
mempolicy wide OOMs with global vs. bpf handler, right?

-- 
Michal Hocko
SUSE Labs

