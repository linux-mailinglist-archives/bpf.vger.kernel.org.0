Return-Path: <bpf+bounces-26918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836538A650F
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 09:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3FA283C4E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37FD84FDC;
	Tue, 16 Apr 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REhlQGam"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AC8120A;
	Tue, 16 Apr 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252500; cv=none; b=MV9BPskicz7ExV/Ab0bSTJFBVx1i+u/ehlPtYrPekq4b1vNr1rUv6Roc6xoNeiA9Q+cgm2/4KYeVXt1y28i8+mhIO2wknZxn9jnwcwR+pNoyev7u2OPARDmdXDjywFsUhYudgdwMrPAreEGsoW6FVnRYY1wTS+zElCsgd/hQJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252500; c=relaxed/simple;
	bh=fUz2ULHO4vQM0iAFiGLWeq+An9hACICk4W7WdzUWjr8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7w7fgd5fpMbwIGo9PQvPIrm8EUG761r4vsBAcqcSY/wBzZBnnBSxa/njlzW+NNyki2RV7lDgEI6ObvbB75sT73ye11ljzebEpTn+Qh5WKfzvPLFDLe2M4W0R0fHlj3wQM/1tuPd3fBIr9wa6Nml3cbLduPLn/zVszPHFX4lw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REhlQGam; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso28537771fa.3;
        Tue, 16 Apr 2024 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713252497; x=1713857297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVbg0XEuYD0ISZnmCPk7SJEed6iK2Cd+clJNUGNCXzw=;
        b=REhlQGamumpJ6h85O6hrUv2gsuHtySxA/AMo1br5wbi5D6whMAT3W/fTUtDMP+nZV9
         w2w4zZEwepe6W5TlKza5fSuN6PwvNFxlnGWA2jw8SL+gK154eEfqTt75XE+mEN9CYRmZ
         0pFH4ZykL31LgOwWPhiraTXRj/89oZYxKZwvnZb0GefaJi/+JG9ggonK57fJ4NvpQuea
         kwwzsdAUhOhKzDb8Pk2cBxzj8ImpHCVfRaOTtqDBI/s6exc5pjLxLHWBAvfJHcDmPigu
         tLo6vyKFxvapzvKUyA9nlAQk++MQVnYeGHrkXiSB3T3OgzZUcmJsvr93LUnZFAzC+0rg
         Y7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252497; x=1713857297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVbg0XEuYD0ISZnmCPk7SJEed6iK2Cd+clJNUGNCXzw=;
        b=af2YKwkJiGIqxWb5k/sGGg28pxhapmvMwpQyGn6qqIfqGazrn8cvcZykooffj6K900
         QAVK0anha50XOCpre5WenNQZSGTM3moK+17nosx8Dg9NZ8NN5dj14uNJQ6VK9dQytHxe
         e/ygTLpsVa///XCwJVFfg8MAP8iDE32prnlu6MVU2T/5+HXLuICJ9DukPwQJC4P39+Zj
         s2J5zOKVtSsSFQzhrQ9mei79YVQXPcV3KZ6jTB34X8xDqihP+ShD8YQ13OwTtMHTFCLF
         vaff+Dazu2LAdDUjV9gHzr1hgpsCBKIaXwmUs6u0E+Jb9opKXluo0RGP8UjhBKnkpT+/
         N0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWqHAUiytJS614o7RtcU3OW2Csc1aOPh2YHm2TsRxTldaYfmZ4ogB7fjN38bktppP7qF3Ny1AuFsoPsLzyPTWalOgyY/292v7JR4CNXrcuyI1ZL8B8ajmb37V7H+svLIPe0
X-Gm-Message-State: AOJu0Yw3vUGqTXNGybjj0zdEwZPU1HQNR1NtPOWYnJvATs3Wvw6kb127
	N3tVWZXe6EUWQkXoDqh3d3lYty7PF+RXN6xKpT03CNsS4B1Sflql
X-Google-Smtp-Source: AGHT+IG2gqMBH6kLPwUn6KCJfMr7TISak+pyID3GCPxN0bPio8S5npb+dB3UDx0/hupJ9snCuIvavA==
X-Received: by 2002:a2e:a696:0:b0:2da:c37f:655e with SMTP id q22-20020a2ea696000000b002dac37f655emr991334lje.16.1713252496774;
        Tue, 16 Apr 2024 00:28:16 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b00414659ba8c2sm19059251wmq.37.2024.04.16.00.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:28:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Apr 2024 09:28:14 +0200
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, haoluo@google.com, sdf@google.com,
	kpsingh@kernel.org, john.fastabend@gmail.com,
	yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	martin.lau@linux.dev, khazhy@chromium.org, vmalik@redhat.com,
	ndesaulniers@google.com, ncopa@alpinelinux.org, dxu@dxuuu.xyz
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
Message-ID: <Zh4ojsD-aV2vHROI@krava>
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
 <Zh0ZhEU1xhndl2k8@krava>
 <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:27:21AM +0300, Dmitrii Bundin wrote:
> On Mon, Apr 15, 2024 at 3:11 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > lgtm, did it actualy cause problem anywhere?
> >
> > there's also tools/include/linux/btf_ids.h
> 
> It caused the problems exactly in the file
> tools/include/linux/btf_ids.h and was reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=218647
> The patch including linux/types.h in tools/include/linux/btf_ids.h is
> already there https://lore.kernel.org/all/20240328110103.28734-1-ncopa@alpinelinux.org/
> I also faced the same compile-error of the form
> 
>     error: unknown type name 'u32'
>                               u32 cnt;
>                               ^~~
> when compiling the bpf tool with glibc 2.28.
> 
> I think it might be reasonable to add the inclusion in
> include/linux/btf_ids.h as well to prevent build problems like this.

ok, it's in the bpf/master already

jirka

