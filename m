Return-Path: <bpf+bounces-49255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E7A15D84
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF51166B0D
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353218FC7B;
	Sat, 18 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c2+0cs6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06E190497
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212224; cv=none; b=EAgPGik6YY7lreTUP7vrW3d+mpXIGFyv71OWVHrIK+bkiw/ysN/Zx+kUwyuhTjrAENdGCUca4z65ZBj4sPLb6HAi6pYYuWlW+pKLwh4s5TTAyAAzMwbmFZP/14nBplsodcEsKq6KZH+9I79QG1j8zJ8NtS+gRZUJFmbC8OF/TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212224; c=relaxed/simple;
	bh=0NHPeW6qzDJKyKyv2LwHCzsD698hpuM+Soh5q7bWTbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjsJ1LyZbThNZYeYyvy1xW2vk1CR8L2R+Ung7+bsjFmb6+/O4XTDfPTUWbQlFPMhl0TSCrkagnX/fYGHkgUq1YkjGyDlMCvO4WoAIpLFhh93qYodW/Dfy98U8mS+r81pwX6t8dA0X6Kya3xql1qycpe69KXU3CJxBkEHpD0lh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c2+0cs6L; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso6026793a12.0
        for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 06:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737212220; x=1737817020; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EocVmcdr+s+eiVI2gdxLwDypgeYEKTEqnZdPS6MtY40=;
        b=c2+0cs6L8hAmDImKIpm6CJUfE9wjeLBIBE48ER01GByH146T44N7zQbjL0CaUYiHOs
         F9SLD+hydfEw9wJsm0nobw5hk5kibrb2JcTafsICKy8IGFt3bafjIVYZUxS3XCaD5TQo
         kOh2gI939tn8A3ble18F4/iYVoXqq5X1ez84lTO7nfi7l6ZzZi3riA8qcsCiVZ1sp+Bo
         /XoEvfThEJt7/44wGpcXtO4FS4Da9K+YTkKWcRBjLubvhrod7AXAz85vi6fovhsku5/b
         td0Tgc+yeqTitxUP+c+J+hYFm5Mc5xbaxiMrXdDUmlBpzm/fFPnYJMSTasVDbzSdhgmL
         xZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737212220; x=1737817020;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EocVmcdr+s+eiVI2gdxLwDypgeYEKTEqnZdPS6MtY40=;
        b=VLfByWTwb5Kfoz5zX7vLsRkZSLX5MnIns8lFirKIo668CTKR/nGLM0a57biNoL/51o
         WRUaxVLx+1nXEnLFyM3ZnJczk99kKFm3gJ20q9oNo9/t8qgqnDeMl7nB31anvChlpWYw
         DRV7ilWOBq1mQiW0eys8LGMGzHv8HONZdrSPfdYMVNiHT/2wk1CQzCvTmy71ua6QToa3
         HASsGZ/Xd0crHR6wJX521O/AzwVM0Lemqlv07tQ3WXZ3Fnl9crwA1K5JyxTR1JTqnN1j
         mpivTdZdHmc0QAen9VZ6MnIN0bH+Art/ozc6QLBTFW1MKYaEYX+7onj3qIL3YKymq+yA
         +9Sw==
X-Gm-Message-State: AOJu0YygQH6qDWHKCOu5Ese4p/Lt71TdsAbfZTx4Bn5h8uO9kovPXLdh
	8q7IheVVyvoODyVGkjce1g2Rg4LsAfnfafDqP0MUz6DxRiD1Ip12jtWROF7BW0U=
X-Gm-Gg: ASbGnct0xxGOqs+7w5+PU+CyCXcrs9GE8bIgnWHvNWhGJqHfiiFtr1xfE6hmrmaW1Hk
	14YzeKDnZQlGXM/36/BWjmtATcuXoHrPR9yEPtIHk4/PsFeh9fKLDPy9BydMmYUs5MaSfIFSZ7K
	FxqaXu3/EG4XtSFvicqiVLGszMBWXmUzmgnx3CLWPBumqAxSvIKkEU0mkbZAAMEPBnaHHevTcLq
	VW2BPw4SQcrdGdUaeo5ViD0uUx24cnaVczlK8MfuXFhULOD+2LW0LLL93rPPw==
X-Google-Smtp-Source: AGHT+IESevYlMBNi2PmR28hKWZ371XolKifqyy2lHOUQAsdFLp4R497eQossqBOZ8uhDdvfVNH8xPw==
X-Received: by 2002:a17:907:3f97:b0:aa6:82e8:e89b with SMTP id a640c23a62f3a-ab38b166589mr543353366b.28.1737212220098;
        Sat, 18 Jan 2025 06:57:00 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f2244csm350261966b.92.2025.01.18.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 06:56:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 1/5] strparser: add read_sock callback
In-Reply-To: <20250116140531.108636-2-mrpre@163.com> (Jiayuan Chen's message
	of "Thu, 16 Jan 2025 22:05:27 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-2-mrpre@163.com>
Date: Sat, 18 Jan 2025 15:56:57 +0100
Message-ID: <87ed10dvba.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  Documentation/networking/strparser.rst | 11 ++++++++++-
>  include/net/strparser.h                |  2 ++
>  net/strparser/strparser.c              | 11 +++++++++--
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
> index 6cab1f74ae05..e41c18eee2f4 100644
> --- a/Documentation/networking/strparser.rst
> +++ b/Documentation/networking/strparser.rst
> @@ -112,7 +112,7 @@ Functions
>  Callbacks
>  =========
>  
> -There are six callbacks:
> +There are seven callbacks:
>  
>      ::
>  
> @@ -182,6 +182,15 @@ There are six callbacks:
>      the length of the message. skb->len - offset may be greater
>      then full_len since strparser does not trim the skb.
>  
> +    ::
> +
> +	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
> +                     sk_read_actor_t recv_actor);
> +
> +    read_sock is called when the user specify it, allowing for customized
> +    read operations. If the callback is not set (NULL in strp_init) native
> +    read_sock operation of the socket is used.
> +

Could be one sentence:

        The read_sock callback is used by strparser instead of
        sock->ops->read_sock, if provided.

>      ::
>  
>  	int (*read_sock_done)(struct strparser *strp, int err);

[...]

