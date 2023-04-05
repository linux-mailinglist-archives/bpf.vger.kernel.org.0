Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7571B6D84F1
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjDER30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDER3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0F5FFE
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:29:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so142965229ede.8
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlr9GDY/QYZYreh5jTzGEQjIFHbYFG6xwUSey6+e7+8=;
        b=ZU5oq3gde2Cf7f1d3N+o6gvZtHkQduptCqlU46dQ35bZ060JLYw07YFDiaHVgeGJ83
         w3tO0jTKi2k8jm+OlJUz9IZDgDS4A2iVb8traj9xrsVWkt6PLT9p2r4xcVFqU/9k3zgX
         vpRRwOfZKIfMdV/R66zqfrIW+zPtJ0zmJUpDdJ2Rf/xBuMdyiKBKA97xjHBK2apze1H/
         6bGqbWyeHjHS4/Zy0sgEAPeeKi79S6a+uc/JFFrm5N/B7xK7vjy1MXLpudaBSFcyfN8J
         raFxThcVckOYiQUrjNtbeXb0aOc72z7uVIiiDTCtxGkh0z5hF9nW2d9Ah9FNspgiQybK
         obbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wlr9GDY/QYZYreh5jTzGEQjIFHbYFG6xwUSey6+e7+8=;
        b=wGn7TjD07s1TOC6a09zwTj6B9t0RWlKaCJ1ga/EwMlAD7ACMMttNqMxtrEKeb2LegR
         Aky8z0eO5efuoJ4QfudImsLVtgZXT0Xzj4qvAbgPeF+Y4wPwNV4XFJ4cPF44I2X0xgAr
         HScv8KRcZlpsCfKBgrNq3JwgVAmLIeWB/jBt0XcJ+3z+Cd+0IZFUvyixV4IA+PihzH9M
         OAInzYici3zWAqyaxwgemiajHcT9DB4vU4X9rHKhZ0MFSmfQHG6jTAwpx08GR0+4v4W6
         7TDXj80ZS0TJ5khM2QyzzayONRz64Qbwkn2E+VrDlHnI88cLHDDcE5w2ahFwS92x+B3z
         glOg==
X-Gm-Message-State: AAQBX9euBF2Uf4hvSfmGVQe4lD3sdv0CfuLXyQhQq9dzOgH5YliFwRYC
        m0ILc/0KTpHagdvtRbYYNMeqIxmUc5BBYduEanfFeg==
X-Google-Smtp-Source: AKy350aj5674HwS7wW9ccS9xIEn5IfuSXxiAq7vXZ47UeZvkjx1qrZI7AOR0OIJThWqMle7GwpVD1/WXqtF7DosohLc=
X-Received: by 2002:a17:906:950a:b0:8e6:266c:c75e with SMTP id
 u10-20020a170906950a00b008e6266cc75emr2085771ejx.14.1680715752149; Wed, 05
 Apr 2023 10:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-15-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:29:01 +0100
Message-ID: <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Drop the log_size>0 and log_buf!=3DNULL condition when log_level>0. This
> allows users to request log_size_actual of a full log without providing
> actual (even if small) log buffer. Verifier log handling code was mostly =
ready to handle NULL log->ubuf, so only few small changes were necessary to=
 prevent NULL log->ubuf from causing problems.
>
> Note, that user is basically guaranteed to receive -ENOSPC when
> providing log_level>0 and log_buf=3D=3DNULL. We also still enforce that
> either (log_buf=3D=3DNULL && log_size=3D=3D0) or (log_buf!=3DNULL && log_=
size>0).

Is it possible to change it so that log_buf =3D=3D NULL && log_size =3D=3D =
0
&& log_level > 0 only fills in log_size_actual and doesn't return
ENOSPC? Otherwise we can't do oneshot loading.

  if PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) >=3D 0:
    return fd
  else
    retry PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)

If the first PROG_LOAD returned ENOSPC we'd have to re-run it without
the log enabled to see whether ENOSPC is masking a real verification
error. With the current semantics we can work around this with three
syscalls, but that seems wasteful?

  if PROG_LOAD(buf=3DNULL, size=3D0, level=3D0) >=3D 0:
    return fd

  PROG_LOAD(buf=3DNULL, size=3D0, level=3D1) =3D=3D ENOSPC
  PROG_LOAD(buf!=3DNULL, size=3Dlog_size_actual, level=3D1)
