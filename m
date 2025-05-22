Return-Path: <bpf+bounces-58786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326AAC175F
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE3A3AFE92
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643012C376E;
	Thu, 22 May 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBTNiygl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340F2820BE
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955391; cv=none; b=qHxlwgm9Medd7hX5kaq+OCAKhbPiyapce7aae/PPV70Br4mTLHlpuqZdTDhRH636QVGfHQDAwr8LhxmAXczRFvnDUDhQfvRVXailvb4Fnx4yuXe0hwyf7AMmxwh2w3xloK35GHaDHgu1OYgV1mw4j7PbT6uosofM2MzJb6l8VEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955391; c=relaxed/simple;
	bh=xmmNbzOUYy0JPMzyNz1HKekN9DEWLMlFpi6NUrnivS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYaM1aMIWZQvpdBkWK0sWsfF7UkzzBr+lqTo0c7u4GqHykV5Kc9eP5FeBdXMC4V1HMIA/XZ+AZqBD28Jht26E4/PU2j5XDwY9ae8ysTmQTeLsx3o6Cw6PhcTVxtIE9Sdy9POQBYww3WC1L9KbzWRU/Oyj4rHJ5K2nOJSW7ojnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBTNiygl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231f6c0b692so77875ad.0
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955389; x=1748560189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CA0pRDW8qyZDyuAgULvPatj8bCNl1YIn/HHQYllO0s=;
        b=oBTNiygl/9B2pDQnU2F0D9VLdshIg7n5cpDLYLXnNgRjtb18pqPJgh1+Ynpr/xLQrU
         mUdwvEjT2Nk9Kl0jKN/GDaswaWwe+7mAV4gzHLwe3zVPPv4n0MwZqU/2lWxT5DaaRrCO
         rb/1rt5tTXdLmxD/anWCe/RylrKQnAEjjmdvp+CAL+NDe4AkeP5enk4C8gVgDsf/kbhV
         6pBieMjmdgMJZ761758MHj6DRhsxnZv8Gl6SCI35d+x8wdnsqUXM0zOOgM8yiG61Snh3
         CKPQ2nBJvZQ15GrHPIf+ytJfc91AdlWUVdQe/jvRGol1weISc18hGPGlb/MSW6kMnJDZ
         XJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955389; x=1748560189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CA0pRDW8qyZDyuAgULvPatj8bCNl1YIn/HHQYllO0s=;
        b=HOb083yNPGuwAeHeXzr3YtPc1pK8jg/Gj6eJmsM1Z9lNiN2N/NvhqObAIUzbH1XhvY
         5lAoPVwgMf30IYYaEBQGtAtg2WKGY3bzawEFo4NLzywMICo2AcVd/xd2ZHmPEVU9iWkX
         Ur3lsPZjtOBTFN3LL2YB9+rkL+k8BEVCA/s4y0monI1TY6JvQb9lYAlklZeCKV1YuHF0
         qGpZNyBfY1rCVGBf0gr83lmSY7WB2XQUfO7+Sc1volHePz1KSCTu7l2ikZhmcSEfa/RG
         6oBwjRaQbG10dvhks0jQbUAjIHw/gBFs3KloOGE7GjuiUXznMmpDzXMQUFRetloVBw9D
         s2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPHASndyOhWr6F0hc5fdjoL/06lH3YdUwg4OOb1cZsW+yTgA52L0wVi3FpjZr36g9g++A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7uHD7c3KULhsu4TEdpJtI0r75dafOG1UsIG3AOUg4cniKg6t
	hsCOic5KpJPbrsEz5sTaeq3QIhLnqPCDejcBoCW4Wqn0SKNjCJRsBgU/rbQEIeB7GIxAwehpVbu
	HjeR3oApukbZDMc6x+rxIOURmT9K+ihsPCrC35hpR
X-Gm-Gg: ASbGnctpYu+kSz+4iUvt1OYWfOPaztQicxZLJVnhb64Q/CqkMvGAxZ0rzNjg8M2PUmq
	+Kn88iroRNsy7BULvdXl9q9r9VRNXsOsJ6ZDxXqfc8apgombFVfpXencXt3VnJgIqg6OACPyxEa
	UxM4O2eo1kfMsZKqNR3tb8fEO/x5RCTD4cJSHxBTbHObOLCpXU/Im6No0sE/XwOKkIlMJLkNZCs
	w==
X-Google-Smtp-Source: AGHT+IFJtNB+0R2HZaOFLO4H9RgrMoQxEv/cH23gmsEVlbJSkVFzBnQPZ8T049oEzAv/Mchs37L4pYjnW9hurdHf+gY=
X-Received: by 2002:a17:902:f548:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-233f34d7114mr438365ad.5.1747955389173; Thu, 22 May 2025
 16:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:09:35 -0700
X-Gm-Features: AX0GCFvKx6EEmbSiu0G5AWSPg_voGp_bld5yLcmbYZI2_sQO6H-AEI2Fdpricnw
Message-ID: <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> Allow drivers that have moved over to netmem to do fragment coalescing.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  include/linux/skbuff.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5520524c93bf..e8e2860183b4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_buff=
 *skb, int i,
>         return false;
>  }
>
> +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
> +                                          const netmem_ref netmem, int o=
ff)
> +{
> +       if (i) {
> +               const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i - 1]=
;
> +
> +               return netmem =3D=3D skb_frag_netmem(frag) &&
> +                      off =3D=3D skb_frag_off(frag) + skb_frag_size(frag=
);
> +       }
> +       return false;
> +}
> +

Can we limit the code duplication by changing skb_can_coalesce to call
skb_can_coalesce_netmem? Or is that too bad for perf?

static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
struct page *page, int off) {
    skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
}

It's always safe to cast a page to netmem.

--=20
Thanks,
Mina

