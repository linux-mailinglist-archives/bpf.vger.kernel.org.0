Return-Path: <bpf+bounces-11125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6587B3AA8
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BAE721C208C9
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046866DD4;
	Fri, 29 Sep 2023 19:25:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8286588D;
	Fri, 29 Sep 2023 19:25:37 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEBA1B2;
	Fri, 29 Sep 2023 12:25:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so139950145e9.3;
        Fri, 29 Sep 2023 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696015529; x=1696620329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMHV2V/kqG9I3RQeTZYX0vMNO9LsbrSBVcGKEums0k4=;
        b=VeF59lhY43MLZSLWpp2VIyT2OnY6BUg9XYKPHKh5W/+hsTFTzECJIRj+fAGgHB/c5g
         kWTFGkRsMKXZjYH4X5fVijn1vC5f5a/tsfLs9Ft1N7GSeFKLb/PMK18p29pWCCHWpBuk
         mMs2khECbb0RhGW9FmVaIyyzGRNBgkrTXih+AJHdrA1UcPbU9syzihTFk4pL7yGFYWEX
         zYUsBKNauzEHBhHjptbI7lPIweQVA1WODXcbxNjs/FadJhWJBYtc+sUVwfF1oQ/sXwBM
         0jJGLO7m5uYTl4we9O/a2jkNH+YTq2WXdNSX9SHJKRC/LgKW9Zw3y9Q7O9pUHUiwLDgd
         z5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015529; x=1696620329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMHV2V/kqG9I3RQeTZYX0vMNO9LsbrSBVcGKEums0k4=;
        b=v6up3/2lmHa7ElvEytwcJwtUAEA7IkKhh5L220e3AUusIq06eudj3uvAWWk8p/mvX0
         G53FX9ond7v8t98jOsOBV/1W2R7vvg4gLMKuOBGs8WIUvjx29p35gq7zpy7OgMGrqOzV
         PtKbJiLy4HR5bxj2C+VWT5KQASqVyaAO0y8wIid/Xl7wG14EDnH7dQxytPEE+7NMJstp
         l0MPRwhUwT5AZhPPS5i1qQ+4VAXDGsRFLk2jrWi9Z71oSqRWP1qZNFUrmth/sKmJ7fXJ
         /ObxJxCCKOpeY78l3JbY5jl2C9I39kVKQ0MR1GelUILn/g6U1++B5lfOt0Wr9+QRFZax
         bR1g==
X-Gm-Message-State: AOJu0Ywk0EfvtmdXnnMa1o5LvIcI18JWlR23ozCbmMh1vcQUhi2s31ao
	QYsV+DMwpnOLnz2Gy0A/bRoJ4iGYUX/c0l4tFZ8=
X-Google-Smtp-Source: AGHT+IEmExtnQrtc5nPi7e3OT9GMrxtnLk0R/vdDkSkap5pcG0kWevBwEypEdBou0cqbwtOww8ZnmlXQrGRpnlk9GA0=
X-Received: by 2002:adf:f102:0:b0:31f:651f:f84f with SMTP id
 r2-20020adff102000000b0031f651ff84fmr3951475wro.27.1696015529150; Fri, 29 Sep
 2023 12:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-2-daniel@iogearbox.net>
 <877coa8xp2.fsf@toke.dk> <11c6240c-ab6b-fba3-d84a-824b3fa36ac9@iogearbox.net>
In-Reply-To: <11c6240c-ab6b-fba3-d84a-824b3fa36ac9@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 12:25:17 -0700
Message-ID: <CAADnVQK82PRjGnw+wht4ZpxK3s3St2qWRoO6bJbuY3cARXXPxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 2:14=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
>
> > I think we should just name the driver 'bpfnet'; it's not pretty, but
> > it's obvious and descriptive. Optionally we could teach 'ip' to
> > understand just 'bpf' as the device type, so you could go 'ip link add
> > type bpf' and get one of these.
>
> I'll think about it, the bpfnet sounds terrible as you also noticed. I
> definitely don't like that. Perhaps meta_net as suggested by Andrii in
> the other thread could be a compromise. Need to sleep over it, my pref
> was actually to keep it shorter.

I don't like the meta name either standalone or as meta_net.
Maybe "hollow" or "void" netdevice?
Since this netdev doesn't have a substance when bpf prog is not attached.
It's empty =3D=3D dummy =3D=3D hollow =3D=3D void netdevice.

