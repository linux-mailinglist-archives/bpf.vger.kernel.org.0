Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F563C90A
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiK2UNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbiK2UNu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 15:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E6101EB
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669752772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/DtU9h0RtN23p7lxcyeL2USYhwV+5eXUa161nOoIdY=;
        b=MC8qC+EgpSc1R2/C/Q+PpiydXe1SiI2cK4Y1bmCjMVjzKvE2l+GDzM/tncJKdDsOId52WA
        dtnEIxGG4IWhz0Qk8HmttiqT7mDvO6gvG/opfA3hHxCEfKioj65uwNYbZQ/ijLsjNWtYfC
        4lPXL03wInkq6GEMVWxIJF0UPLHpzXw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-21VxsvXkPMuHOkSeCLSoBw-1; Tue, 29 Nov 2022 15:12:45 -0500
X-MC-Unique: 21VxsvXkPMuHOkSeCLSoBw-1
Received: by mail-ed1-f71.google.com with SMTP id v18-20020a056402349200b004622e273bbbso8734250edc.14
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 12:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/DtU9h0RtN23p7lxcyeL2USYhwV+5eXUa161nOoIdY=;
        b=7oqHXQOyvkokzGCQi1TaLExcCd2HEN9pqaGKNL9nKp0+8+FA4958eYUP5/cecyAXm0
         b1bN/zKqhZeHQykY6qlhQ3cFb30J9QBzFucQGz6dzXSlLBluj2BxIyd1zGlmJpQVik3t
         dv7AE7KgkrTBPAkUI0X3TKfO39wZK4Q7grjk4Q3G2xYQ/nL0i4b3ZnHEr2zlaHQ/QE6p
         d/Ud2ExhYiBCDNAC3qT+vZdj6Z+aPVLY0ciNSRQrflpSAKpFfhac3GVQ0eo2M/kum/AU
         dxm7Vjw6Eodr+N0McKTHW166SMERHHzRBCTQ+jqo6U/nVqKXwEnKQ2+vFAAW4nWmURNW
         YCCg==
X-Gm-Message-State: ANoB5pnpLoNSrMqZ6y9gchgSUrl7go+HbLe3q4Vgb1Tnta3vi78kMS65
        KRYadK2zGplb7NOf/WSxJ665wUg+L6MQNFxBUjsmUjrcC6sy0Plg7eTLDe4THRTsoUU3XMGWtcf
        DInu18MzPd9NW
X-Received: by 2002:aa7:c145:0:b0:469:400a:3f8e with SMTP id r5-20020aa7c145000000b00469400a3f8emr39759752edp.108.1669752764119;
        Tue, 29 Nov 2022 12:12:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf47fMnGW5m1uEvZbK4cqaeWRHQX5RwhLZquJo/mHcpbp20b6HVDRykbVIPNBHH8lDdukFDHyw==
X-Received: by 2002:aa7:c145:0:b0:469:400a:3f8e with SMTP id r5-20020aa7c145000000b00469400a3f8emr39759723edp.108.1669752763640;
        Tue, 29 Nov 2022 12:12:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id mx16-20020a1709065a1000b007bff9fb211fsm2835635ejc.57.2022.11.29.12.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:12:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A60880AC44; Tue, 29 Nov 2022 21:12:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
In-Reply-To: <Y4Yeom8vSZtBM3o2@wtfbox.lan>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk> <Y4Yeom8vSZtBM3o2@wtfbox.lan>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Nov 2022 21:12:42 +0100
Message-ID: <877czdzfid.fsf@toke.dk>
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

Artem Savkov <asavkov@redhat.com> writes:

> On Sun, Nov 13, 2022 at 07:04:43PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>>=20
>> >>
>> >> Hi everyone
>> >>
>> >> There seems to be some issue with BTF mismatch when trying to run the
>> >> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
>> >> that this is supposed to work, so is there some kind of BTF dedup iss=
ue
>> >> here or something?
>> >>
>> >> Steps to reproduce:
>> >>
>> >> 1. Compile kernel with nf_conntrack built-in and run selftests;
>> >>    './test_progs -a bpf_nf' works
>> >>
>> >> 2. Change the kernel config so nf_conntrack is build as a module
>> >>
>> >> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
>> >>
>> >> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
>> >>
>> >> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT=
 nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
>> >
>> > This week Kumar and I took a look at this issue and we ended up
>> > identifying a duplication of nf_conn___init structure. In particular:
>> >
>> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>> > net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
>> > [110941] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
>> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>> > net/netfilter/nf_nat.ko format raw | grep nf_conn__
>> > [107488] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
>> >
>> > Is it the root cause of the problem?
>>=20
>> It certainly seems to be related to it, at least. Amending the log
>> message to include the BTF object IDs of the two versions shows that the
>> register has a reference to nf_conn__init in nf_conntrack.ko, while the =
kernel
>> expects it to point to nf_nat.ko.
>>=20
>> Not sure what's the right fix for this? Should libbpf be smart enough to
>> pull the kfunc arg ID from the same BTF ID as the function itself? Or
>
> Verifier chose the ID based on where the variable was allocated, which
> is bpf_(skb|xdp)_ct_alloc() from nf_conntrack.ko. Assuming btf id based
> on usage location might be error prone.

Yeah, I think we need something more robust.

>> should the kernel compare structs and allow things if they're identical?
>> Andrii, WDYT?
>
> This works but might make verifier slower.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 195d24316750..562d2c15906d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_lsm.h>
>  #include <linux/btf_ids.h>
>  #include <linux/poison.h>
> +#include "../tools/lib/bpf/relo_core.h"
>
>  #include "disasm.h"
>
> @@ -8236,7 +8237,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_=
verifier_env *env,
>
>         reg_ref_t =3D btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_r=
ef_id);
>         reg_ref_tname =3D btf_name_by_offset(reg_btf, reg_ref_t->name_off=
);
> -       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->of=
f, meta->btf, ref_id, strict_type_match)) {
> +       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->of=
f, meta->btf, ref_id, strict_type_match) && \
> +                       !__bpf_core_types_match(reg_btf, reg_ref_id, meta=
->btf, ref_id, false, 10)) {
>                 verbose(env, "kernel function %s args#%d expected pointer=
 to %s %s but R%d has a pointer to %s %s\n",
>                         meta->func_name, argno, btf_type_str(ref_t), ref_=
tname, argno + 1,
>                         btf_type_str(reg_ref_t), reg_ref_tname);

Ah, cool! This is a lot of code to important into the kernel, though; do
we really want to do that?

I guess an alternative could be to make sure that every data type used
by a kfunc is always referenced in a built-in module somewhere, so
modules will use the definition from vmlinux.

Andrii, Alexei, any opinions on which way to go with this?

-Toke

