Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE26F62B71B
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 11:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiKPKBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 05:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPKBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 05:01:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582CC25
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 02:01:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so3415393pjt.0
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhEjiJsoEOXpxENIp6z3TFp2bIpyRC5OO1bha+ctUmk=;
        b=MycyDn/5Mj+0NhIqu+6VdTXkqnfzRkLETzc12hxmDLaM4FP1RAHunlpvxJvrKL40No
         s4c5dmnhJ0bJ2ljxw5JxDlN6GWEl2zbaPDzpE/VF79ygpxpEfygsll0zq4LP6PmChRDg
         GdKtBhAedHhBxa60qCyV9mbAQvTuWBAKWdq7GrnBCYapTZx9vUMK0OkrZMVmqw60Fio1
         B1aIGBTREkC5qnT5b+1yajW8zOK/xamD2dUAe3T0GcKa3gtXKimacmxyp013jMdSHe5J
         CjoKNbEiRLXL5yr/cbh4cm6uJo9vLRpHDbOuXKMUVDK59ALe4nzii1bB4YkqipLxM2kc
         YnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhEjiJsoEOXpxENIp6z3TFp2bIpyRC5OO1bha+ctUmk=;
        b=WNV8t6MwLSN2XV5tfk5zDBkg54BrKMxz4wID40OqOSiYCcTyRs0bly2KFz0uXbD/Bv
         D74u+NSHrgG+vlcuboQr5Ai3/t3L+2JWNd1zY5bOubVLLlBKY31tQZ6MX1D1XW4H8hB3
         tvzkXgG63umHr5Iti5VaLWm/3BkZOFJ85XyH9CZuZ/TN5ThrUKtEbHrQj3goqknIBFcO
         02SJ8lc3XsWmRvcf/gkykA5oaqvRDlkj9wD9zZmwzrK6X8xz0lj31LuOZvLYgEbP67he
         H3XlnV89OIWKeWHqa/JVZG/K+ytKAsy9rqC66eW8dILdEruqywkw67uJdEmZNnUBuxsf
         ogrg==
X-Gm-Message-State: ANoB5pmlF8U7f3nLB9h6l6tkubxdTYQrF7RlMaB+Mzzl3i5uFWdNBU4q
        YBo25CeWE1hkrpXPcWnXqKE=
X-Google-Smtp-Source: AA0mqf5tF3gy2UjJwaASTQFKFRExzfsl3Q2AZbjVJzNtH8T9ITUNBYgkVl02STRDlrYA2ZPVomZosg==
X-Received: by 2002:a17:90a:d502:b0:218:37b0:d621 with SMTP id t2-20020a17090ad50200b0021837b0d621mr3077935pju.6.1668592883693;
        Wed, 16 Nov 2022 02:01:23 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g6-20020a632006000000b004388ba7e5a9sm9131224pgg.49.2022.11.16.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:01:23 -0800 (PST)
Message-ID: <52151d09-92c5-f6cb-c426-f36ee0c44282@gmail.com>
Date:   Wed, 16 Nov 2022 19:01:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, kafai@fb.com,
        kernel-team@fb.com, quentin@isovalent.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221114211501.2068684-1-deso@posteo.net>
Subject: Re: [PATCH bpf-next] docs/bpf: Document how to run CI without patch
 submission
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221114211501.2068684-1-deso@posteo.net>
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

I know this has already been applied, but am seeing new warning msgs
from "make htmldocs" due to this change. Please see inline comment
below.

On Mon, 14 Nov 2022 21:15:01 +0000, Daniel M=C3=BCller wrote:
> This change documents the process for running the BPF CI before
> submitting a patch to the upstream mailing list, similar to what happen=
s
> if a patch is send to bpf@vger.kernel.org: it builds kernel and
> selftests and runs the latter on different architecture (but it notably=

> does not cover stylistic checks such as cover letter verification).
> Running BPF CI this way can help achieve better test coverage ahead of
> patch submission than merely running locally (say, using
> tools/testing/selftests/bpf/vmtest.sh), as additional architectures may=

> be covered as well.
>=20
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf=
_devel_QA.rst
> index 761474..08572c7 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -44,6 +44,30 @@ is a guarantee that the reported issue will be overl=
ooked.**
>  Submitting patches
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +Q: How do I run BPF CI on my changes before sending them out for revie=
w?
> +----------------------------------------------------------------------=
--
> +A: BPF CI is GitHub based and hosted at https://github.com/kernel-patc=
hes/bpf.
> +While GitHub also provides a CLI that can be used to accomplish the sa=
me
> +results, here we focus on the UI based workflow.
> +
> +The following steps lay out how to start a CI run for your patches:

Lack of a blank line here results in warning msgs from "make htmldocs":

/linux/Documentation/bpf/bpf_devel_QA.rst:55: ERROR: Unexpected indentati=
on.
/linux/Documentation/bpf/bpf_devel_QA.rst:56: WARNING: Block quote ends w=
ithout a blank line; unexpected unindent.

Can you please fix it?

For your reference, here is a link to reST documentation on bullet lists:=


    https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bu=
llet-lists

        Thanks, Akira

> +- Create a fork of the aforementioned repository in your own account (=
one time
> +  action)
> +- Clone the fork locally, check out a new branch tracking either the b=
pf-next
> +  or bpf branch, and apply your to-be-tested patches on top of it
> +- Push the local branch to your fork and create a pull request against=

> +  kernel-patches/bpf's bpf-next_base or bpf_base branch, respectively
> +
[...]
