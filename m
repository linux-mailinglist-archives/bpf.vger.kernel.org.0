Return-Path: <bpf+bounces-19974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C6835755
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D71E1C20C48
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57C3839F;
	Sun, 21 Jan 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pb7k3Ur8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC03838D
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865272; cv=none; b=I/H4LbBVrV42wR2tm7Mbvalo7RV39kj3ThZoUtvZQWRH0YtnyXVqaLaZGuE2sjkyZq6I1qIEvzRtdTK75IGC9x8wuJhWuKdUDL/FqaluwrxV6MkBFNGYDLrgi5aGvt1Qu8qcNVRH/QXNmbTWv0MxkGaBsz6TFhyiHnWzFCNKA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865272; c=relaxed/simple;
	bh=2FpoKLKzqH8UC9hSwhA9E7HCkyq8gOsBF8dHu25KccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJkKcmTmUK4/PDGRZgBfR5KCg/vd74aGsiZaVgTInWywSk11lfoDDDNPM6uKccGo0RzJjAFdmSjf387NoRTMs/nRS42ufpIBZcRxJXdh12J7maqHKSau80h5d7Y5w3HX6zvZ1aoFVFGW7FK4AH3z8lbLZSqCuu8hzX27aqnkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pb7k3Ur8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so2390566a12.0
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 11:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705865269; x=1706470069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=Pb7k3Ur8ELXjk8kws/DCquJ0aRwO1f6XiTIz2OawJIrZSJKZ8QJUztXvAfbIVjJ2lq
         d5UAcRcg4PH9UA9zBADHkHbrMhmFv+ciSigR8Yjri7idzif7p0GC++6AbvVWnJKoJZqP
         zgFSJapFb8dYx71PTI53DVJO3kkMUL+l6ax+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865269; x=1706470069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ilsHoBAFLGrxDRmI028SujMWUyj+V2X5SyCrYhyT90=;
        b=n6f9rKc9tsuBMgBUrqiho0mB0+2o2a4/9rOQcGh8aB5IJPT7AjKisI0Ya8lY0tqHy7
         ZdGJ6fei7jj8Qtg5HVcUIKZMsqpAypV6jrIDCyJ88l4garcqIO7fRTbrkISm8SJ+8wKT
         g720jOFoqgPpN+mWdqpV/E18NWlnvjaeoTikYRuzz92qQ045dnQRxaytc2zXeSjsO42Y
         bKy8L3auztcnQ/ScKNfxfkAuh816KDZbe9O1EKFOdDxO+qoSuo304VwidkCUYGyIDGov
         xW2y8tPENGp9GS/NeHOQo5TPU3loamotiDF5j8/2HcoXgIXv+8zxCLi89is6rgtGA1S7
         vi0Q==
X-Gm-Message-State: AOJu0YwOSW7uSUcYoWhI4JnTOjPQMckFQhwzhUjGRZ2PbV0eJ/FcLUVZ
	ju1D0OHS+Q7inob5YK04uVxes44Mjhf6Jyk0kaen2f1wR9my8z/6V6QBe8gammwcFPI2VWNKXLo
	9vB3f3g==
X-Google-Smtp-Source: AGHT+IH8qxFW0QVkmzR3bE6rksvPvRbtBFn7vOZpuI7m4pCoHBgmQBdoGTpQFeGcYaAcOoZAO9ydxA==
X-Received: by 2002:aa7:d14c:0:b0:55b:8fed:edc0 with SMTP id r12-20020aa7d14c000000b0055b8fededc0mr714643edo.105.1705865268838;
        Sun, 21 Jan 2024 11:27:48 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm8139047edw.95.2024.01.21.11.27.47
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:27:47 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1076875a12.3
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 11:27:47 -0800 (PST)
X-Received: by 2002:a05:6402:26d3:b0:55c:29c1:4186 with SMTP id
 x19-20020a05640226d300b0055c29c14186mr493069edd.26.1705865267510; Sun, 21 Jan
 2024 11:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119050000.3362312-1-andrii@kernel.org>
In-Reply-To: <20240119050000.3362312-1-andrii@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:27:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Message-ID: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF token for v6.8
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 21:00, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> This time I'm sending them as a dedicated PR. Please let me know if you are OK
> pull them directly now, or whether I should target it for the next merge
> window. If the latter is decided, would it be OK to land these patches into
> bpf-next tree and then include them in a usual bpf-next PR batch?

So I was keeping this pending while I dealt with all the other pulls
(and dealt with the weather-related fallout here too, of course).

I've now looked through this again, and I'm ok with it, but notice
that it has been rebased in the last couple of days, which doesn't
make me all that happy doing a last-minute pull in this merge window.

End result: I think this might as well go through the bpf-next tree
and come next merge window through the usual channels.

I think Christian's concerns were sorted out too, but in case I'm
mistaken, just holler.

                  Linus

