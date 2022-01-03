Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEC74836DD
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiACSdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 13:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbiACSdH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 13:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641234786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qN6h930TSM8c/mWmb9+fYi4rE4bqlpIk/doAZAWfiM=;
        b=FeQeI61j36qRlvUlr92L8b8KoxmjtRdVKEkIZ3vvbktB+HMhBi+gK+f9LWLvslLk4sw219
        f7gBDZmNJiKwckSLU6r4k8wO7yVQ61Dlln9JCRqZHhPpJt1kyqtUUf6eAIA0aYsOZjgxpn
        aPgmqZEww1Xg79qxxy7cynzfswgqCFk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-Y92-LA8qPpaUelSD21jsiA-1; Mon, 03 Jan 2022 13:33:05 -0500
X-MC-Unique: Y92-LA8qPpaUelSD21jsiA-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso23423182edt.20
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 10:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4qN6h930TSM8c/mWmb9+fYi4rE4bqlpIk/doAZAWfiM=;
        b=08epcaB9KdzZPOdKUrhGj3y2InBuP6KrQ2tfC2ZI6GXNLMSzgStPLHDA2jk+1wWLYX
         gwpGTrA6IV1tYCvRH2jWVuj8ildTanSFNMiXozKd/WCk1rx+w0ygeotCP9cH6RhCzeQi
         donf2yBSisaQohsDXFb0j4xoJne3DcUqlHMmuBn0AX9vqIo/dThSEP7lgNhXWr1dbXID
         ArgPY3zsrbz+gyNTlXL590vsIlksYo4EHLMDRMau6oDqbZ010BZXH3924xkoRkyVY7XO
         SNdTJedbDLvoZBdAXFTGgLM8Zf5zED6XSc+QEpOkxTvRyTSB4vJoQqBtfBr2KMj3UsCZ
         AnEQ==
X-Gm-Message-State: AOAM531YjkcjuhZJk85v9K/SS43d5hiHtN/FTpkIC61Ba1eZoKJat/Wl
        PlVjeoIYmfFGYoQSrQjwf1kaut94QjSNKb+BsaWaCl5eziQhDl8uiKee0fVsV7qKynnEDiuF4B2
        Pv7PL6tDTxhpt
X-Received: by 2002:a17:907:8a26:: with SMTP id sc38mr37867240ejc.557.1641234783818;
        Mon, 03 Jan 2022 10:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKxgJw62ZH8iVdOI6GaU3nt3iU+z1YpGQfKs7zSUDnMVC+C/Tmlb6WAQgVo32A/ZkGpAuq5g==
X-Received: by 2002:a17:907:8a26:: with SMTP id sc38mr37867212ejc.557.1641234783361;
        Mon, 03 Jan 2022 10:33:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 3sm10873367ejq.159.2022.01.03.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 10:33:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53268180300; Mon,  3 Jan 2022 19:33:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: Adding arch_prepare_bpf_trampoline support for aarch64?
In-Reply-To: <CAADnVQJ9W99v-_P_zE+fPfnR45=jry7RxPNYRL1enYcKF547Hg@mail.gmail.com>
References: <CAFbkdV3Bj=gM0dd6LBaXyc-V79Y0Ewy7xKF5TQT_6H0sCpxE6A@mail.gmail.com>
 <CAADnVQJ9W99v-_P_zE+fPfnR45=jry7RxPNYRL1enYcKF547Hg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 03 Jan 2022 19:33:02 +0100
Message-ID: <87ee5od601.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Dec 29, 2021 at 2:12 AM Huichun Feng <foxhoundsk.tw@gmail.com> wrote:
>>
>> Hi Jean and the list,
>>
>> Attaching BPF to fentry/fexit hooks requires
>> arch_prepare_bpf_trampoline(), which
>> AFAIK has only been implemented on x86. Is there any related ongoing patch for
>> aarch64?
>>
>> I've found a discussion [0] on this, and seems there has no further discussion.
>
> No patches have been posted since then.
> If you have cycles to pick up this work it would be awesome!

+1, would love to see this! :)

-Toke

