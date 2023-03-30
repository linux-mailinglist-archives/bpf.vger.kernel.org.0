Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9D6CFFD2
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjC3JbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3JbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 05:31:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2672A2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 02:31:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so73998185edb.4
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680168681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr9LyzJNwtPBWrLHdnHyiCyBp2Weiwweqokq9zVXTw4=;
        b=EY1XCg/bZ4l7fL8u11yJYaC8xLEFkeDTxY2mPgd3llkCXERrUKrJtbE8y438iDcmfC
         UiUuQPiLQLupwYQfKbQWoSPecpfJWTNfT4mkHzB/rnbVVFi/PSAtG1MxgbivAazwR/oP
         ONXxnuC9DcMIvNW1LbsXBCGZroU+N6PF8KH0I3SBPYCDPyhPFTuWTofUvEsA5xaVeKVE
         sg/aqoBki+6p2msVDN/irTRevxKnTsLnvSRbhzXGJyfWft5LQ367wrBDPBnnkSvnwQOF
         S4RBYCCSs7+pMYwiV7ONiNRzKBWBCXIL3djMw9hGgX+U2AWJCUNgTBgE39g0GdOqZmcb
         tWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr9LyzJNwtPBWrLHdnHyiCyBp2Weiwweqokq9zVXTw4=;
        b=Z/5xXBlpBVz7QANt7G31kueUUmBIup7HyZvY/ZyNKIZw7y5yYPjoK2xa/cUZWC42Vk
         8ZwuyyFbH/Qy55potF/dLKUvC1kK7vRoa8BCArfIxiEJqWzYXeYwVLalMJ4csOzLlxWh
         ieDcFkxT54LqIUPbi5hXFyKu1AJ3vOektkOlw1IKDFpOs5v9AvnhPvjHVPt8AXfxgeZW
         CQgL6sD5sjxuxmFu+cUGNeEFYF6IutohnANLGmQ39ZOY34Az+24oL1Q/DTA94/VfFObV
         qMjatz+oMZpV9oi1txooWQui78vJm7tBMf8yTMCh9ImtXVbxaRo3p3zYfnZKPCbE5MCv
         lvwA==
X-Gm-Message-State: AAQBX9csuePT1uHMnSmckCqxAmbluxeCBp/G8Vrkdxc64deepI00gVlo
        akmV/hm/E/PybrtcQ1p/FiDM/tCAJ4lN/aFhdgo/ng==
X-Google-Smtp-Source: AKy350YPsaKluuVXMSWSkCPI0Mju86GurO8AcWPD15KIe2cAMxjqyLXSm86PdSVY9zDi8l2nTAR9iesstiQhFkPtvhY=
X-Received: by 2002:a50:a6d1:0:b0:4fb:482b:f93d with SMTP id
 f17-20020a50a6d1000000b004fb482bf93dmr11374387edc.2.1680168680874; Thu, 30
 Mar 2023 02:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <CAEf4BzaAcD0HEgJzQH4NTWAzkTXHLS7T-eGGxxhHm2ADROTRrg@mail.gmail.com>
 <CAADnVQKT7Hifb=vV1yu8orgPMkRynNLZykCPKanRqDigE8xVEA@mail.gmail.com>
In-Reply-To: <CAADnVQKT7Hifb=vV1yu8orgPMkRynNLZykCPKanRqDigE8xVEA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 10:31:09 +0100
Message-ID: <CAN+4W8h3K06nY3Adffz3GQqaMOA8U2KRKCV1Hh-Z0EtYeqs6dw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] BPF verifier rotating log
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Timo Beckers <timo@incline.eu>, robin.goegge@isovalent.com,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 6:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Lorenz, ping.

Sorry, I've had a busy week and I'm not working tomorrow. I'll try and
get some review done for the rotating log series today at least.

Lorenz
