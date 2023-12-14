Return-Path: <bpf+bounces-17842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A7813537
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B12AB218E1
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B55D90F;
	Thu, 14 Dec 2023 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rIV+/ZIL"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945AE10F
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6qocdOvkGcUIxq8NnVrY8J+ca/ZtRH5VtXbn/wuaqVg=; b=rIV+/ZILxe7J7APo8Q8Uvptn0j
	8vPb2dkz0jSHAbZWbXblWDXlGm0zbbS8rEbrGa03dRu3Kf/CSqpNo2dhilYQaJCBJnVXQgAxYWKaE
	/jkk4i9ucD+GXAvexl7hLH9Lge6N02jZIF+kJpgEUKF69nLFK6VVV6nfByyUeYi71W7/6dQV8pp1T
	ebKgjAbVlglGQg3toKlZzAROVLHG6u7DLxhhHX4kJCgY6mDdMv3u0Y0/BhoyCtIz6M8q9uWWIe0Lc
	56aiwOGBUypq0UeVZMellZZ9PDuGYJEJ7XC5VWy/V0BiwMVkHY7bTgrd28q12mz9tGFv8FRFqtG6p
	gjjBV/tg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rDny9-000MiV-Bg; Thu, 14 Dec 2023 16:49:49 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rDny9-000K5Z-1L; Thu, 14 Dec 2023 16:49:49 +0100
Subject: Re: [PATCH bpf-next 1/2] bpf: support symbolic BPF FS delegation
 mount options
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231213222327.934981-1-andrii@kernel.org>
 <20231213222327.934981-2-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4461106f-59f5-43e8-fcd9-5a118639c12c@iogearbox.net>
Date: Thu, 14 Dec 2023 16:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231213222327.934981-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27123/Thu Dec 14 10:37:47 2023)

On 12/13/23 11:23 PM, Andrii Nakryiko wrote:
> Besides already supported special "any" value and hex bit mask, support
> string-based parsing of delegation masks based on exact enumerator
> names. Utilize BTF information of `enum bpf_cmd`, `enum bpf_map_type`,
> `enum bpf_prog_type`, and `enum bpf_attach_type` types to find supported
> symbolic names (ignoring __MAX_xxx guard values). So "BPF_PROG_LOAD" and
> "BPF_MAP_CREATE" are valid values to specify for delegate_cmds options,
> "BPF_MAP_TYPE_ARRAY" is among supported for map types, etc.
> 
> Besides supporting string values, we also support multiple values
> specified at the same time, using colon (':') separator.
> 
> There are corresponding changes on bpf_show_options side to use known
> values to print them in human-readable format, falling back to hex mask
> printing, if there are any unrecognized bits. This shouldn't be
> necessary when enum BTF information is present, but in general we should
> always be able to fall back to this even if kernel was built without BTF.
> 
> Example below shows various ways to specify delegate_cmds options
> through mount command and how mount options are printed back:
> 
>    $ sudo mkdir -p /sys/fs/bpf/token
>    $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
>                 -o delegate_cmds=BPF_PROG_LOAD \
>                 -o delegate_cmds=BPF_MAP_CREATE \
>                 -o delegate_cmds=BPF_TOKEN_CREATE:BPF_BTF_LOAD:BPF_LINK_CREATE
>    $ mount | grep token
>    bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=BPF_MAP_CREATE:BPF_PROG_LOAD:BPF_BTF_LOAD:BPF_LINK_CREATE:BPF_TOKEN_CREATE)
> 
> Same approach works across delegate_maps, delegate_progs, and
> delegate_attachs masks as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

LGTM, this needs a small rebase though given:

commit 750e785796bb72423b97cac21ecd0fa3b3b65610
Author: Jie Jiang <jiejiang@chromium.org>
Date:   Tue Dec 12 09:39:23 2023 +0000

     bpf: Support uid and gid when mounting bpffs

Thanks,
Daniel

