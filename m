Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE20426F90
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhJHRdB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 13:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhJHRdB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 13:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633714265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXr/Kgtx/uMX23KWJLjXBvCgcDK/MJr/f3rG38IO2T4=;
        b=WAOoaQorJU19hYegOaYonTmatPTCN+t7PPqILlFj18hBLva8HXSiJshs+bqjR3Jiqp5+ij
        hQ16f0DAF/6+g9Md5W9FlviFl32lqiAPGBdeRcYFsCSXZZ6i8OpRmLspt6koLVDRgfiBiI
        YNmdEKdnOwJnWIFWs/MCCzXTNdWKCkI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-fym8VCcMN524VCKuIibfhQ-1; Fri, 08 Oct 2021 13:31:03 -0400
X-MC-Unique: fym8VCcMN524VCKuIibfhQ-1
Received: by mail-ed1-f72.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso9841087edt.11
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 10:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nXr/Kgtx/uMX23KWJLjXBvCgcDK/MJr/f3rG38IO2T4=;
        b=wV/Kwzcu0jM1QFl9DHubYuvLV0U+YCjyJ9TypJhaVOPxL8JNFBRij4WfUM8UZYB6fg
         wmQClOGTDTATng3/cLxsm/oDIT4cdWuKGoyA0dzMb5BAlM1uugQdWjm8POReFXPVguAJ
         16eQte5IVh2dyFaL/W8QNLis0Kae0dWfp4UqrJENglv42DgMk26oKriciWCIFbPZh5Bl
         zFMiOEZTZUzAP/pejh1bPgSFnaznXfnslm0+EVuzktiD9vsOPjwILpV80ztA8cMIexpZ
         fj0yNFdVptUAisM11rSqi6hD03J54DVZeyviMTL2lec5klcXJM6TQJ4oGCFUDaC1BpjL
         J2CQ==
X-Gm-Message-State: AOAM533jEz+e5bTGMMDZMQAn/Nc0H3tTUvJqRTlf8IU1aNYqG7OoWDRy
        eRI0gpUyWrhTa5Urz8Kurwr051kq2zzMEZKx8oUnr257vOEvbaZmQWUjTwfK6T4pC+7vbPHxbvZ
        ut25K7UNTozw+
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr135321edd.190.1633714261388;
        Fri, 08 Oct 2021 10:31:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYEs6KUgcj6Urs+uu0QBiuBPS7CvL6ILyydM0PrPVTRh7MwbyP6uHOHOu5z752JDMuBel1Rg==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr135265edd.190.1633714260963;
        Fri, 08 Oct 2021 10:31:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v10sm1287615edt.24.2021.10.08.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:31:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8FDC6180151; Fri,  8 Oct 2021 19:30:59 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
In-Reply-To: <20211008000309.43274-10-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-10-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Oct 2021 19:30:59 +0200
Message-ID: <87pmsfl8z0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

andrii.nakryiko@gmail.com writes:

> From: Andrii Nakryiko <andrii@kernel.org>
>
> Map name that's assigned to internal maps (.rodata, .data, .bss, etc)
> consist of a small prefix of bpf_object's name and ELF section name as
> a suffix. This makes it hard for users to "guess" the name to use for
> looking up by name with bpf_object__find_map_by_name() API.
>
> One proposal was to drop object name prefix from the map name and just
> use ".rodata", ".data", etc, names. One downside called out was that
> when multiple BPF applications are active on the host, it will be hard
> to distinguish between multiple instances of .rodata and know which BPF
> object (app) they belong to. Having few first characters, while quite
> limiting, still can give a bit of a clue, in general.
>
> Another downside of such approach is that it is not backwards compatible
> and, among direct use of bpf_object__find_map_by_name() API, will break
> any BPF skeleton generated using bpftool that was compiled with older
> libbpf version.
>
> Instead of causing all this pain, libbpf will still generate map name
> using a combination of object name and ELF section name, but it will
> allow looking such maps up by their natural names, which correspond to
> their respective ELF section names. This means non-truncated ELF section
> names longer than 15 characters are going to be expected and supported.
>
> With such set up, we get the best of both worlds: leave small bits of
> a clue about BPF application that instantiated such maps, as well as
> making it easy for user apps to lookup such maps at runtime. In this
> sense it closes corresponding libbpf 1.0 issue ([0]).

I like this approach. Only possible problem I can see is that it might
be confusing that a map can be looked up with one name, but that it
disappears once it's loaded into the kernel (and the BPF object is
closed).

Hmm, couldn't we just extend the kernel to accept longer names? Kinda
like with the netdev name aliases: support a secondary label that can be
longer, and have bpftool display both?

-Toke

