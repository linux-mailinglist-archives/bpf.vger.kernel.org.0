Return-Path: <bpf+bounces-45448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0B9D591D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 06:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EF42832F0
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 05:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4866158214;
	Fri, 22 Nov 2024 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIaAypHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7867230987;
	Fri, 22 Nov 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732253726; cv=none; b=e/0/sDzur1kIUQ08tjOd05XxDVBY5sQ5kaWIKMiUP9IjD7r4gvugfifVUWEwWaV/gPpy551svprJ5RjHtuX/RtjE186pOoYZN0N3appOecOOfwoScLglbfwS5PYVvZdVDF5Uh/S3hvzt9mGSd4KFYW9i6P9zirieb/Oty9tIkhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732253726; c=relaxed/simple;
	bh=1Fu/eyamRsY/3fVPW2wkEQufdbgIWranViouVkztNUE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MP1C15W4SaZzNw4KDVwcu29Er0Nc//CT7BHFMolzMRfxW8HFdPFoxi01kixQoFV1lAQWp+GqKZJd59vjQvrQ7Ksgv781rIxveuoa2jFEgaFrdxbyWeEDE4Vk/vI3gPltvTkPvoE+KqeuXmv014WpOjBrEmM/jVECukq4YG90MmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIaAypHN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1195293a12.3;
        Thu, 21 Nov 2024 21:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732253724; x=1732858524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGzM6DaE5Htj1XwIKBV1/Zhn8wfqDRpnb+mP4W1uiLU=;
        b=YIaAypHNYa/nPZ691vWWtxm14ekzu+c3tr1y+Wtx9HTUuNfOgbha9RPIS5T80x21FS
         BtvKi7+uVh9uZ7pWlUvMXJGY+EJfTQbVMInv4cFws+ycHjBpzs3QOR108J0rRNFYlRi3
         Sz0+dizwooomS3DZu3fYRPCsO//jw3SC0RQUsEDaPt9THhmebw5EsRZ1Aza9YDz5ssrF
         3qu7CbXTBZKTW1KS7UwYB9Nc8gByMVOj4X81KcidtfqOU0X4SUGs6Gxk87fszeUeMLSW
         0+1xRc+hKtyVd2pcwCeFFa77HD8bJ8SkopSiz0sCdt8lmiwIYCyLEpyAcCt0oMk5jFd7
         GWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732253724; x=1732858524;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGzM6DaE5Htj1XwIKBV1/Zhn8wfqDRpnb+mP4W1uiLU=;
        b=JQvWZIIdEMLGLcvT4voWGQpAiFw02EtNaGM0OutEuAj3WWoslfNQItEC2uus7Zi9uS
         n5UQ75phqSplYaQ65YlPyl4QhYxkihmXdYNbv9kna+PsaHofi0w+h575M+sYw1Q5LEyd
         Z5FngROF+bUQWYIKYlI2lxG7sTxed36J7h2LkSDLLifvJyAt+MUKKjRr8z1OUXKXwNZ3
         21yWgUIlcVzWVBQ+Popojqb571aksUXPcLa0JppFaUIWghEiRAcz/EBu9NcEG37hiOjw
         qJbNrnkMICkYdJd6+6EesEpaCJlQR7Y2MJs4Gr2cCVTjqTCNwiXxzBftOUVfVa8Q3QFj
         XZHg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6uN8Py/MzL87XvVxRHT4MsVHrjSFnNl3MR6kLjIrpHC/g19qFfCGYDIAdb2TU2/nsjDAocB5oQlB72Os@vger.kernel.org, AJvYcCVttM+8MBxIZwF/Yt+n/OfRVIOY5PdO4XksKct/ghqJWyehyUXkzn/33eAFxFuBMBWNxBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxna8IOE9wuGkrAjLAs0s+v2XDyUpou1B5+ntKtrb7JiZJ9Vyx
	424nCxEQTvy6ZlSpPEjpcyaHEwnSad05CcsMjBbESs950T2wysqr
X-Gm-Gg: ASbGncvBXPdhmjVZrsBlE8SzhBQ4NK9ReDM2rcpz6SAO8HXtq8I4AhYQipLSOoLctRr
	Xj6oYiu0I9xaU9mbO7A5RmChl7vgFRirw7fQ3DxbwishWVSkrr1VebfoMfE2fWjioKhrfXupo/7
	OoTU8p+gYYVYELNg586swzTxrkAV5MSzLR2SSse3pqdrh6ND2kkkOGTt2RuvIsVOeyNX7GEF6yb
	E8epSdCpBcX1EcFq98L9ytufPvJfGM2vK5MT0jqqRuSV5vSyDw=
X-Google-Smtp-Source: AGHT+IH82BF4oiF6x6mbKPnAS/dctapod3+sWPM6SVtP3hhv7rVeUlvGu1o00NB3LdLCryczi7M3oA==
X-Received: by 2002:a05:6a20:2446:b0:1d9:11d0:1215 with SMTP id adf61e73a8af0-1e09e40fe3amr2551913637.13.1732253724052;
        Thu, 21 Nov 2024 21:35:24 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de53c38bsm726748b3a.95.2024.11.21.21.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 21:35:23 -0800 (PST)
Date: Thu, 21 Nov 2024 21:35:22 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: "Olson, Matthew" <matthew.olson@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <6740181acbe77_86d22083@john.notmuch>
In-Reply-To: <Zz_YBK3SWnZnze-n@bolson-desk>
References: <Zz-uG3hligqOqAMe@bolson-desk>
 <Zz_YBK3SWnZnze-n@bolson-desk>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve debug message when the base
 BTF cannot be found
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Olson, Matthew wrote:
> From 22ed11ee2153fc921987eac7de24f564da9f9230 Mon Sep 17 00:00:00 2001
> From: Ben Olson <matthew.olson@intel.com>
> Date: Thu, 21 Nov 2024 11:26:35 -0600
> Subject: [PATCH v2 bpf-next] libbpf: Improve debug message when the base BTF
>  cannot be found
> 
> When running `bpftool` on a kernel module installed in `/lib/modules...`,
> this error is encountered if the user does not specify `--base-btf` to
> point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> However, looking at the debug output to determine the cause of the error
> simply says `Invalid BTF string section`, which does not point to the
> actual source of the error. This just improves that debug message to tell
> users what happened.
> 
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> ---


LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> Changed in v2:
>   * Made error message better reflect the condition
> 
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 12468ae0d573..a4ae2df68b91 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
>      return -EINVAL;
>    }
>    if (!btf->base_btf && start[0]) {
> -    pr_debug("Invalid BTF string section\n");
> +    pr_debug("Malformed BTF string section, did you forget to provide base BTF?\n");
>      return -EINVAL;
>    }
>    return 0;
> --
> 2.47.0



