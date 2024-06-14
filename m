Return-Path: <bpf+bounces-32186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A85908B47
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981501C223F2
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D7195FEA;
	Fri, 14 Jun 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3iRHudL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A90192B98
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367101; cv=none; b=aZdpCear3ONbER442jxGXBilgKuazVr/9PKM+ZvktGouFvsGO0HHicCmeTqetnos0UzLpjoOzzY81kbLU7ACa0gKIHsSmt6BDmj3VZ43nCO7iEfWc1Jur1rA9ve6fGDw2l6s84ZREFp36sdXEQewIyaOpgooOvQh5YQncr3rEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367101; c=relaxed/simple;
	bh=KVlIlw1T/IlOGpiD8V6p/D/IPjYmYPW+iHLRy+X9WK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwviZijLR6I8AftzFuTZU25FJi0NKYpDjyQRH3eS6/j8mx7jB50TrBdT++hmRYkOBO9oKhW8IxGujbNvDiHYHPqOAfl+1yb6LOJD1RuGtCNf/5J66xyI20rcZ4wl/+YVinFbYHKdOpeKfd66JCVdVYY5WcobhlZx428GLXCzjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3iRHudL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso14708a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718367098; x=1718971898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVlIlw1T/IlOGpiD8V6p/D/IPjYmYPW+iHLRy+X9WK8=;
        b=I3iRHudLY99nj6iPkETEhz5Ot4wUxzPRl1d5mB14WmlWasIsNHL8+C8c8pjV93gJFe
         +cyuBBVz0TKtmtnZFFPx6mVJ4elVqPBwdQHiHoqpCGwx1wcKEo8o5MObuiWqkVEMabOb
         IuNA+lB2/aP91l7TuRgAzogwY9SQiGMir++VETadk7/rt6RlG3aCz8xUFztbO7J5dWae
         dxH9nUoDNo7K62ivCMg14H/jtN+RsW/wFd0R1/Eicc8TruLaRSMzcPX+8qJ3npqKAaP6
         jQn8c0GclAVk+oFQZ4x3ZW4DfBLVCq3Rrr5KH27EAegv48GdmySJhWY1TtHJVlYNPouY
         nhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367098; x=1718971898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVlIlw1T/IlOGpiD8V6p/D/IPjYmYPW+iHLRy+X9WK8=;
        b=rjnLlUs4kohYuBvnfyGZnjAWC957qoICl74PLcHI/ZlFVDs8B5Zaz2r59LAm10b3SM
         QGlZkxCCj8uhoOEbjcYyRgI1AimKjdFfNjrT/G0tumBtu/apjToenoXaJgB1E31tgxbv
         D11TBCEbRmthuAN5AFotnmZ6M8IpJiGQteyPUp2uawiKXXnGj3rcfKMolqyU62uOFopp
         2v65dXfYGqWHrL+sGqIypsgUlRCfukPwc6VOh1PKDhMm4eU+W/Rjmmkmp6e7nnBYQe5H
         YKxVsyBWx40rJqhCjnsptU1haabH+V58bjfymH2yu4uEIC9H2KBprLW2IjZQdy9NN2UJ
         Kj9A==
X-Gm-Message-State: AOJu0YwQuPIy6YQdIwmJ2Lq9zLaNCwecaT0wKy1j8VUzWvMLiXqJmPqj
	Gg6SiTgHDYj8vQSdUECg+ms8i5P9ztQgOIqoTprR3ZeN2Su3+/TXADiSu258gvU7TYb7b3IjZiy
	8g6oZIhyPwUBd6KncUIHPWVl9gndI04JGIZOy
X-Google-Smtp-Source: AGHT+IFkwOu8kKE/ZfwR1pRWp7X3E1nykpRpqDXoqmWhyx2ZM0Rgok1m3lGIwUBrZLrTexXzng4u0EG/xCNVg5sOVNk=
X-Received: by 2002:a05:6402:4301:b0:57c:ae72:ff00 with SMTP id
 4fb4d7f45d1cf-57cc0a85d52mr130767a12.5.1718367097383; Fri, 14 Jun 2024
 05:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com> <20240614101801.9496-1-fw@strlen.de>
In-Reply-To: <20240614101801.9496-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 14:11:26 +0200
Message-ID: <CANn89i+TRnT8E4fE-kKcUcF2LZ76yAsz=C-450sj54Z1Vq+zrQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: avoid splat in pskb_pull_reason
To: Florian Westphal <fw@strlen.de>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	netdev@vger.kernel.org, syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 12:41=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> syzkaller builds (CONFIG_DEBUG_NET=3Dy) frequently trigger a debug
> hint in pskb_may_pull.
>
> We'd like to retain this debug check because it might hint at integer
> overflows and other issues (kernel code should pull headers, not huge
> value).
>
> In bpf case, this splat isn't interesting at all: such (nonsensical) bpf
> programs are typically generated by a fuzzer anyway.
>
> Do what Eric suggested and suppress such warning.
>
> For CONFIG_DEBUG_NET=3Dn we don't need the extra check because
> pskb_may_pull will do the right thing: return an error without the
> WARN() backtrace.
>
> Reported-by: syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c4150bff9fff3bf023c
> Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push =
helpers")
> Link: https://lore.kernel.org/netdev/9f254c96-54f2-4457-b7ab-1d9f6187939c=
@gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---

Thanks Florian

Reviewed-by: Eric Dumazet <edumazet@google.com>

