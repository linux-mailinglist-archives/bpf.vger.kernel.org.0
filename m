Return-Path: <bpf+bounces-49928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CFA2032B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 03:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018151658C5
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B47083E;
	Tue, 28 Jan 2025 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSMONfSj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B98462
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738031644; cv=none; b=n/dwvm61b0Vs90WxzPq3gnTreZIibWB+ipIAtXq5hEMWc2Oql9Yd6Apxh+yUSC+8VfcpcXke8b6ifTfVURM01mAQBiLamPYjirHbHp23qBa/7C5wTxWJdf1WPYSwR+JAjuqOCPREVTjRC5h/d0u58ERiYWdQV0IoXqEnw9NWKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738031644; c=relaxed/simple;
	bh=dc4Hrng/93YPn9l5MCSvQvfIr4nWyiwc7gfZCyuN4wM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvdxYXHo+bt+bwqVT0JtJtNIQ16+gxU9GAWbNMmtgnDnLaMDzDHEFTzNPyJPXvCSETHCAawKWu4Wqw83sQsrYjsprBYhUZl8D0aMVHqRwjfFImKxI1DgCLvTgOscH0PcN1y/gsiErWuT8jhj6706npMWIioFdVxo4Vhd4E1SUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSMONfSj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so6782679a91.2
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 18:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738031642; x=1738636442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zHBIPdsAY7Vr5fmdBl4Qw1wo74CIB90Bmf4wpDsbkes=;
        b=kSMONfSjCTXFa2Vq3B76NniYj+1gAvRZNrPx7KLrJVcwnYZR1Kx5/caA2w9t9q6ACR
         +0URe1cuGTxTjOnsCr4JDDL8iFDIajEi9sSePkwaXfDu/HM0fPs1mpi/wMii6rymNSq/
         9VfBDeJP8wc/5N91veDGUb83LZIVDAyKfVc/r+dToZB1Pl0e31mv25WzClOBv2v/qork
         ZeVCn+mSPH0oYOuukx1WwuSPsdFj9yEQ3w8TyYvj4YU+BW9iXSpkug7NntJQnyiq/hvk
         DYyfPMCcn5WmqHBMY0VVyk8pVBjSAZHJjMUK37rTGBzqm2Y9C9lctnhwWwLqP/6a90bS
         OwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738031642; x=1738636442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHBIPdsAY7Vr5fmdBl4Qw1wo74CIB90Bmf4wpDsbkes=;
        b=PC5mM0+PGOoV5QJlbKx77hPz6YWA6LvvI7inB3bjlw7NN21vzQtn3fSERkB4zO5tCg
         HyHCHtRX5szA9E6Vm9NV8E/QkM28f0TMQ0d/VrMXD1Zl10EoLiaq5QXmYMW2Q9dGYJ8+
         gSTvLsAaxw/TQtb6S0c1LRSnx6WBhtUMK8OLzfEUgaIwN0S/nBAJjOWxz5CnExdpP6fH
         2fNtIs8SO9pJElJKVoaSkfWqQotgmfSIktzz+Rdp4ZAZHP5u0JbcVOJxtiuEdyQNx2qB
         rcyg9AilS5ymkphhJaKwdyVcwAnp9cFZW48qRAQSU5B/uFRqUhvUZlnwV74/L+o6KMP9
         1OmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHG3KAM++m+ulRlvMPeiCwZnF6srqEhWFParqmKGyxdC0uUwGnt21krGzUarldg+aVaso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HuGRHS/WZW1cpLD6NQYdrSlFpfjcCKh2OYVmKqnFTTvtA2cZ
	yTzyFKQh8f0zIPWiB6sA3zN0WjfgnXSdRB9PsElGfp7u2VdrlGVs
X-Gm-Gg: ASbGncu9icJFfZKuS/aYo/zvl4WcWdaaYthf7UYFuaSL55SmFDcmztdgmTJrMol3csI
	hPOAV64iape5PWgJx9R+FuzL1kqK6j7wly66OyGZQgNWJlgvpgXTd+wPUg6ZE3FWmnYX4zivx+d
	t6gLwdeZe/YtnwUnvKOjadizSWIQx7ZAMDNwpLrkni8fRirvmAiJt5dhd60d6OsQYeIoGB3ZMKQ
	mlfwxqEIiaFuQ19maKhczvScUc4GBQh0o1q6AEUhpKgIL2b/EUSSYQ2h3qkbUfy7xZ7le2a+Ekw
	xqYIgHU2r3mplJPldR4U09mgH3StMKU2RU4/SM9gacTcIvLsz5KOYYbKJQ==
