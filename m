Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7465218C927
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 09:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgCTIsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 04:48:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40908 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgCTIsQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Mar 2020 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584694094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuU6eXxKFxUXML143fYL9OeD0B6kZs/JQK09NJI7vaw=;
        b=HnPSJ2DA6MOY1e191jgMa+dTnvR7h7VP15JIbwuUTo+6b4jvOpWRdZpkzeXCt6RV/KzyVi
        i9QqMUAamtD0o1ajzh4AZmGK7gKWbyeWNpLpIUlRXJlwK2XcOioUydTzSa0rVRd30FGl54
        hnBvkTgDvenRM71dkkfl42KctRQm3wM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-lcMHlXajNh6xSB3gTDP1EQ-1; Fri, 20 Mar 2020 04:48:13 -0400
X-MC-Unique: lcMHlXajNh6xSB3gTDP1EQ-1
Received: by mail-wr1-f72.google.com with SMTP id u18so2287646wrn.11
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 01:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kuU6eXxKFxUXML143fYL9OeD0B6kZs/JQK09NJI7vaw=;
        b=MFapX/UR22k+kguduLoOjhirBpNlrXWNC2aQLrE9TGeFdNSfz2MjCzvUIwlVgQTCEd
         hYE07ga24ZII/ZWGqAmtEOOkG/JLOkk/e7tZZ3lt89ZLjOduiKwSnjL/7KELVtLJMn9w
         NJi9Bx0rOgQLIcAdjxGfiK647vpkitbPED5qwF+ttVyTaYnU+TBQaVNSbxQnx4itJ2fc
         IBTFnA6YAguihQPnYl7IamUz+ZIcUdkzy7szpqnqERlDKWtQLmv71ubEOTZRWOZdx1fE
         dKEvdS85UeYSxmBT0WcPTkjNribCMgnu6yUrR5R23TijVnM/qFCMpEsJUIr+s7DI7Fp2
         TloA==
X-Gm-Message-State: ANhLgQ2BFkNcFTKYjMkbkFAs6wNhFBg9m8DLg35F9D3aFubHpIjswOK7
        liT0k5+vPYL7pDNHXg/AtmHGMVpRx62lTl1spVglg1AwSTPG6YZBY6MKpvR6BSlKrT5sHjbPhwW
        qEg9gQOte21Mj
X-Received: by 2002:a5d:5503:: with SMTP id b3mr9889307wrv.419.1584694091704;
        Fri, 20 Mar 2020 01:48:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUfvpi3QB5T7t/kkB8+Fdi79oHe5zW4N9NEpIQZDcnacftEUtknDYjj5ex995wkUKbqfkTKA==
X-Received: by 2002:a5d:5503:: with SMTP id b3mr9889271wrv.419.1584694091424;
        Fri, 20 Mar 2020 01:48:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d124sm2748648wmd.37.2020.03.20.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 01:48:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3B6BB180371; Fri, 20 Mar 2020 09:48:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk> <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Mar 2020 09:48:10 +0100
Message-ID: <875zez76ph.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 19 Mar 2020 14:13:13 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> While it is currently possible for userspace to specify that an existing
>> XDP program should not be replaced when attaching to an interface, there=
 is
>> no mechanism to safely replace a specific XDP program with another.
>>=20
>> This patch adds a new netlink attribute, IFLA_XDP_EXPECTED_FD, which can=
 be
>> set along with IFLA_XDP_FD. If set, the kernel will check that the progr=
am
>> currently loaded on the interface matches the expected one, and fail the
>> operation if it does not. This corresponds to a 'cmpxchg' memory operati=
on.
>>=20
>> A new companion flag, XDP_FLAGS_EXPECT_FD, is also added to explicitly
>> request checking of the EXPECTED_FD attribute. This is needed for usersp=
ace
>> to discover whether the kernel supports the new attribute.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I didn't know we wanted to go ahead with this...

Well, I'm aware of the bpf_link discussion, obviously. Not sure what's
happening with that, though. So since this is a straight-forward
extension of the existing API, that doesn't carry a high implementation
cost, I figured I'd just go ahead with this. Doesn't mean we can't have
something similar in bpf_link as well, of course.

> If we do please run this thru checkpatch, set .strict_start_type,

Will do.

> and make the expected fd unsigned. A negative expected fd makes no
> sense.

A negative expected_fd corresponds to setting the UPDATE_IF_NOEXIST
flag. I guess you could argue that since we have that flag, setting a
negative expected_fd is not strictly needed. However, I thought it was
weird to have a "this is what I expect" API that did not support
expressing "I expect no program to be attached".

-Toke

