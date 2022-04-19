Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67453507A3B
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbiDSTan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbiDSTal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:30:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2F40A1E
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:27:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w5so8575956lji.4
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3mAvdy0ga85ggIH3HoGB0ePtskeVfNvDlSSUq9jS0A=;
        b=QvNx6FxecAp/z7mkZwwjndqXRE72gf91AcAXVa+k62ZgBfXGYm/WwmIqt/J18sYwhc
         i2StNOuJVaOsCjV7cve0T1U3qOs/WN1wFMwJTv6daJNph0klA03P+VQS+HViCxN/bhCX
         eLHeAXjYrEG6AHsQ2gChTGLFMTqfXijO7Vj+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3mAvdy0ga85ggIH3HoGB0ePtskeVfNvDlSSUq9jS0A=;
        b=WLX2e5nUWvZTVVJjJcImvclPm6ICxgC0+c5rMVLIcryWyhMp7NITXUuFxZyoaPq3Y1
         Wq9ElnKLiRJR0r5aAiX4Io+SPr7IcH+mN3YZaFBIAl7YFFZ3mI2gze30I0C98gBmEUYj
         /WnvQYZ6zE3y9j2muavZIzZQ6n2tE6TKlHNDSnH79AFrUYsWmsE1wMYx0pEzt4QSYVba
         JxQkxM90LmEIhzg7PfsVB31zO18V7p73kFsHJdy03b9pe3Cx3JhVQ2rBqOD2VJPy+zY7
         yJB/VtP0QymMDq02+yXaKy6B8y69q5wxKZ8O4Mp1plnRUqU+4C6uHNVfwWqWQ7j0Tw0M
         aBLQ==
X-Gm-Message-State: AOAM531iDRpLq3SpJmjknCbcHVnIuWetr2pSJS7OAe9d4HB5PFLXjU3S
        Pjq/1Ns2gBwQ5/fvSEqAv2ygitxQD4pv8N4n4TQ=
X-Google-Smtp-Source: ABdhPJwA+qbOTXXklE1HyioQcqaEwwWggZg6FssJYQ1Q5FPckNR+ocmdbKcTsO9373Kc0DRRnBd1fQ==
X-Received: by 2002:a2e:b8d5:0:b0:24c:814a:6190 with SMTP id s21-20020a2eb8d5000000b0024c814a6190mr10873356ljp.531.1650396475657;
        Tue, 19 Apr 2022 12:27:55 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p11-20020a056512312b00b0046d48dbe2efsm1595007lfd.103.2022.04.19.12.27.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:27:55 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h11so21786818ljb.2
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:27:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr12102115lfv.27.1650396055810; Tue, 19
 Apr 2022 12:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
In-Reply-To: <Yl8CicJGHpTrOK8m@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Apr 2022 12:20:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
Message-ID: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 11:42 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> I'd say that bpf_prog_pack was a cure for symptoms and this project tries
> to address more general problem.
> But you are right, it'll take some time and won't land in 5.19.

Just to update people: I've just applied Song's [1/4] patch, which
means that the whole current hugepage vmalloc thing is effectively
disabled (because nothing opts in).

And I suspect that will be the status for 5.18, unless somebody comes
up with some very strong arguments for (re-)starting using huge pages.

                      Linus
