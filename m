Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E344D62AF74
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiKOXea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 18:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOXe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 18:34:29 -0500
Received: from mail-pj1-x1062.google.com (mail-pj1-x1062.google.com [IPv6:2607:f8b0:4864:20::1062])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3880825C44
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:34:28 -0800 (PST)
Received: by mail-pj1-x1062.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so2519834pjt.0
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJY1h/lHP09IY+eljRKbCQakk7HMzR+MefkzkB9YYgM=;
        b=C/iH8Xy0pGEtBRRmo2vxEy4wpoguJMd+y1H+7e7VQhvEf7/PlE4ky5/zwnzJse8aY7
         7Omz0aqCWML+pfASadHwjHY/tmSK4OF6gUXCdR4F6TDWPQoJgNQNJcgh2gAiMk3hu5S9
         fL/ycjQdOw5ePVZ64gnBBqLB7//C1sNeB+haaN97c9zJwBU17Xctna1ln2G5bQ51XKg/
         +sxBjwZnFSUxbBCYvCNBHk3Pas3nsudALdVODi741k3hEYXMdY1ItSMqIVnu1yR+cpUR
         Ffmph/LLjoVkZC5Klye/CgYVkkDDG/b6qWdny/g1YAJlTrY2+X6n2HbnnnHZQKp6dENr
         l5pg==
X-Gm-Message-State: ANoB5pkhbXdRQDZhQE4NCs0c/gU0EliwX4+r/80Rp8DHzIJe88BaYW/V
        7n98JRltIwdDWLET+CnH1WzlDD0Bd+8rvEX01tMrEPgMIjrTeg==
X-Google-Smtp-Source: AA0mqf50Wsv3ZeaacKyTIcH5MFDeCXDuv1NXDxNS6bjw2fyt4z5K63MwySWVRqDSOHWbJfmHZqRzEcQdGDID
X-Received: by 2002:a17:90b:370e:b0:20a:78b7:9210 with SMTP id mg14-20020a17090b370e00b0020a78b79210mr731237pjb.138.1668555267832;
        Tue, 15 Nov 2022 15:34:27 -0800 (PST)
Received: from riotgames.com ([163.116.128.203])
        by smtp-relay.gmail.com with ESMTPS id e4-20020a170903240400b0018680e701ecsm729928plo.76.2022.11.15.15.34.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:34:27 -0800 (PST)
X-Relaying-Domain: riotgames.com
Received: by mail-il1-f198.google.com with SMTP id j7-20020a056e02154700b003025b3c0ea3so5311812ilu.10
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJY1h/lHP09IY+eljRKbCQakk7HMzR+MefkzkB9YYgM=;
        b=jDob1wC8OZpTRMfh1pQAe/iwy3nqh0Z3TeIExFe0UbKqOgxgt4tmMozO7Xm0wuVL39
         jAtJe+CIIVE7Q0N3oknrB2usEtXwwjAp2zTNfrqRIxzxm6dpL2p25wJGAfsl5JNN0X82
         ZxeY2rgy1pqRMkiGm6FX/xSV+W8R2Gd1qHNEI=
X-Received: by 2002:a5d:8d95:0:b0:6c3:168a:a25e with SMTP id b21-20020a5d8d95000000b006c3168aa25emr8858771ioj.174.1668555266085;
        Tue, 15 Nov 2022 15:34:26 -0800 (PST)
X-Received: by 2002:a5d:8d95:0:b0:6c3:168a:a25e with SMTP id
 b21-20020a5d8d95000000b006c3168aa25emr8858759ioj.174.1668555265735; Tue, 15
 Nov 2022 15:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com> <20221115030210.3159213-2-sdf@google.com>
 <CAC1LvL2Qg3jYAUPJ4GofJPBnk4HKYOuqyH_P_ZOcN45TZUzrHQ@mail.gmail.com> <CAKH8qBtDbZSa9VTaNOFNsm-FJgvDngjw7rJuT=QAnAD3FoGfsw@mail.gmail.com>
In-Reply-To: <CAKH8qBtDbZSa9VTaNOFNsm-FJgvDngjw7rJuT=QAnAD3FoGfsw@mail.gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Tue, 15 Nov 2022 15:34:14 -0800
Message-ID: <CAC1LvL3AqXF37HM4Gp9F_CaE7i-kQx95iqaaGXCx-LLw3JAUdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Document XDP RX metadata
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 2:44 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Nov 15, 2022 at 2:31 PM Zvi Effron <zeffron@riotgames.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Document all current use-cases and assumptions.
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > > Documentation/bpf/xdp-rx-metadata.rst | 109 ++++++++++++++++++++++++++
> > > 1 file changed, 109 insertions(+)
> > > create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
> > >
> > > diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/bpf/xdp-rx-metadata.rst
> > > new file mode 100644
> > > index 000000000000..5ddaaab8de31
> > > --- /dev/null
> > > +++ b/Documentation/bpf/xdp-rx-metadata.rst
> > > @@ -0,0 +1,109 @@
> > > +===============
> > > +XDP RX Metadata
> > > +===============
> > > +
> > > +XDP programs support creating and passing custom metadata via
> > > +``bpf_xdp_adjust_meta``. This metadata can be consumed by the following
> > > +entities:
> > > +
> > > +1. ``AF_XDP`` consumer.
> > > +2. Kernel core stack via ``XDP_PASS``.
> > > +3. Another device via ``bpf_redirect_map``.
> >
> > 4. Other eBPF programs via eBPF tail calls.
>
> Don't think a tail call is a special case here?
> Correct me if I'm wrong, but with a tail call, we retain the original
> xdp_buff ctx, so the tail call can still use the same kfuncs as if the
> original bpf prog was running.
>

