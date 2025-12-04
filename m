Return-Path: <bpf+bounces-76022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103FCA250E
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 05:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FC0303EB85
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963C2FD692;
	Thu,  4 Dec 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIunqe3V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCC2F9DB0
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822612; cv=none; b=IYGkaLQwZQqsrJ7IzEAROogdJ52w2MfmB21OvmEMM2eUDJXAPTvzuzcI17oukZ3jPlRhqcrbj4xxe+62kx6rmmxxGvAHWh4GwBAdQiLr5UOHexpSeXgK/Hw0DlSr7hQYkWC+T5a+GHJR8d5mUHwcNorh3+TJbAlm7Mt2J+dLhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822612; c=relaxed/simple;
	bh=cz49EcNrMIRW5eq17ygS/tf6cneY8Hf0FVtcrPwiw1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GYps41PBrnkRJG1Q97vUpcONnqaduhG9viORmbJGWjJWoIxpWW5OwBOsEgWpv8Gbgwlp5tvs0pwNE28mcRTj5DuxH4kQItXUT/YcXlUBuWOUVi+Fl/7yD3MsQn1xTFMHKOuyxrYxGpIsj4DG2b+fLLWzy4IoRFO9m5R1iXH4xfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIunqe3V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso4524475e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 20:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764822609; x=1765427409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CKuYoY84Ub8SjfG2c3zCVp091XJBBf/vFogpY1PQ1MI=;
        b=EIunqe3VPEvAN8MUrgIN7SqOnxKoEY0r+X1VlbOf0JPb+JMaro7DSN9bDv0AM8q++M
         YtRzSgSP/4Fcw2+386xK15lYWRRCkyI/cd/8TgKz3z8FeIR+YzTczp0hTNQ52GeWu+Tt
         hJkn5jSJt7ZcuCRlQzokioRQzzVJaa9sqOu/Iq/ZjJGjc4RqQVJBxWjX2RTyMgEkG5hn
         BDTjRFDdjV2HIftxqjkgaJceb7s13qq9bUhD3L+IEEJv8TUy1GIjzVTwKYuXQnsxUitO
         NVzP2WXcLChSFyfmFs1yzcOeDE8JASZZWG/uvucnUDUoneGbSj113yd74yd/U2ihZDbw
         xPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764822609; x=1765427409;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKuYoY84Ub8SjfG2c3zCVp091XJBBf/vFogpY1PQ1MI=;
        b=mYnTwEIOs48J1FdFl7ohdMD7L0nV54YzQALmkOml303sBqZTqg7r1+pae6DQrJ33dS
         N1IrDgidPUWPs1zLFOmwJvopdLmIPFQQSXCQNlIrvEZXKRmU9p5ep9+4CEuFbH9w+yd6
         QVmR82I5vUFhs35yyrP8YhcKWDw0CoyHGIB3j2Wy+XGu5MdKK0KzvjkDsRNi36Qfnh8M
         nQA5vzsZ0F68fn1ZO/2RTp/tnt8qdPXRXRctYxPkF2d2E7thOHZidfepiLNkHhFJx65J
         Ldk8b2+0HH99k5K2+pm1wxvEvO7Xf6oYjqQ6mwFU1VWzkX/m8P7gVSYg+89wornC0aoS
         yoyA==
X-Forwarded-Encrypted: i=1; AJvYcCWvB2dsj5hyHuQwHkKyRIBhvn3TolhwL8ZMdR5b1oEiUgXjdW/IfVvlLaLfEBubhYpicYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6bGT/A8tS7rqfdcF7O6E7TJ6BnbFOHICCxmj4/KVixMpHdc3
	oXHQ/UkDAgOebZUSk+v17jr5on27Xxx9wPLpI/yaqJBbffQ7gdZ432S13+YTRtFB7BqWCsG9Nzh
	Wojn9Vd3UQniqLxkRB9Bwmdl4mSicHbc=
X-Gm-Gg: ASbGncsiNi3i66rVNLGoNy7c3XxnnqNe4jsGNmLAwiMj981FLg4VaEl1QpvI10SEvEA
	Hd0+NYZEI0t3asEnsB2viCbb1AL6bHGDgmLK7fv3BkN5acgR2crwez+CFal9arCAPaSfBhh6boP
	tpMxxv+ZZHtyfTNf3tV6Z0cRNm9Q0R26ECz3d0bGOBHC4uuHoBrhI26qX5w4AJrkTqjZkNBQwdy
	O1rVkyFopOYMCBlskjxmE+tF/RZccmiPsIXoEb+SoxC3H9gNusIZmIw79aDp4+kb8K9JrN5ksKd
	P3y1tkUM9UHFMSbi81X8t7i/QpSm
X-Google-Smtp-Source: AGHT+IHWjzaOWG01LPDx4MI+tD9aKTvS7QR56qmiiRXKIxM2ykamryNxgZMYT+70qb8o2ZjnLz9GX0lD4dWAcMH3wFQ=
X-Received: by 2002:a05:600c:1e8f:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-4792eb47356mr14784675e9.14.1764822608961; Wed, 03 Dec 2025
 20:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Dec 2025 20:29:57 -0800
X-Gm-Features: AWmQ_bmt7_2mn-o4gjsYVxo5Wr_9yJ9a-ekO1X2mOItBNQVmNOahyK6Cy60vuSY
Message-ID: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
Subject: fms-extensions and bpf
To: Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

The kernel is now built with -fms-extensions and it is
using them in various places.
To stop-the-bleed and let selftests/bpf pass
I applied the short term fix:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=835a50753579aa8368a08fca307e638723207768

Long term I think we can try to teach bpftool
to emit __diag_push("-fms-extensions"..)
at the top of vmlinux.h.
Not sure whether it's working though.

Also,
Quentin,
pls think of a way to silence warns during bpftool build,
which is now noisy due to:
In file included from skeleton/pid_iter.bpf.c:3:
.../tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h:64057:3:
warning: declaration does not declare anything
[-Wmissing-declarations]
 64057 |                 struct ns_tree;
       |                 ^~~~~~~~~~~~~~

