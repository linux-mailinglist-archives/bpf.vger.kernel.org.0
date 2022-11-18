Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980A62EA57
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiKRAcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiKRAcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875614C240
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668731477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+itpjDcga9mH0LamyY/OkXi7TD9WUdNLP2cV3k9ii9k=;
        b=X/6NtoYWaMCVuqyOIkbRp5nVzGm2W4v7eY/rE/4H0aQpDz1iAlLZHtCnmEabshSsbNy+Wd
        A0Nyrlv5TQYL6HUCtxg/u6dLf0rDQcla07JtN2m+dxLxgnOd/CYPr49ssdTj6l0AVf7Ccc
        fmW2CJnYN3UuKn2IQVamPaJIOD4arOI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-dBSYzIhjMc-aVwJX-ZOD6A-1; Thu, 17 Nov 2022 19:29:19 -0500
X-MC-Unique: dBSYzIhjMc-aVwJX-ZOD6A-1
Received: by mail-ej1-f69.google.com with SMTP id ne36-20020a1709077ba400b007aeaf3dcbcaso1967664ejc.6
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+itpjDcga9mH0LamyY/OkXi7TD9WUdNLP2cV3k9ii9k=;
        b=6gIOYBGkY3iVCSTpKHwDBPE+wgnQEtnC8yn2kzSGWyDvmijRRe10e0gFJFOUsJ3pXY
         m8U/D4EOJUsQLCnPI4YvQxhK/Mt5VOFdyH87bpLz6nqmTtUq9mskcH2vI/Jr6GpqmymH
         aot5SBZ5wTzOVEOGUx/nnqlXreJjJ83nKDCzKyxkaysKBEbIrGnAEm9Bis5Clwu/12tP
         prXD2XEMVb3NHjd5uPeaf3CoegVtjfM0bCdnJgP1pNUbT08B/fZmxC0S2NlnxvsyV3+c
         skYsPX0rMJ3NMei1ih7taORtXewwUqTtJJ3/peRr7Yz+oQJshL1U7IiOXE2Hpw91P0zb
         F9EA==
X-Gm-Message-State: ANoB5pm8p54+5oA7YMe7sVnlI8JSxlQ2JeyXGSWbgCL9dHUUL0Mqrzn6
        n8TtRs2eqGieieM4VqTHw4I8SQILz9vY0Z54z8pGSZMHvYYmPJPa40VpGzo2u9dBdXEW/MQlFNz
        +wqIvpkAC+No0
X-Received: by 2002:a05:6402:e0d:b0:466:4168:6ea7 with SMTP id h13-20020a0564020e0d00b0046641686ea7mr4041703edh.273.1668731357199;
        Thu, 17 Nov 2022 16:29:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7JF1PQRWwlPFnvVEFf83RM2J/Pz35scEZj/jJa/EJHPfBYm4P9LtURCOCKlui+6HqGeE+lxA==
X-Received: by 2002:a05:6402:e0d:b0:466:4168:6ea7 with SMTP id h13-20020a0564020e0d00b0046641686ea7mr4041673edh.273.1668731356233;
        Thu, 17 Nov 2022 16:29:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id en17-20020a056402529100b00467960d7b62sm1131575edb.35.2022.11.17.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:29:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0F97E7A702D; Fri, 18 Nov 2022 01:29:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 05/11] veth: Support rx
 timestamp metadata for xdp
In-Reply-To: <CAADnVQJ=MbwUOTtmYb_VmTEBA8SdYXJryfGoYv2W2US3_Es=kA@mail.gmail.com>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-6-sdf@google.com> <87h6z0i449.fsf@toke.dk>
 <CAKH8qBsEGD3L0XAVzVHcTW6k_RhEt74pfXrPLANuznSAJw7bEg@mail.gmail.com>
 <8735ajet05.fsf@toke.dk>
 <CAKH8qBsg4aoFuiajuXmRN3VPKYVJZ-Z5wGzBy9pH3pV5RKCDzQ@mail.gmail.com>
 <6374854883b22_5d64b208e3@john.notmuch>
 <34f89a95-a79e-751c-fdd2-93889420bf96@linux.dev> <878rkbjjnp.fsf@toke.dk>
 <6375340a6c284_66f16208aa@john.notmuch>
 <CAKH8qBs1rYXf0GGto9hPz-ELLZ9c692cFnKC9JLwAq5b7JRK-A@mail.gmail.com>
 <637576962dada_8cd03208b0@john.notmuch>
 <CAKH8qBtOATGBMPkgdE0jZ+76AWMsUWau360u562bB=cGYq+gdQ@mail.gmail.com>
 <CAADnVQKTXuBvP_2O6coswXL7MSvqVo1d+qXLabeOikcbcbAKPQ@mail.gmail.com>
 <CAKH8qBvTdnyRYT+ocNS_ZmOfoN+nBEJ5jcBcKcqZ1hx0a5WrSw@mail.gmail.com>
 <87wn7t4y0g.fsf@toke.dk>
 <CAADnVQJMvPjXCtKNH+WCryPmukgbWTrJyHqxrnO=2YraZEukPg@mail.gmail.com>
 <CAKH8qBsPinmCO0Ny1hva7kp4+C7XFdxZLPBYEHXQWDjJ5SSoYw@mail.gmail.com>
 <874juxywih.fsf@toke.dk>
 <CAADnVQJ=MbwUOTtmYb_VmTEBA8SdYXJryfGoYv2W2US3_Es=kA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Nov 2022 01:29:15 +0100
Message-ID: <87sfihxfz8.fsf@toke.dk>
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

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Nov 17, 2022 at 3:46 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> >
>> > Ack. I can replace the unrolling with something that just resolves
>> > "generic" kfuncs to the per-driver implementation maybe? That would at
>> > least avoid netdev->ndo_kfunc_xxx indirect calls at runtime..
>>
>> As stated above, I think we should keep the unrolling. If we end up with
>> an actual CALL instruction for every piece of metadata that's going to
>> suck performance-wise; unrolling is how we keep this fast enough! :)
>
> Let's start with pure kfuncs without requiring drivers
> to provide corresponding bpf asm.
> If pure kfuncs will indeed turn out to be perf limiting
> then we'll decide on how to optimize them.

I'm ~90% sure we'll need that optimisation, but OK, we can start from a
baseline of having them be function calls...

-Toke

