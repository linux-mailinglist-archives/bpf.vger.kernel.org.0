Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602D507AD9
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbiDSUV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiDSUVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 16:21:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F841995
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 13:18:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j70so4342514pgd.4
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JAlquLesXVnEvl4ylWa2Dm3+bgrVaSmN8YJNkxeweuM=;
        b=SwLYkqhUMBi060/NAiISMsI72rzm5Ylh4w5vGj1xHS/6bMmgjrnxolan4ffVPW9DIb
         7p3RNyxQ8eSnf4jx+X0Rmu8pfEXDhOY+kboScQuw4Uz9bLRkOn0LKGBm2TzJtxWfq/qq
         epe9szP+8W0CIRHHmaNJD8HTtVbXV5DkVIZMoU4XyzaHA4fHPcJ3a38JegA36UhimreR
         oQSXoPo6WLU0Wxb0nxCUGZ4SG0VKBHsn9FMG2UuvY173j1ndg6DgoPFxoXN71KwW3+zi
         T5oyjlqGs1+uL5cXsNKYb0dqkCh9hNiU+jF58SEgIXOIeABvyM+Ny7tUpd+qXCSs6op2
         hXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JAlquLesXVnEvl4ylWa2Dm3+bgrVaSmN8YJNkxeweuM=;
        b=kZOcR6lsPyXCpaN/4iTeIwST6EyJwsY/4V+FiF4hArPwQyU9aCDqD1uLJsBhJL6CIB
         SznVnI5inzorFJIsZ+h0dZWHHONs0UVh3btAAIrekddTM0h+6PmQGUaKwPVq2VK3nqer
         5IgcqOVPFkcHoL7ICIiIuIngen75d0gBuhCLMWRwHjm79N7wC/7mAaRCVirgmUxCPdg7
         BkFED5cvSyCh4QCWhLuGhM3OHvEeEQ+dQWrYCYTJtwPutMP+daZrXUlAe/uEZ2985FQx
         U36WO6+yda7FTfY3sV6qo7vLZVcnRKcQHfcsq9HrXeqJoau30vUlMAKUvHllZatlN31A
         L1Qw==
X-Gm-Message-State: AOAM533ArJaziyXnG7qlkAMlxvrtwLsxXvJhO9qFLK2TLcyKvGYR3FDe
        8h25+Dd//hVsZ3UeZJZ8rHo=
X-Google-Smtp-Source: ABdhPJx1K/wPXuVRUqMlfFVaKpRim9NUiEL2qEoa03+Dn9HdeyXkLPtfG85+SDUYYj0rSqTaPWAYhA==
X-Received: by 2002:a05:6a00:16cd:b0:4e1:366:7ee8 with SMTP id l13-20020a056a0016cd00b004e103667ee8mr19671364pfc.9.1650399521856;
        Tue, 19 Apr 2022 13:18:41 -0700 (PDT)
Received: from localhost ([112.79.167.15])
        by smtp.gmail.com with ESMTPSA id c17-20020a056a00249100b00508389d6a7csm17719627pfv.39.2022.04.19.13.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:18:41 -0700 (PDT)
Date:   Wed, 20 Apr 2022 01:48:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
Message-ID: <20220419201851.qtekbc5twmyuyktn@apollo.legion>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com>
 <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
 <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com>
 <20220418235718.izeq7kkwinedpkuj@apollo.legion>
 <CAJnrk1ag9PT1iXMzB5cxJEnwESYndYE_LozvBuL_Db2degJ-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ag9PT1iXMzB5cxJEnwESYndYE_LozvBuL_Db2degJ-CQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 12:53:55AM IST, Joanne Koong wrote:
> > [...]
> > There is another issue I noticed while basing other work on this. You have
> > declared bpf_dynptr in UAPI header as:
> >
> >         struct bpf_dynptr {
> >                 __u64 :64;
> >                 __u64 :64;
> >         } __attribute__((aligned(8)));
> >
> > Sadly, in C standard, the compiler is under no obligation to initialize padding
> > bits when the object is zero initialized (using = {}). It is worse, when
> > unrelated struct fields are assigned the padding bits are assumed to attain
> > unspecified values, but compilers are usually conservative in that case (C11
> > 6.2.6.1 p6).
> Thanks for noting this. By "padding bits", you are referring to the
> unnamed fields, correct?
>
> From the commit message in 5eaed6eedbe9, I see:
>
> INTERNATIONAL STANDARD ©ISO/IEC ISO/IEC 9899:201x
>   Programming languages — C
>   http://www.open-std.org/Jtc1/sc22/wg14/www/docs/n1547.pdf
>   page 157:
>   Except where explicitly stated otherwise, for the purposes of
>   this subclause unnamed members of objects of structure and union
>   type do not participate in initialization. Unnamed members of
>   structure objects have indeterminate value even after initialization.
>
> so it seems like the best way to address that here is to just have the
> fields be explicitly named, like something like
>
> struct bpf_dynptr {
>     __u64 anon1;
>     __u64 anon2;
> } __attribute__((aligned(8)))
>
> Do you agree with this assessment?
>

Yes, this should work. Also, maybe 'variable not initialized error' shouldn't be
'verifier internal error', since it would quite common for user to hit it.

--
Kartikeya
