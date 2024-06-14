Return-Path: <bpf+bounces-32201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691549092D0
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5091C25B69
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886F1A3BDF;
	Fri, 14 Jun 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwkDrTTr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B07188CCD;
	Fri, 14 Jun 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392190; cv=none; b=YHTg2nBMv1Bstue3FiAC3kox7HJsoQKc79iqD9Ozwy40y54s+tdEr+WiBSogihLK1Pr1A8ZCxIS08zm9lWM1548j/aKCreIVOCpjVYp4Oc7kLxHmqD2jLSlP0eSeJAosbIOvOjlpJPfGYawBCsK9ZAzLg04ftmmIw+JpYve6jio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392190; c=relaxed/simple;
	bh=DGSt7WrCiXZzupZdO8+/84/UT48LDigcSB3517jwWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcvBGe/wLOzQxuYuJjTgkgvThAaKw3aeWsnUdmbMBl6kFtE4gwOyMoAoAwEpAE8ZUIJw4M1EY0iDu8WjNHa6KvRqrO6h1rxmwQowDV11eqFkJpuIKzW98+f+nx9BAM9YdpmxZvEbSaJM2xqPIoeclAVE+CONMEimCjX5iauclXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwkDrTTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B779FC2BD10;
	Fri, 14 Jun 2024 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718392190;
	bh=DGSt7WrCiXZzupZdO8+/84/UT48LDigcSB3517jwWow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwkDrTTrCTKyyRuM7HbMFPFTca/9jnPoVf3EYfp7wCXnsc8ouQ2DbVU62wxZgH1BS
	 1XQp3574l8FXcfOQ0EdIB9GHzgb0er1UsKgemtePUwq0j0ikoljp3o8wYcCJalU21m
	 sn7I+Qg7OxxJ42/BbwT87To3fi32R+UkBKBMNf9rska+VTFCsekukADexHnw7+1muh
	 mzFj4FHk0OUHCclHQCbsSosX8Wo60ijzg5berlQ3WeQN3IrW9GQXy848TzflE+SZSA
	 knCotht8kuAdKx0bgy4cyaaSCLFWC6uZylZfpZgECSjgvpB8IiehNPOTlQzF8zkkd2
	 Xh9ChYtwtJLLw==
Date: Fri, 14 Jun 2024 16:09:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matthias Schwarzott <zzam@gentoo.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
Message-ID: <ZmyVehvNnhrMerlv@x1>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org>

On Wed, Jun 12, 2024 at 12:07:09PM +0200, Matthias Schwarzott wrote:
> Am 11.06.24 um 23:26 schrieb Arnaldo Carvalho de Melo:
> > Hi,
> > 	The v1.27 release of pahole and its friends is out, supporting
> > parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> > tools such as bpftrace to enumerate the available kfuncs and obtain its
> > function signatures and return types.
> > 
> 
> Regarding packaging of pahole:
> What is the state of the contained ostra-cg?

I need to make a decision on that, it is used to produce things like:

http://vger.kernel.org/~acme/ostra/callgraphs/sock/0xf61bf500/

As documented in:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/README.ctracer

But yes, it needs to get retested after all these years to see how
difficult it would be to try and get it back working.

- Arnaldo

> I have no clue what it is and how to use it. Is there still a use-case for
> it?
> 
> Starting it without arguments only shows the usage string.
> Running it with two dummy arguments:
> $ ostra-cg x y
> Traceback (most recent call last):
>   File "/usr/bin/ostra-cg", line 404, in <module>
>     class_def = ostra.class_definition(class_def_file = "%s.fields" %
> traced_class,
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/share/dwarves/runtime/python/ostra.py", line 154, in __init__
>     f = file(class_def_file)
>         ^^^^
> NameError: name 'file' is not defined. Did you mean: 'field'?
> 
> According to
> https://stackoverflow.com/questions/32131230/python-file-function the
> function file() does not exist in python3.
> 
> This part could be fixed by replacing it with open() but I wonder if this is
> worth it.
> 
> As nobody has complained about it being broken:
> Should ostra just be removed?
> 
> Regards
> Matthias

