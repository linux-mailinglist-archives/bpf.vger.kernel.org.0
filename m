Return-Path: <bpf+bounces-549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58570326E
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBD281329
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828BBFBE6;
	Mon, 15 May 2023 16:13:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506EFBE5
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72189C4339E
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684167181;
	bh=m0LJrYIyvn75o1+rd5qYzKljcFLmjbnVauURjb5BbI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R8+NjQjbVSz+vcJNL+2o8xY1rfZ+K98CxGTrvUBfBKuCWEWoNLjtI9lt1w1O5Srwj
	 akwnAa5l5XE58R/VNuBraKjpqAd4H4N8dxkJIEhH+qUJeghk18xoFQwWjqv9zjd7Af
	 JI010dOQI4xHg5g1YIV47IkhluLQq77r4Qpe+Lya2uPEc2W+C0fGblzJBQENgtMVT9
	 kzKV4vosjLE0elwIoNAJGpruTtDZBoU7KIrLtt/o0lzjYjzmlbrFVnEhv2gXzZTfFR
	 kIpJZHHiVpWhWR6gs/JRPHXjqAL+aCVEPqXtiz/Ql4J1lR0I1W/QctxIKaDUhmWDRv
	 rHHDFPwF9v5bg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so14989117e87.2
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:13:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDxWTyNYIQ//5bAI4LGS52uE0FDHZjCjqmwxFaJVstLj9owORiDl
	6WZXvQss94a9WKiYGm5NmhUiFvVy4+kr+SWdux0=
X-Google-Smtp-Source: ACHHUZ6CD6Ky0GLmbOFJ9D3aD2jcw6/8pP/zvqlFb4bRTL+yUkLUmdzTujxVQvZyuwvpPG3eIkaXWPaMIokgd7VP02I=
X-Received: by 2002:a05:6512:909:b0:4ed:b263:5e64 with SMTP id
 e9-20020a056512090900b004edb2635e64mr5751229lft.27.1684167179446; Mon, 15 May
 2023 09:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515130849.57502-1-laoar.shao@gmail.com> <20230515130849.57502-4-laoar.shao@gmail.com>
In-Reply-To: <20230515130849.57502-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 15 May 2023 09:12:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4w6M236koDfMEJtDKNvN4T0_hev-amqgUF1mnfB8fXMQ@mail.gmail.com>
Message-ID: <CAPhsuW4w6M236koDfMEJtDKNvN4T0_hev-amqgUF1mnfB8fXMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Show target_{obj,btf}_id in tracing
 link info
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 6:09=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>

[...]

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

The change looks good to me, except that we should split the change
into two commits.

Also, this doesn't seem to be related to the other two patches. So it is
a little weird to add it in v2.

Other than these.

Acked-by: Song Liu <song@kernel.org>

