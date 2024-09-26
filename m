Return-Path: <bpf+bounces-40368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59D1987BFB
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B56028617A
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E81B07A5;
	Thu, 26 Sep 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K73OLfFq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719715F41B
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394295; cv=none; b=aiV2nmnogNZLbD+ytzkYlMaxJ+SamYzSflQ3t8hRny+2MFjqv4W7ZIbw4Z5o3O2fdTr1mGFXe0UNAYuXMM32LtLxUYfSk8zIKNJVcbyVQYDOeQGPxsZhWI+Cw20yf8uoq7GRoxqEe9cM4os+2my0B2JVOq72xuEWJL8mXnM4e48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394295; c=relaxed/simple;
	bh=TlXnSNg6/uF3dHpv7h74CDNwtN9AQ1jFLBypSXZo2Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtnGRE9aPjjIxxdtp+u+VmdS1GrgfirqPxjO3a1BHodYZx7HJqg6lzEJpq9FtC2R4Aw9AzhNgmwjuO00Vdv6m7a2P1HgJqBse2W2OmxGUfT1bnwkN33F6zgdwLWJgQbeIpPR0cKR4eiHWw2fNumNMJSPmLNVeiOC5Qas4RgiOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K73OLfFq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so26581a91.1
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727394293; x=1727999093; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBqucrFp/DKM3daOAqEmik9TBOFBqpw1FWQ4CUOEH6Q=;
        b=K73OLfFqMOaUJlcj6VVTpiWWqcFK2JCRjYcrir8Pap3rh2COA+t0RGd3mkuIekQ4qb
         ohxoEzpIKOOA/yrVc+4mJ+3W6NgkYJHnTFo52L4BOJ4OmhbLyfJNY0X5wRmKHuaOm398
         JWGOhfUpazCs4bt+EhqsQoTNLYzhhdJqWGeKd7wiwRAXiOYPGLJaGv5bUAS7Ns3gMW5T
         KpEUZKaArrFKglCW3RCrvNPRprEitzrizdo1wuFmFPnhoWTqVxyGBd1qDqpJeSx1negO
         vEDNMr/+rx5lquGHwylljB0d0E+Et79TFsnAs9CQoJkybJSl08hplobu4qbG3BTFJl1u
         hXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727394293; x=1727999093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBqucrFp/DKM3daOAqEmik9TBOFBqpw1FWQ4CUOEH6Q=;
        b=sbrP26yXY5CLalVNGXGi6wMh7KcuhnWXaO2Fbd5XODAuIxs2+mddY7mNnhb8qhtC8d
         MqxrRdXEUTmAO9UlUsWMPtT2lcIzxDsHkFeGb/KAkGDB6ubFkZ0ANLMNX4Rz/qGpPvOM
         neP2lmA5X1aTgdmq+mN9pFHdyr84AwZZIs+nPb7VW7OMRxmUkgNobX+UJyyVWWOB+qnS
         onOQtWAtqvYWwG2nKGJox4JggSZ4DwO8fCNzl36OraVGJHB1nL49bH7rQlgXLbgBLNnW
         PgcrXPLXHRIKX1wRrgc4AQ6crn8ncj0FQAdGZNQT6Tnahn7ykzExNZZm3jcL9mf2m3H3
         RFSA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCGw1fFexkWoGc/6PPaayL9xoonAhGdTn2/VXXrRMEmN5Artu8YcYxFsiTr2KwKY97fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sHRuTsy0Qbs0d4eA+drR/0wgJ1JnccJYTcjab2KxPcGbdRTc
	jzoARaUV6+UkFKFgx4zZvaVFFzBbSyjN3p8xz0+CuONqhFoFS2lR
X-Google-Smtp-Source: AGHT+IGyeCNklITd56+ENV40Dpwi34rUyDHFHgbOB2UWollj9xVwz7V8VSpBQYdZafrlLjmrWGxwMA==
X-Received: by 2002:a17:90a:fd84:b0:2e0:a0ab:7fcf with SMTP id 98e67ed59e1d1-2e0b89d4cfemr1490307a91.12.1727394293448;
        Thu, 26 Sep 2024 16:44:53 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e105e4sm618827a91.37.2024.09.26.16.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:44:52 -0700 (PDT)
Message-ID: <084902540a09a7036b713bd2336955e9b63fb30b.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix uprobe_multi compilation
 error
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Date: Thu, 26 Sep 2024 16:44:48 -0700
In-Reply-To: <20240926144948.172090-1-alan.maguire@oracle.com>
References: <20240926144948.172090-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 15:49 +0100, Alan Maguire wrote:
> When building selftests, the following was seen:
>=20
> uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> uprobe_multi.c:108:40: error: =E2=80=98MADV_PAGEOUT=E2=80=99 undeclared (=
first use in this function)
>   108 |                 madvise(addr, page_sz, MADV_PAGEOUT);
>       |                                        ^~~~~~~~~~~~
> uprobe_multi.c:108:40: note: each undeclared identifier is reported only =
once for each function it appears in
> make: *** [Makefile:850: bpf-next/tools/testing/selftests/bpf/uprobe_mult=
i] Error 1
>=20
> ...even with updated UAPI headers. It seems the above value is
> defined in UAPI <linux/mman.h> but including that file triggers
> other redefinition errors.  Simplest solution is to add a
> guarded definition, as was done for MADV_POPULATE_READ.
>=20
> Fixes: 3c217a182018 ("selftests/bpf: add build ID tests")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

I was curious why this error is not triggered on my local machine or CI.
MADV_PAGEOUT is indeed defined in UAPI.
Selftests build picks it from host system header, which is
/usr/include/bits/mman-linux.h for my Fedora 40 setup.
The MADV_PAGEOUT was added by commit [1] back in 2019
(and should be available from Linux 5.4, I guess Alan uses a very old kerne=
l).

I think that at some point in time we should adjust selftests to use
UAPI headers that come from the kernel being tested, not from the host.
Until that happens, I think this fix is fine.

[1] 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(I want back to 2019...)

[...]


