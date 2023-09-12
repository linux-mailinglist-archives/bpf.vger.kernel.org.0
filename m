Return-Path: <bpf+bounces-9846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65079DCE5
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BBA2823E7
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7714A95;
	Tue, 12 Sep 2023 23:58:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2ABA33;
	Tue, 12 Sep 2023 23:58:35 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90710FE;
	Tue, 12 Sep 2023 16:58:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso10039856e87.0;
        Tue, 12 Sep 2023 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694563113; x=1695167913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zUd3C1FM/wtnOQDYKIuXXd26DTw0nV6sQuRlNb6RDU=;
        b=PTuK0Paj3fAw3ZvDENkCy+olJ3T9K2SSYDhga2dMUSuYZ1eCEAgH7D4CyeJ5F/+NUA
         N/Ml8s9Y2SKRMhmXa222MDOFghlbOEAfbH9DeoOgP9FxeTdYwblk0rClqR5EMHgaYs1F
         K+yxc4BsmBd4OHwG3cY8f9+5U0C2j3qBtpDNpseWqrbESiDNHK7GzWj8UNogiyPJdmTE
         A9AG0GcZfPYfIWfvZ5gann0+sGNZh/zk/Jw0G58JvM7GZIlNhA0QxetW3UHzpnqCxjxC
         4G0ikqYhKkw3oUqUYnIWoZG0iVxpXNJnevtxr5O3jv5AoA8yAnz8nF5lLowXJrNUx33A
         hYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563113; x=1695167913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zUd3C1FM/wtnOQDYKIuXXd26DTw0nV6sQuRlNb6RDU=;
        b=jjw0k9B7W/woEX4vU3+UxScaE7W9FrkvrFBf4W7sd6pimM+S1K+SKQfu5GdcEX1WG9
         smMUpNgHTT59AkVywGxFpbK5EafsATRU1oDP5viS51kVb0PHdP5WlNl3stRJq99dU7Qr
         aLsGmCXK2PQXdX7cGVR75OgoUkDftC4ld3FvViudi0rYv/Pcu8q+RAbe2Pk7wquIZubN
         yZOEOq8aH5VmByfNin6+NoiFFv+sMr63BUygp8WrM42YJAjAAA0TS5SptNxQI36Aj1ER
         dPN4Cbe3xIpcaXsvXzAhl3magHGF7OgvLZ4uAzlgtw+eGkqz6I17m064fUDmv43EGLU5
         SJSg==
X-Gm-Message-State: AOJu0YwEa0PDZ04rvTu7BN9KB6lel/UKxL2t+97lCE9sT580RJmAzFyG
	LcKdN1+BGLdNiEuOed8TcWTac2NRZzhkiDYAyzEZ4rgwUF0=
X-Google-Smtp-Source: AGHT+IGivdEcHiKXCCZRGqJ9thmtaq4JL/TKb/8uGuccY9BfUEgV5LC6kYM+Gxvp4bMzusM+JOxwKRcnE+Pm3b//vEE=
X-Received: by 2002:a19:ca0b:0:b0:502:d85b:5de with SMTP id
 a11-20020a19ca0b000000b00502d85b05demr584754lfg.68.1694563112699; Tue, 12 Sep
 2023 16:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913081050.5e0862bd@canb.auug.org.au> <CAADnVQKt_oCgJpVv+jqi5yhO4XUb2RWzajNSsNWk4fJWD4cJ7A@mail.gmail.com>
 <20230913091507.71869bba@canb.auug.org.au>
In-Reply-To: <20230913091507.71869bba@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 16:58:21 -0700
Message-ID: <CAADnVQ+p0d3QMbAphE5D0-kfYHZ+08WG_3MN7vTePK-spUuXtA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 4:15=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Alexei,
>
> On Tue, 12 Sep 2023 15:18:45 -0700 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 3:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Commit
> > >
> > >   3903802bb99a ("libbpf: Add basic BTF sanity validation")
> > >
> > > is missing a Signed-off-by from its committer.
> >
> > Hmm. It's pretty difficult to fix.
> > We'd need to force push a bunch of commits and add a ton of
> > unnecessary SOBs to commits after that one.
> > Can you make a note of it somehow?
>
> No, I can't - git has no mechanism to do so.  However, I note that this
> commit is signed off by one of the BPF maintainers, so maybe it can be
> left as is and try to remember next time ;-)

Right. Daniel's SOB is there.

I think the sequence of events was the following.
We don't close bpf-next during the merge window.
Only don't push for-next branch.
Daniel committed that patch with his SOB.
I committed few others. Then bpf->net got merged and net-next was
fast forwarded. So we rebased bpf-next to the latest net-next
and I force pushed few patches without noticing that one was
committed by Daniel. Later we added a bunch more and a week
later when rc1 was out we pushed for-next for the first time.
Now that 3903802bb99a ("libbpf: Add basic BTF sanity validation")
is pretty far from the top with myself, Daniel, Martin, Andrii
as committers after.
So to fix that mistakes we'd need to force push all commits
after that one and add SOBs to all of them, since git cannot
force push preserving older committers.
I think the best to leave it as-is.
We'll be more careful in the future.

