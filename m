Return-Path: <bpf+bounces-73143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6EC240AB
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B3C1A24904
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D203321CF;
	Fri, 31 Oct 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qa0LOxbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC032E757
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901567; cv=none; b=ezU8YXrSDJ/kYEqDBu1qAOGNTLxF4DoXKpJxgs3y6gnJwfg4HZUUz9/IGJMsXXA4clw5UD6lru9mrzk6hgiAiPBNVOtDiJY4WEQKbSFPAva8PvqcadFCXFL6cKZPXBGRtAWqPNCoDGY2noWUa1MA1BZbb3N/9XDsd2ASIdtFDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901567; c=relaxed/simple;
	bh=ku+s48JLQC3eWSP8xQJFPNECjEvh3Mo/HcgF5mJuAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKMjDbrtfTJVTxz0OFwM7OyJEmpAZdD11DIsZHUvxKQDfudwG7qehmOLef827I1G3KnUSICz2EWA/6aWB2abUQ80IJvrepMR8QyU+K+dm3gQA3YNW2cuO01XjxCypxZLGdctJoIo4DMhS5YnrOpkdqCJFcn5yQLF8TtUVM8rhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qa0LOxbF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so14295365e9.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901560; x=1762506360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=Qa0LOxbFPBTIZ5cwkjkceemeoaDAvEF27VjguwYlURhZ2PL3DLN3BKqVlQepHUHutb
         cZ3jjSitHVmjW/ptrGxl0LMFy1BzL/MK1QV/GobRfyDX+rsx9g2vNyk7A6nIxtWK7DQM
         XI8U8HPDA/yw+bk86n4qo4IPX4RVPStvIT0L9aq9462QVqJAVLQYK1ek3/Vlue1pp7HG
         NrhsqA6uj+dLRbXdoAHFKyqL+yrK889PHMATq3eWmr/6eFRIJuv2njqQXiku02hVjy5Z
         6s8QFWQ+qAb91+kZsXHuY99XKNnDNoIL+yYIpRwKJzY035098x/kZVKCEQi7d2TSGlvd
         6Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901560; x=1762506360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=qBAfksZpMsFq2ibVd8+PWenm8ife20C9o5J9pVsH43TPJjBqnKx2IDPPpLKX6GtTUG
         te0gMp7EysxvzjYF16YbvasVabMy5iq0idXtIcRn2qf3nQL8XdPcFHZtfJp0rJZZdTZe
         Ehz90yKBjIKEO3TsP4JhEYTpqBVBntiyb9YvJjo3DO89RbLxFRGMtd/xjI+IkDOCZmTr
         e1R84RtMSVkfj9Ln3ztqO+vsakomJ6yVxD5VM0+02QGG4oUHIR3tRhttQYdoPb2wmJEr
         Hz7lH3aObqUyIKjxLfaMB0+Aho5uMDBYl5VRn+G0xrDiRoVGWNzGmdmZ9uvR5XHu49rs
         yp0w==
X-Forwarded-Encrypted: i=1; AJvYcCURwqadVe2zP8lPxkUoIGaBLr2HpttzDeHY50r1Tw28gHlV3GqcJzbOFJEcgQ/BDdp46zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pz8HSQTlG1Of9Dmliq7h6HAjNg5SH3d85i4w5v63+x3sG+I/
	T2OFdQXF7v0S4SXhjBEE9Xfq2WSjtWEORaJUyfa2/R4StqYDsjjKzBUXknr+STun9Vg=
X-Gm-Gg: ASbGncueMD5Z0AgtxrpCIsCpTVXoCbeq8eMUxQGWN6GQViRbAvtZt/HDAHoLLXrlW1U
	sFadPD5iGMNNotwaNF9hPZyf2cdfLgSfFAye5dcc8idcRlqXdRW9SvwqwL3bN/EXvI44Ee1c3mj
	VUgw3ugEyao7uIFKFEkjVL5ktVd1sBpeO2ukrEH86rpT/d6ZIa8snSbYkMP/+DjmG8Macf3CZd0
	KFKETF0/ytJ+/+OSJga3In0NPgHECMbakJxxgx0QH1G2zt/8iomnCS0MVNGPNLEHI9qqQ8gHKzj
	Cpxwsr2gVzcXG04GsZcaKzJ7gmTjd8+ciFrfPIZmI0E1sgT8mKBKFI5icDp41QppA+BXPA75GXh
	O0y4RaLxcfjyIpYPbKzEvCItt8PsZIEnQdxtrDZWT429fgeVUOjaeqtiPr1spfEC7dtealmBx6D
	S7uGK9Dl7lE8FrUuKjP0p0SHiY
X-Google-Smtp-Source: AGHT+IFDhjw/NQy6gXd0KrwaHxidybeaclTmSKM+ZycX2IB9hql/be8JKkXi3tpvF4ocbMgb128LQQ==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr26457735e9.31.1761901560280;
        Fri, 31 Oct 2025 02:06:00 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fe5719csm17619365e9.3.2025.10.31.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:05:58 +0100
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
Subject: Re: [PATCH v2 07/23] mm: introduce bpf_oom_kill_process() bpf kfunc
Message-ID: <aQR79srdPzyUT9_I@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-8-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:10, Roman Gushchin wrote:
> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
> to be used by BPF OOM programs. It allows to kill a process
> in exactly the same way the OOM killer does: using the OOM reaper,
> bumping corresponding memcg and global statistics, respecting
> memory.oom.group etc.
> 
> On success, it sets om_control's bpf_memory_freed field to true,
> enabling the bpf program to bypass the kernel OOM killer.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM
Just a minor question

> +	/* paired with put_task_struct() in oom_kill_process() */
> +	task = tryget_task_struct(task);

Any reason this is not a plain get_task_struct?
-- 
Michal Hocko
SUSE Labs

