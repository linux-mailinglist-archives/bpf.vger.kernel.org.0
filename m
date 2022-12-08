Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874FF647A4B
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHXqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLHXqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:46:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E160C4
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:46:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so2460274pgc.0
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6eq3qVqvQa6a4DnGmG8Wa/pErkcr+JiA2KWwUdGIB4=;
        b=Dof5R32NxDjfCPkvDtsQsnwcDGtJEcCtLAO/d+sZEmis0wCMh6WLMP3oE6yLqiY3L1
         3Yuz9C7Yy7Fq6Ue2NfarLL7dW2yMx4bY93tfDOeYRSzONeaAqfprST6gcM/K6t9cmLiu
         YBJOFL1EsyxwNDjC2RzH9VorQipA1J7qyNcqSBuHWE1O1SpU6KtfgfV86CABddx1bwQq
         87Ib1OgpKRWg6892EJbb4XOCw7pMSCAc6HGk80MJHws+x+bfj/svI5KyqN0ZhZt/zmQj
         j/hA1j1ImRlIcVCnqv3CPcAB7uBiI8qE6Rqd2cIqW3fMnEM8Ab0ik5YV8DkW+PN/gyDo
         sTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6eq3qVqvQa6a4DnGmG8Wa/pErkcr+JiA2KWwUdGIB4=;
        b=OE60FRb05tBP5duaaCDumGXhoa/PvvUDKftJduX2VV1PuYyYNikAHqBUQ6V3aZL/ok
         T94z/JHaEfHTwKV4pNPu9SFBkfhtsKHeIpQhjzDzwlxqg8S1MUJl0DhZwAPkDZKCweAg
         /Ngc7CHXQI5YriETKaaMIWBEPf7uolAQ8PivByXOlIsQERg0LAiEMKtvU418EWhJwlJQ
         dKVBM1qaTJaRvHLNS02aaD53UZtig76Ewcxl3wqt8iwHG0t14I5D9T2cv8Y80Hp2inEz
         kZ/ElJpRk7PQ30FntUrUKTyKOUS8S6H3hnVQWcJ37AhckALugA1uDN90VmVvZWhsGSUV
         MwFg==
X-Gm-Message-State: ANoB5pnwoJX/MCZlbBT7TGox+Ood09BacU1NF/83XExW0aBobfbrPDaF
        cYcSCS5wxCi3qp+vOCG0hHtk9CeBN+dc1VPQlDiNIQ==
X-Google-Smtp-Source: AA0mqf68EfiXKzh4Qqsn45VAM2KqCRu9H5SQS0jk5yiyZhZc9LribcXnYNomw9PrYLODWclkAlvlqykAQZgVL7MVIGk=
X-Received: by 2002:a63:2160:0:b0:46f:f26e:e8ba with SMTP id
 s32-20020a632160000000b0046ff26ee8bamr71514626pgm.250.1670543169691; Thu, 08
 Dec 2022 15:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20221206024554.3826186-1-sdf@google.com> <20221206024554.3826186-12-sdf@google.com>
 <875yellcx6.fsf@toke.dk>
In-Reply-To: <875yellcx6.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 8 Dec 2022 15:45:58 -0800
Message-ID: <CAKH8qBv7nWdknuf3ap_ekpAhMgvtmoJhZ3-HRuL8Wv70SBWMSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/12] mlx5: Support RX XDP metadata
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 8, 2022 at 2:59 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> > Support RX hash and timestamp metadata kfuncs. We need to pass in the c=
qe
> > pointer to the mlx5e_skb_from* functions so it can be retrieved from th=
e
> > XDP ctx to do this.
>
> So I finally managed to get enough ducks in row to actually benchmark
> this. With the caveat that I suddenly can't get the timestamp support to
> work (it was working in an earlier version, but now
> timestamp_supported() just returns false). I'm not sure if this is an
> issue with the enablement patch, or if I just haven't gotten the
> hardware configured properly. I'll investigate some more, but figured
> I'd post these results now:
>
> Baseline XDP_DROP:         25,678,262 pps / 38.94 ns/pkt
> XDP_DROP + read metadata:  23,924,109 pps / 41.80 ns/pkt
> Overhead:                   1,754,153 pps /  2.86 ns/pkt
>
> As per the above, this is with calling three kfuncs/pkt
> (metadata_supported(), rx_hash_supported() and rx_hash()). So that's
> ~0.95 ns per function call, which is a bit less, but not far off from
> the ~1.2 ns that I'm used to. The tests where I accidentally called the
> default kfuncs cut off ~1.3 ns for one less kfunc call, so it's
> definitely in that ballpark.
>
> I'm not doing anything with the data, just reading it into an on-stack
> buffer, so this is the smallest possible delta from just getting the
> data out of the driver. I did confirm that the call instructions are
> still in the BPF program bytecode when it's dumped back out from the
> kernel.
>
> -Toke
>

Oh, that's great, thanks for running the numbers! Will definitely
reference them in v4!
Presumably, we should be able to at least unroll most of the
_supported callbacks if we want, they should be relatively easy; but
the numbers look fine as is?
