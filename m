Return-Path: <bpf+bounces-41526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B6997A84
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D4A1F24030
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880074594C;
	Thu, 10 Oct 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHQJcWw0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D142E3EB
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526894; cv=none; b=mUC+AK6QkQ/KL4dhoggG6cmmG0Ar9qovvDQki7WJPgnWMigUyhmdWek32fdZp23SnPWUe5fYpcVQMOrkEQSzVHBqD+uUG1viE8AbFBOMCgr8kGNvGYe7h+sL0GFbwSCrz12lQnRtNlqaDImw4jy5Xkj1UW2mfYnhSuvCJVh8to0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526894; c=relaxed/simple;
	bh=ojyp8tRpPrOWU8E+Y9yorBYKYvYXXghOJBTqfX7hRD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsK2IP5AV/BxA4Smu5klxy58C20KyWAiliT+X8XTB354bfseHQMzgIhWtKxYImMYW9telpGDij1KkA4k6/w2Lc4Jh2bpAXDzdhAE+AIrO1WqaigA7rty6Q89Ou9K3RxG6Gfg6RkS8cxE6zzfHqQbnJg1Gn3FYSRVHYmPTcxlBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHQJcWw0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso3329945e9.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728526891; x=1729131691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6T0hlPYgxbdjctV2zib+mU0K4VJjLeUm1Ur9iACuv4=;
        b=OHQJcWw0LkfK4v7W1diqsERY6u5pp8uny16Vq20D5hagdKGXagEFGy1aVWmSW7NuUh
         7gzwU5i/35Qr6tOkPPW1gBTby9rX+9EDy9QawT6PA7cs663wfPvSuUECNpQXDQSDlIUN
         MC+f6mGrrUvSLwdvep6tXABkutGxjzWihXvqSv4LbQ/XZ4xDpOswYTN/FYDFimBAiCPk
         lOO6VbFzLUH80WKOFD6V+sP8eSYhF0bimfM6w+bCnGu2H1oxNxyMyNLLUfSQSXHkPBdR
         Q38HksU4nsVhVc3K6I1Ldpbqt/VeGUurQ8Mghz4EIGyQfo9Vuo3Y7SU635Qnzpc7AXRH
         XBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728526891; x=1729131691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6T0hlPYgxbdjctV2zib+mU0K4VJjLeUm1Ur9iACuv4=;
        b=LKMX+GE7Ey4Dc+cMfdfaY9bYxfRfgqoDWD4e0ggWV4lGPz1hWRCmFDWS62EVx3jgZV
         E4FBeedmWpvcUmLKvQsRaZ9y/EwX7ixctfgeTzFu1UkQBc/0MEniRxYg7sy418ZSnFLX
         Dz4C+67xjnR7dGAqjsk0M4HEpBDjoJm2+S39ekB/U6pAqCgXvBipaFKBlgrf4nHYPhYh
         Wx2Jf/jwmAHmnRHr9LiKrXRBeRrldrrl6JErGkPByoum+SVSlXkYbN/vVjf0SFWWxwy6
         TNfHXidxgRJNylEuK2cwUyJlyE7O/0FPRtJqmCt8VmEOYyQy78NbAuVNOfm5nrdb5ga7
         Z91w==
X-Gm-Message-State: AOJu0YxUAPTsSx5bumr9+B/O13izB+KTjtDenRzDSkVMWPLTptiL2Bc/
	t4584QS0kH6+tQ4gNmhXswwoAhesdWLor46FkA19kank6AoHcHH3nJzPonYpE8qmUE7EvllkLyw
	1IsqVQLknFtBJftz6kvZvS0cPax8=
X-Google-Smtp-Source: AGHT+IG6BPV9VoK9/hl7jsevq3b6Dx1Ll6k3gqS9Nrd4Va3Wh/77SQnlNkW9aD3NfUJfswSsXKYZWo/k822AgFROPRo=
X-Received: by 2002:a05:600c:450e:b0:42c:b8cc:205a with SMTP id
 5b1f17b1804b1-431157f4aa5mr17989275e9.32.1728526890440; Wed, 09 Oct 2024
 19:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-2-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 19:21:19 -0700
Message-ID: <CAADnVQJ67TERc5Ag22f_O0BJJPmNpQYvxP08uBa0ur6FRdJoFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Introduce map flag BPF_F_DYNPTR_IN_KEY
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> index c6cd7c7aeeee..07f7df308a01 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1409,6 +1409,9 @@ enum {
>
>  /* Do not translate kernel bpf_arena pointers to user pointers */
>         BPF_F_NO_USER_CONV      =3D (1U << 18),
> +
> +/* Create a map with bpf_dynptr in key */
> +       BPF_F_DYNPTR_IN_KEY     =3D (1U << 19),
>  };

If I'm reading the other patches correctly this uapi flag
is unnecessary.
BTF describes the fields and dynptr is either there or not.
Why require users to add an extra flag ?

