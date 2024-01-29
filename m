Return-Path: <bpf+bounces-20601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07F84099D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1633B27469
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6197651B1;
	Mon, 29 Jan 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BufJe+9c"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B61534F9;
	Mon, 29 Jan 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541445; cv=none; b=tRlohnPigORwOdKVrAAmGSMvr03T+NLVNgs0ThTPxNHnmBw/U9DFP6GvFWss4L/IqGzdC/wPEs36WwoNaPQfRMCsm+QFGvF/QBKWnC6Y737dSqt2+YSDQ7y2GeDj+TO16cyDN3X0q/zOKn4QKvvYgBX4UGzG3mJT33APvjCDR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541445; c=relaxed/simple;
	bh=WzuPg+hXWN29UyVCGB4lAofCnSOJeyD0botzOnCMSXo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BGttRBS+7FHmejxUKuKTIRkOQ1XU01GddFayHJSaAcm96Mp43eEVgLB3JGQcfG9ffw8Uxp9sMO6iF/M8vW0Or6JlGfFffWTARqpowlNYlHtfpy7O4YdaA+RDG/Xy/9lFFQideh1SPzTob2wvUi+L2WfGsaRG/dHfstRDY9HVQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BufJe+9c; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iNsIk5lUAkdWbQ+2vNxrN7oL3ACmQ1NfOOhgcRPQniU=; b=BufJe+9c6ehUdePl7jR2W6faXn
	weWOrTyRzQdPpZljxGKpvrZyye745IcHmpy5kPoDdZ4Jhwi4myw32Uw+8ePM/yhmZ2nS2TO9c417w
	tBL5SGINLx62Z6mDICnS7/swFPU880kZRd0zag4rl6Y+D0IMDp1kX6NRs6wCyI2GNcdFXJMsBlR+/
	0krVJ4paZ/NQqQOxQx9mnVjrWrEcRgK8Ksd4NZkpA79ODDDTiUQGzkUofTkfbOZDAlrGroWDKucEd
	ptD67hZeAXM/+0dX/RGx/ZDWLNk12qQJG3MahY9RZoicioL+xReb0AT8QOrN3MNGeE9y4HGKXI+H1
	t998CGkw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rUTNd-000BoO-E6; Mon, 29 Jan 2024 16:17:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rUTNc-0008YX-TV; Mon, 29 Jan 2024 16:17:00 +0100
Subject: Re: [PATCH 1/1] bpftool: Be more portable by using POSIX's basename()
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Quentin Monnet <quentin@isovalent.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ian Rogers
 <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <Zbe3NuOgaupvUcpF@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c23c7c37-8d4e-e9ad-3fa0-a41da3b7aefa@iogearbox.net>
Date: Mon, 29 Jan 2024 16:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zbe3NuOgaupvUcpF@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27169/Mon Jan 29 10:39:53 2024)

On 1/29/24 3:33 PM, Arnaldo Carvalho de Melo wrote:
> musl libc had the basename() prototype in string.h, but this is a
> glibc-ism, now they removed the _GNU_SOURCE bits in their devel distro,
> Alpine Linux edge:
> 
>    https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> 
> So lets use the POSIX version, the whole rationale is spelled out at:
> 
>    https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643
> 
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZZhsPs00TI75RdAr@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/bpf/bpftool/gen.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d75d2..a5cc5938c3d7951e 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -7,6 +7,7 @@
>   #include <ctype.h>
>   #include <errno.h>
>   #include <fcntl.h>
> +#include <libgen.h>
>   #include <linux/err.h>
>   #include <stdbool.h>
>   #include <stdio.h>
> @@ -56,9 +57,10 @@ static bool str_has_suffix(const char *str, const char *suffix)
>   
>   static void get_obj_name(char *name, const char *file)
>   {
> -	/* Using basename() GNU version which doesn't modify arg. */
> -	strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
> -	name[MAX_OBJ_NAME_LEN - 1] = '\0';
> +	char file_copy[PATH_MAX];

Added a newline in here while applying, otherwise lgtm, thanks!

> +	/* Using basename() POSIX version to be more portable. */
> +	strncpy(file_copy, file, PATH_MAX - 1)[PATH_MAX - 1] = '\0';
> +	strncpy(name, basename(file_copy), MAX_OBJ_NAME_LEN - 1)[MAX_OBJ_NAME_LEN - 1] = '\0';
>   	if (str_has_suffix(name, ".o"))
>   		name[strlen(name) - 2] = '\0';
>   	sanitize_identifier(name);
> 


