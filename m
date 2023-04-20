Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FA6E9B6D
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDTSRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTSRT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 14:17:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B626D30DF
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 11:17:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24782fdb652so937741a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682014637; x=1684606637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfkHvhHLYPgY+Mj4mBbrqBeiHu1eQoHkhSwNn/be28M=;
        b=Z8tykE3fpqmb+P6zqbo6La2hfwS1WNxLq8sZLrXio4ZegQtph6LW/xuru2JfpFWAa3
         joBbqMiU+eq7tk+CmvtcX4aOc1r76fvap9hNHQpFAlZ1WALvklJonlqw9aAsLSIhO3gl
         3mX/VVbyTI9SWoUQ8cGbRegNnH/KIdSmH3qRF0CkbiVJq7z8BJ+8yOFULjOVyXFobXWF
         frmi9N/wCy6AeE0S1l7NdiT46F33Y06oT2QvfY8Y2+h+qFo9D+h8p8kn6AbdQVeNMNG3
         Gzyk53RfYt+7I8QFlRfz8o5KLGVX6uqRGDMrGb55EvC5D1lBkD91mTo5Z6F4x+Ga48u4
         cX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014637; x=1684606637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfkHvhHLYPgY+Mj4mBbrqBeiHu1eQoHkhSwNn/be28M=;
        b=L1o+YGjmMKS6ty2xiyCY0VYkze73fOomI8iSvTkJ9PTbL/gPpf/LDzhCH4CRPExLZv
         7YdEcHbZLi7jxRD5f0vFr8RBrRCFQ9Exv9UdR3VGJemmKBYPzxZVoUFZRoPPd9w+aLFY
         E5zx7nDnb/WH7UXZfw7/coFRF+M+PmKkkpMEAO3PiadriUE1c9jO4Ro+iXbe08HcCKil
         ej0Y6inG3VMrHUMqrqVSvsjY+XMTUyGCT8cR8FaVrNiorJusmGwHgZEOgyoTMP86gy5W
         rSKuvtwIiSApW/1+bMvUNKMqYlRX3DQILL707GenwYxRCOSuZ1YKpqB7bCShzXeZvZoY
         vECw==
X-Gm-Message-State: AAQBX9fsY96PwVvg12Ln3PjdbEnVUPR63OnVyxXi8op5Isp+kxfYTGYp
        X+9s1nJ2diCY0SblHxRryJls8KBoKm44B1AFL9EwIw==
X-Google-Smtp-Source: AKy350b7/7/1V2E+kSv94YWLIAfn4IsMkbuS3qcJN2Bk+XprwLXtBhWtAC6rGESQBvsSf7tZB/N6L2vn9HKvsVQ/aqg=
X-Received: by 2002:a17:90a:688f:b0:247:8ce1:996e with SMTP id
 a15-20020a17090a688f00b002478ce1996emr2448419pjd.29.1682014637039; Thu, 20
 Apr 2023 11:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225343.553806-7-sdf@google.com> <202304200301.XukL6sTb-lkp@intel.com>
In-Reply-To: <202304200301.XukL6sTb-lkp@intel.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 20 Apr 2023 11:17:05 -0700
Message-ID: <CAKH8qBuujEFVR5BqO21YWYT2PqBMbNVJ1aznxtZaTYusOXgPaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/6] bpf: Document EFAULT changes for sockopt
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 19, 2023 at 1:08=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Stanislav,
>
> kernel test robot noticed the following build warnings:

Stupid me using ``` blocks instead of code-block:: c. Will address
once I hear some feedback on the rest of the patches.

> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev=
/bpf-Don-t-EFAULT-for-getsockopt-with-optval-NULL/20230419-065442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230418225343.553806-7-sdf%40go=
ogle.com
> patch subject: [PATCH bpf-next 6/6] bpf: Document EFAULT changes for sock=
opt
> reproduce:
>         # https://github.com/intel-lab-lkp/linux/commit/789f0fbf25934464a=
e56e0022939fc77d4615d65
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Stanislav-Fomichev/bpf-Don-t-EFA=
ULT-for-getsockopt-with-optval-NULL/20230419-065442
>         git checkout 789f0fbf25934464ae56e0022939fc77d4615d65
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONF=
IG_WARN_ABI_ERRORS
>         make htmldocs
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304200301.XukL6sTb-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Documentation/bpf/prog_cgroup_sockopt.rst:115: WARNING: Unexpected ind=
entation.
> >> Documentation/bpf/prog_cgroup_sockopt.rst:111: WARNING: Inline literal=
 start-string without end-string.
> >> Documentation/bpf/prog_cgroup_sockopt.rst:111: WARNING: Inline emphasi=
s start-string without end-string.
> >> Documentation/bpf/prog_cgroup_sockopt.rst:121: WARNING: Block quote en=
ds without a blank line; unexpected unindent.
> >> Documentation/bpf/prog_cgroup_sockopt.rst:159: WARNING: Title level in=
consistent:
>
> vim +115 Documentation/bpf/prog_cgroup_sockopt.rst
>
>    110
>  > 111  ```
>    112  SEC("cgroup/getsockopt")
>    113  int getsockopt(struct bpf_sockopt *ctx)
>    114  {
>  > 115          /* Custom socket option. */
>    116          if (ctx->level =3D=3D MY_SOL && ctx->optname =3D=3D MY_OP=
TNAME) {
>    117                  ctx->retval =3D 0;
>    118                  optval[0] =3D ...;
>    119                  ctx->optlen =3D 1;
>    120                  return 1;
>  > 121          }
>    122
>    123          /* Modify kernel's socket option. */
>    124          if (ctx->level =3D=3D SOL_IP && ctx->optname =3D=3D IP_FR=
EEBIND) {
>    125                  ctx->retval =3D 0;
>    126                  optval[0] =3D ...;
>    127                  ctx->optlen =3D 1;
>    128                  return 1;
>    129          }
>    130
>    131          /* optval larger than PAGE_SIZE use kernel's buffer. */
>    132          if (ctx->optlen > 4096)
>    133                  ctx->optlen =3D 0;
>    134
>    135          return 1;
>    136  }
>    137
>    138  SEC("cgroup/setsockopt")
>    139  int setsockopt(struct bpf_sockopt *ctx)
>    140  {
>    141          /* Custom socket option. */
>    142          if (ctx->level =3D=3D MY_SOL && ctx->optname =3D=3D MY_OP=
TNAME) {
>    143                  /* do something */
>    144                  ctx->optlen =3D -1;
>    145                  return 1;
>    146          }
>    147
>    148          /* Modify kernel's socket option. */
>    149          if (ctx->level =3D=3D SOL_IP && ctx->optname =3D=3D IP_FR=
EEBIND) {
>    150                  optval[0] =3D ...;
>    151                  return 1;
>    152          }
>    153
>    154          /* optval larger than PAGE_SIZE use kernel's buffer. */
>    155          if (ctx->optlen > 4096)
>    156                  ctx->optlen =3D 0;
>    157
>    158          return 1;
>  > 159  }
>    160  ```
>    161
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
