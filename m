Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D655763D
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiFWJFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiFWJFI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 05:05:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D32CE07
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 02:05:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c4so32166180lfj.12
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=kWQuFrB+GAShY1zpJeUQWK0/5ql7lI4QT/5iSPW3krQ=;
        b=OVhWbgCN5qoJTVdH34XRyp1+HWfOI8OF/S14orwjNwL9P+XMHSLNPw+1dfj533JFWB
         LPvokXhMrX3MKw/IyJ5kKnXtXGuWbP13OEcD8o6jRlniLjAmc9nOCz1b70CVpEjpIndi
         q9tUZQarJX8f7kx9g/CYe2FJhQT3jvJgfQNwsM6EnCmHcC0mdkgjo0J+ayFiUTzHFaOw
         K6eOpKYwi+OTVGgWwiSR1SXt7/VK+p9l/xjL3nZ5MRNRU4Jx1Q1xS9XkYGHCyGZpGJK4
         L/Yg3r6yLknAkJdF6aEKKPLzM3UY4GjkvsTozT+HJmweo2kxvN9TvDggJpcbIXQAW9z8
         sM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=kWQuFrB+GAShY1zpJeUQWK0/5ql7lI4QT/5iSPW3krQ=;
        b=k87rOno6rlrILW+XkbvkjTekgzo2BR+75sYsr87/BjRX4f9LGaVCrWGL0NZgSoBIFJ
         3M/3ySBedWmhWw4QSoQaRutSvwt7fjGyUcm0AEWYEzBkkA9VRe01ek+yVllSnKuyJviG
         MAey2zS273kgq+8IZVXXoOHVIQ5K3oNhESI7mkTa2zXQrpRVzH+I2tFmnYPN0odJuzHi
         saz7JYdicBVEEmOyNAf4qNHTLsnfzE27/qmiiaEJKSFCNmpbaeXgDwa0vr2YcG+Tc0yx
         G/siBF7zjoiSTTcBAB+PNkTzTp4ZAokOvvOWv2FBuAMpd0oSXCU77CzFnIH0y4bXouIy
         XjaQ==
X-Gm-Message-State: AJIora8/lJcH/vdCyB3S9sZ4DoXe3b2EUofqZQRSOP+Sz3VOCcxaZaFq
        gImb9tkjk87ucfdgTE03q65WriEAwaqvfw==
X-Google-Smtp-Source: AGRyM1vOv3sbppB1iYBQ1nOMt01YJ6MRjDDRFTEUZGTeCdNZNBriFvZUYtGQlXRPgeJO75Fm+iXnOA==
X-Received: by 2002:a05:6512:138e:b0:47f:77cc:327a with SMTP id p14-20020a056512138e00b0047f77cc327amr4748507lfa.277.1655975105450;
        Thu, 23 Jun 2022 02:05:05 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id s9-20020a05651c048900b0025a898428cbsm486434ljc.43.2022.06.23.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 02:05:04 -0700 (PDT)
Message-ID: <f3c818802a7df5a58256ac1494d6267e478d8dbc.camel@gmail.com>
Subject: Re: [bug report] bpf: Inline calls to bpf_loop when callback is
 known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, ast@kernel.org
Cc:     bpf@vger.kernel.org
Date:   Thu, 23 Jun 2022 12:05:03 +0300
In-Reply-To: <YrQicyVuXTF3WecL@kili>
References: <YrQicyVuXTF3WecL@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, 2022-06-23 at 11:21 +0300, Dan Carpenter wrote:
> Hello Eduard Zingerman,
>=20
> The patch 1ade23711971: "bpf: Inline calls to bpf_loop when callback
> is known" from Jun 21, 2022, leads to the following Smatch static
> checker warning:
>=20
> 	kernel/bpf/verifier.c:14420 inline_bpf_loop()
> 	error: dereferencing freed memory 'env->prog'
>=20
> kernel/bpf/verifier.c
>     14350 static struct bpf_prog *inline_bpf_loop(...)
[...]
>     14411         new_prog =3D bpf_patch_insn_data(env, position, insn_bu=
f, *cnt);
>=20
> The bpf_patch_insn_data() function sometimes frees the old "env->prog"
> and returns "new_prog".
>=20
>     14412         if (!new_prog)
>     14413                 return new_prog;
>     14414=20
>     14415         /* callback start is known only after patching */
>     14416         callback_start =3D env->subprog_info[callback_subprogno=
].start;
>     14417         /* Note: insn_buf[12] is an offset of BPF_CALL_REL inst=
ruction */
>     14418         call_insn_offset =3D position + 12;
>     14419         callback_offset =3D callback_start - call_insn_offset -=
 1;
> --> 14420         env->prog->insnsi[call_insn_offset].imm =3D callback_of=
fset;

Hi Dan,

Thank you for the report, you are correct!

> Presumably somewhere there is a "env->prog =3D new_prog;"

This assignment is inside `optimize_bpf_loop` right after the call to
`inline_bpf_loop`.

> But it feels like it would be more readable to say:
>=20
> 	new_prog->insnsi[call_insn_offset].imm =3D callback_offset;

Yes, I agree.

Alexei, could you please suggest how should I proceed:
- submit a new patch with a fix, or
- submit a the complete patchset with the fix included?

Thanks,
Eduard
