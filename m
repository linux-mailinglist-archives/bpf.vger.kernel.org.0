Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B76E025E
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDLXO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDLXOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 19:14:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4776B7;
        Wed, 12 Apr 2023 16:14:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94cfe3db2aaso171796666b.0;
        Wed, 12 Apr 2023 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681341257; x=1683933257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rzqhflXs2sKlbc9U0/VlmynvyEPb+8EutECMjFY3IA=;
        b=po86E+jVhQ7bFFpc43narTaa9Mvifh3K6nq8j3IADaXwqdrSGCzw1ySp3z2t/Yybcu
         vMphPD0vSAuIi1HfhdJzpFNPRYsFXXxFPpPDDqf3D14IXZBHD1bKORBXvb3MvQWckWEo
         W+ECuUw7rrGtxtMsjNThJjBd3Ea4sSMpf2WD6T9Y456LvVM1gTzIi/NbKWILdx6nVikQ
         6d2w3DcDv3VPHcqagk2kg+4qUw/blq3rBYgBX5VG5HS5mMrgmPuk6v8qzrUN/YlobLFp
         TfkyQuDCsYCcgR0Rbc9n8rAPKeRLzOtJBCmRBRqWFECeIZ6XjQxsIRqscgu1CdPfyTtW
         aepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681341257; x=1683933257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rzqhflXs2sKlbc9U0/VlmynvyEPb+8EutECMjFY3IA=;
        b=hI3/WoZOo5zdSd6sEbJ5VvruebY8zyo3+sq9kRnNzfJf1c8Q3yBypr+NNwY4uniYSy
         Ea3AhkFChDS46t8HqnS3dD8GuSOeY3973hf1U+R0ycxbYypo0oygFxnqwEPlKMdHe3Fy
         OCS3BQrJ6/A5ao3YnLZLpPIZqT9H19xyiN7oQy2orxJCDdCaWWbahOSAy1tZtaujEPxG
         pnK1w+3P3uca6mtjOkTvfuP4/OnN52dkhCutTxWxYy6qVbCB/eT4MF8SMAaTVpN2sObF
         Dywq58B7G2t4uCs3yZh4EdTud1hd7ocQ3Sgib2OrToPEwONQhh5Qd+Zgvx1L4sKlM26F
         u/Kw==
X-Gm-Message-State: AAQBX9edenXiStuFlmX+goHTYqLfc8gVM13o/1izGjJ/AS70AdxhF4K4
        B65PwRK7Yh1wBrJBj9S6/WtmsznklZYPy7S2RbY=
X-Google-Smtp-Source: AKy350ZkFrdFTmGeQYowsoBeoz70MACQiknRJcY05IkkSxjbGhYGCG/8WN7tKQuGrZP6H4+vtFD5Z7WxoeQO7iET0HM=
X-Received: by 2002:a50:9eca:0:b0:506:34d8:c710 with SMTP id
 a68-20020a509eca000000b0050634d8c710mr180546edf.3.1681341256658; Wed, 12 Apr
 2023 16:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZDWAcN6wfeXzipHz@gofer.mess.org>
In-Reply-To: <ZDWAcN6wfeXzipHz@gofer.mess.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 12 Apr 2023 16:14:05 -0700
Message-ID: <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
Subject: Re: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
To:     Sean Young <sean@mess.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
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

On Tue, Apr 11, 2023 at 8:45=E2=80=AFAM Sean Young <sean@mess.org> wrote:
>
> Make it possible to load lirc program type with just CAP_BPF.

Is it safe?
If the user can load with just CAP_BPF the FD to the prog and target_fd
will allow attach as well.


> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  kernel/bpf/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index adc83cb82f37..19d9265270b3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2439,7 +2439,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_ty=
pe prog_type)
>         case BPF_PROG_TYPE_LWT_SEG6LOCAL:
>         case BPF_PROG_TYPE_SK_SKB:
>         case BPF_PROG_TYPE_SK_MSG:
> -       case BPF_PROG_TYPE_LIRC_MODE2:
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>         case BPF_PROG_TYPE_CGROUP_DEVICE:
>         case BPF_PROG_TYPE_CGROUP_SOCK:
> --
> 2.39.2
>
