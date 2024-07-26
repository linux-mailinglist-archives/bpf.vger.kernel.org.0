Return-Path: <bpf+bounces-35696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F92893CCD5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC822831C4
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291AD2261D;
	Fri, 26 Jul 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjvML9KI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525F80B;
	Fri, 26 Jul 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963071; cv=none; b=U0Z/5H7PrmLxWLiKplEcKyopAKLcEyIGEJQ7huqo0KtjSEjqcJe829S5WeMCY5E2UIMJMZhwKjkb1WcAlvr5VKcAFytXcnV0J7s5Gcr4X9BjCUdBT7uhwWEfpkwQPSQNaDrkTvyjO6Pv54eF93Prs6nS1EgvXS8f8Gl3I1q/eg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963071; c=relaxed/simple;
	bh=awyum7uYEbOYA9xUJvq86opnRgKll/wMBwoEm3AIOCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpJh8tKUw+irhWPo0Qlomi/c1hitKeulvYCROc5mEeQ3jkZNwKyhMvMoE1Rnpwa8bU3yUYYExhHujFFzg6s0Bh0hbJspwzX5gw42Y4iUEPjKqp/VDqWHHW5cKNxq/X0N/ptdSZ0pjzGweFAiBZ0eCJgwYIFq4Ub/zeMkwflCVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjvML9KI; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8317511fd45so142926241.1;
        Thu, 25 Jul 2024 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721963069; x=1722567869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awyum7uYEbOYA9xUJvq86opnRgKll/wMBwoEm3AIOCI=;
        b=SjvML9KI29L+ZfeFYGgJYMhzEyZpiBuyRtj5OpB4pmlGGh8EALEQwM+JZlHRb6hjgX
         QoiHppRBSLoyrh/MTyOdr8xAcs0sGdP48Ypg7RT0kSIj9zKGBlt/8R7BO0sbm1oIYeOH
         yVfKIUZjmOLM2EOd1831RMgLXT7BBm1sp4LhDKWAfh4F8mWvbP2SzArtkpwph+238xU3
         lI0YR/vrWOfmiKKagC5RPf9rfL319UXGJ9cRLKAHb8L+O6VsjecMbKI6BFANDxesVRrA
         83uPEZn2ZlNPkZxxOUEgAMgLXudf4tdmu+UBKR3Woc1uF4SdktBTSrCCeBs8/cnOoHSP
         YdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721963069; x=1722567869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awyum7uYEbOYA9xUJvq86opnRgKll/wMBwoEm3AIOCI=;
        b=gLSLMD3SErKvbUqSzZICHISXBBlDwRfvJq0OnwZoOROH+IWcSxbVNkd2Hd+s6Y2lrG
         yCVxIoGyTxOLvadBjG+UchcTtkgjmlBN2faZPJO2jw+ymztsYmkFq4WYGsfqKhGbelnK
         /i+0YuyTsJjJvE//dKd+z4mOMKPbDz6O+6bE3uMrLvMFVXxkipuu1m6yEL89+mRM+3B9
         BuG2oNL9im0WJ5KgShzSrDlN5rUdYhqsUJOeVU1bSPXBIWrspJQz7TT3Igj8nfsrQA2Z
         hSCFVZ8uUY0loFs+KAcl42/zLHya2XlMdW97ERKtMe18dv7+itJHTjp7KGc1M3/0fVNn
         oLtA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aJ3h9DkiRj6ghIuDTd360EY3I5Yo1RCTo1iUyUnGPEUe4HcP4KGzryJBK/FX82y65hpcEdpuCZn44iQ5P7LuNIbq3EZs/rYMPMTkHGoOMEsdq0wQtUCwi6sN8zUV3z7yeluvynkZH3Ci4avjAVcDmlN+R5lG+Z6D
X-Gm-Message-State: AOJu0YyqyNyeWjWNKRi38mSCflksNajg93LrHv/pMV8g7fREUQ+rWD9f
	NPxuomVtkxm6PxEW0d3EbN5/eDGikyhfJR5g1IYqIbjwy1rVc+8rd/Srp0KhW9yNyjpBvW+4Q6K
	mZ+o3MDtfr5ARF0CcLe2wWWZLPaM=
X-Google-Smtp-Source: AGHT+IFFhyXMjhrDnEO+19jgwrk1TFuAn/A0IXjXP28f/riODB+Y1WO91AloV+Vabda/xzpqMFfY7XTxrA6bN4XYvsk=
X-Received: by 2002:a05:6102:5e8b:b0:492:76e9:961a with SMTP id
 ada2fe7eead31-493d629ca4bmr4489134137.1.1721963069028; Thu, 25 Jul 2024
 20:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009d1d0a061d91b803@google.com> <20240725214049.2439-1-aha310510@gmail.com>
 <CACGkMEv2DZhp71-QdckH+9ycerdNd7+F5vFyq3g=qquEsm9rHw@mail.gmail.com>
In-Reply-To: <CACGkMEv2DZhp71-QdckH+9ycerdNd7+F5vFyq3g=qquEsm9rHw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 23:03:51 -0400
Message-ID: <CAF=yD-LtR--NvYuELb2XGaPAoygyWtJOCM4+Pgr-Pg7TwSB5Sw@mail.gmail.com>
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
To: Jason Wang <jasowang@redhat.com>
Cc: Jeongjun Park <aha310510@gmail.com>, 
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bigeasy@linutronix.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Jul 26, 2024 at 5:41=E2=80=AFAM Jeongjun Park <aha310510@gmail.co=
m> wrote:
> >
> > There are cases where do_xdp_generic returns bpf_net_context without
> > clearing it. This causes various memory corruptions, so the missing
> > bpf_net_ctx_clear must be added.
> >
> > Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> > Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

