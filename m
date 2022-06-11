Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891265473FC
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiFKKzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jun 2022 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiFKKzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jun 2022 06:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D21A57988
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654944906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFarg/JFfmBNFzZqU7SVjcMF+Jom9vKZA2S1tn659A4=;
        b=F26e0U8b4kojl8vICyGZ6GdE9DcAzE/X5iTRme33YeZ/ng5tGSahqDPtQIVQtNGyIz6SI/
        IWR541fXo4fsfR0XWiv5B5p0ZBWTWszT/pmaubTXBY9x+gf6h7pp2apDDWn8ksgeJvS+LM
        yPhv5dw11Wh9KOeDHy/eNisZvNqACb4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-nG6PHE08MZK2p-haMr44mg-1; Sat, 11 Jun 2022 06:55:05 -0400
X-MC-Unique: nG6PHE08MZK2p-haMr44mg-1
Received: by mail-ed1-f72.google.com with SMTP id x15-20020a05640226cf00b004318eab9feaso1155722edd.12
        for <bpf@vger.kernel.org>; Sat, 11 Jun 2022 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yFarg/JFfmBNFzZqU7SVjcMF+Jom9vKZA2S1tn659A4=;
        b=3KzLnPKW541Iq+Yw1uiUEn+im2ujkJCslx5toHLNqCRsyy+NnMVF088fPBqN5YBsIq
         6i0xqQsYskW2nd/d4aHvmUtGufUCd4hBM6MT2hNhtD0zk+hhhl+ssAgkg5NYE/0+/vSy
         ShAqKRokRWyesDGzKyK9VmBODT0CDYvTFfIuprgPkH8N6p+ZSfVYNQXa5J6zvu4KUqTS
         uj7PfB2Dt2k6N844iWSqY3Y48z6GRPgOk1+lFt70PuE+zrqdcfLh+xjNSuOau5CZrrrI
         Yx0xnhppyamlCP1kmM0+QSQrsrRGA7odyxaZTNIoMV+7q9AH24/bwBLit+NYdAEnya+g
         g7Xg==
X-Gm-Message-State: AOAM531A08arPQNQmCGbbuIYbZ5+hjukWFCa/dmg/0+q2nArHqaqYdJo
        wWxqMgGnCR5id51tJP5XZQ3rhRKbDBlygYOME3dmXLaJ6M2AKM0vJbCUvwl/ZVlW3fNeabzhF8l
        w+tQ8wF6UG8gb
X-Received: by 2002:a17:906:7a57:b0:711:faf1:587d with SMTP id i23-20020a1709067a5700b00711faf1587dmr14215392ejo.581.1654944902947;
        Sat, 11 Jun 2022 03:55:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytlhudXWd+3Uadbouwxe3Valh4oMzxQ4EpolAY9C86PXPXsU4CompTcUT3ZFItHpMgyqjkBw==
X-Received: by 2002:a17:906:7a57:b0:711:faf1:587d with SMTP id i23-20020a1709067a5700b00711faf1587dmr14215262ejo.581.1654944900415;
        Sat, 11 Jun 2022 03:55:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7c5c8000000b0042e21f8c412sm1205389eds.42.2022.06.11.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 03:54:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F2637406475; Sat, 11 Jun 2022 12:54:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/7] Add bpf_link based TC-BPF API
In-Reply-To: <15bdc24c-fe85-479a-83fe-921da04cb6b1@iogearbox.net>
References: <20210604063116.234316-1-memxor@gmail.com>
 <CAJnrk1YJe-wtXFF0U2cuZUdd-gH1Y80Ewf3ePo=vh-nbsSBZgg@mail.gmail.com>
 <20220610125830.2tx6syagl2rphl35@apollo.legion>
 <CAJnrk1YCBn2EkVK89f5f3ijFYUDhLNpjiH8buw8K3p=JMwAc1Q@mail.gmail.com>
 <CAJnrk1YCSaRjd88WCzg4ccv59h0Dn99XXsDDT4ddzz4UYiZmbg@mail.gmail.com>
 <20220610193418.4kqpu7crwfb5efzy@apollo.legion> <87h74s2s19.fsf@toke.dk>
 <2f98188b-813b-e226-4962-5c2848998af2@iogearbox.net>
 <87bkv02qva.fsf@toke.dk>
 <CAADnVQLbC-KVNRPgbJP3rokgLELam5ao1-Fnpej8d-9JaHMJPA@mail.gmail.com>
 <15bdc24c-fe85-479a-83fe-921da04cb6b1@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Jun 2022 12:54:58 +0200
Message-ID: <874k0r31x9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/10/22 11:52 PM, Alexei Starovoitov wrote:
>> On Fri, Jun 10, 2022 at 1:41 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>>
>>>>> Except we'd want to also support multiple programs on different
>>>>> priorities? I don't think requiring a libxdp-like dispatcher to achie=
ve
>>>>> this is a good idea if we can just have it be part of the API from the
>>>>> get-go...
>>>>
>>>> Yes, it will be multi-prog to avoid a situation where dispatcher is ne=
eded.
>>>
>>> Awesome! :)
>>=20
>> Let's keep it simple to start.
>> Priorities or anything fancy can be added later if really necessary.
>> Otherwise, I'm afraid, we will go into endless bikeshedding
>> or the best priority scheme.
>>=20
>> A link list of bpf progs like cls_bpf with the same semantics as
>> cls_bpf_classify.
>> With prog->exts_integrated always true and no classid, since this
>> concept doesn't apply.
> Yes, semantics must be that TC_ACT_UNSPEC continues in the list and
> everything else as return code would terminate the evaluation.

Sure, SGTM!

-Toke

