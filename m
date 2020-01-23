Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32B1460A0
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 03:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWCI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 21:08:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgAWCI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 21:08:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so749659pfz.9
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 18:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:cc:from:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=5gsNXHyzHDiJgy8YcrzY+fMhsyVMGiFXDcVBfNfdEVo=;
        b=gZz10cQaqiqIYtnjl/9xxE2vIX2tteYAe8iGn7d0JSDxybrWLxFOnWVRktCvwYXQdA
         5QqUi46Q6uWx4ael1eLS0feakIgcUg1HHom7iXtTEtUGvCmP1qLJvePauQaq8pCzTu08
         AppG9qgSFcXI328/MHRLwfmU9CkDIqIPIjm26fCQFbx6vy0SjmmlZVvPZyRpjQTX9CS2
         ovVxsnDit6GxS4v3nI/k124EM5fEpOJYb6gbUnNcAjfITA6+0LYSwVBGwTo+VSItbtdN
         wqen8u/1v5vGacJJb30YUx1pvOi99fvsH55hPWaFjve1MH3OdpBXE09URWiziJfTi12c
         NTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=5gsNXHyzHDiJgy8YcrzY+fMhsyVMGiFXDcVBfNfdEVo=;
        b=jgS4tVWfl0sfLBUb27hKsslxV5f4oUju64oCLlOxxgT8GpoqLKW4I/9Eq9Xo265GfI
         +YX4oRiNVYVC/Hm2Vh8mEuGGRmGvHnQV3gI03gePCcxHX3xSqC7XlSQrXCTS6aFBz92S
         Ur5MPP5xfudquW5T6nAOWs+WsYZdXN05TF8klOHk0UiE30koBzwxDDcGB3OLjRrkCpQY
         O0fRA/6+LmH4crUtfz6aI8qD3lYyGFpyuYK9iqx6aqZBm8xbTBZouFZRIcliiqvsyK/0
         qjNdhL8HL0n2/KA1jXnA5JmlTKnfgAPqT7OOZxr63WY0BPW6pOuWEw/DlnawmnHRAD7O
         dy+Q==
X-Gm-Message-State: APjAAAUQp6S2l/oSCSSPrWxxhcUiJLHlTBkCfOgt36+e/PKAUKFJFAwW
        b4aDLRho/fzmdeXQbb31KE3wnQ==
X-Google-Smtp-Source: APXvYqynPg9BNC9857j3pLW+kIkrUtgKIiKGzykGRIQp06LS0+nPuKG3MQ9oD/XhFKLr67acldXB/Q==
X-Received: by 2002:a63:2308:: with SMTP id j8mr1320556pgj.86.1579745337946;
        Wed, 22 Jan 2020 18:08:57 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id q11sm221136pff.111.2020.01.22.18.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 18:08:57 -0800 (PST)
Date:   Wed, 22 Jan 2020 18:08:57 -0800 (PST)
X-Google-Original-Date: Wed, 22 Jan 2020 18:08:54 PST (-0800)
Subject:     Re: [PATCH bpf-next v2 2/9] riscv, bpf: add support for far branching
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, lukenels@cs.washington.edu,
        bpf@vger.kernel.org, xi.wang@gmail.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <CAJ+HfNjoO2ihHMh2NHMQfxG8X1zLdzEq6Ywr=b2qD0tNwXreFA@mail.gmail.com>
References: <CAJ+HfNjoO2ihHMh2NHMQfxG8X1zLdzEq6Ywr=b2qD0tNwXreFA@mail.gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com> <20191216091343.23260-3-bjorn.topel@gmail.com>
  <mhng-6be38b2a-78df-4016-aaea-f35aa0acd7e0@palmerdabbelt-glaptop>
