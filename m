Return-Path: <bpf+bounces-50532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B40A29648
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA98C16A6BA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF61FC7D5;
	Wed,  5 Feb 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="baLTt/6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91B1DE2A5
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772859; cv=none; b=urUfdCKfOqw39NZk7p+JunmM2mHYh1xr9xotGJBQMa6dch5JrKwl9rN6CYERo56VUEjvxqm++v9QCahdchKuHMlvj/3XHQci1Df63lpPJHATGsksOfSofW70uEDb8OxxAfAGdEHy+m2u/F0a94Oh0jAMIGLA5c9W+9okCsqsGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772859; c=relaxed/simple;
	bh=tdoY1i90ju1unj0uM/Z0RGWwvasjfrSxqElzTIR7WUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sy/bYsv2T6M2HNy9YMxkKsioiLHb6Mya3Rg/dAaAOZzLypAiKATZ8wi1zLrwuZ91FM+t+xupdcZ4O9E5ihwe3w/NW+AssMOJuhurdc+ZKHcjDiyPVHQmA9g9MpA6v3jK5k1kwy+ONj/h8yh3GFy8VWRna/X7ndMtwW6KGnS55m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=baLTt/6b; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7181022a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738772856; x=1739377656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdoY1i90ju1unj0uM/Z0RGWwvasjfrSxqElzTIR7WUk=;
        b=baLTt/6bRgaKznaYD3+4p95edipdtisQyiwpAHSsoFi8p3nKKPeMeeYlRw9l5dPgBd
         bMrz68Nf2fmoKs/ZqJA1epop3qFiWxyFDnUc6GHYoZKzYxCc7rZOKmOY0952fitbkzSK
         FCgaPBOoh5k8O6rmTmxKW/IZ543qB1BXIMXUWupJiF709Mtv2nPuSzr/g5hENE8er0kF
         S4nsTMZlgXyKlL2P2JrdzmIB3huZPPADV8dU/GCOwahyus8T+1mEeZ37cAVa871F2sD0
         o2jTfNU+dleyNvibIwnZ/oWBiYOljbpv5q+vUw1/CniTQ6WxLGsNMsdNC4sMulBgMGbW
         pCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772856; x=1739377656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdoY1i90ju1unj0uM/Z0RGWwvasjfrSxqElzTIR7WUk=;
        b=JR9TFt+vGsfwLW9RM/RRWNPr6mqb5tTGhREIDqz4YMCuYxivgxAxMWSR5EEPXLaIRV
         3hUhNBtGY5bVsXe9n3V8Q36s6t1t0ZAd2s1aCei6UjZh4atY1qP80CVulfQdVabq4osR
         9omCeMzcRjJvnXxn5uJB4NCT/GvT/ifQZmhVpxbh/CI0bEh0lknd/C2X58rQwDE3yAAI
         pJ8H2JYnHDhCeuIT9hvvZiDjtsEK+ll0y/j16n4OiwafwZERsYw3U6Tu0Fup3OwbsNRl
         xRqs5StPHPI/CV6GR7ArN2cJO8n6rewk04owaPIFtMYHJGsOfcC+6zk3gzzzad3XhYcT
         h1gg==
X-Forwarded-Encrypted: i=1; AJvYcCVHGag4ZAU/vmoTC7xHyjTxQEat34XO9b61FDnuzi5zKiztH+R5plJrmjzfD8c0m3l3SOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve2jmpjx5QEN2KDJ+IIfvU/STxexTSrrQNRkTIXJk6VZfArr8
	DsdCqNFFCGFomNM32UrAPZhA6T+vvJV3R9gqsM5rTkJGpKxnFVdxvBOxm2crw6cU1n8G4sr8q88
	jI+MCgI76Ab0jEd0mfl7dcxdedhOV95R0iGkpeSBKh+uLPTzy
X-Gm-Gg: ASbGncsbDwXzbSp5xaMIkieDjr0q0uaJo//f9JQ3ksw4OZI+QORRHAXEiYv7xc0AguF
	FN9aRjlhoS/XhAp01G8/GF5LW+ICva4v/xD69VMT9O3Ye05oFWoKo9JBE1+othVfG7BMW8Ae5dE
	E4uA5BMVaQpMIfNVM=
X-Google-Smtp-Source: AGHT+IHuSTe1jqecC2udbMtYfy/r+k0v0zk+7QoPqkIsv59KrXhLDThRyKb2AUtVbCgXv8oZOIsy68yx9cE2L+/vzHA=
X-Received: by 2002:a05:6402:3483:b0:5dc:c869:da65 with SMTP id
 4fb4d7f45d1cf-5dcdb77fa6cmr4092657a12.27.1738772856081; Wed, 05 Feb 2025
 08:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6JXtA1M5jAZx8xD@debian.debian> <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
In-Reply-To: <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 5 Feb 2025 10:27:25 -0600
X-Gm-Features: AWEUYZmoSerUw6tvWbkyLN6zihGSwqtYkEu3_13W6QY2l_Vo79ir4dFKrMcGvnY
Message-ID: <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 3:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Let's not invent new magic return values.
>
> But stepping back... why do we have this EINTR case at all?
> Can we always goto next_key for all map types?
> The command returns and a set of (key, value) pairs.
> It's always better to skip then get stuck in EINTR,
> since EINTR implies that the user space should retry and it
> might be successful next time.
> While here it's not the case.
> I don't see any selftests for EINTR, so I suspect it was added
> as escape path in case retry count exceeds 3 and author assumed
> that it should never happen in practice, so EINTR was expected
> to be 'never happens'. Clearly that's not the case.

It makes more sense to me if we just goto the next key for all types.
At least for current users of generic batch lookup, arrays and
lpm_trie, I didn't notice in any case retry would help.

best
Yan

