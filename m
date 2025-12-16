Return-Path: <bpf+bounces-76779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E05CC5502
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71BFB300D3C5
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968A33E342;
	Tue, 16 Dec 2025 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9gC9Q+H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E752D9EC4
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923225; cv=none; b=MxiDvDbEMjkYTQdbtoLWo1r7HAc7/FUdo4DNDC1ucHzsx4iFoLrehfW8YC568t7dZXpu6Z9eUAKr3Ub/VO/50z3zwMkgKLXrllhaAU+8ms66T6lelF5cB6Uwww7t+VSxukL26KDSw1DmgNFTp0tR4mC4q7ovahXWVKNp9gO4FR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923225; c=relaxed/simple;
	bh=WlJwZejtyXm3poi5EGdBbT+4qv1SuR+fD0sQp+EVRNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=in3SjJ5K9+9NQ7fe2w3Ejy4vM8CPLXd/w/inEUmL0sDmoCBb5ej1pU4X61Q+hIGNe2Ik5gWUiwcQf7hYH8NiDQx2UwIheG+XCXmjZlMbihJrd0luDkWv1HaeE8A/LkSUPJaSNKHwY4faFrz4kPyJBW7zShfk1UfeoE0Oulf/6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9gC9Q+H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5948955b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765923224; x=1766528024; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlJwZejtyXm3poi5EGdBbT+4qv1SuR+fD0sQp+EVRNU=;
        b=M9gC9Q+Hym/hK7fFy/d9eDQA9aWOhgEPbK3yxyneMBy7vEKvO1RzgFedkUi87yyUuK
         X1UTQ5wUJV9nyPy4N6dYabZcMqj4wxKZbCUwi1FBXKpVypwG8oJrOeSZaJqrpZhInbu5
         Ej0QhPPiwNjEHR8XX/JXfPoLsHwGnuOFXwgEPRy94ebje9W1XCsbU42oHZpobP0Ep84g
         NUGOHY+Ny18HTVxVACQVCx+8XIeVBAjTp/EHdLQhK8nmm2fN6nbfSxZ22Jar8e06wqJe
         oIrAgaskucqEY0Km9vRoO4dzCsVf9xxPjyTW2koEVdbWyqf1dOyEYQtj2PxC5BU23L/q
         2Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765923224; x=1766528024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlJwZejtyXm3poi5EGdBbT+4qv1SuR+fD0sQp+EVRNU=;
        b=Sz4Q7lE+mYv/1yXqWmmZW6hqnNgWXcAIw8abV+SxUozU7+qKDR+x3k7I/iosLe6GrO
         1jg+V/cTm0oCe212IB5vMZwICdrnNtxis6pld0hl12cc3w9BL0WqWtMeBHq2M6YNIB7m
         Z9kB5GxMvOksg2uriQbOg5CDDAe9P66z6Mzkm7pwWM8jGT99BjTfRG2NIJE9ZUSA+bx2
         t+4KpOMbz2643YdwYRjhpkt4k9Yy+HTE3Xs8VrjM0H38dy54PWIR+Q80yIhvzVnMhTVD
         kZyRq8ffJ3ITCthm+vFZA0RSObHxa4gzUvJBfu2BIk5HgF3BHVsHKj1VQxYfyJ3bSvPG
         Gg9w==
X-Forwarded-Encrypted: i=1; AJvYcCVqlpEiUZKeTVK16/qLYxfmOlds2K2QcyZCun9B51uEfmR+EPybGi+j0pboUCHu9IMxXg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgVu/CUMn0DB/GN5I+GDML/P8D/DDkYAznR/kA1JiwZ+k8nOX
	tI0mXkht4PX2FCDywJszyGqMrF4P2LlUuwvxhVUQQf9dqbFw4q6DOrXg
X-Gm-Gg: AY/fxX7CE304aWO34kCII2bASx0a7TYFSm3NbFAojq33Wz5Zqla9YeDEjZ7zkYZrCs0
	oN6qs6irIVoKmbP7aGL59ZiwVGhyWRCnB+MvU6QyHN9txDgAzu1oLBdqYOactKN+09rkY6YZTtP
	8kydphIsh0HoOxEUafHdAZWBBDG0HcgVxIdxs6aVUiBCha1jyxjLKrjsXRHn0ylkKsHbcJKaqtv
	X8Br9M+F5oHhdKxUV85FWyjB56JCI5qLQ0ki+W0ZA5BpmAptbabXryr6vltVtcf6qqj0L63bSgr
	RzMaO2TCrOGfOZvA+Jda6vomruh4XLpRNVNnhnieAC7uxj4/rKd8UcwjYYsnaBta7HAmbJ53hQ6
	9LuDvSaXNlgPorI9KchrMihsvoMAqzMtSKdlPLYCdtyvGX4xpg07LEINAfYpAabnrONJiBowMhf
	dQd4+jBDMZ
X-Google-Smtp-Source: AGHT+IE9eN7uySuleW8xGzJlt1bYU6GgSjaqac+EXTVSfVORSP2l6gaFayJmCmTlr8j6WCnmI49uwg==
X-Received: by 2002:a05:6a20:158b:b0:35e:d74:e4b6 with SMTP id adf61e73a8af0-369adad01a8mr15873585637.7.1765923223871;
        Tue, 16 Dec 2025 14:13:43 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25a86fa3sm16515002a12.5.2025.12.16.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:13:43 -0800 (PST)
Message-ID: <07dccdc0eb8ccf6cff0645ad37d773ca6a43ca6d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 03/10] tools/resolve_btfids: Support BTF
 sorting feature
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 14:13:40 -0800
In-Reply-To: <20251208062353.1702672-4-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-4-dolinux.peng@gmail.com>
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
> This introduces a new BTF sorting phase that specifically sorts
> BTF types by name in ascending order, so that the binary search
> can be used to look up types.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

