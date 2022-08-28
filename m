Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152975A3EB3
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH1RBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH1RBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 13:01:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A92870B;
        Sun, 28 Aug 2022 10:01:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id og21so11563858ejc.2;
        Sun, 28 Aug 2022 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=I82QXomtImz0v3LtMkfEZ6Cz0zXgW/iwVN1tJ8E+Xw8=;
        b=TwaY/bcc20FWlguIBx4z6o0ufaEPX9aQcQHk6417acqqY0BUYpKZz33c9iOAtv1H1i
         hZ5zVvHcnZYyjmBuMUSxP5Bwhkc/Ldftw6RrjdbyOIwoMkFe7QGJ26tDMPAv4uHeRXkh
         l7vzpLvN9iPu1zgooJrrpQdiikWI7tiRzclUVeQUr+S2gmTaCGwpTHT/nmWvlV7tJb8B
         CcJXbKFDsgcbGmQyxoJjgdsg7LAZ1ic7BXiFHgjTuU7vHUHIxEOYWGV41zK5FgP+Bzb4
         f4mrW8b3Gq0SbE0UkC52/NsT0iMCg1K96hmrzgNDx8uzK51X2TDa8sk5hFY+NQWNE0y2
         Fgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=I82QXomtImz0v3LtMkfEZ6Cz0zXgW/iwVN1tJ8E+Xw8=;
        b=q0JOHn8Is4e4Kb8JAHoLC1607aa9FONZZdzlY03nR5a+C6U8hHBbusREnybf6YX+qc
         57vjUe1uOttVf4wjuPsW09a7h/+31iKNH7gSoXD/mTGErbFtzFnu4aryDZGamg+LIbyy
         YnTngzs6o049u7uqXTjyCq52zchfCd3a6vvewH+7vzVMP5lxPFT8RLfLY3ZO+QgJ7yYF
         FDPtgESrvT28UOt7IpENF1DXXldfzpPXaoN/TwTA9gKYPwsqru/fy/vEwMB99IkIOubE
         iDRRJwQCUywGatqvvJeYddU6A/fy4k6LrmzqMgT56aIlQqpfdvyx/OHVeoG7JQSY6EAT
         MO9Q==
X-Gm-Message-State: ACgBeo2UcSMRUw4GxRxbRA8zy3wYVIgnDjYDIuJ8ZtCnVx+JkQWboO02
        AS3WyELmDePVCqOVM4EoKNs=
X-Google-Smtp-Source: AA6agR4nvQ60lGTjoXUtIfvbz5ymDjuX5Q18t3n23YIM7u73nSHKrOtu/Z2/mxbD2NiT1GgDo9jOwA==
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id qa7-20020a170907868700b007307c7bb9cemr10891306ejc.656.1661706107310;
        Sun, 28 Aug 2022 10:01:47 -0700 (PDT)
Received: from krava ([83.240.60.103])
        by smtp.gmail.com with ESMTPSA id t23-20020a05640203d700b00440ced0e117sm4564637edw.58.2022.08.28.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 10:01:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 28 Aug 2022 19:01:44 +0200
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luna Jernberg <droidbittin@gmail.com>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Message-ID: <YwufePAAfJESjOyi@krava>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
 <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
 <YwY3qEa2gFsPg2jz@kernel.org>
 <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
 <538ebda0-0f8a-ebae-f02f-c8f8736ca12b@gmail.com>
 <YwsbYX3g5dvaRABt@krava>
 <b783998f-366b-5643-7347-3cf47269ffc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b783998f-366b-5643-7347-3cf47269ffc8@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 28, 2022 at 11:29:35AM -0300, Martin Rodriguez Reboredo wrote:
> On 8/28/22 04:38, Jiri Olsa wrote:
> > On Wed, Aug 24, 2022 at 07:50:39PM -0300, Martin Reboredo wrote:
> >> On 8/24/22 11:38, Luna Jernberg wrote:
> >>> https://forum.endeavouros.com/t/failed-to-start-load-kernel-modules-on-boot-after-system-update-nvidia/30584/17?u=sradjoker
> >>>
> >>> On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >>>> Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:
> > 
> > SNIP
> > 
> >>
> >> Can you try a build of the kernel or the by passing the
> >> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > 
> > Martin,
> > could you please send formal patch this?
> > 
> > thanks,
> > jirka
> 
> Sure, sure! Though it might take a bit of time due to being my first
> contribution submitted by me (I've already contributed through the Rust
> patches though), I'll add Kconfig entries for this, one for the
> availability to skip the enum64 encoding and another for toggle the
> flag. Stay tuned.

hm, but we actually need that just for 5.15 or whatever stable version
is using latest pahole but does not have support for enum64

please check Documentation/process/stable-kernel-rules.rst

jirka
