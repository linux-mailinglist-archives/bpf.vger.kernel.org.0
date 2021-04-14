Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA835EA5A
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 03:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhDNB0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhDNB0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 21:26:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527D6C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 18:26:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a25so8202463ljm.11
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2WqMti9O3wrQJ6t+hs2Mlew2Yyan051UjCCZiEnCpB0=;
        b=JsK87qlLroYLgFq313scqhA7T7tCtF+2xu0yCKXWvGAAB6zgSDreNKy+sOR//+W5K0
         R6+MD4WMbUhWgyDiKxbTmyk/WNpmEGaVtIcrqHnSSYMPXMby0jt9ceseB6TH68mFKv4o
         gbuAw6CKVgtHLlriFfJb7eXdDw82whi7sQjp2bpmBFc/KOw6rdoc+x0JrShWZnIzpjLu
         xX87XaicNmvAx1a/GFtF5jpUYsEGt4sW54wjV50CSUYygVvX7pwUoxp4CqmKFJioWn48
         Pj/K6atye+TIIhY9uMSwr/H+tv9aIhf5N2nktoV2EteUt0Ywiy+y0Ng9ONRQHIpJ0oNe
         kR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2WqMti9O3wrQJ6t+hs2Mlew2Yyan051UjCCZiEnCpB0=;
        b=r/JeJdMyn8Nfc445RNUtCvjklLu/vNZR7aItazN4WXSIcUcVQnqxuaFcqGH1Af/z0t
         uIlcSU8Krq4Lg5hpkKqhQ3pkAypfgFvtOVf9DhCbu1IzqRsqTX47FmRccAbadc2iGuf9
         NXqzMHYEvxwuv/CKLfzFRYTeVVQoGOiQt9HAOlAd55iF4YQ/TxPEewqHetfnppvN1uxq
         4cc1rR1Yi/YWwlR2y45cSzJqcGRMaBut6EHm/KO8x4ci5jTw83OO44HxI188Fmxl4tM0
         XfS/da0F0StFE5zX7+9R55R7hlkSlj6po7pOkH5jVvGfd3/9IEtbtN+Vr4eYXXBRybdS
         q5UQ==
X-Gm-Message-State: AOAM5334dQtJl6nOvokNbdIe0iULBJrITQpy52qql1aI86+4Bt26kRVq
        28TG79m9BV8j5jSwAu0GDMfb2KkHpPfZYrt56dP/qkUm
X-Google-Smtp-Source: ABdhPJyx5LdB6VfQ6/BQEuncKA2Zn3OyGYGO2959OqhBYO85w1Tvj/UZse68zQpCrj/IaYuBcjJ0TDlbfsDZ6kGPTtg=
X-Received: by 2002:a2e:5011:: with SMTP id e17mr11891623ljb.204.1618363560870;
 Tue, 13 Apr 2021 18:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210413091607.58945-1-toke@redhat.com>
In-Reply-To: <20210413091607.58945-1-toke@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 13 Apr 2021 18:25:49 -0700
Message-ID: <CAADnVQ+z8ShwG=kD+OjcGxycqTAnEvCEJ2jR13H8=5YWsx6Fzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: return target info when a tracing
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

On Tue, Apr 13, 2021 at 2:16 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> There is currently no way to discover the target of a tracing program
> attachment after the fact. Add this information to bpf_link_info and retu=
rn
> it when querying the bpf_link fd.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Applied. Thanks
