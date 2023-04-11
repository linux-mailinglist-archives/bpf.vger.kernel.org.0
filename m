Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27D6DD830
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDKKpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDKKos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:44:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C440CC
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso21108090a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKwu/y0deoV1D03MTliH6tgm4fwQimQ/hW8kSkb4Bo8=;
        b=ESzjdvURXYzmDKGDzWSqbsAzgmnIb1GLmSshPWS5LFmBVNzfhmH+UsJ8ekBJ/kQlQM
         GAUmc5SA/4UU6C7jmwrjW5toc01VNb/lJRN5cRb4FmwsEhQijNdDrhAael6o5WRPvdGH
         OXueXr/oAxtD3RjNPb+QcNp0MuhDiEHq+/fZ3mYplKXqU3PhZBR0PToqhi/81mWjExjE
         JKBUMY2ISOiBVx3JwYnsugvzCWKIrp+kp/gbVb3Q8VppRJXVLraojq/IBCMRX6Nnb+DW
         wRl5TL1y0kF6sDp5PseVaVNfvKTikneBtcF1Prs1NPLV5dnIMqvG8uIMYOuEqctsWsCu
         RFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKwu/y0deoV1D03MTliH6tgm4fwQimQ/hW8kSkb4Bo8=;
        b=dGrSvUUm7aNtev1Qkezny49kUkXFkaBTUmGy1oErPLwg+yrshR1DIZ3MriKofKijFE
         LcIui6ddBW5AOFXryfLAaX0ZjCuSr62bv5y87umn6u12WGN3RailmTNJXvyFaStDZfYb
         Km4bUxb1C/YAjWuMjznyj4fvKDoYMnG8t8ysjVgUVutnPQ/N3rA9MqFbL96irUdV797l
         LNdO2/dfNAWxeIKToYWH5eFAB0mBTG80IlwZhTgVWODkHAVsrIZEMlXGY5n7WfxksY3s
         WIqfuaba0DsKgEWU9Tlavx5nNW+DT3jrGVU3dgZ1dumty3KDsgC99wazsTeVZI3lFLXj
         Ru6Q==
X-Gm-Message-State: AAQBX9c3SplId4pvOvyelJeB7RWGSMsnIPqBw05QB6z2AlLSgyLvjhDO
        vzlEb5QCGbnvoUoDhYcRgpstS2JZmdq8rej5CYrCmQ==
X-Google-Smtp-Source: AKy350bM1ClPleaybFiWZNiYuYms0fiqCbPwe7nr/Puvj6IVwp0FHXJudauJtQxirhMlJ5QNM6UX7RYHMtHcn6s13UE=
X-Received: by 2002:a50:d703:0:b0:4fb:7ccf:337a with SMTP id
 t3-20020a50d703000000b004fb7ccf337amr6561481edi.3.1681209859660; Tue, 11 Apr
 2023 03:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-12-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-12-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:08 +0100
Message-ID: <CAN+4W8jgQ28Lw+o9S=hVSdJOS7vcvqE3QUSu6vh0LmB8hUAZkQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 11/19] bpf: keep track of total log content
 size in both fixed and rolling modes
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

On Fri, Apr 7, 2023 at 12:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Change how we do accounting in BPF_LOG_FIXED mode and adopt log->end_pos
> as *logical* log position. This means that we can go beyond physical log
> buffer size now and be able to tell what log buffer size should be to
> fit entire log contents without -ENOSPC.
>
> To do this for BPF_LOG_FIXED mode, we need to remove a short-circuiting
> logic of not vsnprintf()'ing further log content once we filled up
> user-provided buffer, which is done by bpf_verifier_log_needed() checks.
> We modify these checks to always keep going if log->level is non-zero
> (i.e., log is requested), even if log->ubuf was NULL'ed out due to
> copying data to user-space, or if entire log buffer is physically full.
> We adopt bpf_verifier_vlog() routine to work correctly with
> log->ubuf =3D=3D NULL condition, performing log formatting into temporary
> kernel buffer, doing all the necessary accounting, but just avoiding
> copying data out if buffer is full or NULL'ed out.
>
> With these changes, it's now possible to do this sort of determination of
> log contents size in both BPF_LOG_FIXED and default rolling log mode.
> We need to keep in mind bpf_vlog_reset(), though, which shrinks log
> contents after successful verification of a particular code path. This
> log reset means that log->end_pos isn't always increasing, so to return
> back to users what should be the log buffer size to fit all log content
> without causing -ENOSPC even in the presence of log resetting, we need
> to keep maximum over "lifetime" of logging. We do this accounting in
> bpf_vlog_update_len_max() helper.
>
> A related and subtle aspect is that with this logical log->end_pos even i=
n
> BPF_LOG_FIXED mode we could temporary "overflow" buffer, but then reset
> it back with bpf_vlog_reset() to a position inside user-supplied
> log_buf. In such situation we still want to properly maintain
> terminating zero. We will eventually return -ENOSPC even if final log
> buffer is small (we detect this through log->len_max check). This
> behavior is simpler to reason about and is consistent with current
> behavior of verifier log. Handling of this required a small addition to
> bpf_vlog_reset() logic to avoid doing put_user() beyond physical log
> buffer dimensions.
>
> Another issue to keep in mind is that we limit log buffer size to 32-bit
> value and keep such log length as u32, but theoretically verifier could
> produce huge log stretching beyond 4GB. Instead of keeping (and later
> returning) 64-bit log length, we cap it at UINT_MAX. Current UAPI makes
> it impossible to specify log buffer size bigger than 4GB anyways, so we
> don't really loose anything here and keep everything consistently 32-bit
> in UAPI. This property will be utilized in next patch.
>
> Doing the same determination of maximum log buffer for rolling mode is
> trivial, as log->end_pos and log->start_pos are already logical
> positions, so there is nothing new there.
>
> These changes do incidentally fix one small issue with previous logging
> logic. Previously, if use provided log buffer of size N, and actual log
> output was exactly N-1 bytes + terminating \0, kernel logic coun't
> distinguish this condition from log truncation scenario which would end
> up with truncated log contents of N-1 bytes + terminating \0 as well.
>
> But now with log->end_pos being logical position that could go beyond
> actual log buffer size, we can distinguish these two conditions, which
> we do in this patch. This plays nicely with returning log_size_actual
> (implemented in UAPI in the next patch), as we can now guarantee that if
> user takes such log_size_actual and provides log buffer of that exact
> size, they will not get -ENOSPC in return.
>
> All in all, all these changes do conceptually unify fixed and rolling
> log modes much better, and allow a nice feature requested by users:
> knowing what should be the size of the buffer to avoid -ENOSPC.
>
> We'll plumb this through the UAPI and the code in the next patch.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Lorenz Bauer <lmb@isovalent.com>
