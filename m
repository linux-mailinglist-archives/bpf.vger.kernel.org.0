Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE669B540
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 23:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBQWGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 17:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBQWGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 17:06:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D355F252
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:06:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d24so3275320lfs.8
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuzwBeZIP3++lGaGA6OagGAkXtRIqsITFnPaL/ZqxAM=;
        b=hgXp1DwTQMzvGKkrn6buErn545qLZkLBRz96HcrMSkwdy9+GBMicBfMK6W1RF7JT3j
         sYRtdAOzDbqr/K/G24g1FWfyXepYSaOtqsqWtT8dzQcYSPOOpq5iW97rhhAroMdHjI9I
         JIGS1rOMzp2V+u6lvHC4DZ3hcnJKzKCEOyPaJjDlde1QUE0Ogw1iTj7IQSa4Nk/zXl4A
         hs7PTjXtnwXNmdzioWvg2naCw9xAsxqEy4B6uEXi1mMPsqo8zGFI2tdPIfgigmD7J5Mw
         ut5/jMp2KRe3vbqdE3K3kqGBDYhwyEnwUk6eKv1o4t0hQjAKowgtmHvnNrXQbs4MhBVk
         m6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuzwBeZIP3++lGaGA6OagGAkXtRIqsITFnPaL/ZqxAM=;
        b=oDUS5KVfoqjGOMh+ldvhk9CluUuasFsNsfmluHKW4/dKDEvdQtYHIcggx6q3Ij3wsX
         ot1ZRWsnhATBqws8IJXP6gw3TMYC/Tjoe+uqClnwFp/i0PeBTY/x8pQlGsUFOCf8NKev
         jIS3v5S4gxotv8FxLqMfddvPTeSLaOnB/zClu3uwNEwfMfXWgsMf5cIdoDGDGAwl088+
         iXDRRStWgpBoKI2uXVqw0bp+fdgOQA8+EyNm2P4vJT1UzSDqRUyFeeFsZxi0fz7g5P9w
         ZuvstSjFFaM5oPLMcI1Fus2exDn83UtLQOED5a2/5/Pzp1nhFjxhY4imEaQyMHk//Guq
         AvqQ==
X-Gm-Message-State: AO0yUKV6gI1GYVrfnv+WEaHDCqMnp2Wvj1u2vC0gTxSW9VyMBwmey21e
        tYQEKQ7qkNc9T7EpItfapJ4=
X-Google-Smtp-Source: AK7set+ec7s8YltGL+6/9nJlEkdDxuwZY5kGMP6LTQn38QyxiCueL9Fx6Qwd1/vhS07EEwbSYAvtGA==
X-Received: by 2002:a05:6512:15a:b0:4d3:f0f2:b97 with SMTP id m26-20020a056512015a00b004d3f0f20b97mr128423lfo.38.1676671596783;
        Fri, 17 Feb 2023 14:06:36 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v18-20020ac25612000000b004cc7acfbd2bsm795786lfd.287.2023.02.17.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:06:36 -0800 (PST)
Message-ID: <12e77262577c0621b98eb830177f91ff3710db20.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Tests for uninitialized
 stack reads
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Sat, 18 Feb 2023 00:06:35 +0200
In-Reply-To: <CAEf4BzbE7=NALGK4oJjx8U6rkVdJh91ykhw34UsQy9Rhy-FE7Q@mail.gmail.com>
References: <20230216183606.2483834-1-eddyz87@gmail.com>
         <20230216183606.2483834-3-eddyz87@gmail.com>
         <CAEf4BzYPAE8EhgeGZWuUG5kjvxd8n5c1Qy_PCJveVYQ8=Fuipg@mail.gmail.com>
         <4a1aaff3c2f29485d0a47279bd8b6cc7f0f6c78f.camel@gmail.com>
         <CAEf4BzbE7=NALGK4oJjx8U6rkVdJh91ykhw34UsQy9Rhy-FE7Q@mail.gmail.com>
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

On Fri, 2023-02-17 at 14:00 -0800, Andrii Nakryiko wrote:
[...]
> > Orthogonal to the above issue, I found that use of the '//' comments
> > in the asm code w/o newlines is invalid, as it makes rest of the
> > string a comment. I changed '\n\' line endings to '\' just before
> > sending the patch and did not verify the change.
> > =3D> The patch-set would have to be resent.
>=20
> I was wondering about that, but assumed you tested it ;) so yeah,
> please fix and resend. (in that sense having each line separately
> quoted allows much easier commenting, but we've decided on this style,
> so let's stick to it

And syntax highlighting for strings vs comments :'(

Thank you for the replies, I'll update the patch #1 and resend.

[...]
