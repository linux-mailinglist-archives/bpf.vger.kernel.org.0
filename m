Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A393D6213B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfGHPLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 11:11:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37242 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbfGHPLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 11:11:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so9436379lfh.4
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hZydHmlFZUA08A8AkXYNhkywEFittozBRDXwaReLd4w=;
        b=ZyfpFTbSR7O/9h7MfIdBAHiER+L8NEo14rVkzdymDHVNoCrOlM0Ot7aB8vfdn99U4e
         YxA3eMnCQMZ+5iEQHJXxZgg2EwBnKh30vkk0eTnqkkqKF3Tr2iSYYat5ZjtAqfomvl3L
         WywGKGaxufYT8w2H8Ta/th3tuSqv5kK1HGFeUlnTiuOZeszNlhKbqg6zhDsOf8vOGkZI
         eq/UMa3zYQYQGqFH5xHQz1QUFeUQ9WusZMH4A+rbQlczAVQkHtv3pqGz3U8Fj1/lKRPj
         aO+PcbzJenN8Qe5/pRUJD/UX26Rg+tFKa2ncLCKzfO4hpHX9DSWkyEFWSsH5/xKm0/tt
         2TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hZydHmlFZUA08A8AkXYNhkywEFittozBRDXwaReLd4w=;
        b=egA2Ur1EcFNMFuYKSshz07z3DaUUp9mJBXUIiI9kXmOz4HNe2SshOKDvjuoAI0BGbN
         YziJKF+LVg443iTUH9EkLL7ldKZH9OvTs6scQL2UWDYaTsr3BAk/4+1tshKda1Kf+tRZ
         +/i4LWsQmjrxhr2io5DMW2UlGfBJjGhv2y5/H0bY89OmyNQITGXRT9XQYi7XWNbpJRma
         M0Pfw34mFQE7wznnNcD00cv+xxWeNz1SW4jS43ZP7LEZY29hEfWkcY655xTqrfc689sq
         fyxMMYeZ5K50yqfHQT8JOZeF59h8XwJstedLk893N1MhLjJlhQ7BUmhc2cMptHc74n/H
         IEXw==
X-Gm-Message-State: APjAAAV2P7cldwgSyYkHrr2EEKHHbQKB9POd1b5cuhMMPnP+DCd6niMf
        2gi0z1bEe/eWrm/3gZy7ZoEQ86Mx1Y0e1vlFwYACXA==
X-Google-Smtp-Source: APXvYqwXuXgNhUrUvwHXPLkW4YnCzBX0FsRm3Oi1zeNNFxryz9wYAgPHQuklpNIAxAWBMans2qOyri1HwW3NLnnyTY8=
X-Received: by 2002:ac2:5981:: with SMTP id w1mr8712451lfn.85.1562598696740;
 Mon, 08 Jul 2019 08:11:36 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Mon, 8 Jul 2019 16:11:26 +0100
Message-ID: <CAH+k93FQkiwRXwgRGrUJEpmAGZBL03URKDmx8uVA9MnLrDKn0Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] libbpf: add kprobe/uprobe attach API
To:     andriin@fb.com
Cc:     andrii.nakryiko@gmail.com, ast@fb.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, netdev@vger.kernel.org,
        sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I bisected a perf build error on ARMv7 to this patch:
libbpf.c: In function =E2=80=98perf_event_open_probe=E2=80=99:
libbpf.c:4112:17: error: cast from pointer to integer of different
size [-Werror=3Dpointer-to-int-cast]
  attr.config1 =3D (uint64_t)(void *)name; /* kprobe_func or uprobe_path */
                 ^

Is this a known issue?
