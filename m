Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E56F3B09
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 01:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjEAXcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEAXct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 19:32:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339A3588
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 16:32:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso30577126b3a.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682983968; x=1685575968;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpXzfK07IaWg+tiX/KptYIlMNtAQ73tLp2iewrfMLko=;
        b=bOOrQQPSoqGKeubocU7wMpOSKqBOjo+051Mnz7o4vN7HcCI63jUl0tDaXuxOSSLoHT
         HOL1z104ikBLwAG7jAjxuYrmlQ8+JvA+okt6y5EmHodH7SCOmpUjHuwwSpFYd4K56hgC
         QyNNx6HdfQFbyZQlry5snBJI0tFkTIkTly1+MC+MYe9ge1FuyJbjFLvCI2nHuJAGFct4
         Gf5dVzFFXdpjB/hHzNiqBye7xLrqLfurRek356spA2R5Ba89Oyl9EKoAIrMjAPZ9ymfn
         FXkr8h4ZtzRZG1ZZJ1rlNfzFZJ8oOihO9V2x6csTVyAeTANdQjnVG/eC2qAhdyqA+Iec
         JHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682983968; x=1685575968;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpXzfK07IaWg+tiX/KptYIlMNtAQ73tLp2iewrfMLko=;
        b=fpTFLRfxupSHEChEyCUISt2CMtYR7w2YBFQaTrjzdrQ2pMv2/Klg6Ma0bIMbS5kLfp
         EcgILW67Bi7lPjee41aV4SsGWy1kudRTyTRQZj6/4VkL1sg2As0KVM1g7F/rFDhkYHCu
         msC1+Qzx7t3Q7gOX1VQJtTzFEXpZ9N4zztacnn+Cw1n3qzGaVVhOZLlUPQX3sKeGx8QC
         5n9EofkktWlOs/cCL6RvMP7ykWWx0BEunyBG9Fm6AAfdLDAulzko0LDzgQaEUfH5A1Kz
         HwNk75WUJrMzypBITd0YrKbjD3yTbjoSGBvPHNUhNuJOWsZLZaGYZoLhChhdJ1F9UHdn
         h/3Q==
X-Gm-Message-State: AC+VfDzPhPuQRbUbETIMQs1c7c1dcRmq7eq+jawJxixESwT6JhR+i12j
        9VwkON4TdsU2lyHR6XPxb8/gXQ==
X-Google-Smtp-Source: ACHHUZ76O8qiLituV4iYRmdsDkcBkqqSzug6y78za6eCYgx2GwR8EFJqydzoRuSCjddXehBnjWk+Ow==
X-Received: by 2002:a17:90a:88f:b0:24e:d06:6912 with SMTP id v15-20020a17090a088f00b0024e0d066912mr4153715pjc.18.1682983967716;
        Mon, 01 May 2023 16:32:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:ec67:e52b:8070:1b56? ([2601:647:4900:1fbb:ec67:e52b:8070:1b56])
        by smtp.gmail.com with ESMTPSA id 95-20020a17090a0fe800b0024de3dff70esm4034295pjz.56.2023.05.01.16.32.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 16:32:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
Date:   Mon, 1 May 2023 16:32:45 -0700
Cc:     Stanislav Fomichev <sdf@google.com>, edumazet@google.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>> This patch adds the capability to destroy sockets in BPF. We plan to =
use
>> the capability in Cilium to force client sockets to reconnect when =
their
>> remote load-balancing backends are deleted. The other use case is
>> on-the-fly policy enforcement where existing socket connections =
prevented
>> by policies need to be terminated.
>=20
> If the earlier kfunc filter patch =
(https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalen=
t.com/) looks fine to you, please include it into the next revision. =
This patchset needs it. Usual thing to do is to keep my sob (and author =
if not much has changed) and add your sob. The test needs to be broken =
out into a separate patch though. It needs to use the '__failure =
__msg("calling kernel function bpf_sock_destroy is not allowed")'. There =
are many examples in selftests, eg. the dynptr_fail.c.
>=20

Yeah, ok. I was waiting for your confirmation. The patch doesn't need my =
sob though (maybe tested-by).
I've created a separate patch for the test.=20


> Please also fix the subject in the patches. They are all missing the =
bpf-next and revision tag.
>=20

Took me a few moments to realize that as I was looking at earlier =
series. Looks like I forgot to add the tags to subsequent patches in =
this series. I'll fix it up in the next push.=
