Return-Path: <bpf+bounces-61102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ABFAE0BD2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC723B1D59
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E728640E;
	Thu, 19 Jun 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyPBqKU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529063B9;
	Thu, 19 Jun 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750353480; cv=none; b=mlO91tPL46IvBNB2AmBBG5dDmK9vrXRf0mytvIl7+B4+hFDkeiYErlvJKwI0JHahWDDp+r6BoOlgDnSib/Mra2qsnd3qavJILQPqwgEvVROn+dF8P+G6uUWuPropi7vDIXHUqSCUYNje7JjojmEyrAWLO5pT8lhwPFAI0X1QOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750353480; c=relaxed/simple;
	bh=LcNOtOZVmNxbK5u9RD18K1PuavF+FHJXadsTd/s+9+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUFM/9oPUa/rTkqYDBRVRF7zJHh0ADJkahd5o3+lEbY+U5TLVv8esc2x+M5GQlpBZ7/gXrTOXb2ufqek2fKJAfNHvnKhF+A/Axw3bJhIcSTVajTqe8PcjuMhS31U0itdoOG2QwnH2/8jWD9p3iTgBd0UB4CJJ/2Bs7HZN7Y0tFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeyPBqKU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a510432236so834350f8f.0;
        Thu, 19 Jun 2025 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750353477; x=1750958277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO/J7Pagnq01E8VPCwoxaOTTp05t+ZZcbvS8oAGS03o=;
        b=LeyPBqKUaELvQiXYdbMvrIj3lmQ+YfNLyOGtb9PQhp/cJSmSA5gxDwzs1IEscReJ7x
         JEfOSB8Dz8Ek5cp33XmNVI5lx1xg3SaCcJvlJmL2J2Ffezzb9ayn/ezEvTHl+iB8ZHPT
         hpHd16Szh6Gvr+4rn2CG0b3uxmaSowxFrB8f6pACA47DI/LSQpf/TN+rLrPcZQgj6IaU
         B2I3EFGhx1ZwDaIWkbPGZmA4N0z9ZxGJaZAN7jNg2j1OZ38uhmIFZbFvJmvdbdifxN1O
         WswWKC3GYgew7Zgt0jD/5efITw4GMcIgy+U0vYXIIqKdv0aqOy/Frh0Qoqod2P8Vb4fv
         CZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750353477; x=1750958277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO/J7Pagnq01E8VPCwoxaOTTp05t+ZZcbvS8oAGS03o=;
        b=t1B8s0KlYM7SgpA3jgFf8sgVeSuogekt1crNyJBv4oTh29MXk0gDwS6angqoa/nOrx
         dLIlkjSHXUp3u9UcwwdpTmoqQDhHGhkSmdiXhDLT3FEHGX+x9RWgh9fomraHKVOF47ev
         dwJDBETwZmGA5J9smo0kfEDCe/kkaOdoVs993rvAx3vHIJGUcKgzv30x2iHGu9TicfhU
         e4luS5/ASJJBs9O+69aX00zUyqlr9Yg4Srwige/Yt+/iBgLlf6Mx5jwKPVwCysYxJWLf
         qKmBHabMmeQcyZVUeGXJ7wwOupUqTAt+IO92q6DHECIfXPefqCU2MRnQ1qq7O1eEOUPm
         eLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCXl3nTxnGqqOnHNYkmzUyHRLExadMkHcXXZv3QnaZizZVmdtUZGWU917JA2nW9f4GC5pypiWw41kvdG2@vger.kernel.org, AJvYcCWU5rUqz9xL4NzjjXPqYQp1AbjK38KHcDk3omg8jYTu2uG8iWCra3nNeynfyjlgkk9wfxn1FuqYcqrZl75YYlrTG7YE@vger.kernel.org, AJvYcCXride5SaE+W/CvYkc09yrJ+tBZM7JY9Nr46MABpe8hkd8a2YQKq7UbXh0rULutfYh1yJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xy5BY6IpLNcdiTKYYKrBnsuI0Dvo/g6ZVXrTKwJyyP6aVAuA
	COewKdeviX1PXgU/q85HjOaw/eGuDbNkSN3g5avJuvvRAsyVuvIo8rO5PYAh9ciyi96dNRSfXSC
	gJu8ws8guLX4Grk5UCnaHThTFiA8lzMI=
X-Gm-Gg: ASbGncuPFrLeBeMzClMPUat3v6AJcz4wkGmIU/KGP662BHp/zshxKunx4q2jJrAiZo8
	6TvAJZcPUHqta+Fmh3Jbdnn1DKypmrwg32U54WhHruuUZE0A2o0+vuubf5FMWICi7jWk/dMpkcE
	rWtsKg4zIUFu4pYZCzOLCqv65K1xDt8Rid+YbnjX4ykUF3Pu5yLUBEVABnHkyJtZOJZ1DnsfnM
X-Google-Smtp-Source: AGHT+IESQSXAdMTbOc8kYZxZDWdUN8Mzm3XZQmL6s7XT9MGp/1efEWuVZDh0wTvBIoOOmPc/4r8as/Zp+LeIstNQ0UU=
X-Received: by 2002:a05:6000:4818:b0:3a5:2e59:833a with SMTP id
 ffacd0b85a97d-3a57238b9fcmr17654499f8f.1.1750353476693; Thu, 19 Jun 2025
 10:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619034257.70520-1-chen.dylane@linux.dev> <20250619034257.70520-2-chen.dylane@linux.dev>
In-Reply-To: <20250619034257.70520-2-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Jun 2025 10:17:44 -0700
X-Gm-Features: Ac12FXwKpCNFWOuAGB2fPizZlJe9HoMAYx0YXyOn2INhIO7Op8ZkL1AOyKFu93A
Message-ID: <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:44=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show kprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      kprobe_multi
> link_id:        1
> prog_tag:       a15b7646cb7f3322
> prog_id:        21
> type:   kprobe_multi

..

> +       seq_printf(seq,
> +                  "type:\t%s\n"
> +                  "kprobe_cnt:\t%u\n"
> +                  "missed:\t%lu\n",
> +                  kmulti_link->flags =3D=3D BPF_F_KPROBE_MULTI_RETURN ? =
"kretprobe_multi" :
> +                                        "kprobe_multi",

why print the same info twice ?
seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
in bpf_link_show_fdinfo() already did it in a cleaner way.

Same issue in the other patch.

pw-bot: cr

