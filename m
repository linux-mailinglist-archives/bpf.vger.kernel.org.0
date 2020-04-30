Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D01BF5DB
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3Kth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 06:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50240 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726413AbgD3Ktg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 06:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588243775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21QIlUua/fXzniNbCnhFoUnCFPduQJbhBIgPzwL2ZYc=;
        b=baCnFjHwiJ+faWPFOe4rqZ3HcmoZ0cYd839xZd6ZAunn4xxq3SQYZ+Y9PBgKbanpwZj3KC
        1GPNhICGWBNRsjUIZCmCks2vEBhuOQutLMcnL2S9EG4pdRlR4+xfe1eG8Kt8Q4OfxXHzRj
        KmMLKG+46sUkMfQhz3szdRl82rehrsk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-NosxtTxUO0mL8kg_pKn0Iw-1; Thu, 30 Apr 2020 06:49:31 -0400
X-MC-Unique: NosxtTxUO0mL8kg_pKn0Iw-1
Received: by mail-lf1-f72.google.com with SMTP id t194so394288lff.20
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 03:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=21QIlUua/fXzniNbCnhFoUnCFPduQJbhBIgPzwL2ZYc=;
        b=jCcwxQil/sxjdpf15hejL0jU4g+1TYDofHXgYgnJt75JxXBF4iEmjA2sam3OWIS30d
         VA7iehxwwxf+0zqRC6OH3pzIBvZNVK8e9qwmBpNfEuIH8KVN7ewKeLwLw3XluEJjQXJo
         N3WG2C95hSj+dZvVi5f0O4Ub1IJcs0FY0tVTN+lNrihDU+rryqhJbQRbuscAs00zUKTB
         sfjzlGKbWTD2CNkJDU2l817Md4HnMzdN8/fX2k3Elqc+vhFhP7U5sx3d3RsqtBQ2a064
         jfPnW9lBmO/RaaWLG9W66WbC94QTjEUSRlqNtEVVwfxqqRs+UlmA7KaCPrJeJHZyMJ3N
         M9Dg==
X-Gm-Message-State: AGi0PuZtE/FtXfWj5ScVwnPRVEpRflGiCdIfhh+dKnJ18MQb218vm0Bl
        OnyOWIFogNT/GaE0HlZ3axRAN0/akZpiWJBKjXMcZUJUoPqa1PyMR7YE8dN6+paC7uJfd2IxI7S
        7aET9O7p3Snq9
X-Received: by 2002:ac2:4832:: with SMTP id 18mr1761378lft.162.1588243770242;
        Thu, 30 Apr 2020 03:49:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvQG4IPT8lLe2q6gQ3ZmSHAy6L43CwGDIqeoqvy5+uYU5Y+fGQmjRGUAjEIFbxV6BIlmzCbA==
X-Received: by 2002:ac2:4832:: with SMTP id 18mr1761359lft.162.1588243769993;
        Thu, 30 Apr 2020 03:49:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a19sm4605494lff.11.2020.04.30.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 03:49:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 83CD91814FF; Thu, 30 Apr 2020 12:49:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com
Subject: Re: [PATCH bpf-next] libbpf: fix probe code to return EPERM if encountered
In-Reply-To: <158824221003.2338.9700507405752328930.stgit@ebuild>
References: <158824221003.2338.9700507405752328930.stgit@ebuild>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 30 Apr 2020 12:49:26 +0200
Message-ID: <87tv11s0y1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eelco Chaudron <echaudro@redhat.com> writes:

> When the probe code was failing for any reason ENOTSUP was returned, even
> if this was due to no having enough lock space. This patch fixes this by
> returning EPERM to the user application, so it can respond and increase
> the RLIMIT_MEMLOCK size.
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

For context - we ran into this in xdp-tools where we've implemented
"fiddle rlimit and retry" logic in response to EPERM errors, and
suddenly we were seeing ENOTSUP errors instead. See discussion here:

https://github.com/xdp-project/xdp-tools/pull/16

-Toke

