Return-Path: <bpf+bounces-38089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45795F75F
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5C3B21602
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791B198850;
	Mon, 26 Aug 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lObtDvk8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C143C17;
	Mon, 26 Aug 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691827; cv=none; b=rg+aeUDrTRyL1l/WsYfA3DYHZqkujO4ZhxzxOh72X9OoZH9inSeyNi1PfUd0bQDt9tW9NnReF/35aYxMsDDKpgYOe4pI+K8j1QMGDM24uwzfuV5UH4mSUsfPEICm+3dAR5ixlbiMu1/80dSd+uCloh/i4amMiDgOPg+J5M78sqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691827; c=relaxed/simple;
	bh=5qUldRPe69CZ+YfxEz0IQC70ylubWa3moIOLvtg8JCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBQLkuk0G2aRS6pp5h335xFy1dKB1oGb5Dgbh36suDzxg1aSeugvwA010o44uZ/wcg0LWMSLpTQo4fRteYyrzHhd/ZduspNug1Zx3I7vjCCjTA5LmeBQFsj80MoDfMOITI6gOEaTgt/nxVeGy0EVRmjNiRTp4V18lxYanqv10oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lObtDvk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFB0C567F0;
	Mon, 26 Aug 2024 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691826;
	bh=5qUldRPe69CZ+YfxEz0IQC70ylubWa3moIOLvtg8JCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lObtDvk87oEXziS+hM8r2Yw50PxS0iZ5tSzdetAH1Vo1uViBh6Mk4hr1jS5oWTbYN
	 tNkB5J69b7//JehMXoQHS/GqD6zdn/cMM8CTPJlJc1YJO0w1wVaOlmhEId6tquz15O
	 WO/Z/xYRUJwaR5G5l+HIC1s3VpH7dMN6HlTO0uf1MzE+VcETL9ABr1ZgWnvHaX8tqX
	 jgpO3rg9hJddeKvAU0BiN2qIRujZ/BS4FpUuD1Ce0CBqK3bFWgsl+TSiyEwZWsHeh0
	 PScaIMTS7iK7OizS0NS5Q1ouYlfgyo0GLmK/G6rBf+ugGG1p18TixxR/BVGU3rU83N
	 IX7G1gTD2devw==
Date: Mon, 26 Aug 2024 14:03:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <Zsy1blxRL9VV9DRg@x1>
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
 <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>

On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > I stumbled on this limitation as well when trying to build the kernel on
> > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> > created a swapfile and it managed to proceed, a bit slowly, but worked
> > as well.
> 
> Here, it hits the VM space limit (3 G).

right, in my case it was on a 64-bit system, so just not enough memory,
not address space.
 
> > Please let me know if what is in the 'next' branch of:

> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git

> > Works for you, that will be extra motivation to move it to the master
> > branch and cut 1.28.

> on 64bit (-j1):
> * master: 3.706 GB
> (* master + my changes: 3.559 GB)
> * next: 3.157 GB
 
> on 32bit:
>  * master-j1: 2.445 GB
>  * master-j16: 2.608 GB
>  * master-j32: 2.811 GB
>  * next-j1: 2.256 GB
>  * next-j16: 2.401 GB
>  * next-j32: 2.613 GB
> 
> It's definitely better. So I think it could work now, if the thread count
> was limited to 1 on 32bit. As building with -j10, -j20 randomly fails on
> random machines (32bit processes only of course). Unlike -j1.

Cool, I just merged a patch from Alan Maguire that should help with the
parallel case, would be able to test it? It is in the 'next' branch:

⬢[acme@toolbox pahole]$ git log --oneline -5
f37212d1611673a2 (HEAD -> master) pahole: Teduce memory usage by smarter deleting of CUs

Excerpt of the above:

    This leads to deleting ~90 CUs during parallel vmlinux BTF generation
    versus deleting just 1 prior to this change.

c7ec9200caa7d485 btf_encoder: Add "distilled_base" BTF feature to split BTF generation
bc4e6a9adfc72758 pahole: Sync with libbpf-1.5
5e3ed3ec2947c69f pahole: Do --lang_exclude CU filtering earlier
c46455bb0379fa38 dwarf_loader: Allow filtering CUs early in loading
⬢[acme@toolbox pahole]$

- Arnaldo

