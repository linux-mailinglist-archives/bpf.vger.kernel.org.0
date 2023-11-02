Return-Path: <bpf+bounces-13934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B787DEF5A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180F82811BF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC82125CA;
	Thu,  2 Nov 2023 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km9oBDiz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916451171A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02C2C43397
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698919276;
	bh=5Tenz6IsQxQGTAcqCMrHFIRzA1ReDvwUimtWjz7Pk6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=km9oBDizIvi5l50DZZJlTgQu/1DN9tpEQLwKfAysNUyQ/IW80vYl54iAZh3lb9h85
	 3smhsKdkdoImaMKcEjQpM0kPp9XBRxKcL++eqoVIAxttfYFEjcU7y16WVZ6r6JN5EU
	 NI7/QKD2SiSXwL90P4+S7WYsK9zlGpoJClty5k8gsXX8a+7B6/+ImqyTsTBnPc6J62
	 pJXhnuuN6aFG5G8NMGI0a9Y5gq5V/6Y1fwDNQxqQc8vG2dowwZggRUCl4iO2hTbiL/
	 EgFGSYcDsjNIEgPJVmOAlbYEjwbVMYmmiSsRBKPWaZDfm1ctsVhHzw6wyoMNcikuu0
	 5EZ2xDHTSvA8Q==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1522129a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 03:01:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz0OgwSFV7kHRB79mKbuXxDpdJUV/nEIGucZ82d0lrinDCTKyW6
	kUgy4gmD9XsjY4rE2ApK8SY/E5j4lnYen/2cIJ/Zww==
X-Google-Smtp-Source: AGHT+IFSvp6vXpWavXqy0F9iwkZFc10mUQFAau8fMesG9rp8W0PAa+qisA/0gq7T56jtN9r4Hb92jBAWfBPBzUICsS4=
X-Received: by 2002:aa7:d6c4:0:b0:543:42ac:c9f3 with SMTP id
 x4-20020aa7d6c4000000b0054342acc9f3mr4566613edr.19.1698919274251; Thu, 02 Nov
 2023 03:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102005521.346983-1-kpsingh@kernel.org> <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
In-Reply-To: <b0186178-0338-4db1-9065-b6bbda10d58f@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 2 Nov 2023 11:01:03 +0100
X-Gmail-Original-Message-ID: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Message-ID: <CACYkzJ48EOFEgeWyX=mTwPhZk2Wb=LzngPGCo8Hn=KoBcgCJHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reduce overhead of LSMs with static calls
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:42=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I didn't get your response on https://lkml.kernel.org/r/c588ca5d-c343-4ea=
2-a1f1-4efe67ebb8e3@I-love.SAKURA.ne.jp .
>
> Do you agree that we cannot replace LKM-based LSMs with eBPF-based access=
 control mechanisms,
> and do you admit that this series makes LKM-based LSMs more difficult to =
use?

If you want to do a proper in-tree version of dynamic LSMs. There can
be an exported symbol that allocates a dynamic slot and registers LSM
hooks to it. This is very doable, but it's not my use case so, I am
not going to do it.

No it does not make LKM based LSMs difficult to use. I am not ready to
have that debate again.  I suggested multiple extensions in my replies
which you chose to ignore.

Regarding BPF it's very much possible, as I suggested many times, you
need to rethink about it in terms of implementing policy and not try
to dump the whole code and interface into BPF and expect it to work.
It will need some design work and that's on you. We can help you, we
can also take patches for anything BPF would need to make stuff work
(I don't see anything obvious needed yet). But we surely won't write
the code for you.



>

