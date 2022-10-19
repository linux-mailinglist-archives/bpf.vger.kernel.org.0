Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E66053FE
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJSXeG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJSXeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:34:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398F172B7C
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:34:05 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l3so9623330ilg.13
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abr+u3gmgmHhcaCMi570T4EDBf+4IYjW3x8/kZIifxw=;
        b=XBvuMNTcjXmoYBMDPuQujSQXzyAnWYxQXt6PFsN/WWDgedX5NG7o1paBuiL4BZ+wOI
         MFdw4J476cRTe8z7zFxgOUDZvkhNdLAphnQD6dISYMWRjV1IpgD8xMIgfKoyclPsfKAh
         JjSWhQvXc3gIXJonyq1isWgEJUgSpm4/VvK33S9lqxdS95RQiXnYPhWGKCB5Ug5gNnF8
         RrymZpqhsjbPvLidLWAnbfBt8HG73hgKFfWvpNLYx9QWw8rVPKnGXofNU301cQsFy3TR
         NrdxZJZEAM8gxq9S8pfwy2BqsUqphuU28hl8HKCAOP0OIhRIsb+jTK9twXb8GgNemzpk
         3N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abr+u3gmgmHhcaCMi570T4EDBf+4IYjW3x8/kZIifxw=;
        b=o4H5jBiLalqnrq4CbWwoRF+DtX+ao5rMNV0HPtHcZ/4DTb61qlJ9avuGInFZW8bAvO
         TMDpuc2tlYIKXT8RuPHVXznnq3U9xkcITc7SavsEoxUmngZmUoQxZ8F+bKMBZFQlBKbo
         85DFyn6UbSoCNQnTQ7vcijQilmfFtvC4xevSSEU4Sd7/BsQ935a8vUWiJbpcFo+GTEna
         rqOPMm+PZxr7N361iQfefEdpwyHt8KdbKyQ7IDHEPvJIaBLKg/7xUp14r+p9gerIvLUj
         B2RNauXyZDQPxzal0N4F4cggRyADriTDAtrXVmQ2I1O/TgB18Bde7HJfNE+u64NW9O/Z
         hzSA==
X-Gm-Message-State: ACrzQf2ql5CjaS0cDpjW8iu3gBPDHu0rgIAsnJTFyE6ZrRsRQMNJf0pa
        KhZOFr4M3oYKoENoXz/lgFcjurLeFDGTmb24yjPQNA==
X-Google-Smtp-Source: AMsMyM7j524NB9LHoFaEr7QrR008WVQ3c5puaBUEW1O7RzFWwmE83WapkV/cHoioMH+fEbNDdZuTN+Xk+tMU1sdV1es=
X-Received: by 2002:a05:6e02:17cb:b0:2f9:1fb4:ba3b with SMTP id
 z11-20020a056e0217cb00b002f91fb4ba3bmr7591749ilu.257.1666222444340; Wed, 19
 Oct 2022 16:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com> <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 19 Oct 2022 16:33:53 -0700
Message-ID: <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Oct 19, 2022 at 2:06 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
> sdf@google.com wrote:
> > >   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> >
> > > -  dst_reg = (u32) dst_reg + (u32) src_reg;
> > > +  dst = (u32) (dst + src)
> >
> > IIUC, by going from (u32) + (u32) to (u32)(), we want to signal that the value
> > will just wrap around?
>
> Right.  In particular the old line could be confusing if one misinterpreted it as
> saying that the addition could overflow into a higher bit.  The new line is intended
> to be unambiguous that the upper 32 bits are 0.
>
> > But isn't it more confusing now because it's unclear
> > what the sign of the dst/src is (s32 vs u32)?
>
> As stated the upper 32 bits have to be 0, just as any other u32 assignment.

Do we mention somewhere above/below that the operands are unsigned?
IOW, what prevents me from reading this new format as follows?

dst = (u32) ((s32)dst + (s32)src)

> > Also, we do keep (u32) ^ (u32) for BPF_XOR below..
>
> Well for XOR it's equivalent either way so didn't need a change.
>
> Thanks for reviewing,
> Dave
>
