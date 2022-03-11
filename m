Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9E4D643D
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiCKPDW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 10:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbiCKPDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 10:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7E7B1A41EE
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647010936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhFk1vrA84GqSz25RsRFDbGtNHQdmxiZdJu+41NtC5A=;
        b=jKmVkdNBIChMqM46d4bTC6+RhdhH4lQ2dNP8FAj9ymE/i6zaDQUFbxD1GKsUlE5DHswx63
        nVHMEhqwxHGiMUNnI/lt+gI9/rlJrBegJfXo8fJyJQxMrsA4lm4O2dgStQiDIBhPrv88JC
        zJ3IgykleLUgvbnIqintSKKOj7qZ1+Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-G6fEr59aNi6O_xepDBIVrg-1; Fri, 11 Mar 2022 10:02:15 -0500
X-MC-Unique: G6fEr59aNi6O_xepDBIVrg-1
Received: by mail-ej1-f70.google.com with SMTP id og24-20020a1709071dd800b006dab87bec4fso5106888ejc.0
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 07:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bhFk1vrA84GqSz25RsRFDbGtNHQdmxiZdJu+41NtC5A=;
        b=rQ9tFZ+DH4dxBKGZvqScL7fUmmZIINIM9siHpW8DbEB6HM3CPDzqytBhRoGZzwuEDf
         mukR395kVP3Q4s6tqups1w3chHrt9K3hhFRDoEZoFqubI6wLRcRR8t1VZat896TIPKZc
         4plfmkWQcBLyhsCG7SKvOsUy3Mf+Jrst6W8H5lkBEiMpGfmKX0iDC8x2/d6ddzeeJx8V
         U14QSKci8fTaHl2zUZ0mwBFCfmmze1lzeUyaQ162+4OG9g4sTq2k6BWVTyA6+EHvYe9B
         +PHkYgrrB3WfxZNI+pAhwI0CeHJSwMpWiEn0m5RsjJzYLbjVTZy9VvaE1RLy5JQVCgWx
         Q9pA==
X-Gm-Message-State: AOAM5322UUb+xPct54hPYDHiRBNT8ZP8q76cdFEZ+trZsofLpVOUCu7L
        A2lkmYtETVEOMOLUl+Cqx5NiLvTd+gaP/mICFzfu/naBF2HRjGrGdVM9XcJdrZuedPoHjBu6KwE
        BIYu92naXzBdv
X-Received: by 2002:a05:6402:51cd:b0:416:a841:22a0 with SMTP id r13-20020a05640251cd00b00416a84122a0mr9249849edd.292.1647010931894;
        Fri, 11 Mar 2022 07:02:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQqG7/HKprlozH6n4cYd5+WV/+EBJ822bf0OnhKKBU64innPa8mWZQ3flMcquO9EbmlWsSog==
X-Received: by 2002:a05:6402:51cd:b0:416:a841:22a0 with SMTP id r13-20020a05640251cd00b00416a84122a0mr9249685edd.292.1647010930106;
        Fri, 11 Mar 2022 07:02:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm3033434ejc.42.2022.03.11.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:02:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E251F1AB573; Fri, 11 Mar 2022 16:02:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        syzbot+0e91362d99386dc5de99@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix packet size check for
 live packet mode
In-Reply-To: <20220311000511.atows3k5uzggg6wf@kafai-mbp.dhcp.thefacebook.com>
References: <20220310225621.53374-1-toke@redhat.com>
 <20220311000511.atows3k5uzggg6wf@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Mar 2022 16:02:08 +0100
Message-ID: <87sfrown0v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Thu, Mar 10, 2022 at 11:56:20PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> The live packet mode uses some extra space at the start of each page to
>> cache data structures so they don't have to be rebuilt at every repetiti=
on.
>> This space wasn't correctly accounted for in the size checking of the
>> arguments supplied to userspace. In addition, the definition of the frame
>> size should include the size of the skb_shared_info (as there is other
>> logic that subtracts the size of this).
>>=20
>> Together, these mistakes resulted in userspace being able to trip the
>> XDP_WARN() in xdp_update_frame_from_buff(), which syzbot discovered in
>> short order. Fix this by changing the frame size define and adding the
>> extra headroom to the bpf_prog_test_run_xdp() function. Also drop the
>> max_len parameter to the page_pool init, since this is related to DMA wh=
ich
>> is not used for the page pool instance in PROG_TEST_RUN.
>>=20
>> Reported-by: syzbot+0e91362d99386dc5de99@syzkaller.appspotmail.com
>> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RU=
N")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/bpf/test_run.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 24405a280a9b..e7b9c2636d10 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -112,8 +112,7 @@ struct xdp_test_data {
>>  	u32 frame_cnt;
>>  };
>>=20=20
>> -#define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head)	\
>> -			     - sizeof(struct skb_shared_info))
>> +#define TEST_XDP_FRAME_SIZE (PAGE_SIZE - sizeof(struct xdp_page_head))
>>  #define TEST_XDP_MAX_BATCH 256
>>=20=20
>>  static void xdp_test_run_init_page(struct page *page, void *arg)
>> @@ -156,7 +155,6 @@ static int xdp_test_run_setup(struct xdp_test_data *=
xdp, struct xdp_buff *orig_c
>>  		.flags =3D 0,
>>  		.pool_size =3D xdp->batch_size,
>>  		.nid =3D NUMA_NO_NODE,
>> -		.max_len =3D TEST_XDP_FRAME_SIZE,
>>  		.init_callback =3D xdp_test_run_init_page,
>>  		.init_arg =3D xdp,
>>  	};
>> @@ -1230,6 +1228,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>>  			batch_size =3D NAPI_POLL_WEIGHT;
>>  		else if (batch_size > TEST_XDP_MAX_BATCH)
>>  			return -E2BIG;
>> +
>> +		headroom +=3D sizeof(struct xdp_page_head);
> The orig_ctx->data_end will ensure there is a sizeof(struct skb_shared_in=
fo)
> tailroom ?  It is quite tricky to read but I don't have a better idea
> either.

Yeah, the length checks are all done for the non-live data case (in
bpf_test_init()), so seemed simpler to just account the extra headroom
to those checks instead of adding an extra check to the live-packet
code.

> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thanks!

-Toke

