Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5755A3CE
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiFXVlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiFXVlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:41:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0537AA4
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:41:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q6so7158240eji.13
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o0aY9IYQU7yrstImQ1HA9ipo5iBD5MAn2LRfN2g6z4I=;
        b=WwQ1bbMtqfpjjeLJRLwBbYnQlT1gs96qwB6ZE0E08JbSWxuL5lSOUgzMf0OVKUQSy/
         TXlwn2XEeN98HFkTPmj0rCfP+2Cf8E/QxvKumo5Bl7UiX7/g380i/7zlLL+XCesytewG
         4bj0z3fYeaY+7hzXkasIco8Exa+DFxm09/FFkOvAZrdCr5t00VF/dJCcDDhpz2FHkC2A
         HP8cknCEa2TTWXRrHRfM0nE5AE1+F8BOJi9W2vHC+hcejSkrMujQ2CRLemiJ+9HgQc/H
         NmMYiNmwfovVgUcNOXMH7OmlZPVmihvZRxOVhohumpVBJ6zNzoCmo+pLWoZFCSLiBHeW
         zKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o0aY9IYQU7yrstImQ1HA9ipo5iBD5MAn2LRfN2g6z4I=;
        b=Zsw/1b9rkhlA7tydoZl2wUQUsLqlZb2riWAmFA7AeZBXuemPe2Hr2cJPOFApp9mJlA
         SJG6nDL9n8M5QyCAjmnCTslY1aCqI4DQiJjKzUPq81yQl1NFvi88GqGyqKeNrrDOV3lm
         QY+nveVq+UmFhxIxYOmGZF6/vE9UMZshRnhDqjH85MmuHql884ASgYssEQverfr0/M/d
         v5qgH9axY2bJd5XZ+YvsRsPum3yrfZHauRMRD72LFcKITesvdeZjQLqeMpNTf0D9RapQ
         7vGUHtWUtJ7e8CPhTrncDOWyDJQQcmdurLmusI5RAcWGxV6cLzbdeNKRWd7Nera/1L8F
         zPRw==
X-Gm-Message-State: AJIora9Ki5t/tRh6SkAoWRPQ1jbUbunEL5FccfjcA4NtSVol137Lnqa/
        EDmC0hGpotLR9Lxa0eLdOx0aIdMFzAHt+gKJvQ4=
X-Google-Smtp-Source: AGRyM1vtBD84ZE5sgQVJ4dOuID8QtkZZso2z8lZCxA4thxL1mgTwkwIVMyu/2/jQqTUO83b7HslFPq5xLzKDLdpZqkQ=
X-Received: by 2002:a17:906:6a16:b0:725:279b:3f1a with SMTP id
 qw22-20020a1709066a1600b00725279b3f1amr1043740ejc.115.1656106877769; Fri, 24
 Jun 2022 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220623212205.2805002-1-deso@posteo.net> <20220623212205.2805002-7-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-7-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:41:06 -0700
Message-ID: <CAEf4BzZMd8UNSGJzejnw47zNYSnKjjFJ0Z9Qik3WyGhGgGGMAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/9] libbpf: Honor TYPE_MATCH relocation
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Jun 23, 2022 at 2:22 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This patch finalizes support for the proposed type match relation in
> libbpf by hooking it up to the TYPE_MATCH relocation. For this
> relocation to be handled correctly by LLVM we have D126838
> (https://reviews.llvm.org/D126838).

I think we are getting pretty close, is it time to land LLVM diff?
Yonghong, WDYT?

> The main functionality is present behind the newly introduced
> bpf_core_type_matches macro (similar to bpf_core_type_exists). This
> macro can be used to check whether a local type has a "match" in a
> target BTF.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/lib/bpf/bpf_core_read.h | 10 ++++++++++
>  tools/lib/bpf/libbpf.c        |  6 ++++++
>  tools/lib/bpf/relo_core.c     | 16 ++++++++++++----
>  tools/lib/bpf/relo_core.h     |  2 ++
>  4 files changed, 30 insertions(+), 4 deletions(-)
>

[...]
