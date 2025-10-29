Return-Path: <bpf+bounces-72816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731DC1BE8C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45C464224E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CF34DB53;
	Wed, 29 Oct 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQrNdVj+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015B3358D9
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749388; cv=none; b=ODFahAUK4ylq837TVvM8esab/TFLRlvEfcnGXNpxsVD7XI/GubAmC8PTf2RLr0Qk6JJ5qaJw9DNCcSaATP0Q0/yK9UaVdph2eFRPc8ZcPcAZqp94kTmRlJjDN3wLZgVMQ+D1Tul8LjoPFVq1CDpYQwfxuwTmnUmUFRI47QPTnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749388; c=relaxed/simple;
	bh=N/H9Hc3aJwCtzPmRJOck3fIp82+NkA0LZ9tUFRkG0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9VsZ7V2jUmeG4/Wn9O4Mdy7/YcwYhgyZH0gvpyV58SI+7UARN+33xu1kFBwUXZQGicB13etn8BQiBs8pYQMTe7O9qyDBgHrYvbiLFa9qTfcwT3sq/4H/nzXz20Iuf5AyWkyqFOFU9q3ZNAF+vTQSxQMN+HFDgU1M7ag1QbbW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQrNdVj+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso13410a91.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761749386; x=1762354186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=fQrNdVj+n9mN+TjKgSWKOurWOx8bbFjjcpGc9rbYoX0l9pVxeVS7dwbebPzO7EyMNY
         X2a6Ew+yUq3XXoV/wDq9lkypSK+BYom/rU7WeWRWYvwk9ud2ZvZAMsTQBqg7to0voVyE
         NWPDqGEFI4ycZ4bfSeWBglO8aPeHliM7090p3jHq/UYBn2TX8A3J0QsThKh1Ht7dMrwU
         sdWywmc9wuO5fUMz26trsoLjWgo5P7gJSrB6Xfqf+DBYqgz8bPGcaEGWivFwD1drHXXf
         CRZ7/nRNpUUvgNm2zoncIx+LpnHqQOmwhHcuMIuiiS88r9eKzaxFewWxm80ztiA9EXIT
         k9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749386; x=1762354186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=N0iiA99g00Vs1bZOudGRLS31vgc+YZ8GtLvauHMu6A1J0jb4+1dPqJ3i1N/+0lLZru
         ozNTgjenUygeSRKRsvB7xu1H9RviCcPx2dgfSuQfgO61RpgWxiOJ5qTjQsnPqUQjoh9d
         anvXuOTYWy49jc03/51IyvqrRrdyqNpSowZ4gpQ04wsaBF8RStZAmYW1tIO02gcOKXxV
         azOOz7nvYFwyBNgF63mmZGQ4Nq1nrJdW1ravxxOsM8qMGut+VfiONmBq+oko4O8yn31H
         Xj7Wmcxgu74F2zRhCvY5d64y6WNkQkPbKr89TMJJb/w1A+LDdqlBrImUiVesoPD9oJ1k
         oj/w==
X-Forwarded-Encrypted: i=1; AJvYcCVI9eCX2FERKal1qB8p187T7j7imIxXg2XZaH4gMzvqFRsFtKOlXBat02mrNAfeFIQOWy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPlwEHHO3COo+0hKXTfjhRqAUMMvbKubkCheOPyv0/Ey78xqH
	BvkZ1lDdAhdyX5E8DZni1/odvi3JgGtVAibcztyE5JlNuAvIU3Vs/buKjnk4qDp4EloybpIXG2N
	D6qOy+bl9wlbFy9q/L+ii09YYMqOaqAznU71NjtpN
X-Gm-Gg: ASbGnctd8Fnt400Jvih7yPE1ib2V0HgNpFhzM6pWY/1UzCCg79F38bU1+uFeDtRi4HH
	lo5rEjPC3n47Yf3MOosncBH+YMWUolExrUENIjdYQi3hWKtpfe4R0R6+omiBBs+aiJRVMVerSkA
	JWM4UXiukYTESyQTbbA/1Bqd4P4cvzkR8yNPclMv60WkrJqRPec8FNH1lK39RfCsLm/Y9FxdG9y
	aaE3+zyrsQ3UmNUAe2oGZ6+KerjieqtbIsD1vwHjhmBF3SxtGHwFkEXWhXd
X-Google-Smtp-Source: AGHT+IHiN2wVay8qKwNUCQNQedszNEqWD+gbH8QhJy+T+EtTl6Gz4GwA6YgaiehmmoZJBoAentF29nQI5J4sc3vsbuw=
X-Received: by 2002:a17:90a:d64d:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3403a302f52mr3761415a91.36.1761749386246; Wed, 29 Oct 2025
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-36-viro@zeniv.linux.org.uk> <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
 <20251029032404.GQ2441659@ZenIV>
In-Reply-To: <20251029032404.GQ2441659@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Oct 2025 10:49:34 -0400
X-Gm-Features: AWmQ_bkw5gzRbiAC20oxF8nOixccAI_lXABYmuYCSfnezye7FZYc2Gs15NqnG0I
Message-ID: <CAHC9VhRefx4MBDU78Qob7Pe2pDLK=1HK4b2EuTtENVssntHecQ@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 28, 2025 at 08:02:39PM -0400, Paul Moore wrote:
>
> > I suppose the kill_litter_super()->kill_anon_super() should probably
> > be pulled out into another patch as it's not really related to the
> > d_make_persistent() change,
>
> It very much is related - anything persistent left at ->kill_sb() time
> will be taken out by generic_shutdown_super().  If all pinned objects
> in there are marked persistent, kill_litter_super() becomes equivalent
> to kill_anon_super() for that fs.

Gotcha, thanks.

--=20
paul-moore.com

