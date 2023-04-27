Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9F6F0CED
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjD0UPv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0UPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:15:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16811704
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:15:39 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8eb8db083so90403281fa.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682626538; x=1685218538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5Lnb7aTuHCWI4cpXtVhlA+gR45qQj9fnqWuqavBqZE=;
        b=FSh5TG015rRxK14S5bL4dEMKAkWtDbqtUHXxLhoZWVgHXrEWuNlAeeTfHxPKxOHAu2
         7xpDnYG46CkuK3r1TI/w78eBYdEK5QgC/78xs+fNYY8hKjWfNSWRIQSSj2G/srWvpKMC
         SSBVsS2e0dpJb/czVbQyhUn0U815Lssb7BUCJDNQ5DiNSs1lSDbkLfMGOpBYUoDSUje9
         2h9PycVhfXJ5XVeLVuLiyx5DnnbS7oZBVrAdPfhVJA295fActCWHA19Uz1IoKV0JB117
         Sz2crvV/xlJ7op7eRAia4jB5W3eLWcBdDl4PjVPyVj09k8wmLzzHczRTJVcsuELpFFvq
         CRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626538; x=1685218538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Lnb7aTuHCWI4cpXtVhlA+gR45qQj9fnqWuqavBqZE=;
        b=WlMb+PvzTZalUvRVdFBzBCFyDJ/mx9QgKCuw1jCq5Hh81LYDEDdFnCeuWVWSDawvMQ
         DQkCD4m4ojHOnvePhrFe7tP0FkJZQQa4J1C7r9gPjCcPR754wycQYlrQuhmw33ptjgf1
         me67eYS9ut5kfW77/gdxImSRgz6PupI3XAAqirJ9O26dDW9b8suMqp+lJeTfKgvp3Usb
         luIgasOmVl6BuIU5rrkDqHH2J0UCdrcsIs0Vm4rbVCyl+rkzYX3KvoM3f0GgCP3pL3O2
         4eP3FE3R+lvA0+yawZz3uSFkOm95l9tIMElzrpMIxrKUOJb1Quqc15SOLz9xt2HR1COb
         j2Ug==
X-Gm-Message-State: AC+VfDyhWoMN2zrrXM6oZ6ZW6lM8O4+6EtlC0IOnaGp48m/EjPI6dgHy
        SlruH1e+pdUL8RpYxCxdSzVZ0zGYSJ5Nsk2bXxU/hayW
X-Google-Smtp-Source: ACHHUZ4mREZR9T58cu3z55NvHsitsaISMDVuEq2CnVHJrsDhLj2eVzyIPDm7Ul8saZMgeCcBlob7zUPM7B5y0LcQ8RA=
X-Received: by 2002:a2e:87c7:0:b0:2a8:bc4e:594f with SMTP id
 v7-20020a2e87c7000000b002a8bc4e594fmr900235ljj.20.1682626537554; Thu, 27 Apr
 2023 13:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230426155357.4158846-1-sdf@google.com> <CAEf4BzatobESuMtP=ndHuf+imtX1ovM-4+cnV9c=UdsC=teZBQ@mail.gmail.com>
 <CAKH8qBt4xqBUpXefqPk5AyU1Rr0-h-vCJzS_0Bu-987gL4wi4A@mail.gmail.com>
In-Reply-To: <CAKH8qBt4xqBUpXefqPk5AyU1Rr0-h-vCJzS_0Bu-987gL4wi4A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Apr 2023 13:15:26 -0700
Message-ID: <CAADnVQ+HMtb75JtPSV1oHXoPgxpZuOu0tE6RCZwxtXVKYduYqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Peng Wei <pengweiprc@google.com>,
        Yonghong Song <yhs@meta.com>
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

On Thu, Apr 27, 2023 at 9:59=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> RE unsupported C++: we are not really subscribing to support it here, rig=
ht?
> Just making it easier for the folks who want to experiment with it to
> try it out.

I think short term experiments should be out of tree.
The experiments that lead to a long term goal can certainly be in tree.
In that sense if your team is really going to invest into making
c++ a supported front-end for bpf than this is a good first step.
Such c++ flavor will have restrictions (like no virtual calls and
exceptions) and it's ok. The basic things like CO-RE has to work though.
In other words if there is a draft patch for llvm to enable
existing attrs for c++ then this patch would be fine.
This patch alone with no effort made on llvm side should stay out of tree.
