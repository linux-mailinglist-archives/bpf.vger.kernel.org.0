Return-Path: <bpf+bounces-64298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35DFB111DF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 21:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DCFAC1F2B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0252EE27B;
	Thu, 24 Jul 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KFUNw6Qr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF472EA484
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386210; cv=none; b=ExsSw4P7sPw1GUukfKvkjbDynAAYCajMv/UTegqNBdFSxNQQFtDppqrxJfhT212y7wJf1Om3GMHzp1E1yMG6BJDujUJTKfj/HTNwwfA4FiM8JAB6POay+tf/Mi3MTlnTbJMhvB9Ght+ndPgQ+4izi9zldy4oqOTEyKznL1qf1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386210; c=relaxed/simple;
	bh=IBYYG31UT16+uHWCzegCuJoyUxs4w93TQog9yuOlMK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g9uocxXFNJjxyT7pZv5dUe4dpRXO6FJM+41VgOCOLl4ubwatxL6w9VKEx3p53Bt6fejxD3YwnxwYSa9bPKmJUpcQJdrOU/VDIpW8z7FLf57/G+2dpv5SippqWU2BqSdMSjdIgvZi7MVYkKYTmJG0vBLBST8F0EYaX0iwZv6bAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KFUNw6Qr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7184015180fso15546297b3.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753386207; x=1753991007; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3PFVhfgq47lCZetMS+0wcoDuFutGTPFjQ9Nhoukkk0=;
        b=KFUNw6Qr9iR08Ha2hlCaTJP4fPCLnkv5ko54WhyeyIiA2pP38HxaKkxKdQQWE6Yw+n
         N+iZELhRb869jyfksFMfQAoUQ6+BUigdt7g/TfEPg+Oy0pzYgSiEq99+jJxWKr+jguAf
         +PuL1mj+iHgG9xJsH7y1CI6UcF2gvlwt/lgcMzrLqmP+I5d6+oZKibe8FCCs9dU9e/tz
         pQrtOoGOpYllG+5ZTVNlScSxnqNoUnxgZIUZ796g72XWfCiGhKunz5TNlwx24FCPCeQu
         iABDDBUpVHssQnpbGssTyqjH6gl3+D5pTWdOTf7eIxiVibgJNhVTWzr3DCsak0T7rDci
         8LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386207; x=1753991007;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3PFVhfgq47lCZetMS+0wcoDuFutGTPFjQ9Nhoukkk0=;
        b=TGUiEOLHHMtpEG0WRzwdT+/1ji4Z36mG4ZnUqjjPJWI3MrogrQtQ4sxr1MatBy06EF
         Mhs84U/k0F4xIPSqyammau6oXhg1MYbw74pzeWd7rbI6VRB1XcqoTk1Tz+HMRi0adKFS
         zpxSLZNqjxIv7JMfpVq5IC5lP+pYRRQh94WyY9OsykEhbwokE08L20fm2F3N4+oYaxsw
         DOPgf58VlDpYaFPDJHK/0qt7+1xXYv/vEkd8VOOXlq09Au8t1eu9pW1DsTz9W590xr0D
         T3/4D9SCFDcYbxAcGKLyMFrk/ykx6lmV5/0kpzXjlZJ5LN0WX5AfPVLUHg2Avs87T/E9
         p4cw==
X-Forwarded-Encrypted: i=1; AJvYcCVLJPTs8YnULuM8WSt9uATwp6G8ZR7P3pxQhxprzcNq5vTa7Eq+8wEXnmjjY/PT4xglVLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwim5LpNIKSj0i0/jWA1G1IgwtrDz7aDMgy3xwaIo3AX0lxvMB
	x0LtdgWbhi+HKNRP84TpISmzafDwP/Y4uS1Jrr5L02ijdfPvcnssq/J//6RWsqNT6vWcgzKuuCb
	YCkBI
X-Gm-Gg: ASbGncvM0W3UMiDipTqlvjsr1c6Qy2wmcM6vyyxnnIL77buP2xxb9Zr8vEqrwjpOomp
	g/mQQw4gsyN/I9cRp2yefq8gi+jOGSBLdxboUHCYOITDDJyY3QbkXn5tUcFdVcEoh5hETPC5BN8
	xfarnhuld9rVrqZmkp7VLh4GLHX/lPIn5cf3sJnO30cETHbv8tGgRxOGgxjJi9GQyWv1O124ZoI
	e97ntt5UA4u3qk+ZXj6r7P/IvznVN/1NtVxGqjva/RZnTZ8NX+J84LdmyXWOqrpYY3GRCUbDY+Q
	STL59TVwxuPWJJHJ4OWd26UoQsevjke5guRHRxtrJBitpPpYHxpU5Y6N8tJNk23Og0Ibk3JD7uH
	UU1YZFJYVjYoGwNk=
X-Google-Smtp-Source: AGHT+IGfuHEiPstTElt0iBTpfr9wbCggas01pKeXH35hn0yOBojJbtmBuREYaL06maVPnASaQAphAw==
X-Received: by 2002:a05:690c:6602:b0:70e:2168:7344 with SMTP id 00721157ae682-719b41eda51mr97024727b3.23.1753386207254;
        Thu, 24 Jul 2025 12:43:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:5f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719cb91e739sm5232497b3.56.2025.07.24.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:43:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,  bpf@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Arthur Fabre <arthur@arthurfabre.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,  Eric
 Dumazet <edumazet@google.com>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
In-Reply-To: <0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev> (Martin KaFai
	Lau's message of "Thu, 24 Jul 2025 08:52:04 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<20250723173038.45cbaf01@kernel.org> <87tt31x0sb.fsf@cloudflare.com>
	<0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev>
Date: Thu, 24 Jul 2025 21:43:22 +0200
Message-ID: <87jz3xwf1h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24, 2025 at 08:52 AM -07, Martin KaFai Lau wrote:
> On 7/24/25 4:53 AM, Jakub Sitnicki wrote:
>> In this series we maintain the status quo. Access metadata dynptr is
>> limited to TC BPF hook only, so we provide the same guarntees as the
>> existing __sk_buff->data_meta.
>
> The verifier tracks if the __sk_buff->data_meta is written in
> "seen_direct_write". tc_cls_act_prologue is called and that should have
> triggered skb_metadata_clear for a clone skb. Meaning, for a clone skb, I think
> __sk_buff->data_meta is read-only.
>
> bpf_dynptr_from_skb_meta can set the DYNPTR_RDONLY_BIT if the skb is a clone.

Oh that it clever. TIL. So if we end up calling:

tc_cls_act_prologue
  bpf_skb_pull_data
    bpf_try_make_writable(skb, skb_headlen(skb))
      __bpf_try_make_writable
        skb_ensure_writable
          pskb_expand_head
            skb_metadata_clear
              skb_metadata_set(skb, 0)
                skb_shinfo(skb)->meta_len = 0;

... then the metadata is not so much read-only but inaccessible for the
clone. The dynptr will reflect this state, so all seems right.

Let me see if I can capture that in a test, though.

BTW. I've wondered why pskb_expand_head doesn't just copy the metadata,
but left dealing with it till the next step. If it did, we could just
operate on a copy.


