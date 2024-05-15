Return-Path: <bpf+bounces-29723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306998C5F99
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 06:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622F41C21DA2
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 04:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361338398;
	Wed, 15 May 2024 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KikwvzpG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D738F82
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745988; cv=none; b=INo6DZtltrVGHCCHSVpAEp5lzOq7rEFlIH6IozxabAN9IsSYNTAu4ueJtqjvhVIRLDhMVDqYBvv8lpYmo8dS34cI6bxguTxNHNvnNOlpFSqD6F5/P05bsJTtJLDhYO4bB0wNyZoD8IbjXshaCN2vqWcKbzJR0Ht24egh8ATu7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745988; c=relaxed/simple;
	bh=oDK0dZjxuFm0H+MXlbyx+nVtTUik/dIpxYkVCNyTtUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDhlSqxlU/yFNeFL5dQsO4ZYWaZ7QhC6fH8pd0RpdLIs/6dL2o2q+XTru3L+3Eo9X2yrt8FTplwRte24BhA37sfgrLFQs6rqqykKLeqWH86TyEfTbSFEyqYWQpcv4VZjXTkY0opO8bR09a0rczgqc3N89xReAHaIS/kZGxZ32X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KikwvzpG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so1169849a12.3
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715745984; x=1716350784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=KikwvzpGqJttqA+bdm4+XySSZDkOFMnQ0Ze/nrsLYi+yUpkt8HQBJcSoJmm93mtD/D
         SVaBIVGpLDIM8mS5eod06BYzxMJdXxi+PWvCwlkQfp9KgbFtITipQep69Z+uaSLSWlrc
         uVE0pGyOZoVzzaNeRo3NNeSOWpROY3R7g/CbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715745984; x=1716350784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=NaXhLCCAG5/EKYcMqG12whvuOqVhyBEQ1wQHLM4/+tLrHHBumxaEu7WgwqwMQDBSg3
         xNk2EGd3DD+WqDQx8Y9eFajnQEVus4yXVKpgz+cDKgrlChD5zPjLQr7ESXEkVguTOCkB
         4/IPqfinfGSsaCBafta9TqR5VxrxD3kiq6494zf7IVcM/0XD/TXCrbXpgIdKWSUfghXP
         2xO9qgBW9de0NgXh9Gna4fHwggOpI1WZolWcJ35Jj+Z6KGM04BD31Pr0DK9eOqQd4Pwd
         hMRDKga+g1sq+GMfoNW/IiNyBhyJfggNa+yIomf5y7e5Yx69NT6zQAsg8ILIXLZNSd2a
         4Udw==
X-Forwarded-Encrypted: i=1; AJvYcCXVAlUzL2ZbGIrn16nIWBcLJJ1xWj+XByh5SAwttRfgzoA3HQkk+Q0WLTi++I0zGEJ358McagokM5DcLWsfPy6yIrfs
X-Gm-Message-State: AOJu0Yz/Xn9KNeyzH923MvJTRn4jm+Pn3/gU+dGDAFVw7HUUAEtKXaTL
	vrxO/QvEUsRhMNqgbXVvSb2Jm5p6CRpfUEwe1LcjEtS8XHM4ruDtapBvWqnxhAxh7Y1Z3437RPT
	GXbazKw==
X-Google-Smtp-Source: AGHT+IFQxV+Q8PSNRXK4oc2kmFemFnFVm09aVKB5hRG//Gm5yjqf8RfBgbCK8XjBy5fTGTJALp282w==
X-Received: by 2002:a17:906:7c91:b0:a59:ad47:756f with SMTP id a640c23a62f3a-a5a2d6756e3mr993803666b.74.1715745984561;
        Tue, 14 May 2024 21:06:24 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8a55f2e8sm118664766b.126.2024.05.14.21.06.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:06:23 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599a298990so135975966b.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 21:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjkMcELwiMD6fi8JXHMQlF8nqDlDr2ZrNt3vdNnmXhY+dDS+fJuSvhgNuUU02o3GcvprUiwTq4fvi5BBjI5nwHktmF
X-Received: by 2002:a17:906:7196:b0:a55:5ba7:2889 with SMTP id
 a640c23a62f3a-a5a2d5c9f69mr956803166b.42.1715745983374; Tue, 14 May 2024
 21:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org> <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why does it do that disgusting
>
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>         ...
>                 *insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
>
> thing? As far as I can tell, a bpf map can be embedded in many
> different structures, not just that 'bpf_array' thing.

Bah. It still needs to do that array->elem_size, so it's not just the
spectre-v1 code that needs that 'bpf_array' thing.

And the non-percpu case seems to do all the same contortions, so I
don't know why the new percpu array would show issues.

Oh well. I guess the bpf people will figure it out once they come back
from "partying at LSFMM" as you put it.

           Linus

