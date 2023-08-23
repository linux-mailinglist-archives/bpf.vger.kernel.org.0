Return-Path: <bpf+bounces-8350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAD7856B8
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B9281065
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81035BA4E;
	Wed, 23 Aug 2023 11:30:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F0BA33
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 11:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C49EC433CB;
	Wed, 23 Aug 2023 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692790219;
	bh=ocMOqMFIRxCZnfit4c+vYjFQkOP48/pihHlNEinXJ4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QnT1NUNn12Oh+uOwffF/QoFL+nff4jL2uH47lv1WY3yBI5ZxVp4JwTURcutMGhkkD
	 Q7TmTf55NtL777GYObBeSldiZd8V/RLykvNAyiF3Jy2KvGMbiKNhh1GpjorMJdM4f/
	 jRzvCWc83bLhbh8Cvg5fSHDgxsBP911nBZ9vy21b2pmtOC9N6uHmsmcOsz+V+kbFei
	 VBUSkHvMixVRaKU1h6QjL1wIB8mnCxYrYCSnINwGjWmUEnVz4vBn9VSnr6dvHXQA/H
	 mEZ9+ZTZAhw3yCkhp5CeB2AKmWiV2k7u4srW3LnsTZaXuG74PcWlOSWYvjC2fGlOiA
	 fU53gd2Rxp6bA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50078e52537so5600783e87.1;
        Wed, 23 Aug 2023 04:30:18 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7Y/wZ8JlKRZ9lqqWN71d0HU/nct+qxepf0d6ighX/EAEFmD0X
	zjdTgCT6Iewv0k7/YcbGQfjvw2tEAdOXLvEKQ6I=
X-Google-Smtp-Source: AGHT+IEA441BYks449EZXyfNUxuJ6Rhk4Q5nWkAfern6IdvVfBkfO93pPi7+xr9WUgVoLsvv/fZEnJTWVTjTTJATYTc=
X-Received: by 2002:a19:5f5e:0:b0:4fb:8bea:f5f6 with SMTP id
 a30-20020a195f5e000000b004fb8beaf5f6mr8269267lfj.34.1692790217014; Wed, 23
 Aug 2023 04:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
In-Reply-To: <aeb83832ae61bbf463e1b2e39c1e30c3b227f5a5.1692769396.git.dxu@dxuuu.xyz>
From: Song Liu <song@kernel.org>
Date: Wed, 23 Aug 2023 04:30:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YtQsLbB0jSeRaZnm5d5a+ZCJ3Px46DjF0g_agAQh6Gg@mail.gmail.com>
Message-ID: <CAPhsuW7YtQsLbB0jSeRaZnm5d5a+ZCJ3Px46DjF0g_agAQh6Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__unpin()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> For bpf_object__pin_programs() there is bpf_object__unpin_programs().
> Likewise bpf_object__unpin_maps() for bpf_object__pin_maps().
>
> But no bpf_object__unpin() for bpf_object__pin(). Adding the former adds
> symmetry to the API.
>
> It's also convenient for cleanup in application code. It's an API I
> would've used if it was available for a repro I was writing earlier.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Song Liu <song@kernel.org>

