Return-Path: <bpf+bounces-60043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920BAD1C87
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A777A525A
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD432528F7;
	Mon,  9 Jun 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEcpHUL3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176B155A25
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469255; cv=none; b=eBa4Kan+0u6Qd+D7JeJKPgl0beZXRwKeVe5qC4H6di+PxfxZGHu0qUWzmo1XpPOV03/nG6nVk3hATQZkB4mMwtUGZu4xaR12WuTSUKX1Md2G3Wj6eV3nlMMfB5XSTFkIEL+w4WCDxZbivl8wqpqQfcPMDPyRhEuHJmQcYejtekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469255; c=relaxed/simple;
	bh=+Us5U9e/keSd7l0/S158gF6nWBwGdDZtkEDuENFAowE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEoZRC7Qkhd3+kwliVqGHxdKnPPs2Eg9+rMOeMT5wdrkkqqYS9Mtjz4eu7aVloDKFhGjP3C+lfC6jUtnI3NFEaz21viQJKmWFw6jDWAYzM4rHp7jts13hDpXFhrwbrwIwAi2a9awJU0HiyIY4UqcR4ADz7L3q6HO9cEAnYwIxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEcpHUL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C06C4CEEB
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749469255;
	bh=+Us5U9e/keSd7l0/S158gF6nWBwGdDZtkEDuENFAowE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XEcpHUL3R8wMP2B65LiSXC9IEF4spSAoMJStgbuckBT+XsyBrv7MMzEIVKY8tCqG/
	 1i64e0GIFyNfXuIID1feSeeQCDeYGxycffLptipYfKHdYN3m4qXhJ91sHp2dnmMWc3
	 uSn5ALGVYh+XU08TkDuEoV6qFSFf8na9TozAzu6yVLRtsfXgdeJWBlAqUCVifk09XU
	 jlNpL73EuH/27WCh4c3zC/eoY3IhpMj9WfMg+P17KGh6qOpVGIvSLfDuK7v3828E+3
	 AbyzmllJS3sXot0qDumkP6jNQPxL7sm53Bq3qnzC4ilYDotG36iiOHpB/tf7DLqVeM
	 QRLLIx4sAtOvw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so7824267a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 04:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YzuQgT9LvbxfYxiokH3w1XD/mesDvd55jAXf6lrAxd73GOl++Qe
	NxQXKU5yqVia5gdywGQ1DyOc+Trg6qPqY8XNlNRrr3BVeJH7MaF6p5WFuEfjmcP0f2vJYkN7Gyv
	+iGJ25PIDMEtzwHLe/Ac7MfAjcJsh/IqPcUBVhHnW
X-Google-Smtp-Source: AGHT+IFDI5HAGE1p/SWQTdIwxbnw50X0hs//Qob0D0rC/sKD8bswvKUiScasAR8WYB0L+Z8LEcRuACErIf/3Ev+c+Wk=
X-Received: by 2002:a05:6402:5cd:b0:601:dc49:a99f with SMTP id
 4fb4d7f45d1cf-60773ecd6a6mr11940409a12.18.1749469253826; Mon, 09 Jun 2025
 04:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <87h60ppbqj.fsf@toke.dk>
In-Reply-To: <87h60ppbqj.fsf@toke.dk>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 9 Jun 2025 13:40:42 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
X-Gm-Features: AX0GCFuhmYJJT525bfgNAS7sKZvEtW9WT0x6n7MH7EcY3V_PtJgF6CzMa1dxJ3w
Message-ID: <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Signed BPF programs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
>
> > Given that many use-cases (e.g. Cilium) generate trusted BPF programs,
> > trusted loaders are an inevitability and a requirement for signing supp=
ort, a
> > entrusting loader programs will be a fundamental requirement for an sec=
urity
> > policy.
>
> So I've been following this discussion a bit on the sidelines, and have
> a question related to this:
>
> From your description a loader would have embedded hashes for a concrete
> BPF program, which doesn't really work for dynamically generated
> programs. So how would a "trusted loader" work for dynamically generated
> programs?

The trusted loader for dynamically generated programs would be the
binary that loads the BPF program. So a security policy will need to
allow certain trusted binaries (signed with a different key) to load
unsigned BPF programs for cilium.

For a stronger policy, the generators can use a derived key and
identity (e.g from the Kubernetes / machine / TLS certificate) and
then sign their programs using this certificate. The LSM policy then
allows verification with a trusted build key and for certain binaries,
with the delegated credentials.

>
> -Toke

