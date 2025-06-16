Return-Path: <bpf+bounces-60742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A876ADB8C3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042473A9180
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBA28937D;
	Mon, 16 Jun 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOVjTnIT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C8204C1A;
	Mon, 16 Jun 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098202; cv=none; b=WBeZVt9mlqcL5sCx3tpgodfcdQGuPEQAMo5xGimb47tIiNsgqVACJ17D3EMhgs7YDsTufNfnPjaLveLoI1Zlvq873JRGD6twmv5LTUbbRqHmhYpKoYT5fNrCqfQ8fIawMGLmh4T0EVsrjDYzy9ymLD9Mcstn380hZFMJt7SQVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098202; c=relaxed/simple;
	bh=SkxBo5Uo9BmDFR9ctIppZLeQSbbHyl6wpewl0lp/nng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZstjW0fnuOpbPAPSzNvzru03WPtkeNOtPA5bKnXZjJdZPYGOa2oiYaKJp1XTsZYsuged299sfyyHhRD/+dXTby0QGAkyHzOl1k/PpcxRHGbSDfNBI89DYDYcM9J3SlieaSsjjO/oDuxeb5kOBcVxRhL8b6Hw1hPErJCnCuCaOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOVjTnIT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8272914a12.3;
        Mon, 16 Jun 2025 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750098199; x=1750702999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5432uNKHLCfvBYMfRf2s2o1tNhT7+RCbmj1pz5oxdBA=;
        b=LOVjTnITYuE0XxoTfl06ktA0dIipsAMvdsxEAov9HSrYIqE69EyVTQXOT7sEsWxHS2
         rQm7hYKrTSHbpC4NtpeLO5khY2dH3zVbpOQuDbrM8SV8EejUtPkadjtVGInQaLWcFbFc
         5IYWGnvpiPoAnNamP4/CdoMitrKlL62EG0O5DPPe88z4RcFnP1M+4cDGfPRec78Zw2HD
         6NNpFU6Dxxj+jO/S/3A+JQXVvaBy9u8uBDFA/L2XidYr0iR2DOlnqQdQ+bTUCmM2dsgU
         jde8XagKiPRKDOGad0OLfRXuwSgt6JBDCFf9pMcpLMtOgnLkDcfe7Y9a6a2c+jJLUugz
         HqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750098199; x=1750702999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5432uNKHLCfvBYMfRf2s2o1tNhT7+RCbmj1pz5oxdBA=;
        b=w2bgD6DajPAtxSYAlEvUy8SQcdfqrtEFOWROuHUMH+eu+0yY/gPdzZdxnSTIAUm5Ag
         /pzVhMnZ1DozUtlc4ky4ke1KWM5Eg9tzp3rVkScLkbkbPn0vRQfukYDqdeVxqtTcztzS
         vdDTNumk+998t48pnZagZDzyWXWxv6q6+jbC6c43zo5l0FTIjpqjpELQShtQM6Nfazqk
         otCFI9pDBu7SmVtRswTpcwzkr6mpNqnKakPLkzIjxauuDzEr8545CuUhgAc4CBOiYdUP
         CLIMajRXF+1uT//uStJCmUSb8WVQFVYOSOi2kfHQdX5871Bebobp5t4lkYybi/zAfW9S
         bITA==
X-Forwarded-Encrypted: i=1; AJvYcCWYgztZky7AxV5BVeymNWwB+LBqe4Gu2o39k/fHUcyg5a0TU873e0Tr8OF9lyJOtDM9sxIubQxmhbjx1QYN@vger.kernel.org, AJvYcCXZckMeY3h06CfoeBD0dXw8f21GhPYstI5/gf2j5XQhj9Tm/xTXCRHDPa6hRJd8xbgwj8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSjzCbxT1o1lDJ6E4aW2R/69crrlxc+yHFnvGmf8lG5hlmDHK
	bZdZCx+KXnBlP37igTbXujoPx/Wwp8HiYKhWILMqsK6z0logXPbcpx3bwRKZUKm5EMWQAYyEvsa
	1l1hD/A/FksL4jXsf0qulYJz72WlvgWoH8Igt5Y8=
X-Gm-Gg: ASbGncvyojxviRTx6crPhGWhdiS3udxDT/b6uUI5RxkuYzZF5j7v4wEH3T4Rble8IZV
	7cseoXX8eeZ55XH5Mjc/8b981a0lDExzLEk2KvE61U9umvuJ3KD1o4EGQG9rFIgHkrlUN+C2fpJ
	ymw0eippaG1+t0nS7DgznmeTBDC/Vwpxj1MYGzSlPhcHc=
X-Google-Smtp-Source: AGHT+IGIjtvphpLoc9kCUbfA2WQ2xN+tzFeedjXYONEHZnsxW37Mi+C338tOkfvnR6sg/j3YidOecbpCL2ca4InMQ+4=
X-Received: by 2002:a05:6402:2749:b0:5f7:f55a:e5e1 with SMTP id
 4fb4d7f45d1cf-608d0976322mr8572060a12.24.1750098199241; Mon, 16 Jun 2025
 11:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616162023.2795566-1-quantumcross@gmail.com> <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
In-Reply-To: <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
From: Robert Cross <quantumcross@gmail.com>
Date: Mon, 16 Jun 2025 14:22:43 -0400
X-Gm-Features: AX0GCFvsPOWK_JHyxFl74Qmgj14390Bc6R9oJnYGvhUVTdMTnqGht1oce_wDT2M
Message-ID: <CAATNC474tcoDeDaGg1GKbSAkb8QBT9rcHrHrszycWpQwzU+6XA@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

According to the documents I'm looking at, the 88E6172 and
88E6176 both have external MDIO buses. I have brought up
a board with two connected 88E6176 chips, each with a PHY
that can only be managed with the MDC/MDIO_PHY pins of
the 88E6176s.

After applying this patch I was able to successfully manage
and control these external PHYs without issue. I'm not sure
if you have access to the 88E6176 datasheet specifically,
but this chip absolutely does have an external MDIO.

(also, I fixed the problems with the checkpatch.pl, I will submit
the fixed version again tomorrow)

- Robert Cross

On Mon, Jun 16, 2025 at 1:55=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jun 16, 2025 at 12:20:25PM -0400, Robert Cross wrote:
> > (Sorry this is my second attempt, I fixed my email client)
> >
> > I was trying to enable external SMI on a mv88e6176.
>
>         MV88E6XXX_FAMILY_6352,  /* 6172 6176 6240 6352 */
>
> So it is part of the 6352 family. That family does not have an
> internal and external MDIO bus. It has a single bus which is both
> internal and external.
>
> It is only the 6390 family and above which has two MDIO busses.
>
>     Andrew
>
> ---
> pw-bot: cr

