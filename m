Return-Path: <bpf+bounces-22331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980EC85C2DB
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99161C2217B
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128DB78681;
	Tue, 20 Feb 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB/0d2cg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7378B4F
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450717; cv=none; b=g1wtXS0A9rxdQX/NxHSOHPVnwiykmX9tXWfE4093t3xdN3uc73l7UQNn4ebd+InDr9aSQSCy4UqH1N6fopS88IRNV3RmaX0PSR7M9DLPNtE4lAvypTDftZbRLlA8gN3qY6CXBqBYXBZvjiZ05r+3TynfqNKOvUJMYAsMrnszgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450717; c=relaxed/simple;
	bh=7P4cu+3gtrDEFbTcnAG/bwHGihcnmYCNqTcVxmzmTH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUMqq5I+B80Y6LwZKIAKHn4h7bdqL5lRGIWcaOgxw+uz0lnzJl97i46PJZ3lOkxrglasl9tHkcdL7bY8rx+waB+pmrNfDx0b+lib+PbJX78IdQvvreYwv3RIkK5NA+h12I5wyH/do32lQZQIoUVSY3h1Yovai2eELn2qxhAzpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB/0d2cg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41264c364fbso18928005e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450714; x=1709055514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA55q+/bYljf79vHvCg4yXUihrxEFXikJllz8ZMxQG4=;
        b=nB/0d2cg0Nilr7mduruamkDzzBaztPIlfwbvzm8EHatpk5XweaeZRU1wOaVZs813AB
         Or4dxm6CAhwX10o9MEHw20eWU6PsZePpA6TjACDyP857vfV3nYvkKterW55AxdrJ2xwJ
         5PNyiIjmnzezSFlm+wO7ljBuANUPVQr/u965gc6zqDT+McuZpLoOER7nOp76m7j/5yCD
         2DfMciWHkhovesvdzJKB6FDER/qVDa2VhPs0MoODGTIgwLTy2JNly2r1GSq2AvykBUuw
         A1Jq9PJ0sOkB9PX1utWmgAlQzQfbi/H31NgXXOSCDcY5vCuFm3H6OeKf0Tt10qV56mtu
         Almw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450714; x=1709055514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA55q+/bYljf79vHvCg4yXUihrxEFXikJllz8ZMxQG4=;
        b=R0F95rbII8sEbg49ODyGZUR+2sAu17zKEi84hxuBR/pzdRZISSD/3M5NKYPOfyXOgd
         xzzakJi5Hxmv60nfE/lC19o6iFy18T2XIvotLpX+L44SwtSxxHQ5mBIF+2TvLPX94bIl
         3EpIe2ntC9TfS5PCS3mj78qEeVRqwjClmV6jN1pHL8mWjvNl9o239a5WpJHyAv17ARce
         WUl32nRzQ/0xD9DORsH5m+FAVr4ZgBCc7n6ShAoKRd3qsMBG1nSCCu8gM6mPDc3IdvDL
         oS+0b5NyyEMtiTBoR++SjNk1Uuw86FxRkFkzdWi4FStJFsBsA9NmQqKPuszb9K/ANOsb
         L07A==
X-Gm-Message-State: AOJu0Yz+l3wItG1cKwrdhr5HaUf9O5NJgV4te6B6bkxBS1I9woyIwHXW
	KeL41kG6Qf7iSZHks/RcDfhy2cnQ7uH/epLg50FoZkMdTG4zS4RWw3QaNneAtMhOyyp86Z21vwI
	nutrslUJd1N4WzqAn2S1NZeL4+pw=
X-Google-Smtp-Source: AGHT+IGbJ90y6SLzAQZOhULE68BROWIg7PnXftgNXfcNRB8hxvHgaUwJ2RlQKO3tQax8Tbbf3/0mv1lxQ0D7hfxiS9I=
X-Received: by 2002:a5d:414e:0:b0:33d:1427:5274 with SMTP id
 c14-20020a5d414e000000b0033d14275274mr10550659wrq.52.1708450713944; Tue, 20
 Feb 2024 09:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216193434.735874-1-thinker.li@gmail.com> <20240216193434.735874-2-thinker.li@gmail.com>
In-Reply-To: <20240216193434.735874-2-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 09:38:23 -0800
Message-ID: <CAADnVQ+hXmKGxHQopt8HF5d85sn2vvqZoJ1xNXWV9LzVTtjw1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] x86/cfi,bpf: Add a stub function for
 get_info of struct tcp_congestion_ops.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:34=E2=80=AFAM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> struct tcp_congestion_ops is missing a stub function for get_info.  This =
is
> required for checking the consistency of cfi_stubs of struct_ops.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  net/ipv4/bpf_tcp_ca.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 7f518ea5f4ac..6ab5d9c36416 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -321,6 +321,12 @@ static u32 bpf_tcp_ca_sndbuf_expand(struct sock *sk)
>         return 0;
>  }
>
> +static size_t bpf_tcp_ca_get_info(struct sock *sk, u32 ext, int *attr,
> +                                 union tcp_cc_info *info)
> +{
> +       return 0;
> +}
> +
>  static void __bpf_tcp_ca_init(struct sock *sk)
>  {
>  }
> @@ -340,6 +346,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_conges=
tion_ops =3D {
>         .cong_control =3D bpf_tcp_ca_cong_control,
>         .undo_cwnd =3D bpf_tcp_ca_undo_cwnd,
>         .sndbuf_expand =3D bpf_tcp_ca_sndbuf_expand,
> +       .get_info =3D bpf_tcp_ca_get_info,

No. It was explicitly skipped.
The plan is to use NULL in cfi_stubs to remove
static u32 unsupported_ops[] =3D {
        offsetof(struct tcp_congestion_ops, get_info),
};
and manual check of such fields in is_unsupported().
NULL is cfi_stubs will be such an indication.

pw-bot: cr

