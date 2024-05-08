Return-Path: <bpf+bounces-29012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D38BF499
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A2AB20B20
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B18BE7;
	Wed,  8 May 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAscNMCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2ABC133
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135752; cv=none; b=dpnHBkZRfNBFCf5gtPpJft0nOXZKdSRF0fF7/xPzXQISZpbQyXI5QZAZmYKE6IEC2o74MoWugKn5stOAbT8+Nul4j/c0TbDp2eS6LgiIj9i3A6KNLpGDPQu43AEG1nyX4pr98SgNOmfdeoFbdXmEn+pJ904kGilRUTKcx8Erd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135752; c=relaxed/simple;
	bh=osgX8tjFD5SfpMkUkJT1oW9YIAkBq/7BIgG/GoWsw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssHFhZpJgTb2UVaKqbS3RIsJtwOrIBsPYnrWOPym7TidGXgFTGFOscrxLQDiakf5+800gmkYJkbVi/k6KrlMMLAPhzEZGcIsNyGN52T69Sj/V5+PC1EzzccW+2ZBCxuwBlFh2PoElqTIOGHyTE5ua7DTCXodufzCXg1SOnDDI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAscNMCa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so2932096b3a.2
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 19:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715135750; x=1715740550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6UvHjV4WW7tio3LlaL+r5qi19qe6yV+hJDoyzpWlBY=;
        b=XAscNMCa8D2RFo0KwormPiyhC4pELQujv9y2IqbXN/mfcsIb+w+VXmcpLe5AP5PGr/
         1LDeRzEIpC/1dSbYhr6jkfPO9SN6NGd5oAzqnQ9KbtE0e/Tjf6rEv0n8TG+RspNSSa39
         n/U7nENnii/d2qcz0VMwVhS2kOJ0YZ0JF7MSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715135750; x=1715740550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6UvHjV4WW7tio3LlaL+r5qi19qe6yV+hJDoyzpWlBY=;
        b=PTc5wRRqbWp/dpEHfKNBfm14HpcLjVOo2n9u0jWJ6Jn4l+1bmhzWjWMSGmj1Jpt/iy
         izhrAxnX6gB6M/JEZ9w1IOdexWyuu1rlxGgFnlRdI6BQhn7tFc/sSm/gNisM1YwHCB6d
         Lw99ncuAlqRTwWdO55DnbTRZV4oIBBpsB0c/36gWlRTmghyPYVfIJ1Zm8n+AruN6NhDU
         DVQulQrENNU0Uv2d+/btb0HMhUOZd4pcEuzqjmc4QwoObdWOCrbk/3jDmYZQo9TZHRWI
         pEteVgx5/Aa1UJ59JzuoNtnvXetbIqzjf6zMa7X3QnbZMXn1K+RadHoakxwIOcHvrB69
         5UZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtHIYU37bghz6LEWoZROUIvIny2gsmGb5cu/gND+KUk7579D3y0mCcER7qxOJoyJNfhYCO7h9fx9+oNKsQQyFdmyY
X-Gm-Message-State: AOJu0Yzw6E1gfZonnnZAi5IcfvN9ypcnzkmaNPlXuonFM4vF7Fi6AMIu
	yHTkhflw0eFBay9zR3/k/EXZ9Uz4E6ym3nnR6a+UYgW2CqOdc+veJnVzALEUI+GWjTyJXal5nyE
	=
X-Google-Smtp-Source: AGHT+IGZ5rKp9Bo1YZOipsIloa2Y6dgP8s+sQDK3hSBjVHW9BNLfSWaoMbufoCqj3FPGcGeLAL+6Lw==
X-Received: by 2002:aa7:8516:0:b0:6f4:7297:7bd with SMTP id d2e1a72fcca58-6f49c2ade2dmr1384621b3a.28.1715135750244;
        Tue, 07 May 2024 19:35:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00230b00b006f2909ab504sm4792305pfh.53.2024.05.07.19.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 19:35:49 -0700 (PDT)
Date: Tue, 7 May 2024 19:35:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com,
	song@kernel.org, revest@chromium.org
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
Message-ID: <202405071930.A3022BFDC7@keescook>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>

On Tue, May 07, 2024 at 09:45:09PM -0400, Paul Moore wrote:
> I don't want individual LSMs manipulating the LSM hook state directly;
> they go through the LSM layer to register their hooks, they should go
> through the LSM layer to unregister or enable/disable their hooks.
> I'm going to be pretty inflexible on this point.

No other LSMs unregister or disable hooks. :) Let's drop patch 5; 1-4
stand alone.

> Honestly, I see this more as a problem in the BPF LSM design (although
> one might argue it's an implementation issue?), just as I saw the
> SELinux runtime disable as a problem.  If you're upset with the
> runtime hook disable, and you should be, fix the BPF LSM, don't force
> more bad architecture on the LSM layer.

We'll have to come back to this later. It's a separate (but closely
related) issue.

-- 
Kees Cook

