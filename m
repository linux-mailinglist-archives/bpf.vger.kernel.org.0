Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA412458E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLRLS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:18:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbfLRLS5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqO8aWTsw8nNsw3ZaTy9XRd/OVsjdS8T1HV1zC3O9O4=;
        b=Wp12k+eBrQaPlWLGwPKom6ozOPNFMrRJepIUOIlZVOeYIZSRnI6lr397S0Sgbn1oZFO9Z4
        dfVrSXzsUDXcnR0IqX7zxmWzvv74MrBlVjKkVdFp0FA61wYDUhPaQzMhmJdZwtAL4UgdQX
        chrMxsb+XemDxXM+st6KbK+vHnzGNsE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-v__iAOUoORuhVRQtpXjQ7w-1; Wed, 18 Dec 2019 06:18:37 -0500
X-MC-Unique: v__iAOUoORuhVRQtpXjQ7w-1
Received: by mail-lf1-f72.google.com with SMTP id x79so186217lff.19
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bqO8aWTsw8nNsw3ZaTy9XRd/OVsjdS8T1HV1zC3O9O4=;
        b=cr+5d7GACLfQ4O2+LpxjwkfYo6GV9xdN9hqxsuZZrPAQhafdFUSoBqRJ+1bqkKuzXL
         qb5JPRCSFzoVx3FxHQbzIoX8qoXARnW8MSfnMCeozSuALSYM4p3zISY9Ue5uQPP4RaU4
         yhBZhSQQhALl6P96Kcq9UFBQDhiQrmIsaJFrjIaMYluQodXbHfv4y88MVy4mF2HaTZ5j
         jtyMThh94O/jtIaV7kgW0Z3hUVsvb8R6loL/C6nZ35tneMXXJ/rOrJG6CYyWlHDgUMCo
         YlY4BKEMBMIJPVBO0amazMoVGOrJ69ngS9TwmBjb/IsNdDZrEliUej84aZRIgibeS65j
         KAGQ==
X-Gm-Message-State: APjAAAVvYBVVnzejmErUDk+HHcSogVJss7umNtoWQhL3dgpO7QhN8ItA
        RH+vNXAaET3dy8PtOAX+Gu1kFcaTloT6VBQr3Fq6iPPY739G0k6bSSKXZt2Bo3QWNuyAjlyVBHP
        Yn7T/qxPAYf7e
X-Received: by 2002:a19:48c5:: with SMTP id v188mr1407681lfa.100.1576667915566;
        Wed, 18 Dec 2019 03:18:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuMNgg3shacLSjzVFCXCbTAhoYRat0ZZ0f+/jop/Eo24vYT5bZO+m4spu6MI5tFLyUXkFjvQ==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr1407665lfa.100.1576667915360;
        Wed, 18 Dec 2019 03:18:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h19sm944357ljk.44.2019.12.18.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:18:34 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 29E46180969; Wed, 18 Dec 2019 12:18:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 3/8] xdp: fix graze->grace type-o in cpumap comments
In-Reply-To: <20191218105400.2895-4-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-4-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:18:34 +0100
Message-ID: <87woat6fw5.fsf@toke.dk>
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
> Simple spelling fix.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Even though I kinda like the mental image of RCU going out to the
savanna for a mouthful of grass that the typo seems to imply:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

