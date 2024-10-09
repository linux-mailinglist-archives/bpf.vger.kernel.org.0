Return-Path: <bpf+bounces-41483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426CE9975BF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728D11C22B23
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABDB1E1C35;
	Wed,  9 Oct 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBxCPJXj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12F40849;
	Wed,  9 Oct 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502649; cv=none; b=YKwb01Xh2gnHktWyeEvcAJ2eKUVs5Or8/JZXZ7Rg50HJVDGMV3jtiGCjD68HUunEIHJIgHT780nUD5o7uuz7FvPe/CBtMvuMp9u0Fi3sMvyv0o3eoXt9c5NfFZsXazgxJfkKvkNCCsM7lYdm1SwlnvzyQCX1SEMEIERL+cRcFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502649; c=relaxed/simple;
	bh=B0G8uI4hwgShGq+/JoLlhdBAjD3k55IDNeJ0SfYd18w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAHZr9H+uAJh2hXDMJC8/k9HWyfin/6tna9APOR+QOytS0jzMLOgYTEM2D/O4a2pc5BMInMype/Fu6KzStnD6uwJKzSvJzrpQrVxkDsfXD72x2ZvUildMuxbbczJvSagItCIMj/V8ZJF3pSd+Z/40fjs+od+XGINQev2+EFkgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBxCPJXj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so187502a91.2;
        Wed, 09 Oct 2024 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728502646; x=1729107446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0G8uI4hwgShGq+/JoLlhdBAjD3k55IDNeJ0SfYd18w=;
        b=nBxCPJXj/etTM/acDt/CILdJ15C661g6JWVBHkX0MBZ6rLOm4lcOixcJGMdezjcpEJ
         zit07TX9y0LwDXh+5XRX9GVaN63b2Y47y0GFYaBY5YeB/Z/cJRW8spzNw770c76no6zq
         5lrP73FyLCRksYlh73fO863Snuy6oAYovRnOX6jcMkdnDyx1URTDxVDjKUVijyR73mAT
         HnpMColFtx2g+vIFfQ6tX9XFzpMW9Fk3nESii3v0WxdTM+SX7YFpmV6mrp8/RDrrNJOP
         wEHyaZbn3uC4VKWvBgFaycEJMqrDeb23wriZa2Rd53NMiCO0Jiaa2u7D02SF3t6u0tDI
         OhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502646; x=1729107446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0G8uI4hwgShGq+/JoLlhdBAjD3k55IDNeJ0SfYd18w=;
        b=C9d/AI/FL0fIx379+mB8O6wdrjoASlfIr6C0MBfnXF5012AdyZu0knXl/wWC8Ir5wD
         A9+V1EY6ezxRyz0DenoVhkPN7fBi/avlQWOKitxrixfe7hzqRcHD1rljQzFYSPClars9
         jii3wEbJSar3E061r20YnyJ2q/oISNmAme6+hqHLg8LXqHb21UWQN8C/n40Cxwn7e9Z2
         E8c+ehd4e2KD5lbxUxfpqwKzYcvGc7LQ+k8ldGhcoFEycVqGI5wPZ8VQnEjMb1IExwwi
         MLSLCiMZeCNyeAusewVRp1QRG0X2wN8XQhrE2/NIf4qwqfLPsCCcg3BeZA1omkGFg/pI
         1Uag==
X-Forwarded-Encrypted: i=1; AJvYcCUkAKKHv/Sk1sTS/L1+EckHQX0kjyf+HQhMNyc3PPX23LlDwaYzwqPcMKcSARneEWWAEfc=@vger.kernel.org, AJvYcCV5WbEeWhHGFvjnGxEMeCaNBigTkk2AgBJHgfti5ngV7ps3yk8bU+hukahC1Wc2vpeuipUkS9cMEz+oCXbehvuhsa4H@vger.kernel.org, AJvYcCWYWK8nK6QIsqoNTT0zQxJs7OlgoEQ0HEra4aAXwyiOfuIpu7aJH/G/3WTTr9gU/o03SimLoNF9X1bAejIj@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuVA1HonodQE1UPynkEPJItl8yHoYE/p+/o3KgHA2VM7YYI88
	oofGf2Vz8e77YKOByQbVYDKOswVw2aCSQnC/1XY9FLAU7G5c6FWE+wr/diI6yOAYUE7JoaytCV3
	b9YputUTy42Xx7uIc+o1pRKHkMkA=
X-Google-Smtp-Source: AGHT+IGGmW/6/MnDDSXp8paozBcmrsqqmQRDfwgUCq1zX2ea1Ia9vKFqUtc48dIbbLDp6MvD9w2LMyx3qwM9Vn6jZTg=
X-Received: by 2002:a17:90a:db8e:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2e2c6333812mr1421771a91.13.1728502646371; Wed, 09 Oct 2024
 12:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001225207.2215639-1-andrii@kernel.org> <20241001225207.2215639-4-andrii@kernel.org>
 <20241003-lachs-handel-4f3a9f31403d@brauner> <20241004-holzweg-wahrgemacht-c1429b882127@brauner>
 <CAEf4BzY5fy1VVykbSdcLbVhaHRuT6pRNYNgpYteaD79vRM7N5A@mail.gmail.com> <20241009-eisvogel-zugelangt-d211199df267@brauner>
In-Reply-To: <20241009-eisvogel-zugelangt-d211199df267@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Oct 2024 12:37:13 -0700
Message-ID: <CAEf4Bzb_=Qk3GgLfKE+JAhUudYfLMsQypu-33uKRi4q-kmGiqg@mail.gmail.com>
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

On Wed, Oct 9, 2024 at 3:36=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Oct 04, 2024 at 12:58:00PM GMT, Andrii Nakryiko wrote:
> > On Fri, Oct 4, 2024 at 1:01=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 03, 2024 at 11:13:54AM GMT, Christian Brauner wrote:
> > > > On Tue, Oct 01, 2024 at 03:52:05PM GMT, Andrii Nakryiko wrote:
> > > > > 6cf41fcfe099 ("backing file: free directly") switched FMODE_BACKI=
NG
> > > > > files to direct freeing as back then there were no use cases requ=
iring
> > > > > RCU protected access to such files.
> > > > >
> > > > > Now, with speculative lockless VMA-to-uprobe lookup logic, we do =
need to
> > > > > have a guarantee that struct file memory is not going to be freed=
 from
> > > > > under us during speculative check. So add back RCU-delayed freein=
g
> > > > > logic.
> > > > >
> > > > > We use headless kfree_rcu_mightsleep() variant, as file_free() is=
 only
> > > > > called for FMODE_BACKING files in might_sleep() context.
> > > > >
> > > > > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > >
> > > > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > >
> > > Fwiw, I have another patch series for files that I'm testing that wil=
l
> > > require me to switch FMODE_BACKING to a SLAB_TYPSAFE_BY_RCU cache. Th=
at
> > > shouldn't matter for your use-case though.
> >
> > Correct, we assume SLAB_TYPESAFE_BY_RCU semantics for the common case
> > anyways. But hopefully my change won't cause major merge conflicts
> > with your patch set.
>
> Please drop this patch and pull the following tag which adds
> SLAB_TYPE_SAFE_BY_RCU protection for FMODE_BACKING files aligning them
> with regular files lifetime (even though not needed). The branch the tag
> is based on is stable and won't change anymore:
>
> git pull -S git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git tag=
s/vfs-6.13.for-bpf.file

Ok, will drop. It will on Peter to pull this tag into tip/perf/core,
but I'll mention all this in the cover letter (and will pull locally
for testing, of course). Thanks.

