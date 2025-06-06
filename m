Return-Path: <bpf+bounces-59962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259FFAD09CE
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AD67A2987
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB123959D;
	Fri,  6 Jun 2025 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XytSYPBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA41F8747;
	Fri,  6 Jun 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749247092; cv=none; b=YdxEc7Ayw7v1l9mGECV9e5smGEGQwZaR32mWelGbSI+5HIYF00AeCH57vl+3i5wYvsOHvK/OQ45UKwjF4tRoYGeoJdu7zX3lVvNuEnF86/ssHcQagu0ouqTj4sTqqRFFd/coimP+l+bIn+8O70l7qXMmqNV30CA4GSjiDMrr4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749247092; c=relaxed/simple;
	bh=mg6vomSs4cG9T8Gu5x6mxE9Hwtknv0zyzby6DsBiXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD/kwL+A5Tp9zFLmi6lDemeQuJe2Sk1UqevWeJKF7MQ9WsRs5Zi9CvZghVEn3kEAQcTFosViU2mgOp23zyQ8z3hi2ZkV9FaQ5fmozsJQXY4yNAxPV8J5gBAN1hk4OnQN2mNNy+nwkEc3IGZnybb3mUv5AGPsDCXGH88hMeJsazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XytSYPBo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a35c894313so2151248f8f.2;
        Fri, 06 Jun 2025 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749247089; x=1749851889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fj/xdWe/wKkeAoDR0xgMDBcUyEWecYqUtM2x0l0j5kg=;
        b=XytSYPBoQNkQ4B2OHUTCRqpWUoWNhS20+Uk5iTs3e+uJDAyc1Vs8pvXbo/+B6kwWQt
         Tx/CLumPSXDac0cQKy6Bj145cd+0dNzCNFrhNrPm9sAsdDepsIrV9Y3FQFcF05+dkOX+
         Hrilw/f4FFnifstb9eg/VqFmG5mQr/p3QrPL+tkFfgKhgsm0WqvwVIYsGoWcdHrJxbyw
         65RnA/aMT8ztVYq1IIP3AZ6S3eYs0umv+qmaL+RvwY+55F81cnRtXoD2fVl9a+OX7m4W
         vU1ubc1E1YusHFa+y0QTg2FTYcDXD/bkbrCS5BbHqP6Sv45Ddu3CLvD0u74ABGKTQk/W
         tdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749247089; x=1749851889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fj/xdWe/wKkeAoDR0xgMDBcUyEWecYqUtM2x0l0j5kg=;
        b=HmOFS5AsncDscg0yh/q+3evaaDBHRkDhEpY7phQOBxVBaZTEYWQn4z8ifPHnrRt8ta
         OMhkw2UZzvX/0t/BVMSf5n8uvqGosPTB4nb2b4zx4RESSvKVJo0ZcZOrn6EacVSP08J0
         DFPoq8+LLrnaJyGKR145XKSS2U4cSVtoxzJ2h+oYcqXEKe1ebfjGmioulCo92qu2L2Xo
         dcfonhrGYQRTwSdlV0gtCKcDCiR5vBJaUPKMKUj0VPgdAi6nYasbP0aP1QdK63Hslkyo
         4LhYn7ftDDdVKdBNQv8+0XQG2ORF/Lrso2Gs0egK6tmI6ZdQfkyEA061+OTABY1EA9Kk
         calw==
X-Forwarded-Encrypted: i=1; AJvYcCXDLe5HOb/Pv02JlLFtf+vde0lpsVEtgQ49644Rfrmi3zAi5pszaO7CrnAqUJtM8BLsvRTn1+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOk1YyuMdJm5dsBecqPtS46Gf9FWju16Ly6Kn3hjU2ChuIw/7b
	ljgidUMsg1JciO7gcExkcqozd4/Tx6hcYKMpKnow8ulsccPj12brmaIQU9oSmjmciDsvCXfKlkb
	5ckOY8k4BhCLxwEuvx1b4UxyW2d4AbGo=
X-Gm-Gg: ASbGncu+F8Gjv+EELPXnyKuCzxN4L16HtaiRzFmZSLkS7rVaGD+QsT1f2nRv1VabNP2
	4N6V554eC1ssz4ViRcvtE6CYEBoN7O2XC31j1jjuPKiEUYgoarfpqDGXObUctM9j8HS8C6fnevk
	OV5vX40106pQBgbG5hs/UrYrk3AwZnNJDquxUZiBYsFGMnrPpVJIJwMciHEf8S3KMOgRI+qXEl
X-Google-Smtp-Source: AGHT+IE2YUuzc77PtxHkol91AI7QasVFv6YOe2Jzxf5YFTIzG/SUlY4j6JRd3VbMz17us+IY32U4FI3VbRMCrqkgRxM=
X-Received: by 2002:a05:6000:178f:b0:3a5:2694:d75f with SMTP id
 ffacd0b85a97d-3a531ce73bbmr4286571f8f.52.1749247089359; Fri, 06 Jun 2025
 14:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174897271826.1677018.9096866882347745168.stgit@firesoul> <174897278834.1677018.7674555608317742053.stgit@firesoul>
In-Reply-To: <174897278834.1677018.7674555608317742053.stgit@firesoul>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 14:57:58 -0700
X-Gm-Features: AX0GCFsWI5rp_lvd1FE21Qva_xp_vDHaz3sIz72IYCgD6zYSI3w_w4uiT8nCqEw
Message-ID: <CAADnVQJSE2=YE=-CihGXUtFbEVzyxQXrSGojkLKqkMhACxJjGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next V1 6/7] bpf: selftests: Add rx_meta store kfuncs selftest
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, 
	Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	kernel-team <kernel-team@cloudflare.com>, Arthur Fabre <arthur@arthurfabre.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
> diff --git a/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c b/to=
ols/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
> new file mode 100644
> index 000000000000..1606454a1fbc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +extern void bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
> +                                 enum xdp_rss_hash_type rss_type) __ksym=
;
> +extern void bpf_xdp_store_rx_ts(struct xdp_md *ctx, __u64 ts) __ksym;

CI rightfully complains that kfunc proto is incorrect.

In general there is no need to manually specify kfunc protos.
They will be in vmlinux.h already with a recent pahole.

