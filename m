Return-Path: <bpf+bounces-31916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCE905008
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513A61C21679
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73E16E87B;
	Wed, 12 Jun 2024 10:07:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3216D4E8;
	Wed, 12 Jun 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186837; cv=none; b=fYeSR/A3aPc2o6lzCajxl5tcTTQs27a/Cie5gT6Gyl/5VkGmQSMLd9Ygn/yQ/d1tEQX8eZybNsDbUlCD82Xf/gIdfH46IqrPgwt8GEk/U430MMzfk3/cXkRRzCQS2PjYIlAsNlAcxAWzGjV6ttwZ8tx8R1DmevKEUFWe9+d4uFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186837; c=relaxed/simple;
	bh=wVSj0BFnJgasNyV6X0X+XogJi6hOWF4I2zytqMc1A9s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FTLffbAdpqGAjuwhO1fqeiZLSEvcoRUDDoOlGQAxXaQ5yIoYCnNlBQMJYpj2VXEnj9nUPgnrdEWWA22wJP0cNH5dR+SdT3GzHYkXCRSZO39L7M1vc8cdqPipWB1QzIe/CmOFtcUP9m68ubowyOXmdLx1pnPd0pP+6MJohuacz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <4154d202-5c72-493e-bf3f-bce882a296c6@gentoo.org>
Date: Wed, 12 Jun 2024 12:07:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthias Schwarzott <zzam@gentoo.org>
Subject: Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF kfuncs)
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
 Viktor Malik <vmalik@redhat.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Jan Alexander Steffens <heftig@archlinux.org>,
 Domenico Andreoli <cavok@debian.org>,
 Dominique Leuenberger <dimstar@opensuse.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Yonghong Song <yonghong.song@linux.dev>
References: <ZmjBHWw-Q5hKBiwA@x1>
Content-Language: en-GB, de-DE
In-Reply-To: <ZmjBHWw-Q5hKBiwA@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.06.24 um 23:26 schrieb Arnaldo Carvalho de Melo:
> Hi,
>   
> 	The v1.27 release of pahole and its friends is out, supporting
> parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> tools such as bpftrace to enumerate the available kfuncs and obtain its
> function signatures and return types.
> 

Regarding packaging of pahole:
What is the state of the contained ostra-cg?
I have no clue what it is and how to use it. Is there still a use-case 
for it?

Starting it without arguments only shows the usage string.
Running it with two dummy arguments:
$ ostra-cg x y
Traceback (most recent call last):
   File "/usr/bin/ostra-cg", line 404, in <module>
     class_def = ostra.class_definition(class_def_file = "%s.fields" % 
traced_class,
 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/share/dwarves/runtime/python/ostra.py", line 154, in __init__
     f = file(class_def_file)
         ^^^^
NameError: name 'file' is not defined. Did you mean: 'field'?

According to 
https://stackoverflow.com/questions/32131230/python-file-function the 
function file() does not exist in python3.

This part could be fixed by replacing it with open() but I wonder if 
this is worth it.

As nobody has complained about it being broken:
Should ostra just be removed?

Regards
Matthias


