Return-Path: <bpf+bounces-32529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B1B90F493
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0404A1F228BA
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336E15530B;
	Wed, 19 Jun 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYPPhu2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78D158A08
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816083; cv=none; b=EXDseGoDS3OUTtXum/h2sDcp4fmhuk+f7+a4UvYqzoPdsSUBhfDDcth5E2HJy4+4uJaT1BmZB5JTL4LZE34bG1zvNJvLEgPvr1QynyHF3y+E+yqSh7Dr/LBP2gczhpxuxrzQFJ5iNX8CjsE9EetdOk04pNhDWXa4CTzqR3agZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816083; c=relaxed/simple;
	bh=TM+1sGiyp3K3CASPTHtMnTg0D0XZZY3KxnSfCYb/kVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZByYWiYKi0ic/1S+sm1QS590oAxOZ/7nbqA0GA6M+FDxx8BvDtOYz42WY/mVrxgt+zkmSoDEO6zrReRRWZyRMDss6gb0cFqYVhQdPh8X4SjxrlnBjtjBxkAUO0V11oiAW74LJD7gZU7tvo7juD4ckbkQs7v48l8DgcSz790w6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYPPhu2G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6fada63a6so55238535ad.3
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718816081; x=1719420881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JkSFW77yiL60p2tG8BueKt2iXvlajSzBffu+HRzWx/c=;
        b=eYPPhu2GfVLmMOrgxGhJzSSo+fhhnCHKMHd3bB3oY0ruI5Tnx0aNyfP/YOV/Hg5ICy
         /lz/f1SIpanm/vJ2aiYcrMTRIrFtb9f+cmLWe0zXqmxmOMB5/pa7yrE0GnJIbgo3nXG+
         4D0y6xNz/khhP5asSHGpLSJ3ZosWfCUDrxfI53zZW/QzT+hkSRK6fYYXZHLmiDq23aB4
         8yah0m4j5SCvOF83q8txTwgXq0Z4UKHq/6LfJUb/G1ALSLxi1HxIG6Oh/SC5CyxmfewK
         vInsQvyNsY4arVE9piLOW5bKZgd87+zsMRljqsnGrT9m20JB74NEd94LnAg9tY5XMIjL
         1Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816081; x=1719420881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkSFW77yiL60p2tG8BueKt2iXvlajSzBffu+HRzWx/c=;
        b=C5q9COwlH8PCCKdjPf5DWtPGkCyX1E/CVkApVLaTPphNOgN3LVp1WYWofpykBJ4Pmy
         4v9PunA9nZaxK6mqdclVdm8CHbTlJfteChPugGkqbDNTlUd11jChhcaJB8ARMRzBAtjt
         ZbVoUVvqYfP6iNAIP+5JRTpqkW+02X9/CkeLWqTkZabrwevnYHr3nkj1INkAlUHFAfBx
         2UAe02yCPSLQ6oH7LD95HXHb2dxIhtdE7QWEzAasTNA0QkDKGTEe1WghXC0aIxzun+ig
         /pn5smquuBp7CK0mPdGv2S30eNgcjanNBfQHYDGvBIKTuvkBtnsOxd+NBuS+EBldVK0a
         260A==
X-Forwarded-Encrypted: i=1; AJvYcCVBJluJDGmqheOrQOElNnXarLuguyJUM5qVJiLhdZl9Ki2f91goIHW/nu0J+9dU9ztoEVKvjb+AE/L8/MLbwUfc69Ty
X-Gm-Message-State: AOJu0Yye3Y6bDK4aqMxAev2QpZe2EBmV0ogbE1t+MIFL2hEM9Lf41vQE
	8qkxzCwqWduFB1o72hQBf8pOgEM+R2RMLBwwAIv26ZB0xv5ovfmR
X-Google-Smtp-Source: AGHT+IHYxyhILKzPvXqDeFTFXsUIMnzrBANBDeZtreJwLW6FMQnzFDLPdLlcz/2hTJOlSXDdQ4fOUg==
X-Received: by 2002:a17:902:ea11:b0:1f9:a760:506e with SMTP id d9443c01a7336-1f9aa403b23mr36184175ad.41.1718816080582;
        Wed, 19 Jun 2024 09:54:40 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5ba93sm120172365ad.3.2024.06.19.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:54:40 -0700 (PDT)
Message-ID: <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
  martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, mykolal@fb.com,  thinker.li@gmail.com,
 bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
Date: Wed, 19 Jun 2024 09:54:35 -0700
In-Reply-To: <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
	 <20240618160454.801527-6-alan.maguire@oracle.com>
	 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
	 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
	 <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 17:45 +0100, Alan Maguire wrote:

[...]

> oops, missed a GFP_ATOMIC here to avoid possible sleeping. To use
> existing kfunc call test structure it's simpler to do this than add a
> sleepable test context I think, especially since the focus here is on
> adding a basic test. More below..

Hi Alan,

And I agree, GFP_ATOMIC should probably help and it is simpler than
adding a sleepable context.

[...]

> Yeah, my focus here was testing the registration to be honest and
> thankfully as you noted it caught a case where I had forgotten to do id
> relocation, so thanks for suggesting this!
>=20
> To trigger the dtor cleanup via a map, I came up with the following:
>=20
> - call bpf_testmod_ctx_create()
> - do bpf_kptr_xchg(&ctx_val->ctx, ctx) to transfer the ctx kptr into the
> map value;
> - only release the reference if the kptr exchange fails
> - and then it gets cleaned up on exit.
>=20
> I haven't used kptrs much so hopefully that's right.
>=20
> Tracing I confirmed cleanup happens via:
>=20
> $ sudo dtrace -n 'fbt::bpf_testmod_ctx_release:entry { stack(); }'
> dtrace: description 'fbt::bpf_testmod_ctx_release:entry ' matched 1 probe
> CPU     ID                    FUNCTION:NAME
>   3 113779    bpf_testmod_ctx_release:entry
>               vmlinux`array_map_free+0x69
>               vmlinux`bpf_map_free_deferred+0x62
>               vmlinux`process_one_work+0x192
>               vmlinux`worker_thread+0x27a
>               vmlinux`kthread+0xf7
>               vmlinux`ret_from_fork+0x41
>               vmlinux`ret_from_fork_asm+0x1a
>=20
> Does the above sound right? Thanks!

It does, might as well set some flag in the dtor kfunc and check it in
the program (using another map?). Tbh, I thought we could get away w/o
complicating the test, but since you already have it working, we should
probably add it.

Thanks,
Eduard

