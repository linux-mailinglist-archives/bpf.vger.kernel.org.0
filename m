Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452842336E
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhJEWYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 18:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhJEWYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 18:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E311C6108F
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633472572;
        bh=s+gqLttwC+wPpF+DPnY07KCzd8DIfJ5I+aGt+PnwyY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TnVbGard5wVPoNVDBwc1c4mq3FbTEr3++IqE5KV647zFUOgCbXUrtwD77i8QzNzRD
         uoN2RKNlMWBn6hJMqtvR6TlO0uNDDxZP1V34Bx2VDkCAAulD8c+Sss2ZDxegZhv5cP
         0dVDEQgxaZj7AkMLNEpe269UZaQu7cFFZPSfTpKAB0sd1GevrZkZ2mh7x1aE8dhS+S
         XT+C5iPT3xnPqdkGa0EvMgaIWCRw5PlvCLoYCshkm7ukWXBM7cOLdf8KZso9Dz5c9J
         Zng6lkopBNA0+xX2xu1CYtGP1DQdmiitzGs4vX/7dParY0vCVHXcaXQ8A16IJinn7D
         57I9prWCxLRvQ==
Received: by mail-lf1-f46.google.com with SMTP id x27so2076021lfu.5
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 15:22:52 -0700 (PDT)
X-Gm-Message-State: AOAM533vm5EPdgLLdTQV1DglJKwhidUCIKHNqfFvHA6my0RsnsP9BsKa
        PnkK/DjDP3pR4gu6Yn7xsiAR10zq74lUq+8EwSI=
X-Google-Smtp-Source: ABdhPJy08bC0ZU+oIDQetz5xCbU628xbkMq10Bi2yCZWnwcUqKzwW3O4P6apXgIA1TsH6b2oyWo0Ic+49rvGjE+1CG8=
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr5668344lfb.223.1633472571261;
 Tue, 05 Oct 2021 15:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211003165844.4054931-1-hengqi.chen@gmail.com> <20211003165844.4054931-2-hengqi.chen@gmail.com>
In-Reply-To: <20211003165844.4054931-2-hengqi.chen@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 5 Oct 2021 15:22:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6NVoUebaxWm4YGNkStjxGwcdf5-hRKtcjtpVRpkEfBow@mail.gmail.com>
Message-ID: <CAPhsuW6NVoUebaxWm4YGNkStjxGwcdf5-hRKtcjtpVRpkEfBow@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2 v2] libbpf: Deprecate bpf_{map,program}__{prev,next}
 APIs since v0.7
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 3, 2021 at 10:00 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
> a new set of APIs named bpf_object__{prev,next}_{program,map} which
> follow the libbpf API naming convention.[0] No functionality changes.
>
>   Closes: https://github.com/libbpf/libbpf/issues/296
^^^ I guess we need "[0]" here?

>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

Other than the nitpick above

Acked-by: Song Liu <songliubraving@fb.com>
