Return-Path: <bpf+bounces-74054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F54C45B71
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978853A1FC2
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBECA30216D;
	Mon, 10 Nov 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Af66f07N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F3019D8
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767980; cv=none; b=I3BcTV2CE2GFOOOd7Rsr/TcIDvEjCUn7dplXnNQGAYGKr3EIq6vg47LNyLi0dzdsAS688tYduNVXtIiO/f9SM7PPMymcyVfB5gUBhDPwtpRiQFC/KfKf3l/lpFewzDfVicr4VzT5idHAfci9/v1nZYtPLEAIPXpKxHiOGAY0O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767980; c=relaxed/simple;
	bh=NMx+80RAtRR69xjJFiFNTuk6xFPiPToOmJjCwv8y9D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTOXIjYYxmTweSSaBVEQI3ioxkW882bJ7j08svtLbU/CGD34q/uFxvLoFnSNbF/CkLOFABZKer9KczHGQGSEjW64uhpoNLsA3NijYcFRX6zlkrvHYNcb1VgTmW/M5lES6MHiWDDiUraqOSfTzscuEta4jAeCaQMT79aS1cxwcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Af66f07N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso5700526a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767977; x=1763372777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=Af66f07NTIFdPiwJPK3OpAEebehX3C63WUeCT8aMrKjlXeyPR95kfKf4evVzlI0q85
         NVEnXFpJnNl9t6U5VnFZKTAkjE0Ay7RdhsT08RRh+nt4Cz0UcKHD+JnmonIcFrqI2QzS
         dyTz3j7GQ8FlfOsRtAApdXSdgh8Y6MACXWEN0dWSiiQsl0saBfbb8lzemhx2YWZ2v5ak
         MlHIj4QjckjjFjqcbv87nlc7WXduJqj3BhM3uKCpHpLDN1yhBlbqCuuc4Cd8RXf3EcSs
         Cio697HK2urzJXhXJUK54/fesnsGcKioiAueNtCnbOrAfa51hfXCqe//ZmIT5P69BVHv
         2peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767977; x=1763372777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=oPj4EoO7ue282PTOp0nfgX1kMZKmsywE7mpoCnWb14MEY93DLvwYPGs9H0/DPNgjGO
         Vfx56Cnm0c4aXh9YwhVVJHWDPM8UBXdxDnzVki1haHu1KPqoP52GNPp2niHYh2pXMbgt
         yArvE6efO8K/QS6eyH290X7E/nS79sGmNKt2vc4LFa58vNCEvu+HZeoUwlXJJvR9zJUp
         7oTqt+ktVtswKt4o18GF7/BOHmPSKwXNxHFHd5A4/1ONyFi5AOTAHJvRr7KckzF1nzlO
         lyV9Wqq6JTUnM8uXct4shqG7sgY0Wdqrz3KoGcgnstrtr159PLxFswQA1+wOyTGuQFw6
         1IiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZJiLkSiVPiU6glBPci25VjcWfnVFo7XRvNsB4kC4hoQnex5mJhR8EL4r7NHkknShBwZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4VtmhKoHOC+x+uwsK09v+RS0tdUkeKfk8yUsbTJ6QJ/AhPz8
	pxAOsnSA4pJePnrMP47+KLUAIZn0Fcrrc7rZFZ2cv0nEqgJ+nsMmKzpG2wlVigCEeig=
X-Gm-Gg: ASbGnctZk3VZS3RuetxYxV3+FSQH7LCBk4xkBdlTgvf5OyWCiPExoiL3Cn/BYivQymR
	+yDay2nOFUkHbPwIb0/FDIgcFaMf/zVSY4Otjfw9SCCEtpY6iqzaAbIOJDDk6/9y8Emh/N5+7lF
	sw9QUjuBDn+gTJlMTZ+p56CJLzfrwpZB6giH+Rw90VphnAlSVvuQYYRhqkpVbb/HIHSwJ/Hmnpn
	d2pne5wGoXnEGwdGECs1hnqOtZx0jX6fuP1DKnmA1lkOtHmNW1XFNVbtfFEOHjmPBtXqsTY5rkS
	TovaCvZPtlcEfmcNqCXed+DnYfuMg2nRYFJpMnFnHN0nxayydDWtzf+We3vqRHW971tOLhrR+5W
	m+tOOExvjg1a0p+fB3bTC1tfEQWuqDEq/afp5Lgq4n3cSdkQm5N3S/ATv1CmiC3BrKZUeUlsJBu
	oiBMQ7MevoEIIqdA==
X-Google-Smtp-Source: AGHT+IGmZmcainr9lTW69kXNHob9h7gFoRrMJ4orD0WaJEzcosAR93nxuffTYpmtgx+UXuB6Sga00g==
X-Received: by 2002:a05:6402:1d55:b0:640:ceef:7e4d with SMTP id 4fb4d7f45d1cf-6415e81207dmr6218186a12.32.1762767977000;
        Mon, 10 Nov 2025 01:46:17 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm3896343a12.8.2025.11.10.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:46:16 -0800 (PST)
Date: Mon, 10 Nov 2025 10:46:15 +0100
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
Message-ID: <aRG0ZyL93jWm4TAa@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-3-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> can be declared and handled in the system at once, so if the function
> is called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.

Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
sense to take the oom_lock based on the oc->memcg so that this is
completely transparent to specific oom bpf handlers?
-- 
Michal Hocko
SUSE Labs

