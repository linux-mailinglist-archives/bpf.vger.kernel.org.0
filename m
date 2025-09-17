Return-Path: <bpf+bounces-68625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75512B7E3CD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B161BC3336
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81C261B86;
	Wed, 17 Sep 2025 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udE6SqVT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3FBA42
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087311; cv=none; b=IwKSpS3xAxqZLol0+kKIlB8sm1jOD8GIjITGxopIKixp55mjHFGbXBnbjMqpPBH6QwLivOfzI7Gs2lcmzIOWZR5T15rxX3JHiRl+ANluZa2D5aEtnBoOXquFto2sb9EGP+ad9UYAhYD+D0uzY1iwCY3iUYCD3h5AlcpdFDoe7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087311; c=relaxed/simple;
	bh=YBSGo6hLB1Y0V+RRcxMVaYA3usKRbMY3kC0diTUjjHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQMz/V8tF4OsypwXxd+fcqEhhwQ+P8wX77hI1/L4C84DkKc8G2+3N8mu3lzOf4GlYDw4mavwMhrx0URW2Gr/64GBAyZfEeQngOQ5o76q6EX7qja8Ma/3ghmWJoYZpLSQQyf0dx8oKz+/e8FCN7frW4i7dPwAvqwkB+MNDfJm0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udE6SqVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A0C4CEF9
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 05:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758087310;
	bh=YBSGo6hLB1Y0V+RRcxMVaYA3usKRbMY3kC0diTUjjHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=udE6SqVTgYKt3NpJ3Y5b9zBVPs8RykRj1Eng6VmstlnGjH3MV25TFc5HlEHtrG6Qd
	 DePGoDZTF5EtiuVWCXM4xiB+oS/4UGoH6kZwVMYrLqVXWVbliiuMt+W+MDxJ8WX56n
	 3CGYTsw6OB62IXqxMsxTFdMrUMPY+JmNvgKhrpwP9sH3Ov6I9MNn6kGaXh1LK/OpnO
	 jWuVE4X7Pep3BPdZhxSXBFNnVCgRw5sdgU1qwD4bototwZjKv/rYQXhN4fyLuXWLjE
	 JyKH1BsnhFCMkZd+9SSBf6f344yBISkJGAlhtYlBt9QugPO3PhkoU1NL71uUocU2km
	 yPlo4YmT6zzgw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-812bc4ff723so579852785a.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsMzBQCIhRlx+QYdtaoA29IToKQmlkREs2V4fU8UY59ApqKGuJr2AQONVVyHSsyCsD8lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Gy2Td0FOwI8ZOrfQCxmLgoNiGHVVptI+R6KJqk1yKv/hAKbr
	OW5E+uwVAheWLt99gbEJycGjo6giA8oTWvpThDn3Dva77GjsasD7+AznkqueSMy3B6CcCCT+p5K
	wt5s+UVQxTlWB97GW7Ev9bg98O2mwQYA=
X-Google-Smtp-Source: AGHT+IEKLe67nqhaNaH1nGbbP/1nljhUYRnYbdNEhJp0tkApOXEX7b45Lzube/OIraB3N5fKEDVll/foXqsqLHB3pPs=
X-Received: by 2002:a05:620a:4148:b0:828:99f2:e22e with SMTP id
 af79cd13be357-83114b54b68mr99574885a.81.1758087309699; Tue, 16 Sep 2025
 22:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916232653.101004-1-hengqi.chen@gmail.com>
In-Reply-To: <20250916232653.101004-1-hengqi.chen@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Sep 2025 22:34:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6F_vat3wUEZwuUFWnTaNd-zM_hQteH9bdvO4BcEjBa3g@mail.gmail.com>
X-Gm-Features: AS18NWBWo4cekNwfNpjq0g_fD2G_Y3Lev-YYHAk_Wu6aXAxw4X1w3KEy7uiLUig
Message-ID: <CAPhsuW6F_vat3wUEZwuUFWnTaNd-zM_hQteH9bdvO4BcEjBa3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize()
 in bpf_jit_free()
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, puranjay@kernel.org, xukuohai@huaweicloud.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:26=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The current implementation seems incorrect and does NOT match the
> comment above, use bpf_jit_binary_pack_finalize() instead.
>
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management=
")
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!

