Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1414409F
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2020 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAUPhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 10:37:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58427 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgAUPhi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jan 2020 10:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579621057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEbtb5iPk+ToPcHf5Qqxgw96P5QADIf6QorZP19ushc=;
        b=f0BJ2kGksH7lNdA/SFizeD1ld4mMnMu9RhoPt0H5OAzea8e+ZM9BlRcfL2ymMgZeuzAoy2
        UPAbws/SMmEypBwiDns/E9+RMwCvsTn+d6i6oUBEIOzQPNKCj9pdurfcLE16AE5fpFKGKN
        5j9HqwrT8rpL028+1N5lz9iq4RXZTj0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-11SHWrFfOhSVAdHGVfA8mQ-1; Tue, 21 Jan 2020 10:37:35 -0500
X-MC-Unique: 11SHWrFfOhSVAdHGVfA8mQ-1
Received: by mail-lf1-f70.google.com with SMTP id z3so963424lfq.22
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 07:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KEbtb5iPk+ToPcHf5Qqxgw96P5QADIf6QorZP19ushc=;
        b=MnZA43mnQzzWvBYh0OA6evBIGK4JRjEySBdV5TzyMTzYZEXwkqC1AwtuiSu1db5qzD
         ODArZ1E8ex/OG2WRcs1zIvLvfQNwQY1O6k9wq9dwdowrPksiMYRGR/dMmbj7S1MFvn+z
         9gxgvImB4STeA+4J3r79KippJgFCtluv5sR7jzDmJ8bcJJRGMsUVcx/zZmvcxE+6c6v4
         gwWdRfRtYJNEgXtDefRUY2Im7ctrXu2Bl5StmnMqL/0neXKcG5IIh/cK52OG73Q9864x
         3R39+JJfPIMIflg2NTO5Ym4yJqsMEPZrvY4kuaI05Pi9oPmVpo6QKXaYu/C9SFZpPgFr
         57nw==
X-Gm-Message-State: APjAAAWzqcMIreiPR0omVny7WO2X1U6HqJsNWIWMJXYrYgR+LmHmtrdH
        N03zvQJn5Bn7mqu/0Map0zde2XDzn9T7p0Vr1WsrNNu0dnDToP2Ri1hA3IzYQ5pUQc5SQII+TAu
        pLt2aZonyjJlQ
X-Received: by 2002:ac2:5964:: with SMTP id h4mr2950785lfp.213.1579621054189;
        Tue, 21 Jan 2020 07:37:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6uaYdLVGSTACmkFUIlBWi+Ha5SsSLjiSCZDkG7dr7z3tLFd30yps7dKGbcY0cYUdeEr7ISw==
X-Received: by 2002:ac2:5964:: with SMTP id h4mr2950770lfp.213.1579621053832;
        Tue, 21 Jan 2020 07:37:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o19sm22699778lji.54.2020.01.21.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:37:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE53118006B; Tue, 21 Jan 2020 16:37:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: Program extensions or dynamic re-linking
In-Reply-To: <20200121005348.2769920-1-ast@kernel.org>
References: <20200121005348.2769920-1-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 21 Jan 2020 16:37:31 +0100
Message-ID: <87k15kbz2c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> The last few month BPF community has been discussing an approach to call
> chaining, since exiting bpt_tail_call() mechanism used in production XDP
> programs has plenty of downsides. The outcome of these discussion was a
> conclusion to implement dynamic re-linking of BPF programs. Where rootlet=
 XDP
> program attached to a netdevice can programmatically define a policy of
> execution of other XDP programs. Such rootlet would be compiled as normal=
 XDP
> program and provide a number of placeholder global functions which later =
can be
> replaced with future XDP programs. BPF trampoline, function by function
> verification were building blocks towards that goal. The patch 1 is a fin=
al
> building block. It introduces dynamic program extensions. A number of
> improvements like more flexible function by function verification and bet=
ter
> libbpf api will be implemented in future patches.

This is great, thank you! I'll go play around with it; couldn't spot
anything obvious from eye-balling the code, except that yeah, it does
need a more flexible libbpf api :)

One thing that's not obvious to me: How can userspace tell which
programs replace which functions after they are loaded? Is this put into
prog_tags in struct bpf_prog_info, or?


For the series:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


-Toke

