Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2685A3C88
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiH1HiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiH1HiP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 03:38:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2DC31ECE;
        Sun, 28 Aug 2022 00:38:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h1so2821384wmd.3;
        Sun, 28 Aug 2022 00:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=bOE6005oxr+Ohk6w7ei+lrrxu0l9CG5bgnHEoMaw9cg=;
        b=mC/ozyIH4Msb6uQSNnPKtU6RLwmcOhFTWZFZGDoObVIAMfb1IoD1RI5vto0b+lLh0d
         CKvSJYj/3qjoFv0Buofb4mP6GIIVJl9IhyasUJidU6dzlaM0EyIQD0SmmX/FEs3GGApv
         6nC2/lTunfIAgJ7i3QMQi5QHKujIFTRSQc3FxJZQX9uqdeP6+yhevH5cEQH78R6XgoTG
         wtHoJiZBeze+J5d/dAogg6RrJMvUcbXD3D7xP5APrgsBTq547Ifp/QFSA19U8dOY1i1E
         2ZbVrXujcywuceRmS3efzy7OjhCqSTHvGPTVfUZ7PRAAROPgZUk56nNa6KXiUAPAVbSa
         xrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=bOE6005oxr+Ohk6w7ei+lrrxu0l9CG5bgnHEoMaw9cg=;
        b=22C7BLzOwmUQWcCIBAl7809Jtxf2pm27KerrUfEt9bL4VzxnFz9NQmCj596mP4tw2N
         K6qhvKU2luHZyiAFxAnaefrQENvRWWLG5/XC4/mpicvgEh/3Zmsvebaoo1x2BL/ETYly
         tEhYuEcRSPYWWA/r/7m7VWXNEX1BkKTO2KYdaRH1XtCmCVDz8JokoR2sk32TAe3MRlWN
         +Q1kG2q7pSL6VQifjgnuGHIHqMahc2XZpcU5COogwBkcv23Jw57KdPJfMQrzjV4o3Wv5
         4LZL34zJVEZtWet/m/m7BYqOJFGjMyGSlzzsva7Epax9+n85m+eNKCqrBHA2Q3ynjYFj
         ZLPw==
X-Gm-Message-State: ACgBeo2i5k66J3ch93x2yoaKgJ8PLuQS/lYwQ6ZRGceiTAh6rdnCmXBn
        /UnxmU6B7WzWE09N6vGRbnrFTmhB0ZQvcg==
X-Google-Smtp-Source: AA6agR6186mg/NFmi4ts5fe7lLYE+NB5uBxuPVUo8O0ktlFRUi0+BDKcZcW8TeihM2FZYAkagOwLxg==
X-Received: by 2002:a1c:f709:0:b0:3a6:3452:fcbe with SMTP id v9-20020a1cf709000000b003a63452fcbemr3925210wmh.164.1661672292745;
        Sun, 28 Aug 2022 00:38:12 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d58f0000000b0021e42e7c7dbsm3918271wrd.83.2022.08.28.00.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 00:38:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 28 Aug 2022 09:38:09 +0200
To:     Martin Reboredo <yakoyoku@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luna Jernberg <droidbittin@gmail.com>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Message-ID: <YwsbYX3g5dvaRABt@krava>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <CADo9pHhW9w+ciNbQr+7u4mezuQ1USyh0k2Wshy=wkdEcxRiDLA@mail.gmail.com>
 <YwY2mFuJP10dehRx@kernel.org>
 <CADo9pHheRprMRAZkcxcALRv7gi8r+_CpNBP+LB4rt0n-_ZMQ4Q@mail.gmail.com>
 <YwY3qEa2gFsPg2jz@kernel.org>
 <CADo9pHhcw2+WEYfD=hJ-o67fw9Uf+ERS8xo2SHApNQgPwGCmBA@mail.gmail.com>
 <538ebda0-0f8a-ebae-f02f-c8f8736ca12b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538ebda0-0f8a-ebae-f02f-c8f8736ca12b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 07:50:39PM -0300, Martin Reboredo wrote:
> On 8/24/22 11:38, Luna Jernberg wrote:
> > https://forum.endeavouros.com/t/failed-to-start-load-kernel-modules-on-boot-after-system-update-nvidia/30584/17?u=sradjoker
> > 
> > On 8/24/22, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >> Em Wed, Aug 24, 2022 at 04:36:18PM +0200, Luna Jernberg escreveu:

SNIP

> 
> Can you try a build of the kernel or the by passing the
> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?

Martin,
could you please send formal patch this?

thanks,
jirka

> 
> Here's a patch for either in tree scripts/pahole-flags.sh or
> /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a528..1f1f1d397c399a 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,9 @@ fi
>  if [ "${pahole_ver}" -ge "122" ]; then
>  	extra_paholeopt="${extra_paholeopt} -j"
>  fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +	# see PAHOLE_HAS_LANG_EXCLUDE
> +	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
> +fi
> 
>  echo ${extra_paholeopt}
> 
> - Martin Rodriguez Reboredo
