Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766FD509B57
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387030AbiDUJAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 05:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiDUJAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 05:00:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE320BE4;
        Thu, 21 Apr 2022 01:57:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so4282423plo.0;
        Thu, 21 Apr 2022 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ylxB+Hx++LEIgDce19t2otGtYWyC/YHt80P7LQP09MU=;
        b=TI7S5wZtKMPdTN+iqX/9T9mPd79QQeOPulqS2EsJogc0+YqvElchYQCQuy0DXbdlNU
         /EY4iGvqIXVy8t0kZ4PUPcM97/9A31L83tLD+lHukf4bc/VGRsyf9LU8Ka7okYs2c9j2
         hCbBiCXH9YU6dk0x93oNopfWVenuaNqvyxbG4chsYNGeqLFBfnskg01U/UPrBnDgGAdi
         SgS8swNpDMKTCk0L9wZmvp39E7j7I6+lAFVD0XQE6ehvWMh4y/hS/1u/dGqvaoFIdjIJ
         PaJF8VAZHJH4jrqkrkRX4LM7MmIpCYok2MUJV5AEzpqr8JIQgbMg6YTiB3/3zYoZ9Rkf
         ToEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ylxB+Hx++LEIgDce19t2otGtYWyC/YHt80P7LQP09MU=;
        b=kwbTNyRB7Mso3gn8jzEla51n/HNO/Ss+QMQ9DmB6tpuwexqS1oFD0mHgUUkIihkcwn
         onVKfDgdADn2nqa32oSuJvVK/44qT75wOIkI2h6fs7nmOc+vz4REEpJMWr5qwMb7B6rV
         dQrGIEn9qD3gsoFYaVPhVG28EsGO2vPB9ONq+Qi/wrHsDf51GqqB2HCkBDd4fonIjFGq
         3/XyBqG23MRhWwO4o0yga0CdRA4sjpqjnIl9XoNPaHbBVnFP86nVFnlWKWZaZP9j+ALX
         wym1885/7NMYZzodtFO6bnYh85qRuI38nMC1QXdfWCWD3KlF9meKCDcb6bWADV6gmr0a
         ArXg==
X-Gm-Message-State: AOAM530pyaa23Y1mUh7o+s8RMz+5NgRZR86NkV0RwkHl8ldIxe6/1oy6
        FsKfA2E9eOX9KpKKvBLZmuU=
X-Google-Smtp-Source: ABdhPJxs1z1Cj8A1dElHpP1eXJVgfrm1cl4dkEe0g7tWz1hxqfq4b2gQ/DG8+jgzKwQTof8D/nex1w==
X-Received: by 2002:a17:902:9b95:b0:151:533b:9197 with SMTP id y21-20020a1709029b9500b00151533b9197mr24919678plp.66.1650531448442;
        Thu, 21 Apr 2022 01:57:28 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00159400b0050a946e0548sm9544041pfk.165.2022.04.21.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:57:27 -0700 (PDT)
Date:   Thu, 21 Apr 2022 18:57:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Mike Rapoport <rppt@kernel.org>,
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
        <1650511496.iys9nxdueb.astroid@bobo.none>
        <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650530694.evuxjgtju7.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 21, 2022 3:48 pm:
> On Wed, Apr 20, 2022 at 8:25 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> Why not just revert fac54e2bfb5b ?
>=20
> That would be stupid, with no sane way forward.
>=20
> The fact is, HUGE_VMALLOC was badly misdesigned, and enabling it on
> x86 only ended up showing the problems.
>=20
> It wasn't fac54e2bfb5b that was the fundamental issue. It was the
> whole "oh, we should never have done it that way to begin with".
>=20
> The whole initial notion that HAVE_ARCH_HUGE_VMALLOC means that there
> must be no PAGE_SIZE pte assumptions was simply broken.

It didn't have that requirement so much as required it to be
accounted for if the arch enabled it.

> There were
> actual real cases that had those assumptions, and the whole "let's
> just change vmalloc behavior by default and then people who don't like
> it can opt out" was just fundamentally a really bad idea.
>=20
> Power had that random "oh, we don't want to do this for module_alloc",
> which you had a comment about "more testing" for.
>=20
> And s390 had a case of hardware limitations where it didn't work for some=
 cases.
>=20
> And then enabling it on x86 turned up more issues.

Those were (AFAIKS) all in arch code though. The patch was the
fundamental issue for x86 because it had bugs. I don't quite see
what your objection is to power and s390's working implementations.
Some parts of the arch code could not cope with hue PTEs so they
used small.

Switching the API around to expect non-arch code to know whether or
not it can use huge mappings is much worse. How is=20
alloc_large_system_hash expected to know whether it may use huge
pages on any given half-broken arch like x86?

It's the same like we have huge iomap for a long time. No driver
should be expect to have to understand that.

> So yes, commit fac54e2bfb5b _exposed_ things to a much larger
> audience. But all it just made clear was that your original notion of
> "let's change behavior and randomly disable it as things turn up" was
> just broken.
>=20
> Including "small" details like the fact that apparently
> VM_FLUSH_RESET_PERMS didn't work correctly any more for this, which
> caused issues for bpf, and that [PATCH 4/4].

Which is another arch detail.

> And yes, there was a
> half-arsed comment ("may require extra work") to that effect in the
> powerpc __module_alloc() function, but it had been left to others to
> notice separately.

It had a comment in arch/Kconfig about it. Combing through the
details of every arch is left to others who choose to opt-in though.

> So no. We're not going back to that completely broken model. The
> lagepage thing needs to be opt-in, and needs a lot more care.

I don't think it should be opt-in at the caller level (at least not
outside arch/). As I said earlier maybe we end up finding fragmentation
to be a problem that can't be solved with simple heuristics tweaking
so we could think about adding something to give size/speed hint
tradeoff, but as for "can this caller use huge vmap backed memory",
it should not be something drivers or core code has to think about.

Thanks,
Nick
