Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDD6F3B10
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 01:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjEAXh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 19:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEAXh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 19:37:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F22735
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 16:37:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b603bb360so2655038a12.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682984275; x=1685576275;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8ZXDcYId0uDrhwRGrCCG7Cu8UrinqDG/dzjBktXCoI=;
        b=Z6Atacq3Nlu1+mHt1Bsq7TmdEsE9WFx3BUWVknZy3RrwFQTUf0zOifU1+TsgJq4PzI
         nW8aYXI2cZIbY5Q4dG8eQPFCKM8aHOxDbIlF5aA6rls+0YNZLWOadqPikkT52CCilqse
         ReH++1qAwKEIO813R/m4v193pYWqC798S/5b8TZ0Ui81sIq7gvPe9SDuUacFrXCT3woS
         +ft6kh7oDcMoqzPOum12D+qscTnWwwmU5bgyuH2Wrgsfs1pL5+9woXubvidRagDJRYaR
         MC7qbi1yInaEMnwYNXE+DLHY7KPd9ruyha8bPNU+Odk/bKswQ97UC9rCBow+KVHV5VY8
         CKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682984275; x=1685576275;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8ZXDcYId0uDrhwRGrCCG7Cu8UrinqDG/dzjBktXCoI=;
        b=JWHoYdXaP4WoPXMRm56rLmWC+eBFg8bU13GWZpm9PhXNtGsT0pvxHtgtZCstl5RfWT
         jHVgOfSMox1vuen0jMzsBmsXsmSw+NLmomRGVXE0Va7zDB0ArH4yPGWgvKUk6siwuX/Z
         IEiFIGe6ftumpyxckXeMEi3ZmHyPE5tEnk9L2CePYLFpdyN9uwJwMLJszPPdraxnnD2s
         lLVOG5dR/J2HaITwRtQnuba+PjJG2pqG7EfpFpcyRzdhfvfB9l5NQPdn1Ga/mRM1+4s1
         BxQtPoeI+jvFW8wgVGvUEEZFpECaewqJ++JvF7JgZikVmVB8E8/BPGkEE11F967sfv1f
         lsKA==
X-Gm-Message-State: AC+VfDy2Ai+11xyRZgqxqG8tz2x0HWAEZqUVq/4S0IwBaRj0OPlEQ+Zh
        w919D4zIA+P578h/uBDC3fB66jGvaK6GnnfHtIXEkw==
X-Google-Smtp-Source: ACHHUZ6zRXPpcyWaH2QTdG5HweLx3r4rVSsjOG0o/T7wCvSOqY1MNOifUr71T3eWAgqa4MKlrpZtGw==
X-Received: by 2002:a17:902:b406:b0:1a9:7eea:2626 with SMTP id x6-20020a170902b40600b001a97eea2626mr13186116plr.10.1682984275413;
        Mon, 01 May 2023 16:37:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:ec67:e52b:8070:1b56? ([2601:647:4900:1fbb:ec67:e52b:8070:1b56])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001aaf13db1acsm2923357plh.276.2023.05.01.16.37.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 16:37:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
Date:   Mon, 1 May 2023 16:37:54 -0700
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD812E8A-54FA-4ED9-82A4-0A257E92BFE7@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
 <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
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



> On May 1, 2023, at 4:32 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>=20
>> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>>> This patch adds the capability to destroy sockets in BPF. We plan to =
use
>>> the capability in Cilium to force client sockets to reconnect when =
their
>>> remote load-balancing backends are deleted. The other use case is
>>> on-the-fly policy enforcement where existing socket connections =
prevented
>>> by policies need to be terminated.
>>=20
>> If the earlier kfunc filter patch =
(https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalen=
t.com/) looks fine to you, please include it into the next revision. =
This patchset needs it. Usual thing to do is to keep my sob (and author =
if not much has changed) and add your sob. The test needs to be broken =
out into a separate patch though. It needs to use the '__failure =
__msg("calling kernel function bpf_sock_destroy is not allowed")'. There =
are many examples in selftests, eg. the dynptr_fail.c.
>>=20
>=20
> Yeah, ok. I was waiting for your confirmation. The patch doesn't need =
my sob though (maybe tested-by).
> I've created a separate patch for the test.=20
>=20

Ah, looks like the patch is missing a proper description. While I can =
add something wrt sock_destroy use case, if you have a blurb, feel free =
to post it here.

>=20
>> Please also fix the subject in the patches. They are all missing the =
bpf-next and revision tag.
>>=20
>=20
> Took me a few moments to realize that as I was looking at earlier =
series. Looks like I forgot to add the tags to subsequent patches in =
this series. I'll fix it up in the next push.

