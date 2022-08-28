Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2C5A3D79
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH1MEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiH1MEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 08:04:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DC1CFD5
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 05:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6266EB80AB4
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 12:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353CBC43470
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661688280;
        bh=EPbkOq8JPEc2kCjTiNGhxLiypn6VkEpuIIxi7EoZbZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F+lHTKBON1gw7x50yhM+qJreJdsujmQmZAZ80ttGEhBtRZcOpl+QnWknc7Rc9T0b4
         XFtz+KKdjsvVto2bSGOYbxi/NR8UMWigwFp2k1IclMsyD2feknXuAiEcDUPFx6qcUF
         xcn/sHfTl2PcUfiG8n+wkRFxK9gUuzIqy6SvM8iwKqPCQ25bH38PgrTJ26uZc+KX5G
         mRsyfPzVnxxo/zuBYDByW9floYE+N6YW2/A21fsYdyrFCizRILfvh5Qa56VwN18wWo
         kS7yiwbm9CbiO627BsHoz6DIKvTBLQqp+WYLujkU3npuIDpjYlnmds91xLHusYzp3s
         qxTh1Bcql2+4Q==
Received: by mail-qk1-f175.google.com with SMTP id c9so4332435qkk.6
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 05:04:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo2DXtwy2AfdLrtH5yl1nOO2YH1T5uvRwf32UY0qHYTI794CTA9M
        bdgpXcONN2F69DNda3XYVdHgOX1Tj6bYJ09kAE9u9w==
X-Google-Smtp-Source: AA6agR4FMRX+TaApxmom9KAlHmydRBHrD8YHW7gavrNzM2Rz3w+Of9yKXe9ON7GTG1+MKtNv47+OtaQujsqaLkSoGgs=
X-Received: by 2002:a05:620a:45a3:b0:6bb:d296:aa0d with SMTP id
 bp35-20020a05620a45a300b006bbd296aa0dmr5219938qkb.525.1661688267813; Sun, 28
 Aug 2022 05:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-5-roberto.sassu@huaweicloud.com> <YwhTiGOhzvv+CYYq@kernel.org>
 <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com> <YwrntbSJUs2cA7Xn@kernel.org>
In-Reply-To: <YwrntbSJUs2cA7Xn@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 14:04:17 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5zb2L18=ABUO-AnGBi-PG7SZpEA_1vGZWd4S2nC2wzPQ@mail.gmail.com>
Message-ID: <CACYkzJ5zb2L18=ABUO-AnGBi-PG7SZpEA_1vGZWd4S2nC2wzPQ@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, corbet@lwn.net, dhowells@redhat.com,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 28, 2022 at 5:57 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Aug 26, 2022 at 09:14:09AM +0200, Roberto Sassu wrote:
> > On Fri, 2022-08-26 at 08:42 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Aug 18, 2022 at 05:29:23PM +0200,
> > > roberto.sassu@huaweicloud.com wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > In preparation for the patch that introduces the
> > > > bpf_lookup_user_key() eBPF
> > > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be
> > > > able to
> > > > validate the kfunc parameters.
> > > >
> > > > Also, introduce key_lookup_flags_check() directly in
> > > > include/linux/key.h,
> > > > to reduce the risk that the check is not in sync with currently
> > > > defined
> > > > flags.
> > >
> > > Missing the description what the heck this function even is.
> > >
> > > Please, explain that.
> >
> > Hi Jarkko
> >
> > sorry, forgot to update the commit description. Will do it.
> >
> > > Also, the short subject is misleading because this *just*
> > > does not move flags.
> > >
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  include/linux/key.h      | 11 +++++++++++
> > > >  security/keys/internal.h |  2 --
> > > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/key.h b/include/linux/key.h
> > > > index 7febc4881363..b5bbae77a9e7 100644
> > > > --- a/include/linux/key.h
> > > > +++ b/include/linux/key.h
> > > > @@ -88,6 +88,17 @@ enum key_need_perm {
> > > >   KEY_DEFER_PERM_CHECK,   /* Special: permission check is
> > > > deferred */
> > > >  };
> > > >
> > > > +#define KEY_LOOKUP_CREATE        0x01
> > > > +#define KEY_LOOKUP_PARTIAL       0x02
> > > > +
> > >
> > > /*
> > >  * Explain what the heck this function is.
> > >  */
> > > > +static inline int key_lookup_flags_check(u64 flags)
> > > > +{
> > > > + if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> > > > +         return -EINVAL;
> > > > +
> > > > + return 0;
> > > > +}
> > >
> > > This is essentially a boolean function, right?
> > >
> > > I.e. the implementation can be just:
> > >
> > > !!(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> >
> > Absolutely fine with that, if you prefer.
>
> It can be either, it more depends on if a new function
> is needed in the first place.
>
> E.g. if you are worried about maintaining you could just
> as well define a constant containing the mask, right?

+1 A mask is better.

>
> >
> > > Not even sure if this is needed in the first place, or
> > > would it be better just to open code it. How many call
> > > sites does it have anyway?
> > >
> >
> > Daniel preferred to have this check here.
>
> How many call sites?
>
> BR, Jarkko
