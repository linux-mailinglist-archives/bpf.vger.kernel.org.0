Return-Path: <bpf+bounces-58958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3FCAC457B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 01:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773A21896E9E
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AED1DED56;
	Mon, 26 May 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guHnF2Sv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E60145B25
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748301333; cv=none; b=C2TvQeh+qpbdJmw6mbDftLXnixwtvv/ujSwAHYZs/QTLl01rvDIbogmVBAe26vRMnGxFdMD51Zzg0VbSAz0C0tRPGIk+AWne8TlnUotx7vz8+g1+5LuALin638l8/bFANXIrU8KOnYKjC4VFq9/2QSJHljA2OBYKyw2tH90w4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748301333; c=relaxed/simple;
	bh=Y162w1MGwhDHyYNyeccEkyd7fMNRwCdlD+6EOfwIvMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AMpADSGkkOfoeRVJAE4LoqodXc+EUyZPY6ZjzJessM/WdnTYmp74EZPbbWVOoYjKQMiwfxKmM2jsPmA/tVhQNeiw7nH9fcmbReAodZtt1lOA2kPeSgfL3jBR4hzx1Ce2ybVdrvva4J8vKsR3U5thbmInuxhWYnk4LCfVTPu/4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guHnF2Sv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774d68c670so43066471cf.0
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748301330; x=1748906130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UYmFr2bSSgFHafmgf2CtIl1EnivO1mpRbuCWmmasjLw=;
        b=guHnF2Svxxaq6w2e2A+YGdH7Evc9WE8WXcFX8JwtbwpPO5Op/caLa3o0Rh5LIDzr83
         IHlH/UHaVT8ei5HhaPELLwmwZOEFhwdLFDUDfpHyAYLv4MUaxX52Xko9FvhTRoXkirVZ
         cXGXfrolm51+GoFNzBUYnZyE76IL2j5fudQ8kEAyE0RSyKd6mwiho0eewTpdRTxSr9tl
         Y46obu4pW1RrqdpYvLO5DEN9IAd37q4u3g+7c3DxFbQVOS8iwHdGXfUYwHTiqUqcvdze
         GuQalrN4ivCxhGs0zn8EzU7j0AAuDErt2b2A027GA+1FTpOPqz/e2Z5+hMy2e/rW2y0l
         9a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748301330; x=1748906130;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYmFr2bSSgFHafmgf2CtIl1EnivO1mpRbuCWmmasjLw=;
        b=lh1x5vlsRr1fQWjPoWP1JqNSAzWZddeVDtX3ktTKku0zSryOdKxao8Hls9S8TVWDH0
         vgsoX/A6zy5xQtj0qDO5BRL4dTtRGOl1OHfXoGekPAMj6EjBONIXK+nRAZ6Fzuv6Ynlx
         NmfFs/ZpxMWXzARKrPsOhh0ujpWrDMR+WVyCV97KIUsixcsPJ3n2SOvdnwlZQk2pqpWg
         GmFfmwLZueiafAwdJDCby8IgLgBFOcxpAjpaYRr3qDlvOUBa04IkA8XifqDWNnRAGtxN
         uCiSo/fTjfsF3TyziBqTQWt8NkhZeZ020vV+TgQuErsMR+aQlPTMzilfawiwCr7YrAiF
         LGyw==
X-Gm-Message-State: AOJu0YyEVVtotdL5NyA3v3ZPIuskbmxNMlphs77rb9Z8GBx/UipcZN/G
	I6gcKnnV0zSj8JmAgvcJEXDVf7ufBCY2AtrwWRUE5DlvxT/WM0JFAjP0Cn9R6EoNlKFQ+GYtjmm
	GJJ6p/UZ+4iGnbsyd06OrdM9CXzN2jlQSVvFU
X-Gm-Gg: ASbGnct5qyg29UnI1ot2rOeN0h/RMelyveRt12tQyK6v77kJnzx3SxRAeEg/YZZPVrL
	khtgCfKIgW6ph7adNVu+KhW7timEDgOf8mPxpo1eAJqfAuaaKO1RGA7DwitSPM9DNSeDSI91X+i
	kVaiDg0gahVa4bqRLdnCDKkJerzbNM9vltqELy86s5L9sBSPYK2/aeaqUgrJWU8FzH
X-Google-Smtp-Source: AGHT+IGDw7ATL1wdoJzYEHZKw2cHhLyXpsDGwAKODCnR8jP1Qx45FeThlAOjEgY/BCGhKyVvuGFSEjhBXVR31Uya/Oo=
X-Received: by 2002:a05:622a:424f:b0:476:a6bc:a94d with SMTP id
 d75a77b69052e-49f4674dcd6mr219940191cf.19.1748301329856; Mon, 26 May 2025
 16:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 26 May 2025 16:15:19 -0700
X-Gm-Features: AX0GCFvyIZC_9iKiKM5hP6RZUzCsp1CcNMy_usADKC1MEjEh3IKnYgA0DGQEqeg
Message-ID: <CAK3+h2y0Hu_t2JfEOgEA4Asw2Tr-c8=UHeZ+x=7mmrSA3uVJAA@mail.gmail.com>
Subject: [QUESTION]: run test_tcp_custom_syncookie in local host on lo interface
To: bpf <bpf@vger.kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to run test_tcp_custom_syncookie as a standalone tc bpf
syncookie program on lo interface to see if it can protect local host
nginx server running on kernel version 6.15.0-rc5, but it appears the
socket is stuck in TCP_LISTEN state after cookie has been validated
successfully from bpf_printk I added as below for debugging.

bpf_printk("ACK: Socket state after assign: %d\n", skc->state);

if (skc->state != TCP_LISTEN)
goto release;

I have a detailed report here [0], Am I mis-understanding the kernel
feature developed along with the tc tcp customer syncookie? a
validated SYN cookie ACK would create a successful TCP connection with
the use of bpf_sk_assign_tcp_reqsk()?

I also run the same bpf selftest test_tcp_custom_syncookie program in
the kernel, test works as expected and I can see the socket state
change accordingly.

[root@fedora bpf]# ./test_progs -a tcp_custom_syncookie

#420/1   tcp_custom_syncookie/IPv4 TCP:OK
#420/2   tcp_custom_syncookie/IPv6 TCP:OK
#420     tcp_custom_syncookie:OK

Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

[0]: https://github.com/vincentmli/BPFire/issues/85

Thanks in advance!

Vincent

