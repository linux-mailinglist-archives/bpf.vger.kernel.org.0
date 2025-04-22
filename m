Return-Path: <bpf+bounces-56359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FCA95A52
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B55416FFD6
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59593175D5D;
	Tue, 22 Apr 2025 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdEHZlOY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B0335C7;
	Tue, 22 Apr 2025 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284499; cv=none; b=EEZCxqsi0Boj6rOvOojP3kXvJ7g8bXmVlRdc5MIHobEW3WoTa4QRY9jpLxnokX5OfNErE7liuq506LGOcd3t9xCkUL9/cvkAoS/Dv1h8SJ3sN85+KMoMF5a8RHXpwa2BgtuajvYteph9EwQz/RBo78Y7CGxbgGniqh+hXwD55RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284499; c=relaxed/simple;
	bh=+ge3WuxPkhxoyv5oodyG2+us4bqqbj8r+ZngZ4rCwAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBb/jujMqRwEEhkwF4+1tgLSzFqqi19DR1H1XuuEDmCTqpeobiqePUMutOw8ULEmYGfVzLpY5rlLNuW2N/thQ5FvNIHTnwRrorwK548oBYgW50AdY6XNirH8tZHWeKn6pnLtx4bsUDtff7U2UXUsOxb3R1tpF7vlhGEgrpxqTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdEHZlOY; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5f62ef3c383so5772843a12.2;
        Mon, 21 Apr 2025 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745284496; x=1745889296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ge3WuxPkhxoyv5oodyG2+us4bqqbj8r+ZngZ4rCwAs=;
        b=EdEHZlOYaM9veY9tGj7ratLlgYD/I0bIbj0+xrYswuYGfFdx9lOhrjznDqkqBa/6Re
         /4XDTnZmO4jwkOdFXkS7w7R4vVUdO30tn8YyUSWcsJ8uwa4O3F4Rc/ZA9alr9gMwA940
         FZQdftBUY8Sy+gohXRP5rNNCT7BeEAkGrMJwx1iFTSw1NxOIObDzxCMrPuLiH21raojl
         iR4P238NoDJ+ZWSJutWrEllD8W7pdbakG1rx7LQEbLkyA0gugpbm96BcXun27g2a92yO
         rmF9+qSGQOfUAmCmjH2oHYReTYtO8eH3Dztb96qv+5Lzxa+jld7I5VDFQZIAdeORJ7Dd
         3shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745284496; x=1745889296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ge3WuxPkhxoyv5oodyG2+us4bqqbj8r+ZngZ4rCwAs=;
        b=juLNfreMrrieo/x4kbfw7kPgJ6oN3wyVodv8y/zqH6SDLY9v93HNozjsYeNGxj2FtX
         9MpftGEgP5HhFHeVT90OS6KaQ8YpJoTpuYTFTWlRznk9NY96rGKfE3la06+dHxXJ61Km
         w/EwS0GIcPCi07ERuqqqly9CTF9cPyv+zBfEYL+RwIzoqp3VdNmrKNiB+wtUSrsh6BaP
         pWcVpHaQpuDt05FcpQ46ls/dzOaKUPlf8zh51fuqriJqMIC74xmrfLxC7gfAjdQFtd5S
         oJPnLCBJ6LaxZrTSE3f7IdqkwyaqzxLnVp18eDneyb2FsJ/UK4oafq1ysSJxUxEKjhAY
         6Pjg==
X-Forwarded-Encrypted: i=1; AJvYcCXzqqPpj06xFZSkbitLRA3lTJ/E5OhqtgEsxlvJQVvVkLzAF2a4MZl7PXjfpPfQa8XLZ5eZKJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx76KoAQ7WH44C2s801IX1sWEZ3v/Y+xj00Pwtz2zK/c4LFjGC
	WUqdI6jDR2200pTQMWg8y1L0sbUqUC4NrDDQqU8clOr/N5m2Ssf1UEF1uYPSpU4/QAy/s9/iq/a
	t8hgCe2pjkw6fDqX7B2ZTWEV8UDE=
X-Gm-Gg: ASbGncvMWRF5xBBIUtlEvsAL1sfu4pif1nIbAF5rlJHVcYvd7dCI844myMPKo4+VPEF
	Hqom0ZvEXqj12wD+dDdsIBlkh+iLg+BkYrS2hX8cK3mJX4cDeL7TR0w5mSMFvqyR8MC9IeoCJme
	S29GQ66JQ8g45hfIq8xjeD9XLcZPDw1vSDfxejaT5+/ac=
X-Google-Smtp-Source: AGHT+IEim01M+F08vb/6YQbRoUZ/V+/Hki12bkkZ2pb5+pp9KdfwmQHfd5P4Qn+0e7kTGhJv5Iky2iK8ie/I7CoyhHU=
X-Received: by 2002:a17:907:868f:b0:acb:893:8c40 with SMTP id
 a640c23a62f3a-acb74b388edmr1372977766b.19.1745284496415; Mon, 21 Apr 2025
 18:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-3-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-3-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 03:14:19 +0200
X-Gm-Features: ATxdqUE20nZhs53joWmF2z9s7_vpwgW_kYhWn2CzQQjndRnSFBovCMpFVEZDs4I
Message-ID: <CAP01T74V7PqaS+YU+=BZK3E3TYYB+cr8TP81uHeAXZPdYF3HXg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 02/12] bpf: Simplify reg0 marking for the
 rbtree kfuncs that return a bpf_rb_node pointer
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:47, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The current rbtree kfunc, bpf_rbtree_{first, remove}, returns the
> bpf_rb_node pointer. The check_kfunc_call currently checks the
> kfunc btf_id instead of its return pointer type to decide
> if it needs to do mark_reg_graph_node(reg0) and ref_set_non_owning(reg0).
>
> The later patch will add bpf_rbtree_{root,left,right} that will also
> return a bpf_rb_node pointer. Instead of adding more kfunc btf_id
> checks to the "if" case, this patch changes the test to check the
> kfunc's return type. is_rbtree_node_type() function is added to
> test if a pointer type is a bpf_rb_node. The callers have already
> skipped the modifiers of the pointer type.
>
> A note on the ref_set_non_owning(), although bpf_rbtree_remove()
> also returns a bpf_rb_node pointer, the bpf_rbtree_remove()
> has the KF_ACQUIRE flag. Thus, its reg0 will not become non-owning.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

