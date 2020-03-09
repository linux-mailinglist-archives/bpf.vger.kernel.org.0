Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAC17DCEB
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 11:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIKGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 06:06:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgCIKGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 06:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583748404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pVffw3WEJdN/t3fxfYggMKUlU5RNvR//cUlYZSKZw8=;
        b=BXzqqP7/BwI3pzK5pCw1iLwk4OheGd/UCDpm0Qp2gbhY5pPs242br7JuEw8flmB+eP7Y/k
        LXnsPhZWfa3HEaXF5dBXT9wJEymS+2NiQnDf8Ff9PoRF6zBbXKzBTHmAF/w3mpFyxbPYGO
        5hpvwhyfzPgL0wMt9Sw+3i4QzY4q29k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-vaSVqj_kNvuDQ36mO72yKQ-1; Mon, 09 Mar 2020 06:06:43 -0400
X-MC-Unique: vaSVqj_kNvuDQ36mO72yKQ-1
Received: by mail-wr1-f72.google.com with SMTP id c6so4933347wrm.18
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 03:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5pVffw3WEJdN/t3fxfYggMKUlU5RNvR//cUlYZSKZw8=;
        b=ZQfXjemvk7Kj2QTaVTWxIfy6lxb4+P7mof/tG3RewoLq18en+umj+8QoS7JrZZbPww
         Thf1fzw7aXkhLxoc4ZO8FJg8UcGbqMEHcGEIOhKJ/DuJjmYVMzFYyomLboMCChRuoKip
         7mle7msNcGE/8ajYdVuN9QNgXTdypYVSuupQdLM0nqocHUyGOVvNXI4p4murhQk6WB7Z
         oTTLJOneuDw8qbQ5ujnJnRNPI6DyUSAENrm9fKqlNfRSdgpFx7hy6qzy/aRJ+SyggbzS
         p1dQc068LrJ94n57iKuh6rLvXLTENg7lHT618asXx11FpLNfUpifr3BmQxEWZ/wp0+/M
         NO2w==
X-Gm-Message-State: ANhLgQ3SP1a/T6mYnh1JSMg+TwbleCGgO2ez6REMTQ8H82zTeojkGYAv
        vBxq2jD+gDrMSOCjMV0/ai8PGT4p2moHac/bBpJLP2Yzx2Cyy0JC5bETiZu2vuqpx+TzoO6L3iu
        rwpYlSxadot4D
X-Received: by 2002:a1c:8103:: with SMTP id c3mr13893973wmd.166.1583748402080;
        Mon, 09 Mar 2020 03:06:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsGKUaZexq9c7r3nw7dAdzYDqo8N9O8HFYpRjT3YC3C8khqjG/LN06T7s3/+ot0hMM+ZgBBRQ==
X-Received: by 2002:a1c:8103:: with SMTP id c3mr13893949wmd.166.1583748401833;
        Mon, 09 Mar 2020 03:06:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l64sm3298717wmf.30.2020.03.09.03.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 03:06:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B196C18034F; Mon,  9 Mar 2020 11:06:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next] bpf: add bpf_xdp_output() helper
In-Reply-To: <158348514556.2239.11050972434793741444.stgit@xdp-tutorial>
References: <158348514556.2239.11050972434793741444.stgit@xdp-tutorial>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Mar 2020 11:06:38 +0100
Message-ID: <87r1y1266p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eelco Chaudron <echaudro@redhat.com> writes:

> Introduce new helper that reuses existing xdp perf_event output
> implementation, but can be called from raw_tracepoint programs
> that receive 'struct xdp_buff *' as a tracepoint argument.
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

