Return-Path: <bpf+bounces-55695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A86A84F75
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 00:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B1B9C1C7C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65320AF9B;
	Thu, 10 Apr 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8huhjL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F5EEB1
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322588; cv=none; b=JYPv6m3nRV0ztf1PAylTIJFAyGHlXyCso1cXplJgHXAXXL5s59OfbIwF+9iJQdzbs/mPaSG0Wjxstwk95eEJZ8XUFQtE9wUjTm6Z5JN3IHAgU7Ul+iYsnhBgIy+qj/Rib2rrrTznjY9yizCxufg0XtsbffivpbitLOsy0fPe1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322588; c=relaxed/simple;
	bh=QzXDUMj/I0TBotcEzTfmIqBhyGKaU6oA5yHqZSqh/fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQjLp33QAyE9vYfenudCVcWt4vqM9157X8krybs3lASCo9s2kftOwQo9ZSurHH6A7CGqdFGKLwxI+Nr0HylYPtWuyJIz92gxrwmp8L4FHxvlEtZAITBiuYWcsXMuWlyYeC+RxazWn5kHVUjiqgDE3gz7Y9cwec+5FpbiDNnmecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8huhjL8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-399749152b4so634279f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744322585; x=1744927385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1veiUQeA1tZVO6nh/HvXphFXWbkVbQzDBxXFOuO4/4=;
        b=G8huhjL8Ej3TUhI5lwx1mIOjK2HcGMUp9TWjzBKgwm532q53KQabq7vnUtIasuUGuW
         jdcdaUA1noLMuVxe0FbDTRS3CBkaxSkgqYnrpXuzNcbaAOlJtwEEywifWsoDvq8S7Obw
         HjofyEe6b7CvJKE8yBVEqQIUTHqKHP3P4a+B5eOCu3x8x3oK6uzopUJKE4FkUvZDq+z2
         apJK+jY7nPlXlZXnM1zmH+NjVZWKSKv/neDf4hkXXadqS+nF3AhHI9VYVY+rhlvdvJK4
         VnC56Y6SRvIMGWjJUGHxtT66CiIQIeS4pgQ5YkQzL0u2yasIUKuFT78sX/xVC2ikUAEW
         Qzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322585; x=1744927385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1veiUQeA1tZVO6nh/HvXphFXWbkVbQzDBxXFOuO4/4=;
        b=Rh6gzljjBFpnB2G62Nq2uCV68y9D5kANO+LXQC75XmdUxYNPv/EpNwPDF5j3crSGPW
         yRPVz5rzZGG2hMb5gARbFQWpw42t0MEfcmCRv/dAplpWFnVHCXh2cPPF3EeINjkxmXNA
         bUBy2TTTW8xSCSxr5m8L/j378lkkYLXPjYx2lnsmRAl5r58PmLHmaGNTgghwHCSbi8KB
         AzGcio6LtSIQejtuQRCKmo/rtdusHnFptxn47kN8WlCRqS2ODD9aUsQZamIEHoh5mc4h
         YfURtlmKgqgRQZhoiHNZwNceMOu/Zgujzsko5PCNcVXwAhhLmjTxegOHzzBdvnXErQ/J
         zKAw==
X-Gm-Message-State: AOJu0YwhjFpuLJ1fSTezytZNOukMIUr2stgOnFOSA3cGJIv73vGSvnaK
	n+pWE071HRsFcjHMcsq83GTM/IrbuI2X3ssltnctRH/HX/KkBprtzxCXGiG8fHhUqfSsT7+SLtw
	xX7t+x1dCrBuK4460vT8Evq5YKTA=
X-Gm-Gg: ASbGnct/GF8exUZWomwBOQdxz7Ij+Ien2J9eG1t3TnuIbQqfIioXgER8asBlHvI9qGn
	QCzqGhjZ0t4BRWZni6Uh5f3/hocJYtT4R0B+2fEhV6lf8QFF+VlH+H5eqgUGtKZvG8p23nNU3sJ
	FE9KU1yD+/wPsnwYHNmEdB5a5ilbuzdVQIFsAxIA==
X-Google-Smtp-Source: AGHT+IEtCGnJjnBfyTwiJZbD3zAPoRs6hzzUACmZRi+bHS+EOP8EeO8ItOfuIMDSynM9v8r1gofJd4YVdjZ1fO17m/M=
X-Received: by 2002:a05:6000:2906:b0:399:71d4:a9 with SMTP id
 ffacd0b85a97d-39eaaed5709mr171209f8f.52.1744322584644; Thu, 10 Apr 2025
 15:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410145512.1876745-1-memxor@gmail.com>
In-Reply-To: <20250410145512.1876745-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Apr 2025 15:02:53 -0700
X-Gm-Features: ATxdqUF4bxcYe5gzOnZzP27v1jmMidTznwm-OY9doyaOxUzmrIhl-1pKc6zXa8M
Message-ID: <CAADnVQKUS1DXosTUYF4GE9D_cb94tbRCXED9KOkWt_NDiOZ43w@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Use architecture provided res_smp_cond_load_acquire
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 7:55=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> In v2 of rqspinlock [0], we fixed potential problems with WFE usage in
> arm64 to fallback to a version copied from Ankur's series [1]. This
> logic was moved into arch-specific headers in v3 [2].
>
> However, we missed using the arch-provided res_smp_cond_load_acquire
> in commit ebababcd0372 ("rqspinlock: Hardcode cond_acquire loops for arm6=
4")
> due to a rebasing mistake between v2 and v3 of the rqspinlock series.
> Fix the typo to fallback to the arm64 definition as we did in v2.
>
>   [0]: https://lore.kernel.org/bpf/20250206105435.2159977-18-memxor@gmail=
.com
>   [1]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora=
@oracle.com
>   [2]: https://lore.kernel.org/bpf/20250303152305.3195648-9-memxor@gmail.=
com
>
> Fixes: ebababcd0372 ("rqspinlock: Hardcode cond_acquire loops for arm64")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/arm64/include/asm/rqspinlock.h | 2 +-
>  kernel/bpf/rqspinlock.c             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This one and two other selftest patches were applied.

