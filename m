Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F743E278
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhJ1Nr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 09:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhJ1Nr4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 09:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635428729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4RVU0fCj6WA9PThqjBMiACWmhqkx1yRyCGqh2MBFEY=;
        b=N0LWAktGvqw4eS3LGRciEpX1dPPQFAufI+fpIWa4zhOzPOPkK28C8GYN/Bg7MfAGkgHE+z
        Uu8YVaNZXExxUrdclnaJu6wkq5O1BFXqcP69G8stc+280DYhVy6u6QaUxFbmRB8SH757p4
        K1VDu6Brfv1M6iYJsNr6jpSbmfvNhYw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-mU-V3R3uP76Bq1gcH7n9Lw-1; Thu, 28 Oct 2021 09:45:28 -0400
X-MC-Unique: mU-V3R3uP76Bq1gcH7n9Lw-1
Received: by mail-ed1-f70.google.com with SMTP id z1-20020a05640235c100b003dcf0fbfbd8so5668777edc.6
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 06:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f4RVU0fCj6WA9PThqjBMiACWmhqkx1yRyCGqh2MBFEY=;
        b=ja1uEyvoJIIPVKR4bNAlIWHMRj9GJelgVtQtS48e31YCujjXjPl9AKgsUb83VL3SkL
         IAu7asqXBGrywZzVCo30IbNK+SaZX/+PbLqTTc4RMFOwb/gpHzLegwmgfA4aj8RgG6Rt
         sRbwruFYlIAcGXeSJN95TTuSGWBqTNh01DdLqwzURZesmdztQSKB0F+68bymFxR3z9CX
         keVZ4NFI9JZoEjmcj+nkvnBoglzr2ZmL5A/GPA1a96UtOyZi7HmrPvjFqbna7cJh0pNL
         /bPWZvxDk47c3J7Oq52BUw5xSf8Mu/9iWrN/q3mnIKLhr1Wq2pczspEl2Rg0FMrk1d6O
         8ODg==
X-Gm-Message-State: AOAM532EKrDkFwgIsKUtqpDZptjKJvKFB//zYhAYFdWRHCm3OC1QwFQr
        JLaPXq6ITFHdUb0uNqZm7INUv40RLMEoApRS/v0HX+yAruz2KMN5n9qHiW4Aar5YfpHI1dXa8gG
        UkJZ3SDXQnosq
X-Received: by 2002:a17:906:c248:: with SMTP id bl8mr5457409ejb.360.1635428725653;
        Thu, 28 Oct 2021 06:45:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcDI0nkrtjKeJZUtJYosbKl2scjVFZLNXlJd0FYdMFaHC8SXLtHYGFSpOcdLpttH8EW8QTRg==
X-Received: by 2002:a17:906:c248:: with SMTP id bl8mr5457296ejb.360.1635428724766;
        Thu, 28 Oct 2021 06:45:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x15sm1695156edr.55.2021.10.28.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:45:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D564180262; Thu, 28 Oct 2021 15:45:23 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, yhs@fb.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
Cc:     jonathan.lemon@gmail.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: deprecate AF_XDP support
In-Reply-To: <20211028134003.27160-1-magnus.karlsson@gmail.com>
References: <20211028134003.27160-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Oct 2021 15:45:23 +0200
Message-ID: <87tuh18dqk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Deprecate AF_XDP support in libbpf ([0]). This has been moved to
> libxdp as it is a better fit for that library. The AF_XDP support only
> uses the public libbpf functions and can therefore just use libbpf as
> a library from libxdp. The libxdp APIs are exactly the same so it
> should just be linking with libxdp instead of libbpf for the AF_XDP
> functionality. If not, please submit a bug report. Linking with both
> libraries is supported but make sure you link in the correct order so
> that the new functions in libxdp are used instead of the deprecated
> ones in libbpf.
>
> Libxdp can be found at https://github.com/xdp-project/xdp-tools.
>
> [0] https://github.com/libbpf/libbpf/issues/270
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Seems you typoed 'libxdp' as 'libdxp' in the deprecation messages :)

Other than that, though:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

