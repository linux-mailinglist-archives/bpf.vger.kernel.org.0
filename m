Return-Path: <bpf+bounces-32923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC918915233
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31616B260C6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D819B5A7;
	Mon, 24 Jun 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a8FJszn2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A519B59C
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242780; cv=none; b=uYU4XMe267GyRNb4jYfs0R5Qo1GHnDp3C7fK0L/uJGi/LRZOO0bCJFJrBWT9vGHebbxiHHGlzAeRglb6jXFrlM0Bn5mx9t2QbDdc5gfgID7yvqONqXHYGha3LwXYu0Ekxu95kLmA5Gu8tKRYzY2nr7tXMKw++/lIPip9gTXDT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242780; c=relaxed/simple;
	bh=X3GCAch2gIfMwqHwRrPzjjLrY1muUpO8CJCdf08d3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAbkjCR7kFIX5dj5WxeR5uje+NgwZhYRtZXvBJjNGbGVmpZz2eg6FFpJo+Qkwks0fOpviZHcp1qzWzrJ8U+lCs43bPRi5RdrdB58/Up1p5MbS8MFDXAfQ2ktJfRjzfeOcX168mT5f95fWwcSm1PhKxCYBi9dWLILkzanPfR4woY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a8FJszn2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so30016381fa.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719242774; x=1719847574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOIo2rkbmAE2IZOiuY+F8J2IB2OqQZ6GJixTqwhoOVQ=;
        b=a8FJszn2wAIKrPf3XZllUi5Y4rT7Im+M9mGWbtmlSXXPlRVPTFqyOi7ujt/9duIHsm
         rqjOEDjlV6unBzR3e1u/r7jizX7R9cWEHcU7tBbRHp8zuVIbiEX5yqUKw/HPymz/bj0S
         yJmUo23ecGeA1h2RBKOAKNxe+P9C9jkXe3J2vJghdP+eEzc29QHSXzE1yDX/sOeTvOUc
         Q/FA292tUC3Qpb9Nukd+52GMeXYAk3WSnDYRhjLajRAVR44hTgDUuVlZnmA6rRhXrwcb
         U0qD/61snTadqW4faWz6t2/xYcuK0/BOx07/O7uA6aDISV9oglrYx2bUhUXT5V0FE7Vr
         twzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242774; x=1719847574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOIo2rkbmAE2IZOiuY+F8J2IB2OqQZ6GJixTqwhoOVQ=;
        b=iub6whIoWZlSXiq2OeSVbPUujw0oojRKNmqi657X3ZYL0TGktxjjO7IxbqRSAxHhvK
         5MNsvzpWnxgWLrCkI+2ARx+L2wdLOZpb8lFpKKz5RESpUnFVELhT8D2dz1u8vShMkg6O
         skLJoA5T3ed+Qi3XgGeiYkBAGnZFVgyS7wgQFELeIa2sko21uMU6Ijbnimnc2LjGLEse
         sHhoit0p69RsfCu/AUvQQd+PmepTlIyB3FWZBpDBPVzsy0VW3b2udSZDd8LfUqjm3ptn
         DV9sKOJcKcQhw4pG7LYlLK6gLUNn9hC+rL6CXo0UMxgBnpeJ+IPPN5Wm+0bZ7f7ZB5lm
         Z+SQ==
X-Gm-Message-State: AOJu0Yxy+/q/NfeZ0o/ffd2+dYOzTDaRvzFxuCFfQlMc5j/jjbmQkgiq
	vJ3i27HsWmCKQokXzg1kSvjRY/9AMzut8MNJ8I4ckdpTuM6bS7bE2IIU/kr+WtOr9KhNMzB2ZgN
	U
