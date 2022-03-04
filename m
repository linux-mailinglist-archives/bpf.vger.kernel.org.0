Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FEC4CE05C
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiCDWqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiCDWqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:46:33 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0D21E01
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:45:45 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso9195385pjo.5
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lIEKEgbbzIyv6Sx4tCc0HjzYjUxJuH7uoUKqzbiCiE=;
        b=qE0IOhyZuZ2FKWbR8VCO26smqwbf2S42x/D9vHCl6qtqvmneefNrApT1cZ6Q39B9/i
         VYOiYxk6oLVBsXr8H9OHDkx6jIyJJIKnDsVCnB6iq4nmAEQRD0VJrZEymLTKxpq73v+C
         PXgC50Ufv9KPesFx84meBefo5BkEqOqcXFJwviMcD5fMqjYBGDoG2zZPpeRhSpvcIwWG
         fjOxqW9AF9QoAPZJ5i0R3+1+69pLc1KGPxWOXF1YibGWry/tpLGzsjaESsghFNFRB+tn
         Jdj0i8/k1JFo0mqT6IPimsauJw5JIJkReM3sg0cHfd6AkmbRrIzEvbV51uGn6Blhh1DL
         HYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lIEKEgbbzIyv6Sx4tCc0HjzYjUxJuH7uoUKqzbiCiE=;
        b=xUCJzHFadulckieMG36ONaH7hLCJqr+YTjlEcu0PVzz7mg1/J2DFpq7KtKfLBH9GDo
         oKlm27vFvG/IjlvpXx/HLDiX7rDCLicGpM6WCYz0GpiVLiEzHho789G2EMQFJ52gtAv8
         TA2f1eazejXyyjYXF3L5ZHANyPURJuBIQ8qm8kL3uQy/8UhelmNQFMJCNMTaw+IQ79P6
         ckB23B/UXssch3Okg2vAWZRVNeiZX8qtdcBo81cVX+brZWS2Edl8IEl/M1xpphzeQptD
         gdF6N3cZkEJKrwUVUp5JH7rqC9pKfrkwnikzBkz/pjDPKT8UETmdP2pLOsAqRJxsnhMt
         Fm5w==
X-Gm-Message-State: AOAM533vCuTpjAFcRufXR0XhyfHJSeMhIjYXBPrC+dyWT1Wza3SPZxnl
        m2Czg6vPL08LBOZhGZUmf8A=
X-Google-Smtp-Source: ABdhPJxzQe29jHwdmuUCV5aaxqfIzhrxq6aDDuNasN3/3psaIasLWeqYjz8ra+inHLtLMJ04JYuJYg==
X-Received: by 2002:a17:90b:3b81:b0:1bc:d92f:d359 with SMTP id pc1-20020a17090b3b8100b001bcd92fd359mr12974609pjb.36.1646433945133;
        Fri, 04 Mar 2022 14:45:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a00231600b004e1784925e5sm7036955pfh.97.2022.03.04.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:45:44 -0800 (PST)
Date:   Sat, 5 Mar 2022 04:15:42 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304224542.lfapqmcrpbuabqpn@apollo.legion>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
 <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
 <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
 <20220304214333.5f3yzrhghmqf7rkd@kafai-mbp.dhcp.thefacebook.com>
 <20220304215556.2x2frcep5bebe7ch@apollo.legion>
 <20220304221852.gjaey2y4oztsztjj@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304221852.gjaey2y4oztsztjj@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 03:48:52AM IST, Martin KaFai Lau wrote:
> On Sat, Mar 05, 2022 at 03:25:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Mar 05, 2022 at 03:13:33AM IST, Martin KaFai Lau wrote:
> > > On Sat, Mar 05, 2022 at 02:18:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > On Sat, Mar 05, 2022 at 01:58:30AM IST, Martin KaFai Lau wrote:
>
> > > > > > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > > > > > +				regno);
> > > > > > +			return -EINVAL;
> > > > > > +		}
> > > > > > +		fixed_off_ok = release_reg ? false : true;
> > > > > nit.
> > > > > 		fixed_off_ok = !release_reg;
> > > > >
> > > > > but this is a bit moot here considering the reg->off
> > > > > check has already been done for the release_reg case.
> > > > >
> > > >
> > > > Yes, it would be a redundant check inside __check_ptr_off_reg, but we still need
> > > > to call it for checking bad var_off.
> > > Redundant check is fine.
> > >
> > > The intention and the net effect here is fixed_off is always
> > > allowed for the remaining case, so may as well directly set
> > > fixed_off_ok to true.  "fixed_off_ok = !release_reg;"
> > > made me go back to re-read what else has not been handled
> > > for the release_reg case but it could be just me being
> > > slow here.
> > >
> >
> > Right, I can see why that may be confusing. I just set it to !release_reg to
> > disable any other code that may be added using that bool later in the future.
> hmm... If the concern is on future code,
> how about using a comment to remind future cases instead
> and directly set it to true?
>
> /* All special cases were handled above, the remaining
>  * PTR_TO_BTF_ID case always allows fixed off.
>  */
> fixed_off_ok = true;
>
>

Fine by me.

> >
> > > It will be useful to at least leave a comment here
> > > on the redundant check and the remaining cases for
> > > PTR_TO_BTF_ID actually always allow fixed_off.
> > >
> >
> > Yes, I will add a comment to make it clearer.

--
Kartikeya
