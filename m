Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2416E4DEA48
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiCSTFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiCSTFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 15:05:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12BFD0D
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 12:04:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p8so12240939pfh.8
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7v3ursllm2d7zLn65JqdXT+6TgRSaq3PMvYUmltsZd0=;
        b=c8FYRd+NMSbbKd906Mx/bWzGN/EzUZ+NIKsFFuIr5HEOWXbwodweDeSf0Hseh0XLiw
         szA81gXDwL/XTefVzVJ61cbifaweunPKW9CZqcZviA7XegFq+OHpg2Zla2M7B/zodHZh
         pCbryCf8YrMS15uh/Il49y+Wm9gjmGrOfLC9tZo08tdATu8gADj0DyM/9TLghy/VaxHx
         mvn8BikoLHpRCN0R8xtB9GQUo/kSsGL7Abq6odX29bZp8bJrpSfTObbWXAnjQiq8P1Vk
         0DW1D6ar7Q/6/+ymK90YIvOTagSNnA+UsDwWdwRkk6uQnWKcMg4n/893gXGHkUHTsnmh
         vKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7v3ursllm2d7zLn65JqdXT+6TgRSaq3PMvYUmltsZd0=;
        b=lyjBRJNc57eC65AmUY9xdrChNuMOgXTNFlEg72fG3X/2NW0czDmvOJXd16kBD/5v6R
         up9efANpJj7f0EJGE8Nd0lXEzYnCqqF33wutgROx508cBbjL+cHaxVUB71AlONZvH1yq
         lLI5smqF3BaqhTiHItxWzHHXyfNrw2GKPx1fAogvq8MlGgFVVqAqGqiKl12BNRMky5CG
         1mrOwFJnR4ce6JhBEII1sS0FITaHtkHh53I+vIE6Vy69YfpDHd0Ph1lLqIAnPl38SYhF
         v+UQ55lRR+VIeelUGcfqCYeSNTu/g/+Rzt+dy2SsDaeipJ99nLTNdtg9FLBfXCYwZmzQ
         IIZA==
X-Gm-Message-State: AOAM530MxbnZwTqOsLsvrgqWBhYcygzy9+YeLqegWzkoLHRWnRId023D
        C3XolTNefyUrDpQp8AOZKvE=
X-Google-Smtp-Source: ABdhPJwU9OlPH2UNs2rji9v2/EQswRPV1r3pCpZACoLM9QIjx4qpoZVPySCKz+R1CugivwLHLtXoJQ==
X-Received: by 2002:a05:6a00:851:b0:4f7:68db:51bb with SMTP id q17-20020a056a00085100b004f768db51bbmr16347275pfk.74.1647716654100;
        Sat, 19 Mar 2022 12:04:14 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b004fa8892df25sm1489149pfc.64.2022.03.19.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 12:04:13 -0700 (PDT)
Date:   Sun, 20 Mar 2022 00:34:09 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Message-ID: <20220319190409.7n3bkjdp67finojx@apollo>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-6-memxor@gmail.com>
 <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 12:00:28AM IST, Alexei Starovoitov wrote:
> On Thu, Mar 17, 2022 at 05:29:47PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
> > map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
> > of pointers accepting stores of such register types. On load, verifier
> > marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
> > PTR_MAYBE_NULL.
> >
> > Cc: Hao Luo <haoluo@google.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   |  3 ++-
> >  kernel/bpf/btf.c      | 13 ++++++++++---
> >  kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
> >  3 files changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 702aa882e4a3..433f5cb161cf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -161,7 +161,8 @@ enum {
> >  };
> >
> >  enum {
> > -	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> > +	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> > +	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
>
> What is the use case for storing __percpu pointer into a map?

No specific use case for me, just thought it would be useful, especially now
that __percpu tag is understood by verifier for kernel BTF, so it may also refer
to dynamically allocated per-CPU memory, not just global percpu variables. But
fine with dropping both this and user kptr if you don't feel like keeping them.

--
Kartikeya
