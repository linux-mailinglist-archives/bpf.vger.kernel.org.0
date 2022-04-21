Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878350A537
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiDUQ1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiDUQSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 12:18:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7521167C7
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 09:15:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y11so6389159ljh.5
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMnN6nbCX/7cL3f0ah02MbVShtU02AkQFDakttaTzAw=;
        b=DIriM5i3ajD3RLNWfQ6pW8viAFRJceIIIA5KVQd8g23jiOVythALplSHMoIrFsHDuM
         eS15lrlvqfF3NczkCG/4JPv1xYx+gECADQ1CHdeGSpEBbYpzJLvvDAtKjv6rDHEtN6nt
         bS44RN8RZ8+XDJpvrXldBHWh3kUpSV156bSe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMnN6nbCX/7cL3f0ah02MbVShtU02AkQFDakttaTzAw=;
        b=vqVWXX4ojDpycOff2goI4UfHKxtrV7hug/qFi1Pl/Dlsxm46YNtjVA5g/K6ehd8ylX
         kQjRkj+9yVfxwk5pk8WmFuS1I4c/7+O4SaowmuOk/Ih8xH16CgF9Bel5vRb76BBUumF8
         7bZoXU/WWF83QUVy40meocIcEndjsMkBsklXlvyWQ1c84yG+Gzf2VFW2sPgMHNyk8OLb
         SaAMuppRrsNBCfpm+pF3594KNMRCd2bZj8hMMH1s8/I6vhEkEnWeHSJZ2v/l/1RlpLEX
         tDoC9SjNYbKsSKfmQ+5ur9M0F43DuyqvHiyH85ocsNNeWW5Ww9YF7b5OgvpxBmjuFF9y
         Gkpg==
X-Gm-Message-State: AOAM531HqpqTrnQXWX0F5oHyuaW6SqhhF/cxgRHRH+8nSDdPGe+g+yyg
        /ixNC/5L0UvhHD5pFRE04hBhD90SYKhFBREg0uk=
X-Google-Smtp-Source: ABdhPJzDDpckRZ8VpxcPasJZrH5ke05930NeblvF1AZfOn+NbzR6O0+mZbbj5IZ284PwgwpA6GtjZA==
X-Received: by 2002:a05:651c:549:b0:24d:bd43:222 with SMTP id q9-20020a05651c054900b0024dbd430222mr267802ljp.99.1650557724666;
        Thu, 21 Apr 2022 09:15:24 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p41-20020a05651213a900b00443e2c39fc4sm2229890lfa.111.2022.04.21.09.15.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:15:22 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x17so9572264lfa.10
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 09:15:22 -0700 (PDT)
X-Received: by 2002:a05:6512:6d4:b0:470:f48d:44e2 with SMTP id
 u20-20020a05651206d400b00470f48d44e2mr173410lff.542.1650557721884; Thu, 21
 Apr 2022 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <1650511496.iys9nxdueb.astroid@bobo.none> <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
 <1650530694.evuxjgtju7.astroid@bobo.none> <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
In-Reply-To: <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 09:15:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
Message-ID: <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 8:47 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
>                 I wonder if it
> might have to do with the vmalloc huge pages using compound pages, then
> some caller doing vmalloc_to_page() and getting surprised with what
> they could get away with in the struct page.

Very likely. We have 100+ users of vmalloc_to_page() in random
drivers, and the gpu code does show up on that list.

And is very much another case of "it's always been broken, but
enabling it on x86 made the breakage actually show up in real life".

                   Linus
