Return-Path: <bpf+bounces-41010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E149910D0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC2B2600C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F31B4F14;
	Fri,  4 Oct 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWqCXwYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6141B4F0C;
	Fri,  4 Oct 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071894; cv=none; b=c69aBIE2dev95s1hnkNL9iUmzPC63t0fMpFYeZlljB7qN1zcPcVkb+Ih8oWE54iqcyC3/1q9vPqYWuIiJwI8t0OLyBI3VEABaXiXgWvT+QMwnjIMZ7sgMRXATo9vaSJ5JqHTtW91UNg9llACK8K7T/RMCCQ0+8n/UYgj3bXJGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071894; c=relaxed/simple;
	bh=jGYwHtJUP8CJSvTmfTnBLjBMRqwmyxvX78RTi0aovuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o57ZU5Bux57Q0D0042s/X14eLrDBXwTCvum4PlbHe3+2lqOu07kBT1UHyVpI8o7h6vRqSq4Qn0X9LRW/GwfFipyU0gS5RU3VU3PieVPC1xDRqHDgobw26t115aq5ZUcVqD8CQrz82yYIEn7JM2kBeTjIeuvsIRJ+sx1qFmo/bD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWqCXwYz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db174f9050so691531a12.3;
        Fri, 04 Oct 2024 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728071892; x=1728676692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGYwHtJUP8CJSvTmfTnBLjBMRqwmyxvX78RTi0aovuc=;
        b=DWqCXwYzs9qQWa+iq2SyEoSXT+f1xXxT9EeYNDDjPeD1OPw1X41m7BfcLM3tHyq3Qq
         FvLrf5dGs6wRmi72RkjV8S0RRMofjlS1O1L0F8XxTtq1S//1lbA7GIHOslmDYA6yqpUu
         RWjWxxIE2MQQsfrvk0EnO734Ug7zMCDI+UIg1mLnp5rjK9Yt4jPGXa3Rs4wgj1KJnbJW
         kdFdmyZZE6Jav/xOg8E0LNkfOaMRY8oVfMV6nXUF8oaP9JdFjfWZ8YNs1BwQfzmjUZnE
         TYEkwqxIsEGTMWdLlN/c+9IdKB/gQy3AU0AEldLQv0lpI0jB2CahXKvOm3mfA8Wa7Pfs
         4bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071892; x=1728676692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGYwHtJUP8CJSvTmfTnBLjBMRqwmyxvX78RTi0aovuc=;
        b=krn8WYOCEM2K+Kvm3uxDFR0pSMPVnC0tiJIkQNfetcOKcpOvtbf7bqGS7KMo0O9Pvy
         gU3PIkT9bxKJtgy9XfF1BntWs/iNzSgDq+skl10thsH7x2CLJnvjfSIdtAIE/V9W/JoW
         oF51Qx06zrbfipCwL0PVr7wKTHhfeQV96rAh5cxPinXCDdgjK6VUV+SLnbyFYL6e1mR6
         jENE8/kgZTiRoY5TfvIop0auP85GeM8qtQFZRTUtDGlIMmFAxDcgj9HNFzNBx4f25yrg
         5Sb0sNUHh20Jb5xQwdxdfVIT99LooK00A5Mtbo7gLdugG7dCknTKji/FOZg6QNajK0ee
         hK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVSGw6wXTt1yaGZr1x7zW+EGqgjuXiJFRIomQYl/p9MVFixEzaqYHfmT5Sx1PfwZkbHONzKYpOa3yDEseHBOI0G7aqf@vger.kernel.org, AJvYcCVpDH+0tH7iPBf5+jWwHmOnikWTepOILzpAceXE0UvI7lgQFLtig4Xh+dh9To78+YVbz/Y=@vger.kernel.org, AJvYcCW52r/TYVNNZoGaybhEBBXFKMcgqmF4SXNLV7qVJIYt/ake46PmgXMUq/VPiQYtEEjVkqA3VhuCwnFqJmQW@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsSGgCCbHTkbgr6VEu48zGJVMkSD1qUdQrCL0l1SETr0X9hz/
	SifkJPvZKs5p918xDmM8i2Lgg/KqE2O4iBZOIzggNdtr5/cEsB8jC/xvREq4ooDjujVMowU9sEr
	m5ZP1/T/1owNJwE3BCOGRpOHI+mc=
X-Google-Smtp-Source: AGHT+IEWzIrSjrNtEvKMO440O7fdoRp62ef79uEnejMaUjsk0dIVB65DxKQYHNe6tCIKxr+tm1ziHTzX0Fh2nUC80Bw=
X-Received: by 2002:a17:90b:889:b0:2d8:77cc:85e with SMTP id
 98e67ed59e1d1-2e1e6391a8bmr5375612a91.37.1728071892548; Fri, 04 Oct 2024
 12:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001225207.2215639-1-andrii@kernel.org> <20241001225207.2215639-4-andrii@kernel.org>
 <20241003-lachs-handel-4f3a9f31403d@brauner> <20241004-holzweg-wahrgemacht-c1429b882127@brauner>
In-Reply-To: <20241004-holzweg-wahrgemacht-c1429b882127@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Oct 2024 12:58:00 -0700
Message-ID: <CAEf4BzY5fy1VVykbSdcLbVhaHRuT6pRNYNgpYteaD79vRM7N5A@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 3/5] fs: add back RCU-delayed freeing of
 FMODE_BACKING file
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, mingo@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Oct 03, 2024 at 11:13:54AM GMT, Christian Brauner wrote:
> > On Tue, Oct 01, 2024 at 03:52:05PM GMT, Andrii Nakryiko wrote:
> > > 6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKING
> > > files to direct freeing as back then there were no use cases requirin=
g
> > > RCU protected access to such files.
> > >
> > > Now, with speculative lockless VMA-to-uprobe lookup logic, we do need=
 to
> > > have a guarantee that struct file memory is not going to be freed fro=
m
> > > under us during speculative check. So add back RCU-delayed freeing
> > > logic.
> > >
> > > We use headless kfree_rcu_mightsleep() variant, as file_free() is onl=
y
> > > called for FMODE_BACKING files in might_sleep() context.
> > >
> > > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
>
> Fwiw, I have another patch series for files that I'm testing that will
> require me to switch FMODE_BACKING to a SLAB_TYPSAFE_BY_RCU cache. That
> shouldn't matter for your use-case though.

Correct, we assume SLAB_TYPESAFE_BY_RCU semantics for the common case
anyways. But hopefully my change won't cause major merge conflicts
with your patch set.

