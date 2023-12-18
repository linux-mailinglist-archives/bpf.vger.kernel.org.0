Return-Path: <bpf+bounces-18221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F86D817745
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75B21F25DEA
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316642372;
	Mon, 18 Dec 2023 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUORminA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD113D556
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EE4C433C9
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916364;
	bh=SSkin4Zng+idkGV2ghPX/v8lG8fRnrQyvHvAMsKzQNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUORminAuJuOkvb4nCvANNeh8lvblp0+c0u+3mE/ki8XG5RCck18b40TprHQciN2H
	 Cte93eTcNrGhxvhJWuKbLkLMwpkwlRmfjDh7HZw12M2SNKdO47Z1WNcDr/BG/OBv9u
	 UxWAKA8Q5UL9E7M5QhJe2mZFGuQcQd0HvJolLYpK3Eky+E7qgtN+NXHjbGPugukOW+
	 GdniqxdFI9y4b/x9v65IjrVybstv/dKZnsaJ79RgrxvUWmfwvfPc9hyJpWgIWRKXN4
	 lhID5wUo3ooWXAx2LX/AIFZsOX/A8tZosCElkydQAgN3ePETa544ptlM1xla14/HOL
	 0UUjhytqiXGqA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e3cde8ab8so927187e87.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 08:19:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzUsZFtQDKBdhkEt5QqaP4BpLQm8HsrpTLZYcNxIFpVzQcFmpk9
	XljSmCmooXzfL/9/Vtnfv8SdtDbguLEGkXDTc5U=
X-Google-Smtp-Source: AGHT+IGKEd14uYv0JvRsIJry9AOPqbgqTIldTOSRJ8mpk/SSbDtxmTwXSiKV+TZk7OA7/FkqtdtlosVjzl6Jy9G9jj8=
X-Received: by 2002:a05:6512:ad2:b0:50e:15d4:7f8c with SMTP id
 n18-20020a0565120ad200b0050e15d47f8cmr5211403lfu.27.1702916362532; Mon, 18
 Dec 2023 08:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217215538.3361991-1-jolsa@kernel.org> <20231217215538.3361991-3-jolsa@kernel.org>
In-Reply-To: <20231217215538.3361991-3-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 18 Dec 2023 08:19:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW551fE2Fy=8HLAYJkvttZPaC-hT+nwgrDeHQzwvdZ+6XQ@mail.gmail.com>
Message-ID: <CAPhsuW551fE2Fy=8HLAYJkvttZPaC-hT+nwgrDeHQzwvdZ+6XQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/2] selftests/bpf: Add more uprobe multi fail tests
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 1:56=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We fail to create uprobe if we pass negative offset,
> adding test for that plus some more.

nit: "negative offset plus some more" is a little weird to me. This is more
like "testing error handling paths of uprobe multi creation".

>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Other than the nit,

Acked-by: Song Liu <song@kernel.org>

