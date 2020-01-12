Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C41385FE
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2020 12:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgALLWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Jan 2020 06:22:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732665AbgALLWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jan 2020 06:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578828129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyYLN7biZthy4ZgKpi4qBC5XSIISZKtzeFJ2niSFzW8=;
        b=HUBmwfQYYWj7j+yYNu06nkqigBLPBMgWnAb79FjReVUOrAYcd1WDtoO+/i/NaUE8wP8l/g
        3tO6GQHRGWz3yRANRamiAcfyszknAqkWKr89BR8Jj2iykuzQa0gC79eXLj+d/Tk44n76TB
        MJ3H7/ms5yMtW6DpZ1av9nAP75t3IZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-yDcwbe7jMr2N91kDN7fDoA-1; Sun, 12 Jan 2020 06:22:08 -0500
X-MC-Unique: yDcwbe7jMr2N91kDN7fDoA-1
Received: by mail-wr1-f70.google.com with SMTP id h30so3514223wrh.5
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2020 03:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OyYLN7biZthy4ZgKpi4qBC5XSIISZKtzeFJ2niSFzW8=;
        b=ED4SeSAxw72xubYUYa4zjjNhB7V+RDbOmJXduSr4JzEv/XwHTJP109aZpGBv9xPCit
         AQ8+ZPyFgQTp99fFrvOcAFGjfac+nBN0JFLaXGK4ZkmJdA6d+wfMY8y1wI25G6AjP3Wa
         SR12GyvFiykkFJyev9Dgkeh0Sz/+I6Fieaosp+GKIjKXKPpCDm/benohP44dVbXOu++T
         nqGtnMvnBnHcGuigm16myeF1QjwLpozVXuGSZhWS3BvwYKK7gLYPTgbauR4wdNCdK/UZ
         DAYUiDX9PK8SGwvojYuJe2lMUYC3IxxCbjJnSs6oDZBWhSkRMBHMWPMpI+xNXg9alR+V
         IV6g==
X-Gm-Message-State: APjAAAUNklz+3Y9DRyCLtgMPX6coWlp3TrfTx15RnFdq6YLN+E8znDJD
        qTW9uMZ3HJDAdRqkWUjIgkXehqUNast5Gj82oU2rH8do1bju1hI4cN1ejkWSj1dMJLhaaiuAPOK
        MX5WKaF1MIw1N
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr14239281wmq.142.1578828126913;
        Sun, 12 Jan 2020 03:22:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz9fioFKDalqOic1TVY0mou4uz6C3C/929qnEGdrE0P9cH/kAwIEOkYjp2Ub2x1s7aSWhQyw==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr14239257wmq.142.1578828126721;
        Sun, 12 Jan 2020 03:22:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w17sm10371564wrt.89.2020.01.12.03.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:22:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 85DA71804D6; Sun, 12 Jan 2020 12:22:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>, bjorn.topel@gmail.com,
        bpf@vger.kernel.org, toshiaki.makita1@gmail.com
Cc:     netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [bpf-next PATCH v2 2/2] bpf: xdp, remove no longer required rcu_read_{un}lock()
In-Reply-To: <157879666276.8200.5529955400195897154.stgit@john-Precision-5820-Tower>
References: <157879606461.8200.2816751890292483534.stgit@john-Precision-5820-Tower> <157879666276.8200.5529955400195897154.stgit@john-Precision-5820-Tower>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 12 Jan 2020 12:22:05 +0100
Message-ID: <87muasx6le.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Now that we depend on rcu_call() and synchronize_rcu() to also wait
> for preempt_disabled region to complete the rcu read critical section
> in __dev_map_flush() is no longer required. Except in a few special
> cases in drivers that need it for other reasons.
>
> These originally ensured the map reference was safe while a map was
> also being free'd. And additionally that bpf program updates via
> ndo_bpf did not happen while flush updates were in flight. But flush
> by new rules can only be called from preempt-disabled NAPI context.
> The synchronize_rcu from the map free path and the rcu_call from the
> delete path will ensure the reference there is safe. So lets remove
> the rcu_read_lock and rcu_read_unlock pair to avoid any confusion
> around how this is being protected.
>
> If the rcu_read_lock was required it would mean errors in the above
> logic and the original patch would also be wrong.
>
> Now that we have done above we put the rcu_read_lock in the driver
> code where it is needed in a driver dependent way. I think this
> helps readability of the code so we know where and why we are
> taking read locks. Most drivers will not need rcu_read_locks here
> and further XDP drivers already have rcu_read_locks in their code
> paths for reading xdp programs on RX side so this makes it symmetric
> where we don't have half of rcu critical sections define in driver
> and the other half in devmap.
>
> Fixes: 0536b85239b84 ("xdp: Simplify devmap cleanup")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

