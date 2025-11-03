Return-Path: <bpf+bounces-73374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178FC2DA1A
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9423D4E8641
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FC2749FE;
	Mon,  3 Nov 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cOd52XJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DC2264A3
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193916; cv=none; b=afhTFRd0+XEveHNY1iFYIkIDGNNh7lz+4yMo0frRYNrUl2hf69aZGbrFd+yECt8V5O0j0/9MaeMyqg+Tz1zeiJrD7r2yZLL73tkEhLIGNA2YWOrzpdF5q2+U6iGqSIccsrWYDw1wYT3AGfQixFCQ4ZrFuuiHsLa/uv0BFqLBvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193916; c=relaxed/simple;
	bh=URXNs5NVV9mjyIjpTFJ2nbkM6xeZY0uxMOBeg6vFH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWAgLmNo049LJ9w4oFl4ri8VsUB9vb0Uwl/RzB2fMcNOz+KXc+Be5a43bID/479TSk7KrMvo7nD9BAxzQw1AajYY9LMct4gs+9wLZLnOG4g6KcgfsjVQQpB7BWYIAwCO6/6DG/CLhEJRZRwb1G+6THXOLF4/bTeo9EhNJGXn4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cOd52XJR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70fb7b531cso189644566b.2
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762193913; x=1762798713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=cOd52XJRLZb8IO6129H4kd+jNXtLtqXDIfUbNyTnlPT621DrqSW7cJrsRhJOC1JjJ6
         7jRgw+h0rbmu3qfB++z+uE12q0QJeAOScF4U6tibhKHoiNRAyGUH8iMEl1qNXwHH5u4A
         U0eGwkOlgoXxkQDChytZV6mLW5IU5IwP18WLWLXidYJAN9NeF0b05PZkhe/zVVQAHFvP
         eGQxjXhNbhaR5TcrpQA2D6lF3jRerxH2CumgUjl8YgPKY1KIBVnI3pJREGDF8tejk72z
         HzaYuDkn0WLVvVBq8ndNJl5Cd7cGcQDTt1ZR71N4N3gMxTYT/msNy4ZEGIdsbrVcNyOj
         Jr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193913; x=1762798713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=ljnd/6aCRvW36lyY7GxSeVvYrEhjbWWhbghK2AxGMBaLojS5eHL9itdSmWqxl6BW6d
         9MYla0zX0RI759rnl8pyOHRGsxl9TLrmVaKN8NYQIgPddp1j2UDxgZ2EhxwhGJn1k+6l
         BQkE+fckg4mdS22suDU8pTfvm4NqsfLZimoxJqotLjQ+5BKefQiTCAvnneASv1r3Oc20
         CrhEWMg4KTt5BFblLqFHQy5iKYAHDGPR6nAlu746GVBxBn1p7IeBRCCuKhlhzz6yXJz2
         2Bu1zfmnynPAruadHgB7E97AwingtFmA4/M0XQdTVOaiF7yT25wXjxU4DRXt6nhD66DH
         GreA==
X-Forwarded-Encrypted: i=1; AJvYcCVYz2yq1T1mCUxvW0LzO2dYgWDa7t0Tg0Nxsz3lLVlM/QPERscXGu6O/FfX1T+ING54BK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvglIVHrthF0bOIf+d6fXe2voKOQD0d3guSdeCEA7DKL1iddbA
	uwfJeFDb3nUp3e584YSlmdgEhL6paj8gkzH+pEcmz6H90FsJZAcHf93zQY/eheS+ktc=
X-Gm-Gg: ASbGnctxdpZMzHN5uq/x1VcbTRPsMFC3EA09DKonP2VcoA7ZEazSbKXu6tF41BMjBXt
	g3C3KkvuvRnSiCbpdYT8FJM+yu6ArWe5b9Wd/AFFLYVq+sn0ace4V36C63piP0Kxp66/ewjkVba
	9F2ftO8qiBCEuQPIhgR+DWpv//l2oWEpvaxcXXXQPYEmcpt39f018qHwjcAZv0Z/zCNpduEBRnm
	sY+oN6SQ82i02T8dfLd3nTXxGlgqkooAqXc/mVR2MVSSid9kJmWk9I8uanIRo0bChXV+gMUmaC5
	o3N+e4gVG1CjdwEOEAUwAH3uIHfaMHqchCwc6kGdg6EtPq7mE1EbEcD+t6Qc6Eom28yO7yIxKeZ
	V8k4kH5cFtWAxcXmwST64qkWi7B6+9mEMKRcADnmplO6xF78kfZtUKN/7kdj36tT31XCX5e2cAI
	VjJ/T9Yx56KNFsYg==
X-Google-Smtp-Source: AGHT+IE2daxTlMOHk/CGF2RugDrn4nke6v1czkbTOpjMgsbAikWRjv6WYKeA3oTiX78nZbbiTawnTw==
X-Received: by 2002:a17:906:6a21:b0:b6d:7d27:258b with SMTP id a640c23a62f3a-b70700d34b3mr1435687266b.12.1762193912944;
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm1093828666b.65.2025.11.03.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Date: Mon, 3 Nov 2025 19:18:31 +0100
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
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Message-ID: <aQjx91L6IlG-qtjX@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <aQSB-BgjKmSkrSO7@tiehlicka>
 <87ldkonoke.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkonoke.fsf@linux.dev>

On Sun 02-11-25 12:53:53, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> >> The second part is related to the fundamental question on when to
> >> declare the OOM event. It's a trade-off between the risk of
> >> unnecessary OOM kills and associated work losses and the risk of
> >> infinite trashing and effective soft lockups.  In the last few years
> >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> >> stalls. In this scenario the userspace daemon was supposed to handle
> >> the majority of OOMs, while the in-kernel OOM killer worked as the
> >> last resort measure to guarantee that the system would never deadlock
> >> on the memory. But this approach creates additional infrastructure
> >> churn: userspace OOM daemon is a separate entity which needs to be
> >> deployed, updated, monitored. A completely different pipeline needs to
> >> be built to monitor both types of OOM events and collect associated
> >> logs. A userspace daemon is more restricted in terms on what data is
> >> available to it. Implementing a daemon which can work reliably under a
> >> heavy memory pressure in the system is also tricky.
> >
> > I do not see this part addressed in the series. Am I just missing
> > something or this will follow up once the initial (plugging to the
> > existing OOM handling) is merged?
> 
> Did you receive patches 11-23?

OK, I found it. Patches 11-23 are threaded separately (patch 11
with Message-ID: <20251027232206.473085-1-roman.gushchin@linux.dev> doesn't
seem to have In-reply-to in header) and I have missed them previously. I
will have a look in upcoming days.


-- 
Michal Hocko
SUSE Labs

