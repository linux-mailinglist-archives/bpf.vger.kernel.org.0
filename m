Return-Path: <bpf+bounces-23180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F186E94D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172C428873A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0633A1A8;
	Fri,  1 Mar 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoN1nBGz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45839AF3
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320553; cv=none; b=S+fz6u4Dz50R7PpZRjDsEEyP0zSrlnPBfgPiwOB0qNpWSumabfaXxygP6Pq9wCfOUBq2zNMiZ/J9nkTbljXghlq6yh0pnr0kYU4GKU2iRLUwNhrfLAdKblFpeGl98BjNolOPY5TMh/kWgkPhyaXndrAc/j+XjSc3EcPV41DmXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320553; c=relaxed/simple;
	bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/T9TLIvUzPLwMvPEBt3eXa84XAj7uIP7ZFwjT+n4tSxqD4CUAlwC0ZhfDRy5qRDUYofNso/cWiyecuJ8x/YIbszsBJf/Rho6DByVnEs8efaV1nbwpgOg1d9rCWg8IJR+Mf5myg5j99FsHsQZRTM3ds17wlLZHrQELAx8XTsN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoN1nBGz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso2536991276.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 11:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709320550; x=1709925350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
        b=IoN1nBGzM8kKRJYCn67Uky3jQ8CmRFaRigUyxYupbK3bd0W4Y4Q4oFL2AaP+IftBTB
         P3AwqIgJVkRvYhQ68XpQbRfgi2jY5r2pKC8bWr7tPV/wVHzJ9UHzPjelEn0UPiephrAt
         FHB8LMqEifgH9TBgLc7rauryOUwzVVa44WFVLPC2M5Bl+NPRetY/F6Z8iYQrA0o3TYqU
         BGKMCkNQC5CXy0F2pr45JsQRRVlyBy3vA/410gAlEWoKt3nkPZbyISENxMW0ZEijk5OR
         OpBxnQMMfIbqnj14uaraEGm7f0XyrEFR14oqKpEzzOY/dd2b6zjwvNi7Iki292HMJNyN
         7Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709320550; x=1709925350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SGVdNCzUzfJSyLUiv7OJm+Q7HZsz7W458Em84AKSBQ=;
        b=kkpq3bkHZKqNqx5kG2gOxk0RhUEfICnJL1w5QGB2VZ6dNo8X2MrtkJ8z9+cGofTXOs
         Vf4+qXuqLpWcTA2pu1Tow3ggikkdYd+lPsTiR+VzgeqIz8g7GR2ofpP7ewk8NswYgxLW
         8nm5Fvj7NDR1lKkaR5GEVfv5dKNItgjngQqQYL8ZU78zNud2ltYCPOW7KcQGxFZxOvAL
         /nOeFDHo7YXBbYgjjZSnbiEbzQL60rWE/85+hRCNQVdTOdeeYTO5wYJwUe7ugKl/lrqj
         OgYAjf5cwtZrUZbhpYF6aeSIoosnkTBSskihz7kqPlv10bIofhtx0Ll4Lzx5BmsEFYv8
         JT4A==
X-Forwarded-Encrypted: i=1; AJvYcCV5CvxQt/Gb4HpEe9xfIMJu4JE9f9AF/Vacg54CjpHSl/DyQdm9ZRNvpg44Q5rAZmd01BzyJh8bFS8wVi1lpcSAi84+
X-Gm-Message-State: AOJu0Yzw37TPrhVEJm7x+eNyNYaLVAPdTeBBqxf/sonS0pyDuY5gW5bs
	SEIQAodTvcq3AjNTRnhmlGrni2HYvsq3PSeGAcPZSQu5ekfuV+tn0ZNve8NmQpBw3RWtgpb9XKu
	ydg0Pdw2V08D7zpTa3n/Xu/ZD0Ip6uJtRqCjx
X-Google-Smtp-Source: AGHT+IHpoZqSKyU8K72QYJxIxHP1qT5UNeWaLy/IbqZ0RAKIL2jso0DEQzufbvQHjoDbpJ46K4tcQNzrXK7CAMMiHxM=
X-Received: by 2002:a25:850a:0:b0:dcd:3172:7269 with SMTP id
 w10-20020a25850a000000b00dcd31727269mr2397758ybk.2.1709320550364; Fri, 01 Mar
 2024 11:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228032142.396719-1-jhubbard@nvidia.com> <Zd76zrhA4LAwA_WF@krava>
 <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com> <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
 <34157878-c480-44bb-91d6-9024da329998@oracle.com> <f248cf92-038c-480f-b077-f7d56ebc55bc@nvidia.com>
 <ZeHi4qz8HqDSCC4H@krava> <a0ea8c23-96e8-4ad2-8523-6749dc59b462@nvidia.com>
In-Reply-To: <a0ea8c23-96e8-4ad2-8523-6749dc59b462@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Mar 2024 19:15:36 +0000
Message-ID: <CAJuCfpGMoOTPBJoT=R8GayLg6rfFRppKameeW1w3_V1=YgL6kA@mail.gmail.com>
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:33=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 3/1/24 06:14, Jiri Olsa wrote:
> > On Thu, Feb 29, 2024 at 10:15:23AM -0800, John Hubbard wrote:
> >>> ...
> >>> Running
> >>>
> >>> bpftool btf dump file vmlinux |grep "] VAR"
> >>>
> >>
> >> $ bpftool btf dump file vmlinux |grep "] VAR" | wc -l
> >> 4852
> >>
> >> $ bpftool btf dump file vmlinux |grep "] VAR" | tail -5
> >> [136994] VAR '_alloc_tag_cntr.9' type_id=3D703, linkage=3Dstatic
> >> [137003] VAR '_alloc_tag_cntr.5' type_id=3D703, linkage=3Dstatic
> >> [137004] VAR '_alloc_tag_cntr.7' type_id=3D703, linkage=3Dstatic
> >> [137005] VAR '_alloc_tag_cntr.17' type_id=3D703, linkage=3Dstatic
> >> [137018] VAR '_alloc_tag_cntr.14' type_id=3D703, linkage=3Dstatic
> >>
> >>> ...should give us a sense of what's going on. I only see 375 per-cpu
> >>> variables when I do this so maybe there's something
> >>> kernel-config-specific that might explain why you have so many more?
> >>
> >> Yes, as mentioned earlier, this is specifically due to the .config.
> >> The .config is a huge distro configuration that has a lot of modules
> >> enabled.
> >
> > could you share your .config? I tried with fedora .config and got 396
> > per cpu variables, I wonder where this is coming from
> >
>
> Attaching it. And based on your results, I think that Suren's Memory
> allocation profiling patchset v4 [1] may also be required, as that is wha=
t
> I was building.

Yes, that will definitely increase the number of required per-cpu
variables since it adds a per-cpu variable for each kernel allocation
to track it. I vaguely remember now that Johannes also mentioned
hitting this limit when he was using our patchset. Allocating
encoder->percpu.vars dynamically seems to be a great way to fix this
limitation.

>
> Cc: Suren and Kent. btw, I the whole reason I went down this path was tha=
t
> I recommended your patchset in order to zero in on a memory leak that a
> colleague is debugging. This patchset provides a new view of allocations
> and leaks and we have high hopes for it. :)

Thanks for trying it out John and CC'ing us on this thread!
Suren.

>
>
> [1] https://lore.kernel.org/20240221194052.927623-1-surenb@google.com
>
>
> thanks,
> --
> John Hubbard
> NVIDIA

