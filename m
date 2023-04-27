Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A66F0C2E
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbjD0S45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbjD0S44 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 14:56:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762E40EB
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 11:56:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b86fc03fcso5967851b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682621815; x=1685213815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9U1SOsooYSm5KCVEU0yHDPxyWSN0e4LiuZonUnfDNQ=;
        b=zMSmc1aF1XSfdbFL9HyL9CCLydy6DCbFGZA1Fx3wFEhk6SvhtmFqDmo+JPEA6HACbb
         bFeiiFjVM+v+eJ1GHEIabtFjYtvaGKO+3U1/sZUBkssmoAoM3aGshZDRps+5cnDHQQFx
         84l0q+F5R/KTDUZcKKcRQAtY7ADo5KGcNvilWMeZw6t4mLahC302CxuXP2Y3kEp/ZLem
         PD9VktrgE1Au0nnNYrBb1FNgPkg1P5ndcLOOksuVLSajr4bQqD1DVG8rTbYCPqLisWis
         aiSgtSNs6JeqHssCoGvc+N1TbWmYvtVAfoqVwrgRw42nrFezkt2fU50nZVbF8rkLY0xO
         MfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621815; x=1685213815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9U1SOsooYSm5KCVEU0yHDPxyWSN0e4LiuZonUnfDNQ=;
        b=MSxWsFIWNp6bLwbQmFSv+juwK1bbHUhI4ovXBhoIuKBBTVVY28PTzymMuNowmj79+8
         kzlzAHH3u+abhARVYbgKW/le0BcqSANBDtdVAchUzxttnQR2pzQggev7btwrjSz+fC/8
         0Z6nvDgFDSnepJ/jOcA0kqwS3B9NFC67NTXTmB/N0aoSDb/3WDpTYrmIZWZbWHH4Lh+n
         j0q41aR6L/v5Wi7lnUNZmCSlhB9UF7py65wh7XIAPusgY8/OlCpbnClOPCmZHvom15oF
         /vzHZ6rY4L2vbif7kG+WRbiypYLlA2aI+cQEGWOpHSmK03Ha1RLchTvKhGSg1zNdYGwd
         2KRQ==
X-Gm-Message-State: AC+VfDzNxIliPlMJZu65U5+eyMQzf7mCmoQhnylw/y/bfFe5ZNFgtIFW
        1uirpFsMNofAurrUax564gCDVYw=
X-Google-Smtp-Source: ACHHUZ5nGhgEBGdm63F/rJ/qLbWgsbXGL2u6FeIYbcLBgTogbeWWOa9cLRA4k/cg98EGDX5Q/DFhtdI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:80de:b0:63b:234e:d641 with SMTP id
 ei30-20020a056a0080de00b0063b234ed641mr729757pfb.4.1682621815279; Thu, 27 Apr
 2023 11:56:55 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:56:53 -0700
In-Reply-To: <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
Mime-Version: 1.0
References: <20230427143207.635263-1-revest@chromium.org> <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
Message-ID: <ZErFdVXHhEdJ/m3G@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny list
From:   Stanislav Fomichev <sdf@google.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        xukuohai@huaweicloud.com, mark.rutland@arm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/27, Florent Revest wrote:
> On Thu, Apr 27, 2023 at 4:32=E2=80=AFPM Florent Revest <revest@chromium.o=
rg> wrote:
> >
> > This patch updates the list of BPF selftests which are known to fail so
> > the BPF CI can validate the tests which pass now.
>=20
> Note: I tested this denylist a few months back by sending a manual PR
> to https://github.com/kernel-patches/bpf.
> At the time, it worked
> https://github.com/kernel-patches/bpf/actions/runs/4106542133/jobs/708551=
4761
> (even though there seemed to be a known flake in the gcc variant but
> unrelated to the new arch support)
>=20
> Every time I wanted to have the CI run on my PRs, I had to annoy Manu
> by email (I wouldn't have the rights to trigger the CI by myself
> otherwise). So I haven't tested this *actual* patch rebased on the
> current CI before sending it to the list. (e.g. the
> module_fentry_shadow test has been added since then and I just assumed
> it would pass in CI like the rest)
>=20
> My understanding is that this patch should soon be picked up by the
> testing bot and we can use that CI run to check that everything works
> as intended. Let's wait for a CI green light before merging this! :)
> If there are errors I'll send a v2

Looks green now:

Acked-by: Stanislav Fomichev <sdf@google.com>

https://github.com/kernel-patches/bpf/actions/runs/4822595792/jobs/85907322=
78
