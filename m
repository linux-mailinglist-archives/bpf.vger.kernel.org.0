Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657825A6E31
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiH3UN4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3UNz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 16:13:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34180564F0
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 13:13:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so24467323ejc.1
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=aTahVI/8juRRn9KHhCKiFWZNmejWCsMSm1Bfrz/ssA0=;
        b=HfzZ0m70AFDbdLYbePG30W6ZijqqH0bolyfbqAsnLnBdq7fwAe3u8Xf4weW4S+/TZv
         FURmGyuIpkrlTl48X0rIpRa6Nvd7obXVFk5ZyQ1a1a90TqxOSMRyiHdRsHSIHf0ABsMr
         wyoIRJXXvqrHerjJkB4oSJ+YbyvGidm8ZSB0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aTahVI/8juRRn9KHhCKiFWZNmejWCsMSm1Bfrz/ssA0=;
        b=NSzBrYjRvJ2/RuCJ6+ebAzqXkGcKVxaDYElH4t6WpKyhWNZapSZhEi0zxdU6diY6qb
         5U+prOvWVPEnCn9LY5ZTIxRNOkfgv6YDtN2iRwEYAscOVAD6LTnQLgD5Vj29qm+c1ckv
         mjUk4MkSVjBJEZ/XpcWKwBnXhSAVcXPJYMA0WeS7mFJmQUYk+hR2FWtLStZDBieXHXVS
         Lw3qIbacp3KbdU49e7AqUwvet6RXVz2uhJKzbGVXas79z9KP47kSfenEHYRvcMcTqVR1
         vJduvU+jtOnPHdYuy3sPbabrAczSeph5551+7bDCUpH1zjDinCPwyFB9HC76nM0uX1jS
         j0zg==
X-Gm-Message-State: ACgBeo1/l7TpUKNpUGUA+sOTr1WNd1uoPB42Ho1MjU4g/bBsAbtAxDxk
        alWvZEVlsIbyc44YNkNkc/AUBu4Xo67y1A==
X-Google-Smtp-Source: AA6agR7zaTzrKNK4cWuZxaEsxLHOgSKaQIcE0iIF+31Zc4EkqCK9tdxIXHZNXjFQwOpzCRf8r6/Bew==
X-Received: by 2002:a17:907:b15:b0:741:8ae4:f79d with SMTP id h21-20020a1709070b1500b007418ae4f79dmr8113436ejl.247.1661890432645;
        Tue, 30 Aug 2022 13:13:52 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id e1-20020a50fb81000000b00447c0dcbb99sm7878252edq.83.2022.08.30.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:13:51 -0700 (PDT)
Date:   Tue, 30 Aug 2022 23:13:49 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220830231349.46c49c50@blondie>
In-Reply-To: <20220830230257.67468080@blondie>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
        <20220824044117.137658-3-shmulik.ladkani@gmail.com>
        <CAEf4BzZKts8NckT7L-FWBRWJxAgkHEZoR=wjaKBxYpTD_jjyAg@mail.gmail.com>
        <20220830230257.67468080@blondie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Aug 2022 23:02:57 +0300
Shmulik Ladkani <shmulik@metanetworks.com> wrote:

> On Thu, 25 Aug 2022 11:20:31 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > > + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)    
> > 
> > why can't we rely on dynptr's len instead of specifying extra one
> > here? dynptr is a range of memory, so just specify that you take that
> > entire range?
> > 
> > And then we'll have (or partially already have) generic dynptr helpers
> > to adjust internal dynptr offset and len.  
> 
> Alright.
> 
> For my usecase I need to use *part* of the tunnel options that were
> previously stored as a dynptr.
> 
> Therefore I need to introduce a new bpf helper that adjusts the dynptr.
> 
> How about this suggestion (sketch, not yet tried):
> 
> // adjusts the dynptr to point to *len* bytes starting from the
> // specified *offset*
> 
> BPF_CALL_3(bpf_dynptr_slice, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> {
> 	int err;
>         u32 size;
> 
> 	if (!ptr->data)
> 		return -EINVAL;
> 
> 	err = bpf_dynptr_check_off_len(ptr, offset, len);
> 	if (err)
> 		return err;
> 
> 	ptr->offset += offset;
> 	size = bpf_dynptr_get_size(ptr) - len;
> 	ptr->size = (ptr->size & ~(u32)DYNPTR_SIZE_MASK) | size;
> 	return 0;
> }
> 

Correction, meant:
 	ptr->offset += offset;
 	ptr->size = (ptr->size & ~(u32)DYNPTR_SIZE_MASK) | len;

