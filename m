Return-Path: <bpf+bounces-48009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799B4A031F9
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F34A1885C12
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689BB1DDC0F;
	Mon,  6 Jan 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk3Q/bzU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA01171D2;
	Mon,  6 Jan 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198393; cv=none; b=VMEdNshzobctNUzIvbdDTFIlakIcG6oHsxQsvfanEu+UjjtXuWRsWJVwFW9Pr2QjRmk7CqX/D55aWm28WydoglfvTckfTfHQkzTbI4rX9DtoLwmcjTn8tmbyvQuztNoBjB2dmNANG6q4R3aRVhc0jKIRoO4lpv2J0uzhNGlbz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198393; c=relaxed/simple;
	bh=1IvVO8wjdXmDKwRzBaEFXBnAwV0/f29Vw48pMxlqPlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ue1Vh4KL8oL6CpmLvQmuGbfoMNDRTVNA+Tf3TPiFPTTMtK4yHXQxli/iuJ4fSvhvgpU0gINQ4qwwSH1BNJLTRypBeoBmf8rjtatAws8IdRKfuIZPFIFSKCwSpd3A6pOy6Flb5squA37ZA/XLZVXu9pW9x7WNRotK+1WBxrOwyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk3Q/bzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D264C4CEE2;
	Mon,  6 Jan 2025 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198392;
	bh=1IvVO8wjdXmDKwRzBaEFXBnAwV0/f29Vw48pMxlqPlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lk3Q/bzUpa6izmDyOCrjhJCDsh6IKKGbHfB7OWrP/PW9o42skAr7RzUwzupMBRJER
	 cbbr/u9mW+gjF+d3LZMwfzlmT2sEAkiHHKYgsTRCfuGpdXOhWBQqDtMyhn6/VkWVXf
	 Uy+BNwQIJt//AqxI+x3SIWSKqCOi6RTNa79KVXlsl0zUVeiu8qpiCfEVP/YZe3UYlB
	 kiZbl9+crmV778I3QrA2/FgqZQdGTSRtEskp9e72jHH5P9RvaJPRBzbEmH5Hb8Ws25
	 bF1ZBmAdWt0NJZfhaKNf9vYHuYrDenn77RnXp1ropqx0SgcVUIOM4L+uHRpI+lR3Vb
	 ya4HIpOvfFRCg==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso136879785ab.1;
        Mon, 06 Jan 2025 13:19:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+D9ex21t1SEqFQyFYvZLilpSvFUmGhSAeLTx930zSqsNyC6bDzR+1xJFpZZ9dKcsXGxo=@vger.kernel.org, AJvYcCXHq5axz4bnE7cfCexXUR9RTOS0jLTlu9rUnWjdOckHh9BXmYpFGgtClVPhnzIb9OIggi3J26DC8CGo/lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrnLdy7A9htsmog1Gf5Lx0FXwqP75ZyUg1rjEqnQXbere/tpg
	Kb2aKhjbrykF7c2LBJ3EMgM0XdzrLmjO9SuvFNu1Tcf6QgRRmJJ0yGRYfkB2yvTTIOLRrW/VY9d
	TMXAaPEYoOw8UUpngfmZXAXF5nmg=
X-Google-Smtp-Source: AGHT+IG+IZ862kK6kDnKJWKdE2t5hnf3zzYHYsozv0R7eibPPM7/ODHoZWX3L5ZjVn6xVB8eQQ/ogUsuhhubpVxH1Kw=
X-Received: by 2002:a05:6e02:1fcb:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3c2d5b3786dmr365300975ab.22.1736198391826; Mon, 06 Jan 2025
 13:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com> <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 6 Jan 2025 13:19:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
X-Gm-Features: AbW1kva00aG7ViLBjQbXd8zclJSkWUzD_mt2_zAtClxvxCVGi76ef79Gc0_jSxs
Message-ID: <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: hch@infradead.org, yanjun.zhu@linux.dev, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:52=E2=80=AFAM Vishnu ks <ksvishnu56@gmail.com> wro=
te:
>
[...]
>
> @Song: Our approach fundamentally differs from md/raid in several ways:
>
> 1. Network-based vs Local:
>    - Our system operates over network, allowing replication across
> geographically distributed systems
>    - md/raid works only with locally attached storage devices

md-cluster (https://docs.kernel.org/driver-api/md/md-cluster.html)
does support RAID in a cluster.

>
> 2. Replication Model:
>    - We use asynchronous replication with configurable RPO windows
>    - md/raid requires synchronous, immediate mirroring of data

immediate mirroring is probably more efficient, as the system doesn't
need to read the data from the device.

> 3. Recovery Capabilities:
>    - We provide point-in-time recovery through incremental sector trackin=
g
>    - md/raid focuses on immediate redundancy without historical state

IIUC, the idea is to build a block level remote full journal. By "full" jou=
rnal,
I mean the journal contains all the actual data in addition to metadata.
I think the consistency can be really tricky with write cache etc.

Thanks,
Song

