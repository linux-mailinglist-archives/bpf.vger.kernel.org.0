Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2A3A47EA
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFKRfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKRfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 13:35:08 -0400
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ABAC061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 10:32:57 -0700 (PDT)
Received: by mail-ot1-x362.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so3861947oth.9
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 10:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=+YgtYrc4k9OXHM3kllnTKgsaikVW0I/iTOVcIfrdEhU=;
        b=n2koIc/iIFjoH9hfObrBYMyOwxLnDn5lp1CLjDM5DOdFbgFLsbYXIUqXdzTdhwp0/1
         a6CMyIylOpFKqjWAwT6lYYyiqqqxQjSf5IKrTC6zUhcuAlYJFS8dXFwHbtxX91huxSji
         tLc/l9BByHZ8IKmMnC2Nuh568hiSmor4Boy3DVyCEXPWsf30truNSY5fUY9Za7PlhwjX
         HPcitUEK1m0xNehBomvtEajNmK5YERmxjyKZLbWGcyPXklIcJ3ZUEQilPCLTezGgBgGY
         MesecJHlxNGWyERMXXgjTM+rS8tGqZC9aj1y7yVD9/GuFZVDLJichq99fRQAVAZxo1tR
         CH9Q==
X-Gm-Message-State: AOAM533W35G5Dk8RutBssbWJxWAaCvhtpwhxyqOwZq6FfSyICTEOqirN
        zfX5fmVkeGDus6D51L/lqogHA/Crt4FsNgFzhynjGA9Wgl2wEQ==
X-Google-Smtp-Source: ABdhPJw7IYMkR7eLrP5ofZPEXbFYmI5dWhvAD/N6LEAShOs4Nv98IlYKl8FYelQYbTxGQ8+Ke7+MKffiw+mc
X-Received: by 2002:a9d:64a:: with SMTP id 68mr4013625otn.68.1623432777393;
        Fri, 11 Jun 2021 10:32:57 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.44])
        by smtp-relay.gmail.com with ESMTPS id z21sm226396oor.12.2021.06.11.10.32.56
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:32:57 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    by restore.menlosecurity.com (13.56.32.44)
    with SMTP id 0ec40cb0-cadb-11eb-84a4-ddba25018390;
    Fri, 11 Jun 2021 17:32:57 GMT
Received: from mail-ej1-f69.google.com (209.85.218.69)
    by safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    with SMTP id 0ec40cb0-cadb-11eb-84a4-ddba25018390;
    Fri, 11 Jun 2021 17:32:57 GMT
Received: by mail-ej1-f69.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso1412027ejo.13
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YgtYrc4k9OXHM3kllnTKgsaikVW0I/iTOVcIfrdEhU=;
        b=DMQDTGSBIYlWQgA5NK3H04Y4eTtjL1zoogF8jI5Tlag2ZehLF4EIvFak37/ydNoBYb
         p6AJRqNUlsUfV2/KRfegfxWyfaI9qfIdwlj2Lw+f8kQ81KGaPtQSd4au4k00xtu4xexj
         nII22iR2bxrVbHJBAiEBhZe5HbHakiF1dM3Mo=
X-Received: by 2002:aa7:d555:: with SMTP id u21mr5070009edr.84.1623432774395;
        Fri, 11 Jun 2021 10:32:54 -0700 (PDT)
X-Received: by 2002:aa7:d555:: with SMTP id u21mr5069992edr.84.1623432774245;
 Fri, 11 Jun 2021 10:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com> <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net> <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com> <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
 <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com>
In-Reply-To: <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Fri, 11 Jun 2021 10:32:43 -0700
Message-ID: <CA+FoirARDoWWpif2tw47BG0Rh5+uBpsoVZ7Y05JnZO2UqBDSEw@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thanks a lot for the proposed patch.
I see you're overloading the mac addresses and thus this leaves us
with even more space
I will give it a try and will let you know.

Cheers,
Rumen Telbizov
