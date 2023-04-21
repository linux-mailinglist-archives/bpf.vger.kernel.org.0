Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D436EB28A
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDUTyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDUTyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 15:54:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEF2139
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:54:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so3448086a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682106847; x=1684698847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlHALrujxFgGoRCAh3zNWpXNj1SzPUhJb5sqr3avcPM=;
        b=a9InM5f892QRoXNjJ4W+LDeJ8weJgnIwCnhuH9ZOVW3m5joPQPEgttBPhVPrtdlNey
         n4hgrIpbltxQbfSQXBdRAA7j/IR0p/SgU6S4Iv5KrjyLjRPnJ2uNFIOsyLrWwpXQjkGG
         w697MFX7P8p/+coZqAR7eiNDOoseJvauPgqo9kMOsJQQk7h8uXr80e5rVg5lKQUlPTsB
         3iSqKjWTZw53haQa+dxLbRmQtfZiyFW6dDOZv/kg7Khmffiiy+Ng/LqfzatwOsMz78nn
         E5GBXWL+a+xu7cq4DZo84PHoUvZufHByD9pu4LrMGY6hjXKZlDDEftJj/HllJr6jDFKT
         KVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106847; x=1684698847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlHALrujxFgGoRCAh3zNWpXNj1SzPUhJb5sqr3avcPM=;
        b=dT9XfeaG9/9tk1xJEHaBX1hOqG/0obM5bRps0ZEwnxgRcZvdY58Hl711SnMGoRWjR1
         xt1V4NGfrim6eLfKpGT74voAlX8HXo7YTQOuNEtweiVTmx9JWftwMGgSOiPEle3k1iJw
         NIFnDVuTS84mcN4rvdlkE0efJ2W4n719dJ0rkEVlblfdEnrtF5yNr4m52+dz112iXp4k
         mQ476HRP5Bv2gHC8SI8ZqcX0HF9eAVJ3SEFka2d08EwnwC5reWTtRmAATjzAe0AWlKLa
         kyjYidVGCq1dFuWgWrj1OJTCHjnRxkLhzw6vALjA3wUEqv/MNDZao4eVL+c/wTtlpb+1
         Ghwg==
X-Gm-Message-State: AAQBX9dXU6DQGhZuVU6KAG01q4w/fpmHkL2KN6UgqKkyy60NpJ1nC9gP
        UzMrEjlhxybTpSsUEHX0LT414FTKsWMoIBB42SE=
X-Google-Smtp-Source: AKy350YDtMiEEUM8ngNj0Bw+7FMrHl5D2b2zVj9dR9WrfiL/2uq42wiLpobt7ZEUAtg9k7z3+OBHsfHM/kWw6eETiUA=
X-Received: by 2002:a05:6402:1a42:b0:506:8838:45cc with SMTP id
 bf2-20020a0564021a4200b00506883845ccmr5437622edb.6.1682106846731; Fri, 21 Apr
 2023 12:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174234.2391278-1-eddyz87@gmail.com> <168210602402.3425.11823949766258477429.git-patchwork-notify@kernel.org>
 <9af634d411efb069f64072ddd921cdf3bcb20917.camel@gmail.com>
In-Reply-To: <9af634d411efb069f64072ddd921cdf3bcb20917.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 12:53:55 -0700
Message-ID: <CAADnVQJ_WgLApnzc_pLvF6gfJP8d1dhQ2=7pC9qSAV4o3dbqXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/24] Second set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Fri, Apr 21, 2023 at 12:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2023-04-21 at 19:40 +0000, patchwork-bot+netdevbpf@kernel.org wro=
te:
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Alexei Starovoitov <ast@kernel.org>:
>
> Hi Alexei,
>
> Thank you for merging these changes!
>
> I've noticed that email from the bot does not list
> commit hashes for patches #13,14 (precise, prevent_map_lookup).
> And these commits are indeed not in git [1].
> Is this intentional?

Yes. See other reply.
