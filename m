Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072AD3245C3
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 22:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhBXV1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 16:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232245AbhBXV1L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 16:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614201943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUUlZYULShVGQbqbmrqnJUK4YSqsVE96ayCUiq89EBo=;
        b=CMHWR3gCqv/25h+XponFIGP6LjxiGKhqiOsGmX8V2EcwT5hVzV5RrufZ/rn5OSK9IeAlSD
        pkj7kn+n628X083DERWuuJseOJJCMIpxCKs33kfUsVqcPzaHTJeA35VO4Yul6tvnh7PBZG
        CLSSEy5s/dqCeDrPATkqO6RCqN3hgvY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-jyaD6sEkPuW_sMinYU0D8Q-1; Wed, 24 Feb 2021 16:25:41 -0500
X-MC-Unique: jyaD6sEkPuW_sMinYU0D8Q-1
Received: by mail-ej1-f71.google.com with SMTP id p6so1428499ejw.1
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 13:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MUUlZYULShVGQbqbmrqnJUK4YSqsVE96ayCUiq89EBo=;
        b=FU/hwCUYIXsbiFtXXy7oiMLqeiK5TaML1wDoRmuslMzy79hnhbNJrkjLp7CGdPxvac
         dSXBMSINZ/4rDirtcQG58S+FgTATCf6HbxTOfMTTRAr+AvDLgK06/MbHq4fQmEZWMeMO
         XPEEKEwwjg6KrMWHyOe1/hJwhL/WpXNJUbmKcgl48xjtfnhJF/vxj4Tim/fUoANZ3qA0
         xYI0gBeE+LbND7/D/4DGvY6dmcbRkV+jq35Yfs/tYwNhcLTSjWt7eokBJee1qn/pUYIq
         x6Xx6pCf0uuIpWgQ68bmd59D3jholQVJrzIRhnNtJ6e1m4Kh5rsUl+mD83vFolhhj17h
         AEKQ==
X-Gm-Message-State: AOAM532r35MckDGAyFP7cACPmAhyYZ0NWC531KX4XGaqi9TN/3bjZKsJ
        3UbM9PLLei/mRwabbO5Kze0N/M2IaquOmYLPNi6/0Pr5wMiAQBVQRje5xPzW/yMhtIoM6xjosgS
        uO66LlvyqyB1Y
X-Received: by 2002:a17:906:2e91:: with SMTP id o17mr29539019eji.488.1614201939632;
        Wed, 24 Feb 2021 13:25:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY34lO9NwD1FrPh/fWViZPF8MDAlCcW896jBsrXPWjuY8ikLTSXrf5U8+2nSSV9l1g2+DuQA==
X-Received: by 2002:a17:906:2e91:: with SMTP id o17mr29539003eji.488.1614201939348;
        Wed, 24 Feb 2021 13:25:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y8sm2214305edd.97.2021.02.24.13.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:25:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B3E3180094; Wed, 24 Feb 2021 22:25:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf@vger.kernel.org, kpsingh@chromium.org, will@kernel.org
Subject: Re: arch_prepare_bpf_trampoline() for arm ?
In-Reply-To: <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
References: <CA+hQ2+hhDG2JprNLaUdX4xgcihvchEda1aJuQN3jtJ3hYucDcQ@mail.gmail.com>
 <6af0ab27-48f1-e389-d2f4-41b3c1db4a18@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Feb 2021 22:25:38 +0100
Message-ID: <87blc92m5p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 2/24/21 8:54 PM, Luigi Rizzo wrote:
>> I prepared a BPF version of kstats[1]
>> https://github.com/luigirizzo/lr-cstats
>> that uses fentry/fexit hooks to monitor the execution time
>> of a kernel function.
>> 
>> I hoped to have it working on ARM64 too, but it looks like
>> arch_prepare_bpf_trampoline() only exists for x86.
>> 
>> Is there any outstanding patch for this function on ARM64,
>> or any similar function I could look at to implement it myself ?
>
> Not that I'm currently aware of, arm64 support would definitely be great
> to have. From x86 side, the underlying arch dependency was basically on
> text_poke_bp() to patch instructions on a live kernel. Haven't checked
> recently whether an equivalent exists on arm64 yet, but perhaps Will
> might know.

Adding Jean-Philippe; I believe he is/was working on this...?

-Toke

