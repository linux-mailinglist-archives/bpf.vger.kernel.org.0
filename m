Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50FA2BAF47
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKTPrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 10:47:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728770AbgKTPrA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Nov 2020 10:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605887218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7D2x8us35q17HBLGdyACZHrbyRvTTajSnNXTqPgkdIw=;
        b=emn6i4Z7B5fPoRaZV20Yzh/QtQqGXCwwOGCfgcj+XwYnfseJwWQnH0wTytcHqpkdsQG/ch
        7rEeJxqcmaFvJTCZFKpeozzNSOaZrBqRS+PU9mt63WlNqJaO4sgPZrbMr7wfuEDMjPY8Xe
        di0fLC7hQFjrg7+x6Zi8ptErOXp/J0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-FCqBcmnQOs6fhYdcf6PZ6A-1; Fri, 20 Nov 2020 10:46:56 -0500
X-MC-Unique: FCqBcmnQOs6fhYdcf6PZ6A-1
Received: by mail-wr1-f72.google.com with SMTP id z13so3541280wrm.19
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 07:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=7D2x8us35q17HBLGdyACZHrbyRvTTajSnNXTqPgkdIw=;
        b=sZlmHbVQ+MyFd5rdz0+aEWxpt5HFHD9JZ6isfMVDO/7TVOt9qy7b38GS4hEhvYZEAM
         C28Ky0LiolRDgTkaKnXiUv1ZhaLKr8v32whFGHoCynMD6KyzIS6u9CxDkzJ3KEDus6jp
         KLgCxHfKB1vD6H81v9J+NVhwIbBJoyPpA/ZBLFxyWkcyI00OcVMXQKhgIWRbENtLi/Na
         CZyg4B4Wnch+YCZUNfcO7hHoXkatN+KjJJYBj6FPoQdXMr8LdjzPs0bflTqVqjqh6LrW
         GFnP0uqz2M91WDI00MBz1Hrb9BtnucV5RwRqmh0rPuNw9rUy0AQl3K5+OH5qwd9/ASiA
         H/Hg==
X-Gm-Message-State: AOAM530s3/mMWfzkHtC/JDX7wWP7Is9Lz4eqCHO5bwdaKZIil0yJEiij
        jhcTaGGVlZc9oe1VoM3j1K2Tl6l+DyMIYuVZA5hp+jmJlytpLcPeiyI7g+X5ZCHxmmPWx+kYYq5
        h4O+x0j3UXSP/
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr10524670wme.171.1605887214442;
        Fri, 20 Nov 2020 07:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyed8fU5FpjGTbhTXESXyBAZke9Ry5lq9ggDsQOrPcdVwMvkjgsR+WMyU9nvYfHmKDmoAaxqQ==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr10524546wme.171.1605887212719;
        Fri, 20 Nov 2020 07:46:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a144sm4962057wmd.47.2020.11.20.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:46:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A19D7183852; Fri, 20 Nov 2020 16:46:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@mellanox.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Is test_offload.py supposed to work?
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Nov 2020 16:46:51 +0100
Message-ID: <87y2iwqbdg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub and Jiri

I am investigating an error with XDP offload mode, and figured I'd run
'test_offload.py' from selftests. However, I'm unable to get it to run
successfully; am I missing some config options, or has it simply
bit-rotted to the point where it no longer works?

[root@(none) bpf]# ./test_offload.py 
Test destruction of generic XDP...
Test TC non-offloaded...
Test TC non-offloaded isn't getting bound...
Test TC offloads are off by default...
FAIL: Missing or incorrect netlink extack message
  File "./test_offload.py", line 836, in <module>
    check_extack(err, "TC offload is disabled on net device.", args)
  File "./test_offload.py", line 657, in check_extack
    fail(not comp, "Missing or incorrect netlink extack message")
  File "./test_offload.py", line 86, in fail
    tb = "".join(traceback.extract_stack().format())


Commenting out that line gets me a bit further:

[root@(none) bpf]# ./test_offload.py 
Test destruction of generic XDP...
Test TC non-offloaded...
Test TC non-offloaded isn't getting bound...
Test TC offloads are off by default...
Test TC offload by default...
Test TC cBPF bytcode tries offload by default...
Test TC cBPF unbound bytecode doesn't offload...
Test non-0 chain offload...
FAIL: Missing or incorrect netlink extack message
  File "./test_offload.py", line 876, in <module>
    check_extack(err, "Driver supports only offload of chain 0.", args)
  File "./test_offload.py", line 657, in check_extack
    fail(not comp, "Missing or incorrect netlink extack message")
  File "./test_offload.py", line 86, in fail
    tb = "".join(traceback.extract_stack().format())


And again, after which I gave up:

[root@(none) bpf]# ./test_offload.py 
Test destruction of generic XDP...
Test TC non-offloaded...
Test TC non-offloaded isn't getting bound...
Test TC offloads are off by default...
Test TC offload by default...
Test TC cBPF bytcode tries offload by default...
Test TC cBPF unbound bytecode doesn't offload...
Test non-0 chain offload...
Test TC replace...
Test TC replace bad flags...
Test spurious extack from the driver...
Test TC offloads work...
FAIL: Missing or incorrect message from netdevsim in verifier log
  File "./test_offload.py", line 920, in <module>
    check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
  File "./test_offload.py", line 671, in check_verifier_log
    fail(True, "Missing or incorrect message from netdevsim in verifier log")
  File "./test_offload.py", line 86, in fail
    tb = "".join(traceback.extract_stack().format())

-Toke

