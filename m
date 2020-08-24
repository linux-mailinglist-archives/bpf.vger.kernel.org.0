Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4533124FD10
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHXL5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 07:57:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbgHXL5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 07:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598270234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMvM2RtL83e2YUaGWF80AZDLFuLnlaj4E2rguE786ng=;
        b=OnBy6Fp3KHd6ie8M3A9uoRBfvsVrnI+8NX829x8yFYMUioz7lr6c4h3PFfTIr8zJPLm31h
        hc/Il9EXsU5HclPHOcr0f0nS6KzNOXHA66t1Gqc2hjK3rv+G7liBKgISDxtUAJ1FvCNmkL
        zp3BWl3MFdDAfZZJ014fZGgkvTr3MDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-Q8EgwxsjP_CIN0PTdLYqDA-1; Mon, 24 Aug 2020 07:57:12 -0400
X-MC-Unique: Q8EgwxsjP_CIN0PTdLYqDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB5DB807331;
        Mon, 24 Aug 2020 11:57:10 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA7BA7C656;
        Mon, 24 Aug 2020 11:57:05 +0000 (UTC)
Date:   Mon, 24 Aug 2020 13:57:04 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, brouer@redhat.com
Subject: Re: [PATCH bpf] selftests/bpf: Fix test_progs-flavor run getting
 number of tests
Message-ID: <20200824135704.2b86fc83@carbon>
In-Reply-To: <CAADnVQLA4UNsooPg7Cwk3hQU8dih6uATrOi+-V-a8b0Nb_ndWw@mail.gmail.com>
References: <159802249863.919353.9321169154213417316.stgit@firesoul>
        <CAADnVQLA4UNsooPg7Cwk3hQU8dih6uATrOi+-V-a8b0Nb_ndWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Aug 2020 12:45:08 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index b1e4dadacd9b..d858e883bd75 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -618,7 +618,7 @@ int cd_flavor_subdir(const char *exec_name)
> >         if (!flavor)
> >                 return 0;
> >         flavor++;
> > -       fprintf(stdout, "Switching to flavor '%s' subdirectory...\n", flavor);
> > +       fprintf(stderr, "Switching to flavor '%s' subdirectory...\n", flavor);  
> 
> Hmm. May be move it under -v flag instead?
> The person or script that runs test_progs-no_alu32 knows what's happening.
> That message either to stdout or stderr will be fine under extra verbose flag.

Sounds good to me with a -v flag, sending V2

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

