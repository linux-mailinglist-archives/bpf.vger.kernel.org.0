Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B844B3158
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbiBKXhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:37:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbiBKXhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FD4CD5A
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644622648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpOPfDYPDnKxhUSLr/z486TAlhyuOTHMU0MiS0oYSD8=;
        b=cwQUTGnmtjhe7dsZSBrt3QDSE48iYltTKmogWq8PcbPEwss6KJKYpSsWv22y3zQgYE+Tfy
        +4xcBvpYU/EwlsTcd1fYi7veosOtR+xU4H9fWCgECqENr33psO6PBrNH2oM7rQhXHyBxFL
        bCnBCtfUaLES8xxDCnAT+Q6uR+mT+Vs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-pJ3-mO3qN0m9EOCFAeKa2g-1; Fri, 11 Feb 2022 18:37:27 -0500
X-MC-Unique: pJ3-mO3qN0m9EOCFAeKa2g-1
Received: by mail-ed1-f69.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so6266950edz.8
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZpOPfDYPDnKxhUSLr/z486TAlhyuOTHMU0MiS0oYSD8=;
        b=lMRFhGHMNGiGqGm2dHVyLfbCnyluw6qcSsQOoqIUDPT+dIyHXIpBdqjixdA1INHI0O
         v541rzwPWOHEaovBEwVvHaw0aDf0yeXB4KULoz1WFCnE2Gt/0KmDgxLCXwLqVFeVEUw5
         ZlRHl2DvVu4YYgCotw4N3gN5FgHIRBi/u0w4OyF3HS5j4U4QWZH7mKmiJ+8Q1YLZe8Fy
         DNvOMMCWqfelkYkehVrxHiKJr3DSxuDZY6Rnd5eG9iucE7aBqf421zmJLkI0eihL88fv
         DP4jTLpnh1PmB+MZyrGZhJwsmFKBTKVW0jmDBMLYJ+igsy9PsY8k/JGmp0PjNGYdTYjh
         /npg==
X-Gm-Message-State: AOAM533VoJoNY73u2hrtX2NvohnkrM/UI5zlAOc4mGoQe7vYf36CvYTK
        XqEZt4VZ4PPVz8Y13NZDf9pi1xfSNzFeuxt5twq0kUDuL5cSbOrHogpUN0AqHps1kIjdpATj5Kt
        Y13lpr4USe+SY
X-Received: by 2002:a17:906:3e87:: with SMTP id a7mr3195161ejj.227.1644622643963;
        Fri, 11 Feb 2022 15:37:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytFvHbZt5dgj+JRaP+OjPZe+i3ybKk2FKM0FEpTHYUiqjagN0jhvRN0rdHV9yZpD9sYzQF/A==
X-Received: by 2002:a17:906:3e87:: with SMTP id a7mr3195118ejj.227.1644622643042;
        Fri, 11 Feb 2022 15:37:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x6sm11522001edv.109.2022.02.11.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:37:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A1631102E49; Sat, 12 Feb 2022 00:37:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Zhiqian Guan <zhguan@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Use dynamically allocated buffer when
 receiving netlink messages
In-Reply-To: <CAEf4BzY=spmQrPX06-hrNMSaH_Sst-WTZiHSpNaCid4+ZNjB3w@mail.gmail.com>
References: <20220211195101.591642-1-toke@redhat.com>
 <CAEf4BzY=spmQrPX06-hrNMSaH_Sst-WTZiHSpNaCid4+ZNjB3w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 12 Feb 2022 00:37:21 +0100
Message-ID: <87y22h6klq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Feb 11, 2022 at 11:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> When receiving netlink messages, libbpf was using a statically allocated
>> stack buffer of 4k bytes. This happened to work fine on systems with a 4k
>> page size, but on systems with larger page sizes it can lead to truncated
>> messages. The user-visible impact of this was that libbpf would insist no
>> XDP program was attached to some interfaces because that bit of the netl=
ink
>> message got chopped off.
>>
>> Fix this by switching to a dynamically allocated buffer; we borrow the
>> approach from iproute2 of using recvmsg() with MSG_PEEK|MSG_TRUNC to get
>> the actual size of the pending message before receiving it, adjusting the
>> buffer as necessary. While we're at it, also add retries on interrupted
>> system calls around the recvmsg() call.
>>
>> Reported-by: Zhiqian Guan <zhguan@redhat.com>
>> Fixes: 8bbb77b7c7a2 ("libbpf: Add various netlink helpers")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 52 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
>> index c39c37f99d5c..9a6e95206bf0 100644
>> --- a/tools/lib/bpf/netlink.c
>> +++ b/tools/lib/bpf/netlink.c
>> @@ -87,22 +87,70 @@ enum {
>>         NL_DONE,
>>  };
>>
>> +static int __libbpf_netlink_recvmsg(int sock, struct msghdr *mhdr, int =
flags)
>
> let's not use names starting with underscored. Just call it
> "netlink_recvmsg" or something like that.

Alright, will fix.

>> +{
>> +       int len;
>> +
>> +       do {
>> +               len =3D recvmsg(sock, mhdr, flags);
>
> recvmsg returns ssize_t, is it ok to truncate to int?

In practice, yeah; the kernel is not going to return a single message
that overflows an int, even on 32bit. And with an int return type it's
more natural to return -errno instead of having the caller deal with
that. So unless you have strong objections I'd prefer to keep it this
way...

>> +       } while (len < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>> +
>> +       if (len < 0)
>> +               return -errno;
>> +       return len;
>> +}
>> +
>> +static int libbpf_netlink_recvmsg(int sock, struct msghdr *mhdr, char *=
*buf)
>> +{
>> +       struct iovec *iov =3D mhdr->msg_iov;
>> +       void *nbuf;
>> +       int len;
>> +
>> +       len =3D __libbpf_netlink_recvmsg(sock, mhdr, MSG_PEEK | MSG_TRUN=
C);
>> +       if (len < 0)
>> +               return len;
>> +
>> +       if (len < 4096)
>> +               len =3D 4096;
>> +
>> +       if (len > iov->iov_len) {
>> +               nbuf =3D realloc(iov->iov_base, len);
>> +               if (!nbuf) {
>> +                       free(iov->iov_base);
>> +                       return -ENOMEM;
>> +               }
>> +               iov->iov_base =3D nbuf;
>
> this function both sets iov->iov_base *and* returns buf. It's quite a
> convoluted contract. Seems like buf is not necessary (and also NULL
> out iov->iov_base in case of error above?). But it might be cleaner to
> do this MSG_PEEK  + realloc + recvmsg  in libbpf_netlink_recv()
> explicitly. It's only one place.

Hmm, yeah, if I wrap the realloc code in a small helper that works; will
fix.

-Toke

