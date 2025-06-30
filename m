Return-Path: <bpf+bounces-61857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00133AEE481
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC40A163D96
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3228DB5E;
	Mon, 30 Jun 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5gMlQd8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFB28D837;
	Mon, 30 Jun 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300859; cv=none; b=svjxy1zeGHWUqRtnXxpTRfOrHJga+XWecYcW40MQ1sQaRVauqtt1ZP5OKbma5dbH+ZgSqdB2h3Rga5fMNbkFLFc5HzDDVAEKEcWofmPB1b0CH+OwfTb3ap+kngCcOvTFUj3+G2Fzs2g5A8uvmMiMS/ChaiD8SUhXLG7JV3CTVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300859; c=relaxed/simple;
	bh=4suzjQpxHT3PHOXdfRe76NrMCd1RF5e1dZLNPBqdE9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNGs0LGfRv5eYgQQXhta3pwpEdnZ8rmHBdWRPTTq1RB8hJemZKf+Vqw1idIF0U6oztYBZY8+d8v4z2prnTJ6UaVfdvkNNsyOnJPxFz9s3Z214L1YKMAtaIgWgaebs7Ii/Oh5ylFuCWx8wDsO6tDe4Ji6HiKZ/tsjGI0U8NrJsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5gMlQd8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235f9ea8d08so40487135ad.1;
        Mon, 30 Jun 2025 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751300856; x=1751905656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLa/qvYyOBfAI+FTEEw6GwL+t3XkwSAkil1P+FfrtYw=;
        b=K5gMlQd8odKy+bUKqnQzICgNPwboRaXpoxIKXhhI+bU8GSeQ7NDX3N/kH2DRz4ZqwM
         H0QFQhr3Yh8S4UGNYEJfDT44muFcDVqTz4rQtk6mIYjZh6rQH9jsCx551Nb7l65C3vkX
         Fd7oL2SVcHidAxCBZp4VY4fTsllQwyXtwk9hzj0CJbUdxFkbUJb0r8HbrwUPN+fNtJF0
         gPoHJb+Mm+89zfE+JZ7ulL7dHto4PAoXEak4LEjP7yvo+WHamV5tm6C2ryUvPNnW1/6j
         GH6wgBpD/8MHDaPUPM0B55l0HHmomBGQxbGB6izk7WDjQr8C36JiP3784Viw4UmUX8I7
         Evdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300856; x=1751905656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLa/qvYyOBfAI+FTEEw6GwL+t3XkwSAkil1P+FfrtYw=;
        b=i3UmRPc2VsoeJ7MwHXvsvuDbnSfhN5/Fcl/tw1nf/JD2lrUVeUpepdl4ZMpOu2G+Ag
         +ikY9J2Fl2pws+yh+Ipbde946/I4cgWeUzd5D40aXVflYBjcIxxsI46Lklr9NXTL6do4
         5RdrDfZ25o1t7Gle28D6tLuvUtNx5Vbu6YcgmOSizopBL5cEdLEa05qAAJf2IeDJr2Yy
         n5c6RdPssuLsCEbQjirZEkYBDTfDOi5Z2ypRnDdT6RqhmGM5K0UXUhZUoLZShnvc3uPk
         bM8Vk0BojAOPNSkKmnxXZfBqu5oCwrCPOM90geHNX6FaqVpuGaUHBpFD3xwktfvmieq/
         0uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV3E+bfSKD5sbEd8tZ5/RMmVbE1D66VraVHV2iqOhyUKJYkxaMVHIHy/GTPECWphZcQNaz2Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tqWQmynlon8+6kXZ/84ZGM9IGIxlbORbRXMVMLvxGim0Dvc6
	dE2HryQoBM7JSVwcooUP+WLuxSNCw2Gpb+xo1d+zGrIHv9YHR301Jgk=
X-Gm-Gg: ASbGncv+bQU6KpGG9uUGmkMwv7zJttJwROtfcC+FRDNzJUU8EerNv+TVe4eUdcoj7+k
	NupDSB+R9iVAKr+z+L4R44Wd8tDyJ+jGrc7dmLP3WPiWviNiqfrZWJd12sJ8kk9lF+Tbe3Dyf0S
	rN/rDH4ZZwcGiy7jvauU5LwLtUnnOCExTkbkkwxxbNh3pEeEvEEneddGRgya8kyDREOkp11If7u
	sBKguqZU18DLm2+n3a+MLuqsyIb7r23pa30+pPMV5Qjar1iBOQptX5El43ZGA9gZWyWerJrT4i0
	5kQRIa982BE3n+/eqhsW8PHMFxKhUHgcLk+DG1+xU4c4LXkwVrELl1xTgK+Wc8W/I/JWzemjz8r
	40Ey6DnV6W1nqNxEwFLZDjyA=
X-Google-Smtp-Source: AGHT+IGzt2kaCYOygCwspHQ6+3g9HiUGUjtszZMB44bjvdEEC3v3KqOg9YbQeVXBNhQxuMeafZsIqA==
X-Received: by 2002:a17:902:ebc7:b0:235:f298:cbbe with SMTP id d9443c01a7336-23ac40e028bmr223360635ad.12.1751300856176;
        Mon, 30 Jun 2025 09:27:36 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e21bdsm88692115ad.11.2025.06.30.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:27:35 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:27:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 03/13] bpf: Add new variant of skb dynptr for
 the metadata area
Message-ID: <aGK69qJ9tLVvarqh@mini-arch>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
 <20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>

On 06/30, Jakub Sitnicki wrote:
> Add a new flag for the bpf_dynptr_from_skb helper to let users to create
> dynptrs to skb metadata area. Access paths are stubbed out. Implemented by
> the following changes.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/uapi/linux/bpf.h |  9 ++++++++
>  net/core/filter.c        | 60 +++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 719ba230032f..ab5730d2fb29 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
>  	BPF_F_PAD_ZEROS = (1ULL << 0),
>  };
>  
> +/**
> + * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
> + *
> + * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
> + */
> +enum bpf_dynptr_from_skb_flags {
> +	BPF_DYNPTR_F_SKB_METADATA = (1ULL << 0),
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1fee51b72220..3c2948517838 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11967,12 +11967,27 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	return func;
>  }
>  
> +enum skb_dynptr_offset {
> +	SKB_DYNPTR_METADATA	= -1,

nit: any reason not do make it 1? The offset is u32, so that -1 reads a bit
intentional and I don't get the intention :-)