X-Google-Smtp-Source: AGHT+IGc3ljprjWf3dKLU8r4S2KK31cjhGdacEg+clQKTuUqeVyn2PskqZjanu19RrzJC++zIfSMcQ==
X-Received: by 2002:a2e:a0d6:0:b0:2ec:50cc:6c20 with SMTP id 38308e7fff4ca-2ec5b27eff2mr26896091fa.21.1719242773733;
        Mon, 24 Jun 2024 08:26:13 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1ee3-8904-fd02-5f2e-04fb.dynamic-ip6.hinet.net. [2001:b011:fa04:1ee3:8904:fd02:5f2e:4fb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc2a7fsm63321615ad.283.2024.06.24.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:26:13 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:09 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: verifier: use check_add_overflow() to
 check for addition overflows
Message-ID: <o7b3dfsmkmlh57geyzahgcysaosqxcrsqcmhycqc7vtcgxfgie@mvlcwnwtzael>
References: <20240623070324.12634-1-shung-hsi.yu@suse.com>
 <20240623070324.12634-2-shung-hsi.yu@suse.com>
 <CAADnVQJar6vM-3U_e49yxz=keZs7=xn7O+k_EOAWjnA7kH1VLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJar6vM-3U_e49yxz=keZs7=xn7O+k_EOAWjnA7kH1VLg@mail.gmail.com>

On Sun, Jun 23, 2024 at 08:38:44PM GMT, Alexei Starovoitov wrote:
> On Sun, Jun 23, 2024 at 12:03 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > signed_add*_overflows() was added back when there was no overflow-check
> > helper. With the introduction of such helpers in commit f0907827a8a91
> > ("compiler.h: enable builtin overflow checkers and add fallback code"), we
> > can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
> > generic check_add_overflow() instead.
> >
> > This will make future refactoring easier, and possibly taking advantage of
> > compiler-emitted hardware instructions that efficiently implement these
> > checks.
> >
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> > shung-hsi.yu: maybe there's a better name instead of {min,max}_cur, but
> > I coudln't come up with one.
> 
> Just smin/smax without _cur suffix ?

Going with Jiri's suggestion under patch 2 to drop the new variables instead.

> What is the asm before/after ?

Tested with only this patch applied and compiled with GCC 13.3.0 for
x86_64. x86 reading is difficult for me, but I think the relevant change
for signed addition are:

Before:

	s64 smin_val = src_reg->smin_value;
     675:	4c 8b 46 28          	mov    0x28(%rsi),%r8
{
     679:	48 89 f8             	mov    %rdi,%rax
	s64 smax_val = src_reg->smax_value;
	u64 umin_val = src_reg->umin_value;
	u64 umax_val = src_reg->umax_value;

	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     67c:	48 8b 7f 28          	mov    0x28(%rdi),%rdi
	u64 umin_val = src_reg->umin_value;
     680:	48 8b 56 38          	mov    0x38(%rsi),%rdx
	u64 umax_val = src_reg->umax_value;
     684:	48 8b 4e 40          	mov    0x40(%rsi),%rcx
	s64 res = (s64)((u64)a + (u64)b);
     688:	4d 8d 0c 38          	lea    (%r8,%rdi,1),%r9
	return res < a;
     68c:	4c 39 cf             	cmp    %r9,%rdi
     68f:	41 0f 9f c2          	setg   %r10b
	if (b < 0)
     693:	4d 85 c0             	test   %r8,%r8
     696:	0f 88 8f 00 00 00    	js     72b <scalar_min_max_add+0xbb>
	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
		dst_reg->smin_value = S64_MIN;
		dst_reg->smax_value = S64_MAX;
     69c:	48 bf ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdi
     6a3:	ff ff 7f
	s64 smax_val = src_reg->smax_value;
     6a6:	4c 8b 46 30          	mov    0x30(%rsi),%r8
		dst_reg->smin_value = S64_MIN;
     6aa:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
     6b1:	00 00 80
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     6b4:	45 84 d2             	test   %r10b,%r10b
     6b7:	75 12                	jne    6cb <scalar_min_max_add+0x5b>
	    signed_add_overflows(dst_reg->smax_value, smax_val)) {
     6b9:	4c 8b 50 30          	mov    0x30(%rax),%r10
	s64 res = (s64)((u64)a + (u64)b);
     6bd:	4f 8d 1c 02          	lea    (%r10,%r8,1),%r11
	if (b < 0)
     6c1:	4d 85 c0             	test   %r8,%r8
     6c4:	78 58                	js     71e <scalar_min_max_add+0xae>
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     6c6:	4d 39 da             	cmp    %r11,%r10
     6c9:	7e 58                	jle    723 <scalar_min_max_add+0xb3>
     6cb:	48 89 70 28          	mov    %rsi,0x28(%rax)
     ...
	if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
     71e:	4d 39 da             	cmp    %r11,%r10
     721:	7c a8                	jl     6cb <scalar_min_max_add+0x5b>
		dst_reg->smin_value += smin_val;
     723:	4c 89 ce             	mov    %r9,%rsi
		dst_reg->smax_value += smax_val;
     726:	4c 89 df             	mov    %r11,%rdi
     729:	eb a0                	jmp    6cb <scalar_min_max_add+0x5b>
		return res > a;
     72b:	4c 39 cf             	cmp    %r9,%rdi
     72e:	41 0f 9c c2          	setl   %r10b
     732:	e9 65 ff ff ff       	jmp    69c <scalar_min_max_add+0x2c>
     737:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     73e:	00 00
     740:	90                   	nop

After: 

	if (check_add_overflow(dst_reg->smin_value, smin_val, &smin) ||
   142d3:	4c 89 de             	mov    %r11,%rsi
   142d6:	49 03 74 24 28       	add    0x28(%r12),%rsi
   142db:	41 89 54 24 54       	mov    %edx,0x54(%r12)
		dst_reg->smax_value = S64_MAX;
   142e0:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
   142e7:	ff ff 7f 
   142ea:	41 89 44 24 50       	mov    %eax,0x50(%r12)
		dst_reg->smin_value = S64_MIN;
   142ef:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
   142f6:	00 00 80 
	if (check_add_overflow(dst_reg->smin_value, smin_val, &smin) ||
   142f9:	70 27                	jo     14322 <adjust_reg_min_max_vals+0xde2>
	    check_add_overflow(dst_reg->smax_value, smax_val, &smax)) {
   142fb:	49 03 4c 24 30       	add    0x30(%r12),%rcx
   14300:	0f 90 c0             	seto   %al
   14303:	48 89 ca             	mov    %rcx,%rdx
   14306:	0f b6 c0             	movzbl %al,%eax
		dst_reg->smax_value = S64_MAX;
   14309:	48 85 c0             	test   %rax,%rax
   1430c:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   14313:	ff ff 7f 
   14316:	48 0f 45 d0          	cmovne %rax,%rdx
   1431a:	48 8d 40 01          	lea    0x1(%rax),%rax
   1431e:	48 0f 44 c6          	cmove  %rsi,%rax

Also uploaded complete disassembly for before[1] and after[2].

On a brief look it seems before this change it does lea, cmp, setg with
a bit more branching, and after this change it uses add, seto,
cmove/cmovene. Will look a bit more into this.

1: https://pastebin.com/NPkG1Ydd
2: https://pastebin.com/v9itLFnp

