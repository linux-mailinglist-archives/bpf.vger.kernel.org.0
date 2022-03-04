Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139184CDEB5
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCDUGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiCDUGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:06:02 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CD31AF78
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:01:48 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q8so10757851iod.2
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 12:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7OLZj9rVyIA/cuusSddefTkUC8S9jwrVI7aSuOTwU8=;
        b=KZhl8cPz8VPZF189CYhXzEKjOV85C3T479ZsuAQDX690BJgGL3X2woY6yrMh8BlVHY
         QE5fE8y6m3b764RObAYkC5gKB+5NnNvTVB/6+vSjdAQlBJfV3eu97GBBUcuwJYpy7Zjv
         /EW48ykwVHn74RiL4WEEUnlAHQUaeV4NeHp+84gbbMPFtvCtyX44I2Q6GC1KPczTx5qt
         zLhiXNYgYQoCRxAUnexdCn+uxGxahE8eHWBiAwWOEpFcYNN5QCoGG7pPTxptCWNnKCGQ
         CRfmdhsjmM7UBBDco0NFSeUvuMWl/o+LWgqYSUZUgzVR9dTKzeWLxIdZlmnQSepcxh0o
         yLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7OLZj9rVyIA/cuusSddefTkUC8S9jwrVI7aSuOTwU8=;
        b=Mop3c5x7kaApZdeDekwx5G4DBrHEGG00XXQrNkpdUWX4HKC6LWdj6bo8kd46INetYp
         DqxlvNhuSd5QKDVihIcO9E881Wh+nThI1a7hWJ7sImpRSB4BENLaVs3SuxK5SNKW10CD
         y/VPhitvfxR9T+xX0Gvnp5jxMTZv64y294cYYUE/QwyZyjBJwoZJfAdrHKcE9ODiqUtK
         BYmy1mEM/TG/KD3yerjCYkoOfQNW5lxPoL6t0JPJSUdGkwFq2lT3tPFd2CzdvIQjsrn+
         jKNtopgCeZ8L7eSkiEfEBfq6azX0G6QgV08GQueyQMi8OUw/lJkNL+9EJFH57Beqq7KT
         HDaA==
X-Gm-Message-State: AOAM5318fApMSr6KjhsHvwvEwXyvST6li/oYhTei7A7lfOjX+w5s1NSf
        KaepvA2qxnvGWU1jKNlVlJhMlTRtBy4AB3rKfJEFo0EgN+M=
X-Google-Smtp-Source: ABdhPJzRmZ6kQ8lsE6/KDwx6+rpivxNdG3UV8ztcjbr90G3xY9TwwfDWgK7onMlsqM6owxeYwcDMiKEswzXsy0+q3Ys=
X-Received: by 2002:a5e:c648:0:b0:640:bc31:cbec with SMTP id
 s8-20020a5ec648000000b00640bc31cbecmr114683ioo.79.1646422207587; Fri, 04 Mar
 2022 11:30:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
 <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
 <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com> <108158a8914fbae73f750d635773172db007a704.camel@fb.com>
In-Reply-To: <108158a8914fbae73f750d635773172db007a704.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Mar 2022 11:29:56 -0800
Message-ID: <CAEf4Bzb_iM7pmuTdRu7JinUpXU-h-En0Vs+DPTshZgg-86YAJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 12:54 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Thu, 2022-03-03 at 10:52 -0800, Delyan Kratunov wrote:
> > >
> > > >
> > > > +               map_type_id = btf__find_by_name_kind(btf,
> > > > bpf_map__section_name(map), BTF_KIND_DATASEC);
> > >
> > > if we set obj_name to "", bpf_map__name() should return ELF section
> > > name here, so no need to expose this as an API
> > >
> > >
> > > oh, but also bpf_map__btf_value_type_id() should give you this ID directly
> >
> > TIL, that's not obvious at all. There's a few places in gen.c that could be
> > simplified then - find_type_for_map goes through slicing the complete name and
> > walking over every BTF type to match on the slice. Is there some compatibility
> > reason to do that or is btf_value_type_id always there?
>
> Unfortunately, the internal datasec maps have value_type_id = key_value_type_id
> = 0 i.e. void, so bpf_map__btf_value_type_id won't work out of the box.
>
> I haven't looked if that's a bug all the way in clang-emitted object or
> somewhere further on.

Yeah, just replied in another email. We fill it out too late, but it
should be possible to move it earlier into open phase.

>
> -- Delyan
