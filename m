Return-Path: <bpf+bounces-8385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA1785C50
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC031C20CB2
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A59C8F4;
	Wed, 23 Aug 2023 15:43:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD022905;
	Wed, 23 Aug 2023 15:43:47 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893BE70;
	Wed, 23 Aug 2023 08:43:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so96600311fa.0;
        Wed, 23 Aug 2023 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805425; x=1693410225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE3wqcNpOoc+MtIIQwAoQiiefvXPr9F892w05vM/6pQ=;
        b=AjCtHzz+Ta8GojfWKrW1Ohnoc3kyEMJk+YoAbn3pNEBupc+aqqUotQKv/8VdVYkcSF
         +9PNwqPdWhXLbdG6iLi+xSUR3dpOfWaIOTXK7nUmtfxcyiDMEcoIwy4ct4VUP826vqkz
         SKyMIERNFzlniiMf3Dx1KSdShGNrVRS8WrsctHR/nkCH2kyvyOAWoYop56FfSL7Do84m
         OuSlSSc2XRNeG/L5RPUgRx2yPRZcuZ5LxR1iADhR2ZzeMBO+NuY93zQKbGkZQa49JGgc
         vwow9yAy44WBUiK9O1rQ020or9gq0QFj9knbwn8J0KVWi41NDV0wfLu5Bo0XQyCZUSdO
         DqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805425; x=1693410225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE3wqcNpOoc+MtIIQwAoQiiefvXPr9F892w05vM/6pQ=;
        b=QXTbxyezpzuyVnls5GoddjIMINHOvSrGi7hsXVyADVA275PvMpw0IhF7st56MYcZsM
         KTVm5rFvkdV7Jx5o8uSsdbkftWmKWxKG9Fda8JYXHYITaETXAcwrIBiz+RPTMaaJnNZt
         fsAqimiPPv64Penc8uGopY3gXgLrYTBKloqXZEmvdGuFzrBgj98pSUMpa67wLUzW/HyS
         KEMiaA5W5M2E44BAJraRTrVPggAnMS9BP5LNGBLG3ClnEcyXCHII04k/NDWLFxlAFroL
         Wa/WKXyAP8lCNvsTQqYIT88s+oOThPT1iWxoFNhYTIa23k9zGr8/XUIHrmhrLBkDyTq6
         aPhg==
X-Gm-Message-State: AOJu0YwPSOfgnYsHKXVbRIZPvJZt8m6TI3Jgsj1tHSeBh+aGKGvb5jUe
	ghvcXE8aOc4DEKnTr4TFh4xxvZ5ozw/MlqHR/1u5iAUSZmk=
X-Google-Smtp-Source: AGHT+IFEYRGc3cfoxgyvkJZPI8pZjaALi3OmFHtpEZ4fhakp/Ch1aLuu7pp08XCD1RccnEUr2Zp3vcWDJW8qNhy9c6c=
X-Received: by 2002:a2e:9bc7:0:b0:2bb:99fa:1772 with SMTP id
 w7-20020a2e9bc7000000b002bb99fa1772mr9732655ljj.49.1692805424716; Wed, 23 Aug
 2023 08:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823145346.1462819-1-toke@redhat.com>
In-Reply-To: <20230823145346.1462819-1-toke@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 08:43:33 -0700
Message-ID: <CAADnVQ+rD5S_k81fM82yaK9EEG3yWtEenpA15y9ujvJZVk2n6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] samples/bpf: Remove unmaintained XDP
 sample utilities
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 7:54=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> The samples/bpf directory in the kernel tree started out as a way of show=
casing
> different aspects of BPF functionality by writing small utility programs =
for
> each feature. However, as the BPF subsystem has matured, the preferred wa=
y of
> including userspace code with a feature has become the BPF selftests, whi=
ch also
> have the benefit of being consistently run as part of the BPF CI system.

Did you miss my previous email?

---
Could you add this link with details to samples/bpf/README.rst,
so that folks know where to look for them?

Other than that the set makes sense to me.
---

