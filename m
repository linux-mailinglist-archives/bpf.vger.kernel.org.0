Return-Path: <bpf+bounces-18555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C6981BDEE
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C0028923F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F163500;
	Thu, 21 Dec 2023 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NrjvaxYJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27481634EC
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a23350cd51cso131210866b.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703182203; x=1703787003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCPDmIkvOqzN7yorvfIASJF9FBAZlqrwDbGblS1upSs=;
        b=NrjvaxYJW+nYRhO4eLwEf2oQAcqmRrCzdTvAYInW47yOUO2LT4gPMb4DXIs4J3ehw/
         HZj3DAg58zOenCBd6V8qA0r7S/DeUKJD6JV0vHzGJRiRcfK4kVfsLhvTRr5HwpbbPWOZ
         DJ6CY8+udW/TmcWIS+YHuwHHpnU8yLi0bfyM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182203; x=1703787003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCPDmIkvOqzN7yorvfIASJF9FBAZlqrwDbGblS1upSs=;
        b=QZ0VfkEnzBCUhkR/3Gn7j64rk9WxCGnku0wMkNn6ssOncgDOc21t/s6nnxnClNrDVJ
         zb522EyYkpOzcoo3e30Z9giJFXMA9HoLyX0kggJiCI3Yb7eFaOt09Fkuhna9B7zUKA/W
         67zAPsXHJk51orYao5Zd1FgQTRI533I3Os/+QNmu/ibHwJhH24D69DlCl0PtQ+SfD4Nn
         Kyesilyw84Fq7SIcQiTk+W5rzX4l3FmT2bZXbRjPJwgsn19dhS4giRtDc3dmtEc9YJRM
         boKMOaUIDpvMzO+mQoL8lhiuB1ySExMn9RQF2dyP0pUN8RH8xhghp2BbZowI5p4f4yMR
         b++A==
X-Gm-Message-State: AOJu0YzxqXzokykcyJxyuo5c2+VQ+JC8H9MbyN1P8d6R1tctyxo5GUEg
	ME49MZEjwE7TQAQXLuoBPOyVk+6GbHoZ/eR6sHfcKCrB4JJH6lz9
X-Google-Smtp-Source: AGHT+IFNGGvj4YNfLz7ouQMGbsGsUbL+w0Mud73MJ1Ccd+OgCMjlBRp77GJlYZyJ11w3IYQGQ53kZQ==
X-Received: by 2002:a17:906:3f5b:b0:a23:495e:4ef4 with SMTP id f27-20020a1709063f5b00b00a23495e4ef4mr109517ejj.21.1703182202894;
        Thu, 21 Dec 2023 10:10:02 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906b31000b00a235e5139d2sm1211178ejz.150.2023.12.21.10.10.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:10:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2340c803c6so133980566b.0
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:10:02 -0800 (PST)
X-Received: by 2002:a17:906:74de:b0:a1e:437c:6a6d with SMTP id
 z30-20020a17090674de00b00a1e437c6a6dmr72129ejl.95.1703182202115; Thu, 21 Dec
 2023 10:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205101002.1c09e027@kernel.org>
In-Reply-To: <20231205101002.1c09e027@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 10:09:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whceLbGZwuLnR0S3V_ajedDXj=s86sm89m+VT2YrbG1NA@mail.gmail.com>
Message-ID: <CAHk-=whceLbGZwuLnR0S3V_ajedDXj=s86sm89m+VT2YrbG1NA@mail.gmail.com>
Subject: Re: [ANN] Winter break shutdown plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, fw@strlen.de, 
	pablo@netfilter.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 10:10, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hopefully the merge window for v6.8 will open on Jan 7th or 14th,
> giving us at least a week to settle any -next code which is ready
> after the break.

Just FYI - my current plan is that -rc7 will happen this Saturday
(because I still follow the Finnish customs of Christmas _Eve_ being
the important day, so Sunday I'll be off), and then if anything comes
in that week - which it will do, even if networking might be offline -
I'll do an rc8 the week after.

Then, unless anything odd happens, the final 6.7 release will be Jan
7th, and so the merge window for 6.8 will open Jan 8th.

So that's the plan, and it doesn't look like there's anything strange
going on that would cause me to delay any further, so it's pretty
likely to hold. Knock wood.

                   Linus

