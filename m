Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF706CFD5F
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjC3Hv4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjC3Hvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:51:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D161AD
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:51:48 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso6235017otv.6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680162707; x=1682754707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xZBR4wt4QwYnJl1kiNRkq9/S2tszdu4I6cg/7le8dg=;
        b=A7hX1XYyMvm7A/qrvQyfWor7JJos6+6//5H52lp1R8iq/kNHeD8nh/0LJRz12rx8Vd
         VTAzBclUY82bmvyRUzcBrWmATmQae6D5pCKjleLNNj1TEa+j3lyld2a5/5YspNMKjE5X
         7RECdp4oeD/GCPWuPx6BQ2a4/bbz9TAo1+yPn1jOhBUzJms5BBXzJum3KRE42eponH2t
         eVZsNGD5ouQaEQf8oSMnvvXF00ZT6PWLe/4jFyMCnDxtZp60n62Lx4JEWpGh42YBs2ng
         Y+SVqWCfFazk+7FHBIQu/SaA0AKGVYSWpvl/l8IU54lsWdrU1gaxPeIihovV8ypLvmCo
         E7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162707; x=1682754707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xZBR4wt4QwYnJl1kiNRkq9/S2tszdu4I6cg/7le8dg=;
        b=UZbZVlZCv3EFkg2eK2HmPWsq7ijZpWLHvYHQ8t0NsNt8lwTgIR1XrcRq2OAm4AmazS
         ZXT3kjD1zIQGoX/VxeB331g49afOTtMmG9PzKFPA/IsQYOPBD0fCB0s6MPoXwQyL2qhH
         dzXUYKbByE/Zu8T6TJr+UG9M+Ymk/9cKvps4an1IOYfyRk9gm+hh2W6axLail5rT6ANr
         Rbk8G5Yx0qL1MesvrYYgI+9TNbBgJlKGvXelekEqpDGRbvn83uUMkQYLda9QbjDb4Bnl
         bywgne44hFwMWeKHTwJAuysnd1ZG8uKiNXD55jqKsBT6MJlMO15tde2c8PWROGcw+ztn
         6DnQ==
X-Gm-Message-State: AO0yUKV5W1jFjBcxQzX9PF3d9Xz5e/I9idjr7+1bYXpei52oZnprgRm7
        RxSnHd/Fb+jKCj/jaVDUCrPQR3ehSD+UWnz8oe0x6KAuUTU=
X-Google-Smtp-Source: AK7set8HH6qClMJBQ/Wx722Y5SJB2YGLhWK45uTxqq/yNIMFoz9iHfwplR5uJ0fOEuUBZw4Nbjimcgc6hfSpo2UB7SQ=
X-Received: by 2002:a05:6830:1bed:b0:69f:ac19:a41f with SMTP id
 k13-20020a0568301bed00b0069fac19a41fmr7253294otb.5.1680162707326; Thu, 30 Mar
 2023 00:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev> <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
 <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev> <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
 <2b5b56bb-7160-41ac-1fb8-4dbc6ad67d9f@linux.dev> <CADvTj4pctyvU+9wQ3T+jq49NAxMV89eOFfj3bp3_GfFuJ99opA@mail.gmail.com>
 <a34687f7-e2eb-3e4d-a123-f47fef6444b0@linux.dev>
In-Reply-To: <a34687f7-e2eb-3e4d-a123-f47fef6444b0@linux.dev>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 30 Mar 2023 01:51:34 -0600
Message-ID: <CADvTj4o1xCovE1dhd2yNgHZZthbEhWFtdKM8TGUe+z+LVV3pqQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage creation
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 2:07=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/29/23 1:03 PM, James Hilliard wrote:
> >>> So it looks like fork is translated to __gcov_fork when -std=3Dgnu* i=
s set which
> >>> is why we get this error.
> >>>
> >>> As this appears to be intended behavior for gcc I think the best opti=
on is
> >>> to just rename the function so that we don't run into issues when bui=
lding
> >>> with gnu extensions like -std=3Dgnu11.
> >> Is it sure 'fork' is the only culprit? If not, it is better to address=
 it
> >> properly because this unnecessary name change is annoying when switchi=
ng bpf
> >> prog from clang to gcc. Like changing the name in this .c here has to =
make
> >> another change to the .c in the prog_tests/ directory.
> > We've fixed a similar issue in the past by renaming to avoid a
> > conflict with the builtin:
> > https://github.com/torvalds/linux/commit/ab0350c743d5c93fd88742f02b3dff=
12168ab435
> >
>
> Fair enough. Please post a patch for the name change.

Any suggestions/preferences on what name I should use instead?
