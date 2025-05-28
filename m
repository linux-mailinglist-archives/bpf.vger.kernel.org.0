Return-Path: <bpf+bounces-59074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0ADAC5FDF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633FB9E2FC0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B121E3787;
	Wed, 28 May 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLuGLAzF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8091C4A0A
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401935; cv=none; b=PRvkGEbJitIgXHBXW145eaWnBY0Xq+7naDH1Uvj9u0v+HJndkGE+4dDChQV3V8vlsReEXPxJnzHGtdCBQGmC91eENyx63qlC4Iv0NmnsDNVKNYjpr2iimJhBIIaw9JZ9z6TFcvkn3+6cIf75RR7m48ieGUJNvh7BJks237cz8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401935; c=relaxed/simple;
	bh=45wv2D7qTveHvG++liQk1FdgOdvStQgyo7K7EgLBQ20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sf26JQ6eZvTGqq8yax5LmtgTKUB7LjrshOQxbPHkJU8d/UxAIg+ppHjxUWEwlDEdpablKHrKNS1VbOOEFxI9WAKZObEUo/7VnBbIZFXYi3fw7b8XCYRZinpfRwSsOq32bKUgw/SxRThfqKkCFGeOcK+1NDVX5oK7gEQr5cGFDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLuGLAzF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231ba6da557so79995ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401932; x=1749006732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi54XJvxzTpbX0StT38uQRnU2/zb/XVmDK+caARZGHA=;
        b=qLuGLAzFri0ELQo4ug0igeikL8LmDPPfEQYrCmNbU56Tg8RjWHOo8GCx63KdOLC5fb
         94Jn31FyUqWmxqXyNLqYUmxnmjRwO2pQqa0ZZalBFrASW/1pctyQD2t7UllpFpmvNYrt
         y0mwJnzWgd4jTwRFf8njjTLsyOLvIvcxHIQ/Ul0eHEV0u33HJa1R9v7DUTEol/dfaCv9
         XsolPSH5bhIV+A8Xda5ar5qQR1g4R9BqKe9EK8B+ouo8AwtvnLFwFJerameKYWZLZJpd
         1L1CiVHn/Ix2rwsqKjvMl2SmHlnZz0Uz/gvRtZMV1+LLu2nmlHPBrASFWAikRAlKP3AO
         IjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401932; x=1749006732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi54XJvxzTpbX0StT38uQRnU2/zb/XVmDK+caARZGHA=;
        b=aMsGV22vbFC4gKL5BTvRH6mu4evUoX8MdAMju1Z0zVGZ10BrHqt2/c2i5ai2/qzFU7
         YeNklVFAwcV197kzEezZsloi+15HjjSzwfG3ZYK6+OvFu23OAbwFyN26cKSiYiMRHKaF
         XqHRl3rxQz2rZTIFa3P4jxKsjXrQSMzmhxfwmyMzi3kPDgQ8Cw+CgDcahz2nnb3VrAWx
         sQN13o292tXMBedsx4my0wnTuC/lOUsecoGctuEaVAvqq/98tgF17+Bst+OjRpxlgOyf
         lORGBT8SxQzGvH2Gigh2mjQzStVMJAlwZOQ4lAqZIF2CdyLWvNoWzzoiTh3daNHd8buO
         1VtA==
X-Forwarded-Encrypted: i=1; AJvYcCXORPQy/PZA2iqCLmS1yDSF8e50YVCI17zuFxxczfLb8adxfRZLEoSZUqJGVdWXtnejCQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYFma9WQUouuhXKk7hLKnTIbKAMN92/knHupDfKOWkL/2uWXo
	hh1Ffm5lcdKAcb5XrAjYlnRQGfjN4inJZiappe1qDm2ffhmSazTlplrle73qlIOQubEYP14vHn1
	bbhYo+3E14GTK22dd8HF2/xh2NjuyQcCL+Ojc/7ej
X-Gm-Gg: ASbGncvtk9N2RzlZ/hKkGhwjXNd/zE3TxVLmov4hHExed770KhZpE9eK1ybUf23cVQN
	N6i9/zvBaTKYrdi5x+LcROmmNTkLL2yHzfqPiSzw2lr4omrZoirgBB+/4BVhrM9IFMs6xetS6dW
	mswKega1WQKw0XcyGKHiJWranmGPokPiFFBs2NjcJha8mj
X-Google-Smtp-Source: AGHT+IGdqjyzoDtqYIHx/y7YKWzz/qyhFs2l//e3GArH1hU2e1HUWggvHASce0D05SKLzqIW3p6xmhC7Nwpq0Q6Hybk=
X-Received: by 2002:a17:902:d2c7:b0:234:b2bf:e676 with SMTP id
 d9443c01a7336-234cbe28862mr1141045ad.11.1748401931545; Tue, 27 May 2025
 20:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-3-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:11:58 -0700
X-Gm-Features: AX0GCFvbRHta6TyJPe_xr_2KYS1z9gGCeokku76odClbu09MqRPDqhx2_Gv1QJ4
Message-ID: <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce netmem alloc APIs allowing the code to
> use them rather than the existing APIs for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index a721f9e060a2..37d0e0e002c2 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -177,6 +177,19 @@ static inline netmem_ref page_to_netmem(struct page =
*page)
>         return (__force netmem_ref)page;
>  }
>
> +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> +               unsigned int order)
> +{
> +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> +}
> +
> +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> +               unsigned long nr_netmems, netmem_ref *netmem_array)
> +{
> +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> +                       (struct page **)netmem_array);
> +}
> +
>  /**
>   * virt_to_netmem - convert virtual memory pointer to a netmem reference
>   * @data: host memory pointer to convert

Code looks fine to me, but I'm not sure we want to export these
helpers in include/net where they're available to the entire kernel
and net stack. Can we put these helpers in net/core/page_pool.c or at
least net/core/netmem_priv.h?

Also maybe the helpers aren't needed anyway. AFAICT there is only 1
call site in page_pool.c for each, so maybe we can implement this
inline.

--=20
Thanks,
Mina

