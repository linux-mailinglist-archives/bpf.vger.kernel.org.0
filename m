Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D55A0A38
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiHYH1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiHYH1t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 03:27:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4263F1A
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 00:27:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j21so32422154ejs.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/oj50hsl8kbfl2r5TD7WwWtw83gdRut5PdToYGpC4Ik=;
        b=Goy06y0aydlFdewFjaQoeuV6+94AF3G4Kd5MnBCFsRmAguUDtmTDpQb6gSDsC8v858
         O/sDYoTbg6PSw67ijrEnRK2ZAHwB9YaQefNZl+U/92XlmmBmO0tImfXBiXc6OEXrm0Mk
         aFgclEQ/Wy3ZKJgW2dVbRAOlKaWpWn3UCrdcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/oj50hsl8kbfl2r5TD7WwWtw83gdRut5PdToYGpC4Ik=;
        b=B+Ya6sb1dYtQ8Pc6qCEwA3E6ie7GciKdqGww7xO9Jy1+jXa4W/N2699j1gWst+uT2c
         VZR4in5BVTvEmXfQ+cCicQnB/+G2uzOdX7jF10a3jnWwwcAZsYzDndsxVdFMTValH9kR
         jpJ8LpbPV75mySsDtx9zPhTnVFcw8c8xE9oWOAPd6v2cf76r5Ue0t+GDhX4tkS64VGHh
         /VV7XHmEd3EmtHmJYNxIwnDt4od/0uKvtNJKcp5evJFQXP/tjcaTU7ZITwpGFkHAz553
         EA1mVvFAh677SWU4/BfG1tpRmscKT0USkGvQbMORjNTa7bN/2hRch12D+8TcBl6IlPUg
         JtVw==
X-Gm-Message-State: ACgBeo3E4WYdBvPHNY6gOYqZyk3xvHTZ/jfrpF4FagZ+k3Z97mFLwvux
        sYPKdj3dABo/JB7CapSo7qUU8gdwpIn6sOPPTow=
X-Google-Smtp-Source: AA6agR7Khliy/1krcgeS1GNpA5TOUm1puhpodUKwiHWcg83da5RTA95BzZyI8FZa8onGm9P8LvhPYA==
X-Received: by 2002:a17:906:668b:b0:730:a5b7:8985 with SMTP id z11-20020a170906668b00b00730a5b78985mr1505808ejo.548.1661412466048;
        Thu, 25 Aug 2022 00:27:46 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b0073c5192cba6sm2034286ejf.114.2022.08.25.00.27.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:27:44 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b5so19157295wrr.5
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 00:27:43 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr1385724wrv.97.1661412462666; Thu, 25 Aug
 2022 00:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com> <87ilmgddui.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ilmgddui.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 00:27:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
Message-ID: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 11:41 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> The justifications brought forward are just regurgitating previous
> misinformation.  If you do that, it's hard to take you seriously.

Pot, meet kettle.

> There is actually a good reason for using __u64: it's always based on
> long long, so the format strings are no longer architecture-specific,
[..]

That's a small detail that yes, we've tried to avoid the absolute
humongous mess that the C standard library has with their horrendous
'PRId*' mess, but honestly, it's just a tiny detail.

The real issue is that we want to be able to control our own types,
and our own names, and in the process have sometimes been able to
standardize on types that makes it easier to just not have to deal
with "oh, somebody picked 'int' on this architecture, and 'long' on
this other, and they are both 32-bit types".

We still have to deal with that for '[s]size_t', but that's such a
standard legacy type that thankfully we have the whole '%zu/%zd' thing
for that.

And yes, sometimes we screw up even *though* we were the ones that
picked the types, and we've had pointless differences where '__u64'
could be 'unsigned long' on a 64-bit architecture, and 'unsigned long
long' on a 32-bit one, and then we were able to fix our own little
broken type system exactly because it was *OUR* little type system.

So you are correct that then in the specific case of '__u64' we have
been able to simply just standardize on 'unsigned long long' and make
printf strings simpler.

But you are wrong to think that that is somehow a special thing.

It's not.

It's very much all the same thing: we have types *we* control, and
thanks to that we can do them the way *we* need them done, and can fix
them when we made a silly mistake.

In other words, it's the whole *point* of not ever using 'stdint.h' at
all for those things.

(It's also about avoiding the kinds of unholy things that happen in
system header files. Have you ever *looked* at them? Christ. The
amount of absolute crap you get from including <stdint.h> in user
space is scary)

> You cannot avoid using certain ISO C names with current GCC or Clang,
> however hard you try.

You  are now the one who is regurgitating complete mis-information.

You do it so prettily, and with such weasel-wording, that I know you
must be knowingly threading that fine line between "actively
misleading" but trying to avoid "outright lying"..

You say "certain ISO C names" to try to make it sound as if this was
at all relevant to things like "uint32_t" and friends.

But deep down, you know you're basically lying by omission.

Because it's true that we have to know and care about things like
'size_t', which comes up for all the basic string.h functions.

So yes, we have a very small set of types that we make sure matches
the compiler notion of said types, and we carefully use things like

    typedef __kernel_ulong_t __kernel_size_t;

and then we have our own 'stdarg.h which uses

    typedef __builtin_va_list va_list;

that is explicitly the one that the compiler exposes with those double
underscores exactly because even the compiler can't expose the
"standard" name due to namespace issues.

And no, NONE OF THOSE ARE USABLE IN THE UAPI HEADERS!

And equally importantly, none of those have *anything* to do with the
'uint32_t' kind of names.

The fact that yes, we care about what the compiler thinks "size_t" is
(because we do want the compiler to do memset() for us) has absolutely
*NOTHING* to do with uint32_t and <stdint.h>.

And I'm pretty sure you knew that, but you tried to make it sound like
they were somehow all in the same boat.

And yes, some drivers tend to actually use 'uint32_t' in the kernel,
and we allow it, but they cannot be used by user interfaces. So a uapi
file really *really* shouldn't ever use them.

And no, we don't use "-ffreestanding" and friends - we actually have
occasionally wanted and tried to do so just to make the boundary lines
clearer, but then that will make gcc no longer do sane things for
'memcpy()'' and friends, so it's kind of a balancing act.

> <stdarg.h>, <stddef.h>, <stdint.h> are compiler-provided headers that
> are designed to be safe to use for bare-metal contexts (like in
> kernels).  Avoiding them is not necessary per se.

We explicitly avoid them all.

We historically used stdarg.h and stddef.h (but never stdint.h -
there's absolutely _zero_ upside), but it was always a slight pain.

So we simply bake our own, exactly because it's simply less painful
than having to deal with possible system-provided ones.

People do odd compiler things with host compilers, bad or odd
installations of cross-build environments, it's just not worth the
pain to deal with the "system header files" when they just don't
provide any real value.

                        Linus
