Return-Path: <bpf+bounces-76833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16FCC654E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 08:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F8D300F32C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11F3358A8;
	Wed, 17 Dec 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Itanjh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945892E2DD2
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765955204; cv=none; b=tsmPKl86ECColbxjjIoLnXs6/qT9Dfy6AwvR6rKhbBf/7p6d/ZLgVZ5EYNyKo57Uw4q/2U+A7CXOOBt4BfRQlbxosKr2L27rjQ/ntkHiqUjie+0+i+2esDhXdrKYWTKp7DN1jdPttSnPijy9+WFNzFWiZ6AGEEnDvq9lxhA5bGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765955204; c=relaxed/simple;
	bh=qdaFYfkw1lLbVBnhBPIrFpwmIgjvCBy59xdBN2aMPBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEOo2a7TUZpqJpcMw2RAB3ugHrf2rKrW6GWzlb1V6FH5Q5Wk9TW//IuXUCWNXJKSEesEyNKbNUv9QL58hr1I8ud15wPbkH4Zb1dObH908+aQgjzdcElrM5BehxTqbop+dYUbbMG+SPRKAsyJWR6R2dx79gUBKCpkbxwGqnir7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Itanjh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6348704b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765955202; x=1766560002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdaFYfkw1lLbVBnhBPIrFpwmIgjvCBy59xdBN2aMPBw=;
        b=U1Itanjhc0Dcm17AdL8fP0fe88WB+XvoaTmvapSE18LwceGN+zRbrXuJtu+A/PKeow
         4cJVToZr8azI+Zl2RkwKypc3DkGwQGNHI3hi2WQ8xBvpLG3mVasDqwUq50IRteVYcwNy
         iBi2t3fW0Y42DllzM9ZAHk6fffmEBxhRHUZGqJzwkkwQSXDWu3O4qRS7LHJgJwHViSQb
         FLb6LrSz/UYmWWzro8qeS/2k9jyqXC7wF9O7KXL89y+jGvYjQmT4zSeR3F7VraBz/FAX
         dNt+OvwXhSVHWx4Omt4e80CL3eK5f3FX5I3dMui3SFVKbdoA4YzOPNghjG+8osWe/8x6
         NyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765955202; x=1766560002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdaFYfkw1lLbVBnhBPIrFpwmIgjvCBy59xdBN2aMPBw=;
        b=oXS+rpDO2x4G8gTeQeZDoR9AZttXJ+J6KWNd2F8NT5265rBPzZdexp2LiFTSkq3oay
         i5Ng3rmhkfQZ+j8NP4oI4B6pzxq0whLEn84/PSxXg7AINqhKp8UCtcU8l82qPwqZOAUM
         AQxp3KdhWymoeHBHBFXzKOs5TOMECYTiFAp9ZQiqm9XS+I7JoJ3XBicibl4aQKMGpOUj
         henKxLXAtRqN7L2YbJw4ilPkdw95fvuaHkrf+d7R9eZqIfmo9MND58rYu7DBvur3NEKr
         RtewGP46ZyqecDz74cCPUrx3aGlO0IWhUti0alg979IjuBX72D+9uiE4psThVlzX7erf
         yEEA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcolSK0Mdi8xetUoJLa30BQJPrNqG8kFmvkPQkxbn+FZfAaapgxNzCgyXMKlIgJAFdlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPaJ2oQjjf3Lf9/PkE05DThGZv7+Ff5sgzg6Z7jnDLu87KTTj
	j/73KMRTNGA5DRi/IeRUAqE9v6IlXRkER9GhxGPvuEA4gOjW4QcPxfKu
X-Gm-Gg: AY/fxX763xuo/gbrzQD7JKnRDKHl7Sgbxw6SfIJSPpaH3d6oVhYtPUS5T/L48a9+b3r
	mHOqZiiVb9RYv4QPATHBjSTJDxA928C7gfNhX/D2rfeiAt9WtCcYPfHoZzKfaQ8an4BpOrXlBKC
	FvIqCkZFjhCL3gR3zAmE7UK48JHilMFsYUGe7B5XJ2l+CxA9ALdOLdUYp3V/8VCjaQcW2xiozqE
	yukzHbOxuqtrtgUYq9vozJpNXY4qgtPSK8Mu7/IHAuYyBFXzeDgRPKejVZhxTyt/2JqywQuI3LA
	uhiO1RHlE/dHDsK/XdMxPprvSiy2r/0wupbCIB5FVyChKSVt6VBxDffJZ8mzsGl/H1Gi8NH1b2i
	0joL8itWlubMHDV175X8oLuDybXIPZ1bOWVsX0GZJVhV7Q9SfrY9VCv3Z+Mo8kgvaxCp4TMM8MV
	hVTNWbDY+OFN+L8eUADpA=
X-Google-Smtp-Source: AGHT+IGaKRJmT7FRagOAqHMjHLcipVbSaf9YcuAyC17QP2PbY5xjKBqQmcndtHv2duyi41ejv4ZLOw==
X-Received: by 2002:a05:6a20:3d05:b0:33e:eb7a:4465 with SMTP id adf61e73a8af0-369ae0ab276mr16885833637.22.1765955201974;
        Tue, 16 Dec 2025 23:06:41 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2599228dsm17618748a12.1.2025.12.16.23.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:06:41 -0800 (PST)
Message-ID: <cb281366a96c530d6ff9b554a5c70b168d33423f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 10/10] libbpf: Optimize the performance of
 determine_ptr_size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 23:06:38 -0800
In-Reply-To: <20251208062353.1702672-11-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-11-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Leverage the performance improvement of btf__find_by_name_kind() when
> BTF is sorted. For sorted BTF, the function uses binary search with
> O(log n) complexity instead of linear search, providing significant
> performance benefits, especially for large BTF like vmlinux.

Is this a big win?
I don't like having two code paths for something which is done once
per BTF load. If it is a big win, maybe just stick with the first loop
(the one that uses btf__find_by_name_kind())? Wdyt?

[...]

