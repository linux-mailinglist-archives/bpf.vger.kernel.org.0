Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6D51290C
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbiD1BtA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiD1Bs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 21:48:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D1427CB
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 18:45:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 4so4820986ljw.11
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPwQIDuV4kr+Z3JfS80ukdJYoRtJwGRQLFz/8EXdtY8=;
        b=SCPzYsQnPWyQEhotMv9WnMsrFYGqhLzQhyJCSZmC2yd1aMhIzowrM7DocZOsyuBCND
         +LwiCROHEcaNzZDsvG4C5wkVi5MiKyGzYBTqe13MPpbmjjOEPGQ3P01/J/g7d0R8+Q03
         n3A3yDLjgffMlcrTHNN1O7ZvDG8Uk5nnzfpAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPwQIDuV4kr+Z3JfS80ukdJYoRtJwGRQLFz/8EXdtY8=;
        b=wJMD7EDhB+X+e/44P8Md3Rnm01OZKzjW29aQT+oa9debKKFXz7BOJZJ7EjYYC2HTaG
         BMQf1Zi7b1zi6Qyic808DUSrFqQrnqM5bpf3v2D7/cUoIAXW8sDvWrb57ya+yo+Xv0c7
         /r/3/Vgx3w6TaH2Vupij6Z2S50R9EcR1jaAjPe45kKB9My+mhhyLOSk683W+XwDaPO9v
         aBtyXNjhrlWHWXzRFDlYjFWN0+l931MwOU1mNCuJpjRuKlU11OBW5qnXYrptOr/QMZHp
         pXu1hB93UD5U+w8umxZPne+8oWbCzQtutVq4+np1+tWWFnQ4Fkx+UHDi6MEEIvSABFDg
         MquA==
X-Gm-Message-State: AOAM533xOaYfGPq1MvME25J6NAEBwagqtfymjsaTOu2TaqMwmfXQ9CZo
        dPzFaLL5QnMZw5sqy1m8LTpWq6BDugOTuE2Txe8=
X-Google-Smtp-Source: ABdhPJwkKQ3KEOMX2JnDcWPuj9KRLGJkVirv87b1s7saALKWkjG35hYjzhJ4RixLDOFROGjB6gDylQ==
X-Received: by 2002:a2e:bd09:0:b0:247:e127:5e05 with SMTP id n9-20020a2ebd09000000b00247e1275e05mr20224951ljq.212.1651110344213;
        Wed, 27 Apr 2022 18:45:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c6-20020a19e346000000b0046b8aac6e16sm2218372lfk.26.2022.04.27.18.45.42
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 18:45:42 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l19so4859178ljb.7
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 18:45:42 -0700 (PDT)
X-Received: by 2002:a2e:9d46:0:b0:24c:7f1d:73cc with SMTP id
 y6-20020a2e9d46000000b0024c7f1d73ccmr20046313ljj.358.1651110342350; Wed, 27
 Apr 2022 18:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220425203947.3311308-1-song@kernel.org> <FF2E0EC1-F9D6-4196-8887-919207BDC599@fb.com>
In-Reply-To: <FF2E0EC1-F9D6-4196-8887-919207BDC599@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Apr 2022 18:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA1Uku=ejwknv11ssNhz2pswhD=mJFBPEMQtCspz0YEQ@mail.gmail.com>
Message-ID: <CAHk-=wgA1Uku=ejwknv11ssNhz2pswhD=mJFBPEMQtCspz0YEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/3] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <song@kernel.org>
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

On Wed, Apr 27, 2022 at 3:24 PM Song Liu <songliubraving@fb.com> wrote:
>
> Could you please share your suggestions on this set? Shall we ship it
> with 5.18?

I'd personally prefer to just not do the prog_pack thing at all, since
I don't think it was actually in a "ready to ship" state for this
merge window, and the hugepage mapping protection games I'm still
leery of.

Yes, the hugepage protection things probably do work from what I saw
when I looked through them, but that x86 vmalloc hugepage code was
really designed for another use (non-refcounted device pages), so the
fact that it all actually seems surprisingly ok certainly wasn't
because the code was designed to do that new case.

Does the prog_pack thing work with small pages?

Yes. But that wasn't what it was designed for or its selling point, so
it all is a bit suspect to me.

And I'm looking at those set_memory_xyz() calls, and I'm going "yeah,
I think it works on x86, but on ppc I look at it and I see

  static inline int set_memory_ro(unsigned long addr, int numpages)
  {
        return change_memory_attr(addr, numpages, SET_MEMORY_RO);
  }

and then in change_memory_attr() it does

        if (WARN_ON_ONCE(is_vmalloc_or_module_addr((void *)addr) &&
                         is_vm_area_hugepages((void *)addr)))
                return -EINVAL;

and I'm "this is all supposedly generic code, but I'm not seeing how
it works cross-architecture".

I *think* it's actually because this is all basically x86-specific due
to x86 being the only architecture that implements
bpf_arch_text_copy(), and everybody else then ends up erroring out and
not using the prog_pack thing after all.

And then one of the two places that use bpf_arch_text_copy() doesn't
even check the returned error code.

So this all ends up just depending on "only x86 will actually succeed
in bpf_jit_binary_pack_finalize(), everybody else will fail after
having done all the common setup".

End result: it all seems a bit broken right now. The "generic" code
only works on x86, and on other architectures it goes through the
motions and then fails at the end. And even on x86 I worry about
actually enabling it fully.

I'm not having the warm and fuzzies about this all, in other words.

Maybe people can convince me otherwise, but I think you need to work at it.

And even for 5.19+ kind of timeframes, I'd actually like the x86
people who maintain arch/x86/mm/pat/set_memory.c also sign off on
using that code for hugepage vmalloc mappings too.

I *think* it does. But that code has various subtle things going on.

I see PeterZ is cc'd (presumably because of the text_poke() stuff, not
because of the whole "call set_memory_ro() on virtually mapped kernel
largepage memory".

Did people even talk to x86 people about this, or did the whole "it
works, except it turns out set_vm_flush_reset_perms() doesn't work"
mean that the authors of that code never got involved?

               Linus
