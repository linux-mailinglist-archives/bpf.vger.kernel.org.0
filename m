Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00166A3CE
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 21:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjAMUCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 15:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjAMUCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 15:02:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFFF3BE82
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 12:02:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b4so13081723edf.0
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 12:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8WXfscifUZkh10fR9K/lJ5qGks1qRLG6bpknl3bMAVs=;
        b=HrdEPhbCvojo+Fuar02EPDf85fpuTwfPluZ8wj6SIYd2F+zzgHBN33oUGXbYRryLnr
         sbtlwJ0Jz98B7U+4Ooq7LRMUx9pjeD4XbDfelRTdSDwvD0UMS9LFMpshhf2HfiRIYgzq
         VnmD+LDuYdIUx3Mj2vPtIzvXWwOIyiP7FGZhDv5pcGBt5NEWI4USAzNHjiUARzDlDuyr
         j34B9OXSmXqMBS81wo2etVudOR696br9n+uWvy5MKK82yQnGm6Vs49U7fYitvVw4dgwN
         0REvt9zBlDdgFt9z3N3J+BoejbrZUqNU9zxo+1/ImhFaOaXFgXLn7dMxXEqnYVrvX+rV
         lTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WXfscifUZkh10fR9K/lJ5qGks1qRLG6bpknl3bMAVs=;
        b=zViuamxLMi1S1go6CbPN+n2FJo/3dGqadGplJTIYmSA2BQMfzhU3bMJZcJ1i4ikzo/
         ooVkxspxmrNhpgNGnQMHQgEViCbn236Q7xcW1qtec7fyGjCzADw6o4zr4JMMuiZqwb4g
         paMZuIxjpKH8hSNXMxs4PsH1kwDp4W79/XKWMfxBg3IDDt44jq0aQw36yIv9oS41GfX1
         iwKszDrMQs286lvEQl1lkONRW77gNTI+VeseGJozvmVW+YoRUWAh54AYBjQ5ZYeeF0iW
         vcAk2W1VfQNuNsH3KZkdSbctB2sH3JDrJ0iKqWYEfD/lxmZiamoZSehKV0JBhv+KfiBU
         OYUw==
X-Gm-Message-State: AFqh2kq9hV/S/LreN0t+bGOQWmup1P9YsH3jXnGh5HplOzh8R9Fir14A
        ifzxv+9cKVrZYYuvqJVfp4FSN5lc6WM=
X-Google-Smtp-Source: AMrXdXuIUDwPPz3OFlB/JG5oImq6xxmxVvrVh/B+8xULTm/AJPBZ4/3vlzAlSgcE5Hz59biAdN8yvw==
X-Received: by 2002:a05:6402:5505:b0:499:c332:3b50 with SMTP id fi5-20020a056402550500b00499c3323b50mr14721643edb.39.1673640126314;
        Fri, 13 Jan 2023 12:02:06 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b0079e11b8e891sm8800847ejh.125.2023.01.13.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:02:05 -0800 (PST)
Message-ID: <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 13 Jan 2023 22:02:04 +0200
In-Reply-To: <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
         <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
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

On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
[...]
>=20
> I'm wondering if we should consider allowing uninitialized
> (STACK_INVALID) reads from stack, in general. It feels like it's
> causing more issues than is actually helpful in practice. Common code
> pattern is to __builtin_memset() some struct first, and only then
> initialize it, basically doing unnecessary work of zeroing out. All
> just to avoid verifier to complain about some irrelevant padding not
> being initialized. I haven't thought about this much, but it feels
> that STACK_MISC (initialized, but unknown scalar value) is basically
> equivalent to STACK_INVALID for all intents and purposes. Thoughts?

Do you have an example of the __builtin_memset() usage?
I tried passing partially initialized stack allocated structure to
bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
complain.

Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
instructions because after LDX you would get a full range register and
you can't do much with a full range value. However, if a structure
containing un-initialized fields (e.g. not just padding) is passed to
a helper or kfunc is it an error?

> Obviously, this is a completely separate change and issue from what
> you are addressing in this patch set.
>=20
> Awesome job on tracking this down and fixing it! For the patch set:

Thank you for reviewing this issue with me.

>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
>=20
[...]