Message-ID: <mhng-9d460c8a-52e3-4a65-bd23-6210ad1fbf05@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 07 Jan 2020 00:13:56 PST (-0800), Bjorn Topel wrote:
> Back from the holidays; Sorry about the delayed reply.
>
> On Mon, 23 Dec 2019 at 19:03, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Mon, 16 Dec 2019 01:13:36 PST (-0800), Bjorn Topel wrote:
>> > This commit adds branch relaxation to the BPF JIT, and with that
> [...]
>> > @@ -1557,6 +1569,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> >  {
>> >       bool tmp_blinded = false, extra_pass = false;
>> >       struct bpf_prog *tmp, *orig_prog = prog;
>> > +     int pass = 0, prev_ninsns = 0, i;
>> >       struct rv_jit_data *jit_data;
>> >       struct rv_jit_context *ctx;
>> >       unsigned int image_size;
>> > @@ -1596,15 +1609,25 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> >               prog = orig_prog;
>> >               goto out_offset;
>> >       }
>> > +     for (i = 0; i < prog->len; i++) {
>> > +             prev_ninsns += 32;
>> > +             ctx->offset[i] = prev_ninsns;
>> > +     }
>>
>> It feels like the first-order implementation is the same as binutils here: the
>> first round is worst cased, after which things can be more exact.  We're only
>> doing one pass in binutils because most of the relaxation happens in the
>> linker, but this approach seems reasonable to me.  I'd be interested in seeing
>> some benchmarks, as it may be worth relaxing these in the binutils linker as
>> well -- I can certainly come up with contrived test cases that aren't relaxed,
>> but I'm not sure how common this is.
>>
>
> Ah, interesting! Let me try to pull out some branch relaxation
> statistics/benchmarks for the BPF selftests.
>
>> My only worry is that that invariant should be more explicit.  Specifically,
>> I'm thinking that every time offset is updated there should be some sort of
>> assertion that the offset is shrinking.  This is enforced structurally in the
>> binutils code because we only generate code once and then move it around, but
>> since you're generating code every time it'd be easy for a bug to sneak in as
>> the JIT gets more complicated.
>>
>
> Hmm, yes. Maybe use a checksum for the program in addition to the
> length invariant, and converge condition would then be prev_len == len
> && prev_crc == crc?

That would work, but it breaks my unfinished optimization below.  I was
thinking something more like "every time offset[i] is updated, check that it
gets smaller and otherwise barf".

>> Since most of the branches should be forward, you'll probably end up with way
>> fewer iterations if you do the optimization passes backwards.
>>
>
> Good idea!
>
>> > -     /* First pass generates the ctx->offset, but does not emit an image. */
>> > -     if (build_body(ctx, extra_pass)) {
>> > -             prog = orig_prog;
>> > -             goto out_offset;
>> > +     for (i = 0; i < 16; i++) {
>> > +             pass++;
>> > +             ctx->ninsns = 0;
>> > +             if (build_body(ctx, extra_pass)) {
>> > +                     prog = orig_prog;
>> > +                     goto out_offset;
>>
>> Isn't this returning a broken program if build_body() errors out the first time
>> through?
>>
>
> Hmm, care to elaborate? I don't see how?

Ya, I don't either any more.  Hopefully I just got confused between prog and
ctx...

>> > +             }
>> > +             build_prologue(ctx);
>> > +             ctx->epilogue_offset = ctx->ninsns;
>> > +             build_epilogue(ctx);
>> > +             if (ctx->ninsns == prev_ninsns)
>> > +                     break;
>> > +             prev_ninsns = ctx->ninsns;
>>
>> IDK how important the performance of the JIT is, but you could probably get
>> away with skipping an iteration by keeping track of some simple metric that
>> determines if it would be possible to
>>
>
> ...to? Given that the programs are getting larger, performance of the
> JIT is important. So, any means the number of passes can be reduced is
> a good thing!

I guess I meant to say "determines if it would be possible to make any
modifications next time".  I was thinking something along the lines of:

* as you run through the program, keep track of the shortest branch distance
* if you didn't remove enough bytes to make that branch cross a relaxation
  boundary, then you know that next time you won't be able to do any useful
  work

You're already computing all the branch lengths, so it's just an extra min().
Since we're assuming a small number of passes (after reversing the relaxation
direction), you'll probably save more work avoiding the extra pass than it'll
take to compute the extra information.  I guess some sort of benchmark would
give a real answer, but it certainly smells like a good idea ;)

>
>
> Thanks for the review/suggestions!
> Björn
