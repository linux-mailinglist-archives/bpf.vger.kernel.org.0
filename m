Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08864C74C
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiLNKmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLNKme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8D23392
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671014516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wdWsTQy1PmtZVWiiL7HDvu5DGURuGqGghZsLS7DEOc=;
        b=H04frUGOxCnKcDvmB8Z58y3MKmxvFmr3HAH1hMDTDGm5l/U4hxf0SbKews2jZJrZ8+vAbX
        sdBVU/UJknRCp6t1PsWAIybk5bSDSA9BpDbsythZ9uMRnnsDNODbMirmS8gBoDZ2RN6z/g
        DcT2av+vGmIIB7+e6cFnum+dvqDko9A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-UIIwOxOKNPSLNGDQEP-vzg-1; Wed, 14 Dec 2022 05:41:54 -0500
X-MC-Unique: UIIwOxOKNPSLNGDQEP-vzg-1
Received: by mail-ed1-f71.google.com with SMTP id h8-20020a056402280800b0046af59e0986so9401427ede.22
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 02:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wdWsTQy1PmtZVWiiL7HDvu5DGURuGqGghZsLS7DEOc=;
        b=TZ1IF3iWanVhaBzpOijKKyRlgl3NvHT0pHoXSEN6qiFTQnn0QNyrqxL6c6dZY/LlID
         GTGGA10G8woRetIdFU2swdCKEO/fTm65Ba7wXsSs2C4IU1N4K6f9CaHJO4kwU9O8igQL
         8Oeaz5Xaok7DWhiNEDk2pQVPgIGKGtiQwKeWHjb3QlGqwqxgn7bHkRYUzCUql14ivaY+
         JdbSfxmlpp4kSomRw3cB2VpdFurg8QxNujjIm1ebyfmXHlsjvQOpYD3udrXbtbC9XhL1
         U1KV3OLWJE5KzI4vLA3KCe9lo4YynusgW8HZpE1uzE9BFB5ylsi9eEdY3O5Wa88qlgPG
         ua5A==
X-Gm-Message-State: ANoB5plbg+NKukkilDndZZ44LAOsC2DYw1vSAlf6VKPbZpOlL3AGH8NC
        28TIbHK715sMmZ3FH9yOO9bH2Df6wjVrKzFItw+Cxrz1HFvSSmx5nmZX/3sjk4pjZShRoCSJ7ZR
        NIqwHNtIbeUXd
X-Received: by 2002:a17:906:6ad7:b0:7c1:ac8:399 with SMTP id q23-20020a1709066ad700b007c10ac80399mr5278355ejs.55.1671014513764;
        Wed, 14 Dec 2022 02:41:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5k98PrAYSt8YBPsktotuBlZ4RsT1r4m5dQQWi2PWynxz6//xez8PWUS6/4F7JYmq7UbD0Aag==
X-Received: by 2002:a17:906:6ad7:b0:7c1:ac8:399 with SMTP id q23-20020a1709066ad700b007c10ac80399mr5278335ejs.55.1671014513471;
        Wed, 14 Dec 2022 02:41:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kz21-20020a17090777d500b007c0c91eae04sm5661630ejc.151.2022.12.14.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 02:41:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F3C1082F53C; Wed, 14 Dec 2022 11:41:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 06/15] bpf: Support consuming XDP HW
 metadata from fext programs
In-Reply-To: <1a0436c5-2198-0c69-1306-872454d2fb13@linux.dev>
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-7-sdf@google.com>
 <1a0436c5-2198-0c69-1306-872454d2fb13@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Dec 2022 11:41:51 +0100
Message-ID: <87cz8mgtcg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 12/12/22 6:35 PM, Stanislav Fomichev wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Instead of rejecting the attaching of PROG_TYPE_EXT programs to XDP
>> programs that consume HW metadata, implement support for propagating the
>> offload information. The extension program doesn't need to set a flag or
>> ifindex, it these will just be propagated from the target by the verifie=
r.
>
> s/it/because/ ... these will just be propagated....

Yeah, or just drop 'it' :)

>> We need to create a separate offload object for the extension program,
>> though, since it can be reattached to a different program later (which
>> means we can't just inhering the offload information from the target).
>
> hmm.... inheriting?

Think I meant to write "we can't just inherit"

>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 11c558be4992..8686475f0dbe 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
>>   			goto out_put_prog;
>>   		}
>>=20=20=20
>> +		if (bpf_prog_is_dev_bound(prog->aux) &&
>
>
>> +		    (bpf_prog_is_offloaded(tgt_prog->aux) ||
>> +		     !bpf_prog_is_dev_bound(tgt_prog->aux) ||
>> +		     !bpf_offload_dev_match(prog, tgt_prog->aux->offload->netdev))) {
>
> hmm... tgt_prog->aux->offload does not look safe without taking bpf_devs_=
lock.=20
> offload could be NULL, no?
>
> It probably needs a bpf_prog_dev_bound_match(prog, tgt_prog) which takes =
the lock.

Hmm, right, I was kinda expecting that this would not go away while
tgt_prog was alive, but I see now that's not the case due to the
unregister hook. So yeah, needs locking (same below) :)

-Toke

