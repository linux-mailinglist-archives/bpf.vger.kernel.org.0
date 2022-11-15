Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673062AE77
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKOWox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiKOWoK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:44:10 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA718B0A
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:44:09 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so8211802ilt.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1x2/L1T0WtWyFMgFLrb66QK4cplfsf+uyqGkhNI2KKQ=;
        b=WFgNUnl4chiFWm5ZNrOCo1LqKDET2aBPgVQ7Dm3+QxxdR1uM453Am+3Mawo2VLXCjG
         75zt8NOvfE7Uov2R2+dqzQfHvcjw1QocG0sMScVyTwQ7spC4clR5xzdhCiMnschCmXgt
         LYHYn5l9U9LXC91l5brUL80G3ZuvNai97jXkKVl1kiqpH9w/dvhnLEcQIDiwpDtvLyzD
         pun7P5k0esM8BSIm78oGv+vjgdIfGVkcJtiSzfDJfDI4OM9W4KIyPkT9cPcLX/lkdDqk
         esUPZLpZf7N/DLA6eOfxZaR+GCD2EBXlN/ii84TtZB1NVZlecKxfDbv0ISwcjbbXEPQz
         qFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1x2/L1T0WtWyFMgFLrb66QK4cplfsf+uyqGkhNI2KKQ=;
        b=pJB7BchbGK/XNFj09ISUG19YT7U8c2pt9+7Fa8VnIgDozUuyeBrAMlNfVr7roQzUyD
         gLrm92irOBuh62KHibM6anOWKw+t16fw/c/L9VmLSNE9U3h9BW08YOdBDF7eP85Iq+bf
         9BMnBZZ5fZcie7y921B1sufkdRsMdpYbD4RyC7j7fTpAEKO+rv0NsizTdjPis49G+QPa
         +4CF8jW2YHu1QUo/M2+TlKV2ScoJKgFZ60z3fx1eN6OSC7lXVfPdKUR7sMEPJSQj1kSO
         w3eq+xOIORMzGKVmaznUWn7/UEF0UnJUcQcITjFyqKSVahoEpshkeEPsbU/vf9nxLzat
         TH9w==
X-Gm-Message-State: ANoB5plp7S8VSyuAaE8TdHlnCYCxY+Wn6NeZ+2AGq+nZ+HCE9MbJ3JxY
        vvy9IFdLNoHz8roqnOSOx3bTPd0HYVV2dX0BBDwZquLrzQ+J9Q==
X-Google-Smtp-Source: AA0mqf7GELw7CYrBJ/6SNPTe+5yS75odkqth7YIn/VDPyYoTVwZsIkMpI143fft/c3kMJ8Nz7qIBbEf9CwVMkothVKw=
X-Received: by 2002:a92:d1c4:0:b0:2ea:ba31:f2ef with SMTP id
 u4-20020a92d1c4000000b002eaba31f2efmr9137492ilg.159.1668552249098; Tue, 15
 Nov 2022 14:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com> <20221115030210.3159213-2-sdf@google.com>
 <CAC1LvL2Qg3jYAUPJ4GofJPBnk4HKYOuqyH_P_ZOcN45TZUzrHQ@mail.gmail.com>
In-Reply-To: <CAC1LvL2Qg3jYAUPJ4GofJPBnk4HKYOuqyH_P_ZOcN45TZUzrHQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 15 Nov 2022 14:43:58 -0800
Message-ID: <CAKH8qBtDbZSa9VTaNOFNsm-FJgvDngjw7rJuT=QAnAD3FoGfsw@mail.gmail.com>
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

On Tue, Nov 15, 2022 at 2:31 PM Zvi Effron <zeffron@riotgames.com> wrote:
>
> On Mon, Nov 14, 2022 at 7:04 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Document all current use-cases and assumptions.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  Documentation/bpf/xdp-rx-metadata.rst | 109 ++++++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/bpf/xdp-rx-metadata.rst
> >
> > diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/bpf/xdp-rx-metadata.rst
> > new file mode 100644
> > index 000000000000..5ddaaab8de31
> > --- /dev/null
> > +++ b/Documentation/bpf/xdp-rx-metadata.rst
> > @@ -0,0 +1,109 @@
> > +===============
> > +XDP RX Metadata
> > +===============
> > +
> > +XDP programs support creating and passing custom metadata via
> > +``bpf_xdp_adjust_meta``. This metadata can be consumed by the following
> > +entities:
> > +
> > +1. ``AF_XDP`` consumer.
> > +2. Kernel core stack via ``XDP_PASS``.
> > +3. Another device via ``bpf_redirect_map``.
>
> 4. Other eBPF programs via eBPF tail calls.

Don't think a tail call is a special case here?
Correct me if I'm wrong, but with a tail call, we retain the original
xdp_buff ctx, so the tail call can still use the same kfuncs as if the
original bpf prog was running.

