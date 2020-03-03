Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BFB1770D0
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 09:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCCIKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 03:10:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50666 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727594AbgCCIKE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 03:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583223003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOkmQTJ+XVl4zVvOPZuOWLgUrt4DS7w6s5tuNYtBxO4=;
        b=TraAY20efRy9urZrs+GqcBXMVRNu1QIeFSl74374uXodGfJoVxj7adob5lCk62DX9Bign7
        1Z2KL6eRMMTMqy60Tmvdovf3/hELf0KOgFg+l7xkywBXpehQNAVRbzLxB4VnTdYKejfErN
        M4M+AuCyZL9ZsLB/v4WJAVz9uFJe61k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Fqz7fOO7MhC1R78l1V8ANA-1; Tue, 03 Mar 2020 03:10:01 -0500
X-MC-Unique: Fqz7fOO7MhC1R78l1V8ANA-1
Received: by mail-wm1-f70.google.com with SMTP id y18so609401wmi.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 00:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mOkmQTJ+XVl4zVvOPZuOWLgUrt4DS7w6s5tuNYtBxO4=;
        b=UjCbQ4uWVuCEQQtcc0jES+/q5uFHEFvcxLsZA3sI6YCWPi2T1v+6hk7kSv0saVKy7B
         /JzJq2WwzUYmYe42FIY4yLDT6JxYqvruadXyrjyBnNRzEQn5HSF6bqFxfRUtp6XRyW25
         UnLCJyNZwI/35AsCUHBAU7VQRop6MvANR8TFfFv9KUz7GhrYX9dI/kOMOQxkArCt3Lpm
         KsBluILzd7lN8kmLiQbXLxGn98iCB8HUh1md50yK2ZlGvPFoM0QmEovo/Q0zh8bk/+J6
         ScYknTJsK3Q7JFRUiXdA82f3zPRcGKw/FUHdepupD4x6TlYi5Hc3hZm5xoRb2U3eM0be
         xP1w==
X-Gm-Message-State: ANhLgQ0qght5r6utU6aS5hXYMFxFgdNiIZRt9xNYDGM6qSBTiaMwDLds
        4IE3ifa0T9Q1S3KThA0YtZ22GRasxtpHv6sfRtfb/BgaimOCh7eYOPdFSdIeP4IOvN+MdWfNOVT
        Cnr96iNXtsUyF
X-Received: by 2002:adf:b6a2:: with SMTP id j34mr4330501wre.277.1583223000625;
        Tue, 03 Mar 2020 00:10:00 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs+tnrfwkbcnTyvLJzt6t+0NDfXNje1nnhcxwVCcibcSkOw3I5QV6EC3xMhq7TK3HbcXuPR3A==
X-Received: by 2002:adf:b6a2:: with SMTP id j34mr4330477wre.277.1583223000431;
        Tue, 03 Mar 2020 00:10:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 19sm2629436wma.3.2020.03.03.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:09:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2A461180362; Tue,  3 Mar 2020 09:09:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf] selftests/bpf: Declare bpf_log_buf variables as static
In-Reply-To: <20200303010311.bg6hh4ah5thu5q2c@ast-mbp>
References: <20200302145348.559177-1-toke@redhat.com> <20200303010311.bg6hh4ah5thu5q2c@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 03 Mar 2020 09:09:58 +0100
Message-ID: <87d09tsvu1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Mar 02, 2020 at 03:53:48PM +0100, Toke H=C3=83=C2=B8iland-J=C3=83=
=C2=B8rgensen wrote:
>> The cgroup selftests did not declare the bpf_log_buf variable as static,=
 leading
>> to a linker error with GCC 10 (which defaults to -fno-common). Fix this =
by
>> adding the missing static declarations.
>>=20
>> Fixes: 257c88559f36 ("selftests/bpf: Convert test_cgroup_attach to prog_=
tests")
>> Signed-off-by: Toke H=C3=83=C2=B8iland-J=C3=83=C2=B8rgensen <toke@redhat=
.com>
>
> Applied to bpf-next.
> It's hardly a fix. Fixes tag doesn't make it a fix in my mind.

It fixes a compile error of selftests with GCC 10; how is that not a
fix? We found it while setting up a CI test compiling Linus' tree on
Fedora rawhide, so it does happen in the wild.

> I really see no point rushing it into bpf->net->Linus's tree at this poin=
t.

Well if you're not pushing any other fixes then OK, sure, no reason to
go through the whole process just for this. But if you end up pushing
another round of fixes anyway, please include this as well. If not, I
guess we can wait :)

-Toke

