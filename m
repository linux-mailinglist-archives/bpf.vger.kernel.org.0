Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA84D5566
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 00:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiCJXbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 18:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbiCJXbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 18:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2986019CCC1
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646955050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uO9Ehxi9kzNlNNdspwWMvFlz01uixNVyFZ0MGYbiD18=;
        b=LwlYkjbpB1jcckgvUHbGanQvq4K/1jgaf4UL9kNiWMKT4JK4tpoT1G58Dbm63T/7xg4WOc
        g6j1XaeETrFpjHTfHQ6CpoOddc4vB1TV2OoHS04H4RoHcNcnmxf0RoW7hX629UwGLL/x/2
        jNZPvv54S3YclQCRz+46ndMOkhwJzd8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-8KsSgTlaPG-E8STOSfJPrQ-1; Thu, 10 Mar 2022 18:30:49 -0500
X-MC-Unique: 8KsSgTlaPG-E8STOSfJPrQ-1
Received: by mail-ed1-f71.google.com with SMTP id i5-20020a056402054500b00415ce7443f4so3934713edx.12
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 15:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uO9Ehxi9kzNlNNdspwWMvFlz01uixNVyFZ0MGYbiD18=;
        b=1njTKM8q0G5nKavCltCJd3JhBtsznDBdguUfBri6ziGh7F4omekqS8GR9ub7TdKSm1
         QS94gl/0kkUEMCUsJ3Wxiyv/2rip/vektsYqkZTHhLr92DaMKCFw/Z9gz6xPIlPtF/uC
         KYvvCTGwRDDm7kHwtCKK0jVi7/y0mxRi7NhwZnC+INzt0Paa1KFD+WgM1TSZ/1+WSZyX
         VPxQcflsCVbRRPWBVPIw1qZAWQCyPeevDB9QXh9kCK/yvrGclaREsTUNFREpkkgCscqk
         vOoO3x0viqMg5UyuU3+mpU93jmOh/bLhocC0wOZBkHt74JAQ+mg86TfcGdcb5kNLxZDI
         02fw==
X-Gm-Message-State: AOAM531bOeWla217zcQxmQmhOO1T8syE+IGK4sAXLJnNm9FSUTWMO1IU
        fyO9eSuul8hDRg9LlgbYMAwylEIUASakOolNdwTdyfOKFI0B4rgPPK1rigVvB1ciLjNcahKQGB8
        K2ZhuE4tIODBv
X-Received: by 2002:a17:906:4fd3:b0:6da:8190:5780 with SMTP id i19-20020a1709064fd300b006da81905780mr6302224ejw.731.1646955045357;
        Thu, 10 Mar 2022 15:30:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSuYb+x1FGZpe2l9uV3jfN6b0CD7PJsDSLE79FYAAZuLvIglF7umTJCcfX4oOadGCx0HGIBA==
X-Received: by 2002:a17:906:4fd3:b0:6da:8190:5780 with SMTP id i19-20020a1709064fd300b006da81905780mr6302154ejw.731.1646955043820;
        Thu, 10 Mar 2022 15:30:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402525600b00416cb5fdc56sm450936edd.57.2022.03.10.15.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:30:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 96BDD1A8A32; Fri, 11 Mar 2022 00:30:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Lorenz Bauer <linux@lmb.io>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 0/5] Introduce bpf_packet_pointer helper
In-Reply-To: <CAEf4Bza6BhG7wtgmvWohEKpN5jSTyQwxm5-738oMoniz1v3uVw@mail.gmail.com>
References: <20220306234311.452206-1-memxor@gmail.com>
 <CAEf4BzaPhtUGhR1vTSNGVLAudA7fUDWqZZFDfFvHXi2MOdrN5w@mail.gmail.com>
 <20220308070828.4tjiuvvyqwmhru6a@apollo.legion> <87lexky33s.fsf@toke.dk>
 <CAEf4Bza6BhG7wtgmvWohEKpN5jSTyQwxm5-738oMoniz1v3uVw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Mar 2022 00:30:42 +0100
