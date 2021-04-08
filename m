Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB652358D82
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 21:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDHTfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 15:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhDHTfE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 15:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617910492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=oY7tOqgzR6pel5/UGOt/+PJaDyU1lyM0gUuMCpoUhxE=;
        b=YKNEQsy7xiw5xi9WMyBGhDjSfLZh4HPtlUx0BHEfjxh3n4CBaBFLbrYtmX3QVQNDAWy1Go
        qszNdLhegxRrDdgQIVhMQ8t+i8PhFGKX8A4gzqea6jfglPlPdJ1VpoDjYrgCDyKPvVr0i6
        RAOyAUf3Us4vqAnINVhOJqBgQMWWBVQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-4U8-BpEMPDaLPMhrVLvgkw-1; Thu, 08 Apr 2021 15:34:51 -0400
X-MC-Unique: 4U8-BpEMPDaLPMhrVLvgkw-1
Received: by mail-ed1-f69.google.com with SMTP id r6so1515086edh.7
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 12:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=oY7tOqgzR6pel5/UGOt/+PJaDyU1lyM0gUuMCpoUhxE=;
        b=F70aV+Sag9YziBTQqxw5petJoCDAUfNXI2hcAydQng5+j71yMPedfwev8HZF8xwxMU
         QYmZeSDNLhaVe3BAaPUO2lluZPk9xFanYy8Ek3nQ9P6p0C197LfTZQTyjMq46DgS/Equ
         u9yIbDUPWZZ1ywmtzQXeUPPe/9k63CRmKTxy6dh3OtrmXDZtJvs1TXsYzdC57D/MnL3k
         ZUAmKBmeii7GeFSuvR8bayH5JT3AeWyGGvYwj2szzNGOyt+ldTNk/wuLJDZoP9ClJI2C
         qtxeInP8kuJZAT91qyAfS2xaKkU2+S8EY/xTMCP98AIfFiQJaQpLZKxWIPoljgFdvzSB
         xjBg==
X-Gm-Message-State: AOAM531zcZkED2uEjTJ9z6KhNesjuERaukBpeEHhoI9eil8CgGDUV+mW
        xNn2+zjVzkIUZo35sQeJqcu3NqycC7tVOPa82aY4+BUrsnbZxGc9CTSVubyYRExhbmhEODDGhHk
        5U514Im3r84xX
X-Received: by 2002:a17:906:453:: with SMTP id e19mr12696421eja.354.1617910489524;
        Thu, 08 Apr 2021 12:34:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdEpjUrP+XawuqBDkFqxwwlQfeihc7ZdLRqJjZckxIhp/4W2X0caRMQ7Dxuf3/ZLyZ0S2JMA==
X-Received: by 2002:a17:906:453:: with SMTP id e19mr12696384eja.354.1617910489131;
        Thu, 08 Apr 2021 12:34:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h21sm158324ejb.31.2021.04.08.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:34:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D530618030D; Thu,  8 Apr 2021 21:34:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Selftest failures related to kern_sync_rcu()
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 08 Apr 2021 21:34:47 +0200
Message-ID: <87blaozi20.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii

I'm getting some selftest failures that all seem to have something to do
with kern_sync_rcu() not being enough to trigger the kernel events that
the selftest expects:

$ ./test_progs | grep FAIL
test_lookup_update:FAIL:map1_leak inner_map1 leaked!
#15/1 lookup_update:FAIL
#15 btf_map_in_map:FAIL
test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 == expected 0
#123/2 exit_creds:FAIL
#123 task_local_storage:FAIL
test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual 0 == expected 0
#123/2 exit_creds:FAIL
#123 task_local_storage:FAIL

They are all fixed by adding a sleep(1) after the call(s) to
kern_sync_rcu(), so I'm guessing it's some kind of
timing/synchronisation problem. Is there a particular kernel config
that's needed for the membarrier syscall trick to work? I've tried with
various settings of PREEMPT and that doesn't really seem to make any
difference...

-Toke

