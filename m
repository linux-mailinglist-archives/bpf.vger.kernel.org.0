Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1384B67B67D
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAYQCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjAYQCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:02:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4BE4FC2F;
        Wed, 25 Jan 2023 08:02:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx13so48816028ejb.13;
        Wed, 25 Jan 2023 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh1dfZJXSgcvY7upAcL0rsGMk/lMoiv3FC6N7eINA/8=;
        b=ntcylzuTZx0rV4CTvZ4BHIA9SweCOdoxpfqUE2h2zjyTqRx38QvN9bWgv7IRfWQIMf
         tXdP+VQS0mozV1YeBvFsEiWIGLQgXy/RP2DyBUPHTn4QurQvNAVM1+00eRqi6kAycF2I
         5O2RD8EiVvSxpINhjxovaCMNvn5nqsozs6/Fipm2kKcZHuyXcDx6VbJ5JXBN5a2wwrdp
         Q5Sz+i2uWGsrjAardltjhztKj60vLeW451k8P3cfhvD/QT4rhMz7qXDMu+IptOQZaUHs
         VkuPEBnJrU03eqxN1Lw6XkoWdTfX1J7sh0zZk+EE6SZpX+QwcrFkBRet9iPgazVnfSgq
         IUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh1dfZJXSgcvY7upAcL0rsGMk/lMoiv3FC6N7eINA/8=;
        b=4+lDARAg2ykJ7myp09z7fr+lRW4p7H8lNT9COKoAK4c/TBBlqR3s776EAMKiHR6V8N
         y4nlW9xIFPgy3ov4XLtdtUxWwm3vn+YzTt9hrfQyNVuwggVMPvxZq7hD/bAsjabmwCR5
         DxZ2z5fwVDyPQKDwEsgSQw+OAruRSxllFlPIC8xYsLwA7JTwSXUN/LZGbQBcnmp+jrVO
         r4xg2PnOh2vARVrjoIL+qShtCVS9IibyO58e5jiFGJ+6zbhG4QKuqqX79RUfjC+1oWY0
         04q5ud5Yw2lbubPCRSSrKwq5auECIDygyFnnDDcG9Ng5D2Z0tDuKMr1dPwXneM4eLauv
         Ky7w==
X-Gm-Message-State: AFqh2kp8ihgsANMwRZjOxOekPbEWn8uFJM6VigA3aFbOChl1CCy/kcE9
        B4VuBGBV/ysJ3rjcFnI6NqHv3pSJtJT3dBRmV/0=
X-Google-Smtp-Source: AMrXdXsfyg6GoDdbyemvB94uYyqJ/iJYsk6tbcpzyV8w8n/Rh4x7qloTdD32Oe9YEMsy/dRHdmzVBf78FpHQcM/6IKQ=
X-Received: by 2002:a17:906:e0d3:b0:7b2:7af0:c231 with SMTP id
 gl19-20020a170906e0d300b007b27af0c231mr3605351ejb.240.1674662521560; Wed, 25
 Jan 2023 08:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20230125143816.721952-1-void@manifault.com> <20230125143816.721952-3-void@manifault.com>
In-Reply-To: <20230125143816.721952-3-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 08:01:49 -0800
Message-ID: <CAADnVQLtNJ7DYsvzZ0q3So-8PxywiCC4pmV0xKhkDZiw+jx=4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Enable cpumasks to be queried and
 used as kptrs
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 6:38 AM David Vernet <void@manifault.com> wrote:
> +
> +void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> +{
> +       if (!cpu_valid(cpu))
> +               return;
> +
> +       cpumask_set_cpu(cpu, (struct cpumask *)cpumask);

I was considering suggesting to use &cpumask->cpumask here and
in other cases, but figured it's better to leave it as-is,
since bpf prog will be doing this cast, so it matches.
Maybe some build assertion is necessary to make sure it's the first member.
Probably overkill as well.

Applied.
