Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D43D1E2A2D
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEZSfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 14:35:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387399AbgEZSfy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 May 2020 14:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590518152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ogM6EMAk5wZGZ44YTRT0bYlk0gdm9Bl2w0G3CGLJGw=;
        b=Xz5dVaJqvDSIDem4jfsWJlLtHpDH8Z6a5s+Ad2rhoK2Lms3b7HglHAR4KfMz5OFo3hdT6M
        rbiskgn/j90yl2PJXskopIQcfTJVl//o1+LJmlopJzdDyXy5mOLGcyov6hhYN8bb8JtkgT
        U+BEq5cf63abXOiUnmF69Ri6KwDlgzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-JXKRwOwqOACu_s2dR4f3-w-1; Tue, 26 May 2020 14:35:49 -0400
X-MC-Unique: JXKRwOwqOACu_s2dR4f3-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEF7D461;
        Tue, 26 May 2020 18:35:47 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52E7D10013D5;
        Tue, 26 May 2020 18:35:43 +0000 (UTC)
Date:   Tue, 26 May 2020 20:35:41 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        brouer@redhat.com
Subject: Re: [PATCH bpf-next] bpf: Fix map_check_no_btf return code
Message-ID: <20200526203541.41efd94d@carbon>
In-Reply-To: <CAEf4BzaXE5AsR1EvC8kQRoiRbsdLtq2AkHSU9_NqijAWxcN5fQ@mail.gmail.com>
References: <159050511046.148183.1806612131878890638.stgit@firesoul>
        <CAEf4BzaXE5AsR1EvC8kQRoiRbsdLtq2AkHSU9_NqijAWxcN5fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 May 2020 11:16:50 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, May 26, 2020 at 7:59 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > When a BPF-map type doesn't support having a BTF info associated, the
> > bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
> > map_check_no_btf() currently returns -ENOTSUPP, which result in a very
> > confusing error message in libbpf, see below.
> >
> > The errno ENOTSUPP is part of the kernels internal errno in file
> > include/linux/errno.h. As is stated in the file, these "should never be seen
> > by user programs."
> >
> > Choosing errno EUCLEAN instead, which translated to "Structure needs
> > cleaning" by strerror(3). This hopefully leads people to think about data
> > structures which BTF is all about.  
> 
> How about instead of tweaking error code

Regardless we still need to change the error code used, as strerror(3)
cannot convert it to something meaningful.  As the code comment says
this errno "should never be seen by user programs.".

My notes are here:
 https://github.com/xdp-project/xdp-project/blob/BTF01-notes.public/areas/core/BTF_01_notes.org

> we actually just add support
> for BTF key/values for all maps. For special maps, we can just enforce
> that BTF is 4-byte integer (or typedef of that), so that in practice
> you'll be defining it as:
> 
> struct {
>     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>     __type(key, u32);
>     __type(value, u32);
> } my_map SEC(".maps");
> 
> and it will just work?

Nope, this will also fail.

I'm all for adding support for more BPF-maps in follow up patches.  I
will soon be adding support for cpumap and devmap.  And I will likely
be asking all kind of weird questions, I hope I can get some help from
you to figure out all the details ;-)

> >
> > Before this change end-users of libbpf will see:
> >  libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.
> >
> > After this change end-users of libbpf will see:
> >  libbpf: Error in bpf_create_map_xattr(cpu_map):Structure needs cleaning(-117). Retrying without BTF.
> >
> > Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > ---
> >  kernel/bpf/syscall.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index d13b804ff045..ecde7d938421 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
> >                      const struct btf_type *key_type,
> >                      const struct btf_type *value_type)
> >  {
> > -       return -ENOTSUPP;
> > +       return -EUCLEAN;
> >  }
> >
> >  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> >

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

