Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74426CC126
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjC1NkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjC1NkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 09:40:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E967DB3;
        Tue, 28 Mar 2023 06:40:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so50093496eda.0;
        Tue, 28 Mar 2023 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680010811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLvUIdsE77WPnmyAOUBKh7R4ujLXvQXFucKTylQ06w8=;
        b=KPqtpDKbsQatpBrH7pMhXg/w9V2HPSO9K3/WuKavv9FXcYaV4VAS/7S7RyDs2x8L6o
         tMvcmASclMixCnBPypIvXRrfzPGzcutZzjck2os1TFmPFhqMPhzWL4NDRH0y/cbrQOD6
         Ksxg7zkEDnz0PZ5zGeamP6drEerVT6DNQNnREYpiE2mrR5flTX6ksm/CiZmYDOCoDPc4
         n2jE1u6gdxfI8NTKMFTrOrxuy9JFI4Mkk2WQeEvMq53XzO1x0MclhaT+Qo4qpsj1zCq1
         Go8SKJaaWPQoS756jYe5t+94Q5WguAnQznI9yaOnY0v65CnDigAQBhrxHyxCFkZrQfFI
         L3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLvUIdsE77WPnmyAOUBKh7R4ujLXvQXFucKTylQ06w8=;
        b=aNh5PhHeMDqFsmv11D/194ddUmATMExce+Mx9LOvHZkCHOGJ5/1V3v0VKoRMblktmr
         enDRzmp1FeMGiTMZiq5jKYandx/O5VJAQyIl97zwGMTco4MhOzyUDmRme3uPhiKh0gg7
         SA45tLvhhX1EUlogolqDw3bd+ZUN8qof1R5XXs5Tevrwb9040on7Lct9vB4RJGJUFTVb
         XkNXzL0HI1gcpCBn433Z1qoEQG8yQzjdVMIQJPR7kbULs47HfNjf1mbQi16TV+jgLAGb
         apX0ZVbX/PEiFwnIFjmou9IXlaUPzjtEV4xcrjbEhvpMALQfIutx7Hn53hmCO74mGrcj
         9BpQ==
X-Gm-Message-State: AO0yUKXmccEkPeUHz/MUJpg36crV1/ouGbEaI04g4j8oeDjz7tLkzQ/Q
        Sv5buqTACbxybCaef4+S2ek=
X-Google-Smtp-Source: AK7set/6dlovLUOqBBDlkUHpAp11a1m9flDKxP9+DbhBERu/m/neoxFwZuGc02xyl4u5msLMbifqwg==
X-Received: by 2002:a05:6402:944:b0:4ad:f811:e267 with SMTP id h4-20020a056402094400b004adf811e267mr21822273edz.12.1680010811476;
        Tue, 28 Mar 2023 06:40:11 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a50c181000000b005024faae65esm941393edf.10.2023.03.28.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:40:10 -0700 (PDT)
Message-ID: <7a27dae4640f3e84507773f3763924c1d5d7244a.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Tue, 28 Mar 2023 16:40:08 +0300
In-Reply-To: <ZCLgVrwpb3fhnnE7@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCGCBF5iYxCtBQKh@kernel.org>
         <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
         <ZCLgVrwpb3fhnnE7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-03-28 at 09:40 -0300, Arnaldo Carvalho de Melo wrote:
[...]
> > Maybe put this patch-set on-hold until that is resolved?
>=20
> Ok, so I'll apply just the first two, to get btfdiff a down to those
> zero sized arrays when processing clang generated DWARF for a recent
> kernel, see below.
>=20
> Ok?

Sure, thank you!

[...]
