Return-Path: <bpf+bounces-74055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A3C45B8C
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A376118907E8
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3035301480;
	Mon, 10 Nov 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V81ddc2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FA2FF649
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768134; cv=none; b=Du/NqKYapuSfWDxRfHfUNKp6u9oCwTgU3qop6mVZqIF3XrzdBl+c/ogmplmLdOGG+VaZZpV8W0M2DwuqjCkd2JAlKBMBsenVl/8ghx1C18T5gVSZ4SNpJQr/ElEkbZU+HgqeMDfwLrWknNQSdVGx8qUGmG3lFA/SVe6WlLlBygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768134; c=relaxed/simple;
	bh=bw6QasuA8KeZgfQP2n/F9NjjLOI9T9u407i64LyA4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xigh1dAdDdWj8s5fM7ykUATd7hbiVEvclUXU7IBTqZVFP5daJqTknOWmDPWblMHNd9gpD8KbWjrOBChL1/HsIK3YJ84h9/28RQ+eVrM6EQs/iO0sVANqgCFS+HWSvJ1LSrDTTIwOblQfGYjMToEoObs/Ynl3ci4KsZlkOSPpOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V81ddc2q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso4756775a12.3
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762768131; x=1763372931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=V81ddc2qxiRyTqCzgFZIZ8VateSKEepBtEeHhkhJRYWMIbeNYZtFKGbBfmQ+kNJ0pI
         vfNoGO48VVKoZ5p+wto6BQkLMwI2mTUSN8T7kxqunTPoqV/HC0Hx++AKHY0IH8ZVfl4F
         3awoP5efGFN3YTdaHQqNUWIOJmOWKOSzxOxdc8RTRLl1/77eBYm6ABRef9wt5wLEAsYw
         jjV1sGafv1NRMsjYslQd7nNppLaKavP+rmQuOzOLXsLkh3kVhWVB+xV1HUEi5DEcqg3O
         EJ9I1bsTi3H7OXjiVoB/7rEdyRqdI8zCFB3DIuwY18qR4tGbNPvNeaCxxg9he4UZFy56
         Enfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768131; x=1763372931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhIrfg+ZeGmHHXgRYjIXkWVaO+GMicaDEEBop0R1M78=;
        b=fqmxuOvz37GoRlwTC3RcZXOq4yYjuwF49yTbUQ7i+SfBJwyxTqG0TOWezo540cH6hN
         NEIneTKv72Pltwvy0oE7La6a4hGojD/5oVd64RL9XrvOEwGPLL9wPwDLs58q9YKnKLNE
         WBXpLikH+kJYkAdc8bz7RWg2cAzoKqzGJ43dsU40yU1AW47Qwdhz6LyyxT8oBcTiQs7s
         h7dDOTJafPImgnUkOCFcJ89nFtllAz997JZnetuRORTbd4s0RuTOk7/v1q0iCRORkOO9
         ymlytunQ7AomSzCx4Y1PCxso/9LdgmKZwuQh1UbUBOCRmO0eaIJwBh+BENfCfR1QPoxc
         a5mw==
X-Forwarded-Encrypted: i=1; AJvYcCVu3wECtvLebVIgWCdhhvP/lgCaAgg3nDfT36aGwJsEB/NbuPajhBDmQ/QZy9SONupz7fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHk3o11QQqlKoxTU+Id1UwbDa86HeWSBkmIMBTaW18fdfn4m5
	bw1zlnYod9bcqzwOXpYy458X/DNNDxkV592kQzyrFZdy3zgMVgsdEsasDDudYZdBeLs=
X-Gm-Gg: ASbGnct3Ji1dYEeozyAnk22DStEl7JA1fpTmULV+xcVFTU6UvqVaBHJArlk7YLaxHj1
	YayXhRrkesIN+tmDb0F4rAIgg6zdtJ0NacjcRrz0RyreUkXxCVSgL02iGU0gFP4ZyOUaD987r4s
	8Zy2Lmu9xMBtDslmo0GWZwRT59lVADj+UBoyiw7UBcYmFoAK3w6MEre5Fx2J3lPRp02qvxhy8+q
	rpLRjuOASndfXXGbsJpYK8H4GFRjKGlZfU9K3rZeUasiEC/wuVE8EM7xsiRo9LBhyHU29Cn9Qq0
	niPhPOSNhHeqzVlrMiBDOw3XZ+eEdgCz0w01bKUJfLNrFiKKD6LSgHIQ0kJlbs9OfOSyDHqtWsG
	7W9nLWnxDYvEfIYm0cmR2L4chjLZtCaw2tcYmW46cFGSixButxfi1tXG2siKL8wRwtITGboRJPa
	vdk52fvzi5Ei7wXmwcLBoTOqu1
X-Google-Smtp-Source: AGHT+IFxQkylFq2Crr8V5DsL5/o3I3bsVnjZJeM/h5I99Cls23cajzpMg5CawHlhDUEoe8P5BasDOg==
X-Received: by 2002:a05:6402:50cf:b0:640:da69:334c with SMTP id 4fb4d7f45d1cf-6415e80fc71mr5848770a12.35.1762768130923;
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm10864916a12.14.2025.11.10.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:48:50 -0800 (PST)
Date: Mon, 10 Nov 2025 10:48:49 +0100
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
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
Message-ID: <aRG1AX0tQjAJU6lT@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-13-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-13-roman.gushchin@linux.dev>

On Mon 27-10-25 16:22:06, Roman Gushchin wrote:
> Add a PSI struct ops test.
> 
> The test creates a cgroup with two child sub-cgroups, sets up
> memory.high for one of those and puts there a memory hungry
> process (initially frozen).
> 
> Then it creates 2 PSI triggers from within a init() BPF callback and
> attaches them to these cgroups.  Then it deletes the first cgroup,
> creates another one and runs the memory hungry task. From the cgroup
> creation callback the test is creating another trigger.
> 
> The memory hungry task is creating a high memory pressure in one
> memory cgroup, which triggers a PSI event. The PSI BPF handler
> declares a memcg oom in the corresponding cgroup. Finally the checks
> that both handle_cgroup_free() and handle_psi_event() handlers were
> executed, the correct process was killed and oom counters were
> updated.

I might be just dense but what is behind that deleted cgroup
(deleted_cgroup_id etc) dance?

-- 
Michal Hocko
SUSE Labs

