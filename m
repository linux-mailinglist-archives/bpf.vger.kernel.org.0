Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B8686C0E
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBAQtX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBAQtX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:49:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB22CFDC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:49:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k4so47747525eje.1
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqb+L2CBB33tTQj7SXKsrJt3sMRQT7u62eM6MlF3dSg=;
        b=l8xlrpM2AO1H5zE2VuXJILUd7Mh1Fs+i6mCiMRXQBO5iI1+amCHFyCnmr4A7rHohmg
         QgWEdFBrfCU3OwENwNsMycpLbTaPPIX9TtTvJSujWcKP2l+RPu5qFG+BMJhr/p/zva6R
         0a9HgSjikSTYP3jD04YkXJ9B9c4WZ3o8kgpTfF+0mquHX5eiqC/+TpJw2tSt0j/jtxqO
         Iwcw006ISwso0MGFcOAVIqzYFqfXQwtej+w6bg4932iVpx8yXa+MWhdxaKGiq/sqtk9+
         pVOsv5CkHqA5lyx6KP9T5IBmLQCuUlCLVn+wdq6SzJ/TZg7ZlijQMSfX23Pc9LDP3Wx4
         R5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sqb+L2CBB33tTQj7SXKsrJt3sMRQT7u62eM6MlF3dSg=;
        b=hOasHwIVVrcCfxnPAFudzOeI6hQKvK4QRqG1jOa+ZQ7EYOaecLx1B6fOyfNOztyQGu
         zlSLJ3xU/S3PvzcakAZ0NgEpwv1GCqBGf8gATKvh0cgGLyf2TFsASzRIXx0dZq7cRTqw
         P6MKleq+sk1WN+yC116Fr8pTHcGlqXXeUUVl2b48ornKg6SfLg888GV4z24ORzPZS7is
         gzBc/DIGAsUTxEe2LlfDIBQM5oHuH7B0OmECywRpyKqeL13efaw1RnR5JQ7bQKB8iaGM
         kBMRpB/IHo9SjhC8EkWmBINW3aeDv0R/QIh1lQO41sLxgYJ9lIIXI8eiKTxtDswpQSSJ
         EPdw==
X-Gm-Message-State: AO0yUKUWJR7gGWtWf0dH2mCF2yE5qoOzPIpgnNz2lZF9FsvYmsd2QWPT
        f79A9x4KWCGaEU/grUhHdTkJQpgI6sg72yhm1yY=
X-Google-Smtp-Source: AK7set9V9NOTJ6YnMRd/DUJbTH9imjanR691+eHpe40w2laWFvQVnnKInCnR72CnFyiFMCEd47MkSg/ZW0P0RvqhGgM=
X-Received: by 2002:a17:906:1f16:b0:887:e3fc:9201 with SMTP id
 w22-20020a1709061f1600b00887e3fc9201mr929496ejj.65.1675270158828; Wed, 01 Feb
 2023 08:49:18 -0800 (PST)
