Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FD127842
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLTJec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 04:34:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727235AbfLTJec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 04:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576834471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/UxvPCeTXUKVldWIXLXTiQznfkGrThtTbge0OdQKe4=;
        b=Wr73SsqLoUnzP0qsA+LNqwxJnV7UETTmNcjUAqU4jlb9W37Lxg5+FoBMBm472gBMnd9uN2
        VWV55W3nT7fudccG0+budwK+SwkvapTznOG/+y0bhtsntmn+qAyJZ0wPdbxgrqmEWMhbzK
        gRY3OGLXWMYiwaT3QSTEWxwUamAfBmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102--qmUq0DYNauUF-7U1HEAow-1; Fri, 20 Dec 2019 04:34:28 -0500
X-MC-Unique: -qmUq0DYNauUF-7U1HEAow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D3510054E3;
        Fri, 20 Dec 2019 09:34:26 +0000 (UTC)
Received: from carbon (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42B5A67009;
        Fri, 20 Dec 2019 09:34:21 +0000 (UTC)
Date:   Fri, 20 Dec 2019 10:34:20 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, brouer@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
Message-ID: <20191220103420.6f9304ab@carbon>
In-Reply-To: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 20 Dec 2019 09:25:43 +0100
Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> wrote:

> I've been doing some benchmarking with AF_XDP, and more specific the
> bpf_xdp_redirect_map() helper and xdp_do_redirect(). One thing that
> puzzles me is that the percpu-variable accesses stands out.
>=20
> I did a horrible hack that just accesses a regular global variable,
> instead of the percpu struct bpf_redirect_info, and got a performance
> boost from 22.7 Mpps to 23.8 Mpps with the rxdrop scenario from
> xdpsock.

Yes, this an 2 ns overhead, which is annoying in XDP context.
 (1/22.7-1/23.8)*1000 =3D 2 ns

> Have anyone else seen this?

Yes, I see it all the time...

> So, my question to the uarch/percpu folks out there: Why are percpu
> accesses (%gs segment register) more expensive than regular global
> variables in this scenario.

I'm also VERY interested in knowing the answer to above question!?
(Adding LKML to reach more people)


> One way around that is changing BPF_PROG_RUN, and BPF_CALL_x to pass a
> context (struct bpf_redirect_info) explicitly, and access that instead
> of doing percpu access. That would be a pretty churny patch, and
> before doing that it would be nice to understand why percpu stands out
> performance-wise.

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

