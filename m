Return-Path: <bpf+bounces-49147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3FDA14763
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125A5188E9F3
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB065AD39;
	Fri, 17 Jan 2025 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrFMH1GI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5625A640
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076156; cv=none; b=aIPmBdv00u3dggbfd5UHSibzefYiBwGGxHvj4YI11rLj1nthnwBS8Unn/exn5Va+w0HjM9SXUdOdcreqWyw7WL4TVZULK1CnXQy0QH+4kAKooJOpSPotQ/a9ByAZnWdStFsGcr5C4E4gsMrrswDGPTrDque+CBo537c/mO2fZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076156; c=relaxed/simple;
	bh=Hv3+FDuyrNU/VRjnt4Gw4LwZ1/9jUlnpuPvpYvuNTeE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jPyYuJ1hs0XpdJsAByKd1WGKpoJgO8NalNZZXbpAuePRY/q4yMFh4NAf7sBh8tvv+PjjJInN30J2XpZCMd3HrQHWumAWolNem8hWqjE0F9WI8uj8ugvcd9KWDz0pgSYpmIhjWPGewkwTMXOr7dYPI8QFhCBPP/n/pg25YaPB8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrFMH1GI; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8622c3be2f4so362666241.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737076154; x=1737680954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hv3+FDuyrNU/VRjnt4Gw4LwZ1/9jUlnpuPvpYvuNTeE=;
        b=ZrFMH1GIDcYRb3hinxbC5rS6uGGlD7HQs6lEHSnngDFDVrInOYqn298dxcDNb7Zthe
         woNyewWblbz7HR8aBbscY4CnRjZrXnMWy5ljppgGNVCJbeU3H3Mfe3O+D081XscHCH1A
         JZFY1Yk+SLPnwQm1YhioF4wcTae9H5H/dly96BPU603+LAz4jJmuzLfklMsz0O0KpM1S
         RF8D+7rCVN+UgnCBAlWKHbntUx6z4DG2s3/iCsRCbtByYy73EsXDOKG5HBM0Ce8vReKU
         Xp1q+EpJuUWRFQ7fVzkmaI5hu8EjLc3iYnfsEkYLTQy5XoVhlZ4VbFQR3pJM2/0K5dvg
         odQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737076154; x=1737680954;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hv3+FDuyrNU/VRjnt4Gw4LwZ1/9jUlnpuPvpYvuNTeE=;
        b=piFydh9KgmCVGFcQhtBKsBdlVTzhdECy9MhAcFbKo2iC3Bs+vyT5RtdFLKYGnKrg5N
         gZ4USaccGZJ/V1Q+/wLaxlBDSh5zFQX3byz+IafT1gggLbLlUXOnSlioL+UsuUlR+uFG
         SWyj5rNZUBhxdtW8q8E4mzrWW3lvGet4N7lrnkKhlNYpiPCQq2Eo2SyBa8QUSp285wvb
         9ApLLg7fb0tS//VXpIwHawAM6FREHrJmLTkQN1B/knoQ8cUgEkAyu0oekxeZxMUINfdj
         6QPhABkrGUxI3YySymMFaE48Lnv6fen/WSK8xRQOsdxZj91M9ZrKwgq5Ai40Pk12QAV/
         GEpQ==
X-Gm-Message-State: AOJu0YxXLeEo2YvjO83/G6BagfQ5Yhe3QqFWHK+sMFyGZXaDhTOlAkO0
	bY3mpJZlFDC95CKam0el6zvtB9ChZ6gxqDJZvwk7Rulnz36YPR561wVlynqJvEfzPRezi08MYwC
	zl9/2tmhI9t8kcRbKIa90rCxeWqQ=
X-Gm-Gg: ASbGncu5YZ7rvm6e80cxWb5WGlgik4Hybxv1dmqta4EIBNna5nj7N/XmvJNa+etErBQ
	ADYYaY6ZPZZypsVxMRk6TI3Z4pWbPegh5ybrtgo1nPXS5nup6dwj1ilWYnJNByfHMpiBzuWk=
X-Google-Smtp-Source: AGHT+IHoCIIwmhzrSNpDiGTKJZCFFuHs5Kwy6zRyKQH+eQq9OowQ7ItZuECwijG7/Dsq7TRlYHKlB+NvY1pl9RXL91c=
X-Received: by 2002:a05:6102:38c6:b0:4b2:9eeb:518f with SMTP id
 ada2fe7eead31-4b690bb8dcfmr640391137.10.1737076152196; Thu, 16 Jan 2025
 17:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 16 Jan 2025 17:09:01 -0800
X-Gm-Features: AbW1kvbZh9filFSZQL8LJaQeRLSV_59RUWgoAN8IPLpIlKrsKXLKCK5EE0jtvGY
Message-ID: <CAM_iQpUmeRHjpLfM2QCc=8S_X9saTHX8sZpm5rxFZiY7rb_xFA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Optimizing Skmsg Performance
To: lsf-pc@lists.linux-foundation.org
Cc: bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Zijian Zhang <zijianzhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

eBPF sockmap extensively employs skmsg for its datapath. Although it
is much simpler than the traditional skbuff, it is not as
sophisticated either. As a result, there are numerous optimizations
lacking on the skmsg datapath.

For example, the TCP_BPF ingress redirection path currently lacks the
message corking mechanism that is extensively utilized in the standard
TCP/IP transmission path. This causes the sender to wake up the
receiver for every message, even when the messages are small, leading
to lower throughput compared to regular TCP in certain scenarios.

We propose an optimization by introducing a kernel-worker-based
intermediate layer to provide automatic message corking for TCP_BPF.
Although this incurs a minor latency overhead, it significantly
enhances the overall throughput by reducing unnecessary wake-ups and
minimizing the socket lock contention. Our results indicate that,
compared with vanilla TCP_BPF, the throughput is improved by 5% to
160% depending on the message size, with a negligible latency
sacrifice of approximately 2% on average (still much better than
loopback TCP). In the future, we aim to explore the possibility of
eliminating the socket lock from this code path entirely.

Another performance bottleneck lies in data copying resulting from the
conversion of skbuff and skmsg on the socket transmission path.
Essentially, the ->sendmsg() callback is not suitable for directly
transmitting skbuff. We propose a new socket callback that can enqueue
skbuff directly, which could eliminate this unnecessary data copying.

BTW: Zijian's work is available for review on github
https://github.com/Sm0ckingBird/linux/commits/tcp_bpf/ , we are just
waiting for bpf-next to merge with bpf to submit it.

Thanks!

