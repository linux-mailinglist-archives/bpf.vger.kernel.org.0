Return-Path: <bpf+bounces-42817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AEB9AB72A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21861284B15
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA81CB50C;
	Tue, 22 Oct 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDUG5Y5t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECF17C98;
	Tue, 22 Oct 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626680; cv=none; b=j+jixG7lEi1TFRORpkpGIMQaHmaOWPRQ3jkMqhfbWJJn+V5n5fHbXofBew9g47U25h4EadqawNcEMWfRzHoOwRIrFiP43lPgeqn2SJsjhQNqZJ7jMCrVutsfiOnoaIXoGWw98X8FFhLRzz+qCYSzahKrNrDcvgZhUA6eDgd4Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626680; c=relaxed/simple;
	bh=J61HcGAiaHQ5PwTY0umit5XCMScRBNaBwE0VCLn+GJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1EAAn9aXk7aikbmF8vkWIyu/mSk/BSi2GNvEHjP/+Ll58UWNH5HPa3P5mZ0xXLi3MFb8pwslzirY2hFdDtRM+uZwS5lqOuPVg/PbI002bS+LxvYGrnM+EAx8HEos1F3RDiwiM/4Zjmz42PWEfiykYg7JzinGoMWeBiHJmyK5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDUG5Y5t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso60547415e9.0;
        Tue, 22 Oct 2024 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729626677; x=1730231477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J61HcGAiaHQ5PwTY0umit5XCMScRBNaBwE0VCLn+GJg=;
        b=nDUG5Y5t5c9F1ck3lC4hp6wna0nS2tUFE6gc+E4lmtyix8XZrEkVMb1+o/t814R7QT
         BpEVCJA+qcv6tP8/t05Lyi5+wUKr4nbXXw507yOsAef7+p2paqWU2jtK9/0C3wVjRamn
         f/OjP5g6cRSb4ZDZXXM69fYpC5hGX4fvaIRmdJcM4K8Azic2J1a1VfK2Jq/jKMGfAzYi
         FbI6AT/2LLcs2wiFHPZxovuDXmD8hZHOKmVwoxBVioDNkOMGPBb4gtmA6oWXvupjqaV4
         QsdyL7S5GimrvdNz3RXreHAFq70gebt4tFJHxOJc4lsGMw9LrjOIsW1ryJcxM06maNE4
         6XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626677; x=1730231477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J61HcGAiaHQ5PwTY0umit5XCMScRBNaBwE0VCLn+GJg=;
        b=wfbr6xCD7YQlDKRYVW8Qx+QXH585GjW1eV1Sua4dhKdKA3wK2NFj9+8EkGulVQC1fw
         oHXemAfarxf2+dQBCE9r0IJDsNYBh2iRrJrcdoStN6CGoRu5+G15KIi06qB+ecafKVND
         kB+Nhv5f/U/dA66H+a5Z/zRjjueN9f1k4NfYnCy35OLSd1aHJdY6ZfuFZu0J0LKWRJTU
         AQZbhn8PJ2RQYBf2CuqMviIJTzZAKgUSmpC41ITdDo8dl/ryMH4J0B5M/h+mkzDbV7V/
         HmEoEjSx0FXMNlbiwB/mlvARZTeqTPo+OW6BEftaiarS6Y/hktLx0B4ZHnHmsaQ2Eufu
         FG9w==
X-Forwarded-Encrypted: i=1; AJvYcCW7Q8Sr1ysXzgxbpQtj8F6HhyMcsmV/A3vE3G+cEw4KfqfFgna0hKIozOvGSItkucLcaFo=@vger.kernel.org, AJvYcCXtIVw4cjtYO2A8Md2AZc0KGd91ObBnhaM5/YXDGkATXuHbX9J6ljW6Depqzyt5KWoDnZK9qZXvacEukaTH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KwLjS99AxQkoNVa5QOZIymX3zsAiuy3NfK66gXviwRkxTCKi
	cTk6pIcDk7oeu+csrlbpjIbJQaXliVcHkcWXfF92KNewb86Lfi+4ixCScPCvOJRYPBGM3Gzbmz+
	8SmbF2zkKl1x8zrlaDcd6au5yhnw=
X-Google-Smtp-Source: AGHT+IFm3FrEhSQLGGEHA1D0sY+49Rq3M/57uz82t+3PomkQl+NJ8UENwv/Sxzv4Yu8RtcR11DLGX1x6K8Ibi9Ze7Fk=
X-Received: by 2002:a05:600c:3489:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-43184198c60mr2097905e9.27.1729626677093; Tue, 22 Oct 2024
 12:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
In-Reply-To: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 12:51:05 -0700
Message-ID: <CAADnVQ+Ow2E8qghEZw6x63VS4gM5rDtbM9R-ob00Rha2yBvfgA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:49=E2=80=AFPM Byeonguk Jeong <jungbu2855@gmail.co=
m> wrote:
>
> trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> full paths from the root to leaves. For example, consider a trie with
> max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> .prefixlen =3D 8 make 9 nodes be written on the node stack with size 8.

Hmm. It sounds possible, but pls demonstrate it with a selftest.
With the amount of fuzzing I'm surprised it was not discovered earlier.

pw-bot: cr

