Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D96DA60B
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjDFXAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDFXAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:00:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82669213D;
        Thu,  6 Apr 2023 16:00:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-944bd1d58easo143596666b.0;
        Thu, 06 Apr 2023 16:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680822041; x=1683414041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi05o+/wIqfjwsC6Ux6SGoxSck3jhlcodGAJhg+oXBk=;
        b=JSziECDRBB8uStmFPZbr/gNNDgw3wZBhvaXD14g6jmvJLfOmDr8Dm34YnGR6LHzx1f
         ntG9Rwg5k4ZEKxdwadSN4L+qQcTkRUNU68kn9tN1F2OcKtHjPtitYGQR2qsN56DM40J/
         jejCtQtuoVnVgoDRauMOX5lFMOmJNNnT/BWSP1uSMrMeN6ybkIYu8AqV5kpLNrCyHum5
         SDPYYdJSKxWe7ZoW8O18D0QlDmqPrnIIPYitH9P/PLXVmGsek389cp0b3p/JnjMylu7r
         SQfIO2vVx/Kr9Eo/4cCcU8rcGSYXKpn4VT5J35yxuzS+DWO/t2JOBk/E8IjZ+lSXnJmB
         fcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680822041; x=1683414041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pi05o+/wIqfjwsC6Ux6SGoxSck3jhlcodGAJhg+oXBk=;
        b=10Rc2nZnuBHEQ8r7OaB3QDVuX0yTognNqNungQmWo2u809v0xZ2X0IMbDM3Vfqq6U2
         gscQzuQ/VPZNrt7d5TjINKEo+vGns4RiTcfmTCx1Zvl2VlKWWGvUCQgu2cmnRM1ZwpcY
         4M43RTGGx1oBwLCbT+GTvmhyqgc8YAToIdQ71AaJ1cgQzI/BQOs7J4vo10ZokCW3yJgN
         L9GHvRinOHRZedvOEF34+w4jxOHsIYxaTFdPKuoGAYJNLwmSUL4Qkolps1tJ3DYy9kUg
         GzNZruV76+wJr3nSxC4cNW0Sy9CBFufVYiOWQbdiNrye9BVM5EodBOGuTKF86LxOiK50
         p8XA==
X-Gm-Message-State: AAQBX9ct7jiyqoLRfDw65M8DIMqbz/YhlFPvyEnpLu0MRiC+YEoX+fiM
        0eRvznFZms6SN6lk1/wsezqaZPuCMsVNgwQWUXLFnSpMzyc=
X-Google-Smtp-Source: AKy350bh45yYwqVphkeJknQlcNpvKbWeT11aOvhLw9J5VHA3SrUw/lO64P13Dl9Eo7kpYpBL/zD+0J3JKoF48QwyqNc=
X-Received: by 2002:a50:d6da:0:b0:502:148d:9e1e with SMTP id
 l26-20020a50d6da000000b00502148d9e1emr550905edj.3.1680822040777; Thu, 06 Apr
 2023 16:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230405225246.1327344-1-brho@google.com>
In-Reply-To: <20230405225246.1327344-1-brho@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 16:00:29 -0700
Message-ID: <CAADnVQJ7tG-b_+F7HnrhJ0e-p=PkvymHfQPWybVO2icSiV84aw@mail.gmail.com>
Subject: Re: bpf: ensure all memory is initialized in bpf_get_current_comm
To:     Barret Rhoden <brho@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 3:53=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> BPF helpers that take an ARG_PTR_TO_UNINIT_MEM must ensure that all of
> the memory is set, including beyond the end of the string.
>
> Signed-off-by: Barret Rhoden <brho@google.com>

The patch looks fine, but please rebase to bpf-next and resubmit
with [PATCH bpf-next] subj, so it goes through BPF CI.

See Documentation/bpf/bpf_devel_QA.rst
