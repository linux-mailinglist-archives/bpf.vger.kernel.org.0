Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954332620C
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBZLjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 06:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBZLjK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 06:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614339464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rikGehM9mwA1nuC9BKnS7TVn/QfaVjDSfEE0cqyBQ9A=;
        b=BhYknFRW3FrHyzuKj0yj7aRgPoP+LaVbmgS0jVRtED2ezVqbpd2fxfobe/ZeswH1Luzem8
        EqddT7Tb2aOQKIetQ5W1aFLCUdqkW4n28nugFVF/7lYgiaBGzp70OUT5GY7Om+2AaqLT2P
        GV7povUKtG6Ja4eJEwyNvWZJI6tZaP4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-8lwW_05fOTCWv7IoZlgWRg-1; Fri, 26 Feb 2021 06:37:42 -0500
X-MC-Unique: 8lwW_05fOTCWv7IoZlgWRg-1
Received: by mail-ed1-f70.google.com with SMTP id i4so4359298edt.11
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 03:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rikGehM9mwA1nuC9BKnS7TVn/QfaVjDSfEE0cqyBQ9A=;
        b=ihfqlmhVhpBedE8qHRcuseVJxD4AtmDXQSt47c3ffLWvfrgI72ahcI5SByCKcG5GqY
         xh4Ehz/ET2aAJAMEXOUCKkWj42or2RTERN0fbiYifLzs0NlAeWcaL9qRA2toDK04kfWs
         9Y43W1hl2/YiAOFvhpVDr0+5RE5kQgmJ93YOIyhPRIg766pVoclk28q4Fx/qpWG7yJg2
         63xGbDVzzQLAIFWaiL1hoL8OMPssSzxprvXLWeUYwF0He1/NJo/Io0HZTVKyeRfDX7Ye
         w/Vf3hptNepQamc4tH4okcr6dWGLv0uN1h3F0++ynkVTsaW6ySLsGlBlp3Gdl9yY3IPg
         4Lhw==
X-Gm-Message-State: AOAM531T0HLDkaI+AP+xWjiCY2Djnu6iMqha2P67IIyHAyu9yQ5ehSag
        2bqHV4axjc8Zox6cXiY3e2fJ4Yy2TnFEOeqO9f5zUekjAddMujFdQAmu03nvr8sTeDuhoz5gpRR
        f5unrdhkO6iwc
X-Received: by 2002:a17:906:8593:: with SMTP id v19mr2937008ejx.32.1614339461631;
        Fri, 26 Feb 2021 03:37:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXn/h5D6IkRtSIeDsQ/6ZHYlmsIQmw0U+/xrByjFJmIDx4A8bxWkPzAFulORPtyVc1cPiL0g==
X-Received: by 2002:a17:906:8593:: with SMTP id v19mr2936976ejx.32.1614339461378;
        Fri, 26 Feb 2021 03:37:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lu26sm3566077ejb.33.2021.02.26.03.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:37:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B98B7180094; Fri, 26 Feb 2021 12:37:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        maciej.fijalkowski@intel.com, hawk@kernel.org,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: make bpf_redirect_map() a map
 operation
In-Reply-To: <20210226112322.144927-2-bjorn.topel@gmail.com>
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
 <20210226112322.144927-2-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Feb 2021 12:37:40 +0100
Message-ID: <87sg5jys8r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Currently the bpf_redirect_map() implementation dispatches to the
> correct map-lookup function via a switch-statement. To avoid the
> dispatching, this change adds bpf_redirect_map() as a map
> operation. Each map provides its bpf_redirect_map() version, and
> correct function is automatically selected by the BPF verifier.
>
> A nice side-effect of the code movement is that the map lookup
> functions are now local to the map implementation files, which removes
> one additional function call.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Nice! I agree that this is a much nicer approach! :)

(That last paragraph above is why I asked if you updated the performance
numbers in the cover letter; removing an additional function call should
affect those, right?)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

