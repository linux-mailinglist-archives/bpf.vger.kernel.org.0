Return-Path: <bpf+bounces-13346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE977D8815
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC8282103
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34C3A262;
	Thu, 26 Oct 2023 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykrw/Saw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA038FA0
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0005C433C9
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698344041;
	bh=8/ViV5VphJdSfWni/+MxOXIUXqT2XnwQ2DpWpuinTA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ykrw/SawaVv6ooYZb6ahWVVvv8mxVxhAYvyCLdLI1v4L5yhcEwI4b9MY14u7Cqjq6
	 D8nyipXFZcveKdDfI2TLFgnvaHOIY+F6HGFPx+xdU37slegk7iEu9Kh6TltErQwewq
	 2tfVDTaiCTYkB8V1stgZi1ShGOIExo3dwxh55CBoSeIGlzZMsl08rYcjgOIaUdm+ES
	 MDUHs8BlZCVg4WiHxczFSblVr4GjrwbUG0M/b0Rkp6HKq2pFVeYid6c9Z5E7GLH7vt
	 QImuyvSy2cvBs2pJSmZqsEypyAeSbyVGCoKUXJqlcwcl34UcD8nAIhKcAsHbsepmS0
	 M9x1a5ZOdOSlA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1748397e87.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:14:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywq8i2Emza6HAL+cOnsd5q3owda7hW8dkLtlKDI39P0mf74V+L+
	4792iGUJDR4EeAOglAEJpcElMZm+bDBBKcLY97Y=
X-Google-Smtp-Source: AGHT+IGamHIKQvNeI9Ii8benGnw9FFXgu3CUx9OH5RsTUonfFPa5IsBFxys54drDBwOUx9y+3/W1sDVxJP7WpesRKPk=
X-Received: by 2002:a19:c510:0:b0:504:7f2e:9391 with SMTP id
 w16-20020a19c510000000b005047f2e9391mr135915lfe.34.1698344040037; Thu, 26 Oct
 2023 11:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-6-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-6-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 11:13:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4FY7BmbYnhqt8yEDfaw5eFjKAaVQ+QyWsjUPGpuArzHA@mail.gmail.com>
Message-ID: <CAPhsuW4FY7BmbYnhqt8yEDfaw5eFjKAaVQ+QyWsjUPGpuArzHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] selftests/bpf: Add link_info test for
 uprobe_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:25=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding fill_link_info test for uprobe_multi link.
>
> Setting up uprobes with bogus ref_ctr_offsets and cookie values
> to test all the bpf_link_info::uprobe_multi fields.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---