Message-ID: <87bkydxu59.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Mar 8, 2022 at 5:40 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Tue, Mar 08, 2022 at 11:18:52AM IST, Andrii Nakryiko wrote:
>> >> On Sun, Mar 6, 2022 at 3:43 PM Kumar Kartikeya Dwivedi <memxor@gmail.=
com> wrote:
>> >> >
>> >> > Expose existing 'bpf_xdp_pointer' as a BPF helper named 'bpf_packet=
_pointer'
>> >> > returning a packet pointer with a fixed immutable range. This can b=
e useful to
>> >> > enable DPA without having to use memcpy (currently the case in
>> >> > bpf_xdp_load_bytes and bpf_xdp_store_bytes).
>> >> >
>> >> > The intended usage to read and write data for multi-buff XDP is:
>> >> >
>> >> >         int err =3D 0;
>> >> >         char buf[N];
>> >> >
>> >> >         off &=3D 0xffff;
>> >> >         ptr =3D bpf_packet_pointer(ctx, off, sizeof(buf), &err);
>> >> >         if (unlikely(!ptr)) {
>> >> >                 if (err < 0)
>> >> >                         return XDP_ABORTED;
>> >> >                 err =3D bpf_xdp_load_bytes(ctx, off, buf, sizeof(bu=
f));
>> >> >                 if (err < 0)
>> >> >                         return XDP_ABORTED;
>> >> >                 ptr =3D buf;
>> >> >         }
>> >> >         ...
>> >> >         // Do some stores and loads in [ptr, ptr + N) region
>> >> >         ...
>> >> >         if (unlikely(ptr =3D=3D buf)) {
>> >> >                 err =3D bpf_xdp_store_bytes(ctx, off, buf, sizeof(b=
uf));
>> >> >                 if (err < 0)
>> >> >                         return XDP_ABORTED;
>> >> >         }
>> >> >
>> >> > Note that bpf_packet_pointer returns a PTR_TO_PACKET, not PTR_TO_ME=
M, because
>> >> > these pointers need to be invalidated on clear_all_pkt_pointers inv=
ocation, and
>> >> > it is also more meaningful to the user to see return value as R0=3D=
pkt.
>> >> >
>> >> > This series is meant to collect feedback on the approach, next vers=
ion can
>> >> > include a bpf_skb_pointer and exposing it as bpf_packet_pointer hel=
per for TC
>> >> > hooks, and explore not resetting range to zero on r0 +=3D rX, inste=
ad check access
>> >> > like check_mem_region_access (var_off + off < range), since there w=
ould be no
>> >> > data_end to compare against and obtain a new range.
>> >> >
>> >> > The common name and func_id is supposed to allow writing generic co=
de using
>> >> > bpf_packet_pointer that works for both XDP and TC programs.
>> >> >
>> >> > Please see the individual patches for implementation details.
>> >> >
>> >>
>> >> Joanne is working on a "bpf_dynptr" framework that will support
>> >> exactly this feature, in addition to working with dynamically
>> >> allocated memory, working with memory of statically unknown size (but
>> >> safe and checked at runtime), etc. And all that within a generic
>> >> common feature implemented uniformly within the verifier. E.g., it
>> >> won't need any of the custom bits of logic added in patch #2 and #3.
>> >> So I'm thinking that instead of custom-implementing a partial case of
>> >> bpf_dynptr just for skb and xdp packets, let's maybe wait for dynptr
>> >> and do it only once there?
>> >>
>> >
>> > Interesting stuff, looking forward to it.
>> >
>> >> See also my ARG_CONSTANT comment. It seems like a pretty common thing
>> >> where input constant is used to characterize some pointer returned
>> >> from the helper (e.g., bpf_ringbuf_reserve() case), and we'll need
>> >> that for bpf_dynptr for exactly this "give me direct access of N
>> >> bytes, if possible" case. So improving/generalizing it now before
>> >> dynptr lands makes a lot of sense, outside of bpf_packet_pointer()
>> >> feature itself.
>> >
>> > No worries, we can continue the discussion in patch 1, I'll split out =
the arg
>> > changes into a separate patch, and wait for dynptr to be posted before=
 reworking
>> > this.
>>
>> This does raise the question of what we do in the meantime, though? Your
>> patch includes a change to bpf_xdp_{load,store}_bytes() which, if we're
>> making it, really has to go in before those hit a release and become
>> UAPI.
>>
>> One option would be to still make the change to those other helpers;
>> they'd become a bit slower, but if we have a solution for that coming,
>> that may be OK for a single release? WDYT?
>
> I must have missed important changes to bpf_xdp_{load,store}_bytes().
> Does anything change about its behavior? If there are some fixes
> specific to those helpers, we should fix them as well as a separate
> patch. My main objection is adding a bpf_packet_pointer() special case
> when we have a generic mechanism in the works that will come this use
> case (among other use cases).

Well it's not a functional change per se, but Kartikeya's patch is
removing an optimisation from bpf_xdp_{load_store}_bytes() (i.e., the
use of the bpf_xdp_pointer()) in favour of making it available directly
to BPF. So if we don't do that change before those helpers are
finalised, we will end up either introducing a performance regression
for code using those helpers, or being stuck with the bpf_xdp_pointer()
use inside them even though it makes more sense to move it out to BPF.

So the "safe" thing to do would do the change to the store/load helpers
now, and get rid of the bpf_xdp_pointer() entirely until it can be
introduced as a BPF helper in a generic way. Of course this depends on
whether you consider performance regressions to be something to avoid,
but this being XDP IMO we should :)

-Toke

