Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8955520B0D
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiEJCPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 22:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiEJCPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 22:15:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23B40E5A
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 19:11:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c14so13755484pfn.2
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnQdTG2d3N/tU9tJlds8AUzdophMDnixlVj6jAvheiE=;
        b=c4mhTwiVLvns0LDFuRjhiNYSRqyxXqCmc/6GCLMjoPqhPphz9LuK3v0F9mCNV7An//
         CRxSWap8FgsDmfAKBkxIhkhzcHSIIDAGYaUVKPPc9U7UB2DBe/VIrAS1qrRuaYxamv8C
         4lAFR8+rxP48ZoF8JpVr9jewolYTZsPlybS6eQLaAX67vyXY5qnga/0qfd6jOEOxPqHb
         skczEPCZN6vVjMdRY0KOoQuvtJX8nIxyy6Fp78dRuHf+2YEAAtv4e4IxBxI7lIGiFF42
         WyJ1CdXx+ItBBkOsZsEM6+WNHGu45+/bNtOJljdnO4coD8hmAr2ipao0eIKHEdNpUjI6
         CTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnQdTG2d3N/tU9tJlds8AUzdophMDnixlVj6jAvheiE=;
        b=6drTczk3Pva8hs8aeOFMfQbZwirzQxSS3Nx7Cc/RTqb7rZDKLMYmX+JIdaYWdv/Xi+
         U+nutI4XJwNev5xnRdRFi1P/3g1zdKXHIme1qkKbUVCEXdmwjrBBPIaQ2f1og3juxVEc
         EspdM3KnoDiEKFci2NgG1vpBrinyeqwxWR4O5l8A7PDqt67FgoBY5Lc+6EqzGPcawRpn
         idjfy4rJo31vdynmX5udY1XcsyhLCwB/jjlF8MG14zeo8rOn14KVS6zlx/tdwa3McHHN
         lID6QXJCQ6T7DQQUFzAfJRa/X1TwkbjrCqi/wLQvs+fjwGroZNNinA/6u1lMnowW5UgY
         qBRg==
X-Gm-Message-State: AOAM530qNQMkoKgKt+MD/NrlCY+YWDFW67lK6wpMhA+U5fNlhwVMvAW4
        3dOIv/uxTA2RcxCly0Gh+3i4XSKzAFeyuqz/2/o=
X-Google-Smtp-Source: ABdhPJxK0fp6OhK6k3k+I/+tz46mnKKvZ9sE/f5n97no+6BWvhSbrJRRGCtS3xlxG/QDokjk+IRZAAjXYlcTtUPgj4k=
X-Received: by 2002:a65:6e41:0:b0:39c:c97b:2aef with SMTP id
 be1-20020a656e41000000b0039cc97b2aefmr15758429pgb.473.1652148703815; Mon, 09
 May 2022 19:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-3-kuifeng@fb.com>
 <20220509210425.igjjopd4virbtn3u@MBP-98dd607d3435.dhcp.thefacebook.com>
 <c3ade9c0ad19e9cef5864c0df948e0ae4cd54709.camel@fb.com> <34dd81b7fe8f0e683a56a8fbcb32957d1d61969e.camel@fb.com>
In-Reply-To: <34dd81b7fe8f0e683a56a8fbcb32957d1d61969e.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 9 May 2022 19:11:32 -0700
Message-ID: <CAADnVQL9AGSm57gvBDgrdrV+bvAkAtXGuyFVHKOuiRT393DREg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, May 9, 2022 at 6:43 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Tue, 2022-05-10 at 01:29 +0000, Kui-Feng Lee wrote:
> > On Mon, 2022-05-09 at 14:04 -0700, Alexei Starovoitov wrote:
> > > On Sat, May 07, 2022 at 08:21:14PM -0700, Kui-Feng Lee wrote:
> > > >
> > > > +       /* Prepare struct bpf_tramp_run_ctx.
> > > > +        * sub rsp, sizeof(struct bpf_tramp_run_ctx)
> > > > +        */
> > > > +       EMIT4(0x48, 0x83, 0xEC, sizeof(struct
> > > > bpf_tramp_run_ctx));
> > > > +
> > > >         if (fentry->nr_links)
> > > >                 if (invoke_bpf(m, &prog, fentry, regs_off,
> > > >                                flags &
> > > > BPF_TRAMP_F_RET_FENTRY_RET))
> > > > @@ -2098,6 +2121,11 @@ int arch_prepare_bpf_trampoline(struct
> > > > bpf_tramp_image *im, void *image, void *i
> > > >         }
> > > >
> > > >         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > > > +               /* pop struct bpf_tramp_run_ctx
> > > > +                * add rsp, sizeof(struct bpf_tramp_run_ctx)
> > > > +                */
> > > > +               EMIT4(0x48, 0x83, 0xC4, sizeof(struct
> > > > bpf_tramp_run_ctx));
> > > > +
> > > >                 restore_regs(m, &prog, nr_args, regs_off);
> > > >
> > > >                 /* call original function */
> > > > @@ -2110,6 +2138,11 @@ int arch_prepare_bpf_trampoline(struct
> > > > bpf_tramp_image *im, void *image, void *i
> > > >                 im->ip_after_call = prog;
> > > >                 memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
> > > >                 prog += X86_PATCH_SIZE;
> > > > +
> > > > +               /* Prepare struct bpf_tramp_run_ctx.
> > > > +                * sub rsp, sizeof(struct bpf_tramp_run_ctx)
> > > > +                */
> > > > +               EMIT4(0x48, 0x83, 0xEC, sizeof(struct
> > > > bpf_tramp_run_ctx));
> > > >         }
> > > >
> > > >         if (fmod_ret->nr_links) {
> > > > @@ -2133,6 +2166,11 @@ int arch_prepare_bpf_trampoline(struct
> > > > bpf_tramp_image *im, void *image, void *i
> > > >                         goto cleanup;
> > > >                 }
> > > >
> > > > +       /* pop struct bpf_tramp_run_ctx
> > > > +        * add rsp, sizeof(struct bpf_tramp_run_ctx)
> > > > +        */
> > > > +       EMIT4(0x48, 0x83, 0xC4, sizeof(struct
> > > > bpf_tramp_run_ctx));
> > > > +
> > >
> > > What is the point of all of these additional sub/add rsp ?
> > > It seems unconditionally increasing stack_size by sizeof(struct
> > > bpf_tramp_run_ctx)
> > > will achieve the same and above 4 extra insns won't be needed.
> >
> > I think you are right.
> >
>
> The reason that I don't change stack_size is that we access arguments
> or saved registers basing on stack_size.  Once the stack_size is
> changed, all these offsets should be changed too.

That should be trivial.
keep regs_off = stack_size;
and increase stack_size right after.
or some other math.
Maybe worth introducing another _off
in addition to int regs_off, ip_off, args_off.
Definitely update 'Generated trampoline stack layout' comment
and explain where bpf_tramp_run_ctx is in relation to regs_off.
Maybe keeping regs_off (without new _off) is enough.
