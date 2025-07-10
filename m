Return-Path: <bpf+bounces-62963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D907EB00B4C
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBB644770
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C02FCE3B;
	Thu, 10 Jul 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT+Gzrgf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C822EF9DE
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171932; cv=none; b=i9nrXvO++aT1oBAekVLEpmbaCOG/2vWX00zvnmgwW33tYagmPdeaX+GaNb8GCcee8GrQS5CbONiyRk5c/l33wWltz2vUXjjQ5YzgonysDZM+QkSTTJnbhH9Sj2BJj+BJ471IINGTP73cPcjeoe40yp1w7lOzVIWfhFd6MzrzIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171932; c=relaxed/simple;
	bh=lzOg863td9wmwIzdOW1a8mSXM5R7uBGHNR/Wq8C+XKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI+o3AEym7roz4daLS/qbYQquNgwxX+1S272msz0F22kwIisQVxNhSB8L7skUTkgqOxYODXZYSDfA8pCLveSix35cUA/2t/nrUSLpnikkkqIUc7UOAR+edXXDXk2IqeEGqcQQbmP3QcLSEG3nhB1uAe0V4GGZPjF9hnUFM/odcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qT+Gzrgf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so1636a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171927; x=1752776727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=qT+GzrgfFbv7TNCyvI1nwQhemlew7h2QPaGYd69Kqi499zFAgpcsA9L6Ql8C2UR+2b
         z67/WVydCFIO9AGIyO1OsXS/QNtLnHPNtzbW4xhg/W7vGQqQ0v819gJlOeguSiYqoazk
         yMTfvUrnnPivCdLvSRZcCBY1l6MvszfzuWVhO4rcMWA7DWJFMF0dFW5zKB2ae7KxMgpZ
         fQsioD+YvOSbxnDPApSnChHOEQ7WgMczdqaCs+9KmDuuYoiQI34SRzh8O3sJQLGt4fOc
         +b1hMmPhnAM2GtRhbfsEDW1nlV0Dlnerr9J/1xLuLVglKv5j2qYJvI6pA9uC1oWpWxyH
         6ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171927; x=1752776727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=h6zkTwVNkj2jgQZRZ1eIyrWfSq07oXFWYpWEy4kzB5rf8fDOgT4x7FGaGGr+dV/89t
         jXBVYRfPsFGCqayPEf6OrrxOPhpazZDRQJeVNzMPS1ExTcXj8yPXclkJb7WslEuD1YDE
         uBOlY2RlkKGT2vIZdMgIOXQTBgPGoP6mC7Y3AA4D28wfMLh/GDc9oYl7xhdN3KDc6/n2
         704pOezCTJuYKn1x8DZPqoH1X82TvCTCfrS6BPZ5R5KgMqjWr97BwDHF5Hdyxvy5L69B
         XeCvC1YQ1mDyzQC0/j/Fo/2pV7wF7Bg0cJx3uUfAloXbVmMp75ixtHv5ehi/l4tEZpXo
         kNgg==
X-Forwarded-Encrypted: i=1; AJvYcCVc1Wp0aprixMQT28naIRmGmipJhAYWnTlQb6Iq+x/x2xJSXkP1Oq1+pq0K2yfJYE7u7wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UTKOxTtNMAFuxUrpApiRR8V24ktaMxjJgytrgRATzelEZPCk
	bWOWNB5IKn2FF0yRF8zjkulRlO3dU14cRk2mKcoAvbrS4ZnUMeU2tRZTmc5/bBy2ivztP3dPC+Z
	9iYlf4haukWLZUqEAv9+KXA74b/pPyA+u7sdYrOmA
X-Gm-Gg: ASbGncvDBDGyeOQKTwewvXyK5zUs2BqjzhpFn02wog/JibX+Z+J6zV9TS9IDqvwsPKj
	bG2agh8cVEZTbpQOBjgV1W2k3oo9gpmiwU/2RViQPBHBrYNeAvWC6S9vsR9JPv3/e7advuB/s8w
	ms6iUIKRWz/w7T5VVkFbe0aVdsokutAEzk98i50+UG9apxd74MDD2+YbJPOv6vyvVAuLDLTGU=
X-Google-Smtp-Source: AGHT+IFYbu4F77iXBeAnMl5OLLUNqSyy6NKKa5nSrUrX3MSMLO1UBBwllp1ZZ2m2gbUJ8CJrAGBesZolk6+61YYGeCs=
X-Received: by 2002:a05:6402:30a6:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-611e66aa77bmr9269a12.0.1752171927040; Thu, 10 Jul 2025 11:25:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-5-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:25:12 -0700
X-Gm-Features: Ac12FXxKh5TJZHgIcSqvUZXVnJGYFBLJKrIZOv19NnRAZsweNKYOtzi0atTHg_c
Message-ID: <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page
 to access ->pp in __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, __netmem_get_pp() still accesses ->pp via struct page.  So
> change it to use struct netmem_desc instead, since ->pp no longer will
> be available in struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 11e9de45efcb..283b4a997fbc 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return __netmem_to_nmdesc(netmem)->pp;
>  }
>

__netmem_to_nmdesc should introduced with this patch.

But also, I wonder why not modify all the callsites of
__netmem_to_page to the new __netmem_to_nmdesc and delete the
__nemem_to_page helper?


--=20
Thanks,
Mina

