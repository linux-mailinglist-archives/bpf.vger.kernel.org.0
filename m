Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE9144899
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgAUXzt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 18:55:49 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43211 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUXzt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 18:55:49 -0500
Received: by mail-qt1-f172.google.com with SMTP id d18so4211107qtj.10
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SE9hOvmD0hSvzXars5JSLlC3ojgxSHfE8hffKfhpJII=;
        b=DHEol5piyh5g/Egpn9ndGMmxaglebZUCj/4Op6XrqcoynFKKcF1wvJL8HkHF9MLotv
         baOGF+Vrb7FpVtxFZjZ8pY9BPPInKcpYg3DfSa6+iMIE38nn4BOazQoQO1joGjzn+zcH
         KzEq9ctyYPpe9EDOL9BgOSF68+mgRhub+4lYwPlvVk9ERhsNmh9mV/FyVIMUMaQiJ5cV
         jq/gdFFgksRhUKebIOfSMgeFwWomvpELE5jT3A+sjEtLu1mf4fJPy/arh7nd/WADE1Os
         iQpIZs38pd//NF39/CmMS79owtoADvIKFZql8VKIKx9OYDnYWFHwxHYPeEsVrGPQnk2N
         ZuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SE9hOvmD0hSvzXars5JSLlC3ojgxSHfE8hffKfhpJII=;
        b=Rdl0vNlMOp/VZdpDdYlmJ756dM19FXvaNo2Wn4OHDre0a36+BzuKvnWR6rMn83rPNT
         M4t0+iWTYhJGBXW2MNkYfC9WC0dRsnUaqNaTA4sDuZxBKMCWDd+UmtziJtMuevAmTgpc
         i4HzH1JCWOl/gslev4cOz2T4ShNALzoWyLpCZOqDlBEDEOxMFmTk5LwwRNLcCHXJ8Gc4
         Ec6mxuGqI0Km+6mv46SipGrs6+ey1S9rQJCsG7RjrQl2WiE2PEuiy/wxKh0SrDV6ku5f
         XVIbMpW0b6fn/beHpAH+RTeVzXipu7SpEwDF5fv/+eVfjZJ1RtWg/eJDHaF9EY9HuBm0
         cpcQ==
X-Gm-Message-State: APjAAAXtxyJ8BgynjFBwpHmjWafDpPOrXmjqFAVRSdtq688ruuNESjth
        N9n3v6oYsGnKY7qg+1w9RVDjaiZhujmRrbIis5E=
X-Google-Smtp-Source: APXvYqxD0sn/Z/vnz6ShAGRAGIgbZyFMIcvcd+nyuw6txQMc5SDRef5AuusZOFa9UWaR7QGQZlGIRxrovaX+1WGEJtY=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr7181746qtl.171.1579650947628;
 Tue, 21 Jan 2020 15:55:47 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Jan 2020 15:55:36 -0800
Message-ID: <CAEf4BzbnGw5No-vW0=b3kzTM1078H5QK49+SWEuCmyn3X=wTNw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] BPF static linking
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF static linking
==================

BPF as a technology keeps maturing and gaining more power. Given that,
BPF applications become ever more sophisticated, complex, and large.
Right now, BPF developers are confined to a single C source file for
compiling any BPF application, which becomes a big limitation when
multiple people and teams are working on the same application.
Additionally, BPF as a technology recently gained a dynamic linking
capabilities, so it's just natural to wonder why there is still no
static linking available yet.

There are a bunch of non-obvious BPF-specific problems that needs to
be solved for BPF static linking to become possible. We'll go over
proposed approach, tooling and API changes necessary, pitfalls and
challenges, that need to be addressed to make static linking a reality
in BPF realm.

-- Andrii
