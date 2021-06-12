Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBC3A4B92
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 02:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFLAC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLAC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 20:02:58 -0400
Received: from mail-ot1-x361.google.com (mail-ot1-x361.google.com [IPv6:2607:f8b0:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499FC061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 17:00:43 -0700 (PDT)
Received: by mail-ot1-x361.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so4803467otr.7
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 17:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to;
        bh=44+++in03btYp3o1SQ3+vtEeTTC2qt8hsU0X1VOs4Ag=;
        b=aDJzzD+nRXnLg43DiX9McCQQULeBhlDjVHJxUKbA7MVtL8u+8CdVRxbVNq5hP7f5vx
         IL5ej0F9I2AKsFlaGrSfbSba/bGNNsUcYq0udVbpcLGUlEU5OgYlI1LaD9ZgyDR3Tk4c
         MfQY0aTGhu978LURj4Fiucoafqb7mtj10hLEzco7IuMVzNXif3q0YjIwxyZqHTU60c4b
         tizIP2tBcAi3880LdwkoBmGgzQDBjGFoubCDLIfPhe/XydH0R3XSPv3NS4cUJKpgfPl+
         fTOsqvPXSyeLWgwJyOWlkxsZnWryUz5cMof4xQJWYKPzYkfEI8CoLduxw/MURg1V0lCt
         O+Hg==
X-Gm-Message-State: AOAM533lbeb0WnHCdBPHYVQrdQa+sPLv5D2EFgwxgy8G3pw5gi+evHp9
        GgHjmzrbwnoRIyN40XXxuyOBpRhgN2+PH6rrcKJAlpHTNxUNog==
X-Google-Smtp-Source: ABdhPJzXgOfmyhGzw3rRwf+m1vqGNeo+S9EK2s4cL7KXS4SHwGjmidc+wq9JyYsdeiizFaQC6JtsPmmqT0+L
X-Received: by 2002:a05:6830:2005:: with SMTP id e5mr4986465otp.215.1623456042561;
        Fri, 11 Jun 2021 17:00:42 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.44])
        by smtp-relay.gmail.com with ESMTPS id m11sm3115873otr.5.2021.06.11.17.00.41
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 17:00:42 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    by restore.menlosecurity.com (13.56.32.44)
    with SMTP id 3a3422f0-cb11-11eb-a95d-65172ea45822;
    Sat, 12 Jun 2021 00:00:42 GMT
Received: from mail-ed1-f72.google.com (209.85.208.72)
    by safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    with SMTP id 3a3422f0-cb11-11eb-a95d-65172ea45822;
    Sat, 12 Jun 2021 00:00:42 GMT
Received: by mail-ed1-f72.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso14668824edy.8
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=44+++in03btYp3o1SQ3+vtEeTTC2qt8hsU0X1VOs4Ag=;
        b=SJXaKupUMpDNEqkQCAfDpbgTBV6g0r5KaawXpm8nTOH3pc9kreArJ69jACuBhMaKlo
         tvxG4FZK9Yl6R9Hrl/vgnqOqWTWVMhWjgyspTAGj58hdtLywehI5T9nDoeR16iJCKAEt
         pCNfGlvNO6YYhUxFQeKQfeTlaVAB11YpvD60M=
X-Received: by 2002:a17:906:6899:: with SMTP id n25mr5799726ejr.462.1623456039787;
        Fri, 11 Jun 2021 17:00:39 -0700 (PDT)
X-Received: by 2002:a17:906:6899:: with SMTP id n25mr5799719ejr.462.1623456039600;
 Fri, 11 Jun 2021 17:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com> <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net> <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com> <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
 <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com> <CA+FoirARDoWWpif2tw47BG0Rh5+uBpsoVZ7Y05JnZO2UqBDSEw@mail.gmail.com>
 <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com>
In-Reply-To: <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Fri, 11 Jun 2021 17:00:28 -0700
Message-ID: <CA+FoirAzajd4TNDQpwDnH9krEn15VBj5n=SF72pBXbvo5ZPJcQ@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey David,

I just tested your proposed patch and I want to confirm that it works
great for my use-case.
I get the same rule-selected route based on firewall mark as the
outside ip route get ... mark ...
Also since we didn't touch the ports, multipathing works as expected -
gives a different route
based on the hash of the socket tuple.

So having said that I can't help but wonder what the next steps might be.

Are you able/willing to incorporate this work in the kernel?
If yes I also wonder if it would be possible to backport it into 5.10 branch?

Thank you and Daniel for looking into this. I appreciate your efforts.

Cheers,
Rumen Telbizov
