Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434036E5527
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjDQX3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQX3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:29:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9844B6;
        Mon, 17 Apr 2023 16:28:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so16549651ejj.12;
        Mon, 17 Apr 2023 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774134; x=1684366134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcK5SPnV3oXjtVURjd0PIBbzQgyYu9f1Ri6Sa67Eomw=;
        b=K91qppt+dHtukpsuRdWUWzYdpSwkN8iG+l6NWRLq8RR92qcsIeELytQrFzOGuTwoZn
         ZdtdG94cDZLOsFyBz1seYaG9S+avTfpQsRtj04gw/pbe4byPA+sEN9l63JQW6YehsyYz
         a2ULT04i1vckF3L3/QzyzW38aKFQDrCTT2r+0goejYTbS0SGNUrDZiNGCTNWmaKOzJa1
         fA65S4XSbXxnywuV2b+QanKVAoTr1FPgCqfz2lyqP/UarAr2y/u7sM0Bo9u+npdrf6Wn
         GcNi6sGBkQw12GCF9sYAKtOgrb+8L9uGoBSvdJj1kpRBxTFDNGr9lpBMVNNzhZmjXEqz
         MZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774134; x=1684366134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcK5SPnV3oXjtVURjd0PIBbzQgyYu9f1Ri6Sa67Eomw=;
        b=DcxEz9KiWxdbAKROIybAnCvQ+ZlzeAZMZ1SRvqychRkRxdVrZrj+ellDxppN8DEeh8
         7DOMZZHNnmiN3TjR8K1cnkSeTv0SDKLHsugPkgRUNOzDHrixuH99t8htVg2g2XUgdORH
         mVD+Ibqg2u8Dwprj5hm1MC9eNcL4OVCvrawDAD+rUlcOjBqcBSl5Du8fKDGckahCSX8q
         0OhyysXX9nZhau/uYt8SS41iGRP7pIBIhN7wAfjgnmu/UjfhJjTkFnJ+aNYybrx75nNR
         RDD3I4iMesoVDmQUjKBubhPI5Ov6FJfhxnn1u6QFnMXnM3lXxJ8XvJTOVp8lNgNx6dTj
         BwtA==
X-Gm-Message-State: AAQBX9f3V5Nq5Am8I5JY17qSKPk1YCSZOiO07893CdTF0kO5pZT/o+OM
        iWParmgdTa7hi3RMNma+6RPHuPLRZFZVWHRm/obcqSKY
X-Google-Smtp-Source: AKy350bpyb9nWpQII3t4Oam91iDa4IHEcSy5RgKYsKlqc75TAJiMWLedwaji6pikWYDGd3PokSTk69mHR6Dnh/jA7uE=
X-Received: by 2002:a17:906:3b88:b0:94e:c0fe:415a with SMTP id
 u8-20020a1709063b8800b0094ec0fe415amr4379173ejf.5.1681774134345; Mon, 17 Apr
 2023 16:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com> <87leiv4nb5.fsf@meer.lwn.net>
In-Reply-To: <87leiv4nb5.fsf@meer.lwn.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:28:41 -0700
Message-ID: <CAEf4BzYx+49iG5q0JqJAiWmZoqDjSMa8ED75v2Q2K3enGaLHTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
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

On Thu, Apr 13, 2023 at 12:03=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > Why do you prefer such
> > an approach instead of going with no extra permissions by default, but
> > allowing custom LSM policy to grant few exceptions for known and
> > trusted use cases?
>
> Should you be curious, you can find some of the history of the "no
> authoritative hooks" policy at:
>
>   https://lwn.net/2001/1108/kernel.php3
>
> It was fairly heatedly discussed at the time.
>

Thanks, Jonathan! Yes, it was very useful to get a bit of context.


> jon