MIME-Version: 1.0
References: <Y9hpD0un8d/b+Hb+@kernel.org> <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com> <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge> <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org> <Y9qC5UQaw9g6cPwz@maniforge>
In-Reply-To: <Y9qC5UQaw9g6cPwz@maniforge>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Feb 2023 08:49:07 -0800
Message-ID: <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     David Vernet <void@manifault.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 1, 2023 at 7:19 AM David Vernet <void@manifault.com> wrote:
>
> On Wed, Feb 01, 2023 at 12:02:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
> > > On 01/02/2023 03:02, David Vernet wrote:
> > > > On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
> > > >> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
> > > >>>
> > > >>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> > > >>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > > >>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > > >>>>> <alexei.starovoitov@gmail.com> wrote:
> > > >>>>>>
> > > >>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >>>>>>>
> > > >>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> > > >>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> > > >>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> > > >>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >>>>>>>>>>>> +++ b/dwarves.h
> > > >>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> > > >>>>>>>>>>>>   uint8_t          has_addr_info:1;
> > > >>>>>>>>>>>>   uint8_t          uses_global_strings:1;
> > > >>>>>>>>>>>>   uint8_t          little_endian:1;
> > > >>>>>>>>>>>> + uint8_t          nr_register_params;
> > > >>>>>>>>>>>>   uint16_t         language;
> > > >>>>>>>>>>>>   unsigned long    nr_inline_expansions;
> > > >>>>>>>>>>>>   size_t           size_inline_expansions;
> > > >>>>>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
> > > >>>>>>>>>
> > > >>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> > > >>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
> > > >>>>>>>>>> defined if using a very old elf.h; below works around this
> > > >>>>>>>>>> (dwarves otherwise builds fine on this system).
> > > >>>>>>>>>
> > > >>>>>>>>> Ok, will add it and will test with containers for older distros too.
> > > >>>>>>>>
> > > >>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> > > >>>>>>>> repo at:
> > > >>>>>>>>
> > > >>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> > > >>>>>>>>
> > > >>>>>>>> It failed yesterday and today due to problems with the installation of
> > > >>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
> > > >>>>>>>> notifications floating by.
> > > >>>>>>>>
> > > >>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
> > > >>>>>>>> iterator that Jiri noticed.
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
> > > >>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> > > >>>>>>> from the BTF representation, and as a result:
> > > >>>>>>>
> > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > > >>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> > > >>>>>>>
> > > >>>>>>> Not sure why I didn't notice this previously.
> > > >>>>>>>
> > > >>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
> > > >>>>>>>
> > > >>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > >>>>>>> {
> > > >>>>>>>         return -EOPNOTSUPP;
> > > >>>>>>> }
> > > >>>>>>>
> > > >>>>>>> looks like this:
> > > >>>>>>>
> > > >>>>>>>    <8af83a2>   DW_AT_external    : 1
> > > >>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> > > >>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
> > > >>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
> > > >>>>>>>     <8af83a9>   DW_AT_decl_column : 5
> > > >>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
> > > >>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> > > >>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > > >>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> > > >>>>>>>     <8af83b3>   DW_AT_name        : ctx
> > > >>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
> > > >>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
> > > >>>>>>>     <8af83ba>   DW_AT_decl_column : 51
> > > >>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> > > >>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> > > >>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> > > >>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
> > > >>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
> > > >>>>>>>     <8af83c7>   DW_AT_decl_column : 61
> > > >>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> > > >>>>>>>
> > > >>>>>>> ...and because there are no further abstract origin references
> > > >>>>>>> with location information either, we classify it as lacking
> > > >>>>>>> locations for (some of) the parameters, and as a result
> > > >>>>>>> we skip BTF encoding. We can work around that by doing this:
> > > >>>>>>>
> > > >>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> > > >>>>>>
> > > >>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
> > > >>>>>>
> > > >>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
> > > >>>>>> applied to arguments.
> > > >>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
> > > >>>>>> the way we do in selftests.
> > > >>>>>
> > > >>>>> There is also
> > > >>>>> # define __visible __attribute__((__externally_visible__))
> > > >>>>> that probably fits the best here.
> > > >>>>>
> > > >>>>
> > > >>>> testing thus for seems to show that for x86_64, David's series
> > > >>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
> > > >>>> to cover recently-arrived kfuncs like cpumask) is sufficient
> > > >>>> to avoid resolve_btfids warnings.
> > > >>>
> > > >>> Nice. Alexei -- lmk how you want to proceed. I think using the
> > > >>> __bpf_kfunc macro in the short term (with __used and noinline) is
> > > >>> probably the least controversial way to unblock this, but am open to
> > > >>> other suggestions.
> > > >>
> > > >> Sounds good to me, but sounds like __used and noinline are not
> > > >> enough to address the issues on aarch64?
> > > >
> > > > Indeed, we'll have to make sure that's also addressed. Alan -- did you
> > > > try Alexei's suggestion to use __weak? Does that fix the issue for
> > > > aarch64? I'm still confused as to why it's only complaining for a small
> > > > subset of kfuncs, which include those that have external linkage.
> > > >
> > >
> > > I finally got to the bottom of the aarch64 issues; there was a 1-line bug
> > > in the changes I made to the DWARF handling code which leads to BTF generation;
> > > it was excluding a bunch of functions incorrectly, marking them as optimized out.
> > > The fix is:
> > >
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index dba2d37..8364e17 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> > >                         Dwarf_Op *expr = loc.expr;
> > >
> > >                         switch (expr->atom) {
> > > -                       case DW_OP_reg1 ... DW_OP_reg31:
> > > +                       case DW_OP_reg0 ... DW_OP_reg31:
> > >                         case DW_OP_breg0 ... DW_OP_breg31:
> > >                                 break;
> > >                         default:
> > >
> > > ..and because reg0 is the first parameter for aarch64, we were
> > > incorrectly landing in the "default:" of the switch statement
> > > and marking a bunch of functions as optimized out
> > > because we thought the first argument was. Sorry about this,
> > > and thanks for all the suggestions!
>
> Great, so inline and __used with __bpf_kfunc sounds like the way forward
> in the short term. Arnaldo / Alexei -- how do you want to resolve the
> dependency here? Going through bpf-next is probably a good idea so that
> we get proper CI coverage, and any kfuncs added to bpf-next after this
> can use the macro. Does that work for you?

It feels fixed pahole should be done under some flag
otherwise when people update the pahole the existing and older
kernels might stop building with warns:
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
...

Arnaldo, could you check what warns do you see with this fixed pahole
in bpf tree ?
If there are only few warns then we can manually add __used noinline
to these places, push to bpf tree and push to stable.

Then in bpf-next we can clean up everything with __bpf_kfunc.
