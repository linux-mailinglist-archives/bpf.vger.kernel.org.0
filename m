Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2E3F187F
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhHSLsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 07:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238105AbhHSLsc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 07:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629373675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zQcMqwa53jnwixjh8Le0hk8Ov2voDGT6ZkF7r4VIlY=;
        b=Kxt1+/aU8wz98gsjzWxD7cBuwKNa6cIWcDVU68SyRpgcfdv3kGblbCAnaE4kgFY+pk1ics
        Vt8AQkTYzORI/W+HR/xFZqKDDWqJthqkZgTSRdbzZwu6CVeVBSPGCELVP0dJoxcA/IG/u1
        +j7atY9LxJHmQ8xGVgalXIer07FZQi0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-SBJ__jLHMFmToe0spxgn9w-1; Thu, 19 Aug 2021 07:47:54 -0400
X-MC-Unique: SBJ__jLHMFmToe0spxgn9w-1
Received: by mail-ej1-f71.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so2152928ejc.12
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 04:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3zQcMqwa53jnwixjh8Le0hk8Ov2voDGT6ZkF7r4VIlY=;
        b=T5Xukz/zaUoMqpBVrq+5Mb5HJB63Uy24wfCg/kgukF94W68LgnFXzsDkVO4JuHzrox
         NnVzBpORVpuyz/VOwisg3FpfnyCHVesGJPjzz81eeMJx/cb8X+4NA1hfVjvXmegtUmkW
         2XKS7LxKU4hIdbnkboc5QZMWIiZO9Dcn6/L1Y+cjbUUnoFOOOP88Mu8DzdSPdLkYAVGs
         ppI3g6B9uBIR8KUcSUvWVkUeM3REwZXzXwEyLb1xdT1fdV9fr+AkNk2qG3kVLaAK3kxJ
         bGcT6f5N+HTSVSEKO7eY0qnaC7tVgxdHgfIU8kLQhFxsxBVeIV0d4Mhxt5MRGUv9DimL
         +9dQ==
X-Gm-Message-State: AOAM531EbpAeBAoSELL8Ft4+LFphUqy3Iji8whmBlpwhj80FHaIZFAm5
        ieax8ClEYuYxKaD9Aum947xD87TSrr8ma4dlDLfF1YKFrde2Su3VwTw5HpxL5saOViivfJLaCcG
        5Xs2glh4epoef
X-Received: by 2002:a05:6402:1d84:: with SMTP id dk4mr16107017edb.114.1629373673205;
        Thu, 19 Aug 2021 04:47:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHohZ5NfdmxdcGhQq+Sndo1LWlgOd7+f4Ug8TqM04qPyRrNbnp81HCpBHM9zRckngR6gaB0w==
X-Received: by 2002:a05:6402:1d84:: with SMTP id dk4mr16106968edb.114.1629373672675;
        Thu, 19 Aug 2021 04:47:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f12sm1166408ejz.99.2021.08.19.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:47:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D2728180471; Thu, 19 Aug 2021 13:47:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ederson de Souza <ederson.desouza@intel.com>
Cc:     xdp-hints@xdp-project.net, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [[RFC xdp-hints] 13/16] libbpf: Helpers to access XDP frame
 metadata
In-Reply-To: <CAEf4BzZ44wc-+r6o7vthddt5BoePdg0cQn83g8qkyPMAca4vvA@mail.gmail.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
 <20210803010331.39453-14-ederson.desouza@intel.com>
 <CAEf4BzZ44wc-+r6o7vthddt5BoePdg0cQn83g8qkyPMAca4vvA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 19 Aug 2021 13:47:50 +0200
Message-ID: <87r1eppsex.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Aug 2, 2021 at 6:04 PM Ederson de Souza
> <ederson.desouza@intel.com> wrote:
>>
>> Two new pairs of helpers: `xsk_umem__adjust_prod_data` and
>> `xsk_umem__adjust_prod_data_meta` for data that is being produced by the
>> application - such as data that will be sent; and
>> `xsk_umem__adjust_cons_data` and `xsk_umem__adjust_cons_data_meta`,
>> for data being consumed - such as data obtained from the completion
>> queue.
>>
>> Those function should usually be used on data obtained via
>> `xsk_umem__get_data`. Didn't change this function to avoid API breaks.
>>
>> Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
>> ---
>
> AF_XDP parts of libbpf are being moved into libxdp ([0]). We shouldn't
> keep adding new APIs if we are actively working on deprecating and
> removing existing functionality already. CC'ing Toke and Magnus for
> the state of libxsk to libxdp migration.
>
>   [0]
>   https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp#using-af_xdp-sockets

The AF_XDP code is merged into libxdp and is fully functional with the
exception of Maciej's XDP program auto-detach feature which we need to
replicate in a different way in libxdp.

So as far as I'm concerned, we can just go ahead and accept patches for
AF_XDP in libxdp. Does anyone have any thoughts on a preferred workflow?
Having the libxdp patches completely separate in a Github PR seems like
it will be an annoying workflow, so what to do instead?

-Toke

