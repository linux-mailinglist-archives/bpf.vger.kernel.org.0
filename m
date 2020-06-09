Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49581F4776
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgFITry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 15:47:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731247AbgFITrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 15:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591732071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB1oD9kpoB9pl4KWasJnll/v8m3IdFvCXccjs79r90A=;
        b=MkA7IAkZI76vLfkMeNzLMOdqVQ7Q9W2J6KV8/mMV10XVtX+JWDNp8hMXkq/xi+yfy2nmiz
        GfEp4pZQaE0dPE9xdiquMLFlUNbz7AZ9LzEXzWF/vjAPM04c7i4vzHl/UFvfojR40HxOIH
        Acav/Dq6TAgo4vzIvGoY7POTrgyAL/c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-iwxJK8l3P6qbuPQacd9fsA-1; Tue, 09 Jun 2020 15:47:49 -0400
X-MC-Unique: iwxJK8l3P6qbuPQacd9fsA-1
Received: by mail-ed1-f71.google.com with SMTP id y25so8567334edv.10
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2020 12:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xB1oD9kpoB9pl4KWasJnll/v8m3IdFvCXccjs79r90A=;
        b=k47Yb/jsMxqDV9qaY1iHEIUevRgFdMASgx/yMfAT8uzXeRZFEc7yYitm/ECPIo5NA1
         BJlynr2NdXzndqeGhDkfxAR1+aw1M67gE3VPAgMHdapuDo3ceg9ZldLRpIVVWchstE4e
         pla70XgmGtrzHLzNwTqXtdXZh1l18LCYMIEwxSlQObkri8NqtKA3aNgp1xWX+dVStahg
         LckyswT4F07GGpuzutgXLzOT2seE4Tw6tSHpL293b3lYni6c8DFmAm9q7QgrAT6YHStV
         uJKaDfBLkWoqyxocgEPvYMGVUVgUqr2rfMKPtq2GDUjYR6w2I9BheNo8JvZrN4yHTfT8
         kE+g==
X-Gm-Message-State: AOAM533olyOPdGpuLfM9k5z0c0BS+o4mSGDPOZQ5Rtk14F/KO14cjxmO
        q03PBiU+H4o4FXo7ANu/fL3AbwBkXKsf/MxN6IQrYTcSoZmcDlHoZMksSBTa0lZ6wFECUzQVsTO
        w4HP5Kd5k4y5v
X-Received: by 2002:a17:906:1d55:: with SMTP id o21mr26230175ejh.491.1591732068630;
        Tue, 09 Jun 2020 12:47:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf1sNKkLWeyTjzQSEoqtchZN5z8CNGMjaxb4kfu1oo54GerCMlQme8NBryBKoVoCUZzk2NIA==
X-Received: by 2002:a17:906:1d55:: with SMTP id o21mr26230158ejh.491.1591732068366;
        Tue, 09 Jun 2020 12:47:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p6sm13932648ejb.71.2020.06.09.12.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:47:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0A9B8180654; Tue,  9 Jun 2020 21:47:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        brouer@redhat.com, maciej.fijalkowski@intel.com
Subject: Re: [RFC PATCH bpf-next 2/2] i40e: avoid xdp_do_redirect() call when "redirect_tail_call" is set
In-Reply-To: <20200609172622.37990-3-bjorn.topel@gmail.com>
References: <20200609172622.37990-1-bjorn.topel@gmail.com> <20200609172622.37990-3-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 09 Jun 2020 21:47:46 +0200
Message-ID: <87r1uo81i5.fsf@toke.dk>
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
> If an XDP program, where all the bpf_redirect_map() calls are tail
> calls (as defined by the previous commit), the driver does not need to
> explicitly call xdp_do_redirect().
>
> The driver checks the active XDP program, and notifies the BPF helper
> indirectly via xdp_set_redirect_tailcall().
>
> This is just a naive, as-simple-as-possible implementation, calling
> xdp_set_redirect_tailcall() for each packet.

Do you really need the driver changes? The initial setup could be moved
to bpf_prog_run_xdp(), and xdp_do_redirect() could be changed to an
inline wrapper that just checks a flag and immediately returns 0 if the
redirect action was already performed. Or am I missing some reason why
this wouldn't work?

-Toke

