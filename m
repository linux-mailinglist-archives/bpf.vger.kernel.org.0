Return-Path: <bpf+bounces-57604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BFAAD2D0
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27991BA87A6
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EED145B16;
	Wed,  7 May 2025 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rth6LzWH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218813D8A4
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581346; cv=none; b=SEE+tQvYKn09HPcqp8yn12RMy2DDQHmAsdoNIAJp6KlhsuQnwaDs69mQGvniWduez/hguBDx9+k7yBXZQV1UE6hW4OpL/894jB/Ar2+0N1bd3h3w/43N0JGW8HdCCZ0GG+WUHSURoOyg6P4zCyNildnF/YmQ7wi/Y3Wbo43+7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581346; c=relaxed/simple;
	bh=u9Gok75nz8QyAYOi5wwWhnOiTWkM9CDCvqKYbYtfsv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT6jNBfDX+HxhPruxq6v6AFJXF9HK+T18kMpHCw2rsD2FOKYUhBiiiqyb5D33C7v9nWOSwv/YphfGYp4Xxk/ROcwNNQ8ZT7aewMuRpKMT/l7Jgps+RnIkg1QHbsaL0zlx5C3oA1vZRIdH7zAk+JI/cVzd57wueQFboRlY+GjTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rth6LzWH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso9004295e9.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581343; x=1747186143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Gok75nz8QyAYOi5wwWhnOiTWkM9CDCvqKYbYtfsv8=;
        b=Rth6LzWHOQTeP+s4lQutwv1i4/D5CfcOVsH0R5bjDi0RLoyL+DquG5jbUPm1kPFKyB
         ocplZL7+WeLU9pw5T+3XGVikBb/SZlNwquylvydZ4805LFMtAvd91hPaSidry5c/VviG
         jg8TT6hUYaR2MY1JZoDefMSeBGk+KK5gME05oj+UZs4C/XWHHK1QYjnf720d3qhGTTq6
         eEEzE5nUzuTH2NuqqnV675LM+jhIv5lcrRO5zq7X0o7q2xqZacReQRs5j647gqMCy9G+
         VvA0DoES6hCjLA36cBoEMi3Sx5z6Y0Moe9oHLBh9bRxbyMsqDnV48RoWbIR3iUrRgZOD
         TVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581343; x=1747186143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9Gok75nz8QyAYOi5wwWhnOiTWkM9CDCvqKYbYtfsv8=;
        b=HKB81ah5UmXNmkaz0cU5emlNGwQREPTsHxeLr9zCqP18mFcY130zUGR9DqueuIl2Dm
         TUP1eaB1urLFl2WOaI78jJLoUWAwQqB0xl/3xk0YGP+eCVzmT6T4ZtU4iO2eMNqdzURa
         jPTA7Y9qN67HJSzdRDXM4nfSz4WqNVa0fizL5Y6mvPvJGCENXbr0srXYUFeipl3YuRIa
         C/9V8zIb+D9Tm3C+P/UEHXy3RYToEYzl6AwJNYZhjswab7SPZB+axryfmJg6jmAoBNn7
         IIVroDGdCjBkYS0WQ93cjEakGjo6vK2uj20LlG2uV9DVWkIvUusyPgtSF9GyDfLNkTlu
         cdQQ==
X-Gm-Message-State: AOJu0Yzy02OSvm80sKFGja3seP1JWnxsHZUKYX8VvJ7ISFVmxMv+joyK
	Sf2ysBjvP+tL+HTWLd9NWcpECF8An5P9y/wNpZDm8L9mOSf5he/OGN4K7FP5CUKVdUhouL8mc9V
	CSI2/2zDN2gWl+V95bNtiSpX0fvTdpw==
X-Gm-Gg: ASbGnctdffATUHBQAcKHuMMfJqrsHwjmFgkm13/fHgFb9DdhON7P+8Idnx3NOujGobS
	ZIkXqptVvGsuwQOGM7yEhBxHc1pNPIjLPdzW6nKGcEh5Du44IZQSIhiLTDNYKCTfQaTvkib5qc+
	XaWSg2RA+G7Pm8yA91mCgOn7Fw3vyYgU6xQP0Ysj2AmiiTWyls1w==
X-Google-Smtp-Source: AGHT+IFKBvMTztEPKww1CwykRba3/iVcS0VlpY+XsSQTMkXG/HAsQTWVixHGqgEE1HjQcXFLHP2Xkj9j7Yf/zTMEYRU=
X-Received: by 2002:a05:6000:18a5:b0:3a0:b63f:c88c with SMTP id
 ffacd0b85a97d-3a0b63fcbcdmr66701f8f.58.1746581342918; Tue, 06 May 2025
 18:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-4-alexei.starovoitov@gmail.com> <5e708851-6e8a-4ec8-81ee-55a55d1e3d2c@suse.cz>
In-Reply-To: <5e708851-6e8a-4ec8-81ee-55a55d1e3d2c@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 18:28:52 -0700
X-Gm-Features: ATxdqUHk0QN3Hrx5oH7Yo2q6CPmS5iaj94GdLq_KnqRr0DCmn7KuAlaTjx4ktj0
Message-ID: <CAADnVQLwdsoYEKw5stci6bP5aFCxZLMs6Gq-Wae=KJ3+PjysyQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:59=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/1/25 05:27, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce local_lock_is_locked() that returns true when
> > given local_lock is locked by current cpu (in !PREEMPT_RT) or
> > by current task (in PREEMPT_RT).
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> On !RT this only works for local_trylock_t, which is fine, but maybe make=
 it
> part of the name then? local_trylock_is_locked()?

Prior to _Generic() conversion it would make sense,
but now it will be inconsistent.
Type name is not part of the helper name.
It's local_lock, local_unlock, local_lock_is_taken.
local_trylock() might not even be used at all.

