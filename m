Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC26462B1F3
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 04:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKPDuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 22:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPDut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 22:50:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D3CD4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 19:50:48 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a7-20020a056830008700b0066c82848060so9725336oto.4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 19:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjSzQm8NEY1BrxU20b+mbo555SpvPLWvZzQXqm7pI68=;
        b=Favnj0HvisdTWxl8MYvRuW/NVK6+6f3nemFiEF9NGy7rYuyrmlHZ4eGYjLmlxkeLDd
         c0U49jDEUa5td+/rWA1XEntPzRcRFgH2G9uL5P6bdVzp3r1uHdIQ8m+SfcZJIFKB+Z8K
         9KMnzy/942tZNWN6/6dPmNZjBVFPr3MqHySNWYfpIVZP+JA1ALbv868DDJpn+jVELBLb
         u6Ggsh+0P3P3n9+BmMewTHU9pwOu+bCNusXi71LfWYeXFvuVPdWGGe7h0B4rNVEu7uVm
         EjOhvVynMffzCW/YEfGX+tTdo4GyDUMPujnYz/0ekSiCR36mW+vqdNoWqITfUFtyw+Qu
         0MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjSzQm8NEY1BrxU20b+mbo555SpvPLWvZzQXqm7pI68=;
        b=SXhoKVsXNjSTztzvREG/OSsiMUcCnowenzHRve6pcG7iciFcrRQgF1CkNbT/RJQzKh
         wmn8KaoQXfgrQlpCXG5IBcGXhJWnm6wk72I38mKFLsS4KIbNrHpwmWLqIG79ldg0qC2W
         17tCpsZRLEl5hrrr0hGMb63ILgyoglhIWcOyl0buU8WlzbRiAZg7ROmUWM+bnaEC7hN1
         hjUgEFZ+YSGEXNJMKw+py3gNKcD41jR2FZkWHlrmK6YrP8BvLiB1ey1Rjoa2tNNypjRV
         1ZaiRp/shvRgeZA63j0FalD1LRcewwjaib4rqm5uShoRA0lITmg4xPmVRcBGy19VknbH
         xYcQ==
X-Gm-Message-State: ANoB5pnwLqIlgxWO6sRgRWp0z/nML8AIzAUdb8q1+ryK+7tpocau7MKZ
        9oB7lMCoG5fR37b7ye4n4oo6/VFgh28iRxH9r8CjQw==
X-Google-Smtp-Source: AA0mqf6cNJAqnW6P/VUgK8FFeCVL7oyw7XsuGPxt+P4XPbC9oxaLbZWYYGCkUTxuoKnRfQ2Gl3aPInc6OlcngFYh5Y0=
X-Received: by 2002:a9d:4f06:0:b0:66c:794e:f8c6 with SMTP id
 d6-20020a9d4f06000000b0066c794ef8c6mr10287035otl.343.1668570647953; Tue, 15
 Nov 2022 19:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com> <20221115030210.3159213-2-sdf@google.com>
 <CAC1LvL2Qg3jYAUPJ4GofJPBnk4HKYOuqyH_P_ZOcN45TZUzrHQ@mail.gmail.com>
 <CAKH8qBtDbZSa9VTaNOFNsm-FJgvDngjw7rJuT=QAnAD3FoGfsw@mail.gmail.com> <CAC1LvL3AqXF37HM4Gp9F_CaE7i-kQx95iqaaGXCx-LLw3JAUdA@mail.gmail.com>
In-Reply-To: <CAC1LvL3AqXF37HM4Gp9F_CaE7i-kQx95iqaaGXCx-LLw3JAUdA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 15 Nov 2022 19:50:36 -0800
Message-ID: <CAKH8qBu_h_b8s7XbAHBvVgNgQeg9dNvgo_6dUwH2LMYj8injXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Document XDP RX metadata
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 3:34 PM Zvi Effron <zeffron@riotgames.com> wrote:
>
> On Tue, Nov 15, 2022 at 2:44 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Nov 15, 2022 at 2:31 PM Zvi Effron <zeffron@riotgames.com> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > Document all current use-cases and assumptions.
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > > Documentation/bpf/xdp-rx-metadata.rst | 109 ++++++++++++++++++++++++++
> > > > 1 file changed, 109 insertions(+)
> > > > create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
> > > >
> > > > diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/bpf/xdp-rx-metadata.rst
> > > > new file mode 100644
> > > > index 000000000000..5ddaaab8de31
> > > > --- /dev/null
> > > > +++ b/Documentation/bpf/xdp-rx-metadata.rst
> > > > @@ -0,0 +1,109 @@
> > > > +===============
> > > > +XDP RX Metadata
> > > > +===============
> > > > +
> > > > +XDP programs support creating and passing custom metadata via
> > > > +``bpf_xdp_adjust_meta``. This metadata can be consumed by the following
> > > > +entities:
> > > > +
> > > > +1. ``AF_XDP`` consumer.
> > > > +2. Kernel core stack via ``XDP_PASS``.
> > > > +3. Another device via ``bpf_redirect_map``.
> > >
> > > 4. Other eBPF programs via eBPF tail calls.
> >
> > Don't think a tail call is a special case here?
> > Correct me if I'm wrong, but with a tail call, we retain the original
> > xdp_buff ctx, so the tail call can still use the same kfuncs as if the
> > original bpf prog was running.
> >
>
> That's correct, but it's still a separate program that consumes the metadata,
> unrelated to anything kfuncs. Prior to the existence of kfuncs and AF_XDP, this
> was (to my knowledge) the primary consumer (outside of the original program, of
> course) of the metadata.

