Return-Path: <bpf+bounces-59075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791B5AC5FE2
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F781BA34C3
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CC1E0E14;
	Wed, 28 May 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWyu1Vbv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB21C4A0A
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401992; cv=none; b=Ejl1xLbXOXzDf3bsGEeajCvkiXJww9zIn74zEP0Mq4OFMJCkXA5EpNSgj1dp+xNOXtUTy5kzTO+OyHR10OIqvrIfRPNXGUtDQ18Nj7jVcHLvJiuqaIXLzdDxYtGQb5ciAj6zgVV5qovFXlKoD3/y0t6Hz2EDEspfDuAOAm1LGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401992; c=relaxed/simple;
	bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyZb7WTkzhq4PZQMxPpq8yIgJPo0K4d0SrpG6m3r1rqDnXUp5ONjMiA/AM+gmSyKiLT1OX5M85T8UbTUusTfBLbzzZtaY/jsrPOOLNy++hOzlXtnC/zXhotFqwJrhuX5M46xvc4o/D/LBg8chCIssQyYEG+yTVyPSZOfkyzhz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWyu1Vbv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2348ac8e0b4so69725ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401990; x=1749006790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=ZWyu1Vbv2ejyjuwmvqu1s5LfjEB+ZlDCoQcWYYNoKJEIHuwynv37TA4DSBtp1UaZ0S
         zuJRuTA+hcMV3KHX4mCcQuBv+9ATmxDFcW1KDMbqI3vgmdVEBlR3+86X/gnC/kjumIqo
         hpUv4Z8VF64uiEztKO29w91LCXXBm7SB4I/vRih3EVRgbicfFWwMWAnptFa45ZrwtrwA
         3Vkq3epp/y39JSoFZA72R55fuSQflQs7VGkORFX/afLDoMqhcUcxbL+A3PXGw+R8XuYt
         ehXEjMr3F8JgaNKtCttMdDn0q/wht2A2DHeROq5FlhKDhmnDC1MRv7OnIiWcp7MKB8g9
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401990; x=1749006790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=XGSS+uFKO6SQBCAx6EnwHSf7CSt0aZVzSwEEHbIhV89yL/S2YRE0pOkGo3S2dsrw13
         yQhoBhe2DPW+Y7LYmeFajXGbDJNHNKTLmwyQ28Pz22+BYVLhSaAGc69/ZdMMKx2xAc9R
         gjQ7s0U7vFUwjblm/LjXTr5ATcOCTdYavc7hbwHhe/jtIM3b3IBxPNXbElX5OAcyE4NQ
         /cpS8bElx1np/8YvQSNSCu8bE+fQ6zoTinjhdefw3z5iCOK9XBzS0pEMcNVbRuZpyou7
         iweEqqrd6wABdZsHxG/H1/ogDCbkvFCU21HtvykTbjYHgYM26jPepJOiw7EAMKTMmJho
         HbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStIZkH0qp0EptnJxCtLxPFKFzxJSSp8hIRcs/l67I63GeLyUccY/EDTIWTDqPAYsUbkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdBqS46GGsf41bGgz50dYzzpjC4UueJfjCqBEbqq4idbUSWFz
	q5imJOv7TnVXTnGnfXEqNlmyFLC7K1vS0P5z7WpNxEjIt45lo9x7KLdxy3tEbXo2H58Dm5pDt67
	SnQPJEcsINCfClqLr8o/hR+8TnCwV1WWrkkbjQu7a
X-Gm-Gg: ASbGnctuqIhJgRYLu+WYNripwU1WPPSTs6NWmRu2kNOK70uPhQnamywsBYPB2e9EVxs
	35FgJJMpArwOn0WqMuGWIZai+S1BbcLlilQGRgj1Zqpjo03l9Iod266ain+4ZYgZ7lWnad1RomS
	72yD8HuVms/v0NvQhd2ir9iK81nJDSTQulJBJKturJQ0S9
X-Google-Smtp-Source: AGHT+IEDUY7riFOOR08zN+pI5SwQ05vmhq98GyByeU8awQ87xrmYDNUTemcQa8sUY7rtO1VWlklZOkyX7GAf8CRHf1k=
X-Received: by 2002:a17:902:f785:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-234c5256552mr1833575ad.12.1748401989824; Tue, 27 May 2025
 20:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-4-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:12:56 -0700
X-Gm-Features: AX0GCFstQ8TSymZiP1u3KsDOqDNDhSVZvkeBqi3jCf2XyHkp_VooW3rcyXYh7Xo
Message-ID: <CAHS8izO_ypBm4htYOZ6mDqn5hge5S_3DBKHHTdEW7ay86MsSZg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
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
> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

