Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9357B1245BD
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRL1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:27:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbfLRL1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 06:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576668471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3as0fMepjXKiH9hYeKlkTzZXSRWa3b2rrvx/TlzOdnc=;
        b=TfchaALNm1IqAFQmYb5LuPzROT8YuE7Rr3nZSBt5+Xwg082MIAjsSf/45x7U3IinG/EYlR
        ysD99UP6L1hX51RFgwW8RPDXKAE3mAqMrS3yw6AiAHH6N6IcwXIsG8zoeTVBMbiMjufJhH
        0MvcIopubbl+kRgEX8v/Hdiun0k5a3k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-x1oIuSt6NUm7njCLEi6-Vw-1; Wed, 18 Dec 2019 06:27:49 -0500
X-MC-Unique: x1oIuSt6NUm7njCLEi6-Vw-1
Received: by mail-lj1-f198.google.com with SMTP id z23so582287ljk.21
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3as0fMepjXKiH9hYeKlkTzZXSRWa3b2rrvx/TlzOdnc=;
        b=h8UyYOc2XPi0LCCl4FhWFqAFusIK9D22US3x8NDlcwsrNjE665W54Wfq2/qkiXDv9k
         YIwaB3bZpOYvcERJkphQsKh/Kzaj02nS6ZQkrFV/WCCl3uclAH4TMv/mOx6HLk0Hpgce
         nv160NmRgkKP6LNOitKXvOhVTB2NyLMchXKReLnrXjuwHjRELvfbbOwSLH7mAkW9Gzg1
         qvM8F+PzXozucreJ/768lzzfSPaK4dcTH/EQtROoVzvDaz0AfBh2ZgyhctVnDT/W/8YN
         nqc5xz2ro92edyve9bO6ye5+Ukz+q8hLfOH5gYQOS/elM3h4lp9rF2qWWuYcFqqrSnLA
         aITA==
X-Gm-Message-State: APjAAAUYFNEj85vv9cBlOIPBucynYf+qcpskvEEULSkJEexf7FFsvzui
        NLeJogt8himIrgjkmZ77h9+Z6wVITsWRAVF3U7u3k/i/BSdXVbIKE5Pn1jvre1sFhybzg2YEMgg
        zru97m9NtcvwX
X-Received: by 2002:a2e:8745:: with SMTP id q5mr1365611ljj.208.1576668043912;
        Wed, 18 Dec 2019 03:20:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwT0sB2A0HN5RirCpDjdI6buBQBKUL1wmyz2cbpK4RtNgJzszK5rudZ2tx2g/YsmVeUorBvew==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr1365592ljj.208.1576668043811;
        Wed, 18 Dec 2019 03:20:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c8sm968308lfm.65.2019.12.18.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:20:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 98EAD180969; Wed, 18 Dec 2019 12:20:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 8/8] xdp: simplify __bpf_tx_xdp_map()
In-Reply-To: <20191218105400.2895-9-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-9-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:20:42 +0100
Message-ID: <87immd6fsl.fsf@toke.dk>
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
> The explicit error checking is not needed. Simply return the error
> instead.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