That's correct, but it's still a separate program that consumes the metadata,
unrelated to anything kfuncs. Prior to the existence of kfuncs and AF_XDP, this
was (to my knowledge) the primary consumer (outside of the original program, of
course) of the metadata.

From the name of the file and commit message, it sounds like this is the
documentation for XDP metadata, not the documentation for XDP metadata as used
by kfuncs to implement xdp-hints. Is that correct?

> > > +
> > > +General Design
> > > +==============
> > > +
> > > +XDP has access to a set of kfuncs to manipulate the metadata. Every
> > > +device driver implements these kfuncs by generating BPF bytecode
> > > +to parse it out from the hardware descriptors. The set of kfuncs is
> > > +declared in ``include/net/xdp.h`` via ``XDP_METADATA_KFUNC_xxx``.
> > > +
> > > +Currently, the following kfuncs are supported. In the future, as more
> > > +metadata is supported, this set will grow:
> > > +
> > > +- ``bpf_xdp_metadata_rx_timestamp_supported`` returns true/false to
> > > + indicate whether the device supports RX timestamps in general
> > > +- ``bpf_xdp_metadata_rx_timestamp`` returns packet RX timestamp or 0
> > > +- ``bpf_xdp_metadata_export_to_skb`` prepares metadata layout that
> > > + the kernel will be able to consume. See ``bpf_redirect_map`` section
> > > + below for more details.
> > > +
> > > +Within the XDP frame, the metadata layout is as follows::
> > > +
> > > + +----------+------------------+-----------------+------+
> > > + | headroom | xdp_skb_metadata | custom metadata | data |
> > > + +----------+------------------+-----------------+------+
> > > + ^ ^
> > > + | |
> > > + xdp_buff->data_meta xdp_buff->data
> > > +
> > > +Where ``xdp_skb_metadata`` is the metadata prepared by
> > > +``bpf_xdp_metadata_export_to_skb``. And ``custom metadata``
> > > +is prepared by the BPF program via calls to ``bpf_xdp_adjust_meta``.
> > > +
> > > +Note that ``bpf_xdp_metadata_export_to_skb`` doesn't adjust
> > > +``xdp->data_meta`` pointer. To access the metadata generated
> > > +by ``bpf_xdp_metadata_export_to_skb`` use ``xdp_buf->skb_metadata``.
> > > +
> > > +AF_XDP
> > > +======
> > > +
> > > +``AF_XDP`` use-case implies that there is a contract between the BPF program
> > > +that redirects XDP frames into the ``XSK`` and the final consumer.
> > > +Thus the BPF program manually allocates a fixed number of
> > > +bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
> > > +of kfuncs to populate it. User-space ``XSK`` consumer, looks
> > > +at ``xsk_umem__get_data() - METADATA_SIZE`` to locate its metadata.
> > > +
> > > +Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
> > > +
> > > + +----------+------------------+-----------------+------+
> > > + | headroom | xdp_skb_metadata | custom metadata | data |
> > > + +----------+------------------+-----------------+------+
> > > + ^
> > > + |
> > > + rx_desc->address
> > > +
> > > +XDP_PASS
> > > +========
> > > +
> > > +This is the path where the packets processed by the XDP program are passed
> > > +into the kernel. The kernel creates ``skb`` out of the ``xdp_buff`` contents.
> > > +Currently, every driver has a custom kernel code to parse the descriptors and
> > > +populate ``skb`` metadata when doing this ``xdp_buff->skb`` conversion.
> > > +In the future, we'd like to support a case where XDP program can override
> > > +some of that metadata.
> > > +
> > > +The plan of record is to make this path similar to ``bpf_redirect_map``
> > > +below where the program would call ``bpf_xdp_metadata_export_to_skb``,
> > > +override the metadata and return ``XDP_PASS``. Additional work in
> > > +the drivers will be required to enable this (for example, to skip
> > > +populating ``skb`` metadata from the descriptors when
> > > +``bpf_xdp_metadata_export_to_skb`` has been called).
> > > +
> > > +bpf_redirect_map
> > > +================
> > > +
> > > +``bpf_redirect_map`` can redirect the frame to a different device.
> > > +In this case we don't know ahead of time whether that final consumer
> > > +will further redirect to an ``XSK`` or pass it to the kernel via ``XDP_PASS``.
> > > +Additionally, the final consumer doesn't have access to the original
> > > +hardware descriptor and can't access any of the original metadata.
> > > +
> > > +To support passing metadata via ``bpf_redirect_map``, there is a
> > > +``bpf_xdp_metadata_export_to_skb`` kfunc that populates a subset
> > > +of metadata into ``xdp_buff``. The layout is defined in
> > > +``struct xdp_skb_metadata``.
> > > +
> > > +Mixing custom metadata and xdp_skb_metadata
> > > +===========================================
> > > +
> > > +For the cases of ``bpf_redirect_map``, where the final consumer isn't
> > > +known ahead of time, the program can store both, custom metadata
> > > +and ``xdp_skb_metadata`` for the kernel consumption.
> > > +
> > > +Current limitation is that the program cannot adjust ``data_meta`` (via
> > > +``bpf_xdp_adjust_meta``) after a call to ``bpf_xdp_metadata_export_to_skb``.
> > > +So it has to, first, prepare its custom metadata layout and only then,
> > > +optionally, store ``xdp_skb_metadata`` via a call to
> > > +``bpf_xdp_metadata_export_to_skb``.
> > > --
> > > 2.38.1.431.g37b22c650d-goog
> > >
