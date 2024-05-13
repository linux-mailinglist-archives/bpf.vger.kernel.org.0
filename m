Return-Path: <bpf+bounces-29660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE728C4754
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6C281980
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448E544366;
	Mon, 13 May 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="khGdRp6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555E41C69
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626897; cv=none; b=ouG1sm8lhmYoHaIhP4ZIIxcNSWcRTDFcb3xQMxMXXGhVq6OT/W0WKN+igO87+7ZWsPk6XP0lPWwM+rBeBI5XXIXyzFPJ7EcqAUXKl1pZ1Aa8lGoCMVsdERtJkEGR9PmTxM5jXntzwJRN9C3vAYwqipaAwQWD1PKQKHvnSd41GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626897; c=relaxed/simple;
	bh=ixoeKydcfDxDp9l8VxDd8/Lo0R50toRCOrZzUO6iIoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtOObekx5+SOPQT1VDeR4F9as9IIvZq5ZzKTpNNEWNzXPlJK2VBWQL+inuAColtVk3eCPuLVi4poDJWnUnjCIlNH18U21FoFlx6LND95ZjdZL33o/yIoJYHWlVILoDJtGVfQEDCIShGMTEqCzDJCA+sxGkm75pYs5445WoHACYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=khGdRp6x; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4178aec15so4064040b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715626894; x=1716231694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIo+xJMGqulgfYxJlVNZdIs5O+IlDFivYbvME+JTurQ=;
        b=khGdRp6xcedMPqUkdjBCXK4sdSPqJmU6vARYFj6Cj5Eq4eIXBzQiLY70ZHPcGgXbMk
         bmyzIRWU9xWv7mFCcZXVry6+DKdUldjy0UDRs7CBzo/WZ52pmfJTzHaPpLt8fF2t+qHR
         oTflnLjoMTywzMbSWV/FgJA4eXosN+giu3QeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626894; x=1716231694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIo+xJMGqulgfYxJlVNZdIs5O+IlDFivYbvME+JTurQ=;
        b=icJqFrbiy0EC/IM7oeIJgCmi6ne2dtm/DCmQjZMC6uPC/RrLvcPwd63D30Xn+ulXne
         ihmcNFhDK180PaU4ZTytmXX3GTP59gnLZxrejzwH/3v/HUJgClkMvjFNWl1nKBrwN4CO
         leqlXwxk1XKdGtqqPJFJ6JSGz9od5yB60lwFG1JNwQm/ZcVzFQx8W/pp/KgapUZjV8WO
         /CRYHaB5vf0moFptGqx4v0Ayt9p17xiJawrcRNTbgB34QvDI2A/S9HNdVYJ6nEnWQHZ6
         duXR4z6Noqm6QPWqZdUO8GnpteZyGFC4g5/eZWscafZiz2XlxBh0C3iPCnbN+DLXARnb
         QmyA==
X-Forwarded-Encrypted: i=1; AJvYcCWxlJk87TqAT+MLlF+vIQjR2L627F25nMPdiJdGYgLHHLCI47j/YkUAKJGG6oGgks7iYeZxLR8qa8VgciBHP0WfbZYb
X-Gm-Message-State: AOJu0YwBrPpINI2gKsSDrEVfNjt00V8+CErnz3rZ1EZ65XAv7gSz8hl3
	hp80Fra61Tn7QPyW9g9T3tkeDQe0CNdW24cfCjtzZOfQJ9C5FLgyLQromG0ilw==
X-Google-Smtp-Source: AGHT+IHLLlqHpsImBJBeiowPCBQfnTvm1nsNSIHdpywN+PvsZO8TvuDaxpXhDa9p8QQIqvhj9BXDMQ==
X-Received: by 2002:a05:6a20:de95:b0:1a6:b689:8c29 with SMTP id adf61e73a8af0-1afde225151mr8650429637.61.1715626894512;
        Mon, 13 May 2024 12:01:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a819e7sm7714864b3a.56.2024.05.13.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:01:33 -0700 (PDT)
Date: Mon, 13 May 2024 12:01:33 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com,
	revest@chromium.org, song@kernel.org
Subject: Re: [PATCH v11 4/5] security: Update non standard hooks to use
 static calls
Message-ID: <202405131201.8B145A5C1C@keescook>
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-5-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509201421.905965-5-kpsingh@kernel.org>

On Thu, May 09, 2024 at 10:14:20PM +0200, KP Singh wrote:
> There are some LSM hooks which do not use the common pattern followed
> by other LSM hooks and thus cannot use call_{int, void}_hook macros and
> instead use lsm_for_each_hook macro which still results in indirect
> call.
> 
> There is one additional generalizable pattern where a hook matching an
> lsmid is called and the indirect calls for these are addressed with the
> newly added call_hook_with_lsmid macro which internally uses an
> implementation similar to call_int_hook but has an additional check that
> matches the lsmid.
> 
> For the generic case the lsm_for_each_hook macro is updated to accept
> logic before and after the invocation of the LSM hook (static call) in
> the unrolled loop.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I think this will give us the flexibility we need!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

