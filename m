Return-Path: <bpf+bounces-77378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58A7CDA5A5
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C45143012CC2
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7134B413;
	Tue, 23 Dec 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz0WwELU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6D28C5AA
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517951; cv=none; b=eB0aWoL5VE2i/i1dD7EaBLRFTAT1kgF+t1SIInDHMlVdhCrLnrxHn9jco/zHQcIjF/qIR9ZXBjAWYR69OO1kVhAsEv+kCVqwkDLRS9KP74cxdznugIYG2pkWOlOwMiplrhEew8ur9DX7aUOB7NumMqgX3thBhoGntXFNrc5T9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517951; c=relaxed/simple;
	bh=RL2OrR7u1XM35xbNuvhRgdwdGeqjB+OEAgPg81+SM5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXOqHdqTdTuuirhFkqO5B5HVArg7mftSZCa512PMsh8bBXieKlfIrwU87Od1/QcAcUHbraY3BzFOxpSVvhe0bh4JanRYkFgEuyNipZYXCBUc3K4Ojm6TviO5AP6l58VpRJp7ZXv9QZQFmgyc5zRffGJWej3rxtgCgzqQo8EknnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fz0WwELU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso46416785e9.2
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766517946; x=1767122746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK2yALWFi3DSDt3i2r+xoSVTyoCJ+oh5Wz+q62D7I+o=;
        b=fz0WwELUUxCHmcxoH7QS4QZt1ftlR7WOkZBH8CZfdE92El8ZiO56ZLR/2FBdr+V8+o
         EQQG7guA+OX0h/UBihLwi8mPIrd9AxDs/6Vsv5jwx/HP6dsjeeT4e9jJo6ZyPVtTaCfB
         HgEUwAkiKR24yWMfZo4uKena4NbbjNhLi/6JVkt/57zyenokUEqfdpLcZ+Ieljd+8r+E
         VsBk5nhwR3EXZ/eE9kEI9KQvXxfpPYsvyTIjknlsL4Hjte+VlaJU3CCfcteQ0iOt2QIc
         cMuHJ087hk2WwyG3qPt5DVErpfbK+kbspzkGnLVeQGbzTtb2zRNDTjfah32pcmfLfgja
         ZSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517946; x=1767122746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KK2yALWFi3DSDt3i2r+xoSVTyoCJ+oh5Wz+q62D7I+o=;
        b=gFOZiV9IrKgjOII5S/e1dA3jgMpCP84PQG9whRW4cfK2e/kWWBl5Vau3OsARywwe9f
         4zaMbday5yxWsUI+voGWSnHiRjrDZ+w966iHViNGkN5Q+2Jwz742EYqgaKlKLo6prxBR
         dqO0t0Vefm9RD5LAwW7OeTZfFvbiJ6G+7IIBLTPchN63v6FHAjLK0kCB4b6aBUH/Dwpu
         yadIWBAmQRxFll3pJ+rR08b6SMabwWQbxeuOe83dMuotOLHtpith/AQGjgo3yPQ7EUgn
         xN92dLSyXQhD6BeNB44QYeK8bRpE5JGMmP/Y+lc497SDppkPQODwyxKF2MeU/Hmi74qN
         k36g==
X-Gm-Message-State: AOJu0YxU6R8GmT3rmu4rxJAsqWQwe/ACzPiP4HwiiBTgqUFbh+JQqVpF
	+xfMCSqI90zbvGqUr9w2eIwex1Z//QCWdivfxDmHOuGL9gnz/trHY3x9XE/INYU9jIW4i4n40jc
	xdwMwheXwrCNAbfakTRNUCe7uYeRBiAQ=
X-Gm-Gg: AY/fxX7VohpZ085FlSg86QeUaq7w6zEoIFhp2gSFWSuQG8/vYDQk2lM10HSQ9MFeGX4
	fOC05puV3Cd9GOYdK3TvqHJbw5KIR5Ug8OXnOxSuW3mc0e3lIrmwUQaqG5CufZ+dUjj7Ki9Me1K
	1nuSRfd4rogy50jFhCUFQI3rW3oTCvuKN6kbCo0Ppy/dgdT3yW7lP+qPra5VVfGlqmQ/u1akz2y
	FNb4lKM2FgWSJufyz3uD41nY8+1Ao2y6z5YqAU19EIhx4AZU7xyVIvfUpA/ZB7G08rFo+c/
X-Google-Smtp-Source: AGHT+IHmbdehsTMhWLssjldnFNH++fTjADR70kJcuX3gmJPL/85z4DU6sj2s5TO+oqphYvRmuLCZyPnRKN8SeBRFQ3M=
X-Received: by 2002:a05:6000:2889:b0:430:fb00:108f with SMTP id
 ffacd0b85a97d-4324e4c9eefmr16764898f8f.18.1766517946354; Tue, 23 Dec 2025
 11:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
In-Reply-To: <20251223044156.208250-1-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 09:25:35 -1000
X-Gm-Features: AQt7F2qyhh02kqVtVRibcEKEsFoYW4v0aNMLzxihbL5R7BN5gAyR5u72cVLxIOM
Message-ID: <CAADnVQLAFav8czDjCYPyjDK6Bj7X_L70WQ0eSFTwvsxxEXDzCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
To: Roman Gushchin <roman.gushchin@linux.dev>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 6:42=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce kfuncs to simplify the access to the memcg data.
> These kfuncs can be used to accelerate monitoring use cases and
> for implementing custom OOM policies once BPF OOM is landed.
>
> This patchset was separated out from the BPF OOM patchset to simplify
> the logistics and accelerate the landing of the part which is useful
> by itself. No functional changes since BPF OOM v2.
>
> v4:
>   - refactored memcg vm event and stat item idx checks (by Alexei)

Applied yesterday.

pw-bot seems to be completely broken. No notifications for the last few day=
s.

