Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12DF50DAF7
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiDYIV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiDYIVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 04:21:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168A2672
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 01:18:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so24781746lfg.7
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gf4qna+chgdqKRpP/Wa5zsGXxEnC9UfbtEiM/gls+m0=;
        b=Aml0zD/fxPnfqRhWfiNo69LwKx2/KRsDrIss9R5tS0Ba7quxETTRhXIyWpj4qhK09T
         Gt2fpu8LSyw0qXIyi384DNEtzxsABGGLhu4D3ZrRWYZkwVDzZaz5+/BzVYa3S302X1yY
         yYRDLXxGnGeSi1OfZ5tLmVptCJpEd526sjy/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf4qna+chgdqKRpP/Wa5zsGXxEnC9UfbtEiM/gls+m0=;
        b=Y4N23417pmf1zFhZFuEdrosrGptRhLYji2eW09FEnREpuJBv6WHIoBKdJ6mjzDRHqV
         nTdakrwpQt6iKsXjCDOPArHBOSGsY6gcay6nBrcGGfgvye0E4cghBgWWwnEK65WYTRbf
         jeh8lE1uKd/sJYBpz4BwJG+ajEldZH/LkEvcnQzHC6fu/HIZbY03Yw2khE6pLeXRWM12
         N69oc6L70laxzv9hTbd49y8qkU9EaqZnSvHDYRpiBWLHfZWna6Orj/w/0XQf3w+/37Gw
         jLFCUNrxh4YZeMUwJ8M6pN8wZcZtzRmcWVSuDTgoImud+SbIMVJ3u6FaG4tLRXl2Rz/1
         9btQ==
X-Gm-Message-State: AOAM533B3RQL/tgfhK9rXLiq7OpUjyHgzqgV+ClDr4O+1+qXutI8Z878
        jAQN9SjlJGY4nRppGMM5V9RrIsG7ezg6bZULlQs=
X-Google-Smtp-Source: ABdhPJxZdefUvwE/f0iKVnmQEup3t1ivhW7w40vFCl+uoqjxqy8xcazeLHfqLOU5oz+k27UA38ktCw==
X-Received: by 2002:a05:6512:6c8:b0:471:ee3c:4654 with SMTP id u8-20020a05651206c800b00471ee3c4654mr9351000lff.57.1650874697461;
        Mon, 25 Apr 2022 01:18:17 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm1331394lfj.24.2022.04.25.01.18.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:18:14 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q185so7660811ljb.5
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 01:18:13 -0700 (PDT)
X-Received: by 2002:a2e:934b:0:b0:24f:cce:5501 with SMTP id
 m11-20020a2e934b000000b0024f0cce5501mr4447272ljh.443.1650874693427; Mon, 25
 Apr 2022 01:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <20220415164413.2727220-3-song@kernel.org>
 <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com> <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
In-Reply-To: <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Apr 2022 01:17:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
Message-ID: <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system hash
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Rik van Riel <riel@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000abeec805dd7637e2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000abeec805dd7637e2
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 25, 2022 at 12:07 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> vmalloc_huge() is provided by mm/vmalloc.c, which is not
> compiled if CONFIG_MMU=n.

Well, that's annoying.

Does this trivial patch fix it for you?

I get this feeling that this could be done better with a weak alias to
__vmalloc(), and that could take care of the "arch doesn't support
VMAP_HUGE" case too, but the attached is the stupid and
straightforward version.

                  Linus

--000000000000abeec805dd7637e2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2efx5810>
X-Attachment-Id: f_l2efx5810

IG1tL25vbW11LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvbW0vbm9tbXUuYyBiL21tL25vbW11LmMKaW5kZXggNTVhOWU0OGE3YTAyLi4y
YTY1NWVkNTY2NDQgMTAwNjQ0Ci0tLSBhL21tL25vbW11LmMKKysrIGIvbW0vbm9tbXUuYwpAQCAt
MjI2LDYgKzIyNiwxMSBAQCB2b2lkICp2bWFsbG9jKHVuc2lnbmVkIGxvbmcgc2l6ZSkKIH0KIEVY
UE9SVF9TWU1CT0wodm1hbGxvYyk7CiAKK3ZvaWQgKnZtYWxsb2NfaHVnZSh1bnNpZ25lZCBsb25n
IHNpemUsIGdmcF90IGdmcF9tYXNrKQoreworCXJldHVybiBfX3ZtYWxsb2Moc2l6ZSwgZ2ZwX21h
c2spOworfQorCiAvKgogICoJdnphbGxvYyAtIGFsbG9jYXRlIHZpcnR1YWxseSBjb250aWd1b3Vz
IG1lbW9yeSB3aXRoIHplcm8gZmlsbAogICoK
--000000000000abeec805dd7637e2--
