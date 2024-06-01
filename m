Return-Path: <bpf+bounces-31088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49A8D6EA7
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B730D284F83
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C917BD9;
	Sat,  1 Jun 2024 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZqZUOuh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C114F6C
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226571; cv=none; b=PxfPkydsZ9wxF7b8//K3/uBGNreSdVMYJpGfUxTNaUKY5uNVW1HSobvy9wgxhlKyOQe4vxOLN0LRlIeYRVHZuJIjTVKl4WDpb8z+mpAgKN1pJnMijxlT6TTXGQW0LhQkashl5Q6vKIOrkyafuTy0C67OEZDkpnLu2kusbggNY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226571; c=relaxed/simple;
	bh=e51c28TjTgIO89zlgjEMYgO6f41arrIWCeqOQc470JU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLL8QkEe0GaGaW47DV2XzXmxTFFYotrHz2E20bwNrNtuHU9l8dvoyC4oLoVpZBpgylOSyB6R2bqai/VJvT7L3ZPgF0xp3RbffvMPgHIzS2skwwm/hvr2WxR3uZsYdAQo1E/22i3mImwKZ6BQNHSeqTua119A1cGi3kHIHWr+EeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZqZUOuh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70109d34a16so2577084b3a.2
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2024 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717226570; x=1717831370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=773dvKbS1eLW6TJnEGnqMWo42tD1BsurAbh+K3MMOxM=;
        b=PZqZUOuhkTXEDqP1QhMkrcWEtvCA8RasEGuCa+8sLwR8iQb5SCOEoUrTv5THNzRmC2
         8h37X2+yJ+x4/mve8tX2SXAOiCFYHtp9mjQj6PVLg7wciNvnwOjaVqhf6jvL0iwwesIH
         sUVRsppgFQJP5bu+0KTWN9xPj0LkGTTPWL52QCKVr1i8lf9n1BDMHI6FKyDTXZC3oXMZ
         ZVrjhp+jzwVtkWBHZBZs6mqlRaaL0Gd0/PlYSdS0k2rC5HxLAE5pYg1MADKB7lAto8Zb
         uWbdJy4zr0N9oFo/2cwn3Q3L/rIfuFtdxSWS0iowlnGLY0wLj204X08dyYYlQpJgY/7G
         U+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717226570; x=1717831370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=773dvKbS1eLW6TJnEGnqMWo42tD1BsurAbh+K3MMOxM=;
        b=pI5OVGGtCuNqB8fD8pEBbYHtqH2XnCSpiMAwaYsZqXpxf3H59rGfG1/pNEXJ7kMdb9
         ZQ1jBkxUpjQ7uMdwuMaDXnEu1IiDYgJY+yxXHts8UilE3S2aG2OC602vo+up6NCau3Jr
         7b5cG50OHC65sMfB51UYOInet6rpc+PzXmV8I00i5n8JWySXMbPo1BfPlKRJtMbSBuIq
         /HhG6zvB50QosX6vujw6UnXBwWVmrc7/h70kA9Anja4gjfwpHwjZ1CAJDBaCCzs1hRI/
         4ys/ovA+iOJgWIXC/ao/AL5pUblDWfmoezH/P8CICKCWwmbGFFTTwYtOAkl3sBrVUwkg
         lPBA==
X-Gm-Message-State: AOJu0YwCFVcduMotHfAQPQgS33MBhWduFpYDN48fhv/l43eoTmCoHsOl
	zY5XCObr+5uXj5cD9VsTGUTLzVaTfbxuM/v+6oAFk78q0pWi7E0S
X-Google-Smtp-Source: AGHT+IGTu0lU+aAuQHwAhtASPnubA3IsilQxnORCzJxA2v+udQCDLxBKRMCznTmW5S4AggziUu7wIw==
X-Received: by 2002:a05:6a21:2799:b0:1af:fa18:76f0 with SMTP id adf61e73a8af0-1b26f30da70mr3883828637.55.1717226569466;
        Sat, 01 Jun 2024 00:22:49 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b13550sm2380908b3a.182.2024.06.01.00.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 00:22:48 -0700 (PDT)
Message-ID: <fbb23a418f892cb50470971f8966958f87329b93.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit
 queue and print single type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, alan.maguire@oracle.com
Date: Sat, 01 Jun 2024 00:22:48 -0700
In-Reply-To: <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
	 <20240517190555.4032078-3-eddyz87@gmail.com>
	 <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 15:18 -0700, Andrii Nakryiko wrote:

[...]

> Speaking of which, for the next revision, can you also integrate all
> these new APIs into bpftool to handle the problem that Jose tried to
> solve? This might also expose any of the potential issues with API
> usage.

Hi Andrii,

Good foresight requesting to re-implement Jose's patch on top of the
new API. I did the changes you requested for v1 + tried to make the
bpftool changes, results are here:

https://github.com/eddyz87/bpf/tree/libbpf-sort-for-dump-api-2

The attempt falls flat for the following pattern:

  #define __pai __attribute__((preserve_access_index))
  typedef struct { int x; } foo  __pai;

With the following clang error:

  t.c:2:31: error: 'preserve_access_index' attribute only applies to struct=
s, unions, and classes
    2 | typedef struct { int x; } foo __pai;

The correct syntax for this definition is as below:

  typedef struct { int x; } __pai foo;

This cannot be achieved unless printing of typedefs is done by some
custom code in bpftool.

So, it looks like we won't be able to ditch callbacks in the end.
Maybe the code for emit queue could be salvaged for the module thing
you talked about, please provide a bit more context about it.

Thanks,
Eduard

