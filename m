Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847D435D615
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbhDMDmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 23:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbhDMDmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 23:42:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62425C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:41:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c195so16605023ybf.9
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R8dmaqfcpkmnj8Xn/Be2N6cyed0wiL1ZT6oUKVGdy5Q=;
        b=QzFk49zrLcCp8oSaIlZlEnwCQ3U89Vd9vIQJlijVNRsQbACd2YjKOPsqMc7nvvrr/S
         t7gps/GTQMS5X+8EYVN9EVnTIdvDueQyNMSHu9b5C2Zep4wbkGF4vYrITRdqehNJo0wc
         4YA0d5pelExjwjYbUf7TCg3MWG6CrNd7ow8Kl0qz3R3GuiG89DZcl0I7pkgytRpyBNTQ
         IeSjnilKu0JNVcSmc7r0c+H+noaxrkFBlk+F+6r63MQtij9974erqvsuVui0M5kuN4/D
         cfUUvOVWmYgPBmoBG4yTxBJV8394CXfHAetTYxKjY6DyWygEUM/ZHGkQC2McCpWWKbZ/
         HR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R8dmaqfcpkmnj8Xn/Be2N6cyed0wiL1ZT6oUKVGdy5Q=;
        b=HSVGp5clIzIc+A00kTQMy2iRcIEQgyeRtI+pMYNKZWyARBABCpIx4h/9vzuj1o8cuI
         O3Ej0ZvAPcxRaVwwYlrV+d49xbQg4rkYglNK0Qc1fj5bkwB4Cr+6+g8XkCqTTxAOgqOn
         T9xpSBFmFsYTbtKc8Znrr98hygFQMc19Prt6MKziZ9nG5fG4XxZiPIe5kUSDV5kgrs6Z
         M4p42lADkZ4JdD39s5kCXWJKUYuGgUfgibPfBbVzsP4Ymc6kZpZjM2RBXsnL7tVECFZn
         kv31i0MTS7eFRdBH7QJcS/7xzlM0hNImnLM0KRLNB/PdI7yzKbaqRZ67/p/7ctZpRdnw
         ie1g==
X-Gm-Message-State: AOAM531WTG6ZC8KS31t9yhJjv39/UrXwId/hJGLwR7tEReN8m+welTtr
        j/BZwnEDp0MJH/fah/w5JPvU5GJa383DA2j97jgE/qUZldk=
X-Google-Smtp-Source: ABdhPJyxG12Rw/OSMA8aVes00upwzCFN/4yuJ9x5K8SFmetjDv8wrrbx/6aMszHPBkWU4wfmgSPememkx2Fgcc24Fzc=
X-Received: by 2002:a25:9942:: with SMTP id n2mr41189547ybo.230.1618285300711;
 Mon, 12 Apr 2021 20:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210408195740.153029-1-toke@redhat.com>
In-Reply-To: <20210408195740.153029-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 20:41:29 -0700
Message-ID: <CAEf4BzYX3C1t7PkB5bewCLT92Gh0Ouy6EJocKvphzEY8w484_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: return target info when a tracing
 bpf_link is queried
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 8, 2021 at 12:57 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> There is currently no way to discover the target of a tracing program
> attachment after the fact. Add this information to bpf_link_info and retu=
rn
> it when querying the bpf_link fd.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h   | 9 +++++++++
>  include/uapi/linux/bpf.h       | 2 ++
>  kernel/bpf/syscall.c           | 3 +++
>  tools/include/uapi/linux/bpf.h | 2 ++
>  4 files changed, 16 insertions(+)
>

[...]
