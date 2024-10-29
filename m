Return-Path: <bpf+bounces-43355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC059B3FAD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89311F230BF
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B8644C94;
	Tue, 29 Oct 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U29RhXqY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723ED51C;
	Tue, 29 Oct 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164792; cv=none; b=SLjLlDbg0+/hFsTSfvKoXZryWdlpOFaXsiE8rk30trkXJxSa7FjRC6dl8iFQNwoXywN/5grH0WRmMshioKCUODGDcMhg+oeQdzzXeCoYiY31M/Wjx4uVJncAGNOopYLapKl64ux21yMpuHcLuXQv5CjgC4C8vmCkJ2/IEOqfm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164792; c=relaxed/simple;
	bh=uP7jFmxqUdrY6c8fnzMBr5UyZtgmNdpPhRHFR6y6vqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk0cpwuAJ8zNdW51u0hlayAZY18mAVTC7nh/SO8kFE/ZW8Y2LZZUa/IqZQLf4xegauzIRCU5ybzlkBB8TXAhgJSSRH75zPZcTZGOQZT0rINrwGYdN5KdDMLhB/UnwGRPDYtAwSSz9iozBEobUmmEI9HR5wf31/oV/kiXrh3fztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U29RhXqY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so17604945ab.3;
        Mon, 28 Oct 2024 18:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164790; x=1730769590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP7jFmxqUdrY6c8fnzMBr5UyZtgmNdpPhRHFR6y6vqs=;
        b=U29RhXqY7tjSaeEmvMuZFsEoymrzUWrhC7iJSe4DwMqVHB+4EURrWz7Amy0O/Jq9LD
         03pmijR+C+Jr2DbQREgR7rOXiqybIWmylLoPrp1Ph0p1D3TAjLmFREjt7EKtRBSnRrND
         Gy1X/o5NZBb/tjfGf68ACLYsvIzczEI0sTNSXT8UnO0BsyE1NmpSpS5uPJRNT52xAjfX
         8hwq0/BhB5hNj6LSffFDkegTQAgxr93yyiM8Y4dn7pxN+iNU4Uw6lw/nTaoM2jiIUdNJ
         9+Z2TMQ4QJSxWCeOEiO/INyIHvn6TO1c2FSRXZTrG8Ig/0iDSTIeKiaeVoVPLrjPYJFF
         XURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164790; x=1730769590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP7jFmxqUdrY6c8fnzMBr5UyZtgmNdpPhRHFR6y6vqs=;
        b=QtDG0qkUvgudmg+y/JVEgeglnqJ7cvzrrTf0dLx5bFXzJnA6dkXjpkApEPvZ68228d
         f8ilpqyoiBiLOFg26wyU2MOnpjTLge6K+//R3Kp+8Bqzn8S2UB0gdSgrXJ0QzQajTRfZ
         xfJqj7TJllhvPSZ6OaHVLejwoMQ5oBTBb2V8bsggJtliBtq57Ww7d9fguyn70IHdi9FU
         YBN3BVpHkpr+TDFgWqJ7gPDY8MVx8+rcAMqlMdZulmLArMf1Y6zhHpH9DSAZfkvVKKAy
         Yg+/8xy8Z24cSci4i+YF3GWRsx0qsH8bTMhQ0iubD2xv090xRKh7DGsGsSbHLFRXjJmv
         ymkA==
X-Forwarded-Encrypted: i=1; AJvYcCUtED+KH4krXCqRmTcJ7xkudZNiWA7QNJmvUZr8Xx07Z9e79rGXHnGxmOL0uby3NtMH/C2KBSyj@vger.kernel.org, AJvYcCWd17U0IALhtPoE3pvFOPIwzn60JTtSFGT/RvvrE2NynX3efYc/Y/FGjgNLekfLsjXlvSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyunLpHhCxByyz2YfqtKu44dBUPDDfQOX11pMRs552A31wVE5
	GQLHAAch0qDlyk9VN+EawzakYit7IfWHqVG8tTdCGVpDotg42rkR+/Qrqahq1cr3e/zw8PvLfrJ
	nZseo52J56Zfcv4/5dfZEs8UvqH0=
X-Google-Smtp-Source: AGHT+IHf+4zFDlnUzZ56IAu36DAByWx9gRWl0tLNUKDPee8qLyqTrofL1G8E9Tf6Du9OHMdyJQ+GfXtjKgi5fQIXQiA=
X-Received: by 2002:a05:6e02:20c5:b0:3a4:e99a:bd41 with SMTP id
 e9e14a558f8ab-3a4ed2f3861mr95471385ab.12.1730164789855; Mon, 28 Oct 2024
 18:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-7-kerneljasonxing@gmail.com> <6720346cdebb6_24dce6294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720346cdebb6_24dce6294b0@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 09:19:14 +0800
Message-ID: <CAL+tcoAJ=PvXEpnLAg-eKVsjRHeYgdzEsbwLeQR4Pk-U8j8wUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/14] net-timestamp: introduce TS_ACK_OPT_CB
 to generate tcp acked timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:03=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When the last sent skb in each sendmsg() is acknowledged in TCP layer,
>
> nit: last byte.
>
> The TCP bytestream has no concept of fixed buffer sizes or skbs.

Right, right, big mistake of basic theory. Sorry.

Thanks,
Jason

