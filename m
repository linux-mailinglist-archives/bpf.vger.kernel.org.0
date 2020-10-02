Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03F6281E61
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 00:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJBWcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 18:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 18:32:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A3AC0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 15:32:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 77so3739429lfj.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R/kJ65VjFTSUMd7Tj3UtK5mZW4UlaG1mPW8W/hr9ZBY=;
        b=uGA/2CKmqZiS/t9osTCjZEECLEzuEUPD0qM+CfcqStlvyQTliu3ib63WBPsV1mNEsR
         ZXDIAk0iQzq79tyVlqIRc+lTN0N7jVyoadD+zCWXMzrSaKgNGh5XEutiXXogNI/9zfX1
         2rcrp4nqElK98nRrjWrg7wqHNVGlvxZFX/1rwAc0RD2/b8ZIEtP6jw6oN0VNh6rgn3xU
         0Vk7fI/uNnSOyzGJ9XpwyArjkG2WMZJ7EaJx5+d1N7nMHcqA0iWqs6bYuZ+ISVWwG8xI
         hreaANy513QVO23sWNyCtZJeNBh+ep5FNVVlJrhIOWBoO413kG/8VSrs/2mswcDjNL6Y
         ZCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R/kJ65VjFTSUMd7Tj3UtK5mZW4UlaG1mPW8W/hr9ZBY=;
        b=nqGUprXGSfpszvbw+U1LVxyLp1mnn88LQ7wrRR1JNsdU9jA/2wm852C4kTRsBHYSeo
         FUEBKdF23k9BwRHQNHjen27xdr51Qn9QuPHRsWOKw2YbYrONn+AAF+BFWpUj1dhCx+xT
         C4QR9+eq3KYeytwzIy+sQfhqwV5sxy3wkIi5LWamHTYawqE1f5OdzVa2WihuGVB6rD27
         27dqwm07xTMaZ9jD4kp/lccL1X7ybGxbwDq43wTvOH0nMQD+BrbE1SOYtG4yLzu2DxBO
         0zEAVFRRhKk7xqScYvj4a7MQI37u2V4oYI2hL4tiHRJLjCuUnodvbOhiLvjMHx5qfssw
         JBQA==
X-Gm-Message-State: AOAM533SWNrGkGyubNQlI60w0zKO/GNebKKPcK+LdxXjHwNsyH/Xt0HT
        VLfCufDdZ0BdJVqLqADWVVDsUAQUK8FVqNUuI4OajZuhVPM=
X-Google-Smtp-Source: ABdhPJzV5OHRHIV55Ti6+K1nUfun826hwfK+bOtCdRrXKfu3Oez78h5VeYjgTYH3eEAfafxE7nyxdm+8CAZJdXPC3m4=
X-Received: by 2002:a19:8089:: with SMTP id b131mr1463957lfd.390.1601677934449;
 Fri, 02 Oct 2020 15:32:14 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 2 Oct 2020 15:32:01 -0700
Message-ID: <CAADnVQLueAsn006KnUBkgFrBqQGAabEGJxkWDOmB15oGHe_asg@mail.gmail.com>
Subject: bug: frozen map leaks
To:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

after successful test_progs run I see a bunch of leaked maps:
# bpftool m s
3: array  name iterator.rodata  flags 0x480
    key 4B  value 98B  max_entries 1  memlock 8192B
    btf_id 4  frozen
9: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 145B  max_entries 1  memlock 8192B
    btf_id 13  frozen
12: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 144B  max_entries 1  memlock 8192B
    btf_id 14  frozen
13: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 85B  max_entries 1  memlock 8192B
    btf_id 15  frozen
14: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 45B  max_entries 1  memlock 8192B
    btf_id 16  frozen
15: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 40B  max_entries 1  memlock 8192B
    btf_id 17  frozen
17: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 55B  max_entries 1  memlock 8192B
    btf_id 18  frozen
19: array  name bpf_iter.rodata  flags 0x480
    key 4B  value 14B  max_entries 1  memlock 8192B
    btf_id 19  frozen

Andrii,
I suspect it's due to libbpf doing BPF_PROG_BIND_MAP now.

Stanislav,
could you take a look ?

Thanks!
