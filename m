Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980B62899B
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiKNTpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNTpI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:45:08 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E111117F;
        Mon, 14 Nov 2022 11:45:08 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-367b8adf788so117169857b3.2;
        Mon, 14 Nov 2022 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0kTaazvMn+z7PkbY5IIj8bT/sIYdhb5EA9tVD/sgOk=;
        b=LTVjtCRzIcENz2uMWyMTJLNHxbs1s0zAT4BOk+LWOqU2MubC/4YkcoLJpN1SGcaief
         WoTgigKHlHrzy0GzGgctB3lnteKhoPlhrKcfnWN+mPy4aGvW+6IRm1Db3nuZrb4RCbKV
         F+/Wc8QnumdjeShTx3wGs+5pSZBOdYGAZtsHYltCNWSGixiwuz0ScD3pW8v9YOXaRnJG
         eZW1PM3Q3pojWkk1jdsrlXUj+7mp68xyvDH2+RQYNjZE/vBNdtar1m9Gb25GFPnPyYGv
         MTDZO+n9tRZ0+9opdCwoSlNCYQDOfm6dSFToOujc4gGaVI1SaYdLHUKGmxCm1ZNaJK4s
         re5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0kTaazvMn+z7PkbY5IIj8bT/sIYdhb5EA9tVD/sgOk=;
        b=58f3wt4lbiJtrCSeDGEWHl4CMuNv/e8+hYoHtrIM+n8+/Al8tx5vmGgFHqit09i3Lb
         hgZBdaCHLslJUy2eOGhH0ivQRgGb9hw73fKQnSGBQoE7Rtfog0h6gXnELdGSwwkJKAwu
         YkVwv7LHMnFzfdpeCzAK8iVGW5RNzDkkssrD6QZ8TT+5+tOYQKreTcsowFws1a/mTxxC
         jBBWn/5SP9QsDIf9enclgW8xDtYtONsdQV1cu/M8C4QcpkZHpoVksOAWc+6peM9ZD4FU
         vKGD5HzQKLvp1V27Upp4I25UMahVHs/kTjFN/ABaKX2IkfT/HkNmmz0u628w9eGdvQoB
         F/Eg==
X-Gm-Message-State: ANoB5pkbMNwwZ9WSwC1e5lEPGi5FP+rZRMWfqESUiCYY13NpW5Ag1yRd
        dU24zD1stl16o/hpdFtEyi2MGBvsUrh76oYobsA=
X-Google-Smtp-Source: AA0mqf6vxug+NW6/2EGHo80FbfEq9l2aNaKfoEXFXFi/DxRbB76grQcYVWmSr4VaVaNWGCgHegNm1nIw5tBETR3lvJg=
X-Received: by 2002:a81:8087:0:b0:367:3d7c:30df with SMTP id
 q129-20020a818087000000b003673d7c30dfmr14249259ywf.511.1668455107198; Mon, 14
 Nov 2022 11:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20221109174604.31673-1-donald.hunter@gmail.com>
 <20221109174604.31673-2-donald.hunter@gmail.com> <CAEf4Bzak4A-vP=NeJheA0poiu_8fK53cvbq1EnnSHC78FB7mtQ@mail.gmail.com>
 <m24jv17sbn.fsf@gmail.com>
In-Reply-To: <m24jv17sbn.fsf@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Nov 2022 11:44:53 -0800
Message-ID: <CAEf4BzZeYN0BY6xRB8XnXE8n6Nd3Y1t5Y-LpjgsLDgGaNGgE_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Tucker <dave@dtucker.co.uk>,
        Maryam Tahhan <mtahhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 2:57 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Nov 9, 2022 at 9:46 AM Donald Hunter <donald.hunter@gmail.com> wrote:
> >>
> >> +This example BPF program shows how to access an array element.
> >> +
> >> +.. code-block:: c
> >> +
> >> +    int bpf_prog(struct __sk_buff *skb)
> >> +    {
> >> +            struct iphdr ip;
> >> +            int index;
> >> +            long *value;
> >> +
> >> +            if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip, sizeof(ip)) < 0)
> >> +                    return 0;
> >> +
> >> +            index = ip.protocol;
> >> +            value = bpf_map_lookup_elem(&my_map, &index);
> >> +            if (value)
> >> +                    __sync_fetch_and_add(value, skb->len);
> >
> > should be &value
> >
> > I fixed it up and applied to bpf-next, thanks.
>
> I double checked and it really should be value, which is already a
> pointer.
>
> Do you want me to send a patch to fix it up?

Oh, my bad, value is a pointer already and I was (wrongly) convinced
that it's just a stack variable. Yes, please send a patch, thanks!
