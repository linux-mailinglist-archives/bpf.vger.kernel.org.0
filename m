Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D30355E04
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhDFVf1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 17:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242098AbhDFVf1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 17:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617744918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpN8Kh7q/orjObX7zp1HqUcJQbSHGIFAdNalMLjTGps=;
        b=cBKRFj3w6P3jijUbyI3PsjSzLuByjj27JupplM7/5qp4p94b3AYyJl08AyOC8q4O9L9ryq
        w+fwKKd2l/xfL6SpI50qd/tLlCLy2J/yO8dy34p9NP/W5TvLMykP+NbewNEveFBNsAQTkn
        pK2WS+/86WF21dnoOUWIeAHlhAoIi1k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-1qcf-4_NM2mUWJkPzJTkAQ-1; Tue, 06 Apr 2021 17:35:17 -0400
X-MC-Unique: 1qcf-4_NM2mUWJkPzJTkAQ-1
Received: by mail-ej1-f69.google.com with SMTP id gn30so6037272ejc.3
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 14:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dpN8Kh7q/orjObX7zp1HqUcJQbSHGIFAdNalMLjTGps=;
        b=QMWEp/dizaLUNoBonFX9FoS199AXH/HoG8OXdyg8waEPY8A0XI/dbVYjpS9oZcQr/P
         HFXz13cP0F5aPqH4mLJWejgSSQk2HaNDFg5rzxbHdm5IkgRt+faKP5wbassG7IxL1Rwk
         1n2CMeiRSHdBu3PqacxLSw1bIy9f0s7wP//9bCVK+gMEI7IjMKrNlTwpQiJ5WS5mVvA1
         dNYhtERcd0CQlm+HIQAOA4Q4vLqVU9zfyhgMyharcwr1e8waM32jTATS9P8MKmFALoeq
         J2FECvjtHkIwxFqbEvoZziOTipmJ4q6G4xlNgtduS7kLa5NTpJ49T5C2dvMIMnnhWAtU
         HlNw==
X-Gm-Message-State: AOAM532nx/fLf9HRDAJQCWEcs+Y+l9TEEiq55VI53X+PqF86709VARaT
        UBVzydwVFzPeAPABeVmBb5MO7Gcs/ROpEDhJ2YC/c++8ObtlF1m6R/LMS3xMwHwqLSpC+TZfYKx
        Vv0a6lsKklQjV
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr32119ejb.169.1617744915642;
        Tue, 06 Apr 2021 14:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+CL7dEdgQ4m4YY3Ts2c59TsvVs+NRz0pZHUPGS35XAhnFpQVzGhICRF7jrO3/LzsD9tD/5Q==
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr32086ejb.169.1617744915250;
        Tue, 06 Apr 2021 14:35:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b13sm481806edw.45.2021.04.06.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:35:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D4F5180301; Tue,  6 Apr 2021 23:35:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCHv2 bpf-next 1/5] bpf: Allow trampoline re-attach for
 tracing and lsm programs
In-Reply-To: <20210406212913.970917-2-jolsa@kernel.org>
References: <20210406212913.970917-1-jolsa@kernel.org>
 <20210406212913.970917-2-jolsa@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Apr 2021 23:35:14 +0200
Message-ID: <87tuoj2j1p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <jolsa@kernel.org> writes:

> Currently we don't allow re-attaching of trampolines. Once
> it's detached, it can't be re-attach even when the program
> is still loaded.
>
> Adding the possibility to re-attach the loaded tracing and
> lsm programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

