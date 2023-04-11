Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9F6DD7F1
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDKK2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDKK2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:28:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954A10CF
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:28:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50479981ed6so2420824a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681208898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNUtwEbKoQRqfWR8YWdCgF9nphEY6ojWOBnwrnoW0qA=;
        b=INUeyPdqzAcqJYb02UOC1fpZZHWDGrRJ4kl5TlTetM0RUWdkjNYWj8WTbZ6t4vWMHg
         vXUvbB9RTPZ/qU8GwxtbQ+iVXFCoUt5XZCtMIgPxBrNvcblHEaQO/eXGkSsfwKC9jiO1
         0f6/86zOGWp1dxX/tDKEOkyNh4AyZ3tZYOEGEKR4SoAInNyABEI/MVEzo4gJ4BgsfC3w
         jDgFDigzKAzQRhOAGmf/IJdkPoOd6ExkI01xAcL4Zta3l7qAFlvXhD7039VEGYf68D63
         hHaaDKaoshpEL3p4YW7j7dIAVollb7p2E+Nv1iCoa1fPDgRM2pwXYxPZMvviV9kJhmEP
         V6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNUtwEbKoQRqfWR8YWdCgF9nphEY6ojWOBnwrnoW0qA=;
        b=KkUMD5TilnAmM3V9oXW++OK+gQBNh16gh9JciHS4T7roubbX1DpUjNyQ9SGhlvMWYY
         lAhsYRIMJ+URBZxV+qW7Epa+fMiOnjjJVIQrDRmdkXVbt79T2hMaqj+5vdc+7nbOELtZ
         I4sPe8wkfoOnRjTw2GdfxHp2xJjck4p+WEVTcm78eJzQ7pnLHew9qf7ljxcs/MN9W7Dm
         QDes/XoZxbhCdEYZy/M1TRVttHcPxo7KSrVXiNIBTDuDfT6ZIgqas/0zhm+yHEn5ZlOA
         kI5mfH/jW/mu0Id7y+QCuyoK1GFqFER7xDFGROwIaUEBk7ReX+fOIe95hLadJmGiDc/4
         NPCA==
X-Gm-Message-State: AAQBX9fyx/1vEOCzzRFuCa2s+FH4j5wqy2P14oWnTu4ozjlQiQ+PHgJV
        D5gyv6QGSVBnNmgMn35aawRdVC9xlfX7t2Au+p34OA==
X-Google-Smtp-Source: AKy350Y5L6ThPZ/ynhluW+nrBAn0/BRV+f+OGh5k+EKSdNvfrU/3msoznbHy4E6+rKTL/SOojULfnAcdw7WBQ4jfHp8=
X-Received: by 2002:a50:a417:0:b0:4fb:482b:f93d with SMTP id
 u23-20020a50a417000000b004fb482bf93dmr6205962edb.2.1681208898198; Tue, 11 Apr
 2023 03:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-4-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-4-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:28:06 +0100
Message-ID: <CAN+4W8h2c9CMtAR31BO0GRTXb-z-MaSQFL8u_A4P16xMag6+nA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/19] bpf: switch BPF verifier log to be a
 rotating log by default
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

On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Currently, if user-supplied log buffer to collect BPF verifier log turns
> out to be too small to contain full log, bpf() syscall returns -ENOSPC,
> fails BPF program verification/load, and preserves first N-1 bytes of
> the verifier log (where N is the size of user-supplied buffer).
>
> This is problematic in a bunch of common scenarios, especially when
> working with real-world BPF programs that tend to be pretty complex as
> far as verification goes and require big log buffers. Typically, it's
> when debugging tricky cases at log level 2 (verbose). Also, when BPF prog=
ram
> is successfully validated, log level 2 is the only way to actually see
> verifier state progression and all the important details.
>
> Even with log level 1, it's possible to get -ENOSPC even if the final
> verifier log fits in log buffer, if there is a code path that's deep
> enough to fill up entire log, even if normally it would be reset later
> on (there is a logic to chop off successfully validated portions of BPF
> verifier log).
>
> In short, it's not always possible to pre-size log buffer. Also, what's
> worse, in practice, the end of the log most often is way more important
> than the beginning, but verifier stops emitting log as soon as initial
> log buffer is filled up.
>
> This patch switches BPF verifier log behavior to effectively behave as
> rotating log. That is, if user-supplied log buffer turns out to be too
> short, verifier will keep overwriting previously written log,
> effectively treating user's log buffer as a ring buffer. -ENOSPC is
> still going to be returned at the end, to notify user that log contents
> was truncated, but the important last N bytes of the log would be
> returned, which might be all that user really needs. This consistent
> -ENOSPC behavior, regardless of rotating or fixed log behavior, allows
> to prevent backwards compatibility breakage. The only user-visible
> change is which portion of verifier log user ends up seeing *if buffer
> is too small*. Given contents of verifier log itself is not an ABI,
> there is no breakage due to this behavior change. Specialized tools that
> rely on specific contents of verifier log in -ENOSPC scenario are
> expected to be easily adapted to accommodate old and new behaviors.
>
> Importantly, though, to preserve good user experience and not require
> every user-space application to adopt to this new behavior, before
> exiting to user-space verifier will rotate log (in place) to make it
> start at the very beginning of user buffer as a continuous
> zero-terminated string. The contents will be a chopped off N-1 last
> bytes of full verifier log, of course.
>
> Given beginning of log is sometimes important as well, we add
> BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> tools like veristat to request first part of verifier log, if necessary.
> BPF_LOG_FIXED flag is also a simple and straightforward way to check if
> BPF verifier supports rotating behavior.
>
> On the implementation side, conceptually, it's all simple. We maintain
> 64-bit logical start and end positions. If we need to truncate the log,
> start position will be adjusted accordingly to lag end position by
> N bytes. We then use those logical positions to calculate their matching
> actual positions in user buffer and handle wrap around the end of the
> buffer properly. Finally, right before returning from bpf_check(), we
> rotate user log buffer contents in-place as necessary, to make log
> contents contiguous. See comments in relevant functions for details.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Lorenz Bauer <lmb@isovalent.com>
