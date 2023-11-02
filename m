Return-Path: <bpf+bounces-13955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8127DF54E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707B0281BC6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60031B282;
	Thu,  2 Nov 2023 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OL3y2w7l"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E714265
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:51:47 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AED11B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 07:51:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so1001664276.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698936705; x=1699541505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgwt3hqwAjJDNFAnGfG7utbhaV6aSewJTTMtHQOAwPY=;
        b=OL3y2w7lQabebRIUyU8Lh7h1UyTFhuVT65EBZN+E7biMnDZnYHiRxEudWBv8dB2Ikb
         ZYdHg5lG2NgnLHvFSvFwso+6V1oaajRt6L3h3Tdnt3VLykVsG14Wg/1iZXq9Gdiz2X9x
         5f3Wwq+iI6wkLIK0afOedRmeVaWf1tzShEYbV41pwfRblwySpgW+yVjpVGLP4c9nxYOc
         xjc7GUzxXxlSpJzmB9z4hUm1T9/It3NQo278NGHhaW2g2SVGd6KvS9x75vjbBr2v+wcB
         ME3AVs+Ih3EuF6k2q0RK1Y7KVG9KOA8BGCqm5BuPMhqbKYasDpTBR17qObNrV50YrElR
         NYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936705; x=1699541505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgwt3hqwAjJDNFAnGfG7utbhaV6aSewJTTMtHQOAwPY=;
        b=uYFpeWD+ujsf7iirTl8ayynbAruMNOovgQnbO/dCqNjhefCyWMIGq8vEkn392ABC08
         CA13XAc4WSr2ruT3INXWRjvYKVysx3o0PlsiU6Rv24drm8LUGR9p+mxdAeyQZ+RRBSug
         Yb4uVYdCQg0AxRiIA3Lrp8L8lTeFHCY3OahM1VKP/RgEpcozjYhnk6i6+4qMVFOIhqbM
         QGJS6ruSb04ShzdTwzaZj+uiBQP8LqVytSk/abX2XdMEHttQTNT+wCEcU7WcXgX2PZYq
         Vb65cBJfZ4w803sn/5l+rRrluO3gc+UzH8j8SCDKqJV9OO+amdlDpSkgpVZMOLBqRQsj
         UXqA==
X-Gm-Message-State: AOJu0YzSFOFF3u2pe7KeqnJgYE+PvvBEXIUGTCOWWIwymKMkL3UAgWu9
	+DiIzl28tnVeiDF/N8MNeSdp0h4+3ok/34+USMwGtw==
X-Google-Smtp-Source: AGHT+IH9qpwOErMpJnxVSn5tFfP+4ijhEeqCG2uLPpf9SO/14241kKXlnt1U2G7WgLcyGuajvl+X1cJT7aTGOJKcR7E=
X-Received: by 2002:a25:bfc8:0:b0:da0:69e4:29d5 with SMTP id
 q8-20020a25bfc8000000b00da069e429d5mr14495095ybm.43.1698936705474; Thu, 02
 Nov 2023 07:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027135142.11555-1-daniel@iogearbox.net> <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
 <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net> <5ca2062477738b804ce805847f7aec024ad5988c.camel@redhat.com>
 <CAM0EoMnb8nGJ8U6czNix-qnf9pawZMzmdGKwyfAhbA3nsoWsRA@mail.gmail.com> <ae2e83fffb89973ba77220d01b4cac192d79ef6c.camel@redhat.com>
In-Reply-To: <ae2e83fffb89973ba77220d01b4cac192d79ef6c.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 2 Nov 2023 10:51:34 -0400
Message-ID: <CAM0EoMm=iCz2EX8vjT3URn66Um6whQuRH7its4ABSfxy6Q2Fig@mail.gmail.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, idosch@idosch.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2023-11-02 at 08:47 -0400, Jamal Hadi Salim wrote:
> > On Thu, Nov 2, 2023 at 6:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > > FTR, I agree the comment or even better a build_bug_on() somewhere
> > > should be better.
> >
> > Paolo - Did you see the patch i posted? Ido/Daniel?
>
> Nope, not in my inbox, lore nor PW. I guess a repost will be needed?!?
>

Probably the mistake was to use exactly the same title and most of the
commit message.
Its here:
https://lore.kernel.org/netdev/20231028171610.28596-1-jhs@mojatatu.com/
and
https://patchwork.kernel.org/project/netdevbpf/patch/20231028171610.28596-1=
-jhs@mojatatu.com/

cheers,
jamal

> Thanks
>
> Paolo
>

