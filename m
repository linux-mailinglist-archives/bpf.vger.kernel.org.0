Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB26039B4
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 08:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJSGTw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJSGTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 02:19:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C72619
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:19:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso19602889pja.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRNc4faZ8p8+RMS0pqYT6HUrEoQjzGWW9SKqePgUywA=;
        b=cOQLY/DvGjTc0cf5dgyCTXHRg/AUwQESDkiS0esqi5pZZ0s2xWSa+gv6+6RFh/1ZTS
         oQkpe1w3SCEebq0eFcMvI9dm7/xkXrddPsuaMUxMS7G19ugXU/EQ42MU6OtbVaW15NkN
         ueN3+mw+igt6ADJ4E+e92/TgaZio/xZGMbm2hR05318oB21gvUrAKQhPiQjTBWck/V8h
         9450c/I7SjPPQ3UAtFOv/ygoGaeX+Ue6gbFf4sOZbL6ZKQ3RwFcdF10DQN2lgk2ICyN1
         ItOJKU6a26lbKqhuSQwJhFUvMaAREqh2IlOHi7RQhAfKBjMHpPLXsfIyAdG8PfTVD1ws
         hCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRNc4faZ8p8+RMS0pqYT6HUrEoQjzGWW9SKqePgUywA=;
        b=fxoZf5nmg+Z34gJp+ICMXn2vd92/1SRHDFgjrm2ANGrisadndFlqoOuxySGG+a1rcg
         PUZV5XIsbXZLXe+iMJzLyeHNZTd2xtc59I2CXZuy2wuo6cj0CCt41/3DvYKDpXTWDwxK
         CFyLl5yHZgDtLkijS3hFazps95bavsANPsXPoOqtKxvBnhAUdF6k8UyPstqZpKtcq7HV
         SmbncsSGD66njTrLI8W888bGOcFjvIBA2D+LNLtY76BzPA3zRWEl0tiaDswI8Yu/lgU7
         AfWT9pSoARRf16TYRwh6nn+3aiImzhKZpzQTykmUDy9kXZseA9kp+r+hlDHOsadJN/Bi
         HDhA==
X-Gm-Message-State: ACrzQf1c8RFz8NLVW6Zjv4ICCxKGmefcGVkGnXOAVjKrjgPGTGGphwlj
        qgIWhyr1xwn+cQT2dvFPD6g=
X-Google-Smtp-Source: AMsMyM7UUiU8sO9Fhe9EYotribfZZLO1t6pcSMhKgF8El782jOCiFhY5mIYRKM/04nwZHxAyaTYRjw==
X-Received: by 2002:a17:902:6bc8:b0:178:81db:c6d9 with SMTP id m8-20020a1709026bc800b0017881dbc6d9mr6936893plt.56.1666160362575;
        Tue, 18 Oct 2022 23:19:22 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 203-20020a6214d4000000b005626fcc32b0sm10724267pfu.175.2022.10.18.23.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:19:22 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:49:04 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 03/13] bpf: Rename confusingly named
 RET_PTR_TO_ALLOC_MEM
Message-ID: <20221019061904.5zwkrkubiwp25tjp@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-4-memxor@gmail.com>
 <Y08czdCQgMig/Wir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08czdCQgMig/Wir@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 03:08:21AM IST, sdf@google.com wrote:
> On 10/18, Kumar Kartikeya Dwivedi wrote:
> > Currently, the verifier has two return types, RET_PTR_TO_ALLOC_MEM, and
> > RET_PTR_TO_ALLOC_MEM_OR_NULL, however the former is confusingly named to
> > imply that it carries MEM_ALLOC, while only the latter does. This causes
> > confusion during code review leading to conclusions like that the return
> > value of RET_PTR_TO_DYNPTR_MEM_OR_NULL (which is RET_PTR_TO_ALLOC_MEM |
> > PTR_MAYBE_NULL) may be consumable by bpf_ringbuf_{submit,commit}.
>
> > Rename it to make it clear MEM_ALLOC needs to be tacked on top of
> > RET_PTR_TO_MEM.
>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/linux/bpf.h   | 6 +++---
> >   kernel/bpf/verifier.c | 2 +-
> >   2 files changed, 4 insertions(+), 4 deletions(-)
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 13c6ff2de540..834276ba56c9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -538,7 +538,7 @@ enum bpf_return_type {
> >   	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
> >   	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
> >   	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
> > -	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated
> > memory */
> > +	RET_PTR_TO_MEM,			/* returns a pointer to dynamically allocated memory
> > */
>
> What about the comment? It still says that it's a pointer to a
> dynamically allocated memory :-/ Does it make sense to clarify it as
> well?
>

Argh, right, I will change that. Thanks for spotting it!
