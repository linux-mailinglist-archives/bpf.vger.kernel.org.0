Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB946C219
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhLGRxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 12:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235368AbhLGRxC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 12:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638899371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MB5vgB4lpR5cqAqUHi9YG29ue+1AEcuXdupv4jAGE4=;
        b=Mt/tLlz2KcTW/f11Cmo0+dlr08qCbwn7ZA/k/NxM3PVvyO9Zp35FQCAW5eQD0OMaQfCIm/
        0nSpE+K6SQ5tnXDGSY9zLW4JULydd7hhb44olU+T2uZWFY+AjKfFlkjKk8J7nL3O3T8cer
        qgd+/ZfuFuVaIFiXt8x/C5T/RFAKGSQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-429-xNG5VK2UP9SBH6FdgET5ng-1; Tue, 07 Dec 2021 12:49:30 -0500
X-MC-Unique: xNG5VK2UP9SBH6FdgET5ng-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so12157005edx.4
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 09:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+MB5vgB4lpR5cqAqUHi9YG29ue+1AEcuXdupv4jAGE4=;
        b=HwiRiU3YTtMzjm4tuCL/lxvgIJcBcZBdEpW0u2SYhfQ82rSkZ4EXG/5Ui1vWXvBObr
         F2GlkPTfN0ykL5MmhU2bfFnZ9hUvdPujJ68Igx8dKZNF/3QkR7YvGIumnXp/drY0n0Pa
         nelzCsUos9kCUvQt8pSCg2k+1ZrRICbI2h0Vd1KNp82MAEYEekPHN+eFygf7NqilTRsO
         /7Ufa7Eig1syHplWXLjtRV5z4oKAxAoqodxmGt3RoPyOmTE8ijC/LSKesmz0POXb7j0E
         GTndg4sRbmDf+4yaPLkleJFwqw5xEQ+/o/izXqOTw61J1mc9rmb2CIYYW0Troo6wkedg
         OKVA==
X-Gm-Message-State: AOAM532ZaUVAwHYqC8vWi0Fh7KTrwRkHZJi4vFwyIqSakfR/bSGEZrjV
        QKkcKKJORRwdf6HqTCj00OEszJyJOiXtcZFOq8ra51sBddaPkeSaolvATOuJabPwmW3/4W0I/dT
        Lx9V2qxMAGNdD
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr11386739edd.286.1638899367970;
        Tue, 07 Dec 2021 09:49:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRa5Ul9rNKJtolacBM15WQFhZ+Cq0ZZXeWX3QahjtAVpe7QYyBH9Pw7uTEdzk0EvCqckpWnw==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr11386233edd.286.1638899363884;
        Tue, 07 Dec 2021 09:49:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d10sm143510eja.4.2021.12.07.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:49:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9072F180441; Tue,  7 Dec 2021 18:49:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: RE: [PATCH v19 bpf-next 19/23] bpf: generalise tail call map
 compatibility check
In-Reply-To: <61ae4b768d787_8818208f@john.notmuch>
References: <cover.1638272238.git.lorenzo@kernel.org>
 <15afc316a8727f171fd6e9ec93ab95ad23857b33.1638272239.git.lorenzo@kernel.org>
 <61ae4b768d787_8818208f@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Dec 2021 18:49:22 +0100
Message-ID: <87zgpcxq3h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Lorenzo Bianconi wrote:
>> From: Toke Hoiland-Jorgensen <toke@redhat.com>
>> 
>> The check for tail call map compatibility ensures that tail calls only
>> happen between maps of the same type. To ensure backwards compatibility for
>> XDP multi-buffer we need a similar type of check for cpumap and devmap
>> programs, so move the state from bpf_array_aux into bpf_map, add xdp_mb to
>> the check, and apply the same check to cpumap and devmap.
>> 
>> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> Signed-off-by: Toke Hoiland-Jorgensen <toke@redhat.com>
>> ---
>
> ...
>
>> -bool bpf_prog_array_compatible(struct bpf_array *array, const struct bpf_prog *fp);
>> +static inline bool map_type_contains_progs(struct bpf_map *map)
>
> Maybe map_type_check_needed()? Just noticing that devmap doesn't contain
> progs.

Ah, but it does :)

See: fbee97feed9b ("bpf: Add support to attach bpf program to a devmap entry")

Indeed this feature is why this check is needed, so I think the name is
accurate...

-Toke

