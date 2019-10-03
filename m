Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FEECAB66
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfJCRVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Oct 2019 13:21:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389421AbfJCRVH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Oct 2019 13:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570123266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7rXGAQSbiGa4/7Bkctjr6dl8SSz5zO8pwOGZPcMe1w=;
        b=QN1UGe28ocRTI/3XboKP84GZCpvWUqeja4IGFpzYB3gx9Y9Um4l62cyotb+N2NkN0Kgt1f
        fJuC8MfaBN4jkJe/jeVj+BNwhQ9A0+YmZFVY5ULMXNutA2EemUwIRbNK7DKL+2IM20JIOh
        nLp9ET9nI3Alv1VTW7MDWzlsZT4k998=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-YIQgiriSMA6VnjMSmVHHIg-1; Thu, 03 Oct 2019 13:21:04 -0400
Received: by mail-lj1-f199.google.com with SMTP id r22so1068793ljg.15
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 10:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Z7rXGAQSbiGa4/7Bkctjr6dl8SSz5zO8pwOGZPcMe1w=;
        b=JHatrsNQd4CxqIOmTO7MbKC6n6p47f8pN3YW/jUeoQyZiMRFnw3rfDncRE5mEXHZ1H
         kvUKrW0lOde8Dwjx71BhPojQyYFGdDFM2HPJHlnhpOu45WMuz0W6lA5WT+qol3qZgbQp
         1V9olKn0lq4cPXMxDCwLhXyC/PWk4GV719RHa3OHAazpcmi/c3CxMeJVtquGbYMGPC8H
         OFPs9kTo+4Q2eO8uWFDzygdlglBph/TXtogcYwpsRBiWagnucN6/ckA1A3ZjhXxFDJSY
         vbNX5KOoaTWNYcY3PLvCBzf165HAWFutQLVsuwPX1sVANqcu/SDuJUVeC9Gr0X0nCd09
         zPaQ==
X-Gm-Message-State: APjAAAVVpLcEWGPHxb3GVN/QxX72BhW65wDDB52b/x9adh+uw9267X6i
        by8voe72ZzALzax3uFhbtfm4byCZkMPHUrFaq/kSi12dfWttDn8kpQOb3R6GEm1+4Zp+86pma+b
        n9FgUcSXde3Y6
X-Received: by 2002:a2e:301a:: with SMTP id w26mr6813889ljw.168.1570123262610;
        Thu, 03 Oct 2019 10:21:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdVca8Nh/s/XnjRxYBzzGYfahRNbeqRheVUMUAoTyrgPFZWpEK8rXkXg5jaqOA/m79I5yRKA==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr6813876ljw.168.1570123262441;
        Thu, 03 Oct 2019 10:21:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id i142sm571559lfi.5.2019.10.03.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:21:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5D8E18063D; Thu,  3 Oct 2019 19:21:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/7] selftests/bpf: split off tracing-only helpers into bpf_tracing.h
In-Reply-To: <CAEf4BzZa9aSz_FXkexKWse_k-m0WvxZJZG6qOqacaKKxgHb1OA@mail.gmail.com>
References: <20191002215041.1083058-1-andriin@fb.com> <20191002215041.1083058-5-andriin@fb.com> <87imp6qo1o.fsf@toke.dk> <CAEf4BzZa9aSz_FXkexKWse_k-m0WvxZJZG6qOqacaKKxgHb1OA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Oct 2019 19:21:00 +0200
Message-ID: <87ftk9pwxv.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: YIQgiriSMA6VnjMSmVHHIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 3, 2019 at 12:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > +/* a helper structure used by eBPF C program
>> > + * to describe BPF map attributes to libbpf loader
>> > + */
>> > +struct bpf_map_def {
>> > +     unsigned int type;
>> > +     unsigned int key_size;
>> > +     unsigned int value_size;
>> > +     unsigned int max_entries;
>> > +     unsigned int map_flags;
>> > +};
>>
>> Why is this still here? There's already an identical definition in libbp=
f.h...
>>
>
> It's a BPF (kernel) side vs userspace side difference. bpf_helpers.h
> are included from BPF program, while libbpf.h won't work on kernel
> side. So we have to have a duplicate of bpf_map_def.

Ah, yes, of course. Silly me :)

-Toke

