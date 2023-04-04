Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A66D57CF
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjDDE5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjDDE5b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:57:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF11BCB
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:57:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fi11so2128465edb.10
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680584248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFpQxJL5F85+tfRg3cpGv5GNp5xzIPlkZxBx4tEC+yU=;
        b=oxP7cnKvpvIlp2oQsvrVMVCfQx02usKuT7WSF5CgB6JWj+0BXzAbk/3huBZEGX14Uw
         Ll3RfIVEvcUllM3UVZNFV00GWKRyBPHtxdzU+tQnznq0s/xSIqwGe1WHhOZLXcsreWT0
         H480L6Bq2mRKdSuTHqikC3uWe4WBogsQKkxc/EnEz6op8/d4hf/VYafaO9PgczVRnkyV
         Jye+bmyEpDYsda8eTvYep+Nbiyv3imu9m6oDOteSGdY1zY/Y/36+4KZ9ARFLHTPvo2QF
         7aLgHBIJhaUsUt4RzFiTZFPruJAIQIsn1iLHR4KRfWTovOQl722jzmbuKTs4P0cof7+1
         QAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680584248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFpQxJL5F85+tfRg3cpGv5GNp5xzIPlkZxBx4tEC+yU=;
        b=epR2P+mddUGG1W/Lk9GZus3eKNs2sLjPEyJpT8dJeVPEqEDlaImoVZlGsISi/LaXGg
         ocRDLI5Ht/GtJh0XrTbk7oNDkVQJAIMjsF29MYvdfsQslCbb5lo3oUK3qYEw774Wpd3I
         RkUrbgm9gMSbvmycfA6z3qwPFQ3khEN/QEAdHkbH7dJQRKRR2MMHb7eQ3QI0ziIZXWpg
         a+hJUvdEdqjPKLNEVY6MJek0yAT7kUlUj0fgDAqbzH3D6YznAAyTWc5kqBlSzUW57Csz
         H0hgaDcEKSonrLJihzZ0u7XfVS19lgYSUY6GRp6A3Ngs29wUfkzVFXEVrVcCLgVg+sYl
         tH+A==
X-Gm-Message-State: AAQBX9cnBXUI7rThzqmW1La7kcjpEur4PXrTjA9Gb9rV+XQOJUwlsw0f
        Xepx93koJns7BBn8AEDcSOObwkXGJPe41zih5d4=
X-Google-Smtp-Source: AKy350YlMY1OsCKPh85rgxnA9+RrjFTPIvfJr9bZDZQiqbc8gVHJ9wl1DBkdY1+HTUSt6jvR9MTglqcr+1sF+rjeroc=
X-Received: by 2002:a17:907:6eac:b0:947:9d85:30c9 with SMTP id
 sh44-20020a1709076eac00b009479d8530c9mr7034406ejc.5.1680584248001; Mon, 03
 Apr 2023 21:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
In-Reply-To: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 3 Apr 2023 21:57:16 -0700
Message-ID: <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 3, 2023 at 6:28=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> For Fuse-BPF, I need to access strings and blocks of data in a bpf
> context. In the initial patch set for Fuse-BPF [1] I was using
> PTR_TO_PACKETs as a stand in for buffers of unknown size. That used
> start and end pointers to give the verifier the ability to statically
> check bounds. I'm currently attempting to switch this over to using
> dynptrs for buffers of variable length, but have run into some issues.
>
> So far as I can tell, while a dynptr can have a variable size, any
> time you interact with a dynptr, you need to already know how large it
> is. For instance, bpf_dynptr_read reads the dynptr into a local
> buffer. However, that buffer may not be larger than the dynptr you're
> reading. That seems pretty counter intuitive to me.
> bpf_dynptr_check_off_len ensures that the length passed in is not
> longer than the dynptr. This means I can't, for example, have a buffer
> that could support NAME_MAX characters, and read a dynptr into it. I
> assume this is to ensure that the entirety of the buffer is
> initialized. If that's the case, I could create a variant that zeroes
> out the remaining buffer area.

you are right, we should probably fix this logic to allow to fill up
min(<dynptr size>, <fixed buf size>) bytes of provided fixed-sized
buffers. Zero-filling at the end is an option, but I'm not sure we
have to do it (e.g., bpf_probe_read_str() variants don't zero fill, I
think).

>
> One workaround I've considered is attempting to read to the minimum
> length of string I'm comparing against, treating read failures as a
> nonmatching string. Then I could read any additional space for larger
> comparisons afterwards. This would mean one call to dynptr_read for
> every string length I'm checking against.
>
> The bpf_dynptr_slice(_rdrw) functions looks nearly like what I want,
> but require a buffer that will be unused for local dynptrs.
> bpf_dynptr_data rejects readonly dynptrs, so is not a suitable
> replacement. It seems like I could really use either a
> bpf_dynptr_data_rdonly helper, or a similar kfunc, though I suspect
> the kfunc will require some additions to the special_kfunc_set.

bpf_dynptr_slice(_rdwr) is basically the same as bpf_dynptr_data() and
bpf_dynptr_read() as far as fixed length of read/accessible memory
goes, so I don't think it gives you anything new, tbh.

>
> One alternative I'm looking into is providing kfuncs that perform the
> requested operations. That allows checks to happen at runtime.
> However, I'm having some difficulties working with strings as kfunc
> arguments. There is an existing helper function bpf_strncmp, which
> uses one constant argument which ends up interpreted as a
> PTR_TO_MAP_VALUE. To make a kfunc, I assume I'd need to add another
> special kfunc and then adjust the expected types.

I think we need something like bpf_dynptr_strncmp(), which would take
two dynptrs, one for each string you'd like to compare.

But in general, when you say "I need to access strings and blocks of
data " above, what exact operations do you need to do on them? strncmp
is one of them, anything else?

Note, Joanne is working on another dynptr-related patch set that adds
bpf_dynptr_clone()+bpf_dynptr_trim()+bpf_dynptr_advance(), which
allows to create temporary smaller views into other dynptrs, which
will make dynptr a universal "memory view" mechanism. So designing
APIs with assumption that dynptr is describing a smaller portion of a
bigger variable-sized memory is on the table with that.

>
> Any of these solutions that use fixed sizes ignore cases where I may
> need to compare two strings, neither of which is a constant string
> known at compile time.
> How should I go about using possibly read-only dynptrs whose lengths
> are only known at runtime?
>
> [1] https://lore.kernel.org/bpf/20220926231822.994383-1-drosen@google.com=
/
>
>
> -Daniel
