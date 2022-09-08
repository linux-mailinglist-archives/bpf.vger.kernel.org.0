Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973E05B1292
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIHCjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIHCjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:39:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0432AAE
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:39:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z17so6711996eje.0
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/wnrLBaOC4aWP82zfkDM/92trSlcecvy7qsO4Kz79x8=;
        b=Z4/R0+uaQufuejsMnXGQz1Fg+N0dRFgS9zlL93ceH6K7evk+6NbwDteMll4WHO0x8M
         WhcPV+dVFwQdJ5JkaFRe/JmjbchdDH3+mrbUcOF2FDL0eplXvoDWdkrA01s7ILdxfErP
         RNntSsF4I196VjURPNC7RpWs7DTvpBzq63pSXqbHLMQ7m4EeC692eEHLDMArh23ienYy
         B5+7yKoFV4QnKEGLUzn8yyMoILQsdpgNImKaXXZxNo70oyM7nhHFZ91VjUE0UAT8mveE
         OJJDzdhojS3XeNDryiixnzBQ01V/K9NQ1sqE4bOLXCdyyNMnF7N0VKbTxotQLLEyQp3b
         4MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/wnrLBaOC4aWP82zfkDM/92trSlcecvy7qsO4Kz79x8=;
        b=R35UnA5YOyxYqIA9tg/5B5SRUi5JbGX22p11cshNlR7umuOHWLYOpoNI+4+bohINMI
         CChLMTWqGILrrk7v8kwf3oJOzFWoZjNyUjWCbCKZNvEn0QrZ9suHzoIoiEIB2IF/zSla
         ZiXfqZwIcPiNCkqGsErYJplgMqXEUWUnPdp7e9ZIbkR8xQgXHr08nw3ZBJ+fO5t6fhSJ
         D/KqRg1x9khaKecFGUEbVRxPwRYtMIB+DRvLVBlpQVFxK13K9lX1MWODri07z/c8czly
         xAt1SvR4BBN4sI59Qc1IdLWIJ8oNQvCEkY7Ks+OociW/UcxcJ1YO3rvWsp9wJbddRdGc
         HI1g==
X-Gm-Message-State: ACgBeo21rP2eVZFKyDWLqk2gFCL9Uu1KI0yauT1TdtcAFM5Rp1XQJaBE
        UuyR+bzfDSI80V5/1YtDgd37ozmR4ke01VYag9o=
X-Google-Smtp-Source: AA6agR7Wfj8RsEmGsJA3FE/DqrLcVZz0rUzBNoomhWcjXySRlv0scmh2UMw+Ahm9Bj6/nIZpcy31Ztn9SrGbfjWQFUc=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr4473898ejc.676.1662604786677; Wed, 07
 Sep 2022 19:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <20220908002742.cqwwahxa5ktaik3r@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T76nqGs0gW2MPJVMNu90j7DT6GChU0PKS1KZQt7SHb6ypg@mail.gmail.com>
 <CAADnVQLvRKiqVLy-SqC-fJjfqGHYvYUXQMRuT3vTzVA7BfoEGw@mail.gmail.com> <CAP01T751R0-CnZev6KRQN+x5b9FNeajaAhqaz7MMSmAdKRy6SA@mail.gmail.com>
In-Reply-To: <CAP01T751R0-CnZev6KRQN+x5b9FNeajaAhqaz7MMSmAdKRy6SA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Sep 2022 19:39:35 -0700
Message-ID: <CAADnVQ+qsBNCcTKaV1SOfX6ajv4duOpsVGPbJ9NOb+OXn_5LgQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 6:15 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 8 Sept 2022 at 03:09, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Sep 7, 2022 at 6:01 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Thu, 8 Sept 2022 at 02:27, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sun, Sep 04, 2022 at 10:41:34PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > Global variables reside in maps accessible using direct_value_addr
> > > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > > disallows us from holding locks which are global.
> > > > >
> > > > > This is not great, so refactor the active_spin_lock into two separate
> > > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > > enough to allow it for global variables, map lookups, and local kptr
> > > > > registers at the same time.
> > > > >
> > > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > > whether bpf_spin_unlock is for the same register.
> > > > >
> > > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > > are doing lookup for the same map value (max_entries is never greater
> > > > > than 1).
> > > > >
> > > > > Essentially, we consider that the tuple of (active_spin_lock_ptr,
> > > > > active_spin_lock_id) will always be unique for any kind of argument to
> > > > > bpf_spin_{lock,unlock}.
> > > > >
> > > > > Note that this can be extended in the future to also remember offset
> > > > > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > > > > in the same allocation.
> > > > >
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  include/linux/bpf_verifier.h |  3 ++-
> > > > >  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
> > > > >  2 files changed, 29 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > index 2a9dcefca3b6..00c21ad6f61c 100644
> > > > > --- a/include/linux/bpf_verifier.h
> > > > > +++ b/include/linux/bpf_verifier.h
> > > > > @@ -348,7 +348,8 @@ struct bpf_verifier_state {
> > > > >       u32 branches;
> > > > >       u32 insn_idx;
> > > > >       u32 curframe;
> > > > > -     u32 active_spin_lock;
> > > > > +     void *active_spin_lock_ptr;
> > > > > +     u32 active_spin_lock_id;
> > > >
> > > > {map, id=0} is indeed enough to distinguish different global locks and
> > > > {map, id} for locks in map values,
> > > > but what 'btf' is for?
> > > > When is the case when reg->map_ptr is not set?
> > > > locks in allocated objects?
> > > > Feels too early to add that in this patch.
> > > >
> > >
> > > It makes active_spin_lock check simpler, just checking
> > > active_spin_lock_ptr that to be non-NULL indicates lock is held. Don't
> > > have to always check both ptr and id, only need to compare both when
> > > verifying that lock is in the same allocation as reg.
> >
> > Not following. There is always non-null reg->map_ptr when
> > we come down this path.
> > At least in the current state of the verifier.
> > So it never assigns that btf afacs.
>
> map is only set when reg->type == PTR_TO_MAP_VALUE,
> otherwise btf = reg->btf for local kptrs (else branch). Then the map
> ptr is NULL.
> See patch 18 which already added support to local kptrs.

I see. That's what I was missing.
