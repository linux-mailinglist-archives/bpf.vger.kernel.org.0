Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414B748338B
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiACOiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 09:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235515AbiACOga (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 09:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641220586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6S1XPJQfGremvTb3LBNGu2BEruAkVvXKB9QFLHNFjlY=;
        b=UW07kuZNPa9xPfygw9fDVfXta8qWT1B/e70UEhIimCW+P1BGPGO5bHSr0RHWliyH9/bc+/
        j7aYDR31repQTl45VK+ql7dg2lwb+zHmrauPxjD8HYrQ5Vqn2sxCPmYtMWraHWw41I81mg
        O2QQwrrUPZ+36uW1eb97xXRdCTLJQ+4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-ajKE3--0MBuE1z1LnTPBDQ-1; Mon, 03 Jan 2022 09:36:25 -0500
X-MC-Unique: ajKE3--0MBuE1z1LnTPBDQ-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso22928535edt.20
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 06:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6S1XPJQfGremvTb3LBNGu2BEruAkVvXKB9QFLHNFjlY=;
        b=fybgtEtBQbu0CGZ8okT43CL3/pBNCTgp2K1ivTOPKUSc1viOM2Br6EVAYMaNu8RiBy
         fLTHvGqf65WSf7YXgtUyBqKHLj1m4vdCiltNDqQJ/4sRCQ5smJTPnqZ15+moSSrjzLIz
         Mj3FCZWhJC6H0nJe4b0biGOP1zzY7ek/Ctm2JvN+Ij06tjni7k2/LFLOij14xjUH7Vc9
         NZ8i/m6lRqJoEL/KqtoVPyav6R4hSQ0nsnN/g4Lr/PEXZmneYMq7VtgGvWwRTeirBIxx
         subAqti8IfSx0HqdSE+6hjkR7OUCNHVn5NrKXJzof2ThKdtLFxmYy2cllyZt+tLenQ15
         BMqw==
X-Gm-Message-State: AOAM533Gk6elxDixM1FSUzraMxhx90C65gyiHoTx0m66M1Hqy5VjLEmf
        sNy0vgNR/oqoFUEk3pMzMVvFxeJqSp+rVA+JsvT8bzAhLuVlbw31pi2bcHseZJQFVFv8ZImCQK2
        yty79qAXSerdu
X-Received: by 2002:a17:907:33d0:: with SMTP id zk16mr35770359ejb.165.1641220584746;
        Mon, 03 Jan 2022 06:36:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/2vxpr9zrRB2To0dotN1c4A64scychvym1I8BTv193we4aIN9+pu1XK7snkA6wTtoCKxiIg==
X-Received: by 2002:a17:907:33d0:: with SMTP id zk16mr35770350ejb.165.1641220584523;
        Mon, 03 Jan 2022 06:36:24 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 19sm7714227ejv.207.2022.01.03.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 06:36:24 -0800 (PST)
Date:   Mon, 3 Jan 2022 15:36:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, haliu@redhat.com,
        Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Yonghong Song <yhs@fb.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: Re: [BUG] powerpc: test_progs -t for_each faults kernel
Message-ID: <YdMJ5fuRr+rKiNCe@krava>
References: <YdIiK8/krc5x5BmM@krava>
 <1641188093.6jujx0dvg7.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641188093.6jujx0dvg7.naveen@linux.ibm.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 03, 2022 at 11:07:02AM +0530, Naveen N. Rao wrote:
> Hi Jiri,
> 
> Jiri Olsa wrote:
> > hi,
> > when running 'test_progs -t for_each' on powerpc we are getting
> > the fault below
> 
> This looks to be the same issue reported by Yauheni:
> http://lkml.kernel.org/r/xunylf0o872l.fsf@redhat.com
> 
> Can you please check if the patch I posted there fixes it for you?

great, yes, that fixes it for me

thanks,
jirka

