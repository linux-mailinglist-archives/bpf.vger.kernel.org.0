Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D2C699B59
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBPRdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 12:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPRdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 12:33:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E22E81C
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:33:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t16so5641149edd.10
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ1LE4az2VYlBMNmgbX8QJHSc2f9AjOFjVARuibJCJA=;
        b=hjMJM09w+JUUDs/KCgITIbFnytkTa+5xOAm3uUyr4/nl7wlwd7WSclgM1whHLivLWJ
         QSzWtfFEyCg1QjJkOwXJL2Bj8QYeLRxnm61HGinDqD31elKRCMnE53q2TxP/wAthyZTq
         Js2tlqpCm1caOL+Xm4sYuLTvg8r3iSJPYshw9yRZJ7I9Qy9rb43SqPb6VhGdeR4X7qxX
         kVKrakMqANB5rxGoww6J2nNiPpSkB3uNWMQb06mId50pKopjRJzWGujsHtoV7NuOxDDo
         zFe4irofB7vYEROh7TY9hK0uXFuWXP3YOYuJf3StrSiG0OGW8KT6zbWZYZU8ObVNVGFw
         6TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ1LE4az2VYlBMNmgbX8QJHSc2f9AjOFjVARuibJCJA=;
        b=wqII01OWTgP1u3+7ydcHvbtbsonkE/qi4z3QHqQkTbBptqPgSbI+ynTSapS3lXtDyy
         CFPjHDJy+FB9OGhJ5T8moBiuYf5dXr5XxxIM+bnD97Ud7Cs3fE+87QFTtkSfe7VuUvRx
         9Kx41rZ0BY8JjLTjxlnWL66jnUY79S6UNfJJN2bJ5c8fXipftfDSMU04z2dYWZLwDfZd
         ABRY7qL/coCdDrksECDFpoV/+s59btmfRRFffXevIxivJLtf+Z+AFhv6TvKO2ro6A+Lr
         ghuvr8WVsjdbBeQ3su6X2YDdLtTBVvnxcL1xYI8QtYiiC53fjhvsa1R/YmcJ0X4pEVju
         4iyQ==
X-Gm-Message-State: AO0yUKXNQVGNu5/FBftillJXCl+223SBc2c4L7KNfhm3HZAqEyTuIUIw
        FNFrLNPNYdyJuWUF74wwJ97BYGdEm+Yy2zepDm8=
X-Google-Smtp-Source: AK7set9nmyoSYrVSYoBm3K+bct4HXRBtewnobSPfHEnrUmmZl8ovyaY8CKAt/IwHg9vFchCOppuPgOb5nU+VavaMEOY=
X-Received: by 2002:a50:aac1:0:b0:4ac:b38f:51a1 with SMTP id
 r1-20020a50aac1000000b004acb38f51a1mr3332821edc.6.1676568813199; Thu, 16 Feb
 2023 09:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
 <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com> <Y+5nCRZ3ns3u+Tun@google.com>
In-Reply-To: <Y+5nCRZ3ns3u+Tun@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Feb 2023 09:33:21 -0800
Message-ID: <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Thu, Feb 16, 2023 at 9:25 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On 02/16, Alexei Starovoitov wrote:
> > On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Make the code more readable by introducing a symbolic constant
> > > instead of using 0.
> > >
> > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  include/uapi/linux/bpf.h       |  4 ++++
> > >  kernel/bpf/disasm.c            |  2 +-
> > >  kernel/bpf/verifier.c          | 12 +++++++-----
> > >  tools/include/linux/filter.h   |  2 +-
> > >  tools/include/uapi/linux/bpf.h |  4 ++++
> > >  5 files changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 1503f61336b6..37f7588d5b2f 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> > >   */
> > >  #define BPF_PSEUDO_FUNC                4
> > >
> > > +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm == index
> > of a bpf
> > > + * helper function (see ___BPF_FUNC_MAPPER below for a full list)
> > > + */
> > > +#define BPF_HELPER_CALL                0
>
> > I don't like this "cleanup".
> > The code reads fine as-is.
>
> Even in the context of patch 4? There would be the following switch
> without BPF_HELPER_CALL:
>
> switch (insn->src_reg) {
> case 0:
>         ...
>         break;
>
> case BPF_PSEUDO_CALL:
>         ...
>         break;
>
> case BPF_PSEUDO_KFUNC_CALL:
>         ...
>         break;
> }
>
> That 'case 0' feels like it deserves a name. But up to you, I'm fine
> either way.

It's philosophical.
Some people insist on if (ptr == NULL). I insist on if (!ptr).
That's why canonical bpf progs are written as:
val = bpf_map_lookup();
if (!val) ...
zero is zero. It doesn't need #define.
