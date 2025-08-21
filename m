Return-Path: <bpf+bounces-66171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A68B2F439
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741981CE18BB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FB2E1755;
	Thu, 21 Aug 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR7GBGkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED9217733
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769229; cv=none; b=X+dXWGZmpeyOoKzWvq4iGa53egiSGkXDXhWyfUfhygN0gGRf4b6uDj65HLAIbbcg4G+CDB3gL9chP0A8yjVIMCw+CLlNBs1LAysn0l6xofavtpbcBcVpIV3iejAXyjVNvBdeTXCrWD/qEWvq3pslWPAyAJIh6Q+reAVGsrIWfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769229; c=relaxed/simple;
	bh=VjOG9d0Mi9EmgviaAGmehx14fChAORdYjSukk6CrEv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTf/WwAH+YfdTeteYYyhPV8cdqFbcXAe154qWw50JRTyjPZWbtxHCFFM5Xj1qN3Llv5DIR0hB/eiyWbOuvkJTX+WCu6usvkEA7TvkFTc3/c5D5EszOu5xkOUqgQxi+J9BGUN5yAWEhKTqhJ4N89ybZYNFSqbGSsLezUteG+uW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR7GBGkd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so474313f8f.0
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755769226; x=1756374026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geR66cDkPioHyKxuTWy55x6dISvQNcKQ5AWmUoH+p7c=;
        b=JR7GBGkdnLMDqVqhE0EgBr07VDMRUm8mWOmYD7HZ+IT/JbR4vdbE3lN8Nnulv8Db1V
         T3mqSTAgT7VqrAO5d93UAI9f2nfmhKqbD2x5dPehgujHhdT4U+jFnazJ7GNtvQPu+N8w
         Yj/0WE57NaZpUxnXrFqdWfngzL98+fAQSD1iEMnBMusOskpXYS4Pt6R0anxCV8EsqH2Y
         N6QDoFQaTSFp06fYkzpgiI3sgwnWrvE32DF0cgoEUlDp/UHMz8pptx9mMKL+yGrn+Wq1
         whcwwWlKc1ToT3814fE9WxDvQQOjOjTvQKoJUWJ92k5+VAy/RjO/SdsQK5jQf8qHLN7R
         kZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769226; x=1756374026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geR66cDkPioHyKxuTWy55x6dISvQNcKQ5AWmUoH+p7c=;
        b=pfWClLrptdRPZMJ+RK6peTRj9+HlHvkfVf1QA3zWs0faB+/veOGjwpthA4oGzkkzO6
         Rg/ojYL3KUZVe4K9itOeh9k+5c3HxMfMzDDB3pUbIIsE8hZS1193rk4YR3eFuT3wN/xX
         YzSPomGGe7EuEtef1uW3Jebx6pggWgywn3TCXz47oFiFEn+P6GV586L/f0aS/Xt5H9vG
         qjtbwnKlnIGr9YsS+tjucRa5OHNZEU6XIws2JWef+dIbJT5EKhPzNF8rFgsImbEiTXos
         sREIPUiCNHwuFAoj+KjEsFBuWB03CenMfCecl23z08rjEdFbauODaxrKZuSQ0zTssUWa
         JL4g==
X-Gm-Message-State: AOJu0YzGCcqrN8HJ7tOoTwGIlZ3OAw+759bffzzx/S7Gyi2yI5cB8Bn1
	2LGCSCb3gcGOaqpUxUZJqq2UKyHq+2rXo1QJ7NXQY8pOY7ij+UULBcbh
X-Gm-Gg: ASbGncvdplri6IIwgAbXYNNcbXkID1btEtanIn4cydqWJCoo+HPihkYMGhCFkvxIoAk
	MxwPhtPhbCYWlrlzwRpEewUVj65GoFmW00+r5UNTYa1WVayTKfIau9EZ5006ddX7dd2B1LYY0/j
	eTVNKw7LX/UpqBAWfkeKdAAsluNqOd8HN/YxCpoFGeobqVV1x4XYkoNamLV9vq1GC5VEfw5x+IH
	ODIoXLXp9YPn1d5Wpl7yDQzx2K7MtaASYt+FquqWljNsvw3lAXCwHpkz1mkeB/mxbftA7llOTyr
	KR+ZZZ6woXtyhw2PB9c9xT5Nn1B3gMtBXXemFekNNSKKEc3glUzk6GmfTbFtBX9gVraMRzZDUss
	QFsKp5OBhnjuLNS/4AzdjOVotWFwtS82IyZJEDwbr7vSeM5ubQUJSnNYRn2gWgSdV52asFx7Vgg
	ix6ChwCo+8+rrNIxsusigR
X-Google-Smtp-Source: AGHT+IEeqyNfsY6o7uScn5qBVCfwq9C9sAwVlUe2Rb2e7txjFlmczer6GmR9MEvVOMgsnHvbb/nlXw==
X-Received: by 2002:a5d:5f8c:0:b0:3b8:f318:dc61 with SMTP id ffacd0b85a97d-3c495d47a4fmr1502060f8f.40.1755769226311;
        Thu, 21 Aug 2025 02:40:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00765727e34656ae4a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7657:27e3:4656:ae4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4f77e969asm1175174f8f.20.2025.08.21.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:40:25 -0700 (PDT)
Date: Thu, 21 Aug 2025 11:40:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
Message-ID: <aKbph6651bXV5_Pp@mail.gmail.com>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
 <hxshkvnzsyrmnty25ainifbei732oco3ss6y76iez2cdsxa77q@cdnvjuhsp6c2>
 <aKNmZZ3L3ws8NUth@mail.gmail.com>
 <d5uns2wnicohhp77ufr4kbzsjsughmnvo7c2ws44c5tndlkmg6@zla452ef6qs4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5uns2wnicohhp77ufr4kbzsjsughmnvo7c2ws44c5tndlkmg6@zla452ef6qs4>

On Wed, Aug 20, 2025 at 01:09:22PM +0800, Shung-Hsi Yu wrote:
> On Mon, Aug 18, 2025 at 07:44:05PM +0200, Paul Chaignon wrote:
> > On Thu, Aug 14, 2025 at 08:55:22PM +0800, Shung-Hsi Yu wrote:
> > > On Wed, Aug 13, 2025 at 05:34:08PM +0200, Paul Chaignon wrote:
> [...]

[...]

> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> Maybe add the check right after 'tnum_is_const(t1) && tnum_is_const(t2)'
> check, and before 'umin/umax/smin/smax' check though? Bunching tnum
> usage together for aesthetic.

Done in the v2. Thanks again for the review!

> 
> > ... That
> > said, if others prefer the xor version, I don't mind much :)
> 
> FWIW I'd ideally would like tnum_intersect to return 'false' if no
> intersection can be found (similar to check_add_overflow), then we can
> use it here. And forcing check to always be done should help avoid
> running into some of the register bound violations. But such change felt
> too intrusive for the purpose of this patchset, maybe for a future
> refactor.
> 
>   __must_check bool tnum_intersect(struct tnum a, struct tnum b, struct tnum *out)

I like the idea :) When checking the returned value in reg_bounds_sync
and regs_refine_cond_op, we would probably want to throw a verifier bug,
but that doesn't look too invasive.

