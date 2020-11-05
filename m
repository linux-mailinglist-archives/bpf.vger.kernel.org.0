Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F412A8AA4
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgKEXXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:23:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54149 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgKEXXU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 18:23:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DB9535C0184;
        Thu,  5 Nov 2020 18:23:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 18:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:from:to:cc
        :subject:date:message-id:in-reply-to; s=fm1; bh=duLADp0L3t3dhlQg
        hBrp1HNXQG5rMH4wSnK4U3OyB4g=; b=QQ1R/XwzQqz9hAAuvTmI5vXA5rBueQNr
        QB5dskuIAlch9HBUjzUmZW30cIM44/z19jZzXT9iaJotK8e/s8D7vwQiIfPKx1QB
        dx6Ybu/q3/zDMM9OFGuJ4XJLfrXzfnRL7jwIfOZ37g4DZ8IfJCkzJB3Xt3DQs3Iq
        SCrIBxC1wid4hdKkmXqd6XxYi/0WsZ4S7aGyM/QT9NZnGqrCVXUwamOeYiy8RTjg
        z33phN80Ympi7EzChLWa0l3/IvqaIXRVaxrowyHxsa1rQ1pwiDd3So/Dj13g/0gG
        dbuJsGXYPHhHNx20L28M3BKRC67xaeAxknrpGgFWIcBRpIchP3j3oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=duLADp0L3t3dhlQghBrp1HNXQG5rMH4wSnK4U3OyB4g=; b=ndEotHKT
        txmyrnVFRLQAfdPUSMO2Jv/u399aoxZdELvhTUR4T8ciUpKzB+j7/BSXeMv0R/iA
        MamGFz41Y/s6DMXfvovgvtxut11JVlO9S1Bv3WNLbkf3PjlSSlh+ViHopZLH4kcu
        /qu0xqSdh93WnDRzZj1sBG80q28Zh48+RdmOWq0j1asoLRsD8HP+ZxEnzlDCZ7ON
        eSFfnu0LRqeBMdk/oZWa9OKgtSIvgEC/PxupgWPrUuGmfeQQ1zBUnkTDg9pIbYCg
        Tt8ZvBdiUdMwYrYBjp7t02L1cxBpZjFSBBhC7WKT1Fx5F9M6VfsK8Tn6uB2/jzYl
        dLGIwiZo5v37mQ==
X-ME-Sender: <xms:ZomkXzDysA8Zd_BtSTgrdJGU4sSF-qqOMsi85cMZ5Lp-euXJnDi9fg>
    <xme:ZomkX5haJNRi-fHQSjQJ23DFpyeNM2WgihVnvKzE0gxogqcPFRqm4DYEik_4M4-kA
    9OVyilgmpHLSUmoqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpegggfgthffvufffkfgjsehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueefieduveffuddtheethfeiveegtddukeffleelledutdef
    gfdtffduhfeuffejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:ZomkX-l6X0i84_ll5Vo0JgYPLlQNMDZb0E_lBW5LRLPVChofmNKWnA>
    <xmx:ZomkX1wXxDp4xgrGSRhbKhU4sezASvMO-sCmAOgsKZSQCHj2YXVNPA>
    <xmx:ZomkX4Rejr96eJoF34YYh4WqTKCvKHLzsIJ294yfQrONrvcV3f0yLA>
    <xmx:ZomkX-diNSwEtzIMnoF_IZ8ft5hLHIKSNgQEWTw6G1hR8XLgA4z8PQ>
Received: from localhost (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB4DA328038B;
        Thu,  5 Nov 2020 18:23:17 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "bpf" <bpf@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Date:   Thu, 05 Nov 2020 15:22:34 -0800
Message-Id: <C6VPSZATLVIX.2PK5DDNA9QVDD@maharaja>
In-Reply-To: <CAEf4BzZN3v0Lb=XBKag3+EJANvAA=ei+ot3zNxuQc_HqYEdScw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu Nov 5, 2020 at 1:32 PM PST, Andrii Nakryiko wrote:
> On Wed, Nov 4, 2020 at 8:51 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
[...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str=
.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> > new file mode 100644
> > index 000000000000..41c3e296566e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include <sys/types.h>
> > +
> > +struct sys_enter_write_args {
> > +       unsigned long long pad;
> > +       int syscall_nr;
> > +       int pad1; /* 4 byte hole */
>
> I have a hunch that this explicit padding might break on big-endian
> architectures?..
>
> Can you instead include "vmlinux.h" in this file and use struct
> trace_event_raw_sys_enter? you'll just need ctx->args[2] to get that
> buffer pointer.
>
> Alternatively, and it's probably simpler overall would be to just
> provide user-space pointer through global variable:
>
> void *user_ptr;
>
>
> bpf_probe_read_user_str(buf, ..., user_ptr);
>
> From user-space:
>
> skel->bss->user_ptr =3D &my_userspace_buf;
>
> Full control. You can trigger tracepoint with just an usleep(1), for
> instance.

Yeah, that sounds better. I'll send a v4 with passing a ptr.

Thanks,
Daniel

[...]
