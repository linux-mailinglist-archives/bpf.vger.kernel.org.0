Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7330E405
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBCU1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 15:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBCU1A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 15:27:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40987C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 12:26:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j11so1013800wmi.3
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=TcSKGMKUiT5lrVTD5HzJLT3MKMD61gD7byLx9s9z3zU=;
        b=Osg44wh9KtPieJ5ODYx3LUNXgQAQLfQiaMAGaJTvNl0DomIYOIG+97MChYGz3BB3T3
         f+wLFTF4h56lnHOiNZ9mtkqNXRw7AXzslrSoldNSe+r+TavGmiN2QV2jn2Lnxw4FicrU
         ucDWlYoubV/t/V5DpoFQohdDerwXwkpgU7QO96WjMy93legOaIaxrrXg8ZTzvbUWvtME
         l2sklp+oIYPXkRDP2H+NDRLqhrfUJlP+Q1tkHNfmpaVS1PNyoyIBAQGP9b5iD3c9JwNG
         U8RKlPJEmvMMZSlvBn6EvjYUlLp4uQIwwVAZwVGMfkWDYBc4WLeNcShCxp/7bNkWoh7e
         0KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TcSKGMKUiT5lrVTD5HzJLT3MKMD61gD7byLx9s9z3zU=;
        b=qPYQIZ6BH6v4di9YY5Z/FzZnj+54uZU7DO7eUDKH+FMkfCXNeeSel11J1721/CKEEW
         qRUOw3xl8jLIaOcapJOVCHytfPZpMa7+NeUmKomBqhUqpvnqfqr82ZphuCgrqDoqEtZG
         brhWIDEyvW4qJT5Ac4sP95O9Bjw1KiHFXsmt0Hs+rD3bdidHm//SUjoDc3ubnWH9qz3v
         sNf9HjzrnjvJcj/Wp/qZuPItNGe7YO3PolkB2PbcFYlrhqUprM0vCYpx1HfTrjtWtvdq
         LvBgW0oYXeDj2leznsVXQuMuQCb7x215nQuBo/Hg5G86dpoAky4srwmcQs9rXWBkDBvb
         nw3g==
X-Gm-Message-State: AOAM533IgKNoAlXQnrdqahZtuHzjgEmyWA7um4IlhcpgJ2PFUBc4d5vY
        mnJVl/KX5O1abos5D4vTL5HZe0vxc+cVQaUhrKqhLzx9AYkxv5Vr
X-Google-Smtp-Source: ABdhPJyVz4RO+ZLnSeaGlT08EqjN/fLYDyt6ShI6LosVvT9v3t0rCocsNJ/wAmD06kFU+tJ5Et5zeNQaofUpPRAHa8w=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr4446526wmd.128.1612383978782;
 Wed, 03 Feb 2021 12:26:18 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 13:26:02 -0700
Message-ID: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
Subject: 5:11: in-kernel BTF is malformed
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

qemu-kvm VM starts with kernel 5.10.10 but fails with 5.11.0-rc5.

Libvirt folks think this is a kernel bug, and have attached a
reproducer to the downstream bug report.

"I've managed to reproduce and found that virBPFLoadProg() logs the
following message:

in-kernel BTF is malformed\nprocessed 0 insns (limit 1000000)
max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n
"

https://bugzilla.redhat.com/show_bug.cgi?id=1920857#c4

Thanks,

-- 
Chris Murphy
