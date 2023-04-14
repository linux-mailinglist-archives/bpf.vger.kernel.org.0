Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F76E23EB
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDNM66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 08:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDNM64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 08:58:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE393FF
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 05:58:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m14so1239448ybk.4
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477111; x=1684069111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+od0TCRa121YMCV7OrqJd/UDXySRjMpxgz52trWe98=;
        b=cAHfx8L7TxD9vC59NwxfUdJ2e+a4Rvzde5r3Wh174OmM3PEInpeuuU0h29TUBpfvkO
         MXEvvO3lw2wbkHyogLAr8OliFtVjNWYnSANO/9C26NeerewiRaap265G5nIUHiUxFGrP
         5gTFwwMUGcH0DMYBRviti5CVrIVRMRom6BCsxOwMZQ2eI3dKSJdQX02rjd08ksWsksFz
         T7qkHRaBqxSVC0prFxB4ISuUh91zu2C4W92DT0O+MUiMvfVHiG9bILgIsltDBcscnVKQ
         J9ayeCJy8OuIwhb2rlNgljwbtPZIqqNR5oE90bvPmL2RmoT1u0fIUdW6qAswuuJnz2uy
         J07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477111; x=1684069111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+od0TCRa121YMCV7OrqJd/UDXySRjMpxgz52trWe98=;
        b=VPkMU5OQEMHGSJVHv9goSx92bSC7/BgF/vV/ZTcRAXoV3wRdVbUqblJCRh5mMYXFMK
         OqH66mG+xUhU+MOKprWtxBgGECCnPRxzI7ziPfQDb2Cttn/GkcEE9oDeL2ly76ZPGkd/
         ABT6r9B0kxIVqcjZApA30C1t2KPeMl+Y9pOtQmYRSz1RsxDP0bXyAQAcgKVP/MLp24Q/
         1hQI1JumUDlChMS2u31FjsMg3pR58LGOVmx67mgCHZCXWR/2hcDHQ+N/hl1xWI1o9zci
         Af1RU5N9lwKFxTFqiNgcFEcAiu6ObnhaZnqryey92aCuXS1vdJ10vBZyY4df636ydmsZ
         ICgw==
X-Gm-Message-State: AAQBX9cXmyfuPu5sLS1BjNyjRd4LiNqKc1AlbJi2/4UWzXxvUk7SyQyn
        FC6bx1+KDr9lvrbUOpgqs9soLGQkUcpIkVYR5w==
X-Google-Smtp-Source: AKy350YGGIRqVCI3b+gcARZBnh6Xmku4lo6pKdzyuA62VpWFmUWH1G9gpDQyMpc0tTmdQmVY/kUIrrnX78cTOO3U7qo=
X-Received: by 2002:a25:d1ca:0:b0:b8f:517a:13b8 with SMTP id
 i193-20020a25d1ca000000b00b8f517a13b8mr3743744ybg.7.1681477110902; Fri, 14
 Apr 2023 05:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQL53uhY7qwALpFWznTANbN0dnU=Pp-gZXUYT98tUBDtDQ@mail.gmail.com>
In-Reply-To: <CAADnVQL53uhY7qwALpFWznTANbN0dnU=Pp-gZXUYT98tUBDtDQ@mail.gmail.com>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Fri, 14 Apr 2023 15:57:55 +0300
Message-ID: <CAHn8xck_k3UCGHoEF=rwxL-bZ3u63+m_6aWSXVejjK6EKwH0Xw@mail.gmail.com>
Subject: Re: xdp_bonding/xdp_bonding_redirect_multi is failing
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Manu Bretelle <chantra@meta.com>, bpf <bpf@vger.kernel.org>,
        lorenzo@kernel.org
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

Hi Alexei,

On Fri, Apr 14, 2023 at 3:26=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> is failing with:
> test_xdp_bonding_redirect_multi:FAIL:expected packets on veth1_2
> unexpected expected packets on veth1_2: actual 1 < expected 100

I bisected this down to:
fccca038f3 veth: take into account device reconfiguration for xdp_features =
flag.

This seems to break XDP redirection from a veth device to another veth devi=
ce.
Since bonding just delegates the XDP loading to the slave devices the
failure should
also be reproducible with just a pair of veth devices:

 pkt -> veth1_1  <|> veth1_2 (xdp_redirect_map_multi_prog redirects)
                  |              /
     <- veth2_1  <|> veth2_2   <-

It seems like this is the same failure as with the xdp_do_redirect test:
https://lore.kernel.org/bpf/ea5cda51-e8f0-2bcd-abfa-b6bf4b11d354@linux.dev/

Lorenzo: if you fix the xdp_do_redirect test, could you also check
that xdp_bonding passes?

Cheers,
Jussi
