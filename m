Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53605691B2
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiGFS0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiGFS0j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:26:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32086DFF
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:26:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y141so15070176pfb.7
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEv55no+mDNdpRv2Yii2FTtzxzsaoXBUMlMWPyySZaw=;
        b=XajZao5oUGH9jMUhI6INvwovP3CVCShuJT6+ix93Htg6Lou44Ay60vc5AToPhwI6ze
         DLgizKv3+4u1lhHjR3yYWoYar4zYnV6rDQhKECQLjIGuWyIbqyUD89kAgfLH/0kh4bU6
         rI7ecOBpP0lfv6p8L/tIzT9abcA+Mtagq7aNFgrxhuZvqgKd7Vi2XoIWl/YeUSp37PHZ
         dx3NyAZkIzPxh+5wr5tKE1Y34dtsFemVqmic5OOn01Ij9omlNa/cOiCUOXtQr7Ll95Kv
         da4q5/AZf1yAQTMhFTZi7ZLaYtkOTF3ROQTy8GD1bKuq6/FFT46+Rv9dmM+k+bm17qR2
         GZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEv55no+mDNdpRv2Yii2FTtzxzsaoXBUMlMWPyySZaw=;
        b=m6BM2NeeLzifgg1addj7ermXcmAmUNeMEQOBIuE2vBJYhqKnUaIZyIKtJ4A68XSppd
         8YRzTwdyAkh8lbElxSxNEK43u2APRHpCVzX9OpL4rl1yleu3MRn3NZVfiNbz4MPpBSjb
         vT96o/UfKDusQ6xG2wXBRXPNw+6ydsl+XhpHWsKU/PWKl4GgLznRGHCedaVo2l4rrC/J
         0ByIvX4+BG8JSgqcwzh6o30AQLZ+1OKAPvFX2Db3ckmuNGoY12z850voiF3YLRdOn9S9
         sXTw6CpJymoOze+k+90pPQyB2IwlyXuiGEjLI7HGUWRmwBQQjDcC9hnNrwgbR81hMz8m
         EUOg==
X-Gm-Message-State: AJIora+fi0na8NbtPpzQQR9icG7/7K4r7q8Jvkf+YK3RTI+zif4lIV7W
        wYUM5vDqUKsmStkRHml1fQ8=
X-Google-Smtp-Source: AGRyM1taEbkT7dBbGdXMfEz1oWYmL7t0q00r5lMLCbN2HQZWofL3h86+NOQ/uwxUISNwGkjVQ4BCxw==
X-Received: by 2002:a65:6e4d:0:b0:411:c102:397e with SMTP id be13-20020a656e4d000000b00411c102397emr29425157pgb.271.1657131998716;
        Wed, 06 Jul 2022 11:26:38 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id z26-20020a634c1a000000b0040dd052ab11sm20857296pga.58.2022.07.06.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:26:38 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:26:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220706182635.ccgt6zcr6bkd3rjc@MacBook-Pro-3.local>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <YsXSqSMxsvq13dV4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsXSqSMxsvq13dV4@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 07:21:29PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 11:05:25AM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > For example, I assume that a BPF program
> > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > Right?
> > 
> > No. It's constrained by memcg limits only. It can allocate gigabytes.
> 
> I'm confused.  A BPF program is limited to executing 4096 insns and
> using a maximum of 512 bytes of stack space, but it can allocate an
> unlimited amount of heap?  That seems wrong.

4k insn limit was lifted years ago.
bpf progs are pretty close to be at parity with kernel modules.
Except that they are safe, portable, and users have full visibility into them.
It's not a blob of bytes unlike .ko.
