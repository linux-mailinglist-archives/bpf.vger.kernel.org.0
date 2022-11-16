Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10A62CED4
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKPXiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiKPXiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 18:38:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38A68697
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:38:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y203so107580pfb.4
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkI37tcGPXnSohqzPYqOvLxVUhk0tF8PkG0dnR+tY88=;
        b=DZGEtK0uqpUGwDQxJ8aBT1LhjQ+dGtH9BBD0IRwZjyicRBwuM1YZurnRzoH7oIOWYB
         bygqhrdj4lNLSg069hxydAkEkfwBa3pyS9C3aZKN+PgDMzP0knt6b8lkzr3hJsO/+Qdr
         EAkH2rSi3eaLdj9BDgli9G8ovfkskBUYQZtE5Ii14WTovFEmKLcAqqklamkBNGxBucCv
         89vvZKce2qWr0Hgwp11v1ihmgzKp0dqTrO8RVqCjzH9JM00NPpg5DRcMqpJvm0Buf2Nq
         ffZqjKZqNmXJosExJvIWcjGsVnjA5hk/dkvSLYkddWdkGlYH+4A/6fA3i/AxZCDqBrv4
         l/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkI37tcGPXnSohqzPYqOvLxVUhk0tF8PkG0dnR+tY88=;
        b=e1EG09Ivf6Ddq2zrgZbDhgn9nnmaX1wan3+Qt8XTzVET2GeUP9+Bet/4BPVc05yoE9
         7RxZdgaTdJMj1q/t+bqu1H9GZk5adNWoJtYxs5Qj2oYffE90tmyd9aoBaa2WrpgD6gJg
         WCQYhTwPmi0BxBzpT10ZIb8qk9dBxLpfoswvs1ErVGOcrEQ+Hgrb/xucIx7T1BS35ykq
         WFDqcuyM5VbCUbaeIxFoVzOEWuwBFTBZ4rXjfOWQFNXKfq10AXAb8qLPwqXryJjNOjvF
         hXdoFnpNiOWRXhA9JSsXPzHXDq4diYQnl8oIbu8qDv1q10QJ063EGiwz3HEqGE3aPYtE
         8oGQ==
X-Gm-Message-State: ANoB5pklFLdUXWzJuSfN7o44o65nUcBAVt14j4ymKP0G2B1uAuDlWxDf
        QaubUI99XsacTuwqZ/PS94I=
X-Google-Smtp-Source: AA0mqf7xBHSB/hdB+tBE1orNllG87IZ004U1RLzj2KxgrtRiWyz5xo0ZA231t92zWNFzo9BMrJiiBA==
X-Received: by 2002:a63:e401:0:b0:476:c65c:3761 with SMTP id a1-20020a63e401000000b00476c65c3761mr8228343pgi.57.1668641897423;
        Wed, 16 Nov 2022 15:38:17 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b0017a018221e2sm12779890plb.70.2022.11.16.15.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 15:38:16 -0800 (PST)
Message-ID: <d9dbf747-da63-0fbd-66d2-e5107faf58b4@gmail.com>
Date:   Thu, 17 Nov 2022 08:38:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next] bpf/docs: Include blank lines between bullet
 points in bpf_devel_QA.rst
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
References: <20221116174358.2744613-1-deso@posteo.net>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221116174358.2744613-1-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Wed, 16 Nov 2022 17:43:58 +0000, Daniel M=C3=BCller wrote:
> Commit 26a9b433cf08 ("bpf/docs: Document how to run CI without patch
> submission") caused a warning to be generated when compiling the
> documentation:
>  > bpf_devel_QA.rst:55: WARNING: Unexpected indentation.
>  > bpf_devel_QA.rst:56: WARNING: Block quote ends without a blank line
>=20
> This change fixes the problem by inserting the required blank lines.
>=20
> Fixes: 26a9b433cf08 ("bpf/docs: Document how to run CI without patch su=
bmission")
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf=
_devel_QA.rst
> index 08572c7..03d499 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -51,10 +51,13 @@ While GitHub also provides a CLI that can be used t=
o accomplish the same
>  results, here we focus on the UI based workflow.
> =20
>  The following steps lay out how to start a CI run for your patches:
> +
>  - Create a fork of the aforementioned repository in your own account (=
one time
>    action)
> +
To be clear, as is mentioned in the reST documentation (quoted below):

  - This is the first bullet list item.  The blank line above the
    first list item is required; blank lines between list items
    (such as below this paragraph) are optional.

, this and next blank lines are not required but optional.

Either way,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>  - Clone the fork locally, check out a new branch tracking either the b=
pf-next
>    or bpf branch, and apply your to-be-tested patches on top of it
> +
>  - Push the local branch to your fork and create a pull request against=

>    kernel-patches/bpf's bpf-next_base or bpf_base branch, respectively
> =20
