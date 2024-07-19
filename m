Return-Path: <bpf+bounces-35041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A94937255
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEBD2825FF
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012943AAE;
	Fri, 19 Jul 2024 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T/WZXoB/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2E376E7
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354890; cv=none; b=uooMw0n790s/y8Ob6PpHMZ3UvGF2SgNAEbucvYp9njmL02eK/WABfMC8Q8OAG0viWimZN4HembvQE4recZ3G+gBZCUMNN0Zj3xVlBwCHjVixS0omXI6WoeCH9t1G3IwIDtf4/MDC7zdjGxia2T2s7NzoVZ1Sz42LaIJQBm5C6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354890; c=relaxed/simple;
	bh=K3kRa8M3XjJ6TYCBzNSI7QLaEzBmwYjbaWzmaybCoBA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=NmLbRAwUvdp7kRSIATRfd5f0Ioa6lgC6q98OZiim8JmuSmCRvvx+SMvqurQNH3cxMHTcQX9BQK7i9fQnT4wV0rSgjprI/FFtiBkmR61RalxSRWQjr9J02dJe/+S3Cu/cFRMVgX+ZQgZttM//0mOYBKnfH2xToh1FMLvHnvlEqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T/WZXoB/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79ef7ecc7d4so54991385a.0
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 19:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354887; x=1721959687; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=T/WZXoB/Uk5dXKxdM91e+evI9UA50w4YJkvGfiR+KicDHnrBLsl7spyVjtojoh9j9e
         iCHR6bD5sAJXIlFsHuWrttE4dC2MAqvT4yuDWQZPVv7gEZ/5uQZ3WDmZk4H48ucmH/t4
         QwJoSBjQSGvWGH4pP8QEdzEuAKxqiFhgPcNj9zgMfo6F8VfgYoykQIn6mp7KxBuI3AOc
         2eGFnFm63Pt7h3rk2pAvapCKTcjJtW5agpD0ZP9S2YrFdYKurghIoqCZEPU1+k33JGSy
         Lsi5Ag1JE2Zy1HnnsldPiHemkZ7W8W/zj+lwSZdOcqks7yVpZ5TlFdzmaXebJ0zB/30y
         LYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354887; x=1721959687;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=BmmMd33TO+IWk1bw0QnyDabUmZ4c39zfbdJcIE/pA7f22gJXugrVBqJvuWCDBOOczg
         yaj1+NrDlA8uaxTx1JGpaR081DdksQAaRwTlvsdv9nH1glD9aK2EVcVgm1QD2MNigujs
         /coT1Cl4hjkeMJBB4pMVvPubMf5wlAp3x833I2DnKL0eBi+cfv5qy+vWgIo4MtZkG6l+
         O9jk/wqQ+M5pH3OMciQJQw4+nyfbV193tQra9lS3clS7T59KAPcyCYh1Nw976xNCseLk
         5OY+vQX/kUJwWKLy1XmtdfHFibM2mdDLSLKBRiljFBj7Htxsxm8WZUloFlMtDFYHCWhu
         HLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAVScCaBfLurKEkBYdO1ZM0M3/CUwGfQmg62efywE4VxzOdCpI6iXu3+gN7BHDiQR7eBe0rQPi+u5Az3BMHKOtFfHz
X-Gm-Message-State: AOJu0YxabEty4o2WFLiQ57iu7kIcVfMEdh7BWwKZtSLhDlTiJqB2CpM7
	2D1/5cedqLbX+EdcUSZUV65/KW1kCaR/JKCWZotRD3L2Tt/X2o3hx7yP7GYmnA==
X-Google-Smtp-Source: AGHT+IHJXqsEfMvaJ3I4voV7h0JmzEBLz/Y77YU9PWIwttNlLAz95UGh+qmMP8iEzkPgMVaZTYkx+Q==
X-Received: by 2002:a05:620a:4014:b0:79e:ff47:3307 with SMTP id af79cd13be357-7a1938c1fb6mr351466485a.8.1721354887484;
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198e9f7ccsm22476985a.0.2024.07.18.19.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:06 -0400
Message-ID: <35bc63dac544edc75c25b8dc6c8c99d0@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 8/20] lsm: Refactor return value of LSM hook getprocattr
References: <20240711111908.3817636-9-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-9-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getprocattr to 0 or a negative error code.
> 
> Before:
> - Hook getprocattr returns length of value on success or a negative
>   error code on failure.
> 
> After:
> - Hook getprocattr returns 0 on success or a negative error code on
>   failure. An output parameter @len is introduced to hold the
>   length of value on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/proc/base.c                |  5 ++++-
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  7 +++++--
>  security/security.c           |  8 +++++---
>  security/selinux/hooks.c      | 16 +++++++++-------
>  security/smack/smack_lsm.c    | 11 ++++++-----
>  7 files changed, 33 insertions(+), 21 deletions(-)

The patch 07/20 comments also apply here.

--
paul-moore.com

