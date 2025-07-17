Return-Path: <bpf+bounces-63644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF43B092FF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEBA581B76
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D842FD5B8;
	Thu, 17 Jul 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuAoSDZ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB04157A55;
	Thu, 17 Jul 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772785; cv=none; b=pohaLOaUgAzwwUUwLcWVfa4BZqw83AtGGdXz04pj4Vo0xfERDPlTUDC0KS73lf0j5aAG7KpswGyf8xnrqG4rGr3LHVC1z89qmY0ZGRpBYDDyIWNFIPnDcfpXYlUrTkVAUAUemMk8z3rMki7CGJq0p8X5zXgdo82j1T0QhkJxCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772785; c=relaxed/simple;
	bh=W/DhiasmwCBuFbQCyp1dQTsirgqXj/Eu5bRAkhtMAog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK7Seo/Lv5AboLiBTGfnG5wozUSO4OgH2QW3Lnr/DnEN9L0ub5xg4NG5X6PTtlz9/1C1CVlJRBkgpPrbB4QJkMGTh0i+BaIYk9GQ8JFgaul3JlAs0CdaEoTZ3xIZfcg7Dpjv2quNXbSe8r/fTpgYrGZOXH+ZaZWijtfx6OThulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuAoSDZ9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0de1c378fso184392266b.3;
        Thu, 17 Jul 2025 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752772782; x=1753377582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1rMoCL6Z35Q1ZU9wAKtXkSeqp3Yq+uqdhZO2nKQumQ=;
        b=PuAoSDZ9DE3IQEvB1iVDtthOFz6uq+FC45ysyIjZHrtVCQ2PcTVDqNoeUJrw9KJF7H
         8LIN2THFmE2TuQzELLjc9UaWCc/8vitSNhvQJyGxPpwHqGi8XyXqyJKQre95VcA8oCHq
         Q5CUdRqoPwoUiVUCyB4qL2qpEXVLKgv7b76KJzViHZp4MwcCSiAbQxV52s4OqRLJr2nV
         l2ktdLmoP+gtsFfZsoSQH/BXS8OlY1m+EycvTYY4SpiUGBjoamzt0NkyH3wWHGUe5tHi
         0FFXAs1QRH/9JNP1Jei/d0tNptCHWW658Lr+JzW5qS3U78RhzrrIAz4RdFgMrxdwJQs8
         kHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772782; x=1753377582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1rMoCL6Z35Q1ZU9wAKtXkSeqp3Yq+uqdhZO2nKQumQ=;
        b=YskcuGvtHrKDvVYCOdizGiyMLNRG8jhnyxWzsQkLee+h+i4AHSMWm6KKR/K0Fr6Y+8
         3xvk2xBd31k4ZLnOk29n7k+Wj02NYRrrRbjmo+gdoZ/WuguqtNt3h9n6c8PTKtAwh3pV
         jDK42Y9qGKX4NRIdhxww0QOjbZqIC4M5Lg2FJ7TCyZC3q5KXApouWs0QI75AiA78gz2T
         I3I6hOb2+vj+kf9BwZAqaWZx1e7s/ahkfScRwx5xVAt7pVJeCvRO2+BGCDEpBwHSbI6g
         Js/az9XOMnlN21LN/XXs6xWBqmRfkUBEXPotbmnCwvhKXU1rBU8sjFlu9aTu6qJlwn3y
         BomA==
X-Forwarded-Encrypted: i=1; AJvYcCUs5fREWE962hB3pMx6zdnwNFZzLIoZUvXlQY2hAKrBqkAR11+m9D3YUCZ93ovIDEeHkwsG3u3WvSp2zsT9@vger.kernel.org, AJvYcCVHcTbF/6zhwxCYO0W3yhvIo8JI6VFdOnemh35ecxHxniN8rVu6ofeLRAARLCVhv9uEygg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1ZrvixubffEE9pVu08qwvrExQbwIOis4aOw4sDGEIJjE33SW
	Y7Kb5rvCnQK3jGDMAbo13BFyckk5X9oaERSJ02n4mth2mYZ2uMlvV/hcAoPyVcmC/TDN7XIDN+R
	qT/2D7IJWdBJUpkfjt+CCQqovBJQiHmY=
X-Gm-Gg: ASbGncsWfCSRS2jI3fSny5khV5ghX1KyGZdyLbvp1fN4dWHnKKRJ805+csOnO/Z4Xhe
	zHAWkqRtAIw25qstc6nRMgJ8pq/coxndFpetWSRbupNxtEQNcbnVcgclPedZkVM4dLPKnBOIVny
	8kHfZPy9g4Qs5mv/uty0xeOlqIi+KGsQdLcdkVZjH5Rf/rENynhUDWwJyCPD+Q30dXAV4I4rF71
	C4yMnD3XNP2U5z9ShJTQHQ=
X-Google-Smtp-Source: AGHT+IF7yR8TLWdZv2iR76wMOEnBUAhFbb+Wlu2gwrj7g0DqD5585fO9/6fbqBQJsJwLWddBAL96wRMabRjRvTmlkwY=
X-Received: by 2002:a17:907:7f24:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-ae9cddb1d86mr811165766b.5.1752772782364; Thu, 17 Jul 2025
 10:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Jul 2025 10:19:28 -0700
X-Gm-Features: Ac12FXwUFRH32wJkU9vAEP0Pbh4sI4UAGAlSrErRxYicCr0UK-kVl1OC2kUKGHY
Message-ID: <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:59=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Replace the unsafe strcpy() call with memcpy() when copying the path
> into the bpf_object structure. Since the memory is pre-allocated to
> exactly strlen(path) + 1 bytes and the length is already known, memcpy()
> is safer than strcpy().
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 52e353368f58..279f226dd965 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1495,7 +1495,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> -       strcpy(obj->path, path);
> +       memcpy(obj->path, path, strlen(path) + 1);


This is user-space libbpf code, where the API contract mandates that
the path argument is a well-formed zero-terminated C string. Plus, if
you look at the few lines above, we allocate just enough space to fit
the entire contents of the string without truncation.

In other words, there is nothing to fix or improve here.

pw-bot: cr

>         if (obj_name) {
>                 libbpf_strlcpy(obj->name, obj_name, sizeof(obj->name));
>         } else {
> --
> 2.50.1
>

