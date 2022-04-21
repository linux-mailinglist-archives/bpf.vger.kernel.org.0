Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF80509BBE
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387278AbiDUJKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387266AbiDUJKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4513F82;
        Thu, 21 Apr 2022 02:07:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q3so4279284plg.3;
        Thu, 21 Apr 2022 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Pel2dsTDIe3t8VmyT+t+d8FvIgfC1mdCX7nKYG6+pAU=;
        b=KE+1uE8GspZJXXd4phb9kpKGBFpu+wjtmQuW/trkeZUN7ovwbbuSZOWD1TViv4mTmA
         fYUHJU53DQ9FrM9JacJLmdewAPaLgaXJEMY7fECM4Snj/d2SIe2lP9IyeGH3uscJp6VN
         Jn+7Y4QHlP4czVFWdRMjMGIFJjqX93NAXVZVF6QIfQnRMXiJjDTr6BWu9dhXt1i0ztRG
         XtcrkCd61b/jbbbFzmLB75Ln+jT4PxtRceQhIflESDHg7dzmHadrcNQ5fkJCY9PvqFgj
         g0bHiIwIN76nDb7ziCfKGdb1naBLE29U4i0Sc6+5wS88eFQlEQqkr3SWBAFc5jlWWNkP
         DZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Pel2dsTDIe3t8VmyT+t+d8FvIgfC1mdCX7nKYG6+pAU=;
        b=1Ic/HtLhi9212xACKiCZpdFnoL4Hy3B5Df7fF5NqyMpCcOIZvOejehB5AkBzXex9Wg
         trCkF+3ku/OdmhSM7jtsBhZNUuCSPmVEl7A6VAnWK3z9DNr7OWn0oCyc5IxiBPLrtf1H
         T+L3juja1Anf9l1SyDtX9z/SImZ1lWWNPVU+1yyTx/5xqaVt9WsgVPKGieJVXYUFZuED
         ePqkrOwDboMEw9hcoImg85eqksbqbx87rgnulLEUjsU7W2veHPwI9Cbgnwy5A3asaADh
         r95lNC9C2wKHgv1DejWqUAIbslEcbuk8WAQzq4UNlcyW6266tzNPQprYIHQ79VazIe2E
         qVJA==
X-Gm-Message-State: AOAM530ya3WmRmSrvdrwQHw1yoLTBaBbwJOodELq3FejMwFOyPjGAPZU
        8/k2p1nQbAp/jsd+1zsZbRA=
X-Google-Smtp-Source: ABdhPJxTzOmlLL91c7uscSbJN9RG0yZZMfQvkW/9n5UZt8nUTJpo7WduP18v/O+I0ZB9VNRBIfLAlw==
X-Received: by 2002:a17:902:bf04:b0:149:c5a5:5323 with SMTP id bi4-20020a170902bf0400b00149c5a55323mr24813906plb.97.1650532049802;
        Thu, 21 Apr 2022 02:07:29 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a0002c500b0050600032179sm22557180pft.130.2022.04.21.02.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 02:07:29 -0700 (PDT)
Date:   Thu, 21 Apr 2022 19:07:24 +1000
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
        <CAHk-=wjYabTPnKiHgVzeKCaRkQaGVunwPbS+QeVb09Bm=YUEow@mail.gmail.com>
In-Reply-To: <CAHk-=wjYabTPnKiHgVzeKCaRkQaGVunwPbS+QeVb09Bm=YUEow@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650531495.h5u7ntu1jb.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 21, 2022 4:02 pm:
> On Wed, Apr 20, 2022 at 10:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The lagepage thing needs to be opt-in, and needs a lot more care.
>=20
> Side note: part of the opt-in really should be about the performance impa=
ct.
>=20
> It clearly can be quite noticeable, as outlined by that powerpc case
> in commit 8abddd968a30 ("powerpc/64s/radix: Enable huge vmalloc
> mappings"), but it presumably is some _particular_ case that actually
> matters.
>=20
> But it's equalyl clearly not the module code/data case, since
> __module_alloc() explicitly disables largepages on powerpc.
>=20
> At a guess, it's one or more of the large hash-table allocations.

The changelog is explicit it is the vfs hashes.

> And it would actually be interesting to hear *which*one*. From the
> 'git diff' workload, I'd expect it to be the dentry lookup hash table
> - I can't think of anything else that would be vmalloc'ed that would
> be remotely interesting - but who knows.

I didn't measure dentry/inode separately but it should mostly
(~entirely?) be the dentry hash, yes.

> So I think the whole "opt in" isn't _purely_ about the "oh, random
> cases are broken for odd reasons, so let's not enable it by default".

The whole concept is totally broken upstream now though. Core code
absolutely can not mark any allocation as able to use huge pages
because x86 is in some crazy half-working state. Can we use hugepage
dentry cache with x86 with hibernation? With BPF? Who knows.

> I think it would actually be good to literally mark the cases that
> matter (and have the performance numbers for those cases).

As per previous comment, not for correctness but possibly to help
guide some heuristic. I don't see it being too big a deal though,
a multi-MB vmalloc that can use hugepages probably wants to, quite
small downside (fragmentation being about the only one, but there
aren't a vast number of such allocations in the kernel to have
been noticed as yet).

Thanks,
Nick
