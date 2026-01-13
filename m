Return-Path: <bpf+bounces-78677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47765D17BA1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 664C6304F6D0
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116B38B986;
	Tue, 13 Jan 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcpXZiu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CE38B9A6
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296398; cv=none; b=UsKBN4Fw0GiInEJzlRaW97/yd7ffttD36Y1KAqhhgyXcYgNW//m9sIKMVY6OwO7vuY9U1VyW1ZbL/rbzBJRbz7HXcTIX2UhL8DWhnO5iA8rfm6rO+gmm02/B7EkV7peMtQy67w7InLpsRiaZ7DzBZkKPZUsRyIu+RHlwNru/LUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296398; c=relaxed/simple;
	bh=/n+SyEL7kVlk5YekDcoOR3rUIvZKKssdIjhVUrfoqts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frQAyRTGZJbFeHOPX5+5E8vCrk5wd86jl8bFCth4jpRtJmvzkefXqzLajO88uKFTd8Xm5Y44b3EGKMrWyHgy8RHKwBtNabDbjT5g/F8TDwJpe/5FnnRKcd4PCS6vZVglasrLlE/YwXvBxu6uHR9e0i8UyQpHyGuoiTpzUe6Fx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcpXZiu8; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477563e28a3so40752005e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296389; x=1768901189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n+SyEL7kVlk5YekDcoOR3rUIvZKKssdIjhVUrfoqts=;
        b=OcpXZiu88sNxMkFe1rSCkEALu31eGmgcOinTEyJH+cbj0xupJr3iH5rCVPsBLYjc9P
         986XAu1MmAUMSegQ+S1EOpApI77tyP2rWAr1aa2H2k+V53K6zeFUxSzrNPx+89rSyXWp
         cD4vIk/e9erIC5gqbKOsKqIUPt6yZVzmEWOP3qHIsaZ0eJIVLmerj7YFEujpgKzI3XwU
         36C+aPsvOlABJroTKMD0G153enjh0FHy10XJGOfad0LPjdd7qbyts8PTcPZgNLlr7Z1/
         AsIgi5qCG+CxxvkOR7YxjMdSiviYk1PppRN9kkkli9EnuOSN5NbhgLALt395BP1DJ82n
         M8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296389; x=1768901189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n+SyEL7kVlk5YekDcoOR3rUIvZKKssdIjhVUrfoqts=;
        b=SaLBgQB3HsnqPQ40CUP5AboAVK8hI/9iFS7tfxuFM98tOk61mtcj5ttv9KULdbX4KE
         AjvOFQPE7TBgP9mlGzVOZLaE+MUrJAJyC9ERaNQtQzd6w3dhcHYr+7m+OjZk8wbhF9M5
         gagUjVRJEuZnHdy/G3ZtyQaeezOQpj/0IaF9sS9Y3v1uyehtbkI3rQ9FT8+a0WZt4dW7
         xYgKnYDKL889bC/AH19UywMjs0hqMsp9hhRn3dgoc9gl1gwG7mKTjhnuSxw1i8+25Oyy
         /91BYMUY2F+Sgbj5hPsCgwnspl6G6go5yVT6dVLmJCxCAC8DjCwKMtdDq6zeoLDC7+Ri
         QOCQ==
X-Gm-Message-State: AOJu0Ywlt23Ou42KMFz+Tx6rE/LmnfMOqGdhSqPckrNeQhu30BKC6U3F
	75iL7mX8HBmC2Hz/6Ozp4thZUVuHEyekjtEUM8HMVj3NrCoS+qotm7a46We5KHK7NoFkFKYlZIG
	WTomrB+6twDoazWbYR3H6dpHgUr793YM=
X-Gm-Gg: AY/fxX5xVu7pmmDf84+qLgaaLNsl8AFS8oNG4ZVrlKYJQfPYOyM4ETeOhywsPhME5MZ
	bknwcyx2/KJf0nQgCP26r4zdCiLdO2rTLsFUDm4Mm8ABS58UvFq3g613JqE8dw7T4CVLCy4dkqX
	iO77b4sfdXPXBUlW1gZkX8ffq732lC1ckwX6/2FRt2xffqlO9UjpNm+Lo9/9RpQRTpZrjYunkMK
	oucLxj1Oh7ZSxkIBQoUpt/RjMWx3moCGdMlRG6GPKOE9bHUvzjrYTAaNZiFBDqEWryWh8X9ge0Z
	DuYo6x9HGlh7cK3xIqacGM8ZGXUrIg==
X-Received: by 2002:a05:600c:19d0:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-47ed7c3b7a3mr29950065e9.16.1768296389192; Tue, 13 Jan 2026
 01:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-1-mattbobrowski@google.com> <20260113083949.2502978-3-mattbobrowski@google.com>
In-Reply-To: <20260113083949.2502978-3-mattbobrowski@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Jan 2026 10:26:00 +0100
X-Gm-Features: AZwV_Qhtptmv5KP7Y53yC5r4dNfoZuu1zmol4sLZW940qPlJbbJxAQQE5odt-JU
Message-ID: <CAP01T740dOS2bbz-W1N5JiAjSTAiSSphAPK5=9uX_kwkbX0cWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: assert BPF kfunc default
 trusted pointer semantics
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 09:39, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> The BPF verifier was recently updated to treat pointers to struct types
> returned from BPF kfuncs as implicitly trusted by default. Add a new
> test case to exercise this new implicit trust semantic.
>
> The KF_ACQUIRE flag was dropped from the bpf_get_root_mem_cgroup()
> kfunc because it returns a global pointer to root_mem_cgroup without
> performing any explicit reference counting. This makes it an ideal
> candidate to verify the new implicit trusted pointer semantics.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

