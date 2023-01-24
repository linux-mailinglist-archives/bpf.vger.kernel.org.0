Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E0678D07
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 01:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAXAyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 19:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjAXAyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 19:54:14 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D229428;
        Mon, 23 Jan 2023 16:54:13 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id g10so10598485qvo.6;
        Mon, 23 Jan 2023 16:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI25185Arxz+OcLryD75N/RRI9xj5+Xq8AaJs4bj4EA=;
        b=LEsp1UhobccITp8X4E9qUBp6Qoa2hBrvEhIwn1nnS8lUrkTqRAru6KokT+7caAsWUq
         z1R07qr7tMp1DeYbwkTRa1K8led2XK2N8/HVQZmGHa1fPdnAYmqE9h0fzQGn+Hnl2vLu
         6GwN+iUgCyFAqThHas8+WRTmN/pBiNuUeVPB7yDglhHj9ww562B9ZmNEmLVhJoi6Pq1N
         t5+BUDwVSqHgbI6nmZfwLFDHYl3rlXecTjwjCJjqbu2otznYUZpgxLINwqFXO7o2Rt/M
         YRwH8TJ2BW1nML32exoYs4V9fV633LJM5sprBwNHkhODDwsWPRQpdDifNKO0RdRGZilX
         2RGA==
X-Gm-Message-State: AFqh2kq6YEsOQ+P6BU08tezMFni8pEAQTA7ZT06bzc//F3LfNc5GeSr3
        sbx44MtU4ZJH1Vli6gFBq5k=
X-Google-Smtp-Source: AMrXdXs1b2OKxdUskSsd/f9qxkntCgTaMZJZ3FZEgkiXf18yv15hthEHC0l0f9EH4OaMKOsNMU2Psw==
X-Received: by 2002:a05:6214:3b0c:b0:534:9dca:c7a0 with SMTP id nm12-20020a0562143b0c00b005349dcac7a0mr39743056qvb.13.1674521652267;
        Mon, 23 Jan 2023 16:54:12 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b006fa4cac54a5sm478068qkj.72.2023.01.23.16.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 16:54:11 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:54:10 -0600
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y88sMlmrq0wCFSRP@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
 <87o7qphspq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7qphspq.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 02:00:17PM -0700, Jonathan Corbet wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
> > Did you look into making this similar to the EXPORT_SYMBOL() infra? If possible
> > that would look much more natural to developers, e.g. :
> >
> > struct nf_conn *
> > bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
> >   		  u32 tuple__sz, struct bpf_ct_opts *opts, u32 opts__sz)
> > {
> > 	[...]
> > }
> >
> > EXPORT_BPF_KFUNC(bpf_skb_ct_lookup);
> 
> That was my question too; it's a similar functionality that would be
> nice to express in a similar way.  Even better, if possible, might be to
> fold it into BTF_ID_FLAGS, which I might then rename to EXPORT_KFUNC()
> or some such ... :)

Thanks Daniel and Jon for taking a look. These are good suggestions, and
I agree that using something like EXPORT_BPF_KFUNC or BTF_ID_FLAGS would
be preferred and probably a better and more intuitive UX.

I expect that it's going to require some nontrivial build integration
work to get this looking exactly like we want it to. AFAICT, one
difference between kfuncs and EXPORT_SYMBOL symbols is that
EXPORT_SYMBOL symbol signatures are all exported via headers, as the
intention is of course for them to be linked against by other core
kernel code or modules. For kfuncs, that's not really what we want given
that for many of the kfuncs we may not want non-BPF callers to invoke
them. I don't think any of this is impossible, just a SMOP.

I was perhaps a bit naive to think we could just throw a __bpf_kfunc
macro onto the function signatures and call it a day :-) I think it's
probably best to table this for now, and either I or someone else can
come back to it when we have bandwidth to solve the problem more
appropriately.

> 
> Thanks,
> 
> jon
