Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EC50ABD9
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441864AbiDUXNU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 19:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379294AbiDUXNT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 19:13:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691C49CA1
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 16:10:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so11332497lfb.0
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k9JybJT2MUROhf8pXoPS8XkN0ZGy3V7ewjH68Jql+aU=;
        b=VhYyTtKdaoYxY+fMOA+egYbT4WrtkmFjY76dbsxzRSWoHTG/cSVc24ZCYgchDZSOz1
         MsijtCP0I6WMYg7UTTPiFMnRrpN5SQ+bpWkwoVvUM6FEDJ0ZxJlNVJS9Vyyk5H+kkyqH
         buc9rlIV/CBil6cdYtZs910FWMSW20lCdOP2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k9JybJT2MUROhf8pXoPS8XkN0ZGy3V7ewjH68Jql+aU=;
        b=HGbT8UlZXkEDgL/gS+n/8sjgKPcvOfzGAYAEX9rKoy8RhxhG/7goqjfDnAjICZMjZh
         JXs/OLuJkPNPTCO2cmA7RyCjBfvATns1XueizMndRa9Y4gRZdnwxMhE/e7370e9fbcnn
         yeJ9YhZCqn5bCftf3SDcUKVPjJEMRCAy6lKbOsBGjJLDyc/7CLXnnwlITTt3N+FFWL3Y
         UcRJIt9DzDJG9aOTTM/+z9uBkEJPREjNGrYc2oofurU+S5iu7P0YFIdr7szOCyQ7+XK6
         BThUjkHc6LESTaPKcE7Z/QFAKPpp+BtDqRR4ZoUwt7wVS4YjpHC3bRjjIUt6n6la12Xc
         4PuQ==
X-Gm-Message-State: AOAM532Eulh8/JUCdJg0u/MyjF9yRiiNGOKzoLqjS47oO8sj877pxt7j
        YD2NnNThdf0lsWYWOv5dEzzSX868KcDhrn0la2o=
X-Google-Smtp-Source: ABdhPJzBE51J0FGzRHtcaEE1Ap608VJz+n7s0wbotTdHnkTAg0yzD8SAFmgNMKA8Q3mHn8ygSkTZxA==
X-Received: by 2002:a05:6512:22c8:b0:471:a3dd:9e3b with SMTP id g8-20020a05651222c800b00471a3dd9e3bmr1174797lfu.308.1650582626749;
        Thu, 21 Apr 2022 16:10:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e1-20020a196741000000b0046bc4be1d60sm39037lfj.123.2022.04.21.16.10.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 16:10:24 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x17so11257299lfa.10
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 16:10:23 -0700 (PDT)
X-Received: by 2002:a05:6512:108b:b0:470:90b9:fb51 with SMTP id
 j11-20020a056512108b00b0047090b9fb51mr1151040lfg.52.1650582623375; Thu, 21
 Apr 2022 16:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com> <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
 <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
In-Reply-To: <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 16:10:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
Message-ID: <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 3:52 PM Song Liu <songliubraving@fb.com> wrote:
>
> I think this won=E2=80=99t work, as set_memory_ro makes all the aliases o=
f
> these pages read only.

Argh. I thought we only did that for the whole memory type thing
(history: nasty machine checks possible on some hardware if you mix
memory types for the same physical page with virtual mappings), but if
we do it for RO too, then yeah.

It's sad to use that horrid machinery for basically non-live code, but
whatever.

                  Linus
