Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8660540C
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJSXiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiJSXiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:38:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC41CD6B5
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:38:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so27530628edc.4
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnjjDusnSqw6PXk/4rNV5XQIerNrtjZ7l72TQZ/5vk0=;
        b=DdtWqitMgP9vyzF7UM7V4FV1UHa6+iOP8YZ9pq3cg7DioCWX+4s9/kEi26209UxvPV
         0lZFi0779Lg4YNyTPNS/pTFGQTjtZjCagUJ7Dgzluo/ovaM+64LvkBOqR/jV7HeAygHD
         aWiikfPuWTHmtfbuCLheXaFPhvYUtX1S85VZjNL+0Rna+YDr03rqsp4PXggK+S+fFXib
         qabeUqLPwmXVyKoUsqElJBMnJOegwZ5i71Jqo+aRnjiT0OW+5pI2R0CzblDubVHWZbGt
         HSHgO0eIif5ODRQxVqfKkp5P84vkq3/Z8St3EX0RXXpfKdoWTXVQlpDwq57bMuQlgpvY
         Mv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnjjDusnSqw6PXk/4rNV5XQIerNrtjZ7l72TQZ/5vk0=;
        b=4W4rE998zxsAYhc4qXF2hXvln0wbVHGXAGF9r6LQccYIM5TEg/qJScFWdmUm+nRVFD
         n5XOH658FrhVgwiAQ/0cY30OzYO5hzkH1ActtAQ4JXsCD0KVH2/rJ2gtFB7mQd7zND5K
         7hr5zJixeZybJsuBbJM9cf0CBnz+XLQMr4ll93HMzVxgjtJJcQqkiFjh8OgkCvKspu8i
         0GZLY0RTz+Ry2vzFlbBLuYgPjiocrWCmkF4bbipedViQhIgph0As3lII6WLW9uZZNMNA
         GmbKQsNDW0WFj1PHCRKMPmLs8ELXLPybXvg/ju/Z1MPy+7lR65m86vIJC4ZZbwnk5P+L
         Xknw==
X-Gm-Message-State: ACrzQf3eP/kEdmzYLczQxY7ji/MkZxSi9WV+SEvl3B6dyxJgXfYgrgTn
        0eNGL6l351ShOfIXk6w/J3G1T/bEAkv/fkqykKw=
X-Google-Smtp-Source: AMsMyM4nwSnuSmsX+rxkKda6QQ0bzA6lJMaZ2RQZkQnH00JffoRL9miomJPMolAlP7TwGEURfvBXU0t5f8DjLnYkIw8=
X-Received: by 2002:a05:6402:1205:b0:458:c1b2:e428 with SMTP id
 c5-20020a056402120500b00458c1b2e428mr9590214edw.94.1666222682081; Wed, 19 Oct
 2022 16:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221019183845.905-1-dthaler1968@googlemail.com>
 <20221019183845.905-3-dthaler1968@googlemail.com> <Y1BkuZKW7nCUrbx/@google.com>
 <DM4PR21MB3440ED1A4A026F13F73358C3A32B9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
In-Reply-To: <CAKH8qBterhU-FM52t8ZukUUD3WkUhhNLSFq1y2zD7geq4TYO6g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 16:37:50 -0700
Message-ID: <CAADnVQ+8AtZWAOeeWG5REvW2nW7bw20aZpfHxUjERnqMSHGRiw@mail.gmail.com>
Subject: Re: [PATCH 3/4] bpf, docs: Use consistent names for the same field
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Dave Thaler <dthaler@microsoft.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, Oct 19, 2022 at 4:35 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Oct 19, 2022 at 2:06 PM Dave Thaler <dthaler@microsoft.com> wrote:
> >
> > sdf@google.com wrote:
> > > >   ``BPF_ADD | BPF_X | BPF_ALU`` means::
> > >
> > > > -  dst_reg = (u32) dst_reg + (u32) src_reg;
> > > > +  dst = (u32) (dst + src)
> > >
> > > IIUC, by going from (u32) + (u32) to (u32)(), we want to signal that the value
> > > will just wrap around?
> >
> > Right.  In particular the old line could be confusing if one misinterpreted it as
> > saying that the addition could overflow into a higher bit.  The new line is intended
> > to be unambiguous that the upper 32 bits are 0.
> >
> > > But isn't it more confusing now because it's unclear
> > > what the sign of the dst/src is (s32 vs u32)?
> >
> > As stated the upper 32 bits have to be 0, just as any other u32 assignment.
>
> Do we mention somewhere above/below that the operands are unsigned?
> IOW, what prevents me from reading this new format as follows?
>
> dst = (u32) ((s32)dst + (s32)src)

The doc mentions it, but I completely agree with you.
The original line was better.
Dave, please undo this part.
