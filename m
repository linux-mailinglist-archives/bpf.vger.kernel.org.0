Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC341F47C6
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 22:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgFIUKd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 16:10:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37667 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731802AbgFIUKd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Jun 2020 16:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591733431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIBz2nM/i5kWg1owng6M9L0w19pJxveVwHk7hkV+/2c=;
        b=en8rMeGEfL+EQJCmO2nOFkGh+lT0+3kdxey3e6lW5MmyxtVQyiXkSDxlm7wCcMqStm5/h7
        aZAC+OTD8aSIaWJwNQ1GJe4C0bYJ9ns5c9HFxgsbOdU79gRv0Uw1BgANSj3QjPFL59sZnZ
        7IZdNp1nAr4Gvz0IZQvPsTzYmgUkr/I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Nz-sTPBUMfSAwWQ1oNWi8g-1; Tue, 09 Jun 2020 16:10:30 -0400
X-MC-Unique: Nz-sTPBUMfSAwWQ1oNWi8g-1
Received: by mail-ed1-f72.google.com with SMTP id y5so3111848edt.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2020 13:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rIBz2nM/i5kWg1owng6M9L0w19pJxveVwHk7hkV+/2c=;
        b=NG+xZP6Jh73Rgabrv6v9/Hsb54DIg4hx/BuyKq0st2vBtN45QI2JMDWDKJ8SdVJr/1
         q8uzJY0l3JV3oX82xHBiRIcnmI+0GjDephqte5aza52eIW8S69RYTkZdj3cL5frTXBcT
         res4sHlog1bCV/oykCtKyhrwpvrp4zaJ0idwk+d0h5ncqN/t5bucxSVcK/rrq1SHefTZ
         pwfixH9pPe8SZtJRLOfh8kwmTcG+lAaiaicnRQ2lXMF9PlWX+FK2LdATSnytVi2b55PE
         JrgKEnInOQ42fpTCfbefYeQRwEaBQWSyZGi5ZBHeecQbe8BQKyg3IMGdw8COBukhEBL5
         pUaw==
X-Gm-Message-State: AOAM530J3VM/JtHGcFu0HMlHC6s63eqIkHsTIku/Z4Q29ob5nRUV4wCO
        ojem0j6VJ0COFWrIFP5/+XbpsifmBmPEy/DGkS4JwDWVEJfWHbc6531ujuHc7yElkEx6h1GoTXg
        572lHDQSg1Osp
X-Received: by 2002:a17:906:1841:: with SMTP id w1mr86277eje.21.1591733429078;
        Tue, 09 Jun 2020 13:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhzKST1N5AbWaZKuqZEg8N4xtlo13xa2B0900r3iNywVgyEJwUOyuKAHUumf2R7GN011qnRQ==
X-Received: by 2002:a17:906:1841:: with SMTP id w1mr86256eje.21.1591733428888;
        Tue, 09 Jun 2020 13:10:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v26sm13484784ejx.25.2020.06.09.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:10:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BBC65180654; Tue,  9 Jun 2020 22:10:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        john.fastabend@gmail.com
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        brouer@redhat.com, maciej.fijalkowski@intel.com,
        bjorn.topel@intel.com
Subject: Re: [RFC PATCH bpf-next 0/2] bpf_redirect_map() tail call detection and xdp_do_redirect() avoidance
In-Reply-To: <20200609172622.37990-1-bjorn.topel@gmail.com>
References: <20200609172622.37990-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 09 Jun 2020 22:10:27 +0200
Message-ID: <87o8ps80gc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> Is this a good idea? I have only measured for AF_XDP redirects, but
> all XDP_REDIRECT targets should benefit. For AF_XDP the rxdrop
> scenario went from 21.5 to 23.2 Mpps on my machine.

I like it! I guess in the end the feasibility will depend on the quality
tail call detection, which I don't have any ideas for improving. I'm
sure someone else will, though :)

-Toke

