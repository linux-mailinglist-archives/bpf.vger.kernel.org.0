Return-Path: <bpf+bounces-17320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DCC80B861
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B171C20906
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B981369;
	Sun, 10 Dec 2023 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue9DbjpD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0510C
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 18:11:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3333a3a599fso2288704f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702174290; x=1702779090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L0WF/GRgD0VeB93sokuB5BWx4y++qEijU0iDVZvAkw=;
        b=Ue9DbjpDoGpjzS9HMXf+Zi1K8AVCXmVbgKol4JdzHDDUksFxJk6/tOyMdWnT+OsZsu
         jl5HkbHFsToYfnSaCND/kKJTffFYogrslftkKL/3FaVfKisyT7JtQHi3iK8lqYuwHq7q
         uPY+S+V3/cjUgNfrfZLWs9VaWZ+z6+Nbdjm40Ah/DIOqed501Q3TFbfmoxb+fH8gdqzI
         7TzPrAWduEk++9CPzzdwwxFss0QEveRHUgc11CBqjpv5fZrQwDKYBZMX1uGPfQlVRW6X
         QYfPOqv9+IH1Df0BQuSlw0jx2gOrNAplOJ1josWMGQg2+AivQWD2RAI8ad8jPtr8Nye8
         fOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702174290; x=1702779090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4L0WF/GRgD0VeB93sokuB5BWx4y++qEijU0iDVZvAkw=;
        b=j1v6xJi22maTn8NkBEjXj+qDpVI5/ihUvX6ImB8/vadvQbQCX4TplTPQN90gU9w/aI
         5m8YyvRP27aPz7N9BJ9II43ZH7uBsbYDXb1d0KxKCTVQLUuhjCvQW80PLaAyeBbrdbgK
         8fuMMJB0GPxblJYsLopjvZt+Uz2ggI8p4MxG5zkuu/8NSCwQ8LxsK5IUxiwJGpVkY7TB
         sfzv0rf47ZWUX8b7iH6Chq79/e/iNEzGFTGlnWdIFUSxfxIRayFWVY/TZ/SOsNWZSQnh
         ceNziiKOUHQrIAI/GTqAoixGHghrhB5xY9E2uQqS7IrQNTVXNKawP+Vf0ptHPnUofvB9
         qaXA==
X-Gm-Message-State: AOJu0YyYJMKhuYcvsJ8HUoOp8UeQAwX4AL4G9hoN3uq57h/blZZ6jZDJ
	Si2VJ5ESo1lT+akX+OiMcpAtdfcPH+iV2XAbLXA=
X-Google-Smtp-Source: AGHT+IF5Q+Th0043e2gr0JOioriHKoQKvu0b+8wHfr8TgZ+2pV4uWfgyZXB3PjxXK/eElZ6PCVGYDkUzA4wcJbQHKa4=
X-Received: by 2002:adf:da46:0:b0:333:18f6:e1d1 with SMTP id
 r6-20020adfda46000000b0033318f6e1d1mr1185485wrl.4.1702174290370; Sat, 09 Dec
 2023 18:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208102355.2628918-1-houtao@huaweicloud.com> <20231208102355.2628918-8-houtao@huaweicloud.com>
In-Reply-To: <20231208102355.2628918-8-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 18:11:19 -0800
Message-ID: <CAADnVQKZfvDQUuzJ98n5Q6a1xU5XBxFGi0PeEnmRxj_TFKoW1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:22=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> +       /* Wait for any running non-sleepable and sleepable BPF programs =
to
> +        * complete, so that userspace, when we return to it, knows that =
all
> +        * programs that could be running use the new map value.

which could be forever... and the user space task doing simple map update
will never know why it got stuck in syscall waiting... forever...
synchronous waiting for tasks_trace is never an option.

