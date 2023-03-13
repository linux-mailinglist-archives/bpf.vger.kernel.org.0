Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A26B7F0E
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCMRO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCMROT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 13:14:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18CAC655
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 10:13:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f16so13350477ljq.10
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678727565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nHPExQVVq6iXm0n0BgO9lPEuEcPXx8mZW7Wn/dMWXKo=;
        b=N2NGW9+G0PbfQD8azM/Ojoc5OIQ07poFcxhoruYmP7hUoUQ59Wm49jPBGY/zsUwK9E
         Y7Y2GJR/tC+o/nQWcSOXLTkqBtDXtKR9r76sAxpprYQPKyFx/k33jiCAngV1kSh/G5Bf
         UBbSkn7OkOghZQ11wNtrjuEIryAfiEiQkb5GxS1zgIlyfpZFwvzzr92zWL/z8kTZjt7q
         jqf5Fqp13DO58UGd801SioIKCDMUM8gJIWtX6hEQ78wYWMe6WgIuVWQIFWjG3+zP4Mrk
         pvKYS+lAAQ3oxNJQv5780IOo/ju6+qbKBJcxXxD68NGhheWNRa0IPJICRLfHG75dzqbe
         fajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678727565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHPExQVVq6iXm0n0BgO9lPEuEcPXx8mZW7Wn/dMWXKo=;
        b=3fLDngqhhmqTL6kFopA8ydWVVJRfM+lPP9FbioDvGuJpx3iZ0Ftyju7l6ZnAgo5hrK
         bye55o4MAA4aJw1G/A7ixBeAR9AU9u8+rJBxgOI6ervjL2P6Hu2gGdA5KvxpEZXiznC7
         okLak7Tfkw0lYmeLy3GwwJ5ZHZFHnunOEBpKwxI7at11B9PWQD0qO7YUY0vWWgW5v1Kv
         UucHSxvMGTU7X6qfIC2w77AoUhdreBPlz3vM6PA4cHx8D/9KP/OwZFkPPMeoity2ZG0k
         xwQI3NX2gQriT4CX69qSSmpUj/V87Jy7AOoSI+RLVnSh3qusUyrFgbQXiCjRaAcwnWwr
         dyDA==
X-Gm-Message-State: AO0yUKW26/0FBrREgZ6t5YKP3VJ0u6RrTsbNt2frWWmsdrMwig/n2shP
        531V3MHc/+VDYVWsr+mcmEFqfMFxAHGKE1Nc
X-Google-Smtp-Source: AK7set9gVD6Ska8s8/BB8Lx+ggJKM+eS27NV+qkSmmRgJzTgM0xronDR977oauQMTKajccYYwnjIiw==
X-Received: by 2002:a2e:9d58:0:b0:294:70ba:1f37 with SMTP id y24-20020a2e9d58000000b0029470ba1f37mr11699528ljj.3.1678727565305;
        Mon, 13 Mar 2023 10:12:45 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z1-20020a2e9641000000b002935390c0b3sm71818ljh.36.2023.03.13.10.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:12:44 -0700 (PDT)
Message-ID: <6dfa7235106db98698fe013cde74666f7d485669.camel@gmail.com>
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
Date:   Mon, 13 Mar 2023 19:12:43 +0200
In-Reply-To: <157b8d32-4628-4b78-a587-c492946e5e10@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
         <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
         <cba295426f5bd157688b3393a4f528df06d2eca5.camel@gmail.com>
         <157b8d32-4628-4b78-a587-c492946e5e10@oracle.com>
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

On Mon, 2023-03-13 at 16:37 +0000, Alan Maguire wrote:
[...]
> sure; try adding "--skip_encoding_btf_inconsistent_proto --btf_gen_optimi=
zed".
> I was testing with gcc 11.2.1.

pahole -F dwarf \
       --flat_arrays \
       --sort --jobs \
       --suppress_aligned_attribute \
       --suppress_force_paddings \
       --suppress_packed \
       --lang_exclude rust \
       --show_private_classes \
       --skip_encoding_btf_inconsistent_proto \
       --btf_gen_optimized \
       ./vmlinux

Like this, right?
gcc 11.3, pahole master, still don't see this in function prototypes,
maybe I have a simpler kernel config...

[...]

> > On the other hand, I see it in a few structure definitions, e.g. here
> > is original C code (include/linux/sysrq.h:32):
> >=20
> >     struct sysrq_key_op {
> >     	void (* const handler)(int);
> >     	const char * const help_msg;
> >     	const char * const action_msg;
> >     	const int enable_mask;
> >     };
> >=20
> > And here is how it is reconstructed from DWARF (same happens when
> > reconstructed from BTF):
> >=20
> >     struct sysrq_key_op {
> >             const void                 (*handler)(int);      /*     0  =
   8 */
> >             const const char  *        help_msg;             /*     8  =
   8 */
> >             const const char  *        action_msg;           /*    16  =
   8 */
> >             const int                  enable_mask;          /*    24  =
   4 */
> >    =20
> >             /* size: 32, cachelines: 1, members: 4 */
> >             /* padding: 4 */
> >             /* last cacheline: 32 bytes */
> >     };
> >=20
> > So it seems to be a general issue with modifiers printing.
> >=20
>=20
> So it seems like the modifier ordering isn't preserved, even though
> the final BTF representation looks right? Thanks!

Yes, BTF looks right, bpftool prints the structure correctly.

[...]
