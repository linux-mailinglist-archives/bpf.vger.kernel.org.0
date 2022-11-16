Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369CF62B690
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 10:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiKPJb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 04:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiKPJbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 04:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A012ACE
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668591052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhwvXtJ+QlvItPTzYw/ZocGWMuy4LEUWdgmdV2EYwVM=;
        b=OXFLZjV/1IvOHtERODKlb/D7ix1/o1YGQk7R2VXC6eqbUfS9iArmJWOEY7F7vq5bsnoUwC
        pWx/qlii6XEVK74qUM2AUr1qkw+U8zDajiYe2KRXD2YMZoGJd7KAf9vjKmophTLNBYVHKb
        fs8p+WfBW7IvB/6BGzUuzYE+cgP91RU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-5PMTD_kmN5-LS4lXmscUmQ-1; Wed, 16 Nov 2022 04:30:43 -0500
X-MC-Unique: 5PMTD_kmN5-LS4lXmscUmQ-1
Received: by mail-ed1-f69.google.com with SMTP id f17-20020a056402355100b00466481256f6so11889925edd.19
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhwvXtJ+QlvItPTzYw/ZocGWMuy4LEUWdgmdV2EYwVM=;
        b=Lkrw3KMR4mx5oYrUTTagZr44SsFu718UQI3WkhSpOXfyx5Eh6Nty1sTjWT/EzJBR7S
         5d+KqF19YHwiS70GMykdC2Gq7Ek/nTi0Fuyqj8Et4nfUlOiBXU5sCEbaa0ETStmEfpV+
         l8Hb6tfO9SRzpGxO8vNrD4D1/Lb/Z/l4YbykEEVo9ObMnRLmI6hvnHPcjqN/0odspGqB
         gJirAJq0fatkd4C+AOKSg8GfbB4YLabFhEDA1EcBTP6xW7eny3UXAm2zWqBuH6B/POH3
         StB+1Wb6YYJr8aT+6FuqJGN2ooSI31w5ipo5oJq7ZjQ0610BYT77LLePyzdGL1Xr7RrX
         KqwQ==
X-Gm-Message-State: ANoB5pkbDydZONzTximt4eLg2lJN7+5LeHKnhrsg7tzy12Bk/vwQwG20
        X51CoYmnKLw2p+YfPKzAabCm85KtRm+nUwzIUdLMSmnK+qdLej0VKIvn5AvN9JJ3nJnS/UIHpCZ
        xa3ldkvSdrBE4
X-Received: by 2002:a17:906:2455:b0:78e:975:5e8 with SMTP id a21-20020a170906245500b0078e097505e8mr17150935ejb.82.1668591041503;
        Wed, 16 Nov 2022 01:30:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6T1/jKcStjc+60rFRbavpAvp0ivA59pr9JzV6Scum80n8WSSt2rPa46uwIMpai3PeScl5OTw==
X-Received: by 2002:a17:906:2455:b0:78e:975:5e8 with SMTP id a21-20020a170906245500b0078e097505e8mr17150849ejb.82.1668591039899;
        Wed, 16 Nov 2022 01:30:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906a40200b007b265d3f6a6sm1870230ejz.162.2022.11.16.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:30:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8FEDA7A6DCD; Wed, 16 Nov 2022 10:30:38 +0100 (CET)
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
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 06/11] xdp: Carry over xdp
 metadata into skb context
In-Reply-To: <CAKH8qBugRAS_MJCgHGaYnj2L+7==E0QP37D8iais2mQ_W9ob-A@mail.gmail.com>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-7-sdf@google.com> <87wn7vdcud.fsf@toke.dk>
 <CAKH8qBugRAS_MJCgHGaYnj2L+7==E0QP37D8iais2mQ_W9ob-A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Nov 2022 10:30:38 +0100
Message-ID: <87fsejjlfl.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On Tue, Nov 15, 2022 at 3:20 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> > index b444b1118c4f..71e3bc7ad839 100644
>> > --- a/include/uapi/linux/bpf.h
>> > +++ b/include/uapi/linux/bpf.h
>> > @@ -6116,6 +6116,12 @@ enum xdp_action {
>> >       XDP_REDIRECT,
>> >  };
>> >
>> > +/* Subset of XDP metadata exported to skb context.
>> > + */
>> > +struct xdp_skb_metadata {
>> > +     __u64 rx_timestamp;
>> > +};
>>
>> Okay, so given Alexei's comment about __randomize_struct not actually
>> working, I think we need to come up with something else for this. Just
>> sticking this in a regular UAPI header seems like a bad idea; we'd just
>> be inviting people to use it as-is.
>>
>> Do we actually need the full definition here? It's just a pointer
>> declaration below, so is an opaque forward-definition enough? Then we
>> could have the full definition in an internal header, moving the full
>> definition back to being in vmlinux.h only?
>
> Looks like having a uapi-declaration only (and moving the definition
> into the kernel headers) might work. At least it does in my limited
> testing :-) So let's go with that for now. Alexei, thanks for the
> context on __randomize_struct!

Sounds good! :)

-Toke

