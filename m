Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850762AE8A
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiKOWrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiKOWrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE71D30E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668552366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0TWzdfZiE0mSRF2t3lvU4LTFvtVx66OVWvuDeX1yDA=;
        b=cthi+WNwcawWA9/si44wvGQKJ5tbGgxyjlmZXYqh8kKPYRNH68YlPLaBiLbmQWFwa2oiUR
        dnkG0b5d6bUYA8i++fG9xr0EjJT4e4FjfW/G4atuPVXzvgBC+USWtY/pheA2iI1pPbV+g2
        72kMur45QpORYYvwZ1Ltkl3meZrTQKg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-DtGS6kq5MFOzWlsffvJF9g-1; Tue, 15 Nov 2022 17:46:05 -0500
X-MC-Unique: DtGS6kq5MFOzWlsffvJF9g-1
Received: by mail-ed1-f71.google.com with SMTP id z11-20020a056402274b00b00461dba91468so10816569edd.6
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0TWzdfZiE0mSRF2t3lvU4LTFvtVx66OVWvuDeX1yDA=;
        b=NS2ObR1Ezx+s+4W3ogNC/euksTXvzSWOot1rMELmEGBDNUN03DG5hFtJiZ64ffY+Ub
         Q8V6/nTnJax+2sCaSaq1EUv4rYRW/HxDJ5/NDrib0kfx+mYROrjkkYlUGODp2hXXX2jR
         qNlXCRCT6+pVQMcY6Iqkir42cj54INodm65ITsOGjqD0Zcyr0hx3o5mhLxRm7jZ6q1MX
         JXRNMPgjrxgaf34v1LNd0AhdruABEfvymfwqYpE7BbyIw597HOwmwaA3tQ2cuzkL8mAw
         9117yj1VSAN7QJnNHQiRAY1sXG1J3OPOXuYkfHceCREQQJ+zDNwW2ODY3SdVtohoZiaV
         cLNg==
X-Gm-Message-State: ANoB5plN7lF2VUdvBoefOeTsvkYW6KZlCpMvgKqZtl+kgi+I0edUCcsO
        tNq8T3i2qB3JHn20+OL5/PwzWCuONg3VOiUlFysq6UcToO5eDP1g8FJQJOOAfXdt0TSjrsB3t06
        vZANBxGcmzkvj
X-Received: by 2002:aa7:c557:0:b0:464:b8b:f526 with SMTP id s23-20020aa7c557000000b004640b8bf526mr17399583edr.342.1668552364335;
        Tue, 15 Nov 2022 14:46:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf477ZLTO386+YNbJRKiUR5eAcBJ9x/HvUv4FofCMETVmNspFN6yAC94pUyalqcm74dTdZWoCQ==
X-Received: by 2002:aa7:c557:0:b0:464:b8b:f526 with SMTP id s23-20020aa7c557000000b004640b8bf526mr17399559edr.342.1668552363894;
        Tue, 15 Nov 2022 14:46:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id we10-20020a170907234a00b00782fbb7f5f7sm6079334ejb.113.2022.11.15.14.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:46:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 38FE17A6D54; Tue, 15 Nov 2022 23:46:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 05/11] veth: Support rx
 timestamp metadata for xdp
In-Reply-To: <CAKH8qBsEGD3L0XAVzVHcTW6k_RhEt74pfXrPLANuznSAJw7bEg@mail.gmail.com>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-6-sdf@google.com> <87h6z0i449.fsf@toke.dk>
 <CAKH8qBsEGD3L0XAVzVHcTW6k_RhEt74pfXrPLANuznSAJw7bEg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Nov 2022 23:46:02 +0100
Message-ID: <8735ajet05.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On Tue, Nov 15, 2022 at 8:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > The goal is to enable end-to-end testing of the metadata
>> > for AF_XDP. Current rx_timestamp kfunc returns current
>> > time which should be enough to exercise this new functionality.
>> >
>> > Cc: John Fastabend <john.fastabend@gmail.com>
>> > Cc: David Ahern <dsahern@gmail.com>
>> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> > Cc: Jakub Kicinski <kuba@kernel.org>
>> > Cc: Willem de Bruijn <willemb@google.com>
>> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
>> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
>> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>> > Cc: Maryam Tahhan <mtahhan@redhat.com>
>> > Cc: xdp-hints@xdp-project.net
>> > Cc: netdev@vger.kernel.org
>> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> > ---
>> >  drivers/net/veth.c | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> > index 2a4592780141..c626580a2294 100644
>> > --- a/drivers/net/veth.c
>> > +++ b/drivers/net/veth.c
>> > @@ -25,6 +25,7 @@
>> >  #include <linux/filter.h>
>> >  #include <linux/ptr_ring.h>
>> >  #include <linux/bpf_trace.h>
>> > +#include <linux/bpf_patch.h>
>> >  #include <linux/net_tstamp.h>
>> >
>> >  #define DRV_NAME     "veth"
>> > @@ -1659,6 +1660,18 @@ static int veth_xdp(struct net_device *dev, str=
uct netdev_bpf *xdp)
>> >       }
>> >  }
>> >
>> > +static void veth_unroll_kfunc(const struct bpf_prog *prog, u32 func_i=
d,
>> > +                           struct bpf_patch *patch)
>> > +{
>> > +     if (func_id =3D=3D xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_T=
IMESTAMP_SUPPORTED)) {
>> > +             /* return true; */
>> > +             bpf_patch_append(patch, BPF_MOV64_IMM(BPF_REG_0, 1));
>> > +     } else if (func_id =3D=3D xdp_metadata_kfunc_id(XDP_METADATA_KFU=
NC_RX_TIMESTAMP)) {
>> > +             /* return ktime_get_mono_fast_ns(); */
>> > +             bpf_patch_append(patch, BPF_EMIT_CALL(ktime_get_mono_fas=
t_ns));
>> > +     }
>> > +}
>>
>> So these look reasonable enough, but would be good to see some examples
>> of kfunc implementations that don't just BPF_CALL to a kernel function
>> (with those helper wrappers we were discussing before).
>
> Let's maybe add them if/when needed as we add more metadata support?
> xdp_metadata_export_to_skb has an example, and rfc 1/2 have more
> examples, so it shouldn't be a problem to resurrect them back at some
> point?

Well, the reason I asked for them is that I think having to maintain the
BPF code generation in the drivers is probably the biggest drawback of
the kfunc approach, so it would be good to be relatively sure that we
can manage that complexity (via helpers) before we commit to this :)

-Toke

