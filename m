Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0346BC35A
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCPBex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPBes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:34:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C97AA6
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:34:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so1683001ede.8
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678930486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHPrPlhQMXvVIx5yQs1BZudV0Tq662a5tALQ28pCnKM=;
        b=mAqtdeca2p22E35wvY1/4iKixCVK07hdLBG5Ugy4zEY1s9ggOUYObNQVdjHof6MmmH
         9ojw0wblcE/A5lWVrWGiTxJTUUbSS2djzAGPStxpwhI+dfW9B1gvfdcN2dZp3n9a0IXp
         V/kMor6QFxSa2muVrsF3fkRTlTitH57vr2nymhNG29FS7xVEtPmmGNfzIzWCMVlhh9s8
         CP/74Z2X+k0fEaU3bhb7DnVG4TKktcSmanSCGpPRIjxQx/NPHu9oYZWBURK+LDDi51W2
         2DdO2l29KyH53y0jv8q5GYnTIb/pHkuhjhYYZ+BiWGudR12y3+508v9bU8VwkmBB3AgK
         1uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHPrPlhQMXvVIx5yQs1BZudV0Tq662a5tALQ28pCnKM=;
        b=5bqgRPacDI1IEWTa/ltLqLni29z9o2+dtRf9BYi0UWUdiXyTSD8HhGBmtRfq8OOGYV
         tCG2oRc61VHOU9J8hMMBzHIPThusz8SfgC4M0nQ6MOD/JQ0mNLlpfeFwnBP64FmRVukI
         FzbKTRQGYcVO4fSiYfpfJSA12ByihkP8oAc32NVHCTgzNTkunOYK6hGhU1r7r/fZdAlq
         H73xKAPip1qi/guRLR0AEwVH0z4Kzj2xP6U3Z936oqnEi2BLRjWNnB79LOSSLRHrV2V0
         R4oTsSglTqJuP4WAecLwX8LH4LuI7wDMS0oAJoBYUg5i6MEvCRe4IWo4Q68xIPJn3WfS
         7hHA==
X-Gm-Message-State: AO0yUKWXIYuj+b/t2G8QCKZLgUmxmFr8v0xx/N6LccXT/fzf+yWceSyO
        +nNGdnqvQI3sZF75V0Sjp7O/dxft0+Z6sQ1mvM8=
X-Google-Smtp-Source: AK7set+GdpQkZvRck3sX6DqrZU+6C/wb0RTcQ9tapzMOkgKwb84TtZVCTcKq3dFfkpnYyJekTiBEd5RJMwq8IdTYdig=
X-Received: by 2002:a50:874e:0:b0:4fb:2593:846 with SMTP id
 14-20020a50874e000000b004fb25930846mr2512325edv.3.1678930485757; Wed, 15 Mar
 2023 18:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
 <202303160919.SGyfD0uE-lkp@intel.com>
In-Reply-To: <202303160919.SGyfD0uE-lkp@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Mar 2023 18:34:34 -0700
Message-ID: <CAADnVQJ+-ThSUMzEgWu6OtkWB-bdqZKPiRxWUEbL5L=cPjeezg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     kernel test robot <lkp@intel.com>
Cc:     Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Wed, Mar 15, 2023 at 6:32=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Viktor,
>
> Thank you for the patch! Yet something to improve:

Argh. Comma is missing.
Viktor,
please send a fix asap.
