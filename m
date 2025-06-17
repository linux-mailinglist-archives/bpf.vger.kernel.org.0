Return-Path: <bpf+bounces-60841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D8ADDCA1
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AD189A41E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68F156678;
	Tue, 17 Jun 2025 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="gc7sbHgy"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1442A99;
	Tue, 17 Jun 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189575; cv=none; b=pnRousf0yLy2r09NVqGzhmKdp1r5fOZBTlBKkRNhbFfQjjTjpLAeWUP/Hb07YNrLXEFLlWnqRsQ7+Dc0gh81gbkJPzo+QpxGF+SONBwJ32gPLe4WjObpFIFoxmow2RA+3LYFEyhSmo6VDUoNM5cIxAhfpftZL8jm7d2rUMj1uUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189575; c=relaxed/simple;
	bh=i9VT9MU1eV1jZusVXBnUaKR1q6jUkGire7MftlUt0tM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTPSyQ73FhUvTdZi9HyEfrsrC1v/k9ZJs8xz1SziVIMrWh6o9hM6w4mLqxJTRtBEUREK5GCgnduiD5pY/Fo5lr3xEwwcMGDz5YlVvveI9kQ58QGpgJbxtddUibS8STLYBCHqseKagL/VzNpZYCbyVzMWfQAuMliFZJhSHJH89+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=gc7sbHgy; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750189564; bh=bmjUaNu902W4Vnz0nSIWioF+mc9zxOtXqhelb4K0/uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=gc7sbHgyLiegGVmE2Zn1Wn3DldzVxvLMeWsT9J0xbJnddnJfYwDFAEO1oEXPi8xi3
	 suCiaT6WGnv/iS2HDxdUa1O6PPWTrb52RnuRvCd+PK1R1LwOXQQWi7LRPpkQ6b9Fd4
	 04+OjFnUpM144evsVpDnbpaTghp6drwKoniJ3H19jhdnzi1o9JQR4ywRrLZAN0aDzH
	 evzUuExysaIbiJLhkTpT4Ja1pLI1CUEtaPaA6OLdpRM35WG8nKErEzeyolQNO4fpYI
	 3P9/fJ/Z3miC6Yt0+XQrpTIiAvAEdXD6LiWqvMeN1TOtwuO/hd2TiIGXl3geF+8zYk
	 qobG9U6X24MsA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bMHRc3qMgzPk6c;
	Tue, 17 Jun 2025 21:46:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3605:d600:62fb:a084:d4d8:4e7e
Received: from localhost (unknown [IPv6:2001:9e8:3605:d600:62fb:a084:d4d8:4e7e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+C3RkGdAmEaAKGq86i/+jmt+HKq4VH57I=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bMHRY3SzPzPjjf;
	Tue, 17 Jun 2025 21:46:01 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Hengqi Chen
 <hengqi.chen@gmail.com>,  bpf@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] LoongArch, bpf: Set bpf_jit_bypass_spec_v1/v4()
In-Reply-To: <20250617063206.24733-1-yangtiezhu@loongson.cn> (Tiezhu Yang's
	message of "Tue, 17 Jun 2025 14:32:06 +0800")
References: <20250617063206.24733-1-yangtiezhu@loongson.cn>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Tue, 17 Jun 2025 21:46:00 +0200
Message-ID: <87a5665eyv.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier
> to skip analysis/patching for the respective vulnerability, it is
> safe to set both bpf_jit_bypass_spec_v1/v4(), because there is no
> speculation barrier instruction for LoongArch.

Thank you for addressing this.

Do you think it would be possible to give a more detailed reason for why
Spectre v1/v4 do not affect LoongArch?

Which exploits were tried (and failed) in [3]?

At least from [1] it appears as if there is branch prediction (Figure 5.
LA464 structure, Page 52) and thus also the potential for Spectre v1 (if
there is no hardware countermeasure). For Spectre v4, [1] states
"Supports access optimization techniques such as Non-blocking access and
Load-Speculation" (Chapter 8. LA464 Processor Core). Based on that I
would assume v4 mitigation might also be required.

If there is no countermeasure (and no dedicated speculation barrier), it
would probably be best to lower BPF_NOSPEC to ibar+dbar (leaving
bpf_jit_bypass_spec_v1/v4=false) which might be good enough to make
exploits much harder/impossible.

[1] https://loongson.github.io/LoongArch-Documentation/Loongson-3A5000-usermanual-EN.pdf

> Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>

Just to clarify, I only suggested it assuming that LoongArch CPUs are
not vulnerable (which I only assumed because of [2]).

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6f6a95f2580

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4aa3e..5de8f4c44700 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1359,3 +1359,13 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_bypass_spec_v1(void)
> +{
> +	return true;
> +}
> +
> +bool bpf_jit_bypass_spec_v4(void)
> +{
> +	return true;
> +}

Looks as expected besides the unclarity regarding the countermeasure. In
any case having these set to false (default) does not help if BPF_NOSPEC
is not implemented, thus this is an improvement.

Except for the stated reason:

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>

