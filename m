Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E269D743
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 00:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjBTXmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 18:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTXmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 18:42:45 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD041E1E1
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 15:42:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h32so10662317eda.2
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MepyRHlfykWJcIID9I9np5BfjPwEUVeeHLNS+geqWjM=;
        b=BjwLNazQ45KljbKlUGpOIO+Msjg01UlbFLD63y2zkl6snEDBNZWD6gvqguy75TuX3y
         V2WQq++Ch1XJlD1JQ9jc4TG+ickFAUqg/gOpUKlQiN7+c+gbvzVsF0IsqpmrrEKvMmWs
         ndN+ZYoHhkz9f2qaCq/nC6GM59apv7t9UznlsnO+hBCmclSFVhasyfjlSt7qrWv3LexJ
         Uy7Sj+h/0rUNLBcxdt5l5nGatCsPr0uyZ1GFNQc5yACbmrclTANMk/uhqBlizFuQsBJD
         OqfOwHPclgog2DRt+JktTX6xGRC6534kNHt3MgE7xWQiWSOttLXHv5SlTW71On4IJMov
         GW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MepyRHlfykWJcIID9I9np5BfjPwEUVeeHLNS+geqWjM=;
        b=uEBvUMqew3oxPDXHwygcdfJWMMnnVj4NqLCwIEHHw50vVQPKaPWIXnG267+NZfsib2
         B2F23aA9Pmi6Xl/ok5WMaGl8C3UHDVHoo8nnSqfmpRUnr5R/Q2uVmYgdywA56atdLdji
         EWIPdVCAF4NRmDEf1ftn+lv4JGFLSOLRDVqhReMr6AJh0hhKnu3qseMbA4fmyoR00AYK
         w3f4zRiKfUVV+nZ+uZ/qjX9KdboNSPKFbLZn1dknaX2fxFxfWF1uSwpl4XgJTZO9mPqV
         zzmahpwWIb3Ic/R0DW3AbOqq5cuvm+iyt2zqw+qHDbq94QC+pvHrvhlc3n0+dZ4lIkjk
         /PJQ==
X-Gm-Message-State: AO0yUKUA8mSBgXcvRagdjudKW1iTtvAweaOMuiHKQyamicyAIne8Sep2
        GV3A6mdO+VPgUOROdInmTl4=
X-Google-Smtp-Source: AK7set/gBEzq8QBsaSsKbwVSFAwUkWFh4BalwcVlftFaMTyK22RysvHE26FQGB3us1gOE6lMCBMP5w==
X-Received: by 2002:a05:6402:5299:b0:4a1:e4fa:7db2 with SMTP id en25-20020a056402529900b004a1e4fa7db2mr3944743edb.17.1676936562409;
        Mon, 20 Feb 2023 15:42:42 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a508755000000b004acc02d1531sm1434986edv.14.2023.02.20.15.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 15:42:41 -0800 (PST)
Message-ID: <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        acme@redhat.com, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Date:   Tue, 21 Feb 2023 01:42:40 +0200
In-Reply-To: <877cy0j0kt.fsf@oracle.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-01-05 at 19:30 +0100, Jose E. Marchesi wrote:
> We agreed in the meeting to implement Solution 2 below in both GCC and
> clang.
>=20
> The DW_TAG_LLVM_annotation DIE number will be changed in order to make
> it possible for pahole to handle the current tags.  The number of the
> new tag will be shared by both GCC and clang.
>=20
> Thanks everyone for the feedback.
>=20
[...]

Hi Jose, David,

Recently I've been working on implementation of the agreed btf_type_tag
encoding scheme for clang [1] and pahole [2]. While working on this, I came
to a conclusion that instead of introducing new DWARF tag (0x6001) we can
reuse the same tag (0x6000), but have a different DW_AT_name field:
"btf_type_tag:v2" instead of "btf_type_tag".

For example, the following C code:

    struct st {
      int __attribute__((btf_type_tag("a"))) a;
    } g;

Produces the following DWARF when [1] is used:

0x00000029:   DW_TAG_structure_type
                DW_AT_name      ("st")
                ...

0x0000002e:     DW_TAG_member
                  DW_AT_name    ("a")
                  DW_AT_type    (0x00000038 "int")
                ...

0x00000038:   DW_TAG_base_type
                DW_AT_name      ("int")
                ...

0x0000003c:     DW_TAG_LLVM_annotation
                  DW_AT_name    ("btf_type_tag:v2")
                  DW_AT_const_value     ("a")

I think that this is a tad better than abandoning 0x6000 tag because of
two reasons:
- tag numbers are a limited resource;
- might simplify discussion with upstream.

(It also makes some implementation details a bit simpler, but this is not
 very significant).

What do you think?

Both [1] and [2] are in a workable state, but [2] lacks support for
subroutine types and "void *" for now. If you are onboard with this change
I'll proceed with finalizing [1] and [2]. (Also, ":v2" suffix might be not
the best, I'm open to naming suggestions).

As a somewhat orthogonal question, would it be possible for you to use the
same 0x6000 tag on GCC side? I looked at master branch of [3] but can't
find any mentions of btf_type_tag.

Thanks,
Eduard

[1] https://reviews.llvm.org/D143967
[2] https://github.com/eddyz87/dwarves/tree/btf-type-tag-v2
[3] git://gcc.gnu.org/git/gcc.git
