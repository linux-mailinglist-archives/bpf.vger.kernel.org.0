Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA38124574
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRLPe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:15:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbfLRLPe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 06:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPqDVVveckmN3sA/fk9vSDhaVbSTUnE/mEW7EXldfX0=;
        b=Hh+qxdHjp1p7Rx9M2/AL+uFpK843YiocBL6bx7K/1cTlPTn0SeoJig4O0USZLjW0t7bkEF
        4VML6dMVhnk/MBuXXDH2+8GuPRblO3NZhMJ6XTsbIR4Gap5Jmok3H+YWnIScLolmKw1j9X
        ELm2QMKwDlCLHVtiTS7M+XUkjsrU94o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-6SElSkFeNreVohd_HXxDBQ-1; Wed, 18 Dec 2019 06:15:30 -0500
X-MC-Unique: 6SElSkFeNreVohd_HXxDBQ-1
Received: by mail-lj1-f198.google.com with SMTP id u22so584007lju.7
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XPqDVVveckmN3sA/fk9vSDhaVbSTUnE/mEW7EXldfX0=;
        b=i8U1wkUXXBWQ2rV303WYdy8YeQ3r1n2kigjHa+JsfGHA8ij24avIaIICsk7LHg79Ou
         f2MnX0DPX6UdWwwLLR84GEppQXQDCtL8NIzIirXp9BjxEChHNDk4hDJ1NedPZameitvY
         yhLSpEPvAsqYwrmQYR9vdRRXm18Sad7p1iywS3gIuoIOOSH3t+YgBYlxDnPfL7zDFq/L
         wp2rmSGfYolce3oYLRrxiDN9jWs1B1ShAgccPuVm3v9pUPxicaAuWokikFHnNFi5A0vY
         W8HVf5YF0FYQ/sa8ZRCjiV0KiW9TyipAZaBBtymsw/saeeyMsyXNLsDDjZw/8ayuhDX+
         AzKQ==
X-Gm-Message-State: APjAAAUtm4bRtiiUMiff4me2mZ8327tztAw4mtYOQgQmqnxx7Cg5wyCE
        uD2Joo8hANLyPTZzTh8elI7bFi1fTapOw4ZyAh4CegkzDq6kotTr/ZtHquUKhkHYuJWfR/n8SVc
        SfkIM4eShjY9N
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr1275366ljk.220.1576667728635;
        Wed, 18 Dec 2019 03:15:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzixIyfl4L3TT0L5a14PNoUFqnk2iZQWA1soUx5f/70r4kNLmX5R7fo2rcGyJRXnHKrbsPCaA==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr1275353ljk.220.1576667728499;
        Wed, 18 Dec 2019 03:15:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q26sm936056lfc.52.2019.12.18.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:15:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 579A8180969; Wed, 18 Dec 2019 12:15:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 2/8] xdp: simplify cpumap cleanup
In-Reply-To: <20191218105400.2895-3-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-3-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:15:27 +0100
Message-ID: <87zhfp6g1c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> After the RCU flavor consolidation [1], call_rcu() and
> synchronize_rcu() waits for preempt-disable regions (NAPI) in addition
> to the read-side critical sections. As a result of this, the cleanup
> code in cpumap can be simplified
>
> * There is no longer a need to flush in __cpu_map_entry_free, since we
>   know that this has been done when the call_rcu() callback is
>   triggered.
>
> * When freeing the map, there is no need to explicitly wait for a
>   flush. It's guaranteed to be done after the synchronize_rcu() call
>   in cpu_map_free().
>
> [1] https://lwn.net/Articles/777036/
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

