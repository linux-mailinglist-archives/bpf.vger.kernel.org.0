Return-Path: <bpf+bounces-29594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A08C305E
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9331C20AD1
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75A535D2;
	Sat, 11 May 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYrUYU0U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7E1078B
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419963; cv=none; b=NpuWRLVLi51Ah6s8HjnsujK+nOidRl08Z27tY0qKdN8hf7xTYUQ6CF8JIAmqhSZcKVZ/JqNQw3uBjkJQUrCS2f8onkKr3PIpd8WR9chtpHjT3qIO4/8jHv3Zk8G9NqWmUZWx6DhgXm8SNf2GoxrUxjKOvcd7pqBjEuvj1WyIZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419963; c=relaxed/simple;
	bh=HOILqkq8BxtZBd9HPeieSVrBfePjg1dYuE3o6DmzW9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SA8gr3r5+ALWGmBXX3zbpyZ1jGST9m0VvbtvUdGwaOP+O2ipgyy+BQGMcUg+eix570nhvyodpi/lZEB68/wOd5TquBIVHfjiK60IfipwOW5xeYCNiVpaXBvvi9Xh27kKwPimk+B8GqyZBhpFXdzOLhUvkET1BFGgYhS2QjBxPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYrUYU0U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee954e0aa6so22426745ad.3
        for <bpf@vger.kernel.org>; Sat, 11 May 2024 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715419961; x=1716024761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dEPTXGrobKklT5uVOh9cGdUc2yBkhosCBcoXtEjuB54=;
        b=IYrUYU0Uf2s3Atx4rAj0xsAlIE9LJo52XdA9C4nEeoS84yzISyf73zSAevehkjLnu+
         D0ATIeIOvGhD7ulJmNxEUuYMP6OV4+Bx0gVXnd7bCDoX4xwvE3RvbooKXMepp3K0xJN7
         dhhc8lsEId8u0JACsHCq1ilWXT7t7HCjtZxgjDKsEkHs9MZbgvg1YZuuQIVAE7vC48Px
         7mb33iysMkwG/HvBhaAPC3fG1UavpV1hQDlGbpvhyNSnw80ARBSDza0y8bVbUJvgptiT
         +wqqHV1MjD01GyQvDZGAs9ctOvq407gq0xYCrzmBXX8bwnQhK81QdcPIzGvOTzbtM3Rh
         qgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715419961; x=1716024761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEPTXGrobKklT5uVOh9cGdUc2yBkhosCBcoXtEjuB54=;
        b=YXI8941i2wgo0RukHOHc/RmlHLLEjwGActD8JgYR0VeKlBdWgLHcyLxQ3nABs0JV2R
         +tlYmm7Hi4f381qgOofRkmpY/CosNJbJ2XyoYZ/4rcohyDXkchppK22Zfdb7JV3tVgCT
         m+eyKY2OHsSjh2sur3/kiJ2TDdVYR6JcATkM3sNdepMMmZ8MdCCoq2rNH4NiOg5T63qX
         ib4DAM+reuPTZzbGRms9Yc3zoSpVvoPnay6uIKe0jasQ3vIOOcEa4e5QKUGvOKFjtyQQ
         BCeV52w1mmtz1Dnv5lLGEV0tnur3rocnquTXsy8GA8X/fW7pKa9Dvf6LR2ER59p47bJM
         6zig==
X-Forwarded-Encrypted: i=1; AJvYcCUEgVV/PjBhNSoBBVVJtdy0U/XDNqG9oXrqZBYS/BnGPV4Y95XwvHnSFbIJOz9P5dwrIolqp34bAu19tf3MB7QVqZmA
X-Gm-Message-State: AOJu0YwFvDJvxcF5h6Ib2nZt7/wQnxluEtN5p0QyT3Y0sxlXSQ4s8HK5
	N14INx0G7fhWyyfVYzMOdvmXGC8dluRu09d7GkKVKgSukdgfK1iz
X-Google-Smtp-Source: AGHT+IHZ1hzLux5RyMvxAgW9sEdSPhwqtJc4/Ut2zfi+U69ocRs7dBpfOMWmvxfZu0UZsKRwo0PV4A==
X-Received: by 2002:a17:903:110f:b0:1ea:b125:81a2 with SMTP id d9443c01a7336-1ef44161e50mr61138765ad.53.1715419960766;
        Sat, 11 May 2024 02:32:40 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm45451855ad.264.2024.05.11.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:32:40 -0700 (PDT)
Message-ID: <4cf9a39ff865f8ad10feba6e4666b60eada41bb0.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/11] bpftool: support displaying
 relocated-with-base split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Sat, 11 May 2024 02:32:39 -0700
In-Reply-To: <20240510103052.850012-12-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> If the -R <base_btf> option is used, we can display BTF that has been
> generated with distilled base BTF in its relocated form.  For example
> for bpf_testmod.ko (which is built as an out-of-tree module, so has
> a distilled .BTF.base section:
>=20
> bpftool btf dump file bpf_testmod.ko
>=20
> Alternatively, we can display content relocated with
> (a possibly changed) base BTF via
>=20
> bpftool btf dump -R /sys/kernel/btf/vmlinux bpf_testmod.ko
>=20
> The latter mirrors how the kernel will handle such split
> BTF; it relocates its representation with the running
> kernel, and if successful, renumbers BTF ids to reference
> the current vmlinux BTF.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

