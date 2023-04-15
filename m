Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4F6E31AA
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 16:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDOOBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDOOBm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 10:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E434481
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681567254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nW69+UD3T6sxmMEa/058zAi5RjVrmjAZ+4ynj8Sv9MQ=;
        b=i34me3P/ihHol+QQsyfzUtSt96iBQ3Dn8+s0jlJJ5mnRWBu5aaNuSlgxZRs3F0Lv0QoL5N
        FHfKAQM+vJiK9iGlc96l0uaOK9AhmQcqqFdKLYZjbwrbkwu/zzwPBRnYUJoZJDLKB/72oh
        d+g54G9tnw5yRyB6yVBi0juhef6lbIA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ChScZpxuNXGdKtz1kh9wKg-1; Sat, 15 Apr 2023 10:00:53 -0400
X-MC-Unique: ChScZpxuNXGdKtz1kh9wKg-1
Received: by mail-ed1-f70.google.com with SMTP id z34-20020a509e25000000b00504ed11e0c5so6161398ede.1
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681567252; x=1684159252;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW69+UD3T6sxmMEa/058zAi5RjVrmjAZ+4ynj8Sv9MQ=;
        b=FbBt+5/fQW3ZClJo3rcOLksqAl2+qjFmFpYIaTiw2hLA2Z+PC41AmGS17KLDdO5JvC
         THnh4EjjD9aULL3uF+i4y12vcI0myOtlpEFmVxsKAn+lpWN5e+ZCMgX2aZV3hns/Y3du
         W7eVl0iWPOvzrPL9byfUz3QXM4dUs/bbGVBEF8qdX3Av5YE2rtu1tEJTgeekAaXa0k4K
         nHtk3xt2gg+9lR6We9jT8MQM7ZgntKV/pRBoilaKhBBCw2ZlkKT7FFLFxXERltwDFVqW
         u32zyUaiZSzS9uMuzsK1WyP3RvAPADXSjvv3Bl3BfhTI7d0gj7CkjD2kGjSV9GVKepW3
         fPRA==
X-Gm-Message-State: AAQBX9eJqbt/KEvrKrabMug7s4rqu2ukpMVbWY2PJsKZV5nhymVIUuqD
        SZk+xAjOG7sOgKETax37u1ZplBjkuQiXcFvOxKoe+2+lJoGDY/L/4efnxFPwL2zFfPgudopoJ8U
        3YbXObri97LTd
X-Received: by 2002:a17:906:c809:b0:87b:6bbb:11ac with SMTP id cx9-20020a170906c80900b0087b6bbb11acmr2004771ejb.60.1681567252307;
        Sat, 15 Apr 2023 07:00:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZONno3o52Dh2RoBRJsQ/8EgyrNbjPGFlxrdmhGs0NzRWMFuOpFIugINotJKwcY0giTDxLYbA==
X-Received: by 2002:a17:906:c809:b0:87b:6bbb:11ac with SMTP id cx9-20020a170906c80900b0087b6bbb11acmr2004736ejb.60.1681567251939;
        Sat, 15 Apr 2023 07:00:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gv35-20020a1709072be300b0094f07545d43sm1308273ejc.188.2023.04.15.07.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 07:00:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE36BAA7F7C; Sat, 15 Apr 2023 16:00:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>, martin.lau@linux.dev
Subject: Re: [PATCH net-next] bpf, net: Support redirecting to ifb with bpf
In-Reply-To: <c68bf723-3406-d177-49b4-6d5b485048de@iogearbox.net>
References: <20230413025350.79809-1-laoar.shao@gmail.com>
 <968ea56a-301a-45c5-3946-497401eb95b5@iogearbox.net>
 <874jpj2682.fsf@toke.dk>
 <ee52c2e4-4199-da40-8e86-57ef4085c968@iogearbox.net>
 <875y9yzbuy.fsf@toke.dk>
 <c68bf723-3406-d177-49b4-6d5b485048de@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 15 Apr 2023 16:00:50 +0200
Message-ID: <87o7npxn1p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 4/14/23 6:07 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
> [...]
>> https://git.openwrt.org/?p=3Dproject/qosify.git;a=3Dblob;f=3DREADME
>
> Thanks for the explanation, that sounds reasonable and this should ideally
> be part of the commit msg! Yafang, Toke, how about we craft it the follow=
ing
> way then to support this case:

SGTM! With the kbot complaint fixed:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

