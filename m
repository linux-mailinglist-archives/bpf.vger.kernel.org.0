Return-Path: <bpf+bounces-17572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3580F5A0
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE251C20C6C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF75FF17;
	Tue, 12 Dec 2023 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VghkGZ4q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286D10F5
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F9CC433CA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702406720;
	bh=XjyTKUdgW3EiE27WtUS33647UzbGgC30E2uPAZW3u00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VghkGZ4q2md/c6uOKmnpuQbTzj9RQQEwZsqPW/Tsb8LAhC7whQbk4FGmWIw59EFyS
	 1RTHSIs9MGa5cY7SNe/Xjglv+jrUtJOF7/Ib4GEsdhAIEC9QdF4vlC7mpOSPPyD8Bo
	 tk9KsZWlkoQRudexehC2AGtRAeeGVpkhNGds/EtzXC8svS/7ot0WpSSJm1MlG+YetT
	 cq9Vfospbx5LT7q6PIJuyxBmMrYDxrAzcG72ETPguoEJwwbopcYWmiVGHrm5lcejW5
	 VCUtVRLP32W7UX8bqFJm+kK/Gjh7q2Qk7LiFjIBtVY7Y9gWRYN6CbQnaFnJ4xVZZS7
	 4YLWo65iFMpxA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so8492359a12.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:45:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzkowjHdnXzphRDyJWms4icOb+j1eK62u0f2NrItIh5b3pFrk2k
	iwk225Wy7oG2y+Pz58vx4NJFt6p1ZBYLTw8vQpOlRQ==
X-Google-Smtp-Source: AGHT+IEQNCvXMz5noH2o9RYFzukaov7TXCVPVRFqA0hRV8k12WB0736VrSbsfjg506r+MQ5dQQriDEhOnewHoNbARqE=
X-Received: by 2002:a50:9b55:0:b0:54c:6b61:4352 with SMTP id
 a21-20020a509b55000000b0054c6b614352mr2417239edj.18.1702406719067; Tue, 12
 Dec 2023 10:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXM3IHHXpNY9y82a@google.com>
In-Reply-To: <ZXM3IHHXpNY9y82a@google.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Dec 2023 19:45:08 +0100
X-Gmail-Original-Message-ID: <CACYkzJ50OoQMcqC5ywVsZxNYhRaVPovQ_ecODctc9v-v=Uc7eQ@mail.gmail.com>
Message-ID: <CACYkzJ50OoQMcqC5ywVsZxNYhRaVPovQ_ecODctc9v-v=Uc7eQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add small subset of SECURITY_PATH hooks to
 BPF sleepable_lsm_hooks list
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: ast@kernel.org, andrii@kernel.org, revest@chromium.org, 
	jackmanb@chromium.org, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:32=E2=80=AFPM Matt Bobrowski <mattbobrowski@google=
.com> wrote:
>
> security_path_* based LSM hooks appear to be generally missing from
> the sleepable_lsm_hooks list. Initially add a small subset of them to
> the preexisting sleepable_lsm_hooks list so that sleepable BPF helpers
> like bpf_d_path() can be used from sleepable BPF LSM based programs.
>
> The security_path_* hooks added in this patch are similar to the
> security_inode_* counterparts that already exist in the
> sleepable_lsm_hooks list, and are called in roughly similar points and
> contexts. Presumably, making them OK to be also annotated as
> sleepable.
>
> Building a kernel with DEBUG_ATOMIC_SLEEP options enabled and running
> reasonable workloads stimulating activity that would be intercepted by
> such security hooks didn't show any splats.
>
> Notably, I haven't added all the security_path_* LSM hooks that are
> available as I don't need them at this point in time.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>

