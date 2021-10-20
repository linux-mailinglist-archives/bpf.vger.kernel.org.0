Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284FF4354DF
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTVDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhJTVDa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 17:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634763675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF7FQIu+umaaHoo8uTZ4a7mdVNI6sJmIj2JnPzKuTLg=;
        b=PRVaPrs8YmdDlDsHEmcrqPUYo09e6eae4v+MQXIY1XPfGT7EFHZI0P3qMiJNaue2LyuE2r
        GHfKkZUvxQEiz3yE3GMnwMTD7co3fK4dhS+l8y2ewspDR+Foq2kK7oBJSOZE5E+hGhtJlo
        habk9K+ld/zj9CyLf2jBysc0IKyjUgw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Va6n93thOye1ENazeGzclQ-1; Wed, 20 Oct 2021 17:01:13 -0400
X-MC-Unique: Va6n93thOye1ENazeGzclQ-1
Received: by mail-ed1-f69.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so22186907edi.12
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 14:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xF7FQIu+umaaHoo8uTZ4a7mdVNI6sJmIj2JnPzKuTLg=;
        b=4YgAGRWp4Km8knlopa3aeEh15SjkWa36FbDelqaKVna80DFLdXQUnfXCYz1ucKIFrC
         vNwkswT+GbnTHGLEj6+N4Pv8aJe2YE5FA5+8DXnLQfKOuLFJ9FiV1vCIXOvO/GQ13RQr
         fo5myixM8VyMWkBcKpEEhM+xCzr+SibQDlQRBK0fYUaPMbYZ9F5cD683WZsPe2ia53UA
         wmxK44hSmqkrOaRHg0SsV9IzCP+rtfk5B9FNKARdiI6Dcktwt7JfC04d9hjqQp2V5tav
         kSDJi9GksAdpAnMKR7mwg3jdRLs9XDKdBBDC/MVs2WtKGXgoLJPir8gi8U0xNApG40KR
         ReSQ==
X-Gm-Message-State: AOAM532YDkrhBkWA9yj79VjQxGoH4Hkgak8Lxq9PYEULXlLUaxDE3KXd
        qQpJU45bkCdHLtgZvtNPsjwfnpW6+y+EcdiuHQ+QkUArKIVTINeO2qlK0asBeepKTVaeCNBvlF2
        UrNw6rOr+ShSd
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr2047524ejc.319.1634763671812;
        Wed, 20 Oct 2021 14:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK9cpIuqsC4IbADsAieB2qESZ28NB0YoELWmp65L4FXOvNQ4urYupuCPQfLB7gL4RnjXrTCA==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr2047299ejc.319.1634763669857;
        Wed, 20 Oct 2021 14:01:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y4sm1583906ejw.3.2021.10.20.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:01:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C534180262; Wed, 20 Oct 2021 23:01:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 bpf-next 4/4] libbpf: deprecate
 bpf_program__get_prog_info_linear
In-Reply-To: <CAEf4BzbY+OMR_=JJHdzJpiuar_giusd0sb1LKoCQ7BEDYh57NQ@mail.gmail.com>
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
 <20211011082031.4148337-5-davemarchevsky@fb.com>
 <CAEf4BzbY+OMR_=JJHdzJpiuar_giusd0sb1LKoCQ7BEDYh57NQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Oct 2021 23:01:08 +0200
Message-ID: <87o87je7hn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> As part of the road to libbpf 1.0, and discussed in libbpf issue tracker
>> [0], bpf_program__get_prog_info_linear and its associated structs and
>> helper functions should be deprecated. The functionality is too specific
>> to the needs of 'perf', and there's little/no out-of-tree usage to
>> preclude introduction of a more general helper in the future.
>>
>> [0] Closes: https://github.com/libbpf/libbpf/issues/313
>
> styling nit: don't know if it's described anywhere or not, but when
> people do references like this, they use 2 spaces of indentation. No
> idea how it came to be, but that's what I did for a while and see
> others doing the same.
>
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  tools/lib/bpf/libbpf.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 89ca9c83ed4e..285008b46e1b 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -877,12 +877,15 @@ struct bpf_prog_info_linear {
>>         __u8                    data[];
>>  };
>>
>> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
>>  LIBBPF_API struct bpf_prog_info_linear *
>>  bpf_program__get_prog_info_linear(int fd, __u64 arrays);
>>
>> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
>>  LIBBPF_API void
>>  bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
>>
>> +LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
>
> we can actually deprecate all this starting from v0.6, because perf is
> building libbpf statically, so no worries about releases (also there
> are no replacement APIs we have to wait full release for)

Just FYI, we're also using this in libxdp, and that does link
dynamically to libbpf. It's not an issue to move away from it[0], but
perf is not the only user :)

-Toke

[0] Track that here: https://github.com/xdp-project/xdp-tools/issues/127

