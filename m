Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18CC509CB8
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386466AbiDUJuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387854AbiDUJun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 05:50:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC17275E5;
        Thu, 21 Apr 2022 02:47:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k29so4177693pgm.12;
        Thu, 21 Apr 2022 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lyWO8pI/iZL3pBCIc8iGOQ7+JToyR5F2j32rII4xAew=;
        b=c0gv7Cnxk0OHBkuP2DwEJeHnHhMtv7rbNbQXxDkgpxcDcsqHJpeP6cnivE4wL82xVn
         HRVrWF+J98+ATJf3b6C9CFtxsbBThsPTi0gMkBoaVMfMMqQvNFGHBTCJrbJbrUtiOGrQ
         WFU1ey9FhcQ4iLkh/b/KNXtEEEPYhbIWmuHengFh49Rz+RMvO/qe929Kw1S3DUoG/UGm
         BfUXn3i7FxU6wJXTPH2NKEU8b7ngLILY52TFemea2Q/7/UgaBDjdli1u99pKVXpnKpna
         pbvOsnPcL9/R57sW4YO8RI52ip7+1Pk3GyQwf+s+1MS5QPG37dqI6YkVlVAV0+xY5fSE
         ueQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lyWO8pI/iZL3pBCIc8iGOQ7+JToyR5F2j32rII4xAew=;
        b=uPSdFynWxoddQEuGIPuqYliW5yTd0kI/7BaVtsCQEyQBX8OTZra06+2pqvB8ZSUT2y
         uq1E78Z3Wy+GyFPTU3MlcIgkzP02g87vv68jRnFRMZvIefZtG/Eo7PU4iNiTSaCbGG8A
         NnQucPRRyt+q1NuFDY1tM6qmuR7MVOL+U+B2GLgTTwOv2vfl7Egw1/U1iacLnAvwi0cX
         bxSNurhsF47Nt4xqRb0j6U75z/g+9WCTD1dcIK8Nn/1hBgzY7mE3gqMH0Uocl+pMINww
         FZjfttte76iJu33cpJNQGb3/SFFQSPp9YtPR9CXaCUSWAIVdEVAKih/PptJlqAyjBgUq
         yM7w==
X-Gm-Message-State: AOAM533J9cJu5mU5svllH+gpddvGOVgPVNAuQNPepvqtWhKhbvd34Hh1
        WQTeUaBfq4TsW9qwnLFchAc=
X-Google-Smtp-Source: ABdhPJwqQVk0NLfWe71VgxEX8jGq+J8cb/1K6tUorOoMgwYIFLGuD4VSp0pC02lD9Oy9JEg9hTb9yA==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr27840130pfj.32.1650534472608;
        Thu, 21 Apr 2022 02:47:52 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090ae51200b001cd4989fec6sm2044542pjy.18.2022.04.21.02.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 02:47:52 -0700 (PDT)
Date:   Thu, 21 Apr 2022 19:47:47 +1000
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
Message-Id: <1650533246.j8team32e9.astroid@bobo.none>
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

Oh I missed this comment. Now I'm completely confused. Reverting the
patch which caused the breakage *is* the sane way forward. Your tree
is not broken after that so you're done.

And if x86 wanted to select HUGE_VMALLOC in future then it can do so
after fixing the issues it has with it, so that's that the sane way
forward for that.

What you have now is what's insane. HAVE_ARCH_HUGE_VMALLOC now means
"you can ask for huge pages but it might crash in undocumented=20
arch-specific circumstances so good luck".

Thanks,
Nick
