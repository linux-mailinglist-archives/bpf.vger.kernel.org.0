Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C498E116C4A
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2019 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLIL3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 06:29:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbfLIL3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 06:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575890975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=brrElCnD0fFj0dsAyA7yIHhw8QM+zUQL/kI/lCBWGAI=;
        b=L+RdniZzYNMDYNB0Sh14AxRffbCRbaH1EB7ephcZF3VuypPmPzzV1VDl5JD61kBMdZUlXM
        3eyIa8AxdB6DhQSs3sHvTgmVI9wI3KOI1OQ7pBJa+nWQIBUgUeQ4UUfcrgDGZWho/fx/2t
        hEBeP2LywaLvDJQIhBi3BFB9wd9CMps=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-S2LY_TSENmaJcTQBSmUAfA-1; Mon, 09 Dec 2019 06:29:32 -0500
Received: by mail-lj1-f200.google.com with SMTP id s8so3238524ljo.10
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 03:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=brrElCnD0fFj0dsAyA7yIHhw8QM+zUQL/kI/lCBWGAI=;
        b=FOWPI+jUxfvR2lg0bWkV0/NcXl7r3SRtroYtNTocl9+2wrFmp8nZOUaAhbuo9A7Qtc
         YMzY3rCJZYsKbbhoocb3Ct1uxh7ZkD5SiMVoWlzfPA3qNj26olQcS/1gEHr0RzxITro5
         GsaxlZkRZKEKaN2joGh7RSrIyTXvIdIyQE1kCdRhG8D5XacawDdas0ghgd51KNlLGUyh
         rcGvw7i70VqM0qHnHLYGUBWNo1hmlWUzjiNpPfG8kNPy0rMYX1Zq4tWq3Z3qvO7hj7OI
         sERycx+dr7Da/u223loamd/e7978jpU+xftFQwLyTdi3tWvdQcDNqelRCeqaySUCLxit
         /+/w==
X-Gm-Message-State: APjAAAWrSiMWR5cwx6sXfTqp6TGFF/SRe8Ba9r0bRsc7UUgBkfbOAigV
        K+UVV+Nzit/wSBKjoOnNWDRtWlc0crUclCwNGkJe9j3Y2I9hwr9yutxFkcrlmDW4AOZ8rvdh+Vq
        sWKBLRLHUOiy0
X-Received: by 2002:a2e:58c:: with SMTP id 134mr16936220ljf.12.1575890970399;
        Mon, 09 Dec 2019 03:29:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZVoS/uXs3T1eVf/XlZ02xWycVbJgGakJDNg1/h00N069k47ar4L2ftjtRU4lo//VGRQkrFg==
X-Received: by 2002:a2e:58c:: with SMTP id 134mr16936213ljf.12.1575890970253;
        Mon, 09 Dec 2019 03:29:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i4sm12554298lji.0.2019.12.09.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:29:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 835E718257B; Mon,  9 Dec 2019 12:29:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Establishing /usr/lib/bpf as a convention for eBPF bytecode files?
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 12:29:27 +0100
Message-ID: <87fthtlotk.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: S2LY_TSENmaJcTQBSmUAfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

As you have no doubt noticed, we have started thinking about how to
package eBPF-related applications in distributions. As a part of this,
I've been thinking about what to recommend for applications that ship
pre-compiled BPF byte-code files.

The obvious place to place those would be somewhere in the system
$LIBDIR (i.e., /usr/lib or /usr/lib64, depending on the distro). But
since BPF byte code is its own binary format, different from regular
executables, I think having a separate path to put those under makes
sense. So I'm proposing to establish a convention that pre-compiled BPF
programs be installed into /usr/lib{,64}/bpf.

This would let users discover which BPF programs are shipped on their
system, and it could be used to discover which package loaded a
particular BPF program, by walking the directory to find the file a
loaded program came from. It would not work for dynamically-generated
bytecode, of course, but I think at least some applications will end up
shipping pre-compiled bytecode files (we're doing that for xdp-tools,
for instance).

As I said, this would be a convention. We're already using it for
xdp-tools[0], so my plan is to use that as the "first mover", try to get
distributions to establish the path as a part of their filesystem
layout, and then just try to encourage packages to use it. Hopefully it
will catch on.

Does anyone have any objections to this? Do you think it is a complete
waste of time, or is it worth giving it a shot? :)

-Toke

[0] https://github.com/xdp-project/xdp-tools/blob/master/lib/defines.mk#L12

