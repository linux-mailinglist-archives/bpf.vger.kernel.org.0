Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2213DC68
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAPNvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 08:51:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgAPNvs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 08:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579182708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSQVRIo5T/T5M3nGFCM1g0cRJLehKx87k0xRn1tRw/I=;
        b=Ds0GJHtD5sEQ3OvHo1R/Qotu5pJBP9u7vq2bS3DMdkranifv3aSYXG9U4LUlxwMJTVv4mF
        wqy2ig/iAbVrmMZZJKcf0XCi5ggCMdOqhqqtlosp4Q52PTDYE4FyDpzP/BAgrhDuxFIuZs
        tbtjQj1sZJ8lMIV3G+dviSuLQmAIFFU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-DxkD6LSLOw2TYqG81AEtWQ-1; Thu, 16 Jan 2020 08:51:45 -0500
X-MC-Unique: DxkD6LSLOw2TYqG81AEtWQ-1
Received: by mail-lj1-f197.google.com with SMTP id a19so5184459ljp.15
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 05:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HSQVRIo5T/T5M3nGFCM1g0cRJLehKx87k0xRn1tRw/I=;
        b=gjYBiUjGiO4/ao2PBfSSVBUxp4219mPW6CyZs+IwqJPps+1/2p5efW6l+tQcQDw16E
         ouyKlV28JBwQGP614FKMBbbf/znMui6KRJMeBWGDYFLapFyWggsM9TgY06tQFz0nfcd1
         BoyFcp7KstoH1iqxxIU7bGGvmgwcm7pa3HgqiP+4KKR6PaoRNFB9+i0izX6RfDov8xRE
         MSKQ2Lg7yYpd90AxUvigPenQ+jb2ZJu4k2fxkn5IRNv0MSUcQQK22YOjmxLZciS2Fgwf
         2dHqt7pQIwZb+qFBxg/3niloPCL8lrhZ+e9gPz/htjeR7G3Z4D1WOmaym2t+lSf7c4sL
         wlMQ==
X-Gm-Message-State: APjAAAW7F0ccHXx5V33fpKR38YAVrnJfDXwB7bCUFW37iKSMhjwrHjLB
        sF5XUHAU5npUPS22j/JfOoZGGUv/J92HgCMEjzByvf9qa3C3y5xNZnIcTBhdsczRN99ByxkegWP
        ifcj5Qmhq6JUL
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr2468611ljk.112.1579182703739;
        Thu, 16 Jan 2020 05:51:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5xWH2dF5z9n9RENXRXJOekRF4nc4sEZeF/z5EVeEgZaDID+Q1VUd2+8YwPCybuhIS5I/IHQ==
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr2468585ljk.112.1579182703425;
        Thu, 16 Jan 2020 05:51:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b6sm10570279lfq.11.2020.01.16.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:51:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 375971804D6; Thu, 16 Jan 2020 14:51:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 1/2] xdp: Move devmap bulk queue into struct net_device
In-Reply-To: <20200116122400.499c2b1e@carbon>
References: <157893905455.861394.14341695989510022302.stgit@toke.dk> <157893905569.861394.457637639114847149.stgit@toke.dk> <20200115211734.2dfcffd4@carbon> <87imlctlo6.fsf@toke.dk> <20200116122400.499c2b1e@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Jan 2020 14:51:41 +0100
Message-ID: <87lfq7se4y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Wed, 15 Jan 2020 23:11:21 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>=20
>> > On Mon, 13 Jan 2020 19:10:55 +0100
>> > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> >=20=20
>> >> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> >> index da9c832fc5c8..030d125c3839 100644
>> >> --- a/kernel/bpf/devmap.c
>> >> +++ b/kernel/bpf/devmap.c=20=20
>> > [...]=20=20
>> >> @@ -346,8 +340,7 @@ static int bq_xmit_all(struct xdp_bulk_queue *bq,=
 u32 flags)
>> >>  out:
>> >>  	bq->count =3D 0;
>> >>=20=20
>> >> -	trace_xdp_devmap_xmit(&obj->dtab->map, obj->idx,
>> >> -			      sent, drops, bq->dev_rx, dev, err);
>> >> +	trace_xdp_devmap_xmit(NULL, 0, sent, drops, bq->dev_rx, dev, err);=
=20=20
>> >
>> > Hmm ... I don't like that we lose the map_id and map_index identifier.
>> > This is part of our troubleshooting interface.=20=20
>>=20
>> Hmm, I guess I can take another look at whether there's a way to avoid
>> that. Any ideas?
>
> Looking at the code and the other tracepoints...
>
> I will actually suggest to remove these two arguments, because the
> trace_xdp_redirect_map tracepoint also contains the ifindex'es, and to
> troubleshoot people can record both tracepoints and do the correlation
> themselves.
>
> When changing the tracepoint I would like to keep member 'drops' and
> 'sent' at the same struct offsets.  As our xdp_monitor example reads
> these and I hope we can kept it working this way.
>
> I've coded it up, and tested it.  The new xdp_monitor will work on
> older kernels, but the old xdp_monitor will fail attaching on newer
> kernels. I think this is fair enough, as we are backwards compatible.

SGTM - thanks! I'll respin and include this :)

-Toke

