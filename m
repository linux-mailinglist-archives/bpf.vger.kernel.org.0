Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1391ABB74
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502572AbgDPIiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 04:38:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501892AbgDPIdC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 04:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587025981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C+zGeC2uaepA7YGuXsNsDUyW6GG/C37GwZVj2NCs8M=;
        b=Kmyaf9KjxztuNJhfl9rhh+MR9z91o5ZN6CSR00smsifMGlGmIXNHtWJNU5goBCvBtgdJYL
        GpDiXzB5366xcANXRwqUaING21lhQBV44I3aK3U6KFV7UqWAJpI1Sbk4KS6GjpWBm1WIT3
        VNdYiYzI8XCMkPpZuoJwvNwACLN1OBk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-HH0lHl1ROQOTs03GcFG7AQ-1; Thu, 16 Apr 2020 04:23:33 -0400
X-MC-Unique: HH0lHl1ROQOTs03GcFG7AQ-1
Received: by mail-lj1-f199.google.com with SMTP id o13so1355075ljj.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 01:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4C+zGeC2uaepA7YGuXsNsDUyW6GG/C37GwZVj2NCs8M=;
        b=G2Bz7RXH44K2MHXtcW2V76pb08kQZFi5gn3XG8GFDQ40gGjWeQOfCgnFalHQ8p4zWp
         Po5i4aS/uAPyxOKCrCvQloIxu66p7iLDflfOxQMkm53dQqP+UdcFQfKJA81VXnX7Uofr
         xAoFK0qXxJqGjgNxtxiCe1EJrUirlljvi+nGqE21DdbzHmU1/jAbD5Dum17ic4R6lO2h
         ys3xrpQ2q/KkwM3r4/keZ25CRNA6G7tSpSEFCxwi5fl1Vc39XM6XtgTio2o6q0yx/7h7
         QiFAZgFfV2qN/XQIT8Dk6LEvs+k15N9NETYVWa3u842AGg2qP0/JGKbHay6cP2SIPE8y
         HvPA==
X-Gm-Message-State: AGi0PubZ+m3XsBFT4WEbn/8M+kJFa1kLIT5op2VLnvCszfXNjsDX4AYH
        DAlHPtE3NxSlVmhHF/O6IGmCreI+1+6am4/F045FeN/Jd5fEx+3KiQFHRvB99u63BpwxGm+MG7Y
        AsEdbtuVeAnvt
X-Received: by 2002:ac2:5559:: with SMTP id l25mr5465308lfk.55.1587025411714;
        Thu, 16 Apr 2020 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUxS2MrVwPdgFhPczv6ujV5NRc5E55/X8RHd0otAj5dsbnq589pXigr4Vq7wN9Pjdythnn1Q==
X-Received: by 2002:ac2:5559:: with SMTP id l25mr5465292lfk.55.1587025411426;
        Thu, 16 Apr 2020 01:23:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c2sm15281083lfb.43.2020.04.16.01.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:23:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CE153181586; Thu, 16 Apr 2020 10:23:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        brouer@redhat.com
Subject: Re: [PATCH bpf] cpumap: Avoid warning when CONFIG_DEBUG_PER_CPU_MAPS is enabled
In-Reply-To: <20200416085537.65dde42e@carbon>
References: <20200415140151.439943-1-toke@redhat.com> <20200416085537.65dde42e@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Apr 2020 10:23:29 +0200
Message-ID: <87h7xjn8ji.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Wed, 15 Apr 2020 16:01:51 +0200
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> When the kernel is built with CONFIG_DEBUG_PER_CPU_MAPS, the cpumap code
>> can trigger a spurious warning if CONFIG_CPUMASK_OFFSTACK is also set. T=
his
>> happens because in this configuration, NR_CPUS can be larger than
>> nr_cpumask_bits, so the initial check in cpu_map_alloc() is not sufficie=
nt
>> to guard against hitting the warning in cpumask_check().
>>=20
>> Fix this by using the nr_cpumask_bits variable in the map creation code
>> instead of the NR_CPUS constant.
>
> Shouldn't you use 'nr_cpu_ids' instead of 'nr_cpumask_bits' ?
>
> Else this will still fail on systems with CONFIG_CPUMASK_OFFSTACK=3Dn.

Jesper and I had an offlist discussion about this, and decided that it's
actually better to keep the check in cpu_map_alloc as-is, and instead
just check against nr_cpumask_bits in cpu_map_update_elem(). Otherwise,
the max-size of the map can vary between machines which can affect BPF
program portability.

I'll send a v2.

-Toke

