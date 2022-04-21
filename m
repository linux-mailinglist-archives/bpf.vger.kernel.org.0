Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8950ABF7
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 01:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbiDUXdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiDUXdh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 19:33:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723393A19D;
        Thu, 21 Apr 2022 16:30:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h12so3390617plf.12;
        Thu, 21 Apr 2022 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lE0V3qjAS7CCi6fROk/XeSupX8dBuxp5diNFKdfJZzc=;
        b=KbrsF8Fen3H4rDvpPByaGLqw8BH6O0NVgJ9U9mZVU8q7kEBaZC0YvNL8ZBmICxppS7
         NlQbbRoJWy7Fc/nDZhwdWK6uOBL03/SwAute02SyiW/ofQzqduZftIwR4zCWzCOxyyiY
         OvtMjoQOU11M8gnHp4RATKflKdlU0qs8Aw+u7/gSQTQsaLL+qUZynwsQN7EKKHWLGg46
         Wie4q4wg2XZJ+lWk0OoQsoNEehPlswUEfIXOtsuZIzN/Abmy1LKCWKTvP9BM4AXlv2PS
         4sTU/seTA2grVXKQi85b8mp0tnPy1/Y8hv3JHJ69cywIJJ/esF4lsxgwktJV+c/TSZPs
         vQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lE0V3qjAS7CCi6fROk/XeSupX8dBuxp5diNFKdfJZzc=;
        b=afARTWlerELZ9KCbdPJDRoG+DbCyqpkbvcA1KSnOlKwmbqkUXaH8KBFoAFXCPFMV46
         yBAmoerN4/32QmKy6X497STGHrDoAxrqMkkT0SNufbOf3q37awypc3vh9sMgXZpA8K5m
         032VgjlXcqwOkGeFwhDa3wBOy/Dpja9oM2H8y6u287jBie9a/9HNlM+89OwlqNO+j1RT
         6+BKy/PeTaRh1NLdYS+hwzqjwNvAGYhdlkaB3SyG78YOOEkm8wkqCcVcdUzLcSDMXBHp
         /XBydOb5cPKqYX8+d/Z1M2Nw9D6m6dfZemGQDHsRLO0P6o8yCu01cijkUjUY2q8yoFOc
         EoZw==
X-Gm-Message-State: AOAM5316euwTVoBT7pbQSiZNoJM/+vLKbTCoH78seoj/qTZD3Zlis7Lg
        Kd50GZhEU06zEmvWXgpQMGA=
X-Google-Smtp-Source: ABdhPJy1RKcxdVpf91OOgBJRYlC++j1HAqBJ92ZYc7kGDopyxu+mLuck5D65uI45k2CUxtW+qmxhyw==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr1520080plt.101.1650583844918;
        Thu, 21 Apr 2022 16:30:44 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id l18-20020a056a00141200b004f75395b2cesm207689pfu.150.2022.04.21.16.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:30:44 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:30:39 +1000
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
        <1650530694.evuxjgtju7.astroid@bobo.none>
        <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
In-Reply-To: <CAHk-=wi_D0o7YLYDpW-m3HgD7HeHR45L7UYxWi2iYdc5n99P3A@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650582120.hf4z0mkw8v.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 22, 2022 1:44 am:
> On Thu, Apr 21, 2022 at 1:57 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> Those were (AFAIKS) all in arch code though.
>=20
> No Nick, they really weren't.
>=20
> The bpf issue with VM_FLUSH_RESET_PERMS means that all your arguments
> are invalid, because this affected non-architecture code.

VM_FLUSH_RESET_PERMS was because bpf uses the arch module allocation=20
code which was not capable of dealing with huge pages in the arch
specific direct map manipulation stuff was unable to deal with it.
An x86 bug.

> So the bpf case had two independent issues: one was just bpf doing a
> really bad job at making sure the executable mapping was sanely
> initialized.
>=20
> But the other was an actual bug in that hugepage case for vmalloc.
>=20
> And that bug was an issue on power too.

I missed it, which bug was that?

>=20
> So your "this is purely an x86 issue" argument is simply wrong.
> Because I'm very much looking at that power code that says "oh,
> __module_alloc() needs more work".
>=20
> Notice?

No I don't notice. More work to support huge allocations for
executable mappings, sure. But the arch's implementation explicitly
does not support that yet. That doesn't make huge vmalloc broken!
Ridiculous. It works fine.

>=20
> Can these be fixed? Yes. But they can't be fixed by saying "oh, let's
> disable it on x86".

You did just effectively disable it on x86 though.

And why can't it be reverted on x86 until it's fixed on x86??

> Although it's probably true that at that point, some of the issues
> would no longer be nearly as noticeable.

There really aren't all these "issues" you're imagining. They
aren't noticable now, on power or s390, because they have
non-buggy HAVE_ARCH_HUGE_VMALLOC implementations.

If you're really going to insist on this will you apply this to fix=20
(some of) the performance regressions it introduced?

Thanks,
Nick

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e5b4488a0c5..b555f17e84d5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8919,7 +8919,10 @@ void *__init alloc_large_system_hash(const char *tab=
lename,
 				table =3D memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
 		} else if (get_order(size) >=3D MAX_ORDER || hashdist) {
-			table =3D __vmalloc(size, gfp_flags);
+			if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_S390))
+				table =3D vmalloc_huge(size, gfp_flags);
+			else
+				table =3D __vmalloc(size, gfp_flags);
 			virt =3D true;
 			if (table)
 				huge =3D is_vm_area_hugepages(table);
