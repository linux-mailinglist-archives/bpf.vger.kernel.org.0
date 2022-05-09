Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6D5204FB
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiEITNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiEITM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:12:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97462C5C46
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 12:09:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e194so16353479iof.11
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbnPx3rpVLyvSuU5b7GmPOEDVJEWBhiQ1ZaYUqfgBfU=;
        b=GY+P2eyWnoP9C7lsbLDpmZHUi2FrvUOvMPkj1DfisascqY6j6VpkNFHPA7HFMa/WUT
         rQYAotWfaFUpyWNB7+RmESv0IQyKz92IuKWHCfwhESpjjDPSm9i9q0dGQYtxwdxLCyrT
         JU4kxrcynNgwr4Sv5WMHoi4LHvGkDMkj2pFBHJrIIqWcTPEQ2zxcIxK526oxg+lJbUjz
         Og7QXEM50e/q0PhQaabs8WYEAI5nV1tK1SPqidtDXDkoJOHLF5fNHXYr5qyWVCxC1xfO
         p9vU832YiWDQX+lPLQvKY/Hnbc7b500L2/TBaDmOkbHZVzX8Sb1tjdijsA9ZSXsOBeep
         JwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbnPx3rpVLyvSuU5b7GmPOEDVJEWBhiQ1ZaYUqfgBfU=;
        b=becWu8NaLr8hQbkQd8Lx4hEvkOFJXtdTiFu7JXEHgLsX20jUn2QkjLuhIGLaahBT3X
         8dGRdvPRZcy6M78dvVrtcA+QEfSlDG2b6kWRTe/HpK6wXlkRhQFJGnZPNKHgzT1w1H0O
         kOcL5b2c2uQdnM5d87gj60DX71YO5oyX9drxQzmtrz0cXFpowDIQ5zjctsGqBrfq5Sm5
         /vE0Q10z1PrB9Uu9OXRu9RDVHsAox1rjbMEr1IZBAjRpFh6ZuAdA23tdIEHFuinRpSFD
         9UIecUeAq5z+yGJjE5rHiICltgD/zRuOS0i8Be2avhrtL9zkd11dn3zI0K9lbvKat0Vc
         VQPQ==
X-Gm-Message-State: AOAM532U/E8BsZkBaSV0F6df4UOECGQj9RZA8c9bDLWFwwmV/Ac4N3dB
        hFtY4EqjE1OuyRnREozaskPLBn+lYRYw+Kv1FM4=
X-Google-Smtp-Source: ABdhPJxytgT6SoEOA7CdXzF7hQRrOoW+ztVeJWfJBPMywgbq883oefDXyfhgm1O4AmghlEAaKkrxOHj+9m2k3WSNQSM=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr7964670jav.93.1652123342134; Mon, 09
 May 2022 12:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-6-kuifeng@fb.com>
In-Reply-To: <20220508032117.2783209-6-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 12:08:51 -0700
Message-ID: <CAEf4BzbfGcsE_VyJzDTcYteT2psQJ_yER+Vr68JJvYTpQXdGEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/5] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret/lsm.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Make sure BPF cookies are correct for fentry/fexit/fmod_ret/lsm.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     | 89 +++++++++++++++++++
>  .../selftests/bpf/progs/test_bpf_cookie.c     | 52 +++++++++--
>  2 files changed, 133 insertions(+), 8 deletions(-)
>

Looks great.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
