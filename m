Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C922115109A
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2020 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgBCT6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Feb 2020 14:58:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbgBCT6h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Feb 2020 14:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580759916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wq18Hvvo+EOcNLmYOZqnpt8WL6bT2KvkIZ+84qXmYr0=;
        b=ELWXToZla4+ZpQThg4lrKkSyzvyMX/p38tTyIJlFG5/1PqQbqJesVlUvn27Zv1oY0curlO
        fFmN2+N/L/WY9zUphwc784W/HhXygteBkS+4PnstF2DehbXxiX1YUXdiuq6Q3XivKZM7zN
        NGlWpSYSWw4I7odeYpHjvEpCftF916I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-A8EV7TxENuG7RFVlxWxyVw-1; Mon, 03 Feb 2020 14:58:34 -0500
X-MC-Unique: A8EV7TxENuG7RFVlxWxyVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 176A91005502;
        Mon,  3 Feb 2020 19:58:33 +0000 (UTC)
Received: from krava (ovpn-204-85.brq.redhat.com [10.40.204.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA62D8CCC2;
        Mon,  3 Feb 2020 19:58:29 +0000 (UTC)
Date:   Mon, 3 Feb 2020 20:58:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>
Subject: Re: [PATCH 5/5] bpf: Allow to resolve bpf trampoline in unwind
Message-ID: <20200203195826.GB1535545@krava>
References: <20191229143740.29143-1-jolsa@kernel.org>
 <20191229143740.29143-6-jolsa@kernel.org>
 <20200106234639.fo2ctgkb5vumayyl@ast-mbp>
 <20200107130546.GI290055@krava>
 <76a10338-391a-ffca-9af8-f407265d146a@intel.com>
 <20200113094310.GE35080@krava>
 <a2e2b84e-71dd-e32c-bcf4-09298e9f4ce7@intel.com>
 <9da1c8f9-7ca5-e10b-8931-6871fdbffb23@intel.com>
 <20200113123728.GA120834@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200113123728.GA120834@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 13, 2020 at 01:37:28PM +0100, Jiri Olsa wrote:
> On Mon, Jan 13, 2020 at 01:31:38PM +0100, Bj=F6rn T=F6pel wrote:
> > On 2020-01-13 13:21, Bj=F6rn T=F6pel wrote:
> > >=20
> > > On 2020-01-13 10:43, Jiri Olsa wrote:
> > > > hi,
> > > > attached patch seems to work for me (trampoline usecase), but I
> > > > don't know
> > > > how to test it for dispatcher.. also I need to check if we need t=
o
> > > > decrease
> > > > BPF_TRAMP_MAX or BPF_DISPATCHER_MAX, it might take more time;-)
> > > >=20
> > >=20
> > > Thanks for working on it! I'll take the patch for a spin.
> > >=20
> > > To test the dispatcher, just run XDP!
> > >=20
> > > With your change, the BPF_DISPATCHER_MAX is still valid. 48 entries=
 =3D>
> > > 1890B which is < (BPF_IMAGE_SIZE / 2).
>=20
> great
>=20
> > >=20
> >=20
> > ...and FWIW, it would be nice with bpf_dispatcher_<...> entries in ka=
llsyms
>=20
> ok so it'd be 'bpf_dispatcher_<name>'

hi,
so the only dispatcher is currently defined as:
  DEFINE_BPF_DISPATCHER(bpf_dispatcher_xdp)

with the bpf_dispatcher_<name> logic it shows in kallsyms as:
  ffffffffa0450000 t bpf_dispatcher_bpf_dispatcher_xdp    [bpf]

to fix that, would you guys preffer having:
  DEFINE_BPF_DISPATCHER(xdp)=20

or using the full dispatcher name as kallsyms name?
which would require some discipline for future dispatcher names ;-)

thanks,
jirka

