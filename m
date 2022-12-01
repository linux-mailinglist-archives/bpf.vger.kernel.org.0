Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9279963EF08
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLALLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 06:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLALLF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 06:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A4C6E59
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669892785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyFMoLGbYvLkJTYxwwpaklfGNak+P0HaQDsYqV4zhZE=;
        b=NSlY5Mv2tuDdBj+ycFvRor4UPvYJCB40IPQS3nZVTwC/R3iEGyvYcshdb55BkQ1VN/7SmP
        MGGnJG9K46gQYnrRSYfIFyl61QZIUlwN8X3IL3CD05VizsQJpuF1UnVQ5DVMKIA7jb4U8Q
        QBNcRdS2GuGicJ9fCBSP4ztXjNQvm/0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-Mbg2EA5BMDOcrVaEhqmKtg-1; Thu, 01 Dec 2022 06:06:24 -0500
X-MC-Unique: Mbg2EA5BMDOcrVaEhqmKtg-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so691626edz.21
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 03:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyFMoLGbYvLkJTYxwwpaklfGNak+P0HaQDsYqV4zhZE=;
        b=HYotuTjEP7m2d/yQ2UYIcZo8Pa8Zmn4nihJW9GLAPK0vwDUA++pTF6yYozTtnzS9yx
         fXhJWLo+dtb/d1Uwv2gZ35+U3gqHViQYVitaybqd4sQFBNQvMpDX9qTStrcP4n7QNTaY
         LhU63uUYngq2kATNflM21Jfueobis4l4oME+KEMhjT/Zbr3L6/aELFnkfzQ6I6EGFQdL
         jPtwKtCj6YzX4vk171LGVjdXBZ3+kL1alzWtRZMKluf1hYi/XJt1oyNONPTttvI2bgbN
         q9gnXoLKz0X+cPSx7d04ds1X73nCnace0m4kXE2rhL16nkjaH4lxm/qki6Oey97CZSrs
         SxDw==
X-Gm-Message-State: ANoB5pnxcNNj8+LDvVTyQM5FrkdQ2BzzHFWIoodSSlQDQiVC/05uhmFE
        D9yms1KzF5ZG6ucWrJ2KkKpkDm3A/EjMiz38513nfK+280TGIqzZ/MD4u1rUiC8aBljFUCE5su5
        u41wu0GXt1pos
X-Received: by 2002:a17:906:392:b0:7b5:a9df:d83e with SMTP id b18-20020a170906039200b007b5a9dfd83emr45040828eja.358.1669892781709;
        Thu, 01 Dec 2022 03:06:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dNAxQNgTxqAeWdCeke+Ll3q75+mrvpFjBA/NeFS3y1WND2ICroxDrX9/uOId71zkcNOdu4g==
X-Received: by 2002:a17:906:392:b0:7b5:a9df:d83e with SMTP id b18-20020a170906039200b007b5a9dfd83emr45040686eja.358.1669892779152;
        Thu, 01 Dec 2022 03:06:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm1595165eds.78.2022.12.01.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:06:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE09380AFCE; Thu,  1 Dec 2022 12:06:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Add dummy type reference to nf_conn___init
 to fix type deduplication
In-Reply-To: <CAEf4BzafebzBTVqtTHotRcySXPafF5JK11Svpirtnvz7c9O7uQ@mail.gmail.com>
References: <20221130144240.603803-1-toke@redhat.com>
 <CAEf4BzafebzBTVqtTHotRcySXPafF5JK11Svpirtnvz7c9O7uQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Dec 2022 12:06:17 +0100
Message-ID: <87fsdzxu1i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 30, 2022 at 6:42 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> The bpf_ct_set_nat_info() kfunc is defined in the nf_nat.ko module, and
>> takes as a parameter the nf_conn___init struct, which is allocated throu=
gh
>> the bpf_xdp_ct_alloc() helper defined in the nf_conntrack.ko module.
>> However, because kernel modules can't deduplicate BTF types between each
>> other, and the nf_conn___init struct is not referenced anywhere in vmlin=
ux
>> BTF, this leads to two distinct BTF IDs for the same type (one in each
>> module). This confuses the verifier, as described here:
>>
>
> Argh, shouldn't have wasted writing [1], but oh well.
>
>   [1] https://lore.kernel.org/bpf/CAEf4Bza2xDZ45kxxa3dg1C_RWE=3DUB5UFYEuF=
p6rbXgX=3DLRHv-A@mail.gmail.com/

Ah, yeah, crossed streams; as you can see I came to the same conclusion
wrt types being conceptually independent.

>> https://lore.kernel.org/all/87leoh372s.fsf@toke.dk/
>>
>> As a workaround, add a dummy pointer to the type in net/filter.c, so the
>> type definition gets included in vmlinux BTF. This way, both modules can
>> refer to the same type ID (as they both build on top of vmlinux BTF), and
>> the verifier is no longer confused.
>>
>> Fixes: 820dc0523e05 ("net: netfilter: move bpf_ct_set_nat_info kfunc in =
nf_nat_bpf.c")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/core/filter.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index bb0136e7a8e4..1bdf9efe8593 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -80,6 +80,7 @@
>>  #include <net/tls.h>
>>  #include <net/xdp.h>
>>  #include <net/mptcp.h>
>> +#include <net/netfilter/nf_conntrack_bpf.h>
>>
>>  static const struct bpf_func_proto *
>>  bpf_sk_base_func_proto(enum bpf_func_id func_id);
>> @@ -11531,3 +11532,17 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
>>
>>         return func;
>>  }
>> +
>> +#if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_=
MODULES)
>> +/* The nf_conn___init type is used in the NF_CONNTRACK kfuncs. The kfun=
cs are
>> + * defined in two different modules, and we want to be able to use them
>> + * interchangably with the same BTF type ID. Because modules can't de-d=
uplicate
>> + * BTF IDs between each other, we need the type to be referenced in the=
 vmlinux
>> + * BTF or the verifier will get confused about the different types. So =
we add
>> + * this dummy pointer to serve as a type reference which will be includ=
ed in
>> + * vmlinux BTF, allowing both modules to refer to the same type ID.
>> + *
>> + * We use a pointer as that is smaller than an instance of the struct.
>> + */
>> +const struct nf_conn___init *ctinit;
>> +#endif
>
> Use BTF_TYPE_EMIT() instead maybe?

Ah, TIL about that macro; thanks, will fix!

-Toke

