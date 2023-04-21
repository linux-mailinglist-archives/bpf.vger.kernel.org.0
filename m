Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE66EB27F
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjDUTtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjDUTsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 15:48:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BC1BFD
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:48:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso3068495a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682106523; x=1684698523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGZqROjnGw+3pMy4kbbOtcyppnxFyWjjxMXzXeVvQGI=;
        b=P6DlQZCh+Rlm4++4V7X2gmu8e0QJxpcIK4pmH94mCfzwsOHEXOa6qYJ7eBTKOv1Cfg
         Qy83N2QNJiQfT71a6xmgMyxuR66TO0I8EfdPdtFZbgZHXrgC0MbUDoysyOHbWlaaCV6F
         /maJIN3FLcwZPixaT8431XVuVOoCTygPBGZ0yF3+yodBlDN5C450C+eHPslslAe9iRwE
         3PERCBVfZAgD2+g8Io7voj9OKb7c/JQ5JMlcVGdhckVxUBq2v6o1TcBnwY6TavJ7fU5w
         l6qtVFKRdF5Y5OAYe90djjhF12U+DhSZnjy2/K2FZlvl1VAV7hPEsRrz20SnL9lp2Tw2
         G7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106523; x=1684698523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGZqROjnGw+3pMy4kbbOtcyppnxFyWjjxMXzXeVvQGI=;
        b=F2aaCjDU8ZdLtEm9IIolBwwkYQCOfhd5Dn+hEwnv4kE9Y9OOUJO4MFmuSal9oJHNWt
         QQTa4DvTpuenR1RQa4XT5mH4crZHfEB1DB/QtP3s8gkFCzF5xqNCFH2SlfA4PnE8k1Nb
         awaen1XF+HAtCwzkA5UfS2HooCLB19Twt1rEDYzggTOiUK1NdqFrbhXcrlVuZWF/++zi
         TtdeGzOBr1qGG8XnKbH41HQQd8KQ6+SnI29hk0fJZTydUNhlw47Gf4mr+RKamOx+4Zfv
         bvKyJKip7wzBNacIucTyi6HBSIv4JfDToTA02et+sMRlQFC63sVomjWxO6Edj7maGVTh
         qMIA==
X-Gm-Message-State: AAQBX9eSC8L2wJpGofS3pye8EndpGWfRnMlkl0hJyP+4paehmrPKYmoc
        Nw9IpN7MIAVoAwCPQC95zvW69TZSAs75TU4iIp82BcUX
X-Google-Smtp-Source: AKy350ZAVMkTukB4CBqLxsako3zuOD25gsC9ozkQHKZuC9MMWvYP/ct7RDP1p4+1s7ZU9s7whLxbKvwzQVSZdUtR2AM=
X-Received: by 2002:a05:6402:719:b0:506:b228:7b08 with SMTP id
 w25-20020a056402071900b00506b2287b08mr5503444edx.17.1682106523032; Fri, 21
 Apr 2023 12:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174234.2391278-1-eddyz87@gmail.com>
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 12:48:31 -0700
Message-ID: <CAADnVQKQOX6H5W0RB1wyTAMzqMabWJp9M+pi82_BYdHWQNx3AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> This is a follow up for RFC [1]. It migrates a second batch of 23
> verifier/*.c tests to inline assembly and use of ./test_progs for
> actual execution. Link to the first batch is [2].
>
> The migration is done by a python script (see [3]) with minimal manual
> adjustments.

All makes sense to me.
Took 22 out of 24 patches.
The 13 and 14 had conflicts.
Also there is a precision fix in bpf tree.
So we're going to wait for bpf/bpf-next to converge during
the merge window next week, then add another precision test as asm
and then regenerate conversion of the precision tests.
Not sure why 14 was conflicting.
