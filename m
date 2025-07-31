Return-Path: <bpf+bounces-64812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E5B17289
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60B3622A1B
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917192D0C9A;
	Thu, 31 Jul 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tce0NDU7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799542D0C89;
	Thu, 31 Jul 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970029; cv=none; b=Vfg6W5OZChgYyNF2vvvn9apoggDcCXxC2DJXDAd1jYW2qSevwQS94d5+HZzdmH8tTrQwt/odLgzv83Oi3Zti3psdqzsSPcU8ENn9c9KIh7mvB3YqExkYkgc2IUC912FMeJfkwCnqSvor17yJn4gUNWx2AGIu/i35OZpEiY3nGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970029; c=relaxed/simple;
	bh=3WcITOJIoosbbppFJ8kxiRFliEkMpQLvAZvhxxLU4oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epQwt1qZVLW2O7YSTOXuInAGaIEe5mLk0tt1R3k9aakCHUynYF4DF9y0L8VApKdKh2hrNuDeLBOBspMejkVhUJtfpYyKrDY7uYr7E6IFYRh+2XV1fn7yAeyED8fZ8I2waz6YYovckI/Kpxx53ZyZ1HqlE1p/WoIOOFb32fNESho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tce0NDU7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b780bdda21so774482f8f.3;
        Thu, 31 Jul 2025 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753970026; x=1754574826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuU5mHxdX4lsrow6GitlHTlMRpHE4bdSagIX7HEKYAA=;
        b=Tce0NDU7u4yUK80G6VM8FlcRU9UG0XrEnl96UBkjOGZQNit0JOTJuwX5bCfd0aa4NQ
         9ifPmwp9gx3SjXxNGsiZ8z6up0uJ17WhJc6Wbpx56p/fkxjdui2JjxHFsU70apbHqikS
         Ml5jhuvklGIVfeL8VVrC0AJ2FWbhXVp3luaJQiSZgkdfmGkDmUM9mANVjbasTdn4G/Ul
         ET3TW9DkZHO+ITQAvu6ZFtAXEwHijAHjbAx65ATPHkYjC/z25MUXkRxCZKePp6peUwvu
         vZM3QS2Wq+9t2wiT+tiCtmdASAtUXJrD4/vl8xHKbUGxPemug3dWd+how063nMvNNuOB
         xgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970026; x=1754574826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuU5mHxdX4lsrow6GitlHTlMRpHE4bdSagIX7HEKYAA=;
        b=S9uDuEq7qgud9k8Imggp7u2jDXo1I66axvix+ePpHv5pLJcLyqT40Z0b7SXuBeC2kS
         aGUO+ARVvlGrbq8tMxpiONJy5VNwM1d+0Mye1T8XixJdOkCIVCwbxDJafyOAS8GeJVY4
         +NvdE3bBuLxJCl9vs854ssZ5Mvyts8UK6UBh7asKaji6uuGQeX1D5wGDZRuBdCDvzd3i
         HZJufG+7h/fL/EWb7H4EPMtBc0LSz+Q7y9FoMOJ1gcZ558rwLWxEVNmjK6r07uj8VVRi
         0tP5ClO/jkToEsR2rRV/Nx74J7Y92VubMZZWsGzkCaC4KPPQ+T88emlTLyekNH3NcI87
         8vrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+IEwYAYevOWnADSrXW7aHdemFQauUs3TLzPOkSuax3D6YwQFdD0m2dQy8NNrgtN9i3u0=@vger.kernel.org, AJvYcCWXnF9KRkuUiiYR/rMZ1bHJwz5UQH9jSub5lTDZQspJ3xzYnGOys+TC5nvy9L3k5T4Nv7vonYRrnOdEW0T6@vger.kernel.org
X-Gm-Message-State: AOJu0YynE9bfDHmqvJfWf7BDajRxBpwY++N13KmWrymsNReihSdYLZBD
	W3tg+HK3ACXDLuKDQwpa1Xw7FHgCwNL4ArknISLUonZjjz4n0e5ZZ7HhHvlrZ0AQ
X-Gm-Gg: ASbGncsqdM+iQpNzi3YfdqRTjBk85IOb2eowN129WmJpWwPsOK6p3fiGh6oxnF0qhIu
	xaoyf9sSDUNhrE9BLQe6O7y8DMtiZ66WRp160rL0KpGJow+ysbPcDJIc6aouOZ/uT5WSra71NB7
	0UXcS/bQ6/AOoMe+QNSzEw5UWqVj1CfyV5OhiytdWmP4X6ez4brJIPqH9KBFr4V/xTbsDYXH1w6
	GSM+z8uDH7kmy7VNtE5rTniUeek4avPvpI4sdtJIy8ze9R6O4v2fIuCUrvmztk92/Pt1sv3BPXF
	9LLzio6HP37psBeV1Q3QMojtXmi74CvU/BcRxH5mEODfzk207p3tZy7yYpjNF14J0Zj5BGG0YO2
	qEwc5xaBrkIcliOHf6ylVdnaBfvdILdMWRWV+GGaMTVyrovM3yQWjqCf4QW104h8XuwOKnyPTKO
	FDQaN86wvgPgMlbICfWmEzg/gNhRHgNoI=
X-Google-Smtp-Source: AGHT+IGr4LmHUE203X/uELtd2rH2od83uN6vxCUcgGFhFk5ZX5CohFIKv1F6n2zmUv/ZrVdshykULQ==
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id ffacd0b85a97d-3b794fd5940mr5825549f8f.16.1753970025372;
        Thu, 31 Jul 2025 06:53:45 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e005b2c732a3e9fa7f4.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:5b2c:732a:3e9f:a7f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm2623102f8f.9.2025.07.31.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:53:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:53:43 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in convert_ctx_accesses
Message-ID: <aIt1MuiclSoonZLe@mail.gmail.com>
References: <688ae0bf.050a0220.5d226.0011.GAE@google.com>
 <688b72e9.050a0220.5d226.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688b72e9.050a0220.5d226.0018.GAE@google.com>

This is happening because flow_dissector_is_valid_access matches on
ranges (bpf_ctx_range) whereas flow_dissector_convert_ctx_access matches
on offsets (offsetof). Hence an access to
offsetof(struct __sk_buff, data_end) + 1 is considered valid and then
fails during convertion.

I'll send a fix asap.

Paul

On Thu, Jul 31, 2025 at 06:43:05AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
> Author: Paul Chaignon <paul.chaignon@gmail.com>
> Date:   Tue Jul 1 18:36:15 2025 +0000
> 
>     bpf: Warn on internal verifier errors
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d6aca2580000
> start commit:   e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1436aca2580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1036aca2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d32de89be62206c8
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131049bc580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc2cf0580000
> 
> Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
> Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

