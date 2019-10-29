Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C181FE82EF
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfJ2IGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 04:06:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726246AbfJ2IGC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 04:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572336361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaB5XtQ/QGZvr2h5W63rFZo7WkD/6qyYty4a6W3kSYg=;
        b=K8o8s3TL4QGPjukD3CEJjXNUgbTvRlrHeIUmOXybpvTMpF8q9z7kKp2OwSaqt4RW/uqQT3
        YW9AocBONAcoNXP7Ve9RqQC+B1NwwQXZQ3RDdpkUDbhX4GKKTTGpQhk5IwW5cu8MdSTyxF
        Y1uDHxAfCi+u0pAKApJF9Pvo07u0sEI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-UcIJEDq7MZS_3ICNYrcs0Q-1; Tue, 29 Oct 2019 04:05:58 -0400
Received: by mail-lj1-f197.google.com with SMTP id r13so1926109ljk.18
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rLGoW7SRG4SMfs2KFUdiBrGDzI0FTu0D10Lnaw21e2w=;
        b=CnoJj7eNrmFzAzVt6h17tgRQGBSBuQqmp7eCaCClEvOKvhnBZORYS6xPSEOtdwMSzF
         JMBrF7dljge6ZmfhQkcob4QV9MKF/wywDD695DiJDvJPrD65RUfkWVbGQ7Q7XoKYKE1U
         3woNE2CyqHdmfmDik/S7YFgw7R9nomxfD6wfL/Qr8F/KvOJxuMQFocOD5NLprWxKDklG
         lGucsBtup5k6eQjsKLemw7NGQW2LBuJkrCTrHr9pPAhiSQkPdjWQfvmeFreLCg+HCUyb
         bSQk/Ou2aG4FoVAWwKhMtC7sDzuY29iFXoV3XXLqXf2sSZWWXdPmN4qtiohSfdx/+QWw
         gniA==
X-Gm-Message-State: APjAAAWHFoGpG29wfO+EmXKeNLpgTuFIo65BRJ454eH05/eYCPpBUy5Q
        KRg8eJgCHVtJChHsC2/7RdZWnZCyYHlTuUo2Ab+J93MsAUBluSLuoAMX1FddCQJlToa9a2SNAMh
        SqaHJKJMMhJw2
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr1507318ljr.23.1572336356521;
        Tue, 29 Oct 2019 01:05:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJsOBMRDixarYBapn4qSz+u/tA8XqjuW+RpKGFNawFnUPPOXneS0LHPE70VJ/fIbfF/6PbNA==
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr1507294ljr.23.1572336356300;
        Tue, 29 Oct 2019 01:05:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b23sm7638795lfj.49.2019.10.29.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:05:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 719931818B6; Tue, 29 Oct 2019 09:05:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf-next] libbpf: don't use kernel-side u32 type in xsk.c
In-Reply-To: <20191029055953.2461336-1-andriin@fb.com>
References: <20191029055953.2461336-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Oct 2019 09:05:54 +0100
Message-ID: <87ftjcrn6l.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: UcIJEDq7MZS_3ICNYrcs0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> u32 is a kernel-side typedef. User-space library is supposed to use __u32=
.
> This breaks Github's projection of libbpf. Do u32 -> __u32 fix.

I've always wondered about this, actually. Why are they different?

-Toke

