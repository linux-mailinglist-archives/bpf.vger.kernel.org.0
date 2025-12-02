Return-Path: <bpf+bounces-75917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA914C9CB09
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD934A3E7
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC42D321B;
	Tue,  2 Dec 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUt3Nuvq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB12C11E3
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701606; cv=none; b=Hv8be+2YylNtKhZdOiL0W0+U6+Ax77GiK0YJCCM28FmE7eAa2p5WDV1EaNH6y139YwfZF5TGTo5IsQ5kCOd2klzbj+ilX3kFD70jyTyFrfLWloDBGx/nZgHs4Neg94lRgiDL0LS7b4VQlURi765OM9NgKY5wwKKOsAu5hHbwpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701606; c=relaxed/simple;
	bh=klZ/TYbTgKXyQAIwvLQ8QbC0XMyWKtGlwpOvl+8b4vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+6Qq4yWOdSasKemwz2sfHLCpxNzLNsPYaI8ik2zcRlQsuXZaOJ/ISnLN3FKvSUqVjdsRpMhZi5SsJGgeTwn6sNVu9165Ko5S38uOa2Yhg2EszyzoIF9ebmg+/elNUFaFyGGnz48ds4Q9hvfXXr/BWzDRzku3vc4VlKUgXMy5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUt3Nuvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B68AC19423
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764701606;
	bh=klZ/TYbTgKXyQAIwvLQ8QbC0XMyWKtGlwpOvl+8b4vU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NUt3NuvqO1vPPyX7679xMd0eOQxWY44sceX6TdSVOGYdJZ9eCSUE86OWq/FzMTSx/
	 x4K0bwKMuKfZrR5h7l0d0pfRWoGIo0JhXEzD5CqG4qyQM5lqPI9AGtqJYZrodqVUfn
	 aSbGvHbIgezsgLetZf6FBAKyHXaCMkWWu0qaTiUoSIdNWsmvTVO4UO0Bp3PHAMRc5z
	 0E0GIu8UkiiScvDAw104OZEiKao8RJw5GZGfibmO59cIGt0xMfWzUmVMjyggO3ykFE
	 axkjK8B+aR2A4l1P5m+d3uivo3RCsTKAy9VWbblVXouZLVBK4iM1OAGTLPMzm2Oygd
	 phGQyqCPxE/IQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b22b1d3e7fso546512385a.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 10:53:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN9oQyfshqrZMljEj6MrTP7y355stcffnQuHzR9qRLvAH8NAEsy39WXgwDja/Rj1Ln+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6LAcOBo1rT6aWXxrnDun5GLLTwgzbHGIaZXeOs36gdIw2pMH
	zWFqSUq5GNX8qwHIxefxhEUiYSj6bV5Njz0zD+Q2Ne+o4aaxhQ5Q4CoBSTz7SWeLF7iYai/8swV
	fVe4/pGRrHc6BGtybp8hZWR/UiBNUiiA=
X-Google-Smtp-Source: AGHT+IGY4T8To5f604xL8cQ4mr0hnepUsUqnZjQNY5OdimWntkcIH2Wn8Fj7bJZejVVn5OozFvzW/Yl/94KAChohK6Y=
X-Received: by 2002:a05:620a:3194:b0:8b2:ea5a:414d with SMTP id
 af79cd13be357-8b5d2f29057mr72147985a.66.1764701605726; Tue, 02 Dec 2025
 10:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764699074.git.jpoimboe@kernel.org> <c2764d2ad229d0bcea21dbb774e2494ca34fc130.1764699074.git.jpoimboe@kernel.org>
In-Reply-To: <c2764d2ad229d0bcea21dbb774e2494ca34fc130.1764699074.git.jpoimboe@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Dec 2025 10:53:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6BqkOqEYUF_4tNPaCNRcsKsFpavPHEA0N25x-4p1mSOg@mail.gmail.com>
X-Gm-Features: AWmQ_bkCMuuEPiH1KggUAM4FXGT1Gaqo6c_kSCsF7sgiRJZZmQviXpAfjEqBT9c
Message-ID: <CAPhsuW6BqkOqEYUF_4tNPaCNRcsKsFpavPHEA0N25x-4p1mSOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add bpf_has_frame_pointer()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, bpf@vger.kernel.org, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Petr Mladek <pmladek@suse.com>, 
	Raja Khan <raja.khan@crowdstrike.com>, Miroslav Benes <mbenes@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:20=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Introduce a bpf_has_frame_pointer() helper that uwninders can call to
> determine whether a given instruction pointer is within the valid frame
> pointer region of a BPF JIT program or trampoline (i.e., after the
> prologue, before the epilogue).
>
> This will enable livepatch (with the ORC unwinder) to reliably unwind
> through BPF JIT frames.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

LGTM!

Acked-by: Song Liu <song@kernel.org>

