Return-Path: <bpf+bounces-55082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7830A77E8B
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1E3B0EAB
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFB2063C4;
	Tue,  1 Apr 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWWOrOw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BB205ADC;
	Tue,  1 Apr 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519921; cv=none; b=teZA5Yns7eFybD/plR1D7Yotuw+TqdGdAAFm3y1Wc51q/xHRfEkr1fFL+ivvPE7vllE+YTzRy7L9nD54Ah98GC9mytzczCb7RAKnXXVUhejbpEVH88NW6lnfkKpXB1dOji2gh/vVjQNX26GNBzKglQYtXYq3AzwiUeVdRvFJ+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519921; c=relaxed/simple;
	bh=rzrpNc9TFQoSZZ0niGpxua8m7OyYjVALmZMPEBzfiAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLdo311wb2MjAlgV6Irw7c9ToaK8PELcH54nNILfZIg3QV/biGBGLNyZdzb2qbe8DQaiOHMNCuQQ3U5KkRrVWpLejk4MKalAVKCwxZg3GSboN0ypZF+bsnCMjZpF+q9wpOZuXfcziBWKuv3J9nj8V6J7xhdghZ0fqPlgrMat6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWWOrOw7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso41485115e9.1;
        Tue, 01 Apr 2025 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519918; x=1744124718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzrpNc9TFQoSZZ0niGpxua8m7OyYjVALmZMPEBzfiAg=;
        b=gWWOrOw7Qkt+Wb9dSEsRkCh/1CZAm62FTaWgCI5G1A2ccVCPANI5QNMZb+TLEDcUbu
         09W7zkaKyzoiC+9o8ls0U0HhotzI8kttDl5ZKHDzPCQGKFZnG076WRwkSa7BRUvAmJSl
         bAPHSE4HwS8KX78iFr3ltsaX3t7LIbXaZvg8Nt/E3gOESPzX/2FOkrqgY5HypZydwjoa
         M5RwWdyZ6bPbKe3uXC/Ii7N6LU88ItQykLByOOajOjdBHXknRsnh4QYoRcBFsSULYr7Q
         dcZkCJQDZph78y1lYyu4Aqd8oq9ZZ9o6LtE7NI8TkhaZ7QUB0eUNUxd693iK4cUVLCXH
         ZHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519918; x=1744124718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzrpNc9TFQoSZZ0niGpxua8m7OyYjVALmZMPEBzfiAg=;
        b=kniHZGyaPk71UQiLlzSw2blLCXb3RKvAvxnlgPNoNvNYYS301iR4FcjvT4SwGTNF48
         ojo16LgQiRPxYQy0T6rninxNzUHxYAePxqJtnJpIJfh1ojr+Mbo5Z3BIpLdr+d7FsVic
         g5UdxjTpE3vAuyAoxaalyMuhyOqmdyDm3lwMx+F4JdbCAGCehCycbCj9EvIptpXr7GKU
         9q045uhfUOqp+4L/LuwyJ8c5J+tVpWNXMXVyQquZ6MwCfzDSt1K48QWSe9pFuiGeb4LM
         wKy2dgFmEw6RTrNaaOYMw1eyg/kfZxHEtFLWZV11DKN0VVfJIsqxUQ9NV0C6OkG99ETi
         +jlA==
X-Forwarded-Encrypted: i=1; AJvYcCVOkOeQu+KeFsmU0LcMWotmHNOr3CCgczPJGh+tj+duMdN2e9iWfWGEitr1eHi18k9NZ4A174uATj7+ei4c@vger.kernel.org, AJvYcCVnisxby/FiXmgc6SAhbr8r279W7RMiAyjfPxftYW+yaKUWWFItz2rvIgsLILcwJOpMf4o=@vger.kernel.org, AJvYcCW1BL+IkNlgepJyfWnELj5BfCWPEHuQ1/DOImguNvQxNSSe2D7+6vWd6MYAIR/xmybYrUUyw8wU@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwYh3mfE5zXUOmIxUjdXgVwVkVkXB0qRpjW1YIPadWp9z+aCE
	QOEePDilATysLgDCIiwQB6V762eHPiXnIhORPH3hj5WtDe0T+acZytqq4lqv8DYt1OcXVnNJUOR
	yCr3KYdDzNquwg4efnJpX9Blw4R4=
X-Gm-Gg: ASbGnctk6GUDHIXWUsJSsvu+aEtwmtDNN1XW2yDGbfuVRNhesUfYBTymZbVfQIxYWnv
	jIAa9BIlFMTQ/N1TRCRWM/jkhpiegfSpoFQ1BRtRC6LflWe8WDljkjgaQu5PbR9KkxGOtFKNhkU
	gE59jl/7S0+6PZX6JQCSC5JTYs4IZChk9qUgYbLeI4JhhDI+P29ecS
X-Google-Smtp-Source: AGHT+IHZQtwFAvK2hEK3yaLRLVk7xQKQq7OYedZ7AVxaKdxQr56jQ+LIq0hmcvz8D6ogCFiYYaPot5hdNFHc3HTAwRs=
X-Received: by 2002:a05:600c:458b:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-43db6248241mr135498295e9.17.1743519916412; Tue, 01 Apr 2025
 08:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331142814.1887506-1-sdf@fomichev.me> <d2914c9f-5fc6-4719-bf6b-bc48991cd563@redhat.com>
In-Reply-To: <d2914c9f-5fc6-4719-bf6b-bc48991cd563@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Apr 2025 08:05:05 -0700
X-Gm-Features: AQ5f1JoaNp4frNZ66sJ-r3eX-oDEbtMT1TlTYmYwNQwwHoQyApuM5RKvG1xty38
Message-ID: <CAADnVQJJFPD2X1enPCa-0D7RG6SraRFTdMj1bsKkzFuz6Nighw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 3/31/25 4:28 PM, Stanislav Fomichev wrote:
> > Syzkaller points out that create_link path doesn't grab ops lock,
> > add it.
> >
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@g=
oogle.com/
> > Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>
> LGTM, but are there any special reasons to get this via the bpf tree? It
> looks like 'net' material to me?!?

Pls take it through net.

