Return-Path: <bpf+bounces-13345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B0D7D87F5
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40385282096
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387C39934;
	Thu, 26 Oct 2023 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffvMeble"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3362E3E9
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA3FC433C9
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698343227;
	bh=22lIrI9Ca73UBPo4KaPe8eUFlB7Vk0E0Bt/MqMkR7h8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ffvMeblefuyEIw9N2NkMrTZm5qV6sZd3ykOLkxTKsc/17Mv58LbIQGd6JUW0rR6IJ
	 0u06TMQ2stEoM1a7exhiaMpnzojA7XikXdYJv14lRr/kSrrMas56DHLUaEcSSe7OVO
	 Rsw1PI1CranywVeSKo5w3SmVJgxtF+arUxt3Q6deZiLnw4I6TCga0SGlyFSQPsLL6H
	 e8BRoZ3zKjV2DeKJx0StuGibD7J4578Yummy85Iw4HRjx5DjdHa4LbBuh+cXvVAY6N
	 wsmZf2J/StZamHI10AiNWKcxPaY4J+BMZkLCOqcoJpsfDh8xIBw161fNUaZQvjFmch
	 M4ryOx7+fAxTg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507b96095abso1722879e87.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:00:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGEoWqrP4grFaFq6D6nHF8lWQOkOKzNB1RM7pReKooGsVBcIfZ
	RqzAr/a/2P6CxlBXbdxZ7C++Q1KLogYl0Ywzdwc=
X-Google-Smtp-Source: AGHT+IFPsw6KQq/ZibygUhYI8KUjKNVd7J7+HGNcUKBPojmRAnz4Gf8B8vHAX1q3qtxNEY3snMSrOy3nEVSeh2YJS+o=
X-Received: by 2002:a05:6512:208c:b0:507:ab66:f118 with SMTP id
 t12-20020a056512208c00b00507ab66f118mr53041lfr.68.1698343225968; Thu, 26 Oct
 2023 11:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-5-jolsa@kernel.org>
 <CALOAHbC52fMNvvwsjJHZb26seQjQSZ4oNOLiWp3+3Q+JNmJckw@mail.gmail.com>
In-Reply-To: <CALOAHbC52fMNvvwsjJHZb26seQjQSZ4oNOLiWp3+3Q+JNmJckw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 11:00:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6fET2gVZTks5ECQ+bGK65ijfFeuqimb_zdccdWSkwrjg@mail.gmail.com>
Message-ID: <CAPhsuW6fET2gVZTks5ECQ+bGK65ijfFeuqimb_zdccdWSkwrjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 4:42=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Oct 26, 2023 at 4:25=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > The fill_link_info test keeps skeleton open and just creates
> > various links. We are wrongly calling bpf_link__detach after
> > each test to close them, we need to call bpf_link__destroy.
> >
> > Also we need to set the link NULL so the skeleton destroy
> > won't try to destroy them again.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
>
Acked-by: Song Liu <song@kernel.org>

