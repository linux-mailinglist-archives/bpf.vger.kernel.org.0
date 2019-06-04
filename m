Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC233E11
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2019 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDE3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 00:29:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDE3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 00:29:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so11869323pfe.6
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2019 21:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YotpcPgy/ioLN67cVEDyEBsnoXdJdPakdgz5ApLCKBw=;
        b=vuaYM4A0poBnYZZxP35tYSRSs5ZAwY0nZXUpR9OsgNvq7oymErrMjALZJKhL5mN7Pg
         suEaN+JJSRJEv2VFGHahe7uKa4LOd2Ju2/35oF7K6qmewnSQTZIY7misahhfJ2a4Umqn
         4+FDmEn+Z8mk7c4YJar8nLKcyvEbUAKqdyiQxL9BGmG6e1ISstAxOFiiCVH+FFP+Hi6f
         Rp6ixq7zr411GGOT4BASjzgvU7Q1A1haFfH0V74DRQ+xmfjAS1/Kb7No92G3enkiWlXr
         9ncfGmD04t4i/NsnvM/RbnqRf885wEcjypnJKmTyfBFLUAY9ssx3n8uUzUZLdqetqbR6
         pIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YotpcPgy/ioLN67cVEDyEBsnoXdJdPakdgz5ApLCKBw=;
        b=GMgzmH8UphpZb60iWBbPt+74FlPVR9Ckc6beKPnEf6kVZrAw9McofURS4gtvlxns7v
         PI2ewLw85U0KjM9pfNArW+7pb9M/rduyqCmGVIjgui8ypGzfkIuaEgW2ZDT2pxyaDX2O
         OqzCVcD94EI/DALglDyvKqxFUeeZbGCXdr39MmLDXOcwr6awUTL4xZXnfy/YIQbKe0Iw
         tz8E/uP6w41blxjvs0gc3lrIv+ZYGhu0DL2uL0IP6LlB1bbrvR04y4GU1NcgUOmdR3t5
         xULNiy7Y2a0tLd5CAFX2nH58/T+CKRhcqBT66/dg67rKzdDB4oUgvme/ViN+FH8kjHDr
         5HBw==
X-Gm-Message-State: APjAAAW4N16Y0Nwp1XTjB52LaBrnnPOnGqYXB6f1CitTC8DugAZwkLkY
        dVt7fH7S1oT+Cm41bAvGy6HPFw==
X-Google-Smtp-Source: APXvYqxr9pbzD16CDHaDITplzgJZ0pdLe7pnp0oejXhAzlarnnMQ5G4pKa94Ngv5uU0D1h47wCh8aw==
X-Received: by 2002:aa7:8248:: with SMTP id e8mr36021946pfn.155.1559622544057;
        Mon, 03 Jun 2019 21:29:04 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id q20sm15305137pgq.66.2019.06.03.21.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 21:29:03 -0700 (PDT)
Date:   Mon, 3 Jun 2019 21:29:02 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 6/8] libbpf: allow specifying map
 definitions using BTF
Message-ID: <20190604042902.GA2014@mini-arch>
References: <20190531202132.379386-1-andriin@fb.com>
 <20190531202132.379386-7-andriin@fb.com>
 <20190531212835.GA31612@mini-arch>
 <CAEf4Bza38VEh9NWTLEReAR_J0eqjsvH1a2T-0AeWqDZpE8YPfA@mail.gmail.com>
 <20190603163222.GA14556@mini-arch>
 <CAEf4BzbRXAZMXY3kG9HuRC93j5XhyA3EbWxkLrrZsG7K4abdBg@mail.gmail.com>
 <20190604010254.GB14556@mini-arch>
 <f2b5120c-fae7-bf72-238a-b76257b0c0e4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b5120c-fae7-bf72-238a-b76257b0c0e4@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> BTF is mandatory for _any_ new feature.
If something is easy to support without asking everyone to upgrade to
a bleeding edge llvm, why not do it?
So much for backwards compatibility and flexibility.

> It's for introspection and debuggability in the first place.
> Good debugging is not optional.
Once llvm 8+ is everywhere, sure, but we are not there yet (I'm talking
about upstream LTS distros like ubuntu/redhat).
