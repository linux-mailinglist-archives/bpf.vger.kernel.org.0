Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D957A5D8
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiGSRy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiGSRy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:54:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963685A8BB;
        Tue, 19 Jul 2022 10:54:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v12so20672896edc.10;
        Tue, 19 Jul 2022 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbhAyum864ZsqvRFFzzZX6MZDRiwpPfpSoSOAU6htaU=;
        b=HNjxdorYxYxUKMfD9lktj4vJp2EhVLAmSzIwtorhRm7FXVIzIsk3yZuw8Poyx1UQ+a
         VW4VJRM+wwCdGfYS28mjNcxk/WfDOxlz+6VHLzPzcY6th2pV4lutnIj7vtp1O242VvRe
         eS7c5KD05cYAebqNdilKAcjFX4vxISH3A0hIMmnlBEGl5aYQ+QZTGdF6ZSvmw/LboU5Y
         zexjdmKTpV3Ln6qEoXdifC76+gkMKM/hgVj0G4SSSK0xQyx4JBAgzYgKtipx0XFKgSdi
         k0jKWR2kkodXovqAcntpQWfjGKcQtexQue5QTKJFDuuEo0L+rck9F/SQsHphBqBAhHPV
         r1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbhAyum864ZsqvRFFzzZX6MZDRiwpPfpSoSOAU6htaU=;
        b=qIIP8m/0uDAFurk61x7DPcamhtlfDiNt1OEm8UCmL5Zq0Pt+z8wMT6aKKD/hhfocPE
         hFT/6ntDNo5NUhOtRqmFn4GlaDWmrtj+fPc4zCxPD3O03JEC+NzKbmQS1yuRyJ1KpNDU
         Z9jaTqnT3heSFUzaABXqzEzgJ4ssPVUtVv73yo1OqFr/n6SzEU6W/ShV51gNonMZ9OFN
         1NL+Fm/9LrsGKvdqcfJNcGY/VM92XV5LK/yGHOdlhDQXULJ94f46UBghTQEglBDPNNEO
         8E5hKcagiTo44upntvH2kM5rWYTDWCmf7eY/w3c7eFL5T86nOID4aaPmKq95lBlGA1LI
         480w==
X-Gm-Message-State: AJIora/0HAnJVovwG/mf79okT1VIkbmxciKkmEDP1FRwUuxokEXWvnVi
        5x2TcTeZIxK/w0l4CuY+6byrlYUM+w/aMFQmVW7PsyS1
X-Google-Smtp-Source: AGRyM1tqIixeN8yeh6EOjkIU/JSf0arGAQjp23g98UYabKPnK5PY+8Gi0M1SoNRQXHmOzk1upOkmza3jPh0g+n7s6Ic=
X-Received: by 2002:aa7:c9d3:0:b0:43a:67b9:6eea with SMTP id
 i19-20020aa7c9d3000000b0043a67b96eeamr44770045edt.94.1658253265197; Tue, 19
 Jul 2022 10:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ+/dAA195d99ak@kili> <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
 <20220719175048.GC2316@kadam>
In-Reply-To: <20220719175048.GC2316@kadam>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Jul 2022 10:54:13 -0700
Message-ID: <CAADnVQ+5rZv4ZeuXuMwiXBmnPkbM4qXTx3-otheErDY971kgfA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-janitors@vger.kernel.org
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

On Tue, Jul 19, 2022 at 10:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jul 19, 2022 at 10:19:02AM -0700, Martin KaFai Lau wrote:
> > > @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
> > >     size_t str_len = strlen(str);
> > >     size_t sfx_len = strlen(sfx);
> > >
> > > -   if (sfx_len <= str_len)
> > > -           return strcmp(str + str_len - sfx_len, sfx);
> > > -   return false;
> > > +   if (sfx_len > str_len)
> > > +           return false;
> > > +   return strcmp(str + str_len - sfx_len, sfx) == 0;
> > Please tag the subject with "bpf" next time.
>
> I always work against linux-next.  Would it help if I put that in the
> subject?
>
> Otherwise I don't have a way to figure this stuff out.  I kind of know
> networking tree but not 100% and that is a massive pain in the butt.
> Until there is an automated way that then those kind of requests are
> not reasonable.

Dan,

you were told multiple times to follow the rules.
bpf patches should target bpf of bpf-next trees only.
If you send against linux-next you're taking a random chance
that they will pass CI.
In turn making everyone waste time.
Please follow the simple rules.
