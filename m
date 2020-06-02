Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE801EB71E
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBIPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 04:15:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgFBIPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 04:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591085701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZ49NH6CVqJKHYnyH/nFelZVybu6B+BmB63vlV84gtc=;
        b=dEL8taRoRbQOlpFPo6netG5wHMZiphAnnw4x86X7GiHlfWZbyizxnCC2i5+wAsju77MqPB
        A0ACJuZg24kSz7GsPq++01jusjYqn1GZ6b8JC5JHdvW10LDzbOTnngd662sNN3ZpXcbxml
        SIzRj4SBRgixjWjBr5kb9/PfdAo4EQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-pmv1Vb-VMRyw4L5h_sMqLQ-1; Tue, 02 Jun 2020 04:14:52 -0400
X-MC-Unique: pmv1Vb-VMRyw4L5h_sMqLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C28BFC3;
        Tue,  2 Jun 2020 08:14:50 +0000 (UTC)
Received: from krava (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 854C82DE79;
        Tue,  2 Jun 2020 08:14:48 +0000 (UTC)
Date:   Tue, 2 Jun 2020 10:14:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wenbo Zhang <ethercflow@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <bgregg@netflix.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
Message-ID: <20200602081447.GB1112120@krava>
References: <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net>
 <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava>
 <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
 <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net>
 <20200212152149.GA195172@krava>
 <CABtjQmaDg_kzuDrANQi8rWhZWGarP8OkiZtzi+XWvC-T9Jmz+Q@mail.gmail.com>
 <CAADnVQ+GGjNK+QvT+qc6j0AZ8s4bvY5TDjKtJ4ZEnBEH4c8Uvg@mail.gmail.com>
 <CABtjQmYQKf=Kcyk+dVqSkgvsemtcpV_xtcGY-XnQh+9LGt60bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtjQmYQKf=Kcyk+dVqSkgvsemtcpV_xtcGY-XnQh+9LGt60bw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 02, 2020 at 11:04:02AM +0800, Wenbo Zhang wrote:
> Get it, I'll search Jiri's patches to see how to use that. Thanks.

I'll cc you in the next post

jirka

> 
> Alexei Starovoitov <alexei.starovoitov@gmail.com> 于2020年6月2日周二 上午12:38写道：
> >
> > On Mon, Jun 1, 2020 at 7:17 AM Wenbo Zhang <ethercflow@gmail.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > I find https://patchwork.ozlabs.org/project/netdev/patch/7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com/
> > > this PR's current state is Awaiting Upstream. I don't know much about
> > > this state. I want to ask if this PR will be merged.
> >
> > This one won't be merged.
> > Jiri had sent patches based on whitelist approach.
> > That's a proper direction to address locking concerns.
> 