> > +
> > +General Design
> > +==============
> > +
> > +XDP has access to a set of kfuncs to manipulate the metadata. Every
> > +device driver implements these kfuncs by generating BPF bytecode
> > +to parse it out from the hardware descriptors. The set of kfuncs is
> > +declared in ``include/net/xdp.h`` via ``XDP_METADATA_KFUNC_xxx``.
> > +
> > +Currently, the following kfuncs are supported. In the future, as more
> > +metadata is supported, this set will grow:
> > +
> > +- ``bpf_xdp_metadata_rx_timestamp_supported`` returns true/false to
> > +  indicate whether the device supports RX timestamps in general
> > +- ``bpf_xdp_metadata_rx_timestamp`` returns packet RX timestamp or 0
> > +- ``bpf_xdp_metadata_export_to_skb`` prepares metadata layout that
> > +  the kernel will be able to consume. See ``bpf_redirect_map`` section
> > +  below for more details.
> > +
> > +Within the XDP frame, the metadata layout is as follows::
> > +
> > +  +----------+------------------+-----------------+------+
> > +  | headroom | xdp_skb_metadata | custom metadata | data |
> > +  +----------+------------------+-----------------+------+
> > +                                ^                 ^
> > +                                |                 |
> > +                      xdp_buff->data_meta   xdp_buff->data
> > +
> > +Where ``xdp_skb_metadata`` is the metadata prepared by
> > +``bpf_xdp_metadata_export_to_skb``. And ``custom metadata``
> > +is prepared by the BPF program via calls to ``bpf_xdp_adjust_meta``.
> > +
> > +Note that ``bpf_xdp_metadata_export_to_skb`` doesn't adjust
> > +``xdp->data_meta`` pointer. To access the metadata generated
> > +by ``bpf_xdp_metadata_export_to_skb`` use ``xdp_buf->skb_metadata``.
> > +
> > +AF_XDP
> > +======
> > +
> > +``AF_XDP`` use-case implies that there is a contract between the BPF program
> > +that redirects XDP frames into the ``XSK`` and the final consumer.
> > +Thus the BPF program manually allocates a fixed number of
> > +bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
> > +of kfuncs to populate it. User-space ``XSK`` consumer, looks
> > +at ``xsk_umem__get_data() - METADATA_SIZE`` to locate its metadata.
> > +
> > +Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
> > +
> > +  +----------+------------------+-----------------+------+
> > +  | headroom | xdp_skb_metadata | custom metadata | data |
> > +  +----------+------------------+-----------------+------+
> > +                                                  ^
> > +                                                  |
> > +                                           rx_desc->address
> > +
> > +XDP_PASS
> > +========
> > +
> > +This is the path where the packets processed by the XDP program are passed
> > +into the kernel. The kernel creates ``skb`` out of the ``xdp_buff`` contents.
> > +Currently, every driver has a custom kernel code to parse the descriptors and
> > +populate ``skb`` metadata when doing this ``xdp_buff->skb`` conversion.
> > +In the future, we'd like to support a case where XDP program can override
> > +some of that metadata.
> > +
> > +The plan of record is to make this path similar to ``bpf_redirect_map``
> > +below where the program would call ``bpf_xdp_metadata_export_to_skb``,
> > +override the metadata and return ``XDP_PASS``. Additional work in
> > +the drivers will be required to enable this (for example, to skip
> > +populating ``skb`` metadata from the descriptors when
> > +``bpf_xdp_metadata_export_to_skb`` has been called).
> > +
> > +bpf_redirect_map
> > +================
> > +
> > +``bpf_redirect_map`` can redirect the frame to a different device.
> > +In this case we don't know ahead of time whether that final consumer
> > +will further redirect to an ``XSK`` or pass it to the kernel via ``XDP_PASS``.
> > +Additionally, the final consumer doesn't have access to the original
> > +hardware descriptor and can't access any of the original metadata.
> > +
> > +To support passing metadata via ``bpf_redirect_map``, there is a
> > +``bpf_xdp_metadata_export_to_skb`` kfunc that populates a subset
> > +of metadata into ``xdp_buff``. The layout is defined in
> > +``struct xdp_skb_metadata``.
> > +
> > +Mixing custom metadata and xdp_skb_metadata
> > +===========================================
> > +
> > +For the cases of ``bpf_redirect_map``, where the final consumer isn't
> > +known ahead of time, the program can store both, custom metadata
> > +and ``xdp_skb_metadata`` for the kernel consumption.
> > +
> > +Current limitation is that the program cannot adjust ``data_meta`` (via
> > +``bpf_xdp_adjust_meta``) after a call to ``bpf_xdp_metadata_export_to_skb``.
> > +So it has to, first, prepare its custom metadata layout and only then,
> > +optionally, store ``xdp_skb_metadata`` via a call to
> > +``bpf_xdp_metadata_export_to_skb``.
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
