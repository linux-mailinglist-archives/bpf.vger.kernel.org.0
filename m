Return-Path: <bpf+bounces-67454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28CB44166
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134CF163075
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927E2820D7;
	Thu,  4 Sep 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncHkXC9B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBD27D770
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001413; cv=none; b=g0GVyATQOQT4PuXDpyHKAU5r58raLPmRLZPpgLGuBQliEPGpcXODGPZ2MV3LYmPXLY9tXeT4+4dkunPkc2nVaoCsLLZLZeCLWm+7b/hg8i+2gIc/y93/Zh46OY4Bwiu/Cug+jm2IwTUs5PJeAp/P1rv0ztx86PsFIceVgpQ0GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001413; c=relaxed/simple;
	bh=2IXYBx8Ql8HoKUBW0rrnc1PltzqOrMd5kYA7R0XjsXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zaou4cK9vhe6wNhEH4kiKSuQVwo12wdtxPtcMWUqKSUccLqmdh9GM6oHvSQYNtT3I9sKGksr/R33hBaqZahO4226nk4xYl5Jy7/pvYXsvUZTAmp64j0YvpPkDY3p1lBKTCaXqIwaF1OHTdA/+m0/TetkVUP3cDIdekLqxMm0wDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncHkXC9B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b1a104cso11707635e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757001410; x=1757606210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dsdKSPmuzfpLIW/4kXkMvmDhIbAIRiogKf8zFStQTg=;
        b=ncHkXC9BjfJ+K5mdkw0NTiQgNumj0UqOknn80jwI5AudWwBDgjuaheFOIFq9mkDRoY
         w6wQ2k5zYCTiMUMo6m+qQA70GJnL3UOEs802Yej0vKTLtQ1oc01QxU0nQFCGDil8h03f
         6NakvQhaF51UcfOVJ7EkMQMdQynP0A7PLAqqQyxjj458pnV1sE5RJResQskK1qFa4xMS
         Qk0Ar4U3tSjNfUMVBGRX1b6mcrWgBHBx1GSlR0sE8D1Llusycq87HLxUQCMK01nFf837
         4etkD2vZQp2V4T8MBqUEiqFOJboHhUNJZtpnBiNkapdXC8LSOBmtXIihgU1icW1v7kGz
         bt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001410; x=1757606210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dsdKSPmuzfpLIW/4kXkMvmDhIbAIRiogKf8zFStQTg=;
        b=X8zs/rMXxltJBIVQ3Klmedz9+EMBB9JowJSbX8mnav5Bb80B5mCd+TXkuSnay443Bd
         RYT6DzbJXj8yVwTjmWpKoCXqz3Nkr09ySSTQ4zoBzDS0uF/TUAdgUbBPepnHctmBlbMg
         EFTcrRqPWU+3gNDfv+yMAy6vfppi+jAe7pYE46w2NC9P5u+FmG2pysy28rPodS6kSrZn
         ldKhfe+SLHsu3Os/geEfvNP9HW/gyMaz3NJSFzehEPWuf36U4JF+cUvyxzqCL7pcnUnZ
         jfhEtjvr2K6cW95yZreV+5msVTmAiiokPjj7WkXgzJtkBKj9uTy8d90LJaF1PP+1gY4l
         Q9mQ==
X-Gm-Message-State: AOJu0YxQ8B5hM2PU0R1nlNX45G8Uj42gD6WqC2p0uPdQie7nJfWlBfuq
	WTYIo7oRdrKGDOgN0E8mVxd5JjS0Ma8L06nr51BxkYbcIsVEc1I0PjGG6qMz5dWupAoYJ161uRz
	V9Vggm5uVLZnHOrBIitd9rOQIXE3uU4Vg4Q==
X-Gm-Gg: ASbGncuC0oynrgFg7X/BKLUiLyDtKqJqVDCTlUOd5iPrxWyRzL0LxqVWCCXxpT/K8A0
	P4BYOVU2+eUq2Fwq1447RBwJw3jNVRjJsKSDHUIp4FFtGpqGuvTOpG2YgrZ+8b8dmHr/NB+ssE7
	B9xHCJ49dW9OufOpVi0Tc/3231sDGuwiUCPGS3lTtZg/Fcnv6x5PQjOyG2fZ/Hu6lJkY/YpxZL8
	ZcR8C+vFyFI9QxRMRzg74IwQfm3v6Hl8Q==
X-Google-Smtp-Source: AGHT+IFkyouRebp4MF2sMsMSvYzV/QCgiRXL/pBtemXzYNEGA4AHZMNfixc/BEnmA3akb3CGhQoeFBqkIIVh4EZDZhI=
X-Received: by 2002:a05:600c:3545:b0:45b:7a93:f108 with SMTP id
 5b1f17b1804b1-45b855261f1mr172076025e9.3.1757001409476; Thu, 04 Sep 2025
 08:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756983951.git.paul.chaignon@gmail.com> <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
In-Reply-To: <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Sep 2025 08:56:36 -0700
X-Gm-Features: Ac12FXwh3C7L5nap1a0jE9OpYN-I6XQv_wPc1iPBwbmkjfa6vity31aOM_YfaqQ
Message-ID: <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:11=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> This patch adds support for crafting non-linear skbs in BPF test runs
> for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
> flag is set, only the L2 header is pulled in the linear area.

...

> +               /* eth_type_trans expects the Ethernet header in the line=
ar area. */
> +               __pskb_pull_tail(skb, ETH_HLEN);

Looks useful, but only L2 ? Is it realistic ?
I don't recall any driver that would do L2 only.
Is L2 only enough to cover all corner cases in your progs ?
Should the linear size be a configurable parameter for prog_run() ?

