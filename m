Return-Path: <bpf+bounces-30410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321498CD92E
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8022837A3
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70E2BAE8;
	Thu, 23 May 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GvYQJqK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8B1170F
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485661; cv=none; b=dWdSubxF+8CZgbxph7JmBnreIeiRKV4/+HtJBUBdB37riUWyDPwKQWtVYN/N8mGEwYvzJYNX9E0pJwV+bSbx1fJwB7q09D32vypm9uvy3yDHSf6HX6QGXhU62RRdQ1jlrmFh4+OQwIYZ7d8Lj3YsvZQZI5Iqik6s1P7nuBVS1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485661; c=relaxed/simple;
	bh=RYh8OoLhG8wkzSmhSUyk7cd5O5yDxbhp4x4bwoCPaQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeZ6hhXP8MhM/YjZl7D+jxaSkEkebiDSNWfWB89mEFlGRwFz43JIalM/L+g8HwfZyad7ejzyN8S2MxfUDBV8mnVHurf17FKe2T1QgvHX44A1zilyPvFtyo9cH/ATMLZubTYZUmrlXZYF+YUVy9lbXHk0zBSWkn+hnwXHqDbOACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GvYQJqK4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso50057331fa.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716485657; x=1717090457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyl6AEu3ds8HOVz5EQ1iksU/sF1jUG+bBH9mudT7v9k=;
        b=GvYQJqK4uqqmP4zGwGI8YA0pyEWPgEP6D5kcgbHxsqvsqXxzBx4qeje8b36JoAac5E
         SCRgElbACXhurZ/gYsYDD4oAtfYPyBe0Y/4q3ooJdNFj7nWuwV7yd3qxnUuGSxujLu1j
         /96HeIjPFUTB40UJzgHQrct/ZsrrryRF/GXV4R388px/bBmW+0wqnAmIp1BzQ0r2eZoH
         ltX0qVZj/fejDa4K84cuKxQr1HVlPz6sBRWuP4yD+ZT6BdI0gd7hrmDOiBrRwqEs48Tb
         sofr7stoBXNdPZDLTRMaqwOrJ85oDiDr6jC9ZQzPXlEA7aXhQoOGRB3D123vlKXhJo9c
         K+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716485657; x=1717090457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyl6AEu3ds8HOVz5EQ1iksU/sF1jUG+bBH9mudT7v9k=;
        b=UPMdYUaZxe4yrCSzo1UCcsIMyXfMBDP222zEQIPvTAbp/xEn71Zdbbr2rUvxOUKx7U
         +yfgnCf0SdZYWZBnwtiAQ1Cekp06z1YeJPeFF7w20zGKZhK+1ufjtzUu9BAVii0BM9CM
         xZBTg5uSesV+qfB1kb0d0BYNngbfYSFMsZ8eWHdYutiJ3cy1UUHtVsMs42IujJw0O/je
         JqftbRmuWtvHGG3bRSmCXGcyN1+WgXkpM66UERwvwjLCRpZ50fOt/JuZHjFigdWlHbav
         PlgPC6Jh2RFnqDyB4WCyorxlXpOsFm3nZUEuOeWK/49S4IvSEofw387QxRncFOhymM2J
         Oc6w==
X-Gm-Message-State: AOJu0YxVxgzVxcQYrn87EIZCavCKGnbwauOidMcdjZUlctg+IG091aAr
	JzuCBaGhxT2WZJ1lqcNxX6X97KDLwVE58vcAbwoyN+MCGUhrhrmhrKEITayV/Hg827hr8SueBsy
	m
X-Google-Smtp-Source: AGHT+IFXekDbCnSY7WBnUPe0IaSYY4323LkuEJmBOgeKR5/bRB3b/Lku/fnt4ODfJWMzZ5BhCRVpgw==
X-Received: by 2002:a2e:880d:0:b0:2e2:9416:a63f with SMTP id 38308e7fff4ca-2e9495bacc7mr47964711fa.53.1716485657383;
        Thu, 23 May 2024 10:34:17 -0700 (PDT)
Received: from u94a ([2401:e180:88a1:25d4:f551:5931:7a2e:6b4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3465fdcf4sm12760975ad.60.2024.05.23.10.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:34:16 -0700 (PDT)
Date: Fri, 24 May 2024 01:34:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrei Matei <andreimatei1@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [RFC bpf-next] guard against access_size overflow?
Message-ID: <nbluhqaveyf655lrrjodnsmknu3tzhflc5eehbnoelhtmb2k3u@k4qsscg7jxn7>
References: <20240523131904.29770-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523131904.29770-1-shung-hsi.yu@suse.com>

On Thu, May 23, 2024 at 09:19:01PM GMT, Shung-Hsi Yu wrote:
> Looking at commit ecc6a2101840 ("bpf: Protect against int overflow for
> stack access size") and the associated syzbot report (linked below), it
> seems that the underlying issue is that access_size argument
> check_helper_mem_access() can be overflowed.
> 
> E.g. with a bloom filter where the value size is INT_MAX+2
> 
>   4: type 30  flags 0x0
>           key 0B  value 2147483649B  max_entries 255  memlock 720B
> 
> The ARG_PTR_TO_MAP_VALUE case in check_func_arg() could overflow
> access_size. (Potentially in the ARG_PTR_TO_MAP_KEY case as well)
> 
>   case ARG_PTR_TO_MAP_VALUE:
>   	/* value_size is u32, access_size is int  */
>   	err = check_helper_mem_access(env, regno,
>   				      meta->map_ptr->value_size, false,
>   				      meta);
> 
> Should we guard against such overflow?

Oops, just realize that previous patch in the series, commit
a8d89feba7e5 ("bpf: Check bloom filter map value size"), already address
the issue by limiting value_size to KMALLOC_MAX_SIZE and mentioned that
what done for value_size for other map types as well.

Sorry for the noise.

> ...

