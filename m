Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02D623887
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 02:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKJBCO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 20:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKJBCM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 20:02:12 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F75E68
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:02:12 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p141so201803iod.6
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 17:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CUpF8sPjSKa1qNYh255GV9ZgKn7MltcaT4JcHEFhGY=;
        b=MNdu2pMdm9Q/07uvCc/zUIAyVQxalRVb7Hlr94A0mceH+Li1TWOT/WBQNzhUBXY6CY
         s+KNuB9k1qAkQC6XzPqX2+NXByTm72czY3m2UbOt9yqRBmFCYC5Y1hbEMWbg+ZvttHZT
         jIPsSRcstPdI8PT0q1NSd4oK1ACUzG93mJ+qSVvSKpX37nonJE3EY7MIExhw9FqKDc+d
         +aXbpxtqVnpnDmQRN5W1wEMjDjJn69ttp35I1tTjcLo9G0lLmdgOhE0lXC7TJfu5HAK/
         AnDWp5DJzP76Y0pSK0ABJX1VU4Ie2IzW1n1PZkLJlmNRow+mKg1xjpDwV03HfnOrcTBp
         oy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CUpF8sPjSKa1qNYh255GV9ZgKn7MltcaT4JcHEFhGY=;
        b=6NJlV97i34dGGLLt5poiKgcsZPLFkRtaK5eiwwtUuO3C19AI4iSs/AJpxb+ut52+e3
         zU8MSGzWokU8RB4AyeznY0CePTZR0xPa5hCye717+5ia3XlI5POsgMVekBOlraBEvHnQ
         UmINE0bZEc7aVeg2naNQ2hsAKCJqtfX18ahdmO/bvely6YRvQjfOOp6eQxk6P4iuciLz
         /PWEgf/ADFGrt5PqgUIGRzwChpJY5rqZIOrjJIsTQIrkaRsEHws+AbmlUs7z+Qq/C2eV
         FUs2NQ32qOJUPUIfxOjDK05nOhGgjXPYufK9ZL6N8zyAF5ye30Jq0a7m0zW1z8lNc/1/
         mP3g==
X-Gm-Message-State: ANoB5pmJor+VNgIqJsAl9Eyrp7QmmdzQQl1AT316jY1twdyZbxFlZ1bk
        Ye/31nQI/6xpw//Xn/0jDe7RA7VwN4ZV2FvmFG/tOXcqHAvZUg==
X-Google-Smtp-Source: AA0mqf5iU++nhS9XQpgQ+bbgvvR9S0yg/vQEYa81M7IXz1j3U6aRC34YmQ61ZR1XSRw9bTVDQWqMV96gLsvOhOr1jVw=
X-Received: by 2002:a02:ca49:0:b0:375:c385:d846 with SMTP id
 i9-20020a02ca49000000b00375c385d846mr1901422jal.84.1668042131419; Wed, 09 Nov
 2022 17:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20221104032532.1615099-1-sdf@google.com> <20221104032532.1615099-5-sdf@google.com>
 <636c4514917fa_13c168208d0@john.notmuch>
In-Reply-To: <636c4514917fa_13c168208d0@john.notmuch>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 9 Nov 2022 17:02:00 -0800
Message-ID: <CAKH8qBvS9C5Z2L2dT4Ze-dz7YBSpw52VF6iZK5phcU2k4azN5A@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 04/14] veth: Support rx timestamp metadata for xdp
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
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

On Wed, Nov 9, 2022 at 4:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Stanislav Fomichev wrote:
> > xskxceiver conveniently setups up veth pairs so it seems logical
> > to use veth as an example for some of the metadata handling.
> >
> > We timestamp skb right when we "receive" it, store its
> > pointer in new veth_xdp_buff wrapper and generate BPF bytecode to
> > reach it from the BPF program.
> >
> > This largely follows the idea of "store some queue context in
> > the xdp_buff/xdp_frame so the metadata can be reached out
> > from the BPF program".
> >
>
> [...]
>
> >       orig_data = xdp->data;
> >       orig_data_end = xdp->data_end;
> > +     vxbuf.skb = skb;
> >
> >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> >
> > @@ -942,6 +946,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> >                       struct sk_buff *skb = ptr;
> >
> >                       stats->xdp_bytes += skb->len;
> > +                     __net_timestamp(skb);
>
> Just getting to reviewing in depth a bit more. But we hit veth with lots of
> packets in some configurations I don't think we want to add a __net_timestamp
> here when vast majority of use cases will have no need for timestamp on veth
> device. I didn't do a benchmark but its not free.
>
> If there is a real use case for timestamping on veth we could do it through
> a XDP program directly? Basically fallback for devices without hw timestamps.
> Anyways I need the helper to support hardware without time stamping.
>
> Not sure if this was just part of the RFC to explore BPF programs or not.

Initially I've done it mostly so I can have selftests on top of veth
driver, but I'd still prefer to keep it to have working tests.
Any way I can make it configurable? Is there some ethtool "enable tx
timestamping" option I can reuse?

> >                       skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
> >                       if (skb) {
> >                               if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
