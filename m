Return-Path: <bpf+bounces-42721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CB9A957E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0882D1C21ACF
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFC12C478;
	Tue, 22 Oct 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnEb5BFn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EEB80025;
	Tue, 22 Oct 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561076; cv=none; b=cvmUJzhhz25LWkA+c5Melp63YiNk56ZXbINEYRQXaOzl5F8IXIlrATsozabaWMK0koBDPQDUtemmbWf0atFfg65rysByURLdwjwyFWfdACO8JQf1ckcRF23f41I9SlYVc1YwEzlV89I/AiXPGQz/qgBRl+zhRGyF/6SyBCGRQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561076; c=relaxed/simple;
	bh=NDJLk7xkPiU48e/PSsaR3uNMu9+RXCrTo/wdzd/6Vts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsmANnnWvI9NZyt4PqZkfGlP04IY37WD7ak+F6MnTTB1wY5LPNTB4vn264mEca3OWC2s9zAEya9aahPDQEj/I3fpnIGGUx3rk3rs07YucyJcacdwMc30YlV0dM01ZWN+ZSKqwE73Aqme/LDeZZ0jYLu4xjwJ0KXg7j1hZ2BVTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnEb5BFn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2f4c1f79bso41758207b3.1;
        Mon, 21 Oct 2024 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561074; x=1730165874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NDJLk7xkPiU48e/PSsaR3uNMu9+RXCrTo/wdzd/6Vts=;
        b=CnEb5BFnjhBQbcZghV0O8QO/n7o4aJfb4ZTElX0odhBZQbZfh0i0m9L6bxxtDQLto9
         nKpDYGTvijC7a1Z9eHOhbEftcSaEZ9CqM9tup9cShd7m/PdMB3izG0c4xLr0ItgkXMm3
         ZizjhdgPwEySlNen9IPZ6ZbwLmbULNMYuK4dQs1i0KO4vGxyK6dXVyWxJ7ZPTefMLk8c
         dqxF8AoJ9fntE0UEfjd9YPnoIhCdcpXStOOJtbqjSElqlVN5ZnD8BiQ0vJYWOKBLWhL6
         p42lCwC8rcEiB7PiBU4bA0POVPc8IE1QKpg58+9Ym+qNf+AEikOMuuhHQdUPMSVHhXVQ
         mGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561074; x=1730165874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDJLk7xkPiU48e/PSsaR3uNMu9+RXCrTo/wdzd/6Vts=;
        b=VUib7ReMfLIJZFRA0IpJeFFmLSB9kwgLDkE0GNnaPIrfpYS9YfjUKM1YtYmFI44EOi
         77FFRuXLp/TZ1HGUOFV5ikKwnuNLXfyfOX2cMawugsUmD9CjSg2hAg1q+R308ulv3CoS
         5JXuwoRq3MJ39E7cLugCCyiIU3DAqOkeNJtSY6xrC3nhBHd64cIxB6kRcz2yC2AaJTLE
         IOWy2dnqFenhqP2C2+YLJN5J5LshL+SK6uYGXLgO9rk1zEfQh+s+3AJjvgfDeCHKFwHu
         Vdxe8wMocfJ75FfEdsUMvDRYppEgZzL6yYTyz1LASXviVccdvXCisy/44vMxLuzLR3yc
         EJfw==
X-Forwarded-Encrypted: i=1; AJvYcCV9qKlieFNoBAbqrS/f0LWjuJCRwr4fOZ74yeNkzfNF0jOSmwnMhk/4rQzOwPFPfQslhZuqr5Z7@vger.kernel.org, AJvYcCW4RJS86EzbI51r2DG1vPXC/75GYLMCPWZiTc2uRhRGLu7GJATpqBpZt1wrKfOvHuwUDqA=@vger.kernel.org, AJvYcCXWh8aio4rjTD2avFOkJUiJisEJFHyslwo7zZ/5f3bQsEmu74IdK87n/GZwJYP+5CyUsjAZ31fi1LtBSj0j@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLgSCYoE2+gUwIZ0p3nTfKmL6sJAsTDNAtqDJcUN5niCXXKXU
	mlDv0lRAfeUs89COsAfqIxe9eh2h7nOJk4wXh+qfY9VPoej1Uk5WGVUoK7MsDbxH9Tfzbb2rxzi
	MWmLX3VHCdUOWvMW4tOwjPT1oibk=
X-Google-Smtp-Source: AGHT+IH/tKqA6Ex8XzzdbDrWfvqDknkowK08soSRE5a9PRlkAj9ON17Z/foKz0LOaGN255PnB9CXz+3HOizL5IJ0yLo=
X-Received: by 2002:a05:690c:39b:b0:6d3:4c37:d652 with SMTP id
 00721157ae682-6e7d8256f38mr10799427b3.24.1729561074147; Mon, 21 Oct 2024
 18:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019071149.81696-1-danielyangkang@gmail.com> <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
In-Reply-To: <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Mon, 21 Oct 2024 18:37:01 -0700
Message-ID: <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, 
	"open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

> A test in selftests/bpf is needed to reproduce and better understand this.
I don't know much about self tests but I've just been using the syzbot
repro and #syz test at the link in the patch:
https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090. Testing
the patch showed that the uninitialized memory was not getting written
to memory.

> Only bpf_clone_redirect() is needed to reproduce or other bpf_skb_*() helpers calls
> are needed to reproduce?

From what I can see in the crash report here:
https://syzkaller.appspot.com/text?tag=CrashReport&x=10ba3ca9980000,
only bpf_clone_redirect() is needed to trigger this issue. The issue
seems to be that bpf_try_make_head_writable clones the skb and creates
uninitialized memory but __bpf_tx_skb() gets called and the ethernet
header never got written, resulting in the skb having a data section
without a proper mac header. Current check:

if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0))
{
**drop packet**
}

in __bpf_redirect_common() is insufficient since it only checks if the
mac header is misordered or if the data length is 0. So, any packet
with a malformed MAC header that is not 14 bytes but is not 0 doesn't
get dropped. Adding bounds checks for mac header size should fix this.
And from what I see in the syz test of this patch, it does.

Are there any possible unexpected issues that can be caused by this?

