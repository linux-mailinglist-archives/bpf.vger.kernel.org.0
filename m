Return-Path: <bpf+bounces-63757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFCB0AA1A
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 20:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9361AA4B1E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364192E7F2F;
	Fri, 18 Jul 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWap06Kh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796C1E0DD8;
	Fri, 18 Jul 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863149; cv=none; b=aAoZTSKvpdSo+f+KF27GJCnIVpTeLH8SU+ahZYGXa8UdZ9mrO1kSoIWCHi1oRG1jinhlstzv9rMyytZ0qdLgdQUuWjVQ1kiU5y/+kXdCyEkgrrc3HvWB+2b8af3KX/4O3JMbaRG2bckZAUv3alLHZ4HJGiyguaL+HRP9WF/Gyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863149; c=relaxed/simple;
	bh=7rQ/ySqdp7CI20/9emKDXbsHMq5q6rgQBXDslMGiurw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDSgY2btbYxTbFpLM9yWvCR5GGH04upuTjTNjlvEiSA8dQypRLL02VzloOw9l7hQ8QfRij53OlAlhGXmyFkOB5amT+huCsjjwBB7/iLiCRRXkH8GmtIpQgtZ+uDUusbWZKBXf0quWRI/UI8KEGqTb0NXr2CJsZfr+wJDBXECJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWap06Kh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561607166aso18865325e9.2;
        Fri, 18 Jul 2025 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752863146; x=1753467946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rQ/ySqdp7CI20/9emKDXbsHMq5q6rgQBXDslMGiurw=;
        b=eWap06KhZPKQ1mQLri3yo3sI5wZzoAdh3WJzo9ZCUujR5w5Ga8TTcSyaCRvdpsh2q1
         S2PAhEdqNE0ty6O1yzQmbU9PPQXyXgFQk/z0otb4xrSTGR7uPN6iPspaa7nWm2dOEXxp
         4JbRD728FmJdbGvXivAO06GhjlWgEabIl5os1mEAJC2SQDcwcaHxUZcj5JXFqjU9WvxW
         JNxuNwC9cANbHlL/e01S7aRSFVaOCcg/eOlVWiI+DBtaAVa8kUhaHNT0+74JT7VkHVsf
         ILSpUCRR0LBbQ7GRZ6EjIqs8IzByg37bGNLoYUwDU0JRWycm+JzXviOU+JRSpQsxtWrz
         CYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863146; x=1753467946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rQ/ySqdp7CI20/9emKDXbsHMq5q6rgQBXDslMGiurw=;
        b=W8jYsMlKyEZNjelYQqmvRqS/mjerCpnbpUsvsFQnSsUTQfFmNH8QeNdHJLZX9km2Q1
         06LBmIEl+yMAuj8covXQjW3VBvs/sCk7gm+AfgYd8kzwTau17wysmPQhbvwZcOFdTSjs
         uKjzsgti4Zh50y8yCDVwV2jsK1MRFukoDraHx7By/kWJczwVsrRN8eDghW01NJXxyy0J
         ZDQfx5HCkUSQ9WgOLAfn1sUMMSnkA5fhJwXvDXz/OpX2IvpPiD+t69dkc7O98ghzJIiF
         CHL43ig7JBzbKIjrvbsbDr6JYFJLAs2M2op1h6u2OFvDUUT2QGyKOtspsLP0JCm94YSG
         NztA==
X-Forwarded-Encrypted: i=1; AJvYcCV7XPc8plBkiyVSn436SP5HhW69WzWa1Atw/HvkpMPj6NT/8wEYzaD2ohQTlxeJuXRVzTSmC+ae++o1g1xB1d82@vger.kernel.org, AJvYcCVEyOMK9+GoUEizE6xvuQ/wsps50Muxcduh05Hh22shMNfChUCFbtvg0Y9KIrT3hp0+7b0=@vger.kernel.org, AJvYcCVtppmJLVrhaxNwzUHJcBu76K9szBkLNzsiaub1KqPQ7wQvN1RX9hB1HOm6r5Qws5gSWkr7L5qa9kEDgIdV@vger.kernel.org, AJvYcCWOGAG5FrLiNpNchPKKPL7cIc38luZgvZnc+nl9A6J3505KUu+W++9DfFbZ3u1eKekG9IGOewAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6xL5sct5nnGw6rL/4g4J4OEpGKwe8CXMq+KFzcmF9D6BU7hg
	GnJjVsr27wAKGsxsevdSuJ1+Bqct03nnECiD2wMqEsMIt3pislRrV5Tfn4fSSLrSZoUqzQZ5gY8
	mffIstVxgA7fATHlr1q+BgRLOiAtYXBc=
X-Gm-Gg: ASbGncvSuYGtz7aA01NDqO1vTchQE7BHZj7eXAGitrIM64f0Oxlx+XAKENm0XO7bKyE
	h6A+BA0fA7+w+Z9YOdGCQDVt4FbDc/uFWgHxxXNOvmTz7ggOvuRyG/q6wRjmk4uNtBj1kk+i0Di
	yRU4sbnHmNlUcRGlreTNELZC0oL31cO9VKsoXFi+Zlwqei/Vu93Lq6wBrnTqdHLDQ7xdp7Zf3Mm
	cGGGRA+xWPhK1BxuwYyilkoJuZNklH8LfFp
X-Google-Smtp-Source: AGHT+IEe4rj1cW9cX4tVDm5QTOkimSR766TO9ryjwmojDYGSFepqUgth1+KYXDyOSr1QiZC81Iruk3BcAZ5BEq/lmlY=
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45636ba6679mr91367775e9.10.1752863146237; Fri, 18 Jul 2025
 11:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718172746.1268813-1-chen.dylane@linux.dev>
In-Reply-To: <20250718172746.1268813-1-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 Jul 2025 11:25:35 -0700
X-Gm-Features: Ac12FXyHvw3SskVaxW4s7-ZTUmg2xXrOApp_s7xLqMkcj0CshSbgMR2_GlhJyOk
Message-ID: <CAADnVQKMVJ_2SMcm0hvg2GDc-RPVU7GVAWRqbSdGn2ZtwUbUng@mail.gmail.com>
Subject: Re: [PATCH bpf-next] netfilter: bpf: Disable migrate before bpf_prog run
To: Tao Chen <chen.dylane@linux.dev>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Florian Westphal <fw@strlen.de>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, syzbot+92c5daf9a23f04ccfc99@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:30=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
>
> The cant_migrate() check in __bpf_prog_run requires to disable
> migrate before running the bpf_prog, it seems that migrate is
> not disabled in the above execution path.

bpf@vger mailing list exists, so that developers
read it and participate in the community.

https://lore.kernel.org/bpf/20250717185837.1073456-1-kuniyu@google.com/

--
pw-bot: cr

