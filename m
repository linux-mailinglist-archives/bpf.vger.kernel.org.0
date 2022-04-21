Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEF50955B
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbiDUD2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDUD2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:28:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB850E2E;
        Wed, 20 Apr 2022 20:25:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q12so3506449pgj.13;
        Wed, 20 Apr 2022 20:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/zHCtxMoczMZEIXtnhbHvwUDzUqhEUQwNxssLVReHRY=;
        b=DZZpQpUjF7g81qX3uZg72RUAtHA/JtIx+K/0sPrG0xVt5qvYyqS0v9pm9Ej/CACSet
         VjqSXgpSQdBTsQLFhmrTc+XjIKwyXe2X3608ku/tM7V+5Bq18C9z/4N8u7A1W/Z9pgiq
         FR45KVNFR3vH39TaRwD6O1H0epFDN+N5o3W0w9XA+89Nq0TaQ8xxZZY61qiI6/bFX+X8
         jBcDUh071IHiaY9jnyCG1EwXgqVUH8oJUoTTjxSRPJ8cfrvSWcP2RBFQ04dEdtPUcCKv
         qOF1w0aaF4vRXn4dEkbjZUFRORoMhUM6PB4Lts14HLPSxlUQe0D4ruhIeVYrnH/CT+iu
         w27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/zHCtxMoczMZEIXtnhbHvwUDzUqhEUQwNxssLVReHRY=;
        b=qwXWwQm0VBQwQBSFBJhz3iWltp3F6VPbGYx0xGPnnnaOnv5+lzT1AZNsgSO+f77YoE
         lidIWs2zOrg+s14j7u5+zspEtkTGFLK3/QSaeqcqKA0gr66x/vMSlybLlv0nL/jIDAEp
         VUDwQ7WjyFQ2lY3eb/iG6DI5FxVlZoKLsNubbVe3Mm16AvXSy3dmiCYtTQuTtnwYA7UX
         EzPDSYChgOyX20/Xa/QGcSg+/fXk1cXamBF8n4yBPi/5T43F9Qw1fzFA8TWgZ2U1XKyB
         7ERC0TYylbGNzBvbgKYxS2uuvhL4v2SwW2PvJbZl4/pdKpuMlujI6318ecnWagboVaDU
         jEHw==
X-Gm-Message-State: AOAM533S1YmC7u0zxZDr3JLK2UPaJZK/FxJbBvehWS4o+kKeWEvtQape
        MNa5z3OQdjVzDt/YLA7V8+4=
X-Google-Smtp-Source: ABdhPJwRJWtMqp6HCw0RDv8Ns5buSwZol3RRdVsNZrkSj2HC0TRRxTq66Rf82aICgLt0IH9Is87WNQ==
X-Received: by 2002:a63:8942:0:b0:3aa:8454:414a with SMTP id v63-20020a638942000000b003aa8454414amr2412844pgd.245.1650511522238;
        Wed, 20 Apr 2022 20:25:22 -0700 (PDT)
Received: from localhost ([203.221.203.144])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0050a765d5d48sm12836468pfk.160.2022.04.20.20.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:25:21 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:25:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
        <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
        <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
        <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
        <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
        <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
        <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
        <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
        <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
In-Reply-To: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650511496.iys9nxdueb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Excerpts from Linus Torvalds's message of April 20, 2022 5:20 am:
> On Tue, Apr 19, 2022 at 11:42 AM Mike Rapoport <rppt@kernel.org> wrote:
>>
>> I'd say that bpf_prog_pack was a cure for symptoms and this project trie=
s
>> to address more general problem.
>> But you are right, it'll take some time and won't land in 5.19.
>=20
> Just to update people: I've just applied Song's [1/4] patch, which
> means that the whole current hugepage vmalloc thing is effectively
> disabled (because nothing opts in).
>=20
> And I suspect that will be the status for 5.18, unless somebody comes
> up with some very strong arguments for (re-)starting using huge pages.

Why not just revert fac54e2bfb5b ?

Thanks,
Nick
