Return-Path: <bpf+bounces-67616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B6B4651D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB20A5C750B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F52EBDC8;
	Fri,  5 Sep 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuhDmD+Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45052E9ED4
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106237; cv=none; b=lGc1KnBgoKO/X3gWsXHGhhXzUqH8iDsOvIa29oLlcWkFQ64kgzAbVCg0FQkHQ2mJGCfglPnSDw/VulG7FG7okKK8uAs3e0o8kvHyQGE+MegpcxaGpxGBSIW5Tq+DmDtaM4HHxpxjAZzbBahX+mSwRU1yuEtoap38vUABKYRhmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106237; c=relaxed/simple;
	bh=2qxjiecdOA4RF6h3Y0hYloSjHErvoYXsbOiReTTNtXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyvOSAe5xIusMEbWM1l2MFLSl9bERh4X+p/4CHJCcy6Bn6W61oDbztdXPHcnJLkKdzZ1wwJ+kmrtJYWYY9rbwXyMGa6WUq00IDEjTQd21vEMCflMWbNqluR6Kh+tTggBaOqJtwPTd7RsmDAsOITIahepUx/QMiYJeYzHXp5/HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuhDmD+Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so20715e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757106234; x=1757711034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPyIINiU/ceaI2cj/Yt91Ki4eqt+oAkeBgX7XlUsaZI=;
        b=LuhDmD+QMwq7GfpTab2Bl5qMacvc6ry+gD4v4QelOW0OuQLwkNuzLEslJi5YbGvGQe
         m9hJb2Dn2G2av0vPCeoHkrlAZ089EwEXSzyMPvTqTJHiElTkD2otKOEKW24Hg+laN5R6
         JyGtwLiQBx6Bi2DBE2hn9Srv2omVGNU6Vra3z+8foaR8SAThjaqTlkGpyu9hMMXxI883
         sjTBbrSJ0y/N/fSrSrffaf0xdCtXAEIUJIoe3AteIpRKLeC22tKkgQ+JHYRI7fRPnilm
         ZCLsTygR8nFlNg2QUQyrN0U9WOT4O0NvfFuXBjNGGyE0XCLImp6HntqUBmUE/ubNzTbv
         g7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757106234; x=1757711034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPyIINiU/ceaI2cj/Yt91Ki4eqt+oAkeBgX7XlUsaZI=;
        b=MJu2Naer+k5OLTnOwq7LZbvKMQaNrD2Jdtw9rHh64q8OxqyZeWwfPJexNUm2m/KTgE
         WpeU90HPZQ/EbVEfyVuUq1Oy13ktoo3Z//AMA8mBebCPE0imdtt9t/N0mVhkVmKW7KJd
         g8PPJ+VeTLhV4NUyXLyzxzctR6Tu/BlvzMlEVRZeTgaer0R/TIDcoLxm9IInE/aG7JcY
         sE0v/TLB06oGDEW3Va4lYSz0o6PFc8+8THd3lhqG2xkO3H7PIVfAkUwy6Rz7UUSFWZCy
         g08+vGnw5opScmEnAjrryflDAfADVGFZm3NkDXlbeQe2FkHC80ccL6/o0eYC+7Id9bfZ
         b54w==
X-Forwarded-Encrypted: i=1; AJvYcCUEsWkya37JPC6PMcaF+Ay4pY1EB3cCfFs8EsV4gArcLCkqudzCR6FD2sx+QM8Zt4r4fvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4b9UiEwZh9ccsHT5s7KwQkW23ATb4kFXGUq3S9ny0Ms5GJL6p
	5xYD9QCAvXI1sTkLYfth6pWhVxBgHqIPN5cH8E1kS1T8n++lRy91brI4WGXvLzKYohNH7/Nj9qL
	fic4UYszc8jvShnxgyBXEW/ZzabDAFANvYapvXdkG
X-Gm-Gg: ASbGncsS20tmXiH1nIssN4tc081jC50cZsaTF4K7C7aRHgG63Qp5HugEIeQQFrwTKY9
	ZAo5hjs0gAm2tVekrEUKU2eFr+sWNSJNPlFQmEsQpHSzk2AoJJAdwoUqDKoPiyzLOOugodYmzRc
	l5rbcmfA+4cn3xSWSzChbAur6TPQHokqHU/vP6nu9ZCNDNojq+98pPZA3WD+VLTuJEGxtJBjHkb
	FdqJzDu0YxAvCEcj3V7LL92kg==
X-Google-Smtp-Source: AGHT+IHfnLuS8/hFfgk/YHQsdhLGdiMAZxHIYm7G3lXTwcShqcMGim7FOZX7jFPvq8GAlqHgICGQ/V2KHajcGPUVs4w=
X-Received: by 2002:a05:600c:4f50:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45dddad796amr298505e9.6.1757106233773; Fri, 05 Sep 2025
 14:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903203805.1335307-1-tom.hromatka@oracle.com> <20250904175138.GA886028@ZenIV>
In-Reply-To: <20250904175138.GA886028@ZenIV>
From: YiFei Zhu <zhuyifei@google.com>
Date: Fri, 5 Sep 2025 14:03:42 -0700
X-Gm-Features: Ac12FXz4r5dUSwU8ErtpQOTyiN1SLsGRcsf4tz3TSVCAhgm3LT_uELjv0duJZaM
Message-ID: <CAA-VZP=ZDsEESH0XJLiOp0CEBVR7DQn+dC82PdWzLqVTgSB_HA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tom Hromatka <tom.hromatka@oracle.com>, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, sargun@sargun.me, corbet@lwn.net, shuah@kernel.org, 
	brauner@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:51=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> Looks like the only lockless reader is
>         struct seccomp_filter *f =3D
>                         READ_ONCE(current->seccomp.filter);
> in seccomp_run_filters(), so unless I've missed something (and "filter"
> is not a search-friendly name ;-/) we should be fine; that READ_ONCE()
> is there to handle *other* threads doing stores (with that
> smp_store_release() in seccomp_sync_threads()).  Incidentally, this
>         if (!lock_task_sighand(task, &flags))
>                 return -ESRCH;
>
>         f =3D READ_ONCE(task->seccomp.filter);
> in proc_pid_seccomp_cache() looks cargo-culted - it's *not* a lockless
> access, so this READ_ONCE() is confusing.

> Kees, is there any reason not to make it a plain int?  And what is
> that READ_ONCE() doing in proc_pid_seccomp_cache(), while we are
> at it...  That's 0d8315dddd28 "seccomp/cache: Report cache data
> through /proc/pid/seccomp_cache", by YiFei Zhu <yifeifz2@illinois.edu>,
> AFAICS.  Looks like YiFei Zhu <zhuyifei@google.com> is the current
> address [Cc'd]...

I don't remember the context, but looking at the lore [1], AFAICT, it
was initially incorrectly lockless, then locking was added; READ_ONCE
was a missed leftover.

Can send a patch to remove it.

YiFei Zhu

[1] https://lore.kernel.org/all/CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNi=
Eg0qbD3w@mail.gmail.com/

