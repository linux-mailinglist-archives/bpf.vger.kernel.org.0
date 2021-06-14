Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865903A6C79
	for <lists+bpf@lfdr.de>; Mon, 14 Jun 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhFNQ4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 12:56:31 -0400
Received: from mail-pl1-f226.google.com ([209.85.214.226]:37400 "EHLO
        mail-pl1-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhFNQ4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Jun 2021 12:56:31 -0400
Received: by mail-pl1-f226.google.com with SMTP id h12so6894646plf.4
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 09:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=efVDtLyYl6Rfag2Jmdz2WmCO2ZqRbPjkeEymvW563ok=;
        b=ZP3yUSOlWcbJZyP/8mwxSV+a79oZKfmwa4B2Uw40D2dy5EU/YPGaK7vSx6nL2D4+RI
         N5GqobeC8tlV2Sx7bpl3F72y5PgUi9fpEOh8IT3HJtvfdfWKegbqAxgEXvj9WP/Yd1x9
         BZZm+yVGL1V687FF+ar2HP2F/tQuB3yAZdfL3pK6zNSRevLZZLLGNb0HAaD70MrFVT9K
         31d7sMhMYoo4WVihQPVSr0Mo1qOIuJL6HEumnvEukQn5o9PE+B5eEVSMtwfCC235niPq
         nmAeRomMNiP46V1k/Un2W0UqJ/x7vMpHp3vj0AlhlRaINxnHjLevEZysH+WRXhQVpX4n
         Ym2w==
X-Gm-Message-State: AOAM5300orygB+r8BVfhhNplF89O68KX+eOr7R/HN7QiEC21NpNwllJi
        WNd8fY5W5rJu6fMzgHbK5yp82cdHJvM2D+IdNNkHRLUXzojVpg==
X-Google-Smtp-Source: ABdhPJzAu/2n2nLch3EiXpuIRFXwQ4fI6th/nq1GjESKK3hKUTgLRPjDX33ti7Q50XDCiIyZAyHUJNjildOt
X-Received: by 2002:a17:90a:fd86:: with SMTP id cx6mr67143pjb.148.1623689608328;
        Mon, 14 Jun 2021 09:53:28 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.170])
        by smtp-relay.gmail.com with ESMTPS id c10sm3544731pjn.8.2021.06.14.09.53.27
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:53:28 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (34.202.62.171)
    by restore.menlosecurity.com (34.202.62.170)
    with SMTP id 09eb01a0-cd31-11eb-b2d6-4f7e48d1f4a9;
    Mon, 14 Jun 2021 16:53:28 GMT
Received: from mail-ej1-f70.google.com (209.85.218.70)
    by safemail-prod-02780031cr-re.menlosecurity.com (34.202.62.171)
    with SMTP id 09eb01a0-cd31-11eb-b2d6-4f7e48d1f4a9;
    Mon, 14 Jun 2021 16:53:28 GMT
Received: by mail-ej1-f70.google.com with SMTP id w1-20020a1709064a01b02903f1e4e947c9so3267998eju.16
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efVDtLyYl6Rfag2Jmdz2WmCO2ZqRbPjkeEymvW563ok=;
        b=AZxLqFXPuMNGkhob/AEpyTD2okOs8e/CQA5jiBOULAHHsIM3hLBXfkxxinkgJZsbBJ
         zdQXcNHrZ4N7gL6rnT1l6Lxyq+9lALl9mqeGENxAkiNqM3G7uDoexRuEleexti3WPVN5
         x4AYWSu/up6KFLq44QF9SiqdaJPpYduqXttqc=
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr16644892ejb.188.1623689605406;
        Mon, 14 Jun 2021 09:53:25 -0700 (PDT)
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr16644884ejb.188.1623689605313;
 Mon, 14 Jun 2021 09:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com> <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net> <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com> <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
 <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com> <CA+FoirARDoWWpif2tw47BG0Rh5+uBpsoVZ7Y05JnZO2UqBDSEw@mail.gmail.com>
 <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com> <ae33242e-25c0-744b-6060-4cdecb32e3dc@gmail.com>
In-Reply-To: <ae33242e-25c0-744b-6060-4cdecb32e3dc@gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Mon, 14 Jun 2021 09:53:14 -0700
Message-ID: <CA+FoirAZ-cQKoTabFK9RemhLuNqZL462D=B8EwdPO9tiE-4B5Q@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I do not have the time or hardware at the moment to do the testing - or
> create the selftest for it. If you do have the time for the selftest, we
> can tag team it.

Sure I can definitely do what I can but you'll need to walk me
through, since I am not sure what I is needed.
Can you point me in the right direction?

Cheers,
Rumen Telbizov