SG. I'll add this #4 in the respin and will add a short note that the
tail call operates on the same ctx.

> From the name of the file and commit message, it sounds like this is the
> documentation for XDP metadata, not the documentation for XDP metadata as used
> by kfuncs to implement xdp-hints. Is that correct?

I'm mostly focused on the kfunc-related details for now.



> > > > +
> > > > +General Design
> > > > +==============
> > > > +
> > > > +XDP has access to a set of kfuncs to manipulate the metadata. Every
> > > > +device driver implements these kfuncs by generating BPF bytecode
> > > > +to parse it out from the hardware descriptors. The set of kfuncs is
> > > > +declared in ``include/net/xdp.h`` via ``XDP_METADATA_KFUNC_xxx``.
> > > > +
> > > > +Currently, the following kfuncs are supported. In the future, as more
> > > > +metadata is supported, this set will grow:
> > > > +
> > > > +- ``bpf_xdp_metadata_rx_timestamp_supported`` returns true/false to
> > > > + indicate whether the device supports RX timestamps in general
> > > > +- ``bpf_xdp_metadata_rx_timestamp`` returns packet RX timestamp or 0
> > > > +- ``bpf_xdp_metadata_export_to_skb`` prepares metadata layout that
> > > > + the kernel will be able to consume. See ``bpf_redirect_map`` section
> > > > + below for more details.
> > > > +
> > > > +Within the XDP frame, the metadata layout is as follows::
> > > > +
> > > > + +----------+------------------+-----------------+------+
> > > > + | headroom | xdp_skb_metadata | custom metadata | data |
> > > > + +----------+------------------+-----------------+------+
> > > > + ^ ^
> > > > + | |
> > > > + xdp_buff->data_meta xdp_buff->data
> > > > +
> > > > +Where ``xdp_skb_metadata`` is the metadata prepared by
> > > > +``bpf_xdp_metadata_export_to_skb``. And ``custom metadata``
> > > > +is prepared by the BPF program via calls to ``bpf_xdp_adjust_meta``.
> > > > +
> > > > +Note that ``bpf_xdp_metadata_export_to_skb`` doesn't adjust
> > > > +``xdp->data_meta`` pointer. To access the metadata generated
> > > > +by ``bpf_xdp_metadata_export_to_skb`` use ``xdp_buf->skb_metadata``.
> > > > +
> > > > +AF_XDP
> > > > +======
> > > > +
> > > > +``AF_XDP`` use-case implies that there is a contract between the BPF program
> > > > +that redirects XDP frames into the ``XSK`` and the final consumer.
> > > > +Thus the BPF program manually allocates a fixed number of
> > > > +bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
> > > > +of kfuncs to populate it. User-space ``XSK`` consumer, looks
> > > > +at ``xsk_umem__get_data() - METADATA_SIZE`` to locate its metadata.
> > > > +
> > > > +Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
> > > > +
> > > > + +----------+------------------+-----------------+------+
> > > > + | headroom | xdp_skb_metadata | custom metadata | data |
> > > > + +----------+------------------+-----------------+------+
> > > > + ^
> > > > + |
> > > > + rx_desc->address
> > > > +
> > > > +XDP_PASS
> > > > +========
> > > > +
> > > > +This is the path where the packets processed by the XDP program are passed
> > > > +into the kernel. The kernel creates ``skb`` out of the ``xdp_buff`` contents.
> > > > +Currently, every driver has a custom kernel code to parse the descriptors and
> > > > +populate ``skb`` metadata when doing this ``xdp_buff->skb`` conversion.
> > > > +In the future, we'd like to support a case where XDP program can override
> > > > +some of that metadata.
> > > > +
> > > > +The plan of record is to make this path similar to ``bpf_redirect_map``
> > > > +below where the program would call ``bpf_xdp_metadata_export_to_skb``,
> > > > +override the metadata and return ``XDP_PASS``. Additional work in
> > > > +the drivers will be required to enable this (for example, to skip
> > > > +populating ``skb`` metadata from the descriptors when
> > > > +``bpf_xdp_metadata_export_to_skb`` has been called).
> > > > +
> > > > +bpf_redirect_map
> > > > +================
> > > > +
> > > > +``bpf_redirect_map`` can redirect the frame to a different device.
> > > > +In this case we don't know ahead of time whether that final consumer
> > > > +will further redirect to an ``XSK`` or pass it to the kernel via ``XDP_PASS``.
> > > > +Additionally, the final consumer doesn't have access to the original
> > > > +hardware descriptor and can't access any of the original metadata.
> > > > +
> > > > +To support passing metadata via ``bpf_redirect_map``, there is a
> > > > +``bpf_xdp_metadata_export_to_skb`` kfunc that populates a subset
> > > > +of metadata into ``xdp_buff``. The layout is defined in
> > > > +``struct xdp_skb_metadata``.
> > > > +
> > > > +Mixing custom metadata and xdp_skb_metadata
> > > > +===========================================
> > > > +
> > > > +For the cases of ``bpf_redirect_map``, where the final consumer isn't
> > > > +known ahead of time, the program can store both, custom metadata
> > > > +and ``xdp_skb_metadata`` for the kernel consumption.
> > > > +
> > > > +Current limitation is that the program cannot adjust ``data_meta`` (via
> > > > +``bpf_xdp_adjust_meta``) after a call to ``bpf_xdp_metadata_export_to_skb``.
> > > > +So it has to, first, prepare its custom metadata layout and only then,
> > > > +optionally, store ``xdp_skb_metadata`` via a call to
> > > > +``bpf_xdp_metadata_export_to_skb``.
> > > > --
> > > > 2.38.1.431.g37b22c650d-goog
> > > >
