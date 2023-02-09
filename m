Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A15690DDE
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 17:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjBIQFk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 11:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBIQF1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 11:05:27 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98466EC4
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 08:04:42 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id h24so2501016qtr.0
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 08:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4P+40N3bBS4Fq/14YMs0jzb31JM5tH+x53FqKfD21s=;
        b=G/KG7W1fw0x9HBdRRYZVaUqzobjOY/OrROwvtYvHZg2wmLUiw18wlzDDXgVOX4HuCN
         B4faDBfVKWobjpd3QkKNXCo/x4DTDqWtYGrQcz35qIq7z+OfAOGI6rA6+HThYKR7JXoo
         OhAcGrOc4uEINXy6QicLZjN3Rj9G72oxA5UyLtLugmOsiO8uUqnGuTRltX5G5cJmRP3B
         KVlhBx0S69j3+rT/zU0COYumzNGohz713E/ZwQR8exnRW8A90d9D9i2A5e1JvKYu1Idh
         6uh9KrOssn49v5zpkTFCPrcujPQ/4faL0MgL0MoiVE3h81HfWbDCvl2BQ0F8Q8mKFq+O
         03ug==
X-Gm-Message-State: AO0yUKVJjWr+JbbAOb+rst/Bn8v6zXoRCh7tG0TA2gS/OAsNZMvxlfWs
        MbjROe6cQUqLPmPOQdELMUc=
X-Google-Smtp-Source: AK7set+F5C2oNQ0IlPHoQX6/N++BuJfsyRrQYCHDjcLWtiJZekSByKBm2WsFpugN2AF1zVSFRW4nfg==
X-Received: by 2002:a05:622a:c4:b0:3b9:a4fe:e86c with SMTP id p4-20020a05622a00c400b003b9a4fee86cmr18475428qtw.16.1675958680080;
        Thu, 09 Feb 2023 08:04:40 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:66f6])
        by smtp.gmail.com with ESMTPSA id 17-20020ac82091000000b003b960aad697sm1526560qtd.9.2023.02.09.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:04:39 -0800 (PST)
Date:   Thu, 9 Feb 2023 10:04:37 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Thaler <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Message-ID: <Y+UZlXKpX/DweajS@maniforge>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan>
 <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+hgqw4fL8Vvq7GkP8VkO3wvFbhVD-LFU+h9-8vQC+0RQ@mail.gmail.com>
 <Y+PefizA09h21XSF@maniforge.lan>
 <PH7PR21MB387839E8170EB572814FA63FA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB387839E8170EB572814FA63FA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 05:45:59PM +0000, Dave Thaler wrote:
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Wednesday, February 8, 2023 9:40 AM
> > To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Dave Thaler <dthaler@microsoft.com>; Dave Thaler
> > <dthaler1968@googlemail.com>; bpf@vger.kernel.org; bpf@ietf.org
> > Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
> > 
> > On Wed, Feb 08, 2023 at 09:31:18AM -0800, Alexei Starovoitov wrote:
> > > On Wed, Feb 8, 2023 at 9:26 AM Dave Thaler
> > > <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
> > > >
> > > > David Vernet wrote:
> > > > > > +Reserved instructions
> > > > > > +====================
> > > > >
> > > > > small nit: Missing a =
> > > >
> > > > Ack.
> > > >
> > > > > > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP``
> > > > > > +(0x8d)
> > > > > instruction if ``-O0`` is used.
> > > > >
> > > > > Are we calling this out here to say that BPF_CALL in clang -O0
> > > > > builds is not supported? That would seem to be the case given that
> > > > > we say that BPF_CALL
> > > > > | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.rst.
> > > >
> > > > Yes, exactly.  I could update the language to add something like
> > > > "... so BPF_CALL in clang -O0 builds is not supported".
> > >
> > > That will not be a correct statement.
> > > BPF_CALL is a valid insn regardless of optimization flags.
> > > BPF_CALLX will be a valid insn when the verifier support is added.
> > > Compilers need to make a choice which insn to use on a case by case basis.
> > > When compilers have no choice, but to use call by register they will
> > > use callx. That what happens with = (void *)1 hack that we use for
> > > helpers.
> > > It can happen with -O2 just as well.
> > 
> > In that case, I suggest we update the verbiage in instruction-set.rst to
> > say:
> > 
> > Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> > integer would be read from a specified register, is not currently supported by
> > the verifier. Any programs with this instruction will fail to load until such
> > support is added.
> 
> The problem with that wording is that it implies that there is "the" verifier,
> whereas the point of standard documentation (since this file is also being used
> to generate the IETF spec) is to keep statements about any specific verifier
> or compiler out of instruction-set.rst.  That's why there's separate files like

Yes, good point.

> clang-notes.rst for the clang compiler, etc.   The instruction set rst is,
> in my view, should apply across all compilers, all verifiers, all runtimes, etc.
> It could potentially say certain things are optional to support, but there is
> a distinction between "defined" vs "reserved" where it currently means
> such support is "reserved" not "defined".

That makes sense. IMO we should just say that the instruction is valid
then, and not make a distinction. 'reserved' should imply that the bits
for the instruction in question have no definition whatsoever, e.g.
reserved bits in control registers in x86, etc. In this case, the
instruction is valid, we just haven't chosen to implement support for it
yet in the Linux verifier. That's par for the course for implementing
standards. Usually we don't implement something until it's needed.