X-Google-Smtp-Source: AGHT+IFFOiqRhCUBUJ6gJa5gMMez/9bTupmfJUDDl/WUPFLzFdbo7koaBTfYWmiTvSDwKwqGnMxw/Q==
X-Received: by 2002:a17:90b:37ce:b0:2ee:e961:3052 with SMTP id 98e67ed59e1d1-2f782c787e7mr70565320a91.14.1738031641947;
        Mon, 27 Jan 2025 18:34:01 -0800 (PST)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa44530sm8877009a91.7.2025.01.27.18.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 18:34:01 -0800 (PST)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 27 Jan 2025 18:33:57 -0800
To: shivam tiwari <shivam.tiwari00021@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v1] libbpf: fix accessing BTF.ext core_relo header
Message-ID: <Z5hCFR91L7stFn81@kodidev-ubuntu>
References: <CALz0HOrGei1UTAkceBZqPjGkY=6pRhpjt=b63bhhgPjF7_E9Gg@mail.gmail.com>
 <20250125065236.2603346-1-itugrok@yahoo.com>
 <CALz0HOqsN1VqK1WpmNE4jf+AoQ5Frsan7Ysk_R8LhKdRJxV7_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALz0HOqsN1VqK1WpmNE4jf+AoQ5Frsan7Ysk_R8LhKdRJxV7_Q@mail.gmail.com>

Hi Shivam,

On Sat, Jan 25, 2025 at 01:57:54PM +0530, shivam tiwari wrote:
> Hii Team,
> 
> I am new to contributing to the Linux kernel and recently submitted a
> patch  via the mailing list. I received a response with a proposed patch
> update and I would like to kindly ask for clarification on the status of my
> submission.

I confess I mistook your email for an automated bug notification from
OSS-Fuzz concerning code I previously contributed, which lead me to
investigate and send out a patch.

Regards,
Tony Ambardar

> 
> Does the patch provided represent a draft or suggested change for my
> initial patch? Should I make any modifications or take further actions to
> move this forward? Or has the patch already been accepted for inclusion in
> the project?
> 
> I appreciate your time and feedback, and I look forward to your guidance on
> the next steps.
> 
> Thank you for your support
> 
> On Sat, Jan 25, 2025, 12:22 PM Tony Ambardar <tony.ambardar@gmail.com>
> wrote:
> 
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Update btf_ext_parse_info() to ensure the core_relo header is present
> > before reading its fields. This avoids a potential buffer read overflow
> > reported by the OSS Fuzz project.
> >
> > Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in either
> > endianness")
> > Link: https://issues.oss-fuzz.com/issues/388905046
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 48c66f3a9200..560b519f820e 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -3015,8 +3015,6 @@ static int btf_ext_parse_info(struct btf_ext
> > *btf_ext, bool is_native)
> >                 .desc = "line_info",
> >         };
> >         struct btf_ext_sec_info_param core_relo = {
> > -               .off = btf_ext->hdr->core_relo_off,
> > -               .len = btf_ext->hdr->core_relo_len,
> >                 .min_rec_size = sizeof(struct bpf_core_relo),
> >                 .ext_info = &btf_ext->core_relo_info,
> >                 .desc = "core_relo",
> > @@ -3034,6 +3032,8 @@ static int btf_ext_parse_info(struct btf_ext
> > *btf_ext, bool is_native)
> >         if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header,
> > core_relo_len))
> >                 return 0; /* skip core relos parsing */
> >
> > +       core_relo.off = btf_ext->hdr->core_relo_off;
> > +       core_relo.len = btf_ext->hdr->core_relo_len;
> >         err = btf_ext_parse_sec_info(btf_ext, &core_relo, is_native);
> >         if (err)
> >                 return err;
> > --
> > 2.34.1
> >
> >

