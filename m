Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C66B16CA
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 00:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCHXvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 18:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHXvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 18:51:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52E6A51
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 15:51:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id cp12so428813pfb.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678319462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYKlfh+HAtjIDTpkaO/3hDs0LAn1Lpyx+bEm1IFjieU=;
        b=NfF33TrISaxWD0NjymNOrgtkhu3GOJixW9X1lm8oIhoqkOIdBZ3rrzsVXs2y3ZEALJ
         gGO80wYHXllWMqM3hbvSyoJAWpy/qUL/6+lJsbV4qFWxC+6L2VTG2M+TB+2cBedATrma
         adLcIeuLzzyNgDrbUD4oMzJOZ6tv1jkdFamyxITY7JeLJTEEBJ7Iis7Mdo5nd8dMSum2
         uDpG1bSoQPVeBn0gix5zqUE9l4H+J3PUOeSoZP+C/J2k3hj8Wi0esIMsGUo/+ooSHuRH
         4d/lwmqu39FUaFTxx84Q2PA1Vg7DxSSFYzy7K+4FbFcSqdy4Xm6/3w4X/EuTUStE3fri
         7WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678319462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYKlfh+HAtjIDTpkaO/3hDs0LAn1Lpyx+bEm1IFjieU=;
        b=7msnDEQ49GxErU6O+a2TeuzlEiu6KDQop5/+BYwIl8zs3I1BfFSz/7FdFE/TzDntx9
         OVI/WMUXO6pdrBqwjUYGZ+UFvmCA78+eUnquwMD/PsQG4MkUDuALNLWYVOpUAMlME4yx
         XulfaUZcZpofsvaN/4xzUeDCzO7L0wwpOTQesUBvVl2PyUWdlNz3YADWTZQQ6TSuGPlV
         vCidVR2pnR+LCTJrfHcofEJgnnwfujiCy/++0WsyL+3d1bYvHDYuK42dnFX5XUyZWn3O
         D07ybLnhB1LaKo/BVAPujiAOXge6GdjXPX5JX/RwYEfnmieJE3dJ+4uL5ddOUYwtuIOl
         2Uow==
X-Gm-Message-State: AO0yUKUZU5lPJOW6CaFsPp3HlqFeZxBspBNxQtVHYUNrjF7GZ7vLJfUD
        oNEdP4IYWfTKPEu4myArTRHk30LL78hzDcYvR+bBxeOgX7lamth/A6g=
X-Google-Smtp-Source: AK7set+bNLtddEIYlEzfwB1LldKSWaJfYZbijc7C/pHCnT9KJDFLB8n327Y07PDfEeAk+hHSeCFAD3jRKdlKb9GLHRE=
X-Received: by 2002:a63:543:0:b0:507:3e33:4390 with SMTP id
 64-20020a630543000000b005073e334390mr4460349pgf.6.1678319461723; Wed, 08 Mar
 2023 15:51:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
In-Reply-To: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
Date:   Wed, 8 Mar 2023 15:50:50 -0800
Message-ID: <CAK4Nh0iEP5CAAe+i6o5AT=V=EfX2fW2FmoGCfU3+OgR1f-GMAg@mail.gmail.com>
Subject: Re: Broken build on 6.3-rc1 with uClibc-ng based toolchains due to
 poisoned strlcpy
To:     rongtao@cestc.cn, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(+bpf folks, -perf folks)

Please see below.

On Wed, Mar 8, 2023 at 11:28=E2=80=AFAM Jesus Sanchez-Palencia
<jesussanp@google.com> wrote:
>
> Hi there,
>
> So commit 6d0c4b11e743("libbpf: Poison strlcpy()") added the pragma
> poison directive to libbpf_internal.h to protect against accidental
> usage of strlcpy. This has broken the build for some toolchains and
> the problem is that some libcs  (e.g. uClibc-ng) provide the strlcpy()
> declaration from string.h, which leads to a problem with the following
> include order:
>
>                  string.h,
>                  from Iibbpf_common.h:12,
>                  from libbpf.h:20,
>                  from libbpf_internal.h:26,
>                  from strset.c:9:
>
> If we patch libbpf_internal.h and move the #pragma GCC poison
> directive to after the include list, we fix the problem but at the
> expense of leaving libbpf.h unprotected (and libbpf_common.h as well,
> of course). We could duplicate the directive on all these other libbpf
> headers after the include list, but that's code duplication so I
> wanted to bring this up here before I send out a patch.
>
> Let me know what you think or if you have any other suggestions, please.
>
> Thanks,
> Jesus
