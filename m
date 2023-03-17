Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C36BF53C
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCQWgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQWgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:36:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B92B2AF
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:36:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so25884810edb.6
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679092564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ0Pg2jOR3vZ0FVR0j1m45dPdaLFVfjRtHSdi3frVHI=;
        b=cPNb6comRyqs96ua+qOtgD2Eyirow91U1oXksHds4tlpYiV5n6PxFCmfPjC6qcRquQ
         Z0rKcfWi0rMvhd3olriU8RYORqkNkVCxqNQBe9UzVpO2VdaPAro3nccL55LPS5viDsY6
         fno88hQ4EXnAzGlZUCNngbNZi4xlApVcc7JG0bv5NQEyIHjsoHOkJle3MenOzdCrEYzs
         akhJF34orKKS7xZVbLLfHWGmmmHdweEdM/Bhl7SIe3YgZHgR2e0wtVbXcR2GD8woTjFL
         M0l1RdtFLseg7U4sNRxuO+wIbuLF4eGiw/UXkbaKZE8nRqbhpsyTKeag6x/hyDyZjvut
         3ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679092564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ0Pg2jOR3vZ0FVR0j1m45dPdaLFVfjRtHSdi3frVHI=;
        b=rXVPMJp+jzVsw314d1KpD8QsD0DLQV7UQSOZXcbJpoIKGBTu0VIFkKWHQrFVo+kjph
         fTI5+FQBJrNyeYT1HCFdHnr4GRHoGW+TlqmM/7sn1UlIzdI/7CODguJm/KhHKOrIILS9
         Xa3ht/ZA6lH/9+XiNXzvv5C5jaIB2+E4D0Bini7c79sxBHcbxFhABSnrfyer5XRhNe/b
         NtBEcx6jwW7hiYVE9YtC+G3Sl3PWeijy+KQN34VWpRxA9vPWCgyOSFCPdm6e+iUcmeaC
         sHhn67oF4X+ABfoVCfvqR56cs+Xxu2onJg/DT3b7uZ2qoNc3/jmJIcs5wN+nyXj8G14O
         x8tg==
X-Gm-Message-State: AO0yUKVdEEjfdvZDRaKkC8davcbwx7Gk3PBhY1Bdad+m4+oDSwaHpGva
        3pdgsahXmApAqIVsJ1Kfmr6HUl3FvLHPECSidQDeq62YE28=
X-Google-Smtp-Source: AK7set9rrVAzhb+b6hTT7AYMcWVIumrrsL3EZi7CwlpG7EjDSRcCN4cqcKkpZJhLxQLLeM5ebZ8v0bRA7KT+AbQGt/A=
X-Received: by 2002:a17:906:e52:b0:932:38d5:ff86 with SMTP id
 q18-20020a1709060e5200b0093238d5ff86mr493662eji.5.1679092564470; Fri, 17 Mar
 2023 15:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230316023641.2092778-1-kuifeng@meta.com> <20230316023641.2092778-8-kuifeng@meta.com>
In-Reply-To: <20230316023641.2092778-8-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 15:35:52 -0700
Message-ID: <CAEf4BzbeemshgkOfw9GAhpqSDMOTWNRC+LrmxU368f3-pG811w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 7/8] libbpf: Use .struct_ops.link section to
 indicate a struct_ops with a link.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 15, 2023 at 7:38=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> Flags a struct_ops is to back a bpf_link by putting it to the
> ".struct_ops.link" section.  Once it is flagged, the created
> struct_ops can be used to create a bpf_link or update a bpf_link that
> has been backed by another struct_ops.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 16 deletions(-)
>

[...]
