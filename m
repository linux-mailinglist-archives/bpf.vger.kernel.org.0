Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C18526C00
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbiEMVAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356303AbiEMU77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 16:59:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623203DDD6
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:59:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z26so9997710iot.8
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wezSsuBS7nQbdEcnZdz5AK6r5Ov4h0JLAC+yZ55qyhM=;
        b=f0mjseTkbB/1XM12t/fHegeOYNLZMApU1Rb4GLjk0p7/jBbLBhBB3czoGUe42gNOkj
         j1X4CpIso8bLevhC4Jd+80xDs7XGJkQF8igUozMamxiErWe+PpKYjg45oMrjMBaD1AzX
         3VwLLRlEBP/WZY+t5v6D/q5b3xpe+izyVzyjRquxlaxKm2NjJRIhtvymlHIYhl3TlN/q
         2daaWwL5Zdn2rQpxMIHj8KvzyF3jciq9mPk0/cxbGo5mTnOro8ep7mPHQUsdrarO5hiR
         nLIkeBwKZ6Ib3YJgMClM09LGIi6XDBEOj7ujmfdgySXDgrKBG4beyZknZFEBpaUgIbow
         gHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wezSsuBS7nQbdEcnZdz5AK6r5Ov4h0JLAC+yZ55qyhM=;
        b=Knp3ZoIvex4+brk3KKvPLs4NNQ/3dvSbCViGynXJKUBNGy3ijob5iJ/mtsgxpqmtrO
         EpxXRvi9FzQmbZ2ssNcWMEyma/jqNVseEEwdYPnTEzd6N3nNJX+M9Ha6m/IYdegNP5d1
         eGfCNn8+VSNAgcNV1UIbahubA11G9ujVXsBOmqL2VyM0uiuM+DrcDxhURDKmlS4fAdEG
         1GvggcDCHI83lxHDu71oXrIqAL5ztoKtRIYaW7RPPmXkZTJhMsPGT7/umAeOLJfgFJx/
         +UhqlckC7vkkC8DLgW5oMCSDp4/pUqjhwqZU+xnPu9ZxKiMhdkV9/BdY/2lDi74iEkRc
         7Gtw==
X-Gm-Message-State: AOAM532HEkvQBD47hRihIDEQDKaIlLq1J3gWa4Vfcgk/1FIhEdLfUYND
        rz4u0fQ6xvfp/Tm9oms0qUbzXSG90ry4lhstkOw7dZyhZWA=
X-Google-Smtp-Source: ABdhPJxbxtaEuOQUbKl3ai+hhFHhy7+TPPqa7trijFBpX8IrwRn6G+5OdDTzPieuGDSKEUc+thlaWVSvfbTqwmFlh8I=
X-Received: by 2002:a05:6638:468e:b0:32b:fe5f:d73f with SMTP id
 bq14-20020a056638468e00b0032bfe5fd73fmr3701298jab.234.1652475597724; Fri, 13
 May 2022 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com> <20220509224257.3222614-3-joannelkoong@gmail.com>
In-Reply-To: <20220509224257.3222614-3-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 May 2022 13:59:46 -0700
Message-ID: <CAEf4BzZKZ-3k2EacNd70o2oUNqAywOT+HLyycESLf1Ym6R_zGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 9, 2022 at 3:44 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds the bulk of the verifier work for supporting dynamic
> pointers (dynptrs) in bpf. This patch implements malloc-type dynptrs
> through 2 new APIs (bpf_dynptr_alloc and bpf_dynptr_put) that can be
> called by a bpf program. Malloc-type dynptrs are dynptrs that dynamically
> allocate memory on behalf of the program.
>
> A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
> defined internally as:
>
> struct bpf_dynptr_kern {
>     void *data;
>     u32 size;
>     u32 offset;
> } __aligned(8);
>
> The upper 8 bits of *size* is reserved (it contains extra metadata about
> read-only status and dynptr type); consequently, a dynptr only supports
> memory less than 16 MB.
>
> The 2 new APIs for malloc-type dynptrs are:
>
> long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> void bpf_dynptr_put(struct bpf_dynptr *ptr);
>
> Please note that there *must* be a corresponding bpf_dynptr_put for
> every bpf_dynptr_alloc (even if the alloc fails). This is enforced
> by the verifier.
>
> In the verifier, dynptr state information will be tracked in stack
> slots. When the program passes in an uninitialized dynptr
> (ARG_PTR_TO_DYNPTR | MEM_UNINIT), the stack slots corresponding
> to the frame pointer where the dynptr resides at are marked STACK_DYNPTR.
>
> For helper functions that take in initialized dynptrs (eg
> bpf_dynptr_read + bpf_dynptr_write which are added later in this
> patchset), the verifier enforces that the dynptr has been initialized
> properly by checking that their corresponding stack slots have been marked
> as STACK_DYNPTR. Dynptr release functions (eg bpf_dynptr_put) will clear
> the stack slots. The verifier enforces at program exit that there are no
> referenced dynptrs that haven't been released.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  62 ++++++++-
>  include/linux/bpf_verifier.h   |  21 +++
>  include/uapi/linux/bpf.h       |  30 +++++
>  kernel/bpf/helpers.c           |  75 +++++++++++
>  kernel/bpf/verifier.c          | 228 ++++++++++++++++++++++++++++++++-
>  scripts/bpf_doc.py             |   2 +
>  tools/include/uapi/linux/bpf.h |  30 +++++
>  7 files changed, 445 insertions(+), 3 deletions(-)
>

Apart from what Daniel and Alexei are discussing, LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
